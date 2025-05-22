Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72038C54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 06:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DA5282E31;
	Thu, 22 May 2025 08:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BDrpG6hS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF3B803DF; Thu, 22 May 2025 08:58:25 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E400882E28
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 08:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5D24A5C5578;
 Thu, 22 May 2025 06:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC698C4CEEA;
 Thu, 22 May 2025 06:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747897101;
 bh=+MyixZPs5ZUIdHXTQ6cKzvvopD7Eyvp48ufQvRUZgwk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=BDrpG6hS56ERqs0y0+8tVC/a5cWZ0vYWx6CQPQFHjLJeR/Aabmjo+uxB2H6ItVzm4
 qkVDTCCRMuzx+kubW2EZGPh3LdKKDAadNXqwr3xJgtSmJNRjhRkDTa5NdYGQXtpCEI
 H7DgzecDfOE6OpE05Lwe4dW/CDcL9GbnXfHhajCdwtDvZUGlLTDpSveCNMpgC+1Pye
 Uoh1Wtdm3DLBDNWN6aDDtkiP4uaQHdqM/NNWZPccKp9KBdRLqBRTv2d2D8gaPHrA34
 +72JvA4kQSTR9hEyZ9uNBrD/eEGHv339jAESE+WUBFgiUi/0aucrV7I1yQ4Ey4asCt
 58TnFzXhmlhsg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 neil.armstrong@linaro.org, u-boot@lists.denx.de, Dmitrii Merkurev
 <dimorinny@google.com>
Subject: Re: [PATCH RFT v3 0/3] fastboot: add support for generic block
 flashing
In-Reply-To: <20250521190347.GF100073@bill-the-cat>
References: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
 <174774092427.332438.8643753165301653831.b4-ty@kernel.org>
 <87zff6nhmo.fsf@kernel.org> <20250521151236.GC100073@bill-the-cat>
 <87wma9okxy.fsf@kernel.org> <20250521190347.GF100073@bill-the-cat>
Date: Thu, 22 May 2025 08:58:18 +0200
Message-ID: <87a575gmid.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

On mer., mai 21, 2025 at 13:03, Tom Rini <trini@konsulko.com> wrote:

> On Wed, May 21, 2025 at 08:52:41PM +0200, Mattijs Korpershoek wrote:
>> Hi Tom,
>> 
>> On mer., mai 21, 2025 at 09:12, Tom Rini <trini@konsulko.com> wrote:
>> 
>> > On Wed, May 21, 2025 at 04:49:35PM +0200, Mattijs Korpershoek wrote:
>> >> Hi Neil,
>> >> 
>> >> On mar., mai 20, 2025 at 13:35, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
>> >> 
>> >> > Hi,
>> >> >
>> >> > On Tue, 06 May 2025 18:10:06 +0200, neil.armstrong@linaro.org wrote:
>> >> >> This serie permits using any block device as target
>> >> >> for fastboot by moving the generic block logic into
>> >> >> a common set of helpers and also use them as generic
>> >> >> backend.
>> >> >> 
>> >> >> The erase logic has been extended to support software
>> >> >> erase since only 2 block drivers exposes the erase
>> >> >> operation.
>> >> >> 
>> >> >> [...]
>> >> >
>> >> > Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
>> >> >
>> >> > [1/3] fastboot: blk: introduce fastboot block flashing support
>> >> >       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/88239b5bb04bea2b58f7bf4c3ea72cf832de818c
>> >> > [2/3] fastboot: blk: switch emmc to use the block helpers
>> >> >       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/25ab5c32c28b9f25fb193f726f239d75af3c365a
>> >> > [3/3] fastboot: integrate block flashing back-end
>> >> >       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a885bd8c969e25d03bf406207d89b1145c9490fb
>> >> 
>> >> It seems this series cause CI to fail:
>> >> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/26238
>> >> 
>> >> Without the patches applied, it passes:
>> >> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/26235
>> >> 
>> >> Do you have any idea what is going wrong?
>> >> I could not find anything obvious by skimming through the logs.
>> >
>> > It's a Kconfig problem then. Some platform is prompting for a value (not
>> > a y/n) and there's no default.
>> 
>> You are correct. Thank you for the suggestion.
>> 
>> I've applied the following diff to 3/3:
>> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>> index 68967abb751e..fdf34a6abe1e 100644
>> --- a/drivers/fastboot/Kconfig
>> +++ b/drivers/fastboot/Kconfig
>> @@ -200,6 +200,7 @@ config FASTBOOT_MMC_USER_NAME
>>  config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
>>         string "Define FASTBOOT block interface name"
>>         depends on FASTBOOT_FLASH_BLOCK
>> +       default "none"
>>         help
>>           The fastboot "flash" and "erase" commands support operations
>>           on any Block device, this should specify the block device name
>
> Assuming that the code will see "none" and handle the error correctly,
> OK. But we really should have a configured true value here, yes?

The code does not handle any special cases.
If FASTBOOT_FLASH_BLOCK_INTERFACE_NAME is "none", we will call:

blk_get_dev("none", 0);

Which will then be handled via:

	if (!dev_desc) {
		fastboot_fail("no such device", response);
		return -ENODEV;
	}

>
>> @@ -212,6 +213,7 @@ config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
>>  config FASTBOOT_FLASH_BLOCK_DEVICE_ID
>>         int "Define FASTBOOT block device identifier"
>>         depends on FASTBOOT_FLASH_BLOCK
>> +       default 0
>>         help
>>           The fastboot "flash" and "erase" commands support operations
>>           on any Block device, this should specify the block device
>
> I do not like this at first. If FASTBOOT_FLASH_BLOCK_DEVICE_ID is set,
> there should be a valid ID set too yes? Potentially worse, is 0 a valid
> option here? If so, is that likely to be a real and common one? In that

Yes, 0 is a valid option here. Think of this symbol as a similar one to
FASTBOOT_FLASH_MMC_DEV however it's for generic block device type
(virtio, scsi, ...)

I'd think that 0 is typically the most common value, since it's the
first block controller of a specific type.

> case, we should also be updating the help text to make sure it's clear
> what the normal range is I think.

Ok. That's a bit too much for me to do in a fixup.

Neil, can you send a v4?

>
> -- 
> Tom
