Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D61C3063A
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 15:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D00686B18;
	Thu, 17 Aug 2023 17:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iE383J+7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC8D486B18; Thu, 17 Aug 2023 17:10:29 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3B2D86989
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-58419517920so82586957b3.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 08:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692285025; x=1692889825;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bHTMUNHQchhkn2fSRsDe9BQyvyKt05uIwdgvEFIOF10=;
 b=iE383J+77u9pX6c5P9FIH1ptIlXloD6GFzUBpCMIXSK2bAZ9ytv5oOO0hTW2VsOoLu
 9eJCPs75Dcpgzj7ZIhzimTrxOBlQDXYOkW9Ez4EjHzUUPWdAILVD4BE9RWHVLO4pxDml
 rYfHheHej/8hnKLRPwTVDNqfBgAlhKKj5tc6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692285025; x=1692889825;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHTMUNHQchhkn2fSRsDe9BQyvyKt05uIwdgvEFIOF10=;
 b=Ti7XNja+/x+8pEo0iX+Ggwln29ckXiSFEQQBewHnt9aGS3T9kVtG0+0yPkcAxTBP4T
 O++BtJ+CAnZ8tmfsn4kJVQ1ITLGn08fyYkVgl5XocvSQUmcGbfZwuV+kz2cVLNqgRBr0
 ezOlR/UoBYpzS7ncWOnHm6LBjk3QtGKsRihPXJMH8DSZbwPuAel+FcWYxJrcbuG9iwMb
 eOQIH9UvTecQN0gF6rBYKQiuB4EHBctm8blvMEI/UsZR0bBLc0FMBKuz/mlayXwnFcKH
 9kzdHyB8LixVXDDugZCTqq1avBf86e997RW481rpb0nM9dfLpj865Avp2DY58XV2w7jm
 Q72w==
X-Gm-Message-State: AOJu0YzczKPVWjTA1Mj/nVM637YFlAzFW4zDbnPmEBgQSCSGF0hr3cCW
 VKJbLBz70nqLiQhN3L6n/7EC/g==
X-Google-Smtp-Source: AGHT+IGk5nncxkauP4i1dryTwZIdocmspNhJ7a1XCXvm2nvbTcvPBBuF7yrR3j+yfZFy6NdoF8Zv0Q==
X-Received: by 2002:a81:830f:0:b0:589:db22:bfd6 with SMTP id
 t15-20020a81830f000000b00589db22bfd6mr5155107ywf.40.1692285025726; 
 Thu, 17 Aug 2023 08:10:25 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a0dfa06000000b005732b228a83sm4609339ywf.140.2023.08.17.08.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 08:10:25 -0700 (PDT)
Date: Thu, 17 Aug 2023 11:10:23 -0400
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v2 2/6] scripts/Makefile.lib: Add dtsi include files as
 deps for building DTB
Message-ID: <20230817151023.GE1515023@bill-the-cat>
References: <20230817054856.2019253-1-sughosh.ganu@linaro.org>
 <20230817054856.2019253-3-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="baoQGS5FKPs4luT9"
Content-Disposition: inline
In-Reply-To: <20230817054856.2019253-3-sughosh.ganu@linaro.org>
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


--baoQGS5FKPs4luT9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 11:18:52AM +0530, Sughosh Ganu wrote:

> At the time of building the DTB, some dtsi files can be selected for
> inclusion. Have these dtsi files as dependencies for the DTB
> target. This also ensures generation or updating the dtsi files if
> need be.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--baoQGS5FKPs4luT9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTeOF8ACgkQFHw5/5Y0
tyxLdAv8C2v+1uRr+Ndt0MOPE97TBR31sMoVeo/rVTED5oA893z+Er/OuUpzupkw
NtY/NKRnueb/6hsNHmtE5rnzZGZxP2Ar5IPlQQAJ/txh0qdY1OAi/4SrXDrMvLMU
O35LFqZ55+sHKtt6Bxs43d/zAJPYWmFFQRGTKatWlZiSiSbLEPZeNwiX28ra/RC+
WR3VmIg6XqMZyVipv5nHfy4gywF2Fk21aQpSSL5rqbkDfJb8R8fmJtWsb4aaUzZv
ldODI2aqw65Bpm+QiAKxDAxpFSlqTVTYy5sajUcxoZKppkxW2VyvXR74Ow8dwSkV
F2gWwXuAsDgojZPq5MIHss8B294oTqIDKGypEsEDjQtA5YvHxfSgd2fuRtdYAi2C
uIiiufDnnCUrB88LA21KQ9xMrWeyTx3vnikV/fBmaLC2dgFZpn1RKbmk1oHDOUVe
DrAx2junefclL8FiG3zn2T8eILcyDREEOSost5CMmC3IAu7cC19cNTT8k3av4aJn
VAvd1Ogm
=zETm
-----END PGP SIGNATURE-----

--baoQGS5FKPs4luT9--
