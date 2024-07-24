Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F434C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 17:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77F998875F;
	Wed, 24 Jul 2024 19:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="lzXj8cQE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A4248897A; Wed, 24 Jul 2024 19:10:51 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F7A58857D;
 Wed, 24 Jul 2024 19:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1721841047; x=1722445847; i=frank-w@public-files.de;
 bh=xrrKoQbuuDq6ABAhGNuEUKh5cycos3Wq4gue417VzqA=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
 Content-Type:Date:In-Reply-To:References:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=lzXj8cQEFeVG6MW7Ygd5Q6asUb8z2yBAlDu7kXn5AvPhLUIXDEALXJTw1e8fx8zG
 NovnZKbGerwTq6bhPKu5nf96mZx+ECdEmLMgwXZ+uaVn9mrBOU1fMmtDVlGrLAKSP
 0GE8BSVcxCk1RNWDExWjq/v2RZ451gBh/PnyzjY1KB8DLj8ppXMzyrd1CQnWlZ/3Q
 +Vi0rwIcK5Da2VTV0dIi4HVoGDcPkt2h9CGKXN9JA3rzFFggGlD8GFshxeviaJCfY
 b9vWGKwzqE/r+L23PrXBpWIoUqaKavFbSMZeB+43WA0yBhIDiVD4kHdkcjDgxAAKY
 oH8Y9LUJyEUHPO6PEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.159.2] ([217.61.159.2]) by web-mail.gmx.net
 (3c-app-gmx-bs37.server.lan [172.19.170.89]) (via HTTP); Wed, 24 Jul 2024
 19:10:47 +0200
MIME-Version: 1.0
Message-ID: <trinity-d8537898-e5c7-4ec3-8477-843b24fddf2a-1721841047587@3c-app-gmx-bs37>
From: Frank Wunderlich <frank-w@public-files.de>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Aw: Re: [ANN] U-Boot v2024.10-rc1 released
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jul 2024 19:10:47 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAFLszTgt90Xne03OH4Z53T77j=ehqUJmK0OAXPNAPS7qm=4__g@mail.gmail.com>
References: <20240723015555.GE989285@bill-the-cat>
 <trinity-430de174-6a75-482c-b8dd-fde586286c63-1721742246830@3c-app-gmx-bap35>
 <CAFLszTgt90Xne03OH4Z53T77j=ehqUJmK0OAXPNAPS7qm=4__g@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:wVTYZBn30dB38t5Ujufy9y7LcHPzQ06xpQNzyXAsvmJySSG9QHtMN6f3qxkoFOrI2EGa1
 TAb1SfOZLr8RzN2WAnTVGJVR24TKjFGJQPMolHBYxwA+MJ/Ni1CNw2uaN5GuOpH9ftaKFCnyLsbR
 Ew0gKDJ/pLI6gczz8Epl7mZ10z3/uiyrKaAMg61GARTlB95reNJk39hbUn3gbhtHG5h++NGk47A1
 /B5ocQAEdikUPuDy0ZuEhfh22w8Db3WburO/YXDxxCPX7qKje31JF6cCyrrOQe/0Q0TyIjJi2RKv
 m0=
UI-OutboundReport: notjunk:1;M01:P0:7HS4gNUcMrw=;ZPRM8dSsKimOHzV3xjD4g9lrRK7
 PY5Lbb0FVNo4uDm3PemhSYpGRGtlQAJSpmIhy0lv7F32LyTC8JZdXhUUM7UhnM8/MehDqXKo8
 TdGcwNIGeiwFe6L3XpQZUtMkbwl9DKUZSgwdSDqnBlwxWItSHoDaF7b2Tjf5M0CO7U4y4ukDR
 hk+lI4c+rT3blqgg04XWHZMJHrf387x+NhSV8dWe5ykW8gChL9LCX5k7pTWAx0Acl7UjVV4xl
 sdAGzdR+jeta7IlXTwDy7Q778RAJq/cwTKJh1IO9IphmjtWB2HnupDANi8fHRYAjJMfYI/P4E
 PZIghx++4BJEXm2l0xgB6G9BOSeEv6k1HvFEaWPSobEq/7F0d+OtFOHK/lqCFV0dOfEZDQkWe
 ANqkymX4QG3eHQl+M+Rgw243fyPzvlJ+Sf+4qfKxEA4wMPqFk/3D0LR/6M1KHKEoQrvOShhAR
 RjHpbDFt5cHiMl0KYFNtqJ0H0mng6oQBAPFzNYvjUo0b2clWHxXrUstShfS8xMs146AK8j4BV
 KMNCxKPfvKMYpYqvyEi+D1JjsqRWgHPAu1CrlKhZhyxmXM0rVNJoYNtXtF5zM9cr+NWojOA48
 doQ18dGcjMVerVVvIbYvwKguVv9iE9cpTZr1jF1Yh43mhCsGZxrnlUqToW8r8bBw4NrLx9qpZ
 B+vt+9NlaNDm6HOAU2vMV1pGBpLWcAAC+AGGzXYnMg==
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

