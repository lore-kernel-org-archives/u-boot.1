Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F1EEE498E
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 16:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 022C583FB0;
	Tue, 30 Dec 2025 17:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dzyEcvGc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3338E83F70; Tue, 30 Dec 2025 17:01:52 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A1B783F69
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 17:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7baf61be569so10468508b3a.3
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 08:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767110508; x=1767715308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0y/ggl7Tun78x/xIrwEqAxIUWXuQCd/v8ix5oznx/A=;
 b=dzyEcvGc64H6MLl31UDlXk4jaJ06nbZTU1Qa1tmkwT8cC5Qo2AADPTo+joguelQl47
 ORcCYr1Go9IIFJNUvhEhZdbNqWECHTnrX02znhSK3qIJOn31bppMzUKO1fMImYZg/shc
 Y/nvfhHAyG+pRLHfepDfNVrsmHQZ4b9lb0luhP+eevYRCyZddtzx6s8Syr7BTHHSf4S3
 GR0J0SMM4X+4pwfMFI1kcyO0UPcowt3e7C72//L96+2s+o9Fwf6yZ6IkGlRnqXLbK/ND
 58IayI6t7IKw/n5pLBoaIrwSnh/v1jlV77HSSBHqvqjklL0K6jrOXdyM63nwzCwrp+rz
 Gsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767110508; x=1767715308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n0y/ggl7Tun78x/xIrwEqAxIUWXuQCd/v8ix5oznx/A=;
 b=R6hKQb0XWht4aYAqhUTiIfi7DAGD2VSU+e9ha7Chmtb/s/2zdq+bwRqcGxQyc/E+lO
 BnB23VVbg2JbJx7Xdi22uBFPAARfHB/kl+ogJR+L5YebI4rLVap+ZdrsZI08ZNlalU+e
 rBUiesIyWw/hQFKUqFuOjMU7JGeWz5M9iv5+ABVXO3zXnu/63oQR3bi1FkVs9TWCjzYq
 ZbWv4x3Y+Q7pg6ijUKqNtBMwXn18cKEbDzNFT7Lqn9DaB1Rp4f8eO+W29KE86lfeirTr
 7QiAKZPwX3Onfg5czHPxgI1lehmd0lRc6ErievfAv7aeJyI5gHlRdPvRQOP9jJNU+3wA
 5kbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkNuktSUXoDzK9WOFbJEylTP1rDMtKItHyrJ0F+SakA7ucsyJ5clgcgR1j9Z329tKmkz4AN2o=@lists.denx.de
X-Gm-Message-State: AOJu0YzyDZSZFYbtOGVATG2PfJLqNipazclfp7G9cVQ+HHDuppLLYvkx
 OpdRjfyDk57IW8C8xhtZ0SVPaTl+XujBrEmmNpGU+IKLIxr1TyBQ7L+xi64CRg==
X-Gm-Gg: AY/fxX5zoD32f1y92USgq3YnXlV2unj7n+HlWpt5yYTlCKkANulwFBFSBxOokzjn/y9
 jL3+6afNRSoQLyadCLhLPHNpiHOtd3hxaGw/PX1Gp0Qt+LyoErmri6B7RSpRwTLbY7thgLcZRBg
 3O2f1c3CEuLe2CtyMLPBc3QnAQPl4/eXV30vtt9rqkALaA2xmvXHQMuyhvwH6VR/Gc5gdoG9UfN
 Vbm2F9ckCCdvpNr2JjdC6dw2Ery6euj/9lZjmiILcBNkl4NVK++d0YNHOQXv3cnKFFL81qyN+OZ
 mEu9VOCH4tGSuimm3hdan9Gqwt56HtxWLRYDuZhlgy9Cu7zPjyp5QQbJC1a6psZIP3K2q0CZD0U
 Y88Kycza1BQtqUpNFcaMNhu40BJtJ7qzXcMy0LhMTONymcoRBOpHl+OsMNZOeAtGGQY65RfILgp
 ovTyiI+/ICL7kU4SQI4if39Mp3/4HjXF8DghngPjQHXdf0fcZBnkhr1zlmNpuuf39Qz8GTKF7/X
 /8PIef/fXSFAYBZ74gJS7z8HmZzRWI+
X-Google-Smtp-Source: AGHT+IHthZExKfQRa5jg+DElpOAO8ZWkaGcQkRQ8sfo0ObJvT8dYO0lznvZtpwqj1gyoGoA5YfDluw==
X-Received: by 2002:a05:6a20:430f:b0:364:13ab:d4c5 with SMTP id
 adf61e73a8af0-376a8eb7985mr34385910637.26.1767110507544; 
 Tue, 30 Dec 2025 08:01:47 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7961c8a2sm28558883a12.6.2025.12.30.08.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 08:01:46 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 6/6] CI: Add test jobs for QEMU m68k virt machine
Date: Tue, 30 Dec 2025 16:01:12 +0000
Message-ID: <20251230160112.3045527-7-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20251230160112.3045527-1-visitorckw@gmail.com>
References: <20251230160112.3045527-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Dec 2025 17:55:53 +0100
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

Enable CI testing for the newly introduced QEMU m68k 'virt' board on
both GitLab CI and Azure Pipelines. This ensures the new M68040
architecture support is built and booted correctly in the emulated
environment.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v3:
- Remove TEST_PY_ID

 .azure-pipelines.yml | 3 +++
 .gitlab-ci.yml       | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index e4695f1c55b..f563878b021 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -518,6 +518,9 @@ stages:
           TEST_PY_ID: "--id qemu"
           TEST_PY_TEST_SPEC: "not sleep and not efi"
           OVERRIDE: "-a CONFIG_M68K_QEMU=y -a ~CONFIG_MCFTMR"
+        qemu_m68k_virt:
+          TEST_PY_BD: "qemu-m68k"
+          TEST_PY_TEST_SPEC: "not sleep"
         qemu_malta:
           TEST_PY_BD: "malta"
           TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e7234e003ea..1fc4d1e656d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -408,6 +408,12 @@ qemu_m68k test.py:
     OVERRIDE: "-a CONFIG_M68K_QEMU=y -a ~CONFIG_MCFTMR"
   <<: *buildman_and_testpy_dfn
 
+qemu_m68k_virt test.py:
+  variables:
+    TEST_PY_BD: "qemu-m68k"
+    TEST_PY_TEST_SPEC: "not sleep"
+  <<: *buildman_and_testpy_dfn
+
 qemu_malta test.py:
   variables:
     TEST_PY_BD: "malta"
-- 
2.52.0.358.g0dd7633a29-goog

