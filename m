Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A42CC4829B
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 14:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66F2B879AF;
	Sun, 11 Feb 2024 15:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="v11PJI8D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A8F287C45; Sun, 11 Feb 2024 15:21:40 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADF2B8798F
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 15:21:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707661295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=slF/HtpsjIOQoS5/E6EQ+poRjAfN4v3uTj8SfQy0Ou0=;
 b=v11PJI8D4AU3XqTmTOEXG6cLuF+5vmlcCnvBmfyCKFDyoAXqKwlotnK3+DYt3X3Wx03CDx
 eLSnUjEM6VFAO8ZFhk906pj7DuHqH2HYlyBpiqTzAHOpZJz6LxwjNmzAq7i+s16t+anrZ1
 RNGA/ng2I+dVno5F5vOwV82qRt4vcRgbbxcV4QECvFG7BCXh57PfoqK4VbGU6BF9TSYTVL
 lrAiQqjek16IQjauOhH9d5cPt9aVj7vmD9ukgaoLsdEbnwAm3cTJCFnDBxkGUimi20zCFP
 2GS5CVdaesR/2mBV2y4zLvDF7ynLUqQg7H7/dwxpC92QF9FKOHguMLyS/CkoZQ==
Date: Sun, 11 Feb 2024 15:21:33 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Johan Jonker <jbx6244@yandex.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, trini@konsulko.com, massimo.pegorer+oss@gmail.com
Subject: Re: [PATCH] doc: rockchip: Clarify the rkspi image format further
In-Reply-To: <f0fdf99e-4688-47e2-97ff-a7ba24682a29@yandex.com>
References: <cd0b002cacfd40ac294b1583c1769718e94e869f.1707588872.git.dsimic@manjaro.org>
 <f0fdf99e-4688-47e2-97ff-a7ba24682a29@yandex.com>
Message-ID: <7077477049b35fa738d4e567e2581627@manjaro.org>
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

Hello Johan,

On 2024-02-11 15:07, Johan Jonker wrote:
> On 2/10/24 19:18, Dragan Simic wrote:
>> As discussed on the U-Boot mailing list, [1][2] only some Rockchip 
>> SoCs
>> suffer from a bug in their BROMs that requires a specific format for 
>> their
> 
> This not a bug.
> 
>> SPI images, which was the reason for the rkspi format to be 
>> introduced.
>> 
>> Improve the description of the rkspi format a bit to mention this, for
>> future reference and to make understanding it easier.
>> 
>> [1] 
>> https://lore.kernel.org/u-boot/c32129ba-db25-4b9d-9a4a-032d88dfb9cd@kwiboo.se/
>> [2] 
>> https://lore.kernel.org/u-boot/CACdvmAjfCWicRd=LKKyob7fZo79AFkUQKy0e1HBb0zyJuoO70g@mail.gmail.com/
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  doc/README.rockchip | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/doc/README.rockchip b/doc/README.rockchip
>> index 84caff8a24d3..e0c5c395ec6a 100644
>> --- a/doc/README.rockchip
>> +++ b/doc/README.rockchip
>> @@ -649,7 +649,12 @@ sector is used. The header is the same as with 
>> rksd and the maximum size is
> 
>>  also 32KB (before spreading). The image should be written to the 
>> start of
>>  SPI flash.
>> 
> 
> On rk3066 an image should start before page address:
> NAND : 50
> SPI  : 13
> EMMC :  1
> 
> Not sure about start limits for other SoC's. (Kever ??)
> 
> Also rk3066 and rk3188 use RC4 crypto.
> 
>> -See above for instructions on how to write a SPI image.
>> +Only the BROMs of some Rockchip SoCs, such as the RK3399, suffer from 
>> a bug
>> +that mandates the above-described data spreading, thus requiring the 
>> rkspi
>> +format to be used for their SPI images. Rockchip SoCs that don't 
>> suffer
>> +from this bug use the rksd format for their SPI images.
>> +
> 
> This not a bug. It's a design choice to reuse the reading function in
> the boot ROM shared by EMMC, NAND and SPI etc. due to size
> restrictions.
> 
> See NAND example:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/blob/master/drivers/block/rkmtd.c?ref_type=heads#L259
> 
> This NAND code also applies to SPI with minor tweaks.
> Code will never read more then 2k regardless of the page size.
> 
> ===
> This info must be written in a more neutral wording.(no bugs involved)
> Just describe the 2 formats and the SoC's that use it.

Thank you for the clarification!  I'll make sure to get the
wording adjusted to be more neutral.

> ===
> Extra:
> 
> Could someone cleanup README.rockchip
> The file README.rockchip has most building scenarios covered by now.
> Please have a look if all the boot log listing in that file are still
> needed or can be removed.

There's much more in README.rockchip that should be cleaned
up and refreshed a bit.  I'll convert the file into the RST
format and do a few cleanups.  After that, everyone will be
more than welcome to perform more cleanups.

> ===
> 
> Is there a need for SPI programmer code a la RKMTD with common base
> and block interface tools?
> 
> ===
> 
> Is someone able to extract rk3568 boot ROM code in order to study NAND
> boot behavior for a future RKMTD NFC V9 upgrade?
> 
>> +See the section above for instructions on how to write an SPI image.
>> 
>>  rkmux.py
>>  --------
>> 
