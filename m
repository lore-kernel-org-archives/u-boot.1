Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B29C48BEB
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 09:57:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3D8287DEE;
	Wed, 14 Feb 2024 10:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="kRe37DYt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CF2487DF5; Wed, 14 Feb 2024 10:57:14 +0100 (CET)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7AC28798D
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 10:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4c02dfa01a8so1079701e0c.1
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 01:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1707904622; x=1708509422;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JqdvVBeNIAS0n3Kw8RjC75E7+1Pyl4YOt0WXe3qHF98=;
 b=kRe37DYtSelsHeVkM07WF068rxsYd4JiCpHiC27BvZU4eLtCx8frAkWfmGDne7KHUh
 mVSQe6V0kndNN5Yymi6fxLQNfn/yo+lIn+HXjwYgQOgl/qZuszXwef+fTMhxiiY59uO0
 dficS65neVloedT5aL+wZFhe2YrCbWkij52NvfTREqK5msJ0QCnGHWytqYINFuKmAAk1
 oU85BrQpoO6hfHCOh11mCkf8dtGEImtQSPfmIg4JhyBoeKbY51Ia5BSYeOjifn/Rwuu8
 f3vGDAX6sxtcGi4EVBPH2zZ4yen48yQ4GVf5EzZd5XBVO8mKzv3U7H0OHsd9yAzuCwUZ
 /pSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707904622; x=1708509422;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JqdvVBeNIAS0n3Kw8RjC75E7+1Pyl4YOt0WXe3qHF98=;
 b=mMDuP6e0RAplhct3Mk4ou09uppr6pl7ywHdbWQi7dqKTqeuO+0rvyBsQWTr8Xa5D+F
 Tp4T7qwTC7pq2HETrnmDyfRpevCqptkFNNctGlgIg5/NohNMKojZFT9eV7x9FiS1DWTG
 m8vhDcBoW0kTjqmfII2C3B/SBLkCda6JWHWFDnrx8V4NFHir6q/NwJ10yhvg0bIkMjeO
 CClGsqv70UpYW/97mf54UfXj72nFuN6TwwkFDCL6ag8k6aD/bVLGrVHouI0dZYtfK3X1
 rEPeCura70tM1vIAByVpNaAOT4P24tGyZThn8B7liedDCCK58N6semV+1n38TRyCLma7
 TP4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5tUZVxFIiuDS/7+Oou/+37mUj9deIcfwranZrLZpM0svtGnbnEQXVunOE2JmvgJFxOqe+MUZF5O2WDOm8AnZsnap7tg==
X-Gm-Message-State: AOJu0YzfMd3+4XxZepcQxTdtKFZ8PW2/Iql0yH85SFck4eUD+XMbCEEu
 X3XVOc61BKg0Zt9IhYmxE/u+oZJl0ZjzyciDW5+ot163DWMc3l6D2NLq5MzOm4lM7PgAoWt7U2Z
 ZLtqpiT6LW6yUnBYz/u5NTP7bZ/mFcGb5/AXCrw==
X-Google-Smtp-Source: AGHT+IFccdblUbXglFx9Fc4BjwrZmyaIOVEhA7lkPmyKqtgFHbOmW8KsYVaSqxKbnsrTFeSCX4Gv55qWdZjN4V1ZEy8=
X-Received: by 2002:a1f:6284:0:b0:4bd:8926:8e15 with SMTP id
 w126-20020a1f6284000000b004bd89268e15mr1813156vkb.0.1707904622455; Wed, 14
 Feb 2024 01:57:02 -0800 (PST)
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
In-Reply-To: <e76980463dc9855eda493d5a30f307ee@manjaro.org>
From: Shantur Rathore <i@shantur.com>
Date: Wed, 14 Feb 2024 09:56:51 +0000
Message-ID: <CABEcMwX4mHjibZMxAUiJda36noMFvr7oeAm4cr6y=58NeAAGaA@mail.gmail.com>
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

