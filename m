Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010C7C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78B7C87A7B;
	Thu, 28 Dec 2023 16:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aL7hZ63G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B34F787A83; Thu, 28 Dec 2023 16:40:25 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82B9D87A71
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:40:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5e3338663b2so41820957b3.2
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 07:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703778022; x=1704382822; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LV5HYDTwth11SCm/hkxUEmW750N8GY1Knjet06uuHWg=;
 b=aL7hZ63GntK76DAAIDzLy87mvuBEGW8RoY/fMKVCKnjeAZnLZNMFw0jbg+Q3kA2wV9
 sEfUlb0D8JPpBt1fZ/1x4s/bpcUqq0ovn3PChzBcYJEs1l59Dt6o7z3gNQPxe1QnMrbX
 fqiMfgEh+BuMxB71o9SJ+CiZVCzeO4GB1eCe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703778022; x=1704382822;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LV5HYDTwth11SCm/hkxUEmW750N8GY1Knjet06uuHWg=;
 b=jG9jlSoDyV4ztHVPFBYZwSY1qyBeMtUadXUD065aS50sYOhT9PjPBdqxppUll4a0+2
 BPqQAwlvFm/T5iTViluJ6a6ffwg9Eonw5azYY4wWg5KX2+Wzsm3SRYuEpslw1RXSCyWg
 PVBwrrCsnsbm4OiSnpNs9iQ3EsuytQEDlFek0kV2YfM/Xl2cmVwhFUKHfmwY8F0m8yy/
 udxbm6fmbgmWIGEVJRGUANInF0YV3G21ZrjSP//Z573xXk8JwxQ4LJWqyfTnB/DrajS7
 jMk2PBVTIlvQPNAkj03pDYj3rKzxiwbrvvCCXzyBnxw6kA8/XXfIqeD8UxjnmJhJN6e3
 glIg==
X-Gm-Message-State: AOJu0Ywn07MP4yfDmJgizqzQ+Kb7LjIA6AX2vfiVdDgNKaUs5si+Hd/U
 w0gg0BoIDqemrW5kFXhcpcKXUcr0l082Ww==
X-Google-Smtp-Source: AGHT+IF9bDYM8iFjx6cXz6FQlmhiW+TK8aeP6nAjcA98IP6YEhG/z1NDd1VVC8AZLL7QoL/FTQddLQ==
X-Received: by 2002:a0d:cb97:0:b0:5e8:7efe:236c with SMTP id
 n145-20020a0dcb97000000b005e87efe236cmr4870885ywd.83.1703778022199; 
 Thu, 28 Dec 2023 07:40:22 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 v190-20020a8185c7000000b005da43aa4e56sm7563058ywf.89.2023.12.28.07.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 07:40:21 -0800 (PST)
Date: Thu, 28 Dec 2023 10:40:19 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Andreas =?iso-8859-1?Q?Bie=DFmann?= <andreas@biessmann.org>,
 Michal Simek <michal.simek@amd.com>,
 Michal Simek <monstr@monstr.eu>, Minkyu Kang <mk7.kang@samsung.com>,
 Scott McNutt <smcnutt@psyent.com>, Thomas Chou <thomas@wytron.com.tw>
Subject: Re: [PATCH 0/9] dts: Move to SoC-specific build rules
Message-ID: <20231228154019.GH2652760@bill-the-cat>
References: <20231227082405.2202246-1-sjg@chromium.org>
 <20231227132156.GQ2652760@bill-the-cat>
 <CAFLszThBrAVSH2jYxhxFSETqr4za+BqjZBBjLaDokc1ZdrXXRw@mail.gmail.com>
 <20231228142311.GD2652760@bill-the-cat>
 <CAFLszTghB1ZObpxUe+afAp2zzQOfn2M9198ofsgnyW9cseG2Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1eJK8RpYbJITLfSu"
Content-Disposition: inline
In-Reply-To: <CAFLszTghB1ZObpxUe+afAp2zzQOfn2M9198ofsgnyW9cseG2Ew@mail.gmail.com>
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


