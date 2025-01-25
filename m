Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77EDC0218D
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 18:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBCB080EC0;
	Sat, 25 Jan 2025 19:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J1h/1cD2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C40E80EEB; Sat, 25 Jan 2025 19:25:23 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 068A680836
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 19:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-467a3f1e667so19407171cf.0
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 10:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737829520; x=1738434320; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qnmdrBh5VqYg6l+szwFGQYOaSBPlLZXFh9hzvBvDLX0=;
 b=J1h/1cD2VgZssV/kDysEVV7fGuZdcas0WUZMPIQ6TlW9Sykr8bpd/xzMS4FI4lxXq7
 P01z0zjPquzz6PRuWcNIxiTp+ILEnPYSoPAh2Q38Xi2onBR5Yw458kbuXobVOI179sHN
 e0ghzgb1UfrM97d0By7JW5tz89JImFmGDi5qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737829520; x=1738434320;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qnmdrBh5VqYg6l+szwFGQYOaSBPlLZXFh9hzvBvDLX0=;
 b=XrOgsacYSBwKD+5rkhVWGprO95cysbXm30eUWtgetR45MUQNMjqElP/jvQUaZj/p+n
 de35T62wa7jH3O6VH87nZsTK4h0Qg6Dy1v6LWskI6EUfSw1q8Gb4g8zbef+qBfNLAvY7
 Q2ATODATi+e9F50zOq7cj7A/j44Z5UCSKDCKofHYD8989gFGtJ3HJ2QEyVbZmmEfNUFB
 KpFVN5f0jNm9ELQY+AD0aT2ow7KWWTjOSbIDnGzS5O4kgfXVEFAbZ1y4MZpohJNSS5Qe
 aiLqikrhpzr91wjgMIOE5sXKPkxfa/8xDhlQNNGa6VBKReaiOWVEOTpIrYA2SjVKHBAe
 v4vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd4hg1bCWsYxFmXu2yuqkaaWN5df9muQRSyoF0F7mhdSU1eRokai6iFaUE2cbqJEMu47cgJaY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+sHBWPxSY5raJsSbgG9F6UaT+/EvtfKRNmcjMvMGZGZgTDe5P
 hzqAcS9wCIA21hGwHXacTwBaMgJXFmSkFaGZmvp49LYiNvr3EN8uAuVkOsNjDIg=
X-Gm-Gg: ASbGncvRfQMrqNQTPvzDLIp5HxrD91Em2YTb8RxUyIFGao0aPXUwk7nYs4CCEFLCLuu
 fG9k+g96mnz3ev2J4Y4OmArC/OALhDHhwxdZ7raWhFvYg617jv9hHdQ4CVqSTUYiaJqICjPdjbB
 RfjCMlNpRiIzEJeyKHoJkGEHUSCzqYmXOQwtRXwbecQpaFsEDNrzbPpovVKuXHtfTfM3WZtd3bF
 2si8U743q68dClbemsbXE6vi7l0EXbA94is9puAVz9P8MlbyKS9mjN5rGfsYFIzLJg4z1ot7blw
 gysO
X-Google-Smtp-Source: AGHT+IFCuufjWHF/7D4GdVC3c8pvD7axn3+YE708FDEV51NQ1OCBB6uKoeXc8gY8qhNg6vtZSAOs6A==
X-Received: by 2002:a05:6214:2483:b0:6d8:a188:369f with SMTP id
 6a1803df08f44-6e1b215a0aamr527697556d6.14.1737829519822; 
 Sat, 25 Jan 2025 10:25:19 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2058c2fd2sm19712596d6.108.2025.01.25.10.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 10:25:18 -0800 (PST)
Date: Sat, 25 Jan 2025 12:25:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Alice Guo <alice.guo@nxp.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 01/10] pinctrl: imx: Push imx_pinctrl_ops into drivers
 and staticize
Message-ID: <20250125182515.GZ60249@bill-the-cat>
References: <20250124145520.185414-1-marex@denx.de>
 <CAOMZO5DTbaq+ArihsEE68YbD8S-v9ny2+Nc8XbXZ-JWRRTUFTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UV2RYCp6v2u1MbbD"
Content-Disposition: inline
In-Reply-To: <CAOMZO5DTbaq+ArihsEE68YbD8S-v9ny2+Nc8XbXZ-JWRRTUFTw@mail.gmail.com>
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


--UV2RYCp6v2u1MbbD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 12:53:10PM -0300, Fabio Estevam wrote:
> Tom,
>=20
> On Fri, Jan 24, 2025 at 11:55=E2=80=AFAM Marek Vasut <marex@denx.de> wrot=
e:
> >
> > Move imx_pinctrl_ops into drivers and staticize. This is preparatory
> > patch for follow up pinctrl drivers which will not use this variant
> > of imx_pinctrl_ops content. This should not change size, as most of
> > the deployments compiled in one pinctrl driver anyway. No functional
> > change.
>=20
> The u-boot-imx/master-next fails with this series applied:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1005082
>=20
> This is unrelated to this series, though.
>=20
> Any ideas?

Yeah, sorry, hit retry a few times. I'd like to not have to disable that
specific test, but I don't have any better ideas.

--=20
Tom

--UV2RYCp6v2u1MbbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeVLIcACgkQFHw5/5Y0
tyzWIAv/fAVjtJsWASXzkAwcVy8h7lQfQD1QtnvThzKrbbhVgfmsoOcyVzBAtt5r
27bcS4WRoOFUmByd7itIxYJc8CMMEPQ8QvTTt0HuT546+FW1WxD2zrqh0kfAP8Es
Xh4b01KGIc+K7dnwMWOaJBLeuTI3eX3TB4sIlXDe/s1Ov42N8Np+FqWcNeFqjRrJ
+tLN5LxmLk1l3WM5g5jK4SoUqB8J4XFQgjNlUvGIQ0inatMMgDYQQlM3G0seti9q
zmanft8h7lxt7oc/+AfLz8aQfBYHJs1nKGGM9yM23ZF4VASHWr1Ze3SsLG1fbcDC
hX+ZIeMSypqQ9kZE6G3uQzO05eGWFJmo7g3gSd2ui2leInDRPRqRQFrUq58ZRfAg
ObzukpzWHYhlehCaHfS6OvgWQ+lNe1I+KRNc4QXDnYXif0OFhkXplBG9ESkBuCnb
98UjbKwNlu284gWuB2WFMlwXmDrOCnFVxHV3d4tHZo0JkejG0+yDWvd7QkKFG6To
M4lh4SQk
=W83P
-----END PGP SIGNATURE-----

--UV2RYCp6v2u1MbbD--
