Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAD0E784B7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 14:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 057C58718A;
	Mon,  2 Oct 2023 16:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rQklRQbR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D283870DE; Mon,  2 Oct 2023 16:48:39 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D83B18714B
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 16:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-59bebd5bdadso201823787b3.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 07:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696258114; x=1696862914; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H09Dy0dvmI1QnTyOvqYeYm9+3U8UJFa8Xnjlo/8BztM=;
 b=rQklRQbRhDlWzF8oomepyHkC2ZdCKdhjhW1L6tEe5JVqwv3KFCHY5y473hYf5xHJNd
 xaZPY74uGunn4pyYvbPnhg2Sl4kPOV/xArOP8qBziG3IapecGWB6BBCS32AAuFsLndIk
 /Tnu3exE8kRQ2JZ7Aqzt2S3Vv+EKmNNmdRtuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696258114; x=1696862914;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H09Dy0dvmI1QnTyOvqYeYm9+3U8UJFa8Xnjlo/8BztM=;
 b=qo7PI2BdRU3XJBO6SGBifMpOw4n4U6J5iwcSPN/K+AYuhVupc6o9n5IaIjA2WTtBTw
 laTveBXh2COSbLNb/t28XxgzUbTUAfEgffcqiDtRi0fBugUQ+/eXJ4W/hpihqRDYTGqk
 CjdYcHzt/X/Lw4QjBVtgb7QJeqfpC0lLpOAuD8Vj584WHsGaQ5enOZ+gcKDv2cu+ZSHF
 KfmNYVMn/Uf/8nJ3MZJbuYjP0YQZ94rRKfZjhfnLPxB4JwFgJF6zrZYKt2hlAiF3Cez7
 uo4paQ4JCpbaTMaroKtvYnlpAWb5Lp/UcS1bEZ2xZLTHRWWRkB2ybzn1WJ5fdTKg0mzM
 2Y6g==
X-Gm-Message-State: AOJu0YxH5wQFlCuTkyFs+35Aif7fs+B4tnECV+MUaEFp5nWP1cexIXKb
 sCSREO0ohJk0snMPXYYxSE3hZWGiYhzIbEDJb7Fn8A==
X-Google-Smtp-Source: AGHT+IH/1Hw7rlgyvbAl2fWt/lI8CT7+N4kC0bNyaXS85c+lmgVFLS+1qX7OCzCk/vn+mU97Ronynw==
X-Received: by 2002:a81:8309:0:b0:56d:9e2:7d9e with SMTP id
 t9-20020a818309000000b0056d09e27d9emr13523474ywf.21.1696258114460; 
 Mon, 02 Oct 2023 07:48:34 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92a5-a961-a832-88f6.res6.spectrum.com.
 [2603:6081:7b00:6400:92a5:a961:a832:88f6])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a0df802000000b00582b239674esm7807208ywf.129.2023.10.02.07.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 07:48:34 -0700 (PDT)
Date: Mon, 2 Oct 2023 10:48:32 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2023.10 released
Message-ID: <20231002144832.GX305624@bill-the-cat>
References: <20231002144116.GV305624@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KKryJxXNn6ABYA2d"
Content-Disposition: inline
In-Reply-To: <20231002144116.GV305624@bill-the-cat>
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


--KKryJxXNn6ABYA2d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 10:41:16AM -0400, Tom Rini wrote:

> Hey all,
>=20
> It's release day and here's v2023.10.  Once again I want to thank
> everyone that's contributed to this release, not just in terms of code,
> but documentation, testing and otherwise ensuring things go as smoothly
> as they can.
>=20
> In terms of a changelog,=20
> git log --merges v2023.10-rc4..v2023.10
> contains what I've pulled since the last RC or:
> git log --merges v2023.07..v2023.01
> for changes since the last full release.  As always, more details in
> pull requests (or the tags referenced by them) will result in more
> details here.
>=20
> The merge window is formally open again, and I'll be merging in next
> shortly. v2024.01 is scheduled for January 8th, 2024 and the merge window
> will close and -rc1 will be released on the 23rd of October, and then the
> next window will open with -rc2, two weeks later.
>=20
> Thanks all!

=2E.. And yes, I included some bits there that shouldn't have been.
Please ignore.

--=20
Tom

--KKryJxXNn6ABYA2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUa2EAACgkQFHw5/5Y0
tyzWEgwAtWSQr9YzM3hq1zM7mfbIpGgLq45QoqytOFuIiWwh4zcW4W2rlPrDFoWI
iDhmJUYd7FbeGY3eBmYx1nmKq45kKTMASoiEr1tbsUFqrEbFmi+e7jG/aDzxJmtJ
2ltw7UwYxi6jLBsqV9QVSSdJ95LvDSLnbh8dNMWMeVIQawGGucBtaBcxndcBEgn7
FI26x2VOpSu+tL+D5CQJUiepLlbHkhqh4k1FeT0VR3MjtG+6wBudaVt6j1B4ppjq
ZYkpsJcSYowVjAhw3YKYPj5L2ZNl2UccdmsB3WBpRVkO2mxRp4LkUqSppI7HEgUp
dXX5PPo2p1+B9+UvspBGSSKPB3sqQXbi8IatDYITtkCSmUeNdlKhOeg+7mHrINL7
Zq/v4I4mvhhlxovFmHSIFJYRbzJJa4MgFGnVPMGLS1lkaCkpQJ2LSdIe7ocQZjro
MtIBnJ6k8knbXwEfUImy2B17v6owzmYiXToUwe/SIOBl5Uq5lsKrvPeZFISqqHzo
PV02r1Ey
=oy2i
-----END PGP SIGNATURE-----

--KKryJxXNn6ABYA2d--
