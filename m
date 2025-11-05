Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF40CCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 17:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A56F83AE6;
	Wed,  5 Nov 2025 18:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="X1aWvr5Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03C0B83A5A; Wed,  5 Nov 2025 15:08:27 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1517883A1B
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 15:08:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andrea.calabrese@amarulasolutions.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b727f452fffso52738666b.1
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 06:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1762351704; x=1762956504;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3z3Hreoyc5LEnlxnhvt1RoUSuRJ2bvgjlhDg2tWTfHg=;
 b=X1aWvr5ZMI/1kG9Nq6J8wzNCNdOamreV2FyzwXRr7TyYET1nWjhKWWCzuf5oz+sy1o
 QlRF9+7EUhibbOjAclZwpnYZjNQGNgA2UCPHUyGtI/w488PaAPNbEicp5IkNCD6VDVcH
 OwnYOjXUEeOFKcHp4uNzQekB4MX0Co6+QPu4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762351704; x=1762956504;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3z3Hreoyc5LEnlxnhvt1RoUSuRJ2bvgjlhDg2tWTfHg=;
 b=Q/ISgCs+7qR+meQQrvqinG4pWZkhD0LNumE6T5KAyn3ypE/F9LJZiHQrtmVW9oSXJr
 VUkGp+EkuGU7+I3Y+jqhEPGsrltLuD6n4AblmLE/uba5GfClfSL4GNdm3VLnQh3jKkkP
 AUqJqyiH8RHlzpqlpq0put5nCyAe9aNQqS1/PhPBuIvKDlo7mGHvM0tmhWObnI0X9x19
 4gYJPW0uNUobIYq5kyX70f0rxswHVwiWoM0rgL1ZPEGpPyFD9PF2KLpbbGMbfTy7VX1y
 EqzcISmljS8ufu3e+o7BYbKIkDmX3E0mQmu8QiCS3LxiMcRo4Ll4tqpis8IdBpLVziOf
 jAMg==
X-Gm-Message-State: AOJu0YwP0nffJj1nMt0HAnnIWgpocYzkmLewQSK0Jow0fkdLplQySM4E
 t0eRYb0/UjuIO5jKQlNd6HCQbl332pr1GzN6tKrYh24v0u5SB0tT2QYYXGrqytR2BZc=
X-Gm-Gg: ASbGncsIITrk7s9Jr9y+szejY+ymjUW+mcKg5ACo/izAgGasKiRFvfKiv5rOQ33Onbo
 HTeJjMHCAKQ/JCrDPwAx/08m2/06wKOS4zfoFnqaIGxdjnUB8deijkepWrzgWvDFTBoypPAWW4X
 qeq+u/I32Ky/9I89BnAyeDjg1wWAQxoxkTn56iE3ju5VjdUc+DSavSYOfoG/TqwhCk2PUBXf7dg
 qp4/jKLXp/nskI/qAksVsmOgYo38OH2f5uklDxrj+W5gWPawu8KkcCU6RnwIMNoukdJ9HpG6bpb
 34s+YRNbru8mBFgT75b0ttMh7IsJIq0cEd1e7g8YJVG/OknDZW9U0hQEZNsTw3bkJEY7ztYWpwj
 Jy6MH88qs+UKGDeIzHGloNyKygn6LWdrjmaq+k8YNM28WxpMSlWHhY2YCKiddU/xou3S/bHK5ek
 8+IO9htTqrK6K813s1w0isGv830BxpCckFUsNm/YMfYsPJ/uAqGq9rgTWlOufa
X-Google-Smtp-Source: AGHT+IF65XTUco9LNqmVeK80JZ9E1t4kyM0LTQpK5W8VmbXtIv6/hy3V7kgtSEOzgE6faANXnV43xA==
X-Received: by 2002:a17:907:9449:b0:b6d:671d:8814 with SMTP id
 a640c23a62f3a-b7263246b5dmr453461366b.27.1762351704498; 
 Wed, 05 Nov 2025 06:08:24 -0800 (PST)
Received: from [192.168.1.54] (98-215-98-95.ftth.glasoperator.nl.
 [95.98.215.98]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b724034ade7sm497805066b.69.2025.11.05.06.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 06:08:24 -0800 (PST)
Message-ID: <39087182-ccab-410d-830e-9745e8fb3606@amarulasolutions.com>
Date: Wed, 5 Nov 2025 15:08:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] bsh: imx6ulz_smm_m2: Add imx6ulz BSH SMM M2D board
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, trini@konsulko.com
References: <20251105071308.228223-1-andrea.calabrese@amarulasolutions.com>
 <CAOMZO5AR1+yo+yeUKAhHm73DxdWH4XpdRdD5YgO_Fd2MdnbA7Q@mail.gmail.com>
Content-Language: en-US, it-IT
From: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
In-Reply-To: <CAOMZO5AR1+yo+yeUKAhHm73DxdWH4XpdRdD5YgO_Fd2MdnbA7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Nov 2025 18:22:48 +0100
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

I'm sorry, I thought the change was trivial and did not think about it.

Re-sent now, and built...

Il 05/11/25 14:25, Fabio Estevam ha scritto:
> Hi Andrea,
>
> On Wed, Nov 5, 2025 at 4:13 AM Andrea Calabrese
> <andrea.calabrese@amarulasolutions.com> wrote:
>> diff --git a/configs/imx6ulz_smm_m2.config b/configs/imx6ulz_smm_m2.config
>> new file mode 100644
>> index 00000000000..50dafd887f2
>> --- /dev/null
>> +++ b/configs/imx6ulz_smm_m2.config
>> @@ -0,0 +1 @@
>> +#include <configs/imx6ulz_smm_m2.config>
> A file that includes itself?
>
> You have not tested this, as this does not even build.
>
> Here is my suggestion:
>
> 1. Make a patch that introduces configs/imx6ulz_smm_m2.config with the
> standard defconfig options and convert the existing imx6ulz_smm
> defconfig to make use of it.
>
> 2. Make another patch that introduces the m2d board.
>
> 3. Make sure it builds and boots.

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

