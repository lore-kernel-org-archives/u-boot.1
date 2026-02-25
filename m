Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92986FD3776
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 17:44:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D53FD83E85;
	Wed, 25 Feb 2026 18:44:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MLsrQ4Uc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5453E83E61; Wed, 25 Feb 2026 18:43:57 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AF4F83D8A
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 18:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-679501fac3cso20309eaf.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772041434; x=1772646234; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N35pvmziowy2Ni7ELuiRYMKZ3XqDb5Gy6BLbfmcxGuA=;
 b=MLsrQ4Uc/j4AYeuJd9qMMYcS/SjinQeOegmvZ1eZvtEg9lzUNaUagtuUzI41jpEkbx
 Vm0ZtIUjQKVtVvJnxQ0lMsGJ6ix5Zvjr9w3QstpnSFYXmx9++T1x0EPBZyPVVU8wzsgi
 ocWuJFwtU2wRpSMNjFpigxra31XgdgOOyruOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772041434; x=1772646234;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N35pvmziowy2Ni7ELuiRYMKZ3XqDb5Gy6BLbfmcxGuA=;
 b=hL/JXdW/ujgZq1zVAxfo/pBuVh7TPj/YUFJCuJaladsDvOSLDh0eRP2gZPzL/D6ce/
 qlVl6sah1mLPDyFI4WBlYqEfYuHtBHkyCF+mdOU5fmJ8wc+Zo/xBeQ/TYrNfa3epRXFy
 xvIu6Uiiy9a9QQ6Fl7ycAcZ0VZD7id/2ho58MzftLR5QDKhQG4mtuhxI8FfO4/Cojgx1
 OSnSttu/TDlm7b6awmzW/SDsFCX6qtX+QaslffSnNQ6kkzFPGcpxKcYV8TG+WYGW7ZBa
 EY5uBNtCDIfsUdgiPuuvtIfTc2exNfxilPjvDZfBQAdegIOARzUMzAUyzU5Ge479WRiY
 h02Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCULwVybhR9EbUQzBlPm2oAGjKfC06Aspv3giLWgcRtAKxTZ+ScDT66WTvZvVa0U4nfRno5uCw8=@lists.denx.de
X-Gm-Message-State: AOJu0Yzrzn1Vz58Z0SYKB3fmV1nNGqQtOr+N2sF0LGINZbu7WHWJb6Cb
 3hlEwal4fkHrUGDmMDPBSHfDK78xjpUKWTpzL9L2dhlQXT1XfaIjeOD5f1oo4VElrlA=
X-Gm-Gg: ATEYQzzYpcjK14PN5ACIBce8/0cHdgYvQfshQ7Tbpw9bqzdL2Wo+2Y/R/vvFy1185uB
 zlYqW2Z8CY+n4oa9RciFrxBA/YPFTs8UyjTbftWlf7dF1A1q6qwNrXS7UWtPieX8ELqbyeS+hIG
 sjeMv049dV6RzobFOiie0dy+4TrvR1HTghDiCJiZhmq1R51ypBPIJ3GTc9WsHolU1fjNI1Z8GrB
 HyGF8O7ZpDUhHRKvVWFyXLArZngZJk13vk7C8VYWiv1v0vGsK0/l9ZQ3jWCWsM44GxK8FPpDKIU
 34XLhQ24+YL65m3W7VBZgiTDxX3qJiqUipXaoYH9HxcpwHsp7nL6zFKqmnR6YCY0ncNHonlV6yi
 cb/Q9DPl5VPacgI9GrCj6VBSnnNPe3fmA3OVjyMQrbTR2MMIOqYv3T3xH0XEloaIItsSUvjBd07
 9OMPjIhXbJQbqp2NaDvj+ubJ2r3RQNGP62CgWswdsS22/y17kC1a4avrG/bVSTzO0Op1wVFwPMp
 9crP3J2EclZoWAzXRa2o6GAI7vF8V8V0Fh9Vd42xLQICuCsO7c=
X-Received: by 2002:a05:6820:4d50:20b0:679:c551:f505 with SMTP id
 006d021491bc7-679c551f5a9mr5648258eaf.68.1772041433871; 
 Wed, 25 Feb 2026 09:43:53 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679f11dea87sm211766eaf.16.2026.02.25.09.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 09:43:53 -0800 (PST)
Date: Wed, 25 Feb 2026 11:43:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] sandbox: symbol CONFIG_DM_SOUND does not exist
Message-ID: <20260225174351.GU1593142@bill-the-cat>
References: <20260225173815.86528-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qac2wRExIcI2BCSW"
Content-Disposition: inline
In-Reply-To: <20260225173815.86528-1-heinrich.schuchardt@canonical.com>
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


--Qac2wRExIcI2BCSW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 06:38:14PM +0100, Heinrich Schuchardt wrote:

> The correct configuration symbol is CONFIG_SOUND.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Qac2wRExIcI2BCSW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ800wAKCRAr4qD1Cr/k
Cii6AP9jWuWxAbUDU4ipRqWtuExo9SI/0u4CL3jqjpEB62SuDQD/WI7TpZp5W/cj
U/+06I1YLnwPWMVPBK7cMXbG1ZjMTgY=
=dTnU
-----END PGP SIGNATURE-----

--Qac2wRExIcI2BCSW--
