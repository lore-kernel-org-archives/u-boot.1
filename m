Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA81CD37B9
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 17:17:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A37D8846E9;
	Sun, 10 May 2026 19:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QMneA5FB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="a7suWI9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5991846A0; Sun, 10 May 2026 19:17:09 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DDA584834
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 19:16:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gD8fb06BXz9ssB;
 Sun, 10 May 2026 19:16:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wNoioOfySWWpieDko3Vmwk+6nfTCDu67DHvMh62NtOk=;
 b=QMneA5FBWcnf/STE8gz/MMu+O3ThJsgbPt123Ah3IDu92PwQgStAl4SG9G8td7v3yz2IC6
 loxD/tfhhra4Z/IDg+uXdCdI7rB+6L97cdCTYLk4+dfVZI7z5l6dhzTrXAs64UXWCb5b1T
 EAcDCcYf8C4ypfgx5iIg9OG3okIGz+JllBoStiqCVtTcre7/zBZ0fIHNrW5vB3vF06NwNW
 PQKVsJLsWIjYM3sHVqQ8lu65Vnsfs42BGhZ5ew1nrZuKqnCQFosxLpeGk81GMSOZxZIgim
 axs9COXJnpILI2QnSewZiwS0Ocz2ikDxX+8lHaBRitWF2Spw3J/SINmdAvRH8g==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=a7suWI9g;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wNoioOfySWWpieDko3Vmwk+6nfTCDu67DHvMh62NtOk=;
 b=a7suWI9gSAj57xA1egBCywTgG2f/9DNG8rGofXL8pAZZ9Ih0Hv1AKGpx4iOYkKhDFZoanO
 MFE1nDQYPb7y+BNt1ULlNh3I92Q3/rqamGbWWI/KAKBgkr/Fr4xo4A0wFGOttGuWm6o9Bb
 ku1fM0OrEeblRG1McSzECUXYLDJXBRkkZd5YwhLa8mZMmxZk6a3Bl/6U2es8hccs7dHuEy
 fTkgKwWlcZN8ywqM+TpiyVB5cSw6bnvEAWvABfuG73+d0qM8mRpAwdSP9833fn+HtE2gJn
 U2OFdfKR76SIwWHVIhcQHC6w4mzjj0ykgTXjX5fZ4u7mK5Wj1SqafADjlaGFIw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] usb: dwc3: sti: Staticize and constify driver ops
Date: Sun, 10 May 2026 19:16:32 +0200
Message-ID: <20260510171649.56837-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171649.56837-1-marek.vasut+renesas@mailbox.org>
References: <20260510171649.56837-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: faq794t1iyuk3k64yuk8j48jzkqm94yg
X-MBO-RS-ID: 61ca3a4b1f3c566f1e2
X-Rspamd-Queue-Id: 4gD8fb06BXz9ssB
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/usb/dwc3/dwc3-generic-sti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-generic-sti.c b/drivers/usb/dwc3/dwc3-generic-sti.c
index b34f5ceceac..ce195b2553b 100644
--- a/drivers/usb/dwc3/dwc3-generic-sti.c
+++ b/drivers/usb/dwc3/dwc3-generic-sti.c
@@ -114,7 +114,7 @@ static void dwc3_stih407_glue_configure(struct udevice *dev, int index,
 	setbits_le32(glue_base + CLKRST_CTRL, SW_PIPEW_RESET_N);
 };
 
-struct dwc3_glue_ops stih407_ops = {
+static const struct dwc3_glue_ops stih407_ops = {
 	.glue_configure = dwc3_stih407_glue_configure,
 };
 
-- 
2.53.0

