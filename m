Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D890CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 03:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D76D9871F3;
	Fri, 20 Oct 2023 05:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697771934;
	bh=sdyL7frsBO2tT6eMxyaw7cKS2UStzSIQMQ3xu42vkbQ=;
	h=From:Subject:To:Cc:References:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=OuBDlS9g3ClaORssGhJS0ANimqbBGHp1Ua0UY4Rus6bOuARuXTltGuLuSjssRYVgD
	 v3w+k/BYlwpxwBh7pNfqvrWzSlSPUDZUdKkCUJIHd2xPBPRxNAZRxHb/+I8S7V79sX
	 65z8dhHfQY902rzfVxeQqIDsrMGdmEJWR0LAnhJTmLHkYxwB5VLpp+bAkO9DQD4u5i
	 SdAh9Bwlkd+dOWZxJY2JLioJvsDsjwciH/wUqpWBxYxj/wUCThv25ipquGuc5qlLcw
	 9HctuEBVADGcCwoN5EVm/uFDHRnfNTbYPdpRb6F1vgcB9MIFkZwMBG2IQz3GgmddA6
	 6ydztwNq/5FQg==
Received: from [192.168.1.107] (82-131-155-145.pool.digikabel.hu
 [82.131.155.145])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1ABBB871F0;
 Fri, 20 Oct 2023 05:18:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697771931;
 bh=sdyL7frsBO2tT6eMxyaw7cKS2UStzSIQMQ3xu42vkbQ=;
 h=From:Subject:Reply-To:To:Cc:References:Date:In-Reply-To:From;
 b=JJ07eCDbO40/qSYFDLsOOO6N94Fm2j9doPHVjKVJc0eMLIxNWuGzBci8U3bIfZDWA
 jbobfUwEeg6XUPNd5Kl3uwgJnA8bb9jbYlDkfDry0IzDvGJfpbaMwmkPyeSWNn9G2i
 jCtxrQQyGjhQBNBMsKKlWKiHyZzYxiRkCke8prSf7Uudnp8AK/X5iNOCuZ1uWmXwpo
 ZYPGnX4ocmKYlzxefuOr+chY8r3ntFLkJOiSyIB4T/uXR7awgdObsddGjpk0XPuk/c
 JUgorZVQFfpdn7dTLbQgBJMiykXxtL/4pjknTiQTPI/bt+VivAnBvsEt5tYs1XTDpq
 Oa4/q+es3LdRQ==
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 2/2] bootcount: Add driver model I2C driver
To: Simon Glass <sjg@chromium.org>, Philip Oberfichtner <pro@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <20231013094302.28944-1-pro@denx.de>
 <20231013094302.28944-3-pro@denx.de>
 <037dac45-eee4-c0f1-b72e-ee0a2bfe3807@denx.de>
 <ZSk-2lBrLW5Bel_X@eryximachos.home> <ZS6ET7ExtDSCfsNN@eryximachos.home>
 <CAPnjgZ2OZka03fG5Bt49JxoLn-VHy5TB81r6_uXTy+K5SOGYOw@mail.gmail.com>
 <1ba8ea25-bad0-b66f-b189-67754c488103@denx.de>
 <ZS-6WM11jJnsaakJ@eryximachos.home>
 <CAPnjgZ3bmVieVZpYGPbbGZFU-VF3FbGbAGGM8ekLKhOw=uYS1A@mail.gmail.com>
Message-ID: <6e460b7f-9bc5-e961-7175-abf5ac0001c0@denx.de>
Date: Fri, 20 Oct 2023 05:18:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPnjgZ3bmVieVZpYGPbbGZFU-VF3FbGbAGGM8ekLKhOw=uYS1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Philip,

On 18.10.23 18:10, Simon Glass wrote:
> Hi Philip,
> 
> On Wed, 18 Oct 2023 at 05:00, Philip Oberfichtner <pro@denx.de <mailto:pro@denx.de>> wrote:
>>
>> Hi Heiko,
>>
>> On Wed, Oct 18, 2023 at 06:31:57AM +0200, Heiko Schocher wrote:
>> > [...]
>> >
>> > May Philip can use uclass_get_device_by_phandle and try a list of
>> > possible UCLASS candidates, like UCLASS_RTC, UCLASS_I2C_EEPROM,
>> > UCLASS_POWER,... and if found, check if parent is UCLASS_I2C...
>> >
>> > may not so expensive ...
>>
>> Looks more cheap and elegant than the other variants indeed. But I'm not
>> sure if we can maintain generality using this approach.
>>
>> What if the specific I2C driver is not included in the build, because
>> the devices "actual" functionality is not required?
> 
> Then the device will not be bound and the function will fail. There needs to be a node and a bound
> device.

Yep.

>> Or what if a driver
>> for the specific device does not even exist in U-Boot?
>>
>> Wouldn't the device fail to probe then?
> 
> The DT should specify the compatible string so the correct i2c driver is used. If there isn't one,I
> believe it uses I2C_GENERIC but you'll need to check it.

Yes, needs a check.

But... that is the real issue with that approach (more or less with
all bootcounter drivers?) ... if you assume that the device driver
is not there, may there is missing device init/probe stuff, so also
may the bootcounter will not work!

The i2c device should know, that some registers, mem (or whatever) is
used for bootcounter function, so that it does not use this space for
other device stuff ... to make bootcounters correct, we need something
like a MFD approach here ... and register a bootcounter within that...
so init/probe stuff is always done, and registers/mem is reserved ...

But unfortunately we do not have this...

>> Please correct me if I'm wrong, I'd give it a shot in that case.
>> Otherwise I'll try it with the aforementioned
>> device_find_global_by_ofnode() followed by device_bind_driver() using
>> UCLASS_I2C_GENERIC (I hope that works).
> 
> That is the same approach, I think. But anyway I think Heiko knows more about this than me.

Hmm... yes, with UCLASS_I2C_GENERIC it could also work, but see my
comment above ...

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
