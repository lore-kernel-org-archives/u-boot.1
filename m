Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E51FCCF9FC
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:01:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5E7A83893;
	Thu, 30 Oct 2025 14:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TQ6W4vUg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C774838F8; Thu, 30 Oct 2025 09:41:52 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B907838CC
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 09:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andrea.calabrese@amarulasolutions.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-634cef434beso3421235a12.1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 01:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1761813709; x=1762418509;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RhR3uZEuW5p4fMlgh9PdmaCgOKNUqa31LXDigTHtwl8=;
 b=TQ6W4vUgA5+Fba1GxXzXqz/UJWpecac6ZWFiQUPJ6QRbqm9eMiWPbEX3dULV3pRLA+
 DcJhLTHI9UgYjiIBxfsj1NK9uQai3a5Ho5LF+KGfM5CrzvQ1NwEVpuRo8s9qK+i0rOzu
 i9iyQoexCXZHUFOldabtSAqN6fPCwQ1ls/I7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761813709; x=1762418509;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RhR3uZEuW5p4fMlgh9PdmaCgOKNUqa31LXDigTHtwl8=;
 b=mvDrHvlET3c1sVDlVLMY/b2DYeYoc+Fe7UUKqdFivZAluoLfZWbDzGrtsfhkGEHM3O
 Wc9mNpDli9AZY85isoc1+GJ32CaAmeDQlRngH2/k0ffiZztpvAod+Bj8LKYZaFnq2rPG
 HOvtVqhyRxFFi0Vug1HVvxk5Xj97oz39aAkwsEW5Mj/FBoulGTJR9IiyK7Kk+S5UlNiw
 zqYuJ9KgkQOksWysGyW9uiHaiQX6aFoowt2A5sos6sEBO7eKOiJH9hrz9h+R6gUC+L+I
 JBo7o34RjvSOx3+IOnCjpRnwnV+boyyepJqYG3W7ua5kwp+9b9KfyIvjMPxPdktwYeUt
 yUAA==
X-Gm-Message-State: AOJu0YzLLebSCRyj/LO0PahJpUjtsb2c6V1t3mecx2Po88zC2yduEAqI
 Ba7CxtgoQ4pp9tJSoyEBzeijB1nxWdKQioymncqCg/MqT31GtP7+IZBwBtTF3igj28I=
X-Gm-Gg: ASbGnctb5DCXRcyQSkZDbNP1CpKysqxVxpHn3P4tDqifK5IXq9LLG6oa9lVZ224a13M
 1oV7vNgQOH/HfrdPcdRmuwqUves3fhLgTGYAI+KFU7KVEnbfuICF+tLZ35nHINZm4+6Lly8exoy
 8bCshTAgQS2qNjHYmu2bjyC7BLMqfzhASBj+3tjVJV4p67M71ASKoqgVW0zpGQmzU6lnpjawRt8
 BMb75aiW4MgRjQB0FKEG73199hm7JPMPyJ8rK9q4OOA2kWzdllDNKq9M2bHZW46EvEBL47fCM42
 oUQYAITOucWhpQpx3sHWvDEN+o+W9iqyCgBhuip6ZBpem5npLqM++/Zs2dbQb8Kskk3iljjsH5z
 0PadSU+7q6recrxVP+xRs/F7F+9B5mV4ZEZy9ZMEMwvmPlx5Up7Wtro1Sz0rLtVrj3HLgd4lf/0
 Rcnm2G5YkGTVWNs9xrjnnMeu97uVpo3yP/BMDtiZ6Zqkl9cu5Zx0qAUHJZGEN/Xw==
X-Google-Smtp-Source: AGHT+IEuYGALO6VwKBG9o2wr41gj7Tm1m0HUgNqwJkQs+Nj5MAWiWs5bHFepVHSSaaQDLnzZ1tYc6w==
X-Received: by 2002:a17:907:7f2a:b0:b07:87f1:fc42 with SMTP id
 a640c23a62f3a-b70520bcb84mr316531566b.16.1761813709444; 
 Thu, 30 Oct 2025 01:41:49 -0700 (PDT)
Received: from [192.168.1.54] (98-215-98-95.ftth.glasoperator.nl.
 [95.98.215.98]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85359c0bsm1702590266b.24.2025.10.30.01.41.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 01:41:48 -0700 (PDT)
Message-ID: <c900b5e3-78ef-453a-b79b-0ea7fe1834b4@amarulasolutions.com>
Date: Thu, 30 Oct 2025 09:41:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] bsh: update readme with instructions to build M2B
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, festevam@gmail.com
References: <20251029104901.3810649-1-andrea.calabrese@amarulasolutions.com>
 <20251029191130.GK6688@bill-the-cat>
Content-Language: en-US, it-IT
From: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
In-Reply-To: <20251029191130.GK6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 30 Oct 2025 14:00:47 +0100
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

Thank you,

I will make a V2 for the patch set then.

Best regards,

Andrea Calabrese

Il 29/10/25 20:11, Tom Rini ha scritto:
> On Wed, Oct 29, 2025 at 11:48:59AM +0100, Andrea Calabrese wrote:
>
>> readme was missing instructions to build M2B. Now added.
>>
>> Signed-off-by: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
>>
>> diff --git a/board/bsh/imx6ulz_smm_m2/README b/board/bsh/imx6ulz_smm_m2/README
>> index 03d01325a97..3007180cc47 100644
>> --- a/board/bsh/imx6ulz_smm_m2/README
>> +++ b/board/bsh/imx6ulz_smm_m2/README
> This should get converted and updated as doc/board/bsh/ (and various
> index files updated), thanks.
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

