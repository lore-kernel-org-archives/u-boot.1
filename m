Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629BCC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 10:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93A18833C7;
	Thu, 17 Jul 2025 12:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mu7hGLZF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06FE1833C8; Thu, 17 Jul 2025 12:53:07 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A93D383390
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 12:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prabhakar.csengg@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4560add6cd2so6813835e9.0
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 03:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752749584; x=1753354384; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Gv7m3362hEKcj0v+ILRwb3Va/zhKPVyF3omWQu0U51A=;
 b=mu7hGLZFwGWDaxA7YE+wr2POe48byfv63VOncJ8vZNAwtbNEvrSgDJDJHuIBVxpHGG
 6L1EP9RXh0TEgqQ1qE+Cavy6/zr2O48SYOurknwgAFFTwRdLlY7VP62Clkz+L9b+vR/I
 YXPzmGt3BSZQ7rhZ3KpMnO3fkWgdACoREyiRd1nZr5tq9oTO2iaQbRyo5ER/74tPE0fc
 fGIKBebsQXvB9HRaVA6SWdhiSoW0XV6STtCOkIx2lGcS2K6unvA1sKzoO2zw/4LGS2K5
 IIgxPfrojUb3p2vOMOq+X6dCEnW7Zbues0jtbR152ZTR5NLLNB6Uo0Nn/zojlO7Ar7wE
 umAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752749584; x=1753354384;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gv7m3362hEKcj0v+ILRwb3Va/zhKPVyF3omWQu0U51A=;
 b=sANfcGDroG8eK4xBkU8ssM++k0UKYj/nG3cqWayk085Lm22mifAe1A/EMtjYZzI3aa
 ffifKcFHOFsIZEayoGmP2CRQuXXwcRR7AIdGDQ6zzYygLwlWQpMLCyCF5k/nGI+YOmwB
 6kOs2eB/sQpiIdyiNStgn5NYZHPLeImsnqJA+fvMr7xxSqQY/5flCXqTSgWxljKmMzt0
 fTCOt2FNkLhSa5hqVFZEqDqTzbME9Gss6KUWJNcGV6vgwkkJwLAgg2d8vlhYQUli8MtE
 SbE3PbSyilrw9D7DksNqW7mmO6krjFef5beuFAlZ58PNCTZnQHYCu9/jpTEk9/H5rXqw
 2GFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8OCV+Kl+DBfzphgpJkbvcSfKAgJcAcftMoZ3+qtpbujdzGo+neiDxnd8Ba7601IigWYZUIPs=@lists.denx.de
X-Gm-Message-State: AOJu0YzjVBr3GiyYDxAt4UFSw5thQBUt/aO3ILrOpSjLNB6xBz7hUxMP
 TvvGzhPyA1eUC4nuzMR1ABqcKcTM9CmoLxcLg4mSvbjDes8WfgGX86kR
X-Gm-Gg: ASbGncsdU6vN6dpUT3MADJB/CaF/gNRFj6kkZOzV3slzZ3YWcqJ4yKxWYivggKz36rW
 V/3baxd9MzL89/k9AtiwvPyS834/TuYZHTv/7Uqwi7kcL9Ozh94FvuR7uCN1te+cfFS+6RGaZJk
 XRxqdi2SJVq4bFpk75aBY0+dU8NNEOQesWc42itt8Bx6ap6Rlw7EPb0u4HS6G4ET9sKcwXNY7V9
 /9NWRis2mkip4oHJQHKNx+W22gka/gyDaCoVRF8l/6VcCxDO+ngr0ot7sINUuLvQqaX3Jj2x37x
 17UtAVdT84hk1aQMuNat9XzrnnIbEgiMIQs8glYFttAbEwwKDLjajd+HSsyaSMUX8+HhrSlhSj0
 7IDhEH85TE5/+KQ1QwvLTFyWU9NZKWohF90MkfTobFijpwJkHNgDzJG2cmooU4DKeHekf5kwNJB
 zj1BdiRLU=
X-Google-Smtp-Source: AGHT+IHhQOLUbHC2tC2UB7Lx1hOGFCVttD9MbctuCzY2B8qSW6OZ43TP2Xu3W9VJVhIMA6jJBDKfEw==
X-Received: by 2002:a05:600c:1895:b0:456:1122:8342 with SMTP id
 5b1f17b1804b1-45634536373mr19782675e9.5.1752749583803; 
 Thu, 17 Jul 2025 03:53:03 -0700 (PDT)
