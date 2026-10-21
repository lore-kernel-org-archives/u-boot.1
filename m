Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228A2606A325
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=N/XOqyHQ;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Q2rMrWO0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88B2660A5F;
	Wed, 21 Oct 2026 12:55:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pC_ZhnTTagDD; Wed, 21 Oct 2026 12:55:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E0905608D5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587316;
	b=PmsAzoXJYB/Vh0Kr4KGA8MzSDYTF88axNaXDU/mFNFbns0NJL0vnOLJii76GhR+Ngwqw
	 g9eCvlIPyPY1C57iTGgJYOazjQorgBe+dgJbZTQN18dlDBnh0799JTWer7qAUdikxXwA9
	 RGDGp6SbwE38EHdIAZjLUJUWapa6Rkf2W6jc+rBEHulOaq+ma5FR+CjKIUWeLGhh4RVXa
	 0cUuP4oG7OnGEIo1wCiuBPX9D7kVquItoWVn0ZFR9FtpSvqLcy17xbVCnKNJGdXvlk7iB
	 KRoa76B/66YvO2C1DZGSJXyhz2sRdxnIOXTEszMmw1qoKEvNguWdCQVoAWKdAML/Spw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587316;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CXDC7sOpiK1cA4ne04d7xLfDqLnJ3d13btuxdA05ubI=;
	b=QSeCsMYUhSfOrqhiggrYkGnL8o19d+W/pqg7at+mw8D1z9hzL9+Rt/hQypY6IpJ17V/w
	 iSnepiaumuU1uMkWoFi5EE76mjnC490aPxA4MFwMNhkVLnBLoOPPekKNghVdAh/lehwDJ
	 31fhxYfu424Ciue/DftZZoVWvUWy1pQ5VP9LvZjdSeC10rMtAbS8SOzYWZEgNSJ4wvgm+
	 nl0942YXFLsx/AjhPvsIX/7/1o7c+Ugek0Yt/V0aRgX5uEX9A0VfVykRpnhBW69vNLWYg
	 3aQ84nAqXNOY1mIm7O3fRX1KAyGIDdIalpw/Ie08D4GVrwITeEF9dFvuhZQqHd4prUA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587316;
	bh=CXDC7sOpiK1cA4ne04d7xLfDqLnJ3d13btuxdA05ubI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N/XOqyHQ+Tf5Wdu2PV8ZHFHAiuu5y6fBaBGopEDmOc3Mf5PccqFh0emVgWzWzZSzB
	 a/ytwGx0VcNOTdUBH1ft70YZmU6kypWzDApi9jvgfW1rJE4EvUFzsqfy5ZUg/pSFsd
	 8UnqQRTORhOfcRbYTijPqFQEjGDBDuCMJuJX4Asm5y/3SNlu9qLX0Gsr6vifRh1v8n
	 vD+THXPVIG8XOEgNTv0dbYhkNwOycEiE1dGFoMzHbcPueuiND2mOJ9lzzw2GiWPFXd
	 K37JBHxvCxksaK+REj4/+Lp/X5rBGDNHTjKIT15cEasag2ndTI/1jhH1MP/Pk0+7rw
	 oTxeo/pbZMrOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0905608D5;
	Wed, 21 Oct 2026 12:55:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E0D1F930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D25CB4084B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:55:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yc1pJAGYfs0g for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:55:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B10F44082D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::932"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792587314;
 b=g73HAYtmP2DGaxj7BBGo3jcd1VD13PT9T8gNBwtRXwugLUjDxo32Gtboscn5aiGVBGgG
 sUf3mbND5LEfc3qm6+VwGM/J3GHvVu0U+/0MRzYxVQ7RCebs3ou6FN955fOG60FLJ1HPX
 Pfg8LKYb/6JxxqL47aXZuHoRvNh0jdScL0XD/yvkwzt/mFn1ClYQPBB1Mtd3PDJuEW74q
 QafJFWnTo8AW9qpJ9DN7U6J4r3+336caqRM0FNYxM3Alnf1qDRrXTgnTPwTOCW/eWVgQH
 Z/ShtDcKeO9KcMx0fxTFCker9VxaNfqKxaMLdyFLT7cQvjIaAN+0fnCgD2w0xwmm9Yg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587314;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=CXDC7sOpiK1cA4ne04d7xLfDqLnJ3d13btuxdA05ubI=;
 b=tDESYMw/YdhUBEat0b4H/mSiQwJpJAR7saogKYdZRRCnwkEr7LpJXFDUXJEwSYB9T8Ej
 292Bn1A1pCXwxdZAZeY7R2/FjBP5gW527BP1FESZ+EHNzy4OxWMh0GE9zHFITaH2PGXCC
 X71oa3uFbwZTmuRyBiwl1tt7LewrOA9634GFyMju2WC4x1Kr7R91DfInV1v0X4LROr97o
 uqdeXhCqC5s2pmDVgJJEUAShQG4Gk8joxxgc/5MFEFeLdAcEl5cOKeFo+a7UxhKe3tyrS
 LdQuPdG6SjpCUiLrISCFB9BdBx+xvMwFGfcCrf3zVtQYK/mGm8rrNqmepM0ZvLnHIFA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Q2rMrWO0; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::932"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::932; helo=mail-ua1-x932.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Q2rMrWO0
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B10F44082D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:55:13 +0000 (UTC)
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-990703f817fso336306241.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792587312; x=1793192112;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CXDC7sOpiK1cA4ne04d7xLfDqLnJ3d13btuxdA05ubI=;
 b=Q2rMrWO0ilD3ARFNh6fo1KDnzorHn/CxSOKHoBD34MnFRg36a+gMplyMUvnUVtFJfC
 ltYwauq8AX9kJT1tgelL3qfoUYpyso3Tp8qfuI1CnBtsVUPYJpOvlICc6zStoZqYU89j
 zrICrRKKTen9fIM668z6481WljAjT9+jLwl3ur2GZnfuTQijwDJQAuonZhhUPw58FQ3g
 iQI7y1OX579RntiL4DTc5vuEctFzpB6v2NG+2wgmdVm268EFOeBg7+/diFhcIUk7jqs/
 QcxmQNk341Iu1klZE5thIt/CV1Sad5KnthEUelLJCImx8G/f9G/tOse9Ioecc6XupWTj
 hLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792587312; x=1793192112;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CXDC7sOpiK1cA4ne04d7xLfDqLnJ3d13btuxdA05ubI=;
 b=NLlhOfo1Bhjx6KKrRJkbAFWvbc/KgNAaoRtc/ru0U/Ee15iuilxdQMbIRsG2cqLmZ/
 NJIc8YlhfgYdn19HrUYPOr3hkpSKQD+/8KjzXlF0uHttKyO+9Htfo5F7tpAWSU/iwbz8
 fAWW2qz27PGjty2lR4P35IrSDmVmwe+lrcss/FVrmd0hzLsd00S6SBnXZ1PzKLo2AAwG
 NJQ2bahrgRchXRlguwrJIP78uElHo6zOdfMYcHgBKtBvkRqd5srE1+Gf6olqknALQw2q
 Oou88k1/+JGbvPRh9tmv7+QOnHUPknQeIN6IiN6OKdF4+/D2Zo+yfNdF54TDYRW7H8nB
 2+XQ==