On Wed, Feb 14, 2024 at 3:48=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Shantur and Marek,
>
> On 2024-02-14 04:18, Dragan Simic wrote:
> > On 2024-02-14 03:04, Andre Przywara wrote:
> >> On Mon, 12 Feb 2024 21:19:13 +0100 Marek Vasut <marex@denx.de> wrote:
> >>> On 2/12/24 14:41, Shantur Rathore wrote:
> >>> > On Mon, Feb 12, 2024 at 1:40=E2=80=AFPM Shantur Rathore <i@shantur.=
com> wrote:
> >>> >> On Sat, Feb 10, 2024 at 7:13=E2=80=AFAM Dragan Simic <dsimic@manja=
ro.org> wrote:
> >>> >>> On 2024-02-08 15:17, Dragan Simic wrote:
> >>> >>>> On 2024-02-08 15:10, Shantur Rathore wrote:
> >>> >>>>> On Thu, Feb 8, 2024 at 1:44=E2=80=AFPM Dragan Simic <dsimic@man=
jaro.org>
> >>> >>>>> wrote:
> >>> >>>>>> On 2024-02-08 14:33, Marek Vasut wrote:
> >>> >>>>>>> On 2/8/24 12:30, Shantur Rathore wrote:
> >>> >>>>>>>> On Wed, Feb 7, 2024 at 1:07=E2=80=AFPM Marek Vasut <marex@de=
nx.de> wrote:
> >>> >>>>>>>>> On 2/7/24 11:23, Shantur Rathore wrote:
> >>> >>>>>>>>>> USB 3.0 spec requires hub to reset device while
> >>> >>>>>>>>>> enumeration. Some USB 2.0 hubs / devices don't
> >>> >>>>>>>>>> handle this well and after implementation of
> >>> >>>>>>>>>> reset some USB 2.0 disks weren't detected on
> >>> >>>>>>>>>> Allwinner based boards.
> >>> >>>>>>>>>>
> >>> >>>>>>>>>> Resetting only when hub is USB 3.0 fixes it.
> >>> >>>>>>>>>
> >>> >>>>>>>>> It would be good to include as many details about the fault=
y hardware
> >>> >>>>>>>>> in
> >>> >>>>>>>>> the commit message as possible, so that when someone else r=
uns into
> >>> >>>>>>>>> this, they would have all that information available.
> >>> >>>>>>>>>
> >>> >>>>>>>>>> Tested-by: Andre Przywara <andre.przywara@arm.com>
> >>> >>>>>>>>>>
> >>> >>>>>>>>>> Signed-off-by: Shantur Rathore <i@shantur.com>
> >>> >>>>>>>>>> ---
> >>> >>>>>>>>>>
> >>> >>>>>>>>>>     common/usb_hub.c | 6 ++++--
> >>> >>>>>>>>>>     1 file changed, 4 insertions(+), 2 deletions(-)
> >>> >>>>>>>>>>
> >>> >>>>>>>>>> diff --git a/common/usb_hub.c b/common/usb_hub.c
> >>> >>>>>>>>>> index 3fb7e14d10..2e054eb935 100644
> >>> >>>>>>>>>> --- a/common/usb_hub.c
> >>> >>>>>>>>>> +++ b/common/usb_hub.c
> >>> >>>>>>>>>> @@ -174,8 +174,10 @@ static void usb_hub_power_on(struct
> >>> >>>>>>>>>> usb_hub_device *hub)
> >>> >>>>>>>>>>
> >>> >>>>>>>>>>         debug("enabling power on all ports\n");
> >>> >>>>>>>>>>         for (i =3D 0; i < dev->maxchild; i++) {
> >>> >>>>>>>>>> -             usb_set_port_feature(dev, i + 1, USB_PORT_FE=
AT_RESET);
> >>> >>>>>>>>>> -             debug("Reset : port %d returns %lX\n", i + 1=
,
> >>> >>>>>>>>>> dev->status);
> >>> >>>>>>>>>> +             if (usb_hub_is_superspeed(dev)) {
> >>> >>>>>>>>>
> >>> >>>>>>>>> Should this condition be "all which are lower than superspe=
ed"
> >>> >>>>>>>>> instead ,
> >>> >>>>>>>>> so when the next generation of USB comes, this problem won'=
t trigger
> >>> >>>>>>>>> ?
> >>> >>>>>>>>>
> >>> >>>>>>>>> What does Linux do btw ?
> >>> >>>>>>>>
> >>> >>>>>>>> As of now Linux checks if the hub is superspeed
> >>> >>>>>>>> https://github.com/torvalds/linux/blob/master/drivers/usb/co=
re/hub.c#L2859
> >>> >>>>>>>>
> >>> >>>>>>>> which is
> >>> >>>>>>>>    return hdev->descriptor.bDeviceProtocol =3D=3D USB_HUB_PR=
_SS; //
> >>> >>>>>>>> USB_HUB_PR_SS =3D 3
> >>> >>>>>>>>
> >>> >>>>>>>> This holds true for newer SuperSpeedPlus hubs as well.
> >>> >>>>>>>> https://github.com/torvalds/linux/blob/master/drivers/usb/co=
re/hub.h#L155
> >>> >>>>>>>>
> >>> >>>>>>>> We can change the check to be  bDeviceProtocol > 2 but who k=
nows if
> >>> >>>>>>>> things change in the newer version of spec.
> >>> >>>>>>>> I am open to suggestions.
> >>> >>>>>>>
> >>> >>>>>>> Please just include the ^ in the commit description. Use link=
 to
> >>> >>>>>>> git.kernel.org , not some mirror . This is extremely useful
> >>> >>>>>>> information and, well, you already wrote the V2 commit messag=
e
> >>> >>>>>>> addition in this answer.
> >>> >>>>>>
> >>> >>>>>> Shantur, if that would be easier or quicker for you, I can wri=
te
> >>> >>>>>> a quite detailed patch description for you, in exchange for a
> >>> >>>>>> "Helped-by" tag in the v2 patch submission. :)
> >>> >>>>>
> >>> >>>>> That would be really kind of you Dragan.
> >>> >>>>
> >>> >>>> Sure, I'll write the summary and send it over.
> >>> >>>>
> >>> >>>>> I am down with the flu so that would really help me as my brain=
 is
> >>> >>>>> working at 15% capacity.
> >>> >>>>
> >>> >>>> Oh, I'm really sorry to hear that. :(  I hope you'll get better
> >>> >>>> soon, and I know very well what's it like;  I've also been sick
> >>> >>>> recently, as a result of some kind of flu that unfortunately fou=
nd
> >>> >>>> its way into my lungs, and it took me about a month to get back
> >>> >>>> to about 90% of my usual mental capacity.  I'm still not back to
> >>> >>>> exactly 100%. :/
> >>> >>>>
> >>> >>>> I really hope you'll recover much faster.
> >>> >>>
> >>> >>> I hope you're feeling better.
> >>> >>>
> >>> >>> Below are the patch subject and description that I prepared for y=
ou,
> >>> >>> please have a look.
> >>> >>>
> >>> >>> ------- >8 ------------- >8 ------------- >8 ------------- >8 ---=
----
> >>> >>> [PATCH v2] common: usb-hub: Reset USB 3.0 hubs only
> >>> >>>
> >>> >>> Additional testing of the changes introduced in commit 33e06dcbe5=
7a
> >>> >>> ("common:
> >>> >>> usb-hub: Reset hub port before scanning") revealed that some USB =
3.0
> >>> >>> flash
> >>> >>
> >>> >> I think it was a USB 2.0 drive that didn't work on the USB 2.0 por=
t.
> >>> >>
> >>> >>> drives didn't work in U-Boot on some Allwinner SoCs that support =
USB 2.0
> >>> >>> only.
> >>> >>> More precisely, some tested USB 3.0 flash drives failed to be det=
ected
> >>> >>> and
> >>> >>> work on an OrangePi Zero 3 with Allwinner H616 SoC, which support=
s USB
> >>> >>> 2.0
> >>> >>> only, while the same USB flash drives worked just fine on a Pine6=
4 H64
> >>> >>> with
> >>> >>> Allwinner H6 SoC, which supports both USB 2.0 and 3.0.
> >>> >>>
> >>> >>> Resetting USB 3.0 hubs only has been tested to work as expected,
> >>> >>> resolving
> >>> >>> the previous issues on the Allwinner H616, while not introducing =
any new
> >>> >>> issues on other Allwinner SoCs.  Thus, let's fix it that way.
> >>> >>>
> >>> >>> According to the USB 3.0 specification, resetting a USB 3.0 port =
is
> >>> >>> required
> >>> >>> when an attached USB device transitions between different states,=
 such
> >>> >>> as
> >>> >>> when it resumes from suspend.  Though, the Linux kernel performs
> >>> >>> additional
> >>> >>> USB 3.0 port resets upon initial USB device attachment, presumabl=
y to
> >>> >>> ensure
> >>> >>> proper state of the USB 3.0 hub port and proper USB mode negotiat=
ion
> >>> >>> during
> >>> >>> the initial USB device attachment and enumeration.
> >>> >>>
> >>> >>> Such USB port resets don't seem to exist for USB 2.0 hubs, accord=
ing the
> >>> >>> USB
> >>> >>> 2.0 specification.  The resets seem to be added to the USB 3.0
> >>> >>> specification
> >>> >>> as part of the port and device mode negotiation.
> >>> >>>
> >>> >>> The Linux kernel also resets USB 3.0 (i.e. SuperSpeed) hubs only,=
 as
> >>> >>> visible
> >>> >>> in file drivers/usb/core/hub.c in the kernel source, line 2859.  =
This
> >>> >>> check
> >>> >>> also applies to newer SuperSpeed Plus (USB 3.1 or 3.2) hubs as we=
ll,
> >>> >>> which
> >>> >>> hopefully makes it future proof.
> >>> >>>
> >>> >>> Fixes: 33e06dcbe57a ("common: usb-hub: Reset hub port before scan=
ning")
> >>> >>> Link:
> >>> >>> https://lore.kernel.org/u-boot/20240207102327.35125-1-i@shantur.c=
om/T/#u
> >>> >>> Link:
> >>> >>> https://lore.kernel.org/u-boot/20240201164604.13315fa6@donnerap.m=
anchester.arm.com/T/#u
> >>> >>> Signed-off-by: Shantur Rathore <i@shantur.com>
> >>> >>> Helped-by: Dragan Simic <dsimic@manjaro.org>
> >>> >>> Tested-by: Andre Przywara <andre.przywara@arm.com>
> >>> >>> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> >>> >>> ------- >8 ------------- >8 ------------- >8 ------------- >8 ---=
----
> >>> >>
> >>> >> Regards,
> >>> >> Shantur
> >>> >
> >>> > Is this description acceptable to you Marek.
> >>>
> >>> Please send a V2 patch . If possible, include the device information
> >>> as
> >>> reported by Andre, esp. which USB stick triggered it, including USB
> >>> IDs,
> >>> this is important for future reference and in case someone has
> >>> similar
> >>> failure.
> >>
> >> So the USB 2.0 stick is some no-name, unlabelled and super cheap one,
> >> I
> >> think we bought a pack of it, just for boot-strapping machines. The
> >> USB
> >> ID of "abcd:1234" kind of gives away that this is bogus AF.
> >> The USB 3.0 stick is a PNY 32GB one, the USB ID is:
> >> 1f75:0917 Innostor Technology Corporation IS917 Mass storage
> >>
> >> Hope that helps.
> >
> > Thank you for replying.  I'll include the available information into
> > the revised commit description and send it over a bit later.
>
> Here are the revised commit subject and description, please have a look
> and let me know if further improvements are needed.
>
> ------- >8 ------------- >8 ------------- >8 ------------- >8 -------
> [PATCH v2] common: usb-hub: Reset USB 3.0 hubs only
>
> Additional testing of the changes introduced in commit 33e06dcbe57a
> ("common:
> usb-hub: Reset hub port before scanning") revealed that some USB 2.0 and
> 3.0
> flash drives didn't work in U-Boot on some Allwinner SoCs that support
> USB
> 2.0 interfaces only.  More precisely, some of the tested USB 2.0 and 3.0
> flash drives failed to be detected and work on an OrangePi Zero 3, based
> on
> the Allwinner H616 SoC that supports USB 2.0 only, while the same USB
> flash
> drives worked just fine on a Pine64 H64, based on the Allwinner H6 SoC
> that
> supports both USB 2.0 and USB 3.0 interfaces.
>
> The USB ID of the above-mentioned USB 3.0 flash drive that failed to
> work is
> 1f75:0917 (Innostor Technology Corporation IS917 Mass storage), it is 32
> GB
> in size and sold under the PNY brand.  The mentioned USB 2.0 drive is
> some
> inexpensive no-name drive with an invalid USB ID.
>
> Resetting USB 3.0 hubs only, which this patch introduces to the USB hub
> resets, has been tested to work as expected, resolving the identified
> issues
> on the Allwinner H616, while not introducing any new issues on other
> tested
> Allwinner SoCs.  Thus, let's fix it that way.
>
> According to the USB 3.0 specification, resetting a USB 3.0 port is
> required
> when an attached USB device transitions between different states, such
> as
> when it resumes from suspend.  Though, the Linux kernel performs
> additional
> USB 3.0 port resets upon initial USB device attachment, as visible in
> commit
> 07194ab7be63 ("USB: Reset USB 3.0 devices on (re)discovery") in the
> kernel
> source, to ensure proper state of the USB 3.0 hub port and proper USB
> mode
> negotiation during the initial USB device attachment and enumeration.
>
> These additional types of USB port resets don't exist for USB 2.0 hubs,
> according the USB 2.0 specification.  The resets seem to be added to the
> USB
> 3.0 specification as part of the port and device mode negotiation.
>
> The Linux kernel resets USB 3.0 (i.e. SuperSpeed) hubs only, as visible
> in
> commit 10d674a82e55 ("USB: When hot reset for USB3 fails, try warm
> reset.")
> in the kernel source.  The check for SuperSpeed hubs is performed in a
> way
> that also applies to newer SuperSpeed Plus (USB 3.1 or 3.2) hubs as
> well,
> which hopefully makes it future proof.
>
> Fixes: 33e06dcbe57a ("common: usb-hub: Reset hub port before scanning")
> Link:
> https://lore.kernel.org/u-boot/20240207102327.35125-1-i@shantur.com/T/#u
> Link:
> https://lore.kernel.org/u-boot/20240201164604.13315fa6@donnerap.mancheste=
r.arm.com/T/#u
> Signed-off-by: Shantur Rathore <i@shantur.com>
> Helped-by: Dragan Simic <dsimic@manjaro.org>
> Tested-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> ------- >8 ------------- >8 ------------- >8 ------------- >8 -------
>
> Shantur, I hope you're feeling better.

Thanks Dragan, V2 is submitted.
I am feeling much better, thanks for asking.
