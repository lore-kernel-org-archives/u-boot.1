Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B985F606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aztA++vt;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=jB0jnj6S
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 902BF40754;
	Wed,  4 Nov 2026 08:51:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L5PXV7EvCfIu; Wed,  4 Nov 2026 08:51:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A30D040768
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782290;
	b=FaSyALbDZMeSzwmX5KuNnDX5hSYcZPd+6wxCuYoGlndlNGHgI6Q+2glL7SUWJnUxh4Vf
	 2Lf3bI0v2Li3U9lgVC+sKTQcTC4NFdGxdNqbErx9Apcgz4eS8CVH0aF6HogSpgkEHLh/+
	 JKuWMPfU2nOx5B79xiSzFtV04PJW3UEt6NU+qkUxUszFmFLbDHBlyVPKC+kw0qHTFkMS4
	 PqasGtEQcf22WTLoDtEMkk49d31thEkjeDVHbYcyEj6+w67aE3kNnA/hTDYpWztn0Vejp
	 5QDFeoTgUiypXqiJSZOPK0z7DFBw6XJmtZdPUczAsCRHgTRcTBHDsCoQtCiGeGZuG2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782290;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=32yx6jCyTSMQjaChKqovx2lLLa7OeYlUHAY+TZjY1rM=;
	b=laylrOvee/fDKRdD7Meobjg4TvivSdNF5PW2GYPZ11PEQng6z7YqddfMf6GpQq1m4rNB
	 S0b2mjPgJVnDwTb78aABAo+dNxkkURhnH3AXombLO8j1m+zyPkK0BGcPe9eQvtbCdbEX/
	 OXyYX/UAPpESMjQEaqDUUjodCOXlyNsLAPh2TDffsSsXZtuWLZRlyXC7/7QH7NcqFIxay
	 d1cG+VD5ey33t+ch92tDqtnSlQH2huaKxnWIWXhl5sLB7zCyxuXMhcroW6wF4n9S9Vxb5
	 eMi+OPbA2+p6hf0XtTunow9L6Vy+29uX2wh87m53SWLo0FzQbMzCZ5oO4zYdIihdRpA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782290;
	bh=32yx6jCyTSMQjaChKqovx2lLLa7OeYlUHAY+TZjY1rM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aztA++vtLY2vaWHJYy+Vgvw0QrhIC1gmdoIsKkOXo0k1CGTszLtfIJBqrKRkShgo+
	 sDzulF/3hDr0JVjn57mtjDvNkJ5nS5rOV5pHQurCxyahFsxaZvWuokHfFHrvle+0f7
	 BOm91Qvl697KuQaXN47KlbGpts10ZzvSoKTehUks3//iU8fyXH0BKPc57mjiYWkr7o
	 VsrIhFAxylq7NIzd/ef7d/O4S8bhzOLgXJMyC31Dn3aa7f1gTTRFb5bBKvw0MEtWeb
	 GZBm8raQYO9xx/ArD08OUrvobB60pUjqTzfk9/vyTYtfaU0w8hAPy6ZZ8WdSO6cHEa
	 iH38lHgovtZ4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A30D040768;
	Wed,  4 Nov 2026 08:51:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AEC3A10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5893F401FD
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jmQ3-GMMsjTk for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:51:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3F8FA4004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782288;
 b=fLLoOdDAv1e4RW8PYijCEA4Xu5XhR1M5iUAuwVM0TC/39FjMRcIqmqClOjs2iSE7yP3q
 y3BKuhT0MuWINE5ZTkWeOJBAQXukBeGYchM0jQU1J/5nKEELui8unvRtchm/Xm5SbpVvu
 UqDm8U8XdzBoLeFZdBGLGDSHb2RBXq4vZ/2oGcec0TY0wOtgA06EhzSyeDTZ14AKLyNCf
 nOwBCtBIyoO81SwS8MgrbejCC3FJmVh5z4PZpUoEYAEg9znPWYiKMqjRvncBo5a3Nvkh3
 rIbEFjjjoxfD6e/H3cufWYRXRG0MyEPw9BEDezq0a10zzkRSprtkFEC0LkMmjr4zK2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782288;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=32yx6jCyTSMQjaChKqovx2lLLa7OeYlUHAY+TZjY1rM=;
 b=NR+Q/3KF9APl3d1tCswgzNRpOJpU6HNLo2xS7s254bXxCuttO/60/HJZeAdl0CStraIb
 2v/oO72ynVPkFkghZqXiRC+luAr24rFrB2Znw2IPjIt0dgXtpL1mMZycy9dsK/uGlRqAr
 +gRphy8qYkXeCL5136fgs1n6/cHB9KLN6iBdL6ICN08QhgisndeywyEHRo7ad0iHhzOpZ
 1u70B1cs/kHulHGM7UEjgaAblCGaIgcNKj/BmTtz8ajSTNGkL3Q2pvK11xG4wIA/2htDs
 yymLOwWCsUQgOvQvYFfMyb5W+x1l7/rjty0FqVqP3jaYrrPHjicXVK0l+PYwjBr/viQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=jB0jnj6S; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=jB0jnj6S
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F8FA4004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:26 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso2550155e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782285; x=1794387085;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=32yx6jCyTSMQjaChKqovx2lLLa7OeYlUHAY+TZjY1rM=;
 b=jB0jnj6S/BNlTxuBDXdVnOfLl3gLXMGsRk88Hk5SM1h161D+KsHBExlogQNTjvhe2J
 PPh2JBBHMe5Yct283R8EwT2CT/rSNwuIvCLQy/fKwQ2a5Zq5s7Rxmw4Hiy+tnKt4cDXo
 we0oT4CQ5ksce75KS9yTZhXCqR3zq6Cun2Sec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782285; x=1794387085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=32yx6jCyTSMQjaChKqovx2lLLa7OeYlUHAY+TZjY1rM=;
 b=YI9vX0U3ECS/ivJXu8c8dTsgKzyCqr7hpIgsXQekUm8w08c4GvMukSFNpiTI+GF8D7
 SRH2XgZasfhEgxGo6LwT3tLIRLayis7Qxki9qHiE2cQLmD5z+L61rTFXlTfnZPdeQN4C
 iRrbSoBm5Hjq67z/4I79UPWh0Jb2NRi83pH8WMTTA96rBvVWCLoFnoYSHERxFkY8J3GF
 8o/52R74qOtAQl7nyrdE7b/saJiPHewkQ1CuYsP29UqSnxnDYS7IKC3RdLMYXYDiFjvj
 6kN6O2Fz1+fkMpEAGfNm8pKa9CVA2AnK1JEiA2wLkL/EZOh2/7OJPk65yORqGYBwdYJj
 Rifg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvEQJKeaA18EpAyBxNYt7o1cq7ikdKWVIsFlqbKHCHCfpBZEEd5n01IZkT8Skt6OYhyOzi6KY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+jhusoEObGt8SZek6h8/zhTIAXgAKWInJYmNNn7FTJy/zBdTJ1
 ZAs1JgR7fphMyQ+Sh8rl8ZryaAjDz2cYpMQiisCWRpHCZH7zfa/y3tU61LD2tGDFHv4=
