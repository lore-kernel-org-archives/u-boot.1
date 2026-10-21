Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5645A606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vYOxz+xG;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=HLB8TOET
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D1C4608E9;
	Wed, 21 Oct 2026 12:55:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id al7KLIC7SBZR; Wed, 21 Oct 2026 12:55:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5BF64608EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587321;
	b=spoRtucZ2y2izzhBMXoWcsXZXWdXz6kATnq8npSHLex/NT16r2FsuZHxRHnRkzYVOzfW
	 8BnBhHKSln1PNYdEgxUXn8t5ERZTLN7jd5qJcOOnrXcY1MYsmi2n6sOQ6P2DGya9ZKbZm
	 jY33fSMacc3dPVcvD2lsQCv/i8rQqs85fg/Yuzaj3vhxHrQhQYiRCPWmOi3S/AVsyWRTF
	 uGG1FKlqsG/pE94trkJ3xEw/FRnwujO2wCrywuPI1juA/wVdlU8PIYpoMlsl9os6uy6WE
	 u4V1Eh/sBhTF48ehmlvPWYqdGeSlF1HkIXBglWkKJK+S0iO33Sv6Iuz1VcdYFkd4+kA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587321;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=RA3KCXVJJRvth99FioKvs3x5zRPUd+vYQ+aYI0qbteo=;
	b=IcbKPYo/AtbrM/867RhWVrwxslo0GQihWGTLgG50QXd+4VISY3ZxjlMDFmdaROKnDTMz
	 Ns/mD/2pWw04J99dT6Hn3UjSMklhPeGiLxauf72gJxseDrolqDk/toXiloVdAg9cCGDBj
	 ehTrSdJrjwGA0pGPdrbvIcJ59vwp39EDRq8zFJGAtDPodPehsi9CvObXXBHiy9cFVbG1H
	 U7Ve8+xMBr0G9pZ+yTc/6OZwWd3EmSGEytmTgxy9A3wiSzeWQ8Rk82ulm4n+5x8nZPlig
	 iThvKzlDkMoMM1YGkzcPX5c/2pexJGuKlOTc+NMa0KqVyI3+k2uKX7PDcrCCQkQl3Yw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587321;
	bh=RA3KCXVJJRvth99FioKvs3x5zRPUd+vYQ+aYI0qbteo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vYOxz+xGvH+ACmgSck1F/KTZqsWPovbe3rMPpfh3t6TlZc9nvXuveKvC6tzmW2FvO
	 AfMVpz8D8VRS39RMCU41H7C/VdB1xrBgWI8Nf7zi1cnt3qfn+uLn52cR/G8GeL+ex7
	 T/Xnkh5Sa9YmKsS4arFr9XOTyvzoBYrfG6JtWUbzrfPgg/VkX9yLvDIrDGEAfsY6cU
	 C8abrHzaR0Yxg2Rq9ke1qk9Q/5jazhlS1cymicOI86lycaipOXsJoXQYfPEVkCaot5
	 4OJQ+kjV8W3HAp5IiHLMMtqZ678IkKrfvjEG4SrmSD1+vfWEqkBj2ZYSdKoT4YgTNv
	 lwXrL0BDR7Hdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BF64608EB;
	Wed, 21 Oct 2026 12:55:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D6F4E1AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:55:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8D3481069
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:55:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G1BUbOAPrdKR for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:55:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 76C7F80E0F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::92f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792587318;
 b=XtisBkTZZ69DE8fFazay3jyRfQA6T051GVlqbR6KnT4X/aPO+JS6vL0t+MFhG3Smkt1B
 uuwbsMAPeBTGj7vY2kT+s+2OCD18Q2cmWa+mDu6B1k9xPHbmfSLj5L0aG2Dn0/Vtcdub2
 nDz/SQoUMKm217BOQgF/MaL78FRPezagEzbs2aFksKNMfWq98I568mknXvrznj1MPzLJU
 etpKXXxqySbwdvRL9pUPC2MWKnawJcqgsWyo93KsI7XtPS1RWvrPGbvsNBnmo6MR5UvfE
 vxp4mjvM9lGH+2+uJOPaUHnJwqowjdolsljACseJ4603Yhbs1z3cO6g5ESKWWnHR8Dw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587318;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=RA3KCXVJJRvth99FioKvs3x5zRPUd+vYQ+aYI0qbteo=;
 b=liqBWE2l5C9yA0Y1qXNF1vyV070hA/GQ+nK4MSRe5jIHw3bZ6nToUZAC/4936FEbxxnt
 97tDgd6Cx5SMsrswaSPpsFTJuJES5vOwwRTGsQibXZODI4aAU2uwU8aJGMdvBSoQG14XC
 xTIw7H3tIPoTOmN7VuFq3rWj8zRue6axLw4HK02YeLep/Xc3entjPf39Kp7nwQRP8YeND
 06XN31JFuMK1VQ63rOrGWMu3hCCwhyuvRV4/Mh0M92DOmCi0ibu0d5P3ZW0x0iFgbGtQw
 /4Sk9cshMg69H21hxYXUDqbbU6GxWIU4M1s7oir6Vf8tnG/VO1WzPRyoCDZOfQWkltQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=HLB8TOET; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::92f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::92f; helo=mail-ua1-x92f.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=HLB8TOET
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76C7F80E0F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:55:17 +0000 (UTC)
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-9906870a9baso363968241.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792587316; x=1793192116;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RA3KCXVJJRvth99FioKvs3x5zRPUd+vYQ+aYI0qbteo=;
 b=HLB8TOETWnUlFrgtYhFlA84h9i5U+nfj6rT7Kdw8ybMrTm2iPdNbnJD8Y1BKSMb2bs
 afg2+ED7TuGTD1bCPQbMpi/KGQqNPKxxXpma++kPKwUienf1KMY0i7gLHFDnEYPX13Ue
 uLDx06vFyCG7lN3DRF4+FOFWk6BnQg15CihLA6Wvxs9s6fpA333QjmkNHek7/iVoYbKV
 Wxj4t21n/kXfIiX0xBpnINeLWP66SJhkIim2PXtWI9osUc6J/rUV1Mdw1J7kadzeoBlJ
 GQNJFYcWApULUD8s5NbGWWcURv8aJplyiyM8IbNW+8WfjyYL84cnbH34/+7Wj8r2RIZi
 xKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792587316; x=1793192116;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RA3KCXVJJRvth99FioKvs3x5zRPUd+vYQ+aYI0qbteo=;
 b=J9rXd4y0qF6yMekBH3Q5hh9v6MEB/UKE1Uv5CHuppatFTj+pI6lK9QscSc1t3Om75F
 QjRpS1xxs26euyI1OHAgTfRWgC82mye/QVRszmCrUYS0tsUFyPLV2tQPeTv93IV45rUA
 CSktllVV8REhdV+s+uVE9VYf8lftAptsQKh1A+rYc9/NFoop1mVDV463GzqDPGDyBLkS
 7Fu4s0AbSgcMZ/9+eS/vj4As7EoesjBLhH1wHtuIFsHa3R4lzz2XRGKuNyT3r5cB1/MO
 aRgTZTMLDXmYnqtfDvWs8iZNULZq1Tdv7Le/CJ4RmT8uFf60I1a4Lz8vNSpmOFPMUGmN
 x+mw==
