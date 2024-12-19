Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702E8E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 01:36:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD64A8021D;
	Thu, 19 Dec 2024 02:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YnZWb/M6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3BCE8022B; Thu, 19 Dec 2024 02:36:28 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24A618021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 02:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4679eacf2c5so1876721cf.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 17:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734572185; x=1735176985; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iYXX1aU++L3RamMeLB3DoEnfKvbhayeksF985wr+TEk=;
 b=YnZWb/M60wgGEdu9dsCVkouTkf63iKEGmAkwvVpsWgg662DbCxt7FHbKSvUKwkLSLT
 m3keblRdAmDMm+3NxHEqZsp9Ay1J97td2s9rU95i8SXhRHCogkUyzaWNhcUHIppyCsxV
 8HZ6sHJyO/lbnarz05qGgWgQE/PLBMmxMMSgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734572185; x=1735176985;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iYXX1aU++L3RamMeLB3DoEnfKvbhayeksF985wr+TEk=;
 b=K2sd3YlSY3a5RmdgBLWQcAyu821jHr4ULHtO9/QDMGAyudENK8tTiAe7XY+5XibR4c
 7Fn4on5UyhCNjMrAS3w4bYfD8wFqWXEz2bv7O/68/EPtQggeDKVo7da7VfLRvKcJo+th
 oB22MJBN6aF8Y2lsiKr2zTka7emV4gPWG5xRfmfrK1VyWNWJ4bd4Gq7lpzgVEGbeQDFj
 AT96QbfAYNegtDP9CmrtOhTEO9AaWhIAidDujN++wVG59F1PSytNsCJOaACso/lrkF2b
 mZRQVRFUoSekFCSV1LgT37siJQJ2WR8RrRd9OL1TzJ70Be1IMADyDNt4V8LpM+H7GApt
 Kg/A==
X-Gm-Message-State: AOJu0YwX8Ex9fBWwbmcRakdzE517pkh7UBtnmzqp1k3WIX2nohjqol4I
 +4R7q3HbvdC/DAfjohAgFaqrWYiMK6T4iZT4+LbJOEGIVsPiDzp0pMZA8hFyeCN+CH1GQD8quZi
 o
X-Gm-Gg: ASbGncvnbAFMjrCLtWHLKvYcM5y1dMd6qHYj4FKRhM5KpgkWTtsUKibQsANu6uSjnKL
 +9JyVK4ijw/d6h6VxHYKKiKD9MLT3UszwvXOgVSolUMNBOHVbxHyYT5J0Ri3e3OdobrV1r2DSsq
 bSJxAdRutzsIpoeYHfaP3bdeNHEl1KBkunXVRd9BiLpHu/pgeDed/7T53lg0nF9C0v745iqcmo9
 4oOExn+EqB/K+D4tKA2dKAAHBPzBbfc553wLHQD3/f2n0aesvInm8o6
X-Google-Smtp-Source: AGHT+IEWJSBj20lF4VC3ADtX4zghFgWscmU0X/eAtdeVlU6h3K7/Fa5plX9YWk9zbtk/pkRB0Sn2Ww==
X-Received: by 2002:a05:6214:c45:b0:6d8:d5f6:8c52 with SMTP id
 6a1803df08f44-6dd0923c788mr93966526d6.38.1734572185047; 
 Wed, 18 Dec 2024 17:36:25 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d244fsm1627266d6.98.2024.12.18.17.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 17:36:24 -0800 (PST)
Date: Wed, 18 Dec 2024 19:36:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Weijie Gao =?utf-8?B?KOmrmOaDn+adsCk=?= <Weijie.Gao@mediatek.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Subject: Re: [PATCH 02/10] arm: dts: mt7629: fix sgmii clock selection for
 ethernet
Message-ID: <20241219013621.GQ1505244@bill-the-cat>
References: <cover.1734406967.git.weijie.gao@mediatek.com>
 <0c13bda7a1809c7bc6a6782b4f942670a9ff10d1.1734406968.git.weijie.gao@mediatek.com>
 <20241217155514.GO1505244@bill-the-cat>
 <736f5ee9cf318dfb787caa7eb9ebd649dddd3e56.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9XrTXEqLggvXl4N9"
Content-Disposition: inline
In-Reply-To: <736f5ee9cf318dfb787caa7eb9ebd649dddd3e56.camel@mediatek.com>
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


--9XrTXEqLggvXl4N9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 01:05:56AM +0000, Weijie Gao (=E9=AB=98=E6=83=9F=E6=
=9D=B0) wrote:
> On Tue, 2024-12-17 at 09:55 -0600, Tom Rini wrote:
> > On Tue, Dec 17, 2024 at 04:39:20PM +0800, Weijie Gao wrote:
> >=20
> > > Setup correct parent of clock CLK_TOP_SGMII_REF_1_SEL to allow
> > > sgmiisys1 work correctly.
> > >=20
> > > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > > ---
> > >  arch/arm/dts/mt7629.dtsi | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > What is the plan for switching to OF_UPSTREAM? Thanks!
> >=20
>=20
> As this patch series is for mth_eth driver, we'll send another patch
> to switch to OF_UPSTREAM later (it's not ready yet)

Good to know it's being worked on, thanks!

--=20
Tom

--9XrTXEqLggvXl4N9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdjeI8ACgkQFHw5/5Y0
tyw1tgv+NQS3Soc6II1Q8ywrLqPUhQIxGxHb6XzfyRbl1z9ZijquWqY8hRjnSI/f
jGJ6AkKW+4zInp093NNMTcVNtAEiBlovE3YFOVmQdsVyNxA9vwTRpGXpECFPA9bP
2xuONTcFf7Ec1104Z7eDZPuwFyr/3Me2AoAJffSdxi0TLmqAvQEG3NmNPNuIoTB6
fyS5JyupDC0IjlDiLplyemQ1nxAs9Vc4aRSsaUClhxBiyMoYjCE3xYVxXrGktY+2
aYpm29M5QOHHdDwgCMHBkO6YG2F0hNuSyc4bZrMAP+htXG3lTwDP02xr4GkKHXrk
IZk8zGOOubbrq0eMOjwpdEfvZ9dQ/juJjZuRRRevoSVAt84At7WDEBXIFlxN0InF
+6WGuyS0/NnCKZzEd7qAYwuahiWiV2IsZalIkE5Q4/kon+uw2BE6OfvTYIUlhaDa
yjeiyKw/Cc/YUkiaxR0OzHcTH6/8/QpFDCIQTPUAa9TE0y7GJSUQ2uf4iXUDiQV8
US+aeBd6
=v43f
-----END PGP SIGNATURE-----

--9XrTXEqLggvXl4N9--
