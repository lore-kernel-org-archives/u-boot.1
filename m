Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF62C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 11:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE0F984979;
	Tue, 30 Jun 2026 13:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GsDBqAIy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A922384A30; Tue, 30 Jun 2026 13:19:33 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF6C8490A
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 13:19:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49241dbf9c1so37566515e9.2
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 04:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782818371; x=1783423171; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=imGemtz6hCyH9UFvkFtyHO3sdBDfTdv/g5XG7pKTjP8=;
 b=GsDBqAIy2W+rrHD1rTOf34ID6Vm72OO7SOPnTq4N4nVrdg0MENURQ/S414BnDUabgM
 t3+bjiqnaSTPYydRdZMp3weEV9CChYYjgyiqUghY6gCNk/v5T+AQRwZqcZMYf07i7Yhb
 NOrlUpzLsCAANwcfrcJZpp92Y3VVmc0JpuTqh184JqkJznosKo0ldUf576eNaB2WUuhQ
 JyF1PisZPn5Rn0J/8mNHqMomL0xd7dWg0HC7JCRO3y6GovS/Fc4pxCepugB5bHlxRT4k
 4ibRGmmlHvshYKiT85kK1VSUeFJgWRTZZzuQyvtRdInL+hz9GeJv0ZMPzchmfL99D5rW
 YX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782818371; x=1783423171;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=imGemtz6hCyH9UFvkFtyHO3sdBDfTdv/g5XG7pKTjP8=;
 b=MpJASVIRBL/yWBK9aiFsb+2sR8KO5Cp6HDbIODR/oxkyEekGoMWeDx7XpZflpLMcE4
 zOyu5+jNZwMkK5Uah4uUcnFdjhR2Gl19zUdoj0IKmWftIy1zEWxMpM+FHz77s8AP8sKv
 dSj8KKMu6+Gamj4Fv2oGvJZq356cPi1p9MNVxSl4rMmm5oTZOKNAIdoxIn35xQutwmyL
 aP7qnlZ1DkUCKyhFl1KaZHZgihzpGdAnyf+MjyWykSnQwxO4PHXNN81Vab+TDXGALgQw
 vtZGp0Y/DSepNiBc7Qe5zKP7G2DBGi9H9D9rpOlx6wBr3qcJFXmli/a07nOESHaJMymT
 sh3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8tywp/8SGpPk4/zu/G4pJYMnOGoey45qlDzrOMEFpzNZ/wYnqBMQNiqug2cjNaQht3xXOSyVM=@lists.denx.de
X-Gm-Message-State: AOJu0YyjFLNcHr6EYGmdgdauMbL6p+ShMlJS2m37zcrj4Le+BhZCkfVD
 bV+Xby9mRuweX9scJ01x6dbcUE+cq3FgAdoew6AjYIR0seabLQ3/vEK8rrKcOZPcTb0=
X-Gm-Gg: AfdE7cmaaCftTdOARzEOVLgwiJ7Bn5JcGywmITN3dtn2+Koz3wJCmn6iJM2ReByF/ON
 v29mhDYvCanU/Tj/5DO19bmyb6MAJE2y1A/8XxUpdtFsS1fKrm9NdoFROdVkJRVFhDxxtPU/7nF
 iQyVY2BCUKBUXLzbBmYY0i3nJlRgnemanVZMsW1rSW7Pz/BhI00NGTiRKcS5aMs87eyobvR5A4k
 Qt6JA783BYqG+ejzPIMF3VabiWWsrWdFixvORPNp1MhV7cw6x010mqKGcTPbLT9bJEWnDwy3UCj
 Nv8ReVUEbhNeeBMotyP7LFjf7mVjJgk2u3u3vWIkMeX1DchWrT2q4l889NFzM01jqB1T8GICnVD
 GOFdRG5CbLvajPJwzCENjD0wexHwh7fIzovfdwNzRYVy1uqOWi4XhVGw7lJZFie6yXAtKazUD4+
 +13R6Mbpok6vnUmpUCHs2cXDynptA=
X-Received: by 2002:a05:600c:350b:b0:493:a75e:cf2e with SMTP id
 5b1f17b1804b1-493b82b5520mr48167625e9.25.1782818371130; 
 Tue, 30 Jun 2026 04:19:31 -0700 (PDT)
Received: from [172.16.185.106] ([195.76.196.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8ca8a81sm61857625e9.10.2026.06.30.04.19.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 04:19:30 -0700 (PDT)
Message-ID: <e7d422fd-e589-47f8-ac01-f9c27b9fcb9f@linaro.org>
Date: Tue, 30 Jun 2026 13:19:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] qcom: Add support for SM7125
To: Erikas Bitovtas <xerikasxx@gmail.com>, Sumit Garg
 <sumit.garg@kernel.org>, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 David Wronek <david.wronek@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Paul Sajna <sajattack@postmarketos.org>,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20260621-sm7125-support-v1-0-5ad69a39781a@gmail.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260621-sm7125-support-v1-0-5ad69a39781a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 6/21/26 18:46, Erikas Bitovtas wrote:
> This patch series adds support for Qualcomm Snapdragon SM7125 (atoll)
> SoC released in 2020. The following components are supported:
> - Clocks
> - Pinctrl
> - UFS
> Most of the code for SM7125 is shared with SC7180, hence most commits
> are labeled after SC7180.
> 
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> Vitalii Skorkin (4):
>        clk: qcom: Add driver for SC7180 GCC
>        pinctrl: qcom: add SC7180 pinctrl driver
>        qcom_defconfig: Enable SC7180 GCC
>        phy: qcom-qmp-ufs: Add SC7180 support
> 
>   configs/qcom_defconfig                |   1 +
>   drivers/clk/qcom/Kconfig              |   8 +
>   drivers/clk/qcom/Makefile             |   1 +
>   drivers/clk/qcom/clock-sc7180.c       | 273 ++++++++++++++++++++++++++++++++++
>   drivers/phy/qcom/phy-qcom-qmp-ufs.c   |   1 +
>   drivers/pinctrl/qcom/Kconfig          |   7 +
>   drivers/pinctrl/qcom/Makefile         |   1 +
>   drivers/pinctrl/qcom/pinctrl-sc7180.c |  95 ++++++++++++
>   8 files changed, 387 insertions(+)
> ---
> base-commit: 298d44464dc63a4f3f5489150acd7958f359f9bd
> change-id: 20260621-sm7125-support-25130e2f4ed1
> 
> Best regards,
> --
> Erikas Bitovtas <xerikasxx@gmail.com>
> 

