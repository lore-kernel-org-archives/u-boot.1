Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB95CD8CA4
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 17:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1AB58394E;
	Thu, 13 Nov 2025 18:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="blBMEIVx";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="LrIwxXfP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA2AC83E61; Thu, 13 Nov 2025 18:04:53 +0100 (CET)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57D4A83936
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 18:04:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-ms9j.prod.antispam.mailspamprotection.com;
 s=arckey; t=1763053491; 
 b=Xvt0DiCAtiBJHUoMuxs4jgqj1SYUdh8SjsCADVcbWkpVZICzJSgiQpe6stDI3FOqwKjpuXxz0f
 L131yQhnoMSVvEB0MsKVpyiRBQu84ZqhGcWjEHPv9vPbZ13cfHk0nu99YfiJ8nXNpNTNRsIF95
 9oFvE/Ni1AnoAtTRsx4zPBHgfX5RE/1nWDVyf/M5975fd6flSmLLCtyKuIswVANOdGTyk+pm/v
 CQM7EwHJRD9zlTdsXiXjIKguUnqNtz+Uz4sAKVcVIeG+JV4Ew1PFSHcQWPVi4CJEluyd8uwBFj
 FK3T1eZ2Bxs41ZXGjIiYhEZbOzFaKkCDc6OUB6XgeSwj4g==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-ms9j.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-ms9j.prod.antispam.mailspamprotection.com;
 s=arckey; t=1763053491; 
 bh=RmLyQsN46sblR36nd9PZqhPp9Y2ADldOeuN92jYZgs8=;
 h=Cc:To:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Subject:Date:From:DKIM-Signature:DKIM-Signature;
 b=ce0uiI5RY2su6Z430WC3QgHHJoRPQEVjYJzRBDPVmIlvulDyu4JVp2OUNtnhWT70K9swLd2cjn
 pgIp/VzFzE7uKVjDFUAb9MhMCLaZYzY5ZRMzTyZ4VxvHAU8+SSfpMSXOYD9O7AXxZoRn2oAzAH
 ifoav61FGixCzKBi5qbBcjWkMcFhbSGmoBDFVsfEIFy1wJSQwWVc/qbDWVsclMDxRIBejSfSF6
 DDBMkf81k7/vSPFWxcD7/WbEReK6PkDH7FKVqEo25441u99QyrL8a6g5Lg1e+gSRk37WhIRnMM
 4EZNspAhC9rwSC+wsQf8QND79CIWD30vOQ2wCvVF2ZPJuA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=8nVgssRCtwPQtjNLNrp422SazD/FEkMSed24WzDWC70=; b=blBMEIVxQZt/DDF5YKVH+w0Sqv
 UKbOzC/tgCNiACRTCfbzVYGJQLVLClSHewCoGlq1wT8nw6v1nmybdJTcrF1lcXKYsc1g6xD3gJUP+
 DLRs0BdPvAalg/mlDCBROcYGAXJfrSu6t2ea/QnPIq3aSz9f1fzYzjYCLwi6S14UGEvE=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-ms9j.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.98.1)
 (envelope-from <francesco@valla.it>) id 1vJaka-0000000Aq03-2Hda
 for u-boot@lists.denx.de; Thu, 13 Nov 2025 17:04:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=8nVgssRCtwPQtjNLNrp422SazD/FEkMSed24WzDWC70=; b=LrIwxXfPVVq4CAsvPpch/HNXto
 zACLO0cJOkY+4SNfcJSEMglzBRy/dg1bYUMpkG1RAN+W+60xvHB2xSyIEeblCJgXTRjmpcfaw/6Ja
 R/19abrcctSEoMCM4JXljFG2FEKq5zdT9U2YC39gsM0t4eb89OqNaCIcEE04Se54p4O8=;
Received: from [87.14.44.186] (port=63433 helo=[192.168.178.65])
 by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.1) (envelope-from <francesco@valla.it>)
 id 1vJakO-00000000NKZ-0p85; Thu, 13 Nov 2025 17:04:36 +0000
From: Francesco Valla <francesco@valla.it>
Date: Thu, 13 Nov 2025 18:03:55 +0100
Subject: [PATCH] imx91: fix pinmux macros for ENET1_TD3 and I2C2_SCL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-imx91_pins_fix-v1-1-820933392e7f@valla.it>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WMQQ6CMBBFr0JmbY2DpVpX3sMQUksrk2AhLWkwp
 Hd3ZO/fvZf8t0FykVyCW7VBdJkSTYEBDxXYwYSXE9QzQ32qG+QJeq8au5lC6jytQj29cUpLbJQ
 FPs3Rsd6Dj5Z5oLRM8bP3M/7s31RGgcLrs7z4q1a2l/dsxtEcaYG2lPIFOQdADKsAAAA=
