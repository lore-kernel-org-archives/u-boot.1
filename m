Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998C5606A334
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TjIq76Bd;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=A27PbZpx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 759CD80F9E;
	Wed,  4 Nov 2026 08:51:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Q9CsAG96t8x; Wed,  4 Nov 2026 08:51:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5C90780E45
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782276;
	b=Y0OnxMYC5E3HqjG8wtz3z3MJCmbpnUoMbb2OEiS+VndHJBcewcMFGvtvEHM9jl5K44ub
	 NLEOR2rpV9jSHGZQsvlTz+puG0uQNNVl+2NQcREKifKDeSSdnH6naZBnZ4nbp5ulroAos
	 znobgKT/fctdcvLvGuLM9TR9TIPwG/lDZBC6S+o5zrdOxSN9irZ/tsJ5wEWDENFpCVZxX
	 aQgl7Nj8QGJa8DvvrFj/Dwn182ls665RSHIOYf3INq5JL9VSc8F5Dfouu16iZN1kV+ZmS
	 huL0ys6Rafw+67gIJjES7pZ6e+QCbxuPSPBWwL5cmrYGzIm6TpEMt878fEIDA9Gr0JA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782276;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6TxMga90j2t98fyHH/ve+ZTDnbmzUCUcBOwkJmS4sZ4=;
	b=QGaTd0nG/fCZYnZtdPGFsERmgH0EJ2wZsuP9QhNQUWJ7sWHSfDrSt3y5VcEOZfCj8tyj
	 qGR8uSGvWZPs005etkZ7AT6w05y5GaL5XLPwtO2zLcx7WRVknTfJ31bpB00Y1QEJGsl+A
	 A7TPPvIH6AqV2AaDatVOCtxhPnlIydv6FM9hy6lVP2UZF6V3gCG0rt0lHpvFeVdkFij3R
	 7nqV3Bcm5k0N3KIYAMkzqu+GcWnkRdeEi9nCuCUnkTFCLTuIN16yxzZpP0Ws5iaVoewFq
	 Ri9C/Luua//idCXCZOW3dg581H5e3MIRJsykW8j6ZUEODnLeLJHvrMGl2d6X2mDYTBg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782276;
	bh=6TxMga90j2t98fyHH/ve+ZTDnbmzUCUcBOwkJmS4sZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TjIq76Bdt9Sv+FHFFaWiSY9IRGknAlGXsEqBNbIvbmzoEKAAYSFzWhwNSMqwxj9p1
	 odffsrlhzHVO72s/FVmzkSWM3iahdGN4CT4ddK3pXq53H9VwspQaVB0aut/y2Z3CDa
	 RMM26R3cc2kRckdp3sDPrg5kgHum52T0hovnqGhPGepjHSx2tRERKqvBH/4uD8iPbF
	 2l8FvxZQoF3B83whE7jWRyO9iU1r5fiadFibtZMQnUKOXBZdRZPn+GDZj/nNDkxw56
	 0wWDYHvEqf3eNQWgTr0GHapLnD2FlFv71/Y15rO5UVVwBLB+KBC4sh64md6mwDmn1Y
	 vS+VlZJElXaXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C90780E45;
	Wed,  4 Nov 2026 08:51:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EFC109C4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E1952401FD
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u5NnMrXy_7tW for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:51:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B44DC4004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782274;
 b=gru42mcE3UlX5730Wwg5M+DK/iyB9ebnC3gHSCMDn7i+peGjln/6GP5KdDgL7HNWM6Bo
 1Y2LctQ3uoUwgzGeYkngF5A6byT1NoisilM7CGzCLkKG6Atss8z2t8Q4HUdt1QemBnnZ/
 hhwN6vp1GsWwlxHeO/BPQ/dapzUAWvnUT01C3VZhJVx2PYT5yPQA7VDYJY367IFd5KZNS
 fsgZU808cR/oIvPa1/V0DRxSZERMWhoCbdvCCz2eHUgRf0JYd36kZvRjvX+NgRJiZrYpl
 vzDaXOZuR4atQ0DJYEyNepZGx6vL8xq5XO6pqXwDaBRnW1aikZaIThYh6jxqdDq8RhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782274;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=6TxMga90j2t98fyHH/ve+ZTDnbmzUCUcBOwkJmS4sZ4=;
 b=GitetZruHPZevxUaL5y7MatCyTAgROd4w6M83a+R8TjK16IvktcSIbutdoygN7Rs9SD0
 jmYA5SabNioRI90ROD18/ms3rqHYr2/SAUZ6rMMvtWsWUdyoyDBk9UGRun+c1cBx+F2on
 zuIynBPsUjxe4gwZGsBrAjyq9peRiOML/vghtR+HCpeUIrkbV2WQj3HHMV4TTg+WcjDb3
 eFRTD3wFnFzgVsBIoKnfIfuokojyKL+mazKuGAO4KVWmYWxpIoS3iOBPxPp8SYJ0/cwyM
 MO4XoXbk0bwBfnb9xbu+WwM3z9GGMMnkdNWwVkaQe19R7OAhblEYmbSwia/ge5Glf+w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=A27PbZpx; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=A27PbZpx
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B44DC4004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:13 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so3370495e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782271; x=1794387071;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6TxMga90j2t98fyHH/ve+ZTDnbmzUCUcBOwkJmS4sZ4=;
 b=A27PbZpxVMg7Y/fHPNsxHqvqo/CqX3KgeB9nXyIdF3Fn87XtKYwVB8amIu4llpkM1J
 5mjuI0zYiSXuTvRHkA9iS4KpTzTDAxEMpj2TtRrefVnkaQx5bK869SeKMwRPYbJLvAuQ
 LYSdG3CNTXfhBpbd4ghIsbZavkd81VC1HBjNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782271; x=1794387071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6TxMga90j2t98fyHH/ve+ZTDnbmzUCUcBOwkJmS4sZ4=;
 b=bTje+MuDaWvUAdbZOiempODFgksToClevPjyBeoyzCiwNdb8J1JT4uINLjlZ+GtVhR
 UZO1ubtOM0f/dQhQWd4Ncg/SjH7G9+VLDvIUnCqFv0Vw5+mTO3S1ed/qMeoitVRyPCzP
 pnnoqFceG43/Z4pEegDz6VGcln0r7IRxdq93TsnZXSNtae1alnCLirIRdPAP8V4NAVQM
 a14NnnuiL8TO4zL30Ra3RpwnpS9vA96B80cntI2CTOWKO6pwyY8qzneDoMAhW7pxgHfD
 ZmtXG4yEgoX5D3C/x9aRCfVthkq8vmRbD7ek2mocJugRopbyHzIsf9cUj41AovFA4T/M
 GPFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLgARtzbZMBraQxATCszbl+lLD6JUjmNke4wMdTwl3pyaIu1GBZ/n3q8+FTi+In2aYbjVkzjY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8wf5l3zMDY3d1cSEqZ/ucmSRbNnchQlzG4ZXdi9jxtFi4N342q
 CBkXb4ouyNvra416FQ3PURJDPXDZgfwjoTJmGq+v7nAKscDtPfXH2/mN9AHD8AR8jMo=
