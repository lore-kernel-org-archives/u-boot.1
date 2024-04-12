Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07795C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 18:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A1C387ED3;
	Fri, 12 Apr 2024 20:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1712946381;
	bh=OORJlIY4ad/CcaDiqCOIPnoBKUr+zx8Ml2cQeW1Uxcw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XwpmvEjFTagYZ6sbJpeSgAi5YTTM2byjCsTqUzHKi6HCyoQF21wrlMsnlde8vxn8u
	 boagqxn1BZyzClrckg7OejvtCdOzNCnHV98RJt+YQm8G51q+rTl/UMVwWHd6xnDw5z
	 i8FJgpAJSFBCb8L51lsxA7RMG+qGT7de4J5l0ZX3Xuy/8ZPoGDVu+dt4jy6Uo7LPXE
	 WOBO+TpcB9EC4Ig+r/GZgDz/U2g9kwWQtcesQu45u8YNY0NYdfJKIRYa2xTJ2pWXK7
	 mNOOcFNxDjXqydGJI1UqmC+DpHPloRt0Ku47fdW77mwFtn4HPvEir4mpGDP4C8qGVy
	 cEdrsGp73AWEA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 40B5187DFF;
 Fri, 12 Apr 2024 20:26:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1712946379;
 bh=OORJlIY4ad/CcaDiqCOIPnoBKUr+zx8Ml2cQeW1Uxcw=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=JFO46zX9RHJLrDW3XOk87OcEwZJb7saeyF/dim2g+PwLzr9346lelUcdu8kSitVYB
 2awjO2FU6KXsptKqPZ052kgu4h4IAnqCg4DsXPvh01i62wdPQkr+Yur/GAX9Z+5hVZ
 q7dWj6JLwZAx8lp6G7/UjrIEwTwMAMIsxp+IDm+x7CSmP1iPyKLHqJJEhFwz6T3Rvd
 ee1PSZiQNqY/A0/mn1VIDrRGIBNgqNhH6URdMneeLi2/QuDTZcleYGR3wep4eMdjpp
 spw+ff9mUbqmPBsePsgR0CE+8+fs7cyd/w7DKCpP0Y3nC33IjCbYhcAwgBNvyK79nc
 CyFopyz3xKqeg==
Message-ID: <d65ea7c0-cb89-4cb9-8378-11839a6ee63e@denx.de>
Date: Fri, 12 Apr 2024 20:26:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] USB keyboard improvements for asahi / desktop
 systems
From: Marek Vasut <marex@denx.de>
To: Janne Grunau <j@jannau.net>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 u-boot@lists.denx.de, asahi@lists.linux.dev, Neal Gompa <neal@gompa.dev>
References: <20240404-asahi-keyboards-v4-0-2266033feaff@jannau.net>
 <356b892a-a681-4ae0-a6c8-ed1b4b5a8717@denx.de> <ZhBLfQfxB_UEwvyY@robin>
 <5467f380-de35-4776-8c32-90b8e08aeda7@denx.de> <ZhGq0U_pkrYMe4S1@robin>
 <5ed4e6d2-edc7-461d-8183-e91d7b994aa5@denx.de> <ZhOg81sBEDLgCSIa@robin>
 <83e48e51-f88d-49d4-bcf9-340e229fdf76@denx.de>
Content-Language: en-US
In-Reply-To: <83e48e51-f88d-49d4-bcf9-340e229fdf76@denx.de>
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

On 4/12/24 2:53 PM, Marek Vasut wrote:

Hi,

>> Seems to work here with a broken imx8 config from the CI. Is it ok to
>> rely on dead code elimination? Apparently it is, build with KCFLAGS=-O0
>> has already several other missing symbols.
>>
>> See attached fixup
> 
> Thanks, squashed, let's see how CI likes this.

I think we are getting closer, but still ...

Pipeline #20308 has failed!

Project: USB U-Boot Custodian Tree ( 
https://source.denx.de/u-boot/custodians/u-boot-usb )
Branch: master ( 
https://source.denx.de/u-boot/custodians/u-boot-usb/-/commits/master )

Commit: 63f6a449 ( 
https://source.denx.de/u-boot/custodians/u-boot-usb/-/commit/63f6a449bffe46beca89580d3efa48e5d041025c 
)
Commit Message: usb: kbd: Add probe quirk for Apple and Keychro...
Commit Author: Janne Grunau
Committed by: Marek Vasut ( https://source.denx.de/marex )


Pipeline #20308 ( 
https://source.denx.de/u-boot/custodians/u-boot-usb/-/pipelines/20308 ) 
triggered by Marek Vasut ( https://source.denx.de/marex )
had 1 failed job.

Job #815411 ( 
https://source.denx.de/u-boot/custodians/u-boot-usb/-/jobs/815411/raw )

Stage: world build
Name: build all 64bit ARM platforms
