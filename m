Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446C1C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 14:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA7AD81E0F;
	Fri, 14 Mar 2025 15:54:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SZNIVnmf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CBB781E25; Fri, 14 Mar 2025 15:54:31 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6130C81E0F
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:54:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6e8f7019422so20224466d6.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 07:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741964068; x=1742568868; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IVaWTz46gajKyJyqfTuUZtt2/KboNQ/Mp4ZOEpyQ8fQ=;
 b=SZNIVnmfZ++UurmU/B9kmX/i36ka7Dbn4qsGBlMMVKekhbBrAoxrl2YCkSSPUiIKsr
 lSXapvKRiTpF0LSVONKDw3vo34Pk7TLchShMVuyUQ9t8rl4qa7kuRWyXTjxd70d/fssw
 5TIwuUJdPVmvs+dAjpCnDldsmBSaQgMgbJ5HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741964068; x=1742568868;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IVaWTz46gajKyJyqfTuUZtt2/KboNQ/Mp4ZOEpyQ8fQ=;
 b=m0iO+t5KKeNjbkMWFzs6wsk3Do+q0XXETcm2PDfQeeJht1wxYODkcgPmXyI/cpD/zE
 pULpS67IzXGN205iu6k2w8Wb2XxJbyyBn5gCyh1UMApyEmefFXKJINpUDqQDUncbdeDF
 JApdT3XDQ4EtMIl2ryZwpVFVWUwjbik53zpdyBSJJlfyzWoGoRSK+VUElDMsuu47XMVx
 hcq1JRvTAulCHxveccZbXxv3UZp0UFlQAqeQ50RwbRqBIqysJ4Ufu3a43XlS/y/3d+TN
 KIFf6sRa8vaAOekQdGEvO4lzb4jnuX28SCbh3aApdJenQScYhwgHP9JApq91z9CMxayY
 il1w==
X-Gm-Message-State: AOJu0YzCGMhdvolY5PSkpLa17Y/x9mGMKMUUUitHnngeCDOnl8n4F1CR
 OO1nwEdzKbNvB6hBDL1pip4Z64ytIglOWJ1sCbej4nkWnHfBtAwIFLkOsxsDB7s=
X-Gm-Gg: ASbGncsnhyNm0Mr/uCwGDjZGWylbcrQHC5xL9hjhnYHkuN3mRWy+9q+nUdGcy9Cgf2A
 9LEN7blGK9C+q5Manvab8vt/Jr8zLG+a3ek5rRpS9YSyEVLcyiY/whu7Ht4UsDoQaZwN80CfSS/
 fRZGu7V3HyqEBjG5Q4xKj939/WHOd3HQe7uufkVcxNRP/8GMglv71IbPIwKaQnyqSva9lmKNMka
 gQV010+3I044rbEvd7+LflqiAI1laDjPi/iIt0+IqoBO3vflW0cxac8VDP/SqP0PgmtDkmvvzxP
 tcrWSDNxbesE+nAThNFq0zdLAcN48jxPr4K7ET2iSyowtA==
X-Google-Smtp-Source: AGHT+IFrQzBWPhA6PWEanGRvyNg86tTpBURdDAq0JagHlqBVEbv0C9gHYNS9Sn1mTJgAs2gIvXKxEg==
X-Received: by 2002:a05:6214:76a:b0:6e8:ef80:bcbc with SMTP id
 6a1803df08f44-6eaea9ed769mr35805646d6.5.1741964068321; 
 Fri, 14 Mar 2025 07:54:28 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade330dfasm24688246d6.76.2025.03.14.07.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 07:54:27 -0700 (PDT)
Date: Fri, 14 Mar 2025 08:54:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH v5] spl: remove usage of CMD_BOOT[IZ] from image parsing
Message-ID: <20250314145425.GQ2640854@bill-the-cat>
References: <20250314035505.4029331-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="toDrO1wqbcDW96F8"
Content-Disposition: inline
In-Reply-To: <20250314035505.4029331-1-anshuld@ti.com>
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


--toDrO1wqbcDW96F8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 09:25:04AM +0530, Anshul Dalal wrote:

> Using CMD_* configs from spl doesn't make logical sense. Therefore this
> patch replaces the checks for CMD_BOOT[IZ] with newly added configs
> SPL_HAS_BOOT[IZ].
>=20
> SPL_HAS_BOOTZ is enabled by default for 32-bit ARM systems and
> SPL_HAS_BOOTI is enabled by default for 64-bit ARM and RISCV. This
> ensures configs relying on CMD_BOOT[IZ] in falcon boot still work.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--toDrO1wqbcDW96F8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUQyAACgkQFHw5/5Y0
tyxshgv+PkAh3qhd+AwJnO/rXl4frmVB2Rmf/mk8nmARrnDo9MFzE9XULC7ezK+s
WhhCldefMy4nXlrHhYuj5zuFCNfnb852NVwXSys5wOtPt6KEIwiDHNvuHI8FlCNe
CR/eS11eQ371Oeh43nFmP8FwM9tOEj1jWDLkPEVC65dHfTrv8BQWJgy1pv+Ab3ho
wVABtjrkkWTkp3sN+j8AHk6uimsAlW7gpmp6rYshXHYEngjJii6MC5II9eClGLo1
ns3aPJgcqVuTjldy5FD420PBkYeIc7akPBtdmbmZG4Wpt8n10X63fOboLuSMXYVE
nXpTwGJqizGno1xJiYhJhtgTkz6MWeGJJL6fjjtHjiszt1PyK1c1zO31a7Ent40Z
XG0t45n0ODBGPZnn7g3mdvS61L3VjaMYfRw+Zi7SEXmi3f+C1/AaZPdbUtgYxZlt
eQZeEmmY8NX7Caf+kTqJ1nNxpux2w5tEEpJazfnLegV0mQz2xNwXmQaNzYCqtCoJ
vsna6axb
=VAtB
-----END PGP SIGNATURE-----

--toDrO1wqbcDW96F8--
