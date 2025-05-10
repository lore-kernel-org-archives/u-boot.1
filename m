Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF46C3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7B168295C;
	Sat, 10 May 2025 15:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GMnZ8VBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1511E82952; Sat, 10 May 2025 15:43:28 +0200 (CEST)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3015826AA
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-ad243cdbe98so18728666b.0
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746884604; x=1747489404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9awAucTQ1/yAQt4kOfiGWWaYMsYazroyDswhr4Q41D0=;
 b=GMnZ8VBsqt5OMXzdzjO0Yw54+fw0SaOm2wYhnMZuDoAJPPeN51ck2OVpy7zAne0kAT
 AtgSDC/rq8jyLWMZ9a0/RO53NuQKrUjrgnB6wtRX0wZd6WxnShxzbOH9SByFAgYMaimU
 /ygNx0AS1H92E/xDqyzHBkxhCnDCB0Q3SwIZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746884604; x=1747489404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9awAucTQ1/yAQt4kOfiGWWaYMsYazroyDswhr4Q41D0=;
 b=dqahIQLbLWtic6FhDrCG9j5n2rNLo3EmRdK5dCoEymYPofU5t2RbE6p5ybjA4dCPqC
 z+SeeJytTz2bEzMO0HJGIeqwQXM6PLEKjDqM6e0HAjhDaN6lIkwUuQO/oSO0Q0c2xNxp
 T34Z4d0RtE7YpOOO177MTQftMlnA5oMivKwtZqytByhYswAtNkyzUs8/VptMzBWculPe
 246hWo2iptTHEhan2m+IL3JZIwG3BB0P6+GlXAhjAleI1UC46bDyvX+gTinfXh2bM3AF
 F7ch/ypQsiZEodwbLmLzT8QeDvLQ63xMAs4ekQcj9F7kru5tzHGoiBcNqz3iFm3D4A3b
 zzQw==
X-Gm-Message-State: AOJu0YyvW/yFMWnwnnZguFHqD28x7eJHk1cQiKoX0kNcWsKod7XFCgwH
 v5ZIhE+DSB/IDNUXLTGp9znOy/Z0edklMkRfCN4eigZJH30ymHInb4nUjOkMtxEJ1fuR0/r/Ala
 SVa6CwSTRjauk
X-Gm-Gg: ASbGncsae00Cm7eZTZyAMUjWmS8x17IBC5hR21ACYoRn/L+iDkgc4tDGzvlmxWqE8D4
 cexWpLuS84DxyfMzFcFcXRHbjKTao1v+UggvQCrjDLAdnEwhXFEwMulfOFHJ44+R+F4l9FM7M4t
 wFbS9u8n+MZvgK/16Obn1LeeWVBCoJqg1K+NJrQP3nZqyqYR4u7w2WcuKvmh01QJFDCoMA+SqhD
 ptVtbZqxsed6NL9VHlD1FT+5noWxJlbaQRI4X6qVQAic9RcZdWhPvwSv5KSnEAFqNuJEOQlz/SO
 wtITQeYtbTr+IcCZefX/U/Ond4iOkorz3Uv/hbIfaMl1cj9sWwucd86+pAusNDPZjmJK
X-Google-Smtp-Source: AGHT+IGPXh3kgJlT2ZNFp3oU/+3dxEhDONESZYnsJ1S/3e3LWaEJgGmN43MGwbYCMJiGf9KBHihrtQ==
X-Received: by 2002:a17:907:8749:b0:ac3:4139:9346 with SMTP id
 a640c23a62f3a-ad218e3f640mr583901466b.9.1746884604091; 
 Sat, 10 May 2025 06:43:24 -0700 (PDT)
Received: from chromium.org (82-132-222-17.dab.02.net. [82.132.222.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219747028sm319763866b.106.2025.05.10.06.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:43:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Graf <agraf@csgraf.de>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Liya Huang <1425075683@qq.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v4 01/22] emulation: fdt: Allow using U-Boot's device tree
 with QEMU
Date: Sat, 10 May 2025 15:41:59 +0200
Message-ID: <20250510134253.1581164-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510134253.1581164-1-sjg@chromium.org>
References: <20250510134253.1581164-1-sjg@chromium.org>
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
index fedfdb21457..2c7ff840444 100644
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

