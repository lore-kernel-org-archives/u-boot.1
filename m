Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1720CCCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 13:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF1F983BE1;
	Thu,  6 Nov 2025 14:09:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Oz7hOmtT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2F8E83B48; Thu,  6 Nov 2025 08:47:57 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B09FF83B22
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 08:47:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andrea.calabrese@amarulasolutions.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b719ca8cb8dso134295266b.0
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 23:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1762415275; x=1763020075;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DBn2z8/2M9sZd3d0pYrpTTtDhQ8c13zZSJ7bGiNRrw4=;
 b=Oz7hOmtTgsCbVg1Swl8uu9wxIudQ9M4u/mL3HMdi22jXBOWyliFNv5W2UI2Bj7xurF
 ARwcolTYuRW53IrmvcS87VrqQkHHTZqJy+qiK/gn8j09nInWYBJCN8YKh/3tbWw+B3+0
 TbsNGbN4DPO1EH8PszmhRAx0WvWuq3MAYoUEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762415275; x=1763020075;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DBn2z8/2M9sZd3d0pYrpTTtDhQ8c13zZSJ7bGiNRrw4=;
 b=QrXCTQbRwBdiehWqCXCaQn2smMGga58tvmi1j7kLYVt66LkwRUHt5IQRmC0EA2kwvu
 1fK6e5MuyusC/NlHeUPPbWa5BvPrrg85Yulg1Gk1rbkFKabtrjdpXYF4rAz0v4OjKmQ/
 06ZRDnSC7INJhMEZd4Xc1nTmCxaI3K7P2ltwev5eLlLr5iltQIL+dpvRCesUpI0S41rK
 JzjuSxU9vjFHdaecgzlWSUIY9Av4hAvs9ygyUH5ZLKtWAf+Rusn6IKuR+wpzAPMq83Dt
 NyHg4qtnCLfZnqvqH71gCL5UMbjCIceKcWm4++fHrQBQVNpS/mBGHpi56EXQAvLbtBJ4
 z6Ig==
X-Gm-Message-State: AOJu0Yz7o2lLVrWaMAGZxwLGd5foe8qlN8X99dObcysEpb0wGv/5cDUu
 iaafcCj4OaASfiWIu5zMrVmWxmtlh42sWFcZpP7TVWiaVuDJLs8JhsVqC+iOX4KavPs=
X-Gm-Gg: ASbGnctIAKdJJG/QMkt3b/Ae9l8KxgaoFW27AG1sxPNHwcG6O0+J3bR9JPIbqozj7ZI
 3dB5nNYnR48ibdQKqKvif5BTirAz9WxH5WdiP/Ljhy8mQvc4kEk1/lN9X2RScxiJQQCFfjvhAdH
 gMOztgTOpO00DuW9J6wrTBsQSosP2Ys/7KfRKKZl5uGy2cp9HT4pB8Q+rxsx9PXXQ8HVlxV+MLz
 YN/erYc44o7/m3C5jcbqAtvewa+ENJzzHljHPFgxrd8qWiulgDCASRUEbWyWPeeIYCcrMv1lzV/
 e9WOrylmG7/h/k0CJdGOqLU71AgS/Uxbc1r5TdikT0RPMgxZ2Xxd25IpCkmVOmVEXr8MH9n1x8B
 S3PYU58ONBScO/nMkXgmPcIPYncY1ue6WPQunOq9V2d5dTSbZ1kP8saPOBYYiMi0ZH1tS+Gbwsh
 2O+RZbJbaJHqEebNpGDMOz+DSXyd0lFGT6JJ11JRmzuupQeu3XDL7lDZbphHin9XzsPu9bmRA=
X-Google-Smtp-Source: AGHT+IF9p7vYHn4RfD3GJbt8Wru5k44irSoZnRFoAK8nX3iUY6ZgCI3AOvrV8Tszpk77c55fbmhzcg==
X-Received: by 2002:a17:907:1c0a:b0:b72:5983:db09 with SMTP id
 a640c23a62f3a-b7265586fb2mr648549266b.32.1762415273992; 
 Wed, 05 Nov 2025 23:47:53 -0800 (PST)
Received: from [192.168.1.54] (98-215-98-95.ftth.glasoperator.nl.
 [95.98.215.98]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b729fa4da20sm47189966b.66.2025.11.05.23.47.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 23:47:53 -0800 (PST)
Message-ID: <edd4ec7b-de13-4db8-89f3-d56f8d8242fd@amarulasolutions.com>
Date: Thu, 6 Nov 2025 08:47:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] bsh: imx6ulz_smm_m2: Add imx6ulz BSH SMM M2D board
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, trini@konsulko.com
References: <20251105140609.117866-1-andrea.calabrese@amarulasolutions.com>
 <CAOMZO5Ach-Dd3R98zD31o1THp_M+yRu8=Pa4Ph6w3aeVJ3MboA@mail.gmail.com>
Content-Language: en-US, it-IT
From: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
In-Reply-To: <CAOMZO5Ach-Dd3R98zD31o1THp_M+yRu8=Pa4Ph6w3aeVJ3MboA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Nov 2025 14:09:26 +0100
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

Hello, sorry for being late, but I wanted to make sure everything builds 
properly now after the previous mistake.

Thank you for your reviews!

Il 05/11/25 15:14, Fabio Estevam ha scritto:
> On Wed, Nov 5, 2025 at 11:06 AM Andrea Calabrese
> <andrea.calabrese@amarulasolutions.com> wrote:
>> Introduce the BSH SystemMaster (SMM) M2D board. Notably, the M2D is
>> designed to leverage the existing device tree of its predecessors, the M2B
>> and the M2.
>> The primary distinction arises from memory incompatibilities with the M2B
>> and M2.
>> To address this, we've implemented a configuration system that allows for
>> selective inclusion of the desired memory components.
>>
>> Signed-off-by: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
> Nit: the 3/3 in the Subject is incorrect as you are sending a single patch.
>
>   diff --git a/configs/imx6ulz_smm_m2.config b/configs/imx6ulz_smm_m2.config
>> new file mode 100644
>> index 00000000000..67c1ca33074
>> --- /dev/null
>> +++ b/configs/imx6ulz_smm_m2.config
>> @@ -0,0 +1,81 @@
> Please do as I suggested before:
>
> 1. PATCH 1/2: Send one patch that introduces
> configs/imx6ulz_smm_m2.config and converts the existing
> configs/imx6ulz_smm_m2b_defconfig and configs/imx6ulz_smm_m2_defconfig
> to use it. Please write in the commit log that the reason for doing
> this is to make maintainance easier, avoid duplication, and simplify
> the introduction of new board variants in the future.
>
> 2. PATCH 2/2: Add M2D support using configs/imx6ulz_smm_m2.config.

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