X-Change-ID: 20251111-imx91_pins_fix-6bfae694156c
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Javier Viguera <javier.viguera@digi.com>, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6097; i=francesco@valla.it;
 h=from:subject:message-id; bh=RmLyQsN46sblR36nd9PZqhPp9Y2ADldOeuN92jYZgs8=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDJli/Is3rN199cd0qbepP2b1XTununjCQ/Vl2S/XL2+p7
 37f/jG8tqOUhUGMi0FWTJElZN2Ne3vmmn9L28D4CGYOKxPIEAYuTgGYiJ8WI8OzetfZEsJGMxd1
 NyybeLVt5k2mfymLZhVLWNlvE0pb8GgSwz8jvmfdvC4bZ8t3+lgI3zwtu4irTSYx7tIpG3udfdP
 id3ICAA==
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: c6409236c34be70ec5921ff9f69cbb7f
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vJaka-0000000Aq03-2Hda-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-ms9j.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

Fix macros for the GPIO function for two pads (ENET1_TD3 and I2C2_SCL),
aligning them to the functions specified in the datasheet.

Fixes: a9d562daa3c3 ("imx: Add iMX91 support")

Suggested-by: Javier Viguera <javier.viguera@digi.com>
Signed-off-by: Francesco Valla <francesco@valla.it>
---
Part of this patch was initially sent under a different commit message,
[1] but was then completed with another related bugfix (thanks Javier).
I decided to merge the two because they can be seen as targeted to the
same purpose: proper support of OF_UPSTREAM for any device based on the
i.MX91 SoC.

Since the content is changed, I dropped the R-b tag by Fabio (hoping it
can be gained also for this version).

[1] https://lore.kernel.org/r/20251111-imx91_pins_fix-v1-1-f9347f896cd4@valla.it

Thank you!

Regards,
Francesco
---
 arch/arm/dts/imx91-11x11-evk.dts            | 2 +-
 arch/arm/dts/imx91-pinfunc.h                | 4 ++--
 arch/arm/include/asm/arch-imx9/imx91_pins.h | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/imx91-11x11-evk.dts b/arch/arm/dts/imx91-11x11-evk.dts
index 65571fc223b779d5aafc87da3940624db32418cf..ca9070a4c76440e72ecb2534ab55596fecb758d5 100644
--- a/arch/arm/dts/imx91-11x11-evk.dts
+++ b/arch/arm/dts/imx91-11x11-evk.dts
@@ -503,7 +503,7 @@
 			MX91_PAD_ENET1_TD0__GPIO4_IO5                          0x31e
 			MX91_PAD_ENET1_TD1__GPIO4_IO4                          0x31e
 			MX91_PAD_ENET1_TD2__GPIO4_IO3				0x31e
-			MX91_PAD_ENET1_TD3__GPIO4_IO3				0x31e
+			MX91_PAD_ENET1_TD3__GPIO4_IO2				0x31e
 			MX91_PAD_ENET1_TXC__GPIO4_IO7                          0x31e
 			MX91_PAD_ENET1_TX_CTL__GPIO4_IO6                       0x31e
 		>;
diff --git a/arch/arm/dts/imx91-pinfunc.h b/arch/arm/dts/imx91-pinfunc.h
index b0066df173b1386f040b0776fd798406a6e39e06..5677928ab7c4bdc1cfa02d7a1107e9c1da94d329 100644
--- a/arch/arm/dts/imx91-pinfunc.h
+++ b/arch/arm/dts/imx91-pinfunc.h
@@ -330,7 +330,7 @@
 #define MX91_PAD_ENET1_TD3__CAN2_TX                                              0x00a0 0x0250 0x0000 0x02 0x00
 #define MX91_PAD_ENET1_TD3__HSIOMIX_OTG_ID2                                      0x00a0 0x0250 0x0000 0x03 0x00
 #define MX91_PAD_ENET1_TD3__FLEXIO2_FLEXIO2                                      0x00a0 0x0250 0x0000 0x04 0x00
-#define MX91_PAD_ENET1_TD3__GPIO4_IO3                                            0x00a0 0x0250 0x0000 0x05 0x00
+#define MX91_PAD_ENET1_TD3__GPIO4_IO2                                            0x00a0 0x0250 0x0000 0x05 0x00
 #define MX91_PAD_ENET1_TD3__LPI2C2_SCL                                           0x00a0 0x0250 0x03e8 0x06 0x00
 
 #define MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2                                   0x00a4 0x0254 0x0000 0x00 0x00
