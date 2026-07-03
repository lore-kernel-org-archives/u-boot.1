Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE72C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 12:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4901784A35;
	Fri,  3 Jul 2026 14:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YGcHjHsf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE85884A4B; Fri,  3 Jul 2026 14:59:19 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32D1B849F6
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 14:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-473ba028d46so611381f8f.1
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 05:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783083556; x=1783688356; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wxL9Mp/Vojc9c6iRCiZ3eQ5CtIaxRy/Q1OKS3wXCuiQ=;
 b=YGcHjHsfLrszIQqKTD94OcUxXFL6BMVcvPGFvGA6Lyfv/b9kaZIT42gKpi2GSdX2uN
 AZjdJDExlunOidtmcnoENq4SndNAfp0L+Cg2nxdp1Aw4iAyemV+uLPf3uBKZEdzSGHlJ
 pbuqpAKCfukbS8QF5F//7b4JrCInvsXqkrUCG3ySPfqghqavCZZebhxi7QN15A6x89Hi
 hlGMMsJM2gjzG1LvMrtvIW89oYXnZnwGrQ9ferCqpoTkgjKMvlSCm54z9KICT+d3GjVo
 9rYpmxykfepA6ALtVCQMO5Da0hc+EOsYgm6u7rCFoM4IH3ZGoI59+uHaxLbjxy8/jvqy
 x4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783083556; x=1783688356;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wxL9Mp/Vojc9c6iRCiZ3eQ5CtIaxRy/Q1OKS3wXCuiQ=;
 b=T4yMHKLeA8AmZlrgZ25K8dor8z1HRLU2f2SeZCAiegPXhNP+R5+trFE8xnGbc+ESPk
 eabB5ppMoIQSnAMRMwiGppueoTejlp3Oq2hMtEKyOq518pa3+gBe5ElyQqfLkgUDsaQe
 WNcFv16YGi3KuksVqFCAE39ZRETYyVcGl4xluvXQ7Jdb6St3aKMGsoPBaRoFtqFGyPoG
 CbNy5CMv9q/3LWPFXeSy9KDO9IL4JtvZNuWy6OzwpVFcnzeRP+Zlg0TWdmTimjgdzM+D
 IePZF6KgO8aTx2SwnsWgfzma0S8m8YXnkDzinuc4mVBR40tCi0nLs5+wNQs8b7zlDId4
 eLgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxN8EVXsFoYe7moOUf8gYm4YzbNouyAOFRAINTXkDQyoyw+lccXzP4XeAzekmQNlKuatOmosw=@lists.denx.de
X-Gm-Message-State: AOJu0YzRb61iykhw5dBfv20KDi+16sRPwfvzSORL/P9bRT770iGXZ3NZ
 qMhecGDlCdyXZZX7ky0ytEiQsgYIa1+a369PC9YgUF7na7X89OvuvLGj8YXlhLBslOQ=
X-Gm-Gg: AfdE7clygx0NjAJdCs/JD44+FAmxnb2RWgaX4IDG18zxFzgnkNWehZtRKFxFeZYZVwN
 OcXAXhwKtMMxwgYqX38rWShTHXEcExZAkpCpuVllR0u2rwSj/LtCg3kt21e7UnyBtSeaTLt9L80
 5MZg3YAsPUFRK47j9X1vVhu2WqExLXeA/VagEYC4eftZwGhJ/NX4qfTSu9LgABILTghv0SeUohN
 0K6vnW77z9nK8DN/v13tVCAjlZMU7Bamm0pSfMyyPYqAG3gNYAVOssUwuOterSo50eZe6sl6/2P
 GRZhnW/UX+i+j1DwgsX1cld24cPwKm0NwlIGySrJivBGSGqTYaV/5eBzdW9F4b5R5OOHC14ejz9
 GqvvUPiE+vTbYxqZTChDEkMuSDslMpNLQc9LWIk3uZNPlI+eqlwQts7VHKcn7UES7CwOUpXFdfe
 Xpy42CkrQykyrNydgqDUuOdfJhtwz45uKqswSNKQ3b7pfFJTHFbhFcBIY=
X-Received: by 2002:a05:6000:4203:b0:46f:f12b:e456 with SMTP id
 ffacd0b85a97d-47758db8316mr14508159f8f.25.1783083556482; 
 Fri, 03 Jul 2026 05:59:16 -0700 (PDT)
Received: from [192.168.1.245] (p509936c9.dip0.t-ipconnect.de. [80.153.54.201])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477de3dc77bsm18445838f8f.33.2026.07.03.05.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 05:59:15 -0700 (PDT)
Message-ID: <77ff0f56-5c3b-42e7-bdd1-bf90296da900@linaro.org>
Date: Fri, 3 Jul 2026 14:59:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] drivers: sysreset: revert support for args
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Michal Simek <michal.simek@amd.com>
References: <20260702-revert-sysreset-v1-0-7920c16a1f3a@cherry.de>
 <2ccadd61-59e3-4f97-950a-47928c83c7c9@linaro.org>
 <83dbaf71-7bf0-4c64-a634-8a3bab9a72fb@cherry.de>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <83dbaf71-7bf0-4c64-a634-8a3bab9a72fb@cherry.de>
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

