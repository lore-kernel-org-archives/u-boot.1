Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CA4C3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 22:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 927EB80C83;
	Tue, 13 May 2025 00:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T5QkE118";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5E3482162; Tue, 13 May 2025 00:04:46 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACE1480584
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 00:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2d5e5e21b92so3625899fac.0
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 15:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747087483; x=1747692283; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I+2CU/KVy6s/XXmKAkl+liS+a1d73Bj24EvgUKnfJIU=;
 b=T5QkE118Ew99Hd6DQ86r1gNbCFwbLgl5tsYqJ+8j376iu/xE/+/z2t/0j1nSBfarqW
 foyfusZ8naGF9AV6G20DtMD7FTbKYOQpDjBpB2kRjGvlNdmpWNz4v2FRjtT79IL/B9pB
 xYE9Lrvb4UeH+fI3yTMZRNSgGW3ES05es4v40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747087483; x=1747692283;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+2CU/KVy6s/XXmKAkl+liS+a1d73Bj24EvgUKnfJIU=;
 b=GSS1/Vsxim+7u2gk2u/VZmwVN+dlNGhszVclRK+gicQjpYceoNnURczizDWLooNFvc
 wjARSTv/yjM/xIHpsp7NEX8Jr0K12rsCaLj7rvb+2n9XPUAxg1ctRUFxBTM/izDc2986
 brMMhqZijBRW++e0bBknB4zdl0RUKS42rz8NlTdl9tQiTsKPn3h8hSu1iwwVWYAxyht6
 F9MCAJK3Gq3SPbQ5yxLFGt2rYamG5vlFUP530ArLLtc09tgnfUbWfMtCfakcXpfa0YOQ
 2HjPhHIZPEOnA+BVWweH0TTc+rw2lkDowYvUQTk+Vk1VBU9TFP9vE2weZTlHvPxNinz5
 q9mw==
X-Gm-Message-State: AOJu0YxtlbZM8ej3k8ysGJc1QD1A6ZYyy6EjVCX/PaWH+JZzgIm/bCJ7
 2JZe9R3SsxUCutwITi+sG3Ufr9ZZX3sHDZtutpGCNYAn2XaEga48y5DB+MsUKno=
X-Gm-Gg: ASbGncuKlPtGne4lBAnf+yyAAI6hbnGnAc59FGG+71R+a4Jy2LVjSZeq2KYDu8A+Bw2
 bK/0ay/FKNkMoIv2SOjXZC9uY3nHHdCflAPhATkW9EfE+sgGGYQETwnar9dTz4nX0RfzaSkKOed
 S/Nz8Bw23w3AwwS6GpXR0ZT9V/krTh0Aux5HIpUHhTDbK/uLG/vHTEmfi7EV7u4yAx83wt+LsPc
 /Ej84es6IbmO3NC5kpe0ji7fMzaHqekcpetCpnX9rakHUNbRzs5Ch1w228O0K2a/hB0g9Ly7hgU
 aFgoXQCGDX+Blw7eiQ8y36FnLggbBWnXFq5kO/kXehf8tw0z/zJn0GS9HZKHIw3K7ZbwwPgeu3t
 ZY82wAxV87sw/
X-Google-Smtp-Source: AGHT+IH3/LQa9/GMjRb0pKdHnSxa5d7rz+lU17Ypl1zBIWrLlwuQ5oG28dorYTEElGho9fTg4UvAHw==
X-Received: by 2002:a05:6870:5252:b0:2c2:5a63:9cd4 with SMTP id
 586e51a60fabf-2dba435541emr7958784fac.19.1747087483238; 
 Mon, 12 May 2025 15:04:43 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba07c740csm2085089fac.29.2025.05.12.15.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 15:04:42 -0700 (PDT)
Date: Mon, 12 May 2025 16:04:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 0/3] doc: Document remaining test_b* tests
Message-ID: <20250512220439.GS603748@bill-the-cat>
References: <20250507232500.527782-1-trini@konsulko.com>
 <20250508214222.643020-1-trini@konsulko.com>
 <CAFLszTjwfGV6P7GzFDYFVp8G5oTvoXUKvOXZy6KLNW_=BMO+xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Av143vDccTLFjxep"
Content-Disposition: inline
In-Reply-To: <CAFLszTjwfGV6P7GzFDYFVp8G5oTvoXUKvOXZy6KLNW_=BMO+xQ@mail.gmail.com>
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


