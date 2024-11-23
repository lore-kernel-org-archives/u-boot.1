Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F67E6688E
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 22:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 207AA8934F;
	Sat, 23 Nov 2024 23:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732401272;
	bh=iuNR2SF6oXJYd2IxKvVlNpiuUMHOglnL5DZdNfOkr0U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k4g+49aRlm3bGo93KbbvRvHiW3fNCUQiVJh2qDWmRi/U6yHPuOY2PtjdHwEpAEk24
	 TeHVjU52CvHNvPXuXBb7inbsQ5AC2Cbk9Xjm5NFRV4yPYMAI5dOIwjKrSBjx5Jy6KR
	 KU+JKgDGoML+tMKiA+vOBGS/8csRUA7viL6h5L2A3b9vptmHjrK/TVAj7/LibjexxM
	 SacxTWWjiHL96LINjz2t++ve9ZFsuenq8UWEikyfdNlowQoLBQBm2QyGdvfuY8EceH
	 fmi9nny3wGuDv6yFcm+/1kZ0I6yXxra1z20j94KhAE/h/tpn3lywEizwCZhxulg5VX
	 QAq1GQUYjE1VA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 01E358935B;
 Sat, 23 Nov 2024 23:34:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732401265;
 bh=iuNR2SF6oXJYd2IxKvVlNpiuUMHOglnL5DZdNfOkr0U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=P+QaHS4lH3+tK1x8J92O0BTRNR1q/Wqg16rv9uEQ8Vim9K8n9KsWpK1rb5XLX9zDT
 YgiXEyV3LWf1lR/CPRoVGSzwwvnvl69tpQKh6n85q9AzSWuI7CxMmI3X9TOCh9VJF1
 nVVD3stFJMgzDhWOLCp5H0BqbGgloXyNUQGK8CIVb8fSy+qHOo1A8+3GC0jTQn8yMT
 1t0vJxyhrz+l9T1krzRCAQh5Go9n/50wAs2u4k5IoufbSwLKUUD+CFmwvIrY/K+1w7
 DbdT3518/EGonxl+yWl5KztB0Be6Q7245ExaNhcCPJg7vN/P4RUNg/8JiNyYIgCxZr
 CF/hjC+thdjFw==
Message-ID: <5d6245ba-04c1-4d30-8c10-d38416223e65@denx.de>
Date: Sat, 23 Nov 2024 21:02:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/7] usb: onboard-hub: add support for Microchip
 USB5744
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "Simek, Michal" <michal.simek@amd.com>,
 "fabrice.gasnier@foss.st.com" <fabrice.gasnier@foss.st.com>,
 "git (AMD-Xilinx)" <git@amd.com>
References: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
 <d61ab683-744d-4024-a5d3-71b372e85d02@denx.de>
 <SA1PR12MB869770E331845B38B0BC2AC098592@SA1PR12MB8697.namprd12.prod.outlook.com>
 <5c4c73e1-4b47-427a-b84c-099b044d07a8@denx.de>
 <SA1PR12MB8697165267E847E8F8FDC0D9985B2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <b06d22ba-6629-4893-a90e-185f676017a5@denx.de>
 <SA1PR12MB8697C5004BB109302CE441B198272@SA1PR12MB8697.namprd12.prod.outlook.com>
 <5cd2a342-7208-4cf1-8faa-90dfd82ae5b0@denx.de>
 <SA1PR12MB86972FD15A7312EF59F1A5D298202@SA1PR12MB8697.namprd12.prod.outlook.com>
 <da8d990f-b2fa-4f21-bee5-7d609e9364b2@denx.de>
 <SA1PR12MB8697282F71C84463633BC7D598212@SA1PR12MB8697.namprd12.prod.outlook.com>
 <63680409-ee94-4b2d-85cc-14640e77b9ab@denx.de>
 <SA1PR12MB869756F1B9384CE299FA1C4298212@SA1PR12MB8697.namprd12.prod.outlook.com>
 <696e49d5-a46e-46dd-a44c-cfb72781b85f@denx.de>
 <SA1PR12MB86974CFD8C5FFC7110BF72E498222@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <SA1PR12MB86974CFD8C5FFC7110BF72E498222@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11/21/24 6:08 AM, Abbarapu, Venkatesh wrote:

[...]

>>>>>>> As this delay might be specific to the boards which we tested.
>>>>>>> There won't be any issue if we can add the default
>>>>>>> "reset_delay"(5us) and
>>>>>> "power_on_delay" (1ms) from the USB5744 datasheet, as other boards
>>>>>> will be working without any board specific delay?
>>>>>> Right, the driver has to be generic , that means it should contain
>>>>>> delays specified in the datasheet. Board specific delays have to be
>>>>>> configured in
>>>> board specific DTs.
>>>>> Thanks. I have updated the delays based on usb5744 specification in
>>>>> the [PATCH v13 3/7] usb: onboard-hub: add support for Microchip
>>>>> USB5744 Please review.
>>>> V13 also enables the hub driver for Xilinx hardware, does it not ?
>>>> If so, won't doing so lead to incorrect behavior due to -- now -- too
>>>> short delay ? I suspect you will need V14 which adds those board
>>>> specific delays via DT for the Xilinx hardware.
>>> There are many customers who use their own boards and they might not see the
>> issue what we observe on Xilinx/AMD boards. Don't you think we are blocking them
>> because of our board issues? What you think?
>> Sure, drop 6 and 7 and the current state of 1..5 can go in I think.
> Rather than dropping these patches...
> To not block others, update the default reset delays mentioned in the USB5744 datasheet.
> This way the customers can use these patch series and don’t wait for the Xilinx/AMD board issues to be fixed.
> We can fix Xilinx/AMD board issues with the reset delays(via DT property) for USB5744 by introducing/ discussing with Linux community.
> I think this way...you don't see any issue right?
Sure, simply send the first five hub patches separately as v14, without 
the DT patches, and I'll most likely pick them up. The DT patches have 
to go in via Xilinx tree anyway, the USB patches go through USB tree.
