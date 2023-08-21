Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1A7EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93763871F2;
	Mon, 21 Aug 2023 21:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VGAXve+k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4A0C871E9; Mon, 21 Aug 2023 21:13:40 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94CF6871C9
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d7485d37283so2100787276.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692645213; x=1693250013;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVUO7AaGOJGe/LxZeA64YdDb+FisPfOJq+a5FMHBqsg=;
 b=VGAXve+k0rcwXJCndguXAKS/PiRE8MYikyszSNkQXVWTfZ0y7Eiq63TcCaiQznEsAA
 1D0AhJ7Qg1VtuugTuKPy6HQrqv6zD3qx2IKcjKk+/61JFC8a9O8LhM/C7RqJEsz0mMBr
 RXfAprSpRYHhPahZxkvZLJyqrYfYDbUhDmVhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692645213; x=1693250013;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bVUO7AaGOJGe/LxZeA64YdDb+FisPfOJq+a5FMHBqsg=;
 b=fssOMY7PfFi8NGt/bCI5wx10uXd7Haew1U3RF/70X8QEnh6wwyHzwZTEI2Kt7DQPcH
 7sk8IVfFWyqvI26znskvhtWIET7CXApZ1nQzUQiXlEbpnKDr3u8k9pYV77MnSc+FtpFY
 HsZozHA+2PbBLhXiyDW+uue2ZUjkr4QqYg/250P7dzxtDmnt+GohmRCzg8aqyT1tc96i
 1ZmrGbjCQfPlLf5Fa7CbavhsDACOAdTTV0eDvR4LlG4UKaNbf4YyU9LpLQVRFbEUCRge
 FIV9FSp8hYfdtEVYJTbqOUTItRDb7O6yfECGQPvEijIcviRFhmTLwfbOxI2N4ieiexEn
 DSmA==
X-Gm-Message-State: AOJu0YzMtsOi5dNZUSGNYlAp0JsKmo3elNEw9P8aQgtUqtVCkTQHV45V
 anGEITHUt4wYXhAo2tsuPYmD9PRhfJsNOU0FF8Rj9Q==
X-Google-Smtp-Source: AGHT+IEkApL/Gn7dgSpLYWJ+uHfjgg7oHMEeMiO3CzZSnlScGZwlepN8QtOcle3DGHa4yacUHINyEu6zozuF4NOGhfI=
X-Received: by 2002:a05:6902:1141:b0:d14:c33c:391a with SMTP id
 p1-20020a056902114100b00d14c33c391amr10057411ybu.52.1692645213118; Mon, 21
 Aug 2023 12:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230727215433.578830-1-sjg@chromium.org>
 <CAPnjgZ2krc9eTrCye9UC6=HM8oTrpVmv8mHEGHJRu5kqu7ts+w@mail.gmail.com>
 <CALeDE9OF_a-e=BOCfDG90uju4Ma7_mrLczAwOSo9rjvjR5sahw@mail.gmail.com>
In-Reply-To: <CALeDE9OF_a-e=BOCfDG90uju4Ma7_mrLczAwOSo9rjvjR5sahw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 13:12:00 -0600
Message-ID: <CAPnjgZ0yfn6wvgP04scMm03v2irHCbCHdejZJoT+p+_NQrLkug@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/3] rpi: Convert to standard boot
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Matthias Brugger <mbrugger@suse.com>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
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

Hi Peter,

On Sat, 19 Aug 2023 at 07:53, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Wed, Aug 16, 2023 at 4:08=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Matthias, Peter,
> >
> > On Thu, 27 Jul 2023 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > This series moves Raspberry Pi boards over to use standard boot.
> > >
> > > It also moves rpi over to use a text-based environment. Unfortunately=
 it
> > > is not possible to empty the header file due to several CFG options.
> > >
> > > Fix the repeated "and and" while we are here.
> > >
> > > Note that this reduces rodata size by about 4.5KB. We could get anoth=
er
> > >
> > > for a total image-size saving of about 15KB. This is mostly because
> > > HUSH_PARSER is not enabled anymore and the environment shrinks down b=
y
> > > about 3.5K. Hush is not actually needed anymore, since standard boot =
does
> > > not use it. Also CMD_SYSBOOT is dropped since standard boot calls the
> > > pxe_utils code directly in that case.
> >
> > It has now been about 6 months since I sent the v1 series of this.
> > Even this v3 series is now out of date (in the cover letter).
> >
> > Is rpi still maintained?
>
> Yes, but we've had conversations about this in the past and snide
> comments and regressions don't enamor me to your patches...

I'm sorry for the snide comments.

>
> That said without seeing this email I actually started tested them yester=
day.
>
> U-Boot isn't part of my $dayjob and I've had limited time of late,
> that's slowly getting better.

OK, good. We have seen quite a few regressions and bugs. I expect that
to continue for at least a few more releases, as more boards pick this
up.

Regards,
Simon
