Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7995E606A337
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Mcxr4tGA;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=GLCXHh4f
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39227814B8;
	Sat,  7 Nov 2026 14:33:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bEDEufItMq6k; Sat,  7 Nov 2026 14:33:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4B05B8149C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794061998;
	b=jLxL4XxnpXntBFf9Yi2nfAt5shajzGy6ktOtnj3ekZmqLLAgDUsXt7CpkH41kxRur2zb
	 eOxWq41S908s6as60F5JGxmYs9d+fo8Kbv4cS3vthKNonZH0K5Pke9R2BK9sJ4dkmWACQ
	 ifEHGGI0hexlnNDk42O57qAvvrxBM7zbRsJHYznlkbB8xMNjdCX+cu27rVzYC5FpToPYi
	 W4jVIi/IRKB7ze/sgY+YedUpUBdmkWVMdzkuwZdoP01VCeI8rDuOBzmapdnlfQTGgN7CJ
	 5SbBC2bFlfxnd1iiX7Aj8GiW855BouL+Gm8LxADIN81pvW1KMoiCtDFtj94aImVDN6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794061998;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yVglleHJr50nJjOfAZiN68jsAQhepsUZHpndLyT8FWA=;
	b=mLx+J+REpAtsdgyhr5iwRGAU4dPWKrwWMkNTmE2x3lJlc2ep2wP5G7X2Z+O06O05akNl
	 T+S2yMlw70F14WCzIKmRkZownMdAagNA07jy/1+VMAb/R7U0aBZAjDKHLXUOcSSoiORCv
	 o23ruoP6mSEEmyTzoXD8HZw4vSdHd3TQWTbWe5MmvikP1BRphiPCMCfPjWiw+oj/vTuYH
	 vbcsKRtGTjC3vitjSKfJj0rPfq0sEknt8cMN9/4aBvBGPxiSg4Ms74iHw1AFFR7E/ncjH
	 WKjN+/lV3PA+tsrwMy+SNLgGZYKTIUPfkX5zjsWkKHgzUZErUhNgDiDCd5rpqZzf46Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794061998;
	bh=yVglleHJr50nJjOfAZiN68jsAQhepsUZHpndLyT8FWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mcxr4tGAAPbNuOnmHzzqRP7Zo8HBIfxHyVUhXhkPIKiAHIlcxyvhbbmzyd5+HkH3u
	 sks5wnwwa+JkCkEuQNSKTZqkD4Kgnf2k22TJcgi8Nx+eV7jiQmsTppx1PCzkICgzUc
	 ayeOzSAWBv5Q6zthQf+1b128r10zBQwAfouQuwpkCYW4BovyuOV6iETj8f8H1ieGol
	 m58giUIeiG8145bt+3FMDPpm7d2QyCi9yUUfp2vrzButkaXZTXK60CWGSDclGTyRbf
	 8dqOtvkinE+GZIBDAXhMFzAy0091+7X/DO4O/5uNT+cyKhMvc8FWcbOUOyqeJyYa33
	 cLJJJQa6BO7qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B05B8149C;
	Sat,  7 Nov 2026 14:33:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1200E34D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC239400E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t2aFb5g4ljqk for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BE55D4009B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=GLCXHh4f
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE55D4009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:08 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e47347279so878321f8f.1
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794061986; x=1794666786;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yVglleHJr50nJjOfAZiN68jsAQhepsUZHpndLyT8FWA=;
 b=GLCXHh4fnCDy1sCNIoWMt+HLxmic7GG07+WsFCeVlvHmN1iiABAMR/Z3f8snWqjjAa
 Q4vnNPzO/1yHpcIIkoCfF0SKaZlOS5u69/y5Qv0FWyT1dtd4eW7EhUKgHNnioxlVPLyP
 lueWbH9saTLLp4eNWud4SS4o7x7RaSNJycVsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061986; x=1794666786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yVglleHJr50nJjOfAZiN68jsAQhepsUZHpndLyT8FWA=;
 b=OHjaKg4tFSbdLC6DEtuJvd+Z0+klTXJYvXnPzNWLcCiBw39S6IOQMVhXYAv+ap0fsb
 q/TRofZIIqtRVKUSTY89spD4tma+mrF1acDQg1LjJtEoKvQOIumHZc/fN0w7yj+bnPaA
 J0GX87ixi2/fh/TfgE5fjY9wepMcRE+PEMw5l2p3GZHvsdTUPYCpzD4ajh/m1kxkGqD+
 cx7RRwAV/8q11NyJ4vRP3vcnQrsYGOVnd2tgpW9whf4VP6xWFWHt9JPi0fAvSUZoUG6E
 XYZZMQ7+1YBnuXCTwliQvNIZoXzx+RYkK0F+uP5RDbPLURYQ+lrEJaxDO1nHhL4389dj
 pypA==
