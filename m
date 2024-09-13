Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F5CFC6186
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:09:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0EC288E6E;
	Sat, 14 Sep 2024 03:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vChbYZO4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D012F88706; Fri, 13 Sep 2024 18:16:50 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C64AC88DDA
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:16:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6c355155f8eso8698166d6.0
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726244207; x=1726849007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1DB0VVBIt9HYKKzlQlPk4oPA02bWyaeqj4LRU2tYKA=;
 b=vChbYZO4+0OpkEwSy8ALQIsQWinfKdGTwApsDjRHvaPHP+x4Jvy8RfUbX1DhtTiNMp
 s9dH98HUB1oi7J74S03Jg6UUXQmnVmz9SkY8GwL9d/yT42IzWFV5NfnFvquRJnXjYhJk
 DHbhe3wW/tNWhbJ2VW7E43MtG2+P8aeXmy5Tazu9RzYMWrLORgVzYkYD1IP7KK+j3G9a
 2k+ni5df3syJF7wxtJBKDh4SqVhDxrtMXuIQv81gpEnhx4tFGwT1MswO4TO50V130CS/
 Sx5mG/YXh37kOH4R5AiawzaMdYF9A+lyum5ualTOHA6rFmKwdCv3v1OMguK8BOlQtTzk
 Ut0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726244207; x=1726849007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f1DB0VVBIt9HYKKzlQlPk4oPA02bWyaeqj4LRU2tYKA=;
 b=LO3Gs0+Cm08ZoTaKon5ha4TN3vlHbfJMWgPyVhJNX3XjBjZEXtFcFwjU4w+wmQfy87
 rZuT/stvlK64jeMGd+dzdd2tb7flmW1oxqdOSsu7VMGFUfvtt8U+q9S9G0d0vUHAIWk2
 odbE++RZX33RezQRrNZiCqq+febaeJMVwWPsLcKq77n2nCgaKsj0bHSzO2zlPpWtEySJ
 IEZCN3lxQgEBAP1BkmZdwPyUqZgqH92n7zmBZ7vbGPQRbTJkJ2ubmQiAxrXgtjUgbe4t
 O4PvbVIIygjIvWf+t8vGr4JXiaSjbATshVQF62ehUiSv3NSuK22NotFvtV4z03EwBibi
 RpEg==
X-Gm-Message-State: AOJu0YwIe22vV9f674rWf1X/Y+vPdd/NBxy81gHgybbZW21gDs1UG9lI
 2OGVYyN82EP63pMba2rYZCTcRc/fE2p/FaTLzzst8baoTmjNUn1NON9syKDayr+LLLKzeCDHhtp
 v
X-Google-Smtp-Source: AGHT+IHsMRHYLW1xLyUUKd8zL8qBIPIXjymcVb0E0Lp0ANckJVgtR3vy0SYfDUtDRBmyvM0nAqkG2w==
X-Received: by 2002:a05:6214:5d0a:b0:6c3:5bc3:78d1 with SMTP id
 6a1803df08f44-6c57e234017mr50576826d6.43.1726244207448; 
 Fri, 13 Sep 2024 09:16:47 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:16:47 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Linus Walleij <linus.walleij@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 27/27] configs: enable MbedTLS as default setting
Date: Fri, 13 Sep 2024 09:03:44 -0700
Message-Id: <20240913160408.2199558-28-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913160408.2199558-1-raymond.mao@linaro.org>
References: <20240913160408.2199558-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Sep 2024 03:04:24 +0200
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

Enable MbedTLS as default setting for qemu arm64 and sandbox.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
Changes in v6
- Remove MBEDTLS_LIB_CRYPTO and MBEDTLS_LIB_X509.
Changes in v7
- None.

 configs/qemu_arm64_defconfig | 1 +
 configs/sandbox_defconfig    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 088ba39f18e..6d18a8571ca 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -68,5 +68,6 @@ CONFIG_TPM2_MMIO=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_SEMIHOSTING=y
+CONFIG_MBEDTLS_LIB=y
 CONFIG_TPM=y
 CONFIG_EFI_HTTP_BOOT=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index a50fbce8d06..0ecdeebb45f 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -345,6 +345,7 @@ CONFIG_FS_CBFS=y
 CONFIG_FS_CRAMFS=y
 CONFIG_ADDR_MAP=y
 CONFIG_CMD_DHRYSTONE=y
+CONFIG_MBEDTLS_LIB=y
 CONFIG_ECDSA=y
 CONFIG_ECDSA_VERIFY=y
 CONFIG_TPM=y
-- 
2.25.1

