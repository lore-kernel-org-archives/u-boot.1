Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E62EC5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 12:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABF1D8813E;
	Fri,  1 Mar 2024 13:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=mecka.net header.i=@mecka.net header.b="MIAAOJjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4084F8812A; Fri,  1 Mar 2024 13:00:28 +0100 (CET)
Received: from mecka.net (unknown [IPv6:2a01:4f8:1c1c:934f::1])
 by phobos.denx.de (Postfix) with ESMTP id 2567C88143
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 13:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=manut@mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
 t=1709294423; bh=oYVpbSmJD4zWayjZS3n22J1dibML+LCwS+1HQ/yK5Yc=;
 h=Date:From:To:Cc:Subject:From;
 b=MIAAOJjF9ZhWlFafAHiO4xZu5Xsrb2R2zN2hhxweOMCDiniaPurjQm/plYT99Sz3t
 8kFZpf3lEr6jzUoLXPkQeKy5C2LdeRAEvJQodCQ3WZZmdZ1puLX5yXw/SvdgwceMYP
 wv5GWHjmfY5Cpwhii36AgOHRlkGywkrcE03ioaBxZh79Iwu3E2eIuWguGAxfC/hS5Z
 zlwoaKFads0wtCUEwiHRa3iaP5l6oC0N2+LGLSz1FfSvJqrTNVGHVjIqfYKwlOeTH2
 XGidcc2VuNVKQs+b6ke7Bw+bgaU1QYLDWxSpGKe/svs5WhvoyWeVdzDNJt623krIn3
 ZD8exlbzV10SQ==
Received: from mecka.net (unknown [185.147.11.134])
 by mecka.net (Postfix) with ESMTPSA id 9AAE83E249E;
 Fri,  1 Mar 2024 13:00:23 +0100 (CET)
Date: Fri, 1 Mar 2024 13:00:22 +0100
From: Manuel Traut <manut@mecka.net>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>, Manuel Traut <manuel.traut@mt.com>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH] dts: imx8mm: Add optee entry for binman
Message-ID: <ZeHDVr-Bzm935-5N@mecka.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 01 Mar 2024 13:24:05 +0100
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

Used to embed the OPTEE OS binary into flash.bin so it can be
detected and loaded by trusted-firmware-arm.

Signed-off-by: Manuel Traut <manuel.traut@mt.com>
---
 arch/arm/dts/imx8mm-u-boot.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index 06f2f73a03..8ca4515c9f 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -130,6 +130,22 @@
 						type = "atf-bl31";
 					};
 				};
+
+#ifdef CONFIG_OPTEE
+				optee {
+						description = "OP-TEE";
+						type = "firmware";
+						arch = "arm";
+						os = "tee";
+						compression = "none";
+						load = <0xbe000000>;
+						entry = <0xbe000000>;
+
+						blob-ext {
+								filename = "tee.bin";
+						};
+				};
+#endif
 #endif
 
 				binman_fip: fip {
@@ -160,7 +176,11 @@
 					fdt = "fdt-SEQ";
 					firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
+#ifdef CONFIG_OPTEE
+					loadables = "atf", "optee";
+#else
 					loadables = "atf";
+#endif
 #endif
 				};
 			};
-- 
2.43.0

