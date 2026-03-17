Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A1FFF6E87
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 22:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE2638419E;
	Tue, 17 Mar 2026 23:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="BIvOmF4y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CE0F842A4; Tue, 17 Mar 2026 18:25:29 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D00E84201
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 18:25:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 22FD210DDB8; Tue, 17 Mar 2026 18:25:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1773768327;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=HVhTqnT1yKseVnyOCzxk4GlIc8jt1B/qTjK0noFxPv8=;
 b=BIvOmF4y/xGg/0icFN9X3wKYfMfkxXmjvU6a8UStVkJx6gdcwqHcxSn/UBkBAM5NqO6ySG
 /e0LRdR/A9RioaVgtvXDFBIsi4MJzQ7nvPOqNaRpBYoJAsZ1Mamxi3onnBxRL+LW/P7mAH
 KLGm0424Atm0W7v9a066+nPGJbVSrQFF5P/K8lwdl/waO+AxrKBpMARdgqSG76UKCpoUoq
 HiTJAzcZqbZU9hGMwqgjm7TWqVThly8zxSXUSsukceEr0BkciIX7ZwfK9CrPm1gv5K6Xd8
 awGB18wvqbyKo5T9OsfOjq5+uVvEERTTQhi8jPJNSt/k2d0Sf5xvMUNa3iJHig==
Message-ID: <541a05c0-e0f0-43ce-b944-d7656da585e1@nabladev.com>
Date: Tue, 17 Mar 2026 18:10:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] doc: board: nxp: Add Quickboot documentation
To: Simona Toaca <simona.toaca@oss.nxp.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com,
 viorel.suman@nxp.com, ping.bai@nxp.com, sebastien.szymanski@armadeus.com,
 ravi@prevas.dk, joao.goncalves@toradex.com, ji.luo@nxp.com,
 tharvey@gateworks.com, qijian.guo@nxp.com
References: <cover.1773648510.git.simona.toaca@nxp.com>
 <be6b07edb38e4e0dc86e65f8bac7b6b3b0e29d01.1773648510.git.simona.toaca@nxp.com>
 <d3b42af1-65a8-401f-9dda-1f79cb0dde9a@nabladev.com>
 <yuwvhik6p6eordghidde6l4ey6fclwwuxnzuqpttcoicxqa2r4@jpp2t42tl2wx>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <yuwvhik6p6eordghidde6l4ey6fclwwuxnzuqpttcoicxqa2r4@jpp2t42tl2wx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 17 Mar 2026 23:04:49 +0100
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

On 3/17/26 1:53 PM, Simona Toaca wrote:
> On Mon, Mar 16, 2026 at 01:32:48PM +0100, Marek Vasut wrote:
>> On 3/16/26 9:15 AM, Simona Toaca (OSS) wrote:
>>
>>> +After successful saving, U-Boot clears the data in volatile memory so
>>> +that qb check fails at next reboot and the NVM isn't accessed again.
>>> +
>>> +There are 2 ways to save this data (both can be enabled):
>>
>> Replace () with , .
>>
>>> +1. automatically, in SPL (by enabling CONFIG_SPL_IMX_QB)
>>> +
>>> +- this will save the data on the current boot device (e.g. SD)
>>> +- other configs specific to the boot device need to be enabled (CONFIG_SPL_MMC_WRITE for saving to eMMC/SD)
>>> +- use for: automating qb save / saving qb data if using Falcon mode (skipping U-Boot proper)
>>> +
>>> +2. using qb command in U-Boot console (by enabling CONFIG_CMD_IMX_QB)
>>> +
>>> +- supports saving on the current boot device, or on another, specified device.
>>> +- if flashing via uuu, the command can be added in an uuu script (boot device needs to be specified)
>>> +- use for: saving the qb data during flashing / controlling the NVM to save to
>>> +
>>> +::
>>> +
>>> +        # To save/erase on current boot device
>>> +        => qb save/erase
>>> +
>>> +        # To save/erase on other boot device
>>> +        => qb save/erase mmc 0 # eMMC
>>> +        => qb save/erase mmc 1 # SD
>>> +        => qb save/erase spi   # NOR SPI
>>
>> Can QB data be saved to arbitrary SPI NOR ?
>>
> 
> No, this SPI NOR refers to the SPI controller selected by
> the CONFIG_SF_DEFAULT_BUS and CONFIG_SF_DEFAULT_CS options.

Maybe the user would want to make a backup of the QB data to another SPI 
NOR (e.g. if the device has two, which is not unheard of) ? They should 
not be prevented from doing so.

> The point is that the device we save the data to is also an
> option to boot from, otherwise the qb data is useless.

The QB data could be stored for backup purposes, that is not useless.

> And the
> board will boot from the selected configs if one boots from spi.
Please see above.

>> Looking at this, why can this QB not use the same interface to select
>> arbitrary block storage device/partition/... that e.g. FS_GENERIC does use ?
> 
> There is a limited list of boot devices. By keeping things the way they are
> we limit the usage of this command to the actually useful boot devices (and
> that we also test this command on).

I would argue that it is better to use generic code instead of 
hand-writing local ad-hoc implementation which is a limited version of 
the same.
