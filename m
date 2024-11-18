Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D5ED591A8
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 17:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26093893A2;
	Mon, 18 Nov 2024 18:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KPamY8aC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A98278948E; Mon, 18 Nov 2024 18:16:34 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B99C089373
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 18:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ea8b039ddcso676855a91.0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 09:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731950190; x=1732554990; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KS5rKhTROkv+2ZTOdW3LO7RGLAqcMHxyUKRcIo2595Y=;
 b=KPamY8aCAO5m54SGqxiUKqWlZuiD6vaxoEmcaDYP7AP9NyZsdnrvow51IfXJczwF3f
 OUitvV3iBPkiM+rO7goBWCFQIBhtWLk9SGfMGAdSjbKdOM0VS+K975tCN1xWhtVg43ds
 e3nvBPR4sed2leGqqdk7L9I4lb1OWpkiEMqIPgzB8JV5lb556sJE6EMtSQEMGeQqmY2g
 GLS2PIIVotrPFX1We1kfQlwau3p+qa7dnEcDhZmedW5KhDYmfJqSQTWkMYGlzJysnlUB
 Ulu38a/jHziOoKoPpVIEWuTyYjun+D+OP4k20rU92Pw7tCx8sDBOA5Qn4fzHJOSKNFyF
 JLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731950190; x=1732554990;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KS5rKhTROkv+2ZTOdW3LO7RGLAqcMHxyUKRcIo2595Y=;
 b=AqLe48+VGRUfcK299TU5cdG/xfFtbgN8rdRgxm2Oqr+hgdIqqFdftvujHsoC4sfC7d
 UWeXJnS7G8sWRcerXcjDUw3/jIQ9IIvLXRaT8tQPHJkwIIkWbxlheH+Q9ZP4h56peom3
 JQ5/ZYD3QINDbYjXEFQNQwvr2FSjUfq/OepUTEpPYG+J+5acGmdHAvWPnjtneCHBJx9L
 1rMLYlbDPgvWO6EjHZ0Fk0eAZTZMp9X7Op01H37snji+DvIQWr+yaE4sN1T03/jy577Y
 J3zUQQut8OrMhJopDPxK+oWmkZViCgy024vN9Vn0KcBSbKHoncS72F11nlMONBsHxcUe
 OpDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmI1TJ4xQbwSPt/MDgnQNBW9zDoHFzHSuprvzp6KUABAM+s1mjdAVXmArDV//eTPJjEIrReU0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4ncyldy3IW0LWlFWczZVBmfItyO1Auy4CbcGMekSOICBG93wa
 06nsqr6+yOus1+fIHtJ+KniKDnlf0Gn7mUHBeIr9XEYxZ4v7qcbvgALFs8pB4geOESJPhl2aNmF
 PEcLWRmoY0XR29P+gek7Irl3bNts2z6qltPd/QA==
X-Google-Smtp-Source: AGHT+IEZpR81EHWwXJxM0+HzuMIPFWrAzhizc2ROoxUjH4x/YydWxdAR/j5y7R838WVoXxRAA2r+imU7+osqrGPWkCo=
X-Received: by 2002:a17:90b:4e8d:b0:2ea:61de:38f7 with SMTP id
 98e67ed59e1d1-2ea61de3bccmr6590912a91.29.1731950189801; Mon, 18 Nov 2024
 09:16:29 -0800 (PST)
MIME-Version: 1.0
References: <20241115141748.GS3600562@bill-the-cat>
 <CAJaLiFx35Q8L-kR02GrA1PTd2nY699KMc2fy5fT381Khg5hgxg@mail.gmail.com>
 <CAJaLiFy2oo2fp-08qJni8srUn6RErgGgZs_A3GGPJuD0+=YsOw@mail.gmail.com>
 <CAEfUkUJOd03fc5VERRPY18LWMomEbYFRnkHSJcFLcdnPq4=8jA@mail.gmail.com>
 <CAJaLiFw134mzZk7TkJMgAppx11Xv3qZsbU-Y78XimX8jNbJtMA@mail.gmail.com>
 <CAEfUkUKp9wWhgBW2XFubhoccSGeU-CW3Y+FY+iJhfw7eVLZv_g@mail.gmail.com>
 <CAJaLiFzTjHWCw+ioPZv660yQ0XLM6+SMJh3NV=NYivbtE1Uf_Q@mail.gmail.com>
 <CAEfUkULhPuH15fDENXubhNPOQvbAjBv5f_yoeH7gjC4rhczxtA@mail.gmail.com>
 <20241118153742.GO3600562@bill-the-cat>
 <CAEfUkUJNOTCsh19VbKsHw9wWO1nn8o-OhRrAB46uhpKHO-Owsw@mail.gmail.com>
 <20241118164122.GQ3600562@bill-the-cat>
