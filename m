Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A990ED5CCA9
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 13:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF881891D2;
	Wed, 30 Oct 2024 14:17:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x/BeUaFm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD3B58920A; Wed, 30 Oct 2024 11:45:08 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88A6A88FAB
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 11:45:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fb5be4381dso62008041fa.2
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 03:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730285106; x=1730889906; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gQzfq8HFlckEdMtvo+/7XrLX3oRMcCfkWvw1vc5zxng=;
 b=x/BeUaFmBgwD/NKHzt5JiTSYYyMsbXPD4MdpRTqQ2v1od+VBZW+WVcUK6/1kdMDjHW
 o2RAESud9ueCMhmcwJjZtNGRbpD2bpTzovlAyCCkGKiQblUdeuMLMnNoK9XyhoyEWzFG
 QyheC5C+Z5OSTAjOKV0JayTW+7M8LX9Li4razXlLFlp2RU9K1G/eg0/lweG5R0B/Pl6u
 SIL3xkEKvxdEkMtO23t8u0kC7fyY0ojVYOGYgzGp/V5wwt7Z8le9zDmqv3FMD+gVSJPv
 w6cHMPXizIO0LdVo7OtiLZtCdXCdhFBm5rJYmtbGL66smiMYO0P2vub2dSRLfU9eT/tL
 IeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730285106; x=1730889906;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gQzfq8HFlckEdMtvo+/7XrLX3oRMcCfkWvw1vc5zxng=;
 b=S7IgePUIK0xyVniV2K3KTYb4UxmtgkQcvZZGnqxVrulLCx5biZsRJf5aEhLtjtuRFg
 Tp2q2JdyzAMn3rxtYFI0OpagK5Eg7IJlYzB/xJn9TexdoOICLhqWqY/0j6hkw1ZMsK/L
 r/AY0vsiseP9nyBDKzOkEDslGK5iw1kBkhnsVx8bD0UMbww12W2ZiC13f2X9kJFxBzS3
 h+W0iNAelGHNYnJ6/FAtQh7aVNJd8TehxQ5ACog+7PLwtju/qHN4mlVMDTrPoexVL2f6
 m60GC91wS/SU3h7st8U7TUh3iroBLYYDhVfTewzNCkL/eXz5UIGrD+vaiSSv6dVv69Ls
 SRyg==
X-Gm-Message-State: AOJu0YxPViZzGWEAD9YKSBvLF58MYVp9eyVnEK4tYblVXOWZ3bZlTlkF
 8TiRZxtLGjxKxj7O1JxDNYeohQd3u9OC0cJYcpHDKcd/tiPYLXhOeNt0H2q+kP4=
X-Google-Smtp-Source: AGHT+IHfZ0wQoUVU2dlojNnN9Q7J0tyx2oBk2zp+yztWAtCsqDTt+KPWmsrSjB5Gbpod52pkG8PuTg==
X-Received: by 2002:a05:6512:3f0c:b0:53b:1369:fcf8 with SMTP id
 2adb3069b0e04-53b348f96e8mr7391412e87.15.1730285105750; 
 Wed, 30 Oct 2024 03:45:05 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e8471sm17767315e9.4.2024.10.30.03.45.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 03:45:05 -0700 (PDT)
Message-ID: <19fc4486-f8fe-4286-8941-76ff2a81b7d9@linaro.org>
Date: Wed, 30 Oct 2024 10:45:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] mtd: spi-nor: Remove recently added nor->addr_width
 == 3 test
To: Jagan Teki <jagan@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
 <CAMty3ZB3ngMezv9S2XrNjXL69q+z9x-=qnQGga51FgTfA4fanQ@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAMty3ZB3ngMezv9S2XrNjXL69q+z9x-=qnQGga51FgTfA4fanQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Oct 2024 14:17:52 +0100
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



On 10/30/24 10:33 AM, Jagan Teki wrote:
> Hi Marek,
> 
> On Sun, Oct 27, 2024 at 1:48 AM Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>>
>> Remove undocumented nor->addr_width == 3 test. This was added in commit
>> 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support")
>> without any explanation in the commit message. Remove it.
>>
>> This also has a bad side-effect which breaks READ operation of every SPI NOR
>> which does not use addr_width == 3, e.g. s25fs512s does not work at all. This
>> is because if addr_width != 3, rem_bank_len is always 0, and if rem_bank_len
>> is 0, then read_len is 0 and if read_len is 0, then the spi_nor_read() returns
>> -EIO.
>>
>> Basic reproducer is as follows:
>> "
>> => sf probe ; sf read 0x50000000 0 0x10000
>> SF: Detected s25fs512s with page size 256 Bytes, erase size 256 KiB, total 64 MiB
>> device 0 offset 0x0, size 0x10000
>> SF: 65536 bytes @ 0x0 Read: ERROR -5
>> "
>>
>> Fixes: 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support")
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Andre Przywara <andre.przywara@arm.com>
>> Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
>> Cc: Jagan Teki <jagan@amarulasolutions.com>
>> Cc: Michael Walle <mwalle@kernel.org>
>> Cc: Michal Simek <michal.simek@amd.com>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Pratyush Yadav <p.yadav@ti.com>
>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>> Cc: Sean Anderson <seanga2@gmail.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
>> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>> Cc: u-boot@lists.denx.de
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
> 
> Is this patch-set next version for 'previous' reverted series?
> 

my 2c: I think I lean towards reverting the stacked/parallel support.
The only one that benefits of is AMD, while affecting the core code
quality. It also slows down further contributions and I assume it
hardens maintainer's job.

Even if I (we?) haven't made my mind on how to best implement this, it's
clear that it shall be above SPI NOR without affecting current devices.

Not sure if it's fine to revert everything, haven't followed u-boot
lately, your choice to make.

Cheers,
ta
