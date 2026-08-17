Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24BCC5DF74
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 00:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54CBC60617;
	Tue, 18 Aug 2026 00:36:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NMDnJ40Gm3LQ; Tue, 18 Aug 2026 00:36:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1596A607BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787013367;
	bh=Fl/yw/TU99L9/9wkZq0iod3oa6KyPV/r+h08SEvmd0w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jmGZ6f8qZGwmmHQEjBw80dd9vQ+LuxRduqMvQ8bcoMT6TrM2L1/nBSMe27bxKwbq7
	 WKznXvATS07QtPuTXz7y0XtCu6Ht707cVq2QhACjTrk8nLQPfRUQlB7OIQwO1zWpLJ
	 C2Mahih0JkWE9vo2X+Vno/0e+0qBqc0XiaVu+6CswcmEgPh7d8pRvu6OkJCl4YjhXI
	 vr0nS/rz9MvfzMSXA5CW9LSOk+frFuwZSsoX0ecZoC9fWv7Z0802DtZj69/jEratBN
	 jq0jb4o5u/8Ty+HeAxsU+6c71a+8Xfvr5VGRjvKt6PzaGnqhScBdgfmIZyo5gEwc6M
	 BFd1ip1HXdL5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1596A607BC;
	Tue, 18 Aug 2026 00:36:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 61D0B282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 23:04:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B41E80DAE
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 23:04:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jhn0ULbzP_kx for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 23:04:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=dmanlfc@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6050880D50
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6050880D50
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=jR0st051
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6050880D50
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 23:04:44 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4b28d7fdac4so649559b6e.3
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787007883; cv=none;
 d=google.com; s=arc-20260327;
 b=EBqSs/TKhgfswoHceuVphZo9eF2t77+NF6E5Y4w1QLYUSItZ7m1ejfngsBXKBeE4y0
 Tz9t6TUhj+qSS3t62syxUpseMeNwKAFwiRiBupIr+eGQ4ac/HePxfSwziHxDardbKr0K
 6JZU/04KQfTKxA497mSduQs2Nfh/AzTMd9k9iJqA/hw+EFVVcnnyjzC7TvTAGVYs1Uz3
 BIdOGmt1tzpUHae7/Ur9Pw7e+TEu3Xx9fqfe+nkjYahnrwTcFoQa/pcc6t9LrCpRE5rg
 2csK1pZu/TaOnkjiLXL/+D8O8C9zkYCKfCyj9pQ6YuD8fLJqImGQJ1h2p/02DnqGXv0K
 fXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Fl/yw/TU99L9/9wkZq0iod3oa6KyPV/r+h08SEvmd0w=;
 fh=8Qv/4dIJpC54WUqFi3OWxadTirOb3zA/A7s0nn+lDqM=;
 b=ZHj/vGAbdMWNztd3m0602jqWjAg1N8yCmuwaXmP8IRHWFZGIoLAF89iMowisvh7aUZ
 vF87nEC04S7y1piN1z0PDHy8Kgp0S/JMZg7ikAwLGyDUITQU3ZKcpbEMldsObumjykzy
 JULoYfMjKUTyN2TksooTnJHRfINEvPFvVVusNR+vCzR22m4Np0bsbEkliPMidVLpLR+l
 NPBwrOYodmzB6vDYrk7vCh4O32W1u6IfSz4jrqSyDEYG1tQVmWEQTW7fA7YqNvDibGgH
 bh9t25svelrwJs32JE3CDAyXbIW0HPAKpqONv5SgyzRsaT5D9+RX9MLxm1Ofw0sHuD9N
 eGjQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787007883; x=1787612683;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Fl/yw/TU99L9/9wkZq0iod3oa6KyPV/r+h08SEvmd0w=;
 b=jR0st051KyUk+iqDTqtlJB3Jf85N6wSSTtRipQlowFx2WWkQkiR8428X8Nes9TXNY3
 Lqh4HKmE+9Nk9aTpQzaHxZyeYqczYMpRND1UUSZmLtL8UqTca5enrkAijvkoiYCxVfSE
 iZK3L+Z7PcLksiOJgJmemw9+TeOIa0XoePKi1x+lfDKUNA0HLr4GGHipnohsPruI1GZm
 M8CFUG6WR5kFAWoa5jycS7tOrOysK3NfJ2VXrKW18IOdBI72AqB8NnsjscovGX1VE2yl
 8h2ZCwx42QUp1ZDe2cIu6cwqkve5fXgGeZ29gBxVmJ8zCRXOHNN1WP4TiO0gZjHIktSp
 fw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787007883; x=1787612683;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fl/yw/TU99L9/9wkZq0iod3oa6KyPV/r+h08SEvmd0w=;
 b=Vy0trWcYQmzEt5g2vcdbO1PiIv6xmcfUqEIoWh90/R/VsviMDRKFk2DBBF0k9yf10D
 3Ok29hfeO72hzAA2FxlBdQyiAf+BbsISnEwPdqQnWcaIzP2nL8ev3hHwOMNhaxaNYtNh
 B7Rufeq/YGTYE1Dkpzi2VmkrexctiwXuN/zeWn0ucozcIFKFGp/RD9d7YQ5+lwNFsqd9
 OSVxiEIsB3YGN78OQ+qUGafmUiZ98PCx5g23zwlcWUedbrRHuF2PI6pCVkSpAXaYDpf8
 tWVThxm+/1l1CEuq1owBhlbaco1zw5hmpNmx6C02zAvEh1b4kqKaUt3orw3R7FrfZ02x
 0Rdw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVRg48pCQEwtWf7DeG4h7FTjmjqowxcLqNzgfh5qCqMU4zsqFScf7vICfbU3nwKbMm81RQJ1s=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwAE9HvMSfZ507Rkqe6KCiiOjC8LbakG5CbqOcZ8GN3uLJvQ2rM
 yITbJ5nLdjZaRk5L/3Mk3Yu/NbwxJ6bdl3S0GFWQ2mABneCqLmOqhmHr0YJ1HHmOt/9u75djrXO
 1sWXG9NYakvWpYldfwSv9Jn19j/t0SGtjgxhF
