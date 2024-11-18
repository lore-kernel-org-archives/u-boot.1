Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B47D591AA
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 17:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BEB889493;
	Mon, 18 Nov 2024 18:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q2z6hipO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 473FB89496; Mon, 18 Nov 2024 18:20:35 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 251F989373
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 18:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7f43259d220so1482695a12.3
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 09:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731950430; x=1732555230; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OF8BbIWV++9NEfVvIoKGytV85se66eGEoNJEl3Zk9fc=;
 b=Q2z6hipOLqCdkIaXJDKV0n2rSuMEHdRlrYJ4eVgbwkVs2It4CvhepKK8/u5U20MjgZ
 V92yCU36+ppUQWHrrpGed+72mryetwmyw6iuldFCJXIlr8kIS1McGYdYS45Cl0FlVRBm
 tfwphxWiW29NzNIizit9pyZE9jqZOXL60Mk/NHY7x8nUQRN2fNOE/TximXq0AHLHQhlH
 nSVkJTCJVol6euPGyEW1LNIs1Nt5KIpfyLGXIFUkMMLZtGiBHp4weXOvgdVHUh+9rqR2
 ZfNByKsNIrW0H8Ggr1IRS88n7gAe3+lXQb7OWjEC1oc8zeivtCoLBXr2gFlxMTy6nemu
 lCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731950430; x=1732555230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OF8BbIWV++9NEfVvIoKGytV85se66eGEoNJEl3Zk9fc=;
 b=uDkdPgfrsC8HBKFDpYzu3NW0lfQ/X4SwAtGrSqLr4LT1OC2fnEnJwUKM5ZrnAiacrY
 yqmZBMF3sgKixQru6IHrlWnRmUrdDufer785/fzHn5FiOYDClKjs+AOy5EQ6wGe1ciN1
 VedlbZIjV0Y6nyZT2UVIP5QxL4qQ/i0/YxlJ5Pe1iC+k9nYIstxoePAv6CDvcySQBaSI
 6tZbhL8q/Y3jsX21ZL1n9z+cOBcMrQsz621u5cyV6rV9EgKZx/JA6NMP2qjp7P42XPs8
 mRHKsjBJggYspnk4+BoI1XPi9C72uwEIZDXYegZc56bEnqus9tlTDLoE29JaksjrOqDa
 Dphg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkqysXKABibX85BHqvnkiaqpwAv6I7pcHZhn7FS62BU70WbnvdS5+FNpkWmSNCMi/mC4QdZj4=@lists.denx.de
X-Gm-Message-State: AOJu0YzBkchDQUVMRHuK/CnP/XeuOM7gEc5g0QeBsHlIk2EGdHt+/vPh
 mMTqnqzKa1cgz9V1XFN9s1L7pZzOcQND9md57xE1KJf08PyPwuLgUAyuzIr/Hsln1iJhDTTvcLS
 vFIuuGDZZzf5UUQX/r5q5UOgm3w8YjNo2dC/Irg==
X-Google-Smtp-Source: AGHT+IGUsmn21Gz55tGM3x2CqZR+ve395K/S2QDBK7Ns1L6k7PuBPgPMklimHU/PKU93zoNGcj7Jgkz4t+Bmcb7V1wU=
X-Received: by 2002:a17:90b:1650:b0:2ea:838c:7f1c with SMTP id
 98e67ed59e1d1-2ea838c7fa8mr3685614a91.29.1731950430632; Mon, 18 Nov 2024
 09:20:30 -0800 (PST)
MIME-Version: 1.0
References: <CAJaLiFy2oo2fp-08qJni8srUn6RErgGgZs_A3GGPJuD0+=YsOw@mail.gmail.com>
 <CAEfUkUJOd03fc5VERRPY18LWMomEbYFRnkHSJcFLcdnPq4=8jA@mail.gmail.com>
 <CAJaLiFw134mzZk7TkJMgAppx11Xv3qZsbU-Y78XimX8jNbJtMA@mail.gmail.com>
 <CAEfUkUKp9wWhgBW2XFubhoccSGeU-CW3Y+FY+iJhfw7eVLZv_g@mail.gmail.com>
 <CAJaLiFzTjHWCw+ioPZv660yQ0XLM6+SMJh3NV=NYivbtE1Uf_Q@mail.gmail.com>
 <CAEfUkULhPuH15fDENXubhNPOQvbAjBv5f_yoeH7gjC4rhczxtA@mail.gmail.com>
 <20241118153742.GO3600562@bill-the-cat>
 <CAEfUkUJNOTCsh19VbKsHw9wWO1nn8o-OhRrAB46uhpKHO-Owsw@mail.gmail.com>
 <20241118164122.GQ3600562@bill-the-cat>
 <CAEfUkUJmSL8-XR6LUAKX=xW-mYQWNHzanRKvAVFaB2A9nA4W1A@mail.gmail.com>
 <20241118171811.GR3600562@bill-the-cat>
