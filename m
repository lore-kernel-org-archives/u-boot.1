Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48622D68BDA
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 21:55:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B951D895E0;
	Fri, 15 Nov 2024 22:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dmUOIkdo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 536C2895E0; Fri, 15 Nov 2024 22:55:47 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5016F89688
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 22:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ea0d64e78dso1497999a91.1
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 13:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731707743; x=1732312543; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cf85yO0k0JviHGlnFyFyDNDde+fqdMXOr+G6v8uMhNA=;
 b=dmUOIkdolRJFIWRer8GFAuDWCuSdO/mtuajaN99FyS3U2nXd2S1aqi24fRhKudck5b
 amoVkmKDgP8+0mGabvR9yo5PMetn/pLx3/eIkw6J6Zs+pL68gQVB8DPzx1GN9MIu4UCs
 x193tlIJw5TAXk+sIy8UejMMPeRp9ahCzyZFOHaTV0tZGzsauY/VqxRIj1sV+p2gJ9JO
 NCTbpLTDqCj560HacRt1ZVeuIdOkXsqB4projibuzPsGj3wNpyRL0NphkA/nmYTRKUQG
 UuM827OenFA/ONzh6zcbf/7zI17WfIsHSqt3OhtcdlcrXCS4zlOII5qkn6fhvEfRqeUf
 otpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731707743; x=1732312543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cf85yO0k0JviHGlnFyFyDNDde+fqdMXOr+G6v8uMhNA=;
 b=KQMYKCXSGfY/+Ap3hndUmexfBO2GMtkC7JJsfkZJE2Ph5VvdVFGgvc27YNALRTMqmH
 7+w+kieWeHo+eCbX62Dth7lh8qh/KvkqXPS8MswLPEr56mHmgs2XFZaQjb1duahtj6n4
 op6Q7cdhXHr/px5/VluP0Cz067i/RMgOI15lltUStwuyfSH4PMz6Zt0vvccoBBKd104I
 5bDMnOT/Ccu9Gnu2iFZHbR9ZVzKMEj+omYUwXEGUH1r0kR8m7+WRzZL4eBSOi2UxsGLg
 LSlKngSNegZ+/zAkSErNu9+cP/7KjFnvSWjR8dysWq5EQy6WhgPMz3NUFg5DftEQzmaz
 izEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9nciDgfWmLQqCAVnKRqhYh0LWD81/RKbzL+cB0xdezmSo/7ox9JMNS25KR/sSuoRNNp2tBoA=@lists.denx.de
X-Gm-Message-State: AOJu0YwGpWhykGFJHM4xY4QV+1hledy9I6EvxXPraPjLPxSitwhYApuw
 Dk3wj2BvaCgG2adbL8eZVd0+s1keDZmilpNDnYZpUEmon0HHAbZEKq9fr9OthDNTv5iTNpeuTnF
 FaF6oSADUGCLVianiuUI3x2FrgouLX5uBDHKEdQ==
X-Google-Smtp-Source: AGHT+IH0TGDe74fApXbV8YNgEXAxVjg/yeBq89lQ+SPM27JkEI88iyfsn0RE8Xj3LvE07k55RoDvf5ZohLUsz9BnH+k=
X-Received: by 2002:a17:90b:1bc6:b0:2ea:303e:cf5f with SMTP id
 98e67ed59e1d1-2ea303ed035mr1396013a91.8.1731707742641; Fri, 15 Nov 2024
 13:55:42 -0800 (PST)
MIME-Version: 1.0
References: <CAJaLiFwvFVOKYpAQLSNUqAfVHCsPcxo6g74JGunw8HSQTMCFLA@mail.gmail.com>
 <20241115141748.GS3600562@bill-the-cat>
 <CAJaLiFx35Q8L-kR02GrA1PTd2nY699KMc2fy5fT381Khg5hgxg@mail.gmail.com>
 <CAJaLiFy2oo2fp-08qJni8srUn6RErgGgZs_A3GGPJuD0+=YsOw@mail.gmail.com>
 <CAEfUkUJOd03fc5VERRPY18LWMomEbYFRnkHSJcFLcdnPq4=8jA@mail.gmail.com>
 <CAJaLiFw134mzZk7TkJMgAppx11Xv3qZsbU-Y78XimX8jNbJtMA@mail.gmail.com>
