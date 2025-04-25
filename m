Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E855EC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 14:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F8718215E;
	Fri, 25 Apr 2025 16:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G4YUX8PX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3D648215F; Fri, 25 Apr 2025 16:36:06 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E5328212B
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 16:36:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e8be1bdb7bso3768428a12.0
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 07:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745591764; x=1746196564; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/WNxXHjsqid2n6pgmlu6wjSZnne0WjMKwYRnrEKY9bE=;
 b=G4YUX8PXPdJH9zd3FuPQFlsgcXNeH7Jpaxl21uPx6rqJlT+dENN+AOHhmhReIvWM4g
 QDjkX9eevQeP+wdxlzir9EWwApMCXhcJMXmDR+g8svCsTOT0eRARi5etjOSvhABDRVex
 ILcJwtFf4oTqotl3lckpfNpYOkxsoKQGLSBjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745591764; x=1746196564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/WNxXHjsqid2n6pgmlu6wjSZnne0WjMKwYRnrEKY9bE=;
 b=dUdgn2ZTe8M/H+1jB+x5yIWj1oslLltRQMkH9GSWuHUMbEVPrz791vkyez6RdDC8rF
 nM0+9AVlg8yY2vk2l2khAz7vYgT44ntVpksw2F7mQQ54i/aaEvfHiMfCxpaB7VFp8cv7
 +XtYGsyEiJeZ5DiPiPDFHGv8neQqTm0a1ZW+xWOxQPyF/MCk/Y0zpDKfaBidAWag8YVo
 aFKfGLz184+6cG0BlvzCLA5TAVaun/PQCIQd4P5CUwKO6+vabbU0mtUndWQx3I0nBw6J
 DP1DmSOtn2Kl4LflSYMq2RRZS6/Um/05OuO/6SRljLJEe2kT7qNv3rK7/DLwZdb+IfCW
 ZkqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWi5R7X8wF9rtv9efbgW7MQmThFUfKmUcpD7OOtaC2vryLIOY/VH1CnRKKFxtw9Ghm4XWQH6s=@lists.denx.de
X-Gm-Message-State: AOJu0YwHtPwV3/mwwywGy9uVzZsmdcd0+zrcOTmfNzN2CD8hup5Aa0qc
 Woe4RYyWLPZY+3XAKgqnNlGgXftMpvCsZoPrSPyzSZr2Xo2oeyKAfRYzoQq1TqMjHegbnt8Wtnk
 VAKvvEkQFprzUhIMoUqXzc+/Km1dy98uTTNs7
X-Gm-Gg: ASbGncvn+6egsh8hB+5Vn87TyqVWVzOON2bpsCOKJCdMNdUwF1eumcjRequTjE+uaZ4
 S0FLB1Epbf+yBp66JJaGm3yy0cy+GRe0J8CnZ/FRKCjx+2eLeJJxuT7B/MkkFmkrBFx3TkxttbH
 TWxNEEDB+VbIxtSThr3RmcjAY=
X-Google-Smtp-Source: AGHT+IFsxcu1mK4P2Z7f0wrorAOF2ew81+huwxJTwxyacbn7bv7NiZXS4VZ4I7u0Z9kVYABUjjSyNe4UIZyEUFkr8os=
X-Received: by 2002:a17:907:1c27:b0:ac4:3cd:2cb2 with SMTP id
 a640c23a62f3a-ace7104e5d8mr251156566b.1.1745591763749; Fri, 25 Apr 2025
 07:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de>
 <20250129-wip-bootmeth-rauc-v1-1-6308e732f314@phytec.de>
 <CAFLszTinU=6v+3OyaH0pp8snYm9BgfVrU_+35x2Az7fVs_CfYw@mail.gmail.com>
 <4aef8b9ffd41d4e36550806f4688fc18dbddc500.camel@phytec.de>
 <CAFLszTjPHBw-F0EkQJnT4TOsxdYzGH5EtRBaeRCoKGxQQ_cw4g@mail.gmail.com>
 <20250424184923.GM5495@bill-the-cat>
In-Reply-To: <20250424184923.GM5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 25 Apr 2025 08:35:52 -0600
X-Gm-Features: ATxdqUH1mQaKSQtiKfMV-UwOFdUiJ2N_mgp7aR_xgJR4tvUcXMhL29DICevRtw0
Message-ID: <CAFLszThPcJjhBVLvz=EkdeEP1K948cC=LyZhBk_Upk3iSWXCig@mail.gmail.com>
Subject: Re: [PATCH 1/2] bootstd: Add implementation for bootmeth rauc
To: Tom Rini <trini@konsulko.com>
Cc: Martin Schwan <M.Schwan@phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Thu, 24 Apr 2025 at 12:49, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Apr 24, 2025 at 12:31:38PM -0600, Simon Glass wrote:
> > Hi Martin,
> >
> > On Thu, 24 Apr 2025 at 06:43, Martin Schwan <M.Schwan@phytec.de> wrote:
> > >
> > > Hi Simon,
> > >
> > > thanks for the review and sorry for my delayed reply.
> > >
> > > On Mon, 2025-04-14 at 05:32 -0600, Simon Glass wrote:
> > > > Hi Martin,
> > > >
> > > > On Wed, 29 Jan 2025 at 07:25, Martin Schwan <m.schwan@phytec.de>
> > > > wrote:
> > > > >
> > > > > Add a bootmeth driver which supports booting A/B system with RAUC
> > > > > as
> > > > > their update client.
> > > > >
> > > > > Signed-off-by: Martin Schwan <m.schwan@phytec.de>
> > > > > ---
> > > > >  boot/Kconfig         |  11 ++
> > > > >  boot/Makefile        |   1 +
> > > > >  boot/bootmeth_rauc.c | 408
> > > > > +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 420 insertions(+)
> > > >
> > > > This looks fine to me. Just some nits below.
> > > >
> >
> > [..]
> >
> > > > > +
> > > > > +       partitions = env_get("rauc_partitions");
> > > > > +       if (!partitions)
> > > > > +               return log_msg_ret("env", -ENOENT);
> > > > > +       partitions_list = str_to_list(partitions);
> > > > > +
> > > > > +       slots = env_get("rauc_slots");
> > > > > +       if (!slots)
> > > > > +               return log_msg_ret("env", -ENOENT);
> > > > > +       slots_list = str_to_list(slots);
> > > > > +
> > > > > +       boot_order = env_get("BOOT_ORDER");
> > > >
> > > > Environment variables should be in lower case.
> > >
> > > Unfortunately, we are bound to the naming RAUC uses for these
> > > environment variables, which is upper case. See
> > > https://rauc.readthedocs.io/en/latest/integration.html#set-up-u-boot-boot-script-for-rauc
> >
> > Can't you change it, since you are introducing new support here?
> >
> > If not, then you could perhaps set the env variables to lowercase when
> > you find uppercase variables? I suppose that would require updating
> > the client to do the same thing too?
> >
> > It would be very confusing for a user to have upper-case variables for
> > some things.
>
> Simon, this is an unreasonable request. This is how RAUC has been
> working and deployed for years and years. It would be a nightmare trying
> to handle migration of existing deployments for an aesthetic change.

Yes, I figured. Perhaps it could support lower case in future? This is
the first I have seen on RAUC in U-Boot, although I do see this file
which has both lower and upper case:

include/env/phytec/rauc.env

Regards,
Simon
