Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC13C47DB3
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 17:55:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A48787D74;
	Mon, 29 Jan 2024 18:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ll0E6tUG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5C2487D90; Mon, 29 Jan 2024 18:55:18 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C602887D8D
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 18:55:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6002317a427so24675927b3.2
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 09:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706550915; x=1707155715; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lYms/pZX3vhdMvNaezZNcviw5A2ghSADBzaY7c5AwFU=;
 b=Ll0E6tUGoKvbqTlXtoUg+oLBncrnIsBappRTNa0KdCNi/dhekF52ozuG1u78krcmBg
 zZ/NP2YgPUPbh6nexjtHgHdmq00cLzscG8ZrNOVNojWVTpjxixEW2cYQ56a7HCOo1FEX
 AF1DtxAYKenfSqn7iX+3+12lEgQwfwmf1usN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706550915; x=1707155715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYms/pZX3vhdMvNaezZNcviw5A2ghSADBzaY7c5AwFU=;
 b=SnR0iT6Mvwy+YdTu9De9hvBJZmT36mOzKDnlXvuiQhVoWUpEekzHTzONCxqaebW2ML
 WbSXypeccMV1ZXBgFir/jRWSdwf1zeaeUrhd4EedKqjVZyDS5kNEAl+Wlypuzent6DzU
 PHLNJJjQ2G0Vl1JrizULMBTyjoK/DFu9jhGYvF0pwKKVD3FMZ9NB2nO+C60WBANlldx7
 921Nc1tBnNE800vSrIS5S7wyBMQLQxWoJ/l8Yz9E+es/kYPJKiVLPSN+m02qgJXNfdu2
 iiqyoR1GX1uy1QlQKK4++e+wXeu5EkcQfeIMAYlHlW/vDNDb4j2UcGreMQEnTixpHtp5
 MHdg==
X-Gm-Message-State: AOJu0YwpVrpVu+Bd3q9NQZztZnrXA8i2JdzQA0B/UUxK7RQzh/zJLGkQ
 2G5UlkiaYEBhusa2diIslhr3wkyAXS203nf95oaB8XhD1f21GWLprfMSP9US8eHhCs344454pAO
 z
X-Google-Smtp-Source: AGHT+IFUaxoCdpZ3CCkEB9IOtYjTEwBwaHM68cL30ham8GGTEpldhXty7JmR/cG1548ns7tqquFgjg==
X-Received: by 2002:a0d:d40b:0:b0:5ff:5bac:a28a with SMTP id
 w11-20020a0dd40b000000b005ff5baca28amr4589741ywd.76.1706550915542; 
 Mon, 29 Jan 2024 09:55:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 d142-20020a0ddb94000000b005e7d8d6e446sm2632473ywe.93.2024.01.29.09.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 09:55:15 -0800 (PST)
Date: Mon, 29 Jan 2024 12:55:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] pytest: update requirements.txt
Message-ID: <20240129175513.GF1152441@bill-the-cat>
References: <20240102-pytest-requirements-update-v1-1-8840af19df70@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oUjUCsBzmmXEcHeO"
Content-Disposition: inline
In-Reply-To: <20240102-pytest-requirements-update-v1-1-8840af19df70@linaro.org>
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


--oUjUCsBzmmXEcHeO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2024 at 11:55:30AM +0000, Caleb Connolly wrote:

> Update pygit2 and py to their latest versions. Even in the venv pygit2
> still links against the system libgit2 library which is failing on
> latest Arch Linux.
>=20
> The py library also needs updating to fix a KeyNotFound exception during
> test initialisation.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--oUjUCsBzmmXEcHeO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW35oEACgkQFHw5/5Y0
tyySEAv/QNXiTqOgXdTb+SjvGbG+7pKuFq32RvIev2ddLEtNaEus4oCNIeQxcp1n
pOLKCWg1bzNYSvLpPk62Fzcwzb1ZlvZGAOSmdU3hGy8D9AbtvJFU2CTDGIA+yI+R
NK2gLmv8DpSRISxBq7TuiAWkdqSdM1CF1VB8AGE1U1l75J0kAj46Ca3jZkxFsEcx
OEJFUGC8zbgdYKKEkm78b2aNMB53ZJKXDaIFNbSTHhXM9+dX1bLjkjOwitb5q4GV
FQqZuom5zpIBQtNzFdZRD7vZF2lBHaKIjKSoTvFiUrP4NYu8Yp2n13a8Ye/+S557
rPh1n56LuHEo/ajtsyZgcRGBRMGd5r0aelj1u3vvok0FnKr9nUCy4LlY2VycyCu9
xmDHCme6su+3yar24H5AlI0gwjN9WMatbWAhTd2vGJMTpX3lKG/Dk/nJSHe2do/h
pYE9SiBFdyn8l+Ydbk9Ll4Hfw5t9xNtXWENhVjge66Vs9hyN8eAcmFDJLIRXK391
X17qgcb/
=Q6yE
-----END PGP SIGNATURE-----

--oUjUCsBzmmXEcHeO--
