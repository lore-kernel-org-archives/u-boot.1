Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC48C282D1
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 17:06:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4671C811C1;
	Mon,  3 Mar 2025 18:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HMn5jGDO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B09CA811E0; Mon,  3 Mar 2025 18:06:48 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E383811B2
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 18:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6f4bc408e49so41625457b3.1
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 09:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741021605; x=1741626405; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zlclyMq2XwXgqgVrDDEmxqIrtmcE5TKw8rdds/mHAF8=;
 b=HMn5jGDOHOkw1ciNKIi7IdBxdQzF7pjktRvUS0gOc598v+IgG6kWdKyLY/IvJWhqaM
 V77j1gzlvvWDdeudYMPFf4Cmcs9AZl/rJDV/dFbw3N/yW0mi9L0FJVSPCHMuhg2KUCEZ
 w1Kf1b9i0CvZb8qQx9Q3MX2iQPgdeUdShshD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741021605; x=1741626405;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zlclyMq2XwXgqgVrDDEmxqIrtmcE5TKw8rdds/mHAF8=;
 b=HCQ8OW4L8heZDogjNRm56Oh/yslemhmTSXalVLEzlX76Schv3UgGhVBlKAjGUjBOgm
 J9moQ6Ue8P8BqQh4xzGhuTQu7zIRdNYaYBOkjZvhqXwyULNyhrekUA+NgKQbzZKmkQEb
 vytX+2uUE+zk5HrH6TZ4DyepTir+C3+F1z5btj7+Hvr22HId99vNSe6kq+NsMvf5eSKU
 Oln7Thpi8p57c4goTp1uC2xEnCyMQvi9Wh/Okj+5Vh1/56yaXhHDSKxIsx+DIsHrYDzl
 62jzsbWWcFyC9jlCMYvdn1jAVgP5LUEyosdUsmP+QV3QlbKb3Bl4fQR0b/NbYtFvP5UH
 PavQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuar+MEjQcfS7alKccN2nyJAklIGP6+53DEweu9KbP+WAY8zX+fn9EXkaHU/j/+N+ZALUcJyU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1uS5zVv3q6srKZLe5OsYeT0K/amnTQd0wRlqJvjp0mXG9kU1K
 6NhXSjPiBKEANyG4H7FuS/i/hyL6ythcVdgxRL8E20fZkDO6zijidCUFgQqWVcU=
X-Gm-Gg: ASbGncsQIPgSEekG+teI5lKTutkHHg8NpPXdKeWka9Dx5vDnBsEAh1ZonBJMpPKCmO+
 Vh2JPUXSssnn5XtGqsY5QgExFSpCnU6RKInKZfC2PTi+rTj4NwZoDKsyecFkTgUUSE9E+gEGH2U
 bgkcMtz0q5OGtQ6ZmaHA6RLAZWZ8YeXrM/HvEApp5WO2gJkIM/bPLsn/5i19+NQCIKoxJoLuaoe
 oETTo6HmvqoJVRpK4GZdv1GYD8N8ms/uE1eQorOBsjB4byGg9RdSL4yN8eHVRRCpmsIwD0hYHeP
 FgIKsyDMWG+zjUIsrDkWRKgE4gpbdg/fwPh/L6Jpm40=
X-Google-Smtp-Source: AGHT+IHm0WtjkZwCJjQsR0lKrKCS8v6xDO9NEWKugjOQsWm6dH++TUPOjgMAnZj56PbUWcnLLdb7tg==
X-Received: by 2002:a05:690c:6c90:b0:6f9:ac35:4483 with SMTP id
 00721157ae682-6fd4a1b5c0amr172560377b3.25.1741021605108; 
 Mon, 03 Mar 2025 09:06:45 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3cb826fcsm20804967b3.90.2025.03.03.09.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 09:06:44 -0800 (PST)
Date: Mon, 3 Mar 2025 11:06:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Mario Six <mario.six@gdsys.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 00/12] Add imx8mp video support
Message-ID: <20250303170640.GS2640854@bill-the-cat>
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
 <CAOMZO5BGBv_hM30W+_J8AS_X3fqj6MXy8DYDhoyROdC89=k7aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SxaXWpi6kun44Wkv"
Content-Disposition: inline
In-Reply-To: <CAOMZO5BGBv_hM30W+_J8AS_X3fqj6MXy8DYDhoyROdC89=k7aQ@mail.gmail.com>
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


--SxaXWpi6kun44Wkv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 03, 2025 at 09:31:37AM -0300, Fabio Estevam wrote:
> Hi Miquel,
>=20
> On Wed, Jan 29, 2025 at 7:22=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
> >
> > In order to display a boot picture or an error message, the i.MX8MP
> > display pipeline must be enabled. The SoC has support for various
> > interfaces (LVDS, HDMI, DSI). The one supported in this series is the
> > standard 4-lane LVDS output. The minimal setup is thus composed of:
> > * An LCD InterFace (LCDIF) with an AXI/APB interface, generating a pixel
> >   stream
> > * One LVDS Display Bridge (LDB), also named pixel mapper, which receives
> >   the pixel stream and route it to one or two (possibly combined) LVDS
> >   displays.
> > * All necessary clocks and power controls coming from the MEDIAMIX
> >   control block.
>=20
> I am seeing the following CI error in sandbox_spl test.py with this
> series applied:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1045491
>=20
> Please take a look.

It's a tangential failure. Svyatoslav reported this with a series he's
working on and Simon wonders if bloblist support got broken but hasn't
had time to look at it.

--=20
Tom

--SxaXWpi6kun44Wkv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfF4ZkACgkQFHw5/5Y0
tyzIdwwAjHl6lxWhKKd+X0hCdUO73kmFb5s0mTn+XEptMa6l5oVD7Z/BvKgQs/2C
L9zLf8hDTK2r139E4VdB7anhs+9x/lmHPCEgUxckssc/8MyEyRDde8sOEHqVhrtR
9vbnv7G25SILWBkwZQax2pvyPW01pfRZFsf8cnyXQxuH8ZdQ1F7+tGUEX3gXRaGj
VsqIKSYrZJ2/UFszW72iK6DYISaqiYYrXQZoXiW5E1kCE5f5KZf9FouSpMXhoxii
Lv3do8Z4KR7H5GxA2N4FyAgTQQg54RO8g7eYDQqQCufHBogvcycFJxl875YXfES7
k5y1Xd9yVwkTCEnJ7RFJdSF6bPcps68lPc7nOMghgJ3RBNkh2Jk5MDDrOurSpQzo
rT+AJaaWDZJtxbimEP2Tx7AZpGHJZAION59NAm8O2HTXWAbe5JH19JKT520Q8URD
R5q+yxIrMcoi+QIEK/h2XjgD5hMLVrDF/JsyyN8ABzGrOAaltELlVz9YWJWFEI5t
Ah4LgHNI
=k9TB
-----END PGP SIGNATURE-----

--SxaXWpi6kun44Wkv--
