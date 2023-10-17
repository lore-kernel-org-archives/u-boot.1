Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAFBCDB482
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 12:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25B9986E7C;
	Tue, 17 Oct 2023 14:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="HyMjKmaZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71CC086BAA; Tue, 17 Oct 2023 14:48:44 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FF9D86EA6
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 14:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [192.168.0.125] (unknown [82.76.24.202])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 910DC6603102;
 Tue, 17 Oct 2023 13:48:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1697546921;
 bh=MCEIUKFcGQ104eQlR5E4Q4iVgDe3nQ3TfUlQi+p+RXY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HyMjKmaZ5mO8e7mZGxwJmVANhxN3SPc/wnVw7fJrKr8k63onikFIO97xMDB+uSlYx
 q7aK6MjTCx1thGDykp+kS4K7FPty2agoyHNnp/RhcdllePHTK1NV/fgAOJjnDYS6bS
 wRTThnFl6Zb1cpHwkO5WpGoqK7UyuXIZyfuOrKsD6qFVHmtQxTYyOMDZ4C8oVEz7oN
 BXBAqonTAkB5rCG1D6KWY5LNFwQMBIlNW6XZ1WDs+wL1ecOVfz0CqnN5tsuVWpq7yO
 TPk8ykcTwu2nOMkvW1SzIBTWZgCX9CHNABhLqBYnLRq0X+y68tccuzq3pkg60d327j
 ECA07hRUObaiQ==
Message-ID: <e8501850-b440-4e2c-a120-875924f59453@collabora.com>
Date: Tue, 17 Oct 2023 15:48:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: xhci: Workaround to fix the USB halted endpoint
 issues
To: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
Cc: Da Xue <da@lessconfused.com>, Marek Vasut <marex@denx.de>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de,
 git@xilinx.com
References: <20231013045356.25789-1-venkatesh.abbarapu@amd.com>
 <2016c1bc-dfe0-416e-a910-75e6cf25036c@denx.de>
 <CACdvmAju3wDL0yCJtVdEf47u+L5R3AvRpcuJ+ruKFXDTcQ-TBw@mail.gmail.com>
 <20231013151540.GJ3119521@bill-the-cat>
 <041b37d4-777a-4c02-b8fd-9985c2cfa938@amd.com>
 <20231016193052.GF3119521@bill-the-cat>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20231016193052.GF3119521@bill-the-cat>
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

On 10/16/23 22:30, Tom Rini wrote:
> On Mon, Oct 16, 2023 at 08:34:16AM +0200, Michal Simek wrote:
>>
>>
>> On 10/13/23 17:15, Tom Rini wrote:
>>> On Fri, Oct 13, 2023 at 11:11:04AM -0400, Da Xue wrote:
>>>> On Fri, Oct 13, 2023 at 7:47 AM Marek Vasut <marex@denx.de> wrote:
>>>>>
>>>>> On 10/13/23 06:53, Venkatesh Yadav Abbarapu wrote:
>>>>>> The xhci host controller driver trying to queue the URB's and it is
>>>>>> getting halted at the endpoint, thereby hitting the BUG_ON's.
>>>>>> Mostly these kind of random issues are seen on faulty boards.
>>>>>> Removing these BUG_ON's from the U-Boot xhci code, as in Linux kernel
>>>>>> xhci code BUG_ON/BUG's are removed entirely.
>>>>>> Please also note, that BUG_ON() is not recommended any more in the Linux
>>>>>> kernel.
>>>>>> Similar issue has been observed on TI AM437x board and they created a patch
>>>>>> in Linux kernel as below
>>>>>> https://patches.linaro.org/project/linux-usb/patch/1390250711-25840-1-git-send-email-balbi@ti.com/
>>>>>>
>>>>>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>>>>>
>>>>> I already explained to Xilinx how to sync the driver with Linux and why
>>>>> this is needed to move forward, multiple times, and even provided a
>>>>> script which does most of the work automatically, since it is basically
>>>>> automated process. Xilinx did not even bother to test the script and
>>>>> provide any feedback.
>>>>>
>>>>> Until that happens, this patch is rejected.
>>>>
>>>> This patch also causes all of the USB devices on certain platforms to
>>>> not be detected:
>>>>
>>>> scanning bus usb@c9000000 for devices... Device not responding to set address.
>>>>
>>>>         USB device not accepting new address (error=80000000)
>>>
>>> Yes, we are stuck at the impasse where the custodian is asking for
>>> someone to try and do the re-sync, and everyone else will assist with
>>> testing on other platforms, but the re-sync hasn't happened.  Can we
>>> please get someone from AMD to attempt the re-sync?
>>
>> I would like to say that we have someone to do it. But I simply don't have
>> that person.
> 
> That is the big problem we face, yes.  Eugen, I think you said you were
> going to try and find time to do a re-sync, did you end up getting any?
> 


Hi Tom,

Unfortunately at the moment I am working on a different project, so I do 
not see any perspective to do this in the near future, although I would 
like to do it and to help.
It may be the case that a company investing into an engineer to work on 
this would be the only way.

In any case, do you think Marek would accept doing this incrementally , 
e.g. now the driver is synced with 3.10, it would be easier to increment 
to 4.1 as a first step ?

Eugen
