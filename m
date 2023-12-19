Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA47C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 12:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37589874F6;
	Tue, 19 Dec 2023 13:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AJaBrv9C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3743D87252; Tue, 19 Dec 2023 13:47:14 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53E9D87508
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 13:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id E1501B816F8;
 Tue, 19 Dec 2023 12:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72433C433C7;
 Tue, 19 Dec 2023 12:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702990031;
 bh=qho8vMXc9lzC5phaIjIY6ZUo8nunPbSdj3ASHUga6AQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=AJaBrv9CL0XORUvBHvd9Rg5rza3w9+e+8Qn8YLZERBzS0evZAdcouLFukcfHmMyeE
 8Yya4yBhJdaZB4yT655XKqaVH/dEQ2KkRQ1jk99xtaB1SHJH6hP4zk0ul7HY5hCJGW
 i0JfMcTMsHFcSy2AXu0G7NkjhX9PN1j/LdnWGb1XVau4pJJ7n6q2vPk0+oDlPdLA53
 lkZrqtbZfoZdz3ahLcd85QvsPQzWm/YoU1yOBj0BFIqVb82CTjHz7qiC9ginQSdfKL
 81OBYHFdyFwsqXIwp1VGKNh70FbsPkCCiZ/JhjAmTtziBloXnI6JRgG/Ah3hCT474A
 kTcBEmYkayTWg==
MIME-Version: 1.0
Date: Tue, 19 Dec 2023 13:47:07 +0100
From: Michael Walle <mwalle@kernel.org>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: xypron.glpk@gmx.de, Abdellatif.ElKhlifi@arm.com, Drew.Reed@arm.com,
 ilias.apalodimas@linaro.org, nd@arm.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: Re: Adding EFI runtime support to the Arm's FF-A bus
In-Reply-To: <87plz2nzr1.fsf@bloch.sibelius.xs4all.nl>
References: <B06FB6F5-416C-440D-BC72-070673DF3177@gmx.de>
 <20231219101124.2847425-1-mwalle@kernel.org>
 <87plz2nzr1.fsf@bloch.sibelius.xs4all.nl>
Message-ID: <f2eb636cd895aae348d4357537267fd2@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
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

Hi Mark,

>> > Any runtime device drivers for variable storage should not be in the
>> > U-Boot runtime but live in the secure world (e.g. OP-TEE) FF-A is the
>> > new ARM protocol for talking to the secure world and hence fits into
>> > the picture.
>> 
>> What if I just want a simple embedded boot stack where I don't
>> want any secure world and just want to be able to boot a COTS linux
>> distribution via EFI?
> 
> That already works for many Linux distros.  As long as the distro
> installs the appropriate BOOTxxx.EFI file you don't actually need to
> set any EFI variables for the OS to boot.  It can't get any simpler
> than that.  Of the main Linux distros it seems that only Debian
> doesn't do this.  Someone should probably lobby Debian to do this as
> well as it would mean that Debian would just work on an EBBR compliant
> system.

I know. Last time I checked CentOS (or was it Ubuntu?) tried to
set EFI variables and the installer just failed. Might be fixed now,
though.

> Things get more complicated if you want to install multiple OSes.
> Then having EFI variable support makes things a lot more
> straightforward.
> 
> And of course EFI secure boot needs EFI variable support as well (with
> proper support) for authenticated EFI variables.  But IMHO that no
> longer falls into "simple embedded boot stack" territory.

Thats clear.

>> Assuming, that there might be a simple dedicated EEPROM to store the
>> variables which is not exposed to linux, is that something which would
>> be rejected by u-boot mainline now?
> 
> Not necessarily.  But such an approach will have limitations:
> 
> * Completely hiding the EEPROM from the OS may be hard.  Even if you
>   have a dedicated SPI controller for the EEPROM things like the SPI
>   bus clock or power domains may still be under OS control.

Fair point, but I was thinking about the ls1028a for example, where - if
I remember correctly - there was one dedicated i2c controller in a sense
of isolation, probably to use with a secure OS. Also there is no dynamic
clocking.

So, technically it should be possible, even with a low overhead, like no
device model etc, which could reside in the efi os services. Just 
testing
the waters here, not that I'm interested in adding support for that in
u-boot. Just a bit concerned that it (EFI variables) will only work with
a full stack (tf-a, optee) in the future.

> * It is not possible to properly implement authenticated variables for
>   secure boot if the EEPROM and associated hardware is just removed
>   from the device tree but still accessable to the OS.  An
>   implementation that pretends the variables are "secure" will
>   probably be rejected.

Sure. I excluded any secure stuff. But, with that i2c controller i was
talking about earlier, it should be possible to mark it as EL3 access
only.

Thanks,
-michael
