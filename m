Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAEDD49237
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 15:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42C938935F;
	Mon, 18 Nov 2024 16:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iEBnxmUK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6C6088F12; Mon, 18 Nov 2024 16:37:49 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E4F088C53
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 16:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-460ad98b043so34524591cf.1
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 07:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731944266; x=1732549066; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YHcninl/fmKm3wglrWzTX6WPT0NtxcE97EVkfz4Zj9g=;
 b=iEBnxmUKHwEoOsU206E7Rddm1rSKUG++8S3TL2sfe7M/Tj/JhgHuBVbtTCCehxb3MJ
 1ySc2D1DMjBBWYX3Y6ITTIObSlApSIcLXJKk7qabHKwyjkaq1omiHE+J5LEK/FEmcUcU
 WAZfEXfYRD0BNdVXVjFOaslHvJCIiaYqxWIj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731944266; x=1732549066;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YHcninl/fmKm3wglrWzTX6WPT0NtxcE97EVkfz4Zj9g=;
 b=ASY8oWTIp1jCE92QlRtaQZqHtN8ckMALJxDfiabRuws7LGZGlVzD175I5jpRBGMGCI
 BqB8tCQhv5UjGlsTLnnk8yTBhyZVzo5ynLvJ9RT+v1t8YGigiPh0IG2nT1b0y3IOk8ad
 uUCtENLdIqpv4L33Hh5fGeChk0WZ2qbpHeSwpga44DntFp1Wj2T4LyisNIuJz8SV757K
 7QdDR/c716doLvkJ+b4XMJyfiqqo0pDapcAXovrnoeAQDj8pkv7CrwuOcTT/GTwW9L2Y
 RJWaOiWKiSgqyxpVpCshEHZrwwjIAIltU1qrWo8x2usbjyzYLvecpvaNQYM8tDicwdsG
 iy/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd6PnncTRfAa/tXYkf5WLc+mPBQkkluLTxnLJ1SJdJ9Pv9OqofA6tEyov+AovbyWT6me6/IqA=@lists.denx.de
X-Gm-Message-State: AOJu0YwYnKzHXu74UMYEvGp9syTEGJAkJJ0qu6gl2/Ps1vNLReau0TU/
 cDR2z+kAw9/fMpDhNaiN/ghbeFHJFJQ3KGeeiEdejdDJDQakdVQ9M1/USZzOwXk=
X-Google-Smtp-Source: AGHT+IF+Xeh4l902IGpyCBm8ZWVx+DFR5recmYRvBU6yLzL04WKQ6Xm3eUaq7+PssO5fLxN9a/naqw==
X-Received: by 2002:a05:622a:5e8e:b0:45d:8b53:1888 with SMTP id
 d75a77b69052e-4636352f52fmr217880671cf.11.1731944265967; 
 Mon, 18 Nov 2024 07:37:45 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635a9c5ffasm59840531cf.1.2024.11.18.07.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 07:37:44 -0800 (PST)
Date: Mon, 18 Nov 2024 09:37:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Git commit failed with mbedtls/framework
Message-ID: <20241118153742.GO3600562@bill-the-cat>
References: <CAJaLiFwvFVOKYpAQLSNUqAfVHCsPcxo6g74JGunw8HSQTMCFLA@mail.gmail.com>
 <20241115141748.GS3600562@bill-the-cat>
 <CAJaLiFx35Q8L-kR02GrA1PTd2nY699KMc2fy5fT381Khg5hgxg@mail.gmail.com>
 <CAJaLiFy2oo2fp-08qJni8srUn6RErgGgZs_A3GGPJuD0+=YsOw@mail.gmail.com>
 <CAEfUkUJOd03fc5VERRPY18LWMomEbYFRnkHSJcFLcdnPq4=8jA@mail.gmail.com>
 <CAJaLiFw134mzZk7TkJMgAppx11Xv3qZsbU-Y78XimX8jNbJtMA@mail.gmail.com>
 <CAEfUkUKp9wWhgBW2XFubhoccSGeU-CW3Y+FY+iJhfw7eVLZv_g@mail.gmail.com>
 <CAJaLiFzTjHWCw+ioPZv660yQ0XLM6+SMJh3NV=NYivbtE1Uf_Q@mail.gmail.com>
 <CAEfUkULhPuH15fDENXubhNPOQvbAjBv5f_yoeH7gjC4rhczxtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t9PsAJUi3gkjqowa"
Content-Disposition: inline
In-Reply-To: <CAEfUkULhPuH15fDENXubhNPOQvbAjBv5f_yoeH7gjC4rhczxtA@mail.gmail.com>
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


