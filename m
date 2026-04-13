Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D8EF531CA
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 20:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0039483DC9;
	Mon, 13 Apr 2026 22:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P+mFypT8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D902584198; Mon, 13 Apr 2026 22:13:51 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A43A9839DF
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 22:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d86eb7c854so2387034a34.3
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776111228; x=1776716028; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FWlQ+PCbB7G6Set9qlJlaok8JKGXDb3YlFG9D93GQ9I=;
 b=P+mFypT8bgfeRY5ga93BB+Kjd00MSJutMpYAfuUl274LQeiwHuO4gh1M3seNNgbty6
 8fYt5WRKzGzxz81VdD3r5QUq+LyUKDwzI2rhVUp8160K7ug/96zD4+aTjjE67FIuxiGm
 foAC1p06QUSnvFni+7AQLuGwBmNarjlatKj2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776111228; x=1776716028;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FWlQ+PCbB7G6Set9qlJlaok8JKGXDb3YlFG9D93GQ9I=;
 b=LNQge+PHU9L9dvtILYIcq5J7A7hV2GLTggAnMDX4PEKG9srjDYIq7SW8r4zxwMmEbS
 Xs1YV7IxCFP/aLIr8dQhQ24HL7Qwme9xGDKO7V/5F12rJvhn3VFfL7iy+O8kiaDYCHS4
 MIUlzmi9UK+DSAS/HCAXXKrLSn/Ah76HxwAYADsXvWjTgHBp7i8sWZne2V1tB4P1hozw
 L6c7P8nYl2tklRkWoTdJsNyJtSWeYmLwDklLArryOvh+HfQpxMlP/INHo08I39kbfOJP
 RG2p2Ro0kQLEjnBrkt04Mztj/6QYCMyMe6Vi/5Jc6g9yNxMIyS309iDGlGOGNX3jpk1K
 Te1g==
X-Gm-Message-State: AOJu0Yxz57ZYtClYh7sy6W4Wzl07tSPweaAuGmvrD9f9CucfEvpy+Fxy
 TxLB+KgIxk94sPUltSiARiuXJvqz8xt+a2t0Qj/rBnliMnJm2ncWxi3ZEDNGmiY60u4=
X-Gm-Gg: AeBDies25BwUwA7y2wfshbrDpEshMYPuSumYIVYiIqUlySD1KgTWZm5Q4tHO4JF3pzI
 Yaua3s03BY7lws9k5751cCEv6oU0iOCSE6L78UxbLwK8uxvS/MERMAWezL5JTKycHwJJdLCVyk5
 lguVZk0Mn5msMg/btbMle9o7kRb/BX5Nu6JalvmJR0HdNTso0LSgJSmiVXJhDks9mvb+uasvFfi
 G2L3zNsvaHcdEduYDeQJSnR+QBn39V/D0+q1NQO13r7VkZryHXqbPEZNRsxilf14GPPDS/7X1VM
 oyG8DMYDsGt7IsmJ3yG5Jfqq/gEaQ6hZOJ7O08gtWJFgYY+h4HlRkMJI40/lnzg67kulmjI7Zp+
 iSB+ncjGIqdB8H7Az1HF+o5kfsZjYEnbj0A49OCu86XZID97hSDk37wNHh/LFVmdxQFXR3It1ap
 KtpxMyL4VkEs8Rx/HTIHqOE3h6qtM3lWJk9cKqcevmBY8mw0p946cNpIj8hJHuamSckZNa/voNz
 cEpsl+egRXt/1lxa6QST8EFv3M4a3tmRrChbpUH0aKcBWwaMCE=
X-Received: by 2002:a05:6830:4ac1:b0:7d7:d0bf:7045 with SMTP id
 46e09a7af769-7dc27c9c987mr9167379a34.8.1776111227996; 
 Mon, 13 Apr 2026 13:13:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc26907f82sm9895212a34.17.2026.04.13.13.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 13:13:47 -0700 (PDT)
Date: Mon, 13 Apr 2026 14:13:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 00/12] test: Add support for passing arguments to C
 unit tests
Message-ID: <20260413201344.GF41863@bill-the-cat>
References: <20260412111958.943933-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JJlf/GrFNRJmZbm5"
Content-Disposition: inline
In-Reply-To: <20260412111958.943933-1-sjg@chromium.org>
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


--JJlf/GrFNRJmZbm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 05:19:37AM -0600, Simon Glass wrote:
> Some tests have two parts: a Python test which handles setup, such as
> creating filesystem images or configuring the environment, and a C
> test which does the bulk of the work including assertions. At present
> there is no way to pass information between these two parts, so
> things like paths and device names must be hard-coded in the C test.
>=20
> This tends to make people write tests in Python, but this is not ideal
> for several reasons:

You still need to work on explaining your changes in a positive manner.

> - Python lacks access to things like return codes and has to scan the
>   console output to figure out what happened

Pro: Python exercises things the way users exercise them and so exposes
deficiencies in our user interface as well, when applicable.

> - Python lacks access to internal state, so it cannot directly check
>   the result of an operation

It's unclear when that is, or is not a problem and when tests that do
check intermediate state are providing value.

> - Python is ~100x slower due to console interaction, etc.

Again, maybe you should go back to your suggestion of several years ago
to see about addressing that, as the tests themselves are not slow, it's
the pipe? Our brave new AI powered world runs on Python handing stuff
off and getting it back super quickly.

> - C tests can be stepped through in gdb, which is much harder with
>   Python driving the console
> - C tests can exercise internal APIs directly (e.g. fs_read(),
>   fs_size()) rather than going through the command layer, so they
>   test more precisely what they intend to

All things that may or may not be problems for other people, or are
intentional choices as they again test the system the way it's used.
Using gdb attached to u-boot in the other terminal where you're running
breaking things sounds like a reasonable debug path to me. And having
unit tests calling in to functions is why today we have a lot of things
not marked as "static" and so not being optimized as well as they could
by the compiler, which is its own set of trade-offs and not an automatic
good thing and design win.

[snip]
>  16 files changed, 1437 insertions(+), 279 deletions(-)

All of which is to say, you need to explain yourself in a positive, not
negative or oppositional way. Otherwise this reads like "I don't like
what we do now, here's a bunch of change to what I like instead".

--=20
Tom

--JJlf/GrFNRJmZbm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCad1OdQAKCRAr4qD1Cr/k
CmL5AQD81r5HN5JbKqZw/RVBZmcpY2AwL13qcL8nPaqk23RWJQEA5dgknuvxnhkv
lSt1KoNk1jOCl8Lt27LyOwZ7Z2Z+zAw=
=Y80O
-----END PGP SIGNATURE-----

--JJlf/GrFNRJmZbm5--
