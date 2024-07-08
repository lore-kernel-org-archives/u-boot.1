Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04F5C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 17:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50FF188811;
	Mon,  8 Jul 2024 19:41:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HL6lqdn0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D742887F5; Mon,  8 Jul 2024 19:41:55 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEB6A8880B
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 19:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-70361745053so1001367a34.0
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 10:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720460512; x=1721065312; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OmvplBiiU3YPMIIO17qgICrTowL0pxOcg8fYVcauVd4=;
 b=HL6lqdn0Vr208TkSr0EsS0RvTrr25zXGIlPPcMG9z6QZZef5rVcDnGFphYrsSFmP2T
 dGpFzJZWdwabLO7lUepZWN7sREJtlzG1EZ3po8J4Divwfjlx0T8wryfuyVvhLrx3ZtDM
 Xn3oWLmM3J8VDBpJuV0f4lG/mnrfz4TppWoeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720460512; x=1721065312;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OmvplBiiU3YPMIIO17qgICrTowL0pxOcg8fYVcauVd4=;
 b=Yj6nbpaN5oaI5SQCOA3PjVh8TopeZgIEqt7WmW+NffVhXlzGARnht95xUuIG8/zAna
 D7qzRygyCyDnb6iqR4JhH79Ki5i0Evd5fb8RSlp2w040Ukm66UvwpiS/P1yZ8ZEUWVUf
 jsZm1gBz7Xq8p0B/fBJQtBkMJyXaY7zEB6OD3ng8DU9RyJPyE9CEsgyXkkzNTm+0JLN/
 OQIt4bKtCEPMkyl2/zpXwFwEgPHB70hISZHHfLuh9WdC2rVqetJly7akSO0GobD0XO92
 cMzx2wgfD0ke/PyJ9UhvtdhgsVK9IMhCdPg7K3fQ/icz+8vRh7IVnmqU5jOP7VLWulzb
 f9qg==
X-Gm-Message-State: AOJu0YxeSD1D3LgyGTBgF8bx+s/XrZZkzd6MpYuiGCI9BB30xGqBFpaJ
 CzTK0TZfpliIY6+cVaCpLJXD143msLvTWItlV5ur1c1OxxG29iC/9PbqfN0D8po23EyftjMPvJo
 SHnY=
X-Google-Smtp-Source: AGHT+IHO1LaDBJs7GxG/aJnbb8qfqavRz9VTwhYtzT/mjTxBAPQSwcMoMlS6NiQNQ6JJYJ1Il4VnWw==
X-Received: by 2002:a05:6830:18f0:b0:700:cb2c:1867 with SMTP id
 46e09a7af769-70375fc9ed2mr18281a34.18.1720460511715; 
 Mon, 08 Jul 2024 10:41:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70374fc0b18sm73733a34.55.2024.07.08.10.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 10:41:51 -0700 (PDT)
Date: Mon, 8 Jul 2024 11:41:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Philip Oberfichtner <pro@denx.de>
Subject: Re: [PULL] u-boot-usb/master
Message-ID: <20240708174149.GJ38804@bill-the-cat>
References: <20240706154651.63607-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0RISTZTo8qX4Fr2x"
Content-Disposition: inline
In-Reply-To: <20240706154651.63607-1-marex@denx.de>
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


--0RISTZTo8qX4Fr2x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 06, 2024 at 05:46:39PM +0200, Marek Vasut wrote:

> The following changes since commit fd46ea0e701920eb205c2bce9d527bf0dec10b=
59:
>=20
>   Merge branch '2024-07-05-assorted-updates' (2024-07-05 16:36:43 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git master
>=20
> for you to fetch changes up to 2fc8638403c740e2dffb8d338bb58694779fd0f9:
>=20
>   usb: Assimilate usb_get_descriptor() to linux (2024-07-06 14:45:34 +020=
0)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--0RISTZTo8qX4Fr2x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaMJN0ACgkQFHw5/5Y0
tyxHAQv+L32xTp8nQlNX5xcRqqgFb4FG57XDVHZZtobOxRDpIPAo2wJoYe1yCdkC
EA1a8OhkXSzkwHWNCenULKPvXEyoBDnie6gyIviuoBAr0q1h3tJ8xalzOReP4Jly
kVHQfx/nE97aRMeX82E5YxYQjI/V9LSAmOVIgb/mFqKUtjUw2qpPrqK5R9oMWTVG
geQpjPBUPO7WzJfHUyJ1qR8C7pNKktoB2jQhg+chfle5G8zkEwqRwmHy54obZjvv
WkElmN8HFdIvHkV2fNQLLj0Ijn8kmQw16ZGgA42YNE9If55dcSWbJYR+TkDmkuuQ
xOTBLJTWfP12EuHic9xoq6eGtbqM/MeLXe5/A2z3xkMogxv8uIyCiEicv/U4fsjo
jFRulLQ5FjIypyQIVPkHBnGcEKy6QobiD1yhZtdSE9yTTEi5IZb87TX1wfukvaSl
lAODeXTGNTuRPdxAGEBTXWcony8jfu5rPJAkrf+0tRaYT3pcK2kO1E7iohbh7EPf
5Z5lfjnC
=Q4s8
-----END PGP SIGNATURE-----

--0RISTZTo8qX4Fr2x--
