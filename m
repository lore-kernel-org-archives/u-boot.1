Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30394C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 18:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86B61880F8;
	Mon, 15 Apr 2024 20:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oG22QLxy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF458820E; Mon, 15 Apr 2024 20:45:54 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A50DD880F8
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 20:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2da84f93c99so13296601fa.1
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 11:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713206752; x=1713811552; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2m5rnLj+gzIaEb2hj/05hDDCJBYnAup40KsQdoZg/tQ=;
 b=oG22QLxysKzG5FCshbKzmvi3EIKBNTUOxCamjZySHa38RbqR+MOCvCndgBfoLpsY2G
 rLhvUxpdWR7pgyb4y/A9oAMnBGBEUBrk1aiUJCeC31DRSqH8SM9Nn2LuNpdXC1xwLEdp
 cygNNrJ2Pi4RyXnaGMshfG34H+bt3zwhtVKGvIVkFD9G5duRKUlCvQ+hbKwcp1kqOVq3
 Hn3NfiysI9KRguMpyhMVZR/DMuoVjpoY7fC+61WmNNJK/VX3DOsZoXzcw4mzY6eFlL/E
 jhhDPFbYMwhMMRmUtSplJOFro/duyCzhGCwh3iZnPBaUDjvsP4psqPHXL7sIW/hFUb4D
 OrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713206752; x=1713811552;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2m5rnLj+gzIaEb2hj/05hDDCJBYnAup40KsQdoZg/tQ=;
 b=kOMz3i7fIabcQLYhWlgu2fV1caO47/4EOA3mKGQr9NSs+ALTTaBTWjLjPRHvQJMWao
 J97edrK2VBc1QLdrEiLb5rWAu6Ipu+KlOol2Gxnk7EztvjCOseP1A4BhhE/Xzxm4hrK4
 jYwObL+zAvYEY+UVtZyv6w9iVv+9tW3HFbL8Wa3h8W2qRbSaQK9Qg2TtG8LzyKaR7KMf
 zUeBeby4oujEMYxJZFVi7h6kW2Rj8yVNaZOM9sL3MgvH6gEWoUaxilKXbm8eiIk57frQ
 53g9maQgDdLtJ5DdWE/UTKot/J2/kpZWTDnqYxqojmxUSXCnYAS9p3/FHy/V9Omo+Qwq
 TS9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwa6lfcDbLHTwY2ZQbIly8PMUNNJydrAChZpnQ5XG8365kEIM/VKEAP6iDMsOCFUM5p3DQkm4lRWRb9i5oa9lz/Q39DQ==
X-Gm-Message-State: AOJu0YxMn75/Hcr1O3I9HntBjCD7T6eUEpPX7YNo3sspv2liP++O8cKR
 rZACqLcJGY9Yybh4lWQQ4kzbXsNz9GaxdTBg0aTL7J3a9t8NCgU9A/PMF7DexJggV1Ht4q8qjgX
 c
X-Google-Smtp-Source: AGHT+IGcBC8S2b07YNRHr1k+p0ztlSvBxtxKQP/XgzwVQJK6F9hOarSc8uuIlfNtVo+hPPG1rQTYeA==
X-Received: by 2002:a2e:2e19:0:b0:2d8:ab59:f1c4 with SMTP id
 u25-20020a2e2e19000000b002d8ab59f1c4mr8696223lju.38.1713206751949; 
 Mon, 15 Apr 2024 11:45:51 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 d15-20020a056000114f00b00346d3a626b8sm11893568wrx.3.2024.04.15.11.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 11:45:50 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Robert Marko <robert.marko@sartura.hr>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
In-Reply-To: <20240415-b4-msm-serial-bitrate-v2-0-b7a048adc6a3@linaro.org>
References: <20240415-b4-msm-serial-bitrate-v2-0-b7a048adc6a3@linaro.org>
Subject: Re: [PATCH v2 0/3] qcom: serial_msm: calculate UARTDM_CSR
 automatically
Message-Id: <171320675053.436135.3981359920560487631.b4-ty@linaro.org>
Date: Mon, 15 Apr 2024 19:45:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Mon, 15 Apr 2024 16:03:37 +0100, Caleb Connolly wrote:
> The msm serial UART controller has a bit clock divider register which
> much be programmed based on the UART clock. This changes per soc and
> currently is expected to be specified in DT or otherwise selected per
> board.
> 
> This series fixes the apq8016 and ipq4019 clock drivers to return the
> programmed UART clock rate in clk_set_rate(), it then uses this clock
> rate and the hardcoded baud rate supported by this driver to calculate
> the correct value for the UARTDM_CSR register.
> 
> [...]

Applied, thanks!

[1/3] clk/qcom: apq8016: return valid rate when setting UART clock
      commit: f191853d77899c8a845f20f62068c4ee68d2a020
[2/3] clk/qcom: ipq4019: return valid rate when setting UART clock
      commit: b49b68909b5f4030869051073857d086c5292461
[3/3] serial: msm: calculate bit clock divider
      commit: 1aadf1ebc32c8bf7f4eae9ab2abaf63c1fea7d4f

Best regards,
-- 
// Caleb (they/them)


