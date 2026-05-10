Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA396CD37B2
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 17:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FD0784707;
	Sun, 10 May 2026 19:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ykxRRWbW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NM7YKCmT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9630D847C8; Sun, 10 May 2026 19:17:05 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D55148482E
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 19:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gD8fZ3T8Sz9vC5;
 Sun, 10 May 2026 19:16:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PPwQiAUHG+clPheYS9I5WIatOOg0azY1mEVe/npsbBU=;
 b=ykxRRWbWLf5MHAOG/aKrK3DoK7YupMshfmMffrtrIpYlig+jL4TC3RLUiUbycKQ+P/Z99a
 yaQF0HD/vzfMYqnqZocAr3RHBQl9C93uqtQn8iajH6g6+o7mAOkQboGoHM6AeglLq2U+/Q
 L1+MvEUxNjoam3gVSpP8KX7rWy2mAy4O/SyY/PzXFJ0esIIvhUsXH6YVFpxy/DBOX5vtOu
 z2NZ3z/yL40/hMORfqAmryT29i33e+ODGPMRl/5DQY0Pexj+142Phfl7p8w2jXffeNbhxN
 z111zcpdvTFw45K4zY/vrVb16+RPvE/RStuJp5hBDjGc1+eAYquOQYi6P8YsWA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=NM7YKCmT;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PPwQiAUHG+clPheYS9I5WIatOOg0azY1mEVe/npsbBU=;
 b=NM7YKCmTWeC3h6FSPIu+wijtIuEsBB8J3WcofXLCIO4ymYyynoo0n0V8pKfmXhyaLhA9Ty
 +yfCh0pul6/5FLJfUW8ga5jtBQz87Z2mbJ0HHY2voAMIJFMxKUSUq8o75ZJc+qgNfegu+b
 4GULTtb0ifQYIXh7Tjy4f85gObSTL1QbdKPN3pZqzeF01HiSs+Ci9mby4E4AYc3dsaUDTa
 pgSgYtEQCvaFXT5pNnH6kD6zIbqSudP8BztGyyYK1UjRzXBp4eeJvd9Itl9n+tlgoUtIsU
 VryI3uZCLXJ0Jr2czlyCSjtRxJvgGij/m+UOFaY/8HV5YoW8opDpvfARLw5jSg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] usb: dwc3: am62: Staticize and constify driver ops
Date: Sun, 10 May 2026 19:16:31 +0200
Message-ID: <20260510171649.56837-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 265f2e1eb03b6362e59
X-MBO-RS-META: q39n4kyibpzyr87h8gcp3c467tx6sq9s
X-Rspamd-Queue-Id: 4gD8fZ3T8Sz9vC5
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
 drivers/usb/dwc3/dwc3-am62.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 99519602eb2..8cb5796b6ad 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -105,7 +105,7 @@ static void dwc3_ti_am62_glue_configure(struct udevice *dev, int index,
 	writel(reg, usbss + USBSS_MODE_CONTROL);
 }
 
-struct dwc3_glue_ops ti_am62_ops = {
+static const struct dwc3_glue_ops ti_am62_ops = {
 	.glue_configure = dwc3_ti_am62_glue_configure,
 };
 
-- 
2.53.0

