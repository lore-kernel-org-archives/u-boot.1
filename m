Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7FBD116E0
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 23:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3417B83D13;
	Thu, 27 Nov 2025 00:49:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Bn1R5J5g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D625484260; Thu, 27 Nov 2025 00:49:51 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80E1083B72
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 00:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c6cc44ff62so248722a34.3
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 15:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764200988; x=1764805788; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=nwcO77l0dpoMFADdpf6Qc8drrX89Nm5D3/fe7D6S8Gk=;
 b=Bn1R5J5gmAbQ5UGFqOaTZJobOfZlMwptjUATRD4jYHZUCBdgFN0WiBmJrTCDFEKbh6
 hXQfaPDgcjFUma1BFz9aeT2rBSUVeGpCw5/+DaATv98iKtCGm/wEP1F2DKUx26mNw1eT
 6Tma50pWK/rxdYINwHZMv7ZLjP4muMvHk7uCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764200988; x=1764805788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nwcO77l0dpoMFADdpf6Qc8drrX89Nm5D3/fe7D6S8Gk=;
 b=vP9ifbuCJtuc5/DzZ76gVHu1CZIpaqfhtUbi3C1G5Py1YOqxZFPwMvVzcPmqgZ+MOf
 YVzNUkvgm1ac5meNKqE6Z+DXKgea1gjQQjYtF7QEzOailA90/nD0A+qXkS3MKFQrhscF
 +lR/6Ic7wNrl4ycBorYkE6qDbFR/23uCjRID9OqHaqxsBD2Vc9sNsO4zrs8A1sRiIWUb
 PcyM0eTP9sAgbsj0Tz55Ks5OnUifoPUR98Kk38WNviMThM5lQ3v0SMu9Gav2C3G1nIm1
 sq16leaXRXSWExF8Dt3EVr+s8x16VxbNGVHR9HuWNLdns+4pv+KSSU5Mqebx+ELBuItg
 qZOA==
X-Gm-Message-State: AOJu0Yy9dW3OR+zfHfvQ6jxiXprL+wzrXtZ84QVHvIZseldDyv8lkhu4
 T5SA2QSC7DYytbc/wg8U9SinwxO2GN7a/yep6VhfDS6sPE/ZyKEUV4wqjrXVaa72eeq7dInHExu
 rKepY06Y=
X-Gm-Gg: ASbGncvInnmT/l9GwiBGgbv4ylv53SESLVoyuIPXrvRpm5WOHkyyuRCU7rLv2yT7xmf
 GVh7UOUIyxEH3zqFv6cKrz6XK4no2zavOcSbdoZkZiHReyk2WM8hfEZjJwTkj565ms9/j2FKh5c
 fueQFGxW4LWyVSWabd4acQXYVtaXi68Q3dv3oIUwXVikXAtHa0Xo2DUEpqwyqQrQ7omzPabL76d
 nbUtev/5BhMdvXowC+wbrhVOcQblm6bBQaXlcvgA1T7bstBEdXfNTZoNB22eRTHxEpSw3A8CU2C
 xgkcsx6IH8grl76jMVTTcPZntZ9SxtgmFKZ5nIKlbIP3ro5qZCwxxtxznHc6ScP/NeVmEvdQ+rO
 Ne95mtphT5lh8UOK/nXcA3xTwizBIjZE3DChUF6PeSiHfGDZ7oat+WODSj4bZDDewvTd0qsCNSO
 P/B/VIgoA1NQiwxvAnZ61gJQ61ku6WGwgwQLZenM5VliGSJ1VtUzvl
X-Google-Smtp-Source: AGHT+IGBe67ofZKKxy/Z8l+UkTYm8PL5or0rLm6x5LSS6PqG9OdJqCrtIInSl+sPmgsl3LUhiLc8Wg==
X-Received: by 2002:a05:6808:3097:b0:450:c63e:440 with SMTP id
 5614622812f47-4514e860f55mr3830351b6e.66.1764200987890; 
 Wed, 26 Nov 2025 15:49:47 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450ffe65e6asm5911234b6e.6.2025.11.26.15.49.47
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 15:49:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [for-master PATCH] Azure: Rework jobs for disk space and 29 jobs
Date: Wed, 26 Nov 2025 17:49:46 -0600
Message-ID: <20251126234946.3909525-1-trini@konsulko.com>
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

The problem we face currently with Azure jobs is that we're running out
of disk space on the runners as we build. There's not a good way to
split approximately 1500 configurations across 10 jobs and not be close
to or exceeding that limit. Split this in to 29 jobs instead with a goal
of averaging an hour per job. This split gets us close, but there are
still some challenging jobs to try and break up further. The list is
mostly alphabetized but with some intentional changes (catch-all are
last, mx/imx are together, SoC family splits are just grouped together).

