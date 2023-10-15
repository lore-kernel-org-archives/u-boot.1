Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E54CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 19:28:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BDE586524;
	Sun, 15 Oct 2023 21:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="orlfG2Iz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B4C3863C9; Sun, 15 Oct 2023 21:22:43 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBD39864F3
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 21:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a84204e7aeso17116617b3.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 12:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697397603; x=1698002403; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pzMMMLXQLEDfyqkHehidDuDro1uFIpgOwtu7QORPKyI=;
 b=orlfG2IzJQcZgZ4d3Jggbtlc8y92QAStl3+z20/uBt3C97TqVx1aSXYsV/N+GPrSHR
 mC5bUpgZWNCqz1KiOoPZtXR3+JPmDqIEfFafiDOHvSPLDqmAA1uszSqchGXyRv+EyEzr
 AWilM+HmJS/9iKvnj1nCkuM4toSLatwTeSC8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697397603; x=1698002403;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pzMMMLXQLEDfyqkHehidDuDro1uFIpgOwtu7QORPKyI=;
 b=vIjTrWAlJpkjjBwQT+QDLTXRLza02gg2FEFFPhinNzpiGTTsXvzTpLRfa6yRtj1gE6
 HS6RtAhINJXtrd/aL7GqN5XuMEC5COIzj1vhUVDPusTpljm/CoNiXEUQA5x7MBm2DzuL
 wn3HaSD6QftBd7kzSMeaWcYU/VY4to1sz8B/DnEa2MNj5586h61l3SjboToTE2FyOgTq
 ThqjiCsl3/6bW9JDHkx2p+RjJde54+ZnASjOxhKdpy67Q1n4YYPMaW1qwNwG2LXYFNne
 Bp883U/SROBVmlGYgMDgHN9gaMIvo/OJKRAJmCBiDCCVuABsnpAFhmmWqXHgzk+aw+PV
 t2pA==
X-Gm-Message-State: AOJu0YyT+AfCtNWXO57jlj10nKSuDosxAf6EN/aXknaVF6sO4eIJgBIg
 gINEltr46EJWAuDvT886VGjxPA==
X-Google-Smtp-Source: AGHT+IE5yT+k+i8gJIgfXLQ/whxav2c5sRWc4RlDiTCIFz/SLk2xhWpy1d+OL7vPTMXGSFqTjibr+g==
X-Received: by 2002:a81:4a55:0:b0:599:8bd:5bdf with SMTP id
 x82-20020a814a55000000b0059908bd5bdfmr36058313ywa.50.1697397603536; 
 Sun, 15 Oct 2023 12:20:03 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 d11-20020a05620a140b00b0076cda7eab11sm2430273qkj.133.2023.10.15.12.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 12:20:02 -0700 (PDT)
Date: Sun, 15 Oct 2023 15:20:00 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Harald Seiler <hws@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH v2 17/29] net: bootp: Fall back to BOOTP from DHCP when
 unit testing
Message-ID: <20231015192000.GC3119521@bill-the-cat>
References: <20231014204805.439009-1-seanga2@gmail.com>
 <20231014204805.439009-18-seanga2@gmail.com>
 <1365B46D-6CCA-4064-ABC1-97CF581564C7@gmx.de>
 <f3fa804c-0c6b-f31d-6bd6-d5e3408a3861@gmail.com>
 <CAPnjgZ06ULY5335j-7JpBU75nDV52Rbyevj0FdPyvVwRds47wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I7Z1J0IAuYYHPmRS"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ06ULY5335j-7JpBU75nDV52Rbyevj0FdPyvVwRds47wg@mail.gmail.com>
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


