Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF62CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 07:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2170D84659;
	Tue, 19 May 2026 09:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ekMKVaPT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E3F68465A; Tue, 19 May 2026 09:07:05 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C7FC8460E
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 09:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso30925455e9.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 00:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779174419; x=1779779219; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=e+JBYBWD3ayMCYLA16wEexqX76HHpOFY732wEfq9SwM=;
 b=ekMKVaPTsT4QFJiOoorky27qtCJ1IQnnqV7pemCrhKGgGQyZ/yTfiD7XrlCnVLtChE
 yGDNBstdiPo+L0DDy9xR/QnwE4q4CBl+wwMC99FbnrZPGUj9cBfE3FujlUjGQIq8wRAU
 w/uNJjyUUfcI+7ov3Mp1KpXCHf/E+K3ng6IlwfhojVIa1mR/UkN1l6dX15ggg+rhIJhM
 fxt0xmSYmDH/1BBKSmtrRyNwzgNL6j4cI8o6OeALNestrr64akaUVr1nvoQs270yZyWY
 aL84PRxkiTRTnBMtd0xByXS3Zmfejmr6LH+ol2XWSzZPFuMUduvTdarJTgqlUlUHB9vD
 ZUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779174419; x=1779779219;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e+JBYBWD3ayMCYLA16wEexqX76HHpOFY732wEfq9SwM=;
 b=AwcsTz9bxZsGvXgzJ++ampOgbXY6DMrHFgnEADYUQ/SbYPyveOANpiqviJAeJqBaFH
 kAWZ8lWY3elBcOY51HLCGn/lP48VLeSOGn3C0Lp19SlXfJ1Yin6Po9B/yIXRdS8utJrb
 165rEpUq3G7kastVZFrpl11Xoo9M2NAJLOH4SpxtzqrlvF66s8GTBLDuKkOvafQbrXVD
 HZPIpkDW96Zdz+rkWEZGsma/XuXNj/SmuVzgcDO7vtKoKgBE1wn3xWSCWIyPTpC9utzF
 YsMndfKjUpF6CSeqdOcOq5Mq9s2KscxNPFDzBaT1BKS08zDCfDjwjQHve6M31bcheKgF
 X4vg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Jg1LEkQ+HI/GMfTL78sL9JZrvHKMeLneCUbMZ7NolFaGJ6P0IUn4Ph8Z8F4dyDFyyqv4HVFE=@lists.denx.de
X-Gm-Message-State: AOJu0YxMHBsWM1yHzzHAhBrfEdxY9VRVUqYCXJaLSDq0q2Dg4N6Kp6QR
 A+FCYJbim5uaBR0ev1BnNNOE1tV2VxZ+oEEA8C1g/rxs8fxsi0ZSe1cj/299+HDt9vw=
X-Gm-Gg: Acq92OHf7UpG+WiX3fkNp2L/9zdKQMHqfTlGSxvlg6pcbfXCWGW0PVY0WdtWPervK3H
 E9FHNTqBYddWKP6MGKfXsNaNRBjIJ6anmYEEoQbDn1VZQy5TOM0/T/v7/ISdlnWH29VlRM7XM1K
 /XlIkfRAcWdVUyV4/6SfJckroty1unD2IrRds0/4oLfD3PnXVn475nrdA+HznU7w97GhQxRFKSV
 RMuwgO2dlfY/Vb24w/QBvMxXyTs/QYl3aBrtSi75oHkWcVEoE+vhHhwm1fDfEohu5OxRbyBjCry
 CUyZTIypeQeGA/Id0lc+vnWPSbo5BCKLD8a1nxfNVp7oqUKS7Q4cVM1iz1kyrPs/tbCcG3WhlAg
 JhrLhyMOiX/n6Lyyo26YSNj4KLEa+bBETqYP0CqoyE+AhnKKI32BH8wBtOTXTK1T5JLefQkmXeC
 drcVVtJHVlvwuKKuTOVugL9XSP6NymviRf4Jmc+y1sqk5RVkBrY8Nl89EXK4DArQ6TcIONRPhb4
 lvw
