Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ECED6B6B3
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 17:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B01318925A;
	Wed, 30 Oct 2024 18:20:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y1K+xzrG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64D2F88FCB; Wed, 30 Oct 2024 15:49:16 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D956288F1E
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 15:49:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37ed3bd6114so4261529f8f.2
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 07:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730299753; x=1730904553; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ih2LJlFP7ouZI4XpcBod+6u3eX6bDouMjqKHkaaXymM=;
 b=Y1K+xzrG2EHR7LLu6MjOWCB1cfHwN27xHXZG405uPCFLmsk3vGQ49EP9dzYfhZEF0M
 QMDRR9pGWqj41uXu5OtpAVISHPLUNMBVe8j77XtwxbAjdTWsX6qGwGOSLZZdIOYsRT7u
 av6l+vrzXepea2VL9RAXDp3GaJr5YgfYZvooTxgZXZabEbgkRJe0hFso17uByaGPblA7
 IIknE2zJqIzKfvFvExa5OX3TBN3qOHlLAPwN1yGUJLKUXsUXmpFc1ElL2ORNnJ3VdTC4
 yUBeXZbu/6WqZcULM3f99u29L9SNUy6Zi2H3fT9JM9pDWdXm/i0q5on9UfHjr4LJaGE/
 Lmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730299753; x=1730904553;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ih2LJlFP7ouZI4XpcBod+6u3eX6bDouMjqKHkaaXymM=;
 b=gqMPSuKOqMDZyUitcaA1WehUc8AKnnLgQSKI9/m7fP3hBrXGG1Uf1F/8uPX8j/rncZ
 w98Aew4s9z+oPbeRm4ab8VU1q96tz4df5Dmj7LOyAweqUCoGFygaaHqrQoS9uH7se7NT
 dBqHLoCqtBUU0O6voU/XshFpxEHEytaisQbWv4DdkjmVWBZrNA58ADFOhmXp4b7AzI2E
 6iZ+e8H88m16lk5kKiTSI7MJrSJV2GOrnJao4+kmjtsfHrpw42KN3SNqolX6DJrhFRol
 UtV0MAyQ6jkCWOqxoil25PjPfZP4lUEouJ6dwv2cslEzY/PQcWy8BYHivHrTulv7pHjq
 2vXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr5GOkALaoQKA4CzosnScSJZY/5zk7gOv1n3ROgzW5DwoXaTrPn9SKwAA0s0U9fI9mm5c0Skk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyaoy9vDBA/BcLt4452uBGsVVPkwNMVIQ50ffj5v/YCIY1tyxRB
 rHAn/Y8yOTKN0cOEZegxlGhhzNv5mpQOo2QXs0S35JucqJBlVs/AOra9HDdqlUTzb3Ybeq2o8Fw
 NdFA=
X-Google-Smtp-Source: AGHT+IFYoOhMxj6VEKeLgltGCkOwtk27OCgc4bLo1XLu2tG7cwUBRJZ/wx0AAKiY5vt42jOifFD7qA==
X-Received: by 2002:a5d:4f92:0:b0:37d:3985:8871 with SMTP id
 ffacd0b85a97d-380611dbea7mr10884829f8f.39.1730299753154; 
 Wed, 30 Oct 2024 07:49:13 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b3be78sm15647491f8f.31.2024.10.30.07.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 07:49:12 -0700 (PDT)
Message-ID: <f797cb27-84ca-41c3-83a5-b9044f2d5e5c@linaro.org>
Date: Wed, 30 Oct 2024 14:49:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] mtd: spi-nor: Remove recently added nor->addr_width
 == 3 test
