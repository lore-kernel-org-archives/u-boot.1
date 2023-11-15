Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B712C072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D08B8744E;
	Wed, 15 Nov 2023 23:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FBlkwewu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F67E8746C; Wed, 15 Nov 2023 23:37:26 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC006869F7
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7789577b53fso6344085a.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087843; x=1700692643; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TWVwGlAZSdUP5glTyX1gVmx8EPwaJq2ikd7ccm2rJ3w=;
 b=FBlkwewu84xQ4cvb1/XcFKFBKU/kMySRHARTKRnRPQ5FuVRaYBFDM/Yb+4ff/jPmZR
 Size/YWxdHx6cVp5KPSMY25QiPDJGb2J0uVfXIS8i15PTI0MHVrspeTieoefMPg5gDvD
 bqH+XQFshj54vtYAyaV+GyMNqCoTOdeKPgi+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087843; x=1700692643;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TWVwGlAZSdUP5glTyX1gVmx8EPwaJq2ikd7ccm2rJ3w=;
 b=VUx7fdf3FUT7rJeuMl5rXv/ADUqZDY+jSYppEI9bN5ePapn+8jkvB/UCVS5fv3r8bj
 rRm4u70XW2sbk7eYPL2YnWc2ElEELRoPJI3w94XpxBJnHI1sdU2yUD0+58rVBnt8iaOz
 4SCmjFFneb2jnTY2D2MhE4TV69liRwHXeUL/vlsNxrQGQQXFjSel3RIhp+S41v+lMk88
 dP/3YPPBhm/4WCVOghhbdoWlhaPcT9vS5tA34tIa5/ZcZ0cJcP2+mF/i2QJa84r+Nz+6
 5RlV1lcvJAJ9gb6k8uP+BdKoUa0n4lt6UymauYpBKR/mFX9Jds1Rmdr8uuCEY+L+McqE
 te7Q==
X-Gm-Message-State: AOJu0Yw0fa/zEV00Z3+OTQvN3M5GJSMUqawJYB9SBHx75UjWjZbx7he0
 fR22kblLCYGfmZ91P9b94gD6aA==
X-Google-Smtp-Source: AGHT+IFgujuhn5XNyoHkvkTkKIgE7tGmSvOv4aAlnQpX+9v73Um1qxv9wphgJdTMrFAHjlorWsTw5w==
X-Received: by 2002:a05:620a:4010:b0:77b:b1d2:955f with SMTP id
 h16-20020a05620a401000b0077bb1d2955fmr7016426qko.4.1700087843501; 
 Wed, 15 Nov 2023 14:37:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 dw1-20020a05620a600100b0076ce061f44dsm3843069qkb.25.2023.11.15.14.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:37:22 -0800 (PST)
Date: Wed, 15 Nov 2023 17:37:20 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 17/29] bootm: Reduce arguments to boot_get_ramdisk()
Message-ID: <20231115223720.GY6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-18-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TDpfphhIlrjHgpU0"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-18-sjg@chromium.org>
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


--TDpfphhIlrjHgpU0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:09:02PM -0700, Simon Glass wrote:

> This function normally only uses one argument so pass it in directly.
> Move comments to the header file so could one day include these
> functions in API docs. Fix up the u8 argument while here, since it
> avoids the compiler having to mask the value on some machines.
>=20
> The Android case here is bit strange, since it can use argv[0], so deal
> with that in the caller.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--TDpfphhIlrjHgpU0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVSCAACgkQFHw5/5Y0
tyxdAQv+NvY49KkmCQQUStr9BmqFy1TioV6qMvMIDwQoTxTBZLUGevt/lIQf4ag6
wBDdxKbnAc+PvjBfJfKMkte4XoWXgtrmm2rpVJ3Y8S53u3AZCs1UmAFafcBfXUvv
x2u9APEO20FBs9oTwJcmp9uBJTjJzn+A2c1ILPcCvg7bevAOWjqHSiqL/7Q5kGDS
Bz/hE7X5FYHJ+JpFOxZcJ3gtTji6KJYPi5/Hd5bgnYRT7YpyjZubONSOgPVrhglX
6A7smSoyDeDWIYVVzHj0fa28VGQdh2a+kvVrcD1GtMrWF1kmkMeVix7qQE5SPE0Z
r+/gutQOlbaDnpp/mZ5ZoSyrOQzl6SaYWFWew+XxfwT6KPky2ccmxh9BcmXUeCaU
rfsS8475hcO9xJcKmq07sAuUjMzwkaHXispwvOayiJrkbxT6AfoBvLNwBQUaDDn5
Ic2Ard4T3m4PJ0n3qGYznW8mBc0Z0AfbIDzY1MNd+YN0Nql6XTTwW2FUcY5xFs4u
UIP7Qs+D
=yzM7
-----END PGP SIGNATURE-----

--TDpfphhIlrjHgpU0--
