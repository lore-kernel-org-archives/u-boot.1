Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9437ECD37B2
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 17:17:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23572846F8;
	Sun, 10 May 2026 19:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xC41YICs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dFvXulS+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9988784701; Sun, 10 May 2026 19:17:35 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB229846D0
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 19:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gD8gJ4ZlXz9snJ;
 Sun, 10 May 2026 19:17:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ew+LGNrP90TploLWkO+93ZHinbmQsZIn0DFhOMrSMCA=;
 b=xC41YICs5Bt8Q32u8VNVPEje1QxqM7uh4RNjyBTJ4O8xazQ/GxcZ0z0JXhljWmzYCwEXkW
 VhdZX/7yZvlZum01kRxy+S9wsE7QBkVz9HC0sKw7zaccO3AspdvN8tXgl8zyTxcpz170Kr
 wjkR1mLfjXwHT16Pynzo1EE59Urowgoslnz6Y8DNou0B/wiUHE+ZHErAI96X4M3amdDKJh
 KT90gYQIWQ8YHhsX0qHIVzhgeshyGv8RJoPboaWaS+ZgOJu1ys0hr5x2+bXk0Jd7ho92V4
 ajuDIIEcAzcPqNXmEQSRg2ezS/kyIdkVbwygCxYDzYuY3/rGaJJF/v9VD9sEUg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ew+LGNrP90TploLWkO+93ZHinbmQsZIn0DFhOMrSMCA=;
 b=dFvXulS+BcQ0kPdarBS3G2lM6RCRm2heEX1lFD9OapBwihslHxkPnPkKrYwhkIPGmCjvWi
 gH49FE2u4MT36EcrPJwvJmA/GEsVVm6u+fEROLUNRe5xZpVF6hsgBoSqK7iKPAzRoPmJog
 77aNKsvmxPqjndFqlCCuuxHZ+z8E6uCP8lW7UJHTaHqB7JGmXDMNTmPsE/rhc/tDFvDArt
 CumP8OiukLoWd3UXNvTK2PrKcgXHOXpYNB/IEwvxqBoFksHfAx2X9aMQyXNvfOhfMHoHV5
 HS22N/9165vkVED2EPC36JTKsTmC64DSKFS3lJ7ZjxID/s/UMMhx+kophOkV/A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/11] video: bridge: anx6345: Staticize and constify driver
 ops
Date: Sun, 10 May 2026 19:16:56 +0200
Message-ID: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 481cekdykxythe3gbpfwrzpir8b6st9k
X-MBO-RS-ID: f7dc859207164434c4e
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
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/video/bridge/anx6345.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/bridge/anx6345.c b/drivers/video/bridge/anx6345.c
index 8cee4c958bd..a5d2781aa48 100644
--- a/drivers/video/bridge/anx6345.c
+++ b/drivers/video/bridge/anx6345.c
@@ -403,7 +403,7 @@ static int anx6345_probe(struct udevice *dev)
 	return anx6345_enable(dev);
 }
 
-struct video_bridge_ops anx6345_ops = {
+static const struct video_bridge_ops anx6345_ops = {
 	.attach = anx6345_attach,
 	.set_backlight = anx6345_set_backlight,
 	.read_edid = anx6345_read_edid,
-- 
2.53.0

