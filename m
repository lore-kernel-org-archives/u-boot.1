Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEB7C30653
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 12:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67BCE884AC;
	Tue, 25 Jun 2024 14:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jHlkSwks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65E70884B0; Tue, 25 Jun 2024 14:30:22 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDF6788496
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 14:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2c7fa0c9a8cso3743373a91.1
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 05:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719318618; x=1719923418; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bl4t7em8lGlHzBmUqV/Ct4Gepvqn56f1pQJtcj/mgtk=;
 b=jHlkSwkskaYbRd9z+vXfKHYddAd7GSUp2IutQWJu2wGkhzmBMnApIliG/Td9gUOio7
 /onRrpPbU02a4qV9fzFnZnsMXjMVW8z/l1KXjJwWyMYSTqj5fu9DN2otVefV/FuhZnzK
 elgTqtOm8e7Z8Wyx9n4d/EwZS50/Owwtg10t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719318618; x=1719923418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bl4t7em8lGlHzBmUqV/Ct4Gepvqn56f1pQJtcj/mgtk=;
 b=nAybewTWqXMJClr6PZ9x7h+Y9gzORSPEtBDpNMdnrmp8EX1HDflCdEp5L4tPGlfDdp
 dcpzKhiXnV/d6r7f53m4abdv8kF98Yrw/ZSskrgKCFmiGxQjSEzCeDUGlXi1bGwL9Ryu
 i12N83YBMCcG9SWbyDhRWF4IaUw8Bg7iHWUvzkaz29OSsoTcgV1hkncFTz/mqAZsynkr
 oLlTabzY476HR0huPZiU+dNvlUmQGPTbNFDG3B/0wrEQWqPkXek9oKbmaBDP2VRleSEY
 xvh7wR74aKL0VD6Px5cmTHlnxjZn4r7woe1H0MALeWpl0HssQ/08yiAtWdJxc61rVn4i
 OsVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUabM9YjKZbPP9j0Lrc8Ne+cwr9iQ+E30RqAf3/mRw9wg/haAVVxeZMdCUfGH6gol4vyWWAWdIRLFg9E7N3BmyyqUs1xw==
X-Gm-Message-State: AOJu0YzvCRblHa0A5cHCFeJcQUdq4GPoCYFWGbX4IY/PE7jCD9dTTwKk
 PM5Oy0mVwq12qTlROFdGJhYqt4qKtEeSVa9tdNWCrBNwV+M4gCAlW2aOVQiF3E6ZEGMij79JoyW
 GPhsgq+PrFNBFXpqajZnqhmmi1lrhntGJFTDlEJpW4x4rJhzZBvxp
X-Google-Smtp-Source: AGHT+IEOT/TBVT8KItJ6ybI0/jsmtENDMKM4t0fb5uUJ7HDyJE0nCS8ljYZWqijqvHlThM2S5N7iREo/zD2vQNH5paM=
X-Received: by 2002:a17:90b:440b:b0:2c2:fed1:769f with SMTP id
 98e67ed59e1d1-2c8581d0636mr5803250a91.13.1719318618005; Tue, 25 Jun 2024
 05:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-20-sjg@chromium.org>
 <ZnkchlJmYdVCkQV+@toradex.com>
 <CAOf5uwkQDzOpj-XUojvfWD6tU2cOxZkv4OEvOK7eZJZcRHTjfg@mail.gmail.com>
 <20240624180149.GF38804@bill-the-cat>
In-Reply-To: <20240624180149.GF38804@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Jun 2024 13:30:05 +0100
Message-ID: <CAFLszThdms5TT_o0CjQOp+6pqXF9nMUJKq5rvz0Y=EGZa2Tj-g@mail.gmail.com>
Subject: Re: [PATCH v3 19/19] CI: Allow running tests on sjg lab
To: Tom Rini <trini@konsulko.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Hi,

On Mon, 24 Jun 2024 at 19:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jun 24, 2024 at 04:56:02PM +0200, Michael Nazzareno Trimarchi wro=
te:
> > Hi Simon
> >
> > On Mon, Jun 24, 2024 at 2:52=E2=80=AFPM Andrejs Cainikovs
> > <andrejs.cainikovs@toradex.com> wrote:
> > >
> > > On Sun, Jun 23, 2024 at 02:32:13PM -0600, Simon Glass wrote:
> > > > Add a way to run tests on a real hardware lab. This is in the very =
early
> > > > experimental stages. There are only 23 boards and 3 of those are br=
oken!
> > > > (bob, ff3399, samus). A fourth fails due to problems with the TPM t=
ests.
> > > >
> > > > To try this, assuming you have gitlab access, set SJG_LAB=3D1, e.g.=
:
> > > >
> > > >    git push -o ci.variable=3D"SJG_LAB=3D1" dm HEAD:try
> > > >
> > > > This relies on the two previous series targeted at -next as well as=
 the
> > > > bugfix series for -master
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > Reviewed-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> > >
> >
> > Do you have documentation on how to set it? We would like to do in our
> > company too
>
> I _think_ from some talking with Simon before the biggest sticking point
> might be changes needed on the labgrid side of things. However, that
> might also be most easily remedied if there's a few people showing up in
> the GitHub issue(s) showing interest in getting changes made/merged and
> to use the overall feature.

The documentation is in the PR [1] mostly in the last commit [2].

Yes it would really help for you to try it out and comment on the PR.
I may end up splitting it into a few separate PRs, but code review on
the project is very limited, from what I have seen so far. You will
see an example of my lab (devices and environment file).

I also have a few minor updates to the PR which I just uploaded, to
work on top of the grpc branch and to support QEMU.

[1] https://github.com/labgrid-project/labgrid/pull/1411
[2] https://github.com/labgrid-project/labgrid/pull/1411/commits/c4b13af0e6=
169228c9adef03d4b66401201edd23

Regards,
Simon
