Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E98FC83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 08:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01BA8836A4;
	Thu, 24 Jul 2025 10:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Bimq2qAL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0A66836A6; Thu, 24 Jul 2025 10:58:34 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D93B283666
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 10:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-456108bf94bso4271695e9.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 01:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753347512; x=1753952312; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vbb3DqfGo6vCGeDQahMAHUmns6/fCAWAK3zsNuYHeB0=;
 b=Bimq2qAL3yibwmyfiXLyBaWqxSOEDDHlWpgr67OzGpeks018lPK4tRue6Vp16t5m04
 7jfd9970z+LmYFTsz1LOHEw8ki5fWe8wNlRoU3jWHS1nSbW3fpvr7dAHoxs78DCgnAQf
 l3WQNm95MnXDQp8JZ1IFfKymmqPTzl3eq82mMBCu/36kCP811PyJFBS3neQqIg8boA9B
 gU7fctFc5/bS0xMT/ekPAiKbUrzwPrdSX3PtzaXlD4mdpiuD27dx3MnBKBZ3phoEIBw+
 RkzaQ08ShhctEbWHiBpllyT0TD1OYRnhWffCIwChnJiTI5YOciXmbvZL9mMk3J/M/N8n
 9bIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753347512; x=1753952312;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vbb3DqfGo6vCGeDQahMAHUmns6/fCAWAK3zsNuYHeB0=;
 b=UEVKDtFH/2KSS07usA18sXbX8ZJ9TA+DZHhgf804gRZPMp14Hf/iP3Bz+YSy1atKx2
 JXbRkBmpxVyUzgr8Q7ihiDrxv04d+y+LpBD1twMSVT5zscRDe0vhU5zMJFPEqrD58Fsm
 5i5OWm3fGHKOaRHXNDLxJhqotWsWlrrpboq9cA/SvO83MX2vwggKUi88FX0CpDZk/E04
 gSf2fPWAJweCVT+SnJN8KWMD2IJ+DAx7Cn9nLPSVe1X+c0NfOnrySC2Cbgr6Q1/6NY23
 Tw/6xlwK4qPs0k1dUYmZz4FIqkhuhnef6iZHPWnzCQLekZyaQ5eF6Kamw75j0aSnDdg+
 laBA==
X-Gm-Message-State: AOJu0Yy7AXKmwxCPha+QImZq2ZEjMVwhkiASXELPJAZOnhdUPE++w+MG
 XMF9GAQOcy3ZyfggddRsYgu2EAhj6p6MjnP6K4RsnbaNylfmK2zcHA/O8QB7vjfvflE=
X-Gm-Gg: ASbGnctXfn5qvLbi5FaDQt8p0Cpf6h/F4ZdELdsjAcS7Km0U6ZCyBIRLRZbOydbK74m
 uxk+6nDYlYEPCunuLMsO3NrgkGcWpZaw2itpfvSdddQA3XF6AjuxzNyy2qYKe3YLyYyd0Ip1vKS
 viC/OPmiSAo9hYUHPE85G2j4gc7dN1T7IJJ5PlNULAt+ihA5NTT2WteqFWtX9R7CeNsP+3skZkj
 XaH4zvo4xUnNyPmsQT+U+a5q65I0k0pSDA8wifx+cJcJPN7kb41zti0oR7xtyEeAKsFtdbay1ma
 ll3tiwLYFfmwB8YFvpN2SpxE5HZwF8T1IwvuA6FJ0fzduxWMf889xVL9WpF5aUfQqi+TALK6aEm
 O4Irr9Z7Otx0nTiSt4NCUBB9gCbyGi59jS1s63VeuEbuj+QR6iinOOHcHHw5rBzVW4uPA/dsv78
 andQ==
X-Google-Smtp-Source: AGHT+IEWiIMAiu/vPW96k5enX+SDeteJN6FbuGI8XFUkfwwOtCAcwoWRrb1DQrW7geVtyDxPikipPg==
X-Received: by 2002:a05:600c:8b55:b0:456:25aa:e9c0 with SMTP id
 5b1f17b1804b1-45868c954dfmr60182555e9.14.1753347511794; 
 Thu, 24 Jul 2025 01:58:31 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce?
 ([2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587054f31fsm11622515e9.10.2025.07.24.01.58.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 01:58:31 -0700 (PDT)
Message-ID: <092aff1e-dffb-4ac2-8a2c-2a0e1faa5269@linaro.org>
Date: Thu, 24 Jul 2025 09:58:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: mtd: Prevent use of uninitialised variable
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250626-mtd_fix-v1-1-1ffcc59a9d0a@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250626-mtd_fix-v1-1-1ffcc59a9d0a@linaro.org>
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

ping?

On 26/06/2025 11:49, Andrew Goodbody wrote:
> ret maybe used uninitialised in some cases so instead
> initialise it first to prevent this.
> 
> This issue was found by Smatch.
> 
> Fixes: 9671243e8d10 (cmd: mtd: Use the subcmd infrastructure to declare mtd sub-commands)
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   cmd/mtd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/mtd.c b/cmd/mtd.c
> index c25997cfb24..1651a4a6b3e 100644
> --- a/cmd/mtd.c
> +++ b/cmd/mtd.c
> @@ -474,7 +474,7 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
>   	struct mtd_info *mtd;
>   	u32 oob_len;
>   	u8 *buf;
> -	int ret;
> +	int ret = CMD_RET_SUCCESS;
>   
>   	if (argc < 2)
>   		return CMD_RET_USAGE;
> 
> ---
> base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
> change-id: 20250626-mtd_fix-bb1ae86f33aa
> 
> Best regards,

