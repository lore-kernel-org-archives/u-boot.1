Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F9ECCD192
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 14:20:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AC2B835FD;
	Wed, 15 Oct 2025 16:19:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AD7kvMd2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A07E683655; Wed, 15 Oct 2025 16:19:52 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EC1E800D7
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-79599d65f75so81483926d6.2
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760537989; x=1761142789; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lvUOz4nnXIZW4UjTLs/cOs+csIfqmFPJszVDKVfat4M=;
 b=AD7kvMd2f3ietNhgSsUQgeXf1kKgDtHp6y9sf/jfm7qMcvuxYWM4z41R/s0hWnbYzF
 h9CDOzdLmTFzI5EKsa0Ag+NzDqLEmQA9cgifaKXDrht+CqYlka/IXQ4mVvvItBOpbXm0
 yFVBKzcuhdv9lO6ZhdgnKE2b4tz81jv9OUfz0eCBOehQGXXh0dEcCN2XuRPAH48Thlcz
 THTv7A79w1ZlukJBiZGr+dQR5qS4kR4L0cf/DsKFzrLOSKuzV8kmIJnhJ09dUQlXSZ2b
 6K4b+PFW1hAsZiwcEHWIfkLSKghuyWNKMpJdU7xq4dmQoXDuaeeomNk9TYtMaYN4D07v
 XkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760537989; x=1761142789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lvUOz4nnXIZW4UjTLs/cOs+csIfqmFPJszVDKVfat4M=;
 b=uTQ8hav9b5q0C4EyWubj/QtYB1e4bOoE7uQdcR8Aewhwpdt0lgeHGZeMKCHyc8m5KW
 X9MPbuNSzFM3qYEZ40lQlIMfndMVPRz/Dfd7+KVVNsaWPN41/Iiwx2ErzzzvBgWSXEXM
 Xct98EB7yUYBmxCRnQE2ullvrePavK5JYOtyWW57Bhs9T4SR/eAr+gF908TvnIFJZJ8I
 WSd+/yG3RN8RC1mJguBuMx3Q+pP1gxnWVs+qX16hmlkeDb+sC0VxlgQx2CqbGshFMiiY
 le2O3Uyxc/6JOlcoZ19aCVdTvECE1oYh14YLAhJuI0Z8FCaa77ikwkUx6r3FgN4PZu+5
 oj5A==
X-Gm-Message-State: AOJu0YyXeLyBVEWBR8HzLnS3yJeLaPHhzpjCfVPtF+iUDQ9sPER/bvlE
 oOpO+r0s4wEXtA8dHpahuSAYjjkWiO8YdxiRNnOFSPJisb6fWOfwDuF4NG5KmdAk0T2vqOTwB+I
 rJMFy
X-Gm-Gg: ASbGncu3egoD3DIItXVr4CcMepBXpQW03z51xGbgrZab3F54AiovWWKhvlj2dh30LI7
 M+MdcsBs4D5BvCKEa2HKnTJBXF7I8ynlbizQQ1oP8qZa/jsFjbSe4xMC3Napl0EQveuzYpIt/uy
 8eMeBlzCe0V/lkF20ccbS5Zwbg+wLd4X7nvyMmWzE+yOQDOXQWiRh1ICADSrXxOF4Ao75xtv5gy
 ZfqqJSvIxaJhv+hX4JIs3LxPTGL6SnNgPla5dy6JbbXt0PyMfffXfr2z2UBH1POs0thRO1X9XOc
 VZD+1A+3Rq2LSCnoYbjWOnwXFPWMkFj7+dIii2AiAUv6HTvwwIuya7V9l5/5QwBjbfCOqoDBioZ
 z9ksv2XJl8o0ZDK/TklrrQ3c8HkAr5xmSyqEiYgRBkrzeeI6yT0R6dofnfkWHMw4DC1qlWQdO1C
 Ustuw=
X-Google-Smtp-Source: AGHT+IEJ8KuUBK2+WJu+TsjrX8sXmcT0i6NREK9mKdIqyYY38VaW+EJatt5w0M0alyO0WVwGm0gAwg==
X-Received: by 2002:a05:6214:2507:b0:851:746c:e6d7 with SMTP id
 6a1803df08f44-87b2103ca0emr388205576d6.8.1760537988919; 
 Wed, 15 Oct 2025 07:19:48 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87c0120c20esm19337466d6.5.2025.10.15.07.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:19:48 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v4 6/6] ci: add test entries for qemu_arm64_tfa_fw_handoff
Date: Wed, 15 Oct 2025 07:18:50 -0700
Message-Id: <20251015141856.4168612-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251015141856.4168612-1-raymond.mao@linaro.org>
References: <20251015141856.4168612-1-raymond.mao@linaro.org>
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

Add qemu_arm64_tfa_fw_handoff test entries to azure and gitlab
pipelines.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- None.
Changes in v3:
- None.
Changes in V4:
- None.

 .azure-pipelines.yml | 4 ++++
 .gitlab-ci.yml       | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 4bf4d9e763b..6948ad6b4b6 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -477,6 +477,10 @@ stages:
         qemu_arm64_lwip:
           TEST_PY_BD: "qemu_arm64_lwip"
           TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
+        qemu_arm64_tfa_fw_handoff:
+          TEST_PY_BD: "qemu_arm64"
+          TEST_PY_ID: "--id fw_handoff_tfa_optee"
+          TEST_PY_TEST_SPEC: "test_fw_handoff"
         qemu_arm_sbsa_ref:
           TEST_PY_BD: "qemu-arm-sbsa"
           TEST_PY_TEST_SPEC: "not sleep"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5ae02176167..e20e6c6d43f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -409,6 +409,13 @@ qemu_arm64_lwip test.py:
     TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
   <<: *buildman_and_testpy_dfn
 
+qemu_arm64_tfa_fw_handoff test.py:
+  variables:
+    TEST_PY_BD: "qemu_arm64"
+    TEST_PY_ID: "--id fw_handoff_tfa_optee"
+    TEST_PY_TEST_SPEC: "test_fw_handoff"
+  <<: *buildman_and_testpy_dfn
+
 qemu_arm_sbsa test.py:
   variables:
     TEST_PY_BD: "qemu-arm-sbsa"
-- 
2.25.1

