Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893D8C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 14:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1760E87BB3;
	Wed, 17 Jan 2024 15:27:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ve+WE861";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4857F87B9B; Wed, 17 Jan 2024 15:27:01 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A419087B66
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 15:26:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5ff7953910cso1243067b3.1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 06:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705501617; x=1706106417; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mjqJeS+pb/xk8MEIuUg9cgUE66XSPf0ZYZ3hJwI67GQ=;
 b=Ve+WE861umGNt3eEFfqRSFp92TDIWpDTUG39WyCIPZFoEnCE9NIdeJFuc/ikepI2F5
 C1xOW/yz89p1C3RPdoVVsBMxi9pTGHjqj9j9FQwmtW8JQi2JULmvKzXjvIbGEyPM8eKZ
 b9s/EqE3Cs+BKsc7UoaEzwzoeYXA2drwVDEss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705501617; x=1706106417;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mjqJeS+pb/xk8MEIuUg9cgUE66XSPf0ZYZ3hJwI67GQ=;
 b=O4N+q0BhAudOGwpXDgd5uYqyvW0bWmkhpxS1/etSBh7NyhmOJ26YRmDpYML+jdh693
 h3n2QQyVj6JsDrfZBCPNH4yCjLoqZF2ZPRkGbw3P9xmy+RIPCh1XIRi+62re8whe6Xdf
 b2T+vywYYaMozbhSzkvTDvDzEQ1hbk4Y+hCZXgHoy63hxgSCL4oI3HlXEDsRxeu0ldRH
 RVr7iurJfuCQRmwN6wm6plZB5A1n9K3gT8xitpeX27yKkpsueZ0OaRT8ws3KaYt1mX/d
 qT6J/C2ghb6I/eIPyM29rTlyNdmSTG8fw8acN6z9e19SAllX/OiS9j8zrEiH7Sgyg9tg
 Pc0A==
X-Gm-Message-State: AOJu0YzFxaNZy8LDzOp+DNg+2TXdIabSK1SFQEeF7+MsOdZ8TM1R6e2f
 TpeGqveo6tsGulcuVDYXFt8psG03gl5RC3rv9UBfQWf6t1GLL56DE+cTuAktT+4=
X-Google-Smtp-Source: AGHT+IFOenAlDw2sGUmLTdQdc0JNtPvyNwMDdUnYq7/oWkw+s1546Qs4gsU+63hsBN+f4bbwfcp/Eg==
X-Received: by 2002:a81:af02:0:b0:5ff:583c:6dab with SMTP id
 n2-20020a81af02000000b005ff583c6dabmr438312ywh.13.1705501617412; 
 Wed, 17 Jan 2024 06:26:57 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 l9-20020a815709000000b005ff63349520sm818420ywb.46.2024.01.17.06.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:26:57 -0800 (PST)
Date: Wed, 17 Jan 2024 09:26:55 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 2/2] smbios: copy QEMU tables
Message-ID: <20240117142655.GS12635@bill-the-cat>
References: <20231223010334.248291-1-xypron.glpk@gmx.de>
 <20231223010334.248291-3-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lR3veVifYHz+2ULz"
Content-Disposition: inline
In-Reply-To: <20231223010334.248291-3-xypron.glpk@gmx.de>
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


--lR3veVifYHz+2ULz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 02:03:34AM +0100, Heinrich Schuchardt wrote:

> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>=20
> QEMU provides SMBIOS tables with detailed information. We should not try =
to
> replicate them in U-Boot.
>=20
> If we want to inform about U-Boot, we can add a Firmware Inventory
> Information (type 45) table in future.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--lR3veVifYHz+2ULz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWn468ACgkQFHw5/5Y0
tyxxPAv+MWcvziTn93QHns/RwadkjcFi80bRkr/zLEeI2UDqMfYFkiAO0QxtB8kM
cRXarHHOwBSb4BDToAtazEgPEeIUfXiTOOc2WszFxjBS32gSU0qBPse3epVRkuiz
ouzekX/Q5pBeyC0xUBkgNA9DJ4xpZCb6R5aSt4zq60cE5+HX9u/ZHVYODRFdMpcM
wvXBkxJ+wYiOvJ8srwdlFYEH6pVqmdcB3sBIz7jbblE0TkQsLqdC44csNU53EknL
/TrNCb/QgTtTeMS6dgi08osbABxL/zT0LcFSPFoM1fsd+Ln1RO9JjTi34c5RxO6u
UWMkoSFXWtId3QpIzw1xewjXvr8EaWxM6piU4EFN0T85BvKoZAWi2nRF/q1srfbz
lUwiHdUiGItdzSqinI/H3tW7+Qcae0eLQKmjVsPpp5lcqVKzZz3mhlT8XVt4sII3
BdV79G65Pg83iVVc+0Qpwj0rv2V+LtL+9C9AWNpeuJI2rvV6J5rATsmsrP6ndq1J
pvUO1tIi
=/N6p
-----END PGP SIGNATURE-----

--lR3veVifYHz+2ULz--