X-Received: by 2002:a05:600c:528c:b0:48f:d612:3c6e with SMTP id
 5b1f17b1804b1-48fe60de745mr274967155e9.2.1779174419084; 
 Tue, 19 May 2026 00:06:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1d4b:274c:94d:a69f?
 ([2a01:e0a:106d:1080:1d4b:274c:94d:a69f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febc56f89sm127431195e9.3.2026.05.19.00.06.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 00:06:58 -0700 (PDT)
Message-ID: <f7ffdaa4-5aa0-4519-badf-01bda4c61a13@linaro.org>
Date: Tue, 19 May 2026 09:06:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: U-Boot patch submit standard and requirement
To: Sune Brian <briansune@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Conor Dooley <conor@kernel.org>, Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAN7C2SCYCwE=BRoeCedqQYjv-Gf6x6ETOdKeeDBE=CG=-rSk9w@mail.gmail.com>
 <CALeDE9PU0-fW_+erR9QHK1ST8fcStx0FWWk_0M8ELjtADugd7Q@mail.gmail.com>
 <CAN7C2SCATJL_rhpBZWwZuQVpLdnbDh5+DRFbtGHoxCXu62AVmw@mail.gmail.com>
 <CALeDE9PesKLwzt=uu_b8+pq5QXFnnK1YAO9WL3f8=CHx93w61w@mail.gmail.com>
 <CAN7C2SC_YwotE2-PS=eAFEnMOXp7jVrhaOSbKsuChLVr4zEa8A@mail.gmail.com>
 <20260514-spotted-happier-0ccb77ca8f24@spud>
 <CAN7C2SAVWp23mKeG77MoV6kUKQDBN_Ge3CUMa_quAXP5YbV6UA@mail.gmail.com>
 <20260515-finished-womanly-675afb9b0c7c@wendy>
 <CAN7C2SDDjM+MJbx2d0N8zC74bytb6gKvjw_6auMPLLNGJVwvfA@mail.gmail.com>
 <20260515150227.GC1858239@bill-the-cat>
 <CAN7C2SApq8ah+NP3k1Jj4kbMhK2s50bN10vfCfXkZaBxkq2w9w@mail.gmail.com>
 <1207964a-67cb-4882-ac49-be40e577a5dd@linaro.org>
 <CAN7C2SDGejA8XH57NUhp1x2KEHoWx7atay7xx1KA9GhqhcpH9g@mail.gmail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <CAN7C2SDGejA8XH57NUhp1x2KEHoWx7atay7xx1KA9GhqhcpH9g@mail.gmail.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/19/26 00:05, Sune Brian wrote:
> On Tue, May 19, 2026 at 3:17 AM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
>>
>> On 5/16/26 01:11, Sune Brian wrote:
>>> On Fri, May 15, 2026 at 11:02 PM Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>> On Fri, May 15, 2026 at 04:23:49PM +0800, Sune Brian wrote:
>>>>> On Fri, May 15, 2026 at 3:46 PM Conor Dooley <conor.dooley@microchip.com> wrote:
>>>>>>
>>>>>> On Fri, May 15, 2026 at 08:46:25AM +0800, Sune Brian wrote:
>>>>>>> On Fri, May 15, 2026 at 12:14 AM Conor Dooley <conor@kernel.org> wrote:
>>>>>>>>
>>>>>>>> On Thu, May 14, 2026 at 07:46:46PM +0800, Sune Brian wrote:
>>>>>>>>> On Thu, May 14, 2026 at 6:37 PM Peter Robinson <pbrobinson@gmail.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi Brian,
>>>>>>>>>>
>>>>>>>>>> You have made a very generic statement about levels of accountability
>>>>>>>>>> on patch sets and consistency in reviews.
>>>>>>>>>>
>>>>>>>>>> Can you be more specific?
>>>>>>>>>>
>>>>>>>>>> Ultimately there are subsystem maintainers and each maintainer has
>>>>>>>>>> variation on how they deal with their subsystem. You reference one doc
>>>>>>>>>> three times in your statement.
>>>>>>>>>
>>>>>>>>> Hi Peter,
>>>>>>>>>
>>>>>>>>> Now I understand what you mean.
>>>>>>>>> Simply one sentence is a bit hard to read what your thoughts are.
>>>>>>>>>
>>>>>>>>> That document I am quoting does not refer to the entire docs but only one
>>>>>>>>> section of the docs with that link.
>>>>>>>>>
>>>>>>>>> Before quoting, my declarations as follows:
>>>>>>>>> 1) I am not referring to specific people or party
>>>>>>>>> 2) I experienced reviewer which again not being specific to one that
>>>>>>>>> mentioned this docs is a supreme rules to follow otherwise patch
>>>>>>>>> that is committed is not able to push to mainstream
>>>>>>>>> 3) I simply do a quick check on u-boot mailing pool and do see a lot
>>>>>>>>> of uncompiled reviewed patches that are not following that supreme
>>>>>>>>> docs.
>>>>>>>>>
>>>>>>>>> As such I will being to quote:
>>>>>>>>>
>>>>>>>>> The mailing that are reported as not passing the standard of [1]
>>>>>>>>> Full mailing:
>>>>>>>>> https://patchwork.ozlabs.org/project/uboot/patch/20260423042824.3480-1-briansune@gmail.com/#3684415
>>>>>>>>
>>>>>>>> patchwork isn't loading for me, but it's on lore here:
>>>>>>>> https://lore.kernel.org/all/20260423042824.3480-1-briansune@gmail.com/
>>>>>>>>
>>>>>>>
>>>>>>> Hi Dooley,
>>>>>>>
>>>>>>> Well I am sure you did not have the full picture.
>>>>>>>
>>>>>>> The request had nothing to do with under the --- line if this is
>>>>>>> really the case:
>>>>>>
>>>>>>> Let me bring you back to the history of wonders:
>>>>>>>
>>>>>>> https://patchwork.ozlabs.org/project/uboot/patch/20260421004719.73491-1-briansune@gmail.com/#3680232
>>>>>>>
>>>>>>> https://patchwork.ozlabs.org/project/uboot/patch/20260422065910.5398-1-briansune@gmail.com/
>>>>>>>
>>>>>>> None of those reviewers had mentioned this issue once "---" rather they all
>>>>>>> just alarmingly repeated the wordings.
>>>>>>
>>>>>> The first mail in the thread mentions it:
>>>>>> https://lore.kernel.org/all/CAFLszThg=EamyRohxNA7V+nk+OMVK356nUjAVSbu4+kokOJpdA@mail.gmail.com/
>>>>>>
>>>>>>>
>>>>>>>> The comment about the changelog format seems to be very harsh, I doubt
>>>>>>>> it really makes any difference. What you did and what the maintainer
>>>>>>>> requested are effectively the same thing at the end of the day.
>>>>>>>>
>>>>>>>
>>>>>>> Of course after reading the docs I got it immediately.
>>>>>>> However did those who request contributors quote this from first place?
>>>>>>>
>>>>>>>> The real problem with your patch is that you put the changelog into the
>>>>>>>> commit message itself, rather than under the --- line.
>>>>>>>> None of the examples you quote below do that.
>>>>>>>>
>>>>>>>
>>>>>>> Well after 4 patches of ridiculous request and logic change.
>>>>>>> I guess you will do the same. At least I am not doing it at the
>>>>>>> first moment on replying to the mails who or whom you had mentioned.
>>>>>>
>>>>>> I think this is a reply to the comment below?
>>>>>> The aggressive/antagonistic responses begin in your first reply to
>>>>>> Simon:
>>>>>> https://lore.kernel.org/all/CAN7C2SAdg1MX3ZfEt5-68iiw3pdjyqva48F_uJjNwsHAhdmY3Q@mail.gmail.com/
>>>>>> "So forgive me I really don't give a damn on whatever the header
>>>>>> requirements." "There are many better things to do rather than complaining
>>>>>> about the patch headers."
>>>>>
>>>>> Hi Dooley,
>>>>>
>>>>> You are a bit off topic here sorry if you don't think this is the case but
>>>>> please do finish reading.
>>>>>
>>>>> For what the accused I will give out specific mailing dialogs to explain
>>>>> [HERE].
>>>>>
>>>>> The major discussion or query is all about the standards or rules.
>>>>> There is nothing to do with the reply.
>>>>>
>>>>> Meantime, I cannot see this as "aggressive/antagonistic responses".
>>>>> When the request changes it is ridiculous as you also agree:
>>>>> The header text /  wordings from the updated patch itself
>>>>> had zero impact on the patch itself.
>>>>>
>>>>> You are just simply telling me that if you get hit by someone 4 times,
>>>>> the man who stands out and responds is "aggressive/antagonistic".
>>>>>
>>>>> Again we are NOT discussing any mailing dialogs but the U-Boot
>>>>> patch header standards and rules.
>>>>>
>>>>> Meantime you had failed to respond or comment the entire mailing
>>>>> dialogs do mention any "---" header requirements nor the
>>>>> necessaries of following docs supreme rule / standard from first place.
>>>>>
>>>>> [HERE]
>>>>> Allow me to quote the request of header and modifications mail history:
>>>>>
>>>>> No docs cited nor clearly mentioned the need of specific wordings:
>>>>> https://patchwork.ozlabs.org/project/uboot/patch/20260420074601.24988-1-briansune@gmail.com/#3680096
>>>>>
>>>>> No docs cited nor clearly mentioned the need of specific wordings:
>>>>> https://patchwork.ozlabs.org/project/uboot/patch/20260421004719.73491-1-briansune@gmail.com/#3680232
>>>>>
>>>>> So now you are telling me after at least 2 versions of modifications
>>>>> reviewers suddenly think oh this is not good enough (by my rules)
>>>>> I think it should be other styles etc.
>>>>>
>>>>> Now "LOOK INTO MY EYES" and tell me what is the actual U-Boot
>>>>> header standard? Reviewer mood or docs that are given out?
>>>>
>>>> Brain, I understand being frustrated with the process. Ultimately,
>>>> everyone here is a volunteer and trying their best. Which means that
>>>> yes, we are not entirely consistent about some parts of the review
>>>> process. I would ask you to please be kind to everyone, and expect being
>>>> kind in return.
>>>
>>> Hi Tom,
>>>
>>> Sorry for the additional reply:
>>> First I need to apologize that I am also blinded by emotion and
>>> off-topic.
>>>
>>> Back to the topic:
>>>
>>> Patch header standard is not consistent so docs is not a
>>> supreme standard or supreme rules on the commit changes vN.
>>
>> The base rule for U-Boot is right as the beginning of the doc page:
>> ```
>> A good introduction how to prepare for submitting patches can be found in the LWN article How to Get Your Change Into the Linux Kernel as the same rules apply to U-Boot, too.
>> ```
>>
>> But as the scope of U-Boot is very different and the account of people working
>> on the project is significantly lower, so the actual review/maintainance allowance
>> is less strict.
>>
>>>
>>> Based on the above response we should conclude one fact!
>>>
>>> In those mailing pools that are citations or quotations;
>>> responses or changes requested have no inherent issue
>>> to pass and accept.
>>> The changes requested on very specific wordings are
>>> unreasonable.
>>>
>>> Of course Dooley had mentioned the request of after "---"
>>> placement however again based on this reply it should also not
>>> an issue to push to master.
>>>
>>> Again basically speaking the entire change request or requirement
>>> is not a must nor really needed in the first place.
>>>
>>> I hope this should provide a very good baseline to contributors
>>> and reviewers how they should review and create patches / commits.
>>
> 
> Hi Neil,
> 
>> The baseline is clear since most of the U-Boot developers, reviewers
>> and maintainers are experiences Linux developers as-well.
> 
> Are you sure?
> If so, why do I clearly see the double standard?
> And why Dooley would clearly mentioned doubt on the specific wordings
> making any difference.
> 
> Again without the double or multiple standards placed on the table
> and teasing with ridiculous changes requested due to specific wordings:
> why is it required to raise the tone from first place?
> 
> Reading specific dialogs is not going to understand the full picture.
> I also doubt you do read the context before reply or comment.
> 
> Meantime you are off topic on the citation of context [1] in this mail.
> My question here is pointing out double or multiple standards on specific
> wordings.