X-Gm-Gg: AR+sD10vEse2Ozw6VSFA6Px32YGqsUi3kSKwtOhx02UA0HaPq1V/rP3OsvvM25NhvFb
 RGvS6dgD/zEC8TcKkiRpJ9MAWQVoRqfDorxnh/7uGtYSCHxuGaOK8n1rjOTra+/wUNrN5iNSNRf
 kEYhLf/TL/tIZxAuyVuGnGjj4bS47r0qREAImU+1D8BTwFntNFyzZs2NgieS7tcntjChdPetJBo
 GE5IJ6Dd7LpBSuA1p2GvN6vSDBd2CdmFWz4sPuZ3OB+AUIW7XlxkLS/FGmmvq8IfceiMfwjHzTB
 aA//ddkmoswQgSNtlQ4Hva6BN8ZwwMSkUqz7ZXz4kUqKzjXLjxrKPROFqQ==
X-Received: by 2002:a05:6808:159d:b0:4ae:f5be:fe30 with SMTP id
 5614622812f47-4b241e682c6mr29414339b6e.18.1787007883018; Mon, 17 Aug 2026
 16:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAOyTmd13R7_fan-iB8qK55AFZoba+RCi4VT-GOa5ot+OZD__Rg@mail.gmail.com>
 <38c0d683-46bc-42b1-86a1-345b2070084b@cherry.de>
 <PH0PR19MB997338FA72B2980A64B4194127A5DA2@PH0PR19MB997338.namprd19.prod.outlook.com>
 <CAOyTmd1JvBqRiuBPcLxkhF+x6yws6uOQ7z6vZqq3jrZkgj7+tg@mail.gmail.com>
 <an_Wqkp09sxijfxv@wintermute.localhost.fail>
 <PH0PR19MB9973381C3D06EF7593AE50C56DA5A72@PH0PR19MB997338.namprd19.prod.outlook.com>
