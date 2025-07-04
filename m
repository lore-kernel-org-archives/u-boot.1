Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F0CC83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 20:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 805DA82A76;
	Fri,  4 Jul 2025 22:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hsx/FY7q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FCBC82AF6; Fri,  4 Jul 2025 22:51:22 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BE6582063
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 22:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-60f24b478e3so733850eaf.3
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 13:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751662279; x=1752267079; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8fm0N57B1sGhL4ZdL4Fo0uf98eWuSGpAQ1zozOQIw/o=;
 b=hsx/FY7qecLTEQLqFtKt5ZILbzHIGpcvL1559z3exI4tXtStAQfSORjPlCY1D3Yw3s
 ncuV1xpROgmW1o1k7ZLfuFcX2LN41nfGKMcV9uSK8DXAjfOYVXwWm/oOC9XVnY+Zlzrn
 bSEVYnOdsrRWjBRfFiicCQLbTIRg8lj9VaPcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751662279; x=1752267079;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8fm0N57B1sGhL4ZdL4Fo0uf98eWuSGpAQ1zozOQIw/o=;
 b=TJuC9N6MvWhC/8EHnaZE7MSihIe5HyHQv9IKrBGJp3PLavgqLWdoygwXmFTO48nx+F
 E4oPYsQhSzvcaNCh39tQRG9PpTi0SteMm66+vlolU/6HlhH7Shl6v4SZpMIm8fK+J/bm
 mK1HiRZayJZfiqe6OVbUEQU0QzMAMz0857FDSe55BR4o9S/75lX7Xvig+msxqDkhaouK
 kaw+9hFwTLnA1aycBnZlfL1e6Nwh+vBhoRi3TQM9tRBCSKrXWW/VYV8fRn1CG8V5oOGl
 98NNqWLr4quYDWJ0eC21Pcdz22XY7Hq2yF7ZNCvbf2k1masC2BBeA+zHFts3Cr5Oa66Y
 +PWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpVow/CoY9TFFTqToNzEbN02uwrmAqVUQwblpBsmsnMp+n4Y14QyRlWjrmfxo9GFqdVj44s48=@lists.denx.de
X-Gm-Message-State: AOJu0Ywkhu6d+bTuaGNa/Pn3wr6+G3qth4H3FtpxsGSZz4Wq/OV2gJ9u
 aT5b9Vr4pg1fAKjv1xYfUpmmO6slO2pPAHVn03VUbS17mFm8g1cjS7i0BEhH8d7YRJAtjpZ67/0
 3IIeX3n0=
X-Gm-Gg: ASbGncs8DquqdWt8/PFVoRKyb9uxxWgsTpCEvhfI9mHa3g7OyUlV2pLfsjK4Emv7fwd
 sfJkLft7+eklodOpkn0mM7ArdjxzPTE9gXpeq3iBMtycAVYN7vDN9DHKEIXsn2uvMCxOyUUH8wT
 MjD3Fb0HBYM0ciuFxumd/8EmDpdd9scMVWv5OCIe4Y/nY8c+JzZBvgpUmQ8J2zh7sw25v95uYjx
 lC38Wd7oRYZYBZP8CS2xPJmzig2NIeur6aM9bMC+1zBJMN/Eq4/sEwolndGcvFNe4vSgvD26R7E
 nkAu4toirtXJk0M1sFwyxYfQiGu/SG04Z4hdKOsWOT3ZVShekGkAg06htpqltTwXwHs2ZcMTNa1
 1yGk15mYgzrVMMRH/qyzh
X-Google-Smtp-Source: AGHT+IHL/uoN3AyJp3ZJNXtySOc+tvhrXLbskhXNmUWL99UN4e0OAwpryRPy6JcUTVpKYRRr47YZDQ==
X-Received: by 2002:a05:6820:6acf:b0:611:e00a:598d with SMTP id
 006d021491bc7-61392c2c5a8mr2392399eaf.8.1751662279166; 
 Fri, 04 Jul 2025 13:51:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5c3cf1sm429957eaf.39.2025.07.04.13.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 13:51:18 -0700 (PDT)
