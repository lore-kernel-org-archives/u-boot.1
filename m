Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E998C0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 20:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64BE786994;
	Tue, 15 Aug 2023 22:24:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BwKI3NtK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B5048671F; Tue, 15 Aug 2023 22:24:04 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFB388697B
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 22:24:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-58c5aecea4eso9803397b3.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 13:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692131040; x=1692735840;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FPYiBPPKc0zOAVmvcYxIo77WSg2T5Ik1mQ1TktQQFcg=;
 b=BwKI3NtKcVHoNgMH0rghKl/cVF1FBHkqenyOyItQ+/O5/uQ//SqXyhHUIPayyiN7/I
 LZzSBnNIdyf8FlGxO+HkHK9TpkuBW1rYPCcmqXN/csdA7aTnhXlKJ7InCl95Fh2GArkG
 h2gJl/WQKEEcxb2EDn7NWnuobuJ42wfaIPHVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692131040; x=1692735840;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FPYiBPPKc0zOAVmvcYxIo77WSg2T5Ik1mQ1TktQQFcg=;
 b=U6XCRI6qGb7Bw9AgsD2c3GZ4+Sp3eydr245Kac78isvLUMeDnUa+tkZvAWDXrpOlBe
 vlj+lFnoUsP080ZF2XtJQIiKu9qtWZmGoa3DGETaIDrDeqGJZefKnoNH8BU1oXqCI5zz
 /fl8ea07aVVKOzQhOBiDLJaRvB8/Nse2Pc2aZBGTLy6jRTKDy+8udo+qxtYvry8v1gCs
 EcYJwYSU9Z5l7WQWQ7Ve9ArJabNfBEpwGHchCsYahFBbuHCrChIV4v+clTczWKoJG9p8
 js433aVrE9UKR3Dz4U7/bXRNerfdJdVyn+GoYQ4S+ZxrpfftoxaKSc/HyBl2/Sho4FWf
 93Tw==
X-Gm-Message-State: AOJu0YzIcRoZNF3MoMGwmFMReQSqljDZI7TtfwZQkKAFQiHUWqr7yqjQ
 lRtZtFaLXfWZGrIGyg+heqXpng==
X-Google-Smtp-Source: AGHT+IF3MJcnWalsZicqPZNGz/JURORK8dk5bzzvsqMccfuBgloRQD64fcBfAa/M1xtGl768E79RCg==
X-Received: by 2002:a0d:d552:0:b0:583:307d:41bc with SMTP id
 x79-20020a0dd552000000b00583307d41bcmr14669695ywd.27.1692131040482; 
 Tue, 15 Aug 2023 13:24:00 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 x7-20020a814a07000000b0057085b18cddsm3626076ywa.54.2023.08.15.13.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 13:24:00 -0700 (PDT)
Date: Tue, 15 Aug 2023 16:23:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [PATCH 1/5] scripts/Makefile.lib: Collate all dtsi files for
 inclusion
Message-ID: <20230815202358.GC3630934@bill-the-cat>
References: <20230815162623.1824357-1-sughosh.ganu@linaro.org>
 <20230815162623.1824357-2-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h3WYMQms+wmiDWub"
Content-Disposition: inline
In-Reply-To: <20230815162623.1824357-2-sughosh.ganu@linaro.org>
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


--h3WYMQms+wmiDWub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 09:56:19PM +0530, Sughosh Ganu wrote:

> At the time of building a device-tree file, all the *u-boot.dtsi files
> are looked for, in a particular order, and the first file found is
> included. Then, the list of files specified in the
> CONFIG_DEVICE_TREE_INCLUDES symbol are included.
>=20
> Combine these files that are to be included into a variable, and then
> include all these files in one go.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--h3WYMQms+wmiDWub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTb3t4ACgkQFHw5/5Y0
tyxdzwv/Tii5dVjr2mCEV/9RElfggG8zr+S87CnqQ2FirKbWIMb5DkckCJiapoK/
rpazdKGAM3u25DE2rc/pMPZQR9GPMIOS/I0QOlaIMe8hXJA5eH30SKHrrTUA72zl
Vijr5/4F3zqAcW2zDSm4jsWZqPANohyYMHXWTU6aBVECZMvXdW8Bq/aWwuM+5ttJ
RPzW4ao068eOWJVIQ+FJ+fP/HegJbgvIoWMvwr0d+RG/xU2ALIfCKG2vTCvYgOsB
wadiRD3g1Z2zJ2Fbc8poZ8IKI7y70DtBJT81TmXzFrExWgXoFdIkoKusTQGAnFfo
EHRob1qpbm+dhI5sLOtN3wJu7LRyOhgeB0v0DfSk9scf30ohxuHpEqHOzmiIqSQe
uRoOebPNrCrqHAXG7gOjY3/6L8btXmIU5LufXOYWw0cC9q0ZejKUBQUQ9gMrGh15
Rvm9Oq4tyionIRVMnn8/B70am9Lp5/hbeDWMi3IFcBsjX3sPgjLWvGe8aRPmaJHU
lC2GZmWy
=dfjV
-----END PGP SIGNATURE-----

--h3WYMQms+wmiDWub--
