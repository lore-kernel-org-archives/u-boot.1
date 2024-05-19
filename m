Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AEBC25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 18:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9D94882B7;
	Sun, 19 May 2024 20:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JHOaIO3h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46FDF882B7; Sun, 19 May 2024 20:18:46 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 623FC88223
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 20:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a59b49162aeso603756666b.3
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 11:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716142724; x=1716747524; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jOeEETcd4aVwMnMxkfUM9cz7YO/nJ4v4b2/5ayNReSA=;
 b=JHOaIO3h/YIYJnkzRVSR+nylJDzOn6dRe59dieVTJUtREWeFsi+eJ1cVrGc5JwHSEw
 dY7mq5tLnwFjdjgmBfpn7s0tHG8276LgmCqtQjd/lh8YFkB1EIH3L121Kgb5h2xl8EPA
 CfYpquvVQEH6TPD+vL1Lkx0L96+x6XJ6lT3lwnugf5f1HiuTC2+SdNSxtkbJ3n/giwUo
 BpDz9IjvBhGwUg5t4opkpH8NIojXzMGbdmn3uUlmBJ167tMYZ6Uu+57mIwi8AuYFTmUJ
 UbFTwq9hbNx0Q/VDTDQqvFFt3ZPITHu04yK5/vr3I8CtUEs4qSTLM/TLF+Q0pTpVg/vg
 vOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716142724; x=1716747524;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jOeEETcd4aVwMnMxkfUM9cz7YO/nJ4v4b2/5ayNReSA=;
 b=DXKlcAuUJSda/ZDA9R/zcvG/ollC2QDfAtbDDrJr4NmKi7tfvQ5j8A2I51Nn+MSQci
 UVAqZ+vLU2e5ZMoVUk0qwDVqHf4IXtAxVGsCi2gsgmyuOLFg8YGf7+ff8m4ObWOSxL5k
 PwUlBDi7aXCfr1u1ockUU8DB1gjZayqxY7YcS6U2d0YpTeto732a/su22hPCQKJPLI6X
 DExQqPk0LJ2djabqgzTi2Sat5jw4eUV3diSsdSNKcdtIH0r3kCRxciUOkVfQE/od7d+g
 yJWFZPGpy/7uFtmGkZ1yg3ksGA+zA7HMqfiiQk6zOHQToQr4HO8IR3Vc/mdl1t7JBSKc
 BAoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV17+U7OLKFQ/8oKGD0SvUeCnZ5V2+ZFhrrEbqGGUZm2R4wtkEjkRv2CpcXDlytmJ62rHQpVNM/e5tmidmQmlaHsR7VuQ==
X-Gm-Message-State: AOJu0YzuVoF+C597bjaOJyPgGgKdViuSz4FW1FQE60cfwev+jZBT0Fcd
 Uc1U9UB5FWLH/I1A+5CcJLebKxG0k1n5ilvZhKOERnrhRaN9suGb
X-Google-Smtp-Source: AGHT+IGfxXteshy5VFoEG7KEtHfOPt6rx85X5EX7Q1M85btNVObCrJNp4o3iROR65DLnjrW5cWRnHw==
X-Received: by 2002:a17:907:980d:b0:a5a:5496:3c76 with SMTP id
 a640c23a62f3a-a5a54963cdfmr2018598366b.6.1716142723791; 
 Sun, 19 May 2024 11:18:43 -0700 (PDT)
Received: from [192.168.10.30] (77-7-142-46.pool.kielnet.net. [46.142.7.77])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b17727sm1360107366b.208.2024.05.19.11.18.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 May 2024 11:18:42 -0700 (PDT)
Message-ID: <ebccc62c-6fb0-41d3-899b-12c99e4814ae@gmail.com>
Date: Sun, 19 May 2024 20:18:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/12] dts/upstream: Add Makefile for MIPS
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
 <20240517-boston-v3-10-1ea7d23f4a1d@flygoat.com>
Content-Language: en-US
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
In-Reply-To: <20240517-boston-v3-10-1ea7d23f4a1d@flygoat.com>
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
> It is required to make OF_UPSTREAM work.
> 
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   dts/upstream/src/mips/Makefile | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
