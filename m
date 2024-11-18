Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33306D49234
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 15:24:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A587D890F8;
	Mon, 18 Nov 2024 16:24:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q8fG+CN+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 333E789100; Mon, 18 Nov 2024 16:24:50 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60E18890DA
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 16:24:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20c6f492d2dso21237845ad.0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 07:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731943486; x=1732548286; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5zO1ScBTYgRlKTsha8b9rrt4tQNs4hLkhDjk0qNW+Ko=;
 b=Q8fG+CN+AVIhu7aO1n8wkkPEwdNDg14AuA/kKsov4c1LNmENsOcSXF30msyoeGH3AA
 KPwwK8e+pYwCX1xOLwApTxWjWAJ+Fr5No7CYVOoHBfi2SwZWdHsPKBF0yE4V+Kwi96tO
 vyJBckZ7UGJQUm+cbTWask4ISbZA2TOYyA03MRN/C2c/Yb3eSe+aceoBt02zuiJScSsB
 enizoeXUxGFeVwwlxcCcaO83I92xhxW4x5OJY5VdM2t/Hklmt82ghyqxCLJXjys4qcn8
 SWgzLNpIxM5p3gD1M4epn1u7bB+sWAB5fmpFjDFbP9kfzbQjPwehdLXWF2vISBPE6Ft5
 VFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731943486; x=1732548286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5zO1ScBTYgRlKTsha8b9rrt4tQNs4hLkhDjk0qNW+Ko=;
 b=p8ptBrYOBn6h44L9mrAUtd4Wr335D6NODFQA1g413lxI7uHeEXtqBRphRYA4JluWuh
 966gcYZ38jbCguK4WKLswsHRySW7xVhr2lC8ar4HEXR2cmzYWGgRYK/3opcaXgcWCKP+
 SQFyNutclFSbW/oQ042bJwTklC/C0m6g4tAqdkgGd3gnOb/kNG6l0kqsqfO76+gkxkZv
 hu+ZQYNGp9KT+1x1vBDAXj1ElhCkuY/aciJg40UjCT2/tspTK14YNiVxrDEib9g5/jh8
 W2jEuVjEBj2n7FlS6e6OgOohNDJ0mcV3rq+bTli83aATwPaoBAdBnlDf/aeWXdGiFrHj
 KHZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWSr1L9KQb4jyYnl6Wbm4cgy7TzWkUqp3Jwp6I1TcIx2kdwLUIf9r11NY2iaYvBRwlNOjfn10=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/oEcn2FTg0bQyslOhWdf7lUa9dzgShSqJ+hixQX/uo0K3aFOb
 PgU32j1YeY6yFyk/m7Igv8v+HRUTDgZffkzU7/kZuYmj0TH9GXip5yRDlVTO174Ewjo6uNMC5XF
 eEEmhuOg4sLGZaBgroCjKwnSD7xyvnTNCEoyZUw==
X-Google-Smtp-Source: AGHT+IGRtiDuH/CU8AVsnGDDyHUYBjru45yfJVnESeH9adphGHheDT4g9C4Sqn/vd6At4KyfubMBCnA7p2Lw8fWbpPU=
X-Received: by 2002:a17:902:e891:b0:20c:7796:5e47 with SMTP id
 d9443c01a7336-211d0d6f702mr175034885ad.4.1731943485766; Mon, 18 Nov 2024
 07:24:45 -0800 (PST)
MIME-Version: 1.0
References: <CAJaLiFwvFVOKYpAQLSNUqAfVHCsPcxo6g74JGunw8HSQTMCFLA@mail.gmail.com>
 <20241115141748.GS3600562@bill-the-cat>
 <CAJaLiFx35Q8L-kR02GrA1PTd2nY699KMc2fy5fT381Khg5hgxg@mail.gmail.com>
 <CAJaLiFy2oo2fp-08qJni8srUn6RErgGgZs_A3GGPJuD0+=YsOw@mail.gmail.com>
 <CAEfUkUJOd03fc5VERRPY18LWMomEbYFRnkHSJcFLcdnPq4=8jA@mail.gmail.com>
 <CAJaLiFw134mzZk7TkJMgAppx11Xv3qZsbU-Y78XimX8jNbJtMA@mail.gmail.com>
 <CAEfUkUKp9wWhgBW2XFubhoccSGeU-CW3Y+FY+iJhfw7eVLZv_g@mail.gmail.com>
 <CAJaLiFzTjHWCw+ioPZv660yQ0XLM6+SMJh3NV=NYivbtE1Uf_Q@mail.gmail.com>
In-Reply-To: <CAJaLiFzTjHWCw+ioPZv660yQ0XLM6+SMJh3NV=NYivbtE1Uf_Q@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 18 Nov 2024 10:24:32 -0500
Message-ID: <CAEfUkULhPuH15fDENXubhNPOQvbAjBv5f_yoeH7gjC4rhczxtA@mail.gmail.com>
Subject: Re: Git commit failed with mbedtls/framework
To: Tony Dinh <mibodhi@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tony,

