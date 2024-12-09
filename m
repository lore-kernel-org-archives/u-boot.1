Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6F4E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 15:32:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA1DC8913F;
	Mon,  9 Dec 2024 16:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SjZW3m5W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0046788CA0; Mon,  9 Dec 2024 16:32:23 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D11F88815
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 16:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d8fd060e27so17835676d6.1
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 07:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733758340; x=1734363140; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PVb9EBqrdhTCkP8RoP1hq8jbF99dref4jk+53QeVoUM=;
 b=SjZW3m5W1pQSADr7546qAxjf1mQgNaKAVRIwHYGZmJNZLn8aVpoV9lXBvBWWRDtTgE
 LoKYLNoVSw6zI3eSCzmiqIDCpAvbM4LJZsE6ZSW+i+5jMX2ddE9bvsgd82T+Ci0RTbl6
 u3FqYMYLeWC+OQbyhSUnjYA5CtuKtMKDD8y8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733758340; x=1734363140;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVb9EBqrdhTCkP8RoP1hq8jbF99dref4jk+53QeVoUM=;
 b=llfDvtT/885zhsMqMRsv4sC58xMJr0kgoXR+0g+9VC7pIFJjxqzNoytH85/+T3zsmB
 UBmKqRb2RPh1znGRiSYQ7zhlDZaX8vRZLsuezxnA1/xcngzrkvgIqGikQ0LaGVbDtmgF
 oeUosR0WBxz54Oqj+yVrYt+HkY1C3sKBI1TcAlnCtHWE1VGSEX4ybhNFgo8V7/5qe2XP
 cd8CxwhsgHdQQiXHWBakpRTJmaiewzlV3wqs3eyumom9+n6YzROsbSZdyZTQNLn+1Wbh
 9k6dxIaWZ8Soabyh8gCpl7+PqNP0xIZrQHb20YkTiJbFsqavypK1uEaTYQJud9POmYxv
 ToNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZAhn4ZIDX/+cNZLFCGQ3VfqELskAWpSuTOFMWdYeAWrZ3cUBqnmOjc+D1guwtDZU80Wb9SCs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+7hwtVYtNei99IT7kGwv/iWtUszynnvgF6P8pg4iudiPieNTX
 vRaM4No4aZtiR3ONXT/3l81EU1rfuXX9POJ1gtiv28bsTMYNnrksep6LBQ8sydM=
X-Gm-Gg: ASbGnct1j31V3BUkJjOtlLvfH2zIwf21qhxZVi4pnObqjC5VU2NDQJIYtf53BYx/Q17
 o5GGtQpLGMWzynhqO2rLlgRsTYnGovrND5vsaXSf5HGp6pzR33f5w6Iopf5xpmjX08Sfnr1Spco
 60XBIb7ug9Zio/UgN/0hX7B5K9AXRgosPJRioqz4XHs5HI9RQegPXwgyaolnbKvFg65MFj5VJME
 m6fTGbt5mke0xFNGJA7db9fCitVE714fuUz7k10u9Dhitj1hAg=
X-Google-Smtp-Source: AGHT+IFuzvSfhUtnna3tWNA/r0HQXv24hjgMEeaaeeuIX94GwrutW76MpKJYM7edYCKgrAkA8S56Cg==
X-Received: by 2002:ad4:5d69:0:b0:6d4:1d4a:70e9 with SMTP id
 6a1803df08f44-6d8e70e9247mr182754506d6.19.1733758340561; 
 Mon, 09 Dec 2024 07:32:20 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da696aa2sm49976516d6.42.2024.12.09.07.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 07:32:19 -0800 (PST)
Date: Mon, 9 Dec 2024 09:32:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, git@xilinx.com,
 neal.frager@amd.com, Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 2/7] common: binman: Calling initr_binman() when
 BINMAN_FDT
Message-ID: <20241209153216.GJ2457179@bill-the-cat>
References: <cover.1730452668.git.michal.simek@amd.com>
 <f79dc1fbf796dd5ad290f6080608ee68d7652cfc.1730452668.git.michal.simek@amd.com>
 <CAFLszTiWOdsS8=pm7aSvyC2QYiXbbsciz2yb6s9YPV1FeFFrgg@mail.gmail.com>
 <2ee46698-87c9-47e3-8951-41ac3c50331a@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gUbfKBcAUk+RGOE+"
Content-Disposition: inline
In-Reply-To: <2ee46698-87c9-47e3-8951-41ac3c50331a@amd.com>
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