X-Forwarded-Encrypted: i=1;
 AL+hErEBc6MOk91+fwvSfSoNrh0olUgkFLd+NsXn2W8GPkHBv+dMN7BG5RZeDJbNZwGlrQFJbvFQj8Y=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+1+VTLPc+OkJeTCYI0AUiq4LpG1N5bLX4CNjZMLnlO0FrypKks
 LNRX784q9lyY7xlvvPB3ZdnhRCqKtX2t400Vpin48b5jHsaLfitnm/N1UK2mkQkogLk=
X-Gm-Gg: AYBFou03vWFU3vEn1Def306cxbrTILDgFDHZo7BwP/9N+/cDFJ4Jaez2aulOBPPtJrc
 sCgoSjcOy97z6JTYeg6y8TTZkuKcNcVUJzN/12vNxLAVNPg0uxfxWAPcSLX3BD4NKrsT1V45PXn
 0ferlehKWAR0gaK4L9ZH1J9sFuFsY8QKCH6F6UoPLZhE0gete01OVehbi8bnU8H5S5FP8zd0Fuj
 L1vhJC0EgsCCH5gQosDt1EiTo2E4G1Qbcl6nCdNHZ9utvFpTVJdhFepKEgCNFW5i19LNsm/2iL5
 p52DdClaGTzV2dIgtt+Z+U3GyDNSWPD6Gq7Einf0u2rTlr/mVIdd2qrfZHufM6Wy5iwRh8rwWXF
 PV6/VZSF1ZanMLXmrd7dZGzzWzXWQ8QIGFjjeoanuq3+OjvZujYObKMsjj2LqDr135J0Q9EkFy0
 KTxr+mQbLbXm7PQ43n5jUqoYV3hkZn23sLhyjZDBy1ZdXgeE2nKdVgw2+x69DZrr20R/SterZ3N
 vOnvCBOEUs7wGAbeumif+lZags+IzCiciq+1vKhCiuRTgKCN8m5QZh8rgp6RKyXp2pbB3lQcI9P
 XwsdpZU9NfBPGsz1HkcHxEBx45I7FpvP5gt/OmQjIEhBP4wiAR9ScmBP0SYpx5GqfOiHKPrF+zB
 a22wv0NXEVu4Pvh17uBxlXlD89bfI7JeYCCuaRKKIec8I0yEcCty0n5dpecYhMIQw/14+RZHbiv
 c6YaOuA0U9cG/6gLTrjwsf3EmvzIal+UBO+5QBanDWk7HCRMc=
X-Received: by 2002:a05:6000:26cb:b0:491:e062:383d with SMTP id
 ffacd0b85a97d-4928030bd26mr11383264f8f.57.1794061986396; 
 Sat, 07 Nov 2026 06:33:06 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:05 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 11/35] arm64: dts: st: add sdmmc2 pins for stm32mp25
Date: Sat,  7 Nov 2026 15:32:01 +0100
Message-ID: <20261107143241.2236511-12-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
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

Add the sdmmc2 pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-12-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 17d813da16896a7ced144acf41bf7edc419a9fe5 ]

