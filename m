Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D2BC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 09:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 371D98368E;
	Thu, 24 Jul 2025 11:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r5MK51qU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D47483831; Thu, 24 Jul 2025 11:00:35 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45C5C83666
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 11:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ab112dea41so410061f8f.1
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 02:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753347629; x=1753952429; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FrDLQkHZjoioIjVxt028nZVuMVC3LyzIKz7WnYhNxuQ=;
 b=r5MK51qUJKDG0ax4hBjsDor0hZGXj8lMa+md+e/Yrji4ASyGJlR9ltESJSQW8W3+6z
 RtzLF3ppIm/UVsZgFjePUYmEMdWW6j+LdAp/rCPzDhsL4GjZ5BgOmKiMK9UTsjCXTqOo
 r+HYJfS4HZD1c/uDiKcDWmnQN8VS34qq950Sx+rO4S8WEDxeTuBFZaavizFAPmQpof3D
 HonHokDqponpWPzY0VE63Jx1VhwPf5s/x/KSPL1oWzl0zB/lPcS6ZYP+FTTINMQcO9y7
 10cABAKbcXm94Ihxy3E0WhE71TwLqyLrWgPS8MMQrkul3F15dTv0UGB7HWxawAH0Tr+o
 iiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753347629; x=1753952429;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FrDLQkHZjoioIjVxt028nZVuMVC3LyzIKz7WnYhNxuQ=;
 b=IirVjfWOM6y/lHHjkxsTn9AZAL+Nfb9LvqUFDFQ4Zr2mdQWU+ecrmbeL9jiRm6TcXd
 J0P9YwtcxfaHwdgXc0T5WLMc0kXBDe5yjRos+SSDZiBP1cLI7zIDnomdLuopJVF7of4t
 hpJdam0tVnJXKWG/c3/EgTA6xvMMrB2BveTkcET5EnT14PArB2uVi0kee2d7va9SUwbB
 ijDe5k19O+5qumOPsZrI+oopsuA2yW9HgFgRQ5ECN8MNGuMrE8JRNpV/OxkEHdD8DI5L
 OyM9RSqjXS7IaJyvTnJwq/ybZEMJ7UdRR0XkR/DTbeLnvCS4s3RqBugntYfMoSwCBu9v
 g0Cg==
X-Gm-Message-State: AOJu0YxfnmGd1+KRkYZpobSG+yL6s4ZsiGA1Y6iUGpX2TYZ296jwQUQ6
 AtGpId5wnhpOazHT9j4UHE0sWBON1Rod4l3NGky0w1TJ6rb2kAJg2n2fIm5c+CsglMg=
X-Gm-Gg: ASbGncvQSgnHpKa8Q2dC3iFzYT/8f0wv9i3B8bDDWTERamnnAG653OfkJb2FclpNbXH
 gx3jqZGFl1qJKzSKGgzKLk8GFy//Xt05kKh/XCkD207wkv74sPN/jpnjw+oaF+5vJNE6aqcNBrs
 kaJ9xy+QQysDXNP1CVslflVSsqt4i/vAywOkvU5KTnI/k0nI5doHrt+eQjcexf6pAldUU6Rxxli
 kmSXRMDGJonuZjx23pJouHp6B7soVm1WmjhybZdR9WWb8HUDeSEGUzGHrxfgPw5fmEexhWUrVPX
 C798/zLdUJuJ9CRkd0YAlpZYxPlsEFLB38ENBj/Gd9R4x5mde1OL7UzqOBX+9+42uMVCeumSZZs
 ERl7iwLkrp8FLSlUp8DRewQdsu8XO9QaU2ZV0qTvAuT0D0wgOKBP+j/i4WcxurMC+vgpxwwwqgx
 OnWw==
X-Google-Smtp-Source: AGHT+IENgjonJvcdApU93QpEGL9nv0GL5iaeUfpV3Hf+yoy17fk+FFm5XTPWR+A+86if9wg2qzbDNA==
X-Received: by 2002:a5d:5d07:0:b0:3a3:7bad:29cb with SMTP id
 ffacd0b85a97d-3b768f16423mr4413315f8f.52.1753347628998; 
 Thu, 24 Jul 2025 02:00:28 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce?
 ([2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fcb8aa6sm1518054f8f.67.2025.07.24.02.00.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 02:00:28 -0700 (PDT)
Message-ID: <b0be0a9b-164d-45a9-92f4-63d9dafef855@linaro.org>
Date: Thu, 24 Jul 2025 10:00:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: regulator: Fix incorrect use of binary and
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250703-regulator_uclass_fix-v1-1-8bce90b7e07a@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250703-regulator_uclass_fix-v1-1-8bce90b7e07a@linaro.org>
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

On 03/07/2025 12:53, Andrew Goodbody wrote:
> In regulator_list_autoset there is a test for ret being non-zero and
> error being zero but it uses the binary '&' instead of the logical '&&'
> which could well lead to unexpected results. Correct this to use the
> logical '&&' instead.
> 
> This issue found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/power/regulator/regulator-uclass.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
> index 09567eb9dbb..fbd1f69ac72 100644
> --- a/drivers/power/regulator/regulator-uclass.c
> +++ b/drivers/power/regulator/regulator-uclass.c
> @@ -389,7 +389,7 @@ int regulator_list_autoset(const char *list_platname[],
>   		ret = regulator_autoset_by_name(list_platname[i], &dev);
>   		if (ret != -EMEDIUMTYPE && verbose)
>   			regulator_show(dev, ret);
> -		if (ret & !error)
> +		if (ret && !error)
>   			error = ret;
>   
>   		if (list_devp)
> 
> ---
> base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
> change-id: 20250703-regulator_uclass_fix-d9457eff7fe9
> 
> Best regards,

