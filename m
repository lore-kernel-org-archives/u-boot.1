Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D9DC77B7C
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 17:41:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33FE882E05;
	Mon, 23 Jun 2025 19:40:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UdgseabW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A61CA82E2D; Mon, 23 Jun 2025 19:40:34 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78AF382D60
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 19:40:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-311e46d38ddso3900623a91.0
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 10:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750700431; x=1751305231; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bJdbvAJTdCux1O1UCbj/ymnxkBwIwcSghIWNfEN3nPk=;
 b=UdgseabWC9yTwQNxXmWvtVVs4Rlmgs+nyoUc+sERqguDlZyaNPMV3nIl83o/MKkxiA
 0dvfTDXlCa8DUo4RhcdIp8DW9sSt3USwgXKtgKXxhV9y2r2bjHqel6d91ctBHQI3gtT5
 bmgnFFyTUGDT70Tad46Cqd5z9oMvpkJ+UNlxniN3TgQgpqFV80MzsEtxxybbJt85CvPl
 hT00teNRR80t6m0w0Qwu++Ut/90nRr3aaRIlSVlqsJfjOXreKzkD+vuWx3+6THuxiibW
 Vti8MmyPZPf8/T2AD2yXC76ugnJiaIKDtVs0AR4PJWjRtU8ocO+FecLVaeDR/62sh1rE
 FXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750700431; x=1751305231;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJdbvAJTdCux1O1UCbj/ymnxkBwIwcSghIWNfEN3nPk=;
 b=W0lhXFoo1B29eZy6bui4NfDGtTI4FEWsNcVpf/QevBd2CS/W79UMDiU4DBC/NIh+nx
 IM/dB5lxr0TDL2qNm4lfdDv27hSpDM3ApWc1vSx9Qo2Ep+wxmniYR0U52v3aBWih7Vhb
 /qMu+lYsWvFIIFCXSTuV1x8vK4SO+LVmPJheTxdFW6HSxTgVDT8yG1HvVyApDrRw5eve
 ZA2yLiSfndEyAidZ3izdN3kOwUcoyg3fzOaOTpU0w1zh8R82jN9ubKIi+zJE3GOIkn+z
 MbWErvytIpDj29uQu5bMwaMhvMBYf71I1IG7F3bZfTmksNJ0U5+wAyu/32cswZVVLU2v
 EjLg==
X-Gm-Message-State: AOJu0YzzSo6UNpS8OoczY0PAeSVj6/OW3HlCLTwPXDc7qZaEKGVndF3I
 kk8EQ92JWBrC8mv27WnihmUwXlFznsBDnKBSmx4czHWikjTHUdzuecZg/U2g4Usb
X-Gm-Gg: ASbGncs0Zxzpn+iTc48cahWjV/SHCSfy2V2z5jAxsYMp889bvit0iAieP0fSnI3m8Lq
 muQJaIdmMxBahUoUXi2CzGnrW3iQDQu81Fr2dLVh2GzihWc8rh3idDkeEVE3/BaVSfhlACanH0T
 vAKse7sTKWdxuN6QtKS3NzvZwlpIg3MJJiFg3dtqajHE9giVtc5K6gK6+GRbmKFnKTnbwURp6GB
 fs1jKcgccjtaPXld9vLs1R7ZzWAjHLy5OmFF5N9YeBawFGOjVz9iD+vJXYyKr7cnAYKLnw7s3R6
 zfO+Vg0Uym3Mli8DixWz9F420S2WSsHCyuNa3LQN7WUaU8gqNPbrwXtBes6STyvHDuE5Rm/c78I
 4Idp6
X-Google-Smtp-Source: AGHT+IF0DR1aRnz4FXcjAPjjB134nR3sguGtkEgVjxQae1n029d7I+BLgAUBRd6SoIyIYKQqoT/AYQ==
X-Received: by 2002:a17:90b:1fcc:b0:312:e76f:5213 with SMTP id
 98e67ed59e1d1-3159d8dbf30mr20928794a91.28.1750700430971; 
 Mon, 23 Jun 2025 10:40:30 -0700 (PDT)
Received: from [10.22.1.180] ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3159df8354bsm9465088a91.18.2025.06.23.10.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 10:40:30 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Date: Mon, 23 Jun 2025 14:39:57 -0300
Subject: [PATCH 4/4] board: toradex: verdin-am62p: Add fixup for critical
 trip points
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250623-am62p-fdt-fixup-trip-points-v1-4-12355eb6a72f@toradex.com>
References: <20250623-am62p-fdt-fixup-trip-points-v1-0-12355eb6a72f@toradex.com>
In-Reply-To: <20250623-am62p-fdt-fixup-trip-points-v1-0-12355eb6a72f@toradex.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
X-Mailer: b4 0.14.2
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

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

While TI AM62P supports up to 125°C junction temperature, Tj, for
industrial and automotive parts, Toradex Verdin-AM62P hardware lifetime
guarantees consider a 105°C Tj. Fixup the device tree temperature
critical trip points to match the hardware specifications. The
implementation ensures the architecture code will not overwrite the
board specific changes by enabling CONFIG_OF_BOARD_SETUP_EXTENDED for
the Verdin-AM62P.

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
---
 board/toradex/verdin-am62p/verdin-am62p.c | 8 ++++++++
 configs/verdin-am62p_a53_defconfig        | 1 +
 2 files changed, 9 insertions(+)

diff --git a/board/toradex/verdin-am62p/verdin-am62p.c b/board/toradex/verdin-am62p/verdin-am62p.c
index 8b246e9d304331047dee2073b3fc4c45eceb8ed1..43d1c9312fe309f8b12e0cb2f64447942402a14f 100644
--- a/board/toradex/verdin-am62p/verdin-am62p.c
+++ b/board/toradex/verdin-am62p/verdin-am62p.c
@@ -8,6 +8,7 @@
 
 #include <config.h>
 #include <asm/arch/hardware.h>
+#include <asm/arch/k3-common-fdt.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <dm/uclass.h>
@@ -97,6 +98,13 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_OF_BOARD_SETUP_EXTENDED)
+void ft_board_setup_ex(void *blob, struct bd_info *bd)
+{
+	fdt_fixup_thermal_critical_trips_k3(blob, 105);
+}
+#endif
+
 static void select_dt_from_module_version(void)
 {
 	char variant[32];
diff --git a/configs/verdin-am62p_a53_defconfig b/configs/verdin-am62p_a53_defconfig
index e782ad4faca78a0e7b171933461f145956cca3f0..e4a28050079b4dcce6778d1729c549d0e44e442f 100644
--- a/configs/verdin-am62p_a53_defconfig
+++ b/configs/verdin-am62p_a53_defconfig
@@ -37,6 +37,7 @@ CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_BOOTDELAY=1
+CONFIG_OF_BOARD_SETUP_EXTENDED=y
 CONFIG_BOOTCOMMAND="bootflow scan -b"
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile k3-am62p5-verdin-${variant}-${fdt_board}.dtb"

-- 
2.43.0

