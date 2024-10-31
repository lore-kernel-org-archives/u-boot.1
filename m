Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B03CD74959
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 13:09:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EB7A892B5;
	Thu, 31 Oct 2024 14:09:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bQHCrfSz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D480789245; Thu, 31 Oct 2024 08:10:36 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 640B889288
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 08:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37d47b38336so498492f8f.3
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 00:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730358634; x=1730963434; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MSTWRPHinJZQzx9wAdFkaC9m1ILgta8SsdyNNp9eS7g=;
 b=bQHCrfSz7VWUV5hltB6dndZmmh26MjsYrJ7Q5OQ+ejzTwQIjiAIthkiTBNc5264BDT
 bT3EtVkLvb7AnyIkiZutXtOrTIA6PeoVL8XS82d+AQi9W29Pv0gP3IQNCaepzR+0oj22
 GHSUXkuuJIrjgA4CtUjGtja9CIgpBI6QC1hcnhcEVD9oJrj1Nmq6LqP0GBE0NVTrP5eu
 3xJAIYCuvhSA+/Jsmxii5XXDOz7VAfkkxUcAZ8/XpszQJgmq19choM6zpeADxd51DU8v
 gkFsXvcgjOMcGxWwSNwmrvRmsecfVupgvuKy5T5UAdw9M4ObkvpT6n3yHBXtZMUV28jZ
 4xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730358634; x=1730963434;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MSTWRPHinJZQzx9wAdFkaC9m1ILgta8SsdyNNp9eS7g=;
 b=BsNmmdGR1IlruqSQHVZ/3IxapfPwqBSbSSzl4jOJf/5CEVxVyCq5K+OKpNdrv2lqwN
 t8dUZA3jmq3gx0G/VjGYlZygDxl7P4Dh8Nv6LsTrNm//yK0IJr5dWxDta4hTU+lDw0LC
 YuPrPsxo9VEQ87fy0rnV875jGt8ghKCzg7fn1a1qabC2qrMlAFdqakuLuDua4/gmSWHy
 WbgCM5e2x41okOOdSn8F5qnNrrFsocgLvB2HVhHLHG9RZLGlz7MyUAdEt8BwX59PDwUu
 F2AXvGh92AXUZYb82uyP8wGWsr0BfFfe1JtMDs3sng5zsMJrlklCS93eVE6yNh152KMv
 D9XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2PTW1wd8AIKdMQMZZeIc69jRPEFWPrOhx9+emAkiEw0VYFj1XRO5SEm2a1LLVBRsTKbFg24A=@lists.denx.de
X-Gm-Message-State: AOJu0YzNlUJ5crKTbgZa/DTi4YDgdY9a29bVCSskBGSvvsr7AZfho2/2
 Axswdr/vSW8u4evXhgf5xdArfw8/BhhNK8Se9c6lVutmxvRYfDipR07kJFvuy+A=
X-Google-Smtp-Source: AGHT+IFjRC2LtqEIZ0hor5n7YMgzAAOXBut70z1XBAp9fWZsC1gaX50jfCgDip1ZAEi7RG1KKgJ55Q==
X-Received: by 2002:a05:6000:d4f:b0:37d:45c3:3455 with SMTP id
 ffacd0b85a97d-38061163803mr13532110f8f.30.1730358633774; 
 Thu, 31 Oct 2024 00:10:33 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7c13sm1169113f8f.13.2024.10.31.00.10.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 00:10:33 -0700 (PDT)
Message-ID: <37c64d4a-1d5b-4f5e-bf2d-6e2a8b6b7669@linaro.org>
Date: Thu, 31 Oct 2024 07:10:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] mtd: spi-nor: Remove recently added nor->addr_width
 == 3 test
To: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Michael Walle <mwalle@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
 <CAMty3ZB3ngMezv9S2XrNjXL69q+z9x-=qnQGga51FgTfA4fanQ@mail.gmail.com>
 <19fc4486-f8fe-4286-8941-76ff2a81b7d9@linaro.org>
 <CAMty3ZAJrKvUAxWg9CfKtyrjw+WnHOgwkfAJb+N-7d3NyXUrxA@mail.gmail.com>
 <f797cb27-84ca-41c3-83a5-b9044f2d5e5c@linaro.org>
 <3835b139-ae37-423e-8a24-a958ece69c0d@amd.com>
 <20241030165618.GP2558755@bill-the-cat>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241030165618.GP2558755@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 31 Oct 2024 14:09:45 +0100
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



