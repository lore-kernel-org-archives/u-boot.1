Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C730DC48BC4
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 10:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D1C187DF9;
	Wed, 14 Feb 2024 11:01:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="ubh94yvY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF07687DF9; Wed, 14 Feb 2024 11:01:45 +0100 (CET)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A857387DEE
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 11:01:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4c009d2053fso1309195e0c.3
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 02:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1707904895; x=1708509695;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V92+zuafKtlQOJv/dlvy0pEQG31VTgQ2eAS+1zKrwJ0=;
 b=ubh94yvY+p/5K7sWafDjCnI71/KXdJnssglSDvkYIxHV18lHnLsEVctS+QBCN0O8IO
 gCzQfau/HX44B4n5jtLDDpqvFuOKGMnyu8Wk2iD7Lx/QgYn8eylG2WfwKfGUxUFGZqZP
 AVevtdyopwl/dzyuUYDZd/crEOA+NJ6oEua5JWXaXLQpJXG39F+TJweCV0mVK7jE0QrC
 9at9SRyJ/S1HB9O3prY8lnEhRmvnopgHZc72cwCcFh0rOe3nodyHBQmdOnVnbV6UOb/S
 4eZoB9Yd0EaRH/2mVh9Psk4qSFPAEc6NHD1nd8oApZ/O6QB+SNpVM5Rh6kdhGvuCYG6u
 gm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707904895; x=1708509695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V92+zuafKtlQOJv/dlvy0pEQG31VTgQ2eAS+1zKrwJ0=;
 b=pKd+dTN1xG7bpE4oeen2U1Vezc0jNYCgBMNXU1kdB0T78HzX6NxvuArsXu/mQXmv6L
 h6jcVIWMsSrycFQyzDAg7oHbQ+MM0HszrRWzMTONnfeEXteJYiF/n2cHw3JcfbHfc6h0
 OfnarI97aJONhavFCuERT+wzAlHw4TtNzag8jqcjvVNugD0FHxchMKWsjkrSxoEtwXv6
 noIK587uHiRttlKvTwvUPQyl7o10nwXspqgf332qBPasGUxKbA4EHnTCP7kbOop4UKps
 ayfF3nnaSj3v88eQGCnpC41tvaXtc72awc77FTl6IDgtgTTdOexiEYgVLiar2Wb8SfMD
 W2tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9BYRY+x3w+sNmTPbXdKwEQoKO9je+q0Bb/ij26N4JZkkZX0qJ/sOxZ2zXwiOkQF7pYL0HRkw0sRi14+ULTAgkSq9jag==
X-Gm-Message-State: AOJu0YyT0lQaq0Q08g01dZQ00ySkv5+c7UzyLWzY3U/lxV1FrklAPJEz
 4UNHghIpYEii93QPs3HzbbqwPp23hXTW01DeXwSaM6nrsqAnTm15wNXYmANyGc02KYIILrDkj9P
 kGXnxffZubO2SkZ3Fz/OUeQ/NmYjO3iAS6CUr9g==
X-Google-Smtp-Source: AGHT+IGI3fl7KOH0mR4L3Tmaokux0pMr8VXW8mqXocUlCUKZyf1plkxAFF8+fPdw39vsueYJ0GI8FglDonnsXD3uj98=
X-Received: by 2002:a1f:de82:0:b0:4c0:7d26:58da with SMTP id
 v124-20020a1fde82000000b004c07d2658damr2270954vkg.2.1707904895184; Wed, 14
 Feb 2024 02:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20240207102327.35125-1-i@shantur.com>
 <32db6dba-d515-4077-9d72-d77a7f431335@denx.de>
 <CABEcMwXW3KXQCJM16Qhk=19Sss3zdtQyWtJEed5y=na2mP8RFA@mail.gmail.com>
 <93f69779-3197-4ede-bb78-f2512ec30fc1@denx.de>
 <24f25359ce213370214bceeabc55e1df@manjaro.org>
 <CABEcMwUoyi5uLSADa2N76V3C-ryiXzYywgOKnL=DEqtU6LYa_w@mail.gmail.com>
 <a042e4fa90f02b5f51dd76c3dedf5ae1@manjaro.org>
 <3aa6998e3d9fd97cd4ba729f7656f467@manjaro.org>
 <CABEcMwXAjRLDcg+xP_td6cujPzPJNdQg8YHUjPNj8scea9cS-w@mail.gmail.com>
 <CABEcMwUvHJWTWykvD3w4HZ3H1fAZMAtMy3CYq_Dv6jnPuzYxdw@mail.gmail.com>
 <aa804978-0b1f-4ccd-a4be-f3608cad5ebd@denx.de>
 <20240214020413.662bfac6@minigeek.lan>
 <db00cf79606be59e9041b870c3f96507@manjaro.org>
 <e76980463dc9855eda493d5a30f307ee@manjaro.org>
 <CABEcMwX4mHjibZMxAUiJda36noMFvr7oeAm4cr6y=58NeAAGaA@mail.gmail.com>
