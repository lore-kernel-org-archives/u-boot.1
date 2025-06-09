Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3004DC61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 17:36:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55C9682998;
	Mon,  9 Jun 2025 19:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="MJ4f4QR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6FA782AA7; Mon,  9 Jun 2025 19:36:00 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07330826AA
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 19:35:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e81b44fb54fso2389360276.2
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 10:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1749490557; x=1750095357; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J4Gc7l2pUsSXEN/qSDoqYa87qp58qNlNtdouOoXY45Y=;
 b=MJ4f4QR6Gym3GncZojRxq4ZayNGFFSc9RV+pXrhxmSJVY8jMAqfRdq3lZmeGz3ViUy
 cUkmQqQ0AxWXU+HIyGatMZsjr3aZh30B/Zi84i897jYjZld8sACok3MRafruggH4N8Au
 P19BQr0Q0ufoTsYKrtn3/0vIPdc/uq10ugJGILdjdzRGy4I7BNUajCCsWO0tll4Hgf3M
 kbSc2h1a1alEXk7wa095Rdb7oeEOEhO6EWMPBl/tQ5I7DYDhRJ0PTMpDLJngdwLNYfJq
 NaOSWp9pG53A6i05ge9EfP2HJq9uahAfbBdt4qcMpifEh6BwM77tZIjom4Z6cDJaCzyU
 GiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749490557; x=1750095357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J4Gc7l2pUsSXEN/qSDoqYa87qp58qNlNtdouOoXY45Y=;
 b=mNT6Ji/hsDlOZwqgzHmR1zVzKdMiskaBzEUJJ8FWqakELf8vAfX6lAE6cbab06LwQo
 gaRCqnlQKDv4MrALwRM8ir9MGGU49vDU8yh8LKTbB2gNHeQvWrNpawnRimKQack+BVLx
 ONkD3Wq2seZ9OgPdhpXyJ4/DHhtz6v8TpzCy23RCETJqLOk66sSHnmq/nmfitMbkhPKY
 xITXj2o16M46Dq+xZK8wuzM/sUmLZrN/UR2gFNkVCPGg37x+KlOfU/rsQIXIo5OwKZxW
 yV6jZZn1phg+kR0697bjuh9NbKsjoR96vzbm4rHgtlQEfxJyoA1Osoa1iu5KtGkU9Iu5
 Wv1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnJJM7qNmT19i+Zm/DSg4kngtE9EXZ4VJ040GNnSk/11nK0ZhCG5TNDMa6h27iCYkB7YhtvdQ=@lists.denx.de
X-Gm-Message-State: AOJu0Ywlgca6g4vK+u3lpl6MFThVv4DrqJTXFsFqeiB5PnJqa1pmTSBn
 qdqlbcz5S7fzhQqAoVRxGhBuEQHBFIjlGfKbyYN+IUg/WwOm/R4YQruJghxm4PQwWjAFcUZ4Cmn
 34m3q5Z6+FE2sBdmjDWcOxrKtTEBDy648rOcwZbhuTQ==
X-Gm-Gg: ASbGncs2T7IZfWo8pLBNYmppFdy1amxGRs1CTePgPGYaBFSSuRon89ARkmNBetSLBgD
 yDauOrZag4XM8tM27K701FxbFHi1Sy6BzDXj5NULlPYdvsz7ZdK2bROoTNem43cATtItP5KUdAp
 ch6H6srB0Xie196XD34/JB0HNU9kdw/znH
X-Google-Smtp-Source: AGHT+IHi0DtuMBqV37WMWSYmbGi5NkYn0ZFT5VHMNCcrtIgAKMZjlG96cASPK73scGgaN7NVxsAvS/Dem5r68bPkWgU=
X-Received: by 2002:a05:690c:f0f:b0:70d:f47a:7e21 with SMTP id
 00721157ae682-710f76300bamr190632257b3.1.1749490556748; Mon, 09 Jun 2025
 10:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250530153826.1057407-1-tharvey@gateworks.com>
 <f19b630b-4a01-4e6f-b419-d2995b45198c@canonical.com>
 <CAJ+vNU2UfSVHvo=_HsCKbWH5AFsYV=SnVGru4ZBWHrGnAVBcRw@mail.gmail.com>
In-Reply-To: <CAJ+vNU2UfSVHvo=_HsCKbWH5AFsYV=SnVGru4ZBWHrGnAVBcRw@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 9 Jun 2025 10:35:43 -0700
X-Gm-Features: AX0GCFvuuWU3DOH8kFIJweYJevXLySyOFkietfneJQ_OXnmPAsvYJbB01xkbbcA
Message-ID: <CAJ+vNU2trStWN_7jG5OxvvKtodz=qq9JVMaYHPWdpzUDJYiU=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] net: lwip: call sys_check_timeouts and schedule on
 rx
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.denx.de, 
 Anatolij Gustschin <agust@denx.de>
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