On Sat, 16 Nov 2024 at 02:39, Tony Dinh <mibodhi@gmail.com> wrote:

> Hi Raymond,
>
> On Fri, Nov 15, 2024 at 1:55=E2=80=AFPM Raymond Mao <raymond.mao@linaro.o=
rg>
> wrote:
> >
> > Hi Tony and Tom,
> >
> > On Fri, 15 Nov 2024 at 16:35, Tony Dinh <mibodhi@gmail.com> wrote:
> >>
> >> Hi Tom,
> >> Hi Raymond,
> >>
> >> On Fri, Nov 15, 2024 at 1:09=E2=80=AFPM Raymond Mao <raymond.mao@linar=
o.org>
> wrote:
> >> >
> >> > Hi Tony
> >> >
> >> > On Fri, 15 Nov 2024 at 15:32, Tony Dinh <mibodhi@gmail.com> wrote:
> >> >>
> >> >> Hi Tom,
> >> >>
> >> >> On Fri, Nov 15, 2024 at 11:27=E2=80=AFAM Tony Dinh <mibodhi@gmail.c=
om>
> wrote:
> >> >> >
> >> >> > Hi Tom,
> >> >> >
> >> >> > On Fri, Nov 15, 2024 at 6:17=E2=80=AFAM Tom Rini <trini@konsulko.=
com>
> wrote:
> >> >> > >
> >> >> > > On Thu, Nov 14, 2024 at 08:26:33PM -0800, Tony Dinh wrote:
> >> >> > > > Hi Tom,
> >> >> > > >
> >> >> > > > I am on 2025.01-rc2, and I am trying to commit some files. Th=
e
> error
> >> >> > > > seems to indicate this framework directory might need some
> >> >> > > > modification. Did I miss something?
> >> >> > > >
> >> >> > > > error: 'lib/mbedtls/external/mbedtls/framework' does not have
> a commit
> >> >> > > > checked out
> >> >> > > > fatal: updating files failed
> >> >> > >
> >> >> > > That's odd. You didn't happen to try out some of the previous
> lwIP
> >> >> > > iterations on that tree did you?
> >> >> >
> >> >> > No, I did not. The tree is clean with "make mrproper" and on the
> >> >> > master branch. I just did a git pull and worked on it.
> >> >> >
> >> >> > I went and looked at https://github.com/Mbed-TLS/mbedtls.git. The
> >> >> > framework directory is pointing to a specific commit.
> >> >> > framework @ 3867faa
> >> >> >
> >> >> > I'll stash and repeat it on another clean tree.
> >> >>
> >> >> I have the same commit error on a brand new tree.
> >> >>
> >> > I think you are talking about the test framework of MbedTLS's
> original testsuite,
> >> > am I right?
> >> > MbedTLS was ported into U-Boot as a git subtree and that framework i=
s
> a git
> >> > submodule of original MbedTLS repo which was not included in the
> porting
> >> > of U-Boot since U-Boot has its own testsuite.
> >>
> >> Here is what I found.
> >>
> >> git clone https://github.com/u-boot/u-boot.git u-boot-master-test
> >> cd /usr/src/u-boot-master-test/
> >> patch -p1 < ../builds-u-boot-marvell/sheevaplug/sheevaplug_bootstd.pat=
ch
> >> git add .
> >> git commit . -m "arm: kirkwood: Enable bootstd and remove jffs2 for
> >> Sheevaplug board" -e
> >>
> >> The git commit above gave out this error:
> >>
> >> error: 'lib/mbedtls/external/mbedtls/framework' does not have a commit
> >> checked out
> >> fatal: updating files failed
> >>
> >> So I tried to commit only the specific files, and it works OK.
> >>
> >> git commit configs/sheevaplug_defconfig include/configs/sheevaplug.h
> >> -m "arm: kirkwood: Enable bootstd and remove jffs2 for Sheevaplug
> >> board" -e
> >> [master 47de8cff2d] arm: kirkwood: Enable bootstd and remove jffs2 for
> >> Sheevaplug board
> >>  2 files changed, 17 insertions(+), 19 deletions(-)
> >>
> >> I think it must be what Raymond said above. So perhaps during Tom's PR
> >> pull, the framework directory was created. But "git commit ." does not
> >> like the empty lib/mbedtls/external/mbedtls/framework directory.
> >>
> > Under the native MbedTLS git repo, by default it has a "framework"
> pointing to
> > its git submodule.
> > Maybe we should mark it in the gitignore.
>
> I've tried .gitignore but could not make it work (my Gitfu is pretty
> lousy). Can you suggest how that should be done?
>
> You can use the command without the '.' : git commit -m "<commit_msg>",
this
should work.

@Tom Rini <trini@konsulko.com> Shall we remove both
"lib/mbedtls/external/mbedtls/.gitmodules" and
"lib/mbedtls/external/mbedtls/framework"? I can submit a patch if you agree=
.

Regards,
Raymond
