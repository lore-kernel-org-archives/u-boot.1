Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A7CE92706
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 14:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39A5186CF7;
	Thu,  5 Oct 2023 16:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hhYWUcmW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49FF386CB7; Thu,  5 Oct 2023 16:49:12 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C413E86CFE
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 16:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d8afe543712so1199397276.0
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 07:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696517348; x=1697122148; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KqCvGmJTWUjsD7bYG3OaYBBQn42gDoqEf2Z2rsjfZRc=;
 b=hhYWUcmWXebcYYtAcqb+O9d5H1+lsEJxjWjftQHHXUAqx5ACeFvRhYxnDdHcEHXk24
 DPITURieBdmInayylwKn2CSUgzxSEab/jOz170O5Yrs2SAEXRsQGb01+LlRbErhPH1L7
 2MHgOXsFQWzdIP9MITIevy3YPfOnUUb3fI9e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696517348; x=1697122148;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KqCvGmJTWUjsD7bYG3OaYBBQn42gDoqEf2Z2rsjfZRc=;
 b=SRs9uo/oiYMWM4SN4CTLQ/WpJpndTiLoUtYSKyRMKPPQYWuTTkjWka2FHOsSDHnuxx
 bYfiiTOvIkgintkDrvTPgq9BaVoC9767ztbxc5LgZU28Z9PyF97f6Q/6EwBs4NWw8/EN
 5kgyklBxyA2WoS1U7A4StcPTqVgBiRQr0TYfvOV3fOBv9qws6Evz1pVZDSpeFT5EQPjS
 rugrmXE1+OOAKn0AXxd56mhDIDlEnr/eU8ATIkF47TeZZPf6sGx2PJAe9sfipwzW7Xf0
 erLOH7a73OdOCPKZtTFCVqGZRH+N9+GoxFx2VD8Rdvukp6bqAHcf/v8ricehEF0yEfhr
 Nx1g==
X-Gm-Message-State: AOJu0Yy8ejn0CqV0GA27QYVRxtnhBY8FRZN4FxwxD/K0jw8lFLe47WYc
 Fn/kp5Lctp8/LgaPy7l5mq3OIw==
X-Google-Smtp-Source: AGHT+IGoRdFKjBvaCH4frmcxZzIrBjGrJx8M7CBc8nC6HveRxuNKdBrlRLjJkbmdvEfESUVSiF6PNw==
X-Received: by 2002:a25:d202:0:b0:d71:8e8c:5233 with SMTP id
 j2-20020a25d202000000b00d718e8c5233mr5507416ybg.12.1696517348477; 
 Thu, 05 Oct 2023 07:49:08 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-f1fa-53fc-3572-fce8.res6.spectrum.com.
 [2603:6081:7b00:6400:f1fa:53fc:3572:fce8])
 by smtp.gmail.com with ESMTPSA id
 6-20020a251806000000b00d800eb5ac2asm427615yby.65.2023.10.05.07.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 07:49:07 -0700 (PDT)
Date: Thu, 5 Oct 2023 10:49:06 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm
Message-ID: <20231005144906.GJ8465@bill-the-cat>
References: <CAPnjgZ0V5_UsZOPPX_sjNECHTzC-pgFqMsfuNWP0-kEe5dZxRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i2acLTeY8iSv6bEu"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0V5_UsZOPPX_sjNECHTzC-pgFqMsfuNWP0-kEe5dZxRw@mail.gmail.com>
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


--i2acLTeY8iSv6bEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 12:00:32PM -0600, Simon Glass wrote:

> Hi Tom,
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/18014
> (usual azure branch but I cannot get the link)
>=20
> The following changes since commit 65b9b3462bec2966911658836983819ab4e482=
3e:
>=20
>   Merge branch 'next_pinctrl_sync' of
> https://source.denx.de/u-boot/custodians/u-boot-sh (2023-10-02
> 15:19:02 -0400)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-pull-4oct23
>=20
> for you to fetch changes up to 4840b71bb009711564e20f9695b92950c3f73e42:
>=20
>   qconfig: Update the documentation (2023-10-04 09:25:22 -0600)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--i2acLTeY8iSv6bEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUezOIACgkQFHw5/5Y0
tyzipAv/aLeb1hiQFamDJrDFBJIHc0lEHlD6J8p50pO/x3a5mz9tYFDQ6jx+KkV+
DjQLmz7nNWm7WS4I53iIY1AezHdeSyIPUzY0sYA3+oJMWbzuCYMoiOijAlvRxnWG
tG14rHQc7j8xbqy7Ps3eekgLkyDAUBKBZf8a1rTpfuQLtC1EtWcmHaoShyD40Mzv
DU9clrcPe62LrTeGl7EZzQQ6k3XK7RHoNLsxv5X8c58TfzNO6zn2pABMZmYSYqGp
FJXZctTi98mJGdgEVE0Pu5GcvVICNnANoZcqsDLNkLD4u4Hfi5LBPOqShY+8uQrZ
Z97ZNLj/14V8Yb8AcKH+BfVUfsQ0aoj/eP4fpPxf7CicrNshlkoI21lB8eqE6R4u
Fz8051l7qsxibIDEVLSJ6UPmiq8OD22C/pNPtvTUV3Z+VkIbktAmHSXACuZ6FKDQ
lfUSGhTtkWR2DFrnxlFp7zB3PXavBBj88lOppAF4su4MK4Fd+zozRMriDIKDJ8Jj
rHXbkKSI
=d8Ki
-----END PGP SIGNATURE-----

--i2acLTeY8iSv6bEu--
