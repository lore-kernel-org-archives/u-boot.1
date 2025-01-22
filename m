Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EE5C02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 16:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9489280AE5;
	Wed, 22 Jan 2025 17:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mQp8wKZp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 408EF80805; Wed, 22 Jan 2025 17:12:57 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B469980805
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 17:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ab2bb0822a4so1377677166b.3
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 08:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737562374; x=1738167174; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKnSmXZuotKxsQZ8HTIx6/gPIVBVOAImV2pUkE2CeTw=;
 b=mQp8wKZpZ20KsfulD8TNOHSgr7Ht1Xd/JsPYotB7siDvTyBXdQq2Z0Lfw1BRvJjYMf
 +9URqwWDno/UvOJ0DrJWCEYhYGHHe+2OEKlr8q65sb6hnLmekAmLKU9FgCrauixa4Wm3
 iK+A2jVJ0eS/whEdfPf5q+wqM+yVvmxl03x0dXm3FmKQyDMRxhEJbMdyiaaQTVP4sb/L
 3KYyTInoSm2J1c1GgEuurqBlRtroSYOlqBfLDhkO6vgjc8zMlmm828wvAyC1a3X6eCSF
 1o4B8hXBG32nCZee0pMOo1gDOE0BkD0vJkiIZC3f2OWSJ3CwWNxll8If0WWfCVADNNdE
 rDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737562374; x=1738167174;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aKnSmXZuotKxsQZ8HTIx6/gPIVBVOAImV2pUkE2CeTw=;
 b=iOFDVmU1HpoktGVYfDn9fNwoyXDd+ld2wWt1LU3lPNi4pDQy3fNyzojQEdr2FZrH2h
 CGJ6JWoBIAgiq3oceIPrIcFXXLCnyWPjephA3RaFUn3R1IWur7sxGqQTAl0iJFiC54az
 THxafQwMlJ3z7VmqxFLGgNn4KV5wUIWsz62xc+E7M/4geA3+M1S3qML2SCi2/vpmghmR
 k5nIOa/64dTsRLSfG+TmzEQFVUwh/lUxVq2Yu/ODL7ItSSP3caR3BrWmYCbqR809fbgl
 oDSmJJWBkZtWzv5JhmjTbjphqxp59t8bk3rLxArXv2QpjWYR3Q8b+pw4+U2kQx3AiKGu
 HZYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxBgTDZoQ3ONSDw+EdvLu5CmpkhythTI0e5uaaqE3alFBf3J9O6hHo6lX7HtJcubMIE2F40KQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+9Kzcm301SCW0mklgaIvb9X7QX7WpTMju7Ah4OOVfHZJN9jna
 M1amIMb7TwxHx7+P/Crt1xT8O/QdaFnXYG5JFwQrsuOKyku5zWUAJYpsWI/6KtA=
X-Gm-Gg: ASbGncvlCfCEIdCRTG09XO392jYxXV4bgyAriVeFfidh1Adu3sGStMOe7eLZtSKiGao
 47Mpo+zC7S2wYoX2lxoUAfToHMenUGN0syURTKFYI0HDl/77hRQwbwv1RZ7tpDFIqT+PjtS+/hR
 04fBg7lBH1VITigNnMCjmliwb+TMNwqDGlMzHi5eyqdVu6+T+E/HMDJ2GA6LQxWgEG8MNFBN9wj
 xluCHNnLvm/CsQYNzs6OTDnJak/UpMZNaXTadb3OrpTeh2e9yCzWXagY9R1H0kgSuCaYSn0LLnP
 OQ0g8b7zfwBp
X-Google-Smtp-Source: AGHT+IHTU9SzXQYYYC2gHXIOlSxNJ1ZjLJhDTJecO/GUjwIwqLi8us7tskRaFPiz7KCbptrSzcir1A==
X-Received: by 2002:a17:907:980e:b0:aa6:73ae:b3b3 with SMTP id
 a640c23a62f3a-ab38b1665damr2084797966b.32.1737562374168; 
 Wed, 22 Jan 2025 08:12:54 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce105dsm924966866b.39.2025.01.22.08.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:12:53 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20241125-topic-pcie-pinctrl-v1-0-4df323d90397@linaro.org>
References: <20241125-topic-pcie-pinctrl-v1-0-4df323d90397@linaro.org>
Subject: Re: [PATCH 0/3] pinctrl: qcom: add clk_req functions
Message-Id: <173756237294.1864727.5413040699844185107.b4-ty@linaro.org>
Date: Wed, 22 Jan 2025 17:12:52 +0100
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


On Mon, 25 Nov 2024 09:29:09 +0100, Neil Armstrong wrote:
> Add the missing PCIe clk_req functions for the SM8550, SM8650
> and X1E80100 TLMM.
> 
> Depends on:
> - https://lore.kernel.org/all/20241115-topic-x1e80100-pinctrl-v1-0-35f984226e47@linaro.org/
> 
> 
> [...]

Applied, thanks!

[1/3] pinctrl: qcom: sm8550: add pcie1_clk_req_n function
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/7ca1b3f0d998
[2/3] pinctrl: qcom: sm8650: add pcie[01]_clk_req_n function
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/7acf090d2709
[3/3] pinctrl: qcom: x1e80100: add pcie[3456ab]_clk functions
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/767a1e57fa1f

Best regards,
-- 
// Caleb (they/them)


