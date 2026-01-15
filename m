Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EACD4662F
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 22:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78D9B83966;
	Thu, 15 Jan 2026 23:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SOK1Tbev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09C2082BF2; Thu, 15 Jan 2026 23:28:42 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64DE380325
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 23:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-45c8984fac8so528131b6e.3
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 14:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768516118; x=1769120918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YKRVdoc3TscobKfz2sXrRcg2lgSUZJ8wU0RI7zBmDR8=;
 b=SOK1Tbevu84TZXAmmwS5fwwSHCN5+5cE0D68HnVIaUgVeIWrGMCVJtoqD1fimpeAdD
 wrBAdQoIEH8ML5smSF8AnRnzavZxMVrwueVf0yHERN1XKkcTqku4hOEo0MU+lJI5BSD/
 dGAVMa+PllUV28G2rbm6tm7bSMV6Wr2VWMiL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768516118; x=1769120918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YKRVdoc3TscobKfz2sXrRcg2lgSUZJ8wU0RI7zBmDR8=;
 b=hIud/JESCMWF9t31rDfmWxETKAgPfNeEGt4lRNEM0WccreI38OYIzMv4x0o0S/E6z4
 fxefWG01idasJ3oRGaHKBlQqfNdR+DSB5eKh78fCqFvPGWsXMcp5gZxKWFd2c6pBvJC+
 tO74qSIJNjmxHgBhy+ypQsUA0lB2rxmMSsFicC23pZbdGegi9gBWM7FHMuHWW2V9QWNA
 DQjPjsJmUliS5oZcfVFkRoZ0xlTuEUyu8o08QZLdtU0x/iD8N49fnee1Ztj9fz40BF9Q
 /wd2Gu7uyr5LoALGjjeE88oRfxSqSK0m7o9M4Pz2vMuQLghNdmYqEK3mfl/2XCAw3EHq
 qU4g==
X-Gm-Message-State: AOJu0Yw39BAPVOvMuIfG+J/GeGY+y29X2VfivjRUYCBfAM8zDcXk3q29
 i4d8evdcef7pb1rDb9zsIZgrCXFjfqXql5RqwCE6mAlmdsdh3eR9Rd5iT78O7OQYeQeW0ogYo+K
 M4r83G9w=
X-Gm-Gg: AY/fxX5YaAgnRadRgZyWNihmSWTM6rqXr4uEvcnbRVVkcjEpCElzErHxilY/jq+Brxx
 m8jmJYETcyvxmwBP28Jb/JbcdElVO4AyPRSw7p/qPQl9YXVFSf4XajBlFB65ahGURp7o9azlIsW
 acCQkhQoPw33dTKCiExXygzOPxXGO/toWsq75+OZc5XGHdkScHn/xMfsTFPdC94wz0WjQmmIXfh
 JqxGGPgpw5Yl8Png+w0jQ6xiBjU4a7EYXQ+9FtLFyj2f40nOAEBeM6b9GowtzbmXVigz8TYAEGJ
 PiiztsgkH2fMNH+ufbtUuWyVBSqBfvGsY9ozuGgBZ67AX+c1u+5D2Gwa+FJdm03pPhE7km+1Q6G
 kqNc8EHiLZmfim4EVGUFMlQTRu3V68sq4AIIkSBlrfngICc6/E5iC39YCFOvOPgtZkCi8alJwxn
 /RRhpnOtk+8AEDaBLdqaK5Wg6rAwd7bLWClvlVF0ETEmhZgovNh/H8ad+FTtEEhtJYvoz6GTxkn
 5GeYkuergNIApgmIBqjw5BVpqZ5qkhHrsBrs3/4A/V8mzMHo2Sg
X-Received: by 2002:a05:6808:1923:b0:453:30e5:5582 with SMTP id
 5614622812f47-45c9c1b9079mr521432b6e.47.1768516116979; 
 Thu, 15 Jan 2026 14:28:36 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2b5aaesm544074a34.31.2026.01.15.14.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 14:28:36 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, Joel Stanley <joel@jms.id.au>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH 02/10] arm: Update linker scripts to ensure appended device
 tree is aligned
Date: Thu, 15 Jan 2026 16:19:32 -0600
Message-ID: <20260115222828.3931345-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115222828.3931345-1-trini@konsulko.com>
References: <20260115222828.3931345-1-trini@konsulko.com>
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

