Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3CEC25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 15:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1433B87AEB;
	Thu, 26 Oct 2023 17:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N0Ayu1u/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B1287B71; Thu, 26 Oct 2023 17:39:39 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40C1F87B23
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 17:39:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32d885e97e2so681433f8f.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698334776; x=1698939576; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y0cANZcb1MpvaSnp9U9HyFtmMtizrWrl9ghLQcJ93X8=;
 b=N0Ayu1u/RSZBHd39OT4bX/AKiXMNogRHNA22JWbxKRDHyRu5VU5wlRjg/nkxPQ8VM5
 1ZEytGsqEQBGqDD4LO8lYjCJqcHe1P8mFbHQpY9TOAiDAg+0uC14yrQCAeixMig9XGq1
 Dqi/C8JFYfGkq9Q9qZVrjF98+HmUGHeQMF7m17FxU5bVDUfAVfmxYcf5MYfTuL7PN+u5
 QZdnme7RJcpNF5zO36R3ehRcyiuPGs/boUgCj/AeqDPjdZdbrRsJHwQH2yTz1JSTTBkt
 fHbMWA+yjAb9DEjjUfw8pDU3nCg+p6meLBUN561eBHj9RQ2CtowcWW6H9EhlI0M0vxaO
 x6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698334776; x=1698939576;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y0cANZcb1MpvaSnp9U9HyFtmMtizrWrl9ghLQcJ93X8=;
 b=F9awkvFhraAPx9RY78+Xu+c7Vx48w9+ZUWm91HwdYWY/B5hfDScM5pyFyFXhYPYal6
 mIoGZ48RxwuNP9BghRoTHIm2DPulBAafT1KX4igYMa0tvednif28zyB3HVTrLKo/eCL1
 zHMmWPuYtBtWh7Omw4B1Akepbbazes92+fVI4MniuEnq4n/MXa+qptNsYYptCbISbG/m
 +uPnF7V/I5Gsc3s5JAu/Mh9O+7uWnUnIHFrzZ97s68t6JapNBnUyExCq/Kg0uhQrDCqa
 VpGmuHxs3J0DmbL3ZD08pT/4yjSYkpqXjKD5/0KkCtcF1lSGHCN3rrqoZssk4JHyMSag
 X8Gw==
X-Gm-Message-State: AOJu0Yxm2ItDFxNpiwm/u47BVmSOo3M/r+a3iQcPBC1Aa+wOMVyQ8SaG
 lQyzgIJxzE4v+Oa+Q/dsothvwQ==
X-Google-Smtp-Source: AGHT+IHSGcQlYQZ20xS7sbx58R58yuGZhTynFt7/wNbzP9aQeaV1jicOKZHAMyR/kymnrTKrLZ57rQ==
X-Received: by 2002:a5d:4708:0:b0:32d:89b5:7fd9 with SMTP id
 y8-20020a5d4708000000b0032d89b57fd9mr14600941wrq.56.1698334776462; 
 Thu, 26 Oct 2023 08:39:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 w5-20020adfee45000000b00317a04131c5sm14495883wro.57.2023.10.26.08.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 08:39:36 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de
In-Reply-To: <20231026-fix-saveenv-v1-1-6aa59be65481@baylibre.com>
References: <20231026-fix-saveenv-v1-1-6aa59be65481@baylibre.com>
Subject: Re: [PATCH] configs: khadas-vim3*_android: fix environment saving
Message-Id: <169833477579.2656704.6983830809763111011.b4-ty@linaro.org>
Date: Thu, 26 Oct 2023 17:39:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
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

Hi,

On Thu, 26 Oct 2023 15:41:31 +0200, Mattijs Korpershoek wrote:
> The environment is used to configure some additional boot features such as:
> * extra boot arguments
> * enable AVB (Android Verified Boot) verification
> 
> Right now, we cannot store it in eMMC:
> 
>   Loading Environment from nowhere... OK
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] configs: khadas-vim3*_android: fix environment saving
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/8a08092ddba82e18e8ed1ef84580aff00b419fbb

-- 
Neil