In-Reply-To: <20241118171811.GR3600562@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 18 Nov 2024 12:20:19 -0500
Message-ID: <CAEfUkUJPngVhDTbui-UUhPyMW=kiMgVPtxyfHG1LmDsdd9bfOw@mail.gmail.com>
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

On Mon, 18 Nov 2024 at 12:18, Tom Rini <trini@konsulko.com> wrote:

> On Mon, Nov 18, 2024 at 12:16:18PM -0500, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Mon, 18 Nov 2024 at 11:41, Tom Rini <trini@konsulko.com> wrote:
> >
> > > On Mon, Nov 18, 2024 at 11:27:06AM -0500, Raymond Mao wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 18 Nov 2024 at 10:37, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > > On Mon, Nov 18, 2024 at 10:24:32AM -0500, Raymond Mao wrote:
> > > > > > Hi Tony,
> > > > > >
> > > > > > On Sat, 16 Nov 2024 at 02:39, Tony Dinh <mibodhi@gmail.com>
> wrote:
> > > > > >
> > > > > > > Hi Raymond,
> > > > > > >
> > > > > > > On Fri, Nov 15, 2024 at 1:55=E2=80=AFPM Raymond Mao <
> > > raymond.mao@linaro.org>
> > > > > > > wrote:
> > > > > > > >
> > > > > > > > Hi Tony and Tom,
> > > > > > > >
> > > > > > > > On Fri, 15 Nov 2024 at 16:35, Tony Dinh <mibodhi@gmail.com>
> > > wrote:
> > > > > > > >>
> > > > > > > >> Hi Tom,
> > > > > > > >> Hi Raymond,
> > > > > > > >>
> > > > > > > >> On Fri, Nov 15, 2024 at 1:09=E2=80=AFPM Raymond Mao <
> > > raymond.mao@linaro.org
> > > > > >
> > > > > > > wrote:
> > > > > > > >> >
> > > > > > > >> > Hi Tony
> > > > > > > >> >
> > > > > > > >> > On Fri, 15 Nov 2024 at 15:32, Tony Dinh <
> mibodhi@gmail.com>
> > > > > wrote:
> > > > > > > >> >>
> > > > > > > >> >> Hi Tom,
> > > > > > > >> >>
> > > > > > > >> >> On Fri, Nov 15, 2024 at 11:27=E2=80=AFAM Tony Dinh <
> > > mibodhi@gmail.com>
> > > > > > > wrote:
> > > > > > > >> >> >
> > > > > > > >> >> > Hi Tom,
> > > > > > > >> >> >
> > > > > > > >> >> > On Fri, Nov 15, 2024 at 6:17=E2=80=AFAM Tom Rini <
> > > trini@konsulko.com>
> > > > > > > wrote:
> > > > > > > >> >> > >
> > > > > > > >> >> > > On Thu, Nov 14, 2024 at 08:26:33PM -0800, Tony Dinh
> > > wrote:
> > > > > > > >> >> > > > Hi Tom,
> > > > > > > >> >> > > >
> > > > > > > >> >> > > > I am on 2025.01-rc2, and I am trying to commit so=
me
> > > files.
> > > > > The
> > > > > > > error
> > > > > > > >> >> > > > seems to indicate this framework directory might
> need
> > > some
> > > > > > > >> >> > > > modification. Did I miss something?
> > > > > > > >> >> > > >
> > > > > > > >> >> > > > error: 'lib/mbedtls/external/mbedtls/framework'
> does
> > > not
> > > > > have
> > > > > > > a commit
> > > > > > > >> >> > > > checked out
> > > > > > > >> >> > > > fatal: updating files failed
> > > > > > > >> >> > >
> > > > > > > >> >> > > That's odd. You didn't happen to try out some of th=
e
> > > previous
> > > > > > > lwIP
> > > > > > > >> >> > > iterations on that tree did you?
> > > > > > > >> >> >
> > > > > > > >> >> > No, I did not. The tree is clean with "make mrproper"
> and
> > > on
> > > > > the
> > > > > > > >> >> > master branch. I just did a git pull and worked on it=
.
> > > > > > > >> >> >
> > > > > > > >> >> > I went and looked at
> > > https://github.com/Mbed-TLS/mbedtls.git.
> > > > > The
> > > > > > > >> >> > framework directory is pointing to a specific commit.
> > > > > > > >> >> > framework @ 3867faa
> > > > > > > >> >> >
> > > > > > > >> >> > I'll stash and repeat it on another clean tree.
> > > > > > > >> >>
> > > > > > > >> >> I have the same commit error on a brand new tree.
> > > > > > > >> >>
> > > > > > > >> > I think you are talking about the test framework of
> MbedTLS's
> > > > > > > original testsuite,
> > > > > > > >> > am I right?
> > > > > > > >> > MbedTLS was ported into U-Boot as a git subtree and that
> > > > > framework is
> > > > > > > a git
> > > > > > > >> > submodule of original MbedTLS repo which was not include=
d
> in
> > > the
> > > > > > > porting
> > > > > > > >> > of U-Boot since U-Boot has its own testsuite.
> > > > > > > >>
> > > > > > > >> Here is what I found.
> > > > > > > >>
> > > > > > > >> git clone https://github.com/u-boot/u-boot.git
> > > u-boot-master-test
> > > > > > > >> cd /usr/src/u-boot-master-test/
> > > > > > > >> patch -p1 <
> > > > > ../builds-u-boot-marvell/sheevaplug/sheevaplug_bootstd.patch
> > > > > > > >> git add .
> > > > > > > >> git commit . -m "arm: kirkwood: Enable bootstd and remove
> jffs2
> > > for
> > > > > > > >> Sheevaplug board" -e
> > > > > > > >>
> > > > > > > >> The git commit above gave out this error:
> > > > > > > >>
> > > > > > > >> error: 'lib/mbedtls/external/mbedtls/framework' does not
> have a
> > > > > commit
> > > > > > > >> checked out
> > > > > > > >> fatal: updating files failed
> > > > > > > >>
> > > > > > > >> So I tried to commit only the specific files, and it works
> OK.
> > > > > > > >>
> > > > > > > >> git commit configs/sheevaplug_defconfig
> > > include/configs/sheevaplug.h
> > > > > > > >> -m "arm: kirkwood: Enable bootstd and remove jffs2 for
> > > Sheevaplug
> > > > > > > >> board" -e
> > > > > > > >> [master 47de8cff2d] arm: kirkwood: Enable bootstd and remo=
ve
> > > jffs2
> > > > > for
> > > > > > > >> Sheevaplug board
> > > > > > > >>  2 files changed, 17 insertions(+), 19 deletions(-)
> > > > > > > >>
> > > > > > > >> I think it must be what Raymond said above. So perhaps
> during
> > > Tom's
> > > > > PR
> > > > > > > >> pull, the framework directory was created. But "git commit
> ."
> > > does
> > > > > not
> > > > > > > >> like the empty lib/mbedtls/external/mbedtls/framework
> directory.
> > > > > > > >>
> > > > > > > > Under the native MbedTLS git repo, by default it has a
> > > "framework"
> > > > > > > pointing to
> > > > > > > > its git submodule.
> > > > > > > > Maybe we should mark it in the gitignore.
> > > > > > >
> > > > > > > I've tried .gitignore but could not make it work (my Gitfu is
> > > pretty
> > > > > > > lousy). Can you suggest how that should be done?
> > > > > > >
> > > > > > > You can use the command without the '.' : git commit -m
> > > "<commit_msg>",
> > > > > > this
> > > > > > should work.
> > > > > >
> > > > > > @Tom Rini <trini@konsulko.com> Shall we remove both
> > > > > > "lib/mbedtls/external/mbedtls/.gitmodules" and
> > > > > > "lib/mbedtls/external/mbedtls/framework"? I can submit a patch
> if you
> > > > > agree.
> > > > >
> > > > > Can we do that and not make a problem for the next resync?
> > > > >
> > > > > Hmmm, no, this cannot be pulled back to the MbedTLS upstream so
> still a
> > > > problem
> > > > when resync.
> > > > Another option is to include that git submodule into the U-Boot
> project,
> > > > this needs
> > > > to revert the commit of introducing the library and redo the git
> subtree
> > > > after the
> > > > submodule is updated, but it does not seem to be a good choice as w=
e
> > > don't
> > > > use
> > > > that test framework in U-Boot at all.
> > > > Right now I don't have a perfect solution, maybe we can accept usin=
g
> git
> > > > commit
> > > > without the '.'?
> > >
> > > Hmm. Maybe we just delete the .gitmodules / directory and it shouldn'=
t
> > > be too hard to deal with on updates. I have to do some small fixups
> with
> > > the device tree ones anyhow sometimes.
> > >
> > > How about checking and deleting this in the subtree update script?
> > Then we can skip manually doing this each time.
> > I can make a patch for it if you feel fine.
>
> Lets worry about that if it's a problem when we resync next.
>
> Sure thing.

Raymond