With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
that we must have ALIGN(x) statements inside of a section to ensure that
padding is included and not simply that the linker address counter is
incremented. To that end, this patch:
- Expands some linker sections to be more readable when adding a second
  statement to the section.
- Aligns the final section before _end (for U-Boot) or
  _image_binary_end or __bss_end (for xPL phases) by 8-bytes by adding
  '. = ALIGN(8);' to the final section before the symbol.
- Ensure that we do have alignment by adding an ASSERT so that when not
  aligned we fail to link (and explain why).
- Remove now-spurious  '. = ALIGN(x);' statements that were intended to
  provide the above alignments.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
The only part of this I am only mostly rather than fully confident in is
having caught all cases of having SPL_SEPARATE_BSS being false. I
believe I have as the generic ARM SPL linker script enforces the BSS
ending with 8-byte alignment, and the point of the ASSERTs here is to
catch the case where the section we're adding the ALIGN to ends up being
empty and so that ALIGN would become useless.

Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Adam Ford <aford173@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Stefano Babic <sbabic@nabladev.com>
---
 arch/arm/cpu/arm1136/u-boot-spl.lds            | 8 ++++++--
 arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds      | 5 ++++-
 arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds    | 5 ++++-
 arch/arm/cpu/armv7/sunxi/u-boot-spl.lds        | 5 ++++-
 arch/arm/cpu/armv8/u-boot-spl.lds              | 4 +++-
 arch/arm/cpu/armv8/u-boot.lds                  | 2 ++
 arch/arm/cpu/u-boot-spl.lds                    | 5 ++++-
 arch/arm/cpu/u-boot.lds                        | 4 ++++
 arch/arm/mach-aspeed/ast2600/u-boot-spl.lds    | 4 ++++
 arch/arm/mach-at91/arm926ejs/u-boot-spl.lds    | 9 +++++++--
 arch/arm/mach-at91/armv7/u-boot-spl.lds        | 9 +++++++--
 arch/arm/mach-omap2/u-boot-spl.lds             | 3 +++
 arch/arm/mach-rockchip/u-boot-tpl-v8.lds       | 5 ++++-
 arch/arm/mach-zynq/u-boot-spl.lds              | 6 ++++--
 arch/arm/mach-zynq/u-boot.lds                  | 3 +++
 board/davinci/da8xxevm/u-boot-spl-da850evm.lds | 4 ++++
 board/samsung/common/exynos-uboot-spl.lds      | 5 ++++-
 17 files changed, 71 insertions(+), 15 deletions(-)

diff --git a/arch/arm/cpu/arm1136/u-boot-spl.lds b/arch/arm/cpu/arm1136/u-boot-spl.lds
index b7af29183a97..22a9302275ae 100644
--- a/arch/arm/cpu/arm1136/u-boot-spl.lds
+++ b/arch/arm/cpu/arm1136/u-boot-spl.lds
@@ -30,8 +30,10 @@ SECTIONS
 	.rodata : { *(SORT_BY_ALIGNMENT(.rodata*)) } >.sram
 
 	. = ALIGN(4);
-	.data : { *(SORT_BY_ALIGNMENT(.data*)) } >.sram
-	. = ALIGN(4);
+	.data : {
+		*(SORT_BY_ALIGNMENT(.data*))
+		. = ALIGN(8);
+	} >.sram
 	__image_copy_end = .;
 	_end = .;
 
@@ -44,3 +46,5 @@ SECTIONS
 		__bss_end = .;
 	} >.sdram
 }
+
+ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
diff --git a/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds b/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
index 7c6309246f8b..b4adae272eba 100644
--- a/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
+++ b/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
@@ -45,7 +45,7 @@ SECTIONS
 		. = ALIGN(4);
 		__bss_start = .;
 		*(.bss*)
-		. = ALIGN(4);
+		. = ALIGN(8);
 		__bss_end = .;
 	}
 
@@ -62,3 +62,6 @@ SECTIONS
 	.gnu : { *(.gnu*) }
 	.ARM.exidx : { *(.ARM.exidx*) }
 }
