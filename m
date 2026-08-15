Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7655C5AD5A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 18:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7296C4080E;
	Sat, 15 Aug 2026 18:55:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c-fx5h4F3nOr; Sat, 15 Aug 2026 18:55:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0885F40802
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786820127;
	bh=ziedgTYrEe8XJqfPhNc8uqF74rg9ZEliwI48HjDnxC4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KrtFsoUOfSoDMINV2+GfV34tX+cJW2AhXVo1VMTjnbhcaP/a4zSiOpysAKivCZmuf
	 343VZCd2u/kpqrKziJHkpn2WYOt2S0aVCcDp7VTGhaXHMW3gGOm1IHAD7EmC5aD7Ph
	 +ZwbXfBKCatJn5DQGY0WPGzHJqmoTtf9WOOOxS8WY3cIndFPNEosY0GmiP6esu+Rrn
	 J3M07HZlIJDVEN929mNtEYlakutrcGPwJfNLspY5Y/c9wF3A3WQZ9+oqueBIzxACHp
	 H9fyN9UnLmUhp0lumlrQ5Yr84RCxjy0SrmwSYTvwbnu6YbMX/EORo/RHwW8XS739hG
	 Rm0AYEfB4OC3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0885F40802;
	Sat, 15 Aug 2026 18:55:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 84C5723F
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 17:23:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76B11400AA
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 17:23:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Da_fWnvUQVG for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 17:23:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::92b; helo=mail-ua1-x92b.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7AE4240026
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7AE4240026
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=NaFJaIQQ
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7AE4240026
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 17:23:51 +0000 (UTC)
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-96944741eaeso474838241.1
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 10:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786814630; cv=none;
 d=google.com; s=arc-20260327;
 b=hOAltlVPvIXoqIz20JosXSjME6kJK6b0qIUaa/HwCQQQrdAEeo64BWD1zfaYcMt7Mq
 wwMpe6YyEFqfVoZ1Lgz+Kcei3aJNEZ3m2gCBMw1Z1di2U0ZU+RhFRVJPewvMS7UZPPKr
 ikx5Acd+wvko4fNLlgbqElwb0VIYMTiUbTfutWdO1Blz0WYciHhAC2Kl/65Ogn51V/Sj
 hdjVnTaOjzSyassAcDlf0Bnm7yEYZm8g3j4uegnOEu/OZH/fsBWyJkhB4a2YOeYr9SHk
 na+bZSbjQ/T+42RyOghDA6doyMDoriWbEVpq8OPO0ijikluQZybBEm9GCX7TN2Ke9EYB
 QwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ziedgTYrEe8XJqfPhNc8uqF74rg9ZEliwI48HjDnxC4=;
 fh=2Xwx16O9LbRjt2i+odzJsXLS0Hr6Z3H7RZdBUMpFkjY=;
 b=gex47Q+v1CAe7+U6G6lk2JGtw6xw4Vti9Cj+Sv744sQcU11HsWb+AW61W6Y5jFvgVY
 qoBpKJiCwuXt0UmsNVSDUwuk33XJHw1lm0S9a0Rd8LNmxjMg1LwAMEtHF9Bk3j7l/sVN
 YF1Cw8sMTLUs0KefTTMj1aY5jy1/P/oX5JwY+Nmq+fVWPlGqEC4pDEiMwdzNL3e+bPos
 NssvQumjT22KiPqjigXvITe1qQH5XoJC4Mf2ZRs/IwosZvNnNccZknxtLo3n2/j7ciRX
 KlmD9esKSxJmtMsv86nLyZDZYxcPpJ+8uow4jl8YPK4qQtioAcIPbArQcwN7s6VyKzDa
 TIGA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786814630; x=1787419430;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ziedgTYrEe8XJqfPhNc8uqF74rg9ZEliwI48HjDnxC4=;
 b=NaFJaIQQw5rAnObB57UAcVW2FT6pyiDCPQAmoARBuh/V+rkfO6tyD65jL6aEn6HUCC
 9Um0H5Lfuz7IhtJvHAXaOkCec7rg9X6SIrvCyBWGGAO8dVh/gUO8D4/fqu75TDraN1NI
 SeGt4lbCrprofhhOsQOaSxJvOsprsWla2jxev7GmUjqr0onlGtI6crvXqOCtwUNXE2gC
 XpfQ41VKnQDvffEyTJgrQlZknK5PhIoDvo7rA6qNfOgFheOQzUeo6WlLfBulKttQk3tL
 isaahjnjXT/JgLNHi1aIXWXaDAd5mYpmsuk8CTkzzzhEtB1PRV2iPrf1UPgwaPAZKfsy
 ob8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786814630; x=1787419430;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ziedgTYrEe8XJqfPhNc8uqF74rg9ZEliwI48HjDnxC4=;
 b=dJf61S4pqfM6VXPcBdGFkYJ4CWnc3HirUOakkfxFpFFPei85tZcLC4Ht0Dm2UKYVM/
 YKloKsCEQMyoWD4M8B2+t5iOWkEzK3qaIJbIq2n+gYlZOtidPze1kEUqSDfx3L4I6lqN
 LW51fan3yhnqRehyO54TynR6DEjvVg0XRfO/sdN5+eIza/u3XWnzENrMt+6tBytekJjv
 EGbgou58BVWUPRZxL3yLt8jEiKeQOOHezoyTDro9qIHQbSnh7543lWfmPaDFVCmht7Hr
 HQRpbf9uB2wMCF2j3L6FQBuf5HzV3cTcIxRWa46OndR6MnvcP0tHj/oizlM4EDv+XBwe
 NLlw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9zy0dK9alAy5nM3DYy2Ijk1neaa3tE2WjTGa+asgyuyJym5PBVhiwr2P37wC17o+sUg4L/Ok=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy3CT4md6zTtYg4oQcnNJKNEr/UQDHByTb9pcuQZCr0j5g4deXA
 Shg9puQIpzHcyW2zwbVYnDGCpFSC3wGY5a4dNqUoybNWrKCzUbuTF744XEGwr1BUixU2QV0sywX
 bNhOLzziVE7PCrFwCRSbWfQsBiNBNwQ4=