--1eJK8RpYbJITLfSu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 03:09:40PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, Dec 28, 2023 at 2:23=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Dec 28, 2023 at 01:37:07PM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, Dec 27, 2023 at 1:21=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Wed, Dec 27, 2023 at 08:23:56AM +0000, Simon Glass wrote:
> > > >
> > > > > U-Boot builds devicetree binaries from its source tree. As part o=
f the
> > > > > Kconfig conversion, the Makefiles were updated to align with how =
this
> > > > > is done in Linux: a single target for each SoC is used to build a=
ll the
> > > > > .dtb files for that SoC.
> > > > >
> > > > > Since then, the Makefiles have devolved in some cases, resulting =
in
> > > > > lots of target-specific build rules. Also Linux has moved to using
> > > > > subdirectories for each vendor.
> > > > >
> > > > > Recent work aims to allow U-Boot to directly use devicetree files=
 from
> > > > > Linux. This would be easier if the directory structure were the s=
ame.
> > > > > Another recent discussion involved dropping the build rules altog=
ether.
> > > > >
> > > > > This series makes a start at cleaning up some of the build rules,=
 to
> > > > > reduce the amount of code and make it easier to add new boards fo=
r the
> > > > > same SoC.
> > > > >
> > > > > One issue is that the ARCH_xxx Kconfig options between U-Boot and=
 Linux
> > > > > are not always the same. Given the large number of SoCs and boards
> > > > > supported by U-Boot, it would be useful to align these where poss=
ible.
> > > >
> > > > I don't know why we should start with this now, and further not bei=
ng on
> > > > top of Sumit's series to remove our duplicate dts files. And that's
> > > > where we can have the conversation about for which cases it even ma=
kes
> > > > sense to build all of the dts files for a given SoC.
> > >
> > > This is a completely different series - there are no conflicts with
> > > Sumit's series so it can be applied before or after it.
> > >
> > > My goal here is to clean up our build rules, rather than just throwing
> > > them all away, for reasons we have discussed previously. I filed [1]
> > > to track that.
> >
> > Yes, I'm saying we shouldn't be doing anything this series does until
> > after Sumit's series has landed. Along with the fact that I don't like
> > what's going on in this series.
>=20
> This seems to again be the disagreement over whether a single DT
> should be build for each board, or all the DTs for an SoC?

It's about the disagreement on what we should be building, and what that
infrastructure looks like. I do not like adding extra rules for
"clarity" because they don't make things clearer, they lead to the
unclear mess we have today getting worse. Most instructions are _not_
"now take this dtb and this binary and .." but just "take this binary",
because we already have the rules and logic to ensure we build the
required dtbs. I also don't like the parts of this series that amount
to deck shuffling when we should just be taking the chairs away. There's
just not nor will there be a case for omap3/4/5 platforms of "change the
dtb", so building more is pointless. For other SoCs, there may be some
cases of "this could have been just a DT change", like
rock5b-rk3588_defconfig / rock5a-rk3588s_defconfig could share a board
dir, but the configs are different and the dts are different, so I don't
know that you could really just swap the dtbs.

--=20
Tom

--1eJK8RpYbJITLfSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWNlt0ACgkQFHw5/5Y0
tyxZeAv+KZ/ZOWaF1EIt6rekh/nbJwlRL/ey2w3zCN5Lnrz2MsBUQqz9P21Mz2Zo
GMU5dWtkv0vcnF9+HiR811uWbthocy7POwhlpZvC0JSGgiWRIhyWWdR8eePkSYU/
zpKicUWA0QKYhV0uWTwDazdM6XHNzbRR/bcfT2CMoI0WxRbRfdwcn1sprkUwTiPM
I6JBU9to/xwfg1D54G43WBFI+fEAhsN3r/Eu5kGLg0KdKdrpnjAfpO8n2JvYQ7J5
S8EZfkLbEy/w/jYjLNIy+rIjXnsrm3MwsE0wnjEO1mdcqZzS6b2bmPSjImDYahCf
94B4vQE5ygRMmxb08uCxlo8LESk3262EB9D43hKm5Ggc1Fjs/SajZ9tPV6ncQ4T1
f/0hoFPImrRPSwhn0jR1ktKvbvdQ2PViigLmUIxdvjiQXkUEYdgtEYMxoOteFgfB
jeSvxzgzkz4977lagdM0nKmo35Eso88NNsWU5IKPw8E/jfPL7NHm7plbn3JuKBKD
+tzK4uWc
=1rgn
-----END PGP SIGNATURE-----

--1eJK8RpYbJITLfSu--