+
+ASSERT(_image_binary_end % 8 == 0, \
+       "_image_binary_end must be 8-byte aligned for device tree");
diff --git a/arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds b/arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds
index cf65e8c46281..2225985c79c0 100644
--- a/arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds
+++ b/arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds
@@ -31,9 +31,9 @@ SECTIONS
 	. = ALIGN(4);
 	__u_boot_list : {
 		KEEP(*(SORT(__u_boot_list*)));
+		. = ALIGN(8);
 	} > .sram
 
-	. = ALIGN(4);
 	__image_copy_end = .;
 	_end = .;
 	_image_binary_end = .;
@@ -47,3 +47,6 @@ SECTIONS
 		__bss_end = .;
 	} > .sdram
 }
+
+ASSERT(_image_binary_end % 8 == 0, \
+       "_image_binary_end must be 8-byte aligned for device tree");
diff --git a/arch/arm/cpu/armv7/sunxi/u-boot-spl.lds b/arch/arm/cpu/armv7/sunxi/u-boot-spl.lds
index fb7a789b28b8..e69291d8be6d 100644
--- a/arch/arm/cpu/armv7/sunxi/u-boot-spl.lds
+++ b/arch/arm/cpu/armv7/sunxi/u-boot-spl.lds
@@ -40,9 +40,9 @@ SECTIONS
 	. = ALIGN(4);
 	__u_boot_list : {
 		KEEP(*(SORT(__u_boot_list*)));
+		. = ALIGN(8);
 	} > .sram
 
-	. = ALIGN(4);
 	__image_copy_end = .;
 	_end = .;
 	_image_binary_end = .;
@@ -56,3 +56,6 @@ SECTIONS
 		__bss_end = .;
 	} > .sdram
 }
+
+ASSERT(_image_binary_end % 8 == 0, \
+       "_image_binary_end must be 8-byte aligned for device tree");
diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
index c4f83ec9cfc4..d9963846c4f4 100644
--- a/arch/arm/cpu/armv8/u-boot-spl.lds
+++ b/arch/arm/cpu/armv8/u-boot-spl.lds
@@ -52,9 +52,9 @@ SECTIONS
 	__u_boot_list : {
 		. = ALIGN(8);
 		KEEP(*(SORT(__u_boot_list*)));
+		. = ALIGN(8);
 	} >.sram
 
-	. = ALIGN(8);
 	__image_copy_end = .;
 	_end = .;
 	_image_binary_end = .;
@@ -89,5 +89,7 @@ SECTIONS
 #endif
 }
 
+ASSERT(_image_binary_end % 8 == 0, \
+       "_image_binary_end must be 8-byte aligned for device tree");
 ASSERT(ADDR(.bss) % 8 == 0, \
        ".bss must be 8-byte aligned");
diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
index f4ce98c82c8d..704e0bf9468d 100644
--- a/arch/arm/cpu/armv8/u-boot.lds
+++ b/arch/arm/cpu/armv8/u-boot.lds
@@ -175,3 +175,5 @@ SECTIONS
 #include "linux-kernel-image-header-vars.h"
 #endif
 }
+
+ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
index 5aecb61ce902..d780a5060774 100644
--- a/arch/arm/cpu/u-boot-spl.lds
+++ b/arch/arm/cpu/u-boot-spl.lds
@@ -51,9 +51,9 @@ SECTIONS
 		__rel_dyn_start = .;
 		*(.rel*)
 		__rel_dyn_end = .;
+		. = ALIGN(8);
 	}
 
-	. = ALIGN(8);
 	_image_binary_end = .;
 	_end = .;
 
@@ -80,6 +80,9 @@ ASSERT(__image_copy_end - __image_copy_start <= (IMAGE_MAX_SIZE), \
 	"SPL image too big");
 #endif
 
+ASSERT(_image_binary_end % 8 == 0, \
+       "_image_binary_end must be 8-byte aligned for device tree");
+
 #if defined(CONFIG_SPL_BSS_MAX_SIZE)
 ASSERT(__bss_end - __bss_start <= (CONFIG_SPL_BSS_MAX_SIZE), \
 	"SPL image BSS too big");
diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index 78aad093d3b2..8e2266a90fe2 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -164,6 +164,7 @@ SECTIONS
 		__rel_dyn_start = .;
 		*(.rel*)
 		__rel_dyn_end = .;
+		. = ALIGN(8);
 	}
 
 	_end = .;
