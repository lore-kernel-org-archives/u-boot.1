Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF99CC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48A8488089;
	Mon, 15 Apr 2024 14:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BfHYfBTD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E49A88190; Mon, 15 Apr 2024 14:51:41 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 816D988089
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 14:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-343f62d8124so2721465f8f.2
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 05:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713185499; x=1713790299; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yfevUrTHDVyjmGULmngunNbxx5tEzC9/7mh+8oUmIGw=;
 b=BfHYfBTDZ98B246kQBAepGj0X7ufjqsihywKs3yUh9Gmcj8EH+xjbBwkG4ZQYhJTr0
 z3THIFsrxWuvyW5659/5XyUo2P78v2yIhC9gcKRDurVLlUmpGbJrmj37DnfdoulzvmnI
 01bUQnxzjNrYMXhY+C6PtfhTmXjPFxa59nB6W8je3pQpRmiPKu0+yJeUtC6dPHBU6LDg
 QFmhYkfEn2pOX5Jjb48uCWohFya/0ZGabrTkWumi2pOby6IGjlIDr8reDBLBjZ2ImhQ6
 kcrytBh1spTrRVqJ5j1dsBPSeMuT1OcgqbIY4Yo3LNnV8zcdDXp5SseX7/0KGb3O54Sy
 IKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713185499; x=1713790299;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yfevUrTHDVyjmGULmngunNbxx5tEzC9/7mh+8oUmIGw=;
 b=jTsLaMnUOP6Lh6m746qzmshcBtpEh7m56QC8B8+B7eN7aUV64uAzGBZXorCpdk4M0L
 5m4UtpLwMmt08jj8kF9tDWSqzJq7y3Bc0VRoLUPAbYmIxJlL33Dg8gKZ7WF7+O5/mYlr
 G9F/bgVyTpQ3ghRfBrnTBh7AVmT03Bv5Q3Bf46VtT8CNB4VmGSRykcfng23TTtWgpEz3
 o84Zyf+NwPLTrMcfcUsWH7gEuyDucHFEVITF9VojbeMlGs3SNznCTdyGgSfnFkaz91d8
 BcFL7XVW7I0kt9tCljLgp5fCkkjeJyFpO0tzsst78Ss+RTAuFqFKkXVSj3wJpDYHsQwS
 J7Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+EchA5JEG2yndoQWmelyIF0HnAv68CEdZ3hLuE/udu5Ceo3qHBdOxthyJYPmfnk2vOyyuxCB7rT+VwbHQzwK9eLxL2g==
X-Gm-Message-State: AOJu0YxGjPYnwUrkAm1eRp9zGuMZhDiudXD75q5OiQX8MnkMzOstdmAm
 TLaoNu0id/tuLU3d9TblbDcUpj5nteLyk1F5b2Nm+knmFPcJsD6wbKemj9WS9xg=
X-Google-Smtp-Source: AGHT+IHMo8M/TCAxVckkLj4ITtkewp5kKQb8rY13NGnvYrcTneycBMt3YVbNfCl0ZH2/JH7MppzRkQ==
X-Received: by 2002:adf:ab03:0:b0:346:758e:5f29 with SMTP id
 q3-20020adfab03000000b00346758e5f29mr7029793wrc.60.1713185498966; 
 Mon, 15 Apr 2024 05:51:38 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 c10-20020adfc04a000000b003467a420243sm12117833wrf.12.2024.04.15.05.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 05:51:38 -0700 (PDT)
Message-ID: <304870ea-c277-486d-9746-5affdb02019f@linaro.org>
Date: Mon, 15 Apr 2024 13:51:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3-generic: fix support without DM_REGULATOR
Content-Language: en-US
To: Robert Marko <robert.marko@sartura.hr>, marex@denx.de,
 trini@konsulko.com, jonas@kwiboo.se, kever.yang@rock-chips.com,
 jagan@amarulasolutions.com, neil.armstrong@linaro.org, sjg@chromium.org,
 peter@korsgaard.com, u-boot@lists.denx.de
Cc: j.beck@linefinity.com
References: <20240415115728.448176-1-robert.marko@sartura.hr>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240415115728.448176-1-robert.marko@sartura.hr>
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



On 15/04/2024 12:56, Robert Marko wrote:
> Recent addition of vbus-supply support has broke platform which dont use
> controllable regulators for USB.
> 
> Issue is that even withou DM_REGULATOR being enabled regulator related
> functions will still build as there is a stub in regulator.h but they will
> simply return -ENOSYS which will then make dwc3_generic_host_probe()
> return the same error thus breaking probe.
> 
> So, check whether return code is -ENOSYS before erroring out.
> 
> Fixes: de451d5d5b6f ("usb: dwc3-generic: support external vbus regulator")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Changes in v2:
> * Drop #ifdefs and check for -ENOSYS that regulator stub returns
> 
>  drivers/usb/dwc3/dwc3-generic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 7a00529a2a..df0b0b8c02 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -248,7 +248,7 @@ static int dwc3_generic_host_probe(struct udevice *dev)
>  
>  	/* Only returns an error if regulator is valid and failed to enable due to a driver issue */
>  	rc = regulator_set_enable_if_allowed(priv->vbus_supply, true);
> -	if (rc)
> +	if (rc && rc != -ENOSYS)
>  		return rc;
>  
>  	hccr = (struct xhci_hccr *)priv->gen_priv.base;

-- 
// Caleb (they/them)
