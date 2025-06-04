Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F1CC5AE59
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 00:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E56B881F0D;
	Wed,  4 Jun 2025 02:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="DCEreuuc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D038781FEE; Wed,  4 Jun 2025 02:04:29 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0AFA81E72
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 02:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70e767ce72eso62894237b3.1
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 17:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1748995464; x=1749600264; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHuMPHrxNX52I0F5KXlI206A53SslfZZ55jWbAYL7qI=;
 b=DCEreuucpeKhIZDcEa2XyjlJqVAndOJYi6t8TrG+qrSsxrRqd7clJeFBRi7uNd8GXx
 Af46bad8BJKVsev90I8pki99AJm4oi5fQ8U3/TUA+Dt00wMp99hykXv7BlBovXAplCA1
 t1v5NtHPht437dKmmr2XERKlVsW8BAn2pJqao6tON3sEAV60FAxvSJUTzQMBUcjd9tHK
 XDv95HkvGhqlH/FHjJqtmtpXzTxEjfpqoTud1nMSOSobsxzNgF39Gwq3NXlfAlti8BZx
 92uvfpRNftow567DbwyZ8ZSWTSXyYJd96i6MA6lIxwfCyJpM6lYaRFqWig0T12475n2/
 ybzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748995464; x=1749600264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHuMPHrxNX52I0F5KXlI206A53SslfZZ55jWbAYL7qI=;
 b=HPWpl/NKxGlN2SrBjxy7XZzZlWjYnlshC5fxt1uTmCzYotLofYuoUvNgfcmCkI7TjZ
 DqKBYjhaGgSIe2qRClGDQ6k7EeOgXLlHfM8sca2zjBm1jelGs8fKSxmQ4l9XTh/pzTl8
 Ya74/qMhfG+YhEZ1opbdXk7tWcQYXY1r7par0+j4HwgcgVl66scFpGcGu/mUAWuqa4gm
 fHbi/YaepFiIsejqBkggJYFLugGvFKnamYkOq2RZxI3smt/KzhCux9jVy69iTRAU+PMA
 hS/3bkEJ7tKdlF0/gVpEzL4pK1npw7O7orshVzVqE9SBeU3e5gf1vqsm1fiA5YsbV0Ve
 8Mbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaukWmZIPQf+YPqkuaw8QXUg5YHwSRwwKC0byfCN9WPhTXVNGHz7ELBg0i/ZIth1QRrV+ql7g=@lists.denx.de
X-Gm-Message-State: AOJu0YxKLRk6fD/1HJLV+T2xqqfjY4sWDXB6+2achiFpWBHs9SvFMSBb
 mSAv+0fBEdJm1uU2i+vDNltT3d3ZmTZJRq5lKf8xNvdqed/faZhJXdB6LCS3CNQcIAn9iSsAExw
 VZH7nbjLYYPIwt1no2Vnt4Ib3eJDrFIgMvMSfgbyDiA==
X-Gm-Gg: ASbGncv6EdkYnVJuozy6i13H0QdnFEbSNr0DBGS2Qt4M0alteKkivSU+vC36hLSHur8
 Uk5UfvS8KeRYDmnFnH4MJ5pmqe72h4YFcD5PLK5IfiKuPtSI+WAIsUcK5Y4UjinyAE/ku82LkzK
 /6FbumIPuEGG2AbBnJOJwxxhEyrsozXCst
X-Google-Smtp-Source: AGHT+IFsKjg1DU6Hh+dPIIgSK0rTyid2TN6+sQ8Xw/CQwtNGVpJnZtbeMzoBeMs0AmSrZAhnJqu8nnmR3XWcbDUYLrg=
X-Received: by 2002:a05:690c:dd3:b0:70e:2ba2:659d with SMTP id
 00721157ae682-710d9f523c9mr9965857b3.23.1748995464540; Tue, 03 Jun 2025
 17:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250530153826.1057407-1-tharvey@gateworks.com>
 <f19b630b-4a01-4e6f-b419-d2995b45198c@canonical.com>
