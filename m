Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B462C25B78
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 17:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7AB988093;
	Sun, 19 May 2024 19:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g/CtPmVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E37DD882C4; Sun, 19 May 2024 19:59:27 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 080EB87F65
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 19:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-51f12ccff5eso4408940e87.1
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 10:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716141565; x=1716746365; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=plvGJi1rFQMTBJTpTq4ZSLPVPAimBzra0mTZIO1zDXs=;
 b=g/CtPmVA7rYyTv3L/W55bYfDIx27x+7lo1fIGjPnyU4uvgmPTDoDrEGCBiYRv/ZADb
 skPWY+eUwgoIr5A1fz9ZMwaZHyVecR+Vbj+fql5JG7ApmwKKO/g0VbXMmmwa7kQHUus7
 1o2dg3FScvs4K7ZItyesXCRszM/GsoUM8E1AyuQiHiyhryB0GBncCEDiCExWbTdcMge5
 cSwyUArsTQd1918Bqt7pt9lz2dnQ7tV81Fdb7YB3P/fmMmUcOh7FPawEFUBp48BySYSb
 G/uIp9s5unBlet/cHRiVT1qB4WL4vq99h1d+EmZCvzUTIrrp1y/izKG+/mrG+LD/67OM
 Qg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716141565; x=1716746365;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=plvGJi1rFQMTBJTpTq4ZSLPVPAimBzra0mTZIO1zDXs=;
 b=R+i79E93FbklUPrh3eRIjLMivD7G9/Bwn+jRJVIy1DIC+tXrXh8Qdk/KGj/acSNose
 8hqjVbUfEo15aALJJrntATfwhTY48D9B6tqe/ZL0RjReq/zRPHZjvqOiJ0bWyDgosIuq
 9unhT+pOroNq+wmNzSH1/H5pycb4ASsW8Z99+IP2wczu97C2qow/noSUNneWNk7mMiiw
 e2yHmP8myt7VCozm90j08xWywr7UYq2zKw/ocdTYEekfBT7FUcsjncp8ESnfF4Ma7/tN
 C330ze89sUEyDVX/PCPs74dfsl+6gOa5bhrbBrE6umHAZeMd0bAI9xDhSvywY1SZ6BMU
 wVBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFHKocsOPF2rVehfU/3mkT//cYHztyt0RNzzBpRUR2beMggNc9aUSUZFZkBFeFRRo0lwlY+dbcjNttIzXJKOESSQ9zLQ==
X-Gm-Message-State: AOJu0Yy+hbQrIgHriYQ5hv6pKypRrAyJ9D+Jt2Aqakovt2e4q8tLtyXr
 owWS7MiKPPG0OFxlHICh+IK7mrdCP/7s40inkl689n5iCMbaLwq/Xfw0GxTn
X-Google-Smtp-Source: AGHT+IE7Q7fGrcELI16ga4SY9cJPMewmT/ueFxXOr/VY0Npfei627DCug43TNcRVBGZEGvNahXxxcA==
X-Received: by 2002:a05:6512:b88:b0:523:8c7a:5f6 with SMTP id
 2adb3069b0e04-5238c7a06e3mr11480447e87.51.1716141565259; 
 Sun, 19 May 2024 10:59:25 -0700 (PDT)
Received: from [192.168.10.30] (77-7-142-46.pool.kielnet.net. [46.142.7.77])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1787c715sm1370708466b.46.2024.05.19.10.59.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 May 2024 10:59:24 -0700 (PDT)
Message-ID: <2987dbda-6879-4f23-8190-44238655b1e6@gmail.com>
Date: Sun, 19 May 2024 19:59:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] MIPS: boston: Imply various options
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
 <20240517-boston-v3-7-1ea7d23f4a1d@flygoat.com>
Content-Language: en-US
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
In-Reply-To: <20240517-boston-v3-7-1ea7d23f4a1d@flygoat.com>
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



On 5/17/24 20:14, Jiaxun Yang wrote:
> This is a PC-like platform board.
> Enable drivers for most on-board devices to make it useful.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   arch/mips/Kconfig | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
