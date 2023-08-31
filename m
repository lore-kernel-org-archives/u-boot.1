Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44C5C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 16:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6B03866A0;
	Thu, 31 Aug 2023 18:26:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YCJaG8aB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4497866EC; Thu, 31 Aug 2023 18:26:55 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 388698666B
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-58fb8963617so12070857b3.3
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693499212; x=1694104012; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/+y31Ie65+ipzfBbkcDz+bNAh5k+WFtVxFCmLZMAeiU=;
 b=YCJaG8aBgGHF+5vHuI4Inqy65+OX8E3Rl7V1Hbsg09sGiVFSDQ+EVUAdmSQ0w1GWOd
 vJxWoqblCVCbwdC/iHNOdcb+1IIu5oTYxqu8YYX42b0YTJsPKnUpPk2xnWtx1FSgNmg5
 132+qxcwdOjRH2BhKbE7g17e88iZNwJkplZ58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693499212; x=1694104012;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/+y31Ie65+ipzfBbkcDz+bNAh5k+WFtVxFCmLZMAeiU=;
 b=C9jNCPwG0+m6cpys8F0WK8cFYAc3Aro//DU4jWamJ/I5u1eRLPmhzyitNqxKNkuz8F
 Rs4wLFQOIlAnC6knjSWMSoCFrq4F69EBErUl9A+6fMF0M6kYO/XNSHVIbR1s+NXwSQvQ
 0FcXOB4HIKu6rNJpCIHefab4RkQy53vKLBfyxtMpDKgy2JJiLWOqJ69DvC1xuNbFB2QZ
 cNnq6oFVQKllNAqHKt0fSCIDWAGCdeeosGDaB7tmKfPW/qBah2N8N7vdHXBL/IeCsr58
 W7mRMn20xhJq/66VlZzg1JReikLNnEAQBmkZzBDfzM6fDXYEEg1TV8JyNXzbDMbNgmKV
 7KPg==
X-Gm-Message-State: AOJu0YxV25FDsr1AQ75A83ZIghY0FeVFy3xvkUEp0Fxw3LX8T1eEC1mN
 DC2pSx6YgXdoWWhu8J4owGwAZg==
X-Google-Smtp-Source: AGHT+IH5MsXFgaVORk70FQ03edlJ+cRSCY+7mh/sN92EDebkWjke4aZ+lKfcWY4p1ekKywy6IyM+Jg==
X-Received: by 2002:a0d:d910:0:b0:583:f78c:994e with SMTP id
 b16-20020a0dd910000000b00583f78c994emr6122422ywe.42.1693499212022; 
 Thu, 31 Aug 2023 09:26:52 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 x185-20020a8187c2000000b00589f4021f84sm514270ywf.37.2023.08.31.09.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 09:26:51 -0700 (PDT)
Date: Thu, 31 Aug 2023 12:26:49 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 5/5] configs: sandbox: Enable NVMXIP QSPI driver
Message-ID: <20230831162649.GI3101304@bill-the-cat>
References: <20230823001821.266578-1-marek.vasut+renesas@mailbox.org>
 <20230823001821.266578-5-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lrE8dGhrpB+6l5F6"
Content-Disposition: inline
In-Reply-To: <20230823001821.266578-5-marek.vasut+renesas@mailbox.org>
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


--lrE8dGhrpB+6l5F6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 02:18:21AM +0200, Marek Vasut wrote:

> Enable NVMXIP QSPI driver on sandbox, since it is already enabled
> on sandbox64.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--lrE8dGhrpB+6l5F6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwv0kACgkQFHw5/5Y0
tyz8mgv9FPj1d5u5YeXaioe7jmd/TBNpgbj+UoFIYTLPOdWvrfk0i83dHesI/CF2
UHP4z+REcnBEDY697F3ujo79P8m/yMbqcvkle7uYAfE5epVFah3MHxhdizY9EZ6Y
4kziU2QFNsKBBmla2SzxoD3L8HUUVhQLb+hM7TTckfpcB0vgDLSyWlLkU8OckUNw
n7y1DRaO3JTxPy18HaNjrbdga34HnJzpUNVAzbuirmzSTczemJ/XUzTREgWy6Zcq
iYi6EFGT+vszD33BqoA5c3R90pWhmGXVZ5V5WkS6bYlZU5Q+ifPk8mp3+ajWI9Rx
Iw7IVdX7NAsMm7KMqM/Lwv9uEqK8dOi7F4OI+XGsQeWkER7Soa6didZoDwsFQ4fJ
Prpoq4N0gmGazAqyl9uaTdqS2/uKlaCS/NJ2hDkRP2g21UXjZS/JXWb5mYDXxZWy
ox8NfAzCYidNofaIuQJWpN4xP/bvVWENprsGPhqVEYN/2xsrcnq5MAFtCiNYKNFt
plgsycjN
=BT6+
-----END PGP SIGNATURE-----

--lrE8dGhrpB+6l5F6--
