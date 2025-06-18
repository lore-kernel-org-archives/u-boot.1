Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586B7C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 15:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACE8982DF2;
	Wed, 18 Jun 2025 17:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="Oi4WrrBx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6E9882E08; Wed, 18 Jun 2025 17:33:10 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3F8E82C55
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 17:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2e9a38d2a3aso5091520fac.3
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 08:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1750260786; x=1750865586; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8h1QqNtARcdIe6lQb+zNQ4Bt7+1jpoQEmkkPCEG7sGk=;
 b=Oi4WrrBxa6i7s1n3u9Ivxii2/sDrJaCVicGWW0/zz8i00SQQJshpBxqd4qP3IwcA0w
 KnvsLRS1kFUYeU8TyIhXKPzeQ/YzmX1GSEjtp1iP1dPYZ0RlqYQ8x1Gb2x23/i/8gr0C
 9wzF8mHXS1jpfs8CJ8jOL6ywKWI4ZAh9Dm0vX2UGRGzeEfyHyviRMj1vIE7S1GWw8v9R
 oNhx8L0o2R9GcGnyFBN9bWu2aHAwilsuZ2mf3/0mnhaHaeB5C5O5iAfwsb/uk9tbnXP+
 afuAj2hnyVGCJw/EZ/1yLZXpPFQvTZzQCeDpO4U6VYiHfl3Pb/egxJ1IpLUv+z1sptcV
 7Bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750260786; x=1750865586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8h1QqNtARcdIe6lQb+zNQ4Bt7+1jpoQEmkkPCEG7sGk=;
 b=ZHOUF5NuxlA1rEaLGLUXrxic2++fttGHZykFhx7WeEY9huB3eYSdGIiGwV7KmdvuYD
 Or4M5sSj74CWzwTT4QK2ml8fJrcO/fkmivS0VWKPnaYhvoB2HKxdbotFdOdMeu489lFR
 gkjBqOZpLkukAokszSG2Y4Dtm6owGtCn+wTlOuVkQGeW0fdxReXYI4APsgUGDMs4y8vl
 P5TYiA96QViqojVFjTiI2KS0Bc8K29YCjh/G/OwaD2s42/kBOxDb9FboqBN8EPxFux7B
 h4VORxtlUrJmrIErEtU6KwDt5oMlpxXKuXFU3eAFdtre1RzPjvwSyvOX9ljfz5BdtGfS
 3SkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzJVtyivlrYDOD61wG5SKLBLFDtQW4tLRp8PuAoiKP73I4cBlJGAY1Mh1usJ+8IWo5EaCH/Jg=@lists.denx.de
X-Gm-Message-State: AOJu0YwArmNAmiPNhjv4L6oi97c0m7Byu6p2lafyIlt9hD+tRu56/3S2
 BLUwvdMQEdZCB/KumD42SdrMu0VQwDRBxkA0cFcGMfMSeIEYXB1MvfwGqT3XiTQrG/OO8M04TXp
 bKYorKz/0RZ1Jte9C+DBYjk7/K5NQD1UDqXV/9Gmlqw==
X-Gm-Gg: ASbGncvAJXpQE23PU0cThew5p1zenKq+LIcQOvAhlAWk0DtFt1SyPYJFOGchpRrk4GL
 +TOWlfFbVZ7RUG7okBzGCTrf+Kjw9JTYiyn5g5HX0goPYcenC7+f4uVdZdLW+BSjEOMuG5wSurY
 j3jji0+sWVzFya8pgYt43nFtQ9n4s6Y/ePheWVw6VknlU=
X-Google-Smtp-Source: AGHT+IHIf/A9rYycPZpd57GkDs31zXjaJwp7d0r5Am/Zz6rywUtlw60ak1WEzyQRWtNIcerFuz8tDVFHuAabGGnmhBg=
X-Received: by 2002:a05:6870:b01a:b0:2c2:cd87:7521 with SMTP id
 586e51a60fabf-2eaf07f5f14mr10621917fac.4.1750260786250; Wed, 18 Jun 2025
 08:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250530153826.1057407-1-tharvey@gateworks.com>
 <f19b630b-4a01-4e6f-b419-d2995b45198c@canonical.com>
 <20250617224551.GA1687135@bill-the-cat>
In-Reply-To: <20250617224551.GA1687135@bill-the-cat>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 18 Jun 2025 08:32:55 -0700
X-Gm-Features: AX0GCFuiP7L7FohoTxknvFuHFUJWa5WKCSBVrIK5eKgC6HJNNu79S0nt0DtVKi8
Message-ID: <CAJ+vNU2oNMpupHLHHcf3HTXBTN8mnPczo6T8khAkN875YwmUxg@mail.gmail.com>
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

On Tue, Jun 17, 2025 at 3:45=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sun, Jun 01, 2025 at 11:07:16PM +0200, Heinrich Schuchardt wrote:
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
> > >     /* Wait for DHCP to complete */
> > >     do {
> > >             net_lwip_rx(udev, netif);
> > > -           sys_check_timeouts();
> > >             bound =3D dhcp_supplied_address(netif);
> > >             if (bound)
> > >                     break;
> > > diff --git a/net/lwip/dns.c b/net/lwip/dns.c
> > > index 19172ac959ac..738f8bf3196b 100644
> > > --- a/net/lwip/dns.c
> > > +++ b/net/lwip/dns.c
> > > @@ -91,7 +91,6 @@ static int dns_loop(struct udevice *udev, const cha=
r *name, const char *var)
> > >                     net_lwip_rx(udev, netif);
> > >                     if (dns_cb_arg.done)
> > >                             break;
> > > -                   sys_check_timeouts();
> > >                     if (ctrlc()) {
> > >                             printf("\nAbort\n");
> > >                             break;
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
> > >   /* xx:xx:xx:xx:xx:xx\0 */
> > >   #define MAC_ADDR_STRLEN 18
> > > @@ -284,6 +286,11 @@ int net_lwip_rx(struct udevice *udev, struct net=
if *netif)
> > >     int len;
> > >     int i;
> > > +   /* lwIP timers */
> > > +   sys_check_timeouts();
> > > +   /* Other tasks and actions */
> > > +   schedule(
> >
> > Some scheduled tasks have a long duration, specifically video_sync_all(=
)
> > called via video_idle(). This change will lead to lost packages.
> >
> >
> > @Tom, Simon
> >
> > The EFI code was impacted by 29caf9305b6f ("cyclic: Use schedule() inst=
ead
> > of WATCHDOG_RESET()"). This added schedule() calls to EFI networking.
> > Package losses can expected if schedule() takes more than 1 =C2=B5s. Th=
is is much
> > shorter than the time needed for synchronizing a 1 MiB frame buffer. Th=
e
> > cyclic framework was explicitly meant for short duration function calls=
, not
> > for long duration tasks like syncing the video frame buffer.
> >
> >
> > I think we should remove video_idle() from the cyclic framework.
> > video_sync_all() should only be triggered if there is video output.
>
> So for testing purposes, if CYCLIC is disabled but LWIP is enabled,
> things are fine here? And so we need to at least partially revert commit
> 5c8dddadf1c9 ("video: Use cyclic to handle video sync") if not fully
> revert it?

Hi Tom,

I can't disable CYCLIC without also disabling WDT which then works
fine as the watchdog isn't being used.

You are likely pointing to the correct patch that is causing
Heinrich's issue but as far as I know he has the
hardware/configuration needed to test this and I don't know how to
re-create his issue.

So in my opinion there is nothing wrong with my patch here and it's
more of an issue with the video using cyclic for video sync.

Best Regards,

Tim