X-Gm-Message-State: AFq9FYK8BcnZYFbFXo5vUZsjzGRwzqprVRFhTwUxH36IDvDit8F5Yu1M
 onCGSJmL+fbkFACXQEZN8QwGO55b3Olnug2dfEO72tnbdjVuwXriwf6yawTHEBGDz8c=
X-Gm-Gg: AYBFou3WVlNblunbkf3GaEFS/K3fOKpq/n414Lvj2QKrsTBGid21Mms35P4QXwYLOct
 lBSFpCvgdFstdyRDi1sU/y6u+rzIfqsQw6MxXUBzCkjb5OLbgzWAX3YgDKkzyjIZx2DFCfwVYDF
 TFnr5T0zd6ZLBJSiU0FJKrhzoym2hVUSrJ42LChz69e8wdcUfbw2EZmssB1xuy5QH9JVYMB+9Ny
 6gYMwwiYwi/sUL/JsUzLg+DLe20OGImWcbfAW1hR3vuLBNm8vENwGklxa+U09oxmJfIgd2LTcj2
 ZSnU4cTZqDG0358Qip8veSZ4Gln8xZHUmm3ikr7Bs+OjyEJ35Fv3NgxbL2FHi0s6e3FZmB1my4m
 46J6Am3l7AavDTZ/DAyvzE/4LyJU3kYMhp8enGgh1KOkPx/ZbiSfB3kYkph1+AiYcuYErLrwirQ
 6YoRt6E5x3Y1gv6FPlx6b1Yzb2W9fS/rbZXXZ1A2GIdsaVCwiuO9NU0EKORjs13D0P5Y+iqUbkj
 6yZm9VEmgg7BhTWsP0oHCp++MeEkXw7PMXNkr/FebYkKgGw9BWVLwZ7NHDFtH2Rw8a6vbQJaoeJ
 Lb4ScpeXdUd6M/60tt4=
