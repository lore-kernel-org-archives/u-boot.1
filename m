Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C4CC4829A
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 12:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82ED187E96;
	Sat, 10 Feb 2024 13:07:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="C/3CdfbF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19BB987E82; Sat, 10 Feb 2024 13:07:26 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59F1687E82
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 13:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a26fa294e56so240318566b.0
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 04:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707566842; x=1708171642; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eVesnW2IK/KX/TLf/6Io9qcB3JQvVmIJbvgwPKtxKT4=;
 b=C/3CdfbF1PapbHCFmbvxbQLZPupPTOfjnWkbwSF0IlNV+a0rSOAJrkOWwiGV1tXqZN
 Uam+lbDD+TQrfLVoKMQYPcDW+Fy+9L17kIaGS8tdT20t+oeZd8kzePty/YWBZWkUNUSk
 RCE6UsLQgGaQSGMQUv4+i7LNT/3XVcocFpwN1/RDiRcQKjUMGqvAiUIeeOdJpzEJ9QLq
 fSPorxuhY+GiThNAud5kVYHeDo7ey+xQrHpAoY3XNydnI6Utde9EaNwiQN3et3liXLYn
 V9V9PdR3sJ4cxVVrouwnF8ZUjh0YLNXmaTbon5O1R3snUx+cezlN0h/PL/Uot0VUKkqG
 vzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707566842; x=1708171642;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eVesnW2IK/KX/TLf/6Io9qcB3JQvVmIJbvgwPKtxKT4=;
 b=FDrquxAQEWZn2NUphS8EzyNGtLge6qp8OvHBBSMsNhRZ0tq8YBEOOsLXgBSU6dl3qo
 Z9awYDb0Dr9WPlgYMR/Wsa2lPJFnA5ic47Xs9oTOKIOvGnCrRL7yOz89ub66yisLLN7F
 7byZBm2va1uJUcyGznSaP7kJ1Iw7jiVdkMnocuAXzo1TDOfs1tQ7p90XZiJkSdtTgY4i
 +SUnbH8FdH/SvXB/r9IfpNRGOb6b2bp6USWiPu+uI+yKc5tIkdHVacgBKfMFE4gksgtL
 i/VyMvKmrqg6s6ZnuE0Mrrl4Figwte9ZbgGLGIFhMcwQBrfvS53awqZVOppURMKwGo+Z
 wCdw==
X-Gm-Message-State: AOJu0YyF4dPUN/g9Atr3LGgLkFJt2/RVe/cxq6qH6E0sd68jojR8Fp34
 vnsM5uLUOhGsKbNA85gEnNhN26eTeDid71Rh7OT9wnj/eZJAYwasADXGkaknNkh4QwJ+vJZeaOS
 xBYE=
X-Google-Smtp-Source: AGHT+IFwdg2vRHpdSs/dDzk/xWXdl9DZgeDPBSzEIwhMwnBnskFqSklLtzkIAoVlETEOi2lZ51dpfg==
X-Received: by 2002:a17:906:e8e:b0:a3b:d25d:ebb7 with SMTP id
 p14-20020a1709060e8e00b00a3bd25debb7mr1172107ejf.74.1707566841603; 
 Sat, 10 Feb 2024 04:07:21 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX8KjMDN7TIPFPAlkphKnTiSrGYLPcIzIqLBZPceogJBw2wHGAa10xy/2FL1ZuZzOpLrEdEf5h3yqeSa5TtYoX9Kol7ILROiLh1OGlqeRr9bIY4YIQlZT8XVGonEI8K+l3+RzCDmsMLsJgpA58872W5ghCFF/ZAEPjhYsqnA9D5Hei/auz5JEWYAJTppU+n4KtYCAoMrdunbzU4zZEVfCX7XF1DiV3MnMrrFUU1gr1s5cywVQN3vCzaWDYzkRGi64cgl4FhqXObFe4HcXe1jGaatr85stk=
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 tz3-20020a170907c78300b00a3c019e8e4dsm1241603ejc.76.2024.02.10.04.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Feb 2024 04:07:20 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Loic Poulain <loic.poulain@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Marc Zyngier <maz@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>,
 Simon Glass <sjg@chromium.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v1] armv8: crypto: SHA-512 using ARMv8 Crypto Extensions
Date: Sat, 10 Feb 2024 13:07:09 +0100
Message-Id: <20240210120709.938286-1-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
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