--Av143vDccTLFjxep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 01:27:23PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 8 May 2025 at 23:42, Tom Rini <trini@konsulko.com> wrote:
> >
> > Hey all,
> >
> > This short series is a follow-up to my last series. It could have been
> > longer, but I think this is a good point to get some feedback on a few
> > points.
> >
> > As background, something I wondered about and the answer seems to be No
> > is, can we automatically take things like:
> > @pytest.mark.buildconfigspec('cmd_button')
> > and get some nice output? Since we can't that limits the value,
> > possibly, of generating some documentation.
> >
> > First, as this series shows, is there value in documenting tests which
> > do not require additional configuration? We have some tests with no
> > comments and some that are fully commented, but at the end of the day
> > when trying to run these tests, pytest will already say helpful things
> > like not being supported on a given platform, or not run because
> > something isn't enabled in the build. Spelling that out in generated
> > documentation would require duplication of work.
>=20
> Yes, I agree. I think the code is the best place for most of the docs.

>=20
> >
> > Second, is there value in documenting arguments? Especially ones like
> > "ubman" that are just required and always present?
>=20
> I like documenting arguments, since when people see the docs they
> continue the trend. Python suffers terribly from a 'def
> my_function(*args, **kwargs)' disease where you have to spend hours
> spelunking around to figure out what is actually valid as an argument.
> Highly Pythonic, but dreadful.

Maybe I wasn't clear in these two points. Let us use
test/py/tests/test_cat.py as a concrete example. Today, most of the file
is:
# SPDX-License-Identifier:      GPL-2.0+

""" Unit test for cat command
"""

import pytest
=66rom subprocess import call, check_call, CalledProcessError
=66rom tests import fs_helper

@pytest.mark.boardspec('sandbox')
@pytest.mark.buildconfigspec('cmd_cat')
def test_cat(ubman):
    """ Unit test for cat

    Args:
        ubman -- U-Boot console
    """
    try:
    ....

My point and question is that "@pytest.mark.buildconfigspec('cmd_cat')"
will not be translated to generated documentation, but also that if you
try and run this test outside of sandbox, pytest already tells you it's
not supported, and a similar error if sandbox but not cmd_cat.

So is there any value in adding doc/develop/pytest/test_cat.rst that
will consume the above and generate valid documentation that I'm not
sure would ever be read?

> > Third, should we document internal functions too, or just the tests? I
> > would be inclined to say no unless they're expected to be re-used. The
> > test_net functions to bring up the networking are an example that of
> > reuse that should be documented for example.
>=20
> Sounds right. But I am likely to continue to document all Python
> functions, since I never know when I'm going to want to export
> something for use elsewhere.

I'm certainly not saying we shouldn't comment the code, but perhaps
a follow-up to document test/py/tests/test_distro.py would clarify some
of what I'm asking about in your mind.

--=20
Tom

--Av143vDccTLFjxep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgicHMACgkQFHw5/5Y0
tyxghQv8CAhkv3+b6KzIZ6YuL0tg8akheFWtB99fQr16Q+G9Rph5z5Y/xck2u04E
h9ePNSQpvmB2hGeGeLGB3V0UiO4PNy+Ao7tyvFw1N6BrPUgNsIbIocE93TpXyQtk
LhuM/MHZdCDTfamit/AHeVXUgvGepvOEI2FJPwxRT9tR7S5MztY9+f/sA64wkaB+
Nd6NtbPLlGoCTxw7jqUmsajneOJlol7zEqAN+3D6vDDS+nhRUKGMISZE1ZKT4VPR
axABuoHHhQ+DHxrrz+jQbDh/VoC2LBvJwuUdcFBiqEsnPi9VjlZcvQSjDJwit0CV
+iK3oR0UQi+0HIjJ+Ia3aHDp7mO9CdKUWH9n6xre5dPJP11B9oIXdUw6bHckutjw
nq4bN9i5EEDd0CN77dnV4FYVj8PaJkd0y709L3wBxaQ2x8TjOEICKzvzRjL/Tq+q
/yglU5+piC4ufKOigtDkHFvufLF3am7mnvZVEMnHP0dt9lntzzevraiBXE36mb2i
BPkrRtB9
=tg1U
-----END PGP SIGNATURE-----

--Av143vDccTLFjxep--
