Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49F9FC72A6
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 03:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D424283FE1;
	Sun, 22 Mar 2026 04:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="AiUoIBYc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87B7E83E48; Sun, 22 Mar 2026 04:44:00 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27A3883F9B
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 04:43:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fdhx837h5z9tWG;
 Sun, 22 Mar 2026 04:43:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774151036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vGdybmGNZGgdRyqvhDMy55lTcLHtl+rIXEpB2JUcn48=;
 b=AiUoIBYclfOBqqync+Qf0xLnDn7n/vyk4CDZj8/E1wANdWOBshKGgqE079y0OcJjGLvs0y
 mhzW0ul7TgnwZYL6l4jtFdXKWfDGF/xnFzB0orCYaATjteIyIPxsTBzVXIuHlfhUmPsdHd
 fraxwEfX40ChhtOj9aOsJB85jDn2B7w43IP15XhDhXrUoXUhobkq3LBXfF/LOMuVQVlLoF
 4NmVBAD4+AByoYvVBFdM+uvYdJ7F2wHSJq9vbbXen//e4dexcDQyJhALrb2O5UqMeHYt2L
 UH+osLfHDPbSCPZenVKbXF1HauqHHMH1MqN/y9+88R3q9qrVJrV/vEfj+3nErw==
Message-ID: <a2705750-df08-4f6e-b86b-a214b71d1561@mailbox.org>
Date: Sat, 21 Mar 2026 19:52:18 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] reset: Correct dependencies for RESET_RZG2L_USBPHY_CTRL
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260317012443.4162600-1-trini@konsulko.com>
 <ed88ec35-7d53-48df-a65b-7da1298e265b@mailbox.org>
 <20260317134008.GQ502704@bill-the-cat>
 <58699be1-5414-4749-9975-7fdf0064b1a3@mailbox.org>
 <20260318012557.GF502704@bill-the-cat>
 <34a0c151-f8ff-4b91-92b3-d6f63097440e@mailbox.org>
 <20260319134128.GP502704@bill-the-cat>
 <11128ed2-a53d-4286-84cc-dc5c6d932405@mailbox.org>
 <20260320135616.GY502704@bill-the-cat>
 <2446be00-c67d-4dd7-b45c-da3925b23cd0@mailbox.org>
 <20260321171030.GF502704@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260321171030.GF502704@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d5a5bc053711939da73
X-MBO-RS-META: qrm3bjznxx19wzwpeq6i5bbdw7jar6pr
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

On 3/21/26 6:10 PM, Tom Rini wrote:
> On Sat, Mar 21, 2026 at 03:23:35AM +0100, Marek Vasut wrote:
>> On 3/20/26 2:56 PM, Tom Rini wrote:
>>> On Fri, Mar 20, 2026 at 04:58:13AM +0100, Marek Vasut wrote:
>>>> On 3/19/26 2:41 PM, Tom Rini wrote:
>>>>
>>>> [...]
>>>>
>>>>>>> So I think the answer is if you fire up menuconfig, and turn off
>>>>>>> RESET_RZG2L_USBPHY_CTRL and REGULATOR_RZG2L_USBPHY and DM_REGULATOR and
>>>>>>> then enable RESET_RZG2L_USBPHY_CTRL things will become mad because
>>>>>>> RESET_RZG2L_USBPHY_CTRL has select'd REGULATOR_RZG2L_USBPHY but we don't
>>>>>>> have DM_REGULATOR.
>>>>>> How is it possible to enable RESET_RZG2L_USBPHY_CTRL without enabling its
>>>>>> dependencies ? This is what I do not understand.
>>>>>
>>>>> The way I said in the part you quoted? If you don't like the way I'm
>>>>> solving the problem with the dependency graph here please propose an
>>>>> alternate. But it is possible to encounter this problem, or randconfig
>>>>> wouldn't expose it.
>>>> What I do not understand is, how is it possible to enable Kconfig symbol
>>>> without enabling its dependencies. Is that a bug in Kconfig ?
>>>
>>> There is nothing ensuring that when you enable RESET_RZG2L_USBPHY_CTRL
>>> today that DM_REGULATOR is enabled. But since you're telling it to
>>> select REGULATOR_RZG2L_USBPHY it then will give an error.
>> Hmmm, I see it now. If I have both CONFIG_REGULATOR_RZG2L_USBPHY=y and
>> CONFIG_RESET_RZG2L_USBPHY_CTRL=y in .config, and I delete
>> CONFIG_DM_REGULATOR=y from .config , then I can select CONFIG_DM_REGULATOR=n
>> .
> 
> Right.
> 
>> But isn't the right fix the elimination of 'select' ? Linux Kconfig
>> documentation now hints that 'select' should only be used for hidden
> 
> As a much longer term goal, yes, this is largely where we should go. But
> we're still at the point where I'm catching these kind of dependency
> issues in the Kconfig side of things, let alone build time problems.
> 
>> symbols. So how about this fix instead , that should retain the transitive
>> dependency on REGULATOR_RZG2L_USBPHY , which depends on DM_REGULATOR :
>>
>> "
>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> index 2fd91d6299c..a7acd5cfa69 100644
>> --- a/drivers/reset/Kconfig
>> +++ b/drivers/reset/Kconfig
>> @@ -239,8 +239,7 @@ config RESET_AT91
>>
>>   config RESET_RZG2L_USBPHY_CTRL
>>          bool "Enable support for Renesas RZ/G2L USB 2.0 PHY control"
>> -       depends on DM_RESET
>> -       select REGULATOR_RZG2L_USBPHY
>> +       depends on DM_RESET && REGULATOR_RZG2L_USBPHY
>>          help
>>            Enable support for controlling USB 2.0 PHY resets on the Renesas
>>            RZ/G2L SoC. This is required for USB 2.0 functionality to work on
> 
> This is fine too, yes
Excellent, can you please do a V2 ? I'll RB it then.

Thank you !