Hi

> Gesendet: Mittwoch, 24. Juli 2024 um 16:37 Uhr
> Von: "Simon Glass" <sjg@chromium.org>
> An: "Frank Wunderlich" <frank-w@public-files.de>
> Cc: "Tom Rini" <trini@konsulko.com>, u-boot@lists.denx.de, u-boot-custod=
ians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
> Betreff: Re: [ANN] U-Boot v2024.10-rc1 released
>
> Hi,
>
> On Tue, 23 Jul 2024 at 07:44, Frank Wunderlich <frank-w@public-files.de>=
 wrote:
> >
> > Hi,
> >
> > i notice build-error because of CONFIG_TOOLS_MKEFICAPSULE is set autom=
aticly and does not find an include
> >
> > https://github.com/frank-w/u-boot/actions/runs/10059612312/job/2780523=
2284
> >
> > tools/mkeficapsule.c:20:10: fatal error: gnutls/gnutls.h: No such file=
 or directory
> >    20 | #include <gnutls/gnutls.h>
> >       |          ^~~~~~~~~~~~~~~~~
> >
> > solved it temporary by adding CONFIG_TOOLS_MKEFICAPSULE=3Dn to my conf=
igs/mt7622_bpi-r64_defconfig
> >
> > commit: https://github.com/frank-w/u-boot/commit/2640a8881d3c6a232575f=
46b0f2b8a0217b6d639
> > fixed pipeline: https://github.com/frank-w/u-boot/actions/runs/1005996=
5071
> >
> > breaking commit seems to be
> >
> > b7a625b1ce49 tools: Build mkeficapsule tool by default if EFI_LOADER i=
s set
> >
> > i have EFI_LOADER set to y,but it is unclear where the header-file sho=
uld be...i do not find any gnutls.h in my tree
>
> We should really build all tools always, where possible.

why require more depencies for tools which are most likely not used by use=
rs...in my case i do not need the mkeficapsule ;)

the gnutls error i get only in pipeline...maybe on my host i have the requ=
ired lib somewhere in the common includes of gcc crosscompiler.

on my laptop i get a different error but also on mkeficapsule tool

tools/mkeficapsule.c:18:10: fatal error: uuid/uuid.h: No such file or dire=
ctory
   18 | #include <uuid/uuid.h>
      |          ^~~~~~~~~~~~~

i guess this can be installed with "apt-get install uuid-dev" but why shou=
ld i fix the depency if i do not need the tool?

regards Frank

> > regards Frank
> >
> >
> > > Gesendet: Dienstag, 23. Juli 2024 um 03:55 Uhr
> > > Von: "Tom Rini" <trini@konsulko.com>
> > > An: u-boot@lists.denx.de
> > > Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.=
denx.de
> > > Betreff: [ANN] U-Boot v2024.10-rc1 released
> > >
> > > Hey all,
> > >
> > > It's release day and here is -rc1. Looking at my own queue, I think
> > > it's in OK shape, but there's a few things I want to take still, and=
 I
> > > need to check some other areas for mature changes to pull in as well=
.
> > >
> > > In terms of a changelog,
> > > git log --merges v2024.07..v2024.10-rc1
> > > contains what I've pulled but as always, better PR messages and tags
> > > will provide better results here.
> > >
> > > I hope to remain on schedule and that means the rest of the rcs ever=
y
> > > other Monday, and with final release on Monday,  October 7th, 2024.
> > > Thanks all!
> > >
> > > --
> > > Tom
> > >
>
> Regards,
> Simon
>
