Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB88DCD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 16:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68D7484704;
	Mon,  8 Jun 2026 18:47:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P2B9ti7Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8C9C84701; Mon,  8 Jun 2026 18:47:15 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58FDF8407D
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 18:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-69155ca09d8so2740638a12.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780937233; x=1781542033; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z6IiBIJaJnWLxYU+LCqX4yJRPGtoX7Vq99qOfvd2eGU=;
 b=P2B9ti7QHSeJqD90/vTvR0YAneETgW9Nc4+CuUU4rSRMIL5fTUCz4cSW2IRvFwDXNe
 /G7G4FcLcW7d6UCvYIzs7z2tnML8Vp9Bq9UKOKV7D+X5GbWA7+99f4Csu5UrVtaXRNao
 TaJ8YGOdS8Dw5DHPcXfLw/XmWs1MM/R/39LBZOAO+t6zX+Of7Es+K5OVpWYD3izEfgDJ
 NrwxvOGcPHA3td/8XxIYAFWwTkgNNxM73GjZIuHdxeEj3QRAikauNFFh9cCANbJbaCfg
 Nn/VGTOOG+gY9WZJvcRoVoawko4PS70BSRFOKTPcIrzD5rYKMsUzfBTdrzRKUE4k0fCo
 3LxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780937233; x=1781542033;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z6IiBIJaJnWLxYU+LCqX4yJRPGtoX7Vq99qOfvd2eGU=;
 b=eZ0Z5OjjIaE7Xnfo67Y/sxVMv/V9NGTBpfuR+5baPotBj0mCFNMl1gLuV/GyRnOdUr
 yV5EDSFhXBBB8ae+dsJvtsPuh9uMIH5uF6Dk+ODx+h4STc5y+ei5iNkukgQ1JV3oXnIr
 XuIw0a/4ezLyrQi8jqXYgyjNXs2iRykY1JeeeA4p8aO6MTbRHsgOxegtf5u4Vga0xtx6
 sMYgvq254+Vjjurv0yyaRFpg/h1Q27IVghnQzYo8oeEs/NLDQgarMCMXOuskBjbRrze2
 2y577/3FGtmtiTo6vVqlw+09tdwhMsxpphEsu2CV9sjsQPaeWTW74yOp5d4umyL/CXyL
 qR3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8TyhpY1I/znaiZP/zLUvQOhUOSr9NRnkXV2Igm/XpiOIO7pUoXsvtZxw421A836rR+F0i4ow4=@lists.denx.de
X-Gm-Message-State: AOJu0YxTG7oyC6W2bHOWM6ORfo6Hv2HNnn20aRB814cyGjySM2ehNjRw
 3HqJc5XNCyHeAYr7alwlwiOlGMOP9mTM4wmIyFkVTsK5cHXOIwY8/rThd1MyXgY7RfU=
X-Gm-Gg: Acq92OGZ9OsmoSwvmzj+cBDD+qu1VLF92mJpgui3exiBU54MnkXUD5kYMieBqsuITIc
 y/KCsgPuHFg7kz6hSC/k451lFKvth2Svg6Nc6XdblmBsza9H20bCEvCo5mFsNnZQo7u1QoYuz2+
 JMbqrLiIurqRoOu7zRoKzyPRfftMVF92QlFdPEDAJM0qhyE9bPG+ywZf2RVKvqESH/v/XaceyPj
 /xBMZKbMh8W+tZVchRDs7rf4kPB0GREGEjyBywiGe4ZULeD+mujUljxZgy7usvLzzgCLA36pPDs
 aC1KGyf7H6sdEaBXCPWKijYNbJ0PwllF/wh1RlAuBWUT8YM+6PzPoRFDIDJvMWlsPXQmnC/vPVV
 RVZ0I39AAQswEKYnjTtcuAOzxBGm0CthDHnGDOvarToYHM7rEunCTElPCmZl6+sNxyAqRWXfhUe
 ZVDDcs8JQXPTBN82QttWo8KLYDFc0bGRTPpUDc6eUM3AHWSgc7Rmwk5NAa+U1b10QNE7iqQx6s9
 Q==
X-Received: by 2002:a05:6402:5305:b0:689:6c2e:6cdf with SMTP id
 4fb4d7f45d1cf-68fa5153b06mr6585460a12.22.1780937232573; 
 Mon, 08 Jun 2026 09:47:12 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65b4d988sm7475498a12.25.2026.06.08.09.47.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 09:47:10 -0700 (PDT)
Message-ID: <144a8cab-3934-4065-beb1-cee792316cef@linaro.org>
Date: Mon, 8 Jun 2026 18:47:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] MAINTAINERS: add qcom_lemans_snagboot_defconfig to
 ARM SNAPDRAGON
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo
 <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Kory Maincent <kory.maincent@bootlin.com>,
 Yao Zi <me@ziyao.cc>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>
References: <20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com>
 <20260608-snagboot-v2-6-036bb0343bf7@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260608-snagboot-v2-6-036bb0343bf7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
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

Hiya,

On 08/06/2026 11:06, Balaji Selvanathan wrote:
> Add an explicit file entry for the new Lemans-EVK snagboot defconfig
> to the ARM SNAPDRAGON section in MAINTAINERS.

You don't need this patch, the file is picked up by the "N: qcom" line

> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Newly introduced in v2
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 571af196465..d7507006d8b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -687,6 +687,7 @@ L:	u-boot-qcom@groups.io
>  S:	Maintained
>  T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
>  F:	configs/qcm6490_defconfig
> +F:	configs/qcom_lemans_snagboot_defconfig
>  F:	configs/qcs9100_defconfig
>  F:	drivers/*/*/pm8???-*
>  F:	drivers/gpio/msm_gpio.c
> 

-- 
// Casey (she/her)

