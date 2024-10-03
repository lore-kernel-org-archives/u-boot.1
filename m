Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89767CFA745
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 05:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C839C890AD;
	Fri,  4 Oct 2024 06:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YfuBA6oD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D71288D7F; Fri,  4 Oct 2024 00:06:18 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DEFB88D94
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 00:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cb399056b4so11302616d6.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 15:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727993175; x=1728597975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NNNpZDhxGI6dxoYja7UkxJFzNuRudv341H/vEtfWniU=;
 b=YfuBA6oDccJGSJavI/VFoknMDIO+LycORI1W8ks3w1JpJ+vEtc4N6FoP/xFcRRw0lL
 TgO7m18mIl3iH5CQWRV9OHyjvNoMzgaPeBRykI6dSr28lleNPBevZuxIMd0eZYlJlSoe
 B5JT6PBi6QSLyZCaaasOY16fgWR2FH1rRp5hure0Uml+Fq/pSQcvf7/4m3kdzF0KeWpq
 tbSLEVsp92l4Ys+CYhvecNvz0nIx/SvgTfLBFZUCYCWTFqnr3+GHRybNKolsM4TRF4uK
 KwWNI3L/McXJ0ILtYxICm3CHJIiGqdG8bmd6uFqGbXOgIF0MlK3ELDkrOsBx9lG4szog
 cTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727993175; x=1728597975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NNNpZDhxGI6dxoYja7UkxJFzNuRudv341H/vEtfWniU=;
 b=Gx0LbEtDStRHoM4F3W8XBQtaHzAzrtmuKK2gug6Bdmp2AD66/Hdp06HgHVJGWHI2PZ
 35qnoYoNO5eoph0NUS21Mgae0gq5+uVd5nMejt5NAQEUSMYzLrSdlcIuqQsvw9B2Af1w
 gI8knIWI8xaOlMSW5vY5AYLMeiZXmn/wHNgnpzEaHCRoS/Nql+FUDmTLTIRvOaeJzF1H
 o7mTo7P94xB0jIfR1tM/W8Botg+d7T/D4hL6o1a2H9Q+gf4wkogt1q19OPTvHBlPZ522
 qpCG9P9zkVu5J4y7pllct4boyo2zOK94MbGmIcHYHO/VOp28aYLI0diA5W7GhoVxHQ4M
 bBBA==
X-Gm-Message-State: AOJu0YxAbogoA+fZ0B2ncrOawXYvD5eXd/WRcz1+Xod3aMayr+Gkn7m2
 3AXegRzEqpGeMIQ4ld0H+wA9McJCWjihNfrxIyrrViYzuWzqYI3g4Y3ffnN0CJZqB3wDex7HnML
 +
X-Google-Smtp-Source: AGHT+IGGzMSqpj987GOKDYGILzhRlGO2O2MeZNYVKopKQ3250xs0/QUT9a5eTPus6TdMZ7txxQMbIw==
X-Received: by 2002:a05:6214:588a:b0:6cb:5aa6:97a with SMTP id
 6a1803df08f44-6cb9a30ce97mr11829056d6.24.1727993175135; 
 Thu, 03 Oct 2024 15:06:15 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92ddf5c4sm9001541cf.18.2024.10.03.15.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 15:06:14 -0700 (PDT)
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
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sumit Garg <sumit.garg@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Marek Vasut <marex@denx.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v8 27/27] configs: enable MbedTLS as default setting
Date: Thu,  3 Oct 2024 14:50:40 -0700
Message-Id: <20241003215112.3103601-28-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003215112.3103601-1-raymond.mao@linaro.org>
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Oct 2024 06:57:18 +0200
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
Changes in v8
- None

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

