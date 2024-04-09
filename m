Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161EACD128A
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 19:28:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D41B8799C;
	Tue,  9 Apr 2024 21:28:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="ZjEYxCH5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D82F687E86; Tue,  9 Apr 2024 21:28:16 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D974E870D2
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 21:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1712690894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ueyHQXfYbBF74wkB495rFYTVGnCNAyXLUGYxMeyCv84=;
 b=ZjEYxCH5lew5Hl7GnnY4oTRWyZtsZ2YMDyM8rBL3MyGDtu4Sqp8XD4RsDAo8QHOhnHgh5o
 5WCXHKW20smEq3wobU7b2TRQBy/QqOMYJ3sqIMQh0A+LO66KcqnCdvWPuL+suEaj8W9nO2
 4JC+eCli7sUldWzOJs+Vdbg04ydcxINCnVQ2zoNPWBkwox0jXj0jbNnri3ZwNbIsyNmq89
 lF7IxJkqA5Py17n4y2olNnRCBRKLyMpTojwP/JFpBUyV5HGKw4liiifNJUvj38T3ujMn6S
 03uAwDDT6EuVsd2iXHdwhjjapV1DnYbfu3TaiiCb5QDwDxJ5elXO+CN+Nvskpg==
Date: Tue, 09 Apr 2024 21:28:14 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Peng Fan <peng.fan@nxp.com>, Jaehoon
 Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] mmc: Imply HS200 cap with mmc-hs400 prop to match
 linux
In-Reply-To: <ac394528-ca53-41d5-8c4c-7c10943a7c92@theobroma-systems.com>
References: <20240408210619.3749231-1-jonas@kwiboo.se>
 <496013c1-7a57-4d12-bf31-c5257f35ee8c@theobroma-systems.com>
 <3b2643b4-dea7-43cd-9f9c-da63e6588281@kwiboo.se>
 <ac394528-ca53-41d5-8c4c-7c10943a7c92@theobroma-systems.com>
Message-ID: <9b62bbedf2c6d52b76a8ce1ce57dd35d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Quentin,

On 2024-04-09 18:02, Quentin Schulz wrote:
> On 4/9/24 17:58, Jonas Karlman wrote:
>> On 2024-04-09 17:27, Quentin Schulz wrote:
>>> On 4/8/24 23:06, Jonas Karlman wrote:
>>>> eMMC nodes in linux device tree files typically only contain a 
>>>> mmc-hs400
>>>> prop to signal support for both HS400 and HS200. However, U-Boot 
>>>> require
>>>> an explicit mmc-hs200 prop to signal support for the HS200 mode.
>>>>   > Fix this by follow linux and imply HS200 cap when HS400 cap is 
>>>> signaled
>>>> using a mmc-hs400 prop.
>>> 
>>> Technically speaking, the DT binding should be the one and only 
>>> source
>>> of truth and should be implementation-agnostic.
>>> 
>>> There it says:
>>> """
>>>     mmc-hs400-1_2v:
>>>       $ref: /schemas/types.yaml#/definitions/flag
>>>       description:
>>>         eMMC HS400 mode (1.2V I/O) is supported.
>>> 
>>>     mmc-hs400-1_8v:
>>>       $ref: /schemas/types.yaml#/definitions/flag
>>>       description:
>>>         eMMC HS400 mode (1.8V I/O) is supported.
>>> """
>>> 
>>> So I'd say, the DTs should be fixed to add mmc-hs200 as well wherever 
>>> it
>>> makes sense.

Good point, but I think that the descriptions in this Linux kernel
binding should be fixed instead, to eliminate this ambiguity.  I'll
explain this further below.

>>> The point of the DT/DT binding is to be system-agnostic and
>>> representative of the **HW** implementation. At least that's what the 
>>> DT
>>> people want it to be.
>>> 
>>> If the eMMC standard doesn't allow to have HS400 without HS200, then 
>>> I
>>> think this change is acceptable as is, because it is the reality of 
>>> the
>>> HW standard. Couldn't find this implied in the standard though (but I
>>> just skimmed through).
>>> 
>>> It's also quite surprising, as it's not because the eMMC works with
>>> HS400 that it necessarily does with HS200 or that it's desired (EMI,
>>> signal integrity/stability, etc...)?
>>> 
>>> Now, it wouldn't be the first time U-Boot follows whatever is done in
>>> Linux, so... up to you/the maintainers :)
>> 
>> Agree that implying HS200 does not fully make sense, however it was 
>> part
>> of the original Linux binding when HS400 was added in v3.16-rc1 [1] so 
>> I
>> think that this is the expected behavior and changing it may be an ABI
>> breakage.
> 
> I'm not advocating undoing the kernel "hack", but rather make it so
> that we add hs200 to DTs where it's actually supported instead of
> doing the same hack the kernel does. In that case, we wouldn't need
> the hack anymore.
> 
> (well maybe it isn't a hack per-se, but for lack of more info on that,
> I call the kernel implementation this :) )

Let's keep in mind that the troublesome DT properties describe the
capabilities of the MMC controller and the board, not the capabilities
of the MMC storage device.  As we know, eMMC devices provide automatic
detection capabilities, to allow the host to determine its supported
modes, and match them with the ones the host is configured to support.
It's all described in the JEDEC standards.

Having that in mind, I find the approach in the Linux kernel rather
reasonable, because I highly doubt that some MMC controllers support,
for example, HS400 without supporting DDR52, or HS400 without supporting
DDR52.  A reasonable approach for an MMC IP block is to make it capable
of supporting all the speeds below its highest supported speed, to make
itself capable of supporting more, if not all, MMC storage devices.

In fact, I'll probably go ahead and submit a Linux kernel patch that
updates the descriptions in the binding, to hopefully eliminate any
ambiguities like these.  I hope you agree.
