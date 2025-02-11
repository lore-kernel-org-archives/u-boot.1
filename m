Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09F6C0219E
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 20:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8A74809D0;
	Tue, 11 Feb 2025 21:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dHRIDgqB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 407AC80AE5; Tue, 11 Feb 2025 21:49:28 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A619680842
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 21:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21f40deb941so130880045ad.2
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 12:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739306964; x=1739911764; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T9lJOAS0hg3xYytXXptCdLAOyJ75ZWXrf8qE91fUsFE=;
 b=dHRIDgqBYAv9TcDztj+q6862hFyC5MveUOblW1HZN5HZtHJcGSrFwAeaN7E5jF4uc3
 klSyhh7jZe0+pxEzZdLCyf8ARD4zFT/IckQlcpLtclUyPLN1e+lS3vAK4kI/Kq1MU3U6
 q7V+EJTGj228Lkkp2E6ib2TLTsSexxOsnoSPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739306964; x=1739911764;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9lJOAS0hg3xYytXXptCdLAOyJ75ZWXrf8qE91fUsFE=;
 b=ri3sOKrJUsWpbCh4KT5v2vBYNjaYlWpZI8FV7b/TKOgC63ZymAwRnQsf4tSI7fWHdD
 iUqHnupHTXicj1wjJaiQg6EWfPFXsoUWlRfRHYbkWv0x7mvaf3ACDJGWE9iZJYG3U38Y
 uA60TnEJ6wUxJXkIzsn738JOGD2rt1LAIVAStLXYkbFmf9cfALsH+hNhJ2srDNpFPKa2
 L47BS7eMZEgyU9y9Q7RJNJZU2lViOWMMviKANm4jVAXcnn13q/G/fGHvWphz4nxIp6UC
 2G4f0PMRFC+Cn4CA9YL/P+/DfRut+7nsE7cf/5t79beStwZqSeMqyI9weT/v+seBchd2
 eOeQ==
X-Gm-Message-State: AOJu0YykC4kVnpxOmzPS5vKSO7Kbg4PTcmXjL4DKaia0kszeQNwK8ghr
 3csJb1QOz+Gck3bskc289tb0lmVaaALa7LOvVySenX2WAjFUMfEwWHAJPmRxtWz1PnXnSCKsR8E
 HOurY6A==
X-Gm-Gg: ASbGncushkPtJauYECwauKT+sKUjKNelFLemSorIGBpEaIYmf2Qx/ljzXzhymvXTE1+
 wdw0wlnI6Y6y4GwRDd5KEucb5gffgNPgEDosGB4chQqrM1pdeN1b6+kfXxeTuNwsIeBArGxZtIz
 8q6AkWFexL1trBBCWArir26mVFRLF/uc2QjVFuVe+ciwqfGMl5ew8IlM7y58i+ZYw+VQylnNC44
 m6i+xFb/IIM93xT49c445EpbltejNO5IJM27+DSaUxH2chkwrQ2bPl93D/2EN7+DMeBo2IQfWgg
 RYZfzTbUj+sCDew=
X-Google-Smtp-Source: AGHT+IE0rQp+j9rP30K3f3jitE1Zl77zcG6rmFvJMBXRhW7y4ygME7pfSjScZDmbujRKpMYhzIEGvA==
X-Received: by 2002:a05:6a00:2382:b0:725:cfd0:dffa with SMTP id
 d2e1a72fcca58-7322c3695e2mr699411b3a.5.1739306964020; 
 Tue, 11 Feb 2025 12:49:24 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048ae7baasm9869420b3a.73.2025.02.11.12.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 12:49:23 -0800 (PST)
Date: Tue, 11 Feb 2025 14:49:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Sam Day <me@samcday.com>,
 Michael Ferolito <michaelsunn101@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20250211
Message-ID: <20250211204920.GE1233568@bill-the-cat>
References: <87v7tg8rka.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="N886V2wOGGQjK09k"
Content-Disposition: inline
In-Reply-To: <87v7tg8rka.fsf@baylibre.com>
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


--N886V2wOGGQjK09k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 03:49:25PM +0100, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Please find the following fixes for master:
>=20
> Android:
> - Handle boot images with missing DTB
>=20
> Usb gadget:
> - Fix nullptr in g_dnl when serial# is unset
> - Add missing schedule() in f_mass_storage gadget
> - Add support for STih407 in dwc3-generic
> - Fix usb clocks on STih407
> - Migrate STih407 to DM_USB_GADGET
>=20
> Note that this also includes some small developments to enable
> DM_USB_GADGET on the ST STih407 platforms.
> These were pending for some time.
> I missed those because the patches were assigned to Marek (instead of
> me) on patchwork.
>=20
> If it's too late (because it's past rc2) then please let me know.
> In any case, my apologies for missing the patches.
>=20
> CI Job:
> - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/24556
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit b3c09eb36529fbb277bec17b35e638f42cb336=
83:
>=20
>   arm64: configs: Remove SYS_BOOTM_LEN for TI devices (2025-02-05 12:45:1=
1 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-20250211
>=20
> for you to fetch changes up to 4096d28ec80f982454ef0dc7d42a4d4eaead5d56:
>=20
>   configs: stih410-b2260: Enable CMD_USB_MASS_STORAGE flag (2025-02-11 09=
:01:08 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--N886V2wOGGQjK09k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmert8kACgkQFHw5/5Y0
tyyPrgwAl/YIRhC7STbDNjd0YLlK25CsXitLJtmUxxI2eQUW5/UYEYmiTx97NWfU
7nUbQRJlMZ5p2gVFdt+DAOiLRaZgP3DdVuZiOKBqye4q/1NzxS/cl/mT9adtcNAW
296NsiOtE1c+DdP/lDeyP5xMUdip4eB/394RBbZczlXBTpz4r2+mZkSaMLa4hqLM
B5wjhuaGFYpHkGjatjXucDjRtq9g2ijZSohKuKu71qZX+ZLZIAAS6kECEcl2m2ZG
plxtankB2i9TbGECBtGC4MD4PhN0ZAdNq3VLLoppnJp5T88DQIGKqdEnjZmbt9bi
PFmKzDAMk+syqSEnsI86f2DJO2S3+kJ+w96Ih4uL+AbVJzrjC8FAV+HPhZKEetml
b9mqoWY4LsbFboPCFgiNSi5wiMZ1Eyh971GoCa9emu0Ns9aZaYa3cp45QayROKYW
15fI1ICbxt0nHmbyFpvUDX9FipyY1AOmn4qG3OJjSams0VCLdU1woHhE77k6xO3h
Ly1GQ2CD
=GUde
-----END PGP SIGNATURE-----

--N886V2wOGGQjK09k--
