Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB02EE4993
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 17:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E69886A42;
	Sun, 20 Aug 2023 19:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kNAuf3gk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F3E486993; Sun, 20 Aug 2023 19:31:35 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54AEE869AE
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 19:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-58caaedb20bso28844227b3.1
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692552691; x=1693157491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=doLLs0zwMV/OdDYCgPuj6HIEbNik6a0YlMYITNkNiYI=;
 b=kNAuf3gkgydc3w3rklP5A7Tj3jldJzMsG95p3xZBfjJc1BRxcdiU38NpohyimQSAig
 KPIR4dV0p7s5BktqGuHLEjDBNYzsQNIAVgDCY4ERaaBHYqcH5gLZlGR2xNt1EbTTTibE
 7oIh6Q9IBXvd3tZuvzOy/phohGzK//gtJISnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692552691; x=1693157491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=doLLs0zwMV/OdDYCgPuj6HIEbNik6a0YlMYITNkNiYI=;
 b=ZKK5OsuhuwWFoHBryKac1qaZVTC8cANh+V1qsNfTm6CJJH3N/MdQlECPE4LnT5IXw/
 mmXfv/Wl+ewcPin4uzB89c+pmS9IPwTKDwYFT4As9/69oV5PHImsXQ9elpcUqgD6c/x2
 iIRAu1EOfswg+f7vwxI3dfUoVGcqXxgm5viaXYp8LVEOP8BjBECU+Vne4/n+oSf4wBcy
 WCVuRQx1wF1fUceFqGfiqM8UTeGKzGGjh07jXs6fZJDxjT8L4yKRIxpPZ0K6Pf+LoW6S
 zsqY7L+L7fQfcroetxP4tgXJkjibLJHEF+D5dKggde/6+yEhMqpAMjk6Iqkx5HLaERBz
 vqXQ==
X-Gm-Message-State: AOJu0YzPEdznu92CPhz7CFhBrv6wTnLHURcHRXaFdj/d0ypUJK85DD7o
 jmI49G5HIdUgh1dR/UF7YUsPNSP6tHEqNKFATYtArg==
X-Google-Smtp-Source: AGHT+IGgOCTrRxngvVkbVJedzqCVYBCJxq7Ax5CXo0VIi7xD6bE/6bGJCjXNO1Ujc5FxfLO0vpitdw==
X-Received: by 2002:a81:7c06:0:b0:583:d363:8d1b with SMTP id
 x6-20020a817c06000000b00583d3638d1bmr4653343ywc.47.1692552690983; 
 Sun, 20 Aug 2023 10:31:30 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-2d48-63ba-cc6c-366e.res6.spectrum.com.
 [2603:6081:7b00:6400:2d48:63ba:cc6c:366e])
 by smtp.gmail.com with ESMTPSA id
 i194-20020a816dcb000000b0057042405e2csm1800683ywc.71.2023.08.20.10.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 10:31:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/4] Azure: Rework build the world jobs
Date: Sun, 20 Aug 2023 13:31:27 -0400
Message-Id: <20230820173129.781985-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820173129.781985-1-trini@konsulko.com>
References: <20230820173129.781985-1-trini@konsulko.com>
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

Now that we have 3600 minutes per build job, condense and rework things
such that our overall time largely doesn't change, but we can also
largely avoid having to re-tweak this job to avoid timeouts.  Given that
we have 10 threads, we also move a few of the specific sandbox test
builds to a prior stage.

Note that while sandbox builds with address sanitization enabled (ASAN)
not all tests pass, so we limit ourselves to just checking that the
version test passes for now.

Link: https://learn.microsoft.com/en-us/azure/devops/pipelines/process/phases?view=azure-devops&tabs=yaml#timeouts
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>

I believe we merged ASAN with the intention of fixing some of the found
issues later, so this isn't really a functional change.
---
 .azure-pipelines.yml | 100 +++++++++++--------------------------------
 1 file changed, 25 insertions(+), 75 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index fc3188a806f4..ab3f961e01ee 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -254,9 +254,17 @@ stages:
       matrix:
         sandbox:
           TEST_PY_BD: "sandbox"
+        sandbox_asan:
+          TEST_PY_BD: "sandbox"
+          OVERRIDE: "-a ASAN"
+          TEST_PY_TEST_SPEC: "version"
         sandbox_clang:
           TEST_PY_BD: "sandbox"
           OVERRIDE: "-O clang-16"
+        sandbox_clang_asan:
+          TEST_PY_BD: "sandbox"
+          OVERRIDE: "-O clang-16 -a ASAN"
+          TEST_PY_TEST_SPEC: "version"
         sandbox_nolto:
           TEST_PY_BD: "sandbox"
           BUILD_ENV: "NO_LTO=1"
@@ -476,84 +484,26 @@ stages:
       # Use almost the same target division in .travis.yml, only merged
       # 3 small build jobs (arc/microblaze/xtensa) into one.
       matrix:
