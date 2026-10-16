Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5212CCF2C2
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:24:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FF6C61005;
	Fri, 16 Oct 2026 13:24:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vW7zlcUBdqvI; Fri, 16 Oct 2026 13:24:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3E71F61275
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792157064;
	b=fTQPsDx0VGYBhjST+fmoufgPjc9ZxW+hkGC6ckKOsKXu5jthvqdnBnQEC0YhmrL2yTNV
	 gOHoJUrkNQIbaaAvxXFTqhznkxOZehbLPz0rafiiWFYJccQAoiJ5UPHK0fRLgetP4wSFk
	 a0I6SXcsAXSixWKnDznyDMOIDY3q2MzjISKIbyefsovsi4HW/AZbXMz3erlwPAy44LDFM
	 gMJs3Sx2h+kdwhuUjxAFHy8jLBr/s47WLkDyrqkWu7WRkUalhBudPrET/z56ZsaJGUOg5
	 MA8j0NKVK0qWNOcL/k4pctByH/lv/p1RDycI1HlfLkHpvmevJThNUzqBjDFu0Llhh3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792157064;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jpoCXXA+4Dxv7CGXvWoJAsrnicmQLNQevk6y5xHl3wI=;
	b=qpUCx01t460arVXw+K4FZlj/6McwkeP94N51rRcxzw8+EHmFxfN9IQiGGujOWz9ZeXq8
	 OHFb7iwAFaUR2mlBFJYa5tDtK+QN5/k1KtpkyNJQTDtK0N92iZFsjFHw3sarBKl24XqU0
	 yI5Qvn1qjhp+xlXdQ+fWBzVkkaWBHa5nchbfNvsISsq39TH9pqGvZx3BnbQg07nE1STPf
	 abvFVnbacK5w4yiAvqDRn+97fNMV5QgnbJfs2j477ksDfsUXqQP8zyQvLr+OxP0Bbk0ZS
	 OSIKIQjXbYeoN4sjr+J+TSL0r0DsPYnYK/iqVV/Wgl/WvuhWr3AeLAs2MG5KokQ4MVw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792157064;
	bh=jpoCXXA+4Dxv7CGXvWoJAsrnicmQLNQevk6y5xHl3wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i+jult3e3N5eCQcxcn43F4ac2PRhlEZppOixaY/GuZh5GS85c5w3E4N0Sdfyy9G9x
	 Jak3MjXERekBZuKwzL/k7eyPQgNx0qS0rbyUAMKngWZxkbQLf7wZNlE8mH6bH2C7nm
	 4ELuc2T0nt6JIw3QOXbwZ6GzN4rkTjDdTaK6bNnI9u6IclRs+gUQ9Lq/yRnE3z1g00
	 8m1RZSUP6t4JLL1vpiT0FIZF115OeHhc8qt9pa5H35WIpHXAs63iV8QOJB388zaBaX
	 MrbSS1oIOwy8MSgKjrDkElOTp/RPDr/pCRq2vIgbmE5yYqOUs7hwf/2RivbVuJHjWD
	 NMrplCM9U99Pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E71F61275;
	Fri, 16 Oct 2026 13:24:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B4982A8
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D7A08146A
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5JCrFzq7d4td for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 09:17:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3972681220
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792142230;
 b=esJrvoGGYx1SIZPTmmUiZuDErSHoGqJ3x9vsyXpETm3bRc7yWEW4fgqTnNcOOvxK0U2Z
 9TzfbqhBdMOjihIC6fexTl329doO9Ey+P2ipb7c0N4/D/1ZihY9bLi1vMuaq4uPsim8aB
 6vDbrP7pLrGApg7bFyB0eAfO52IziImYoQW5UuYm5L9kPelERPDMTi/3lKmJvRajNadt9
 fr0Obz5ykN4fNxWvPp66MaFX1PBS7lEvYk6x4roN6yhNOs4Mk8l+4Qj1YdgIvO1vkkUbD
 QAllr/Q8iwzfvbK2gyNbqOa1gIdVJ0+0ArcOPbjEMJTFi4I5fYZEqiYBy5X2EmqoO6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792142230;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=jpoCXXA+4Dxv7CGXvWoJAsrnicmQLNQevk6y5xHl3wI=;
 b=Db10+h6HCGYNeKtLfxrPJglsBSQkOVAbunc0HgpfvJsAq9TPopMLCREXHAyzErsUYGhr
 1zzRAaTXabxahnELL9cx4w4RvfVc/vP8+mOQefR0Qzk6YzAP1T7vKMk0EX0oeaCMZvGzn
 qJemMLdn8Nlxow3ZHcubX079K6GV80f6u1StnXdDzOWW3blIEdkrrLuch6qRTINty8ymB
 c7Ekr3YKwEZNAG3bN8GTy7IeXpsxU66/KoiBlh1QWTtWIvY+9OfDdqBKXsR9hRHQ+Acu6
 eapf8hcKtqcVdTX9dCKOceDSliGjzc2ZRohzmNjaoJifarY7REh7iuB58emg3OUOdmg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FSxbygTC; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=pmazzini@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=FSxbygTC
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3972681220
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:08 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so19800165e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 02:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792142227; x=1792747027;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jpoCXXA+4Dxv7CGXvWoJAsrnicmQLNQevk6y5xHl3wI=;
 b=FSxbygTCg4hkmS1G2qtlo8+SdUxpvR23xfiLzaXINBwXcBQ8EN6UCLOxePN5JchxUR
 +VkyrIMU6bQ0Wb6Jj9tai0cG+wqSU6dMD6ApoWS0z2EY3lByu0R9guDqdtfEWDH//rC/
 VGHiW3ABa++NCexbSVidIDbC0NiqfrX5QTXFhKH/QjMUdfkSlvCc3iJavxmCfViZwc9s
 UmU8Yj1zFUrP3nauv4RgpPbXEk9oGfg/Aiqqoeqky9c1VsS6MU+U+bqIK7QKS39KJ9tC
 samWZ80QmldmY6gkT2t1VSnROKRnqSr5/E7Skz1wsfmIOgOnoBqrVAuydJ1TcQlQNYea
 pSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792142227; x=1792747027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jpoCXXA+4Dxv7CGXvWoJAsrnicmQLNQevk6y5xHl3wI=;
 b=1K+Lm77cjFygD7ipkIxxy4Fv7ol9zq+kXIhuxaqohvOJipla2D3YuFGibV78Z26Khx
 l6gbwMjsBOI40t3kmlXhy+KN4I/8RP24ipijAPRjGJOLwbioUz+r6/aVawcoSXTiMaDL
 5hOoAuZZXqcFDgl5JI/VO1sBukRmez1+45M6X13n+4YkwN0mOLnfFKlZBzsia3uwKHYP
 23FJwP4KiBREW31Rswn4ovXmUakNUiuk1HAXS1yCaoo9TBKZr1+lJxMADqUnMxpj62xU
 PQyut1lkNrnX5FcDXZscMBAIAA4EfYhlYat8Ode/GHxNUq7RxI9i6pDqQfOm40ggjgz4
 NpSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcMOpWOoyRvpOjYU4DA1x2oq+NylxPMUq8yM5tLI/TWpWd1dRTl36EbTUVhSYuwjgDOCOtUK4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYILqvteGhDE4rcfogjD3HHiS6YYlwjo04XFlcW78QqMngZCwbiw
 tsM9/Q5aOLor3EGiaSlfKFkWCZrvdpalNQj9aUeS+A6bVadpxTWKfFfg