X-Gm-Gg: AYBFou1SzdIjteOrNGly0LsiN5O8OtdATx9o7Y6AbMTGJtNK+bq9StQFTUatuVTTEiD
 XO21Ct+2uWhZ/G6L3ERTAB3eksltWTuJyQ4j5BX/nJhZ640cbsXsFtoOMGgVC2X7emQmSUdsSuf
 w8IN99HYRq/9qJMh8Yca4i1/+ygHeseC0JqvlvJNU4i1w/xdOj+34eJJctJ9qiiUfsqi45nDhuP
 CtE/6z1mu7wTFMPW1Lzm2U6BiRSiljCBlFiHai0CTMuiQrT8gxTOAICccf682TuCNFazKXCEAxy
 2e0G9vM3Z3JkIs0DfydfhgMf/hs95+ZhHT3fkuzkf3OclRdB9TGtXbXz8VZhYNZRi8x79S8x6Em
 7gKiGpuxWxEAWh4T+B5KcY25viPeVyFGknnEa+QNWJlHad4f1R360FdEU637z2D4WTQQdlp70f5
 If6oyMSIFgqVpLUCiTfl0ivWFTfb1DTdIu3a/vzS5oxfNaK3012FqNFQsPGshw8K8GG/vuy8/Y5
 N8Z8ida46wuGoUdqo8HU73RvhvXtbmvO9aaHU/0XqjmSOx0VNcoL3qxoeRwim3ckIghyjT7Qigx
 ZU2s5oolAQg7/pkIHHHDLVizcFRAJeqM3Fg263K4/rRZc8LsPcs9mAb867XkEJoCjSE9il4Hlzm
 kynS0gIilw9AphUkhe9+9HFlMoYyEutNF6BipQnd5McHKkweU
X-Received: by 2002:a05:600c:524c:b0:4a1:e6c5:e44c with SMTP id
 5b1f17b1804b1-4ac17470f97mr361537805e9.10.1793782284949; 
 Wed, 04 Nov 2026 00:51:24 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:51:24 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 11/33] arm64: dts: st: add sdmmc2 pins for stm32mp25
Date: Wed,  4 Nov 2026 09:49:44 +0100
Message-ID: <20261104085036.4012238-12-dario.binacchi@amarulasolutions.com>
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

Add the sdmmc2 pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-12-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 17d813da16896a7ced144acf41bf7edc419a9fe5 ]

(cherry picked from commit 9bf2959090b5831f7ac2caf05aa880768def9f32)
---

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