X-Received: by 2002:a05:6102:5346:b0:7c2:7a0:ae28 with SMTP id
 ada2fe7eead31-7cc9272480fmr808226137.30.1792587316569; 
 Wed, 21 Oct 2026 05:55:16 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:8bf0::33ca])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-990d0e0ba56sm3013863241.1.2026.10.21.05.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 05:55:16 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Wed, 21 Oct 2026 09:54:21 -0300
Subject: [PATCH 5/8] board: sophgo: milkv_duo: initialize PLLs in SPL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-milkv-duo-spl-v1-5-ee7618860237@baylibre.com>
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DDR training runs from the XTAL, before the PLLs are configured, so add
PLL setup after it in board_init_f().

The sequence bypasses all clocks to the XTAL, reprograms the APLL,
DISPPLL, CAM0PLL, CAM1PLL, MIPIMPLL, MPLL and TPLL synthesizers and
their derived dividers, waits for lock, then switches every clock from
the XTAL bypass to its PLL source. It is ported from the Sophgo FSBL
(plat/cv180x/platform.c), https://github.com/sophgo/fsbl.

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 board/sophgo/milkv_duo/spl.c | 123 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/board/sophgo/milkv_duo/spl.c b/board/sophgo/milkv_duo/spl.c
index 3db50df0615..8b2dc2756ae 100644
--- a/board/sophgo/milkv_duo/spl.c
+++ b/board/sophgo/milkv_duo/spl.c
@@ -2,12 +2,17 @@
 /*
  * Copyright (c) 2026, Hiago De Franco <hfranco@baylibre.com>
  *
+ * PLL setup based on the Sophgo FSBL (https://github.com/sophgo/fsbl),
+ * plat/cv180x/platform.c.
  */
 
 #include <asm/arch/rom_api.h>
+#include <asm/io.h>
 #include <asm/system.h>
 #include <dm.h>
 #include <hang.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <spl.h>
 #include <spl_load.h>
@@ -18,6 +23,76 @@
  */
 #define CV18XX_ITB_OFFSET		0x40000
 
