Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A8CC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BC838806A;
	Mon,  4 Mar 2024 16:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JUtYMoG3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C5068805D; Mon,  4 Mar 2024 16:28:28 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8522188059
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:28:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-69081dd82bbso995176d6.2
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566105; x=1710170905; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GxCYKgk0D6T4Or6kNc5dkeqopPKb5Gear6bx2craLrc=;
 b=JUtYMoG3wz61o2UczvVETFcP49R92m+ryx9H1rrm7y2+yAlYPFglPMoS36IjRUcZ5W
 9zcEtdRyfjymI5TuNFHRw6PvaJ4bDeecxKeonT7vhGs3b84KruPtEha1UNjxkfHY7w9R
 TZTDCEy3QzI3qjH2p8E4mqIeci0JZOoWIQYfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566105; x=1710170905;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GxCYKgk0D6T4Or6kNc5dkeqopPKb5Gear6bx2craLrc=;
 b=qj2Ani5Cs0uaT9OOegS16ftRKZvTlv9aCNUNF3duVtqz9QLEnQmrNzhcofS9iYR8dW
 p0CY38aodny5aOv2wV28JL5ey8xKCcjWCDuRYYY675cN45z459ScbtATLmgjZ1dEAIQB
 Y/7w9CJX3Wf3b6uaj+TxiCKRMWazpAklsc5BpotQdhjVM0JGAwMQO2O+utZqEo85qAg+
 Hcyac8T15/V19amoojjp+L/Ha+6zLYCdfcXxdpA0BTYkU9AlicE/+BmBnjw7Thrn3+sw
 mVqLHVRH4XPbPCD8d8ALLldCzbRUnfsgEBMMqCwiOUI2MleC59Cp5XkEPTGv/g4MfF7V
 Wbyg==
X-Gm-Message-State: AOJu0Yym6rgk3gvhRzQNiBr+ardw71aQYzzw2Bw8D+sr92GKT/Stm5cM
 Rs3+sUhMBRhVjKvTv0B+cLmEwfT1FZxf+o7mA2/wXCNg9DewYNBuoQHRz1yzqBxkRyJ08sXOwSR
 f
X-Google-Smtp-Source: AGHT+IHxqMxCYXrD3cFdK6EDf0dZTa7uwxkhD0l839oaxWDHHC01BgOHQ6DXbYciKzgHKhCRDNTdVQ==
X-Received: by 2002:a0c:eb42:0:b0:690:6b62:108b with SMTP id
 c2-20020a0ceb42000000b006906b62108bmr4243224qvq.12.1709566105342; 
 Mon, 04 Mar 2024 07:28:25 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 ld8-20020a056214418800b0068fef1264f6sm5142751qvb.101.2024.03.04.07.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:28:24 -0800 (PST)
Date: Mon, 4 Mar 2024 10:28:22 -0500
From: Tom Rini <trini@konsulko.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, martin@geanix.com,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH v2] scripts: dtc-version: Don't show error messages
Message-ID: <20240304152822.GB1523872@bill-the-cat>
References: <5ece6e37de9321ad1c2e089659cbd80355181c4a.1707217112.git.dsimic@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xOgwC6kls0290Gz/"
Content-Disposition: inline
In-Reply-To: <5ece6e37de9321ad1c2e089659cbd80355181c4a.1707217112.git.dsimic@manjaro.org>
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


--xOgwC6kls0290Gz/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 12:00:04PM +0100, Dragan Simic wrote:

> Prevent the error messages produced by which(1), such as the one quoted
> below, from being visible in the build outputs.
>=20
>     which: no dtc in (./scripts/dtc)
>=20
> This makes the build outputs look a tiny bit cleaner.
>=20
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Applied to u-boot/next, thanks!

--=20
Tom

--xOgwC6kls0290Gz/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6JYACgkQFHw5/5Y0
tyxGsAv/TmF3B51fkL2qwb/sobcYoHjLXPsECTS8qH2y7Q3Cxw3oTU0kS2wkshNp
SRtxEIojg2uk5G61B1zyKDkqZ/RkRFFk+PfvSw17E7cxmhlFfmxC82WsvCzYzFVb
IpvfZ28jMDvQYdBbYPULSlpYlBtnxrpPCzD3ilhYpOTXZ9PK9TYYSPaf4S/g3pNf
jXZ0/1kQCYLxAjy8qDyOayZyGVlmh0KlUu/PNdWh5fFz204/t81+PWRBT0rWmo4y
rWu5FPjTJFAwkBrTerG4VzoXuNzaEVfYg9zlpMz7+4/oooS6loiE/0nSUepIXWfC
+Bc4SGfXMl9Aezx5j0+WfFJ9rIRmlZaH0DFjcwi52CALMUFh6mnNU7j2deht0Tv/
iwv7eOsWwkfSrDiiDJx9gMfKaUc11L9R/x2BBcC38lcsuT2LtOLmwOrVb5y6fde/
mKyOjMKs+MFZbxcmIv/De6we8JfknancTJLOVayQg6SX1CZzRnP4UFUlPWKnZjGf
/ZhJLBEE
=w20u
-----END PGP SIGNATURE-----

--xOgwC6kls0290Gz/--