Please read my entire response instead of inventing stuff:

```
But as the scope of U-Boot is very different and the account of people working
on the project is significantly lower, so the actual review/maintainance allowance
is less strict.
```

There's no double or triple standard, there's simply a more disparate
allowance due to low review and maintenance capacity.

To make it simpler so you can understand:
We're happy when people takes time to review and pick patches, even if doesn't
strictly conform to the "rules".

Reviewing, picking, building, testing and creating pull requests takes a lot
of our precious volunteer engineering time, be grateful of that.

We're a fully volunteered, self organized open source project, please keep
this in mind.

I think this thread loops in the void, so I think it would a good time
to stop responding.

Neil

> 
> Thanks,
> Brian
> 
>>
>> And as an extent, other rules does apply informally to U-Boot like
>> any other Open Source project ran by volunteers, please have a look at:
>> https://docs.kernel.org/process/code-of-conduct.html
>>
>> I'll cite the following behaviors that any Open Source project would like
>> to have as basic rules of communication:
>> - Using welcoming and inclusive language
>> - Being respectful of differing viewpoints and experiences
>> - Gracefully accepting constructive criticism
>> - Focusing on what is best for the community
>> - Showing empathy towards other community members
>>
>> I did review the communication between You and Simon, and this exact thread,
>> and your replies are not acceptable, and I'll ask you to reconsider your tone.
>>
>> Thanks,
>> Neil
>>
>>>
>>> Thanks,
>>> Brian
>>>
>>>>
>>>> --
>>>> Tom
>>