+#define CLKGEN_BASE			0x03002000UL
+#define CLK_SEL_0			0x020
+#define  CLK_SEL_0_C906_1		BIT(24)
+#define  CLK_SEL_0_C906_0		BIT(23)
+#define CLK_BYP_0			0x030
+#define CLK_BYP_1			0x034
+#define PLL_G2_CTRL			0x800
+#define  PLL_G2_CTRL_PD			0x00011111
+#define MIPIMPLL_CSR			0x808
+#define APLL0_CSR			0x80c
+#define PLL_G2_SSC_SYN_CTRL		0x840
+#define APLL_SSC_SYN_CTRL		0x850
+#define  SSC_SYN_CTRL_BYPASS		BIT(4)
+#define  SSC_SYN_CTRL_SW_UP		BIT(0)
+#define APLL_SSC_SYN_SET		0x854
+#define MIPIMPLL_D3_PD			0x8a0
+#define  MIPIMPLL_D3_PD_PD		BIT(2)
+#define CAM0PLL_D2_PD			0x8ac
+#define  CAM0PLL_D2_PD_PD		(BIT(2) | BIT(1))
+#define MPLL_CSR			0x908
+#define TPLL_CSR			0x90c
+
+/*
+ * Divider register: [20:16] divider factor, [9:8] clock source, [3] take the
+ * divider factor from the register, [0] de-assert the divider reset.
+ */
+#define CLK_DIV(div, src)		(((div) << 16) | ((src) << 8) | BIT(3) | BIT(0))
+#define clkgen_reg(off)			((void __iomem *)(CLKGEN_BASE + (off)))
+
+struct cv18xx_clk_div {
+	u16 off;
+	u32 val;
+};
+
+static const struct cv18xx_clk_div cv18xx_clk_divs[] = {
+	{ 0x130, CLK_DIV(1, 3) },	/* clk_c906_0 = MPLL(850) / 1 */
+	{ 0x138, CLK_DIV(2, 2) },	/* clk_c906_1 = DISPPLL(1188) / 2 */
+	{ 0x054, CLK_DIV(3, 3) },	/* clk_tpu = FPLL(1500) / 3 */
+	{ 0x048, CLK_DIV(3, 0) },	/* clk_cpu_axi0 = FPLL(1500) / 3 */
+	{ 0x064, CLK_DIV(4, 0) },	/* clk_emmc = FPLL(1500) / 4 */
+	{ 0x088, CLK_DIV(8, 0) },	/* clk_spi_nand = FPLL(1500) / 8 */
+	{ 0x098, CLK_DIV(18, 0) },	/* clk_sdma_aud0 = APLL(442.368) / 18 */
+	{ 0x120, CLK_DIV(15, 0) },	/* clk_pwm_src = FPLL(1500) / 15 */
+	{ 0x0a8, CLK_DIV(1, 0) },	/* clk_cam0_200 = XTAL(25) / 1 */
+	{ 0x0c8, CLK_DIV(3, 0) },	/* clk_axi_vip = MIPIPLL(900) / 3 */
+	{ 0x110, CLK_DIV(2, 2) },	/* clk_src_vip_sys_2 = DISPPLL(1188) / 2 */
+	{ 0x144, CLK_DIV(3, 2) },	/* clk_src_vip_sys_4 = DISPPLL(1188) / 3 */
+	{ 0x0e4, CLK_DIV(3, 1) },	/* clk_axi_video_codec = MIPIPLL(900) / 3 */
+	{ 0x0ec, CLK_DIV(4, 3) },	/* clk_vc_src0 = FPLL(1500) / 4 */
+	{ 0x0d0, CLK_DIV(6, 2) },	/* clk_src_vip_sys_0 = DISPPLL(1188) / 6 */
+	{ 0x0d8, CLK_DIV(6, 2) },	/* clk_src_vip_sys_1 = DISPPLL(1188) / 6 */
+	{ 0x0b8, CLK_DIV(5, 0) },	/* clk_axi4 = FPLL(1500) / 5 */
+	{ 0x12c, CLK_DIV(5, 0) },	/* clk_src_rtc_sys_0 = FPLL(1500) / 5 */
+};
+
+/* APLL, DISPPLL, CAM0PLL and CAM1PLL synthesizers and dividers */
+static const u32 cv18xx_pll_syn_set[] = {
+	614440960,	/* 98.304 MHz */
+	610080582,	/* 99 MHz */
+	610080582,	/* 99 MHz */
+	615164587,	/* 98.18181818 MHz */
+};
+
+static const u32 cv18xx_pll_csr[] = {
+	0x00128201,	/* * 9 / 2 = 442.368 MHz */
+	0x00188101,	/* * 12 / 1 = 1188 MHz */
+	0x00308201,	/* * 24 / 2 = 1188 MHz */
+	0x00168101,	/* * 11 / 1 = 1080 MHz */
+};
+
 u32 spl_boot_device(void)
 {
 	return BOOT_DEVICE_BOARD;
@@ -52,6 +127,52 @@ static int cv18xx_spl_romapi_load(struct spl_image_info *spl_image,
 
 SPL_LOAD_IMAGE_METHOD("ROMAPI", 0, BOOT_DEVICE_BOARD, cv18xx_spl_romapi_load);
 
+static void cv18xx_pll_init(void)
+{
+	int i;
+
+	/* Run everything from the XTAL while the PLLs are reprogrammed */
+	writel(0xffffffff, clkgen_reg(CLK_BYP_0));
+	writel(0x0000003f, clkgen_reg(CLK_BYP_1));
+
+	/* MIPIMPLL = 900 MHz */
+	writel(0x05488101, clkgen_reg(MIPIMPLL_CSR));
+
+	writel(0x3f, clkgen_reg(PLL_G2_SSC_SYN_CTRL));
+	for (i = 0; i < ARRAY_SIZE(cv18xx_pll_csr); i++) {
+		writel(cv18xx_pll_syn_set[i],
+		       clkgen_reg(APLL_SSC_SYN_SET + 0x10 * i));
+		clrsetbits_le32(clkgen_reg(APLL_SSC_SYN_CTRL + 0x10 * i),
+				SSC_SYN_CTRL_BYPASS, SSC_SYN_CTRL_SW_UP);
+		writel(cv18xx_pll_csr[i], clkgen_reg(APLL0_CSR + 4 * i));
+	}
+
+	/* Power up the PLLs */
+	clrbits_le32(clkgen_reg(PLL_G2_CTRL), PLL_G2_CTRL_PD);
+
+	/* MPLL = TPLL = 850 MHz */
+	writel(0x00448101, clkgen_reg(MPLL_CSR));
+	writel(0x00448101, clkgen_reg(TPLL_CSR));
+
+	for (i = 0; i < ARRAY_SIZE(cv18xx_clk_divs); i++)
+		writel(cv18xx_clk_divs[i].val,
+		       clkgen_reg(cv18xx_clk_divs[i].off));
+
+	clrbits_le32(clkgen_reg(MIPIMPLL_D3_PD), MIPIMPLL_D3_PD_PD);
+	clrbits_le32(clkgen_reg(CAM0PLL_D2_PD), CAM0PLL_D2_PD_PD);
+
+	/* Wait for the PLLs to lock */
+	udelay(200);
+
+	/*
+	 * C906 clocks from the *_0 dividers, then switch every clock from the
+	 * XTAL to its PLL source.
+	 */
+	writel(CLK_SEL_0_C906_0 | CLK_SEL_0_C906_1, clkgen_reg(CLK_SEL_0));
+	writel(0, clkgen_reg(CLK_BYP_0));
+	writel(0, clkgen_reg(CLK_BYP_1));
+}
+
 void board_init_f(ulong dummy)
 {
 	struct udevice *dev;
@@ -73,4 +194,6 @@ void board_init_f(ulong dummy)
 	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 	if (ret)
 		panic("DRAM init failed: %d\n", ret);
+
+	cv18xx_pll_init();
 }

-- 
2.53.0

