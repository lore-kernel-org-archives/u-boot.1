Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1138ECDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 14:54:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B9FF864D4;
	Tue, 17 Oct 2023 16:54:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697554474;
	bh=FgRm8M5ZJJ1OQEjP8iDEfwwD5R5apkchfULxy+TnQcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rFMBlZ1jLRsxvAn28J8VaRHLUZffytp3zMmnItO2y4Duys6DSf3Zxw+hwjdhpGHWa
	 XF8ic9sCgdSfZZrH12TWl1HzMSW17Pcbz32lTS+QRfqKeafIgNhnY9U52wRYs6KK8z
	 x0nmcpncS3zG9EoonhlCGJaCQgUOvM5HYEemFenR3Jx/PvtE5BUOhxXw8VV5MJ6S+J
	 svuPW7xxFneEOvBOFrewL7w3vXqkF25DHtL33B+3kJprDbKZdlnaOWRpJrwk1nUzsi
	 9e8vZpaXcjybbmbdMvj+jDqdeI6irmUuhdWyL8H3TX0xY4Ho2lB0iEWlwJSP5htWmp
	 R6APtEez5VwEQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3A0C486EE2;
 Tue, 17 Oct 2023 16:54:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697554472;
 bh=FgRm8M5ZJJ1OQEjP8iDEfwwD5R5apkchfULxy+TnQcg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OxVk5PL+LnxZmiwageS9qXOS5cg8klGbSb1LBoDpwuG7CmoqBTP58YtybznG7f7Oz
 uUtjh52oDR6hiQ63h4sOVHw7IKALOF8w6Sy1NA9I95jxuBsI3ONAGCqO5c7ayfFDeP
 d7TEuSv4aGcmBV3rkHk9BasDiJw3SkxRtgT0PaFxT8DfUsCciUI5agpk6XXZGCTTh1
 dFlCt8EAmeujGjgc83eJdme/ItUg+kQIeMwcSy0hJ6fUYenTyG3HjcKpixMHzmab6G
 KZlkjnVVx61Jk5ZbK2WUyNH4wiYCVtLkd4Fyc7pwXtlPV58/6QAZRXTna6MAAqkZDX
 43Nh8XrLSkuuQ==
Message-ID: <361b19c0-229c-4fb5-9835-d952e877baee@denx.de>
Date: Tue, 17 Oct 2023 16:54:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: xhci: Workaround to fix the USB halted endpoint
 issues
To: Tom Rini <trini@konsulko.com>, Eugen Hristev <eugen.hristev@collabora.com>
Cc: Michal Simek <michal.simek@amd.com>, Da Xue <da@lessconfused.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de,
 git@xilinx.com
References: <20231013045356.25789-1-venkatesh.abbarapu@amd.com>
 <2016c1bc-dfe0-416e-a910-75e6cf25036c@denx.de>
 <CACdvmAju3wDL0yCJtVdEf47u+L5R3AvRpcuJ+ruKFXDTcQ-TBw@mail.gmail.com>
 <20231013151540.GJ3119521@bill-the-cat>
 <041b37d4-777a-4c02-b8fd-9985c2cfa938@amd.com>
 <20231016193052.GF3119521@bill-the-cat>
 <e8501850-b440-4e2c-a120-875924f59453@collabora.com>
 <20231017141612.GE3119521@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231017141612.GE3119521@bill-the-cat>
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

On 10/17/23 16:16, Tom Rini wrote:
> On Tue, Oct 17, 2023 at 03:48:37PM +0300, Eugen Hristev wrote:
>> On 10/16/23 22:30, Tom Rini wrote:
>>> On Mon, Oct 16, 2023 at 08:34:16AM +0200, Michal Simek wrote:
>>>>
>>>>
>>>> On 10/13/23 17:15, Tom Rini wrote:
>>>>> On Fri, Oct 13, 2023 at 11:11:04AM -0400, Da Xue wrote:
>>>>>> On Fri, Oct 13, 2023 at 7:47 AM Marek Vasut <marex@denx.de> wrote:
>>>>>>>
>>>>>>> On 10/13/23 06:53, Venkatesh Yadav Abbarapu wrote:
>>>>>>>> The xhci host controller driver trying to queue the URB's and it is
>>>>>>>> getting halted at the endpoint, thereby hitting the BUG_ON's.
>>>>>>>> Mostly these kind of random issues are seen on faulty boards.
>>>>>>>> Removing these BUG_ON's from the U-Boot xhci code, as in Linux kernel
>>>>>>>> xhci code BUG_ON/BUG's are removed entirely.
>>>>>>>> Please also note, that BUG_ON() is not recommended any more in the Linux
>>>>>>>> kernel.
>>>>>>>> Similar issue has been observed on TI AM437x board and they created a patch
>>>>>>>> in Linux kernel as below
>>>>>>>> https://patches.linaro.org/project/linux-usb/patch/1390250711-25840-1-git-send-email-balbi@ti.com/
>>>>>>>>
>>>>>>>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>>>>>>>
>>>>>>> I already explained to Xilinx how to sync the driver with Linux and why
>>>>>>> this is needed to move forward, multiple times, and even provided a
>>>>>>> script which does most of the work automatically, since it is basically
>>>>>>> automated process. Xilinx did not even bother to test the script and
>>>>>>> provide any feedback.
>>>>>>>
>>>>>>> Until that happens, this patch is rejected.
>>>>>>
>>>>>> This patch also causes all of the USB devices on certain platforms to
>>>>>> not be detected:
>>>>>>
>>>>>> scanning bus usb@c9000000 for devices... Device not responding to set address.
>>>>>>
>>>>>>          USB device not accepting new address (error=80000000)
>>>>>
>>>>> Yes, we are stuck at the impasse where the custodian is asking for
>>>>> someone to try and do the re-sync, and everyone else will assist with
>>>>> testing on other platforms, but the re-sync hasn't happened.  Can we
>>>>> please get someone from AMD to attempt the re-sync?
>>>>
>>>> I would like to say that we have someone to do it. But I simply don't have
>>>> that person.
>>>
>>> That is the big problem we face, yes.  Eugen, I think you said you were
>>> going to try and find time to do a re-sync, did you end up getting any?
>>>
>>
>>
>> Hi Tom,
>>
>> Unfortunately at the moment I am working on a different project, so I do not
>> see any perspective to do this in the near future, although I would like to
>> do it and to help.
>> It may be the case that a company investing into an engineer to work on this
>> would be the only way.
>>
>> In any case, do you think Marek would accept doing this incrementally , e.g.
>> now the driver is synced with 3.10, it would be easier to increment to 4.1
>> as a first step ?
> 
> Incremental updates feels like it might be less of a daunting path to
> me, so I'd be agreeable.  Marek?

I am fine with that obviously, in fact, I am fine with anything which is 
not "pick a random patch from the middle of kernel git log, submit it, 
make the driver into a mess of partial patch backports".
