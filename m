Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2166C54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 12:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21F3887D83;
	Wed, 20 Mar 2024 13:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rR0rkFle";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 659BC87D83; Wed, 20 Mar 2024 13:41:42 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0747087D7F
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 13:41:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-609fb19ae76so71333627b3.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 05:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710938499; x=1711543299; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qk9pg89g8v+VEtYsMuSmLo3f6+SQXUkxVkmOB65RT/E=;
 b=rR0rkFleEUk2lg/PR6IsXQ1e7VYyx02dlVX+jtZSe/HVBiPV+0zsnr2yljy9o32mjI
 Y+Hxh12PpHFtO6JnvhjEhX0ysUQ8vUAWrJqQJSywCg4onTGnWXWEtXXxf2VN0fMBbb7H
 DnXcHpBptSDqYZ4Qqb6Q601iA/mSrduiyAlE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710938499; x=1711543299;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qk9pg89g8v+VEtYsMuSmLo3f6+SQXUkxVkmOB65RT/E=;
 b=ftlBq+M9NEU0mnkgZyCfLy4RRdpwJRFyKygsk02kBZpQhBvMU4vsznarNIIBcqZl5v
 bxocxYb9eiVB/FrRcZtMhTZQrn9ysQKW8/jDQ4leKrCbjN3uDRtmtRWB2pUfBWPSLjYD
 EIoZgG1viau0Nfb65f2gkCoUmKJdxeMJKYoOaCnyBTf7pVnFjaB+b27gPf7K91Y6Vmfm
 4R2DczeTu+1duRmDW4p21o2gsHxZ+IgnrYf47sSyp7Ho0apLPnc8i10qb+1E0Hxb55S/
 0pAlQ5g6cpBb0TxcxQnCQYqSrTGEj2G4TdJXQOofsDIALSxqI099cjfPp8OHnwLDzwPP
 zYPg==
X-Gm-Message-State: AOJu0YxpF/XGH03zEXvHqa2346SSIOLi9VwtiLrc4JOp8jci3yqTr9NX
 KSmRLffN5teycuskfdeEEVd31Ac955dYhwrlWXI8FHV5odx5iVO6Hu1Ubvk04aQ=
X-Google-Smtp-Source: AGHT+IHEIEpggsN6aCZGmSrnrKQNBiHhQRxfDGIbSCd8u8p4R0nHtMorKtBDKf2kkkUnsLl4RKuMdA==
X-Received: by 2002:a81:d801:0:b0:610:1a19:14fa with SMTP id
 d1-20020a81d801000000b006101a1914famr12716680ywj.50.1710938498896; 
 Wed, 20 Mar 2024 05:41:38 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 et13-20020a05690c2e0d00b00609f45c6b89sm2740299ywb.88.2024.03.20.05.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 05:41:38 -0700 (PDT)
Date: Wed, 20 Mar 2024 08:41:36 -0400
From: Tom Rini <trini@konsulko.com>
To: Aniket Limaye <a-limaye@ti.com>
Cc: u-boot@lists.denx.de, u-kumar1@ti.com, vaishnav.a@ti.com, a-nandan@ti.com
Subject: Re: [PATCH 1/4] configs: j7200_evm_*_defconfig: Enable OSPI configs
Message-ID: <20240320124136.GM3442575@bill-the-cat>
References: <20240306063749.1411176-1-a-limaye@ti.com>
 <20240306063749.1411176-2-a-limaye@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YmTbFotLtZzR4IGI"
Content-Disposition: inline
In-Reply-To: <20240306063749.1411176-2-a-limaye@ti.com>
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


--YmTbFotLtZzR4IGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 12:07:46PM +0530, Aniket Limaye wrote:

> Add the necessary configs required for OSPI functionality.
> Also update the ospi flash partition offsets as per the devicetree.
>=20
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> Reviewed-by: Udit Kumar <u-kumar1@ti.com>

For the series, applied to u-boot/next, thanks!

--=20
Tom

--YmTbFotLtZzR4IGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX62YAACgkQFHw5/5Y0
tyz1Fgv/TJeOqOqN3DQgQWAIYKrTZQoN/tTCYdvlWyGGSsBljm99TNcdXzyu16VD
urUJqh0iX5FZCUL1V6lkfKhiAbAEtafLBUDLaYYIsp3k0Nplj6utKzP65b/spY5O
ukrFnrUn8LFp1QHgF3MILGged3lVlL+iNXCKIJghlWA6/xdBtEGwrFzjE65NmDWQ
rFo/vh9AoE4PnuEC/gHvfdmHxcdQQGhqnoiIO1FEnAcQhntiN07Laj7CVVDM9t6q
7Igz4qVrejpmdUr+XjEpS2djL3NfaqKXFi51o3u/6UpKlU6AZ5CGGpEGP/8KW30m
Ljz9skrDJOAiBvgdMKpQY7IuHIX4tkpa/XZZIIB4EdC+Zzzs9/PzQ2bjDkYR5py2
XkWijo0VBZIUfyFm8ollolByx+okZPkMNTYaveL1dZNFSzIWy84cK/PBzHbRFYHX
aZEAJ7YInYYYc9VsBrw2B9VEBw1ptYETIf6gCGp9rkU1yfbejqfl95GIBqKMKECr
UuRuPi35
=q5Pl
-----END PGP SIGNATURE-----

--YmTbFotLtZzR4IGI--
