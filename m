Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05531C02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 19:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C1B8805E9;
	Mon, 13 Jan 2025 20:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oTWLDl9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE2918060C; Mon, 13 Jan 2025 20:38:57 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D935805E7
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 20:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ee989553c1so7815636a91.3
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 11:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1736797133; x=1737401933;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wC3OWiVpIMAWxXHd7wEtfdEkMvKB7aN5R42IUOOsLuc=;
 b=oTWLDl9k2w88unjAVtQEaoR8N1HGG/wOAMi3xf9L1EmHxgZbS8w2I2fya4xCPeW/ln
 rl/TVa05Sqo8KyvEcImhb1wBDzZKEv4XOVeHXPtv4UfUVGrCMkavxlFdhTlRDd5ynGdf
 qnqGih3XxvVG6nwL4IT22Qn+SSbuVOh3m2MPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736797133; x=1737401933;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wC3OWiVpIMAWxXHd7wEtfdEkMvKB7aN5R42IUOOsLuc=;
 b=YXa+DIF6ar9Xs4MwPOJY0JmZZDpbYE6KeCghOTenKg4AtJPvyQeZb/ZSPpnGEH4NLk
 anaRPiN3UKqpDg+TmiamrTWCFm9ANGfjbjiyzlGBpwa08dQgocOoBlJMAuf4Lw5ebn0U
 OX7a2CsaMuLXp4Kad5p5idsa4FYGcRPYOu/p+DMbXRY6+l/YcM1uNHMI0jq5FTQEKlPh
 dF3Mf3nU1MK5+tPmqmXTKlnkRk2IS9baW043D6e+eD8cQjFQ3UsVRa+hGs5gcxVgYchS
 7TuvXu02o7bOIiwp5q+wzCkQh5nl21+9UHUVrLvwrHLfSnr5KYALQ08igvHSeKmWlroS
 EAsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpKYU9FyyuwlWowvxabMBEZuLkffzJyNgST7+sZFOB+3EzyPd8KO2ZKRDWgMpUjJghfWafLiQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0SR2wU+bZ+dwVw7FtCBZC9YUeVgU1P3TQQG5PKkPlyJ0TVASD
 ZRZ7dxOzTXuUK2gkDFnM2PF+zCQdXK3G64t4K9nju2O6Dgm2jSL1Uv7yYqXlKnL1w7H2BcLk1s5
 NTP75TT0QyU/tOv0ot1QknvG3RvNb4jReAqZKWg==
X-Gm-Gg: ASbGncsuQPx+bDwQeleDLs3XRtlsBFW5t04LXxY8kqLOtL0F4wbdz/AG6m1WLe3OKYX
 9VeXuskTHLgFtnib6ETI5jHs4oYw4zP67qy2rfN8ker58vUXQPhyGoB30WDws/ISxc75L
X-Google-Smtp-Source: AGHT+IGxBpjtwn0jthpNxhZuK89fqQgfJuBVz8Kh13qkgjnVYaSsZA6PdUjRe+tYZ5j87UPJ2+1norJo4a3UnjV0078=
X-Received: by 2002:a17:90b:514d:b0:2ee:d024:e4fc with SMTP id
 98e67ed59e1d1-2f5490dd195mr34204148a91.33.1736797133361; Mon, 13 Jan 2025
 11:38:53 -0800 (PST)
MIME-Version: 1.0
References: <20250113183409.GY3476@bill-the-cat>
 <CAFLszTjDx3bBwgnvB2v6ow70a4-XS-fR5UHFdFQNn7Fdytba8w@mail.gmail.com>
 <20250113193035.GA3476@bill-the-cat>
In-Reply-To: <20250113193035.GA3476@bill-the-cat>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 13 Jan 2025 20:38:42 +0100
X-Gm-Features: AbW1kvYh-NuL7kSCiPBSfzHNq72j4esckR7nwG-E-n0wNj7Wx74sMzqfRa0j2So
Message-ID: <CAOf5uwmgnGzhu6Un-ZOA_QgBb3naK1EJ5jSE5mG+4dRPSOL1pg@mail.gmail.com>
Subject: Re: [ANN / RFC] Regular community calls?
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

Hi all

On Mon, Jan 13, 2025 at 8:30=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Mon, Jan 13, 2025 at 12:10:35PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 13 Jan 2025 at 11:34, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > Hey all,
> > >
> > > It's been suggested again a few times recently that we should try and
> > > have some sort of regular open call / video chat as that might help
> > > clear up some issues. To that end, I'd like to propose we have the fi=
rst
> > > one at 9am -0600 UTC (3pm +0 UTC) via Google Meet. This will be a day
> > > after the v2025.04-rc1 release, and I'll include a link in the releas=
e
> > > email. If this works out well, we can make it a regular thing for the
> > > day after a release and also try rotating the time, or having a secon=
d
> > > meeting much later in my day that's at a better time for other parts =
of
> > > the world.
> >
> > So do you mean the first one will be in two weeks (i.e. Tues 28th Janua=
ry
> > America/Europe, Wed for Asia?)
>
> Yes, thanks for the clarification.
>
> > Here are the running notes
> > <https://docs.google.com/document/d/1YBOMsbM19uSFyoJWnt7-PsOLBaevzQUgV-=
hiR88a5-o/edit?tab=3Dt.0>
> > from the previous series.
>
> Meeting minutes are good, but perhaps we should send them out via email
> so they're more accessible.
>

+1

Michael

> --
> Tom



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
