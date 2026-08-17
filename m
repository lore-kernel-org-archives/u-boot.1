Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861F8C5DF7D
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 00:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD10581131;
	Tue, 18 Aug 2026 00:36:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RFEbALvBDnif; Tue, 18 Aug 2026 00:36:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F7A781141
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787013369;
	bh=G78lt1AsgUo2tdzDp0KmExtR5G0ILNNBXQypJcnRXC8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G07YCJ0ZtTFv7HTI9/OeF5rEbbLXr6n6tHOwFyHQXcWNBp0z0F5wWtcOJV8XrAl6r
	 QCN5uNoX2uoU/ompAOC7Rxb4TopviAwPsAc2UY8z3YfX6UW5SRuICyvP/gnVndZFpw
	 6n6M8Sp4UuPBC4kXUsSHllZbq65x8w32T/hlb8AoR9435boUViNlcTAWkY4I/tCrJS
	 lFHkzwT5zNNLJKyIAnoYhoHLPH7rmG64ro2z/KQN0IUwKUuUncNBVQkd4Mon4xY4Ns
	 gi8/3MvRyyutVp/qJfBBqbCABN8gO7EReLz+cMsxbruHZBbA8xm+vf5oBDV9t27nAs
	 YCBuDxK9RxtfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F7A781141;
	Tue, 18 Aug 2026 00:36:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B82C72EF
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 23:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A92BA407D3
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 23:14:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BtkOc9Ujj7we for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 23:14:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::230; helo=mail-oi1-x230.google.com;
 envelope-from=dmanlfc@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CFB85407D0
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CFB85407D0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=jKEvS1Tx
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CFB85407D0
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 23:14:30 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4ab8cb2a6e4so2688305b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787008470; cv=none;
 d=google.com; s=arc-20260327;
 b=F478yU3KlIMHjLzzwQ4SB66/0FpoOXKsxT2sAkMB7ouboGfQliKPdeMboCDgkpOyzh
 R3HeZ45Rm4TIFJfvpg4e3dFI8YZ/id1RH1F0c6WM1pZZCz3RQ5VkfvfzlicVGs1hDjKl
 JD2OlyEkw2YOAcsX2S6sZij6ZfVnrNm92SdSksXxcQrfomfbOnfV3pjqY0tbyEi1DBET
 O/oMd3p3OJKxQfAgzObJjfyhk1wpHrJ7/+Mq+ds0mTQQo0OUlj9YIgL7z2LbI8jzunJM
 oQRKkGPVwbdRKhMmyW8gi10nQ6BhzI6gXVagFZWDScp6whLDMaun6kZC82ztcYkJPtSM
 8gpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=G78lt1AsgUo2tdzDp0KmExtR5G0ILNNBXQypJcnRXC8=;
 fh=It428xZPArRWd8lkPZ89xzh8osEgBiNqHs4UGwJqw/c=;
 b=BQZ6/Ym4QRAzP5BiC3C27WucwKp9UV0fpDd8lrDwVOynOlxcUWo1spwjT9Uky+u0Gs
 BLO0yMyHUJaz88CR2YJHp7Wisv1UDQnd6kFKZLzx2GPCEdsrgIkk9fezVMroKhCCFk2s
 V/gap8eZrQShRRx0dsGXJTMVK9cH5KLBHoWaLYIZ7w2oVnJYGWh+XLRR9QC6yLhR+Pwm
 zFkGSHcC7gIMJBlMJlQculjN+vGzL07AmMIaohrckVkTPpZ6MAYf6EDLDarWiwArXVVB
 JFkzgCB4Y9HVVBo4S45znfHlYd5DW0iv8KwwtXht50Q9MhC9iaIwCFekDQR9cLuEdg7A
 dHuQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787008470; x=1787613270;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G78lt1AsgUo2tdzDp0KmExtR5G0ILNNBXQypJcnRXC8=;
 b=jKEvS1TxHyyAkJ+6+V3CkNPT7eMOdZ4Tdn5MOX8kvMhBMiETB1WzRQzOx/ifYgMntl
 Bi7g8jXuJy2LifMdDCC7svSUCnkY8jv1+bz+upYjlWowT0sXu4xU+jQBDvYiBMjAa/s2
 60AbqB4U+44FhhJVL3gOEcXRGAP3STdqBRx4cJsLFDdhGTDafXEsLtt0rU27KRCNE8tZ
 cir9Psky4BlQ3rxbm3U3ku7tBil41pyLHzHk8AT8yPLT027AJmRgg/LL58vf4tzlI9Qz
 /IExJyZQgtV4bso/GlZKdhjgFMvoBe5il2QGUUcPDUG31Jmk4+QSjzwHp1lZbqRjHIXh
 SLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787008470; x=1787613270;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G78lt1AsgUo2tdzDp0KmExtR5G0ILNNBXQypJcnRXC8=;
 b=RkzauAHAM6bEyD3INb2UyoJ0IAGTVtqFZNUro12YElLDAYKKWiIvKNj4wYWPvoWiSc
 y9HiaKaOXaxkty6yrasYDzwDx8YngejE+b7/2OlM685yuhnvVk+PsjwGBW0pV9CYGOyz
 NoMbjXtKJSh0YYFUAgTHxvelzPv6/YdOoKy9OUufflXhPgPTpdqvr0N97Kbmc0Rd9WjA
 5r6kM+TXc+iaMX+olmn2DLAlqwg69kiKifTrj8y84A5q2L6moLpZFvuR+wEciy7FQzeq
 mKSvyBr2vTwPvVI6VkHU8klyYAcADXxO7GjyQI/fU9yKCilv9+xZTp6HxF4Z00Cb4tsP
 es9w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4KRCKThWEPTii0v2w3GbplRf5UMFzFJKETUqY35zReY3/XsiyDFzhYpLP6XRlkT4p/bvqtLM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxHMMvmxQFRSreQz0ZnI+DRvc6xlbgxUihldZzofk7Baa9btYDj
 4iy3Vs5rlP0twCtzKkLrJh3JBAO++Vwo+uQyyFd0MnoSggAeVny4Vwr1GNHj6vXUJiBEfyaHH30
 HcPCzCCuJilJ+Q5G/irmcY+MGXWvCC/8=
