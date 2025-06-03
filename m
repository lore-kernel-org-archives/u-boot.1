Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD65C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 15:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B6B682AE1;
	Tue,  3 Jun 2025 17:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YEM/z6ZL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E23082B0E; Tue,  3 Jun 2025 17:00:48 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68B738091A
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 17:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-451d54214adso23856075e9.3
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748962845; x=1749567645; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s8sfm4nR2W7/JdoxD5G8tYOAGyIO1nKH3gdBUug1vbw=;
 b=YEM/z6ZLgOs1Y38d3y0vwsThRp8M5c+dtReg2UgFRWqV9gVJBic6RJOixVOIgkvsJA
 TyTAZpJmOBDkQwBI7gD6MiIpdo7NR5X8aOOMCCNGRuRccZxnlgdVl3l6wTwjwkzeASTS
 dfxaWpexMQ9jpu5cIxkhTa9m/nsmCeZlHBgcoNjPBNAIXZgwjjJNNkjq+Xsu2XxSBqBI
 ynXP+aBnAhB+lZIRyzKsjs8fEuefj5PfxNGds5mTp90+5Wbtj90ZSO2zskuZ1oRxE4T9
 u0BlN49F9iG6hyVBvcTfO0bNXFyHaxRNdbqfOanZyRpUg1I1a8HA7LT26hfZR31hocE3
 VMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748962845; x=1749567645;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s8sfm4nR2W7/JdoxD5G8tYOAGyIO1nKH3gdBUug1vbw=;
 b=oH3zMQFuCuAF2N0PLWD9LEhzZluluo5vKoSadrM72X8XAMUepRFNiAd+6XCGDpcOTN
 TaRjAV+2waRg2tWrMlXuzGWavR/ahp/esKzLm6OlMlER1axTp5sjTjhghNfBFSRw2a7o
 00f67IpXg5k8/bKpSu5QyekWLHtzEbrrAg10YMYDCF+tpMW82/LoVjN3CGxvwT2zTmbZ
 Fx6nUONktguZgbkUDZKN7l28USHC0FjBrkz2izSFe5lH3WntRk+ZaENunkZ7XHfgRDUT
 AGy2wUXyPafkXfEA2KNlezcGchPxCL2YqIunxRMslsSmdDV5l8MFWDR31JcQ1HyEgUtT
 FRtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYdLUD/YK6yUxImjhmqLw9PtkGmwur7sEt93H4z7cO70J6x/E9loPrcqYOSC6VPkHtMKliHBY=@lists.denx.de
X-Gm-Message-State: AOJu0Yyz+X6QCQkJ3svGf6Kb0ybyQ7+VGS+nkpTlo5NGGKbIUQ+uK8ri
 R7FVTvh0r1Kn69xNcYgsYsdfdqrfsNz0VvB5rfQDZKBBCileYu3EcQOoCeK9l7PboL4=
X-Gm-Gg: ASbGnctXAB/8fT/A68OeyArzXC1hInTX+PVDzTEdGemgrtyVIgrS7Z7gF2ThiaM1zE3
 YY03UlrZWhc/68RN2GjAQnkN7y3TfRUME8HnE8BgCU6uh1tcpNQfODix742wN20zeX97dFSlN+T
 vDbAyEUrUPLXV7Cu8LlauBnjDGgQhQvCvkvmGRHOJ0iHghpVYn9+3VQurHZ82sX+QUwDJ5vvGU8
 6hYercuari8qja6aJe58iiU5DBB1DmmE/owaLyBA3icw4MHGu6W1TE0rmJWt6byHGdnCmVlp5Oi
 UlsgZXDYGVj0jTWjHfeEo7SuG5NZ8jSTiL1JTmsLqFK4+M08wy/eHTKSsjsSYe5ZGvCC22Rpy8s
 5
X-Google-Smtp-Source: AGHT+IHG0yHopPEWZ1CCGKym9tYmtiqCDm5VCA7sRnnjN1CdCXdJSFPslryyFeMpvbjJRVXlAmlq5A==
X-Received: by 2002:a05:600c:4688:b0:44a:ac77:26d5 with SMTP id
 5b1f17b1804b1-450d64fedb2mr174273615e9.14.1748962844608; 
 Tue, 03 Jun 2025 08:00:44 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a01:170:117e:fc:e089:f4a9:4c4d:e359])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451e5496282sm19845165e9.1.2025.06.03.08.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 08:00:43 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250424-apq8016-clock-fixes2-v2-0-fcc371c9e45f@linaro.org>
References: <20250424-apq8016-clock-fixes2-v2-0-fcc371c9e45f@linaro.org>
Subject: Re: [PATCH v2 0/6] clk: qcom: apq8016: Clock fixes for U-Boot v2025.07
Message-Id: <174896284320.1020546.5587892671229800884.b4-ty@linaro.org>
Date: Tue, 03 Jun 2025 17:00:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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


On Thu, 24 Apr 2025 11:16:40 +0200, Stephan Gerhold wrote:
> Fix some issues in the clock-apq8016 driver that I noticed while testing
> U-Boot v2025.07-rc on the DragonBoard 410c. Make it possible to poll the
> clock status with GATE_CLK() to avoid potential race conditions.
> 
> 

Applied, thanks!

[1/6] clk: qcom: apq8016: Fix SDCC clock addresses
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/3d9e6d42ca14
[2/6] clk: qcom: Move qcom_gate_clk_en() to C file
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/409da8c49353
[3/6] clk: qcom: Use setbits_le32() for qcom_gate_clk_en()
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/94e57ba2011b
[4/6] clk: qcom: Allow polling for clock status in qcom_gate_clk_en()
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/6c049ed99392
[5/6] clk: qcom: apq8016: Convert GATE_CLK() to GATE_CLK_POLLED()
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/9d9bac00bc07
[6/6] clk: qcom: apq8016: Fix SDCC clock warnings
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/1079d4bf2ed8

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

