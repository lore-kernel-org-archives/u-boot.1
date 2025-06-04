Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1CEC5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 15:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A70AF8006D;
	Wed,  4 Jun 2025 17:13:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OwxNZpBS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF72E80584; Wed,  4 Jun 2025 17:13:05 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85F228004F
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 17:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-403407e998eso21661b6e.0
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 08:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749049981; x=1749654781; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KRGhr870xP1Ku6KFb987OLgHLIQfdjK1zKSslIXp5eU=;
 b=OwxNZpBShztTJQE68hSg5pv//xEnkGTWIER3xK+NaeY2rt7fWCY1QCnM/ncs3Kikwd
 7gnZ2qkXqi1B46bXOqL07dQY6cguJjsfUPrY2k/Ded/5IrRaHKqxGcxBrm6DO6Ostxs1
 ocgXO86Z8oyUUWt/qbjMbL9MNZf+f3PY18DrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749049981; x=1749654781;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KRGhr870xP1Ku6KFb987OLgHLIQfdjK1zKSslIXp5eU=;
 b=iHmrtjf3OGaoEyswltCOmCTwITvoYraw9MQesQgYREKG6vFsNWXBSXEKyrNSJIrf9A
 Q/hds8ODWt2gmDfrDELwNlu806VtlyHIHW5DfqZnvlbSV34WZBGyoAB8o3VjTuFgv6B7
 3uUTJNmkjMT1GTWX9u0w750o3OzIMCxncnXl8hmma7CSZyTsspEqVH+zw1Abp/77jkyf
 SxE9KKuHN4z8JP6GFJxBO4J0CPW2eiWae+IK9KYQMobzEZMGY8ozirzs2j30WDA10AHT
 rwfvdUMC9oTMewYNvMCJI9gAS3g9dLTwNUeE/6e22Hd/q9N5RrRk67yccUEeHClzYNQ1
 rsKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQz9k/hNqS7O2T+vRQ0wfeo0X+o7V5zZSv4nB2GBYWhgkKLVm7R8jxvw5x/sn/JJ0xpz1AFHs=@lists.denx.de
X-Gm-Message-State: AOJu0YyQLYSSOuFGPnVr6LNnoALQXXc+8VsOkDHaJT0uNcEN/yq3R0rR
 lEo8cFbS2Jdpiw0fM+U3DXMWvqyJNxpQvV+fgYr0kO8HmQTsZ97zIbmmn07sbwrU4ME=
X-Gm-Gg: ASbGncv9toCVpI+ITjKXB2jytn/AWbYiF7Y3vbCOcnmf07LvHEtW44+Z/Hnx53YGuSp
 AMCQEb6oynzm+kflFFeXd2njCQO9TGBnWiDri4ADIBNkRpTHITfsReBJMw6jgh7spaba2K57+Sv
 852Xa5Zle501hSoHLIMCJplnkM9pVKfgE5NwTFkJgSVfkWr0BrIEZRPpesC3BcCzJnBJ5/lyhm5
 7DSNFgArc82QnDQ7xe1XuoyHAg2VesfdMmLrXbhLUqdvWd3okOImhG/L5FWhzT93knqvJp5DJzD
 WmKIGEIl50LFyBALSTtclQhy4JwG06+RpJiArDqkkDv7Hbtd24elNKgz6FI6uQWZ0uGEptVdYN8
 JmxmFV6+NWNxx
X-Google-Smtp-Source: AGHT+IGA2gTr5OcozQvb69/SKnRvdM7zB18bJp8vpn/wvVd7WZKAcLeFN/qAeK8fJpkTp+W+MHe9Eg==
X-Received: by 2002:a05:6808:228b:b0:407:a4d3:acad with SMTP id
 5614622812f47-408f0f38805mr2246352b6e.14.1749049981518; 
 Wed, 04 Jun 2025 08:13:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678ce8267sm2224816b6e.37.2025.06.04.08.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 08:13:00 -0700 (PDT)
Date: Wed, 4 Jun 2025 09:12:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Raymond Mao <raymond.mao@linaro.org>
Cc: Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>
Subject: Re: [PATCH] sandbox: solve undefined reference to pthread_kill symbol
Message-ID: <20250604151257.GP1382132@bill-the-cat>
References: <20250603151401.1709532-1-raymond.mao@linaro.org>
 <20250603154748.GG1382132@bill-the-cat>
 <CAEfUkU+7BaEcmQ1NL2TSMLpHYQt1DhPLKZPtkB_Fd6u_Oq4qEA@mail.gmail.com>
 <20250603192345.GL1382132@bill-the-cat>
 <CAEfUkULmB2PckAKf+euT8Mj3ehirw-TjmNT20-+AfVy6SpRB=Q@mail.gmail.com>
 <DADNW2131HYB.V2UGC24FOJJO@ti.com>
 <20250604135612.GN1382132@bill-the-cat>
 <6c8b029d-a4a0-43e6-a229-89c6f0583553@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r/4PXNAlxFHzMFuR"
