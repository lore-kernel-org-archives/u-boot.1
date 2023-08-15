Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E14C001E0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 11:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B637E8676C;
	Tue, 15 Aug 2023 13:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CjI/0Ngy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A74E986776; Tue, 15 Aug 2023 13:49:42 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C55E3866A7
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 13:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer@gmail.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-589f437fd1dso18132547b3.1
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 04:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692100177; x=1692704977;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZOsgt4TGIq3RKWwZJWRni6G3FG0RIG/+yxGb3D/sX5c=;
 b=CjI/0Ngy1BGgW7pQqZ2zLY4JgBl0J92BhB2HgwIwVvcnOR0JITw3K5zGaozbwqJ3Yj
 ouVuK4WCzMwX1tgh4OVuU4yawei9qOMr7eUqpmmBB8rIOaztyvQ0ixeyngDganZREyND
 ZNFQP0kWcWiM3+Z52aEFNe0tJaZ58EVoNr62duv0A6mGTSL5vZuTVimWJCOJ08qnffP2
 8fm5XQf/YKZZemvo1uF/3vZLvvTES5RgbgcYfq8fHSu7QGn32MQqg09qIQxVg+K4iVM2
 6PNMDwgOERBX6foLWYWR16CiNzHz/8e4IQHVNy8EbEAlAKs1W53xTQjMQkqQ9YT3wi+p
 UuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692100177; x=1692704977;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZOsgt4TGIq3RKWwZJWRni6G3FG0RIG/+yxGb3D/sX5c=;
 b=A1Ic8Gq3yxmBvd/fytQJ4IC8KWix3GYGAob/AUEu1TeJKtSN+ZD18vXGKTyqrmiwOM
 zhke0342GfbGvIQ1F+O4/KlPV75AC3/jSvQjSjU+20vsXuOVKlzGTu11CfRAZgS1apZV
 L4t2X6W4y/6U3D125ULv1MuRBuVNcU61YvEMV5E9JNQGQdITCHYxrPo0EsjZXDsJ1uXj
 CNIjw6c1/TMggV3cxx/CIR9U3va0VRTH4YwfQqE+qFKZ1f2RjTgydbzmfW25SBon3F3D
 nQS88PAiK9AIEW4lCx6hgSmzvOoe+9qse7BrNdJYrbSnalEdOT4+TyOuCS2FE14L12wb
 96kA==
X-Gm-Message-State: AOJu0Yx1hIJWk4SPuCxG9hYI+ZWvAksqGKkOmwUuwLQiDQHqJf91HV03
 YQ8tpdGYfOYptwwZGd1qIKXjvApq8oKqUBA9Kpg=
X-Google-Smtp-Source: AGHT+IEVtkp78D/8YFYGWP9GpBBv70Dmurlzi97upm3da2wtvFxQk5LpsSgN+fPPute06NeudqjzJHP+Kpxi/TItCMg=
X-Received: by 2002:a81:52d5:0:b0:589:e91d:786c with SMTP id
 g204-20020a8152d5000000b00589e91d786cmr5329113ywb.46.1692100177117; Tue, 15
 Aug 2023 04:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <ae8ab037-2eef-1ada-483a-67a0e4f65fb1@conplement.de>
 <CAC928HbE69E_kSgDdyK=G8v7kd8DyReuAhU50vgZt5FLsXPR8A@mail.gmail.com>
 <20230813173713.GA42565@kunlun.suse.cz>
 <d2db28c6-9873-7c91-79cc-e4a3a7a0bd15@conplement.de>
In-Reply-To: <d2db28c6-9873-7c91-79cc-e4a3a7a0bd15@conplement.de>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Tue, 15 Aug 2023 13:49:26 +0200
Message-ID: <CAC928HZuDfiJcqtBqkNE9wvm-0VxEjibB9srjcrda2kP9jDVyQ@mail.gmail.com>
Subject: Re: Problem upon startup with halted USB device on RaspberryPi 4
To: Harry Waschkeit <Harry.Waschkeit@conplement.de>,
 =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Il giorno lun 14 ago 2023 alle ore 11:11 Harry Waschkeit <
Harry.Waschkeit@conplement.de> ha scritto:

> Am 13.08.23 um 19:37 schrieb Michal Such=C3=A1nek:
> > Hello,
>
> Hi again,
>
> thanks for your answers!
>
> > On Sat, Aug 12, 2023 at 08:31:56PM +0200, Massimo Pegorer wrote:
> >> Hi Harry,
> >>
> >> Il giorno lun 7 ago 2023 alle ore 11:02 Harry Waschkeit <
> >> Harry.Waschkeit@conplement.de> ha scritto:
> >>
> >>> Hi,
> >>>
> >>> I have a RaspberryPi 4 where on one USB port a Sierra Wireless LTE
> >>> module (EM7455) is attached via an PCIe-to-USB adapter.
> >>> The boot image I use gets built by Yocto with the help of poky
> >>> (kirkstone) and meta-raspberry (beside a few other layers) which
> >>> incorporates U-Boot 22.01.
> >>>
> >>> When I apply power to the board it will come up until scanning USB
> >>> devices (for potential boot devices), but then throw a BUG end reset
> the
> >>> board.
> >>
> >>
> >> Do you need USB boot devices? If not, I would build U-Boot without USB
> >> support.
>
> Yeah, I am aware of that possibility, thanks for your hint anyway, but ..=
.
>
> >
> > That would be great workaround, However, enabling a device should not
> > break the board. If that's the case the driver is clearly broken.
>

