Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C799FC54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 12:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 309C087FC9;
	Fri, 15 Mar 2024 13:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="hltxdOud";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79CD987D84; Fri, 15 Mar 2024 13:01:36 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A65AB87FBC
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 13:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1710504092;
 bh=tqtL3JHP4JQrlm7rZQSgKzbeMOl/2MuNk+izap8v3Fg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hltxdOudKBMh7/y2BF+db+6gdjzMiyIA4keyimNFyuVBhWg6eZ+sHcPfp4X/bNrPl
 lfjv3/anWrm3AxvX2GxJNwdNtrKb1lKKbQNMYAUvNB83pAgmDM9LlQE7oxzdnpdboZ
 WtyG8r1OWOPPeKYjGOjH1YdeKvs9f6lEPNFY7OMVvrWItIqQ/lMCJ86GmjxMTpavW1
 8+RE9N1bT/a7fZSL1BvW9wwfSZub3aDb28bsWWtIcQ7CChkOq8FcVdGWS0IKEI6m0F
 I5fFBztCvRC3L0nXcxAo2UWXfBSedhsgTFQFfLAS0SnjqIw5iQLTKbN9R40lFk52T3
 UOtqhAJrMfcnA==
Received: from obbardc-t14.home (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: obbardc)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id C5196378210F;
 Fri, 15 Mar 2024 12:01:31 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
To: u-boot@lists.denx.de
Cc: kernel@collabora.com, Christopher Obbard <chris.obbard@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] arm: rockchip: sync ROCK Pi 4A DTS from Linux
Date: Fri, 15 Mar 2024 12:01:18 +0000
Message-ID: <20240315120126.75424-2-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315120126.75424-1-chris.obbard@collabora.com>
References: <20240315120126.75424-1-chris.obbard@collabora.com>
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

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---

Changes in v2:
- Collect Reviewed-by tag from Kever Y.

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

