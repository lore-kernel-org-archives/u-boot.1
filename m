Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9572DC4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 14:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6889E87872;
	Mon, 22 Jan 2024 15:30:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="IReVOKaG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F881878A1; Mon, 22 Jan 2024 15:30:04 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D91548785F
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 15:30:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: a291bef6-b932-11ee-90ec-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id a291bef6-b932-11ee-90ec-00505699b430;
 Mon, 22 Jan 2024 15:29:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=arJEhCwJ1H8sM99dBCt97FkxZeTxctip94LNkI9cliA=;
 b=IReVOKaG5Kt2072QChwyjQ1DUZcfx+6J+DN0qDf2ou7B1Sj4XBaKZ56RbDvz0acOxD04l1UZEPnUF
 CyEe1J2EyZZ+nkkyIw2f+GXhFfLyDBcgEH8PKxnDUkUu+kYJ6A589oz0qW6YvcQRAwnzWeUo1K4l/j
 oEHoJyeDdj0uw38B8Xqq8YY6iSC8EvopdDB6dOi73GqCRw3RoKEl0KGcqtbwdnVw1/UND3Zeg3bPsJ
 cSzLrmvLWyIGsmJRsrZS0bjAC+dEyg/UofnvpS0ou6/B2IO4yAWXovS8w1416BDXhUvxobfNU7U3P/
 2MxpTueU4AaH+nrNk+nGyc08DeKHOog==
X-KPN-MID: 33|N+81GViB+tBiHah3Ks51Ts2n/5N8c0R6Y+TvRyTO71TNhDJK05hALeq2LDZzk4A
 ZPT9Y+KrxlAl/NnlH2O4KEKJDjAvkllgAruW2cLeEnN0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|SHQ6kmZqXKwUDkLXdkpzJN0G2UE4IVziMfSJ5XPJZcSkwgBFiZmeJr1bnUq1d72
 Rzc3SlR6sx3BIjrzH1OgShA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id b94a725b-b932-11ee-ad2d-005056998788;
 Mon, 22 Jan 2024 15:30:01 +0100 (CET)
Date: Mon, 22 Jan 2024 15:30:00 +0100
Message-Id: <87frypsaon.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: "Ivan T. Ivanov" <iivanov@suse.de>
Cc: wahrenst@gmx.net, mail@jens-maus.de, u-boot@lists.denx.de
In-Reply-To: <uwh4skanpw4c42t5iefqiawfns2wglxl4rizmaexeaetyvahf3@yibnd3owvcn2>
 (iivanov@suse.de)
Subject: Re: [PATCH v4 0/6] rpi5: initial support
References: <25AB43C7-829F-4F62-AC8E-3284B22ACB03@jens-maus.de>
 <E7BFDAEE-00A9-463A-AF73-75101AFF2BC6@suse.de>
 <FB66DFF3-03B0-4DA5-8916-AB80CA6C6EB5@jens-maus.de>
 <dvpwizpui6a52dfmy57ghv4zmplvgqvow6oec7x5opwzh63zzl@jehyglofr6yh>
 <489FBAE5-501A-49F6-894D-58BE5C5429CC@jens-maus.de>
 <A0746263-646C-40C6-A2A6-659C39385E8B@jens-maus.de>
 <246035ba-0090-4cc3-982e-1de837ec7340@gmx.net>
 <6E2D7E91-E869-48C6-8CE8-0B410A2B67B9@jens-maus.de>
 <ebffa598-6945-4a03-abe4-fe519df5fbfd@gmx.net>
 <223DA3F8-B17B-44CF-B247-12DEBD100A75@suse.de>
 <uwh4skanpw4c42t5iefqiawfns2wglxl4rizmaexeaetyvahf3@yibnd3owvcn2>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
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

> Date: Mon, 22 Jan 2024 16:16:34 +0200
> From: "Ivan T. Ivanov" <iivanov@suse.de>
> 
> Hi,
> 
> On 01-22 13:57, Ivan T. Ivanov wrote:
> > > Am 20.01.24 um 10:48 schrieb Jens Maus:
> > >> Hi,
> > >> 
> > >>> Am 20.01.2024 um 10:22 schrieb Stefan Wahren <wahrenst@gmx.net>:
> > >>> 
> > >>> Am 19.01.24 um 22:26 schrieb Jens Maus:
> > >>>> I actually do have some good and bad news:
> > >>>> 
> > >>>> 1. Good news: I got u-boot finally showing up with my RaspberryPi5 8GB both on the HDMI and on the serial debug UART like you reported.
> > >>>> 
> > >>>> 2. Bad news: I actually got it working by downgrading the rpi-eeprom to the same 2023/10/30 (VERSION:30de0ba5) version like you have.
> > >>>> 
> > > 
> > > One idea would be to enable early debug in U-Boot (no idea how to
> > > achieve this). I assume U-Boot crashes before it's able to print the
> > > first line, but it's hard to believe it crashes at the very first
> > > instruction of U-Boot. So with some luck we should be able to narrow
> > > done the cause.
> > 
> > I was able to enable early debug UART in U-Boot and I will try to
> > find what is happening, once I get some free cycles.
> 
> Ok, this was relatively easy to find :-)
> 
> New versions of EEPROM firmware change “kernel”/U-Boot load address 
> from 0x80000 to 0x200000. And because on RPi’s CONFIG_TEXT_BASE is
> hardcoded to 0x80000 code run through the fields. 
> 
> Hopefully simple patch like bellow make it work fine in older and
> newer EEPROM firmware versions.
> 
> Regards,
> Ivan  
> 
> diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
> index 11ede9435d..ce64f9554f 100644
> --- a/configs/rpi_arm64_defconfig
> +++ b/configs/rpi_arm64_defconfig
> @@ -1,6 +1,7 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_BCM283X=y
>  CONFIG_TEXT_BASE=0x00080000
> +CONFIG_POSITION_INDEPENDENT=y

Not sure if it really matters, but for the Apple M1 config I set
CONFIG_TEXT_BASE to 0x00000000 (zero).
