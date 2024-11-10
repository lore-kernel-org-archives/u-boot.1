Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666DED12D4A
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 16:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 958E5881E7;
	Sun, 10 Nov 2024 17:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731256953;
	bh=w9Rby4Tf8VDOtbYxe39lAIg18HLHzAqmidOyZFyXeQY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kn8Lqila26C/BWtXA3VhTJyNKCjtMPXQe9kCybG0ZQJUbaDAyZSG/jFbOP28Ey0n8
	 bH71kHvB+WD48bE5BN0fac5b24lgJ1hsOBi9EmppjMUh61VfMHTtA7nigsXnL38AhM
	 uHSuAC4EpDiyyYP0cAuyiMUmYm9446GzyXJFZy4RrTpeSPXiR24oSJbfukE0ke/9ij
	 pV5WbXOTdH/PZUh8wR6wfd389xWo03SQjgcu4mnxBZBA2bZLXSI70ykyhgulsJRsBy
	 Cocf3LPw71UBCzjj0I8lDUHMjOqN7zNT8tdYkKgxAqPvlkhY/2WXdhgp45O7D6RTSF
	 L0I7zrVDJ4ZpQ==
Received: from [127.0.0.1] (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6BA1680245;
 Sun, 10 Nov 2024 17:42:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731256952;
 bh=w9Rby4Tf8VDOtbYxe39lAIg18HLHzAqmidOyZFyXeQY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rLxwsBHAa+OYUP8ht2vKewqVfo6JitljNOGY3l9mCRj+/T3awGLy/CYsBaHM4QyFy
 Fx5HQ5A6ZU7xHYWlnvRarNb9fTbqM38/m+bkCtEAL2RbSoZdKiX7gey14kW1HMAtW4
 LzMUiFzAzhV8wZORCiGUtaif8VgjEPzYUjJgQLx/Oapyyl9pRgCYSo6e12wqotY6qY
 AwA/2qTBDyh/j3Dz7DxMngmoRCw/f7ZYWK34lRyQmS1HkyE/IHQgBEpt+caap6gmFG
 Oq1JzK2n3XwZtQtdu8g4gEUZMdgojXLvn0iwqA7gtGZq5LstgYF7asXQOzoemu+NvG
 DV7WL+sh0sfdw==
Message-ID: <187dd32c-642e-4595-a90f-4213fd68f6cc@denx.de>
Date: Sun, 10 Nov 2024 17:33:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: imx8mn: Fix FSPI booting
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, lukma@denx.de,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20241109200610.1615430-1-aford173@gmail.com>
 <20241109200610.1615430-2-aford173@gmail.com>
 <690f6e55-ac68-4ef6-aeda-1f36a36e9a32@denx.de>
 <CAHCN7xL84i08BhBVBEPZgwPtaj9QFirNpb1k5HpmTwnMttV9LA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAHCN7xL84i08BhBVBEPZgwPtaj9QFirNpb1k5HpmTwnMttV9LA@mail.gmail.com>
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

On 11/10/24 2:15 PM, Adam Ford wrote:
> On Sat, Nov 9, 2024 at 7:34 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 11/9/24 9:06 PM, Adam Ford wrote:
>>> When FSPI_CONF_HEADER is set, the binary needs to be built such
>>> that there is a configuration file located at 0x400 and the start
>>> of the file that would normally be flash.bin starts at 0x1000.
>>> This used to be done properly until the device tree was converted to
>>> nxp_imx8mimage.
>>>
>>> Building these with the offsets built into the binman device tree
>>> changes impacts how the actual image is built and the locations
>>> of the various blobs aren't fetched properly and booting fails.
>>>
>>> Fix this by building a standard image as if it were to boot from
>>> eMMC or SD, then use that image as the input for a second image
>>
>> This seems like a workaround for some broken offset calculation in binman ?
> 
> This used to work until it was migrated to nxp_imx8mimage.
> The blobs appear to be at the proper offsets, but the contents of
> what's stored at those offsets are not the same.

I know, this is what Lukasz reported too.

> If you're going to claim there is a bug somewhere, I would argue that
> it's somewhere i nxp_imx8mimage

I agree with that claim. Well, by extension, the problem might also be 
in binman itself.

>.  However, if you look at this series,
> the added benefit is the ability for Nano to be able to build both a
> SD/eMMC image and FSPI images with one config which allows for the
> elimination of extra defconfig files.  I am guessing Plus would have a
> similar benefit since they have similar bootloaders.
This I do not agree with. If the intent is to generate two images, then 
there should be two full binman descriptors, one for each image (one for 
flash-plain.bin and one for flash-fspi.bin or some such naming).

Can you try and fix the FSPI generation first, so an FSPI compatible 
flash.bin can be generated using binman only, without the dependency on 
processing non-FSPI compatible flash.bin ? I think the intention of 
binman was to replace all that ad-hoc pre/postprocessing of blobs.
