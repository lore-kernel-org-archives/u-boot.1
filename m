Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8882CD10F28
	for <u-boot@archiver.kernel.org>; Sun, 17 Nov 2024 19:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0385893A1;
	Sun, 17 Nov 2024 20:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FD7tzZ1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABFBD893A6; Sun, 17 Nov 2024 20:48:30 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51F6A891CF
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 20:48:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5cef772621eso3693026a12.3
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 11:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731872908; x=1732477708; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=adYee4DNSQRsDxsermCl/CLkOWsgxlE+IH3kiew5xi0=;
 b=FD7tzZ1CnVGPAUk0ERyidROjDl//uHe/vVZzr6+aOoZDjtV8gAnMmhoTdT+PertDLS
 igDplzfIADbPT9Hvx3gNAA6xQ+QWv9jp6cBpfTXKFALv7adkx+vxuIvUyhsd3Z5nV6RH
 4D2oVg/Bbq1L05ApVSzhDSADmqfqlax0wBlq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731872908; x=1732477708;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=adYee4DNSQRsDxsermCl/CLkOWsgxlE+IH3kiew5xi0=;
 b=BAy6vFlTycyzVFsXF7Rc3ECvKfsykxDZD+b+mAYyu/o7V8eMyQnHb0yXfWJn5Cwrz5
 1TMWGRDWfV1K4wF3z7fOMGNn+aT9zsqBLRLrLTPx+VAuedW8JZMx9Q05wCZoxHNqKCPJ
 3LOjTvl9miBGV99t0pYMLDJNWSG80B0td8H+elMv8QOPRuhnC9mJm+42GeuE8Swn1eCu
 A2E3mHAByGeRAiY9Wy34tCeIb91N0AMbtAr+cP1Y5LfhLG5jCx//95KquSijmPbhBfwH
 84BSbAU+jnxHtxdodV3LAqCKTvZfSz9zc4gLichm2sKwUAVtwud73STdoXYX2Dn+Fd/N
 CLvQ==
X-Gm-Message-State: AOJu0YwgMwBhZ1SfBL8qVoVrDNthrL+E/QNANSOXjlspUIY7phSYFzLi
 JAqvOxQAmfe2LQP9sfS6TtMzUWgr66/N6keeXy3WnV0i36HmHVjH2euV2G2ZYvFa8W31yZ9drkP
 e9VjcgMfIhbDxuzqD3SOKfzeCDJXqSwZCUzXJTbPxwFQBw2c=
X-Google-Smtp-Source: AGHT+IHsYt74vAC9h6TzBagZ0aVAixL4ooj1jkLn7CpFPzN/TLPmR27SkVGRO68PAhatXvX+4l5T6kMfedA11YPzRec=
X-Received: by 2002:a17:906:d54b:b0:a9a:4f78:b8 with SMTP id
 a640c23a62f3a-aa4833ec1b5mr790220566b.2.1731872907596; Sun, 17 Nov 2024
 11:48:27 -0800 (PST)
MIME-Version: 1.0
References: <20241108152350.3686274-1-sjg@chromium.org>
 <20241108152350.3686274-9-sjg@chromium.org>
 <20241113024029.GH3600562@bill-the-cat>
 <CAFLszTirek2=_j15W5LCZERTs2TZXawV0o3aGO12dgDJpzTdQw@mail.gmail.com>
 <20241113222016.GZ3600562@bill-the-cat>
 <CAFLszTivnmnB+1p58sZ_VSZBWpL1Kt7QJ=mnnEvHZswAeEZc0g@mail.gmail.com>
 <20241115144412.GV3600562@bill-the-cat>
In-Reply-To: <20241115144412.GV3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 17 Nov 2024 12:48:14 -0700
Message-ID: <CAFLszTjqJ5dr8_qm6y2pv+76kBEgv5BbwLigB2YfYWHmD2h-3w@mail.gmail.com>
Subject: Re: [PATCH 8/9] buildman: Propose a format for extra boards
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Fri, 15 Nov 2024 at 07:44, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 15, 2024 at 06:37:18AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 13 Nov 2024 at 15:20, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Nov 13, 2024 at 09:03:35AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 12 Nov 2024 at 19:40, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Nov 08, 2024 at 08:23:49AM -0700, Simon Glass wrote:
> > > > >
> > > > > > It has become more common to use config fragments to extend or adjust
> > > > > > the functionality of boards in U-Boot.
> > > > > >
> > > > > > Propose a format for how to deal with this. It is not implemented as
> > > > > > yet.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >
> > > > > I think that the first problem is that this patch series is an
> > > > > inappropriate method and place to start the discussion.
> > > >
> > > > We had a discussion a year ago but it trailed off.
> > >
> > > OK. Still an inappropriate place to resurrect it.
> >
> > What do you suggest? I am trying to solve the problem, not just talk
> > about it, so patches are often best for that.
>
> Well, in that there's a problem to be solved, it's that buildman makes
> #include more painful that it should be to use.
>
> Or, we validate config fragments by building them. A requires-buildman
> solution is not appropriate. That:
> https://patchwork.ozlabs.org/project/uboot/patch/20241114115049.2070780-2-patrick.rudolph@9elements.com/
> doesn't use the acpi.config fragment is because of the parsing issue
> buildman has.
>
> > > > > I also think this gets things backwards as the common case is "make",
> > > > > not "buildman". We need more defconfig's that are just base +
> > > > > fragment(s) if they're important enough to be a combination that needs
> > > > > to be tested and work. A board is not a time-expensive part of CI. A
> > > > > pytest run is, a new job itself is.
> > > >
> > > > OK, that would work too. It would also avoid the problem of combinatorial
> > > > explosion. But I am not seeing people actually doing that, with rare
> > > > exceptions.
> > >
> > > I think it's the exception, not the rule, where config fragments are not
> > > being put to use in a defconfig. And that's possibly because not a lot
> > > of people seem to know about the #include option, and then when I
> > > explain it exists to people the next problem is "Oh, I have to do what
> > > so that buildman also works?".
> >
> > Are you looking for any feature in Buildman for this? This series is
> > intended to fix [1]
>
> Yes, the part of this series that, if I read it right, causes buildman
> to read the preprocessed config file, rather than the raw defconfig, is
> what should fix that, as the final patch in the series confirmed.

Are you saying you want a validation solution that doesn't use
buildman. If so, why? CI relies entirely on buildman for building
things.

The first 7 patches of this series resolve an issue that you filed.
Above you say 'because of the parsing issue that buildman has'.
So...should we fix it?

I don't like having fragments in the tree where we don't (at least
programmatically) know what board they relate to. At least I think it
should be an error to add a fragment with no in-tree defconfig users.

In any case, I think the file format I have come up with is somewhat
reasonable. My main concern with it is that it might greatly increase
the CI load.

Regards,
Simon