Date: Fri, 4 Jul 2025 14:51:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Julius Lehmann <lehmanju@devpi.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Smatch reports for drivers/scsi/scsi.c
Message-ID: <20250704205116.GK6424@bill-the-cat>
References: <047489d8-c453-4eb2-8a10-ef736da556b9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Bn1SdI5hmsx3g8DP"
Content-Disposition: inline
In-Reply-To: <047489d8-c453-4eb2-8a10-ef736da556b9@linaro.org>
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


--Bn1SdI5hmsx3g8DP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 02, 2025 at 02:45:48PM +0100, Andrew Goodbody wrote:
> Hi,
>=20
> Smatch reports the following for drivers/scsi/scsi.c
>=20
> drivers/scsi/scsi.c:165 scsi_setup_erase_ext() warn: right shifting more
> than type allows 16 vs 24
> drivers/scsi/scsi.c:166 scsi_setup_erase_ext() warn: right shifting more
> than type allows 16 vs 16
>=20
> I just wanted some ideas on the best way to resolve this. There are
> differing patterns even within this file about how the number of blocks
> parameter should be handled in calls to static functions. In all cases the
> value starts as a lbaint_t which can be a long or a 64 bit type.
>=20
> 1) in scsi_read there are calls to scsi_setup_read_ext whose third parame=
ter
> is an unsigned short. The lbaint_t variable is assigned to an unsigned sh=
ort
> (smallblks), which will simply truncate the value, before smallblks is
> passed as the 3rd parameter to scsi_setup_read_ext.
> In scsi_setup_read_ext the third parameter (blocks) is split into 2 bytes=
=2E A
> third byte is set to 0 and I am guessing that if appropriate this could h=
ave
> taken a higher order byte if that had made sense.
>=20
> 2) scsi_write is similar to scsi_read
>=20
> 3) scsi_erase calls scsi_setup_erase_ext with lbaint_t as the third
> parameter. scsi_setup_erase_ext takes unsigned short so there is an impli=
cit
> truncation here. Here is where Smatch complains as this unsigned short is
> shifted 16 or 24 bits to the right, both of which exceed the size of this
> type.
>=20
> So possible fixes are to make all three functions consistent and take an
> lbaint_t as the third parameter. Or to make scsi_setup_erase_ext like the
> other two and just hard code those bytes with excessive shifts to be 0. C=
an
> probably remove the use of the smallblks variable at the same time.

I suspect the best functional answer would be to use lbaint_t all around
and cleanup/make sure we're good when SYS_64BIT_LBA is enabled.

--=20
Tom

--Bn1SdI5hmsx3g8DP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhoPsAACgkQFHw5/5Y0
tyytZwv+O2EEIqly5ilbDoindW1BOhllpbxyql1AEIRCWdqndiU/gVofCc7TWPgI
7YzLOq6KYqPMfF7hd0HqF7lVlG2C1neyJjSKri3KOMj9ferLPdEnFbz2zsqb8n3r
toFJe1Ni9gttYC8S5lqd15vkUwD8DKqmFqVJ9AOIQPgNKJtvacko1mWNNmI0U0as
R1mhVI3nz2xQV1jtl9vGJshc7Mxkagp1q8QIQ+9XbdOM9JkV2YaQ57BS05P+f+Gf
D367J+nXUDlcuhUqe3Q737/f5qxxpoC8Z2cAJ8t1gFaqf6HI8m+zN7Y5zvlGFndf
RVMlGMgd3xH0utUKI97ANYlgXrXxDB2SoCy2SwgOgBfy4Q7u7OjO6d1xtGxqwsW0
guxJ1bu6S7X2FPN6l34mcaQUQZHQ6V6BF8/7XVGZmjG4zS5LsaxyCo4Hzy3qi2Wz
cI/9ReQpGy8kWLgHc4SeMLU3Bl1Szukw3bDOGR6K0JQtvMlTOfeudKDnSIyM1QO9
+4LbD+RX
=fxvJ
-----END PGP SIGNATURE-----

--Bn1SdI5hmsx3g8DP--
