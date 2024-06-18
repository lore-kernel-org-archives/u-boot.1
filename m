Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CD3C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 17:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E52BE8812C;
	Tue, 18 Jun 2024 19:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cV4eIDcV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F32888381; Tue, 18 Jun 2024 19:28:30 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F3A28812C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 19:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-421757d217aso59341315e9.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718731708; x=1719336508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lQiTLpYrIy8iCYWtlMhR+aG+H3xnvzSJaolirsptGa8=;
 b=cV4eIDcVSO217RAyqgbyMB5TrZeIAXJ1rSEvh71bGOc0vyHcs9eEv+pIwZCrh82u7+
 cyXNK8Uc+zgjMh2FdaRrc0bUGxUq3D69nTXZY935Mh7Y8Ylc4hV377JEwIwe36rXd3Ge
 tKzwPt/6n/jT8XlwSkroqp9mj4gAH5hokyv7Ce4USCKPY+Wtd75nJGoweu3UUCA85yAg
 vhT7rll4TzFZ4fJSSSsEqmMtoyC9Wc+6y8qstYfMrS2/xykSg8iPE7eHU/8rX+tm+uKZ
 KGV+zf9XGR3+RISdkohzkQ6BmdI/ROMk7AwD7wnV/eOKcKgyzTTff4n0BKTDohR+KW/C
 tcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718731708; x=1719336508;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lQiTLpYrIy8iCYWtlMhR+aG+H3xnvzSJaolirsptGa8=;
 b=XN0GUzdSfq5X7lPgRwOyL+Lm6gl8zmXiFMD1j4pQYgMCm6L5rP7I8suDQb4S+mopkJ
 hqU7Jt59tqj3o/+BWi2tMdelTcUasaT1xB1rzhKUoBxkucDbQzOG4fk6z4QQLpRfILdQ
 SsQpq2K2VH42wCLUmuSsd8BL8gLmYlhPF3FeWThQtN4+8slFbZrsyx65LGgPncq8Tuza
 yA/Fnv6zqtS1sk55UF7sVgHx7J6lAUWU2032fwtSSmjPmFWzQCh7OSe983f29PijiNnz
 w2ZtUArVVDJyvc+JNSljGOGY7Z/hfiHsHIQRayzme5us6VmUhSqLW/S7Wpz+65RIBMiH
 +0vw==
X-Gm-Message-State: AOJu0YztqD+fVjaenQs/kZYS2MPEG1qeCUrDdLmlE+WMQdO4Ecd1q7gO
 ATkT6rDHFmbibML74IdEobY3D54afEohUCBgNv/C0MjKKQs/uqn6aXJZh2mSl8w=
X-Google-Smtp-Source: AGHT+IFaE4NwYo5U3Bd4215fq4ukKlpoyBOyW+Wn08XY7eNT+ApgMBz59IsfehdJqZVVtRne0SM/iQ==
X-Received: by 2002:a05:600c:1d1c:b0:421:e7ae:955b with SMTP id
 5b1f17b1804b1-42475180a2dmr1235745e9.21.1718731707769; 
 Tue, 18 Jun 2024 10:28:27 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f5f33bdasm197893745e9.8.2024.06.18.10.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 10:28:27 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: sjg@chromium.org,
	heinrich.schuchardt@canonical.com
Cc: u-boot@lists.denx.de,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] configs: enable setvariable at runtime on sandbox
Date: Tue, 18 Jun 2024 20:28:20 +0300
Message-ID: <20240618172820.5570-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

We currently don't have any boards enabling CONFIG_EFI_RT_VOLATILE_STORE.
We do have EFI selftests testing the feature though, so enable it in
all the sandbox platforms and test the functionality properly

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 configs/sandbox64_defconfig | 1 +
 configs/sandbox_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 2bd4eeaade9e..dd0582d2a0c0 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -267,6 +267,7 @@ CONFIG_CMD_DHRYSTONE=y
 CONFIG_TPM=y
 CONFIG_ERRNO_STR=y
 CONFIG_GETOPT=y
+CONFIG_EFI_RT_VOLATILE_STORE=y
 CONFIG_EFI_SECURE_BOOT=y
 CONFIG_TEST_FDTDEC=y
 CONFIG_UNIT_TEST=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 93b52f2de5cf..da8c1976d7bd 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -348,6 +348,7 @@ CONFIG_ECDSA_VERIFY=y
 CONFIG_TPM=y
 CONFIG_ERRNO_STR=y
 CONFIG_GETOPT=y
+CONFIG_EFI_RT_VOLATILE_STORE=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
-- 
2.45.2