-        arc_nios2_m68k_microblaze_xtensa:
-          BUILDMAN: "arc nios2 microblaze m68k xtensa"
-        amlogic:
-          BUILDMAN: "amlogic"
-        arm11_arm7_arm920t_arm946es:
-          BUILDMAN: "arm11 arm7 arm920t arm946es"
-        arm926ejs:
-          BUILDMAN: "arm926ejs -x freescale,siemens,at91,kirkwood,omap"
-        at91_non_armv7:
-          BUILDMAN: "at91 -x armv7"
-        at91_non_arm926ejs:
-          BUILDMAN: "at91 -x arm926ejs"
-        boundary_engicam_toradex:
-          BUILDMAN: "boundary engicam toradex"
-        arm_bcm:
-          BUILDMAN: "bcm -x mips"
-        nxp_arm32:
-          BUILDMAN: "freescale -x powerpc,m68k,aarch64,ls101,ls102,ls104,ls108,ls20,lx216"
-        nxp_ls101x_ls108x:
-          BUILDMAN: "freescale&ls101 freescale&ls108"
-        nxp_ls102x:
-          BUILDMAN: "freescale&ls102 -x keymile"
-        nxp_ls104x:
-          BUILDMAN: "freescale&ls104"
-        nxp_ls20xx_lx216x:
-          BUILDMAN: "freescale&ls20 freescale&lx216"
-        imx6:
-          BUILDMAN: "mx6 -x boundary,engicam,freescale,technexion,toradex"
+        am33xx_at91_kirkwood_mvebu_omap:
+          BUILDMAN: "am33xx at91_kirkwood mvebu omap -x siemens"
+        amlogic_bcm_boundary_engicam_siemens_technexion_oradex:
+          BUILDMAN: "amlogic bcm boundary engicam siemens technexion toradex -x mips"
+        arm_nxp_minus_imx:
+          BUILDMAN: "freescale -x powerpc,m68k,imx,mx"
         imx:
-          BUILDMAN: "mx -x mx6,imx8,freescale,technexion,toradex"
-        imx8_imx9:
-          BUILDMAN: "imx8 imx9 -x engicam,technexion,toradex"
-        keymiles_siemens_technexion:
-          BUILDMAN: "keymile siemens technexion"
-        keystone2_keystone3:
-          BUILDMAN: "k2 k3 -x siemens,toradex"
-        sandbox_asan:
-          BUILDMAN: "sandbox"
-          OVERRIDE: "-a ASAN"
-        sandbox_clang_asan:
-          BUILDMAN: "sandbox"
-          OVERRIDE: "-O clang-16 -a ASAN"
-        samsung_socfpga_renesas:
-          BUILDMAN: "samsung socfpga renesas"
-        sun4i_sun9i:
-          BUILDMAN: "sun4i sun9i"
-        sun5i_sun6i:
-          BUILDMAN: "sun5i sun6i"
-        sun7i:
-          BUILDMAN: "sun7i"
-        sun8i:
-          BUILDMAN: "sun8i"
-        sun50i:
-          BUILDMAN: "sun50i"
-        arm_catch_all:
-          BUILDMAN: "arm -x arm11,arm7,arm9,aarch64,at91,bcm,freescale,kirkwood,mvebu,renesas,siemens,tegra,uniphier,mx,samsung,sunxi,am33xx,omap,toradex,socfpga,k2,k3,zynq"
-        sandbox_x86:
-          BUILDMAN: "sandbox x86"
-        kirkwood_mvebu_uniphier:
-          BUILDMAN: "kirkwood mvebu uniphier"
-        mips:
-          BUILDMAN: "mips"
+          BUILDMAN: "mx imx -x boundary,engicam,technexion,toradex"
+        rk:
+          BUILDMAN: "rk"
+        sunxi:
+          BUILDMAN: "sunxi"
         powerpc:
-          BUILDMAN: "powerpc -x keymile"
-        tegra:
-          BUILDMAN: "tegra -x toradex"
-        am33xx_omap:
-          BUILDMAN: "am33xx omap -x siemens"
+          BUILDMAN: "powerpc"
+        arm_catch_all:
+          BUILDMAN: "arm -x aarch64,am33xx,at91,bcm,ls1,kirkwood,mvebu,omap,rk,siemens,mx,sunxi,technexion,toradex"
         aarch64_catch_all:
-          BUILDMAN: "aarch64 -x amlogic,bcm,imx8,imx9,k3,tegra,ls1,ls2,lx216,mvebu,uniphier,renesas,sunxi,samsung,socfpga,rk,versal,zynq"
-        rk_non_rockchip_64bit:
-          BUILDMAN: "rk&aarch64 -x rockchip"
-        rk_rockchip_64bit:
-          BUILDMAN: "rk&aarch64&rockchip"
-        zynq_zynqmp_versal:
-          BUILDMAN: "zynq&armv7 versal zynqmp&aarch64"
-        riscv:
-          BUILDMAN: "riscv"
+          BUILDMAN: "aarch64 -x amlogic,bcm,engicam,imx,ls1,ls2,lx216,mvebu,rk,siemens,sunxi,toradex"
+        everything_but_arm_and_powerpc:
+          BUILDMAN: "-x arm,powerpc"
     steps:
       - script: |
           cat << EOF > build.sh
-- 
2.34.1

