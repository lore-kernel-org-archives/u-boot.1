Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D52EECD6F3
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 22:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC5DF83B30;
	Wed, 11 Feb 2026 23:11:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QKnGeekT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 930B783B64; Wed, 11 Feb 2026 23:11:41 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2663A8388D
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 23:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-40ea611d1a4so615419fac.2
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 14:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770847898; x=1771452698; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kvq5Dkg4N0ptHvcvY3xXcn4wRGRpsJe69JXn69YI2f0=;
 b=QKnGeekTUgbz0QGKadvrApGnzZnA76BdTqVkLP6gLRbOcbXqZ5dz0roRMcAM4wUAdb
 dq9ZfH/S6ZObpAH26Vrtde4TzE7z7nzhjQyNeuukOUOL0Qet+V/TuGBMOMMlIK4EgawZ
 Zfz/ncK5yYh/6suDEooHZ2s4e0/U+NORH1cUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770847898; x=1771452698;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kvq5Dkg4N0ptHvcvY3xXcn4wRGRpsJe69JXn69YI2f0=;
 b=qN35GBwyreLHeKxc5RnYPGNrYGHP2WH2HB+odFZGhWCjkApF/W30rEBHf+L+M+k8BA
 VT6996w+e7Rui5Tclpmd7yu+aoRt85Z88+3HlP3wninwQ46SO8o00C2pRm60b8Lb5OPY
 rfJ3zj0TiAEsRG0L4uQYlC5aJMr0nh4ruk1j7cn+UUhikAN1AtawPcN2lkJ8ELo+NjDW
 HGP5dE7KOeo4Fu5DNHOtSqkRkrB8sHdn51v9QweS2+8oloKF6KNq+xorLrjTJP3rVlSr
 OpkzHsiH2ktfgiydMT/glRVcKV0m7kpu7hkyUbnsFUrbViMK5TrqYxPANP8ZpEndHcq0
 uHqw==
X-Gm-Message-State: AOJu0YxDDekzmx12L9vMWFZ1uRDHy/8W/hQCN7BsYiNvTbflX2qx8Eil
 3nqbLt+Z1eAnyB/is+VificSsHAwY61jgUXWNYmh/ZDZYyGr8L7OG2b4u5XdZAidzMlelR75I/5
 bnNTtyPs=
X-Gm-Gg: AZuq6aJytRs/DpPBU5QGK8xU+EXrBn3SaIzjHutgZOT0RwCwindrJXpVwOMoo5v48M3
 saAjjyTB9hy9SZa4S+YAswjj2e/uWBuMDSi0A9smOf8nhiVQJdXj5kfMdtm3HvyNwJiqE508CdZ
 xuEyRWgHMbMuDbh9bGJsZC9mSpfjOmlKQ4gsVwMyTt2vY/Ilbac9lJD0w2lNXYi4EwqgyxermrC
 h1h9wJ2GepvgspFw1HjuJ5eRJI4KhY72EHi+X+t3qxx1acR4eqzd5KVSRxhnr6s8GOqb13GnlzG
 /Effio7hFQPowWgCE1DM4MTkbGiNnw0Qy8HU4GYGU0fnJeotRrdNK8UpPGty82dyDvW4xWTIA++
 p/5ECq9x6A7nCQUfe2WYuWkHwIFVWZ5i9JH+fhEyf0Nj4XBFg2YVKjYkNhQfdXn3AslPuTwpTX8
 EAALgG5E6nz9JP2ut7z49EZzuW8hnmEn7LHHqxfrhvi411HGsN9bITzXeRmfmnCAex4HbQ3D2Xe
 JVWxniO2umStrLGKcZfkI5l8q+Z7qmofVPitQWENRNEBiMQHWfBJR53W5uXifSw