Received: from iku.example.org (97e54365.skybroadband.com. [151.229.67.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e89bfecsm47451105e9.27.2025.07.17.03.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 03:53:03 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Adam Ford <aford173@gmail.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 "Cogent Embedded, Inc." <source@cogentembedded.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Chris Paterson <chris.paterson2@renesas.com>,
 Prabhakar <prabhakar.csengg@gmail.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2] configs: Remove redundant CONFIG_TEXT_BASE assignments for
 Renesas defconfigs
Date: Thu, 17 Jul 2025 11:52:59 +0100
Message-ID: <20250717105259.96548-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.50.1
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The Renesas board defconfigs explicitly set CONFIG_TEXT_BASE=0x50000000,
however U-Boot's POSITION_INDEPENDENT=y build default already places text
at 0x0. These hardcoded overrides are therefore unnecessary and will be
pruned automatically in upcoming resyncs.

Remove the CONFIG_TEXT_BASE lines from the following defconfigs:
  - hihope_rzg2_defconfig
  - r8a77970_eagle_defconfig
  - r8a77970_v3msk_defconfig
  - r8a77990_ebisu_defconfig
  - r8a77995_draak_defconfig
  - renesas_rzg2l_smarc_defconfig
  - rz2_beacon_defconfig
  - silinux_ek874_defconfig

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- Instead of setting CONFIG_TEXT_BASE=0x0, removed the line entirely
  as it is redundant and will be pruned in future resyncs.
- Updated commit message to clarify the reason for removal.
- Included renesas_rzg2l_smarc_defconfig
---
 configs/hihope_rzg2_defconfig         | 1 -
 configs/r8a77970_eagle_defconfig      | 1 -
 configs/r8a77970_v3msk_defconfig      | 1 -
 configs/r8a77990_ebisu_defconfig      | 1 -
 configs/r8a77995_draak_defconfig      | 1 -
 configs/renesas_rzg2l_smarc_defconfig | 1 -
 configs/rzg2_beacon_defconfig         | 1 -
 configs/silinux_ek874_defconfig       | 1 -
 8 files changed, 8 deletions(-)

diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defconfig
index f5bb28cb0c7..19fb14887c6 100644
--- a/configs/hihope_rzg2_defconfig
+++ b/configs/hihope_rzg2_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_TEXT_BASE=0x50000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a774a1-hihope-rzg2m-ex"
diff --git a/configs/r8a77970_eagle_defconfig b/configs/r8a77970_eagle_defconfig
index 4ab362f0d43..3734836fa61 100644
--- a/configs/r8a77970_eagle_defconfig
+++ b/configs/r8a77970_eagle_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x700000
diff --git a/configs/r8a77970_v3msk_defconfig b/configs/r8a77970_v3msk_defconfig
index 5ef81682caa..d3df0fd0baf 100644
--- a/configs/r8a77970_v3msk_defconfig
+++ b/configs/r8a77970_v3msk_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x700000
diff --git a/configs/r8a77990_ebisu_defconfig b/configs/r8a77990_ebisu_defconfig
index 414bfdebab1..7405f207612 100644
--- a/configs/r8a77990_ebisu_defconfig
+++ b/configs/r8a77990_ebisu_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
diff --git a/configs/r8a77995_draak_defconfig b/configs/r8a77995_draak_defconfig
index 12d92067de5..2d487722677 100644
--- a/configs/r8a77995_draak_defconfig
+++ b/configs/r8a77995_draak_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
diff --git a/configs/renesas_rzg2l_smarc_defconfig b/configs/renesas_rzg2l_smarc_defconfig
index e7c0a7e1eae..4730c76248b 100644
--- a/configs/renesas_rzg2l_smarc_defconfig
+++ b/configs/renesas_rzg2l_smarc_defconfig
@@ -3,7 +3,6 @@ CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_SYS_INIT_SP_BSS_OFFSET=1048576
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_RENESAS=y
-CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SYS_MALLOC_F_LEN=0x80000
 CONFIG_ENV_SIZE=0x20000
diff --git a/configs/rzg2_beacon_defconfig b/configs/rzg2_beacon_defconfig
index 0b91337b17b..d3f7061f04d 100644
--- a/configs/rzg2_beacon_defconfig
+++ b/configs/rzg2_beacon_defconfig
@@ -3,7 +3,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
-CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFE000
diff --git a/configs/silinux_ek874_defconfig b/configs/silinux_ek874_defconfig
index acdd1ad5205..af462d2086f 100644
--- a/configs/silinux_ek874_defconfig
+++ b/configs/silinux_ek874_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN3=y
 CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ARCH_CPU_INIT=y
-CONFIG_TEXT_BASE=0x50000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3F0000
-- 
2.50.1

