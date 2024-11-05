Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18ABD2B92F
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 14:17:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A3A89156;
	Tue,  5 Nov 2024 15:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YBS3V6sK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C859D8912C; Tue,  5 Nov 2024 15:17:20 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A94489000
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 15:17:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b147a2ff04so421503985a.3
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 06:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730816237; x=1731421037; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8msJYFmmT7Bwwpr/gUwUON79nyAFuwkww/7p0OvY8/I=;
 b=YBS3V6sKmJtDaPrI/zsrhTTs9NtFg9UJg1z09d/niuGVnZQBUSLXZw6f0bxIq5HKRv
 7wXn0QBuknRi//d4Wxckg+k98mbLrXNB98WAR2ZVSCPDVyCNQIExiwXYWNPLcSbFVlWx
 FisoBs071UsiSqxInO4Ddip+mocxGXuA26Fnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730816237; x=1731421037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8msJYFmmT7Bwwpr/gUwUON79nyAFuwkww/7p0OvY8/I=;
 b=uOGsQ+lMLjDBrFLATAtd0uruacE1iD2YksbBWDzfLxHkwb37KbJGqNjItyq/BTq89G
 0OaBzZnJ6Y4IGFaMM/kvURKdnZKD/qCOng/UAjm1MGX5uM67TtGeKTpqmX6YjZtTaHyg
 F5ZugCOMrcbjtQr18MRvd35dAi7wGT+1mfMvYoMb+Ab3ZEkiptffg+8qbBfWOVUtnKHX
 sbggbYZTU7aNlw/CR78x2RRHVRd0MAQDy2EKrD7wpkQG2kMMONNUkAhrvIAgIFSa3JP/
 2sGyMvFKs8QzaF+ofomZtkRVDPkWp0WK9s056lsCUFpcdFFGv9dF3OXmBjEaLOvOBmQZ
 XgBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ5DXEucTvKSLEXMKM79c4M2uY2NP2x2vVd2lurAb0QUY64SBzbCgKMii2ejfAtC+58wV4XcM=@lists.denx.de
X-Gm-Message-State: AOJu0YwNGwkBC6EzGlYgeCxHn0JyUG6ZYT1+PV7i2TBtKCsFu/xLbHEX
 vGhtlyyEeH7DXUXb6t9Fyx7OkUm91PvD6gx3/G1ddTvFNW01MftX0QK2bFDPRag=
X-Google-Smtp-Source: AGHT+IEXrt8ImDp4DVyAhDKQS+4jwFFwV4GkhJy7OkSE3BJ5k4MdvbZuqRHn6iF75+JSwrrdSyAPRw==
X-Received: by 2002:a05:620a:468a:b0:7b1:53c5:8f42 with SMTP id
 af79cd13be357-7b2fb979256mr2346306585a.15.1730816237500; 
 Tue, 05 Nov 2024 06:17:17 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a81530sm520914385a.103.2024.11.05.06.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 06:17:16 -0800 (PST)
Date: Tue, 5 Nov 2024 08:17:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v12 00/13] net: tcp: improve tcp support in legacy stack
Message-ID: <20241105141712.GD3600562@bill-the-cat>
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
 <20241104233227.GA3600562@bill-the-cat>
 <CAFLszThXiK=EzrUStsOBiSQ_pe1-Vdwtg-238BjQd91SMBym7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xzpmkw54OeGn9b4F"
Content-Disposition: inline
In-Reply-To: <CAFLszThXiK=EzrUStsOBiSQ_pe1-Vdwtg-238BjQd91SMBym7A@mail.gmail.com>
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


--xzpmkw54OeGn9b4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 06:03:44AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 4 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 28, 2024 at 05:31:30PM +0300, Mikhail Kshevetskiy wrote:
> >
> > > Legacy TCP stack is bad. Here are some of the known issues:
> > >  * tcp packet from other connection can break a current one
> > >  * tcp send sequence always starts from zero
> > >  * bad tcp options processing
> > >  * strange assumptions on packet size for selective acknowledge
> > >  * tcp interface assumes one of the two scenarios:
> > >      - data downloading from remote host to a board
> > >      - request-response exchange with a small packets
> > >    so it's not possible to upload large amount of data from the
> > >    board to remote host.
> > >  * wget test generate bad tcp stream, test should fail but it passes =
instead
> > >
> > > This series of patches fixes all of the above issues.
> >
> > I know Peter asked on the last one, but I want to ask as well. With lwIP
> > merged, why do we want to add features to the old stack? I can see
> > fixing issues, but not adding new functionality as well. Thanks.
> >
>=20
> Let's apply this. It has tests and the old stack is still used by a
> lot of boards. At present lwip is only used on one. There is more work
> to do on the new stack, including finishing off the sandbox
> implementation.

Yes, I'm fine with the fixes, but I'm not sure why we want to add
new features to the old stack.

We've had exactly zero releases with lwIP included, so counting the
number of boards with it enabled is not helpful. I'm sure that once I
merge the https support series a whole lot of platforms will switch
because that's needed for easier SystemReady IR certification.

--=20
Tom

--xzpmkw54OeGn9b4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcqKOQACgkQFHw5/5Y0
tyxa4AwAhRSdgCcWDl59jw/ANr8oQSPr49EC7khBudQk9bMOqXMHdPjKRp1md3a8
3W4zjOzu5NSsXJml1ApA27LIZRTyizuLCaKIS9VQ4xzRD7EMsG+XHAcgFnrfFmdb
vxno8Y40Wol8Lc6V0pfW/1dP12MRtVnlQulDEByT/HMKKjxYNAkTa+r1vTNk2Iop
2bppdsAc/KlcubbNi32RVvY8v2KgfGCFGGg9I+T4rbGejvD+FPD3kD/aIe043s+8
DMIvN+2cC+0g7s82putd0/oaerYtcnA4MVCuYQ1mreNrufDGwkXkr1xMPW1NDITN
14BMt8oXnusi8ZGSv/yKt/TQu4idiDX4JK7hqB4TewHjFeQhhPAUHihvoXJ1JLh2
k09dxjvOYQGqdzTONPdcW4k4/64klUIxvgex2wwh/n0v5HoR5oBTXYry2TpPRP1v
p26rMRVFZu9udium9eKBhYIsZEzAlzMPN/miFYRg4xEEKJ4zvSHvQdUXaorJ9Tls
ObJtwzRX
=2QWq
-----END PGP SIGNATURE-----

--xzpmkw54OeGn9b4F--
