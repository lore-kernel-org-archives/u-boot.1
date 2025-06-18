Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A39C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 19:38:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4495182BCD;
	Wed, 18 Jun 2025 21:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="VPeYZ7fF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8807E82BCD; Wed, 18 Jun 2025 21:38:36 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7E0D82B20
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 21:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-40a4de1753fso754811b6e.1
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 12:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1750275512; x=1750880312; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mwyymksZGns3cXWmcDWi+bg8KK3FnNPeG4dAdtiX1JY=;
 b=VPeYZ7fFmhYVoHy4GwNO3f0DEOSrCHpe0JOkL1Les764RxO5QQUPXDY3WX/CvvRrNh
 tkhXtXLqYwZ6Rgxjj34J0+S1khFe7qXQRv/NzCR1l+EfJMiCfvaCQoMC4V5b1kVEzTZI
 PE9fkbapaCLGIKIdEatP7nJ96Z+LLZhtWryDhiIGXXGYX8BmFDzCIuAF3nUQ0IKeEITq
 upmrvL+Mic2U0FtGzbrRUrgO/uNQpBcyUg+gF1Jc7QOFFFTDYbUeb80WA+hknkMcTnNK
 o7r8N0G389zJK9+auEiHzj3XQpafDyuzb9jdWgGbCzVK5EGJvirEADLf0fJOYDuYcoUQ
 sG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750275512; x=1750880312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mwyymksZGns3cXWmcDWi+bg8KK3FnNPeG4dAdtiX1JY=;
 b=uGx3ecckmUyaym6hV77aFQlGDl7sK3CPXB4cfrOM5JsT9YTlDyHqffGN/1I8fH9ZZG
 86Uz3TdFolG8j8oGDxB3LNMvkiRHXs4tgqmEsb/xktFXe/+bNbwvPxYcw+SOXiw6kwys
 cprzTl921r8Gka04cf1+B2f30G0yzDV2eZSbUHJy4Vts/HNY6ukLQ2FARtRkIJfDxfQY
 UKPabsZj7TugMxFITeSs29yI0pH8L8vJLyhqPB5bVNIOxyiRgpM9alEvmMb4yebdXZjH
 am8YXNYgnl2QJS2mRMhIUXqvWcX3JZIkgu2C1LSJWi2DvO0by0BEEHEh/dcvHyPC5ADx
 2VcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqI8QfPU/3CE7Z9uQtvAopqSN2C4j3pxyq12SQqm8elRJ9X/jenGDGf9aC40jrAB4UXhtHT7c=@lists.denx.de
X-Gm-Message-State: AOJu0YxlD0IhdQ6FDh8KrpKTaAis9g9AvQOwuDY5tK3CAWGn58QWpXOF
 +7u0lttp1bimIhXrcFEC8CFpSVZS0jXT76sIJgzORoOQnZ4Yi40QrtEHRREXYJaKmdqrQlvczu/
 SCeQzfjo2sUpmL7v8sYT0VBqgp5aMNzPb1l2ZqjyRVw==
X-Gm-Gg: ASbGncv3N7ygpIeoOHYFPKfFZ+jB7h0GcjlhnfEeFlBxndfBd44V16fDPoscb4wLxrO
 sVXF2+HWW0+m9Zrz2870ctbh5Ky4/YuNiA+ZzCUW3CAfRYYU8BQiz3yB0RIBebF9rpsA7PIlp23
 iKm/DTgTDJuCyF1uLkynp8aaTJuNa+XSCMb/z4PW1yLkI=
X-Google-Smtp-Source: AGHT+IG9MLh3BZhqO8tnBDBBvA3mXWuAXuqkhyx6MYGZLrovCPfFqlbnD/+GSnBi+4QfrIH/9fM1iQvK+86Tq4UDkNM=
X-Received: by 2002:a05:6808:201c:b0:3f3:d6f9:69a5 with SMTP id
 5614622812f47-40ab5150553mr734847b6e.8.1750275512455; Wed, 18 Jun 2025
 12:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250530153826.1057407-1-tharvey@gateworks.com>
 <f19b630b-4a01-4e6f-b419-d2995b45198c@canonical.com>
 <20250617224551.GA1687135@bill-the-cat>
 <CAJ+vNU2oNMpupHLHHcf3HTXBTN8mnPczo6T8khAkN875YwmUxg@mail.gmail.com>
In-Reply-To: <CAJ+vNU2oNMpupHLHHcf3HTXBTN8mnPczo6T8khAkN875YwmUxg@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 18 Jun 2025 12:38:21 -0700
X-Gm-Features: AX0GCFs-HPQ1pVNkH18pldKUq4bJanwNDeVQlnX-mY-LOflKdPTJZgtg9KVknNY
Message-ID: <CAJ+vNU3UH2fMBc=fg4aMvUCdxHf4ADf2KeApBeiCiGrrNyc+ew@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] net: lwip: call sys_check_timeouts and schedule on
 rx
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
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

