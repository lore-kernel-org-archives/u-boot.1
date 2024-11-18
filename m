Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7592AD68BFA
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 16:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C19488947B;
	Mon, 18 Nov 2024 17:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UWVaPjZI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20A6789482; Mon, 18 Nov 2024 17:27:22 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3589D88FE5
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 17:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ea6f821decso1052849a91.1
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 08:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731947238; x=1732552038; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LKormixjlng9R1y1C0dW0XpN+vTUpiTaO2uX8V8FkrE=;
 b=UWVaPjZIfbLbSXtBgGoD74jJOtSfe2yD9b4KJ7C2gbcxCa8ByxVkl0P6AvVCw6tZKV
 OQ7x77Yo1h70OzDXsjz0YU2WamOBJ2tp5YS6GTrovu5eeA2JksMr4kOUh1EQI3U41HVP
 N1x2Xg9LKhsTeP8Rw44AAz4qnHw+q6BBQIHvPtPBH1d7ZE/4XkHJhqE9esl18Tzvu9jO
 3agGDxHW+urJ8cAPJ0sj/knbebSm6k8YwZfp3mlDDGhI8wnF4IEtjpsBfHUTrHyiQ0n+
 ymqxyYX24+Ld0WqjnNjWwTKw+e7UdLwM/MsIiKpchMWs6+K54eEzDolVTyuMZlpdZJ6A
 +q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731947238; x=1732552038;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LKormixjlng9R1y1C0dW0XpN+vTUpiTaO2uX8V8FkrE=;
 b=bRnaOqA/zF8EV7WRqPNv+ZwYnvROnNoa/1mQds+z0QOe5DNTokv+ZKIrc7lALQgfvP
 BG3ikknaglrOZlbfsFQl+TFGjF1jrZSg1T+D1FsmyQTZCSQXSLbcfefxomLtbt/C0kGz
 OxQr9sQWz0SrxNY2uV/KgJ+UIzgcRoCUenlrWfC2bbcf0t1DWD2t5vEwCx/cnLpF3SEM
 S9qGPkFsqK4v4qfThSqilD5DZMq8wbKl6kSvadlhTP0moy8sJ6G4z72VhYy3JNRdTdAZ
 xWEz+l4Kgz9vZBGFDWu4BlA6vEROyzHrm1aBeF9/HrzdyVTgsI+5+yEmlTjHGRrI2U6n
 px5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1oUPkCO2TTI0nK9n5n67OWDZOcaGdUu929lP1bSYzM7yEoWxR2KfVG5jhZW5nahOLOAVipts=@lists.denx.de
X-Gm-Message-State: AOJu0YzDliA8T1sD45uBKgl+WJczv8wpBynx7p9iLMSwK0TiYRE+tL4V
 4AVxX7c3c4wtnk6GxVHqht2+qp2toLCfMNlZSYfCY9eTmmytrwf6ai3spCjknL24oUfYAFRnhhE
 +RV9prZoB9DvDzvOwHYLqOcQzuRX6Cq7SwRfh/vYmti/Z4+8GO3w=
X-Google-Smtp-Source: AGHT+IHJ6E3b1FrR2K3MCJGXlKAYugDdkn9Jtj/yCrU8oi1rzQqEv+o4sS7fp0mBDEZ+fLxSc0k9iqtkvK4+GuvXTvg=
X-Received: by 2002:a17:90b:2494:b0:2ea:356f:51a6 with SMTP id
 98e67ed59e1d1-2ea356f54a1mr12165183a91.14.1731947237455; Mon, 18 Nov 2024
 08:27:17 -0800 (PST)
MIME-Version: 1.0
References: <CAJaLiFwvFVOKYpAQLSNUqAfVHCsPcxo6g74JGunw8HSQTMCFLA@mail.gmail.com>
 <20241115141748.GS3600562@bill-the-cat>
 <CAJaLiFx35Q8L-kR02GrA1PTd2nY699KMc2fy5fT381Khg5hgxg@mail.gmail.com>
 <CAJaLiFy2oo2fp-08qJni8srUn6RErgGgZs_A3GGPJuD0+=YsOw@mail.gmail.com>
 <CAEfUkUJOd03fc5VERRPY18LWMomEbYFRnkHSJcFLcdnPq4=8jA@mail.gmail.com>
 <CAJaLiFw134mzZk7TkJMgAppx11Xv3qZsbU-Y78XimX8jNbJtMA@mail.gmail.com>
 <CAEfUkUKp9wWhgBW2XFubhoccSGeU-CW3Y+FY+iJhfw7eVLZv_g@mail.gmail.com>
 <CAJaLiFzTjHWCw+ioPZv660yQ0XLM6+SMJh3NV=NYivbtE1Uf_Q@mail.gmail.com>
 <CAEfUkULhPuH15fDENXubhNPOQvbAjBv5f_yoeH7gjC4rhczxtA@mail.gmail.com>
 <20241118153742.GO3600562@bill-the-cat>
In-Reply-To: <20241118153742.GO3600562@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 18 Nov 2024 11:27:06 -0500
Message-ID: <CAEfUkUJNOTCsh19VbKsHw9wWO1nn8o-OhRrAB46uhpKHO-Owsw@mail.gmail.com>
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

On Mon, 18 Nov 2024 at 10:37, Tom Rini <trini@konsulko.com> wrote:

> On Mon, Nov 18, 2024 at 10:24:32AM -0500, Raymond Mao wrote:
> > Hi Tony,
> >
> > On Sat, 16 Nov 2024 at 02:39, Tony Dinh <mibodhi@gmail.com> wrote:
> >
> > > Hi Raymond,
> > >
> > > On Fri, Nov 15, 2024 at 1:55=E2=80=AFPM Raymond Mao <raymond.mao@lina=
ro.org>
> > > wrote:
> > > >
> > > > Hi Tony and Tom,
> > > >
> > > > On Fri, 15 Nov 2024 at 16:35, Tony Dinh <mibodhi@gmail.com> wrote:
> > > >>
> > > >> Hi Tom,
> > > >> Hi Raymond,
> > > >>
> > > >> On Fri, Nov 15, 2024 at 1:09=E2=80=AFPM Raymond Mao <raymond.mao@l=
inaro.org
> >
> > > wrote:
> > > >> >
> > > >> > Hi Tony
> > > >> >
> > > >> > On Fri, 15 Nov 2024 at 15:32, Tony Dinh <mibodhi@gmail.com>
> wrote:
> > > >> >>
> > > >> >> Hi Tom,
> > > >> >>
> > > >> >> On Fri, Nov 15, 2024 at 11:27=E2=80=AFAM Tony Dinh <mibodhi@gma=
il.com>
> > > wrote:
> > > >> >> >
> > > >> >> > Hi Tom,
> > > >> >> >
> > > >> >> > On Fri, Nov 15, 2024 at 6:17=E2=80=AFAM Tom Rini <trini@konsu=
lko.com>
> > > wrote:
> > > >> >> > >
> > > >> >> > > On Thu, Nov 14, 2024 at 08:26:33PM -0800, Tony Dinh wrote:
> > > >> >> > > > Hi Tom,
> > > >> >> > > >
> > > >> >> > > > I am on 2025.01-rc2, and I am trying to commit some files=
.
> The
> > > error
> > > >> >> > > > seems to indicate this framework directory might need som=
e
> > > >> >> > > > modification. Did I miss something?
> > > >> >> > > >
> > > >> >> > > > error: 'lib/mbedtls/external/mbedtls/framework' does not
> have
> > > a commit
> > > >> >> > > > checked out
> > > >> >> > > > fatal: updating files failed
> > > >> >> > >
> > > >> >> > > That's odd. You didn't happen to try out some of the previo=
us
> > > lwIP
> > > >> >> > > iterations on that tree did you?
> > > >> >> >
> > > >> >> > No, I did not. The tree is clean with "make mrproper" and on
> the
> > > >> >> > master branch. I just did a git pull and worked on it.
> > > >> >> >
> > > >> >> > I went and looked at https://github.com/Mbed-TLS/mbedtls.git.
> The
> > > >> >> > framework directory is pointing to a specific commit.
> > > >> >> > framework @ 3867faa
> > > >> >> >
> > > >> >> > I'll stash and repeat it on another clean tree.
> > > >> >>
> > > >> >> I have the same commit error on a brand new tree.
> > > >> >>
> > > >> > I think you are talking about the test framework of MbedTLS's
> > > original testsuite,
> > > >> > am I right?
> > > >> > MbedTLS was ported into U-Boot as a git subtree and that
> framework is
> > > a git
> > > >> > submodule of original MbedTLS repo which was not included in the
> > > porting
> > > >> > of U-Boot since U-Boot has its own testsuite.
> > > >>
> > > >> Here is what I found.
> > > >>
> > > >> git clone https://github.com/u-boot/u-boot.git u-boot-master-test
> > > >> cd /usr/src/u-boot-master-test/
> > > >> patch -p1 <
> ../builds-u-boot-marvell/sheevaplug/sheevaplug_bootstd.patch
> > > >> git add .
> > > >> git commit . -m "arm: kirkwood: Enable bootstd and remove jffs2 fo=
r
> > > >> Sheevaplug board" -e
> > > >>
> > > >> The git commit above gave out this error:
> > > >>
> > > >> error: 'lib/mbedtls/external/mbedtls/framework' does not have a
> commit
> > > >> checked out
> > > >> fatal: updating files failed
> > > >>
> > > >> So I tried to commit only the specific files, and it works OK.
> > > >>
> > > >> git commit configs/sheevaplug_defconfig include/configs/sheevaplug=
.h
> > > >> -m "arm: kirkwood: Enable bootstd and remove jffs2 for Sheevaplug
> > > >> board" -e
> > > >> [master 47de8cff2d] arm: kirkwood: Enable bootstd and remove jffs2
> for
> > > >> Sheevaplug board
> > > >>  2 files changed, 17 insertions(+), 19 deletions(-)
> > > >>
> > > >> I think it must be what Raymond said above. So perhaps during Tom'=
s
> PR
> > > >> pull, the framework directory was created. But "git commit ." does
> not
> > > >> like the empty lib/mbedtls/external/mbedtls/framework directory.
> > > >>
> > > > Under the native MbedTLS git repo, by default it has a "framework"
> > > pointing to
> > > > its git submodule.
> > > > Maybe we should mark it in the gitignore.
> > >
> > > I've tried .gitignore but could not make it work (my Gitfu is pretty
> > > lousy). Can you suggest how that should be done?
> > >
> > > You can use the command without the '.' : git commit -m "<commit_msg>=
",
> > this
> > should work.
> >
> > @Tom Rini <trini@konsulko.com> Shall we remove both
> > "lib/mbedtls/external/mbedtls/.gitmodules" and
> > "lib/mbedtls/external/mbedtls/framework"? I can submit a patch if you
> agree.
>
> Can we do that and not make a problem for the next resync?
>
> Hmmm, no, this cannot be pulled back to the MbedTLS upstream so still a
problem
when resync.
Another option is to include that git submodule into the U-Boot project,
this needs
to revert the commit of introducing the library and redo the git subtree
after the
submodule is updated, but it does not seem to be a good choice as we don't
use
that test framework in U-Boot at all.
Right now I don't have a perfect solution, maybe we can accept using git
commit
without the '.'?

Regards,
Raymond