The average build time should be close to the same, but outliers can and
will happen.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 137 +++++++++++++++++++++++++++++++++----------
 1 file changed, 107 insertions(+), 30 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index c2500c3c58db..206d44241143 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -11,16 +11,35 @@ variables:
   container_option: -u 0
   work_dir: /u
   # We define all of these as variables so we can easily reference them twice
-  am33xx_kirkwood_ls1_mvebu_omap: "am33xx kirkwood ls1 mvebu omap -x siemens,freescale"
-  amlogic_bcm_boundary_engicam_siemens_technexion_oradex: "amlogic bcm boundary engicam siemens technexion toradex -x mips"
-  arm_nxp_minus_imx_and_at91: "at91 freescale -x powerpc,m68k,imx,mx"
-  imx: "mx imx -x boundary,engicam,technexion,toradex"
-  rk: "rk"
-  sunxi: "sunxi"
+  am33xx_kirkwood: "am33xx kirkwood"
+  amd: "amd xilinx zynq"
+  amlogic_bcm: "amlogic bcm -x mips"
+  atmel: "atmel"
+  engicam_renesas: "engicam renesas"
+  k3_32b: "k3 -x aarch64,phytec,toradex"
+  k3_64b: "k3 -x armv7,phytec,toradex"
+  kirkwood_mvebu: "kirkwood mvebu"
+  layerscape_vf610: "ls1 ls2 lx2 vf610 -x phytec,toradex"
+  m68k_remaining_mx_xtensa: "m68k imxrt mx xtensa -x mx6,aarch64"
+  mips_x86: "mips x86 -x mediatek"
+  mx6: "mx6 -x engicam,phytec,toradex"
+  imx8: "imx8 -x engicam,phytec,toradex"
+  imx9_arc_nios2_socfpga: "imx9 arc nios2 socfpga -x phytec,toradex"
+  phytec_toradex: "phytec toradex"
   powerpc: "powerpc"
-  arm_catch_all: "arm -x aarch64,am33xx,at91,bcm,ls1,kirkwood,mvebu,omap,rk,siemens,mx,sunxi,technexion,toradex"
-  aarch64_catch_all: "aarch64 -x amlogic,bcm,engicam,imx,ls1,ls2,lx216,mvebu,rk,siemens,sunxi,toradex"
-  everything_but_arm_and_powerpc: "arc m68k microblaze mips nios2 riscv sandbox sh x86 xtensa -x arm,powerpc"
+  riscv_stm32: "riscv stm32 -x engicam,xilinx"
+  rk3399: "rk3399"
+  rk352x_rk358x: "rk352 rk358"
+  rk356x_rk357x: "rk356 rk357"
+  rk3xxx_rest: "rk30 rk31 rk32 rk33 -x rk3399,phytec"
+  sandbox_tegra: "tegra sandbox -x toradex"
+  samsung_omap_mediatek: "samsung omap mediatek"
+  sun4i_5i: "sun4i sun5i"
+  sun6i_sun7i: "sun6i sun7i"
+  sun8i: "sun8i"
+  sunxi_rest: "sunxi -x sun4i,sun5i,sun6i,sun7i,sun8i"
+  arm_catch_all: "arm -x aarch64,am33xx,atmel,bcm,ls,lx,imx,k3,kirkwood,mvebu,mx,omap,renesas,rk,samsung,socfpga,stm32,sunxi,tegra,vf610,xilinx,zynq"
+  aarch64_catch_all: "aarch64 -x amd,amlogic,bcm,engicam,imx,k3,ls,lx,mediatek,mvebu,renesas,rk,samsung,socfpga,stm32,sunxi,tegra,xilinx,zynq"
 
 stages:
 - stage: testsuites
@@ -212,16 +231,36 @@ stages:
           # First get the total number of boards
           total=$(tools/buildman/buildman ${BMANARGS} | grep "Total boards to build for each commit" | cut -d ' ' -f 8)
           # Now build up the list of what each job built.
-          built="$(tools/buildman/buildman ${BMANARGS} $(am33xx_kirkwood_ls1_mvebu_omap) | grep '^   ')"
-          built="$built $(tools/buildman/buildman ${BMANARGS} $(amlogic_bcm_boundary_engicam_siemens_technexion_oradex) | grep '^   ')"
-          built="$built $(tools/buildman/buildman ${BMANARGS} $(arm_nxp_minus_imx_and_at91) | grep '^   ')"
-          built="$built $(tools/buildman/buildman ${BMANARGS} $(imx) | grep '^   ')"
-          built="$built $(tools/buildman/buildman ${BMANARGS} $(rk) | grep '^   ')"
-          built="$built $(tools/buildman/buildman ${BMANARGS} $(sunxi) | grep '^   ')"
+          built="$(tools/buildman/buildman ${BMANARGS} $(am33xx_kirkwood) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(amd) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(amlogic_bcm) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(atmel) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(engicam_renesas) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(k3_32b) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(k3_64b) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(kirkwood_mvebu) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(layerscape_vf610) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(m68k_remaining_mx_xtensa) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(mips_x86) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(mx6) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(imx8) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(imx9_arc_nios2_socfpga) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(phytec_toradex) | grep '^   ')"
           built="$built $(tools/buildman/buildman ${BMANARGS} $(powerpc) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(riscv_stm32) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(rk3399) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(rk352x_rk358x) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(rk356x_rk357x) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(rk3xxx_rest) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(sandbox_tegra) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(samsung_omap_mediatek) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(sun4i_5i) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(sun6i_sun7i) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(sun8i) | grep '^   ')"