@@ -192,3 +193,6 @@ SECTIONS
 	/DISCARD/ : { *(.ARM.exidx*) }
 	/DISCARD/ : { *(.gnu.linkonce.armexidx.*) }
 }
+
+ASSERT(_image_binary_end % 8 == 0, \
+       "_image_binary_end must be 8-byte aligned for device tree");
diff --git a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
index 9502a7384b53..c9664a6ce566 100644
--- a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
+++ b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
@@ -59,6 +59,7 @@ SECTIONS
 		__rel_dyn_start = .;
 		*(.rel*)
 		__rel_dyn_end = .;
+		. = ALIGN(8);
 	} > .nor
 
 	_end = .;
@@ -79,6 +80,9 @@ ASSERT(__image_copy_end - __image_copy_start <= (IMAGE_MAX_SIZE), \
 	"SPL image too big");
 #endif
 
+ASSERT(_image_binary_end % 8 == 0, \
+       "_image_binary_end must be 8-byte aligned for device tree");
+
 #if defined(CONFIG_SPL_BSS_MAX_SIZE)
 ASSERT(__bss_end - __bss_start <= (CONFIG_SPL_BSS_MAX_SIZE), \
 	"SPL image BSS too big");
diff --git a/arch/arm/mach-at91/arm926ejs/u-boot-spl.lds b/arch/arm/mach-at91/arm926ejs/u-boot-spl.lds
index 09cf838cf96e..1af4f7b6524c 100644
--- a/arch/arm/mach-at91/arm926ejs/u-boot-spl.lds
+++ b/arch/arm/mach-at91/arm926ejs/u-boot-spl.lds
@@ -29,9 +29,11 @@ SECTIONS
 	.data : { *(SORT_BY_ALIGNMENT(.data*)) } >.sram
 
 	. = ALIGN(4);
-	__u_boot_list : { KEEP(*(SORT(__u_boot_list*))) } > .sram
+	__u_boot_list : {
+		KEEP(*(SORT(__u_boot_list*)))
+		. = ALIGN(8);
+	} > .sram
 
-	. = ALIGN(4);
 	__image_copy_end = .;
 	_end = .;
 	_image_binary_end = .;
@@ -51,6 +53,9 @@ ASSERT(__image_copy_end - __start <= (IMAGE_MAX_SIZE), \
 	"SPL image too big");
 #endif
 
+ASSERT(_image_binary_end % 8 == 0, \
+       "_image_binary_end must be 8-byte aligned for device tree");
+
 #if defined(CONFIG_SPL_BSS_MAX_SIZE)
 ASSERT(__bss_end - __bss_start <= (CONFIG_SPL_BSS_MAX_SIZE), \
 	"SPL image BSS too big");
diff --git a/arch/arm/mach-at91/armv7/u-boot-spl.lds b/arch/arm/mach-at91/armv7/u-boot-spl.lds
index 460a91d93ec4..287764df48ff 100644
--- a/arch/arm/mach-at91/armv7/u-boot-spl.lds
+++ b/arch/arm/mach-at91/armv7/u-boot-spl.lds
@@ -36,9 +36,11 @@ SECTIONS
 	.data : { *(SORT_BY_ALIGNMENT(.data*)) } >.sram
 
 	. = ALIGN(4);
-	__u_boot_list : { KEEP(*(SORT(__u_boot_list*))) } > .sram
+	__u_boot_list : {
+		KEEP(*(SORT(__u_boot_list*)))
+		. = ALIGN(8);
+	} > .sram
 
-	. = ALIGN(4);
 	__image_copy_end = .;
 	_end = .;
 	_image_binary_end = .;
@@ -52,3 +54,6 @@ SECTIONS
 		__bss_end = .;
 	} >.sdram
 }
+
+ASSERT(_image_binary_end % 8 == 0, \
+       "_image_binary_end must be 8-byte aligned for device tree");
diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/mach-omap2/u-boot-spl.lds
index 5ad169a37b73..86ab692ae390 100644
--- a/arch/arm/mach-omap2/u-boot-spl.lds
+++ b/arch/arm/mach-omap2/u-boot-spl.lds
@@ -55,3 +55,6 @@ SECTIONS
 		__bss_end = .;
 	} >.sdram
 }
