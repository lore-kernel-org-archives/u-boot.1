Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7171CC5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 15:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4102488152;
	Fri,  1 Mar 2024 16:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XUn4jZOd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F19068814E; Fri,  1 Mar 2024 16:10:40 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1557A8814F
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 16:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d269b2ff48so24093441fa.3
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 07:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709305837; x=1709910637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BJl1619jm9X5o0UBJOFjmFC/HLI05JzdHp/9A4qjZq8=;
 b=XUn4jZOdrFj9LDlVGDFePa2kBZ4A/zvsAvzB21X/Ek/RczJ3+tNBKqcQcCMmKPZa5C
 zr+J8ChPc29BbEe8pAr0tPPaTR4KBBnuex3PdDdTvD/lh5DH///DCj7I7jPjJpXRS5gQ
 cmDl7t+woJzOhIKdcg2TwUzoTmEYT++cVHwUWUFS1q7BPv96vYsWWuFWuaZxhOhwWOHm
 1Ugxj51NEtxzcyUSW2c6MLAYz9OBGLt76iPruohsERQMRwTrn8xWNCJtUwwhnreNHVCO
 ClOsHG0JtipOht8hU0mNgMorUAd0/IjXwLc/f6koVGmpmV979EdkY1ckfbegMrHc3Sdb
 B9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709305837; x=1709910637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BJl1619jm9X5o0UBJOFjmFC/HLI05JzdHp/9A4qjZq8=;
 b=dhTmwE/aoIssGmVWwSMA7w/5vW1hspb8x3Gle/wyOjYVscVEKHmX2swNJO8pHebj3F
 gYd7qOb3hQqEENBrh/sNS0pYQ4Nh0OY82gZeL4bg7UQmIN7UsDl4rfSFDh6KURfTKtV/
 DCkpNZDObH6M4pcQBQ4IlLfzGSrqVkD9a060BNRL8XtAPEU9DMZ/xzycHS2wf3Xij/fU
 XKvl9Lyqm3m3rmJ6/uMYdWVANJi8YTFcBv9wr25BTzt8QyctWcw0caXCfbJ+dsrgbIIz
 ApyrP2CMCeX3L0g0YLS07TOUujgy0CFl4U4F755lsqO1Q2HplnQ5iGGk+PuR1HiJq6b3
 y8/g==
X-Gm-Message-State: AOJu0Yyk2InutlM0iwmmDwNIDHKUpYgAO2fsQwZAp+ktcmB4ezLtPHSv
 yGAZKVZBHIIrwgXb6oZh/TvNDUdEHKSIIhbVYn6/l17FGI9F24hRjkX5EH/0P5M=
X-Google-Smtp-Source: AGHT+IFGz8e9msIZGEW0gBaZ0NP59Nygv1Dty4Xuf3XU4MPI8rMVdr1w6HA9lWt7Or0KwakH2rEiQA==
X-Received: by 2002:a2e:98d3:0:b0:2d2:eeda:c019 with SMTP id
 s19-20020a2e98d3000000b002d2eedac019mr1269221ljj.28.1709305837325; 
 Fri, 01 Mar 2024 07:10:37 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-232.as13285.net.
 [92.17.96.232]) by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c4ece00b00412b775e979sm5843614wmq.2.2024.03.01.07.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 07:10:36 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] clk/qcom: apq8016: allow apq8016_clk_init_uart() to be
 called externally
Date: Fri,  1 Mar 2024 15:10:26 +0000
Message-ID: <170930580024.4192355.3301469460987026995.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240301150651.4181574-1-caleb.connolly@linaro.org>
References: <20240301150651.4181574-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Fri, 01 Mar 2024 15:00:24 +0000, Caleb Connolly wrote:
> When U-Boot as running as the first stage bootloader on MSM8916 devices,
> early debug UART requires turning on the clocks (for some reason the
> pre-loader turns them off?!).
> 
> To simplify developing for this platform, allow the
> apq8016_clk_init_uart() function to be called externally. Developers can
> call this from the serial_msm debug uart driver to configure the clocks
> before the driver model is available.
> 
> [...]

Applied, thanks!

[1/1] clk/qcom: apq8016: allow apq8016_clk_init_uart() to be called externally
      commit: cbf3152f6afff25c25aa69ae06488671ca0aa765

Best regards,
-- 
// Caleb (they/them)

