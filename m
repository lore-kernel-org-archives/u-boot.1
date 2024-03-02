Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFBBC5478C
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 14:34:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5392A8785A;
	Sat,  2 Mar 2024 15:34:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ESNLywr0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E12DB87DCA; Sat,  2 Mar 2024 15:34:33 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EEE087D37
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 15:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1709390071;
 bh=IfRf6oebHUqBY1Zom3bGXwqYrXse6aQ84mDhGSkkQ30=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ESNLywr0Ryod0kBcWEmzDCQ06BteIKZinRRpyMZ1d2EYQ4gYcMuOCsUJGG1NUtOau
 glw5XeHsEROjK5/ssp9OVVe8Lv4W41ZZy57bs8Z6urI4RgWMalvxmpvDMaxoLhX0WA
 fUDK0sbIZ6MMq8WB5ARY7MMmkEgmVst00TvcYreB7S27Pv8DLpMZOQlEyq4guH1qf/
 sHeTDsbOZj605nuX5sTWxkPlGGuAjciPO62v7h85lsmkyYxufm/+KUikBV4dqs3kWG
 qFo/ouuSJvmBOQLpkGUFxM6tfM6SZz5hOoNBdOzeUuzQr0lSqdwRQgjzcUve5Tm0qx
 N8QbYM1G2FIcA==
Received: from obbardc-t14.home (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: obbardc)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4272D378208D;
 Sat,  2 Mar 2024 14:34:31 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
To: u-boot@lists.denx.de
Cc: kernel@collabora.com, Christopher Obbard <chris.obbard@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/2] arm: rockchip: sync ROCK Pi 4A DTS from Linux
Date: Sat,  2 Mar 2024 14:34:10 +0000
Message-ID: <20240302143417.164560-2-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302143417.164560-1-chris.obbard@collabora.com>
References: <20240302143417.164560-1-chris.obbard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

To prepare for ROCK Pi 4A SPI flash support, sync the DTS from Linux which
includes an SPI flash node.

Kernel tag: v6.6-rc1
Kernel commits:
 - eddf73029770 ("arm64: dts: rockchip: Enable internal SPI flash for ROCK \
                  Pi 4A/B/C")

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---

 arch/arm/dts/rk3399-rock-pi-4a.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/dts/rk3399-rock-pi-4a.dts b/arch/arm/dts/rk3399-rock-pi-4a.dts
index 931334aa3d6..d5df8939a65 100644
--- a/arch/arm/dts/rk3399-rock-pi-4a.dts
+++ b/arch/arm/dts/rk3399-rock-pi-4a.dts
@@ -12,3 +12,13 @@
 	model = "Radxa ROCK Pi 4A";
 	compatible = "radxa,rockpi4a", "radxa,rockpi4", "rockchip,rk3399";
 };
+
+&spi1 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+	};
+};
-- 
2.43.0