On 10/30/24 4:56 PM, Tom Rini wrote:
> On Wed, Oct 30, 2024 at 04:20:32PM +0100, Michal Simek wrote:
>>
>>
>> On 10/30/24 15:49, Tudor Ambarus wrote:
>>>
>>>
>>> On 10/30/24 2:17 PM, Jagan Teki wrote:
>>>> On Wed, Oct 30, 2024 at 4:15 PM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 10/30/24 10:33 AM, Jagan Teki wrote:
>>>>>> Hi Marek,
>>>>>>
>>>>>> On Sun, Oct 27, 2024 at 1:48 AM Marek Vasut
>>>>>> <marek.vasut+renesas@mailbox.org> wrote:
>>>>>>>
>>>>>>> Remove undocumented nor->addr_width == 3 test. This was added in commit
>>>>>>> 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support")
>>>>>>> without any explanation in the commit message. Remove it.
>>>>>>>
>>>>>>> This also has a bad side-effect which breaks READ operation of every SPI NOR
>>>>>>> which does not use addr_width == 3, e.g. s25fs512s does not work at all. This
>>>>>>> is because if addr_width != 3, rem_bank_len is always 0, and if rem_bank_len
>>>>>>> is 0, then read_len is 0 and if read_len is 0, then the spi_nor_read() returns
>>>>>>> -EIO.
>>>>>>>
>>>>>>> Basic reproducer is as follows:
>>>>>>> "
>>>>>>> => sf probe ; sf read 0x50000000 0 0x10000
>>>>>>> SF: Detected s25fs512s with page size 256 Bytes, erase size 256 KiB, total 64 MiB
>>>>>>> device 0 offset 0x0, size 0x10000
>>>>>>> SF: 65536 bytes @ 0x0 Read: ERROR -5
>>>>>>> "
>>>>>>>
>>>>>>> Fixes: 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support")
>>>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>>>> ---
>>>>>>> Cc: Andre Przywara <andre.przywara@arm.com>
>>>>>>> Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
>>>>>>> Cc: Jagan Teki <jagan@amarulasolutions.com>
>>>>>>> Cc: Michael Walle <mwalle@kernel.org>
>>>>>>> Cc: Michal Simek <michal.simek@amd.com>
>>>>>>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>>>>>>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>>>>>> Cc: Pratyush Yadav <p.yadav@ti.com>
>>>>>>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>>>>>>> Cc: Sean Anderson <seanga2@gmail.com>
>>>>>>> Cc: Simon Glass <sjg@chromium.org>
>>>>>>> Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>>>>>> Cc: Tom Rini <trini@konsulko.com>
>>>>>>> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
>>>>>>> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>>>>>>> Cc: u-boot@lists.denx.de
>>>>>>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>>>>>>> ---
>>>>>>
>>>>>> Is this patch-set next version for 'previous' reverted series?
>>>>>>
>>>>>
>>>>> my 2c: I think I lean towards reverting the stacked/parallel support.
>>>>> The only one that benefits of is AMD, while affecting the core code
>>>>> quality. It also slows down further contributions and I assume it
>>>>> hardens maintainer's job.
>>>>
>>>> I did try this before and it is hard to separate from the core. and at
>>>> the same time it is hard to maintain the core too.
>>>>
>>>>>
>>>>> Even if I (we?) haven't made my mind on how to best implement this, it's
>>>>> clear that it shall be above SPI NOR without affecting current devices.
>>>>>
>>>>> Not sure if it's fine to revert everything, haven't followed u-boot
>>>>> lately, your choice to make.
>>>>
>>>> If we find a way (not sure if it's possible) separate like a wrapper
>>>> or fix the things without revert - these are two points I can see as
>>>> of now.
>>>>
>>>
>>> Then this set shall help move in this direction. Some involvement from
>>> the stacked/parallel authors would be nice here, and some commitment
>>> that the current status in just a temporary situation.
>>
>> I hope that by authors you mean SW owners not really HW authors of this wiring.
>> Jagan is aware that we are using this configuration for quite a long time
>> and we are still here and not leaving.
>> As you know Amit is trying to find a solution in Linux but nothing has been
>> agreed yet. If there is agreement to separate it to own driver or so we will
>> be definitely working with u-boot to get it to the same state.
>>
>> This patchset is using the latest approved DT binding created by Miquel and
>> if new binding is accepted we will be working to align to it.
>> Also intention is to bring this functionality to customers and not break
>> others. That's why these patches are pulled into rc1 to get better test
>> coverage.
>>
>> And to be fair to say version which has been merged was v14 and anybody
>> could comment it before and we are definitely here to help to resolve issues
>> on other boards caused by this patchset. But we need to have help from
>> others because obviously we don't have other boards and they are likely also
>> not wired in CI.
> 
> To be clear, we need to resolve the problems that have shown up now on
> all of the hardware that was working in v2024.10. My current inclination
> is to merge
> https://patchwork.ozlabs.org/project/uboot/list/?series=429932&state=*
> (aka this series in question) ASAP.
> 

We can surely live with this temporary situation. Now that we're assured
to have AMD's help in moving forward, it feels less like a transfer of
responsibility on the poorly designed stacked/parallel software support.
Fine by me to choose the smaller fixes/improvements over the full revert.

Cheers,
ta
