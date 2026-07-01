Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B59C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 06:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6049384A3C;
	Wed,  1 Jul 2026 08:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VB+ZgZCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0652784A52; Wed,  1 Jul 2026 08:23:42 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A09584A26
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 08:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493be1b9682so1666725e9.2
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 23:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782887018; x=1783491818; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JhvIiflFDzXFoTGioPK9CR5jvGnGeDwy1UI+Ub4DIVU=;
 b=VB+ZgZCrwngcJtxBizjHxSdg1v8mdGyNXXlNmGoxtaMxEyssnPb0Nh5+4Et6UrhyRR
 hZyRqZuPuOOhiWE8gfBcNxZvmdKci+nev0gjgPr3l/ffElHl9eL91wp0SLy+s7wSuKGy
 ErgirWm7b56remHqRFqHW1/SLxVX7lr+9dlSLHkWQExD6ykoi/RVmlI2uWMxb4ni1zLA
 1hHQu6Q1a+hXFtgo6HxoezMvIopyTelKzsZEWyNxMtTU4ZKqFWfR+1fxkaf/donh/sY3
 b/+8taZGtZka/q3X1VUVTzsLIaX8GaABiDHmFg5aoQIKBQgkhnb1q1FZBB49vo9mV7WI
 IpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782887018; x=1783491818;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JhvIiflFDzXFoTGioPK9CR5jvGnGeDwy1UI+Ub4DIVU=;
 b=ee3tKyNur4lOjgE9l3cbXrDL3Imx7Xo237w5jAoNJx4+ggsmFMuGEFbf4BZt9YdYGl
 kQtqMS9nQohmgtW7jnJ+bFQEmCKyALdODKpU7W0Jc4YUeUdK6ITNDoxNHTlOG0nYOE5S
 vqTu2LVJEIIX9gh6zmxkgjD6dUpYQjnfvOr1/MikX0JwmwEN3SALNJ+9GhTA/r7MnMXV
 U5Y5KbvkmFNoxNb6JmVzWfGpKXdR3HGeX4+Mg97e10jA61V3o2YfKRJ6z1FRuGvypLn4
 q6xKfGTW2sPN4tScM8IGzVhPzV+dY2KT5aoAcJVxgJa3tesWawOtwDuw/8yjAeIrMVyI
 gfSQ==
X-Gm-Message-State: AOJu0Yz8Ri/VvN8DdCaIaHjlGAsySZZf6q2bhQqC3cwrT9lWZWul09pV
 mjVD8TKNKyCpUFHj50N6cUA7RzVuBxQwZOUQ8OWhGDa2/j1OikoLR7rzjrPHZvQx2ySND4IKW38
 RxZwGZRdSxw==
X-Gm-Gg: AfdE7clhCzBZKuwp3RFM9jYvpKRnyy79G4elIIs1tWH3vpYIo68h4zBXIJ9waV39cnO
 8h4FHUKJWmrvoyWmD5bSUk6Yumt/zoiiJZisbkvcXopaTPzNAXvFYXDeMUXfPDLK0JrvgkgOcN2
 ZTHOApz16EbWse82yZXBMHPbIM/0d4PTUsQMBgcI5n+oQasop64MsebW3NuCah7/Nhq0W5XmS3L
 Ltc6soY90XzRZzDMOnJ3745gJjslq0+pgLOlM3xYFbQhQi7wkWccWOl1RLTBmiZ9O8h1I5SmsRu
 muljM7aae4m9kauTYh7t5OIdcFLHAb4nl1yQWasvGsOO/ykfuJq2MTm6JECVPtKp7ps7yX0S09E
 u1MDmN88efuizQUTiWaYpUz6ppJuhqogcYdflNY6sWu+cuDlOuBj1Vz3JH6DHfq5ciUNk4vFhDm
 XCAaxrVmZenVvUCe5tL6sGAHP8GKFDUSmMz04m+bTRuXOvXc8ipB+amusuugE=
X-Received: by 2002:a05:600c:c118:b0:492:62d9:4e57 with SMTP id
 5b1f17b1804b1-493c2b382c2mr2809355e9.2.1782887018476; 
 Tue, 30 Jun 2026 23:23:38 -0700 (PDT)
