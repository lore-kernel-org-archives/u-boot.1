Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95269C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 12:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 747C98862E;
	Thu, 18 Apr 2024 14:41:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QqfeHTKY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C7E7884C4; Thu, 18 Apr 2024 14:41:11 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABF328862B
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 14:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4187c47405aso5689565e9.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 05:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713444069; x=1714048869; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ndXgdv4mc2+T9HIspZBbI+543ywWqxCGNevQI19qGhQ=;
 b=QqfeHTKYFiwPzWt04FPsBd3baSoNUlimLcb1VLi5VPSAk2R8MEGAbVYQ0aWEzE8AI6
 9bWB/0qKQxaSrXBMtMY18GI1WdsALsAkzdVfVqX7L4yelOWVo707ZnNu5L25uJNqwhgp
 tkYgPVTlJnhoSp92mC4lXj8g5Khj6uOUVg+oPxCd/vjECNfMYV5Lur3UihvxJPaDwZAC
 XxIysFX0Wvezhu4HsM5Fpw8UBKU+ywOcM3GSlcqoFKZGBVcb7GXd55nCFClHaDSEChEy
 EZs3IjnRDOkYyxzHT3QlM4a9xAMpkcjuQwfEr54z2JzQ/mgflAd0K18MnUpE3FgLwELb
 tGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713444069; x=1714048869;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ndXgdv4mc2+T9HIspZBbI+543ywWqxCGNevQI19qGhQ=;
 b=DnLSBwAWwn9glOpiA4kDFR5mtqC2mVOPqGCHcTPHyB0G0pt7zCNWOcLscDJ8nKPHAY
 xu3vs5qXDssEXBAQjpzFpB4aBbauRB/cRP3g5rTYuUdFZJIEs7hjn3Mbq+HUz368JJ1c
 iLerugDBN5O9RptgnNrK2fLmIQFwtF+vwT8yfJjK/go8zC4djvjvN3+Jp2AkR6piy7e9
 d+10ZSJ1WfECHDaP3u7C7UfN0ru3TaA28/6fYNAFNhM1JCZLJO/YquN8wuZvokk2GhDM
 0OM80AMbAgdZGgr9oFrGoBqDAOyhG865VZHCjB24CU8veJTY+XBEM3NYbSmmzwG/Qzlf
 eiFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHgjnQt8NdrVhciv9EULObTgaf9giihTqW0VeAfixmx4HglXOp2lJ082UFtCrhtbbyH3tedHvD2STMl+SSoG4OWlgp8A==
X-Gm-Message-State: AOJu0Yyg2B5mdTZ/cqZ8ESOBugQqweORWu+72AVN24Zxy6aJoYPEMxHa
 bO5OPvQfIBzPIUeCaXUZfp0101toyiwtHgOgZGPicyWBeVbDrTZ/1/HJRgRpQLs=
X-Google-Smtp-Source: AGHT+IGxvDle7ROGute5+ZXvTKJe9UiN+qyBw+OdoBPsOcRrdMo+aRyKKY17ELxu7V+XKrJo2kQ0WA==
X-Received: by 2002:a05:600c:4f4d:b0:416:9ba0:8f17 with SMTP id
 m13-20020a05600c4f4d00b004169ba08f17mr1601023wmq.22.1713444069261; 
 Thu, 18 Apr 2024 05:41:09 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 z9-20020a05600c0a0900b00418916f5848sm2553220wmp.43.2024.04.18.05.41.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 05:41:08 -0700 (PDT)
Message-ID: <c5a979f0-a25a-49d3-b2c3-5855a6129ad7@linaro.org>
Date: Thu, 18 Apr 2024 13:41:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pinctrl: qcom: ipq4019: adapt pin name lookup to
 upstream DTS
Content-Language: en-US
To: Robert Marko <robert.marko@sartura.hr>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, u-boot@lists.denx.de
Cc: j.beck@linefinity.com
References: <20240418091435.18232-1-robert.marko@sartura.hr>
 <20240418091435.18232-3-robert.marko@sartura.hr>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240418091435.18232-3-robert.marko@sartura.hr>
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



On 18/04/2024 10:14, Robert Marko wrote:
> We want to use OF_UPSTREAM on IPQ40XX as its well supported upstream, so
> as a preparation update pinctrl driver to look for the upstream pin format.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-ipq4019.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-ipq4019.c b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
> index 4479230313..4fcc4b1810 100644
> --- a/drivers/pinctrl/qcom/pinctrl-ipq4019.c
> +++ b/drivers/pinctrl/qcom/pinctrl-ipq4019.c
> @@ -36,7 +36,7 @@ static const char *ipq4019_get_function_name(struct udevice *dev,
>  static const char *ipq4019_get_pin_name(struct udevice *dev,
>  					unsigned int selector)
>  {
> -	snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
> +	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
>  	return pin_name;
>  }
>  

-- 
// Caleb (they/them)
