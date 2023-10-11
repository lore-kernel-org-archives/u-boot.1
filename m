Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128EBCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:33:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08C7486CA1;
	Wed, 11 Oct 2023 21:33:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fkT4fYNi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E71F986CDD; Wed, 11 Oct 2023 21:33:34 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49A3286C6E
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 21:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-d9a58f5f33dso205734276.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 12:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697052808; x=1697657608; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x6hDlc6cYvlt9SKeRanoFIhZ9FN+XaMPNCokFHWDljo=;
 b=fkT4fYNiylesf0xo9yYC2WPtOU9UuYFKwlDWjUCCLIMnqcO+sViVro7T47LXK42+3T
 w1LrZUNTlMXnrVDfTV3Y6nsAkJY7pLKZvbFxpd9ejgQOD1loCVhFbBIYFeD1hFaPzc1+
 v1nsUWdHnlCnCXVowpY+DAddBz6uMh2AN7IdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697052808; x=1697657608;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6hDlc6cYvlt9SKeRanoFIhZ9FN+XaMPNCokFHWDljo=;
 b=nj76KTFFw0UBZhoiI8Trfl5huNU9JR2iziWEjLUkAYm7fDMmfCMt4Wkq9Ycn6q4f+b
 a7oow4Bps533jhfFpN39RUtDC/eHJzPaV04Cy/ShIpEZdMiJE4qD2wLccWXhoLblGOf2
 i+1OlYd1Dk/PqAVQgRUTG1bGFiB2GhqlTFOnmwlkz2/j1o+JpL1czmN3nIOcjpepOuYx
 Wsyb9uv2GWdxTRtgj8CzUfdGHqQYOjk/o8JsEbspfLuZfdP4MaN+jAMuaVAaQ4JADNaP
 K6fl3a7ccSx9xeuMZK9bv+jHW5qxnVzJOay6tsUfw0HMJSiA/UXsZnCNpUmx9LU7G2VS
 n4oQ==
X-Gm-Message-State: AOJu0YzLM72ETopgpEH5AFLrMvqPXO06mccTmSOTIxVBjKoLzzesR2Nz
 wZatCgEB+bOYG+MXkjx4Mdiskg==
X-Google-Smtp-Source: AGHT+IHuqru/M4sSDLrE9e08Be9C3b7bG72Z0fnusNs2L1hP+Hr/wnxMn7ow09qUzajqfLv8/7Z6Cw==
X-Received: by 2002:a25:b1a0:0:b0:d9a:44dd:fe45 with SMTP id
 h32-20020a25b1a0000000b00d9a44ddfe45mr6625205ybj.49.1697052807808; 
 Wed, 11 Oct 2023 12:33:27 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 a14-20020a25f50e000000b00d677aec54ffsm4532157ybe.60.2023.10.11.12.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 12:33:27 -0700 (PDT)
Date: Wed, 11 Oct 2023 15:33:25 -0400
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 5/4] mkimage: update man page and -h output
Message-ID: <20231011193325.GJ3119521@bill-the-cat>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230928080257.2650461-1-rasmus.villemoes@prevas.dk>
 <20231011183722.GT3119521@bill-the-cat>
 <5801c81b-8bfa-6e65-6176-f94299520a62@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KknGbwibiLs+d2eK"
Content-Disposition: inline
In-Reply-To: <5801c81b-8bfa-6e65-6176-f94299520a62@prevas.dk>
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


--KknGbwibiLs+d2eK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 09:07:11PM +0200, Rasmus Villemoes wrote:
> On 11/10/2023 20.37, Tom Rini wrote:
> > On Thu, Sep 28, 2023 at 10:02:57AM +0200, Rasmus Villemoes wrote:
> >=20
> >> The man page correctly said that -B was ignored without -E, while the
> >> `mkimage -h` output suggested otherwise. Now that -B can actually be
> >> used by itself, update the man page.
> >>
> >> While at it, also amend the `mkimage -h` line to mention the
> >> connection with -E.
> >>
> >> The FDT header is a fixed 40 bytes, so its size cannot (and is not)
> >> modified, while its alignment is a property of the address in RAM one
> >> loads the FIT to, so not something mkimage can affect in any way. (In
> >> the file itself, the header is of course at offset 0, which has all
> >> possible alignments already.)
> >>
> >> Reported-by: Sean Anderson <seanga2@gmail.com>
> >> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> >> Reviewed-by: Simon Glass <sjg@chromium.org>
> >=20
> > Applied to u-boot/master, thanks!
> >=20
>=20
> Thanks, but I'm afraid that was premature.
>=20
> The original series which this was a fixup/followup for hasn't been
> applied, and Sean had reservations. I'm leaving it to Simon or Tom or
> whoever has final say to decide if they should eventually go in, but it
> would probably be good to get a verdict soonish (it really shouldn't be
> too controversial), and if it's a no, this should just be reverted.

Ugh, thanks.  I'll push the revert with the next round of changes.

--=20
Tom

--KknGbwibiLs+d2eK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm+H4ACgkQFHw5/5Y0
tywyWAv+NwVaWJkENgl/BJR5+cCk8Mm5zuDZVuwYNWtKWHSg7x8FIiJwm80LS0nw
Kdixlv60F/axhXI8M0XhJ9TQV2p/zzooeqIJ246ob2D8fwWYrbtkz2ioQx+Qkq4R
UuE5sf/41A6590+Kb4EGBFKLZr7/+OY0NZOYNwQjTaVyMbuoT2hnlpiP8snbowLD
kmG3Vff4Eo9VGR2eUsiv1LqiDMeGLOz7IMo2hA5am1iHQNWNulDdpDauMFEOA4B8
l1ffA1NK2Z8S9mOt1+L1NggH9bEscreB42Xpae82HoPQscHA5+si6hc+9+aBfghX
cB88cKCxtpeRwJ8vRrhOotl28rZHcIX+2O5sKtnFn4GOor4V/1Be0bSc/X5L4tAg
nyEl0nqmgJDiXkUJk11lBe8YO9jR71NmjSUlqjrzdNA1IoUDwLMEOw3tcgZKxx/d
kxMbVaWRmoFl031S09fPDSoX0OtuyNA7ZbKBVZX/FU5KbocsxMKEC4UD2OP6F4cT
e7okYyhl
=rRTj
-----END PGP SIGNATURE-----

--KknGbwibiLs+d2eK--
