Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463CAD358F7
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 10:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DADC83B43;
	Thu, 29 Jan 2026 11:41:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="DMJaj90Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6842483EE2; Thu, 29 Jan 2026 11:41:32 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E407483B03
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 11:41:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 36F1A10E1CE; Thu, 29 Jan 2026 11:41:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1769683289;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=H41tTfe4ucyyppvJoK8OunU3gadpkOW+vsOxwSLn+T4=;
 b=DMJaj90ZuDFqPXkV43iECQ8K3RiXR2nWBfPHbbE8ZK63tPrXxCu4LK7LVp2taqBzKDzUj+
 R8bkul5f7RZdXTHWLUKJeZQCrObK0BmkjyuptMx/65DsNqr2RFWTP+IHUeOBQ/Vrl1CDrH
 DD7h9BY+0I5KL0pQEn3C8QfUtwC1+tTfC6YPOZgaCKvtsNHBk27RAmRfMBBa4mKBoj84Ml
 XeH21/H3RNr66usc9ZUdc8EgmLS+GT+Gr8zbhAcAxiwGV6lyz9/djBPOEUOWKc9O1JMEG8
 48QamJWiEeb1QS87l1SK9pW+Q1PIFbp2Wr7GFFwePuQTUbLwXz3N6QeBVFt9yw==
Message-ID: <7d9a3b43-7a6c-dc97-69ad-b71acd062538@nabladev.com>
Date: Thu, 29 Jan 2026 11:41:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 0/2] fastboot: mmc: fix bootloader offset
Content-Language: en-US
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>,
 Dmitrii Merkurev <dimorinny@google.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
References: <20260124054712.7939-1-hs@nabladev.com> <87y0lkogbt.fsf@kernel.org>
 <e7917bc9-11b1-18d0-1f04-9d6af003c1cd@nabladev.com>
 <875x8kohmf.fsf@kernel.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <875x8kohmf.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Mattijs,

On 29.01.26 11:09, Mattijs Korpershoek wrote:
> On Mon, Jan 26, 2026 at 16:46, Heiko Schocher <hs@nabladev.com> wrote:
> 
>> Hello Mattijs,
>>
>> On 26.01.26 10:48, Mattijs Korpershoek wrote:
>>> Hi Heiko,
>>>
>>> Thank you for the patch.
>>
>> You are welcome!
>>
>>>
>>> On Sat, Jan 24, 2026 at 06:47, Heiko Schocher <hs@nabladev.com> wrote:
>>>
>>>> Not for all SoCs the bootloader start at offset 0x0,
>>>> in a hardware partition of an emmc. So we need the possibility to
>>>> set the correct offset, where bootloader starts.
>>>>
>>>> Example:
>>>>
>>>> imx8qxp revision C0 emmc Partition layout
>>>>
>>>> | eMMC block / partition | Offset     | Size  | Purpose                        |
>>>> | ---------------------- | ---------- | ----- | ------------------------------ |
>>>> | /dev/mmcblk0boot0      | 0x0        | 2MB   | imx-boot-container A           |
>>>> |                        | 0x00220000 | 128kB | secure boot signature rootfs A |
>>>> | /dev/mmcblk0boot1      | 0x0        | 2MB   | imx-boot-container B           |
>>>> |                        | 0x00200000 | 8kB   | U-Boot env 0                   |
>>>> |                        | 0x00202000 | 8kB   | U-Boot env 1                   |
>>>> |                        | 0x00220000 | 128kB | secure boot signature rootfs B |
>>>>
>>>> imx8qxp rev B0 emmc Partition layout
>>>>
>>>> | eMMC block / partition | Offset     | Size  | Purpose                        |
>>>> | ---------------------- | ---------- | ----- | ------------------------------ |
>>>> | /dev/mmcblk0boot0      | 0x00008000 | 2MB   | imx-boot-container A           |
>>>> |                        | 0x00220000 | 128kB | secure boot signature rootfs A |
>>>> | /dev/mmcblk0boot1      | 0x0        | 8kB   | U-Boot env 0                   |
>>>> |                        | 0x00002000 | 8kB   | U-Boot env 1                   |
>>>> |                        | 0x00008000 | 2MB   | imx-boot-container B           |
>>>>
>>>
>>> Why can't we use raw partition descriptors for this?
>>>
>>> See:
>>> https://docs.u-boot.org/en/latest/android/fastboot.html#raw-partition-descriptors
>>
>> Thanks for this hint!
>>
>> Possible yes ( I must try)... but this will lead in adding
>> complexity to scripts people use all over there and needs
>> to adapt CI setups, as siemens has B0 and C0 variants.
> 
> If you try, please let me know.

I am sorry, did not find time yet... sorry.

> Do the same boards (as in U-Boot board definition) have multiple SoC
> variants (B0 and C0) ?

Yes there is the capricorn board in U-Boot and it have different
variants (not all mainlined yet) with B0 and C0 variants...
number of boardvariants grown over the years, started even with A0 SoCs
(IIRC)...

> In that case I understand it's a pain to add more script complexity.

It is. and U-Boot could easily detect the SoC revision... and it is
fix ... so no need for having this configurable and making mistakes...

>> If we introduce this series, user has nothing to know about
>> offsets for different CPU modules as no change in API for
>> them...
> 
> I understand, and I do like this approach as well. I just don't like
> having 2 code paths/approaches for the "same thing".

Hmm... understandable...

> 
> I am not saying that this is a NAK, but i'd like to iterate a bit to see
> if we can either deprecated raw partition descriptors (and migrate
> existing boards) or use that everywhere.

No idea if this is possible for all boards?

May user want to write "some data" to an offset... which is not
SoC/board dependent...

"flash bootloader" is well defined -> flash the bootloader, so I argue
that this should simply burn the bootloader to the correct offset...

"raw" interface -> do what you think you need write to wherever you want...

> I will try to use this series on VIM3 to see how it behaves. It will
> take some time though.

VIM3 ? Is this a imx8qxp based hardware?

Thanks for your time!

bye,
Heiko
> 
> Thanks
> Mattijs
> 
>>
>> bye,
>> Heiko
>> -- 
>> Nabla Software Engineering
>> HRB 40522 Augsburg
>> Phone: +49 821 45592596
>> E-Mail: office@nabladev.com
>> Geschäftsführer : Stefano Babic

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
