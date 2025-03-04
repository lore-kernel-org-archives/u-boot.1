Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB094C282D3
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A1C581A0C;
	Tue,  4 Mar 2025 14:10:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kGgJJC5p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B02B819B1; Tue,  4 Mar 2025 14:10:17 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 505398197D
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:10:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-855bd88ee2cso151008739f.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741093813; x=1741698613; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BT9XcVfrVAloT9cNUE3vLot+cyNMjRqZbj/Bf6BSMa4=;
 b=kGgJJC5pOaAc7xz8imu4yf2XTjeR19D+oFph46VNaErggmObF/eQjOwhN9SVUwk5jA
 neL8RraxJ5dajGH9kdhkCOCF2WQx7P4lZDjdYDWLgPfdS2yjCJPTL8p+VX2NNdRoxA39
 gU0BwTn0HCw2O2VOIjrXXVVN/gOHHwA4j3Sso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741093813; x=1741698613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BT9XcVfrVAloT9cNUE3vLot+cyNMjRqZbj/Bf6BSMa4=;
 b=lK9Zs6MvX7A1uwI6AHOcNNulEs0wYF/QKgv3ZZtZPm89HdSMEQQXnV8CX0ZMbuFokP
 FQ8DWTOun0+c5+APbTVykZ1OQhM6JbKaGBHIN07FFU0YjDDRM0XHoginEybuGwW32d5+
 VrIYDUyfKXyMJIps1yKE4Q/WImp1lgwHcm4pP2CwQrL6YLLcGF56vsKuzlp7nsNnUThZ
 CsR1MhcBEPtT7H1CxUxO61PgJ0tThVE5eG5RMK6ogU5a7WhBd0dJDnfoY6e8uaGXbyy4
 cj9b6w5kgtSIWt7AotT0x2ps9jOZmOQGjnik1Az3s5PNwVhL5YiAyIieWw+/xsBtlxeP
 NIVA==
X-Gm-Message-State: AOJu0YxxXd2WenM7w35xHK5/fdtMFKYjx56uLVXk3fdvB7++xHnGBt1Q
 g3VMiTFt4FSP/XIb6eZiChO03kDkqoJaspxa+EBeLmHa/jZAMy1+0oehOksebehnuuUxN0c9hAk
 =
X-Gm-Gg: ASbGncsGrZGNGIoa+tN3Z/f84O8jz/V33KHCvvk1zO7e56fum2cphRkb5T1H/lmLz7p
 VpcPqU34BzQjeCwYe6IuWu8WMJ7ZeBcGOf5MK++F2h++dgguQ7sR+U3LXwAYFidek/nagpnfvXI
 Iss8H3EPrh3TnJLJNexnVo3t/nxMF1qAHL8d3KHsCeawagmsi7Nbh7o2lWQ3JxXuO64Ls5mfjp+
 UAGTFdUQ4Q96wnlM15sVNXRKQPSjnKFHFaFvaO9DMDWTYy0/wIgdocTY/Ovlb6Zu+rQNSnGdD1l
 t+uQlAx2K+cDS1Ymwgw2BPBu4UXXcT10cwdntl+mfmpnSiqOgndxyw2vdOVA/mp2V0VZoO/l3hj
 QbHogUw==
X-Google-Smtp-Source: AGHT+IEyKFuZCxL8dnJNC20puUU8M+IsYqMoxSlAJpGBpDNokP6IXH/vm6U1uQUJPWuoRoU+rGTyaQ==
X-Received: by 2002:a05:6602:378a:b0:85a:e78e:2823 with SMTP id
 ca18e2360f4ac-85ae78e2b44mr523345239f.2.1741093813067; 
 Tue, 04 Mar 2025 05:10:13 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-858753cd304sm287383839f.33.2025.03.04.05.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 05:10:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 7/7] CI: Run code-coverage test for Binman
Date: Tue,  4 Mar 2025 06:09:44 -0700
Message-ID: <20250304130947.109799-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304130947.109799-1-sjg@chromium.org>
References: <20250304130947.109799-1-sjg@chromium.org>
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

Binman includes a good set of tests covering all of its functionality.
This includes a code-coverage test.

However to date the code-coverage test has not been checked
automatically by CI, relying on people to run 'binman test -T'
themselves.

Plug the gap to avoid bugs creeping in future.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

 .azure-pipelines.yml | 5 ++++-
 .gitlab-ci.yml       | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 2bc2ca55b9a..712c823e145 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -140,7 +140,10 @@ stages:
           export PATH=${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}
           ./tools/buildman/buildman -T0 -o ${UBOOT_TRAVIS_BUILD_DIR} -w --board tools-only
           set -ex
-          ./tools/binman/binman --toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools test
+          export TOOLPATH="--toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools --toolpath /opt/coreboot"
+          ./tools/binman/binman ${TOOLPATH} test
+          # Avoid "Permission denied: 'cov'" error by using a temporary file
+          COVERAGE_FILE=/tmp/.coverage ./tools/binman/binman ${TOOLPATH} test -T
           ./tools/buildman/buildman -t
           ./tools/dtoc/dtoc -t
           ./tools/patman/patman test
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8c49d5b0a79..c6461f33982 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -229,7 +229,9 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
       ./tools/buildman/buildman -T0 -o ${UBOOT_TRAVIS_BUILD_DIR} -w
         --board tools-only;
       set -e;
-      ./tools/binman/binman --toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools test;
+      export TOOLPATH="--toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools --toolpath /opt/coreboot";
+      ./tools/binman/binman ${TOOLPATH} test;
+      ./tools/binman/binman ${TOOLPATH} test -T;
       ./tools/buildman/buildman -t;
       ./tools/dtoc/dtoc -t;
       ./tools/patman/patman test;
-- 
2.43.0

