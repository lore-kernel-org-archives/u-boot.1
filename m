Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7F1CAC592
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 17:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05DD5830B4;
	Mon, 15 Sep 2025 19:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m7rPgGL2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40863830CA; Mon, 15 Sep 2025 19:31:16 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11239802C1
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 19:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-75871cd9228so1180607a34.3
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 10:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757957473; x=1758562273; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z1FmZONa5nSh3/mvNXuPk01/YO1JwGp53vna844lQq0=;
 b=m7rPgGL2k0cPfc3+xo4Ua6ktzGeZPRW1agqEmazFPCdM90Ur/NYNNIFnOjlPYoAZiU
 MmnqhHVV6ms8kTrCrwygc8FGuj7f8ikLQREevqRIg9v2t7dp8KHBo20G5EKOe56zadvr
 m/SeuX+lmcr5pbpqBN1fEd2vaX4IWczB9PVzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757957473; x=1758562273;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z1FmZONa5nSh3/mvNXuPk01/YO1JwGp53vna844lQq0=;
 b=XQGwys7lIhINHZ8uXU4xVO4fBVqDhI2TtbxwNvqwyBk44ULe1D7ewYsc7V+/oBgym+
 F2J4t5JnbrSr82tUENC51RxdrN0xaWtPidb0A3kIutWiD+0tx15tPcCiOEa9vRxJ1cDK
 sf2lAUYD1BYyVIoK67ARLq/avpudDKptZLvtHBxRyRTWm6v4ikx7ilrRdazqGiMwCa4r
 EkU5rmSBlZtHeQDj0Lmgtk409bM469uIviVMQ4XMPdz36XUDwP2nA9V2wPsAIgxXLREZ
 JlHirl1MxD9/LtvymU+MGQ65r/xhX//RBltrrgFKs8uLrwImf/aIAntngu1QCFIwYlG7
 26tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJzaSZnlM3cWd2XqbwwcNuulIrSDNlGtBJjJVO2kAjdZtmEvvQvv5Nx8AWULe9w6qfD270bwE=@lists.denx.de
X-Gm-Message-State: AOJu0YyoyoXc+ZOSOlrPjHY/wfFvNUJcgEub/CWveyjwZhPCyjQvZney
 U8RJsCMtZJGWYCHMUQPKLMXyZkPuOoXVUsE8jJCJVuZ38HGQ8BzsRfT10j18TO6MU2s=
X-Gm-Gg: ASbGncvDRuXBRWhUL3r4RbXQquzy+IvKOf1cYMbuDmQ0cIGYCqNy08kDAynhYuILGQz
 NMGoEpM3ngLaiL+UH1UUGmOTSiGBOFv6gJs0f3/Kp9Jl7cdOc1pLUX6sCl0VpVZW1OHVu0SEbaR
 9Q99jiI7puDIM1OxN6EmaToY51edGXi73oLoaNYN49HkpK8ujOaHEs10YFBnfRWYD0TQD9eQQ+x
 O1NuE5rZsl+/S2lEP6we78AO3/iOX/cx12ra5BJ/2Yd5H5u4Hn814RJfhPyhyg/QzVgpM4WAVie
 wefqWQEE1j1/erQl+Jl9pDDEg9rIRw/v1M4sm+bJTY8ElKDBPnnqjjG+u13N25Ykg1dskzJzhHP
 uhmUG6YmqHjvwywMMHml3gCEw4LC6pLw7JbxUQa8rqDwhozODspiFGXursw5618r6rYs=
X-Google-Smtp-Source: AGHT+IEpgxC6xdPSGLpQgyvpYpnVa5IgurFRmJO+gUsqnVgcpjpPH3ggnvPKHVEO7egR+7EmqhhkjA==
X-Received: by 2002:a05:6830:920:b0:745:a220:155c with SMTP id
 46e09a7af769-75353e5eaaamr7242903a34.16.1757957472670; 
 Mon, 15 Sep 2025 10:31:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-621b7d22e0asm1262777eaf.13.2025.09.15.10.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 10:31:11 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:31:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] power: pfuze100: Ensure loop index is incremented
Message-ID: <20250915173109.GL124814@bill-the-cat>
References: <20250703-pfuze100_fix-v1-1-5f838e29d122@linaro.org>
 <20250831153513.GA2800031@bill-the-cat>
 <20250913155154.GF124814@bill-the-cat>
 <cf91c8fe-a264-4db3-990b-b866a42d17a1@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NsOhyZ+UctK8bWA3"
Content-Disposition: inline
In-Reply-To: <cf91c8fe-a264-4db3-990b-b866a42d17a1@linaro.org>
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


--NsOhyZ+UctK8bWA3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 10:45:56AM +0100, Andrew Goodbody wrote:
> On 13/09/2025 16:51, Tom Rini wrote:
> > On Sun, Aug 31, 2025 at 09:35:13AM -0600, Tom Rini wrote:
> > > On Thu, Jul 03, 2025 at 12:31:50PM +0100, Andrew Goodbody wrote:
> > >=20
> > > > The for loop in se_desc uses i as the loop index and also to cause =
the
> > > > loop to end if the passed in name is not found. However i is not
> > > > incremented which could cause the loop to continue indefinitely and
> > > > access out of bounds memory.
> > > > Add an increment of i to ensure that the loop terminates correctly =
in
> > > > the case where name is not found.
> > > >=20
> > > > This issue found by Smatch.
> > > >=20
> > > > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > > > ---
> > > >   drivers/power/regulator/pfuze100.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > I size tested this as part of merging and saw unexpected shrinkage. In
> > > turn, this got me to look harder at the code and I think the best ans=
wer
> > > is to refactor things so that se_desc(...) follow the normal (linux
> > > kernel) pattern of for (i =3D 0; i < ARRAY_SIZE(desc); i++) instead of
> > > being passed size. That's I think the root of this confusion too. I'll
> > > post a patch shortly.
> >=20
> > While I really wanted to make this suggested change, I'm just missing
> > something as to how it should work, and perhaps the better answer is to
> > rework the caller a bit to handle the check inline? I'm not sure...
>=20
> Sorry Tom, I am just not sure if this is an action item on me or are you
> still looking at it? I do not know the code well but could take a look at=
 it
> if needed.

Sorry for being unclear. The original patch isn't right I think, the
size change leads me to believe that we're changing the loop behavior.
Looking harder at the code in question, it seems like it's an odd way to
iterate over every element in the array ('i' isn't used, we just
increment desc and quite possibly don't handle failure to find a match
correctly?). I think the best path is reworking the code a bit, but no,
I don't have the time to. If you don't have time to, perhaps Fabio or
Peng can?

--=20
Tom

--NsOhyZ+UctK8bWA3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMhNWgAKCRAr4qD1Cr/k
CitBAQCcqMLG3u873ZWRW2GO9nwZjYJDqnsMdCtgKoB0VpKq1AD+MTWM52NQ+IB4
yexiuWCNcP5YIWdH/I5ofclntSXrIg8=
=mxPK
-----END PGP SIGNATURE-----

--NsOhyZ+UctK8bWA3--