In-Reply-To: <CAJaLiFw134mzZk7TkJMgAppx11Xv3qZsbU-Y78XimX8jNbJtMA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 15 Nov 2024 16:55:31 -0500
Message-ID: <CAEfUkUKp9wWhgBW2XFubhoccSGeU-CW3Y+FY+iJhfw7eVLZv_g@mail.gmail.com>
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

Hi Tony and Tom,

On Fri, 15 Nov 2024 at 16:35, Tony Dinh <mibodhi@gmail.com> wrote:

> Hi Tom,
> Hi Raymond,
>
> On Fri, Nov 15, 2024 at 1:09=E2=80=AFPM Raymond Mao <raymond.mao@linaro.o=
rg>
> wrote:
> >
> > Hi Tony
> >
> > On Fri, 15 Nov 2024 at 15:32, Tony Dinh <mibodhi@gmail.com> wrote:
> >>
> >> Hi Tom,
> >>
> >> On Fri, Nov 15, 2024 at 11:27=E2=80=AFAM Tony Dinh <mibodhi@gmail.com>=
 wrote:
> >> >
> >> > Hi Tom,
> >> >
> >> > On Fri, Nov 15, 2024 at 6:17=E2=80=AFAM Tom Rini <trini@konsulko.com=
> wrote:
> >> > >
> >> > > On Thu, Nov 14, 2024 at 08:26:33PM -0800, Tony Dinh wrote:
> >> > > > Hi Tom,
> >> > > >
> >> > > > I am on 2025.01-rc2, and I am trying to commit some files. The
> error
> >> > > > seems to indicate this framework directory might need some
> >> > > > modification. Did I miss something?
> >> > > >
> >> > > > error: 'lib/mbedtls/external/mbedtls/framework' does not have a
> commit
> >> > > > checked out
> >> > > > fatal: updating files failed
> >> > >
> >> > > That's odd. You didn't happen to try out some of the previous lwIP
> >> > > iterations on that tree did you?
> >> >
> >> > No, I did not. The tree is clean with "make mrproper" and on the
> >> > master branch. I just did a git pull and worked on it.
> >> >
> >> > I went and looked at https://github.com/Mbed-TLS/mbedtls.git. The
> >> > framework directory is pointing to a specific commit.
> >> > framework @ 3867faa
> >> >
> >> > I'll stash and repeat it on another clean tree.
> >>
> >> I have the same commit error on a brand new tree.
> >>
> > I think you are talking about the test framework of MbedTLS's original
> testsuite,
> > am I right?
> > MbedTLS was ported into U-Boot as a git subtree and that framework is a
> git
> > submodule of original MbedTLS repo which was not included in the portin=
g
> > of U-Boot since U-Boot has its own testsuite.
>
> Here is what I found.
>
> git clone https://github.com/u-boot/u-boot.git u-boot-master-test
> cd /usr/src/u-boot-master-test/
> patch -p1 < ../builds-u-boot-marvell/sheevaplug/sheevaplug_bootstd.patch
> git add .
> git commit . -m "arm: kirkwood: Enable bootstd and remove jffs2 for
> Sheevaplug board" -e
>
> The git commit above gave out this error:
>
> error: 'lib/mbedtls/external/mbedtls/framework' does not have a commit
> checked out
> fatal: updating files failed
>
> So I tried to commit only the specific files, and it works OK.
>
> git commit configs/sheevaplug_defconfig include/configs/sheevaplug.h
> -m "arm: kirkwood: Enable bootstd and remove jffs2 for Sheevaplug
> board" -e
> [master 47de8cff2d] arm: kirkwood: Enable bootstd and remove jffs2 for
> Sheevaplug board
>  2 files changed, 17 insertions(+), 19 deletions(-)
>
> I think it must be what Raymond said above. So perhaps during Tom's PR
> pull, the framework directory was created. But "git commit ." does not
> like the empty lib/mbedtls/external/mbedtls/framework directory.
>
> Under the native MbedTLS git repo, by default it has a "framework"
pointing to
its git submodule.
Maybe we should mark it in the gitignore.

Regards,
Raymond