On Wed, Jun 18, 2025 at 8:32=E2=80=AFAM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> On Tue, Jun 17, 2025 at 3:45=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Sun, Jun 01, 2025 at 11:07:16PM +0200, Heinrich Schuchardt wrote:
> > > On 5/30/25 17:38, Tim Harvey wrote:
> > > > Call schedule() in net_lwip_rx() to service U-Boot tasks and
> > > > actions during packet rx.
> > > >
> > > > As a cleanup also move sys_check_timeouts() here and remove it from=
 the
> > > > functions that call net_lwip_rx().
> > > >
> > > > This resolves the issue of an active watchdog resetting the board o=
n
> > > > long network activities.
> > > >
> > > > Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
> > > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > ---
> > > > v2:
> > > >   - remove duplication of sys_check_timeouts() from functions that =
call
> > > >     net_lwip_rx()
> > > > ---
> > > >   net/lwip/dhcp.c     | 1 -
> > > >   net/lwip/dns.c      | 1 -
> > > >   net/lwip/net-lwip.c | 7 +++++++
> > > >   net/lwip/ping.c     | 1 -
> > > >   net/lwip/tftp.c     | 1 -
> > > >   net/lwip/wget.c     | 1 -
> > > >   6 files changed, 7 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
> > > > index 92bd7067a7fb..b79b746db390 100644
> > > > --- a/net/lwip/dhcp.c
> > > > +++ b/net/lwip/dhcp.c
> > > > @@ -57,7 +57,6 @@ static int dhcp_loop(struct udevice *udev)
> > > >     /* Wait for DHCP to complete */
> > > >     do {
> > > >             net_lwip_rx(udev, netif);
> > > > -           sys_check_timeouts();
> > > >             bound =3D dhcp_supplied_address(netif);
> > > >             if (bound)
> > > >                     break;
> > > > diff --git a/net/lwip/dns.c b/net/lwip/dns.c
> > > > index 19172ac959ac..738f8bf3196b 100644
> > > > --- a/net/lwip/dns.c
> > > > +++ b/net/lwip/dns.c
> > > > @@ -91,7 +91,6 @@ static int dns_loop(struct udevice *udev, const c=
har *name, const char *var)
> > > >                     net_lwip_rx(udev, netif);
> > > >                     if (dns_cb_arg.done)
> > > >                             break;
> > > > -                   sys_check_timeouts();
> > > >                     if (ctrlc()) {
> > > >                             printf("\nAbort\n");
> > > >                             break;
> > > > diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> > > > index f05c4cd3f64f..e8d4cc542ed8 100644
> > > > --- a/net/lwip/net-lwip.c
> > > > +++ b/net/lwip/net-lwip.c
> > > > @@ -13,8 +13,10 @@
> > > >   #include <lwip/etharp.h>
> > > >   #include <lwip/init.h>
> > > >   #include <lwip/prot/etharp.h>
> > > > +#include <lwip/timeouts.h>
> > > >   #include <net.h>
> > > >   #include <timer.h>
> > > > +#include <u-boot/schedule.h>
> > > >   /* xx:xx:xx:xx:xx:xx\0 */
> > > >   #define MAC_ADDR_STRLEN 18
> > > > @@ -284,6 +286,11 @@ int net_lwip_rx(struct udevice *udev, struct n=
etif *netif)
> > > >     int len;
> > > >     int i;
> > > > +   /* lwIP timers */
> > > > +   sys_check_timeouts();
> > > > +   /* Other tasks and actions */
> > > > +   schedule(
> > >
> > > Some scheduled tasks have a long duration, specifically video_sync_al=
l()
> > > called via video_idle(). This change will lead to lost packages.
> > >
> > >
> > > @Tom, Simon
> > >
> > > The EFI code was impacted by 29caf9305b6f ("cyclic: Use schedule() in=
stead
> > > of WATCHDOG_RESET()"). This added schedule() calls to EFI networking.
> > > Package losses can expected if schedule() takes more than 1 =C2=B5s. =
This is much
> > > shorter than the time needed for synchronizing a 1 MiB frame buffer. =
The
> > > cyclic framework was explicitly meant for short duration function cal=
ls, not
> > > for long duration tasks like syncing the video frame buffer.
> > >
> > >
> > > I think we should remove video_idle() from the cyclic framework.
> > > video_sync_all() should only be triggered if there is video output.
> >
> > So for testing purposes, if CYCLIC is disabled but LWIP is enabled,
> > things are fine here? And so we need to at least partially revert commi=
t
> > 5c8dddadf1c9 ("video: Use cyclic to handle video sync") if not fully
> > revert it?
>
> Hi Tom,
>
> I can't disable CYCLIC without also disabling WDT which then works
> fine as the watchdog isn't being used.
>
> You are likely pointing to the correct patch that is causing
> Heinrich's issue but as far as I know he has the
> hardware/configuration needed to test this and I don't know how to
> re-create his issue.
>
> So in my opinion there is nothing wrong with my patch here and it's
> more of an issue with the video using cyclic for video sync.
>

Incidentally, I've noticed that I only have this
watchdog-not-getting-reset issue when using the IMX FEC driver. The
IMX QOS (imx8mp) has calls to udelay in the packet send and udelay
calls schedule. I'm not sure how many network drivers out there end up
calling udelay/schedule on their own.

Best Regards,

Tim
