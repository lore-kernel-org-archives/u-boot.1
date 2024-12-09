Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1C4E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 16:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6780388FA8;
	Mon,  9 Dec 2024 17:55:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xmzw0QTk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35D898962C; Mon,  9 Dec 2024 17:55:15 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C7D48916C
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 17:55:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa68d0b9e7bso209656566b.3
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 08:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733763312; x=1734368112; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3/W57uyOfnteisLkrPg9+jvQWl5lqU/tcoLfOLGo2gA=;
 b=Xmzw0QTkcsPhiwgDhH3pfqHqcSU6VR6+ykl1snPpD6uuyLaf5Jaiu2DtrDzI3X0b0o
 xTSiDq25dInwFx6C+fSEBE2HTnTvGjJbelsWj8XZxPfYGiB6DiH2+4B6VYnir9Jf+UZ9
 fR7R4MWRE72QsNLowXhnBN/CJtNSEc6xezS0ULkeFgjp+Ue95l6k/8vE1aZ4HruS0Lbf
 TgSPO8b4FIsT46MMccZKTuD5/novOUbN8IwLkvO88rosYaEhBVL+Fa9/HJT97rOkeSFR
 WQE/ABJbKxJIdjHSMf4uEfk8C/8lMAtT8EVYNTE4dgfPFxS/+woGbTGEDn7hRb8M72I0
 Ag+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733763312; x=1734368112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3/W57uyOfnteisLkrPg9+jvQWl5lqU/tcoLfOLGo2gA=;
 b=ElP60enZjprmaQFM5Wj+9RPgagME/QYxp7+CtqNSXDQEvlzTTdbbumVE+AnV94kWAg
 ZXlOdSeiutW1Ugni82+MiJQd6EYGu30kF8/7p0xXgCjnuh57H5DEXoRHiE0wD/zHZ1mP
 fXlczBd8bun9zjbjMie2UuhcYt0GJBuaUh+fi9tAmK97PLguR7xUBNzqI41rkHwWSxNq
 i696L2OjSe61/B7L9fG2cBHkFxETUAwd61v+Qh3uzql3J9+4byygw+6gIZAlzBqrj6pD
 dUbXbDSLR2NQURn4D8CGtjH8+QlmavywIvFoCIrlLYGEhMMZ0oqvoKD4aE1+DGQBWYce
 LP6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzHtopa5OLKI50YjwRS+YNwZf3dyvN/Eth2rcgctfaswqsB8Th7RlPXWETDg81ng+PhxioPJ4=@lists.denx.de
X-Gm-Message-State: AOJu0YztqVpo+Akm27HPnHV7JQK7+5g+FpTAUeqEV0+jt8u3NldBgoWx
 pN4NK29KiZdTmyxyZJ7FUDKZHOEA98NXmpJ6HWDpceW/apqHq4D97m8XIoaeF+vvzq2u8E8BAlL
 OKUg=
X-Gm-Gg: ASbGnctQesGiS5Ulj+nGP/N/3pdzul/tFdsIZ2O1ZCngEqWoPFtJcFbMXZdDFDKokLn
 YVR2ojNKDnFzgStP/SkXqi0FnUQtusG6v9GAvT6PGgu19McCaNRP4GVD35yJhH71GipFxAySe4P
 R2cHI5TNrs+iwYnF+YIEP3lXIPH1AjVd2zFLzR1sa4GUgBW26pMsfXAcWkS3Rt7PveeHedoMhh3
 goNkawa4FvcOxrJ/Dve9WdJQ/Li18KsRo8TOeIT1AhEaNbkjhGjD34QFgeotSuCf9y5DqPTrYXm
 H0HhFAj+rXCeEqmfbTxRaW3fWPrqDx3F
X-Google-Smtp-Source: AGHT+IHZlJ7WYGRo9ahYSX0UMBiYFwvXwvXNrn2uxe9kOCgDBSW/Se2KF6/yrFU4jCgHh8ZwKhYiNg==
X-Received: by 2002:a17:907:7703:b0:aa6:8fed:7c15 with SMTP id
 a640c23a62f3a-aa69cd4635cmr142408366b.17.1733763312490; 
 Mon, 09 Dec 2024 08:55:12 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa68a1ea59asm162538466b.118.2024.12.09.08.55.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 08:55:12 -0800 (PST)
Message-ID: <9f2d69ec-d760-4189-ab63-a804c419cf0a@linaro.org>
Date: Mon, 9 Dec 2024 17:55:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cmd: Allow building ufetch without CONFIG_BLK
Content-Language: en-US
To: =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20241205-ufetch-v1-0-df861318bd49@posteo.net>
 <20241205-ufetch-v1-2-df861318bd49@posteo.net>
 <3367bf91-1715-416b-b6d9-751f385971d4@linaro.org> <Z1cgKCUyvspIe7Nb@probook>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <Z1cgKCUyvspIe7Nb@probook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 09/12/2024 17:51, J. Neuschäfer wrote:
> On Mon, Dec 09, 2024 at 04:04:50PM +0100, Caleb Connolly wrote:
>> On 05/12/2024 19:35, J. Neuschäfer via B4 Relay wrote:
>>> From: "J. Neuschäfer" <j.ne@posteo.net>
>>>
>>> The ufetch command is still quite useful on systems without block
>>> device support; remove the CONFIG_BLK dependency and make sure the code
>>> compiles/works with and without CONFIG_BLK.
>>>
>>> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
>>
>> Small nit below, but with that:
>>
>> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
>>> ---
> [...]
>>>  		default:
>>> +#ifdef CONFIG_BLK
>>> +			struct udevice *dev;
>>
>> At least without the #ifdef, I see a warning "A label followed by a
>> declaration is a C23 extension".
> 
> Ah, I wondered about this. Apparently I have a compiler that uses C23 as
> the default, so I didn't see the warning. I'll fix it in the next revision.
> 
>> So to be on the safe side please put this section in a block:
>>
>> 		default: {
> 
> An alternative that I prefer because it's a bit less intrusive with
> regards to indentation, is to use a semicolon:
> 
> 		default:;
> 			/* code with the same indentation as usual */
> 			/* and no closing brace to remember */

Hmm, haven't seen that one before. fwiw I think you can leave the
indentation as-is and just add the brackets.

Kind regards,
> 
> What do you think?
> 
> 
> -- jn

-- 
// Caleb (they/them)

