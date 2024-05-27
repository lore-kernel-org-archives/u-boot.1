Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B04CC25B78
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 07:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F93388228;
	Mon, 27 May 2024 09:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="U7NR2MPt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3457B88229; Mon, 27 May 2024 09:58:31 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B23D8820B
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 09:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2e72224c395so85952481fa.3
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 00:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1716796708; x=1717401508; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=lblQRap/8v5tjmg/Di/XWbWQghLM05q7B8wQfwC4ofk=;
 b=U7NR2MPtKOaOLv8HBBLvx2seRACmGUlUEnYKZKjXnEmJANOaKqo5cSI/5No8DF75j8
 wOiKidn3Sk3Js7dR7QL1+XkybSDocDGTae7sxrH0QD+3UjbIRhrz5ytJLb26Kqft/ekh
 UEBZ1ji8a2/LoiZMYtoeb+4aEwu/9EZSRxHeq6ISygcNOSJosJLFOf/nVqYd20bDNDnj
 mO7KnWLslYPr7JawYOja/TQq5ObbKbhhOT7H4Ghhd+/iUlt0QDMzQ6X/XnyQ3RKUQQu3
 lmmxvMeLg4L4LirTcKR8oLZV2JUmH9+Tng8isI+1YeMo4STcl13Rrn/QWXwHp73Vhdnq
 iSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716796708; x=1717401508;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lblQRap/8v5tjmg/Di/XWbWQghLM05q7B8wQfwC4ofk=;
 b=onu3wkcxKDVOk7JO9IujQFxiA7xtkjIGzRbifFa3jxiUEjXJcUkavvEuSFu1YeoX+H
 g/vjVrB1OJf0u3L1oL9wIOMXhmrn7tXzy+5kxTmcd7DcdcC5yhOMuSFHpW/X+H879Edd
 Ie8WuS6Bl0vZHxq0r2GTp6YznsfWdnyCzTeAfXuSdbr/S/gMKAVSVcBsyfCKvb767Mm1
 hofoQIEm2C6IcBdlu49qLCv1xwFYWz/CeYd/HPtrhXpR9E2t+0KpJAtEd1FVURl5sqgt
 Aa2Kl390ymId969tY/r8AuneI0IpczKide58k8gzU9yEhGzDcE0a5Re039n6lJnJXZra
 fWHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKPehtcRyfnnu6uWCZioeLagmNcVsXgXtSdjkfqTpZQgaqhqQ4bs76v6PaMmb6pHqtBdqnSp6mMoQPyiI9A7qQsWsVAA==
X-Gm-Message-State: AOJu0YzNH3Du4sxl0re6SVp89hgQZRScasj/lUKXxzz8kcm66/rKKM4X
 jyAxeF3yTzT0fxufaTdfBBuBEqn2mRDw5ldy0BphyTFvn0peF6ePBL4Pl8k/9kE=
X-Google-Smtp-Source: AGHT+IH3LvmO7oKhz0igAWjwRc1OMCWom9nV9O7qLltV9YBG/WjuWNcQ7Y2OZtfTDsitZfmfLbM9ow==
X-Received: by 2002:a2e:beab:0:b0:2e2:7f2:9f9d with SMTP id
 38308e7fff4ca-2e95b0bdc6amr62968441fa.24.1716796708200; 
 Mon, 27 May 2024 00:58:28 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.161.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100ef1207sm131307315e9.10.2024.05.27.00.58.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 00:58:27 -0700 (PDT)
Message-ID: <3e653c2c-ab2e-46bd-8385-c264d9cdc9bc@suse.com>
Date: Mon, 27 May 2024 09:58:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "arm: dts: bcm283x: Add minimal smbios information"
To: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240514130724.1474507-1-pbrobinson@gmail.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20240514130724.1474507-1-pbrobinson@gmail.com>
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



On 14/05/2024 15:07, Peter Robinson wrote:
> This reverts commit 33041972727e84d3f95e26c83322521f61827584.
> 
> With the ability to generate this SMBIOS details autmotically the
> small amount of details that this patch provided are generated
> automatically so this is now obsolete so we can just drop it.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Acked-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   arch/arm/dts/bcm283x-u-boot.dtsi | 19 -------------------
>   1 file changed, 19 deletions(-)
> 
> diff --git a/arch/arm/dts/bcm283x-u-boot.dtsi b/arch/arm/dts/bcm283x-u-boot.dtsi
> index 8c17c6f6a52..ec0f93dd850 100644
> --- a/arch/arm/dts/bcm283x-u-boot.dtsi
> +++ b/arch/arm/dts/bcm283x-u-boot.dtsi
> @@ -6,25 +6,6 @@
>    * (C) Copyright 2016 Fabian Vogt <fvogt@suse.com>
>    */
>   
> -/ {
> -	smbios {
> -		compatible = "u-boot,sysinfo-smbios";
> -		smbios {
> -			system {
> -				manufacturer = "raspberrypi";
> -				product = "rpi";
> -			};
> -			baseboard {
> -				manufacturer = "raspberrypi";
> -				product = "rpi";
> -			};
> -			chassis {
> -				manufacturer = "raspberrypi";
> -			};
> -		};
> -	};
> -};
> -
>   &uart0 {
>   	skip-init;
>   	bootph-all;
