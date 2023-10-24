Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128E7C25B48
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B58C087A06;
	Wed, 25 Oct 2023 01:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BJp9Mdkc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB469879F2; Wed, 25 Oct 2023 01:16:40 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43C45879B8
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6ce2d4567caso3389630a34.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189382; x=1698794182; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HurMC584s84zO9yREasU4BaaCy8ViL/XzFwJa9mdHqU=;
 b=BJp9MdkcoIe6CyX7V8vCg8jSqw79QbBAFLgPoKiZ8nC7/M5iXVHruaRhDyK+ygdavT
 ZS+CSyCtrOV3gXtxHnAAaMMEJ+rbk5RBFP8866w7Nw139xTt1A6mLh0kCB72rLLFi9+H
 z0hOiVK2W2ideWW1RyaOjHOo7JHGYxB8kHnac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189382; x=1698794182;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HurMC584s84zO9yREasU4BaaCy8ViL/XzFwJa9mdHqU=;
 b=ll7//xqX0qV+xzMAka3PPdUr1u1oMW8NKaD9P03lwVAJGHeEPUvbrBTCxxxPbdzxpB
 LXdeHHVAmf0BpwHSRu1Q/4lUR05euzmX6v9LPUxbVusvOqvbrQ6PYcuLAh/WtyEzqJk4
 OAEvVuIPACX4rXmwD1PoAmxDrjjcNoR3ou8GqEodD6+0OPrpQolvY2fFoZwN1sjtorpv
 9HQ2k84ocjoptEb566s/0MPGPJmGhnjWMwZTysPHjiP+vuaJscK6dN4t/Ho0quo43/q1
 qYE7v9qgqzloT7SDBPeAVZ398aXTAT33RJ3+WZLYiQ1AjPa/3CZo7RHTl8v7cNLl9GXa
 H4tg==
X-Gm-Message-State: AOJu0Yz+QPMx5SVwCRppYWmAeiWszrtCeNP3OYMEA6787dn7V1HsNE60
 fKImYCXMk+iYfA5CsaYXs1xQCw==
X-Google-Smtp-Source: AGHT+IHH6mSS3FmqDcFyC6yRDRnrClAJCvJF0gTZbNkY6qw5Ug1Oy8alIkaX5/k/a4wn+oujY3flCg==
X-Received: by 2002:a05:6830:2704:b0:6ce:2e78:e0ca with SMTP id
 j4-20020a056830270400b006ce2e78e0camr17905505otu.4.1698189382396; 
 Tue, 24 Oct 2023 16:16:22 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 o139-20020a0dcc91000000b00583e52232f1sm4517839ywd.112.2023.10.24.16.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:16:21 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:16:20 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Lars Feyaerts <lars@bitbiz.be>
Subject: Re: [PATCH v2 1/2] checkpatch.pl: Make common.h check boarder
Message-ID: <20231024231620.GV496310@bill-the-cat>
References: <20231013162836.1911982-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ydcqlf9lUqFlss4X"
Content-Disposition: inline
In-Reply-To: <20231013162836.1911982-1-sjg@chromium.org>
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


--ydcqlf9lUqFlss4X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 09:28:32AM -0700, Simon Glass wrote:

> From: Tom Rini <trini@konsulko.com>
>=20
> At this point in time we should not add common.h to any new files, so
> make checkpatch.pl complain.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--ydcqlf9lUqFlss4X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UEQACgkQFHw5/5Y0
tywBVgv+KQmVgcEIJq1TNTLpzBTpcijvViLt/YwljE/Tk//PBgT+mtoDLf5E/iM4
2x0RwmbjMfZr0VvGo5G2kJmH7AC19gxI4x1mMwq8JrGRk3C2n0eDTn4nBbS7QPbx
d5RZ/8j2Xy3eS1wS6NVbC5EvaBGXwn/YcAjCffkVew4qDnmuL1UrmyzYoDBvjy2J
SdCJABUBxWyp+OS177qSfW8V9qQZUcavGZFsakkliinqDgu0PqJRp9lg/Sp78s4V
DWvyVzcvOtMiZUEuWOT/gGmI2sDoiT/8ntaDOYz1kQt4WNjl1gLCSSqshK/BsiNs
cqSqU6PgPXGlpPyOairJkVGdwzynh3IXnRGpAreFw63LKw3SGA9hAJBEq1F07u99
G8CBH/RthPDUhskOgb9J8Vx/Tv4239ezbpWYhWS63yz2oFbv2SYxh0YlLdDFTVGR
hj9kFhJcqMAktqMWC6ml8lMXvev8D4Wy5JG1MvdIhbtZa36cS1vuhVOeaUXCY8hD
R/yUCcBj
=rayO
-----END PGP SIGNATURE-----

--ydcqlf9lUqFlss4X--