Content-Disposition: inline
In-Reply-To: <6c8b029d-a4a0-43e6-a229-89c6f0583553@foss.st.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--r/4PXNAlxFHzMFuR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2025 at 05:03:44PM +0200, Patrice CHOTARD wrote:
>=20
>=20
> On 6/4/25 15:56, Tom Rini wrote:
> > On Wed, Jun 04, 2025 at 03:33:31PM +0530, Anshul Dalal wrote:
> >> Hi Raymond,
> >>
> >> On Wed Jun 4, 2025 at 2:30 AM IST, Raymond Mao wrote:
> >>> Hi Tom,
> >>>
> >>> On Tue, 3 Jun 2025 at 15:23, Tom Rini <trini@konsulko.com> wrote:
> >>>>
> >>>> On Tue, Jun 03, 2025 at 02:00:23PM -0400, Raymond Mao wrote:
> >>>>> Hi Tom,
> >>>>>
> >>>>> On Tue, 3 Jun 2025 at 11:47, Tom Rini <trini@konsulko.com> wrote:
> >>>>>>
> >>>>>> On Tue, Jun 03, 2025 at 08:13:58AM -0700, Raymond Mao wrote:
> >>>>>>
> >>>>>>> This patch is to solve the sandbox building error:
> >>>>>>> $ make O=3Dbuild-sandbox -s sandbox_defconfig
> >>>>>>> $ make O=3Dbuild-sandbox -s -j2
> >>>>>>> /usr/bin/ld: /tmp/u-boot.27rzOu.ltrans58.ltrans.o: undefined refe=
rence to symbol 'pthread_kill@@GLIBC_2.2.5'
> >>>>>>> /usr/bin/ld: /lib/x86_64-linux-gnu/libpthread.so.0: error adding =
symbols: DSO missing from command line
> >>>>>>> collect2: error: ld returned 1 exit status
> >>>>>>> [...]
> >>>>>>>
> >>>>>>> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >>>>>>> ---
> >>>>>>>  arch/sandbox/config.mk | 2 +-
> >>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> OK, but how do you get this failure to start with? What host?
> >>>>> It failed when I started any sandbox unit test like:
> >>>>> ./test/py/test.py --bd sandbox --build -k <any_test>
> >>>>> My local host: Ubuntu v20.04, x86_64
> >>>>
> >>>> We don't see that normally, is there something odd about your compil=
ers?
> >>>> This is the kind of thing which should be failing everywhere, but is=
n't.
> >>>> Thanks.
> >>>>
> >>> This failure occured in my host since v2025.07-rc1, but with the same
> >>> host, same setup and same instructions it worked fine in v2025.04-rc5.
> >>> Seems that some impacts were introduced during v2025.04-rc5 ~
> >>> v2025.07-rc1, which might be worth investigating.
> >>>
> >>
> >> I am unable to reproduce the issue on gcc 15.1.1 and glibc 2.41. I thi=
nk
> >> the issue is likely on your host end.  What compiler and libc are you
> >> using for the build?
> >=20
> > This feels like if it's generic, CI should be blowing up too, even if
> > it's Ubuntu 22.04 not 20.04 these days. Please bisect down to the
> > failure, since you have known good/bad commits and 'git bisect run' can
> > use the test case you have.
> >=20
> Hi=20
>=20
> I got exactly the same issue on my Ubuntu 20.04 when trying to compile sa=
ndbox.
> b989f9ed9fe1 ("test: lib: add initjmp() test") is the the commit which is=
 causing this issue.
>=20
> Until now, i am still using the default gcc (Ubuntu 10.5.0-1ubuntu1~20.04=
) 10.5.0.

Ah, OK, thanks. Lets reword the commit message, add a fixes tag and
throw it through CI please, thanks!

--=20
Tom

--r/4PXNAlxFHzMFuR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhAYnYACgkQFHw5/5Y0
tyztngwAnCkx3uZwYUQVRC8Kohas9LATn7aokb1uRia7xEK4Qg0FqQlRvfp11NcG
PHo9ueAgLbMVMLweI2xc1bvcsTh7PYba4oAi50B+/mF2M9rLFkJRcrvkr96CHU/C
OeaqPhT6AcXi6tNur9tKKR0lJRxCawnfVvTmu6rBq2DpOavKNMP/TBA+bIgxJym3
WIWETsqj73WdsOeVPQ9+Uo2KtTG3ZLXScmjb0AsjowANm+HP4+ccT6MauwjehAuL
5Ps5rp8sP+zAifep/iVUdlSwtTfSEy0SqyfEW16ja/VGJuduqVP1I+YdJUKV49m8
R3DDvt3Jf/CF5qoRI7gw/odstZM4QNoYUVbfkpmWEslTggV0h7sBHBqMIHAOkcou
RSeADbFPR3+2lZQRVuJgHDmg7W5MoOx5jf5E1b/PUiM/W2Yb/1g+r2h17PLG6vOP
9c94BOTxLX+OqZmaIDfD91621eeLhbauNUFEOgH2+jVkmRNBOdblRwfzoJUwCds8
/sRlkMpI
=GD4C
-----END PGP SIGNATURE-----

--r/4PXNAlxFHzMFuR--
