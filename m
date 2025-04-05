Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2F8C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 19:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3CF68215B;
	Sat,  5 Apr 2025 21:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JdZAjmx5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB77D82A76; Sat,  5 Apr 2025 21:07:58 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3561981F45
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 21:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-739be717eddso2364530b3a.2
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743880074; x=1744484874; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q66nu4s6Tj2ZV6J9S/zgW1UkE0Kc7fCaZoXzGTXAIPg=;
 b=JdZAjmx5pIxx07asRkxlAiYYiu5zUhwjEgI2wdja4s6/Fdz4xg5r60gFCGAsY+Nvda
 JDwYW5vhQtvMx8czxx5IEfxs6z/54K0AGzAlJb6jmp3Zlx4aFQSNQ0YKR6aTiWjxn1Ii
 bgC9AeyCEowGR4k7k6dn+PWFJ7sXusp620Psk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743880074; x=1744484874;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q66nu4s6Tj2ZV6J9S/zgW1UkE0Kc7fCaZoXzGTXAIPg=;
 b=d0+bMrA1HK5EHXgYB462kVQTiNqoPO4N0lcXJnMuthiZlZWXiICr185CBZETgdKcg6
 07yA+Qg8bzdZ7LKU5RosQXsG/Hu21QpviZJFEVPSfoU2GnWXJq0Be5Uxv3JMguMwmOEE
 VL4nwh27+pxrsTxp6pZrdW2mWV1v2f66XRp0h/PYnrJZ8tqtR6OCsqcs00CpahBQpyVv
 pjrGXuIxuICSw2EZj0Hj4sassTFoF5b6QYFpd8T0VftX4kyqVMflO9gSyWDv6rkKpzAx
 S1YHuA2Na0zQ4e/YY8oAOnqw5jsmcyAk4rl4tVxoheeJv62FXHtXMh9TZy+HGDc7BrUf
 Ktyg==
X-Gm-Message-State: AOJu0YzYCAMD0Nqct76cVarr/WffNFsPwgjZNhQTrK2YMTqmbqqXdKB5
 M+0BiW3B/ztwf8lKZ+UDOvNonESC7IdZS7v81uE9YsrpuwitqnZfLcWamWe1JTiaH2/EshuhK97
 8Zg==
X-Gm-Gg: ASbGncteMVJrmcofIsjOMhxQvLhyUhbb/vjFgXZwKMunD2LbFrB/axXOBQMJmG+5I9l
 L1Sa1DI8mXFzJlCdc3vPHZYEV+UbS0fMa0wEowYUyIkINsMBdx86j8o5V3NnhpC4fO53uwX2mJo
 C01/e28lDLWqM0SEIXRE+/6R2tAoXv3rDN42uUVwV1+2C0IUXh/JcUn0y47z/5j7a8GlAsv3B72
 i9xgGCUVPbUpuqE8UKwYR30lzBMPZmHLixUDQNl/wc1rcEl2YYm4Q+ogSR06T5oqIb3kFm4WgGL
 9p/beiK19jjG62pmn/cH5WgF/Jx4z2zPyhC5GTYzENo=
X-Google-Smtp-Source: AGHT+IFnKWPhzSU1sdupfiruvNcloKcu6EQTyfOcalLJdPTyTKw4MAcZ6ccwHcR11VltcNDWfmufIA==
X-Received: by 2002:a17:90b:2c84:b0:2fe:99cf:f566 with SMTP id
 98e67ed59e1d1-306af71af56mr4390667a91.13.1743880073986; 
 Sat, 05 Apr 2025 12:07:53 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057ca8768fsm5974081a91.27.2025.04.05.12.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 12:07:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Andrew Phelps <andrew.phelps@canonical.com>,
 Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v2] emulation: fdt: Allow using U-Boot's device tree with QEMU
Date: Sun,  6 Apr 2025 07:07:04 +1200
Message-ID: <20250405190711.365419-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

At present it is impossible to change the qemu_arm64 defconfig to
obtain a devicetree from the U-Boot build.

This is necessary for FIT validation, for example, where the signature
node must be compiled into U-Boot.

