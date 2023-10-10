Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47D0CD80CA
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 12:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF651869D6;
	Tue, 10 Oct 2023 14:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o3oB16Ug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 758E586B29; Tue, 10 Oct 2023 14:58:18 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DC2C86591
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 14:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-59f6441215dso69006447b3.2
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 05:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696942695; x=1697547495; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Co3ZyEnu3yD++XwDdTFCFUZozrsDNUyat2WHIFrK9/E=;
 b=o3oB16Ugyno+coRcRC5BwZC+kAOf/g/QAE9lc9VgujWbcdjJ8clgq3enJD3ICTV4w3
 moSPR6qMtgrCohS6C2A4PH5wMbiuBLHjBasoGxcja4T5uaQKNM4QuN6fwJ6fzgu3RbOk
 dHYXlUrM8b285dzUbRG7BJecFfu7RbECK907k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942695; x=1697547495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Co3ZyEnu3yD++XwDdTFCFUZozrsDNUyat2WHIFrK9/E=;
 b=rFzxL2Flt15sqbuZYrsSSeydyQ23dx0O25k0ku8eRJCUtQfFrc/YYdiBcndiOeZkWp
 XqIvrPUz3cjqqzxdaXSJrxdEMM6BatmAKjkWaaqgzKEr1XndI8wCrSwG/IioZjYTSY4d
 T6M79wQ6QMj8NEA8dz6CVbyAWcZFaJBMglAUmuqBmEhiegK5Lf+E6MEM4VJLgOHUzd/4
 xF1Lxsb4azVA6hSF3gWhSe0NLh6kU+1ld0c1HXFRnwZrd5fbpEFMCes1teyJ0AGFUBIx
 3Qn0z8JZe/QAL7XS/DJrfkUHmvOv6JH2gcOcwoe+aXDz5KcKTYrKM6bNPTlC6haG5g/b
 zZhA==
X-Gm-Message-State: AOJu0YyDJShCB6XLlM75z8H7Ss+nyJttXyj+azgHfQXpbUZCiIPk7tvk
 ewT9IlJNNPIJ2bvwpViR0PtPaNdeuktJTIDXz5iRJQ==
X-Google-Smtp-Source: AGHT+IEG1BVaHwN22IQcvtY02G4SBcbLxnMIr9f1GbBIlP6bxl7scFDRm/fUDfVY6I7wjqPpHzZZwA==
X-Received: by 2002:a81:a0d0:0:b0:5a7:c4a7:21c3 with SMTP id
 x199-20020a81a0d0000000b005a7c4a721c3mr1268196ywg.38.1696942694975; 
 Tue, 10 Oct 2023 05:58:14 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6c43-4eba-c113-e8cd.res6.spectrum.com.
 [2603:6081:7b00:6400:6c43:4eba:c113:e8cd])
 by smtp.gmail.com with ESMTPSA id
 u84-20020a816057000000b00583803487ccsm4398710ywb.122.2023.10.10.05.58.13
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 05:58:13 -0700 (PDT)
Date: Tue, 10 Oct 2023 08:58:12 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] Makefile: Allow for board directories to not have a
 Makefile
Message-ID: <20231010125812.GX2227687@bill-the-cat>
References: <20230921233248.159047-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="x5ZFEx4NowrkcnuP"
Content-Disposition: inline
In-Reply-To: <20230921233248.159047-1-trini@konsulko.com>
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


--x5ZFEx4NowrkcnuP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 07:32:46PM -0400, Tom Rini wrote:

> It is entirely possible at this point to have platforms in U-Boot that
> do not have board-specific C code (just Kconfig or environment) and so
> make it optional to have to descend in to and then build in the board
> directory.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--x5ZFEx4NowrkcnuP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlSmMACgkQFHw5/5Y0
tyx89wwAgu05DfbAS9uihbi+A37fGS5ZaqtyfQIKJtzh0t9TV63OMiSFHLefRxsv
VKRtG1/CWp8uMI0KbPtU72EXDbeyu8I4W+bc6L82CCyg+9+GVQYXOdPwhvRPnsIS
/bYbUxMrBgNMCivUpeCYT6EI+d3l4Uhae3jYzVVs9W+F7cubgudLtDxe9dkBIx9h
E+WrD9eqHgrcmkLVGwGWJ5MM+btZPX2j64cP3lNqijy0GXCI480pHrv3hpwnk17r
FLWZmiWvPYqJYn2DHvTrW+2TbCcXUWectERTajap3Av2bHwML+wD0cxa43HkdAmO
Z7p3gtXMv0IaDm63qJ5OrpFmSvsFihPNxCaXqWrzr2qYLH9bTkAyVPNJU5YcfBsy
m+rp/pV7oVBGkPwD+YcU0h+p1De8oLHOq+F3/j+ltdhSFegM/sP7s/ydpvNVmGis
mAxFlYEYzjgdA+BERjENV0bWbSQ5eg41XxNTemp2Otsd60qM55BEPqQ+ezB0A2OF
o6GDTk68
=Kd8R
-----END PGP SIGNATURE-----

--x5ZFEx4NowrkcnuP--