Received: from [172.20.10.2] (ip-109-42-118-107.web.vodafone.de.
 [109.42.118.107]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bfe7427dsm19329195e9.2.2026.06.30.23.23.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 23:23:37 -0700 (PDT)
Message-ID: <2b62cc26-f457-430e-83f4-0de1ce2b2229@linaro.org>
Date: Wed, 1 Jul 2026 08:23:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] get_maintainer: ignore Tingting Meng
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260616131133.2143136-1-casey.connolly@linaro.org>
 <20260616143649.GH382693@bill-the-cat>
 <151e43ad-d1d8-4c14-a541-0824abb7186c@linaro.org>
 <20260617172654.GR382693@bill-the-cat>
 <e3511960-44fe-4faa-8da5-aed28a677ca9@linaro.org>
 <20260630213357.GE749385@bill-the-cat>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260630213357.GE749385@bill-the-cat>
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



On 6/30/26 23:33, Tom Rini wrote:
> On Tue, Jun 30, 2026 at 09:18:35AM +0200, Casey Connolly wrote:
>>
>>
>> On 6/17/26 19:26, Tom Rini wrote:
>>> On Wed, Jun 17, 2026 at 05:03:52PM +0200, Casey Connolly wrote:
>>>> Hi Tom,
>>>>
>>>> On 16/06/2026 16:36, Tom Rini wrote:
>>>>> On Tue, Jun 16, 2026 at 03:11:26PM +0200, Casey Connolly wrote:
>>>>>
>>>>>> Their email is no longer valid and bounces, ensure we don't include it
>>>>>> in get_maintainer.pl output.
>>>>>>
>>>>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>>>>>> ---
>>>>>>    .get_maintainer.ignore | 1 +
>>>>>>    1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore
>>>>>> index 899a1469b2ae..5b7d84646f62 100644
>>>>>> --- a/.get_maintainer.ignore
>>>>>> +++ b/.get_maintainer.ignore
>>>>>> @@ -1 +1,2 @@
>>>>>>    "Pali Rohár" <pali@kernel.org>
>>>>>> +Tingting Meng <tingting.meng@altera.com>
>>>>>
>>>>> The .get_maintainer.ignore file is a heavy-handed measure for things
>>>>> more serious than just bouncing email. It looks like Tingting Meng just
>>>>> comes up via git history and so will roll out of emails in a few months
>>>>> now, so I don't want to go this path.
>>>>
>>>> Ok, that makes sense. I have found bouncing emails and excessively long
>>>> CC lists to be a bit of a recurring email when using b4 prep
>>>> --auto-to-cc, do you have any ideas on how we can improve this?
>>>>
>>>> Maybe we could tighten the timeline and/or contribution weight a bit?
>>>
>>> It's hard because we've had contributors at both ends of the spectrum
>>> speak up before. I think what Marek has been doing to use "N" to get
>>> more files covered by maintainers directly helps so that more things
>>> will always have someone else see them and in the future maybe we can
>>> try and lower the git range.
>>
>> Hmm I see. I've been getting some feedback from folks who have contributed
>> to Qualcomm support that they are being CC'd in too many patches as well.
>>
>> If we will keep --git for then perhaps we could try and tune things a bit to
>> be less aggressive? Maybe something like:
>>
>> --git-min-percent 15 --git-since 4-months-ago --git-max-maintainers 2
>>
>> Still less than ideal for defconfigs and such but at least it would reduce
>> the huge CC lists that "b4" currently makes. I think 4 months is more
>> reasonable than 1 year so things will cycle through faster and folks will
>> still be notified about changes up to the next release.
>>
>> That being said, if folks are speaking up about not being CC'd in patches
>> that touch code they care about they really ought to add themselves to
>> MAINTAINERS... We have board/qualcomm/MAINTAINERS for exactly this purpose.
>>
>> The --git flags will never be perfect imho, but would you be ok with the
>> changes above? Or any subset of those flags?
> 
> So, 4 months is only a bit more than one release cycle. Maybe 6, since
> we're currently at 12? And I don't disagree with saying we need more
> people to list themselves under MAINTAINERS if they're interested. The
> feedback has been less on board / platform code, and more on general
> code that just won't usually have a specific maintainer, and due to the
> slowness of testing cycles on a lot of platforms, it takes a while for
> corner cases to be found and reported on or a workaround / fix proposed.

Right I see, yeah that sounds reasonable. I'll send a patch then and see 
if anyone has other feedback. We could always try it for a cycle and 
revert it if there are issues.

Thanks,>