In-Reply-To: <PH0PR19MB9973381C3D06EF7593AE50C56DA5A72@PH0PR19MB997338.namprd19.prod.outlook.com>
From: Daniel Martin <dmanlfc@gmail.com>
Date: Tue, 18 Aug 2026 09:04:31 +1000
X-Gm-Features: AcwNN1ViZy7CRl7aDdulxOJ9HcJps_j0WNUBMUJTMnmGsYKJe0dz4uzU6o23Vig
Message-ID: <CAOyTmd0QrejH5tR013FDOpMJu27UXf2BE1t87f9Skxm9uyLC8Q@mail.gmail.com>
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

That's great, thanks for the update Chris.
So maybe I'm missing something...
I didn't try `Arm Trusted Firmware` but I used rk3588_bl31_v1.54.elf
without Optee.
Does it need Optee? I assumed not as other RK3588 devices don't.

Let me try again on the weekend with ATF & LInux 7.2.

Dan

On Tue, 18 Aug 2026 at 03:34, Chris Morgan <macromorgan@hotmail.com> wrote:
>
> On Fri, Aug 14, 2026 at 10:02:05PM -0500, Chris Morgan wrote:
> > On Sat, Aug 15, 2026 at 10:06:23AM +1000, Daniel Martin wrote:
> > > Thanks for the further details Chris,
> > >
> > > It would indeed be great if we could move this device to mainline end=
-to-end.
> > > Let me know how you get on with v2026.07 and if possible, test your
> > > DTS with the stable kernel (7.1.8 or similar).
> > > When I reverted uboot, I encountered inconsistent I/O issues with the
> > > latest stable kernel, therefore I ended up going back to the BSP.
> > >
> > > Thanks for all your work, we appreciate the effort.
> > >
> > > Dan
> >
> > I've just tested booting the device with a completely unmodified
> > version of Arm Trusted Firmware (checked out at tag v2.15.0), U-Boot
> > (checked out at tag v2026.07 and changing nothing from the
> > gameforce-ace-rk3588s_defconfig), loading Linux 7.2 (tag v7.2-rc7) via
> > extlinux boot method and it seems to be working. I do note that it
> > seems to be slower to boot since I upgraded A-TF and U-Boot to the most
> > recent releases, so I'll troubleshoot that some more next week as I try
> > to install a fully up to date Ubuntu 26.04 on it.
> >
> > I know you said it's hard to get a serial port on it, but if you
> > continue to have problems booting it that might be required to
> > troubleshoot it further. Otherwise I can send you my binaries if
> > need be.
> >
> > Thank you,
> > Chris
>
> I'm afraid I cannot seem to recreate the problem, and I'm going to need
> a serial dump of the kernel logs. I'm sorry to ask that of you, but it
> will help further debug what the issue may be on your end. So far I've
> tested using a mainline kernel (v7.2 checked out this morning), U-Boot
> v2026.07, Arm Trusted Firmware (mainline master, checked out this
> morning OR the rkbin version, rk3588_bl31_v1.54.elf), optionally with
> Optee (master, checked out this morning). In each case the device boots
> successfully for me running Debian 13 (Forky) with my own mainline
> kernel.
>
> I'm going to test installing Ubuntu 26.04 and fusing some OTP keys
> later today, I'll let you know if I encounter further issues.
>
> Thank you,
> Chris
>
> >
> > >
> > >
> > > On Sat, 15 Aug 2026 at 07:40, Christopher Morgan
> > > <macromorgan@hotmail.com> wrote:
> > > >
> > > > I'm having trouble with my usual email client, so I'm sorry if this=
 message is formatted weird.
