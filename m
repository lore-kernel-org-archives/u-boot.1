Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EC1C8302F
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 12:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D9B681D6A;
	Mon, 30 Jun 2025 14:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FZm6DVfL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D65BE81E13; Mon, 30 Jun 2025 14:37:57 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3E8D80B9B
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 14:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ae0ccfd5ca5so273908866b.3
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 05:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751287073; x=1751891873; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M/wlxn2q0zBKjwoqVKsQPVSWypInQ1nlMF0CdymjgjU=;
 b=FZm6DVfLup3gRyKxnj+spQXoYEpBuT8btjxqharLvoty6+69TIY1EK7iKUyqr83EK0
 ba5jnwJn/rYPN1RjtWly7px9MT22kmnQjkWWaheihAZjpADSMiNpuuW6HnckowuZWRW1
 2Mh5LlnpvrQFtiwSBYjIfk8sYQDaUeuJCaMVNdmAma814kSIZAOUaYBwfllCTRb8N49U
 nHfXTkCP3lUyvnMj5pRTfsCjgBQZ6vnjeT4Gw5pxMglU+93OHzNfCJEAhhNJ59KxgE3/
 EVa3hGw9RGoXJhinTVIXGfZg5zB6U0geyAStbSebrMeMz6x0t4rAOVy1lWpbkhPD7eRL
 p93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751287073; x=1751891873;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M/wlxn2q0zBKjwoqVKsQPVSWypInQ1nlMF0CdymjgjU=;
 b=IVUPt6X/bXS+XQrPx1/FXsQixnJOFCp7nEwApl1ZCJnT5rsO/y5pV8Fj/tYqhcEZzz
 NljOBrTEoQ4MihB9VzpqLufwL977t8yRVyaf36m8JLHB+EuJHS6T6kCB+IuhZuQ7nt5t
 ol/3ru3bZjUAsUHL0ePQDqv1GN4mt0rxqWr1N7f3SG/NjYcjUsBOiQTcnrKYM14RQVCt
 8mxkg8pf+7NPina7T4rB553Qz4sr+PSbEwfrGk1rhAdt9iEoR5pmiuSA9+0k18Zjk0Gf
 UvEVzQIjyo2c64mWbWFGpM7Gprh4CsVjBRVzA+dumwS2PfRjedGsQ6h2LZPJfP6A9XJY
 fUXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUtKZTza9XBVSC1XxIOm39t3QMUgYtEZdLg1ToqFXdxgcOedjtejiQgkc/uYqbi3XtYnu9WL0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1eXooSYd/NDPWRuz8mBtkU6CFq38o6E8M4B4Xg0OjRC9uHF3K
 15kVnz/KBiA8IPOIRt0QlAtAgGSgVRL7f6WtmbuhuP+p8bt5Kk1Ov49fMTqGQAAgAkA=
X-Gm-Gg: ASbGnctBq3y4bhpj/pzQUeCiF61naSK8jCg2ujT9cl6ROpRfn7PXd6IMDAGff1J14hF
 iw8rVOTlyj89mz9oSNUawzUUw9ECCCMI0ARJ0Clxt7pzGvC/vf1JUU1iMiEqh8OSAqrJn5Rs8sP
 0/OttvL8/OHl+3MzqaNyoBoFLNu1t1nK2LuiLIPUiVEhJg920EQPD3Qr8BdGkzB/ititdv6ayRD
 MVqndOO6H2vHIiDTinoaafH5UK3Dtr8+0H+RvZBVrOV9tF6buf4WBc2xH7vj8EiEhT/qLZSjI+6
 Gix50yxv6JNjRaZPcusvPEqANGRalW0PlC3J3dF3SlCTr03RcJ8Sb9mH1gYjQDaPOXJr
X-Google-Smtp-Source: AGHT+IFE7WpwmdT+YILj1BosZE+sC1JdbeCPk5K9PvZvx4yQeANVoG0qtx8ZNOIbETkDngMvG8Sv6A==
X-Received: by 2002:a17:907:e98b:b0:ae3:66ff:f922 with SMTP id
 a640c23a62f3a-ae36700014dmr729289766b.50.1751287072915; 
 Mon, 30 Jun 2025 05:37:52 -0700 (PDT)