In-Reply-To: <CABEcMwX4mHjibZMxAUiJda36noMFvr7oeAm4cr6y=58NeAAGaA@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Wed, 14 Feb 2024 10:01:24 +0000
Message-ID: <CABEcMwUtCk-jehZPWrCdBTKYoX8T+xixMVhJFmM2PxXB-paSLg@mail.gmail.com>
Subject: Re: [FIX PATCH v1] Fix: common: usb_hub: Reset only USB3.0 hub
To: Dragan Simic <dsimic@manjaro.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, 
 Hector Martin <marcan@marcan.st>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

On Wed, Feb 14, 2024 at 9:56=E2=80=AFAM Shantur Rathore <i@shantur.com> wro=
te:
>
> On Wed, Feb 14, 2024 at 3:48=E2=80=AFAM Dragan Simic <dsimic@manjaro.org>=
 wrote:
> >
> > Hello Shantur and Marek,
> >
> > On 2024-02-14 04:18, Dragan Simic wrote:
> > > On 2024-02-14 03:04, Andre Przywara wrote:
> > >> On Mon, 12 Feb 2024 21:19:13 +0100 Marek Vasut <marex@denx.de> wrote=
:
> > >>> On 2/12/24 14:41, Shantur Rathore wrote:
> > >>> > On Mon, Feb 12, 2024 at 1:40=E2=80=AFPM Shantur Rathore <i@shantu=
r.com> wrote:
> > >>> >> On Sat, Feb 10, 2024 at 7:13=E2=80=AFAM Dragan Simic <dsimic@man=
jaro.org> wrote:
> > >>> >>> On 2024-02-08 15:17, Dragan Simic wrote:
> > >>> >>>> On 2024-02-08 15:10, Shantur Rathore wrote:
> > >>> >>>>> On Thu, Feb 8, 2024 at 1:44=E2=80=AFPM Dragan Simic <dsimic@m=
anjaro.org>
> > >>> >>>>> wrote:
> > >>> >>>>>> On 2024-02-08 14:33, Marek Vasut wrote:
> > >>> >>>>>>> On 2/8/24 12:30, Shantur Rathore wrote:
> > >>> >>>>>>>> On Wed, Feb 7, 2024 at 1:07=E2=80=AFPM Marek Vasut <marex@=
denx.de> wrote:
> > >>> >>>>>>>>> On 2/7/24 11:23, Shantur Rathore wrote:
> > >>> >>>>>>>>>> USB 3.0 spec requires hub to reset device while
> > >>> >>>>>>>>>> enumeration. Some USB 2.0 hubs / devices don't
> > >>> >>>>>>>>>> handle this well and after implementation of
> > >>> >>>>>>>>>> reset some USB 2.0 disks weren't detected on
> > >>> >>>>>>>>>> Allwinner based boards.
> > >>> >>>>>>>>>>
> > >>> >>>>>>>>>> Resetting only when hub is USB 3.0 fixes it.
> > >>> >>>>>>>>>
> > >>> >>>>>>>>> It would be good to include as many details about the fau=
lty hardware
> > >>> >>>>>>>>> in
> > >>> >>>>>>>>> the commit message as possible, so that when someone else=
 runs into