--gUbfKBcAUk+RGOE+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2024 at 04:26:15PM +0100, Michal Simek wrote:
>=20
>=20
> On 12/6/24 20:20, Simon Glass wrote:
> > On Fri, 1 Nov 2024 at 03:18, Michal Simek <michal.simek@amd.com> wrote:
> > >=20
> > > Calling empty function when BINMAN_FDT is adding +64B for nothing whi=
ch is
> > > not helping on size sensitive configurations as Xilinx mini configura=
tions.
> > >=20
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > ---
> > >=20
> > > Changes in v2:
> > > - new patch
> > >=20
> > >  From my perspective there is no reason to call empty function. It is=
 just
> > > increase footprint for nothing and we are not far from that limit now.
> > >=20
> > > ---
> > >   common/board_r.c | 7 +++----
> > >   1 file changed, 3 insertions(+), 4 deletions(-)
> >=20
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >=20
> > This is a bit odd, though. Do you have LTO enabled?
> >=20
>=20
> yes LTO is enabled. And there are other candidates like this.
> Is LTO able to fix function arrays which is calling empty function?
>=20
> (without this patch)
>=20
> 00000000fffc0eb4 <initr_of_live>:
>     fffc0eb4:   52800000        mov     w0, #0x0                        /=
/ #0
>     fffc0eb8:   d65f03c0        ret
>=20
> 00000000fffc0ebc <initr_dm_devices>:
>     fffc0ebc:   52800000        mov     w0, #0x0                        /=
/ #0
>     fffc0ec0:   d65f03c0        ret
>=20
> 00000000fffc0ec4 <initr_bootstage>:
>     fffc0ec4:   52800000        mov     w0, #0x0                        /=
/ #0
>     fffc0ec8:   d65f03c0        ret
>=20
> 00000000fffc0ecc <power_init_board>:
>     fffc0ecc:   52800000        mov     w0, #0x0                        /=
/ #0
>     fffc0ed0:   d65f03c0        ret
>=20
> 00000000fffc0ed4 <initr_announce>:
>     fffc0ed4:   52800000        mov     w0, #0x0                        /=
/ #0
>     fffc0ed8:   d65f03c0        ret
>=20
> 00000000fffc0edc <initr_binman>:
>     fffc0edc:   52800000        mov     w0, #0x0                        /=
/ #0
>     fffc0ee0:   d65f03c0        ret
>=20
> 00000000fffc0ee4 <initr_status_led>:
>     fffc0ee4:   52800000        mov     w0, #0x0                        /=
/ #0
>     fffc0ee8:   d65f03c0        ret
>=20
> 00000000fffc0eec <initr_boot_led_blink>:
>     fffc0eec:   52800000        mov     w0, #0x0                        /=
/ #0
>     fffc0ef0:   d65f03c0        ret
>=20
> 00000000fffc0ef4 <initr_boot_led_on>:
>     fffc0ef4:   52800000        mov     w0, #0x0                        /=
/ #0
>     fffc0ef8:   d65f03c0        ret
>=20
> 00000000fffc0efc <initr_lmb>:
>     fffc0efc:   52800000        mov     w0, #0x0                        /=
/ #0
>     fffc0f00:   d65f03c0        ret

No, but maybe Simon would prefer if we marked all of the could-be-empty
functions as __maybe_unused and did:
	CONFIG_IS_ENABLED(BINMAN_FDT, initr_binman),
etc in the list instead?

--=20
Tom

--gUbfKBcAUk+RGOE+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdXDXkACgkQFHw5/5Y0
tyyzkgv9HQfqPwa4FU3iObV2fSbvH1t5riy6Br3AFcWqwRohzBKWWEd3Dgy5eJBC
uEICeubtx2vGTv7/AXhg9Hp2xU++X9H+AUNA9VFnZAY7vASotRQ2svt8IUqCtc+W
viXiYkzzvhfK2+v3SoACKGE6b2fmJ/XqzSx1yZv9cHsmrrJOrWjHP2eiCE3DtkW1
o9zpQGGmGbzexpVz8SYcIXjC9mK54y11ajX+Cbdt7sQFV4akFYXwy9HRpTbxZLls
NwYPh+WNmYRlrjbsOSVsFLpJgAV6CMbijneYnCo87WEHJWIN7i/VyzjIhpx7e29J
5Sb7lrE89qAv0P+muKo+V9D3gqtA5pKwKSoX52VBZbntvvYt/C2NlLPowaq5daqU
EBjAF1Qt+lQfrj4Ioiezyu17my0a7FYqKG5irAN4qOOYGSLJS03wT316RvNpqi7L
iPEQwI26V1cuNin0fM5CvRhL2XOJwyrxx7CyJzBmeNDBjs8IdG8IohCg6KLLMPFO
QBv3p+4N
=iIxp
-----END PGP SIGNATURE-----

--gUbfKBcAUk+RGOE+--
