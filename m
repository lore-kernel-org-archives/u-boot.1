Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9835CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 22:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DCA383835;
	Sat, 18 Oct 2025 00:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="E9S7Y906";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DXwV7VRI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6156983835; Sat, 18 Oct 2025 00:10:05 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A678382E
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 00:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cpJsQ56jgz9tJ6;
 Sat, 18 Oct 2025 00:10:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1760739002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MIcp0Z6Q2ahKo1YQcYu3Fp6k0ofSfCxjsDqqW3TRuwo=;
 b=E9S7Y906vpfRQYMlHTyabFNtcJiyfoFFDGrgOspXnaw/4FUixWUgM7imbCMDwzqGdqg1w1
 JEv8QYHi+ZBH7ehFX4epIdC8aap9f6WbHwOhl4OYboIJ/ejXL5nj4RTafTYXBZnlYJTeT5
 pS5ZFOcctLW+Hw6dvXEXAcNZBTonXEgQk38oSgCQtPXSfQZ7Vwe5zcVKMz7MiC+0rDQHvo
 cgRPw5zWNkdWjwQ9txFRhcz3OFi+PGgFEk8cBjcK1+0r1xa/mEk3bT8sX8JPit6smuZfn3
 08DVzQ1Hv00tYPw5dlCgvApICmT1n8R8BcKNz8iXDxhcy0TX3T+PEnBRxqZezA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1760739000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MIcp0Z6Q2ahKo1YQcYu3Fp6k0ofSfCxjsDqqW3TRuwo=;
 b=DXwV7VRIWU/6jxOJoynl8rOd15snfAhEM7AW5q3MaLaN0jziupDFmoJQP1tyBf8Oo+tkDX
 zyWtAM4rTlF3HXBgQmEFLH1gnKOZx6if6nlV3a9J8A+ApEHvIyl1zll8fAS+B4/59Hqd4q
 2wti7n77PLr7w07pnlyi25triVOvcZ6qHovXOTCQyLmviEolEDxaQf5RPz2xPVqE5hCWMz
 YpShvzwG00MKIoRe/NAOBvm7s0dVznh7u9HueVIljacBflYr7P4sPOtzTIiccN2mpoZWwj
 mBoJn/aOLjtjQIixRt6RGB2nNt9VPjORMaEPLA+WIU/o4e9CqI9+Bp5lVvLFRg==
To: u-boot@lists.denx.de
Cc: Nguyen Tran <nguyen.tran.pz@bp.renesas.com>,
 Khanh Le <khanh.le.xr@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: dts: renesas: Disable RPC driver on R8A779H0 V4M Gray
 Hawk board
Date: Sat, 18 Oct 2025 00:09:09 +0200
Message-ID: <20251017220944.138456-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7bfe968c7e5e87e9f05
X-MBO-RS-META: d7hnw1wmpfm9r5omtohs99p3gzducyr4
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

From: Nguyen Tran <nguyen.tran.pz@bp.renesas.com>

As requirement of CR side, QSPI Flash usage via RPC driver shall
be disabled and leaving the control of this module to CR side.
Perform DT modification to disable the RPC SPI.

Signed-off-by: Nguyen Tran <nguyen.tran.pz@bp.renesas.com>
Reviewed-by: Khanh Le <khanh.le.xr@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
[Marek: Do not modify defconfig, modify the DT instead, this way
        the RPC SPI can be enabled without recompiling the U-Boot
        itself. Update commit message accordingly.]
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/r8a779h0-gray-hawk-single-u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/r8a779h0-gray-hawk-single-u-boot.dtsi b/arch/arm/dts/r8a779h0-gray-hawk-single-u-boot.dtsi
index 91e1ee1f890..c04d2ae2be4 100644
--- a/arch/arm/dts/r8a779h0-gray-hawk-single-u-boot.dtsi
+++ b/arch/arm/dts/r8a779h0-gray-hawk-single-u-boot.dtsi
@@ -27,7 +27,7 @@
 	#address-cells = <1>;
 	#size-cells = <0>;
 	spi-max-frequency = <40000000>;
-	status = "okay";
+	status = "disabled";
 
 	flash@0 {
 		#address-cells = <1>;
-- 
2.51.0