X-Gm-Gg: AR+sD13yZActD7GGoK+H7KLNsDRw3MFiTZ3VCdAMeP+n9w/uveH6i1tXodubEVX34Dg
 jLcTqcDon160CfVPhcVRCqcEc6q2GlxhYl8tmOT6O+SQrKUmj8BeDU3AnhXt72hij9plwdpunLq
 5zxurLJR9sCHvkcmzaZvsDXE6tJgLNYFMrZwAyf3dZu1oscuhXsRnKL06tJh44KO6zK7VYGEb+7
 6g/jPoatIhoeiusn7cx//fxs40TA1xSulBXIZBPZrjgLtfHo9ruAOfMHZxWOw3eNVb0haKnR5i9
 noRDfx7loZkUb/GdO8XqA6y9FdXzirSONEfKgzd0m5p8XQ==
X-Received: by 2002:a05:6808:c172:b0:4a3:3108:866a with SMTP id
 5614622812f47-4b2979a08eemr4401465b6e.17.1787008469719; Mon, 17 Aug 2026
 16:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAOyTmd13R7_fan-iB8qK55AFZoba+RCi4VT-GOa5ot+OZD__Rg@mail.gmail.com>
 <38c0d683-46bc-42b1-86a1-345b2070084b@cherry.de>
 <PH0PR19MB997338FA72B2980A64B4194127A5DA2@PH0PR19MB997338.namprd19.prod.outlook.com>
 <CAOyTmd1JvBqRiuBPcLxkhF+x6yws6uOQ7z6vZqq3jrZkgj7+tg@mail.gmail.com>
 <an_Wqkp09sxijfxv@wintermute.localhost.fail>
 <PH0PR19MB9973381C3D06EF7593AE50C56DA5A72@PH0PR19MB997338.namprd19.prod.outlook.com>
 <CAOyTmd0QrejH5tR013FDOpMJu27UXf2BE1t87f9Skxm9uyLC8Q@mail.gmail.com>
 <PH0PR19MB9973381877D494D491EBAC9161A5A72@PH0PR19MB997338.namprd19.prod.outlook.com>
In-Reply-To: <PH0PR19MB9973381877D494D491EBAC9161A5A72@PH0PR19MB997338.namprd19.prod.outlook.com>
From: Daniel Martin <dmanlfc@gmail.com>
Date: Tue, 18 Aug 2026 09:14:17 +1000
X-Gm-Features: AcwNN1XIX4tF2bMsOOCjDrsCRLMSAja2jw8pKLNbWuHIHWWGeSHsKlOBn1BdxA0
Message-ID: <CAOyTmd2bwxO4XVApg67t8vVCOhppY1HQEi93NbCsPVOOm1RBcA@mail.gmail.com>
Subject: Re: [BUG] rockchip: v2026.07 fails to boot on GameForce Ace (RK3588S)
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 18 Aug 2026 00:36:05 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Sounds good, thanks!