A proposed change to QEMU to allow device tree additions has been
blocked for several years. The only known workaround is to use QEMU's
dumpdtb option, merge in the signature node manually, disable
OF_HAS_PRIOR_STAGE and then start QEMU with special arguments. This is
complicated enough that it is documented in U-Boot[1].

Unfortunately the only way to disable OF_HAS_PRIOR_STAGE at present is
to hack the Kconfig.

Add a new QEMU_MANUAL_DTB Kconfig option which makes OF_HAS_PRIOR_STAGE
optional, thus avoiding needing to patch U-Boot to get this working.

This seems a clearer solution than just making OF_HAS_PRIOR_STAGE
visible, since that symbol is intended to be set automatically by each
platform.

[1] https://docs.u-boot.org/en/latest/develop/devicetree/dt_qemu.html
Link: https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.256484-1-sjg@chromium.org/#24481799

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Tom Rini <trini@konsulko.com>
---

Changes in v2:
- Add a new QEMU-specific Kconfig instead

 arch/arm/Kconfig                   |  2 +-
 board/emulation/common/Kconfig     | 12 ++++++++++++
 doc/develop/devicetree/dt_qemu.rst |  5 +++++
 dts/Kconfig                        |  9 +++++++--
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index db8758e6dfe..b55ed61894a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1055,7 +1055,7 @@ config ARCH_QEMU
 	imply DM_RNG
 	imply DM_RTC
 	imply RTC_PL031
-	imply OF_HAS_PRIOR_STAGE if !TARGET_QEMU_ARM_SBSA
+	imply OF_HAS_PRIOR_STAGE if !TARGET_QEMU_ARM_SBSA && !QEMU_MANUAL_DTB
 	imply VIDEO
 	imply VIDEO_BOCHS
 	imply SYS_WHITE_ON_BLACK
diff --git a/board/emulation/common/Kconfig b/board/emulation/common/Kconfig
index 4c15c8bcb89..3f9a6ea578f 100644
--- a/board/emulation/common/Kconfig
+++ b/board/emulation/common/Kconfig
@@ -13,3 +13,15 @@ config MTDPARTS_NOR1
 	help
 	  This define the partition of nor1 used to build mtparts dynamically
 	  for the u-boot env stored on nor1.
+
+config QEMU_MANUAL_DTB
+	bool "Manually provide a device tree to QEMU"
+	help
+	  For some use cases, such as FIT validation where a public key must be
+	  placed in U-Boot's device tree, we need to override the device tree
+	  that QEMU would normally provide to us.
+
+	  Note: this work-around is necessary since Linaro has blocked
+	  addition of a feature to support additions to the QEMU devicetree:
+
+	    Link: https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.256484-1-sjg@chromium.org/#24481799
diff --git a/doc/develop/devicetree/dt_qemu.rst b/doc/develop/devicetree/dt_qemu.rst
index 8ba2b225590..c693b49d3d4 100644
--- a/doc/develop/devicetree/dt_qemu.rst
+++ b/doc/develop/devicetree/dt_qemu.rst
@@ -46,3 +46,8 @@ You can then run qemu with the merged devicetree, e.g.::
 
 Note that there seems to be a bug in some versions of qemu where the output of
 dumpdtb does not quite match what is provided to U-Boot.
+
+See also the
+`rejected QEMU patch <https://patchwork.kernel.org/project/qemu-devel/patch/20231117021840.117874-1-sjg@chromium.org>`_
+and
+`discussion <https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.256484-1-sjg@chromium.org>`_.
diff --git a/dts/Kconfig b/dts/Kconfig
index 2e88d210bb8..53f7e246a80 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -205,8 +205,13 @@ config OF_HAS_PRIOR_STAGE
 	  development purposes, but it is not recommended, and likely will not
 	  even work, for production systems.
 
-	  Note: This option must be set in Kconfig and cannot be enabled or
-	  disabled in the board's defconfig file.
+	  Note: This option can be disabled for QEMU usiing QEMU_MANUAL_DTB thus
+	  allowing QEMU to support FIT validation, where the devicetree must
+	  include a public key.
+
+	  See also this for context:
+
+	  https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.256484-1-sjg@chromium.org/#24481799
 
 config OF_OMIT_DTB
 	bool "Omit the device tree output when building"
-- 
2.43.0

