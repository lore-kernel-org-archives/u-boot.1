Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FEAE77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 15:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E980F801F5;
	Fri, 10 Jan 2025 16:51:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="M/eI0Skb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9B758036B; Fri, 10 Jan 2025 16:51:03 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC56280050
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:51:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ef87d24c2dso3010624a91.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 07:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1736524259; x=1737129059;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=644eJkarIePJJW184QwREw51+EFu7qiRi6mwo+rjAus=;
 b=M/eI0Skb/Rvbc4EBaouEpv7guZqu9c3/Q4u8VnqMuaGHMFUHH6ZkmeQMnhJ2x2qEGN
 n+YzNcQeM9yPfW4ovT6auPcR4P2+yXciQvC7j86gfVx/S05gLxLtRvqz8NuHDM/JK6gl
 hSXxhzljIFyAmw13TeAa1W77OTkiUZFPs97ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736524259; x=1737129059;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=644eJkarIePJJW184QwREw51+EFu7qiRi6mwo+rjAus=;
 b=QbgOzN3gjUoCykN3mRwKAOpme5qGLNr6+7uFogW50n3yhxzrNtq6y84oAk7W+GDZL6
 hMjHnG9spm0BAaY2m7xXFXF7JB1VrGCp+rssfnjUij78FMW4GjQV4rBoci9BBdC9bInI
 RDYWScCydd8KKdghfDrICmVUsSKcGKkJiK2rO0JEegUb+La57wNQQ2D/sKPpZ0fzIFMo
 fsv6hzs3+DHp0hcnROyqeYQM+Gge7Qa3B4iQwKco/qda6i8H9/x2O0UvrFYP4bJcq4Ch
 IoljPE134rY5PGMB2QjCkNeXnCz4GeEzaaaJM4tDOEk/euT95bKblbUPcEtJ5ZV7TXff
 GfdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW76qo8yJNVvwAuM1+twJE1epQxBkYNktiORm1yVVs8cHu7Y3QPysh8OzZFK5hF/qr1H2pOYUA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8wgfftcd+ewQZsaqCySaCjbQDsSu386ey0/JVKMJ3tklBbrCI
 JCsONwYQzYGlXIFqpGcoYauwzoqv4/oAEVjYwnnCYBLNFEQG8u/PhSdOs1AyxpNI2SbD8Yx0ayi
 9d/4PVGrpHOBNZa+rkEdrR7IsTEtNgpmMmpHoEz/kZPdKf7QLtao=
X-Gm-Gg: ASbGncuxQekmtwFMrrnCBVWZk9jqIxJjUUS/mrH+V1WI9Tj6/1365W4mJ9j5QRNPfXZ
 iWSBDZyFObvUZsv7Yc4o7bBLOP5mY4xOInjdZ
X-Google-Smtp-Source: AGHT+IHgsBaSQ7QzYQXdX9fwfHoaYsM3piu5WjHzUSwumWA+fK9e9mb/i42oTldudWpWqcO2FGCmLKjmbo8vuDsqGo4=
X-Received: by 2002:a17:90b:3c81:b0:2ee:c9b6:4c42 with SMTP id
 98e67ed59e1d1-2f548f39801mr18422054a91.16.1736524259453; Fri, 10 Jan 2025
 07:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20250102161313.GP3476@bill-the-cat> <Z36DdfO_EH454Xdw@hera>
In-Reply-To: <Z36DdfO_EH454Xdw@hera>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 10 Jan 2025 16:50:47 +0100
X-Gm-Features: AbW1kvYx3RzsiMazohfqtPNj2zHxZv_tfJPP5l-3d2JBDAVHF1515zXswUvo1FU
Message-ID: <CAOf5uwnODo9ZpBMDBi6LGG3Fx-cggiryDZ_mrrTEV+S9mx7s8g@mail.gmail.com>
Subject: Re: Simon Glass's future with Das U-Boot project?
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot-Denx <u-boot@lists.denx.de>, 
 Simon Glass <sjg@chromium.org>
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

Hi

On Wed, Jan 8, 2025 at 2:54=E2=80=AFPM Ilias Apalodimas <ilias.apalodimas@l=
inaro.org>
wrote:
>
> Hi Tom,
>
> On Thu, Jan 02, 2025 at 10:13:13AM -0600, Tom Rini wrote:
> > Hey all,
> >
> > While I had hoped that the quiet of the last week or so had meant that
> > things would perhaps return to how they had been before, Simon's large
> > patch series and then comments on the TPM+bloblist patch have shown
> > otherwise.
> >
> > At this point, I do not know how best to handle Simon's behavior,
> > without soliciting feedback in public first. At best he's created a
> > soft-fork of the project with his "sjg/master" branch. I've asked him
> > repeatedly to explain how he thinks this is all going to work out, in
> > public. I've had private conversations with him, but I want him to
>

I have some private fork of the project and have some project that
implements
some features that are still not in the mainline. I think that forking
u-boot in general
is not a good idea. Will be nice to have more developers and maintainers
workshop
where we can discuss problems and direction of the project. Let's say some
place where
we can reach each other and talk to each other. I found out that sometimes
discussion on video calls
moves things a bit faster.

> Everyone is entitled to create a fork. But as noted in another mail, he
> can't use the public mailing lists asking feedback for his forked patches=
,
> nor can he use the public infra (incl patchwork) to test and maintain his
> changes.
>
> > explain in public. Or, he can post the messages if he likes.
> >
> > And I am in the process of getting outside help that would in turn be
> > able to help the project move beyond the BDFL model we've always used.
> > Because at the end of the day, if most of the active developers would
> > prefer the direction Simon wants to take everything in, that's somethin=
g
> > I can accept.
>

Will be nice to know the exact thread or discussion

> +1 here. As long as patches get reviewed properly we should follow what
the
> majority thinks is the proper technical direction.
>
> > But what's going on now is towards the worst end of
> > possible outcomes I think for the project itself. And by that I mean,
> > one prominent contributor steam-rolling over others and doing as the
> > please and implicitly acting as an authoritative voice for the project.
>
> I personally don't want to pay attention to out of tree patches.
> Simon randomly responds to emails 'applied to sjg1/master' or something
> along those lines, which further complicates things as people might think
> their code got merged.
>

Me too. I don't have that time and for the moment how the project is
progressive is fine.

Michael

> I think we should wait a few more days and give Simon a chance to respond
> and perhaps explain what drove him to create his fork.
>
> Regards
> /Ilias
> >
> > --
> > Tom
>
>


--
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