X-Gm-Gg: AR+sD122gFB8S3EHV4pSLxXmBxMQ+dRVxgOwlY5RCqytw2NgsjZjfmG2Srufc+AYBIk
 9q6guEupdDrtlM4rj3IPuj7iRUwCvAR2tsfBEegoOpb3eWHS5KUyI1NcdDY7wpMhd07lfWucCBb
 Z4lBN069iXZzB19PGdoWWFoRd9lH1K0YkY+0ZZzgyRZQMNT9W5vyyZiqzq9ROK+YOoUR3AjV0zT
 RaCmY+33SGCARrLsTymynh7BiieFUcRj6lxHGmeRMAIzjkenVhyd3X460WRktt6sD1kRzcvFBLQ
 JOhelbVkWM9z0PE1xMJZi1nRu4xkWOSwDxqki5zNSliYL7CzWZe/NXvHynFzeL5pYDKHCW/BwwM
 vRJ8IPGCoHmMcF3dzg9saLbF1FttxV/Na/o5pG0QGLCl0qorCzLp5lBkkA44rq9GKS+jCQlVjS1
 wpmkzSDpMQS9gyWkvvbePCJ5xMYpN8mks39rimleLqsQ==
X-Received: by 2002:a05:6102:3fa8:b0:745:78d4:4856 with SMTP id
 ada2fe7eead31-76f2b9172abmr2260933137.7.1786814629770; Sat, 15 Aug 2026
 10:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260813-submit-ce-series-v2-v7-0-593fcd8479fd@gmail.com>
 <20260813-submit-ce-series-v2-v7-6-593fcd8479fd@gmail.com>
 <CAFLszTig3sOjU-bDZ5mrkmXvRabLA4Rsg4oC_n6+4Y=ghhXpeA@mail.gmail.com>
