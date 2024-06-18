Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBA6C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:19:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BFA988356;
	Tue, 18 Jun 2024 16:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D1FkF0GJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 185A6883AE; Tue, 18 Jun 2024 16:18:58 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E67168832D
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6f971cb3c9cso3063266a34.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718720334; x=1719325134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xEShGuK54v9H+H5+rWnraL3Cvaw73v+vDZ6FALI63cM=;
 b=D1FkF0GJlzs5hvKP3VpknMti3yZ+5jjx27ZikMC//h0aFbS3xxUI+YhLIdthejnF8y
 H6X3vwufbCOU9qt2KiIKBDzpXukzoT9xHCZRWnAYykcKpGdsK9EBqkitydi3FWCN0kzC
 su+JqEBnFiV4AaVBMhVJT3EjFnNYWpwut/k/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718720334; x=1719325134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xEShGuK54v9H+H5+rWnraL3Cvaw73v+vDZ6FALI63cM=;
 b=pnhUvtE+oNKfvKn1ByjjRWdE3pAvlJmoPYBYV8IXEz2tAa9Wtam26pA+mDPS5Qmq/N
 t566c/uVWVpcgFauEKnpuZJ2f7FwSTU+teOa+Gw/YvRBJSp7LSkVsWnjWnFQj2AyfgTe
 jkFcZUtz56pm2pJNMyovZCnpQxmlYmGX9QAY+NMr6xqg3ZW94n4YLneVCVUMbIP4AC63
 kUu/mQvaQsmV2QLoa9fLuNLaDUwG5o58Gi8lgnklm7iJCgn+4rnZ/vy332Tnk5VDEPJR
 oTS0KpXE+VwULqeLk8dlGcyKp9yFIelwN/XhKglCxzQXtjrbGv7POzM8WmQG8N8C8ZzA
 aX9Q==
X-Gm-Message-State: AOJu0YwmVlEh7X1N0b98x+aMMT9gvMSTNaXjpvtuTIksdxyT2ur8AYdy
 oFLPGzpJTPokaI8pYPbTpwGCUnL8NUcLMqh8fyroTwlVIuvSRWjStg+pjh71suu1hY9m4V7tghd
 1ku/2cQ==
X-Google-Smtp-Source: AGHT+IH8g5Mr+VLgHfz3OCVH1RUJAZLVgTfX09hLMR6TBFxfy27QUriPaj3u/WtHIWdCBxVlQAFBzw==
X-Received: by 2002:a05:6830:114b:b0:6f9:6065:5253 with SMTP id
 46e09a7af769-6fb93b3b2ecmr11980328a34.38.1718720334615; 
 Tue, 18 Jun 2024 07:18:54 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-187-190-205-45.totalplay.net. [187.190.205.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fb5b1b0bd9sm1844183a34.27.2024.06.18.07.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:18:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 4/5] Azure: Update some job breakdowns so we build the world
 again
Date: Tue, 18 Jun 2024 08:18:50 -0600
Message-Id: <20240618141851.3303112-4-trini@konsulko.com>
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

As part of commit 9aeac898da66 ("Azure: Rework build the world jobs") I
made a few mistakes. An errant '_' meant that we built neither at91 nor
kirkwood platforms. Further, the non-freescale (NXP) "LS1xxx" platforms
were also not being built. Adjust some jobs to have these be built
again.

Fixes: 9aeac898da66 ("Azure: Rework build the world jobs")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .azure-pipelines.yml | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 2c2d0809cab1..116ce903b067 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -9,9 +9,9 @@ variables:
   container_option: -u 0
   work_dir: /u
   # We define all of these as variables so we can easily reference them twice
-  am33xx_at91_kirkwood_mvebu_omap: "am33xx at91_kirkwood mvebu omap -x siemens"
+  am33xx_kirkwood_ls1_mvebu_omap: "am33xx kirkwood ls1 mvebu omap -x siemens,freescale"
   amlogic_bcm_boundary_engicam_siemens_technexion_oradex: "amlogic bcm boundary engicam siemens technexion toradex -x mips"
-  arm_nxp_minus_imx: "freescale -x powerpc,m68k,imx,mx"
+  arm_nxp_minus_imx_and_at91: "at91 freescale -x powerpc,m68k,imx,mx"
   imx: "mx imx -x boundary,engicam,technexion,toradex"
   rk: "rk"
   sunxi: "sunxi"
@@ -487,12 +487,12 @@ stages:
       # We split the world up in to 10 jobs as we can have at most 10
       # parallel jobs going on the free tier of Azure.
       matrix:
-        am33xx_at91_kirkwood_mvebu_omap:
-          BUILDMAN: $(am33xx_at91_kirkwood_mvebu_omap)
+        am33xx_kirkwood_ls1_mvebu_omap:
+          BUILDMAN: $(am33xx_kirkwood_ls1_mvebu_omap)
         amlogic_bcm_boundary_engicam_siemens_technexion_oradex:
           BUILDMAN: $(amlogic_bcm_boundary_engicam_siemens_technexion_oradex)
-        arm_nxp_minus_imx:
-          BUILDMAN: $(arm_nxp_minus_imx)
+        arm_nxp_minus_imx_and_at91:
+          BUILDMAN: $(arm_nxp_minus_imx_and_at91)
         imx:
           BUILDMAN: $(imx)
         rk:
-- 
2.34.1

