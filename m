Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E44D591A5
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 16:41:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DA7D8948B;
	Mon, 18 Nov 2024 17:41:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mJYNbMis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDB5789491; Mon, 18 Nov 2024 17:41:29 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40EB289482
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 17:41:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d42518f493so5740836d6.0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 08:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731948086; x=1732552886; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IyDI0EQFtErFZBR5gGbF5xzIvVenLLjX1Y9yT9pmsEU=;
 b=mJYNbMiso1wt3mTRrevIeTYf4wSluaWhoQei9tr/ENfXvLKq0Roxk9ebhHbxtPIN1L
 wePMDRid7iIc6LrhVjlHM/BC+2EVdZqxNaLg3aWZKsh3vsy2U7v2kKBe/d4iLLwwpgLO
 qAtVfVTZzsP8Avi9cdfyg/Fos9aX3T0FHUScs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731948086; x=1732552886;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IyDI0EQFtErFZBR5gGbF5xzIvVenLLjX1Y9yT9pmsEU=;
 b=OnXvNzrsTHZf7BmaVBEFDX2rNJVg/dWuVNBYvuCgrAjj+BHAgtSYVHxQvbF50HF2J2
 D9N+vr2C36Wm2fQiPgJXFVfwdiWO5mSPEJzfS3KShMAVMvuU81CjAOP6vqfKX8s83+u/
 9QcKR7XMTSTGRLp3arhiiA9LLDbzxDH1zteamTDUgzl4hcXnUl5imB0Zag+9qiUqE3zY
 +en7avqLmufJLjC6TNyMiKLXw4KaFxq8bEvQSVq5YWuwx9EG4LyxFByLMzPgyxQ+jHgI
 91r9VQpxe3dMdRSpb++5SUEsM76rUsPJMXebAFHEkQu9FhySjXxDgDnrRBg7D8rXtv8L
 QPHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3zZGHOH5/bgeJcvhIFTY7GB7r+JfzmnGUByu9N2Hsx6FmyJlujMjBMa1fm+sNjMfwDd9ehOU=@lists.denx.de
X-Gm-Message-State: AOJu0YxFNDr5+z4Jv9hGM6RPkQantrVkxgAJ5ptMy9jMQh8pZ1FPICRS
 CRTJVlagtbpszbe1PZmhCjIR7hPsuCiBQR/jb13yiBucuW1NvZbch9T0UOfak9wawbFwYevbWk8
 ZGr4=
X-Google-Smtp-Source: AGHT+IETSVXHv4DPeLBRXkyHMn4XXZzSKQyRD4E8SW50SqvoWrvabjv39xgEwp/BuHHgfddPH+A+/Q==
X-Received: by 2002:a05:6214:dc2:b0:6d4:287f:4301 with SMTP id
 6a1803df08f44-6d4287f51e0mr22687656d6.28.1731948086090; 
 Mon, 18 Nov 2024 08:41:26 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d40dc0f8f0sm37714836d6.41.2024.11.18.08.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 08:41:25 -0800 (PST)
Date: Mon, 18 Nov 2024 10:41:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Git commit failed with mbedtls/framework
Message-ID: <20241118164122.GQ3600562@bill-the-cat>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VCuxu1/Et5XoE+u6"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJNOTCsh19VbKsHw9wWO1nn8o-OhRrAB46uhpKHO-Owsw@mail.gmail.com>
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


