Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020C5C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 11:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2898E86DE0;
	Fri, 17 Nov 2023 12:58:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Kz/yFg8k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A546B87056; Fri, 17 Nov 2023 12:58:50 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 775C186D9A
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 12:58:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [100.94.55.57] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 318206607380;
 Fri, 17 Nov 2023 11:58:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1700222319;
 bh=EKeoB6ehwq6TqB7tHVgPaejzXWRqhGYrGLBuEYV46uU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Kz/yFg8klx3DYr5yFh3TcUPaUe9cnHIvi9G6/AmJScxbplmz20RBssUUbrDx+V0FD
 Mu1iqGed0uNAsIHzkm4b96mQpxsbZmZPqXUdFwc7gzuMjh9VKy992eAixy0VwHiyJr
 n9HNuqRAUbxcFYK1OXU+ldRIukCDWe4dAs0zVRAjFy66iRc4VMlqbPoCAFHgXAhBPL
 OiSV7hYGYfAtLwUB1IBWzg+Z7wshWReac0uNzReiuOICXL4c/DNIQM0ztsWgSQqwnA
 U9ukb3CIzvb6V5eSdyGsJmm8USrEfF44sfF26LJ1lbayEVpyZhH5TUhanaYGF+qqm+
 M+KOTELxauhPw==
Message-ID: <6133d5a4-9baf-486f-a595-59ce922964f9@collabora.com>
Date: Fri, 17 Nov 2023 13:58:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: Enable SYS_THUMB_BUILD on AT91
Content-Language: en-US
To: Mihai.Sain@microchip.com, trini@konsulko.com, seanga2@gmail.com
Cc: u-boot@lists.denx.de, Nicolas.Ferre@microchip.com,
 Aubin.Constans@microchip.com, Cristian.Birsan@microchip.com
References: <20231105022742.632175-1-seanga2@gmail.com>
 <20231116184702.GA344953@bill-the-cat>
 <4906942a-8140-4264-afaa-3072f2eaed98@collabora.com>
 <PH8PR11MB68049E01B9388C294E9DD10582B7A@PH8PR11MB6804.namprd11.prod.outlook.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <PH8PR11MB68049E01B9388C294E9DD10582B7A@PH8PR11MB6804.namprd11.prod.outlook.com>
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

On 11/17/23 11:15, Mihai.Sain@microchip.com wrote:
> Hi Eugen,
> 
> I built new binaries with CONFIG_SYS_THUMB_BUILD=y for sam9x60_curiosity, sama5d29_curiosity, sama7g5ek and new sam9x75_curiosity board.
> I used the latest u-boot/master branch for this test.
> I noticed that the file size of the binaries have beed reduced with aprox 150KiB due to CONFIG_SYS_THUMB_BUILD=y.
> After flashing the new binaries on these boards I can confirm that on all boards the linux kernel was booted properly from mmc, qspi-flash, nand-flash and usb.
> I tested using bootm and bootz commands.

Thank you Mihai,

Tom, Sean, are you okay with this going in the next merge window ?
It is definitely not a fix, so that would be the best.

Eugen

> 
> Best regards,
> Mihai Sain
> 
> --------------------------------------------------------------------
> 
> On 11/16/23 20:47, Tom Rini wrote:
>> On Sat, Nov 04, 2023 at 10:27:42PM -0400, Sean Anderson wrote:
>>
>>> Several AT91 boards are quite close to their SPL size limit. For
>>> example, sama5d27_wlsom1_ek_mmc is just 173 bytes short of its limit
>>> and doesn't even fit with older GCCs.
>>>
>>> All AT91 processors should have thumb support. Enable
>>> SYS_THUMB_BUILD. This shrinks SPL by around 30%.
>>>
>>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
>>> ---
>>> This has been BUILD TESTED ONLY!
>>
>> We in turn need this for Sean's other cleanup series to go in. Is this
>> OK? Would it be safer if it was only for CPU_V7A ? I do have
>> recollections of thumb being sometimes buggy prior to v7a cores. Thanks!
>>
> 
> Hi Tom,
> 
> I would like this to be tested on a few boards at least. There are boards with Cortex A5, A7 and ARM926 which are important, one of each of them and booting Linux should be enough I think.
> Nicolas, Aubin ? I remember you guys have also a CI tool that is fairly easy to use if you just push a branch/commit.
> 
> + Mihai as well.
> 
> Eugen