--t9PsAJUi3gkjqowa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 10:24:32AM -0500, Raymond Mao wrote:
> Hi Tony,
>=20
> On Sat, 16 Nov 2024 at 02:39, Tony Dinh <mibodhi@gmail.com> wrote:
>=20
> > Hi Raymond,
> >
> > On Fri, Nov 15, 2024 at 1:55=E2=80=AFPM Raymond Mao <raymond.mao@linaro=
=2Eorg>
> > wrote:
> > >
> > > Hi Tony and Tom,
> > >
> > > On Fri, 15 Nov 2024 at 16:35, Tony Dinh <mibodhi@gmail.com> wrote:
> > >>
> > >> Hi Tom,
> > >> Hi Raymond,
> > >>
> > >> On Fri, Nov 15, 2024 at 1:09=E2=80=AFPM Raymond Mao <raymond.mao@lin=
aro.org>
> > wrote:
> > >> >
> > >> > Hi Tony
> > >> >
> > >> > On Fri, 15 Nov 2024 at 15:32, Tony Dinh <mibodhi@gmail.com> wrote:
> > >> >>
> > >> >> Hi Tom,
> > >> >>
> > >> >> On Fri, Nov 15, 2024 at 11:27=E2=80=AFAM Tony Dinh <mibodhi@gmail=
=2Ecom>
> > wrote:
> > >> >> >
> > >> >> > Hi Tom,
> > >> >> >
> > >> >> > On Fri, Nov 15, 2024 at 6:17=E2=80=AFAM Tom Rini <trini@konsulk=
o.com>
> > wrote:
> > >> >> > >
> > >> >> > > On Thu, Nov 14, 2024 at 08:26:33PM -0800, Tony Dinh wrote:
> > >> >> > > > Hi Tom,
> > >> >> > > >
> > >> >> > > > I am on 2025.01-rc2, and I am trying to commit some files. =
The
> > error
> > >> >> > > > seems to indicate this framework directory might need some
> > >> >> > > > modification. Did I miss something?
> > >> >> > > >
> > >> >> > > > error: 'lib/mbedtls/external/mbedtls/framework' does not ha=
ve
> > a commit
> > >> >> > > > checked out
> > >> >> > > > fatal: updating files failed
> > >> >> > >
> > >> >> > > That's odd. You didn't happen to try out some of the previous
> > lwIP
> > >> >> > > iterations on that tree did you?
> > >> >> >
> > >> >> > No, I did not. The tree is clean with "make mrproper" and on the
> > >> >> > master branch. I just did a git pull and worked on it.
> > >> >> >
> > >> >> > I went and looked at https://github.com/Mbed-TLS/mbedtls.git. T=
he
> > >> >> > framework directory is pointing to a specific commit.
> > >> >> > framework @ 3867faa
> > >> >> >
> > >> >> > I'll stash and repeat it on another clean tree.
> > >> >>
> > >> >> I have the same commit error on a brand new tree.
> > >> >>
> > >> > I think you are talking about the test framework of MbedTLS's
> > original testsuite,
> > >> > am I right?
> > >> > MbedTLS was ported into U-Boot as a git subtree and that framework=
 is
> > a git
> > >> > submodule of original MbedTLS repo which was not included in the
> > porting
> > >> > of U-Boot since U-Boot has its own testsuite.
> > >>
> > >> Here is what I found.
> > >>
> > >> git clone https://github.com/u-boot/u-boot.git u-boot-master-test
> > >> cd /usr/src/u-boot-master-test/
> > >> patch -p1 < ../builds-u-boot-marvell/sheevaplug/sheevaplug_bootstd.p=
atch
> > >> git add .
> > >> git commit . -m "arm: kirkwood: Enable bootstd and remove jffs2 for
> > >> Sheevaplug board" -e
> > >>
> > >> The git commit above gave out this error:
> > >>
> > >> error: 'lib/mbedtls/external/mbedtls/framework' does not have a comm=
it
> > >> checked out
> > >> fatal: updating files failed
> > >>
> > >> So I tried to commit only the specific files, and it works OK.
> > >>
> > >> git commit configs/sheevaplug_defconfig include/configs/sheevaplug.h
> > >> -m "arm: kirkwood: Enable bootstd and remove jffs2 for Sheevaplug
> > >> board" -e
> > >> [master 47de8cff2d] arm: kirkwood: Enable bootstd and remove jffs2 f=
or
> > >> Sheevaplug board
> > >>  2 files changed, 17 insertions(+), 19 deletions(-)
> > >>
> > >> I think it must be what Raymond said above. So perhaps during Tom's =
PR
> > >> pull, the framework directory was created. But "git commit ." does n=
ot
> > >> like the empty lib/mbedtls/external/mbedtls/framework directory.
> > >>
> > > Under the native MbedTLS git repo, by default it has a "framework"
> > pointing to
> > > its git submodule.
> > > Maybe we should mark it in the gitignore.
> >
> > I've tried .gitignore but could not make it work (my Gitfu is pretty
> > lousy). Can you suggest how that should be done?
> >
> > You can use the command without the '.' : git commit -m "<commit_msg>",
> this
> should work.
>=20
> @Tom Rini <trini@konsulko.com> Shall we remove both
> "lib/mbedtls/external/mbedtls/.gitmodules" and
> "lib/mbedtls/external/mbedtls/framework"? I can submit a patch if you agr=
ee.

Can we do that and not make a problem for the next resync?

--=20
Tom

--t9PsAJUi3gkjqowa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc7X0IACgkQFHw5/5Y0
tyyr1gv9E7/1aU8qqTTp4qDPBiIY6iqfDQeayNAc1B5UAupsHvrJPa3Ip0cJLBh5
EWyVFo9ahtWQ5CmlqsClIzKRnjkKPwYsO7k5NWx9Gkm8gzl+StD9gjyXJEy1GVfC
l1K+4JlvX4RwQbH6WnBiXtsqVN8gqDCLFlnwS1IkHiv7hWDdVXNtg5zoMCWYGPc+
Ybz1jTbASupprK7ZpMNnJ7SO5L4SdN09Jtp5l+KmaopR08rRxYeWubvK8DKM/Ydh
mPQQO790EC4Y0gcKeKSrwFmQi3bAgko4myaqKxh7nY8+FQ4rcDR1z/W+xyL4l1cV
k/CAY820/e5TtFQTqJ2iUKuJUWep2CrUsCZ6NB3rgSqCLnmz6sZdhwXUas+fVpsw
Wc6REo1QJdHLHg3u/RFxr8YnXnVh2fV42p20yXF38+1+Xl5xuJP5DZ1mABiA5NM2
4kaz5nuE6hvTokRiUz86jMgVlXAp+bWCmSCZclbN/KHv3LpLY1/RFFubePOX0rQk
m8SFNNZ0
=4+Zw
-----END PGP SIGNATURE-----

--t9PsAJUi3gkjqowa--