X-Gm-Gg: AYBFou3Ic4fnPKPnjupUs6w4htr0cwIvyvapYWCfUAkc9/dWPwzvrd8HJQ2gW0PBo1U
 8oVc5Weo3d7Z+dVAAGLWtFyljWPj01unu4jbXV0vvsXnGAb2syzgR3lvPD7agI+Fmj+m4GyofOV
 LfbEWctPSPsHqC8dcqE2Zn0b3HHkCPITqdEYE8sPER5rfWePchzJC/tmX5vq/1A0zeCFq48RWBh
 sp/6NTVbL5zZ8YZl+uIMEBknM/36cbKyR/o8T1hEjYSD3IWYcvtncDv1nGVzjweuJsMvDdgwaSj
 ZQvCkIl8iS4NczrHuIC341juDLncYUHbHqfVAqiMQPvOYNnEeumRkSmfYK3qu1voyxvb9+rW5wp
 CdfA/eZPSxP2bhqRNGf5yqO18oAWcD2v2VKnDodfUdiViGQtV41tIRYvfPDkulGV7Uk6xNEBVmN
 P4zlo9XCCJ0j6EhWDerVPu9vTMSKpGs270ouc+HgSUuYDktR2gv32zFL0AGEg=
X-Received: by 2002:a05:600c:3b8b:b0:4a1:811c:8078 with SMTP id
 5b1f17b1804b1-4a18e4a7cfcmr545274385e9.26.1792142226569; 
 Fri, 16 Oct 2026 02:17:06 -0700 (PDT)
