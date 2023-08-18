Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D902EE498B
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 17:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4866686F5A;
	Fri, 18 Aug 2023 19:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rjG/RWmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D6D686EFF; Fri, 18 Aug 2023 19:49:51 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3A7A8082A
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 19:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-58fa51a0d97so2320857b3.3
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 10:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692380987; x=1692985787;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pYHVFMMezMY07RArJmG/zes0ft6ctcHRJrWzui9XUKg=;
 b=rjG/RWmEhTjn1tbDq3g8Zy13v5xb1ao8wo/bK7aiNkbuBJpGKS3lgxaExqsjTBONnF
 BCowR2b5J8NWpiCRT7XcH/iA0+10UcYmEUF1R02sI9rFSCS2sYZLrHxYlJqbvx6HCWv7
 dAMMJVIFukz1rCe5AFpVxyZPjq5f85nIvoNqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692380987; x=1692985787;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYHVFMMezMY07RArJmG/zes0ft6ctcHRJrWzui9XUKg=;
 b=k0c5Ae6RETDNdwCgR3ylEXuradnC9J6KCunpzeF/8qpXy6KM7boMY5nf32GcXrDpFL
 GzxGqD3Vt/ADgVmJ4GDHlHPf2atddItdRtNZvtQ38RDAe9B0koC2tkX71UEyDenJFnPg
 MOk7NrVg7qQDd17jwn7IY2yt66hiWfEfQflN6XPFqHJ574rgKZOJF7WCqDzy8MpR7xi/
 hQR4g01BzzSSccSd42J1nPrQe3e5f05Ta1/PfK8SJazPLSx8SH/H2YYMoqJlz756Lg9j
 ZH0assqNtaOyUBeg0DcMd7hzdzkngMPeMzHHFaNfP/MulkcBAGDNjyJf6beun33ItfeM
 hTnQ==
X-Gm-Message-State: AOJu0YzMonogUlicylK5AiHMrgtpMJVk/IQAqlN6kqt6xnc+oAtiQ4xF
 bJohxurePrNbiw96Q/SotFwtAQ==
X-Google-Smtp-Source: AGHT+IHdjw8wqg3u2GFnTZI4fbTcj/+U6yYG+M0vavbb4OZDpgFnNe9Tfs+yYbFE0PvHai1oRcCQZQ==
X-Received: by 2002:a0d:cd04:0:b0:585:fb08:157a with SMTP id
 p4-20020a0dcd04000000b00585fb08157amr3287377ywd.50.1692380987560; 
 Fri, 18 Aug 2023 10:49:47 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-38f7-b1b8-9b5e-5709.res6.spectrum.com.
 [2603:6081:7b00:6400:38f7:b1b8:9b5e:5709])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a0dff04000000b0058bcea54fc2sm632571ywf.57.2023.08.18.10.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:49:47 -0700 (PDT)
Date: Fri, 18 Aug 2023 13:49:45 -0400
From: Tom Rini <trini@konsulko.com>
To: Frank Wunderlich <linux@fw-web.de>
Cc: u-boot@lists.denx.de, Frank Wunderlich <frank-w@public-files.de>,
 Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH] arm: dts: mediatek: convert gmac link mode to 2500base-x
 for r3
Message-ID: <20230818174945.GF1515023@bill-the-cat>
References: <20230803165258.14744-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="heLgaJeS4vnpU82t"
Content-Disposition: inline
In-Reply-To: <20230803165258.14744-1-linux@fw-web.de>
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


--heLgaJeS4vnpU82t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 06:52:58PM +0200, Frank Wunderlich wrote:

> From: Frank Wunderlich <frank-w@public-files.de>
>=20
> Ethernet on Bananapi-r3 is broken after
>=20
> commit bd70f3cea353 ("net: mediatek: add support for SGMII 1Gbps auto-neg=
otiation mode")
>=20
> because changes from this commit were not applied to bpi-r3 devicetree to=
o:
>=20
> commit aef54ea16cac ("arm: dts: medaitek: convert gmac link mode to 2500b=
ase-x")
>=20
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Weijie Gao <weijie.gao@mediatek.com>

Applied to u-boot/next, thanks!

--=20
Tom

--heLgaJeS4vnpU82t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTfrzkACgkQFHw5/5Y0
tyxq+gv+P/3Esa7zR1E36QBdbvgHsclP8DlVmJ/Zhtq/FiDQJOVCwhjQ1zhgtpyj
S6smvDrY7wSmjt/awUJTVj6k+mLwZnrFFq1c+Z3rRz26s5R4fBBjpHUKjm7wwW+t
fdinMeBOu8MsPDZiTCuFIBC0k5+tu0ElgZfWLp7AVzftKgULSP5z8fQY8Zt8Eh9S
rgaioMaOZ3+GmvVBJ01fFQD9nY7tlt9L2y7/SejxNqFNVZZpbMguixrEtWpzoiOS
L/JRN0+ytfMhloSNodvEwjXvdhdwrZNIVJNjs9OzYqyhatFh/ERPawwlFxOUEZJt
IcrvhaQ2pZW1B2NNgL2eMAbEgSSvak2llHKTSChR4bKH72j8EYhFkIRj8OtPK1Up
/Nbq4JVep7xzhAE3cMjD9OQxxx+57fGSdCyz8oavp6+e51ahxmwn3J1UIa/tyqF/
NrGxJwmpRfwxrv31qbwuo6DCdtbIwpjgdMz45yiKOqJbaj73b2B8xPlvioZPHnTU
m+U1sQBz
=WZgm
-----END PGP SIGNATURE-----

--heLgaJeS4vnpU82t--
