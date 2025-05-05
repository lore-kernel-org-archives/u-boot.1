Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA51C3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 20:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 913218210D;
	Mon,  5 May 2025 22:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l6XCCN1y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8244F82163; Mon,  5 May 2025 22:20:18 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58AB68210A
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 22:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-60638c07cabso2622968eaf.3
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 13:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746476415; x=1747081215; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CU38Ee5Gr0o4EJW1sdL4gIrWWugvvnl6tNodY4zaCO0=;
 b=l6XCCN1yKr5uhH94l5rLuVLN2VtUVUwr0huNwtF5w0MVeZbFJZ7gNeWEpLbwF2/o0x
 RmoqQ8aetiqgndU7ZhDGbCsAPVl2Mb9aTqmB7xWElepeyuUiI3ugaN1K/xfFY8dKi4vl
 gFtN0jj6t4aqa8t8m9m0ySQn2qHjMnbJc8UmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476415; x=1747081215;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CU38Ee5Gr0o4EJW1sdL4gIrWWugvvnl6tNodY4zaCO0=;
 b=ixdfC31CUJB7NBlBJ9mxx3L71IUEBUIk7BHF+H7cVSniihUY+5o7Si+DrTdOv0hUcj
 EOo9VKokWBf4hYXxkvYNwf4R+Vap5yDBeTlXNQYwIbdkZCFLCcoeJrgZg1Wr8Z2ELhVi
 KD5liMNhMqBxRaa1iTSS++EveztLcTpoO2xN9Tar+6RhTD8K7BQapbeAs7yS27BIoROQ
 xhjDx3pnfcZ/tKfZPXec53r4WinCeC4YSLog3BmzbjoV370uPY631Fd65DIbQCg+vIAS
 zNKWF29jKMKrtQ4U0KWuuneeBpijqkU2++YBOAf+LZOzpzlcn5suSRWiDZs/rouC5VBK
 MP8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW6pArCDMtXO1+qO0wTGeO7nAIQXoLuloCR/LKmxzvTvOOTKiDKADyU215aD6D2JI6acWMOS4=@lists.denx.de
X-Gm-Message-State: AOJu0YxataNt5mC+qB4bPeDBhOPkALjWRwzWEXgUBnamhG5PZ/J93Zz0
 iBBMW9FjH+3yuSFLzo26wEcBtJ/2h/gQbFsdi4Ux0l7hSBnjdjH3OuaAWBalKq0=
X-Gm-Gg: ASbGnctItYQXdS/8XzHIGU1y9Hsn03gHuvzIRGas8Nr/F0ZaORUVTswuLHsqyJe3H6H
 1hzIyFiceyoUBiqYVxDwgKHdEYPipGe9tIrLuLFP4/43W0jlSQDmocYF93qU6YALPFF0lXdw/MJ
 etbNg+N887tKoHxx5oSPmFFUB5HY3jyQyTHpn6OkEKIuifC/ebHrEAddfD5XxHlgMZpwxb852oZ
 uTlJfFHoVkvn0Ot+Xuidm7FbyPiji+wlddNRRqEZiMOiN2xBciw3s4PRAHmHDxZi4ggd+FXi+4i
 xaIMupnNDCaL4VopfXpwnHksrw8i4m3ngDqLn7x6u3OtoxedJmcGaoTzOGN86dl1g3NfGimoIzU
 NKA==
X-Google-Smtp-Source: AGHT+IFBDkBvvx85Y3ddEm7SFa30P8/tjK4Q5+uwtsBSnrQrdXi9cX7/mprPfBXznL9QHtzY/6gNTw==
X-Received: by 2002:a05:6870:f21a:b0:29d:c85f:bc8c with SMTP id
 586e51a60fabf-2dab3400f1fmr8831523fac.36.1746476415124; 
 Mon, 05 May 2025 13:20:15 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d34d8c28sm1692279a34.43.2025.05.05.13.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:20:14 -0700 (PDT)
Date: Mon, 5 May 2025 14:20:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: Wadim Egorov <w.egorov@phytec.de>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Garrett Giordano <ggiordano@phytec.com>, Apurva Nandan <a-nandan@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] arm: dts: k3: require mandatory firmware in binman
Message-ID: <20250505202012.GA51730@bill-the-cat>
References: <20250429-non-optional-v1-1-b4cad3bc7789@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sQ1YjgBm4qxM875B"
Content-Disposition: inline
In-Reply-To: <20250429-non-optional-v1-1-b4cad3bc7789@ti.com>
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


--sQ1YjgBm4qxM875B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 03:01:56PM -0500, Bryan Brattlof wrote:

> TI's Foundational Security (TIFS), Device Management (DM) and Device
> Management and Security Control (DMSC) firmware are required for a
> successful boot. Remove the 'optional' flag so binman will emit an error
> if these firmware components are not found
>=20
> Signed-off-by: Bryan Brattlof <bb@ti.com>

Can you please rebase this to master? Thanks.

--=20
Tom

--sQ1YjgBm4qxM875B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgZHXwACgkQFHw5/5Y0
tyy2OQv/QZe5jgWJGOktJ+cR693njnEqeFEZBtRndojjLKNu40Xch3sYusADTy4C
+REClXm7ZXe1bteEWaigtYxsiiBmbgsHgPt5Ge9E2gvv9MHoJfnifHq6UZg/rsrA
O3P4+5WHtS4jSeMqPInZsYH+rdjxLrGvuvAOhKNgn6AJAnL7tbJlr2PDKmLYN0bm
awBroEfLhQXQtM+bMEnwiDf8rnBxqtmscT9DnmfNPZ1Msd3e5zZrlkAmTm8PwVi4
NCMKpX0KPNawPh1LQRpMbr23vP/aJyvn3B81LPJQyepm4+qd2GptqghgjcldQMem
4JgPyVVr8hDo6oNqFmlpPV2g8epPOyq5d4H5PVGUbrEpXrIFsMgoBJCQvazH6g3Z
InhzFypNRBRH7qIQbA0eyqVYdz8gkS4DaH8wnT43MTHFDf8HQSJpk/iKE+7H3utv
yRXkwXyiTipS9Y8NzIja1ewMROC3n3TNjj6t/+wET127Cp2jPthHr/UmUb7X7hwJ
UWE5Sdhy
=4BOB
-----END PGP SIGNATURE-----

--sQ1YjgBm4qxM875B--
