Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BAAE95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 21:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 760E786A02;
	Sat,  7 Oct 2023 23:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696713025;
	bh=knwMh7rD8iLoI8utmwsJlF/sVJHzzgd6/Qgvs9h0L4I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZmozWBGloNkabWXnUM5VExY3rKRo9yBorZMT0v7Hn8/MFMvbvCXwqixnOAovKubyk
	 e2BkFa7Y8wRIM7VcHiie88LQ0aBMkP15wKdKjceSI5GRxbnfQdSE7t8i1IGkog0WT1
	 XfrHabQFRaeYcG7wd5u+1+U8F31NzLcHTuRVuVDV4YiicR9YYkgwT5XW4KaiFMJQoY
	 TRMC1hlZmzT3CU+3lTmyQzCBLUJXTrNDqBoEK94kPx8PeH/m3ILGmFg3o3GqVojhXW
	 SCfTDuuwjc2EP/KchwXqNoRZT+YG7rMWjJY26+asA8QFaaMD/F7JD4WDNUoulTUR2B
	 HKNTs+ggSF2KQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DA5E4868D1;
 Sat,  7 Oct 2023 23:10:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696713024;
 bh=knwMh7rD8iLoI8utmwsJlF/sVJHzzgd6/Qgvs9h0L4I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZOtqmwb/VAhueQoPB0XUiBOxw97R9McD7mSADkyZwk5iw3kSYbQlPp4MPOh1j2bxX
 9XgSHoufAo53esZu5taBfTyclj/8Kw65U1fWt7gEWb+kjPB+caNut6J0UCqyqlKrbz
 V7oC5SQ5sv/ZVIby+wwnp8Rs3krlcF0mhFfpL2QynrgvbZgPcWZZ+O5FybTgaReVrI
 koUDFeX6UqKq+YysS9JxzS74YmvEPziFygXLmAOGjp91Sdixnxi4VcrCszYQrZg+HN
 3Zc//8xjTISPH8eZwGV2dcENnVm07BEdS8lQoqB4C7nEsryjJ0Obwb8BtA36Q1+bXm
 LSTbUgqRdO1aw==
Message-ID: <0369113f-719d-49c3-9043-b01cf98ac15c@denx.de>
Date: Sat, 7 Oct 2023 23:01:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/17] dm: usb: udc: Factor out plain udevice handler
 functions
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Angus Ainslie <angus@akkea.ca>, Dmitrii Merkurev <dimorinny@google.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>, Kever Yang
 <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Nishanth Menon <nm@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, kernel@puri.sm
References: <20230901095003.352930-1-marex@denx.de>
 <20230922120012.6e24645f@xps-13> <20230927155901.10c5d520@xps-13>
 <7abc460b-54c2-67b0-2f1e-e67a6878666e@denx.de>
 <20231002154246.38d43236@xps-13>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231002154246.38d43236@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/2/23 15:42, Miquel Raynal wrote:
> Hi Marek,
> 
> marex@denx.de wrote on Sat, 30 Sep 2023 23:11:17 +0200:
> 
>> On 9/27/23 15:59, Miquel Raynal wrote:
>>> Hi Marek,
>>
>> Hi,
>>
>>> miquel.raynal@bootlin.com wrote on Fri, 22 Sep 2023 12:00:12 +0200:
>>>    
>>>> Hi Marek,
>>>>
>>>> I'm answering here as there is no cover letter. Just to let you know
>>>> I'm still concerned by the series and want to test it but did not had
>>>> the time to do so recently. Hopefully next week.
>>>
>>> The series looks good to me and works as well on a Beagle Bone Black
>>> with no visible functional changes regarding the use of the UDC. The
>>> whole series is:
>>>
>>> Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>>
>>> By the way, following your initial series there have been three
>>> followup patches trying to improve a little bit the doc, one got merged
>>> and two others were delegated to you:
>>> https://patchwork.ozlabs.org/project/uboot/list/?series=367635
>>>
>>> They are almost 2 months old now, would you mind acking or merging
>>> them so both your initial USB gadget rework and the additional
>>> (related) doc can be in the same release please?
>>
>> Can you resend those and CC this mail address ?
> 
> Of course!
> 
>> That said, 1/2 should be in some sort of README instead, and the 'dm tree' command depends on CMD_DM=y .
> 
> Well, the README is more something which targets the developer IMO,
> whereas here I want to target the users. Many people only see U-Boot
> through Yocto now (that's a different topic) and the purpose of this
> additional text is to help them in finding their way into U-Boot device
> model *alone*. It's really short, but I bet it can really help, given
> how I felt when I actually understood why you advised to type a couple
> of semi-random bind/unbind commands which eventually worked. Anybody not
> involved in any DM conversion is likely just not aware of all of that.
> Having people finding their own way through the DM means less
> complaints/needs for help on the mailing list.

Thinking about it back and forth, I think you've got a point, yes.

>> The usb_gadget_probe_driver() is code synchronized from kernel, you likely want to add any such clarification to usb_gadget_register_driver() .
> 
> Actually the kernel functions do have some kind of alternate error
> message as well now :-) Clearly different given that this code has been
> adapted to U-Boot's DM, but the idea is close. However
> usb_gadget_register_driver() is kind of blind regarding the number of
> UDCs in the system and if they are already bound or not, so I don't
> really see the point in moving the error message there along with all
> the logic duplication involved.
> 
>> That said, the usb_gadget_register_driver() should be reworked into
>> some new functions, which takes UDC controller *udevice pointer to
>> avoid this binding heuristics.
> 
> Yes, I don't know many boards with two UDCs but it's a clear limitation.

i.MX8M Plus is one such example, Quad I think is another, and pretty 
much anything with more than one DWC3 controller is. The CI HDRC is also 
often present in OTG capable configuration, so a lot of i.MXes are multi 
UDC systems.