From: Igor Opaniuk <igor.opaniuk@gmail.com>

Add support for the SHA-512 Secure Hash Algorithm which uses ARMv8 Crypto
Extensions. The CPU should support ARMv8.2 instruction set and implement
SHA512H, SHA512H2, SHA512SU0, and SHA512SU1 instructions.

This information can be obtained from ID_AA64ISAR0_EL1 (AArch64 Instruction
Set Attribute Register 0), bits [15:12] should be 0b0010 [1], that
indicates support for SHA512* instructions in AArch64 state. As not all
ARMv8-base SoCs support that, ARMV8_CE_SHA512 is left disabled by
default for now.

Tested in QEMU for ARMv8 with compiled-in SHA-2 support.
Even on emulated cpu the hashing speed increase was visible:

With CE usage:
=> time hash sha512 0x40200000 0x2000000
Calculate hash
Calculate hash
sha512 for 40200000 ... 421fffff ==> 1aeae269f4eb7c37...

time: 0.215 seconds

Without CE usage:
=> time hash sha512 0x40200000 0x2000000
sha512 for 40200000 ... 421fffff ==> 1aeae269f4eb7c37...

time: 0.356 seconds

Real HW tests should provide much more improvement and objective results
with 10x speed increase at least.

The implementation is based on original implementation from Ard Biesheuvel in
Linux kernel [2]

[1] https://developer.arm.com/documentation/ddi0601/2023-12/AArch64-Registers/ID-AA64ISAR0-EL1--AArch64-Instruction-Set-Attribute-Register-0
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/crypto/sha2-ce-core.S

CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

 arch/arm/cpu/armv8/Kconfig          |   5 +
 arch/arm/cpu/armv8/Makefile         |   1 +
 arch/arm/cpu/armv8/sha512_ce_core.S | 210 ++++++++++++++++++++++++++++
 arch/arm/cpu/armv8/sha512_ce_glue.c |  20 +++
 lib/sha512.c                        |   6 +-
 5 files changed, 240 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/cpu/armv8/sha512_ce_core.S
 create mode 100644 arch/arm/cpu/armv8/sha512_ce_glue.c

diff --git a/arch/arm/cpu/armv8/Kconfig b/arch/arm/cpu/armv8/Kconfig
index 9f0fb369f7..fd5c26421b 100644
--- a/arch/arm/cpu/armv8/Kconfig
+++ b/arch/arm/cpu/armv8/Kconfig
@@ -204,6 +204,11 @@ config ARMV8_CE_SHA256
 	bool "SHA-256 digest algorithm (ARMv8 Crypto Extensions)"
 	default y if SHA256
 
+config ARMV8_CE_SHA512
+	bool "SHA-512 digest algorithm (ARMv8 Crypto Extensions)"
+	depends on SHA512
+	default n
+
 endif
 
 endif
diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index bba4f570db..3894f2bb2a 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -45,3 +45,4 @@ obj-$(CONFIG_TARGET_BCMNS3) += bcmns3/
 obj-$(CONFIG_XEN) += xen/
 obj-$(CONFIG_ARMV8_CE_SHA1) += sha1_ce_glue.o sha1_ce_core.o
 obj-$(CONFIG_ARMV8_CE_SHA256) += sha256_ce_glue.o sha256_ce_core.o
