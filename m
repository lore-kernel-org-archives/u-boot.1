Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E756BC36005
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 01:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 299C0810E8;
	Wed, 26 Mar 2025 02:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jAz3UPRF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56FD18186D; Wed, 26 Mar 2025 02:37:09 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35A528083E
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 02:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZMqCP0qSpz9sWN;
 Wed, 26 Mar 2025 02:37:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742953025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6imv3macZbWQ0xzLbu9HW9i2YMD7z/f2SB5gxCu82bM=;
 b=jAz3UPRF0h3XtzuGpdA9XrJ/g4RTebaeVN3D8Pkw5rAC8cqQws44hGto9tdtPeWwFJgpzR
 3h0ZGLiYtk2s6U4U7l/pITruae5hfLbSb8f+Ks5S4dRq5qRjuXH9XjT502/aWimFaJjj4S
 gofIQqyEg6v2YvJZjVAeNpNVmgS740VMyT8ca0SF95wTkny8wGx0WfAlGey2A2olgDwhIL
 68IzRUNDTWIqQ0X3VZXZZW/Gnf+t374KEdKgZd24kAak96VNYqQaGjMR72D+hla37arjfG
 0SC9tsNcpss4Cp8VQp+L6wAP7gDR1uI56jyOejguSeMafhmTFwX8EKSE4Q7HvA==
Message-ID: <d576535e-f8d0-4ae7-b8b7-f4316535a6ee@mailbox.org>
Date: Wed, 26 Mar 2025 02:37:03 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 4/8] env: Rename SYS_MMC_ENV_DEV to ENV_SDMMC_DEVICE_INDEX
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
 <20250322215624.18994-4-marek.vasut+renesas@mailbox.org>
 <90254a96-5d67-4d34-afe6-772af42ee557@cherry.de>
 <e385568e-59b1-4adf-9fb7-d87b4254eae9@mailbox.org>
 <20250326001521.GN93000@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250326001521.GN93000@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e6d6c3417d78332ed00
X-MBO-RS-META: yqk883z48skujfpey9un3aid478tcqek
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

On 3/26/25 1:15 AM, Tom Rini wrote:
> On Wed, Mar 26, 2025 at 12:02:08AM +0100, Marek Vasut wrote:
>> On 3/24/25 1:39 PM, Quentin Schulz wrote:
>>> Hi Marek,
>>
>> Hi,
>>
>>> On 3/22/25 10:55 PM, Marek Vasut wrote:
>>>> Rename the variable and add ENV_ prefix, so that all configuration
>>>> options which are related to environment would have an CONFIG_ENV_
>>>> prefix. No functional change.
>>>>
>>>> Use ENV_SDMMC_DEVICE_INDEX to clarify this is the SD/MMC device
>>>> index, a number, as enumerated by U-Boot. Update the help text
>>>> accordingly.
>>>>
>>>
>>> I disagree with this part of the rename (MMC->SDMMC), our drivers all
>>> are using mmc (env/mmc.*, drivers/mmc/*, cmd/mmc.c, ...) for both SD and
>>> MMC. We also have ENV_IS_IN_MMC which is for both. I don't think it's
>>> worth the confusion.
>>
>> My main problem is, that it is confusing to call everything _mmc_ even if
>> most of it also applies to SD . There is no way to discern parts which are
>> MMC specific from parts which are common to SD and MMC now.
> 
> Do we have support for anything using the MMC part of the standard that
> is not storage? I certainly agree it's confusingly named atm, but I
> think changing some parts but not other parts will make it worse, not
> better.
That's not what I am concerned about. What I am concerned about is that 
we are talking about partitions, and only eMMC supports HW partitions, 
but both SD and MMC support SW partitions . So we should refer to 
CONFIG_..._SDMMC_..._SW_PARTITION here when talking about SW partitions 
, but CONFIG_..._MMC_..._HW_PARTITION when talking about eMMC HW 
partitions. Currently we are missing the two and it yields a horrid 
confusion. That is in fact what prompted this series.
