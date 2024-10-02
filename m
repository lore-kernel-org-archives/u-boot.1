Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6BFCF6D28
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 14:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6A6489109;
	Wed,  2 Oct 2024 16:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mG1fA0Ui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9477389103; Wed,  2 Oct 2024 16:52:46 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5012288DCE
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 16:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a90349aa7e5so978912966b.0
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727880764; x=1728485564; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85PQWEQ4b+PKlCBStBz4V6XO2RSJpUbpGTppivgGpdc=;
 b=mG1fA0UiD0tcrue8N7lSTXoyg0Y4ap7aik0HtBEC5iq1O0ev+CFk2UtB6/uGUqDsCN
 MUPLjg5y5NuhfoIbTT9NP3Ux3jIi0lGCj1jRIG8FuoFw5BoPky0Qxx6EJeGa0HurMZLe
 NjIQVgtcjMxMDbZlZbFaHx/iyuKqBSmoaJ+fYvaV3CtbhE8Q8H3RgwHAEuqN6n4+FTBa
 6z6UzE9aFj2+BTLOGwjDLEE0KF3c+nId9Gvve7oqJYKXk4mkNJTQngogzFsLU43ALoEi
 Kix3hNNM9Sm4iwPeGs5XxbaMWCzqK3r1GH0/KNaVP8WKj/2X3l8YdXuPhpSUOZA+AM9A
 1CXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727880764; x=1728485564;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=85PQWEQ4b+PKlCBStBz4V6XO2RSJpUbpGTppivgGpdc=;
 b=GLUTJB67qOAwjr2N0v5czrYvyh8WhfAUhiyDmUi881EpO1w6LYLHkBhbTEDduMA+7N
 faLUmp++0f0LEKAtaWzpwka96AvYLrf0Cv8iJjhKo0vyjBSBAyv/C2tSlhTePmBhWXVH
 XPE9+IDOhpiOuRu1SL69HiUwtAZ2qmauWsuaiv22OzQFhWo8udIfGS37LnyHsr8qjeOo
 DiC+GjJ0JmNlPIZzTxoq/k/hUGjQFhCPuCzliDhzG7U52QLlQfPBqhTPySTtZbbLnc/C
 KNwTtoCGN9WLs1ZpCaGbIHC71r9FnVjt7VqZlKaa7BUEQzWNAaIm8xEkgp41iJd54ELJ
 4/yQ==
X-Gm-Message-State: AOJu0Yyw4JQkEMEKRZMAp3NcK4ZismxssDcXTnsMWNGBpusrv3mPTxk0
 Apo3v2txb2mWo2exkgcPI5IECwaYwSwM/e7aPnzhI/4WAv4wzohDCdimC818sos=
X-Google-Smtp-Source: AGHT+IGrFPI6uu3ncJ6Gd18wAJ7jla+WBAZRBmoSzOL/FOg4fh4+JqkWXk2KHtnxzxi+gR5SuOwOAQ==
X-Received: by 2002:a17:906:6a19:b0:a86:743e:7a08 with SMTP id
 a640c23a62f3a-a98f825a9d4mr315893866b.31.1727880763715; 
 Wed, 02 Oct 2024 07:52:43 -0700 (PDT)
Received: from [192.168.195.50] ([95.90.247.28])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c297be12sm889785666b.179.2024.10.02.07.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 07:52:43 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Julius Lehmann <lehmanju@devpi.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>
In-Reply-To: <20240911-sm8150-patches-v3-0-d9164b71316f@devpi.de>
References: <20240911-sm8150-patches-v3-0-d9164b71316f@devpi.de>
Subject: Re: [PATCH v3 0/3] Support for Qualcomm sm8150 SoC
Message-Id: <172788076258.935801.16286885100986930324.b4-ty@linaro.org>
Date: Wed, 02 Oct 2024 16:52:42 +0200
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


On Wed, 11 Sep 2024 19:13:08 +0200, Julius Lehmann wrote:
> This series picks up the work from Volodymyr Babchuk (https://lore.kernel.org/u-boot/20240306005230.2638972-1-volodymyr_babchuk@epam.com). clk and pinctrl drivers are adjusted to work similarly to existing qcom drivers. I could only test this using android boot chainloading.
> 
> Fixed wrong register values in sm8150_clks, alphabetic ordering and added GCC_SDCC2_APPS_CLK rate setting.
> 
> Thanks for all the help again!
> 
> 
> [...]

Applied, thanks!

[1/3] clk: qcom: add driver for SM8150 SoC
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c46a583b842f
[2/3] pinctrl: qcom: add driver for SM8150 SoC
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/6e843358ef7f
[3/3] config: qcom: add sm8150 to qcom_defconfig
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/7b42726927ae

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