+          built="$built $(tools/buildman/buildman ${BMANARGS} $(sunxi_rest) | grep '^   ')"
           built="$built $(tools/buildman/buildman ${BMANARGS} $(arm_catch_all) | grep '^   ')"
           built="$built $(tools/buildman/buildman ${BMANARGS} $(aarch64_catch_all) | grep '^   ')"
-          built="$built $(tools/buildman/buildman ${BMANARGS} $(everything_but_arm_and_powerpc) | grep '^   ')"
+
           # Finally see how many machines that is.
           actual=$(tools/buildman/buildman ${BMANARGS} $built | grep "Total boards to build for each commit" | cut -d ' ' -f 8)
           echo We would build a total of $actual out of $total platforms this CI run
@@ -619,26 +658,64 @@ stages:
       # We split the world up in to 10 jobs as we can have at most 10
       # parallel jobs going on the free tier of Azure.
       matrix:
-        am33xx_kirkwood_ls1_mvebu_omap:
-          BUILDMAN: $(am33xx_kirkwood_ls1_mvebu_omap)
-        amlogic_bcm_boundary_engicam_siemens_technexion_oradex:
-          BUILDMAN: $(amlogic_bcm_boundary_engicam_siemens_technexion_oradex)
-        arm_nxp_minus_imx_and_at91:
-          BUILDMAN: $(arm_nxp_minus_imx_and_at91)
-        imx:
-          BUILDMAN: $(imx)
-        rk:
-          BUILDMAN: $(rk)
-        sunxi:
-          BUILDMAN: $(sunxi)
+        am33xx_kirkwood:
+          BUILDMAN: $(am33xx_kirkwood)
+        amd:
+          BUILDMAN: $(amd)
+        amlogic_bcm:
+          BUILDMAN: $(amlogic_bcm)
+        atmel:
+          BUILDMAN: $(atmel)
+        engicam_renesas:
+          BUILDMAN: $(engicam_renesas)
+        k3_32b:
+          BUILDMAN: $(k3_32b)
+        k3_64b:
+          BUILDMAN: $(k3_64b)
+        kirkwood_mvebu:
+          BUILDMAN: $(kirkwood_mvebu)
+        layerscape_vf610:
+          BUILDMAN: $(layerscape_vf610)
+        m68k_remaining_mx_xtensa:
+          BUILDMAN: $(m68k_remaining_mx_xtensa)
+        mips_x86:
+          BUILDMAN: $(mips_x86)
+        mx6:
+          BUILDMAN: $(mx6)
+        imx8:
+          BUILDMAN: $(imx8)
+        imx9_arc_nios2_socfpga:
+          BUILDMAN: $(imx9_arc_nios2_socfpga)
+        phytec_toradex:
+          BUILDMAN: $(phytec_toradex)
         powerpc:
           BUILDMAN: $(powerpc)
+        riscv_stm32:
+          BUILDMAN: $(riscv_stm32)
+        rk3399:
+          BUILDMAN: $(rk3399)
+        rk352x_rk358x:
+          BUILDMAN: $(rk352x_rk358x)
+        rk356x_rk357x:
+          BUILDMAN: $(rk356x_rk357x)
+        rk3xxx_rest:
+          BUILDMAN: $(rk3xxx_rest)
+        sandbox_tegra:
+          BUILDMAN: $(sandbox_tegra)
+        samsung_omap_mediatek:
+          BUILDMAN: $(samsung_omap_mediatek)
+        sun4i_5i:
+          BUILDMAN: $(sun4i_5i)
+        sun6i_sun7i:
+          BUILDMAN: $(sun6i_sun7i)
+        sun8i:
+          BUILDMAN: $(sun8i)
+        sunxi_rest:
+          BUILDMAN: $(sunxi_rest)
         arm_catch_all:
           BUILDMAN: $(arm_catch_all)
         aarch64_catch_all:
           BUILDMAN: $(aarch64_catch_all)
-        everything_but_arm_and_powerpc:
-          BUILDMAN: $(everything_but_arm_and_powerpc)
     steps:
       - script: |
           set -ex
-- 
2.43.0

