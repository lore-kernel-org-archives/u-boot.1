Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15107CDB47F
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA40886E51;
	Wed, 11 Oct 2023 21:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fcoQFA4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF46586D0B; Wed, 11 Oct 2023 20:39:57 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CA8086DF7
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a7a7e9357eso2113727b3.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049485; x=1697654285; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1TzD0qRb6ksrz2hEQ+M9LhXZs0iykAFg4cPlVZLi6dg=;
 b=fcoQFA4AIQk31O0+5UzSXzF8t1UKL3Lsw/ZIiAtqNV8tX9JetKDlqBhOdZ5Lxio7Wx
 craBUuB3/5SB5Xxo3RuGgAOFXGNcNJeHAXbiT1Mr/g0mjvBNY9Q+9djQRbqkUBVn9OPv
 0ajllJ2OWuZaDdxr8+FrYMeSI/7vZ2++agZLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049485; x=1697654285;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1TzD0qRb6ksrz2hEQ+M9LhXZs0iykAFg4cPlVZLi6dg=;
 b=W+QUYWamjipFf8e2hj7iVlnVvZ809rwDCwPMVEfEjDyiSvamYQD61t2YMSBm8savgR
 gluWiPJc8LFIf7bRPP69Jk/p0C4UKZTCUsFamiP76dFThHgNFxNq5kknhE5yRMSeglqN
 CVgqhjXi/Feo7mzh0e5e0+I88M38f8HpZULKpGi8FXJjp5hpb2EefsDLxQKwN1ZXhaki
 GqskCAWnIZkRcpreijIeb73OiWhyuShYRPhtU5zu1Tltfeul0iaE0MfO2fhtDGpHHIG8
 /YLttIyVtdQeIkquejWn+LxX/aYLBfe9uTYbXwjU2L03dU353jJlI/wwrXoHPRrHZrpR
 Lnbw==
X-Gm-Message-State: AOJu0YzP1x3NQ3qYHiXCgn4XiNC4TlxXNhxhU9Ec2U1pPlh8nViqEvcv
 t0S9s0U4fK+IJMXJrp08XmiF2onQD4vfaaq2GmKECw==
X-Google-Smtp-Source: AGHT+IEHz4Z/XoW4RvTJzDn+36S836erwP+flrigKb96iQUbG0h6zV3pb6tI3Dcif9j3aUqv0EIimg==
X-Received: by 2002:a0d:cb49:0:b0:5a7:c97e:39e3 with SMTP id
 n70-20020a0dcb49000000b005a7c97e39e3mr5004932ywd.15.1697049485534; 
 Wed, 11 Oct 2023 11:38:05 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 eo15-20020a05690c2c0f00b005a7ba08b2acsm1575900ywb.0.2023.10.11.11.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:38:05 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:38:03 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Chanho Park <chanho61.park@samsung.com>,
 Leo <ycliang@andestech.com>, Nikita Shubin <n.shubin@yadro.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Rick Chen <rick@andestech.com>, Simon Glass <sjg@chromium.org>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: Re: [PATCH 2/2] event: Rename rest of EVENT_SPY to EVENT_SPY_FULL or
 EVENT_SPY*
Message-ID: <20231011183803.GB3119521@bill-the-cat>
References: <20230905134808.14744-1-marek.vasut+renesas@mailbox.org>
 <20230905134808.14744-2-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3uqX3L5mZ31RfEzS"
Content-Disposition: inline
In-Reply-To: <20230905134808.14744-2-marek.vasut+renesas@mailbox.org>
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


--3uqX3L5mZ31RfEzS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 03:48:08PM +0200, Marek Vasut wrote:

> Fix up remaining occurances of EVENT_SPY with no suffix.
>=20
> Fixes: 6c4cad7438 ("event: Rename EVENT_SPY to EVENT_SPY_FULL")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--3uqX3L5mZ31RfEzS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm64oACgkQFHw5/5Y0
tyylTQv/TRi23Wu2xE152VDJqTUqIRfjobpq2gKF57vLZAwXQp9JY+/o97LAUu7H
l9EhE/uKncfPRXUc7Yl9mgAVcVwGafoU/8r4uht/fdfQe5p2/5MZJeNj1pC4cMjZ
qAHahTl+7LzE2XO9on2XZJrm6GrHUM0zIyS2Dse2CghtDlmwbw1aGI9H2EGRYj5V
14vzPNT2UP82WQ0w+e6pU14DxolpY1zx1On4tOWc9yx0asFBB2Oj5F8A2F9fzwKy
eei9OjmbzA5i/QaAFsCF+R33FefZ15WRp3y3NnFT42BfjRWt8mjjXs65ytPQAzid
ekuAtMRJ+d7RRnke4s3HPDtOz7RBT/jQ9PJbgVu4Cb5KlNxqdh4gtZxCG/Zqux08
RiPwzDJ/hiF6nptMz89KZ+0QXnPa6XBGO7tII21REP7lrfLEnwKJaOkzwC/n+iBP
0Bc9WPCRCd5CU8wuUzM+sPHG9uHTl+1DGSe7pwl97N6RuyrUDis5uRvPib9nUklt
vCH7fdSG
=mPiO
-----END PGP SIGNATURE-----

--3uqX3L5mZ31RfEzS--