+
+ASSERT(_image_binary_end % 8 == 0, \
+       "_image_binary_end must be 8-byte aligned for device tree");
diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
index 958a1b70aefe..2c0f5c3e5f32 100644
--- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
+++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
@@ -42,9 +42,9 @@ SECTIONS
 	__u_boot_list : {
 		. = ALIGN(8);
 		KEEP(*(SORT(__u_boot_list*)));
+		. = ALIGN(8);
 	}
 
-	. = ALIGN(8);
 	__image_copy_end = .;
 	_end = .;
 	_image_binary_end = .;
@@ -69,6 +69,9 @@ ASSERT(__image_copy_end - __image_copy_start < (CONFIG_TPL_MAX_SIZE), \
 	"TPL image too big");
 #endif
 
+ASSERT(_image_binary_end % 8 == 0, \
+       "_image_binary_end must be 8-byte aligned for device tree");
+
 #if defined(CONFIG_TPL_BSS_MAX_SIZE)
 ASSERT(__bss_end - __bss_start < (CONFIG_TPL_BSS_MAX_SIZE), \
 	"TPL image BSS too big");
diff --git a/arch/arm/mach-zynq/u-boot-spl.lds b/arch/arm/mach-zynq/u-boot-spl.lds
index d96a57702886..17f0d7c9b72f 100644
--- a/arch/arm/mach-zynq/u-boot-spl.lds
+++ b/arch/arm/mach-zynq/u-boot-spl.lds
@@ -39,10 +39,9 @@ SECTIONS
 	. = ALIGN(4);
 	__u_boot_list : {
 		KEEP(*(SORT(__u_boot_list*)));
+		. = ALIGN(8);
 	} > .sram
 
-	. = ALIGN(4);
-
 	_image_binary_end = .;
 
 	_end = .;
@@ -62,3 +61,6 @@ SECTIONS
 	/DISCARD/ : { *(.interp*) }
 	/DISCARD/ : { *(.gnu*) }
 }
+
+ASSERT(_image_binary_end % 8 == 0, \
+       "_image_binary_end must be 8-byte aligned for device tree");
diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
index f52523edf490..2a8e3399e0bf 100644
--- a/arch/arm/mach-zynq/u-boot.lds
+++ b/arch/arm/mach-zynq/u-boot.lds
@@ -66,6 +66,7 @@ SECTIONS
 		__rel_dyn_start = .;
 		*(.rel*)
 		__rel_dyn_end = .;
+		. = ALIGN(8);
 	}
 
 	_end = .;
@@ -98,3 +99,5 @@ SECTIONS
 	/DISCARD/ : { *(.ARM.exidx*) }
 	/DISCARD/ : { *(.gnu.linkonce.armexidx.*) }
 }
+
+ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
diff --git a/board/davinci/da8xxevm/u-boot-spl-da850evm.lds b/board/davinci/da8xxevm/u-boot-spl-da850evm.lds
index 56d6f4f114b9..d1a82e118af1 100644
--- a/board/davinci/da8xxevm/u-boot-spl-da850evm.lds
+++ b/board/davinci/da8xxevm/u-boot-spl-da850evm.lds
@@ -43,6 +43,7 @@ SECTIONS
 		__rel_dyn_start = .;
 		*(.rel*)
 		__rel_dyn_end = .;
+		. = ALIGN(8);
 	} >.sram
 
 	__image_copy_end = .;
@@ -58,3 +59,6 @@ SECTIONS
 		__bss_end = .;
 	} >.sdram
 }
+
+ASSERT(_image_binary_end % 8 == 0, \
+       "_image_binary_end must be 8-byte aligned for device tree");
diff --git a/board/samsung/common/exynos-uboot-spl.lds b/board/samsung/common/exynos-uboot-spl.lds
index 9d3b57e98dbb..62e150bcf335 100644
--- a/board/samsung/common/exynos-uboot-spl.lds
+++ b/board/samsung/common/exynos-uboot-spl.lds
@@ -48,7 +48,10 @@ SECTIONS
 		. = ALIGN(4);
 		__bss_start = .;
 		*(.bss*)
-		. = ALIGN(4);
+		. = ALIGN(8);
 		__bss_end = .;
 	} >.sram
 }
+
+ASSERT(__bss_end % 8 == 0, \
+       "__bss_end must be 8-byte aligned for device tree");
-- 
2.43.0

