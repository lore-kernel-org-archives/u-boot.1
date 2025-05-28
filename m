Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C52BC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E05ED83A2A;
	Wed, 28 May 2025 14:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GzON0PHc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1387839D9; Wed, 28 May 2025 14:33:20 +0200 (CEST)
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 464E083986
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x142.google.com with SMTP id
 e9e14a558f8ab-3dca2473129so29059655ab.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435596; x=1749040396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ilqaLo8eSk85qVdLl1TKWklGQQWoSV1AQbkB5blD1s4=;
 b=GzON0PHcb17xb3S2OM9YGkeGUMingVysJQVowxXCawJAfaEYrqxCZBU9sz6g6LDWId
 TVDy9D76opmmYCWTUAjX3Djw7KcrvF41QPBQzZ1x/Eg9Ro3S9zn3c7y1zHYz6NCa2giU
 aJYJRmmvVrSQWJQJCrF/JcfKlJloxJIMUDhMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435596; x=1749040396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ilqaLo8eSk85qVdLl1TKWklGQQWoSV1AQbkB5blD1s4=;
 b=QRqnOhNZe9tD/tNWpx0goLWeCggOHOh+HbQdpMAG7JJ8h36MuQ0lOD7nZ1jtpCgZ1c
 I5+a8jDoVo1YBoFnzgzYf8JHzCg22zn8+D+WhIIeJTp8yGX8JhG2J6vNFwcYZpB0Geo9
 zV6ded551bxqd1nN6n9ExcO6UDKidTJFrIUmfDt10Q6L3DeXxllxX/ehg1dBXGLUlHor
 6/yV1Hjg2Va0O+rzixVaZGqup7Jt5PsaAqHSt0oFreTyVfoqL46g/6xQsD2Ccm1xUYyf
 pAahuyyikZqN+ZdrFUIvsu4bVDO4S5eq3WTn1fzwQPrMwGJDjEmdHeRgFlZ+qgbDOGZM
 n0Vw==
X-Gm-Message-State: AOJu0Yw250jRGXolOKrY/tRhN350Rpg7WGiHmO9znP07l3CIJa2i21J1
 nVknE0xryUuNPYHlv5AEz4sbjskil6Pp2zfraxzflDIgnRaM3353n+rxTcHdLvyhX4daB9BM6xi
 dPS/g/uTvcm0=
X-Gm-Gg: ASbGnct2JB1SMGJ4/LhP5/wBxi5W0ZhHIAzBrOdc5C9I5l9vl6dFcw2s+OeRgdgZ8cH
 th1Ot4FBlmDGS2oQRCwEISfJFUGYVUw5GARbvfYaIJsUSq00PfwslLEBJuzSY1mm2Cxx+Qcc91t
 gfEf9PNHPf3Wh5BFVae2kOayMf5m0y0AdVRwVi6uhi0fATjnJkc/jayrxL3DaYdVVh3r/WntXau
 bMg60obBnHou+/B9Cdt/U85L5V1bao3mWjrJHZOdsrol8XIgL7REpVBOcv9/0f4v+xlZwXE4XOf
 SkgVxu+N3ngY2BIgzXugheqFGiGRecuc/T3nEnU5JdeE29o2bmPIQAZPNWyDF2wGGpmLVDKh8ZC
 SJxw4m3k5jk/K
X-Google-Smtp-Source: AGHT+IGL/fEzh3+ccZ9EESxUmn38tq3Kw2mjS7NiQmD2ILqfj30wNEi+wKTsK6x3noTWQ5LHelT81w==
X-Received: by 2002:a05:6e02:5:b0:3dc:8058:ddfc with SMTP id
 e9e14a558f8ab-3dc9b6f650amr178845095ab.11.1748435596401; 
 Wed, 28 May 2025 05:33:16 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:33:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Bin Meng <bmeng.cn@gmail.com>, Boyan Karatotev <boyan.karatotev@arm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Liya Huang <1425075683@qq.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v5 03/25] emulation: fdt: Allow using U-Boot's device tree
 with QEMU
Date: Wed, 28 May 2025 06:32:05 -0600
Message-ID: <20250528123236.1138632-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 May 2025 14:35:17 +0200
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

(no changes since v3)

Changes in v3:
- Add mention of QEMU_MANUAL_DTB in doc/
- Fix 'usiing' typo

Changes in v2:
- Add a new QEMU-specific Kconfig instead
- Move patch into the standard-passage series

 arch/arm/Kconfig                   |  2 +-
 board/emulation/common/Kconfig     | 12 ++++++++++++
 doc/develop/devicetree/dt_qemu.rst |  8 ++++++++
 dts/Kconfig                        |  9 +++++++--
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 79f60eb3f34..4ec25d590ed 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1080,7 +1080,7 @@ config ARCH_QEMU
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
index b452e2a997a..21056ac78db 100644
--- a/doc/develop/devicetree/dt_qemu.rst
+++ b/doc/develop/devicetree/dt_qemu.rst
@@ -53,3 +53,11 @@ You can then run qemu with the merged devicetree, e.g.::
 
 Note that there seems to be a bug in some versions of qemu where the output of
 dumpdtb does not quite match what is provided to U-Boot.
+
+It is also possible to enable CONFIG_QEMU_MANUAL_DTB so that U-Boot's devicetree
+is built as part of u-boot.bin and can potentially be supplied to QEMU.
+
+See also the
+`rejected QEMU patch <https://patchwork.kernel.org/project/qemu-devel/patch/20231117021840.117874-1-sjg@chromium.org>`_
+and
+`discussion <https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.256484-1-sjg@chromium.org>`_.
diff --git a/dts/Kconfig b/dts/Kconfig
index 6a5141b56e9..c544f948a15 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -197,8 +197,13 @@ config OF_HAS_PRIOR_STAGE
 	  development purposes, but it is not recommended, and likely will not
 	  even work, for production systems.
 
-	  Note: This option must be set in Kconfig and cannot be enabled or
-	  disabled in the board's defconfig file.
+	  Note: This option can be disabled for QEMU using QEMU_MANUAL_DTB thus
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

