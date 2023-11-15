Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F51C2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C213386F31;
	Wed, 15 Nov 2023 23:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="iK2OqMgM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E41586F53; Wed, 15 Nov 2023 23:13:46 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A7AF86564
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-507962561adso211732e87.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700086423; x=1700691223;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGQc0/wPv+R4p6SndqzW5s6c63rexPnHmkPHw+kbVlo=;
 b=iK2OqMgMl9rX6lAlCV8QWQKOCOP28lE9RAHAobVdMCcAZi4Dt4cHbaCXi5XbPtbea1
 u21J4FwJ8Odq+0A+WhL/ZXLyNmSjwmuMNtPXd1uXcOPHoxAqW03AaooNmcFgqxZbzyrP
 MpQaTh8v/mGNwyODREGvFEQ0M4FqKrv2j4ILFUq1U+qiRtPJmhdnUmhGKZZ09yz+Ub8U
 NFQQV2Z6L3S3OM+zklPBSEJkOylech0MW8wP0XXiumAUKkgDqW1WZtN15d9Ds8LVZow2
 BrK3zd0i+LZ4mwF8JeT5PlzbkLk8bC9Fmlo74xUjV+dGF4SdgYBVk/FtpHygqs+h43L1
 +FdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700086423; x=1700691223;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GGQc0/wPv+R4p6SndqzW5s6c63rexPnHmkPHw+kbVlo=;
 b=jZU1BXaAahQC1FDmwOg277VCfEnQJ9ZKRT25SltWQxt/GheA1YvU3b7brZqkgWA3d5
 ZmgxeVzZZYYjzuL/mFYgkPRX02f6de/9sMrd6QYkiNsvuS4lgCVZNmk7W4XRDIBr33qe
 JSuXK377ySeIy3nsXJwiOsKC3t/tFlHSaIbazBHbZcnaDURwzEM2eC9VnooZtPB4xRIM
 RcOU74jHFNVP7u4HQDpxxro7Bcg/q4jA1FOBx0mCLdGdOELuuBeL65YY4bfMnixW5Kii
 FWJgEI9OP8yMOJMwS3dV5xAjUtdVTS+WljdVHJP5sQBCuuL3RjjELllTLHeYqq2bgefm
 IMng==
X-Gm-Message-State: AOJu0Ywe0OMQiOWXmD/E/XA9lsrEs324NUW/CbfEvqPKvsr1FHbiOufd
 gCEQLTX8lxqUn8+Alkqldruaodw/BBQW/KVCQhNx7Mgc
X-Google-Smtp-Source: AGHT+IHXp9A+ygsxLsCyxBCMwHQuhuaN3HMeR4fBGJfh9CjeIPtuJMCABFbzt4NugfxbfodGL0dFFg==
X-Received: by 2002:a19:8c10:0:b0:50a:9652:31d4 with SMTP id
 o16-20020a198c10000000b0050a965231d4mr2475977lfd.22.1700086422800; 
 Wed, 15 Nov 2023 14:13:42 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com.
 [209.85.208.44]) by smtp.gmail.com with ESMTPSA id
 lr18-20020a170906fb9200b009b2ca104988sm7573082ejb.98.2023.11.15.14.13.42
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 14:13:42 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-545ed16b137so250641a12.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:13:42 -0800 (PST)
X-Received: by 2002:a05:6402:2756:b0:544:a27c:f7b6 with SMTP id
 z22-20020a056402275600b00544a27cf7b6mr13002786edd.8.1700086421929; Wed, 15
 Nov 2023 14:13:41 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2hrverfcsEEahUcRkcjrnF3jr0oyds2yo0RBVMB7E01g@mail.gmail.com>
 <CAPnjgZ1-_ohZaVwMGtTDt4-W--2q0AM2KPtX9RLgAbMEhMRugw@mail.gmail.com>
 <CAHc5_t1icj6d82GH+FK8qGg3MvDkpwEicH964ULcN971_=aSKg@mail.gmail.com>
 <CAHc5_t2vLU9gHufMS_Fjv6j5+E8ksgCCLzKQ7NxTHzJsdcmsNQ@mail.gmail.com>
 <CAPnjgZ3VY_M+zd2na+N9WCxj-L2F+KKhLgykQ21FTA7GPVrKNQ@mail.gmail.com>
 <CAHc5_t1fBzzpJaQed9kcKF92ProStsutmOBW-1jmi5vWFvLM8g@mail.gmail.com>
 <CAPnjgZ3WNmnNv7DjMFDM9Med3yRng32N6tku4NGxbwA5DRhQgA@mail.gmail.com>
In-Reply-To: <CAPnjgZ3WNmnNv7DjMFDM9Med3yRng32N6tku4NGxbwA5DRhQgA@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Wed, 15 Nov 2023 22:13:30 +0000
X-Gmail-Original-Message-ID: <CAHc5_t1H39YV=HSSa7TCEdzRctAX+zibkx1vsuwEW-raOL9TcA@mail.gmail.com>
Message-ID: <CAHc5_t1H39YV=HSSa7TCEdzRctAX+zibkx1vsuwEW-raOL9TcA@mail.gmail.com>
Subject: Re: bug - bootflow: grub efi crashes when bootflow selected explicitly
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Simon,

I have figured out the cause of the crash.
It happens here -
https://github.com/u-boot/u-boot/blob/master/boot/bootflow.c#L470
while doing - free(bflow->buf)

As I understand it,
- Just before starting kernel EFI binary calls usb-uclass->usb_stop()
- This starts removing all devices in my case ( 6x usb_hub, 2x
partition, 1x blk, 2x bootdev, 1x usb_maas_storage)
- While removing bootdev, it ends up calling bootdev-uclass ->
bootdev_pre_unbind -> bootdev_clear_bootflows which calls
bootflow->bootflow_remove and bootflow_free

I don't know why this buf cannot be freed, is it because the EFI
binary in the buffer is still being used ( efi/boot/bootaa64.efi ) ?
But commenting this line out fixes the crash and linux boots happily.

Fixing this properly is above my pay grade as of now.

Kind regards,
Shantur

On Wed, Nov 15, 2023 at 3:58=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Shantur,
>
> On Wed, 15 Nov 2023 at 08:23, Shantur Rathore <i@shantur.com> wrote:
> >
> > Hi Simon,
> >
> > >
> > > Is this the blue port on top of the USB-C connector?
> > >
> > Yes, that's correct.
> > For my drive I needed -
> > https://patchwork.ozlabs.org/project/uboot/patch/20231110141311.512334-=
1-i@shantur.com/
> >
> > >
> > > Which version of Armbian / download link?
> > >
> > https://redirect.armbian.com/rockpro64/Bookworm_current
> >
> > > Yes it is scanning first, before reading the efi app, etc.
> > >
> > > I have the same hardware so may be able to dig into this.
> >
> > Sorry, I meant to ask if anything specific to USB.
> > I see it loads efi from the network or disk and calls bootefi with the
> > loaded address.
> > I don't know deep boot / efi stuff, just trying to compare how it's
> > loading efi differently than fatload in this case.
>
> There is nothing special about USB in boootstd, so far as I know.
>
> But until we figure out this bug, it is hard to be sure.
>
> Regards,
> Simon