In-Reply-To: <CAFLszTig3sOjU-bDZ5mrkmXvRabLA4Rsg4oC_n6+4Y=ghhXpeA@mail.gmail.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 15 Aug 2026 11:23:38 -0600
X-Gm-Features: AcwNN1UROH51tP7xSzS2hOjZCdh9CDgYVexdC6p0l6cid72M5PQAMEg3aZ7r8nA
Message-ID: <CADvTj4rTCJN=azo4YAt=smZum=HRw9gNF0MJ3eXfkzpNuhEEsw@mail.gmail.com>
Subject: Re: [PATCH v7 06/15] crypto: hash: support hardware-only progressive
 hashing
To: Simon Glass <sjg@chromium.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.u-boot-project.org, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, 
 Thierry Reding <treding@nvidia.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Francois Berder <fberder@outlook.fr>, Peng Fan <peng.fan@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Stuebner <heiko@sntech.de>, 
 Vincent Jardin <vjardin@free.fr>, Raymond Mao <raymondmaoca@gmail.com>,
 Yao Zi <me@ziyao.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 15 Aug 2026 18:55:25 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, Aug 14, 2026 at 4:31=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi James,
>
> On 2026-08-13T19:58:53, James Hilliard <james.hilliard1@gmail.com> wrote:
> > crypto: hash: support hardware-only progressive hashing
> >
> > FIT configuration signatures hash multiple discontiguous regions throug=
h
> > the legacy progressive hash interface. This still requires a software
> > implementation even when image hashes use a driver-model hardware
> > provider.
> >
> > Add provider selection for progressive driver-model hashing and use it
> > from hash_calculate(). Allow SPL_SHA256_LEGACY to be disabled explicitl=
y,
> > link the SHA-256 software support only for a selected software backend,
> > and make legacy fallback paths reject an algorithm whose software
> > callbacks are absent.
> >
> > Extend the hash provider-selection test to cover progressive
> > initialization.
>
> That seems like a stale comment, at least for this commit.

Missing tests added in v8:
https://lore.kernel.org/u-boot/20260814-submit-ce-series-v2-v8-6-fe9212431a=
94@gmail.com/

> >
> > This permits SPL to retain SHA-256 FIT support while relying exclusivel=
y
> > on a hardware hash provider.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> >
> > boot/image-fit.c                  |  2 +-
> >  common/hash.c                     | 21 +++++++++++++++++++--
> >  drivers/crypto/hash/hash-uclass.c | 31 +++++++++++++++++++++++++++++++
> >  include/u-boot/hash.h             | 14 ++++++++++++++
> >  lib/Makefile                      |  4 ++--
> >  lib/hash-checksum.c               | 28 +++++++++++++++++++++++++++-
> >  lib/mbedtls/Kconfig               |  2 +-
> >  7 files changed, 95 insertions(+), 7 deletions(-)
>
> > diff --git a/lib/hash-checksum.c b/lib/hash-checksum.c
> > @@ -20,13 +22,37 @@ int hash_calculate(const char *name,
> > +             if (!ret) {
> > +                     for (i =3D 0; i < region_count; i++) {
> > +                             ret =3D hash_update(dev, ctx, region[i].d=
ata,
> > +                                               region[i].size);
> > +                             if (ret)
> > +                                     return ret;
> > +                     }
> > +
> > +                     return hash_finish(dev, ctx, checksum);
> > +             }
>
> If hash_update() fails partway through, the provider's ctx is leaked -
> nothing calls hash_finish() or an equivalent free path. Do you need an
> explicit teardown on the error exit?

Yes. In v8 I added an explicit hash_abort() provider operation. After a
successful hash_init(), the context must be consumed by exactly one
hash_finish() or hash_abort() call.

hash_calculate() now calls hash_abort() after any hash_update() failure
and returns the original update error. The existing progressive providers
were updated with matching abort cleanup.

The new failure-path test verifies that an update error calls
hash_abort() exactly once and does not call hash_finish().

See v8:
https://lore.kernel.org/u-boot/20260814-submit-ce-series-v2-v8-6-fe9212431a=
94@gmail.com/

>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Regards,
> Simon
