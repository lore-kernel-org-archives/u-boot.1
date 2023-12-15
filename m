Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790AFC35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 13:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0B9487BB9;
	Fri, 15 Dec 2023 14:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F7C587BC1; Fri, 15 Dec 2023 14:26:26 +0100 (CET)
Received: from 4.mo581.mail-out.ovh.net (4.mo581.mail-out.ovh.net
 [178.32.122.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E49C87BB1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director11.ghost.mail-out.ovh.net (unknown [10.108.17.234])
 by mo581.mail-out.ovh.net (Postfix) with ESMTP id 845F528C2F
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 13:26:23 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-z9m4m (unknown [10.110.178.161])
 by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id C6C4E1FD9C;
 Fri, 15 Dec 2023 13:26:22 +0000 (UTC)
Received: from armadeus.com ([37.59.142.101])
 by ghost-submission-6684bf9d7b-z9m4m with ESMTPSA
 id WAnxLv5TfGXQsgAAI9rXVg
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Fri, 15 Dec 2023 13:26:22 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004fd18ba91-fa62-4756-b31c-10cfd448d871,
 EE1322658B9640F39C03CDED81C5E13E4737D870)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 92.148.253.243
Message-ID: <8e73cb81-b40e-472c-bfb6-cb4ff32dff19@armadeus.com>
Date: Fri, 15 Dec 2023 14:25:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Makefile: pass -ansi option to cmd_gen_envp
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Le Jin <le.jin@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Fabio Estevam <festevam@denx.de>, Heiko Schocher <hs@denx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Eduard Strehlau <eduard@lionizers.com>
References: <20231215111333.31286-1-sebastien.szymanski@armadeus.com>
 <CAOMZO5C8F3EpzpMS3=XC5n8uzzR30LBpY9V7t-Het7NEe+krXQ@mail.gmail.com>
From: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Autocrypt: addr=sebastien.szymanski@armadeus.com; keydata=
 xsBNBFNfZLEBCACv1lqSePHJNpRgcnER+3emy+Arjz84zFax3XkogjY/e3ZneihIgWrVKe5M
 ql16pX4KTkzNgMUKz4bG/XwT3kjcrXshxFLlg7KrHMl287C+W+QOUjnjVeRi/su+SPmjz8VD
 yr11h+ZkVLAWhS+uQJ93jy1NwG8M4t1kBLAVHHD5Vw4FJ+3ouaVYIp1X1Cr8bVKQw33Q1aTd
 ro0kMBb96B9vNu7ciJZ3gvlaBzUEKOgNnq9KaywuLnqrqr4HUIn5JuxZjCjJzt9kTAKcTfp2
 cJM8qpp+2FF5qtbkse9fZ6M64qozgOPr9Tk4Amf9fZEUQ6UNw14mmBZuXSzoHe75gI7TABEB
 AAHNN1PDqWJhc3RpZW4gU1pZTUFOU0tJIDxzZWJhc3RpZW4uc3p5bWFuc2tpQGFybWFkZXVz
 LmNvbT7CwJAEEwEIADoCGyMHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgBYhBJwGygpYm/1C
 /GCmwbCaKeiBMmTiBQJdhIHLAAoJELCaKeiBMmTixXIH/2W3kbzRG0UF81jtRRnp0H83rjDT
 v0H+8fgFMRL/7HCJ1QPArkfRJlM2wlJkN+ChP09CCarYfUEHfRCHlTb7At6Yyrz1jziD7ZwX
 8IWHYRXnZkY5eZc5DsiUgq6JH49kt+GPzK8UVP9MTa6zkBpPCUf7LzZ4pD3FihdkT52BU3gI
 d9P49fSI0TYySlb/VKn815aOhvwEr7+Dh3mZUjSh7saofbRmVUOr7p+R3MvvGI19/IJZjeOE
 ZWliODDOt6HnBOtoGSXMcNIFF6snH52D5N5gY88njZjTwhgGGUBix1bsgf/EY0v4R5itZBXB
 B/Ze4Tm++YHaB75hZK6PQu/YRv7OwE0EU19ksQEIALo7jhXddrXBTRu5SAjelV53jyHBJTX/
 vN4nL/VbbW/saca+NJjDSxx5DBmotZbQdWIyZiSIjU/xnTREvtDrl6ZeSsKWd7ZqiuiY4fSR
 zwuQp9rd0yqRuxesrWeyJB1zCSdEvLyKASERt+nxkOA+IzJ4y1qLtvnWr+SL1AXgTMw+Tkyw
 KIDCRWHTIYas11ldGj82gOIpYeXnapeNLHfT4EQwg0NeWYHynJxAQWiX5aPlw0uSpAQSsBXQ
 FIe3fpoveMSnXK+PG2BBOzexYv7r4S70a6sF9sgTTPpfKqUaqqC+u1+bUX6alTAKhGKJywaF
 6ViqLlgY8PfwohSyAlqlTRMAEQEAAcLAdgQYAQgAIAIbDBYhBJwGygpYm/1C/GCmwbCaKeiB
 MmTiBQJdhIHSAAoJELCaKeiBMmTitU8IAK7NQM3fEwaF5XaKtepYWsVka44CD8A9e4r7NVK9
 ugirKvXirIxBSDmN/Db862NmVpITsZ6ERNSNZLm/7k55N+TexKYiFZeU7G92TEfAM6qPElvx
 DLEcrkNMq9r08YZeUloacsq31AL5fK4LW+xdvXudkdiKRMJsdTpmff3x5kIziGOHjwFP9wve
 ZgEH52gpbRsP8Whx/Z2lNX/BBRmFM8OnEXFsjjqDzYThdxTq85wGPpkgvvUGyPNRD7TpbB1C
 pajOUUkPxgj5LKt77HD1afeZNudWhgcdkbtT5PMQTT0WY6wvMEj9S1+bGPeXRGWLYB7gHQ+L
 JNoSD7Kz6Y9qnKo=
In-Reply-To: <CAOMZO5C8F3EpzpMS3=XC5n8uzzR30LBpY9V7t-Het7NEe+krXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6052556425107270557
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtvddghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefurogsrghsthhivghnucfuiiihmhgrnhhskhhiuceoshgvsggrshhtihgvnhdrshiihihmrghnshhkihesrghrmhgruggvuhhsrdgtohhmqeenucggtffrrghtthgvrhhnpedtgeehtdduledtudevveekveevveefffdthedtieekgeeukeevtdffieegteekhfenucfkphepuddvjedrtddrtddruddpledvrddugeekrddvheefrddvgeefpdefjedrheelrddugedvrddutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshgvsggrshhtihgvnhdrshiihihmrghnshhkihesrghrmhgruggvuhhsrdgtohhmqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpoffvtefjohhsthepmhhoheekuddpmhhouggvpehsmhhtphhouhht
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

Hi Fabio,

On 12/15/23 13:03, Fabio Estevam wrote:
> Hi Sébastien,
> 
> On Fri, Dec 15, 2023 at 8:14 AM Sébastien Szymanski
> <sebastien.szymanski@armadeus.com> wrote:
> 
>> --- a/board/siemens/iot2050/iot2050.env
>> +++ b/board/siemens/iot2050/iot2050.env
>> @@ -1,4 +1,4 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> +/* SPDX-License-Identifier: GPL-2.0+ */
> 

With the -ansi option, the C++ style comments make an error:

include/generated/env.txt:1:1: error: C++ style comments are not allowed 
in ISO C90
     1 | // SPDX-License-Identifier: GPL-2.0+

I should have mention that in my commit log.

Regards,

> This is an unrelated change.
> 
>>   /*
>>    * Copyright (c) Siemens AG, 2023
>>    *
>> diff --git a/board/storopack/smegw01/smegw01.env b/board/storopack/smegw01/smegw01.env
>> index 93de8669109d..6807ada71887 100644
>> --- a/board/storopack/smegw01/smegw01.env
>> +++ b/board/storopack/smegw01/smegw01.env
>> @@ -1,4 +1,4 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> +/* SPDX-License-Identifier: GPL-2.0+ */
> 
> Same here.

-- 
Sébastien Szymanski, Armadeus Systems
Software engineer

