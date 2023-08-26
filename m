Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B32C83F01
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 23:50:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77C1284003;
	Sun, 27 Aug 2023 01:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lmgbfxbp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B52EE833CF; Sun, 27 Aug 2023 01:49:56 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A1F282BBF
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 01:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-59234aaca15so24469847b3.3
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 16:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693093792; x=1693698592;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tMCLp1nJyjGwlegiLFXvJvNQef9PVfjIbc04WlimLhQ=;
 b=Lmgbfxbp33yZWByY0KQX650y+0Ovvh73YlSNbLRKNq8K7wuB0XuPGZuZfiB2T8ysRQ
 L/0khIZBjlbFxqn12WLAra7iTRy/ulvN/2sYFnUCpOQO9Ng/rNfz+vIOasWTSCYxPOvv
 ZyLIOQgIV3P7VGP78we8CJpr8xWQvE5HgyvKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693093792; x=1693698592;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMCLp1nJyjGwlegiLFXvJvNQef9PVfjIbc04WlimLhQ=;
 b=UPZsOwsOZDhNN+/9rmWzT1AQrWSnr+GPhTmkcPRPqglOaKj9Kh9c5a+Rk0ruQ6Hfhe
 bwm+YsyZD/jXcEkVDA5N2PI4mMFjaRkv7Qzm1yIcXagBHZtbgzCejD0RWPueM4iiv6tW
 y92raJNYtSnWS6BXGZf5OWt29pclodhPrt7k2pfx9Fl9OOAYA5DEY2DV0QaFYywP1UTx
 ioXWQKyTOldnSAoTupVGGNb55LbLALE4+o0+v0FlMcY5CRkx8z/trbNNAvKSRMLtLhfq
 tYtWmwHY2HPkMVWpSO/oSLjOoeSGB0hzxeMMDIlk80EEkRN+c7tAg2eIkSV4jdfkWKL0
 GhCA==
X-Gm-Message-State: AOJu0YwUlmWRQZX9dj42Wtt+3thh9VreU2/8URVfN9/QhpogyouN272q
 TzDxFUXg9pN+HXdIORsIyRoIXDy8aSPEo7S5IVf7Pw==
X-Google-Smtp-Source: AGHT+IGBf6SMrv19R5OSLZFsAHaQWw8YiXwgFfppFBZl+d1uVr7gKZiG2KQWT2n4Sfk1owmo7pgVMA==
X-Received: by 2002:a0d:d608:0:b0:584:61df:45e8 with SMTP id
 y8-20020a0dd608000000b0058461df45e8mr24020287ywd.13.1693093792684; 
 Sat, 26 Aug 2023 16:49:52 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-cf2b-5e4e-16cb-5c6a.res6.spectrum.com.
 [2603:6081:7b00:6400:cf2b:5e4e:16cb:5c6a])
 by smtp.gmail.com with ESMTPSA id
 t130-20020a0dea88000000b005839a780c29sm1307165ywe.102.2023.08.26.16.49.51
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Aug 2023 16:49:51 -0700 (PDT)
Date: Sat, 26 Aug 2023 19:49:50 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] CI: Update to gcc-13.2.0
Message-ID: <20230826234950.GV3953269@bill-the-cat>
References: <20230825172127.3406461-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ua4xbqnLeiuyaVzD"
Content-Disposition: inline
In-Reply-To: <20230825172127.3406461-1-trini@konsulko.com>
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


--Ua4xbqnLeiuyaVzD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 01:21:26PM -0400, Tom Rini wrote:

> The latest kernel.org toolchains for gcc are now 13.2.0, so upgrade to
> that.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--Ua4xbqnLeiuyaVzD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTqj54ACgkQFHw5/5Y0
tyxV7Av+JKSnTBNxJoEmMKXzFjXUef24X9WL64nSVAF9s09wvBSrR+aNu2dDWcpj
Xao11DBcWGPLbQCNAFCatOtd8Cmi2HaodZHx2cOjZQu1+pyJeyocTLMKyOJ+Ad/s
A/Xr1wjKvHoD2wjexVecvjjHybNhQrMz5lCwsCF0t6Y3FRVJ5I9ufROqXzi4YjV+
pBIhTPNtA2/97GjvBQhCSI2ouhITZrGT2LbwBT7rwDfwvPTbgxja+Sjt1oone7pH
5JzReAo33csuIX5IO0WIIu35Zba+i2+LGuYriWEKlaOwNCGqko/x3gi8JGYE0ZZ+
mD2ZNIGr/LH8w9xEXT7S6XhivIM34PQikn23TOcIbRx7zu6jQH1JdMEqUDUc58bS
HbUTPoFYEB2oiLzF31eiLdrxCeCs8gaZf5sCwAKlaCu3gpX2abmER+GXyV44AjD5
wVMTud7y+U5dDbbquzQj5/ohTeuu0y+Hujx5/VD+b7+Az2wiJcqLBwA2iFwfZOzn
UAk48v7q
=SpJB
-----END PGP SIGNATURE-----

--Ua4xbqnLeiuyaVzD--
