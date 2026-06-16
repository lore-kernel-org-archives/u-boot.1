Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6191CD98E4
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 19:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9919B848C5;
	Tue, 16 Jun 2026 21:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DDEDL4Cq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F26CA84970; Tue, 16 Jun 2026 21:19:05 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0321784895
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 21:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490a76757e5so35961225e9.2
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 12:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781637543; x=1782242343; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7DLYoFjMmzIG/KeRpUl/4sc47lOw3Oy4VAGTzOIAC4w=;
 b=DDEDL4CqSSbt5Tg4uP/UfB2JR0DtUP+llOSkZkuX/vXE51X4o5Xvgn3DAxzJPGCtBf
 4QaWfEQzL8RTat9qoFhRnh5XUotv+eNGsqnt3I3WKKY4cvVMR5F3GosEku8kkjc/mS+b
 3R3UGlAJtP2zspdy5siA/q8RRl422ENNL0555qXp7KlU7CH8tIpgWkCpJH/BuNfBqKHC
 pylu7mfgK3xWKfw7uYOfC60+GS3bkNtDaX8aLApaKMW+X1QpYXdzuvA8Qn+30/8KH13f
 agvbEaM+It4pboXm9X/2x3QMb0ps7F68kxgrWTCWkJfcNWaW0qpk6FDk5wCdUO7jzVKl
 hLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781637543; x=1782242343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7DLYoFjMmzIG/KeRpUl/4sc47lOw3Oy4VAGTzOIAC4w=;
 b=bjVAr39OJEuvcLv2/dncdsWIZykBgODPV2wO3fQzMD8l7gEdYFZkeAjdpsvJKdTvWt
 q7f7T68l0dK4f2SOO4t6PVtt23AHgBz2MWHHVJU/pSciFnRxErjd4fgKOVg3IPkzXdph
 PzGKlWZbqZdcqP8srv61L/wmbt0mzCLzVKur/Y5+oi0Smmbz/pi8HYK9Fnb4f8PBZ/zw
 SqVqu71a6n1jECOjJx8SPGKG0SUx9BRwavadXQAxHLWunf4O1M/QP6Hf65s2kwK1HkMR
 HK2d5MGJFStGsiTLx9B2TXvVXjKLaA/U/QNmYEiR2dzXxGX+lu7RyVvJL/ZH+7iHj7NS
 3wcQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8r/DIWTPJsC3CX51RKAcViDze9tt84aZBjkAEmsAudD23w5QQZJzx6xIhwEtQQkIx30el79Q0=@lists.denx.de
X-Gm-Message-State: AOJu0YxuHaWMA1HaUGyv6XG49Ac009izeVdwyUbi10qSi90gqdfamIzE
 jaAtSsROjU2hibCSPgvoExUhq4mZjYFAtAHwr5Oe/osuGcV+LafBOoQ2
X-Gm-Gg: Acq92OEPZIvLgdr6igm2h3LMwQXoXrsRG82znS2uSmqG6esxGk9lNnfvbYUaNF/jLc3
 L84hGHGAfVcKC/I432y92YjEiAOBDs9etWuWBS1y3ZlY3n2kZWKLgT2YvYljoSxpKLuO1LjWUx2
 mqbPEZTVfXTlTu3EyY+KMPE+HutKItAoxIseqSFaThX294fO8YXKCwBNKu1Z1+c5lJBPU13HeUz
 A/oIF4JpTw5NtpfXC/4EOQyWFTFQrn8Nx3dU2x/X7l8/ux5WR9yTUD2JPIydMS9Ky8a4C1Ol5vK
 /FHXyKZTDPFfj+fuTNp5DEcMU2QPomY7KA2w8HPkQ7dv98d11+fA5nUfZr6CgHO3KED++bWZvhd
 a3VPhb8RNXl+MCquUfAexxNutPO5pzVWsS+wyaIxI2sESU4+WvSZgUY1Ct36uUahbwNlazfq0nh
 L2ZzYF1HKlBdeb5CY0SIXADr1U8D/Y8xvpTWZZqHmiMldTN0WJmrkSNLc=
X-Received: by 2002:a05:600c:608f:b0:490:c0d8:d517 with SMTP id
 5b1f17b1804b1-492333ba2cdmr15766335e9.3.1781637543194; 
 Tue, 16 Jun 2026 12:19:03 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-88-103.ip49.fastwebnet.it. [93.34.88.103])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4922f9cd140sm91326895e9.0.2026.06.16.12.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:19:02 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Martin Schwan <m.schwan@phytec.de>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, Randolph Sapp <rs@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH v7 6/7] doc: dtbinding: Update documentation for Generic
 Firmware loader
Date: Tue, 16 Jun 2026 21:18:41 +0200
Message-ID: <20260616191845.6182-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616191845.6182-1-ansuelsmth@gmail.com>
References: <20260616191845.6182-1-ansuelsmth@gmail.com>
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

Update documentation for Generic Firmware loader, generalize it from FS
specific and add new property and example for FIP loader.

Also add details on the usage of 'phandlepart', 'mtdpart' and 'ubivol'
property.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../misc/{fs_loader.txt => fw_loader.txt}     | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)
 rename doc/device-tree-bindings/misc/{fs_loader.txt => fw_loader.txt} (58%)

diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fw_loader.txt
similarity index 58%
rename from doc/device-tree-bindings/misc/fs_loader.txt
rename to doc/device-tree-bindings/misc/fw_loader.txt
index 542be4b25a0a..f62a8c760fc1 100644
--- a/doc/device-tree-bindings/misc/fs_loader.txt
+++ b/doc/device-tree-bindings/misc/fw_loader.txt
@@ -1,17 +1,27 @@
-* File system firmware loader
+* Generic Firmware loader
 
 Required properties:
 --------------------
 
-- compatible: should contain "u-boot,fs-loader"
+- compatible: should contain "u-boot,fs-loader" or "u-boot,fip-loader"
+
+Optional properties:
+--------------------
+
 - phandlepart: which block storage device and partition the image loading from,
 	       this property is required for mmc, usb and sata. This is unsigned
 	       32-bit array. For example phandlepart=<&mmc_0 1>, meaning use
 	       that MMC0 node pointer, partition 1.
-- mdtpart: which partition of ubi the image loading from, this property is
+- mtdpart: which partition of ubi the image loading from, this property is
 	   required for ubi and mounting.
 - ubivol: which volume of ubi the image loading from, this property is required
 	  for ubi and mounting.
+- partoffset: valid ONLY for "u-boot,fip-loader". Offset of the partition to
+	      parse the FIP partition from.
+
+Either 'phandlepart' or 'mtdpart' can be used. For Block device, 'phandlepart'
+should be used and for MTD device, 'mtdpart' should be used. With UBI device,
+in addition to 'mtdpart' also 'ubivol' is required.
 
 Example of storage device and partition search set for mmc, usb, sata and
 ubi in device tree source as shown in below:
@@ -46,3 +56,20 @@ ubi in device tree source as shown in below:
 		mtdpart = "UBI",
 		ubivol = "ubi0";
 	};
+
+	Example for FIP from eMMC:
+	fs_loader4: fip-loader@4 {
+		bootph-all;
+		compatible = "u-boot,fip-loader";
+		phandlepart = <&mmc0 0>;
+		partoffset = <0x100>;
+	};
+
+	Example for FIP from ubi:
+	fs_loader4: fip-loader@4 {
+		bootph-all;
+		compatible = "u-boot,fip-loader";
+		mtdpart = "ubi",
+		ubivol = "bl31";
+	};
+
-- 
2.53.0