On Tue, 18 Aug 2026 at 09:10, Chris Morgan <macromorgan@hotmail.com> wrote:
>
> On Tue, Aug 18, 2026 at 09:04:31AM +1000, Daniel Martin wrote:
> > That's great, thanks for the update Chris.
> > So maybe I'm missing something...
> > I didn't try `Arm Trusted Firmware` but I used rk3588_bl31_v1.54.elf
> > without Optee.
> > Does it need Optee? I assumed not as other RK3588 devices don't.
>
> No, it doesn't, though I boot with it anyway.
>
> Note that in digging through the code again I *did* find a bug and a
> possible issue, though neither would stop the device from booting
> successfully. I'm going to push a bugfix soon to fix the following
> issues:
>
> 1) CONFIG_TARGET_GAMEFORCE_ACE_RK3588S=3Dy is not set in
> gameforce-ace-rk3588s_defconfig, but it should be.
>
> 2) Since recovery from the internal eMMC isn't simple, we really should
> set the default u-boot,spl-boot-order for this device to *always* favor
> the external sdmmc.
>
> I'll push a fix upstream soon to handle these two issues, but neither
> of them would cause a boot failure like you have experienced.
>
> Thank you,
> Chris
>
> >
> > Let me try again on the weekend with ATF & LInux 7.2.
> >
> > Dan
> >
> > On Tue, 18 Aug 2026 at 03:34, Chris Morgan <macromorgan@hotmail.com> wr=
ote:
> > >
> > > On Fri, Aug 14, 2026 at 10:02:05PM -0500, Chris Morgan wrote:
> > > > On Sat, Aug 15, 2026 at 10:06:23AM +1000, Daniel Martin wrote:
> > > > > Thanks for the further details Chris,
> > > > >
> > > > > It would indeed be great if we could move this device to mainline=
 end-to-end.
> > > > > Let me know how you get on with v2026.07 and if possible, test yo=
ur
> > > > > DTS with the stable kernel (7.1.8 or similar).
> > > > > When I reverted uboot, I encountered inconsistent I/O issues with=
 the
> > > > > latest stable kernel, therefore I ended up going back to the BSP.
> > > > >
> > > > > Thanks for all your work, we appreciate the effort.
> > > > >
> > > > > Dan
> > > >
> > > > I've just tested booting the device with a completely unmodified
> > > > version of Arm Trusted Firmware (checked out at tag v2.15.0), U-Boo=
t
> > > > (checked out at tag v2026.07 and changing nothing from the
> > > > gameforce-ace-rk3588s_defconfig), loading Linux 7.2 (tag v7.2-rc7) =
via
> > > > extlinux boot method and it seems to be working. I do note that it
> > > > seems to be slower to boot since I upgraded A-TF and U-Boot to the =
most
> > > > recent releases, so I'll troubleshoot that some more next week as I=
 try
> > > > to install a fully up to date Ubuntu 26.04 on it.
> > > >
> > > > I know you said it's hard to get a serial port on it, but if you
> > > > continue to have problems booting it that might be required to
> > > > troubleshoot it further. Otherwise I can send you my binaries if
> > > > need be.
> > > >
> > > > Thank you,
> > > > Chris
> > >
> > > I'm afraid I cannot seem to recreate the problem, and I'm going to ne=
ed
> > > a serial dump of the kernel logs. I'm sorry to ask that of you, but i=
t
> > > will help further debug what the issue may be on your end. So far I'v=
e
> > > tested using a mainline kernel (v7.2 checked out this morning), U-Boo=
t
> > > v2026.07, Arm Trusted Firmware (mainline master, checked out this
> > > morning OR the rkbin version, rk3588_bl31_v1.54.elf), optionally with
> > > Optee (master, checked out this morning). In each case the device boo=
ts
> > > successfully for me running Debian 13 (Forky) with my own mainline
> > > kernel.
> > >
> > > I'm going to test installing Ubuntu 26.04 and fusing some OTP keys
> > > later today, I'll let you know if I encounter further issues.
> > >
> > > Thank you,
> > > Chris
> > >
> > > >
> > > > >
> > > > >
> > > > > On Sat, 15 Aug 2026 at 07:40, Christopher Morgan
> > > > > <macromorgan@hotmail.com> wrote:
> > > > > >
> > > > > > I'm having trouble with my usual email client, so I'm sorry if =
this message is formatted weird.
> > > > > >
> > > > > > I have tested the device most recently with 2026.04 with the de=
fault defconfig options. I am using mainline Arm Trusted Firmware though, n=
ot the Rockchip versions. Using Rockchip's A-TF should work, but again it's=
 not something I've tested. I can note that if you're using mainline A-TF a=
