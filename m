Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C831C021A1
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 12:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 335BA80A55;
	Tue, 11 Feb 2025 13:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kQ7aarTy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3763280A55; Tue, 11 Feb 2025 13:40:25 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A4CD8043C
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 13:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom.rini@konsulko.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fa8ada664fso2610930a91.3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 04:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739277618; x=1739882418; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gkgai3aW3QLZaHbhT/GCaAHhw+fYg3Nrenq1U051F5Q=;
 b=kQ7aarTykhdKu4FLtf9bO7BmUhF0l2AUR0WeZ4LMKylSxH+FPp14ujoZ/mzOcy89on
 G9uHPGlZp28sDEskRaDh4A6nGt/BPS5zjB87JpVfgiCA+Eo6h7ri4x9YUABnzyb/gtT7
 vJ3ogyBMULlSXQz1uGhQOdEfhRgGCm681b3PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739277618; x=1739882418;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gkgai3aW3QLZaHbhT/GCaAHhw+fYg3Nrenq1U051F5Q=;
 b=bZPz0wr7SJgyxzDXuWfNXJiR4zk44drDFa4YlS19JcRY1raAbixqzyvViUURGodrQO
 FJprLZYUq4R0koFBg1kzVL/SybLP7jQBE/61rFNOELWCbhkBV6ew3gycBhpSe+apy89X
 nov8/tpcawrR6P2sJ2bG6jhDDR8wDqXlviE+Dt9N/Kg3CE414YR87XZABsReBN1eseYF
 LN4JMtheReWlar1aqQmJi0yI0yLENVl3ma+SEx81hYiZmJNSdWPFf4BuBI+7Hh4MTYJ7
 QoAXUJSADKPCi2Bvj+ThUgwv/2PTvnd8wOcCoq1ReK/mUk9hMwKuc58S4ch7fHrHW9TC
 3UCQ==
X-Gm-Message-State: AOJu0YzpvyvLnACL87qGrXLUhBHwUDMvoJ6BBZOexeVnuzPz+J4E+gTt
 UYzCLcEEFTyPdKd9bOmzdVvHdzK/E+3UVkh2LWHYXqIp4GL3E33uk8h23xbPqmcKBwzBc66b438
 5jXNKxhprA4uAS3glvLzHMJXy6C7IFbPMpvWvpw==
X-Gm-Gg: ASbGncsi+j06OvBj2v3CzpQcon4uOKKUX1h71Xkt7Hqcp0pZSB0LoRwvAw++eKZPyjK
 1yEme8TWVsEKcB7LAb+1FVxh/E/j3H53eOwkUNjZxcB06H1DR3+Hm5QaYOISmE+dd2XcKIN/Gvw
 ==
X-Google-Smtp-Source: AGHT+IFUHCtrWEzQEGXu295ZMgyGmkAAHep7zXX1ELNxKRK+wCrl8TlVX81QhD3g08JWK28mkU/Aol0jkPYgJkc5IVY=
X-Received: by 2002:a17:90b:6cd:b0:2ee:7698:e565 with SMTP id
 98e67ed59e1d1-2fa23f6e5e6mr27010630a91.8.1739277618435; Tue, 11 Feb 2025
 04:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20250210220151.GR1233568@bill-the-cat>
 <5b1e2d1d-87b1-4051-acb1-ea91b0a31dc2@gmx.de>
In-Reply-To: <5b1e2d1d-87b1-4051-acb1-ea91b0a31dc2@gmx.de>
From: Tom Rini <trini@konsulko.com>
Date: Tue, 11 Feb 2025 06:40:05 -0600
X-Gm-Features: AWEUYZmcBe3HWptb_ry4-5ncBwQxdptO72GJofGxNluJA_EJUX7MZxmUS4lHhp4
Message-ID: <CAEGM6azW4Y7b3zL2Ch=yfw-gtJbm0hyZpHLT2EwCLEEjwm2D3g@mail.gmail.com>
Subject: Re: [ANN] U-Boot v2025.04-rc2 released
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>,
 u-boot-board-maintainers@lists.denx.de
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

On Tue, Feb 11, 2025, 1:38 AM Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:

> On 10.02.25 23:01, Tom Rini wrote:
> > Hey all,
> >
> > It's release day and so here's v2025.04-rc2. As this is the -rc2
> > release, I've now also opened up the -next branch and will be stricter
> > about what I apply myself, and what I see coming in for pull requests a=
s
> > well moving forward.
> >
> > Continuing on with what I started after the -rc1 release, I've
> > scheduled a video call tomorrow at 9am -0600 and the calendar link is:
> >
> https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DN280=
N2tlcXE3aDVtbjlicnNkcm82YnA1bDAgODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1ZjB=
hYmQxMWMxYjgzNjA2MWFlMDZjMWM3ZGJjZDE4ZGY0MUBn&tmsrc=3D89be7b813136bec06a83d=
e4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com
>
> When I try to follow this link it Google just tells me "Calendar could
> not load the data. Please try reloading later."
>

Strange, I'll look in to it for next time.

U-Boot community meeting
Tuesday, Feb 11  =E2=80=A2  9:00 =E2=80=93 10:00 AM
Google Meet joining info
Video call link: https://meet.google.com/btj-wgcg-euw

More phone numbers: https://tel.meet/btj-wgcg-euw?pin=3D1307528552322


> Best regards
>
> Heinrich
>
> > and this is the same as last time. I've edited that event to be
> > recurring and will tweak it as needed as we aren't quite every 2 weeks
> > every time, but close enough.
> >
> > In terms of a changelog,
> > git log --merges v2025.04-rc1..v2025.04-rc2
> > As always, more details in pull requests (or the tags referenced by
> > them) will result in more details here.
> >
> > I continue to plan to do an rc release every two weeks and the final
> > release will be 07 April 2025.
> >
> > Thanks all!
> >
>
>
