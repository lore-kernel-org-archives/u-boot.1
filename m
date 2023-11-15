Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C5FC2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 747928622B;
	Wed, 15 Nov 2023 23:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oMbS3jl+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43AD886564; Wed, 15 Nov 2023 23:16:10 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 318E884956
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:16:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5a84204e7aeso1470907b3.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700086566; x=1700691366; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wU37ynQl/50ndI1EVYiUyDhClRlTG8e+hp7DAHTaDb0=;
 b=oMbS3jl+cuM3lBUpPG49V5L17N/Z8NdQyaw+miyVodGUwsxkx8jN8Lp4cDDgei9VLQ
 +uNIopzWKbU+fiW1uGKJ/oXDO0QQ7kvRsDkKIF+CTJvPg+YOqLZFOsvgl2SHtujDM7D7
 ymn7rP/trq2/H3avdgYQEpPakDd/B8UKLEeWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700086566; x=1700691366;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wU37ynQl/50ndI1EVYiUyDhClRlTG8e+hp7DAHTaDb0=;
 b=dP38hRTGQRSaq3vZPhIoc5hMqZp5LLnOyb1+QzTi01u/Lrke9B2yzTw22VhVx6nHtE
 20eZ3eyHVGOIqE1tkW5e5OxNyYjcYAMNqCjcZYv73HGBplf6NGqmUZG/RJJKmjMZlxfV
 S+94VXXwAgbZuJTbVbHXcITUvtHI8PlAhkLGLs0acgrNjgzKTEZjepwq0vzt9dw6QJis
 o+IeZowoqZrUrjfj3psxe7oGuLp+1Zh91ECo8OYKTYtSKfiwm2W8qqFlVhgnFPHJT3mZ
 DsdRMBDMsEWl/8zGq/zdi3xYA7HLW9z+na8rf2OvATMve4lONRHcRoIF/S6T2011fEQa
 iRlw==
X-Gm-Message-State: AOJu0YwrJWWPDPN4NalmmTpKGwq5nfT2nlT13+Lbh/Ul40/2Xl7uwnIC
 iywy50AhZRKgzJZh83EHEhOhD21Ay4/B4v02SEmnbw==
X-Google-Smtp-Source: AGHT+IHH7zI+bDWfgx7EvOt8/s0p/MKUm3xdntdsn2F65gPKOJTT4gaBWnKbbf4Sxkzm8eyQH0D8UHXt3xlV7Nv0V9k=
X-Received: by 2002:a81:6d0b:0:b0:577:51cd:1b4a with SMTP id
 i11-20020a816d0b000000b0057751cd1b4amr16367397ywc.41.1700086565664; Wed, 15
 Nov 2023 14:16:05 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2hrverfcsEEahUcRkcjrnF3jr0oyds2yo0RBVMB7E01g@mail.gmail.com>
 <CAPnjgZ1-_ohZaVwMGtTDt4-W--2q0AM2KPtX9RLgAbMEhMRugw@mail.gmail.com>
 <CAHc5_t1icj6d82GH+FK8qGg3MvDkpwEicH964ULcN971_=aSKg@mail.gmail.com>
 <CAHc5_t2vLU9gHufMS_Fjv6j5+E8ksgCCLzKQ7NxTHzJsdcmsNQ@mail.gmail.com>
 <CAPnjgZ3VY_M+zd2na+N9WCxj-L2F+KKhLgykQ21FTA7GPVrKNQ@mail.gmail.com>
 <CAHc5_t1fBzzpJaQed9kcKF92ProStsutmOBW-1jmi5vWFvLM8g@mail.gmail.com>
 <CAPnjgZ3WNmnNv7DjMFDM9Med3yRng32N6tku4NGxbwA5DRhQgA@mail.gmail.com>
 <CAHc5_t1H39YV=HSSa7TCEdzRctAX+zibkx1vsuwEW-raOL9TcA@mail.gmail.com>
In-Reply-To: <CAHc5_t1H39YV=HSSa7TCEdzRctAX+zibkx1vsuwEW-raOL9TcA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Nov 2023 15:15:46 -0700
Message-ID: <CAPnjgZ3V65sCuRV_NzJFZHL7-ZHq9SQUTxvvbj5GszFAhJ4WzA@mail.gmail.com>
Subject: Re: bug - bootflow: grub efi crashes when bootflow selected explicitly
To: Shantur Rathore <i@shantur.com>
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

Hi Shantur,

On Wed, 15 Nov 2023 at 15:13, Shantur Rathore <i@shantur.com> wrote:
>
> Hi Simon,
>
> I have figured out the cause of the crash.
> It happens here -
> https://github.com/u-boot/u-boot/blob/master/boot/bootflow.c#L470
> while doing - free(bflow->buf)
>
> As I understand it,
> - Just before starting kernel EFI binary calls usb-uclass->usb_stop()
> - This starts removing all devices in my case ( 6x usb_hub, 2x
> partition, 1x blk, 2x bootdev, 1x usb_maas_storage)
> - While removing bootdev, it ends up calling bootdev-uclass ->
> bootdev_pre_unbind -> bootdev_clear_bootflows which calls
> bootflow->bootflow_remove and bootflow_free
>
> I don't know why this buf cannot be freed, is it because the EFI
> binary in the buffer is still being used ( efi/boot/bootaa64.efi ) ?
> But commenting this line out fixes the crash and linux boots happily.
>
> Fixing this properly is above my pay grade as of now.

Great, thank you! I will send a patch.

Regards,
Simon

>
> Kind regards,
> Shantur
>
> On Wed, Nov 15, 2023 at 3:58=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Shantur,
> >
> > On Wed, 15 Nov 2023 at 08:23, Shantur Rathore <i@shantur.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > >
> > > > Is this the blue port on top of the USB-C connector?
> > > >
> > > Yes, that's correct.
> > > For my drive I needed -
> > > https://patchwork.ozlabs.org/project/uboot/patch/20231110141311.51233=
4-1-i@shantur.com/
> > >
> > > >
> > > > Which version of Armbian / download link?
> > > >
> > > https://redirect.armbian.com/rockpro64/Bookworm_current
> > >
> > > > Yes it is scanning first, before reading the efi app, etc.
> > > >
> > > > I have the same hardware so may be able to dig into this.
> > >
> > > Sorry, I meant to ask if anything specific to USB.
> > > I see it loads efi from the network or disk and calls bootefi with th=
e
> > > loaded address.
> > > I don't know deep boot / efi stuff, just trying to compare how it's
> > > loading efi differently than fatload in this case.
> >
> > There is nothing special about USB in boootstd, so far as I know.
> >
> > But until we figure out this bug, it is hard to be sure.
> >
> > Regards,
> > Simon
