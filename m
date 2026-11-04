Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59F5606A332
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=P8fROKyy;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=f/YJ8hjY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE47C80F80;
	Wed,  4 Nov 2026 08:51:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vJCeKYkYSMXd; Wed,  4 Nov 2026 08:51:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BAAF180E83
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782286;
	b=FQrlUF7o4XRYZ1klfvLRK+AeAet10UXyyV1LzKQnScEu/1zv4sVBoelPLNG+59UqTOJv
	 rkNAk6xX0N35TnLqy+fT7y/TTc0mShai4bbno61UKRfSNDqwu+bxikum72/1mGpdyFbbD
	 UJRPFl9PtNfwCajlEz94Kv0NX5TI9PTVGWtyDxwzBaeWhUaRWqL34lSaVB5AOI6Kfbvkh
	 wjlpgUAOFWWq9HwezS1ywCax/9sZuu96jQwOkNnMNREkqxvyuUezzNz1ZF8cwltxhhS8v
	 0mTRqnewn1/xSZXPFq/ncfQt3iMdp1nvRuzjtxzyTMQNMD6w2JFe3yh2+KbSlOL3czw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782286;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vAPqI3v5lQUOQgRIIt8ob8JK9hjKKecK2HosXv3af/Q=;
	b=kaDAwYIJECmT9qGN3iTjqpyJkqQFCat22UaJXRP1u1tCbSIR/RQjmkPCsOLLTR2rIto7
	 HpZeD0aNaemuLsZyD69tWX/eJPER4fzomeH9fTLLDIkyTx5uKt7nk/7Hbo03y8EguT+54
	 AwKJDV7t/HGY9zi2pvL0udxmUDb1/o3gsN9rjXCXiHOaHyNBMT6Cbha1jcz8zPO5+5GwD
	 X2VN7thQxzS/FP2jJegR3oiK8h7d0QeRKFDk2ewPqtLSKkvwK83hRJNxDeDo0S/wrW9Ov
	 CJ8iLH65SqregZcG4oz4pjVc7CzdLJCq+cITUtkKBSiMbJRCQ931k3SyHaUu2w4O6pA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782286;
	bh=vAPqI3v5lQUOQgRIIt8ob8JK9hjKKecK2HosXv3af/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P8fROKyyLuMQd7fz9fnOC+aI6OJAc3Y7mNsSxUxLct1NMkto84VhAna11XbvqIQjr
	 spKoxErs+EiwJH53pw3sZaY7vr7mT5n+7TPi2xMTJVzzmmRU+2OAIiF1kZW3pBCHY9
	 NcGr793SeVr9JM9PZ4UQhkUEWaNXUvZWvmGcqRyV2m6vIRIabn7EitY8DvegDDcxmP
	 04WJoxjStleLv+ErmX7ZZdPblpU83RUAUTKIGHH0P69ljeFMoRC4P91GCK2wxQBrHY
	 o1KCb9B4iIUls9UsoR/Nasr5ysamwHzVLz/G2CRO4jF0mS63DSJMXv1wYIzNe438Eo
	 wrQLGrMBlnApA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAAF180E83;
	Wed,  4 Nov 2026 08:51:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CCB99C4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 39FF940768
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DtDZLYLPZ8sN for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:51:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2A0CA40764
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782284;
 b=p44G3rk22t2tqrS78rjdU3HmsagcyWE6RqzDJTfAHPA1gJ8SgG/TMTF0PyXQ69bJxF/h
 ZiejIJpLfHxk5FYhPKTgWub3BcflF/0EjFL5V4Sk/Es+bKmkHsB+QHlboCYEA1tkHnKe1
 2FRfR/qbUBF76op8880T1+eykNnVx8ppE9+UvYjd6hvHg8E52An5TitZB+5W1Vha37Kva
 N7Dem3B+EA3W71Hs+PeI/dhyXrfC21MkRZ5t7mA0SDt2pmDk7RqOQ1eQkL50irFoXlhMs
 RWF96HimZPqpCwoiKwlGYJCblrGaOQEXoOD1NPtpzww3E/JsybxDUSJLCADFY6qcAsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782284;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=vAPqI3v5lQUOQgRIIt8ob8JK9hjKKecK2HosXv3af/Q=;
 b=ptF29uF+qnuLzBdl50Gu9Qh61sAjdn8bNGodcz1rgvR+Us3rg1zKcnwNrQgF2EHkLPXc
 DhxcKvYeXTocERPPTbn1R40eHWnji48XqQGQ9SV0KxLsrbCPiV7vHra/lZDER6Uc0qO9b
 ufiFarBoVR/I3t7zPKvcJfXXntUTqIwlBaaG2r4hg1PBm7eGZywonMdJG5CS9Wgzl6bG2
 zVFA+wVinQg8kNx6BFn7rtOnnfIPs7kElvyM3ho5zVB73cScxRd+0gjUQwwqynToRAih/
 8hUoJcFzDRJrnsigQ3cuQioNcz/sL+wPUusZoQPLcgnD6K3jarK1ikWofw9M6Aw/kqw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b="f/YJ8hjY"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=f/YJ8hjY
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A0CA40764
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:23 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so4605915e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782282; x=1794387082;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vAPqI3v5lQUOQgRIIt8ob8JK9hjKKecK2HosXv3af/Q=;
 b=f/YJ8hjYVW/pgXYAPmYiJ/C6J4UtZYmlDYmO90rA2Ie5lyI9aF6ay5c05ZhcWs/9a0
 4Bic3AA4OoqUyAY1TEszQxdAP2ygFGT4Ct/OGTi+urI89BD6R4MA7wxtiLrVdoeDDvS1
 4t2+DT1wBmKkTeoXP6PJv8E0JCBhcoF7yUiqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782282; x=1794387082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vAPqI3v5lQUOQgRIIt8ob8JK9hjKKecK2HosXv3af/Q=;
 b=pIv+2C76NSFLGl3Nt76u3CJqLQLSAOxxyF/OkgtgPfwMMp63PNcLOjOOvlIOJADBqr
 Eu2UmPS7qbdSGFXYnaBZal42nLtfGSEcsMHHru7G/oEyW4fLRYD4ml3WwPOgb0sQEPUk
 xqTn9APNHHGsfiG8AeFkVG7hXUnGVES7tnj/dpN1f6UdwCqaz5Uu5wGeJ2JZk/V2OuYO
 8OwCo/DnE5xevEJdGs9iT9ZJZLP/xP2SIMIKSyRpAWUBTe3y/DYz4x9320uovxB21Gk/
 NaYZEN6a9xg3K/NMwPlXo6phwJSCTmQceCziY/+A6/HtkZQzyx7hbYwzlNqITDhSYlVb
 B+og==
