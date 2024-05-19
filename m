Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD559C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 18:16:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2081788124;
	Sun, 19 May 2024 20:16:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QexAyJZo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D975880FB; Sun, 19 May 2024 20:16:25 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71BCE88124
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 20:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a5a0013d551so361877666b.2
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 11:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716142583; x=1716747383; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OGb8c5aiEjJ8wAJ8aoMBcZ9zeqb58k8UZ3nyAhMiB5k=;
 b=QexAyJZoEX3ROm9KcTsrveIOqB2P+bKlTOGxkRxywnhCPiEv6s4/0Qyvrkc0F575KT
 dljjm+xFeMkLjZJ2jXcDg35ow2wfVM7vM4lnPTvoPmcJYd9n8MLoRbu08TMl1+I+R5O5
 n/YZ0NobOQ79p9Evp6n7mLNqqYBAIme48aS95f4JBR+HkpZj22q1/kQhLcQ6qAoWBGW4
 ydKlZhl1r/Ey9NoN0JFezSMf+8ZT6XrAE3Maz9bNIdfqWvuK2mLX2dlIPhrWUTYUgy5r
 IkzVEDnYSk3WEpZ5Cnu5OdzypZFjXxhS4c48wwVPeY0xM+3JUUnNPhtSlk21xt+Uvi99
 6q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716142583; x=1716747383;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OGb8c5aiEjJ8wAJ8aoMBcZ9zeqb58k8UZ3nyAhMiB5k=;
 b=k7ijjNiTvoMhV20qYx87mcE9cWMHFpY3KlG7+F3Hb3LRdARvHSuwExp8jtDVkLBunO
 qKryqxfdW8wWEg0r5o+dQzrcpnd5XJUNPNYmi+iTywclemZ2Ce67LPp+KimscT1SL417
 z3Sba+CxzDqpNKqxNhJwCKMauebmt5ZpQqxzO4FJlmQ4pSg1LOvZ3HytxVdUYXWWvKPO
 aACTecj15pWp63YVGACCF/URv1+qTeDNIH37FCRrPY7pUl457APpZiZGAOStjxRZtPiD
 wcux7rNanpv/GnxaXObVX+Gb4A2ZLr3U1R7Fv0CWQaqRFYvn7nkjSN2Etk88bbM++Ar8
 5ujA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyLPAuqc3Mj6Wepn7lX6Tl8ghR2aKLr7546c1sLFSEU/xeRkohX/tZVlPB5/KvT7kipt6gBfmw3SZQxoc/AiTeAmkYdw==
X-Gm-Message-State: AOJu0YwSH0wStTgBrMkm7NGKcEFfYXI9Xo1Hv5nKjkpKlnFQIUQTI3TF
 S99e/i6H8ZKvvRwisZjv2lPI8FttSBqtKPcfVmiPvEJuBDH31aVo
X-Google-Smtp-Source: AGHT+IGhHUJsEWW0zxukU3HUCqURSEecC1K6pocMY/A1rBa0ZTJtIVZnPJELZv2RGucuXA90pbQu+Q==
X-Received: by 2002:a50:d7c2:0:b0:570:3bb:e099 with SMTP id
 4fb4d7f45d1cf-5734d597dc2mr21245975a12.1.1716142582611; 
 Sun, 19 May 2024 11:16:22 -0700 (PDT)
Received: from [192.168.10.30] (77-7-142-46.pool.kielnet.net. [46.142.7.77])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-574eaace761sm7039574a12.91.2024.05.19.11.16.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 May 2024 11:16:21 -0700 (PDT)
Message-ID: <ea3619b7-0a1a-43c1-8de0-f06fd83c4ab3@gmail.com>
Date: Sun, 19 May 2024 20:16:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/12] clk: boston: Allow to get regmap from parent
 device
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
 <20240517-boston-v3-9-1ea7d23f4a1d@flygoat.com>
Content-Language: en-US
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
In-Reply-To: <20240517-boston-v3-9-1ea7d23f4a1d@flygoat.com>
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
> In upstream devicetree, clk_boston is a child of syscon node
> and there is no "regmap" property for clk_boston node.
> 
> Try to check parent device first to look for syscon.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v2: Move syscon_get_regmap to probe
> v3: Move syscon detection code to probe to ensure
>      parent is probbed before syscon_get_regmap.
> ---
>   drivers/clk/clk_boston.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