> > > >
> > > > I have tested the device most recently with 2026.04 with the defaul=
t defconfig options. I am using mainline Arm Trusted Firmware though, not t=
he Rockchip versions. Using Rockchip's A-TF should work, but again it's not=
 something I've tested. I can note that if you're using mainline A-TF along=
 with mainline Optee, you need to pass CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3DN=
, otherwise the device will fail to boot because it won't protect the Optee=
 regions. (For mainline A-TF CONFIG_SPL_ATF_NO_PLATFORM_PARAM is optional u=
nless you use Optee, for Rockchip's BL31 you need CONFIG_SPL_ATF_NO_PLATFOR=
M_PARAM=3DY).
> > > >
> > > > I'm going to test the device next week and see if I encounter any i=
ssues with it. I'll report back if I find out anything weird.
> > > >
> > > > Thank you,
> > > > Chris
> > > > ________________________________
> > > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > > Sent: Wednesday, August 12, 2026 10:22 AM
> > > > To: u-boot@lists.u-boot-project.org <u-boot@lists.u-boot-project.or=
g>; dmanlfc@gmail.com <dmanlfc@gmail.com>
> > > > Cc: Chris Morgan <macromorgan@hotmail.com>
> > > > Subject: Re: [BUG] rockchip: v2026.07 fails to boot on GameForce Ac=
e (RK3588S)
> > > >
> > > > +Cc Chris who maintains this board and may be able to help.
> > > >
> > > > I somehow didn't receive this mail in my inbox, here's my attempt a=
t
> > > > quoting text from a mail I didn't receive (and it's also not availa=
ble
> > > > on lore.kernel.org...).
> > > >
> > > >  > Hello,
> > > >  >
> > > >  > I am experiencing a total boot failure on the GameForce Ace hand=
held
> > > >  > console (Rockchip RK3588S) when trying to run mainline U-Boot
> > > >  > v2026.07.
> > > >  > The device fails to initialize or display any output during the
> > > >  > initial handshake.
> > > >  > Unfortunately, due to the tightly integrated form factor of this
> > > >  > handheld device, it is exceptionally difficult to break open the
> > > >  > casing and wire up a UART serial console to capture early boot l=
ogs.
> > > >  > The target operating system (Batocera Linux) environment is runn=
ing
> > > >  > the mainline Linux 7.1.5 kernel.
> > > >  > Given the complete lack of visible console output, I wanted to c=
heck:
> > > >  >
> > > >  > 1. Has the GameForce Ace board target been actively tested with =
the
> > > >  > v2026.07 release?
> > > >  > 2. Are there any specific or updated build instructions, BL31/TP=
L/SPL
> > > >  > combinations, or proprietary Rockchip firmware binary requiremen=
ts
> > > >  > (rkbin) needed for this release that may differ from previous
> > > >  > versions?
> > > >  >
> > > >  > For reference, the build configuration used was: gameforce-ace->
> > > > rk3588s_defconfig
> > > >  > TF-A / BL31 version: rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.21.bi=
n /
> > > >  > rk3588_bl31_v1.54.elf
> > > >  > Compiler: GCC 14.3
> > > >  > Linux 7.1.5 uses the rk3588s-gameforce-ace.dts
> > > >  >
> > > >  > Any guidance on known regressions regarding this target, or
> > > >  > recommendations on how to isolate the stage where it hangs witho=
ut a
> > > >  > hardware UART, would be greatly appreciated.
> > > >  >
> > > >
> > > > If you have a known working version of U-Boot, maybe start a bisect=
 with
> > > > that commit as good and 2026.07 as bad to isolate a commit that bro=
ke
> > > > the board.
> > > >
> > > > Cheers,
> > > > Quentin
> > >
> > >
> > >
> > > --
> > >
> > > Kind Regards,
> > >
> > > Daniel



--=20

Kind Regards,

Daniel
