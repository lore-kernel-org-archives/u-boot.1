Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F15E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E6C68727E;
	Mon,  2 Oct 2023 03:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NPN7XS92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 523B287464; Mon,  2 Oct 2023 03:18:42 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB4FD8727E
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-79fa2125e19so506086439f.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209391; x=1696814191; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EKqdt2yye0Iw3/e7rgu6pQgMxRVx14kpOsTfFe5cQkY=;
 b=NPN7XS92O2RZXaWzdykJx1phDvWtLVhvCiitXd6tugP/0KSEvDDecJJfbgE92c1Cz7
 hzv9NzypJDrp6OJMSRJNEYIGQwi7APU4V/BPR4a8zgY0uQUBUNvPjHosmgpqAC+whrVK
 ww+3Uipkft3+RLywIv0roEDawB5FyGqjzHpGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209391; x=1696814191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EKqdt2yye0Iw3/e7rgu6pQgMxRVx14kpOsTfFe5cQkY=;
 b=uvfxps5e15X3muvrmwQDwoLTdxo0IIarVgZ+Tc0NvF/Kj1UX8AMrK9gJKJKotoi8U7
 PTUDdpJccdStmF8UdQYvy6bnYZxp+oCiuFEvOSbhtg/aoiVuD08+6BMQpQuYpOabMfs+
 Bkahu8ao4V7fcBeGM2sm9HPqCIADID9xbGdPLAtBaAdWU2ydLOp/YUf1std+0RMnPAuI
 HxbOGzbtJKnHJwUI6bzajHMv4TfhB68ThWbqDpFZ91j523640xliK5T8CShXoutHolkT
 jvm93hCbY4//xXX/4zqZTMfMHJ4S3/O2/eRqY8W9M7VJupw0zqfrhS0yeso3DXGgXpH2
 VrfA==
X-Gm-Message-State: AOJu0YxlgJ0UlDjsp4C7YhOxNDj+AGTF1l3VR/hq01kZCLXyDhrsURZf
 LwzxFGD3Nbkn8SykQmqVva+DvXdygoFimSvVll8=
X-Google-Smtp-Source: AGHT+IHIgvRQUCHlOBDg9tI4Fv7suySNAHCiqnerXzCNH4V/HHZY5cpMA7i6e1pBfmBjWm3z7il+4w==
X-Received: by 2002:a6b:5b15:0:b0:79f:99f5:fadd with SMTP id
 v21-20020a6b5b15000000b0079f99f5faddmr11424397ioh.6.1696209390933; 
 Sun, 01 Oct 2023 18:16:30 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>
Subject: [PATCH 28/34] x86: CI: Update coreboot
Date: Sun,  1 Oct 2023 19:15:38 -0600
Message-ID: <20231002011553.463514-29-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

 .azure-pipelines.yml | 2 +-
 .gitlab-ci.yml       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 421c5018b40b..83491e38f70c 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -255,7 +255,7 @@ stages:
               cp images/spi-nor.img \${UBOOT_TRAVIS_BUILD_DIR}/;
           fi
           if [[ "\${TEST_PY_BD}" == "coreboot" ]]; then
-              wget -O - "https://drive.google.com/uc?id=1uJ2VkUQ8czWFZmhJQ90Tp8V_zrJ6BrBH&export=download" |xz -dc >\${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom;
+              wget -O - "https://drive.google.com/uc?id=1RWzwnrha-wsj8WgO2XHByo7vttxb62pJ&export=download" |xz -dc >\${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom;
               wget -O - "https://drive.google.com/uc?id=149Cz-5SZXHNKpi9xg6R_5XITWohu348y&export=download" >cbfstool;
               chmod a+x cbfstool;
               ./cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f \${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6efbd8021c8c..a9c2e578ce16 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -69,7 +69,7 @@ stages:
       fi
     - if [[ "${TEST_PY_BD}" == "coreboot" ]]; then
         wget -O -
-          "https://drive.google.com/uc?id=1uJ2VkUQ8czWFZmhJQ90Tp8V_zrJ6BrBH&export=download" |
+          "https://drive.google.com/uc?id=1RWzwnrha-wsj8WgO2XHByo7vttxb62pJ&export=download" |
           xz -dc >${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom;
         wget -O -
           "https://drive.google.com/uc?id=149Cz-5SZXHNKpi9xg6R_5XITWohu348y&export=download" >
-- 
2.42.0.582.g8ccd20d70d-goog