--VCuxu1/Et5XoE+u6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 11:27:06AM -0500, Raymond Mao wrote:
> Hi Tom,
>=20
> On Mon, 18 Nov 2024 at 10:37, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Mon, Nov 18, 2024 at 10:24:32AM -0500, Raymond Mao wrote:
> > > Hi Tony,
> > >
> > > On Sat, 16 Nov 2024 at 02:39, Tony Dinh <mibodhi@gmail.com> wrote:
> > >
> > > > Hi Raymond,
> > > >
> > > > On Fri, Nov 15, 2024 at 1:55=E2=80=AFPM Raymond Mao <raymond.mao@li=
naro.org>
> > > > wrote:
> > > > >
> > > > > Hi Tony and Tom,
> > > > >
> > > > > On Fri, 15 Nov 2024 at 16:35, Tony Dinh <mibodhi@gmail.com> wrote:
> > > > >>
> > > > >> Hi Tom,
> > > > >> Hi Raymond,
> > > > >>
> > > > >> On Fri, Nov 15, 2024 at 1:09=E2=80=AFPM Raymond Mao <raymond.mao=
@linaro.org
> > >
> > > > wrote:
> > > > >> >
> > > > >> > Hi Tony
> > > > >> >
> > > > >> > On Fri, 15 Nov 2024 at 15:32, Tony Dinh <mibodhi@gmail.com>
> > wrote:
> > > > >> >>
> > > > >> >> Hi Tom,
> > > > >> >>
> > > > >> >> On Fri, Nov 15, 2024 at 11:27=E2=80=AFAM Tony Dinh <mibodhi@g=
mail.com>
> > > > wrote:
> > > > >> >> >
> > > > >> >> > Hi Tom,
> > > > >> >> >
> > > > >> >> > On Fri, Nov 15, 2024 at 6:17=E2=80=AFAM Tom Rini <trini@kon=
sulko.com>
> > > > wrote:
> > > > >> >> > >
> > > > >> >> > > On Thu, Nov 14, 2024 at 08:26:33PM -0800, Tony Dinh wrote:
> > > > >> >> > > > Hi Tom,
> > > > >> >> > > >
> > > > >> >> > > > I am on 2025.01-rc2, and I am trying to commit some fil=
es.
> > The
> > > > error
> > > > >> >> > > > seems to indicate this framework directory might need s=
ome
> > > > >> >> > > > modification. Did I miss something?
> > > > >> >> > > >
> > > > >> >> > > > error: 'lib/mbedtls/external/mbedtls/framework' does not
> > have
> > > > a commit
> > > > >> >> > > > checked out
> > > > >> >> > > > fatal: updating files failed
> > > > >> >> > >
> > > > >> >> > > That's odd. You didn't happen to try out some of the prev=
ious
> > > > lwIP
> > > > >> >> > > iterations on that tree did you?
> > > > >> >> >
> > > > >> >> > No, I did not. The tree is clean with "make mrproper" and on
> > the
> > > > >> >> > master branch. I just did a git pull and worked on it.
> > > > >> >> >
> > > > >> >> > I went and looked at https://github.com/Mbed-TLS/mbedtls.gi=
t.
> > The
> > > > >> >> > framework directory is pointing to a specific commit.
> > > > >> >> > framework @ 3867faa
> > > > >> >> >
> > > > >> >> > I'll stash and repeat it on another clean tree.
> > > > >> >>
> > > > >> >> I have the same commit error on a brand new tree.
> > > > >> >>
> > > > >> > I think you are talking about the test framework of MbedTLS's
> > > > original testsuite,
> > > > >> > am I right?
> > > > >> > MbedTLS was ported into U-Boot as a git subtree and that
> > framework is
> > > > a git
> > > > >> > submodule of original MbedTLS repo which was not included in t=
he
> > > > porting
> > > > >> > of U-Boot since U-Boot has its own testsuite.
> > > > >>
> > > > >> Here is what I found.
> > > > >>
> > > > >> git clone https://github.com/u-boot/u-boot.git u-boot-master-test
> > > > >> cd /usr/src/u-boot-master-test/
> > > > >> patch -p1 <
> > ../builds-u-boot-marvell/sheevaplug/sheevaplug_bootstd.patch
> > > > >> git add .
> > > > >> git commit . -m "arm: kirkwood: Enable bootstd and remove jffs2 =
for
> > > > >> Sheevaplug board" -e
> > > > >>
> > > > >> The git commit above gave out this error:
> > > > >>
> > > > >> error: 'lib/mbedtls/external/mbedtls/framework' does not have a
> > commit
> > > > >> checked out
> > > > >> fatal: updating files failed
> > > > >>
> > > > >> So I tried to commit only the specific files, and it works OK.
> > > > >>
> > > > >> git commit configs/sheevaplug_defconfig include/configs/sheevapl=
ug.h
> > > > >> -m "arm: kirkwood: Enable bootstd and remove jffs2 for Sheevaplug
> > > > >> board" -e
> > > > >> [master 47de8cff2d] arm: kirkwood: Enable bootstd and remove jff=
s2
> > for
> > > > >> Sheevaplug board
> > > > >>  2 files changed, 17 insertions(+), 19 deletions(-)
> > > > >>
> > > > >> I think it must be what Raymond said above. So perhaps during To=
m's
> > PR
> > > > >> pull, the framework directory was created. But "git commit ." do=
es
> > not
> > > > >> like the empty lib/mbedtls/external/mbedtls/framework directory.
> > > > >>
> > > > > Under the native MbedTLS git repo, by default it has a "framework"
> > > > pointing to
> > > > > its git submodule.
> > > > > Maybe we should mark it in the gitignore.
> > > >
> > > > I've tried .gitignore but could not make it work (my Gitfu is pretty
> > > > lousy). Can you suggest how that should be done?
> > > >
> > > > You can use the command without the '.' : git commit -m "<commit_ms=
g>",
> > > this
> > > should work.
> > >
> > > @Tom Rini <trini@konsulko.com> Shall we remove both
> > > "lib/mbedtls/external/mbedtls/.gitmodules" and
> > > "lib/mbedtls/external/mbedtls/framework"? I can submit a patch if you
> > agree.
> >
> > Can we do that and not make a problem for the next resync?
> >
> > Hmmm, no, this cannot be pulled back to the MbedTLS upstream so still a
> problem
> when resync.
> Another option is to include that git submodule into the U-Boot project,
> this needs
> to revert the commit of introducing the library and redo the git subtree
> after the
> submodule is updated, but it does not seem to be a good choice as we don't
> use
> that test framework in U-Boot at all.
> Right now I don't have a perfect solution, maybe we can accept using git
> commit
> without the '.'?

