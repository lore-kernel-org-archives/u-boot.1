Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65066C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 12:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C930E88F23;
	Thu, 25 Apr 2024 14:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M1pfGjO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B490588EF4; Thu, 25 Apr 2024 08:13:39 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EC5188EF2
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 08:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a56d7d457a1so68924966b.1
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 23:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714025616; x=1714630416; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4oAOdYOX0RD0UvbTSAjV8xtUv8+p4L1S8AM392UvtRU=;
 b=M1pfGjO5fbSx9xw2RlcBt+V7VyfXmeZfJXIbpZDBRgxtACpsWVHAPHmVD97TneNqCW
 EI2chIxHIgAhOircfgnKPVyqp2oM++MjFvukC/ApmpkOKk4cLYMSzQ3SPfa5U9klZ/tU
 RQX6MPYLmsFs/Fisr0P35nvZljFvBvBGK1KS01DLOrrTwNxTWezWXLogeBSQIKvUgvTe
 EhzX0VrK5PPlNJWuCxS0Cs57thLZGPHadH0G+RfaUX/q8USHuhyRcCBiy+r219yfVZ+q
 F4eGzAAUuG9Nm9rxpM+yUmaR7eLus/ELVL8UOuSUB48sth8xQuR+Pa42faHm0ptvSmd0
 ulFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714025616; x=1714630416;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4oAOdYOX0RD0UvbTSAjV8xtUv8+p4L1S8AM392UvtRU=;
 b=lqCXRE91ErEQIq3DuomzheXx9q4oLJz8hhhwDzurkAEFzc0X1czjAPPsE4YD2SMsrX
 7iVb+g4u0jd8QK9fuufFxu3U2z47fE9zoVebFXyw3hIVPSlfxvDBmm8kT+AoDyVa0WNV
 Dyvlm/VocsgYg+bP4+5cq1y6hu5VjMM5HtQ+DQ3+tGy2FU8KeiOiLDUxSvMZoGrcKsZq
 hty9j1jEsVbgiNFoZbHFa4gphO6dgZlyLjRAN9OL8zLuccf0w7O4yh8i7WorrDazl2Tg
 6x9pWGP+LDLYwLXnS7Ec2Db4AGGMjrx4eevQrCRoja+BcVr7857E1TnMiytnFCjTiL5U
 qRFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWysjJZuZjO3R2mMKK0BkHuBlWd0cAZBAV7gab7qrPjMJssGyCkYJ3SnsSLrf7SvVETvTIJDF3qMRHZfblkdYBFAAqyaw==
X-Gm-Message-State: AOJu0YwpE1smk0cX1v238l+17WoJ7BYJr4pOeMZJyuUGGTFRwanBinWg
 N2o5670WoBuBsrR7aLhV4XjtmPy1A0UTp3PGgR+FY0gILAStW2Gi9fnBETPBjqs=
X-Google-Smtp-Source: AGHT+IH6dCmhwyp/egJGt60cKQHwIsHRDKZfXDhHzaX2k8IEBGL9t2AgU8IKzvv6jBF+JZVNQ30RiA==
X-Received: by 2002:a17:906:97d1:b0:a55:b3bb:e7c7 with SMTP id
 ef17-20020a17090697d100b00a55b3bbe7c7mr2955628ejb.10.1714025616605; 
 Wed, 24 Apr 2024 23:13:36 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.100])
 by smtp.gmail.com with ESMTPSA id
 qy34-20020a17090768a200b00a55a59c629fsm5687130ejc.121.2024.04.24.23.13.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 23:13:36 -0700 (PDT)
Message-ID: <4aeb16b0-e0f3-45c6-a67e-66392cdafb61@linaro.org>
Date: Thu, 25 Apr 2024 07:13:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] mtd: spi-nor: Replace default_init() hook with
 late_init()
To: tkuw584924@gmail.com, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, d-gole@ti.com,
 pratyush@kernel.org, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1714020303.git.Takahiro.Kuwano@infineon.com>
 <ab901185da7f37f17767f93ce554b40a4b06b518.1714020303.git.Takahiro.Kuwano@infineon.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <ab901185da7f37f17767f93ce554b40a4b06b518.1714020303.git.Takahiro.Kuwano@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 25 Apr 2024 14:32:02 +0200
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



On 4/25/24 05:52, tkuw584924@gmail.com wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> default_init() is wrong, it contributes to the maze of initializing
> flash parameters. We'd like to get rid of it because the flash
> parameters that it initializes are not really used at SFDP parsing time,
> thus they can be initialized later.
> 
> Ideally we want SFDP to initialize all the flash parameters. If (when)
> SFDP tables are wrong, we fix them with the post_sfdp/bfpt hooks, to
> emphasize that SFDP is indeed wrong. When there are parameters that are
> not covered by SFDP, we initialize them in late_init() - these
> parameters have nothing to do with SFDP and they are not needed earlier.
> With this we'll have a clearer view of who initializes what.
> 
> There are six default_init() hooks implemented just for initializing
> octal_dtr_enable() and/or setup() hooks that called later on.
> Just moving those to late_init() does not change functionality.
> 
> Suggested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