X-Received: by 2002:a05:6820:99a:b0:65f:7375:e92 with SMTP id
 006d021491bc7-675986584b2mr410940eaf.5.1770847897741; 
 Wed, 11 Feb 2026 14:11:37 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaeb42708sm2347661fac.0.2026.02.11.14.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:11:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Dominik Haller <d.haller@phytec.de>, Fabio Estevam <festevam@gmail.com>,
 Garrett Giordano <ggiordano@phytec.com>,
 Gilles Talis <gilles.talis@gmail.com>, Joseph Guo <qijian.guo@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Teresa Remmet <t.remmet@phytec.de>,
 Wadim Egorov <w.egorov@phytec.de>, upstream@lists.phytec.de
Subject: [PATCH] board: Correct usage of fdtfile=CONFIG_DEFAULT_FDT_FILE
Date: Wed, 11 Feb 2026 16:11:35 -0600
Message-ID: <20260211221135.1738981-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As explained in commit 03d2d5fc003f ("board: sifive: unmatched: set
fdtfile with unquoted variable.") using the syntax of
'fdtfile=CONFIG_DEFAULT_FDT_FILE' in the plain text environment files
will lead to extraneous and problematic "s in the output. This is fixed
by using fdtfile=DEFAULT_FDT_FILE which was introduced recently.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
This is for the next branch currently.

Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Christoph Stoidner <c.stoidner@phytec.de>
Cc: Dominik Haller <d.haller@phytec.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Garrett Giordano <ggiordano@phytec.com>
Cc: Gilles Talis <gilles.talis@gmail.com>
Cc: Joseph Guo <qijian.guo@nxp.com>
Cc: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Teresa Remmet <t.remmet@phytec.de>
Cc: Wadim Egorov <w.egorov@phytec.de>
Cc: upstream@lists.phytec.de
---
 board/emcraft/imx8mp_navqp/imx8mp_navqp.env          | 2 +-
 board/nxp/imx8mm_evk/imx8mm_evk.env                  | 2 +-
 board/nxp/imx8mn_evk/imx8mn_evk.env                  | 2 +-
 board/nxp/imx8mp_evk/imx8mp_evk.env                  | 2 +-
 board/nxp/imx8mq_evk/imx8mq_evk.env                  | 2 +-
 board/nxp/imx8ulp_evk/imx8ulp_evk.env                | 2 +-
 board/nxp/imx91_evk/imx91_evk.env                    | 2 +-
 board/nxp/imx91_frdm/imx91_frdm.env                  | 2 +-
 board/nxp/imx93_evk/imx93_evk.env                    | 2 +-
 board/nxp/imx93_frdm/imx93_frdm.env                  | 2 +-
 board/nxp/imx93_qsb/imx93_qsb.env                    | 2 +-
 board/nxp/imx94_evk/imx94_evk.env                    | 2 +-
 board/nxp/imx95_evk/imx95_evk.env                    | 2 +-
 board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env | 2 +-
 board/phytec/phycore_am62ax/phycore_am62ax.env       | 2 +-
 board/phytec/phycore_am62x/phycore_am62x.env         | 2 +-
 board/phytec/phycore_am64x/phycore_am64x.env         | 2 +-
 board/phytec/phycore_am68x/phycore_am68x.env         | 2 +-
 board/phytec/phycore_imx8mm/phycore_imx8mm.env       | 2 +-
 board/phytec/phycore_imx8mp/phycore_imx8mp.env       | 2 +-
 board/phytec/phycore_imx93/phycore_imx93.env         | 2 +-
 21 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/board/emcraft/imx8mp_navqp/imx8mp_navqp.env b/board/emcraft/imx8mp_navqp/imx8mp_navqp.env
index c19fe08648a4..326023274e98 100644
--- a/board/emcraft/imx8mp_navqp/imx8mp_navqp.env
+++ b/board/emcraft/imx8mp_navqp/imx8mp_navqp.env
@@ -11,7 +11,7 @@ image=Image
 console=ttymxc1,115200 earlycon=ec_imx6q,0x30890000,115200
 fdt_addr_r=0x43000000
 boot_fdt=try
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 initrd_addr=0x43800000
 bootm_size=0x10000000
 mmcpart=1
diff --git a/board/nxp/imx8mm_evk/imx8mm_evk.env b/board/nxp/imx8mm_evk/imx8mm_evk.env
index 299b8472c74c..d59bd6fd5edc 100644
--- a/board/nxp/imx8mm_evk/imx8mm_evk.env
+++ b/board/nxp/imx8mm_evk/imx8mm_evk.env
@@ -6,7 +6,7 @@ boot_targets=mmc1 mmc2 dhcp
 bootm_size=0x10000000
 console=ttymxc1,115200
 fdt_addr_r=0x48000000
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 fdtoverlay_addr_r=0x49000000
 initrd_addr=0x48080000
 image=Image
diff --git a/board/nxp/imx8mn_evk/imx8mn_evk.env b/board/nxp/imx8mn_evk/imx8mn_evk.env
index 487893f92876..cffa83bf7928 100644
--- a/board/nxp/imx8mn_evk/imx8mn_evk.env
+++ b/board/nxp/imx8mn_evk/imx8mn_evk.env
@@ -6,7 +6,7 @@ boot_targets=mmc1 mmc2 dhcp
 bootm_size=0x10000000
 console=ttymxc1,115200
 fdt_addr_r=0x48000000
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 fdtoverlay_addr_r=0x49000000
 initrd_addr=0x48080000
 image=Image
diff --git a/board/nxp/imx8mp_evk/imx8mp_evk.env b/board/nxp/imx8mp_evk/imx8mp_evk.env
index 18cdf3da0568..e994b93b168d 100644
--- a/board/nxp/imx8mp_evk/imx8mp_evk.env
+++ b/board/nxp/imx8mp_evk/imx8mp_evk.env
@@ -7,7 +7,7 @@ bootm_size=0x10000000
 console=ttymxc1,115200 earlycon=ec_imx6q,0x30890000,115200
 fdt_addr_r=0x43000000
 fdt_addr=0x43000000
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 image=Image
 ip_dyn=yes
 mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
diff --git a/board/nxp/imx8mq_evk/imx8mq_evk.env b/board/nxp/imx8mq_evk/imx8mq_evk.env
index cab8c6b70bf3..6575dd7cb07b 100644
--- a/board/nxp/imx8mq_evk/imx8mq_evk.env
+++ b/board/nxp/imx8mq_evk/imx8mq_evk.env
@@ -5,7 +5,7 @@ boot_targets=mmc1 mmc2 dhcp
 bootm_size=0x10000000
 console=ttymxc0,115200
 fdt_addr_r=0x43000000
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 initrd_addr=0x43800000
 image=Image
 ip_dyn=yes
diff --git a/board/nxp/imx8ulp_evk/imx8ulp_evk.env b/board/nxp/imx8ulp_evk/imx8ulp_evk.env
index 52d7f4470297..da97631e03ee 100644
--- a/board/nxp/imx8ulp_evk/imx8ulp_evk.env
+++ b/board/nxp/imx8ulp_evk/imx8ulp_evk.env
@@ -23,7 +23,7 @@ mmcdev=CONFIG_SYS_MMC_ENV_DEV
 mmcpart=1
 image=Image
 cntr_file=os_cntr_signed.bin
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 console=ttyLP1,115200 earlycon
 bootm_size=0x10000000
 boot_fit=no
diff --git a/board/nxp/imx91_evk/imx91_evk.env b/board/nxp/imx91_evk/imx91_evk.env
index 6c10784cf61a..d669c6e31337 100644
--- a/board/nxp/imx91_evk/imx91_evk.env
+++ b/board/nxp/imx91_evk/imx91_evk.env
@@ -8,7 +8,7 @@ cntr_file=os_cntr_signed.bin
 console=ttyLP0,115200 earlycon
 fdt_addr_r=0x83000000
 fdt_addr=0x83000000
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 image=Image
 mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
 mmcpart=1
diff --git a/board/nxp/imx91_frdm/imx91_frdm.env b/board/nxp/imx91_frdm/imx91_frdm.env
index b0450ff576c5..557e508bd6af 100644
--- a/board/nxp/imx91_frdm/imx91_frdm.env
+++ b/board/nxp/imx91_frdm/imx91_frdm.env
@@ -8,7 +8,7 @@ cntr_file=os_cntr_signed.bin
 console=ttyLP0,115200 earlycon
 fdt_addr_r=0x83000000
 fdt_addr=0x83000000
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 image=Image
 mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
 mmcpart=1
diff --git a/board/nxp/imx93_evk/imx93_evk.env b/board/nxp/imx93_evk/imx93_evk.env
index d5ed216f54b5..b2ed1901a2b7 100644
--- a/board/nxp/imx93_evk/imx93_evk.env
+++ b/board/nxp/imx93_evk/imx93_evk.env
@@ -8,7 +8,7 @@ cntr_file=os_cntr_signed.bin
 console=ttyLP0,115200 earlycon
 fdt_addr_r=0x83000000
 fdt_addr=0x83000000
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 image=Image
 mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
 mmcpart=1
diff --git a/board/nxp/imx93_frdm/imx93_frdm.env b/board/nxp/imx93_frdm/imx93_frdm.env
index 111f38ed72a6..9af3bdfd7145 100644
--- a/board/nxp/imx93_frdm/imx93_frdm.env
+++ b/board/nxp/imx93_frdm/imx93_frdm.env
@@ -8,7 +8,7 @@ cntr_file=os_cntr_signed.bin
 console=ttyLP0,115200
 fdt_addr_r=0x83000000
 fdt_addr=0x83000000
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 image=Image
 mmcdev=1
 mmcpart=1
diff --git a/board/nxp/imx93_qsb/imx93_qsb.env b/board/nxp/imx93_qsb/imx93_qsb.env
index 6c10784cf61a..d669c6e31337 100644
--- a/board/nxp/imx93_qsb/imx93_qsb.env
+++ b/board/nxp/imx93_qsb/imx93_qsb.env
@@ -8,7 +8,7 @@ cntr_file=os_cntr_signed.bin
 console=ttyLP0,115200 earlycon
 fdt_addr_r=0x83000000
 fdt_addr=0x83000000
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 image=Image
 mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
 mmcpart=1
diff --git a/board/nxp/imx94_evk/imx94_evk.env b/board/nxp/imx94_evk/imx94_evk.env
index 2baf1bbadcb7..894f59758125 100644
--- a/board/nxp/imx94_evk/imx94_evk.env
+++ b/board/nxp/imx94_evk/imx94_evk.env
@@ -28,7 +28,7 @@ fdt_addr=0x93000000
 cntr_addr=0xA8000000
 cntr_file=os_cntr_signed.bin
 boot_fit=no
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 bootm_size=0x10000000
 mmcdev=CONFIG_SYS_MMC_ENV_DEV
 mmcautodetect=yes
diff --git a/board/nxp/imx95_evk/imx95_evk.env b/board/nxp/imx95_evk/imx95_evk.env
index a7309d734b0d..19f9bd5c16e5 100644
--- a/board/nxp/imx95_evk/imx95_evk.env
+++ b/board/nxp/imx95_evk/imx95_evk.env
@@ -12,7 +12,7 @@ fdt_addr=0x93000000
 cntr_addr=0xA8000000
 cntr_file=os_cntr_signed.bin
 boot_fit=no
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 bootm_size=0x10000000
 mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
 mmcautodetect=yes
diff --git a/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
index f064bbe3d31e..7ea7bde86a16 100644
--- a/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
+++ b/board/phytec/imx8mp-libra-fpsc/imx8mp-libra-fpsc.env
@@ -2,7 +2,7 @@ boot_script_dhcp=net_boot_fit.scr.uimg
 console=ttymxc3,CONFIG_BAUDRATE
 emmc_dev=2  /* This is needed by built-in uuu flash scripts */
 fdt_addr_r=0x40480000
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 fdtoverlay_addr_r=0x404a0000
 ip_dyn=yes
 kernel_addr_r=0x40a00000
diff --git a/board/phytec/phycore_am62ax/phycore_am62ax.env b/board/phytec/phycore_am62ax/phycore_am62ax.env
index eeb7cd6899ae..e7b9cc0791ca 100644
--- a/board/phytec/phycore_am62ax/phycore_am62ax.env
+++ b/board/phytec/phycore_am62ax/phycore_am62ax.env
@@ -13,7 +13,7 @@ ramdisk_addr_r=0x88080000
 fdtoverlay_addr_r=0x89000000
 fit_addr_r=0x90000000
 
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 mmcdev=1
 mmcroot=2
 mmcpart=1
diff --git a/board/phytec/phycore_am62x/phycore_am62x.env b/board/phytec/phycore_am62x/phycore_am62x.env
index eeb7cd6899ae..e7b9cc0791ca 100644
--- a/board/phytec/phycore_am62x/phycore_am62x.env
+++ b/board/phytec/phycore_am62x/phycore_am62x.env
@@ -13,7 +13,7 @@ ramdisk_addr_r=0x88080000
 fdtoverlay_addr_r=0x89000000
 fit_addr_r=0x90000000
 
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 mmcdev=1
 mmcroot=2
 mmcpart=1
diff --git a/board/phytec/phycore_am64x/phycore_am64x.env b/board/phytec/phycore_am64x/phycore_am64x.env
index 67d2b87f1442..6cfe64e676fb 100644
--- a/board/phytec/phycore_am64x/phycore_am64x.env
+++ b/board/phytec/phycore_am64x/phycore_am64x.env
@@ -12,7 +12,7 @@ ramdisk_addr_r=0x88080000
 fdtoverlay_addr_r=0x89000000
 fit_addr_r=0x90000000
 
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 mmcdev=1
 mmcroot=2
 mmcpart=1
diff --git a/board/phytec/phycore_am68x/phycore_am68x.env b/board/phytec/phycore_am68x/phycore_am68x.env
index 4908055b5425..0c61e645c88d 100644
--- a/board/phytec/phycore_am68x/phycore_am68x.env
+++ b/board/phytec/phycore_am68x/phycore_am68x.env
@@ -7,7 +7,7 @@ ramdisk_addr_r=0x88080000
 fdtoverlay_addr_r=0x89000000
 fit_addr_r=0x90000000
 
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 mmcdev=1
 mmcroot=2
 mmcpart=1
diff --git a/board/phytec/phycore_imx8mm/phycore_imx8mm.env b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
index f6d0c0553b5d..7cd601f8cd58 100644
--- a/board/phytec/phycore_imx8mm/phycore_imx8mm.env
+++ b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
@@ -2,7 +2,7 @@ boot_script_dhcp=net_boot_fit.scr.uimg
 console=ttymxc2,CONFIG_BAUDRATE
 emmc_dev=2  /* This is needed by built-in uuu flash scripts */
 fdt_addr_r=0x40480000
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 fdtoverlay_addr_r=0x404a0000
 ip_dyn=yes
 kernel_addr_r=0x40a00000
diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
index c339c315c308..652761d1f998 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -4,7 +4,7 @@ emmc_dev=2  /* This is needed by built-in uuu flash scripts */
 fastboot_raw_partition_all=0 4194304
 fastboot_raw_partition_bootloader=64 8128
 fdt_addr_r=0x48000000
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 fdtoverlay_addr_r=0x49000000
 ip_dyn=yes
 kernel_addr_r=0x5A080000
diff --git a/board/phytec/phycore_imx93/phycore_imx93.env b/board/phytec/phycore_imx93/phycore_imx93.env
index 4e89c4ae26cb..c8fb3a875da0 100644
--- a/board/phytec/phycore_imx93/phycore_imx93.env
+++ b/board/phytec/phycore_imx93/phycore_imx93.env
@@ -4,7 +4,7 @@ boot_script_dhcp=net_boot_fit.scr.uimg
 console=ttyLP0
 emmc_dev=0  /* This is needed by built-in uuu flash scripts */
 fdt_addr_r=0x90000000
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=DEFAULT_FDT_FILE
 fdtoverlay_addr_r=0x900c0000
 ip_dyn=yes
 kernel_addr_r=0x88000000
-- 
2.43.0

