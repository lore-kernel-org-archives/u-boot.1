Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FDDC71159
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 17:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E85BD81E18;
	Mon, 16 Jun 2025 19:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="ZlNI8y/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A490682A0A; Mon, 16 Jun 2025 19:38:12 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C169881760
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 19:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4079f80ff0fso3523770b6e.1
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1750095488; x=1750700288; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ZqQbCdPZX6NSp3RyKuFUbreg2h5b0Pnk4VstOqHuBI=;
 b=ZlNI8y/WTWcvo9nNKDQt8BSk4pdrF3ZdDpk1hcuNDUunLFsLAAzayXxnRDImLJZXoV
 K1tZ+cdrsvh1xQoNP77ovHqhUBi6XaKMyQxOPBlTWVAvD7uPgVlw3xplcI9cDi7EHthT
 UNo7rs5mUOpifT0ppkTEL35J2Kn48g2Xn1DLWvky6gjpW14KjqJHIJpc/NYdAG/BlIah
 LNnyHmUTqX0hoQoYkSEL+MTZV1730YIjB/y9DAZirG/DcFzDoMzdxoHDeHojiDwhOHY2
 rumqiUf5qWV/Pys9NzpxUmG2n/H69SCVLgkGLwnCXbcAGpIkKHfuunfJmYBo2OVZbcZG
 YU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750095488; x=1750700288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ZqQbCdPZX6NSp3RyKuFUbreg2h5b0Pnk4VstOqHuBI=;
 b=Yasz3rS9EoxUT44TTT0enUkm0m2WCqOdhlUZxzSPVdQ4xPjV11QKNZNV5hVI/Fs3h0
 vMlIfYVfwLZb7fY5WeGmGfDDgUSLz9Z2PpbQNisRhwuVGCn5WepTFoOTy1oQ+Zf9/eDk
 CfXOed69i0lWSqznfjhDEAw8GY6A3kZJlUneNQaMYaYS2Js7BxYpliZKRp0SKNqtPu0P
 r0TVQcIo4nnHkQWWoXIPE69S05pj8v4EY4S1QgdwyMjGvmy5aKuCpHsbkKN0uEQpOoMA
 gI168zEqVNVmg8IQwCQHDizWY4/4ROzaJTK7odAYz8jl8qFXawP93oLeIbNnkrlgVFPl
 7psA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQuIenoSvecElj8maLgw2Y3mf7HZHSJYgkxwcIV8+2BlDut0t3Cr1jlKgLb3cDzchLZnaVkyU=@lists.denx.de
X-Gm-Message-State: AOJu0Yym6OaBPTLZ11F+cz/ivdoFsKNk3xCxR0yCcFclFPfPo9tEVPHq
 vwLtE6KYWY8eZmpq/Eacvuunbm443Of9ONpZWztVKZ30R3zDxkzI26MMMMl9X2HVBESIfyBIgwE
 3YeCYspvjLRR2m3g94nP2i9/t54raHU4b+BFfkYR0rw==
X-Gm-Gg: ASbGncsKV1Puq6+rY83Qkn/lEFJLARr3u1lZ75BQ6XCwaEeqzb4rjjbUqyvC43C0Wvm
 2HOV9Lr1ADeFKp0oPt2I+6N4/sC6xhXU9LgjiybbCx33sSp7A5F+Lb5V3XPA7AJKMLvkbjpAQcu
 xWWJ2BFG//a8uorlDGzuaUCioVpWiMZaKjRc7PY6yKVUg=
X-Google-Smtp-Source: AGHT+IGAh374d4xDLGB874QzQ0/N8FhOhGf/RNzGGFO+wvk/l/l86ywJtqXHEKEewU9Nvm6uxMY+p9qeI+HljUuQ4qs=
X-Received: by 2002:a05:6808:130a:b0:3f8:18a3:b1cc with SMTP id
 5614622812f47-40a7b6fea25mr6841414b6e.12.1750095488361; Mon, 16 Jun 2025
 10:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250530153826.1057407-1-tharvey@gateworks.com>
 <f19b630b-4a01-4e6f-b419-d2995b45198c@canonical.com>
 <CAJ+vNU2UfSVHvo=_HsCKbWH5AFsYV=SnVGru4ZBWHrGnAVBcRw@mail.gmail.com>
 <CAJ+vNU2trStWN_7jG5OxvvKtodz=qq9JVMaYHPWdpzUDJYiU=Q@mail.gmail.com>
 <63e2718b-81f8-4f2b-9d23-73d53a26b358@linaro.org>
In-Reply-To: <63e2718b-81f8-4f2b-9d23-73d53a26b358@linaro.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 16 Jun 2025 10:37:57 -0700
X-Gm-Features: AX0GCFtFRVZwDWtxGoeiMcy56ioPUCXLTOgfkTQDQ_j7rqdJenzc9EfKmyDboYw
Message-ID: <CAJ+vNU2-iaDxsPYkkNC1P=OREj2c9FxNuRZrajYiT4TDnuh9Hg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] net: lwip: call sys_check_timeouts and schedule on
 rx
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 u-boot@lists.denx.de, Anatolij Gustschin <agust@denx.de>
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

