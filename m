Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669D3C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC0AB8839A;
	Tue, 18 Jun 2024 16:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B84F9Orw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA1E288365; Tue, 18 Jun 2024 16:18:56 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78D9188366
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6f986b92acaso3144591a34.2
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718720333; x=1719325133; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gjjKzzxwKK6tdjrGjRUaaPd6zCLINVKoINdApMJRfIg=;
 b=B84F9Orw10FKue68AAxIEsLRyAraRrL/Ds3H2ErDgi1lyX97SP5tJHZ/PosT97W8Ad
 r5zElJ5eiwHsSMFsOTlfLYiatG+der6rV184+RzJB+zJlPTHRQPZG6MMR7gSb8QtOY5C
 wuMVAhlvH7WWCSXFltg4RgiyCd8ZuGoK1RcUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718720333; x=1719325133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gjjKzzxwKK6tdjrGjRUaaPd6zCLINVKoINdApMJRfIg=;
 b=RQTWGEyliWfQcaDN0qWS6jogbyxDVZ3qsG3HdRX+rvBby7n3SzGio4ZpYu7P0RGkNN
 1xK2mAU05kUlnvaYwKCcLjo9FATZPtpsQp3jLOfiP9nizxHVDkDtWtf8rBZP0Y7Emjkq
 WnvYvo0p0TlLgrZURjCWiNTg1T66aXLfy76xDYvL1eTqx0OnOTdVCjOuXrW1gGkJaidb
 qK3EBO94oXY1hdFk4/vZKfNHCFYSmmLwnTJ18hG4Muj7Smqk3gFH2QyeF+RYv5ml0Phh
 KvSiasYdrzfsSsmfKEpXlQOjrhe/zZA4MXvpF6kF6v3WTmvdU44Kebl/RkNHNnJpz60i
 PJfA==
X-Gm-Message-State: AOJu0YwbH0eutzUnuhLSZo4pgYgkTYoTNOMXpeGayZP4Y8yPns+oGWZ3
 S7WhREAZkjF6nlf2Ktj0+IfL72a1k5hPVhumGaWC95Et1D0osJSO3k2H/En1EE9d2VQUk2sJIbc
 gC/EeaQ==
X-Google-Smtp-Source: AGHT+IHVb0XOgMbR4m27Lp3Ms03OUbFiV8aNoJ3ujbtskVnoutc0kNw7b8L9BijHJkEtLobdeG5Ilw==
X-Received: by 2002:a05:6830:1209:b0:6f9:8f34:81ce with SMTP id
 46e09a7af769-6fb9378419fmr14411064a34.17.1718720333156; 
 Tue, 18 Jun 2024 07:18:53 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-187-190-205-45.totalplay.net. [187.190.205.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fb5b1b0bd9sm1844183a34.27.2024.06.18.07.18.52
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:18:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/5] Azure: Rework how we define what to build in the world
 build
Date: Tue, 18 Jun 2024 08:18:48 -0600
Message-Id: <20240618141851.3303112-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618141851.3303112-1-trini@konsulko.com>
References: <20240618141851.3303112-1-trini@konsulko.com>
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

Instead of defining BUILDMAN to the value we'll build in each part of
the matrix job, define a variable with that name and have it list what
to build. This will allow us to reference these multiple times
consistently later on.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index f662f41872fd..6d3bdcee8aac 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -8,6 +8,17 @@ variables:
   # since our $(ci_runner_image) user is not root.
   container_option: -u 0
   work_dir: /u
+  # We define all of these as variables so we can easily reference them twice
+  am33xx_at91_kirkwood_mvebu_omap: "am33xx at91_kirkwood mvebu omap -x siemens"
+  amlogic_bcm_boundary_engicam_siemens_technexion_oradex: "amlogic bcm boundary engicam siemens technexion toradex -x mips"
+  arm_nxp_minus_imx: "freescale -x powerpc,m68k,imx,mx"
+  imx: "mx imx -x boundary,engicam,technexion,toradex"
+  rk: "rk"
+  sunxi: "sunxi"
+  powerpc: "powerpc"
+  arm_catch_all: "arm -x aarch64,am33xx,at91,bcm,ls1,kirkwood,mvebu,omap,rk,siemens,mx,sunxi,technexion,toradex"
+  aarch64_catch_all: "aarch64 -x amlogic,bcm,engicam,imx,ls1,ls2,lx216,mvebu,rk,siemens,sunxi,toradex"
+  everything_but_arm_and_powerpc: "-x arm,powerpc"
 
 stages:
 - stage: testsuites
@@ -477,25 +488,25 @@ stages:
       # parallel jobs going on the free tier of Azure.
       matrix:
         am33xx_at91_kirkwood_mvebu_omap:
-          BUILDMAN: "am33xx at91_kirkwood mvebu omap -x siemens"
+          BUILDMAN: $(am33xx_at91_kirkwood_mvebu_omap)
         amlogic_bcm_boundary_engicam_siemens_technexion_oradex:
-          BUILDMAN: "amlogic bcm boundary engicam siemens technexion toradex -x mips"
+          BUILDMAN: $(amlogic_bcm_boundary_engicam_siemens_technexion_oradex)
         arm_nxp_minus_imx:
-          BUILDMAN: "freescale -x powerpc,m68k,imx,mx"
+          BUILDMAN: $(arm_nxp_minus_imx)
         imx:
-          BUILDMAN: "mx imx -x boundary,engicam,technexion,toradex"
+          BUILDMAN: $(imx)
         rk:
-          BUILDMAN: "rk"
+          BUILDMAN: $(rk)
         sunxi:
-          BUILDMAN: "sunxi"
+          BUILDMAN: $(sunxi)
         powerpc:
-          BUILDMAN: "powerpc"
+          BUILDMAN: $(powerpc)
         arm_catch_all:
-          BUILDMAN: "arm -x aarch64,am33xx,at91,bcm,ls1,kirkwood,mvebu,omap,rk,siemens,mx,sunxi,technexion,toradex"
+          BUILDMAN: $(arm_catch_all)
         aarch64_catch_all:
-          BUILDMAN: "aarch64 -x amlogic,bcm,engicam,imx,ls1,ls2,lx216,mvebu,rk,siemens,sunxi,toradex"
+          BUILDMAN: $(aarch64_catch_all)
         everything_but_arm_and_powerpc:
-          BUILDMAN: "-x arm,powerpc"
+          BUILDMAN: $(everything_but_arm_and_powerpc)
     steps:
       - script: |
           cat << EOF > build.sh
-- 
2.34.1

