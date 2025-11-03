Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE21CCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 20:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7731D836D1;
	Mon,  3 Nov 2025 21:42:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mlACbZk5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D65E8838D7; Mon,  3 Nov 2025 21:42:43 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3E548331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 21:42:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c69f515220so616004a34.1
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 12:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762202560; x=1762807360; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VpJUfL/507ldd/XLabD2it8yEJn86kAxKVtbfJd0BKM=;
 b=mlACbZk56czkYc2ZHkrE8cxyga+3EXmOnxi899CJPh0M/fM6wm5sFhNnsyUSz9EZyG
 AnhCjZhedGsECxNlFObj41fSt7BpY5O5X2BqASolwJE4TsIL6/+l7Rbid6wHWVBeP53V
 PgA6q1s/51GACOUaSeGfeXJ9ijxiKl9s0vxts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762202560; x=1762807360;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VpJUfL/507ldd/XLabD2it8yEJn86kAxKVtbfJd0BKM=;
 b=Fzbe7+7T2lbgtQLSjv6rbk1rZsFrXTDGzcf9ZwQgK+f9uj0FtcmT6oWtpAhBloeN9L
 9gk4fSQrFKjK9KiKsU+4bIZSUT7DrAbADXclBzzIPEPL0k4ti+zub+a5i2Y5AjJbqom8
 c9ks5vnuBt/P1xPfAuIqwDBcWOmKWthYS22SwamE3E8Td+p9HV2FMskta4xEf9FDSQjR
 S1dbJSyqGiylGzXYbj72bgJa5UAbWsuiXedOGSfLER9Tc4obbt4yUO1I5rrAAo+xG7Qi
 HlgHfkQUR7NcR/CUgh+T/sSzcfPpWr+VLjE2q+lg3q1w4+ZewWwnpxEs7jxXLgNKchhd
 wChA==
X-Gm-Message-State: AOJu0Yx2d2ivw3KDTl3QbG1rgAcrEe0Y1buIj2XaL3rUXZiepNFa+VCg
 1+UcInJUVWoTt9nrA0xtUXkDweXucZcZ8YLesjZx4UZodz4QFPsdcJIHfxDUhG8/qGE=
X-Gm-Gg: ASbGnctUmgllgQ/hJttwtjOEYTZIjPjn87zAhN6noNt20QH8bHfNHlXDihE5P1akzgv
 M/GZNRuwEqno6Vch1VUJngw3zf5ltfT0qpm+eD74fMUU1iFPWHknydJ2jjb/AXChktzCx+JmKWZ
 eZ8a2hYtmNP1zkYubMa3XcYSh6gbz/2kgLQEQtWiitHsuT8mo/MP7+Tn1djcjV+NhauFLtj62S+
 grNGNXnxsWCrr9HazbjYVfXEM3cQlGcuUFMEmrFPZC0ZrxYtHrd2lpaprQ26EumTR55AFjTqAKV
 CWP3oC6r53VlIzALqj4LG/OkKNPgLt6OP30ALJMIDGFMnGa67LZ8Y1ldu5AY4XVSM0LnMXmatsu
 Fbpp7FYV7bTZ3/Dy6tNZ3rSheaBskSOcBpm6dtgTy/AF/ah1ll+pbMSzbflTquLJQW7DdtwFjo6
 DMseQWfG88T84njNwOAHTFBhd6Q4fuwMUZgxeCEmM=
X-Google-Smtp-Source: AGHT+IGnVFjXeOeT1BnJ8dY3758q7j1gtrb9Mkq7EPy5QE0hsWnvuHlSaNI3bCAPDH44ctZe9GsQjw==
X-Received: by 2002:a05:6830:dc1:b0:749:fac2:92fe with SMTP id
 46e09a7af769-7c69661cb68mr6382910a34.0.1762202560376; 
 Mon, 03 Nov 2025 12:42:40 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6c25002eesm428090a34.28.2025.11.03.12.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 12:42:39 -0800 (PST)
Date: Mon, 3 Nov 2025 14:42:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] Add make feature support for SoCFPGA Handoff
Message-ID: <20251103204237.GS6688@bill-the-cat>
References: <20251101035252.261-1-briansune@gmail.com>
 <20251103153657.GO6688@bill-the-cat>
 <CAN7C2SB0b_YjcJ+LyVUJwi5DjdjR5Ssi=yQwuCvSvBh3XVj+dA@mail.gmail.com>
 <20251103200959.GR6688@bill-the-cat>
 <CAN7C2SCY1Q2_YcJWVMs0Zv+ymcuXLXEhrkX2JGcJviOaKDf0sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v4e1zFSEXVHnAS1w"
Content-Disposition: inline
In-Reply-To: <CAN7C2SCY1Q2_YcJWVMs0Zv+ymcuXLXEhrkX2JGcJviOaKDf0sQ@mail.gmail.com>
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


--v4e1zFSEXVHnAS1w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 04:16:28AM +0800, Sune Brian wrote:
> > On Tue, Nov 04, 2025 at 02:55:53AM +0800, Sune Brian wrote:
> > > > OK. I was hoping that we could just automate as part of the regular
> > > > build process seeing for example $(BOARD)/foo.xml and invoking the
> > > > script to re-create foo.c and so forth, but that doesn't seem to be=
 the
> > > > case. So, no Makefile logic. We should then instead start on some
>=20
> My previous mail would like to know what need to be done for the
> Makefile logic automation works as you expected. I can give it a try.
> And what is the current difficult?
>=20
> Should the handoff compiled folder just place in the board/xxx/xxx
> And let is auto build or not?

I think I'm not explaining things well enough because I don't quite
understand the tooling well enough either. What I would like, but don't
think is possible, is something like:
$ make O=3D/tmp/myboard myboard_defconfig
=2E.. goes along and sees that boards/myvendor/myboard/myboard.xml exists.
=2E.. Runs the python script to re-create all of the C files, assuming xml
=2E.. is newer than the C files.
=2E.. Now compiles the new C files.

But I also don't know how useful that work flow is. Which is why I'm
going back to thinking that just having the tool, and documenting where
it is / how to run it (under docs/boards/... so that it shows up in our
generated docs) is likely good enough.

--=20
Tom

--v4e1zFSEXVHnAS1w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQkTugAKCRAr4qD1Cr/k
Ckp6AP9y2kUke1V7GJG92wYqPolfzLTwaz9hmsPpkw65oP5FvQD9Fd0kvB95zMdk
iNK3clEhPDRsjc9E4e9QzycMbz7PAwE=
=2bZ2
-----END PGP SIGNATURE-----

--v4e1zFSEXVHnAS1w--
