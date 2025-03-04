Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BD5C282D2
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 16:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9242A805C3;
	Tue,  4 Mar 2025 17:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i56zCadg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62828807D9; Tue,  4 Mar 2025 17:53:31 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AF3D801CF
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 17:53:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6fd719f9e0dso21946277b3.1
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 08:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741107208; x=1741712008; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CY1qU4V7dHNCiDzxSOSjgUDFumYNiwJ5qCCdh/Eip8E=;
 b=i56zCadgXGD6dwk3Tn8GaX68rHgjv5sRpVx47AT55S3Yhk3/w1csHSpccLclToY41C
 oLnhByQMo9eNB9LcJNoZTRcvJxCWVP6Z7i0KTQiibLrUsHyNg3cXxSMbj/cY/E/nFVXX
 DKgmB2tED8FuB7obF6pUNRdXqJ2hNFyC2jwMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741107208; x=1741712008;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CY1qU4V7dHNCiDzxSOSjgUDFumYNiwJ5qCCdh/Eip8E=;
 b=MA4IkMRam9N5ZOKIvgWrS9E8Si+VsR7RxhD3WRDzpF8BjOLyQ6UTav7iIGDEn3uOxp
 p6n56m/YMtAa15wlPvJyL/o7W4EdNyHr2uZOSz0SeTr7dXZ+6ueNUqiZLLiPqjh655n1
 6c/ZFgQUJhui6N8X+rMrE5IDdtbzZPlzn0MEXLfYsESin1oz2a9N5JZzZ16Ev01waAqA
 JNZ8V51oNZDRME26GpqUiVh0/m6a3TPuKiAyWfiRvmb42++xNCIibZppz3SFBEd9A3ZS
 y2zwRL4uIffRoMzO6RshFMN6cBwoQtXmE6WIDb3kv87NlBXESv7cEAV7Jp336LttP7Pk
 7iog==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoKvd0OMNQBIvuTfyT4uGvTwbEk5zsNHw5IYaigdxbZlSwee2uPQBuKAfrfD3JsU/gmK2vOBk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxz0vRQDK3lhmUznLoJaq9GvJ1E78Kg5M7iIb7qFfqX5/y2Ax6N
 dbHaC9UsqlmDLtpURNHotSEDMwiMxGcBE5qrf3Zq1/vzzMOJpExU/uayDDmvxuY=
X-Gm-Gg: ASbGncv4C6t9L3RYxb0gKs8R08KegfAF9XP3PptOBbBWO8FHJVHW1SWJJtda7Ib9qI9
 nH+f4+QSJA3MMXWykbqVQlOUQUJwKxesWBLa04mblOlXX1/Sxu0h0Hx1Zl310d5sUMXO57Ba+bs
 C7JeAMe0yBCl3SCA9otmqpT2SXgHJR8kL08/UzRGH9vpRIvuJBH/mZy8gB2gcLbJt7l5xJ2SXBk
 61vub416gpztDmlHL197/f6Q/6b+LyIpG6DkITKa+0OEekd3YyWDQWSW0rz2OtdLZWxm3SBCkg0
 oV5KSjtd0lRdDwxHfldPUJT0JoXkJLucI2rZUzWfsPk=
X-Google-Smtp-Source: AGHT+IFPwHWt9fjEaN0hDvglQ6OBXP/LuxN1N84n+4gO4KzrjdjdRrj35sDa1a9cS5BlrXqG1Zrc2w==
X-Received: by 2002:a05:690c:6d01:b0:6fb:9088:8895 with SMTP id
 00721157ae682-6fda2f176f2mr49797b3.4.1741107208062; 
 Tue, 04 Mar 2025 08:53:28 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3ca0f49esm25221447b3.2.2025.03.04.08.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 08:53:27 -0800 (PST)
Date: Tue, 4 Mar 2025 10:53:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: nd@arm.com, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] vepxress64: disable CRC32 by default to prevent aborts
Message-ID: <20250304165325.GD2640854@bill-the-cat>
References: <20250304165204.53097-1-harrison.mutai@arm.com>
 <20250304165204.53097-2-harrison.mutai@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rl1gEzoKhtLouxo/"
Content-Disposition: inline
In-Reply-To: <20250304165204.53097-2-harrison.mutai@arm.com>
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


--rl1gEzoKhtLouxo/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 04:52:01PM +0000, Harrison Mutai wrote:

> On fast models, the CRC32 feature is disabled by default. When enabled
> in U-Boot, it leads to synchronous aborts due to unrecognized
> instructions. This change ensures CRC32 is disabled by default to
> maintain compatibility.
>=20
> Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--rl1gEzoKhtLouxo/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfHL/0ACgkQFHw5/5Y0
tyzS3gv9FGB2BvZ1Aifgkbdb/ySwwX5D7ZTSlZ9O5M4Hn13oHKAjo2z/K5n1vt5O
F1pZfl6hECGwboSXBDZGtF90+n6eOLEfB1a8fTMdkUIRqnjsYEB1p/jbZoqZb9a7
RB6qdkf758xqiXU0Bul65Nidb8Oro4XuaqFHmPgQTHr7GT2URQhsFhkZOSOzbhEi
kydYr1QqrIUE4sohSbv8C36dJOsOQwg/7mYdVSmG56zjaihRfI3MZOcBuGLcjh2Y
xQ2kzuzLcFUZQS4ByGn/ObJSRiOfnpM4+WGeYix8bUAOwWJ58EWhYKR+kIkmWBvc
PNpcrb3cMi8KCtR27JFyQ56bwlsUxfzt+ytqsG3jkh2n+qBnLsveMRcipZd1k3AA
ogSXkosnGy1ItFN6njW/GQphn7tQj1yMpGaOtnA84pPv8+a8LQnsZArtDG722uen
08JNSYfCEMU/2MEBaiNK36EwpQcrFgjUXlzU+nHCrPynCEmi2dqfGTDad7QcMCqd
wCKH7sny
=pZkj
-----END PGP SIGNATURE-----

--rl1gEzoKhtLouxo/--