In-Reply-To: <f19b630b-4a01-4e6f-b419-d2995b45198c@canonical.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 3 Jun 2025 17:04:13 -0700
X-Gm-Features: AX0GCFt2e0LYqT7oYH-ObEMagQoql2pEV3mlov1efCecMCHLAsVYZbRRjyZlMXg
Message-ID: <CAJ+vNU2UfSVHvo=_HsCKbWH5AFsYV=SnVGru4ZBWHrGnAVBcRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] net: lwip: call sys_check_timeouts and schedule on
 rx
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
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

On Sun, Jun 1, 2025 at 2:07=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 5/30/25 17:38, Tim Harvey wrote:
> > Call schedule() in net_lwip_rx() to service U-Boot tasks and
> > actions during packet rx.
> >
> > As a cleanup also move sys_check_timeouts() here and remove it from the
> > functions that call net_lwip_rx().
> >
> > This resolves the issue of an active watchdog resetting the board on
> > long network activities.
> >
> > Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> > v2:
> >   - remove duplication of sys_check_timeouts() from functions that call
> >     net_lwip_rx()
> > ---
> >   net/lwip/dhcp.c     | 1 -
> >   net/lwip/dns.c      | 1 -
> >   net/lwip/net-lwip.c | 7 +++++++
> >   net/lwip/ping.c     | 1 -
> >   net/lwip/tftp.c     | 1 -
> >   net/lwip/wget.c     | 1 -
> >   6 files changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
> > index 92bd7067a7fb..b79b746db390 100644
> > --- a/net/lwip/dhcp.c
> > +++ b/net/lwip/dhcp.c
> > @@ -57,7 +57,6 @@ static int dhcp_loop(struct udevice *udev)
> >       /* Wait for DHCP to complete */
> >       do {
> >               net_lwip_rx(udev, netif);
> > -             sys_check_timeouts();
> >               bound =3D dhcp_supplied_address(netif);
> >               if (bound)
> >                       break;
> > diff --git a/net/lwip/dns.c b/net/lwip/dns.c
> > index 19172ac959ac..738f8bf3196b 100644
> > --- a/net/lwip/dns.c
> > +++ b/net/lwip/dns.c
> > @@ -91,7 +91,6 @@ static int dns_loop(struct udevice *udev, const char =
*name, const char *var)
> >                       net_lwip_rx(udev, netif);
> >                       if (dns_cb_arg.done)
> >                               break;
> > -                     sys_check_timeouts();
> >                       if (ctrlc()) {
> >                               printf("\nAbort\n");
> >                               break;
> > diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> > index f05c4cd3f64f..e8d4cc542ed8 100644
> > --- a/net/lwip/net-lwip.c
> > +++ b/net/lwip/net-lwip.c
> > @@ -13,8 +13,10 @@
> >   #include <lwip/etharp.h>
> >   #include <lwip/init.h>
> >   #include <lwip/prot/etharp.h>
> > +#include <lwip/timeouts.h>
> >   #include <net.h>
> >   #include <timer.h>
> > +#include <u-boot/schedule.h>
> >
> >   /* xx:xx:xx:xx:xx:xx\0 */
> >   #define MAC_ADDR_STRLEN 18
> > @@ -284,6 +286,11 @@ int net_lwip_rx(struct udevice *udev, struct netif=
 *netif)
> >       int len;
> >       int i;
> >
> > +     /* lwIP timers */
> > +     sys_check_timeouts();
> > +     /* Other tasks and actions */
> > +     schedule(
>
> Some scheduled tasks have a long duration, specifically video_sync_all()
> called via video_idle(). This change will lead to lost packages.
>
>
> @Tom, Simon
>
> The EFI code was impacted by 29caf9305b6f ("cyclic: Use schedule()
> instead of WATCHDOG_RESET()"). This added schedule() calls to EFI
> networking. Package losses can expected if schedule() takes more than 1
> =C2=B5s. This is much shorter than the time needed for synchronizing a 1 =
MiB
> frame buffer. The cyclic framework was explicitly meant for short
> duration function calls, not for long duration tasks like syncing the
> video frame buffer.
>
>
> I think we should remove video_idle() from the cyclic framework.
> video_sync_all() should only be triggered if there is video output.
>

Hi Heinrich,

It makes sense what you are saying but I don't have the hardware to
test your scenario. Can you submit a patch for discussion with a fixes
tag?

Best Regards,

Tim