X-Gm-Gg: AYBFou0f0plE3GLGkRjKBVWmBvGHxyTYa5vdNWSQ847AZqaA77l/3tebYQ+rWMJJRCx
 NIyUsMkbwILOmuaQ/sLFrF+nhYYuf5NPH165fmeys2lgXubvBd5sZfH1mJVy2SiaAfeEicAw2+C
 l/65Nxv/0jrTbZXac+Yl7xYCFh62k503+JQJ3FK+NCsuTo4K+1W3oWAzqD57hkYoTJSnBXxCjYZ
 QDLtQcJj+IMuhkRKUGR4RpaaclQEp9huWq5wlTSV2UnNQ42d+mA3uP/RMza6xJ8ueAT7qfVdfDT
 F/+hq49NvPyz4nPAYwt+wItUvzNFw6m1Nrx1d7UMnQFIYSgYO5ETvnK1ytkqevtKcPbvdhQBJeB
 YgjtGf3BMwFczyhnuoTnbH68hXbcRMK1Iwr3TENbkea+0dnQRcR8rO7XDjcytu+DW6RmiTU8vwd
 mgU4KMy8LScN8R4yzlZ4kkhAz9Pg52hmwmIAm85vcVADDOaKk21zD7rJP1Jw63p/1kzprMrtPPo
 tIDkuO56ZRmHL83LoEnQ9txJ1o2AVrLpSDnxRr5rl0P7/I0OZqbEPw0Yt3hOeXaqyMglSeLp224
 ZGwAuEK7EVdEC7zRgTf0w0hGJeB2eVedpUrmK5k9jPFtIQeQ767nnp8LYh/SR98LdBCB6QHS5zt
 KK58HA99qSrLU8IEfnvM00LdCAHAMx1O+Yn2/DP8saK9aVc0r
X-Received: by 2002:a05:600d:6508:b0:4b0:b9ff:1e7c with SMTP id
 5b1f17b1804b1-4b0b9ff2129mr169638265e9.15.1793782271564; 
 Wed, 04 Nov 2026 00:51:11 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:51:10 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 07/33] arm64: dts: st: add ltdc pins for stm32mp25
Date: Wed,  4 Nov 2026 09:49:40 +0100
Message-ID: <20261104085036.4012238-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add the LTDC pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-8-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 0183a9f7ba2de9fc9c1e0ee53e4cc7b049e69181 ]

(cherry picked from commit 24128ab8c8a3c29003deb325424d39d31ee08165)
---

 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