Received: from [10.5.0.2] ([45.11.80.135]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353c0427bsm656455866b.84.2025.06.30.05.37.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 05:37:52 -0700 (PDT)
Message-ID: <a68bb62c-570d-4619-a9f0-b76550e9aaa4@linaro.org>
Date: Mon, 30 Jun 2025 14:37:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: xhci: Workaround to fix the USB halted endpoint
 issues
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Eugen Hristev <eugen.hristev@collabora.com>
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
 <361b19c0-229c-4fb5-9835-d952e877baee@denx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <361b19c0-229c-4fb5-9835-d952e877baee@denx.de>
Content-Type: text/plain; charset=UTF-8
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

Hi Marek,

Sorry or digging up an old discussion.... I work for Linaro and one of the
tasks I am considering is helping out with the USB stack update/re-sync.
Not that I know much at all about USB :-\ but at least I will be able to
spend some cycles on that subject.

Please see below.

On 10/17/23 16:54, Marek Vasut wrote:
> On 10/17/23 16:16, Tom Rini wrote:
>> On Tue, Oct 17, 2023 at 03:48:37PM +0300, Eugen Hristev wrote:
>>> On 10/16/23 22:30, Tom Rini wrote:
>>>> On Mon, Oct 16, 2023 at 08:34:16AM +0200, Michal Simek wrote:
>>>>>
>>>>>
>>>>> On 10/13/23 17:15, Tom Rini wrote:
>>>>>> On Fri, Oct 13, 2023 at 11:11:04AM -0400, Da Xue wrote:
>>>>>>> On Fri, Oct 13, 2023 at 7:47 AM Marek Vasut <marex@denx.de> wrote:
>>>>>>>>
>>>>>>>> On 10/13/23 06:53, Venkatesh Yadav Abbarapu wrote:
>>>>>>>>> The xhci host controller driver trying to queue the URB's and it is
>>>>>>>>> getting halted at the endpoint, thereby hitting the BUG_ON's.
>>>>>>>>> Mostly these kind of random issues are seen on faulty boards.
>>>>>>>>> Removing these BUG_ON's from the U-Boot xhci code, as in Linux kernel
>>>>>>>>> xhci code BUG_ON/BUG's are removed entirely.
>>>>>>>>> Please also note, that BUG_ON() is not recommended any more in the Linux
>>>>>>>>> kernel.
>>>>>>>>> Similar issue has been observed on TI AM437x board and they created a patch
>>>>>>>>> in Linux kernel as below
>>>>>>>>> https://patches.linaro.org/project/linux-usb/patch/1390250711-25840-1-git-send-email-balbi@ti.com/
>>>>>>>>>
>>>>>>>>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>>>>>>>>
>>>>>>>> I already explained to Xilinx how to sync the driver with Linux and why
>>>>>>>> this is needed to move forward, multiple times, and even provided a
>>>>>>>> script which does most of the work automatically, since it is basically
>>>>>>>> automated process. Xilinx did not even bother to test the script and
>>>>>>>> provide any feedback.
>>>>>>>>
>>>>>>>> Until that happens, this patch is rejected.

Would you mind telling me a bit more about the re-sync process and the script
you mentioned?

>>>>>>>
>>>>>>> This patch also causes all of the USB devices on certain platforms to
>>>>>>> not be detected:
>>>>>>>
>>>>>>> scanning bus usb@c9000000 for devices... Device not responding to set address.
>>>>>>>
>>>>>>>          USB device not accepting new address (error=80000000)
>>>>>>
>>>>>> Yes, we are stuck at the impasse where the custodian is asking for
>>>>>> someone to try and do the re-sync, and everyone else will assist with
>>>>>> testing on other platforms, but the re-sync hasn't happened.  Can we
>>>>>> please get someone from AMD to attempt the re-sync?
>>>>>
>>>>> I would like to say that we have someone to do it. But I simply don't have
>>>>> that person.
>>>>
>>>> That is the big problem we face, yes.  Eugen, I think you said you were
>>>> going to try and find time to do a re-sync, did you end up getting any?
>>>>
>>>
>>>
>>> Hi Tom,
>>>
>>> Unfortunately at the moment I am working on a different project, so I do not
>>> see any perspective to do this in the near future, although I would like to
>>> do it and to help.
>>> It may be the case that a company investing into an engineer to work on this
>>> would be the only way.

I might be that guy :)

>>>
>>> In any case, do you think Marek would accept doing this incrementally , e.g.
>>> now the driver is synced with 3.10, it would be easier to increment to 4.1
>>> as a first step ?
>>
>> Incremental updates feels like it might be less of a daunting path to
>> me, so I'd be agreeable.  Marek?
> 
> I am fine with that obviously, in fact, I am fine with anything which is not "pick a random patch from the middle of kernel git log, submit it, make the driver into a mess of partial patch backports".

Makes sense of course. What could be a first, simple step in the right
direction?

Regards,
-- 
Jerome
