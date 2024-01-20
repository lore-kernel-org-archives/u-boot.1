Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA565C47258
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 16:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F1838790A;
	Sat, 20 Jan 2024 17:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aQOW7KaO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D71D87BE1; Sat, 20 Jan 2024 17:36:32 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7235878F9
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 17:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-dc223d20a29so1410097276.3
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 08:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705768588; x=1706373388; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9g1qsH58LQK4miTjX33rDuKpAuiVokFsBf8u3u0GicM=;
 b=aQOW7KaOPMtoRO8+UuNO1jOsyecVcjrYmwddRseurZB6FmjVx9iNRVyMUk73dYM6Th
 6mauuRS1HFrjhvZQ6hQVeH53LcXan5aC1kk+ZV0fz/wHmkG/0wTJhZDmTn8LcGke5E61
 3bTLhPsaTIwiygki1A08iILdDiruBq2XO55/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705768588; x=1706373388;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9g1qsH58LQK4miTjX33rDuKpAuiVokFsBf8u3u0GicM=;
 b=Z3zsbhL+1Dp56QhE5dF6x/U0gfvKtcbRJPPaJ/FqlRORjcYZFscYT/DWsw2+nD0OwJ
 TnQJESh/y3YlOepaLHz03cR9A4kOdrNAMiBEuFM7kqPmCcOPhSIACjjp0VNCFxn1HbN8
 P/v/MoOIAb4/UDIGwSqFDPJLlDLp5EzyrMWkGTAkk/lEdB33juna2ArpYHl/bb90c8US
 jbsvfrYB20fQ6t58pzAitFL65u4HFLShqEc6ctcYyTmNiD/t16zlFlir9j6Wv7tQo8DT
 sDtm6bGFCfruxENFV3zLWk2E2Cgs+sn9EhOZ0DHu17GRvidb8YVKISiTRcBgg3hRJ/Go
 2SSA==
X-Gm-Message-State: AOJu0Yy20WLkh8LflVTVQcoOJlUN6Eg7t9TIR8+GVSg/gUqSzRtYk86/
 iGDdLuHzw3N9bYzDmnGDCfi5j3taJ4Z3GwHIYLI+dPhF5v/6lrI5+IgIB2wy3GE=
X-Google-Smtp-Source: AGHT+IFQqQsODfV+G3UeXMHl62UixUgxgivsrpNj1U+cGHiuQ1cOm4bsAI2I4NXAOT8JH+oIjNcg/A==
X-Received: by 2002:a25:f509:0:b0:dc2:523d:83b7 with SMTP id
 a9-20020a25f509000000b00dc2523d83b7mr985917ybe.6.1705768588403; 
 Sat, 20 Jan 2024 08:36:28 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 a12-20020a25804c000000b00dc226e2dd70sm505835ybn.3.2024.01.20.08.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 08:36:27 -0800 (PST)
Date: Sat, 20 Jan 2024 11:36:25 -0500
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Roger Quadros <rogerq@kernel.org>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, u-boot@lists.denx.de,
 Jon Humphreys <j-humphreys@ti.com>
Subject: Re: [PATCH V2 00/10] board/ti: k3 boards: Stop using findfdt
Message-ID: <20240120163625.GA3665999@bill-the-cat>
References: <20240109191506.3820908-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yiguieGzuLRf8dzc"
Content-Disposition: inline
In-Reply-To: <20240109191506.3820908-1-nm@ti.com>
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


--yiguieGzuLRf8dzc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 01:14:55PM -0600, Nishanth Menon wrote:

> This is a wide cleanup to switch to setting fdtfile using env_set
> instead of scripted magic. 'fdtfile' is expected to be set by default.
> This allows the stdboot triggered efi loaders to find the correct OS
> device tree file even if regular boot process is interrupted by user
> intervention.
>=20
> This is a refresh of
> https://lore.kernel.org/all/86le9dwz4d.fsf@udb0321960.dhcp.ti.com/ which
> was the wrong approach.
>=20
> Updates from V1:
>  * Renames of variables and macros for various review comments.
>  * Commit message updates in some patches for clarity.
>=20
> Bootlogs: https://gist.github.com/nmenon/843e343cde645ec4aa57b60cece5256a
>=20
> based on master: c5e461fbf7cc Merge tag 'u-boot-imx-master-20240108' of h=
ttps://gitlab.denx.de/u-boot/custodians/u-boot-imx
>=20
> NOTE: There are a couple of checkpatch WARN (around LATE_INIT) and
> CHECK (fdt_ops #ifdeffery) that on closer inspection looks fine and
> consistent with other similar usage.
>=20
> V1: https://lore.kernel.org/all/20240108173301.2692332-1-nm@ti.com/

Unfortunately this FTB's on omap3_evm omap4_panda omap4_sdp4430:
board/ti/common/fdt_ops.c: In function 'ti_set_fdt_env':
board/ti/common/fdt_ops.c:39:34: error: 'CONFIG_TI_FDT_FOLDER_PATH' undecla=
red (first use in this function)
   39 |                                  CONFIG_TI_FDT_FOLDER_PATH, CONFIG_=
DEFAULT_FDT_FILE);
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
board/ti/common/fdt_ops.c:39:34: note: each undeclared identifier is report=
ed only once for each function it appears in
And even tho I should delete omap4_panda and omap4_sdp4430, omap3_evm is
maintained.
It also FTB's on am62x_evm_a53:
board/ti/am62x/evm.c: In function 'board_late_init':
board/ti/am62x/evm.c:60:9: error: implicit declaration of function 'ti_set_=
fdt_env' [-Werror=3Dimplicit-function-declaration]
   60 |         ti_set_fdt_env(NULL, NULL);
      |         ^~~~~~~~~~~~~~

--=20
Tom

--yiguieGzuLRf8dzc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWr9oYACgkQFHw5/5Y0
tyy8Ngv+Pe+40QpyscWO4UAuu6Y+u8ROzjb49u81UcTOGN0v6z2dT2mj1oB+PSaq
pvXWFqiNCuSquUMALFNYFnNouecZz5XuqNEz1tdpFZoUGl9hynDasJNqt+ijJpO8
xBQxyWS7Fhp1hRwMFJUM4Hj44LeAVDJxs4aQ4OPzibdnca0eBJoNgK1Ip4gzx0sd
3ipZWOz6KKXUKwBoCZ+Yb0wkNJVtPvvIsZh/yR4SKwf40Wub+LWEXrpgGJuNnPMR
Q4BaRRQz0H7pxEYcYERKOgZ6UqK4zxarvUEZ4KuT0iBQcLcAze8WpzyPLtGvhuhy
2M2AupnbaLczZh4ufs8c+iFxmaxd09MwX2xICE7r/MgESPgRf3aKw7GzGoLkIawK
QvLkPCMjFbGlcia5u8o+I8/OVhNG41bZYU/wwYPJREuky1bGP3cPEYqqvYfOxQPz
NMPSdDVWrYQivxBEp2EzW/HJguGRfCFeGQb8nIaWIAjv2WJO4uiwm6sM4XDmG9L5
eW4ajEwd
=69uK
-----END PGP SIGNATURE-----

--yiguieGzuLRf8dzc--