X-Forwarded-Encrypted: i=1;
 AKwUvBzv18CKhF0hSPUC7P2QUEA8shAc4UwXO/QchCgKZvMXF49pAYT2tP9GiqiD7WTpgTTbe9L2pEE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9EKdcIycyfmYbyS2p/vGHHSLeKfcBvXOgfQCjrA731k7unVuRr
 ylVb9zeIURdHpiwsBbCFDX+m9F+n7ypD4Rrj7AlVB8DHnhekvCfGFHHznNxEG7h4L8Y=
X-Gm-Gg: AYBFou25ZI4sIxIoNPsvcrvQGJlX2lVmohchXPGNPvgRTRKHt2yaHab3ln54apiHwB0
 H9/ICCHd+IYX3r81oSfQTFVNveU2oN06BROo3pJCfvB823rxWEJUAmPDCW4ax6kgj1g6rm6PRmA
 cSvFRWMYb1ype0wPhkAOa/8a3Dnz9plKme2mdvo3W6bOGbEAHUgdW2kohMI78Av80wdcAFXo8SZ
 FCdhzaVHSd/nGOhWRDdU4jta3nGX8tvnY+NO5BcY/3ose1Q8/ZJq6eEK2/wi4IklybJoSQat6kn
 apypRJqUjoOdQ5hdLntZ4VBgNrx3uAozMV1tej42ZJd29NlF73iy98X9XcaMDCOOEMPEmPqO5zw
 Ps5YicrBTW5bXcG31e9bR5BMqtS13YnlTRA/8/vGnv+P/AZGVd2TGp3AQK1WLGuUSlZK9mT/q9i
 uqQpBLYs5125uYC9Yw3yPMBiB7tlPl/LGG0+2sF9+Ptv4YItosgYQ99XZGu9xRMZug9tXtp2/KC
 4u3li/HDkE88tiXXgk1aHiu2x8nVvlsNddejT9Y9JpMEW2TpAMpd26XQ3JK7UeB3TfssuGDZEMV
 876drbQZjm0ZNxPoO+jsBMLoqNSHz/hdmn1dmzQdbDhm7KS/AcRgPCeiYJQL65cgyXoThhGO+H1
 eZknCdTWX0PtCSvMAW2HWKOMg12M=
X-Received: by 2002:a05:600c:1f87:b0:4a1:f68a:9736 with SMTP id
 5b1f17b1804b1-4ac17b2be08mr352772055e9.26.1793782282076; 
 Wed, 04 Nov 2026 00:51:22 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:51:21 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 10/33] arm64: dts: st: add sai1 pins for stm32mp25
Date: Wed,  4 Nov 2026 09:49:43 +0100
Message-ID: <20261104085036.4012238-11-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the sai1 pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
Link: https://lore.kernel.org/r/20260820091652.43541-11-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: ec9e6b832ff186db9fe4a8c9e57ed120669229d7 ]

(cherry picked from commit efe29427df55d919eb9bbb319e6f4acdfd14f4bf)
---

 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
index 695c9d771853..002fbc724b9d 100644
--- a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
@@ -520,6 +520,51 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	sai1a_pins_a: sai1a-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('D', 9, AF3)>, /* SAI1_SD_A */
+				 <STM32_PINMUX('D', 8, AF3)>, /* SAI1_FS_A */
+				 <STM32_PINMUX('D', 10, AF3)>; /* SAI1_SCK_A */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('D', 11, AF3)>; /* SAI1_MCLK_A */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <2>;
+		};
+	};
+
+	/omit-if-no-ref/
+	sai1a_sleep_pins_a: sai1a-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 9, ANALOG)>, /* SAI1_SD_A */
+				 <STM32_PINMUX('D', 8, ANALOG)>, /* SAI1_FS_A */
+				 <STM32_PINMUX('D', 10, ANALOG)>, /* SAI1_SCK_A */
+				 <STM32_PINMUX('D', 11, ANALOG)>; /* SAI1_MCLK_A */
+		};
+	};
+
+	/omit-if-no-ref/
+	sai1b_pins_a: sai1b-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 4, AF4)>; /* SAI1_SD_B */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	/omit-if-no-ref/
+	sai1b_sleep_pins_a: sai1b-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 4, ANALOG)>; /* SAI1_SD_B */
+		};
+	};
+
 	/omit-if-no-ref/
 	sdmmc1_b4_pins_a: sdmmc1-b4-0 {
 		pins1 {
-- 
2.43.0

