Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF66E10BA425
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 07:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DED8084010;
	Sat, 28 Mar 2026 08:05:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="J6iOihPn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FCAB83DA7; Sat, 28 Mar 2026 07:43:58 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F1078394E
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 07:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 35D981125B4; Sat, 28 Mar 2026 07:43:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1774680234;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=rw39yihxKLlu8Uf6ArwdqVOcXmmYYeUxMsEElf2kZpI=;
 b=J6iOihPnSLXLCUFPqYUsDUo4c82bNPDxffEmLURc3e02KrAcvwFFYjUAsnbAw8CcNul8Fg
 rygnQy+yxieJz+Oc3ez+h/ag+ttbHw21vinFB+lpK6p18CJCKdE5hv/cbE0HuQeZRbliJ2
 OJ5a4JmN82I+7vho+/dYiV47frE8oUk1zlI2ebqnQcqB5cLwPqPO8ornNdywq3zvezRtlI
 oMGQzl1l904FPzyS3SJwORK7zJs/NumOnvfnOelorbpgT9GKLY3Y3pYkApA0Q64oKmm/JA
 XshdyGm2XjNmvKK0A6OfThpjbjeCLg8jjJMjebzX6s0pwGO+gdJPRj3hdS1fag==
Message-ID: <03fd5ca1-6581-4c50-8d50-2cfae6d98683@nabladev.com>
Date: Sat, 28 Mar 2026 00:11:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: dhelectronics: imx: Use second Ethernet MAC also
 from fuse
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot <u-boot@dh-electronics.com>
References: <20260320102918.4011-1-cniedermaier@dh-electronics.com>
 <382f338c-020f-482d-80b8-5a39ad724843@nabladev.com>
 <b443e161b5db4abab8d8889135a345fa@dh-electronics.com>
 <941708e9-a2e6-4f8d-a15d-d1da8a91ae91@nabladev.com>
 <2eebac26eff54f9da7e2d01dbca71569@dh-electronics.com>
 <a40a11f9-f3f5-4eee-ab6e-c2597808c471@nabladev.com>
 <a7ebfe912f084176b79c54a2e9e3d8e3@dh-electronics.com>
 <2dca42bf-a247-4190-9439-14e14f65aec3@nabladev.com>
 <3a8724ffe4fa44808ac8a278e4a702f7@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <3a8724ffe4fa44808ac8a278e4a702f7@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Sat, 28 Mar 2026 08:05:42 +0100
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

On 3/27/26 11:02 PM, Christoph Niedermaier wrote:
> From: Marek Vasut <marex@nabladev.com>
> Sent: Monday, March 23, 2026 6:21 PM
>> On 3/23/26 5:49 PM, Christoph Niedermaier wrote:
>>
>> [...]
>>
>>>> As for the rest, it really boils down to the ordering of fallbacks, it
>>>> is either:
>>>>
>>>> A)
>>>> fuse1
>>>> eeprom1
>>>> fuse0+1
>>>> eeprom0+1
>>>>
>>>> or
>>>>
>>>> B)
>>>> fuse1
>>>> fuse0+1
>>>> eeprom1
>>>> eeprom0+1
>>>>
>>>> The following ordering, which is the ordering introduced by this patch,
>>>> is confusing:
>>>>
>>>> fuse1
>>>> eeprom1
>>>> eeprom0+1
>>>> fuse0+1
>>>>
>>>> So please pick either A) or B) above. I do not see any particular
>>>> advantage of either of the other, except maybe B) improves boot time in
>>>> case both fuse blocks are blown, because it avoids the EEPROM I2C access.
>>>
>>> The prevention of I2C access is only a one time effect, because then the
>>> MAC addresses will provided by the environment.
>>
>> Which increases the system boot time, which is undesired.
> 
> If a customer sequentially fuse only the first MAC address from a MAC address
> pool. Then the second MAC address of the SoM is the same MAC address as the MAC
> address from the next SoM's first MAC address. That is very bad. With the A)
> it can be avoided, because the second MAC address then is taken from the EEPROM.

This edge case can be fixed on first boot in a boot script. Read out the 
fuse using "setexpr var *addr", detect whether the fuse is empty using 
"if test ...", and if it empty, then populate its content with EEPROM 
content. This saves you one extra I2C operation on every boot afterward.

> If I had to choose between reducing the boot time once and preventing potential
> duplicate MAC addresses, I would say that preventing potential duplicate MAC
> addresses is the better option. Furthermore, the issue of duplicate MAC addresses
> in the system is not a hypothetical scenario, it has already occurred in practice.
> 
>>> If I remove the eeprom0+1, because it was for prototype configurations,
>>> my preferred order would be:
>>>
>>> fuse1
>>> eeprom1
>>> fuse0+1
>> eeprom0 can not be removed, that breaks backward compatibility. And the
>> ordering of fuse-eeprom-fuse is confusing and has the boot time increase
>> downside of A).
> 
> For which SoM should backward compatibility be maintained here. There is
> no SoM at the customer's site where it is required. For rev.200 the EEPROM
> ID page is used, for rev.100 only some internal SoM prototypes with two
> Ethernet interfaces had only the first EEPROM populated. It's not worth
> keeping that code.

So yes, eeprom0 can not be removed, because it also contains the WLP.

>> I would say B) is the way to go, it should also cover your requirements,
>> keeps the boot time low if both fuse banks are fused (which can be fixed
>> even on existing hardware, simply read out eeprom content and fuse it
>> into fuse bank 1), and it retains the priority ordering (env, fuse,
>> eeprom) without mixing it up.
> 
> The case that only the first MAC address is fused and not the second one is
> a special case, but if this happens, with the order A) above you can prevent
> duplicate MAC addresses from appearing in the system. In addition, if you want
> to fix it, it's dangerous to fuse the second MAC address at the customer's
> location, because if something goes wrong during the fusing, the device must
> be replaced on-site. This can also be avoided with order A).
If this is a special case, then please convert it into a common case, so 
the generic code upstream can be kept that, generic.

If this special case can not be converted to common case, then add local 
patch to handle that specific device.