Hi Quentin,

On 7/3/26 14:35, Quentin Schulz wrote:
> Hi Casey,
> 
> Thanks for the prompt answer!
> 
> On 7/3/26 2:27 PM, Casey Connolly wrote:
>> Hi Quentin,
>>
>> On 7/2/26 20:27, Quentin Schulz wrote:
>>> The args support for the sysreset uclass contains a logic bug. The first
>>> sysreset device implementing the request_arg callback will consume the
>>> args, not support the specified arg and thus return -EPROTONOSUPPORT
>>> which will stop the iteration over all sysreset devices.
>>>
>>> This is an issue if one has multiple sysreset devices and each with
>>> support for different (valid) args. If a sysreset device implements a
>>> -dummy argument and another -foo and one calls reset -dummy on the
>>> U-Boot CLI, it'll depend on which sysreset device will be attempted
>>> first. If it is the one implementing -foo, it'll return it doesn't
>>> support the argument with -EPROTONOSUPPORT in which case the device
>>> implementing -dummy will never be attempted and instead we'll do a cold
>>> reset which is very likely not what's expected.
>>>
>>> I suggest to either add an additional return code for the case where the
>>> sysreset device knows it isn't supposed to handle this argument because
>>> it isn't among the ones it supports, and thus we try other sysreset
>>> devices until we find one that says it tried and either is in progress
>>> or couldn't realize the request, or no sysreset device supports this
>>> argument and we end up doing a cold reset (but should we even try to do
>>> a cold reset if the type of reset requested by the user isn't
>>> supported?). Or just don't try piggy-backing on the reset command and
>>> have a new command instead?
>>>
>>> Maybe I misunderstood something or misread the code, so please correct
>>> me if I'm wrong.
>>>
>>> We've tried bringing up this issue multiple times over the last
>>> month[1][2][3] but it seems like we're left on read. This is the last
>>> resort to get attention on this patches, hopefully we don't have to get
>>> through a revert a few days before the release though there is only two
>>> working days left before the release. Sending a revert as requested by
>>> Tom[4].
>>
>> I'm so sorry I missed this feedback. That really isn't great.
>>
> 
> It happens, I'm glad you see it now :)
> 
>> I'm with you that this is a pretty fundamental issue with the 
>> implementation here and I think the best course of action is to revert 
>> it and come up with a more suitable approach that isn't so open to 
>> trivial logic bugs like this, likely with some deeper refactoring of 
>> sysreset/reboot-mode code in U-Boot.
>>
>> In hindsight I think I should have pushed back harder on this 
>> implementation, this is something I'll be more cautious of in the future.
>>
> 
> Just to be clear I wasn't trying to shame anyone here, contributor, 
> reviewer or maintainer. Mistakes happen.
> 
>> Acked-by: Casey Connolly <casey.connolly@linaro.org>
>>
>> I don't have a chance today to test this today as I'm OOO but if it 
>> doesn't break other platforms then it ought to be fine on Qualcomm 
>> too, maybe Neil can give it a spin on 8650.
>>
>> Tom: feel free to pick this up if you're happy with it.
>>
> 
> Varada sent a series trying to fix the logic, c.f. https:// 
> lore.kernel.org/u-boot/d7e003b3-e693-4579-8e3a-b09ce9f78d10@cherry.de/T/ 
> #mf098752c30cd6a6c8e7700f61cd54cbc8f307d6d. But if you feel like we 
> should start from a clean slate again instead then we can revert this 
> now and take the time to implement this differently for next release. I 
> think your feedback on what to do next is important here. But I 
> appreciate you're OOO so we'll do without if you don't have time :)

heh I just saw that after hitting send...

I think the original series could probably have used some more 
discussion before it got picked up, and the overall approach feels less 
than ideal particularly when the reboot-mode mechanism already exists 
for exactly this purpose.

imo eeping this implementation will only result in further issues down 
the road particularly as other vendors adopt reboot2 support, and 
frankly doing argument parsing in drivers just feels deeply wrong to me.

So I'd say let's revert it and go back to the drawing board with 
something cleaner and more scalable. The exact same functionality has 
gone through a lot of iterations on the Linux mailing list and it seems 
like they're coming up with something quite sensible in the end with a 
reboot-mode subnode on the psci DT node. With those DT changes in place 
it seems foolish to a) have this be qcom specific and b) hardcode these 
magic values in the driver.

https://lore.kernel.org/linux-pm/20260514-arm-psci-system_reset2-vendor-reboots-v22-4-28a5bde07483@oss.qualcomm.com/

I would be strongly in favour of something like the above, the "reset" 
command in U-Boot could then have a way to retrieve all the possible 
modes registered with the reboot-mode framework.

Thanks,
// Casey

> 
> Thanks,
> Quentin