X-Gm-Message-State: AFq9FYIHd2JEXVk6adaqPeeGJ0SZrx6pQW+U+D4/wA14LTAA5NAKf4HS
 KNm1ayratWNvdRqwj2Wj/FOVn8mOkG/Cgnv2vWvO+EWBMwtvMfJUnN17ot7nndmD1L8=
X-Gm-Gg: AYBFou3AmWa57ocxuU0RxbR7kFm8INjvPBhNZeUH9Z7F60sLywSUVZmbW7BBVHqoU/x
 zdUOQeM8NLKRQ9LBNMsG7RPLjOKNt2jKQoTnb6lg+VmXrSINF/XfoO8fWD7r6PYHZ17mD7CNLpg
 x6O3wrF4iwTzGfHLoiNK/fyn1i4aMYoSLNXtoQ2NzHMIffP+wxAyLxFIUQG3Z+G+pL2kezVa2Tl
 Zx3pMw+baIw4zyid1IKJ0QJjX7SrJFgAnqr1K5BxCLnFAfM6R+ZUrK0xL03ybTHdBKBPzZ+QEyk
 eFmlgL96Y5MIgxkpezdsjoPH4L/Eeeb4tJClMXsZPVrOt1efW1f/yL2Yam7sAK4hrfxHEXaucNY
 x2xDmDiwQcdaOFhGAXmALjsy2joK1HLRIdns7mSKtFarGGBlSaJCAJijBh/0gTXwJAqhG2zCnnr
 nLxa5XoBSM5MAP5MUEd8TMXP5KRQZaahamwzCMc/eQ9NkXcE5IA/JotA/y+0GfOekivA7AXDgM3
 Gil8bMiMRpYUvVyMMHVBPlfymgaRb03ebGdGpeLH5kuAVQAVK/6gidJuyRiMRfsrgI9m0XUD7gh
 lOwQwHDgjuUJQ5aamyE=