--I7Z1J0IAuYYHPmRS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 15, 2023 at 08:39:50AM -0600, Simon Glass wrote:
> Hi Sean,
>=20
> On Sat, 14 Oct 2023 at 15:27, Sean Anderson <seanga2@gmail.com> wrote:
> >
> > On 10/14/23 17:22, Heinrich Schuchardt wrote:
> > >
> > >
> > > Am 14. Oktober 2023 22:47:53 MESZ schrieb Sean Anderson <seanga2@gmai=
l.com>:
> > >> If we sent a DHCP packet and get a BOOTP response from the server, we
> > >> shouldn't try to send a DHCPREQUEST packet, since it won't be DHCPAC=
Ked.
> > >> Transition straight to BIND. This is only enabled for UNIT_TEST to a=
void
> > >> bloat, since I suspect the number of BOOTP servers in the wild is
> > >> vanishingly small.
> > >>
> > >> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> > >> Reviewed-by: Simon Glass <sjg@chromium.org>
> > >> ---
> > >>
> > >> (no changes since v1)
> > >>
> > >> net/bootp.c | 6 ++++++
> > >> 1 file changed, 6 insertions(+)
> > >>
> > >> diff --git a/net/bootp.c b/net/bootp.c
> > >> index 2053cce88c6..7b0f45e18a9 100644
> > >> --- a/net/bootp.c
> > >> +++ b/net/bootp.c
> > >> @@ -1073,6 +1073,11 @@ static void dhcp_handler(uchar *pkt, unsigned=
 dest, struct in_addr sip,
> > >>                          CONFIG_SYS_BOOTFILE_PREFIX,
> > >>                          strlen(CONFIG_SYS_BOOTFILE_PREFIX)) =3D=3D =
0) {
> > >> #endif       /* CONFIG_SYS_BOOTFILE_PREFIX */
> > >> +                    if (CONFIG_IS_ENABLED(UNIT_TEST) &&
> > >> +                        dhcp_message_type((u8 *)bp->bp_vend) =3D=3D=
 -1) {
> > >
> > > As written before, please, do not add unit test specific code paths.
> >
> > While it is convenient for tests to implement a BOOTP server, there are
> > effectively no BOOTP servers in the wild. However, BOOTP is commonly en=
abled
> > in U-Boot. In an effort to avoid growing most U-Boots for testing purpo=
ses,
> > I enabled this path just for unit tests. That said, only 6 boards enabl=
e SPL_ETH,
> > so maybe it is not too bad.
>=20
> Yes, also if you are using networking in SPL, you can expect it to add
> quite a bit to code size.

And so long as this doesn't lead to overflowing them, OK.  But size is
not infinite there, am335x_evm and am43xx_hs_evm are both a bit
constrained.

--=20
Tom

--I7Z1J0IAuYYHPmRS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUsO1wACgkQFHw5/5Y0
tyxATAv9Fg5DZHKF2b34iVvpxPxRMzt2ieanw8GeSe5BqEwmq29tKy98vQeQ1Mji
J7/jpv5fpqDrfrKyQUFnJZzJKnRp3Oyhoa5CiraiEtDxN2fs28in9DNWifqsqMlz
8btdsg2LLZMaF445Qzl6v8qR+8r40dgUaBnbPYD058blTqHrc7g5DHvk6/mpKFvE
Hghbf3KYgQflYbKHHRoXQ0X+mXguJkOa/v0FqZ+O5CRnoMvxxQKnfGp587k3nd27
+UqSQoqEet2CIvpx1wIjTTR2/Rh7HN4J+09cHoqJpSF4PQRnUTxmtqDaW6vn9H9n
y7k5UDtSxRI3+HyaIec5YpYnyWRD7PtsfvqA/tS2pwOMhr7vGZvwTicBKuF9fHFJ
9hNhyDtLpyrN3N7ACjtpE4M3JtjwvwKSc3ufXVP6pmT6UaGAt/GvvLh62XzKu0Hn
+BGqfji+7jQaYjAU1af/aueEjNBEQ7dUdpNKYOPGuYcQn0fLFmRryNf/ocvu2/ya
g29shLj9
=wYql
-----END PGP SIGNATURE-----

--I7Z1J0IAuYYHPmRS--