long with mainline Optee, you need to pass CONFIG_SPL_ATF_NO_PLATFORM_PARAM=
=3DN, otherwise the device will fail to boot because it won't protect the O=
ptee regions. (For mainline A-TF CONFIG_SPL_ATF_NO_PLATFORM_PARAM is option=
al unless you use Optee, for Rockchip's BL31 you need CONFIG_SPL_ATF_NO_PLA=
TFORM_PARAM=3DY).
> > > > > >
> > > > > > I'm going to test the device next week and see if I encounter a=
ny issues with it. I'll report back if I find out anything weird.
> > > > > >
> > > > > > Thank you,
> > > > > > Chris
> > > > > > ________________________________
> > > > > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > > > > Sent: Wednesday, August 12, 2026 10:22 AM
> > > > > > To: u-boot@lists.u-boot-project.org <u-boot@lists.u-boot-projec=
t.org>; dmanlfc@gmail.com <dmanlfc@gmail.com>
> > > > > > Cc: Chris Morgan <macromorgan@hotmail.com>
> > > > > > Subject: Re: [BUG] rockchip: v2026.07 fails to boot on GameForc=
e Ace (RK3588S)
> > > > > >
> > > > > > +Cc Chris who maintains this board and may be able to help.
> > > > > >
> > > > > > I somehow didn't receive this mail in my inbox, here's my attem=
pt at
> > > > > > quoting text from a mail I didn't receive (and it's also not av=
ailable
> > > > > > on lore.kernel.org...).
> > > > > >
> > > > > >  > Hello,
> > > > > >  >
> > > > > >  > I am experiencing a total boot failure on the GameForce Ace =
handheld
> > > > > >  > console (Rockchip RK3588S) when trying to run mainline U-Boo=
t
> > > > > >  > v2026.07.
> > > > > >  > The device fails to initialize or display any output during =
the
> > > > > >  > initial handshake.
> > > > > >  > Unfortunately, due to the tightly integrated form factor of =
this
> > > > > >  > handheld device, it is exceptionally difficult to break open=
 the
> > > > > >  > casing and wire up a UART serial console to capture early bo=
ot logs.
> > > > > >  > The target operating system (Batocera Linux) environment is =
running
> > > > > >  > the mainline Linux 7.1.5 kernel.
> > > > > >  > Given the complete lack of visible console output, I wanted =
to check:
> > > > > >  >
> > > > > >  > 1. Has the GameForce Ace board target been actively tested w=
ith the
> > > > > >  > v2026.07 release?
> > > > > >  > 2. Are there any specific or updated build instructions, BL3=
1/TPL/SPL
> > > > > >  > combinations, or proprietary Rockchip firmware binary requir=
ements
> > > > > >  > (rkbin) needed for this release that may differ from previou=
s
> > > > > >  > versions?
> > > > > >  >
> > > > > >  > For reference, the build configuration used was: gameforce-a=
ce->
> > > > > > rk3588s_defconfig
> > > > > >  > TF-A / BL31 version: rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.2=
1.bin /
> > > > > >  > rk3588_bl31_v1.54.elf
> > > > > >  > Compiler: GCC 14.3
> > > > > >  > Linux 7.1.5 uses the rk3588s-gameforce-ace.dts
> > > > > >  >
> > > > > >  > Any guidance on known regressions regarding this target, or
> > > > > >  > recommendations on how to isolate the stage where it hangs w=
ithout a
> > > > > >  > hardware UART, would be greatly appreciated.
> > > > > >  >
> > > > > >
> > > > > > If you have a known working version of U-Boot, maybe start a bi=
sect with
> > > > > > that commit as good and 2026.07 as bad to isolate a commit that=
 broke
> > > > > > the board.
> > > > > >
> > > > > > Cheers,
> > > > > > Quentin
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > >
> > > > > Kind Regards,
> > > > >
> > > > > Daniel
> >
> >
> >
> > --
> >
> > Kind Regards,
> >
> > Daniel



--=20

Kind Regards,

Daniel
