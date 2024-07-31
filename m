Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4874C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3690B88AC1;
	Wed, 31 Jul 2024 19:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P1H7H+wE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CB9288AD4; Wed, 31 Jul 2024 19:36:41 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5739A88910
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7a1d024f775so383315085a.2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722447398; x=1723052198; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ufPCFT1gvLQHP6KQxPaSX2yjKF376P07VNNf0n05Is=;
 b=P1H7H+wEPoO1tnU/vxsMuFjsU9ZhdycA8bo91cewGjWG8AJWSLpG3zfDSuzPRO0aHa
 8p4jlcwA56Jlp+vBDtToC2wFJTPW8fooob2uhJ/zuep8FY7SIawVaVglmHVtcHWv7zUi
 4JUH3cpUk0lTkj763nTZeklLvjzRBX1IZ2m9QydfS0Jf3rOcin/+URBBhOGC9D7X/E+n
 lFHn6UlHFNXkDElP/mvVNlEovHBGdxLbZeJLvOgqjrXNDkWChf/aWssHYWKjI8tYzhpn
 M4E9ocYFboH+Xe+kUc5ZD3gCNI/Ydmwlyo+2CwqmJsYZSGnqqiPFwStCyVqWQUWxm5TC
 5L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722447398; x=1723052198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ufPCFT1gvLQHP6KQxPaSX2yjKF376P07VNNf0n05Is=;
 b=FoFcR29zmM3CuIKmgFLwaCPD3DYcKWP0XIlwOE4V4m1U3blkhDkKrXQsidlL+RTnAg
 ZOwn5/yipj/4G9grBo4TBTxPgWRG+VU3mXJPFpRtikl2LpMsn4gDgoMgBb1pwAV3PVKt
 wOSfbXHxdo0u12i/7HVuZAbI65EV/lcS72NSsjcpofKDhswpsBPeqghYp6dyDeK7uf5b
 HWiUIpsaT/z5NBBUIp4O6dR5FkUNuHYEYjMvgcXnAIIdc74T25Gld2xjUTEJRa7T4y6z
 qAQZlPLXo/vWdeax2ija97GDWI0LoKsszxPuvAIvRNwtqTX6UcNawu0AnQ65c/hawgCh
 0gJw==
X-Gm-Message-State: AOJu0YxVAOWYtdnvnFrsI72lxodsbkyMdwZCTzUDJ1c/hhp2y9eaYRx5
 qV3EMipMYvaXs7oTVkJdpMKnE5sb8LMcn35obkDt0T0xgBq1MkIpmledQVn2e7g0Oxoe4WN9LgS
 /HmM=
X-Google-Smtp-Source: AGHT+IEesvE7dY/dHrLOt0eliVc9A90liOMr2I+109sSjkrFBI5ESud+IVYnK+cwl//8/L89PjCB9w==
X-Received: by 2002:a05:620a:4250:b0:79f:4b5:3696 with SMTP id
 af79cd13be357-7a1e52c823cmr1602955685a.56.1722447397909; 
 Wed, 31 Jul 2024 10:36:37 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d73b378fsm779452485a.37.2024.07.31.10.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:36:37 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v5 27/27] configs: enable MbedTLS as default setting
Date: Wed, 31 Jul 2024 10:25:37 -0700
Message-Id: <20240731172556.1348487-28-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240731172556.1348487-1-raymond.mao@linaro.org>
References: <20240731172556.1348487-1-raymond.mao@linaro.org>
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
- None.
Changes in v5
- Remove unused config MBEDTLS_LIB_TLS.
- Remove EFI_SECURE_BOOT from the default config.

 configs/qemu_arm64_defconfig | 3 +++
 configs/sandbox_defconfig    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 7e166f43908..22d38608842 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -67,4 +67,7 @@ CONFIG_TPM2_MMIO=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_SEMIHOSTING=y
+CONFIG_MBEDTLS_LIB=y
+CONFIG_MBEDTLS_LIB_CRYPTO=y
+CONFIG_MBEDTLS_LIB_X509=y
 CONFIG_TPM=y
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

