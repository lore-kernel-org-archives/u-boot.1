Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103A1C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 03:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E375C87774;
	Sun, 29 Oct 2023 04:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i8ryyhFB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 676FE8789B; Sun, 29 Oct 2023 04:48:58 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3946187739
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 04:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7789cc5c8ccso277197785a.0
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 20:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698551330; x=1699156130; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EiSKM1h5ug+OTaPL1YAP3IyM4XDf3SEuEThf5V4sADI=;
 b=i8ryyhFBnR5iilF0LmDtqWrXAMwsCObCRFN21L7oHa5G2E95cHod1GJmSUrUxO7Y0u
 LX7Zzv13SrVYI2Fmt8PcTFb4rDHQ2H3ii9OqGCKY6XSppaft6HBabkvHsCy9pv31YRbk
 MlEIgJJUkJFQuppshAho0CgT62j2L1IZYm+HYHMGyhq8QqJ0uRHnKFByspiQH/FaQzpK
 v+MNwZ8d9EcCzEUGM2bDm6Lf1/gAg9Yj9Nxwbrh7csL+AUNT8iqvjoHon4FKBqum37KG
 X8EdFTpVgrnGnqL5MwOEXniHnlCcBy9kcWe7JHBLj9/xROxiP7vSZVAjG3lz5YuKHRnB
 +Obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698551330; x=1699156130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EiSKM1h5ug+OTaPL1YAP3IyM4XDf3SEuEThf5V4sADI=;
 b=A/Xrtm7GTd16EQ0hv6HzThwQG4sDh5brC72/njtOZnPbpuJBBqvCew1uWKUE+xujdo
 RVuKAYgeEQMGZeeztJffEF4N8T0Q27m+zem3M+arw6/8HXmkgWlRhhHtFBs3jAu6htGo
 Mve8RKLRbr+1mXAZYvScNcU/6tL8suSaFikm6h7byXqlNnZs+6C0NAMllmTyX3Hb+4II
 x8KiTIeX3HnqsiJgG3rklPt2tGedB1UbQsFcsS+dXDLHCbfO7JIpcHrx91gaRD3BU865
 ThLdEHxLhWOBMnurr4wqOTSapWo01es/aVMK7G5bRLcf2AlfLRJsFgY3hBs4AadlcmUJ
 2IyA==
X-Gm-Message-State: AOJu0Yx2lZen/8ikG04ynh2A4SfvG6vXNzdAVXpSKzCoBrU0+N9l9XRX
 A9UdxxWDr/bnIUGXfcXz/hOz00HRJBjg2w==
X-Google-Smtp-Source: AGHT+IEppBwQFE9+yTqT8jh8GBxPy7c0972dMB5EpZaeVHGFMBzTJBWRvUzeJi8S6QnXUNOrz9U4EQ==
X-Received: by 2002:a05:620a:172c:b0:772:63b3:2423 with SMTP id
 az44-20020a05620a172c00b0077263b32423mr9381131qkb.0.1698551329841; 
 Sat, 28 Oct 2023 20:48:49 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 i21-20020a05620a405500b00774309d3e89sm2110502qko.7.2023.10.28.20.48.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 20:48:49 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 01/15] spl: nand: Fix NULL-pointer dereference
Date: Sat, 28 Oct 2023 23:48:31 -0400
Message-Id: <20231029034845.1169614-2-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231029034845.1169614-1-seanga2@gmail.com>
References: <20231029034845.1169614-1-seanga2@gmail.com>
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

spl_nand_fit_read unconditionally accesses load->priv. Ensure it is set.

Fixes: 00e180cc513 ("spl: nand: support loading i.MX container format file")
Fixes: 4620e8aabc1 ("spl: nand: support loading legacy image with payload compressed")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 common/spl/spl_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index 07916bedbb9..a19236d9e6d 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -105,7 +105,7 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 		struct spl_load_info load;
 
 		load.dev = NULL;
-		load.priv = NULL;
+		load.priv = &offset;
 		load.filename = NULL;
 		load.bl_len = bl_len;
 		load.read = spl_nand_fit_read;
@@ -116,7 +116,7 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 
 		debug("Found legacy image\n");
 		load.dev = NULL;
-		load.priv = NULL;
+		load.priv = &offset;
 		load.filename = NULL;
 		load.bl_len = 1;
 		load.read = spl_nand_legacy_read;
-- 
2.37.1