On Mon, Jun 16, 2025 at 12:18=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 6/9/25 19:35, Tim Harvey wrote:
> > On Tue, Jun 3, 2025 at 5:04=E2=80=AFPM Tim Harvey <tharvey@gateworks.co=
m> wrote:
> >>
> >> On Sun, Jun 1, 2025 at 2:07=E2=80=AFPM Heinrich Schuchardt
> >> <heinrich.schuchardt@canonical.com> wrote:
> >>>
> >>> On 5/30/25 17:38, Tim Harvey wrote:
> >>>> Call schedule() in net_lwip_rx() to service U-Boot tasks and
> >>>> actions during packet rx.
> >>>>
> >>>> As a cleanup also move sys_check_timeouts() here and remove it from =
the
> >>>> functions that call net_lwip_rx().
> >>>>
> >>>> This resolves the issue of an active watchdog resetting the board on
> >>>> long network activities.
> >>>>
> >>>> Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
> >>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> >>>> ---
> >>>> v2:
> >>>>   - remove duplication of sys_check_timeouts() from functions that c=
all
> >>>>     net_lwip_rx()
> >>>> ---
> >>>>   net/lwip/dhcp.c     | 1 -
> >>>>   net/lwip/dns.c      | 1 -
> >>>>   net/lwip/net-lwip.c | 7 +++++++
> >>>>   net/lwip/ping.c     | 1 -
> >>>>   net/lwip/tftp.c     | 1 -
> >>>>   net/lwip/wget.c     | 1 -
> >>>>   6 files changed, 7 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
> >>>> index 92bd7067a7fb..b79b746db390 100644
> >>>> --- a/net/lwip/dhcp.c
> >>>> +++ b/net/lwip/dhcp.c
> >>>> @@ -57,7 +57,6 @@ static int dhcp_loop(struct udevice *udev)
> >>>>       /* Wait for DHCP to complete */
> >>>>       do {
> >>>>               net_lwip_rx(udev, netif);
> >>>> -             sys_check_timeouts();
> >>>>               bound =3D dhcp_supplied_address(netif);
> >>>>               if (bound)
> >>>>                       break;
> >>>> diff --git a/net/lwip/dns.c b/net/lwip/dns.c
> >>>> index 19172ac959ac..738f8bf3196b 100644
> >>>> --- a/net/lwip/dns.c
> >>>> +++ b/net/lwip/dns.c
> >>>> @@ -91,7 +91,6 @@ static int dns_loop(struct udevice *udev, const ch=
ar *name, const char *var)
> >>>>                       net_lwip_rx(udev, netif);
> >>>>                       if (dns_cb_arg.done)
> >>>>                               break;
> >>>> -                     sys_check_timeouts();
> >>>>                       if (ctrlc()) {
> >>>>                               printf("\nAbort\n");
> >>>>                               break;
> >>>> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> >>>> index f05c4cd3f64f..e8d4cc542ed8 100644
> >>>> --- a/net/lwip/net-lwip.c
> >>>> +++ b/net/lwip/net-lwip.c
> >>>> @@ -13,8 +13,10 @@
> >>>>   #include <lwip/etharp.h>
> >>>>   #include <lwip/init.h>
> >>>>   #include <lwip/prot/etharp.h>
> >>>> +#include <lwip/timeouts.h>
> >>>>   #include <net.h>
> >>>>   #include <timer.h>
> >>>> +#include <u-boot/schedule.h>
> >>>>
> >>>>   /* xx:xx:xx:xx:xx:xx\0 */
> >>>>   #define MAC_ADDR_STRLEN 18
> >>>> @@ -284,6 +286,11 @@ int net_lwip_rx(struct udevice *udev, struct ne=
tif *netif)
> >>>>       int len;
> >>>>       int i;
> >>>>
> >>>> +     /* lwIP timers */
> >>>> +     sys_check_timeouts();
> >>>> +     /* Other tasks and actions */
> >>>> +     schedule(
> >>>
> >>> Some scheduled tasks have a long duration, specifically video_sync_al=
l()
> >>> called via video_idle(). This change will lead to lost packages.
> >>>
> >>>
> >>> @Tom, Simon
> >>>
> >>> The EFI code was impacted by 29caf9305b6f ("cyclic: Use schedule()
> >>> instead of WATCHDOG_RESET()"). This added schedule() calls to EFI
> >>> networking. Package losses can expected if schedule() takes more than=
 1
> >>> =C2=B5s. This is much shorter than the time needed for synchronizing =
a 1 MiB
> >>> frame buffer. The cyclic framework was explicitly meant for short
> >>> duration function calls, not for long duration tasks like syncing the
> >>> video frame buffer.
> >>>
> >>>
> >>> I think we should remove video_idle() from the cyclic framework.
> >>> video_sync_all() should only be triggered if there is video output.
> >>>
> >>
> >> Hi Heinrich,
> >>
> >> It makes sense what you are saying but I don't have the hardware to
> >> test your scenario. Can you submit a patch for discussion with a fixes
> >> tag?
> >
> > Gentle ping here.
> >
> > Can we get some discussion on the point Heinrich brings up about
> > video_idle in cyclic? Without my patch here which this discussion is
> > blocking, large lwIP network transfers are quite broken on boards with
> > watchdogs.
>
> Another option might be to increase the watchdog timeout?
>
Hi Jerome,

I don't think that makes much sense. Long transfers for compressed
disk images can take minutes sometimes. It doesn't make sense to not
call any cyclic's in that timeframe. Additionally its possible some
older less capable watchdogs don't have that much flexibility in
timeouts.

What Heinrich points out here seems valid but I'm not familiar with
the video framework to work up a patch.

Best Regards,

Tim
