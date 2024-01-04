Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D592C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E62F87A11;
	Thu,  4 Jan 2024 16:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hh+lDbp4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB4DE879DF; Thu,  4 Jan 2024 16:12:40 +0100 (CET)
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2EAF87A01
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x141.google.com with SMTP id
 e9e14a558f8ab-35fcea0ac1aso2419295ab.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381130; x=1704985930; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HxPHQwKUFBvSnga5VkJmI7+Nkfl6207kQ5iRgJpZwPs=;
 b=Hh+lDbp4pkmDC/Yzf3nqGd/Ou/ZlZNzgNrAkZDCyrxa8eM5XEXVaujmQzzKqnSt181
 m2lwznD7q/yCNdwjL4AIHsxWllStVpDZeZ5bC0egycyg3jvDgTIDQaYdDzpmdbIuRsBR
 MiWIw2vrRDzNIpZF1AAj1I20J2WLnkRMLa4C0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381130; x=1704985930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HxPHQwKUFBvSnga5VkJmI7+Nkfl6207kQ5iRgJpZwPs=;
 b=hw6rXTWbJUuzxAllWRjgfeSeWiBGdKEp6VAWpCHMwll5P4CwZiUG98SOOCvZQlSyWO
 L/YJvZhQB7rECRVj+XgXIVKJeNGzg+PfoJFi9WR1JGYjKsjdxDNtZdX//gTnKDi2pyKC
 cFP6gKc6cb1PtKn28qeWGRhUbF7qqHdCptX5MGTJ2EK6kXiHjq6JmtCqkab3ixO9x6e5
 5nYsElqMiypG9jqiOPXyT2y2hgxvNSAf4c33WHhLg4F8Z4IvxEWvII0Fq3ENheXK/87r
 z1pLKFFjY0/WelVxYySSmSMbb3opmhDdpKZBJKQLHHkm1CizjXKJIZncGBkysLSHIxKf
 tvhQ==
X-Gm-Message-State: AOJu0Yw64phVZ7or8NuoxXjO0gNuOpGcN0FRUlfdHO800b0IT0CTZoyQ
 ZhhMWIMtB89h/Ttiz0mvUcxlOIMdkIv8z8g7+iiPGPdT4UUkOM4=
X-Google-Smtp-Source: AGHT+IFPgU7hWQYa5NbsMgAjkk037sjSwQm9n5tcUZ+MbhaLUF/mNWA4ttzGbZgD/kMK6aC92YEs3Q==
X-Received: by 2002:a05:6e02:12e8:b0:35f:e1da:e15f with SMTP id
 l8-20020a056e0212e800b0035fe1dae15fmr729395iln.73.1704381130215; 
 Thu, 04 Jan 2024 07:12:10 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cv4-20020a056e023b8400b0035fb79100cesm9260742ilb.59.2024.01.04.07.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:12:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 13/19] x86: CI: Update coreboot
Date: Thu,  4 Jan 2024 08:11:46 -0700
Message-Id: <20240104151152.697855-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151152.697855-1-sjg@chromium.org>
References: <20240104151152.697855-1-sjg@chromium.org>
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

Update to a newer version which supports settings in CMOS RAM.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 .azure-pipelines.yml | 2 +-
 .gitlab-ci.yml       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index b9d6aa98a0b..05efb8449ab 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -236,7 +236,7 @@ stages:
               cp images/spi-nor.img \${UBOOT_TRAVIS_BUILD_DIR}/;
           fi
           if [[ "\${TEST_PY_BD}" == "coreboot" ]]; then
-              wget -O - "https://drive.google.com/uc?id=1uJ2VkUQ8czWFZmhJQ90Tp8V_zrJ6BrBH&export=download" |xz -dc >\${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom;
+              wget -O - "https://drive.google.com/uc?id=1RWzwnrha-wsj8WgO2XHByo7vttxb62pJ&export=download" |xz -dc >\${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom;
               wget -O - "https://drive.google.com/uc?id=149Cz-5SZXHNKpi9xg6R_5XITWohu348y&export=download" >cbfstool;
               chmod a+x cbfstool;
               ./cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f \${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index fbf99f0322a..1402d97d805 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -71,7 +71,7 @@ stages:
       fi
     - if [[ "${TEST_PY_BD}" == "coreboot" ]]; then
         wget -O -
-          "https://drive.google.com/uc?id=1uJ2VkUQ8czWFZmhJQ90Tp8V_zrJ6BrBH&export=download" |
+          "https://drive.google.com/uc?id=1RWzwnrha-wsj8WgO2XHByo7vttxb62pJ&export=download" |
           xz -dc >${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom;
         wget -O -
           "https://drive.google.com/uc?id=149Cz-5SZXHNKpi9xg6R_5XITWohu348y&export=download" >
-- 
2.34.1