+obj-$(CONFIG_ARMV8_CE_SHA512) += sha512_ce_glue.o sha512_ce_core.o
\ No newline at end of file
diff --git a/arch/arm/cpu/armv8/sha512_ce_core.S b/arch/arm/cpu/armv8/sha512_ce_core.S
new file mode 100644
index 0000000000..906291f35b
--- /dev/null
+++ b/arch/arm/cpu/armv8/sha512_ce_core.S
@@ -0,0 +1,210 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * sha512-ce-core.S - core SHA-384/SHA-512 transform using v8 Crypto
+ * Extensions
+ *
+ * Copyright (C) 2018 Linaro Ltd <ard.biesheuvel@linaro.org>
+ * Copyright (C) 2024 Igor Opaniuk <igor.opaniuk@gmail.com>
+ */
+
+ #include <config.h>
+ #include <linux/linkage.h>
+ #include <asm/system.h>
+ #include <asm/macro.h>
+
+	.macro	adr_l, dst, sym
+	adrp	\dst, \sym
+	add	\dst, \dst, :lo12:\sym
+	.endm
+
+	.irp		b,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19
+	.set		.Lq\b, \b
+	.set		.Lv\b\().2d, \b
+	.endr
+
+	.macro		sha512h, rd, rn, rm
+	.inst		0xce608000 | .L\rd | (.L\rn << 5) | (.L\rm << 16)
+	.endm
+
+	.macro		sha512h2, rd, rn, rm
+	.inst		0xce608400 | .L\rd | (.L\rn << 5) | (.L\rm << 16)
+	.endm
+
+	.macro		sha512su0, rd, rn
+	.inst		0xcec08000 | .L\rd | (.L\rn << 5)
+	.endm
+
+	.macro		sha512su1, rd, rn, rm
+	.inst		0xce608800 | .L\rd | (.L\rn << 5) | (.L\rm << 16)
+	.endm
+
+	/*
+	 * The SHA-512 round constants
+	 */
+	.section	".rodata", "a"
+	.align		4
+.Lsha512_rcon:
+	.quad		0x428a2f98d728ae22, 0x7137449123ef65cd
+	.quad		0xb5c0fbcfec4d3b2f, 0xe9b5dba58189dbbc
+	.quad		0x3956c25bf348b538, 0x59f111f1b605d019
+	.quad		0x923f82a4af194f9b, 0xab1c5ed5da6d8118
+	.quad		0xd807aa98a3030242, 0x12835b0145706fbe
+	.quad		0x243185be4ee4b28c, 0x550c7dc3d5ffb4e2
+	.quad		0x72be5d74f27b896f, 0x80deb1fe3b1696b1
+	.quad		0x9bdc06a725c71235, 0xc19bf174cf692694
+	.quad		0xe49b69c19ef14ad2, 0xefbe4786384f25e3
+	.quad		0x0fc19dc68b8cd5b5, 0x240ca1cc77ac9c65
+	.quad		0x2de92c6f592b0275, 0x4a7484aa6ea6e483
+	.quad		0x5cb0a9dcbd41fbd4, 0x76f988da831153b5
+	.quad		0x983e5152ee66dfab, 0xa831c66d2db43210
+	.quad		0xb00327c898fb213f, 0xbf597fc7beef0ee4
+	.quad		0xc6e00bf33da88fc2, 0xd5a79147930aa725
+	.quad		0x06ca6351e003826f, 0x142929670a0e6e70
+	.quad		0x27b70a8546d22ffc, 0x2e1b21385c26c926
+	.quad		0x4d2c6dfc5ac42aed, 0x53380d139d95b3df
+	.quad		0x650a73548baf63de, 0x766a0abb3c77b2a8
+	.quad		0x81c2c92e47edaee6, 0x92722c851482353b
+	.quad		0xa2bfe8a14cf10364, 0xa81a664bbc423001
+	.quad		0xc24b8b70d0f89791, 0xc76c51a30654be30
+	.quad		0xd192e819d6ef5218, 0xd69906245565a910
+	.quad		0xf40e35855771202a, 0x106aa07032bbd1b8
+	.quad		0x19a4c116b8d2d0c8, 0x1e376c085141ab53
+	.quad		0x2748774cdf8eeb99, 0x34b0bcb5e19b48a8
+	.quad		0x391c0cb3c5c95a63, 0x4ed8aa4ae3418acb
+	.quad		0x5b9cca4f7763e373, 0x682e6ff3d6b2b8a3
+	.quad		0x748f82ee5defb2fc, 0x78a5636f43172f60
+	.quad		0x84c87814a1f0ab72, 0x8cc702081a6439ec
+	.quad		0x90befffa23631e28, 0xa4506cebde82bde9
+	.quad		0xbef9a3f7b2c67915, 0xc67178f2e372532b
+	.quad		0xca273eceea26619c, 0xd186b8c721c0c207
+	.quad		0xeada7dd6cde0eb1e, 0xf57d4f7fee6ed178
+	.quad		0x06f067aa72176fba, 0x0a637dc5a2c898a6
+	.quad		0x113f9804bef90dae, 0x1b710b35131c471b
+	.quad		0x28db77f523047d84, 0x32caab7b40c72493
+	.quad		0x3c9ebe0a15c9bebc, 0x431d67c49c100d4c
+	.quad		0x4cc5d4becb3e42b6, 0x597f299cfc657e2a
+	.quad		0x5fcb6fab3ad6faec, 0x6c44198c4a475817
+
+	.macro		dround, i0, i1, i2, i3, i4, rc0, rc1, in0, in1, in2, in3, in4
+	.ifnb		\rc1
+	ld1		{v\rc1\().2d}, [x4], #16
+	.endif
+	add		v5.2d, v\rc0\().2d, v\in0\().2d
+	ext		v6.16b, v\i2\().16b, v\i3\().16b, #8
+	ext		v5.16b, v5.16b, v5.16b, #8
+	ext		v7.16b, v\i1\().16b, v\i2\().16b, #8
+	add		v\i3\().2d, v\i3\().2d, v5.2d
+	.ifnb		\in1
+	ext		v5.16b, v\in3\().16b, v\in4\().16b, #8
+	sha512su0	v\in0\().2d, v\in1\().2d
+	.endif
+	sha512h		q\i3, q6, v7.2d
+	.ifnb		\in1
+	sha512su1	v\in0\().2d, v\in2\().2d, v5.2d
+	.endif
+	add		v\i4\().2d, v\i1\().2d, v\i3\().2d
+	sha512h2	q\i3, q\i1, v\i0\().2d
+	.endm
+
+	/*
+	 * void sha512_ce_transform(struct sha512_state *sst, u8 const *src,
+	 *			  int blocks)
+	 */
+	.text
+ENTRY(sha512_ce_transform)
+	/* load state */
+	ld1		{v8.2d-v11.2d}, [x0]
+
+	/* load first 4 round constants */
+	adr_l		x3, .Lsha512_rcon
+	ld1		{v20.2d-v23.2d}, [x3], #64
+
+	/* load input */
+0:	ld1		{v12.2d-v15.2d}, [x1], #64
+	ld1		{v16.2d-v19.2d}, [x1], #64
+	sub		w2, w2, #1
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+        rev64		v12.16b, v12.16b
+        rev64		v13.16b, v13.16b
+        rev64		v14.16b, v14.16b
+        rev64		v15.16b, v15.16b
+        rev64		v16.16b, v16.16b
+        rev64		v17.16b, v17.16b
+        rev64		v18.16b, v18.16b
+        rev64		v19.16b, v19.16b
+#endif
+	mov		x4, x3				// rc pointer
+
+	mov		v0.16b, v8.16b
+	mov		v1.16b, v9.16b
+	mov		v2.16b, v10.16b
+	mov		v3.16b, v11.16b
+
+	// v0  ab  cd  --  ef  gh  ab
+	// v1  cd  --  ef  gh  ab  cd
+	// v2  ef  gh  ab  cd  --  ef
+	// v3  gh  ab  cd  --  ef  gh
+	// v4  --  ef  gh  ab  cd  --
+
+	dround		0, 1, 2, 3, 4, 20, 24, 12, 13, 19, 16, 17
+	dround		3, 0, 4, 2, 1, 21, 25, 13, 14, 12, 17, 18
+	dround		2, 3, 1, 4, 0, 22, 26, 14, 15, 13, 18, 19
+	dround		4, 2, 0, 1, 3, 23, 27, 15, 16, 14, 19, 12
+	dround		1, 4, 3, 0, 2, 24, 28, 16, 17, 15, 12, 13
+
+	dround		0, 1, 2, 3, 4, 25, 29, 17, 18, 16, 13, 14
+	dround		3, 0, 4, 2, 1, 26, 30, 18, 19, 17, 14, 15
+	dround		2, 3, 1, 4, 0, 27, 31, 19, 12, 18, 15, 16
+	dround		4, 2, 0, 1, 3, 28, 24, 12, 13, 19, 16, 17
+	dround		1, 4, 3, 0, 2, 29, 25, 13, 14, 12, 17, 18
+
+	dround		0, 1, 2, 3, 4, 30, 26, 14, 15, 13, 18, 19
+	dround		3, 0, 4, 2, 1, 31, 27, 15, 16, 14, 19, 12
+	dround		2, 3, 1, 4, 0, 24, 28, 16, 17, 15, 12, 13
+	dround		4, 2, 0, 1, 3, 25, 29, 17, 18, 16, 13, 14
+	dround		1, 4, 3, 0, 2, 26, 30, 18, 19, 17, 14, 15
+
+	dround		0, 1, 2, 3, 4, 27, 31, 19, 12, 18, 15, 16
+	dround		3, 0, 4, 2, 1, 28, 24, 12, 13, 19, 16, 17
+	dround		2, 3, 1, 4, 0, 29, 25, 13, 14, 12, 17, 18
+	dround		4, 2, 0, 1, 3, 30, 26, 14, 15, 13, 18, 19
+	dround		1, 4, 3, 0, 2, 31, 27, 15, 16, 14, 19, 12
+
+	dround		0, 1, 2, 3, 4, 24, 28, 16, 17, 15, 12, 13
+	dround		3, 0, 4, 2, 1, 25, 29, 17, 18, 16, 13, 14
+	dround		2, 3, 1, 4, 0, 26, 30, 18, 19, 17, 14, 15
+	dround		4, 2, 0, 1, 3, 27, 31, 19, 12, 18, 15, 16
+	dround		1, 4, 3, 0, 2, 28, 24, 12, 13, 19, 16, 17
+
+	dround		0, 1, 2, 3, 4, 29, 25, 13, 14, 12, 17, 18
+	dround		3, 0, 4, 2, 1, 30, 26, 14, 15, 13, 18, 19
+	dround		2, 3, 1, 4, 0, 31, 27, 15, 16, 14, 19, 12
+	dround		4, 2, 0, 1, 3, 24, 28, 16, 17, 15, 12, 13
+	dround		1, 4, 3, 0, 2, 25, 29, 17, 18, 16, 13, 14
+
+	dround		0, 1, 2, 3, 4, 26, 30, 18, 19, 17, 14, 15
+	dround		3, 0, 4, 2, 1, 27, 31, 19, 12, 18, 15, 16
+	dround		2, 3, 1, 4, 0, 28, 24, 12
+	dround		4, 2, 0, 1, 3, 29, 25, 13
+	dround		1, 4, 3, 0, 2, 30, 26, 14
+
+	dround		0, 1, 2, 3, 4, 31, 27, 15
+	dround		3, 0, 4, 2, 1, 24,   , 16
+	dround		2, 3, 1, 4, 0, 25,   , 17
+	dround		4, 2, 0, 1, 3, 26,   , 18
+	dround		1, 4, 3, 0, 2, 27,   , 19
+
+	/* update state */
+	add		v8.2d, v8.2d, v0.2d
+	add		v9.2d, v9.2d, v1.2d
+	add		v10.2d, v10.2d, v2.2d
+	add		v11.2d, v11.2d, v3.2d
+
+	/* handled all input blocks? */
+	cbnz		w2, 0b
+
+	/* store new state */
+3:	st1		{v8.2d-v11.2d}, [x0]
+	mov		w0, w2
+	ret
+ENDPROC(sha512_ce_transform)
diff --git a/arch/arm/cpu/armv8/sha512_ce_glue.c b/arch/arm/cpu/armv8/sha512_ce_glue.c
new file mode 100644
index 0000000000..4db78c8efd
--- /dev/null
+++ b/arch/arm/cpu/armv8/sha512_ce_glue.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * sha512_ce_glue.c - SHA-512 secure hash using ARMv8 Crypto Extensions
+ *
+ * Copyright (C) 2024 Igor Opaniuk <igor.opaniuk@gmail.com>
+ */
+
+#include <u-boot/sha512.h>
+
+extern void sha512_ce_transform(u64 state[SHA512_SUM_LEN / 8], u8 const *src,
+				u32 blocks);
+
+void sha512_block_fn(sha512_context *ctx, const unsigned char *data,
+		     unsigned int blocks)
+{
+	if (!blocks)
+		return;
+
+	sha512_ce_transform(ctx->state, data, blocks);
+}
diff --git a/lib/sha512.c b/lib/sha512.c
index ffe2c5cd96..186ca4d2ca 100644
--- a/lib/sha512.c
+++ b/lib/sha512.c
@@ -16,6 +16,8 @@
 #include <compiler.h>
 #include <u-boot/sha512.h>
 
+#include <linux/compiler_attributes.h>
+
 const uint8_t sha384_der_prefix[SHA384_DER_LEN] = {
 	0x30, 0x41, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
 	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x02, 0x05,
@@ -187,8 +189,8 @@ sha512_transform(uint64_t *state, const uint8_t *input)
 	a = b = c = d = e = f = g = h = t1 = t2 = 0;
 }
 
-static void sha512_block_fn(sha512_context *sst, const uint8_t *src,
-				    int blocks)
+__weak void sha512_block_fn(sha512_context *sst, const uint8_t *src,
+			    int blocks)
 {
 	while (blocks--) {
 		sha512_transform(sst->state, src);
-- 
2.34.1