> > >>> >>>>>>>>> this, they would have all that information available.
> > >>> >>>>>>>>>
> > >>> >>>>>>>>>> Tested-by: Andre Przywara <andre.przywara@arm.com>
> > >>> >>>>>>>>>>
> > >>> >>>>>>>>>> Signed-off-by: Shantur Rathore <i@shantur.com>
> > >>> >>>>>>>>>> ---
> > >>> >>>>>>>>>>
> > >>> >>>>>>>>>>     common/usb_hub.c | 6 ++++--
> > >>> >>>>>>>>>>     1 file changed, 4 insertions(+), 2 deletions(-)
> > >>> >>>>>>>>>>
> > >>> >>>>>>>>>> diff --git a/common/usb_hub.c b/common/usb_hub.c
> > >>> >>>>>>>>>> index 3fb7e14d10..2e054eb935 100644
> > >>> >>>>>>>>>> --- a/common/usb_hub.c
> > >>> >>>>>>>>>> +++ b/common/usb_hub.c
> > >>> >>>>>>>>>> @@ -174,8 +174,10 @@ static void usb_hub_power_on(struct
> > >>> >>>>>>>>>> usb_hub_device *hub)
> > >>> >>>>>>>>>>
> > >>> >>>>>>>>>>         debug("enabling power on all ports\n");
> > >>> >>>>>>>>>>         for (i =3D 0; i < dev->maxchild; i++) {
> > >>> >>>>>>>>>> -             usb_set_port_feature(dev, i + 1, USB_PORT_=
FEAT_RESET);
> > >>> >>>>>>>>>> -             debug("Reset : port %d returns %lX\n", i +=
 1,
> > >>> >>>>>>>>>> dev->status);
> > >>> >>>>>>>>>> +             if (usb_hub_is_superspeed(dev)) {
> > >>> >>>>>>>>>
> > >>> >>>>>>>>> Should this condition be "all which are lower than supers=
peed"
> > >>> >>>>>>>>> instead ,
> > >>> >>>>>>>>> so when the next generation of USB comes, this problem wo=
n't trigger
> > >>> >>>>>>>>> ?
> > >>> >>>>>>>>>
> > >>> >>>>>>>>> What does Linux do btw ?
> > >>> >>>>>>>>
> > >>> >>>>>>>> As of now Linux checks if the hub is superspeed
> > >>> >>>>>>>> https://github.com/torvalds/linux/blob/master/drivers/usb/=
core/hub.c#L2859
> > >>> >>>>>>>>
> > >>> >>>>>>>> which is
> > >>> >>>>>>>>    return hdev->descriptor.bDeviceProtocol =3D=3D USB_HUB_=
PR_SS; //
> > >>> >>>>>>>> USB_HUB_PR_SS =3D 3
> > >>> >>>>>>>>
> > >>> >>>>>>>> This holds true for newer SuperSpeedPlus hubs as well.
> > >>> >>>>>>>> https://github.com/torvalds/linux/blob/master/drivers/usb/=
core/hub.h#L155
> > >>> >>>>>>>>
> > >>> >>>>>>>> We can change the check to be  bDeviceProtocol > 2 but who=
 knows if
> > >>> >>>>>>>> things change in the newer version of spec.
> > >>> >>>>>>>> I am open to suggestions.
> > >>> >>>>>>>
> > >>> >>>>>>> Please just include the ^ in the commit description. Use li=
nk to
> > >>> >>>>>>> git.kernel.org , not some mirror . This is extremely useful
> > >>> >>>>>>> information and, well, you already wrote the V2 commit mess=
age
> > >>> >>>>>>> addition in this answer.
> > >>> >>>>>>
> > >>> >>>>>> Shantur, if that would be easier or quicker for you, I can w=
rite
> > >>> >>>>>> a quite detailed patch description for you, in exchange for =
a
> > >>> >>>>>> "Helped-by" tag in the v2 patch submission. :)
> > >>> >>>>>
> > >>> >>>>> That would be really kind of you Dragan.
> > >>> >>>>
> > >>> >>>> Sure, I'll write the summary and send it over.
> > >>> >>>>
> > >>> >>>>> I am down with the flu so that would really help me as my bra=
in is
> > >>> >>>>> working at 15% capacity.
> > >>> >>>>
> > >>> >>>> Oh, I'm really sorry to hear that. :(  I hope you'll get bette=
r
> > >>> >>>> soon, and I know very well what's it like;  I've also been sic=
k
> > >>> >>>> recently, as a result of some kind of flu that unfortunately f=
ound
> > >>> >>>> its way into my lungs, and it took me about a month to get bac=
k
> > >>> >>>> to about 90% of my usual mental capacity.  I'm still not back =
to
> > >>> >>>> exactly 100%. :/
> > >>> >>>>
> > >>> >>>> I really hope you'll recover much faster.
> > >>> >>>
> > >>> >>> I hope you're feeling better.
> > >>> >>>
> > >>> >>> Below are the patch subject and description that I prepared for=
 you,
> > >>> >>> please have a look.
> > >>> >>>
> > >>> >>> ------- >8 ------------- >8 ------------- >8 ------------- >8 -=
------
> > >>> >>> [PATCH v2] common: usb-hub: Reset USB 3.0 hubs only
> > >>> >>>
> > >>> >>> Additional testing of the changes introduced in commit 33e06dcb=
e57a
> > >>> >>> ("common:
> > >>> >>> usb-hub: Reset hub port before scanning") revealed that some US=
B 3.0
> > >>> >>> flash
> > >>> >>
> > >>> >> I think it was a USB 2.0 drive that didn't work on the USB 2.0 p=
ort.
> > >>> >>
> > >>> >>> drives didn't work in U-Boot on some Allwinner SoCs that suppor=
t USB 2.0
> > >>> >>> only.
> > >>> >>> More precisely, some tested USB 3.0 flash drives failed to be d=
etected
> > >>> >>> and
> > >>> >>> work on an OrangePi Zero 3 with Allwinner H616 SoC, which suppo=
rts USB
> > >>> >>> 2.0
> > >>> >>> only, while the same USB flash drives worked just fine on a Pin=
e64 H64
> > >>> >>> with
> > >>> >>> Allwinner H6 SoC, which supports both USB 2.0 and 3.0.
> > >>> >>>
> > >>> >>> Resetting USB 3.0 hubs only has been tested to work as expected=
,
> > >>> >>> resolving
> > >>> >>> the previous issues on the Allwinner H616, while not introducin=
g any new
> > >>> >>> issues on other Allwinner SoCs.  Thus, let's fix it that way.
> > >>> >>>
> > >>> >>> According to the USB 3.0 specification, resetting a USB 3.0 por=
t is
> > >>> >>> required
> > >>> >>> when an attached USB device transitions between different state=
s, such
> > >>> >>> as
> > >>> >>> when it resumes from suspend.  Though, the Linux kernel perform=
s
> > >>> >>> additional
> > >>> >>> USB 3.0 port resets upon initial USB device attachment, presuma=
bly to
> > >>> >>> ensure
> > >>> >>> proper state of the USB 3.0 hub port and proper USB mode negoti=
ation
> > >>> >>> during
> > >>> >>> the initial USB device attachment and enumeration.
> > >>> >>>
> > >>> >>> Such USB port resets don't seem to exist for USB 2.0 hubs, acco=
rding the
> > >>> >>> USB
> > >>> >>> 2.0 specification.  The resets seem to be added to the USB 3.0
> > >>> >>> specification
> > >>> >>> as part of the port and device mode negotiation.
> > >>> >>>
> > >>> >>> The Linux kernel also resets USB 3.0 (i.e. SuperSpeed) hubs onl=
y, as
> > >>> >>> visible
> > >>> >>> in file drivers/usb/core/hub.c in the kernel source, line 2859.=
  This
> > >>> >>> check
> > >>> >>> also applies to newer SuperSpeed Plus (USB 3.1 or 3.2) hubs as =
well,
> > >>> >>> which
> > >>> >>> hopefully makes it future proof.
> > >>> >>>
> > >>> >>> Fixes: 33e06dcbe57a ("common: usb-hub: Reset hub port before sc=
anning")
> > >>> >>> Link:
> > >>> >>> https://lore.kernel.org/u-boot/20240207102327.35125-1-i@shantur=
.com/T/#u
> > >>> >>> Link:
> > >>> >>> https://lore.kernel.org/u-boot/20240201164604.13315fa6@donnerap=
.manchester.arm.com/T/#u
> > >>> >>> Signed-off-by: Shantur Rathore <i@shantur.com>
> > >>> >>> Helped-by: Dragan Simic <dsimic@manjaro.org>
> > >>> >>> Tested-by: Andre Przywara <andre.przywara@arm.com>
> > >>> >>> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> > >>> >>> ------- >8 ------------- >8 ------------- >8 ------------- >8 -=
------
> > >>> >>
> > >>> >> Regards,
> > >>> >> Shantur
> > >>> >
> > >>> > Is this description acceptable to you Marek.
> > >>>
> > >>> Please send a V2 patch . If possible, include the device informatio=
n
> > >>> as
> > >>> reported by Andre, esp. which USB stick triggered it, including USB
> > >>> IDs,
> > >>> this is important for future reference and in case someone has
> > >>> similar
> > >>> failure.
> > >>
> > >> So the USB 2.0 stick is some no-name, unlabelled and super cheap one=
,
> > >> I
> > >> think we bought a pack of it, just for boot-strapping machines. The
> > >> USB
> > >> ID of "abcd:1234" kind of gives away that this is bogus AF.
> > >> The USB 3.0 stick is a PNY 32GB one, the USB ID is:
> > >> 1f75:0917 Innostor Technology Corporation IS917 Mass storage
> > >>
> > >> Hope that helps.
> > >
> > > Thank you for replying.  I'll include the available information into
> > > the revised commit description and send it over a bit later.
> >
> > Here are the revised commit subject and description, please have a look
> > and let me know if further improvements are needed.
> >
> > ------- >8 ------------- >8 ------------- >8 ------------- >8 -------
> > [PATCH v2] common: usb-hub: Reset USB 3.0 hubs only
> >
> > Additional testing of the changes introduced in commit 33e06dcbe57a
> > ("common:
> > usb-hub: Reset hub port before scanning") revealed that some USB 2.0 an=
d
> > 3.0
> > flash drives didn't work in U-Boot on some Allwinner SoCs that support
> > USB
> > 2.0 interfaces only.  More precisely, some of the tested USB 2.0 and 3.=
0
> > flash drives failed to be detected and work on an OrangePi Zero 3, base=
d
> > on
> > the Allwinner H616 SoC that supports USB 2.0 only, while the same USB
> > flash
> > drives worked just fine on a Pine64 H64, based on the Allwinner H6 SoC
> > that
> > supports both USB 2.0 and USB 3.0 interfaces.
> >
> > The USB ID of the above-mentioned USB 3.0 flash drive that failed to
> > work is
> > 1f75:0917 (Innostor Technology Corporation IS917 Mass storage), it is 3=
2
> > GB
> > in size and sold under the PNY brand.  The mentioned USB 2.0 drive is
> > some
> > inexpensive no-name drive with an invalid USB ID.
> >
> > Resetting USB 3.0 hubs only, which this patch introduces to the USB hub
> > resets, has been tested to work as expected, resolving the identified
> > issues
> > on the Allwinner H616, while not introducing any new issues on other
> > tested
> > Allwinner SoCs.  Thus, let's fix it that way.
> >
> > According to the USB 3.0 specification, resetting a USB 3.0 port is
> > required
> > when an attached USB device transitions between different states, such
> > as
> > when it resumes from suspend.  Though, the Linux kernel performs
> > additional
> > USB 3.0 port resets upon initial USB device attachment, as visible in
> > commit
> > 07194ab7be63 ("USB: Reset USB 3.0 devices on (re)discovery") in the
> > kernel
> > source, to ensure proper state of the USB 3.0 hub port and proper USB
> > mode
> > negotiation during the initial USB device attachment and enumeration.
> >
> > These additional types of USB port resets don't exist for USB 2.0 hubs,
> > according the USB 2.0 specification.  The resets seem to be added to th=
e
> > USB
> > 3.0 specification as part of the port and device mode negotiation.
> >
> > The Linux kernel resets USB 3.0 (i.e. SuperSpeed) hubs only, as visible
> > in
> > commit 10d674a82e55 ("USB: When hot reset for USB3 fails, try warm
> > reset.")
> > in the kernel source.  The check for SuperSpeed hubs is performed in a
> > way
> > that also applies to newer SuperSpeed Plus (USB 3.1 or 3.2) hubs as
> > well,
> > which hopefully makes it future proof.
> >
> > Fixes: 33e06dcbe57a ("common: usb-hub: Reset hub port before scanning")
> > Link:
> > https://lore.kernel.org/u-boot/20240207102327.35125-1-i@shantur.com/T/#=
u
> > Link:
> > https://lore.kernel.org/u-boot/20240201164604.13315fa6@donnerap.manches=
ter.arm.com/T/#u
> > Signed-off-by: Shantur Rathore <i@shantur.com>
> > Helped-by: Dragan Simic <dsimic@manjaro.org>
> > Tested-by: Andre Przywara <andre.przywara@arm.com>
> > Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> > ------- >8 ------------- >8 ------------- >8 ------------- >8 -------
> >
> > Shantur, I hope you're feeling better.
>
> Thanks Dragan, V2 is submitted.
> I am feeling much better, thanks for asking.

PS : I don't think I could ever explain as well as you did Dragan.
Thanks a lot for the help.

I will bring another pending matter to your attention on the Linux list now=
 ;P