In-Reply-To: <20241118164122.GQ3600562@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 18 Nov 2024 12:16:18 -0500
Message-ID: <CAEfUkUJmSL8-XR6LUAKX=xW-mYQWNHzanRKvAVFaB2A9nA4W1A@mail.gmail.com>
Subject: Re: Git commit failed with mbedtls/framework
To: Tom Rini <trini@konsulko.com>
Cc: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Mon, 18 Nov 2024 at 11:41, Tom Rini <trini@konsulko.com> wrote:

> On Mon, Nov 18, 2024 at 11:27:06AM -0500, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Mon, 18 Nov 2024 at 10:37, Tom Rini <trini@konsulko.com> wrote:
> >
> > > On Mon, Nov 18, 2024 at 10:24:32AM -0500, Raymond Mao wrote:
> > > > Hi Tony,
> > > >
> > > > On Sat, 16 Nov 2024 at 02:39, Tony Dinh <mibodhi@gmail.com> wrote:
> > > >
> > > > > Hi Raymond,
> > > > >
> > > > > On Fri, Nov 15, 2024 at 1:55=E2=80=AFPM Raymond Mao <
> raymond.mao@linaro.org>
> > > > > wrote:
> > > > > >
> > > > > > Hi Tony and Tom,
> > > > > >
> > > > > > On Fri, 15 Nov 2024 at 16:35, Tony Dinh <mibodhi@gmail.com>
> wrote:
> > > > > >>
> > > > > >> Hi Tom,
> > > > > >> Hi Raymond,
> > > > > >>
> > > > > >> On Fri, Nov 15, 2024 at 1:09=E2=80=AFPM Raymond Mao <
> raymond.mao@linaro.org
> > > >
> > > > > wrote:
> > > > > >> >
> > > > > >> > Hi Tony
> > > > > >> >
> > > > > >> > On Fri, 15 Nov 2024 at 15:32, Tony Dinh <mibodhi@gmail.com>
> > > wrote:
> > > > > >> >>
> > > > > >> >> Hi Tom,
> > > > > >> >>
> > > > > >> >> On Fri, Nov 15, 2024 at 11:27=E2=80=AFAM Tony Dinh <
> mibodhi@gmail.com>
> > > > > wrote:
> > > > > >> >> >
> > > > > >> >> > Hi Tom,
> > > > > >> >> >
> > > > > >> >> > On Fri, Nov 15, 2024 at 6:17=E2=80=AFAM Tom Rini <
> trini@konsulko.com>
> > > > > wrote:
> > > > > >> >> > >
> > > > > >> >> > > On Thu, Nov 14, 2024 at 08:26:33PM -0800, Tony Dinh
> wrote:
> > > > > >> >> > > > Hi Tom,
> > > > > >> >> > > >
> > > > > >> >> > > > I am on 2025.01-rc2, and I am trying to commit some
> files.
> > > The
> > > > > error
> > > > > >> >> > > > seems to indicate this framework directory might need
> some
> > > > > >> >> > > > modification. Did I miss something?
> > > > > >> >> > > >
> > > > > >> >> > > > error: 'lib/mbedtls/external/mbedtls/framework' does
> not
> > > have
> > > > > a commit
> > > > > >> >> > > > checked out
> > > > > >> >> > > > fatal: updating files failed
> > > > > >> >> > >
> > > > > >> >> > > That's odd. You didn't happen to try out some of the
> previous
> > > > > lwIP
> > > > > >> >> > > iterations on that tree did you?
> > > > > >> >> >
> > > > > >> >> > No, I did not. The tree is clean with "make mrproper" and
> on
> > > the
> > > > > >> >> > master branch. I just did a git pull and worked on it.
> > > > > >> >> >
> > > > > >> >> > I went and looked at
> https://github.com/Mbed-TLS/mbedtls.git.
> > > The
> > > > > >> >> > framework directory is pointing to a specific commit.
> > > > > >> >> > framework @ 3867faa
> > > > > >> >> >
> > > > > >> >> > I'll stash and repeat it on another clean tree.
> > > > > >> >>
> > > > > >> >> I have the same commit error on a brand new tree.
> > > > > >> >>
> > > > > >> > I think you are talking about the test framework of MbedTLS'=
s
> > > > > original testsuite,
> > > > > >> > am I right?
> > > > > >> > MbedTLS was ported into U-Boot as a git subtree and that
> > > framework is
> > > > > a git
> > > > > >> > submodule of original MbedTLS repo which was not included in
> the
> > > > > porting
> > > > > >> > of U-Boot since U-Boot has its own testsuite.
> > > > > >>
> > > > > >> Here is what I found.
> > > > > >>
> > > > > >> git clone https://github.com/u-boot/u-boot.git
> u-boot-master-test
> > > > > >> cd /usr/src/u-boot-master-test/
> > > > > >> patch -p1 <
> > > ../builds-u-boot-marvell/sheevaplug/sheevaplug_bootstd.patch
> > > > > >> git add .
> > > > > >> git commit . -m "arm: kirkwood: Enable bootstd and remove jffs=
2
> for
> > > > > >> Sheevaplug board" -e
> > > > > >>
> > > > > >> The git commit above gave out this error:
> > > > > >>
> > > > > >> error: 'lib/mbedtls/external/mbedtls/framework' does not have =
a
> > > commit
> > > > > >> checked out
> > > > > >> fatal: updating files failed
> > > > > >>
> > > > > >> So I tried to commit only the specific files, and it works OK.
> > > > > >>
> > > > > >> git commit configs/sheevaplug_defconfig
> include/configs/sheevaplug.h
> > > > > >> -m "arm: kirkwood: Enable bootstd and remove jffs2 for
> Sheevaplug
> > > > > >> board" -e
> > > > > >> [master 47de8cff2d] arm: kirkwood: Enable bootstd and remove
> jffs2
> > > for
> > > > > >> Sheevaplug board
> > > > > >>  2 files changed, 17 insertions(+), 19 deletions(-)
> > > > > >>
> > > > > >> I think it must be what Raymond said above. So perhaps during
> Tom's
> > > PR
> > > > > >> pull, the framework directory was created. But "git commit ."
> does
> > > not
> > > > > >> like the empty lib/mbedtls/external/mbedtls/framework director=
y.
> > > > > >>
> > > > > > Under the native MbedTLS git repo, by default it has a
> "framework"
> > > > > pointing to
> > > > > > its git submodule.
> > > > > > Maybe we should mark it in the gitignore.
> > > > >
> > > > > I've tried .gitignore but could not make it work (my Gitfu is
> pretty
> > > > > lousy). Can you suggest how that should be done?
> > > > >
> > > > > You can use the command without the '.' : git commit -m
> "<commit_msg>",
> > > > this
> > > > should work.
> > > >
> > > > @Tom Rini <trini@konsulko.com> Shall we remove both
> > > > "lib/mbedtls/external/mbedtls/.gitmodules" and
> > > > "lib/mbedtls/external/mbedtls/framework"? I can submit a patch if y=
ou
> > > agree.
> > >
> > > Can we do that and not make a problem for the next resync?
> > >
> > > Hmmm, no, this cannot be pulled back to the MbedTLS upstream so still=
 a
> > problem
> > when resync.
> > Another option is to include that git submodule into the U-Boot project=
,
> > this needs
> > to revert the commit of introducing the library and redo the git subtre=
e
> > after the
> > submodule is updated, but it does not seem to be a good choice as we
> don't
> > use
> > that test framework in U-Boot at all.
> > Right now I don't have a perfect solution, maybe we can accept using gi=
t
> > commit
> > without the '.'?
>
> Hmm. Maybe we just delete the .gitmodules / directory and it shouldn't
> be too hard to deal with on updates. I have to do some small fixups with
> the device tree ones anyhow sometimes.
>
> How about checking and deleting this in the subtree update script?
Then we can skip manually doing this each time.
I can make a patch for it if you feel fine.

Regards,
Raymond
