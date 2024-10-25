Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7ADD149D6
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 17:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B5FA88E88;
	Fri, 25 Oct 2024 19:08:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V/XtOOOy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBBD388F68; Fri, 25 Oct 2024 19:08:32 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4E7288D4F
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 19:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b1467af9dbso164121285a.0
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729876106; x=1730480906; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o/lHb6OEwchE5BTi1Pidrd+E6QdMmuLvAnymVFtNwFg=;
 b=V/XtOOOy3jG+Xrd3173bqQ95AriQ1z11M83ZKBtbdP/ijbjuHvu9FjJxEalsShbba9
 RiF4KrgccSAvG0G7atJG4kx8CwtdPcoshXIcSAhmMqwVAua0zDqX61zvGv02wQ8v+0Tg
 K+h1ne1K0303U6izaRioJxKEOzQBpC1MZ8w/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729876106; x=1730480906;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o/lHb6OEwchE5BTi1Pidrd+E6QdMmuLvAnymVFtNwFg=;
 b=tyF/Hyouy799CZrdpc6t561mKL91D1Wg9yWBDpsuj+Imk9ZWbIgoB1Wcvc0vDb/cA7
 3zm8wMBSFdIwaJI6sRMsojDXEZCfNEDjszh358s1OXoD93uxCzyu1QLbhguImQ3PI6ep
 vWTxKNJ2bi35swJ0zLaU/lZK0bsNVgJkFl0NF20XIq7JcrvuJb9F/m2O9GhtSsTWvfrR
 n6RshAglnFaeoB4rhqs9bLSylAT43pZ3P6uZqLiabIHFyuCn8f8119rG1J1bFTw4IgN3
 R9j+9Ai5yjG6db32jKSf/rnxBufmLuJFiGLFK3kZCkWw/8aiZEgIEYPxDOItzHr6/7vA
 eZDQ==
X-Gm-Message-State: AOJu0YzSmAxNyFisSQcfVZc5uuVYJIUhFqAEqpaoTBOEWVhVgFARjgAW
 W/JCj+EiC8ILry7b6kSF5AJf88dE3VSq2+tfjmefNiUdtYIPey4V33+sOx0YXoM=
X-Google-Smtp-Source: AGHT+IHB7Tan9yv7qnYpMXaThVKF5G+sHazXCeKzsMKssXtpW7d7+aE9SxHUaMWi+K+Z0j+mJJVpiQ==
X-Received: by 2002:a05:620a:4249:b0:79f:776:a9f2 with SMTP id
 af79cd13be357-7b193f5dee9mr14599185a.56.1729876106381; 
 Fri, 25 Oct 2024 10:08:26 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d3261e5sm70508985a.95.2024.10.25.10.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 10:08:25 -0700 (PDT)
Date: Fri, 25 Oct 2024 11:08:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Angelo Dureghello <angelo@kernel-space.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] x86: Missed removal of CMD_BOOTEFI_HELLO_COMPILE
Message-ID: <20241025170823.GA4959@bill-the-cat>
References: <20241025170700.74440-1-andrew.goodbody@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Oy3ajQP+uSUBqVp1"
Content-Disposition: inline
In-Reply-To: <20241025170700.74440-1-andrew.goodbody@linaro.org>
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


--Oy3ajQP+uSUBqVp1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 06:07:00PM +0100, Andrew Goodbody wrote:

> The config setting CMD_BOOTEFI_HELLO_COMPILE was removed in favour
> of BOOTEFI_HELLO_COMPILE but the usage in this Makefile was not
> updated. Fix it.
>=20
> Fixes: 6fe80876dcc7 ("efi_loader: Rename and move CMD_BOOTEFI_HELLO_COMPI=
LE")
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Oy3ajQP+uSUBqVp1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcb0IMACgkQFHw5/5Y0
tyys6Av/SWwQWa6qq0a4itn8knOwF2bcQ9RV9jjDsCeGq5s8vfWOcZQx1svCveo9
Ewpn2JhwICiTf7iCqYsiRxn357ETnP8aS/UGoDs0I9TRdrp3NcachLCdBYzWXva4
MV52FsjfQddqms9HxGYefGJjOm5iU38lBElD2NBzbU1n3VNS5SNKNsu5xhO1zGEX
cOPiZSozsq96d3H5B9mKUo1Qi5dUPJGJWoiQtk1NrNB92/zCpK53K2JYlIbKZub7
ZUxRC7m1sfByYtY9fGYI+xcZXRHW1EEl7rNEy1tP8KCw+bvijJgW8E+zxLBiTCn3
v2myCCOWXVrw2J+VXGA4++Zx0+BEZpIHn4q030RA8kjXXeIx/b8oxSnezkjpjX98
Aq+qsMmA6/lqNVHHWmfDod1sDCENBY9FgXsvHhsNuC1ZoXAFSiR9enu6TwU8Wuvo
kYZsH6yCKhGbFaSwX0okcmrr6RmRxhZE9CUwHfG5DoyZF+cETItY3Tv75peA/Fro
Ww5gnDAj
=71qK
-----END PGP SIGNATURE-----

--Oy3ajQP+uSUBqVp1--