X-Received: by 2002:a05:6102:d87:b0:7b2:43df:ca51 with SMTP id
 ada2fe7eead31-7cc926e0d85mr732323137.27.1792587311560; 
 Wed, 21 Oct 2026 05:55:11 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:8bf0::33ca])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-990d0e0ba56sm3013863241.1.2026.10.21.05.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 05:55:11 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Wed, 21 Oct 2026 09:54:20 -0300
Subject: [PATCH 4/8] board: sophgo: milkv_duo: add SPL support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-milkv-duo-spl-v1-4-ee7618860237@baylibre.com>
References: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
In-Reply-To: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Kongyang Liu <seashell11234455@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Bin Liu <b-liu@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andrei Lalaev <andrey.lalaev@gmail.com>, Zhuxu Ran <zhuxu_ran@zohomail.com>, 
 Udit Kumar <u-kumar1@ti.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Wire up SPL for the Milk-V Duo so it no longer depends on the vendor
FSBL.

The SPL uses the BootROM ROMAPI to load the FIT image with OpenSBI,
U-Boot and the device tree, from offset 0x40000 of fip.bin.

The BootROM loads the SPL into the 100 KiB VC SRAM at 0x3bc00000 and
jumps past the 32-byte BL2 header, so SPL_TEXT_BASE is 0x3bc00020.
SPL_MAX_SIZE (0x13fe0) is exactly SPL_BSS_START_ADDR (0x3bc14000) minus
SPL_TEXT_BASE, so the SPL image cannot grow into its own BSS.
SPL_BSS_MAX_SIZE (0x1000) caps that 4 KiB BSS, ending at 0x3bc15000, and
SPL_STACK (0x3bc19000) is the end of the SRAM, leaving 16 KiB below it
for the stack, the pre-relocation malloc_f pool (SPL_SYS_MALLOC_F_LEN, 8
KiB) and the global data, as the generic SPL board_init_f flow expects.

In DRAM, SPL_OPENSBI_LOAD_ADDR (0x80000000) is the base of RAM: the
fixed link address OpenSBI's "generic" platform uses for fw_dynamic, and
the load address given to it in the FIT. SPL_CUSTOM_SYS_MALLOC_ADDR
(0x81000000) moves the SPL heap into DRAM once it is up, 16 MiB in,
clear of SYS_LOAD_ADDR (0x80080000), U-Boot's default load address, and
of TEXT_BASE (0x80200000).

SPL_SMP is disabled, as only one hart is brought up, and
SPL_OPENSBI_SCRATCH_OPTIONS is cleared so that OpenSBI prints its boot
banner, which the default (SBI_SCRATCH_NO_BOOT_PRINTS) hides.

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi  | 92 +++++++++++++++++++++++++++
 arch/riscv/include/asm/arch-cv1800b/rom_api.h | 36 +++++++++++
 board/sophgo/milkv_duo/Kconfig                |  5 ++
 board/sophgo/milkv_duo/MAINTAINERS            |  5 +-
 board/sophgo/milkv_duo/Makefile               |  1 +
 board/sophgo/milkv_duo/spl.c                  | 76 ++++++++++++++++++++++
 configs/milkv_duo_defconfig                   | 18 ++++++
 7 files changed, 232 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi b/arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi
new file mode 100644
index 00000000000..7f9a7a03c5d
--- /dev/null
+++ b/arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2026, Hiago De Franco <hfranco@baylibre.com>
+ */
+
+#include <config.h>
+
+/ {
+	binman {
+		filename = "fip.bin";
+
+		sophgo-cv18xx-fip {
+			u-boot-spl {
+			};
+		};
+
+		fit {
+			/* Keep in sync with CV18XX_ITB_OFFSET in spl.c */
+			offset = <0x40000>;
+			description = "OpenSBI and S-mode U-Boot";
+			#address-cells = <2>;
+			fit,fdt-list = "of-list";
+
+			images {
+				opensbi {
+					description = "OpenSBI fw_dynamic Firmware";
+					type = "firmware";
+					os = "opensbi";
+					arch = "riscv";
+					load = /bits/ 64 <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
+					entry = /bits/ 64 <CONFIG_SPL_OPENSBI_LOAD_ADDR>;
+
+					opensbi {
+						filename = "fw_dynamic.bin";
+						missing-msg = "opensbi";
+					};
+				};
+
+				uboot {
+					description = "U-Boot";
+					type = "standalone";
+					os = "U-Boot";
+					arch = "riscv";
+					compression = "none";
+					load = /bits/ 64 <CONFIG_TEXT_BASE>;
+
+					u-boot-nodtb {
+					};
+				};
+
+				@fdt-SEQ {
+					fit,operation = "gen-fdt-nodes";
+					description = "NAME";
+					type = "flat_dt";
+					compression = "none";
+				};
+			};
+
+			configurations {
+				default = "@conf-DEFAULT-SEQ";
+
+				@conf-SEQ {
+					description = "NAME";
+					fdt = "fdt-SEQ";
+					firmware = "opensbi";
+					loadables = "uboot";
+				};
+			};
+		};
+	};
+};
+
+&{/soc} {
+	memory-controller@8000000 {
+		compatible = "sophgo,cv1800b-ddr";
+		reg = <0x08000000 0x12000>;
+		bootph-pre-ram;
+	};
+};
+
+&cpus {
+	bootph-pre-ram;
+};
+
+&cpu0 {
+	bootph-pre-ram;
+};
+
+&uart0 {
+	bootph-pre-ram;
+	clock-frequency = <25000000>;
+};
diff --git a/arch/riscv/include/asm/arch-cv1800b/rom_api.h b/arch/riscv/include/asm/arch-cv1800b/rom_api.h
new file mode 100644
index 00000000000..fe4c55321de
--- /dev/null
+++ b/arch/riscv/include/asm/arch-cv1800b/rom_api.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2026, Hiago De Franco <hfranco@baylibre.com>
+ */
+
+#ifndef __ASM_ARCH_CV1800B_ROM_API_H
+#define __ASM_ARCH_CV1800B_ROM_API_H
+
+#include <linux/types.h>
+
+#define CV1800B_ROM_API_BASE		0x04400000
+#define CV1800B_ROM_API_LOAD_IMAGE	(CV1800B_ROM_API_BASE + 0x60)
+#define CV1800B_ROM_API_GET_RETRIES	(CV1800B_ROM_API_BASE + 0xc0)
+
+/*
+ * Read @size bytes at @offset of the boot image from the boot device the
+ * BootROM booted from. Returns a negative value on failure.
+ */
+static inline int rom_api_load_image(void *buf, u32 offset, size_t size,
+				     int retry)
+{
+	int (*load_image)(void *buf, u32 offset, size_t size, int retry) =
+		(void *)CV1800B_ROM_API_LOAD_IMAGE;
+
+	return load_image(buf, offset, size, retry);
+}
+
+/* Number of retries the BootROM allows for the current boot device */
+static inline int rom_api_get_number_of_retries(void)
+{
+	int (*get_retries)(void) = (void *)CV1800B_ROM_API_GET_RETRIES;
+
+	return get_retries();
+}
+
+#endif /* __ASM_ARCH_CV1800B_ROM_API_H */
diff --git a/board/sophgo/milkv_duo/Kconfig b/board/sophgo/milkv_duo/Kconfig
index 040a7487f1b..b2727355589 100644
--- a/board/sophgo/milkv_duo/Kconfig
+++ b/board/sophgo/milkv_duo/Kconfig
@@ -24,5 +24,10 @@ config ENV_SECT_SIZE
 config BOARD_SPECIFIC_OPTIONS
 	def_bool y
 	select SOPHGO_CV1800B
+	select BINMAN if SPL
+	select RAM if SPL
+	select SPL_LOAD_BLOCK if SPL
+	select SPL_RAM if SPL
+	select SPL_SOPHGO_CV180X_DDR if SPL
 
 endif
diff --git a/board/sophgo/milkv_duo/MAINTAINERS b/board/sophgo/milkv_duo/MAINTAINERS
index 5e15e461b17..a384a0e6186 100644
--- a/board/sophgo/milkv_duo/MAINTAINERS
+++ b/board/sophgo/milkv_duo/MAINTAINERS
@@ -1,8 +1,11 @@
 Milk-V Duo
 M:	Kongyang Liu <seashell11234455@gmail.com>
 S:	Maintained
-F:	board/sophgo/milkv_duo/
+F:	arch/riscv/cpu/cv1800b/spl.c
+F:	arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi
+F:	arch/riscv/include/asm/arch-cv1800b/rom_api.h
 F:	board/sophgo/common/
+F:	board/sophgo/milkv_duo/
 F:	configs/milkv_duo_defconfig
 F:	doc/board/sophgo/milkv_duo.rst
 F:	drivers/ram/sophgo/
