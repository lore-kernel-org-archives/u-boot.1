Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79390CCF9FE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 10:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D64AE838E7;
	Fri, 31 Oct 2025 11:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UaKDeHwU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE85383642; Fri, 31 Oct 2025 08:45:26 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FEA9800B1
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 08:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andrea.calabrese@amarulasolutions.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-63e18829aa7so2654985a12.3
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 00:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1761896724; x=1762501524;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kI6PE/moS170NniqYn/ONvoARxpvRKpgDQMB3SAIvFk=;
 b=UaKDeHwUsPYbXItPi2FPr3TZa3iwr+704IN2gvp7OJcd1bnjZS0H00OkWBXJwL3aZN
 LnWxR32s/xBmMlmNgrp5NvJR01OOCTySTkQTCENuShUiwYiCwvpJpDO1q5rY0kjBBSIE
 /qpvpOPBv+N7TpA2h35AxeVXradZ67sg4lEH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761896724; x=1762501524;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kI6PE/moS170NniqYn/ONvoARxpvRKpgDQMB3SAIvFk=;
 b=vPwmJ3POJ14AcZ4g8ucCj6/sUbzDS1cN4+37t0n0XPs6GQ+aS2uTDER6+e7L4rFP6F
 Rq2e6GtS+lUm+HiWd9ow3VxNOWbilR0ngF+pS2A3pOJw+6ZBn28ugtjwEwEPhLJKiXdi
 FZr3NrGqLKETQa4wxald3mUR2h3PqaW663g3figXYWVzeMbZIbX/2jGUFsxOzp8Wu5XJ
 eKz7CebQex67gagbI0oy7sz3i95jVm5tB5PUIFukoWaQIeF9jDqKbDjM2CjgChTDbBwM
 x/7reIequQaEq9399Opx/h1R2mdwe1+bbokL7EFCW9JdRDea/nG5t8TzX724tcphvtGN
 o4oQ==
X-Gm-Message-State: AOJu0Yy+R3B9ono8eXkuc2pwU20vlzcJHLwrk0quguDIctFBsADJQQIB
 dl33VIpeYm2e0OMkmwXLrBsLjciX8qioREWtzuk/u2zORiJFIMDN2yhSdx+5snFCQCA=
X-Gm-Gg: ASbGncudL09dlyIMs7Yb29xWZyZFR+5KHDE032PhCTSgIHfCfVJStKEMJeD+SOxxGX+
 Ytwofhoh7sxa2PwFXVOf22mpm/EKuyEM4S0FYQszWZ5CngFxuPYdzHzqv5JS+P6WO4bclvu2tbg
 ER+qbAngaTG86e0Mbv8a1t18XvliiogyhwT0mHQuqzZv/jmi9+HnrwrPavctWnlLobvtKxx4udV
 09IoH50aRaAAYug+z+cNWC1oWOpFoMIJ+v0LSkKXs1WBtBaJwP/uC5Znhif6Bfa9ZCXkf3vgtKY
 8bOW4DxPYgO5ep9Nct4iUrV5m0CEDGM+m1aN0iyREUKULq7vkbj+iM3d8ukTdrD1anTfwYte+8Z
 bd9+1joqCODL+nLDeeO//GG6QQ1JSyFuP2UUy/VnUMT1fnSQ2/mig8r2o3mL8JJVvSEFtJlGz73
 kiPjrvXQMYtvG3wp06fTbM84oDU7DGyxjfyOeOU8/duWnKJwntScxlqssisaJ0hA==
X-Google-Smtp-Source: AGHT+IHkbmVfKlqDIYyD4xRQAIaZzr7CFwtt3kLoNdG2vf0Eh9YjO14bCeo7DLc3w/RCX7Uro/Y3LA==
X-Received: by 2002:a05:6402:5111:b0:63e:2d4d:5a60 with SMTP id
 4fb4d7f45d1cf-64076f67066mr2070744a12.8.1761896723821; 
 Fri, 31 Oct 2025 00:45:23 -0700 (PDT)
Received: from [192.168.1.54] (98-215-98-95.ftth.glasoperator.nl.
 [95.98.215.98]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6407b390d7dsm970734a12.10.2025.10.31.00.45.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 00:45:23 -0700 (PDT)
Message-ID: <22fb0887-e1a2-4a0e-8b8a-5b49e78ebfbf@amarulasolutions.com>
Date: Fri, 31 Oct 2025 08:45:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] bsh: update readme with instructions to build M2B
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, festevam@gmail.com
References: <20251030084710.3995770-1-andrea.calabrese@amarulasolutions.com>
 <20251030133649.GR6688@bill-the-cat>
Content-Language: en-US, it-IT
From: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
In-Reply-To: <20251030133649.GR6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 31 Oct 2025 11:57:12 +0100
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

You are right, I used a tool to verify everything was in order, but I 
did it in the last commit... Will send a v3.

Il 30/10/25 14:36, Tom Rini ha scritto:
> On Thu, Oct 30, 2025 at 09:47:08AM +0100, Andrea Calabrese wrote:
>
>> readme was missing instructions to build M2B. Now added.
>>
>> Signed-off-by: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
> [snip]
>> diff --git a/doc/board/bsh/imx6ulz_bsh_smm_m2.rst b/doc/board/bsh/imx6ulz_bsh_smm_m2.rst
>> new file mode 100644
>> index 00000000000..c61dbfe2ae7
>> --- /dev/null
>> +++ b/doc/board/bsh/imx6ulz_bsh_smm_m2.rst
>> @@ -0,0 +1,85 @@
>> +.. SPDX-License-Identifier: GPL-2.0+
>> +
>> +How to Update U-Boot on imx6ulz_smm_m2 and imx6ulz_smm_m2b boards
>> +==================================================================================
> Please see doc/build/documentation.rst for how to build the
> documentation as there's errors here that will trip CI. Headings (===)
> need to be the exact length as the text. Everything else is probably
> fine but I can't always spot spacing errors without building. I don't
> know if Fabio wants to fix this part up when applying. Thanks!
>
-- 
Andrea Calabrese
Embedded Software Developer
M. +39 339 394 4747
andrea.calabrese@amarulasolutions.com

__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9170
info@amarulasolutions.com
www.amarulasolutions.com

__________________________________
This message and any file transmitted with it may contain privileged or confidential information. In case you were not listed in the addressed recipient, please notify the sender immediately and delete the message.
Any other use of this email, including copying it and the disclosure of its content, is prohibited.