Received: from debian.tfbnw.net ([2620:10d:c092:400::4:7d8a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4ee183sm3692331f8f.29.2026.10.16.02.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:17:05 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 3/7] dt-bindings: clock: add the Allwinner B288 CCU
Date: Fri, 16 Oct 2026 10:16:04 +0100
Message-ID: <20261016091608.121842-4-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016091608.121842-1-pmazzini@gmail.com>
References: <20261016091608.121842-1-pmazzini@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:23:56 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The clock and reset indices of the B288 CCU, as under review for Linux.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
---
 include/dt-bindings/clock/sun8i-b288-ccu.h | 82 ++++++++++++++++++++++
 include/dt-bindings/reset/sun8i-b288-ccu.h | 45 ++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 include/dt-bindings/clock/sun8i-b288-ccu.h
 create mode 100644 include/dt-bindings/reset/sun8i-b288-ccu.h

diff --git a/include/dt-bindings/clock/sun8i-b288-ccu.h b/include/dt-bindings/clock/sun8i-b288-ccu.h
new file mode 100644
index 00000000000..c9b9eaf979a
--- /dev/null
+++ b/include/dt-bindings/clock/sun8i-b288-ccu.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+#ifndef _DT_BINDINGS_CLK_SUN8I_B288_H_
+#define _DT_BINDINGS_CLK_SUN8I_B288_H_
+
+#define CLK_PLL_CPUX	0
+#define CLK_PLL_AUDIO_BASE	1
+#define CLK_PLL_VIDEO0	2
+#define CLK_PLL_DDR0	3
+#define CLK_PLL_PERIPH0	4
+#define CLK_PLL_VIDEO1	5
+#define CLK_PLL_24M	6
+#define CLK_PLL_PERIPH1	7
+#define CLK_PLL_DE	8
+#define CLK_PLL_DDR1	9
+
+#define CLK_PLL_PERIPH0_2X	10
+#define CLK_PLL_PERIPH1_2X	11
+#define CLK_CPUX	12
+#define CLK_AXI	13
+#define CLK_CPUAPB	14
+#define CLK_AHB1	15
+#define CLK_APB1	16
+#define CLK_APB2	17
+
+#define CLK_NAND	18
+#define CLK_MMC0	19
+#define CLK_MMC1	20
+#define CLK_MMC2	21
+#define CLK_MMC3	22
+#define CLK_SPI0	23
+#define CLK_SPI1	24
+#define CLK_SPI2	25
+#define CLK_DRAM	26
+#define CLK_DE	27
+#define CLK_EE	28
+#define CLK_EDMA	29
+#define CLK_TCON0	30
+#define CLK_MBUS	31
+
+#define CLK_BUS_THS	32
+#define CLK_BUS_NAND	33
+#define CLK_BUS_SDMMC0_BUS	34
+#define CLK_BUS_SDMMC1_BUS	35
+#define CLK_BUS_SDMMC2_BUS	36
+#define CLK_BUS_SDMMC3_BUS	37
+#define CLK_BUS_SPI0	38
+#define CLK_BUS_SPI1	39
+#define CLK_BUS_SPI2	40
+#define CLK_BUS_I2S0	41
+#define CLK_BUS_I2S1	42
+#define CLK_BUS_SPDIF	43
+#define CLK_BUS_DSD	44
+#define CLK_BUS_DMIC	45
+#define CLK_BUS_USBOHCI0	46
+#define CLK_BUS_USBEHCI0	47
+#define CLK_BUS_USBOTG	48
+#define CLK_BUS_DE	49
+#define CLK_BUS_EE	50
+#define CLK_BUS_TCON0	51
+#define CLK_BUS_CSI	52
+#define CLK_BUS_ADDA	53
+#define CLK_BUS_SDRAM	54
+#define CLK_BUS_PSRAM	55
+#define CLK_BUS_DMA	56
+#define CLK_BUS_UART0	57
+#define CLK_BUS_UART1	58
+#define CLK_BUS_UART2	59
+#define CLK_BUS_UART3	60
+#define CLK_BUS_UART4	61
+#define CLK_BUS_UART5	62
+#define CLK_BUS_TWI0	63
+#define CLK_BUS_TWI1	64
+#define CLK_BUS_TWI2	65
+#define CLK_BUS_PIO	66
+#define CLK_BUS_GPADC	67
+#define CLK_BUS_KEYADC	68
+#define CLK_MMC0_SAMPLE	69
+#define CLK_MMC0_OUTPUT	70
+#define CLK_MMC1_SAMPLE	71
+#define CLK_MMC1_OUTPUT	72
+
+#endif
diff --git a/include/dt-bindings/reset/sun8i-b288-ccu.h b/include/dt-bindings/reset/sun8i-b288-ccu.h
new file mode 100644
index 00000000000..67514565454
--- /dev/null
+++ b/include/dt-bindings/reset/sun8i-b288-ccu.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+#ifndef _DT_BINDINGS_RST_SUN8I_B288_H_
+#define _DT_BINDINGS_RST_SUN8I_B288_H_
+
+#define RST_BUS_THS	0
+#define RST_BUS_NAND	1
+#define RST_BUS_MMC0	2
+#define RST_BUS_MMC1	3
+#define RST_BUS_MMC2	4
+#define RST_BUS_MMC3	5
+#define RST_BUS_SPI0	6
+#define RST_BUS_SPI1	7
+#define RST_BUS_SPI2	8
+#define RST_BUS_I2S0	9
+#define RST_BUS_I2S1	10
+#define RST_BUS_SPDIF	11
+#define RST_BUS_DSD	12
+#define RST_BUS_DMIC	13
+#define RST_USBPHY0	14
+#define RST_BUS_OHCI0	15
+#define RST_BUS_EHCI0	16
+#define RST_BUS_OTG	17
+#define RST_BUS_DE	18
+#define RST_BUS_EE	19
+#define RST_BUS_TCON0	20
+#define RST_BUS_CSI	21
+#define RST_BUS_ADDA	22
+#define RST_BUS_WLAN	23
+#define RST_MBUS	24
+#define RST_BUS_DRAM	25
+#define RST_BUS_PSRAM	26
+#define RST_BUS_DMA	27
+#define RST_BUS_UART0	28
+#define RST_BUS_UART1	29
+#define RST_BUS_UART2	30
+#define RST_BUS_UART3	31
+#define RST_BUS_UART4	32
+#define RST_BUS_UART5	33
+#define RST_BUS_I2C0	34
+#define RST_BUS_I2C1	35
+#define RST_BUS_I2C2	36
+#define RST_BUS_GPADC	37
+#define RST_BUS_KEYADC	38
+
+#endif
-- 
2.52.0