@@ -680,7 +680,7 @@
 #define MX91_PAD_I2C2_SCL__LPUART2_DCB_B                                         0x0178 0x0328 0x0000 0x02 0x00
 #define MX91_PAD_I2C2_SCL__TPM2_CH2                                              0x0178 0x0328 0x0000 0x03 0x00
 #define MX91_PAD_I2C2_SCL__SAI1_RX_SYNC                                          0x0178 0x0328 0x0000 0x04 0x00
-#define MX91_PAD_I2C2_SCL__GPIO1_IO3                                             0x0178 0x0328 0x0000 0x05 0x00
+#define MX91_PAD_I2C2_SCL__GPIO1_IO2                                             0x0178 0x0328 0x0000 0x05 0x00
 #define MX91_PAD_I2C2_SCL__I3C1_PUR_B                                            0x0178 0x0328 0x0000 0x06 0x00
 
 #define MX91_PAD_I2C2_SDA__LPI2C2_SDA                                            0x017c 0x032c 0x03ec 0x00 0x01
diff --git a/arch/arm/include/asm/arch-imx9/imx91_pins.h b/arch/arm/include/asm/arch-imx9/imx91_pins.h
index 26246702a9607cd1ba6c8a15be9313db63b2a4af..838a81422575cd99726e8bfc74a94f34e6d38f50 100644
--- a/arch/arm/include/asm/arch-imx9/imx91_pins.h
+++ b/arch/arm/include/asm/arch-imx9/imx91_pins.h
@@ -329,7 +329,7 @@ enum {
 	MX91_PAD_ENET1_TD3__CAN2_TX                                                     = IOMUX_PAD(0x0250, 0x00A0, 0x02, 0x0000, 0x00, 0x00),
 	MX91_PAD_ENET1_TD3__HSIOMIX_OTG_ID2                                             = IOMUX_PAD(0x0250, 0x00A0, 0x03, 0x0000, 0x00, 0x00),
 	MX91_PAD_ENET1_TD3__FLEXIO2_FLEXIO2                                             = IOMUX_PAD(0x0250, 0x00A0, 0x04, 0x0000, 0x00, 0x00),
-	MX91_PAD_ENET1_TD3__GPIO4_IO3                                                   = IOMUX_PAD(0x0250, 0x00A0, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_ENET1_TD3__GPIO4_IO2                                                   = IOMUX_PAD(0x0250, 0x00A0, 0x05, 0x0000, 0x00, 0x00),
 	MX91_PAD_ENET1_TD3__LPI2C2_SCL                                                  = IOMUX_PAD(0x0250, 0x00A0, 0x06, 0x03E8, 0x00, 0x00),
 
 	MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2                                          = IOMUX_PAD(0x0254, 0x00A4, 0x00, 0x0000, 0x00, 0x00),
@@ -679,7 +679,7 @@ enum {
 	MX91_PAD_I2C2_SCL__LPUART2_DCB_B                                                = IOMUX_PAD(0x0328, 0x0178, 0x02, 0x0000, 0x00, 0x00),
 	MX91_PAD_I2C2_SCL__TPM2_CH2                                                     = IOMUX_PAD(0x0328, 0x0178, 0x03, 0x0000, 0x00, 0x00),
 	MX91_PAD_I2C2_SCL__SAI1_RX_SYNC                                                 = IOMUX_PAD(0x0328, 0x0178, 0x04, 0x0000, 0x00, 0x00),
-	MX91_PAD_I2C2_SCL__GPIO1_IO3                                                    = IOMUX_PAD(0x0328, 0x0178, 0x05, 0x0000, 0x00, 0x00),
+	MX91_PAD_I2C2_SCL__GPIO1_IO2                                                    = IOMUX_PAD(0x0328, 0x0178, 0x05, 0x0000, 0x00, 0x00),
 	MX91_PAD_I2C2_SCL__I3C1_PUR_B                                                   = IOMUX_PAD(0x0328, 0x0178, 0x06, 0x0000, 0x00, 0x00),
 
 	MX91_PAD_I2C2_SDA__LPI2C2_SDA                                                   = IOMUX_PAD(0x032C, 0x017C, 0x00, 0x03EC, 0x01, 0x00),

---
base-commit: 365a7079fb918643da0f0709660a7d8ea76dd6f3
change-id: 20251111-imx91_pins_fix-6bfae694156c

Best regards,
-- 
Francesco Valla <francesco@valla.it>