Of course, mine is just a workaround, nothing more. To make hardware combo
working, and just for specific use case (if I properly understood). Not for
typical
usage of rPi. About the driver: can be broken, or the root cause can be the
PCIe-to-USB bridge misbehaving, or both.

> Also rPi typically uses USB keyboard for boot-time input which makes the
> > workaround not so great.


For U-Boot booting phase, or later on for Linux or other OS boot phase? I d=
o
not know too much about this specific board.


> ... but as Michal pointed out, the rpi - at least rpi 400 - should be
> considered to regularly use USB devices for normal operation, so
> completely disabling USB is not really an option here.
>

Disabling USB support in U-Boot (via defconfig) would not affect Linux (or
other OS) USB functions in any way, if this is what you are concerning abou=
t
with "completely disabling USB".

My USB knowledge is too little to point the finger on the problem but my
> guess still is that U-Boot is only using a part of Linux's USB driver
> for bringing up devices, thereby omitting some of the error handling
> which would be done in the Linux kernel in some (maybe concurrent) way.
>

I suggest to address this email also directly to maintainers:

./scripts/get_maintainer.pl drivers/usb/host/xhci-ring.c
Bin Meng <bmeng.cn@gmail.com> (maintainer:USB xHCI)
Marek Vasut <marex@denx.de> (maintainer:USB)
u-boot@lists.denx.de (open list)

Regards,
Massimo

And given the bunch of boot messages "WARN halted endpoint." with the
> patch I mentioned, chances are that the patch is either not the right
> one or at least incomplete.
> But the general approach to ignore halted endpoints appears completely
> reasonable to me when it avoids a hanging of boot looping system.
> I cannot tell whether there should instead be some cleverer treatment to
> get such a device running ("Reset Endpoint" from what I read), though.
>
> Regards,
> Harry
>
> > Thanks
> >
> > Michal
> >
> >>
> >> Massimo
> >>
> >>> This continues as long as the modem is unplugged.
> >>> The exact error message is:
> >>>
> >>> scanning bus xhci_pci for devices... WARN halted endpoint, queuing UR=
B
> >>> anyway.
> >>> Unexpected XHCI event TRB, skipping... (3af519b0 00000004 13000000
> >>> 02008401)
> >>> BUG at drivers/usb/host/xhci-ring.c:503/abort_td()!
> >>> BUG!
> >>> resetting ...
> >>>
> >>> Some internet research brought up a patch (1) for
> >>> drivers/usb/host/xhci-ring.c where halted devices simply get ignored
> >>> during enumeration:
> >>>
> >>> diff --git a/drivers/usb/host/xhci-ring.c
> b/drivers/usb/host/xhci-ring.c
> >>> index acf437104a..6d995f446e 100644
> >>> --- a/drivers/usb/host/xhci-ring.c
> >>> +++ b/drivers/usb/host/xhci-ring.c
> >>> @@ -227,7 +227,8 @@ static int prepare_ring(struct xhci_ctrl *ctrl,
> >>> struct xhci_ring *ep_ring,
> >>> puts("WARN waiting for error on ep to be cleared\n");
> >>> return -EINVAL;
> >>> case EP_STATE_HALTED:
> >>> - puts("WARN halted endpoint, queueing URB anyway.\n");
> >>> + puts("WARN halted endpoint.\n");
> >>> + return -EPIPE;
> >>> case EP_STATE_STOPPED:
> >>> case EP_STATE_RUNNING:
> >>> debug("EP STATE RUNNING.\n");
> >>>
> >>> The driver file itself stems from the Linux sources, so I'm pretty su=
re
> >>> that it is correct in that context.
> >>> Even though I'm not really into USB stuff and therefore I cannot not
> >>> really follow the discussion for the proposed change, in my eyes the
> >>> patch could be reasonable for U-Boot nevertheless given that a) in my
> >>> experience driver code is often used in a simplified way in U-Boot
> >>> compared to Linux kernel, and b) it's all about board start-up only a=
nd
> >>> not about full OS use with all bells, whistles and full error handlin=
g.
> >>>
> >>> Of course, I might be wrong while missing some important other use or
> >>> corner cases, so I wanted to check here :-)
> >>>
> >>> At least, what I can say: with this patch I see a bunch of these
> warning
> >>> messages but the board comes up and is usable in the end by Linux.
> >>>
> >>> fwiw: my internet search also showed another patch labelled in the
> first
> >>> place "[PATCH] pi4: fix crash when issuing usb reset" (2) that didn't
> >>> make it into the particular U-Boot 22.01 but was integrated right aft=
er
> >>> that version in commit "Prepare v2022.04" with hash
> >>> e4b6ebd3de982ae7185dbf689a030e73fd06e0d2 (3).
> >>> As I first hoped I could address my problem by just adding this patch=
 I