(cherry picked from commit 9bf2959090b5831f7ac2caf05aa880768def9f32)
---

(no changes since v1)

 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
index 002fbc724b9d..c816a6aece47 100644
--- a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
@@ -622,6 +622,86 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	sdmmc2_b4_pins_a: sdmmc2-b4-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('E', 13, AF12)>, /* SDMMC2_D0 */
+				 <STM32_PINMUX('E', 11, AF12)>, /* SDMMC2_D1 */
+				 <STM32_PINMUX('E', 8, AF12)>, /* SDMMC2_D2 */
+				 <STM32_PINMUX('E', 12, AF12)>, /* SDMMC2_D3 */
+				 <STM32_PINMUX('E', 15, AF12)>; /* SDMMC2_CMD */
+			slew-rate = <1>;
+			drive-push-pull;
+			bias-pull-up;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('E', 14, AF12)>; /* SDMMC2_CK */
+			slew-rate = <2>;
+			drive-push-pull;
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	sdmmc2_b4_od_pins_a: sdmmc2-b4-od-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('E', 13, AF12)>, /* SDMMC2_D0 */
+				 <STM32_PINMUX('E', 11, AF12)>, /* SDMMC2_D1 */
+				 <STM32_PINMUX('E', 8, AF12)>, /* SDMMC2_D2 */
+				 <STM32_PINMUX('E', 12, AF12)>; /* SDMMC2_D3 */
+			slew-rate = <1>;
+			drive-push-pull;
+			bias-pull-up;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('E', 14, AF12)>; /* SDMMC2_CK */
+			slew-rate = <2>;
+			drive-push-pull;
+			bias-disable;
+		};
+		pins3 {
+			pinmux = <STM32_PINMUX('E', 15, AF12)>; /* SDMMC2_CMD */
+			slew-rate = <1>;
+			drive-open-drain;
+			bias-pull-up;
+		};
+	};
+
+	/omit-if-no-ref/
+	sdmmc2_b4_sleep_pins_a: sdmmc2-b4-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('E', 13, ANALOG)>, /* SDMMC2_D0 */
+				 <STM32_PINMUX('E', 11, ANALOG)>, /* SDMMC2_D1 */
+				 <STM32_PINMUX('E', 8, ANALOG)>, /* SDMMC2_D2 */
+				 <STM32_PINMUX('E', 12, ANALOG)>, /* SDMMC2_D3 */
+				 <STM32_PINMUX('E', 14, ANALOG)>, /* SDMMC2_CK */
+				 <STM32_PINMUX('E', 15, ANALOG)>; /* SDMMC2_CMD */
+		};
+	};
+
+	/omit-if-no-ref/
+	sdmmc2_d47_pins_a: sdmmc2-d47-0 {
+		pins {
+			pinmux = <STM32_PINMUX('E', 10, AF12)>, /* SDMMC2_D4 */
+				 <STM32_PINMUX('E', 9, AF12)>, /* SDMMC2_D5 */
+				 <STM32_PINMUX('E', 6, AF12)>, /* SDMMC2_D6 */
+				 <STM32_PINMUX('E', 7, AF12)>; /* SDMMC2_D7 */
+			slew-rate = <1>;
+			drive-push-pull;
+			bias-pull-up;
+		};
+	};
+
+	/omit-if-no-ref/
+	sdmmc2_d47_sleep_pins_a: sdmmc2-d47-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('E', 10, ANALOG)>, /* SDMMC2_D4 */
+				 <STM32_PINMUX('E', 9, ANALOG)>, /* SDMMC2_D5 */
+				 <STM32_PINMUX('E', 6, ANALOG)>, /* SDMMC2_D6 */
+				 <STM32_PINMUX('E', 7, ANALOG)>; /* SDMMC2_D7 */
+		};
+	};
+
 	/omit-if-no-ref/
 	spi3_pins_a: spi3-0 {
 		pins1 {
-- 
2.43.0

