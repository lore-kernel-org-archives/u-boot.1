Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6FBEE645E
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 17:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9A9D840D7;
	Wed, 31 Dec 2025 18:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bEGCw9dD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E325840DE; Wed, 31 Dec 2025 18:13:47 +0100 (CET)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 022AF840CB
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 18:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-455a461ab6eso3385833b6e.2
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 09:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767201224; x=1767806024; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bhLlU4cRjsd2zOS/TzHn7uWnXubRcLlBqiqZoRXgH2M=;
 b=bEGCw9dDi5cEiNmf8AIl9zb/v7lyXro9W+qn4DJ9T+bfoV37ZvAzoYedv0eBTkqmkg
 ehucq2sk304LvQ62GLQrW95Baz5BiVPl+lDm5WmV6ZEh8rhr+r97T+usnAra1jsqVrAr
 X5d4JwNo9auY3FQXpOXbPAV5S5W6DpfGidtYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767201224; x=1767806024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bhLlU4cRjsd2zOS/TzHn7uWnXubRcLlBqiqZoRXgH2M=;
 b=T2fIoBZUjHz68/dpPvwGFl26W4QG8571svsZadOnFvBXrIysxyEHVZiHGTmTPwdtBB
 1Lcyz/spuBMoC6dLLDWtRFTE5veDFe3e0bixGK3jApaYYfycpmhO8gk5AP+rFvetq9TU
 GJ3RxL4xl6sNxyklE2PDHa/u32un6HYlfKjDH240hpsggmQf0qMRerv/oJnNSar9BxTD
 XDsr/ARvxH3IgPsNaDbXpl8aFggMQpGYn7ieCezbMG2M77zZx2UaNWYfZ9g+l//9t9FO
 5Jqifzdz4Le5Peoj/glVeFTGBVT8fRprmSpCTcHFhKVV0ga+YuDdchuCBSbXmlHlpF11
 jOpg==
X-Gm-Message-State: AOJu0YzifZ4MsUs9fAO5+pqroZCOX1tROlRoQ73ZeONdOfoi8RjGSsfu
 c/Tg7fPaW+3bn8+JRCEF6Np2aMVD4tZ8iDRadfagVJWqemGBKOdJq9Z0O4V+dNRpi3mfr8nma25
 7TFiT3SM=
X-Gm-Gg: AY/fxX6wY76XDDRqY+MaH6y83ZjXCLV7UnR2TYrcMNc7WebZBPkTW82MqVTWTAahuwy
 869B0zjDAc1U8XT+/BOZ9V12u4ZnHeRgnNCC32sMdVgM7bLmN3CvjwfNMi49suuAak2Cjk5WK4k
 RgIHKaV9RrvvbNjkRqLqgr3EM9LdNPTxciK5YMfvqkeWxlQXvWWhByWK6NeWOJqB96XbLDy6xeB
 sCvxLu5rdjfZx0+vx4PnpFX9oK1ugAfAAQ+N6AtRLN2CwMfBI2DjuY/WnoTpeJaLOmKXUwgsV6R
 mwpfcOr5HR64P0JJuurkM1lv5mhmXYhTn48x9endcx6eHhBby+mmNd0yxgAu3hPdE6Wh8BdBMG7
 E9rwgQPToDogRcY/h89/h7dCTx1FOnX+LcJlvZQ2akFeZ/9VB2+pgJcr/ZgRuFQx7k5hXkPJNSR
 A7oc5tKzmRZFWRIsRV5K0avpbxesf6vIiNe/64hJ83S/6YZJH+cAmJAlCkCTRdYhbXl/Y6+HkDy
 JL5Osje/uTJAGfbc2QWj7g1ghK+KkwupmveTgg+advNXtSkNuE3
X-Google-Smtp-Source: AGHT+IEofOeHf2QlwbBPdwtjxcXZo/N04Va3xaWGHmTqBS86QcadSdgecq/tX63tAScUvW+BpdRB6w==
X-Received: by 2002:a05:6808:e85:b0:450:d143:b77e with SMTP id
 5614622812f47-457b2010039mr17312799b6e.58.1767201223590; 
 Wed, 31 Dec 2025 09:13:43 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b39f22e2sm17683374b6e.0.2025.12.31.09.13.42
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 09:13:43 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] CI: Add "allyesconfig" to one of the build jobs
Date: Wed, 31 Dec 2025 11:13:41 -0600
Message-ID: <20251231171342.3046889-1-trini@konsulko.com>
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

Now that we can have "make allyesconfig" build and link, add this type
of build to the job which builds host tools as well. In GitLab, make
this job rather than binman testsuite be the job which unblocks the next
stage of the pipeline. This is because we had been using that job for
"sandbox builds", and now that we have an explicit test for that, we
should use it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Technically, this still requires:
https://patchwork.ozlabs.org/project/uboot/patch/20251230171038.4155709-1-trini@konsulko.com/
to be applied first. I will pick that up before applying.
---
 .azure-pipelines.yml |  8 ++++++--
 .gitlab-ci.yml       | 10 +++++++---
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 25b0e4c985c8..46655776ffad 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -128,8 +128,8 @@ stages:
       - script: |
           ./tools/buildman/buildman --maintainer-check
 
-  - job: tools_only
-    displayName: 'Ensure host tools and env tools build'
+  - job: allyesconfig_and_tools
+    displayName: 'Ensure allyesconfig, tools-only and envtools build'
     pool:
       vmImage: $(ubuntu_vm)
     container:
@@ -137,6 +137,10 @@ stages:
       options: $(container_option)
     steps:
       - script: |
+          # Allow pipefail because of how we use 'yes' here.
+          set +o pipefail;
+          yes 0 | make allyesconfig oldconfig all -j$(nproc)
+          make mrproper
           make tools-only_config tools-only -j$(nproc)
           make mrproper
           make tools-only_config envtools -j$(nproc)
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 08bea0dd2342..b9843c4ff265 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -32,7 +32,7 @@ stages:
 .buildman_and_testpy_template: &buildman_and_testpy_dfn
   stage: test.py
   retry: 2 # QEMU may be too slow, etc.
-  needs: [ "Run binman, buildman, dtoc, Kconfig and patman testsuites" ]
+  needs: [ "Build allyesconfig, tools-only and envtools" ]
   before_script:
     # Clone uboot-test-hooks
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
@@ -195,10 +195,14 @@ Check for configs without MAINTAINERS entry:
     - ./tools/buildman/buildman --maintainer-check
 
 # Ensure host tools build
-Build tools-only and envtools:
+Build allyesconfig, tools-only and envtools:
   extends: .testsuites
   script:
-    - make tools-only_config tools-only -j$(nproc);
+    # Allow pipefail because of how we use 'yes' here.
+    - set +o pipefail;
+      yes 0 | make allyesconfig oldconfig all -j$(nproc);
+      make mrproper;
+      make tools-only_config tools-only -j$(nproc);
       make mrproper;
       make tools-only_config envtools -j$(nproc)
 
-- 
2.43.0