To: Jagan Teki <jagan@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Michael Walle <mwalle@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
 <CAMty3ZB3ngMezv9S2XrNjXL69q+z9x-=qnQGga51FgTfA4fanQ@mail.gmail.com>
 <19fc4486-f8fe-4286-8941-76ff2a81b7d9@linaro.org>
 <CAMty3ZAJrKvUAxWg9CfKtyrjw+WnHOgwkfAJb+N-7d3NyXUrxA@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAMty3ZAJrKvUAxWg9CfKtyrjw+WnHOgwkfAJb+N-7d3NyXUrxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Oct 2024 18:20:04 +0100
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



On 10/30/24 2:17 PM, Jagan Teki wrote:
> On Wed, Oct 30, 2024 at 4:15 PM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>>
>>
>> On 10/30/24 10:33 AM, Jagan Teki wrote:
>>> Hi Marek,
>>>
>>> On Sun, Oct 27, 2024 at 1:48 AM Marek Vasut
>>> <marek.vasut+renesas@mailbox.org> wrote:
>>>>
>>>> Remove undocumented nor->addr_width == 3 test. This was added in commit
>>>> 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support")
>>>> without any explanation in the commit message. Remove it.
>>>>
>>>> This also has a bad side-effect which breaks READ operation of every SPI NOR
>>>> which does not use addr_width == 3, e.g. s25fs512s does not work at all. This
>>>> is because if addr_width != 3, rem_bank_len is always 0, and if rem_bank_len
>>>> is 0, then read_len is 0 and if read_len is 0, then the spi_nor_read() returns
>>>> -EIO.
>>>>
>>>> Basic reproducer is as follows:
>>>> "
>>>> => sf probe ; sf read 0x50000000 0 0x10000
>>>> SF: Detected s25fs512s with page size 256 Bytes, erase size 256 KiB, total 64 MiB
>>>> device 0 offset 0x0, size 0x10000
>>>> SF: 65536 bytes @ 0x0 Read: ERROR -5
>>>> "
>>>>
>>>> Fixes: 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support")
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>> ---
>>>> Cc: Andre Przywara <andre.przywara@arm.com>
>>>> Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
>>>> Cc: Jagan Teki <jagan@amarulasolutions.com>
>>>> Cc: Michael Walle <mwalle@kernel.org>
>>>> Cc: Michal Simek <michal.simek@amd.com>
>>>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>>>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>>> Cc: Pratyush Yadav <p.yadav@ti.com>
>>>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>>>> Cc: Sean Anderson <seanga2@gmail.com>
>>>> Cc: Simon Glass <sjg@chromium.org>
>>>> Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>>> Cc: Tom Rini <trini@konsulko.com>
>>>> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
>>>> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>>>> Cc: u-boot@lists.denx.de
>>>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>>>> ---
>>>
>>> Is this patch-set next version for 'previous' reverted series?
>>>
>>
>> my 2c: I think I lean towards reverting the stacked/parallel support.
>> The only one that benefits of is AMD, while affecting the core code
>> quality. It also slows down further contributions and I assume it
>> hardens maintainer's job.
> 
> I did try this before and it is hard to separate from the core. and at
> the same time it is hard to maintain the core too.
> 
>>
>> Even if I (we?) haven't made my mind on how to best implement this, it's
>> clear that it shall be above SPI NOR without affecting current devices.
>>
>> Not sure if it's fine to revert everything, haven't followed u-boot
>> lately, your choice to make.
> 
> If we find a way (not sure if it's possible) separate like a wrapper
> or fix the things without revert - these are two points I can see as
> of now.
> 

Then this set shall help move in this direction. Some involvement from
the stacked/parallel authors would be nice here, and some commitment
that the current status in just a temporary situation.

All the stacked/parallel code shall be pulled out from SPI NOR
eventually. The design is treating 2 independent flashes as one.
Whatever ties them shall be above SPI NOR. In the meantime we all suffer
until that is achieved. I guess if things become unbearable we can't
remove everything later on, can we? Or maybe this ship has sailed
already, I don't know.

It's really your decision to make because you maintain this code. If
full revert is chosen, I can agree and ACK that. If we keep it and try
to sweeten everything a bit, then be it.

Cheers,
ta