On Tue, Jun 3, 2025 at 5:04=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> w=
rote:
>
> On Sun, Jun 1, 2025 at 2:07=E2=80=AFPM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 5/30/25 17:38, Tim Harvey wrote:
> > > Call schedule() in net_lwip_rx() to service U-Boot tasks and
> > > actions during packet rx.
> > >
> > > As a cleanup also move sys_check_timeouts() here and remove it from t=
he
> > > functions that call net_lwip_rx().
> > >
> > > This resolves the issue of an active watchdog resetting the board on
> > > long network activities.
> > >
> > > Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > ---
> > > v2:
> > >   - remove duplication of sys_check_timeouts() from functions that ca=
ll
> > >     net_lwip_rx()
> > > ---
> > >   net/lwip/dhcp.c     | 1 -
> > >   net/lwip/dns.c      | 1 -
> > >   net/lwip/net-lwip.c | 7 +++++++
> > >   net/lwip/ping.c     | 1 -
> > >   net/lwip/tftp.c     | 1 -
> > >   net/lwip/wget.c     | 1 -
> > >   6 files changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
> > > index 92bd7067a7fb..b79b746db390 100644
> > > --- a/net/lwip/dhcp.c
> > > +++ b/net/lwip/dhcp.c
> > > @@ -57,7 +57,6 @@ static int dhcp_loop(struct udevice *udev)
> > >       /* Wait for DHCP to complete */
> > >       do {
> > >               net_lwip_rx(udev, netif);
> > > -             sys_check_timeouts();
> > >               bound =3D dhcp_supplied_address(netif);
> > >               if (bound)
> > >                       break;
> > > diff --git a/net/lwip/dns.c b/net/lwip/dns.c
> > > index 19172ac959ac..738f8bf3196b 100644
> > > --- a/net/lwip/dns.c
> > > +++ b/net/lwip/dns.c
> > > @@ -91,7 +91,6 @@ static int dns_loop(struct udevice *udev, const cha=
r *name, const char *var)
> > >                       net_lwip_rx(udev, netif);
> > >                       if (dns_cb_arg.done)
> > >                               break;
> > > -                     sys_check_timeouts();
> > >                       if (ctrlc()) {
> > >                               printf("\nAbort\n");
> > >                               break;
> > > diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> > > index f05c4cd3f64f..e8d4cc542ed8 100644
> > > --- a/net/lwip/net-lwip.c
> > > +++ b/net/lwip/net-lwip.c
> > > @@ -13,8 +13,10 @@
> > >   #include <lwip/etharp.h>
> > >   #include <lwip/init.h>
> > >   #include <lwip/prot/etharp.h>
> > > +#include <lwip/timeouts.h>
> > >   #include <net.h>
> > >   #include <timer.h>
> > > +#include <u-boot/schedule.h>
> > >
> > >   /* xx:xx:xx:xx:xx:xx\0 */
> > >   #define MAC_ADDR_STRLEN 18
> > > @@ -284,6 +286,11 @@ int net_lwip_rx(struct udevice *udev, struct net=
if *netif)
> > >       int len;
> > >       int i;
> > >
> > > +     /* lwIP timers */
> > > +     sys_check_timeouts();
> > > +     /* Other tasks and actions */
> > > +     schedule(
> >
> > Some scheduled tasks have a long duration, specifically video_sync_all(=
)
> > called via video_idle(). This change will lead to lost packages.
> >
> >
> > @Tom, Simon
> >
> > The EFI code was impacted by 29caf9305b6f ("cyclic: Use schedule()
> > instead of WATCHDOG_RESET()"). This added schedule() calls to EFI
> > networking. Package losses can expected if schedule() takes more than 1
> > =C2=B5s. This is much shorter than the time needed for synchronizing a =
1 MiB
> > frame buffer. The cyclic framework was explicitly meant for short
> > duration function calls, not for long duration tasks like syncing the
> > video frame buffer.
> >
> >
> > I think we should remove video_idle() from the cyclic framework.
> > video_sync_all() should only be triggered if there is video output.
> >
>
> Hi Heinrich,
>
> It makes sense what you are saying but I don't have the hardware to
> test your scenario. Can you submit a patch for discussion with a fixes
> tag?

Gentle ping here.

Can we get some discussion on the point Heinrich brings up about
video_idle in cyclic? Without my patch here which this discussion is
blocking, large lwIP network transfers are quite broken on boards with
watchdogs.

Best Regards,

Tim