Hmm. Maybe we just delete the .gitmodules / directory and it shouldn't
be too hard to deal with on updates. I have to do some small fixups with
the device tree ones anyhow sometimes.

--=20
Tom

--VCuxu1/Et5XoE+u6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc7bisACgkQFHw5/5Y0
tyxO4gv7BG816k1H7ittLByiUyIjPGcm2m3cLez4YtuFobL85YyhkG9kROVPtfzb
jhhNnVWpG410jrWMaTCELg/GCBlyxrgryhQ49etP42mV0EL3SEZFhlETfyG5ShMZ
GLpt8Vih39WmxSqi5gyqPS74FGnGAXF+bmhsAso+RHQ3ainMoLTLSy+piCkleoLl
NaCx/3VLdkUD/pTS3MGQ73cKhT3GKGO5p8FM1BaDL0EQ6ljzlXu0QMYmw5El7T54
6VF45sNoepiEp2X2BK34JFRnZTFkI/yDEgLbEH9plDW6darsdJH8eaXS9ZM6NiNo
B9lM5tK4d3Ou4lse3oNTl7A3DBb3n4Zh7wPJtIf6iB2SEROLvWdU7D+7Uk9Z5gYS
c5G65W2b5aRrpVVCEjajuMYn2JS2QCfFcdmbLFz+pagI5JBiXRpfogQWz2U0dmoL
HV2WdfxaMuytaPGq1eIv5Dj6naYX2f2pjuTlPOdlQh9Mkh4IKGh5peBrsnHsZnZq
7vTnImuI
=KFDF
-----END PGP SIGNATURE-----

--VCuxu1/Et5XoE+u6--