diff --git a/board/sophgo/milkv_duo/Makefile b/board/sophgo/milkv_duo/Makefile
index aa321d15687..6671631a7ba 100644
--- a/board/sophgo/milkv_duo/Makefile
+++ b/board/sophgo/milkv_duo/Makefile
@@ -4,3 +4,4 @@
 
 obj-y += board.o
 obj-$(CONFIG_NET_LEGACY) += ../common/ethernet.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/board/sophgo/milkv_duo/spl.c b/board/sophgo/milkv_duo/spl.c
new file mode 100644
index 00000000000..3db50df0615
--- /dev/null
+++ b/board/sophgo/milkv_duo/spl.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2026, Hiago De Franco <hfranco@baylibre.com>
+ *
+ */
+
+#include <asm/arch/rom_api.h>
+#include <asm/system.h>
+#include <dm.h>
+#include <hang.h>
+#include <linux/kernel.h>
+#include <spl.h>
+#include <spl_load.h>
+
+/*
+ * Offset of the FIT image in fip.bin, keep in sync with the fit node in
+ * cv1800b-milkv-duo-u-boot.dtsi
+ */
+#define CV18XX_ITB_OFFSET		0x40000
+
+u32 spl_boot_device(void)
+{
+	return BOOT_DEVICE_BOARD;
+}
+
+static ulong cv18xx_rom_read(struct spl_load_info *load, ulong off,
+			     ulong count, void *buf)
+{
+	int retries = rom_api_get_number_of_retries();
+	int i;
+
+	/* The BootROM reports no retries for some boot devices */
+	if (retries < 1)
+		retries = 1;
+
+	for (i = 0; i < retries; i++)
+		if (rom_api_load_image(buf, CV18XX_ITB_OFFSET + off, count, i) >= 0)
+			return count;
+
+	return 0;
+}
+
+static int cv18xx_spl_romapi_load(struct spl_image_info *spl_image,
+				  struct spl_boot_device *bootdev)
+{
+	struct spl_load_info load;
+
+	spl_load_init(&load, cv18xx_rom_read, NULL, 512);
+
+	return spl_load(spl_image, bootdev, &load, 0, 0);
+}
+
+SPL_LOAD_IMAGE_METHOD("ROMAPI", 0, BOOT_DEVICE_BOARD, cv18xx_spl_romapi_load);
+
+void board_init_f(ulong dummy)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = spl_early_init();
+	if (ret)
+		hang();
+
+	preloader_console_init();
+
+	/* Probe the CPU so that the RISC-V timer is available */
+	ret = uclass_get_device(UCLASS_CPU, 0, &dev);
+	if (ret)
+		panic("Failed to probe the CPU: %d\n", ret);
+
+	riscv_cpu_setup();
+
+	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+	if (ret)
+		panic("DRAM init failed: %d\n", ret);
+}
diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
index c6c0dbb4be6..e279e7c7d5f 100644
--- a/configs/milkv_duo_defconfig
+++ b/configs/milkv_duo_defconfig
@@ -5,16 +5,33 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
 CONFIG_DEFAULT_DEVICE_TREE="cv1800b-milkv-duo"
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
+CONFIG_SPL_STACK=0x3bc19000
+CONFIG_SPL_TEXT_BASE=0x3bc00020
+CONFIG_SPL_BSS_START_ADDR=0x3bc14000
+CONFIG_SPL_BSS_MAX_SIZE=0x1000
 CONFIG_SYS_LOAD_ADDR=0x80080000
+CONFIG_SPL=y
 CONFIG_IDENT_STRING="milkv_duo"
 CONFIG_TARGET_MILKV_DUO=y
+CONFIG_SPL_OPENSBI_LOAD_ADDR=0x80000000
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
+# CONFIG_SPL_SMP is not set
 CONFIG_STACK_SIZE=0x100000
 CONFIG_FIT=y
+CONFIG_SPL_LOAD_FIT=y
 CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_SYS_CBSIZE=512
 CONFIG_SYS_PBSIZE=544
+CONFIG_SPL_MAX_SIZE=0x13fe0
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x81000000
+CONFIG_SPL_OPENSBI=y
+CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x0
 CONFIG_SYS_PROMPT="milkv_duo# "
 CONFIG_CMD_MMC=y
 CONFIG_CMD_POWEROFF=y
@@ -32,6 +49,7 @@ CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_CV1800B=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_ETH_DESIGNWARE=y
+# CONFIG_RAM_SIFIVE is not set
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SPI=y

-- 
2.53.0

