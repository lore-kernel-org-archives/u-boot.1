Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78ADC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:05:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2280F8848D;
	Tue, 16 Apr 2024 21:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qh97fBC3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02DE08843B; Tue, 16 Apr 2024 21:02:35 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCA3088444
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:02:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-69b44071a07so36666556d6.3
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294138; x=1713898938; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDhVijotmZ2nU3RlW7hAeAlRdrWCm4nMHMPEC/ghkOo=;
 b=qh97fBC3Jjevb/7P5M0qfN2Pkvz+Q1u/R9EA59grhP/60eP/wzes4x19QTkpAdm61z
 eoGjB+2usYgyHBxiyzcEcWMSDLPN5/T3KG92J8Ly2mjgI+2JUz2vdZYH4qnMf9T5emm6
 R8tNK3hIfqrPJ7wMEB0XL9ysjImB67ihfieE7kdTF4osBz57mVCzYH6XeP6HhnQGLsrk
 up3vwKe8FSa5Yje+G5U1Ukc5cz7V7c6p7mrE3CPi7BYJEDyWnyJ31PO9+K2rK9gFfHkY
 v0KMQrpMloe3X0/fgSP0EucxMtSEY7gsqxIkCI9A93TPX3ClqN42lRveiiQ6hcqmsdFx
 kkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294138; x=1713898938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZDhVijotmZ2nU3RlW7hAeAlRdrWCm4nMHMPEC/ghkOo=;
 b=kWaKCNK6LoYj5veQr1QLkEonTzgU++OknNf2GNewjL654q1izv78sZqD5pxCq+GSk6
 yRwo6SaZmTRsE41XkWxs7N7rnXu6iu45Tgpq4/QAfo7x2c3skoiXAiN//REji5JtiD4d
 P+xS22aISEUEWWrSGVt48uKjkddCXVModECw5YXHEAQIaMDHxw3bER3cNcoYF4ne+qzZ
 VrkAJ1mEnK8VWp95oXYfRrYygc8aacAQKTOSO+udpWahae93rbjrOoQhWQxzCtQUv3DD
 8L8EiDgR0wWSewdWwEvQ1HpTDrBr4yYl0nki8c318EB0pfeiKHgpvwm5wFrZLeQrevr+
 97FA==
X-Gm-Message-State: AOJu0YzgYzfFChxVRLHYipetnuhn9EKkYzpGBNhFT+rGlPt03I72c7bQ
 tckocnz0Rb7x9KEIwOPpfI77FT9USEAev7VR2vWA2TsXoFKOuMm3iyn1xW2ULyfLaoGL8PR167H
 9
X-Google-Smtp-Source: AGHT+IF8LJb/1WHCX6Bh2VCt1XRC5hJ+KK6IaDlYpAkv1qPY1ulCiSM2VTuZllvDbPnh+J7vXUDlxA==
X-Received: by 2002:a0c:f846:0:b0:69b:ae3:ee1a with SMTP id
 g6-20020a0cf846000000b0069b0ae3ee1amr13937034qvo.65.1713294138134; 
 Tue, 16 Apr 2024 12:02:18 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a0cbe8d000000b0069b59fb5829sm5971657qvi.44.2024.04.16.12.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:02:17 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: raymond.mao@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [PATCH 23/23] configs: enable MbedTLS as default setting
Date: Tue, 16 Apr 2024 12:00:19 -0700
Message-Id: <20240416190019.81016-24-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416190019.81016-1-raymond.mao@linaro.org>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
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

Enable MbedTLS as default setting for qemu arm64

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 configs/qemu_arm64_defconfig | 5 +++++
 configs/sandbox_defconfig    | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 7e166f4390..587a3fb912 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -67,4 +67,9 @@ CONFIG_TPM2_MMIO=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_SEMIHOSTING=y
+CONFIG_MBEDTLS_LIB=y
+CONFIG_MBEDTLS_LIB_CRYPTO=y
+CONFIG_MBEDTLS_LIB_X509=y
+# CONFIG_MBEDTLS_LIB_TLS is not set
 CONFIG_TPM=y
+CONFIG_EFI_SECURE_BOOT=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 93b52f2de5..6f36fa0ac8 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -343,6 +343,10 @@ CONFIG_FS_CBFS=y
 CONFIG_FS_CRAMFS=y
 CONFIG_ADDR_MAP=y
 CONFIG_CMD_DHRYSTONE=y
+CONFIG_MBEDTLS_LIB=y
+CONFIG_MBEDTLS_LIB_CRYPTO=y
+CONFIG_MBEDTLS_LIB_X509=y
+# CONFIG_MBEDTLS_LIB_TLS is not set
 CONFIG_ECDSA=y
 CONFIG_ECDSA_VERIFY=y
 CONFIG_TPM=y
-- 
2.25.1

