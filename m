Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF9FE6B27C
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 14:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E11F78924F;
	Fri,  1 Nov 2024 15:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T362R8Q2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2A7D891E2; Fri,  1 Nov 2024 15:14:16 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D8F488C05
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 15:14:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4613162181dso12645121cf.3
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730470453; x=1731075253; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6AXxl7vx9d415yojUIlBZj3uAX9/GuA55iaZN/949jk=;
 b=T362R8Q2hvQpiFtf/aeVLYfKWLOtHrRvEzbzxoxFGRFu0aVEY2YhvMAAK1TkAO1DyT
 ogjhbvmBOhOnG61sjp5PkZszUfwJ2aV96Xs3M/i/cmKrsm4fh/XdGpDKZOKkPrGPOPip
 cL4TZNoxeWCqHXWR/Q6W5YGIWgxY1dmI2pSx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730470453; x=1731075253;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6AXxl7vx9d415yojUIlBZj3uAX9/GuA55iaZN/949jk=;
 b=unDa4CGiUJdlTV04i3dw00IUMaTBF9dTgqbyCALjgSBR2Sls+12hRSyEnBRdn+zL+p
 3w4b0Is0o50zng1BR9Vz19IJy3ePsizNAG6v+hcZDTT/LiDoTNNM30zK/A1vY5iV9Sch
 qmxzAUesCwGZzZp7P0DVgwUst4+dqtjoGExEkyfo6uMUj3Q/NdOarZOMAuUnwjXjnh5I
 RREnW09XHxuRFc2p7Or/fRh+a1O4dM16Njcpih8LohwK0EhuJIZgI1X+QTj8TuuewG7s
 ttVZuMZtE9vCCaQv8sXYtzOy5A1Oxhft3sU3ugEV2Ok+BBo2N2+rDjHQ8ksfpvZXlT0N
 QlFA==
X-Gm-Message-State: AOJu0YxQtzgbX/l3HZ4a1JeE95h2gRF+y08xPnWWAfTT25lyPSxVV2mz
 GFNGgPf1Qz/NJMXaFO/r2hqwOTm6sWn+6O9bWtpJ9kXYKe+kCodXkKpklWhjFwQ=
X-Google-Smtp-Source: AGHT+IGx5JJ8Fczd2S7YyKn8LuFAI4lMQpBKLh+snK///1Z0+VAudtV73vwQjHIHXHSGtZ5UrPXvxg==
X-Received: by 2002:a05:622a:489:b0:460:b008:9bb2 with SMTP id
 d75a77b69052e-462b876aa53mr37251701cf.58.1730470452952; 
 Fri, 01 Nov 2024 07:14:12 -0700 (PDT)
Received: from bill-the-cat ([189.177.122.145])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad089aacsm18818061cf.20.2024.11.01.07.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 07:14:12 -0700 (PDT)
Date: Fri, 1 Nov 2024 08:14:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Svyatoslav <clamor95@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH v2 3/3] common: Move autoprobe out to board init
Message-ID: <20241101141407.GM3600562@bill-the-cat>
References: <20241101115028.214678-1-sjg@chromium.org>
 <20241101115028.214678-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RT3sWbsnFiyBP9yU"
Content-Disposition: inline
In-Reply-To: <20241101115028.214678-4-sjg@chromium.org>
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


--RT3sWbsnFiyBP9yU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2024 at 12:50:26PM +0100, Simon Glass wrote:

> Rather than doing autoprobe within the driver model code, move it out to
> the board-init code. This makes it clear that it is a separate step from
> binding devices.
>=20
> For now this is always done twice, before and after relocation, but we
> should discuss whether it might be possible to drop the post-relocation
> probe.
>=20
> For boards with SPL, the autoprobe is still done there as well.
>=20
> Note that with this change, autoprobe happens after the
> EVT_DM_POST_INIT_R/F events are sent, rather than before.
>=20
> Update the docs a little, for this feature.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This commit is where we need:
Link: https://lore.kernel.org/u-boot/20240626235717.272219-1-marex@denx.de/

So that it's easy to go from git to fuller history.

> diff --git a/doc/develop/driver-model/design.rst b/doc/develop/driver-mod=
el/design.rst
> index 8c2c81d7ac9..1dcac1408ff 100644
> --- a/doc/develop/driver-model/design.rst
> +++ b/doc/develop/driver-model/design.rst
> @@ -842,6 +842,21 @@ steps (see device_probe()):
>        cause the uclass to do some housekeeping to record the device as
>        activated and 'known' by the uclass.
> =20
> +For some platforms, certain devices must be probed to get the platform i=
nto
> +a working state. To help with this, drivers marked with
> +``DM_FLAG_PROBE_AFTER_BIND`` will be probed immediately after all device=
s are
> +bound. For now, this happens in each xPL build as well as in U-Boot prop=
er,
> +both before relocation and after relocation.  See the call to ``dm_autop=
robe()``
> +for where this is done.
> +
> +Note that autoprobe happens after the ``EVT_DM_POST_INIT_R`` and
> +``EVT_DM_POST_INIT_F`` events are sent, since these events relate to
> +device-binding.
> +
> +See here for discussion of this feature:
> +
> +:Link: https://patchwork.ozlabs.org/project/uboot/patch/20240626235717.2=
72219-1-marex@denx.de/

There's 40+ messages in the thread (but I know not all of them were
about design), so is the above really a sufficient summary?

--=20
Tom

--RT3sWbsnFiyBP9yU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmck4i8ACgkQFHw5/5Y0
tywvKwv+NVaaYQHNA/6kLKh2vn9I5Iu4qMZv1Vwx7dBd5Mu/oCqrsvtiIxlPx3+W
7Xfjl9plsUkw7sOXZ0fovvxl3dY49N/Z9DJtUlv74bZDp3XvA7OBuOLPdTPZiSYd
/IFT/yovtf0A1hSKPXmZP1rSu0gyQQ3qM7XiIy+hkBFsnybkDBLi4AvCsTr7DknD
rCa6tNvuhtLv3UI2NcD06AnOSLFHnWu7fDYghgDVNx9egGiA9LnLKyVyK7PHK02z
yZtzfZLxeGL41YnpcI7og3SXOBFPdRwqnXDCmcn4Lg/dqI2ti6EDsj8j2dlfL1tm
uf7yUpmk75biVO7xlF0pkMA2BiuqWhHRulVNTOwisgxYSTdJwEt9yjxbMG6yd7nH
5ocqGFqk0dTKsw9UpJct6MHe7EUey3l3SAnBsRdZqnVh2nYcbC/QzD8Q6b/TDJGK
yaL68l3PsvAWm2L0mEUGL76PXFln+h0/9PJMEVJMzxgdRaK4zrb2P/xT8UMsqs+2
wBfGxNj/
=X5sV
-----END PGP SIGNATURE-----

--RT3sWbsnFiyBP9yU--
