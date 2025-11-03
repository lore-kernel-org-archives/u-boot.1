Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43640CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 20:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71671836D1;
	Mon,  3 Nov 2025 21:10:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jKgPyvLl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8203B838A5; Mon,  3 Nov 2025 21:10:06 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 922618331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 21:10:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c5333e7099so2983586a34.3
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 12:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762200602; x=1762805402; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dW7ePI9OZDHFzPvzkJLnilrF1wW4Pbq/DQU9JhVJyBA=;
 b=jKgPyvLlxz2fWcLQQgwgE5MuQwP3P+8zU6c/SS7aKxfyx8jgIjDSh4ndh0EyQYxwsy
 0TlPQW8dxAnM5ZgFIIl/99Q4MneGqqGxSpMmEoYGaB257fcJ37zIJ33aGUk9p56Z+Y0/
 y+QA8QtjgyA1p7HnkAswpD6cFUUvJ7ta9IEaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762200602; x=1762805402;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dW7ePI9OZDHFzPvzkJLnilrF1wW4Pbq/DQU9JhVJyBA=;
 b=ewGoh94jBks1y4+EzOkT+2YXTV3GBWWUF0JjAIhp77ibjzw4Gm8ZiosqM/E9IpWRla
 UJzzaLruXF5EH8e7KKRjsoBdrxYQdo7GrE0MeISc5KPXQL0LbzCNITMU8DK50YNUg7oD
 pDKxBaI+2l22Da+kQcMgR6GfY2EPBmVylaf6jC00P7G87cE2nmgARDnVkEiLONoR+onG
 BtgMWtPXOqLeLcKb9kz6NS9HWC6bHB8CR1NEaW08vFv1PPKIDh2wp4h9tcX8Ww8jFAYm
 q8uzkYI7fkNLdW784o0QTtebUT1frhHZaRFqfe8ENNssbp+vtEMJuDjYN0XgRe9em3bu
 YtpQ==
X-Gm-Message-State: AOJu0YwvgZZVU8Yx9tuRLr50oiC7yx4PIw4T/5Ntf5DeeyicvrGFkyAG
 j84rlG9J5mmQ8/Wyzn4zyBR7Rog2A4HIqFOb67qujs/rpaMvemvJCnjwZ/O8mjUXcbc=
X-Gm-Gg: ASbGncu/1Cw5PFxjO9FFjRcHchpb0XL/PENWcjZ2i3EVixP9fhrfJYzg46E3fk4zLbv
 ieR/eBjOr587vhqnu/rXpUY5wK+caSkh1K6hPxop57Bi0PGJBT6RDnUbPRO34d6jCYBEDgYWg+L
 96HDfQVq9jAiIxoBcRavTnf4DE8Fvj7ap5akN3GxNgpvyi+P7qTlWbFmXR2IqL1lkI4F7sePbRc
 4Ldc8C7PmgE+B6mw/QS6MZEI12+1CLZazEQvwKbyl7UgbA6i6soSYEMWmHkHpiutBVeBSNY5Vbh
 kTLeDzAvetgiM1IG6WTzJBal4fRdthxu092z2r+g5TDgh56aJOBKIrPX2ZP6pJmMtjVVR1VqLGT
 rUDKDeVttpFhj8yfwDUCNqYtQlksLIlF+5clycBWFjCKZjMCjChZryl/C5eEqUpqf04fbkNbT1M
 fGj8fdJcRcUE0ATDERKwiFrLxHG7OMO4zqsNRpFetMk336JxKb0g==
X-Google-Smtp-Source: AGHT+IF2BXkPrrQjYCD8YVIZ943qBqzk1BJafN0HOy0/lYJYg1JX048XPktGSrUTUfQ9DEgcHL7wDQ==
X-Received: by 2002:a05:6830:6104:b0:7bf:6dca:2055 with SMTP id
 46e09a7af769-7c6be1cd7abmr1528442a34.4.1762200602178; 
 Mon, 03 Nov 2025 12:10:02 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6c24edd5esm407805a34.21.2025.11.03.12.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 12:10:01 -0800 (PST)
Date: Mon, 3 Nov 2025 14:09:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] Add make feature support for SoCFPGA Handoff
Message-ID: <20251103200959.GR6688@bill-the-cat>
References: <20251101035252.261-1-briansune@gmail.com>
 <20251103153657.GO6688@bill-the-cat>
 <CAN7C2SB0b_YjcJ+LyVUJwi5DjdjR5Ssi=yQwuCvSvBh3XVj+dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fBJLvvbeh2z3YgRT"
Content-Disposition: inline
In-Reply-To: <CAN7C2SB0b_YjcJ+LyVUJwi5DjdjR5Ssi=yQwuCvSvBh3XVj+dA@mail.gmail.com>
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


--fBJLvvbeh2z3YgRT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 02:55:53AM +0800, Sune Brian wrote:
> > OK. I was hoping that we could just automate as part of the regular
> > build process seeing for example $(BOARD)/foo.xml and invoking the
> > script to re-create foo.c and so forth, but that doesn't seem to be the
> > case. So, no Makefile logic. We should then instead start on some
> > content for doc/board/socfpga/ and document this tool there. Thanks!
>=20
> Ok what you expected on the automation flow.
> I can give it a try. But the build flow for Altera project side
> is that the compiled handoff is in the form of a folder.
> only foo_bar is defined by user other naming on C5
> should be fixed.
>=20
> hps_isw_handoff/foo_bar/
>=20
> |-- alt_types.h
> |-- foo_bar.hiof
> |-- emif.xml
> |-- hps.xml
> |-- id
> |-- sdram_io.h
> |-- sequencer.c
> |-- sequencer.h
> |-- sequencer_auto.h
> |-- sequencer_auto_ac_init.c
> |-- sequencer_auto_inst_init.c
> |-- sequencer_defines.h
> |-- system.h
> |-- tclrpt.c
> `-- tclrpt.h
>=20
> Documentation is not an issue.

OK, yes, I think we just document for ourselves too that the tool exists
and how it's expected to be run. Thanks.

--=20
Tom

--fBJLvvbeh2z3YgRT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQkMDwAKCRAr4qD1Cr/k
Cu2jAP4xW6XYD12MlvjSaDi+BADevwfoKyaP+0r5on3xhy9RSAEAo5WekwdKK7R9
FuhvCJcWvGhNtopS28b8UVlLtIlzdA4=
=pwjR
-----END PGP SIGNATURE-----

--fBJLvvbeh2z3YgRT--
