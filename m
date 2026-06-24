Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD508CDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 17:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30A6E8460E;
	Wed, 24 Jun 2026 19:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yKrkr8BT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XZLBjs7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AFC384659; Wed, 24 Jun 2026 19:14:35 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8BEF80398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 19:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4glpT42181z9vC1;
 Wed, 24 Jun 2026 19:14:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782321272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=U+AS91x54xgP3hiMJ5bUV+ddV0cpK4OqMalIpnjvYkU=;
 b=yKrkr8BTe2XZ6lLYcn1S6eTsfnGNfyjF1N3J8xTgHigWJ6keLf3VyvR5omOfBvB6tdJ/3b
 3u2U+BMCi0zFzL14df8dPT9ayn9Fg1a/y6ndbI4ha2QnMYRmObLoTlzfJXyrNO3uPn+Ufp
 FVnqpM3r/hPF55HkuiQmI7/3woyuKBf4UdaeNb7uWD8+9yYfcAeeZbSePAbLU9j26HfU+J
 OXYTchtrA+sguot3Pn9/kyQjqa43JQ8E34UIkIxe5u00g5//P2I0DcjU9FO9P1T1C8YyE/
 0SrcBe6633fpMDGRvMagSGLlcCb3NpNNBQxSMtwLyhFuTzPunepdXZDktnIYDQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782321270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=U+AS91x54xgP3hiMJ5bUV+ddV0cpK4OqMalIpnjvYkU=;
 b=XZLBjs7NY/HQSTALtShaSPd9iJxSRTgFMQJHr88d5sO7vEQpb+0raFeHCIyEnQx9dvA6eW
 GRBHAjHW7UxvHSdVrBycvut+kxH3jUhsDN00F02SNgYHI+yK6NfysFLnExBQF/pP7AQgsl
 QhuM0OiZjvpFBjrshPAno7b97g98rRr6aDB1VA5fbPd/oCG72ypPH2K4jQKWpqpXEtoDEY
 NiJbPprvyewTw0qdOEpwptykurxqO9wduGm2XrUofnQPTeFsjMB9ujD4TWszR8v1aqHmdY
 ROS/CQ/bJyR4QSYraSGcIpVzTefOAyZjmbnqLudAes4loRYuvR1Fies1+f638Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] MAINTAINERS: Update SH/SoCFPGA/USB email addresses
Date: Wed, 24 Jun 2026 19:13:49 +0200
Message-ID: <20260624171428.33523-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4h8k4y4xruqhx46rj8dnaeiha4fbgqxe
X-MBO-RS-ID: 20e7ec3f2bb148635aa
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

Update the email addresses to a valid one.
Use N: usb to match on all USB related bits.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>
---
 MAINTAINERS | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 571af196465..ba5ba77b0ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -161,7 +161,7 @@ F:	arch/arm/dts/Makefile
 F:	cmd/arm/
 
 ARM ALTERA SOCFPGA
-M:	Marek Vasut <marex@denx.de>
+M:	Marek Vasut <marek.vasut+socfpga@mailbox.org>
 M:	Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
 M:	Tien Fong Chee <tien.fong.chee@altera.com>
 S:	Maintained
@@ -1725,7 +1725,7 @@ F:	cmd/printf.c
 F:	doc/usage/setexpr.rst
 
 SH
-M:	Marek Vasut <marek.vasut+renesas@gmail.com>
+M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
 M:	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-sh.git
@@ -1938,14 +1938,10 @@ F:	test/boot/upl.c
 F:	test/py/tests/test_upl.py
 
 USB
-M:	Marek Vasut <marex@denx.de>
+M:	Marek Vasut <marek.vasut+usb@mailbox.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-usb.git
-F:	drivers/usb/
-F:	common/usb.c
-F:	common/usb_kbd.c
-F:	common/usb_storage.c
-F:	include/usb.h
+N:	usb
 
 USB TCPM
 M:	Sebastian Reichel <sebastian.reichel@collabora.com>
-- 
2.53.0

