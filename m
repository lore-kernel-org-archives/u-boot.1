Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3663C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:35:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B4FB88809;
	Tue,  2 Jul 2024 20:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ULHGlg9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFD5B8880B; Tue,  2 Jul 2024 20:35:15 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E127F88808
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-445ae4cfe5aso29294341cf.0
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719945312; x=1720550112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y5F1Ir437iEyPXb6NGp2Ypy8IpvZItoyXxHmvB284RQ=;
 b=ULHGlg9cZ5cP2HKzN228n1ostMRJpMO9wPv8YB0FcDFxIsOYQCJR/AvZT44dyallxu
 KxOClbLookx03pebwsN7mCOQK9HBXf3LXaK5aTCOraX7e0TfYVBNhyOXE65e2tJcMZK+
 ep/+6z9PBC5cqf/V+xt/z2hmiIBvdEtppt7JIJPgRRcXFx6pRM2T6xrZlhFek+9SuLXt
 mEWM182rWywkAXzdYGLTkYgtEkkPV26ymSaPmCqTeewhftwMDwyUKYsDBnGw0bJK3N64
 sN5Ys4rAmZJUQtf9enGFut/YJVd5HwfPrtqiUWtBhmBQEjGJ3VGDR7y2iXxBoOaPYPdR
 1mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719945312; x=1720550112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y5F1Ir437iEyPXb6NGp2Ypy8IpvZItoyXxHmvB284RQ=;
 b=H8rKwRLWQ6H66znNayYeDTgzxxj6AJPEEMq/9uDSm5BM3i/KEUA4okGMxD3gPFxQKQ
 K9dx0sijFz5NMGyqQpcQZ5jDAXeXxgwkW/MgIlqH1wXbg1Pb9tovbkZBzAe2NxSPbvYp
 2KjlL+6BpibNuyzw74THtKzSvSjJ6XNGXC4QqOn6Z2dgim0gEbMiKtbyrFqZz5Nm7dBT
 Rd0nUqFxq9Zsd9KRXK/D/j7N6YwpyNvLGOjKIyrg6b4f0SIvfKnbhonEGFeBH3FGABhH
 cfrsq/jjowB6of0q3YtQMM0M4/qCoEvmDrChEnPUGelOpSfnR2jmJNo8lRK4c8EQQgm7
 tDiw==
X-Gm-Message-State: AOJu0Yxe3JLWnPTfUT/oj6n+UH6wYgFV/15gCBFJ0Qnv0dtH2NGODTik
 25tkWj47ji2ywQT/a2ksb5PfUERCM7otWWCCDPh2lL8knTy04P9tK6UnHrL/D4/QSO7MNOw4SrY
 8
X-Google-Smtp-Source: AGHT+IFddS14qV21gOsf1H9IKZKaKX68PFcz495f8Un2cn2QDQ/dWgSKElIdNQ1IosVwqALi5Mwj2w==
X-Received: by 2002:a05:622a:11c9:b0:445:9387:25f6 with SMTP id
 d75a77b69052e-44662e74a89mr131391501cf.50.1719945312578; 
 Tue, 02 Jul 2024 11:35:12 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:35:12 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 29/29] configs: enable MbedTLS as default setting
Date: Tue,  2 Jul 2024 11:23:05 -0700
Message-Id: <20240702182325.2904421-30-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702182325.2904421-1-raymond.mao@linaro.org>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
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
Changes in v3
- None.
Changes in v4
- removed the unused CONFIG_MBEDTLS_LIB_TLS.

 configs/qemu_arm64_defconfig | 4 ++++
 configs/sandbox_defconfig    | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 7e166f43908..9e2c490192c 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -67,4 +67,8 @@ CONFIG_TPM2_MMIO=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_SEMIHOSTING=y
+CONFIG_MBEDTLS_LIB=y
+CONFIG_MBEDTLS_LIB_CRYPTO=y
+CONFIG_MBEDTLS_LIB_X509=y
 CONFIG_TPM=y
+CONFIG_EFI_SECURE_BOOT=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 93b52f2de5c..679bbf69936 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -343,6 +343,9 @@ CONFIG_FS_CBFS=y
 CONFIG_FS_CRAMFS=y
 CONFIG_ADDR_MAP=y
 CONFIG_CMD_DHRYSTONE=y
+CONFIG_MBEDTLS_LIB=y
+CONFIG_MBEDTLS_LIB_CRYPTO=y
+CONFIG_MBEDTLS_LIB_X509=y
 CONFIG_ECDSA=y
 CONFIG_ECDSA_VERIFY=y
 CONFIG_TPM=y
-- 
2.25.1

