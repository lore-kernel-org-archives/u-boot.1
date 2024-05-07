Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0694AC10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 18:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92D8988809;
	Tue,  7 May 2024 20:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wCf5QS03";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A687D88809; Tue,  7 May 2024 20:03:52 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F4FE88025
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 20:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-69b44071a07so36074676d6.3
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 11:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715105029; x=1715709829; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1iu4SrFJHYiQ4Nf0EKqTlCxaydyAJ5X3n1jhHXsqNe0=;
 b=wCf5QS03UF2dVe3AlUZPVnLklBg9zsbEwzdCtKIv5WdQKLZcFpcaamIgmQRIT3tNy3
 60PXHfsue6OCePiCuIaG6fkeNemk+yAIFQZrUsTfE5t0W2XfYk/aRk8h/VnbsYsG9+8a
 +sIa0C1Ge5GDczEjUm8Ruw56ChBxFrBfQPvniI5zCKCgLzIt9pDTMqPGyReZIB1VyZdB
 XlOsnzqvjutS9DB2M9yNc0U5kg7rR2+3/hl+nB/8dbxFOxBRog0RbFEwGjnhROaUK++N
 Y7Q15p5a4xieDSvZXKaYwVYH5qzhEJx/pCZ/nD1LC8Nxp7kfHYHkh+mJ9SGgHvwHzRoy
 sGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715105029; x=1715709829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1iu4SrFJHYiQ4Nf0EKqTlCxaydyAJ5X3n1jhHXsqNe0=;
 b=qKzD42pklwDzrq2lqpxrq1ZtXgxCpt1c7gc2AsBMpcqGm8MusrQ3xKwwAe7VQul6Xc
 7qbf6dVLoAkpxwehkwtq0Pcztz4RdN2YCWwS/VrhnqOD4armzcZGj0bBhj3+V0b+Cabc
 pZwpUYlMlIyN5L3PLrUBtSBA+u8SCvZlYrcBlkcxlg9DfoxN2D2dY/7AHOuQRlW57hkc
 qAMtOskdi8uSqxOP7u8xoAFXUXzacpBc8/2DnH3XMirFek5BZRzVVnTQnikpzjfcS6SR
 fdlcYvxEO7ydsr5PhBMo6Ha1rcqe2D6k7QTrUD0SKmgKigWnD98807gCQaPbnJYMSvzA
 Lmrg==
X-Gm-Message-State: AOJu0YzRT1RCTKnGQgx51Pum2FwvitkdLu9b9KY1nVDAUMDWAL5Re37z
 MO0Qz/QQzFB2prcNLHXmiTb8PkfTVzV3Fjlt/Zrez0iybJ0jq3IHoiB9cxhqm+LiufGCIfmCrt9
 s
X-Google-Smtp-Source: AGHT+IGPyfqKyr1IGAhsgs+zfYaRDzUFV6q70Y48jrJzUSZcIY93+NU2f2CtF3+n18Oh/V2U/gjwuA==
X-Received: by 2002:a05:6214:f26:b0:6a0:b905:97b0 with SMTP id
 6a1803df08f44-6a15149fdf3mr7312506d6.39.1715105029181; 
 Tue, 07 May 2024 11:03:49 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.11.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 11:03:48 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Eddie James <eajames@linux.ibm.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 28/28] configs: enable MbedTLS as default setting
Date: Tue,  7 May 2024 10:51:10 -0700
Message-Id: <20240507175132.1456512-29-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507175132.1456512-1-raymond.mao@linaro.org>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
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
Changes in v2
- None.

 configs/qemu_arm64_defconfig | 5 +++++
 configs/sandbox_defconfig    | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 7e166f43908..587a3fb9123 100644
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
index 93b52f2de5c..6f36fa0ac86 100644
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

