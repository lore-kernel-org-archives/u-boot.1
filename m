Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0F9C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 21:24:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9832883D2;
	Tue,  7 May 2024 23:24:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MIy4YbQv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCB00883C8; Tue,  7 May 2024 23:24:12 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AC83883DE
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 23:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7928ec5308cso17369085a.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 14:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715117049; x=1715721849; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PSaX6sz1cbTirOmyVuHGoDr5PFf5+Z4gd8BYApEj9rI=;
 b=MIy4YbQvQq3hDwbYIKl3fSYR4UgPvdRprZXDDJoHuo8AtXcmNzDLA3b6jLBkjlt0jC
 SPaaOw59nBY2ciKEp9Rl7zF4oFRNzN8RGpBTYjQt4gOR1vx5Xpvoa46v4ucfum4IJ0ze
 LnkFNoOIqdemCnta0Msd3NT7Q44bmkEHHVHLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715117049; x=1715721849;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PSaX6sz1cbTirOmyVuHGoDr5PFf5+Z4gd8BYApEj9rI=;
 b=VHiBWNN+eNkKZAsssA94QyDfk1XU6fzZd5NNTTaV++cOxgH2xYFZ3kOdvJjmUI5TkF
 lhtoqDYffOmAvjJ72yS0oFDqTvWNgl7dXnVeQ55A3W5DQwEcbkvpbMK6yyJQQ9yajn+7
 XQ6Qk8akdWaHOKkSbA/fT7q0Edjq4489TkWhsovhzBAH7cWmPwyHrvWnewW/42A91Daj
 1FVb2ZppjNWhjmMefEO1awdww3xU1+XaeW7BKNfguao3BY+pe7SfD5p/vZNuAUVgUAkr
 lkj+Su0fStB3KaXwOWeN+B61YoqJ0YgtqO+FLNPtHynTSjAi+Myrq6XmkSTYIFzOHS6k
 spfQ==
X-Gm-Message-State: AOJu0Yw7ec5SWCfpnUVfgwKa+GDJNmVMGjSw2VF0w5sjZWuN2AG8gwzP
 6kCfraHh6eUmEI9Sj5wQWcizy4XHgvx1rtNuqM6Dk/XKAg/rSQuctCnyrHK9V48=
X-Google-Smtp-Source: AGHT+IETuWrWphmMZLrcwHfjlmDxLpAvnr1k70Mcbma+mqzCo+++LriOdWZ0YTz4VmzKyGj9zCuvIQ==
X-Received: by 2002:a05:6214:76b:b0:6a0:ea1e:833d with SMTP id
 6a1803df08f44-6a1514ce653mr19449806d6.27.1715117049187; 
 Tue, 07 May 2024 14:24:09 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a0cf7ce000000b006a0e5626f67sm4982261qvo.50.2024.05.07.14.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 14:24:08 -0700 (PDT)
Date: Tue, 7 May 2024 15:24:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Andrew Davis <afd@ti.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: Re: [PATCH v2 06/28] efi_loader: remove redundant hash includes
Message-ID: <20240507212404.GB2568172@bill-the-cat>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-7-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OLGiB7M6fizLoCuc"
Content-Disposition: inline
In-Reply-To: <20240507175132.1456512-7-raymond.mao@linaro.org>
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


--OLGiB7M6fizLoCuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 10:50:48AM -0700, Raymond Mao wrote:

> Remove the redundant includes of u-boot/sha1.h, u-boot/sha256.h
> and u-boot/sha512.h
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--OLGiB7M6fizLoCuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY6m/QACgkQFHw5/5Y0
tywsWgv/WyAffQ7fRa6zCk6S7iX1GP1raKCOQaUn7MCqopxO/iHoSdtkhFizgpYl
fYKFREtJqVHo30EYxDGHOra9V07XRLGwd6Lu3iQZ8DPTSJwm1pcewS5cn3OF5bv/
5Dkoa6crl0QPDbonrASkjHwsWs4DTxQoqUaIezkoL0KFPZanUhLqlgYLbHu8uIGf
M/ItpPV2jIOVik6eQIK/OokHk4Arah68Nc3X4/w/V6iEmaY0HJqn37v0XT8wf5M+
rIUHr3gClXtW8Q2J7Xfk5x8S36tCNAtnnz2AkrCYkMW96iz6ClBFQ/7cVXI7s3Hd
PhSBv/CfrimMIAlH/3U1OIsW+oOvtrbe5L/H/6OWMlJzdUwh4fSM92UOvk0qxEKs
25fROMHYlhTNztGtCoM9uuobhk60xgkCWBMGI89kP9dmwWKBwsLwT1S9Qxx5x4XU
Bw/jESmHE7GOd8/+1zSehbwnq7wwHAVz9Ns79+1BeTqJ2f+kaakjyrRk+pyKZn+Y
0Yg3tq6i
=wc8U
-----END PGP SIGNATURE-----

--OLGiB7M6fizLoCuc--