> >>> got promptly disappointed. The only thing I gained was to now get
> >>> endless error messages followed by retries until I power-cycled the
> >>> board (causing to start all over):
> >>>
> >>> USB XHCI 1.00
> >>> scanning bus xhci_pci for devices... WARN halted endpoint, queueing U=
RB
> >>> anyway.
> >>> Unexpected XHCI event TRB, skipping... (3afd6b30 00000004 13000000
> >>> 02008401)
> >>> XHCI abort timeout
> >>> WARN halted endpoint, queueing URB anyway.
> >>> Unexpected XHCI event TRB, skipping... (3afd6b40 00000004 13000000
> >>> 02008401)
> >>> XHCI abort timeout
> >>> WARN halted endpoint, queueing URB anyway.
> >>> Unexpected XHCI event TRB, skipping... (3afd6b50 00000004 13000000
> >>> 02008401)
> >>> XHCI abort timeout
> >>> WARN halted endpoint, queueing URB anyway.
> >>> [...]
> >>>
> >>> To me it means that this specific PCIe-to-USB bridge might misbehave
> >>> somehow,
> >>> but the final question is: what are the odds to get that patch into
> >>> official U-boot, or any other fix/quirk to make my hardware combo
> working?
> >>>
> >>> And also interesting: if I cannot hope for an upstream change, what
> >>> potential risks I would have to accept when keeping my patch?
> >>>
> >>> Regards,
> >>> Harry
> >>>
> >>> (1)
> >>>
> >>>
> https://linux-usb.vger.kernel.narkive.com/VW4VTVDU/patch-usb-host-xhci-fi=
x-halted-endpoint-handling
> >>> (2)
> >>>
> https://lore.kernel.org/all/3d4ece94-932a-25dd-ef29-0ddfb4a51465@denx.de/=
T/
> >>> (3)
> >>>
> >>>
> https://source.denx.de/u-boot/u-boot/-/commit/e4b6ebd3de982ae7185dbf689a0=
30e73fd06e0d2
> >>>
> >>> --
> >>> i.A. Harry Waschkeit
> >>> Senior Embedded Engineer
> >>> conplement AG
> >>> S=C3=BCdwestpark 92
> >>> 90449 N=C3=BCrnberg
> >>>
> >>> Handelsregister: HRB 22863
> >>> Registergericht: N=C3=BCrnberg
> >>> Vertreten durch: Britta Waligora und Thomas Wahle
> >>> Vorsitzender des Aufsichtsrates: Lorenz von Schr=C3=B6der
> >>>
> >>>
>
> --
>
> #GernePerDu #CallMeByMyFirstName*
>
> i.A. Harry Waschkeit*
> Senior Embedded Engineer
>
> *conplement AG*
> S=C3=BCdwestpark 92
> 90449 N=C3=BCrnberg
>
>
>
>   Telefon IconTelefon: +49 911 25 50 976-862
> Handy IconMobil:    +49 173 38 29 258
>
> _harry.waschkeit@conplement.de
> _www.conplement.de<http://www.conplement.de/>
>
>
>
> Bild mit conplement Logo mit Claim Picture of conplement Logo with Claim
> Ein Bild, um bei Klick auf das Bild zum Download eines Whitepapers zu
> gelangen f=C3=BCr das Thema "Remote-Updates f=C3=BCr Embedded Linux Syste=
me"
> Picture linked to a landing page to download the Whitepaper =E2=80=9CRemo=
te
> Updates for Embedded Linux Systems=E2=80=9D<https://hubs.ly/Q01tz75q0>
>
>   Besuchen Sie uns auf Social Media:
>
> LinkedIn
> Link<https://www.linkedin.com/company/conplement-ag/>         Instagram
> Link<https://www.instagram.com/conplementag/?hl=3Dde>         XING
> Link<https://www.xing.com/companies/conplementag/updates>
>
>
> Handelsregister: HRB 22863
> Registergericht: N=C3=BCrnberg
> Vertreten durch: Britta Waligora und Thomas Wahle
> Vorsitzender des Aufsichtsrates: Lorenz von Schr=C3=B6der
>
> *E-Mail Disclaimer *
> Der Inhalt dieser E-Mail einschlie=C3=9Flich aller Anh=C3=A4nge ist vertr=
aulich
> und ausschlie=C3=9Flich f=C3=BCr den bezeichneten Adressaten bestimmt. We=
nn Sie
> nicht der vorgesehene
> Adressat dieser E-Mail oder dessen Vertreter sein sollten, so beachten
> Sie bitte, dass jede Form der Kenntnisnahme, Ver=C3=B6ffentlichung,
> Vervielf=C3=A4ltigung oder Weitergabe des Inhalts dieser E-Mail unzul=C3=
=A4ssig
> ist. Wir bitten Sie, sich in diesem Fall mit dem Absender der E-Mail in
> Verbindung zu setzen sowie die Originalnachricht zu l=C3=B6schen und alle
> Kopien hiervon zu vernichten.
> Daf=C3=BCr vielen Dank im Voraus.
>
>
>
