Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58D7C83F1A
	for <u-boot@archiver.kernel.org>; Sun, 20 Jul 2025 20:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BEB483045;
	Sun, 20 Jul 2025 22:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WlXJe7lP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="A3dFPubN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DBB682DA1; Sun, 20 Jul 2025 22:00:49 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9F5783013
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 22:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4blZCL3Q2wz9snL;
 Sun, 20 Jul 2025 22:00:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753041646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0gooiqQTYme5yICqCoIU+5u2cM7BwCB/HIWs0u9Isvc=;
 b=WlXJe7lP5mkPUPUhu7kaojJ4S5cOLR9E6hNO6MOGJYKORPqSwEwbyEXVh6587awi82pmBa
 qfnw1gRkPU19BOwOzGIIbk4AvTo6DWX+zlfs6V0Z6Ro0MLUjl1+Bx9f9+NX/UR5ZW1p2uC
 VUNLH4d+L/U4pRDRgwJWshAhyI1xO/B0BQzOZe8F3gArXHDdivB/pK0TgB3ez1leQMceDK
 0ykLj2tEupMqPaXc/jX66gnAwE+nuLVHg0ss6nKX9VbEBigQxT5EDhbD4stAtQM/+P24LF
 6yGl3yXXkePs2O/vDa9Iwa9YdvAdpqDoxayM9jxggDIwXv3VGfiUGwg9FEXmbw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=A3dFPubN;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753041644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0gooiqQTYme5yICqCoIU+5u2cM7BwCB/HIWs0u9Isvc=;
 b=A3dFPubN74gM1IJj/VuCfNyHcLJYrQybRhjWZtQC/hCQrqVN4K2aP5NwubK+9dsuvql8C4
 Px8Rmf718bJSCAC3y/kWhre5nPuxZomGlWjfj8NiRn3Q2KKF9uJ3avDHZayyAQRFuTbfo+
 z0p9WMioKDGbWMtWtrTQhlburuIxpPwfDlrYPCdS7YgbJn6u6eQdP9kNZEETk+pldUXeRd
 Du/agbzxwiAf9V3756CAe8w7itKHs90RstsClcqtbJ4RPTJiNohyXX3SnD6D2RXnNOM0k5
 PMl4g0boz7XTw82Bod2HfU1Tvt+hwofGo0j7sGztglbJLv6T95UgkOxcwXS6Rg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] arm64: dts: renesas: r8a779g3: Describe generic SPI NOR
 support on Retronix R-Car V4H Sparrow Hawk board
Date: Sun, 20 Jul 2025 21:59:43 +0200
Message-ID: <20250720200003.414120-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e64d096555e885d63db
X-MBO-RS-META: y8go9bcawbwxmtheeb9b13imsyh34tro
X-Rspamd-Queue-Id: 4blZCL3Q2wz9snL
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

Retronix R-Car V4H Sparrow Hawk EVTA1 is populated with Spansion S25FS512S,
EVTB1 is populated with Winbond W77Q51NW. Describe the SPI NOR using generic
"spi-flash" compatible, because both flashes can be auto-detected based on
their built-in IDs.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts b/dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts
index b109095a0d8..a0fda441320 100644
--- a/dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts
+++ b/dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts
@@ -623,7 +623,11 @@
 	status = "okay";
 
 	flash@0 {
-		compatible = "spansion,s25fs512s", "jedec,spi-nor";
+		/*
+		 * EVTA1 is populated with Spansion S25fS512S
+		 * EVTB1 is populated with Winbond W77Q51NW
+		 */
+		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <40000000>;
 		spi-rx-bus-width = <4>;
-- 
2.47.2