index db485b9ed904..50f454630cf2 100644
--- a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
@@ -260,6 +260,77 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	ltdc_pins_a: ltdc-0 {
+		pins {
+			pinmux = <STM32_PINMUX('C',  6, AF14)>, /* LCD_CLK */
+				 <STM32_PINMUX('G',  2, AF13)>, /* LCD_HSYNC */
+				 <STM32_PINMUX('G',  1, AF13)>, /* LCD_VSYNC */
+				 <STM32_PINMUX('C',  5, AF14)>, /* LCD_DE */
+				 <STM32_PINMUX('H',  4, AF10)>, /* LCD_R0 */
+				 <STM32_PINMUX('F',  7, AF13)>, /* LCD_R1 */
+				 <STM32_PINMUX('C', 11, AF13)>, /* LCD_R2 */
+				 <STM32_PINMUX('A',  1, AF11)>, /* LCD_R3 */
+				 <STM32_PINMUX('B', 15, AF13)>, /* LCD_R4 */
+				 <STM32_PINMUX('G',  3, AF13)>, /* LCD_R5 */
+				 <STM32_PINMUX('A', 10, AF12)>, /* LCD_R6 */
+				 <STM32_PINMUX('G',  7, AF13)>, /* LCD_R7 */
+				 <STM32_PINMUX('F',  8, AF13)>, /* LCD_G0 */
+				 <STM32_PINMUX('H',  5, AF10)>, /* LCD_G1 */
+				 <STM32_PINMUX('C',  9, AF13)>, /* LCD_G2 */
+				 <STM32_PINMUX('C', 10, AF13)>, /* LCD_G3 */
+				 <STM32_PINMUX('A',  6, AF10)>, /* LCD_G4 */
+				 <STM32_PINMUX('G', 11, AF13)>, /* LCD_G5 */
+				 <STM32_PINMUX('G', 12, AF13)>, /* LCD_G6 */
+				 <STM32_PINMUX('A',  9, AF12)>, /* LCD_G7 */
+				 <STM32_PINMUX('F',  6, AF13)>, /* LCD_B0 */
+				 <STM32_PINMUX('A',  3, AF11)>, /* LCD_B1 */
+				 <STM32_PINMUX('G', 15, AF13)>, /* LCD_B2 */
+				 <STM32_PINMUX('I',  0, AF13)>, /* LCD_B3 */
+				 <STM32_PINMUX('I',  1, AF13)>, /* LCD_B4 */
+				 <STM32_PINMUX('A',  7, AF10)>, /* LCD_B5 */
+				 <STM32_PINMUX('F',  5, AF13)>, /* LCD_B6 */
+				 <STM32_PINMUX('I',  4, AF13)>; /* LCD_B7 */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+	};
+
+	/omit-if-no-ref/
+	ltdc_sleep_pins_a: ltdc-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('C',  6, ANALOG)>, /* LCD_CLK */
+				 <STM32_PINMUX('G',  2, ANALOG)>, /* LCD_HSYNC */
+				 <STM32_PINMUX('G',  1, ANALOG)>, /* LCD_VSYNC */
+				 <STM32_PINMUX('C',  5, ANALOG)>, /* LCD_DE */
+				 <STM32_PINMUX('H',  4, ANALOG)>, /* LCD_R0 */
+				 <STM32_PINMUX('F',  7, ANALOG)>, /* LCD_R1 */
+				 <STM32_PINMUX('C', 11, ANALOG)>, /* LCD_R2 */
+				 <STM32_PINMUX('A',  1, ANALOG)>, /* LCD_R3 */
+				 <STM32_PINMUX('B', 15, ANALOG)>, /* LCD_R4 */
+				 <STM32_PINMUX('G',  3, ANALOG)>, /* LCD_R5 */
+				 <STM32_PINMUX('A', 10, ANALOG)>, /* LCD_R6 */
+				 <STM32_PINMUX('G',  7, ANALOG)>, /* LCD_R7 */
+				 <STM32_PINMUX('F',  8, ANALOG)>, /* LCD_G0 */
+				 <STM32_PINMUX('H',  5, ANALOG)>, /* LCD_G1 */
+				 <STM32_PINMUX('C',  9, ANALOG)>, /* LCD_G2 */
+				 <STM32_PINMUX('C', 10, ANALOG)>, /* LCD_G3 */
+				 <STM32_PINMUX('A',  6, ANALOG)>, /* LCD_G4 */
+				 <STM32_PINMUX('G', 11, ANALOG)>, /* LCD_G5 */
+				 <STM32_PINMUX('G', 12, ANALOG)>, /* LCD_G6 */
+				 <STM32_PINMUX('A',  9, ANALOG)>, /* LCD_G7 */
+				 <STM32_PINMUX('F',  6, ANALOG)>, /* LCD_B0 */
+				 <STM32_PINMUX('A',  3, ANALOG)>, /* LCD_B1 */
+				 <STM32_PINMUX('G', 15, ANALOG)>, /* LCD_B2 */
+				 <STM32_PINMUX('I',  0, ANALOG)>, /* LCD_B3 */
+				 <STM32_PINMUX('I',  1, ANALOG)>, /* LCD_B4 */
+				 <STM32_PINMUX('A',  7, ANALOG)>, /* LCD_B5 */
+				 <STM32_PINMUX('F',  5, ANALOG)>, /* LCD_B6 */
+				 <STM32_PINMUX('I',  4, ANALOG)>; /* LCD_B7 */
+		};
+	};
+
 	/omit-if-no-ref/
 	ospi_port1_clk_pins_a: ospi-port1-clk-0 {
 		pins {
-- 
2.43.0

