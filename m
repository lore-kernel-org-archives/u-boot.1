Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BF4CF3975
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 22:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77FE4892EE;
	Fri, 20 Sep 2024 00:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q1F40m0X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A376D892EA; Fri, 20 Sep 2024 00:06:18 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A6F8892E4
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7a9a7bea3cfso98730385a.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 15:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726783575; x=1727388375; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7uuoRho71XFgrDqNApF69GwC24gqWBW+lQsnU1JEeQk=;
 b=Q1F40m0XfEuG1ifmIMR6vNQwraMhJ9NdC5tlL3vQ5lqNOoTjJbQ+7OKJQHj6s85q6J
 OpmNRLnQRyr8PdzPFt7pwT/AHxlY2X85U0wwoMq+pT8LGUCd+IFEvk1RVQzxnU2DPDeK
 fm0dKd4Ha8ACwIFKpe/gV7YvuWFBXvXAL2eI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726783575; x=1727388375;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7uuoRho71XFgrDqNApF69GwC24gqWBW+lQsnU1JEeQk=;
 b=F6pi6hel+RxHsI5LoBzVLruDlNy32DRpxC7JoMlB/8llOzotiKQya/Z0ZPWzSu4xdC
 w7QStHF4QwiDk/oMeJXVzzG0TqRylcM8Ki4hUs8lhjBwhhye7yJtaN0e9HwosMVE8mrg
 ALcY1L+rwALxr1e/bVnsvFJ3fhVDmPYJJWJw9BxEXmj54kTJqVD1r6P1vcg/lROBj2u8
 DsbZJPpvp5pVCfPK3Rgmw8Wzvb+YcVJ60/qPy0oLlK/rUgm7iBj18d4HUZ/dGuLWVxN7
 8RtBc/MMqTvLT44w8+3Hs27RddVBxpe12XQbfiEemW8+B2PrHZfGT2ptrni4xvqswgVH
 /0aw==
X-Gm-Message-State: AOJu0YzZinw8McMP3CJIZ/ItELxyToZ55+ekpSqwC5i9xFUlOdXBSZcN
 bRq4w3illkKAAnpLMBTF1dAgKTnw7hebz76lgmWRbf16gpRL4Jc576lu0oc+6Kc=
X-Google-Smtp-Source: AGHT+IHJ/iXz60kWPc4im2Ir2351b9XFU5T7drokOsWfU+eQK8/Zw7CXNGfZhnIG8b+UvG6tomnUUQ==
X-Received: by 2002:a05:620a:440e:b0:7a9:ad65:f4a1 with SMTP id
 af79cd13be357-7acb8d91299mr72641085a.26.1726783575081; 
 Thu, 19 Sep 2024 15:06:15 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acb080a003sm111829685a.44.2024.09.19.15.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 15:06:13 -0700 (PDT)
Date: Thu, 19 Sep 2024 16:06:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20240919
Message-ID: <20240919220611.GX4252@bill-the-cat>
References: <20240919115734.3594662-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d9+GHhPSK4x84B7K"
Content-Disposition: inline
In-Reply-To: <20240919115734.3594662-1-festevam@gmail.com>
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


--d9+GHhPSK4x84B7K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 08:57:34AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/next, thanks.
>=20
> The following changes since commit c17805e19b9335e1fb5295c81b59eddf88d1b9=
ec:
>=20
>   Merge patch series "Fix various bugs" (2024-09-18 13:07:19 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-next-20240919
>=20
> for you to fetch changes up to effe934e50f03c92ba6febecfe132c9cb34ecf59:
>=20
>   imx6q-lxr: Add board support (2024-09-19 00:13:20 -0300)
>=20
> u-boot-imx-next-20240919

Applied to u-boot/next, thanks!

--=20
Tom

--d9+GHhPSK4x84B7K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbsoFMACgkQFHw5/5Y0
tyya7wwAj4tpNgsWXQlMsO4JPxBQRzYfUtkmgtkiN32hhRJrDFOsRvfK2NQndRJ4
+rwf40t1/Z38YgzdE5/ulqOXxOH8Gf8umXYfYkKIoxgc2WJNf4UALlvZ2m4R8/EV
0e37QdbAenbbXlBgdJvvxVgMyxuaB1eKIKS1Xig3d/W3Frs/gYn5AXcFWlq6VjYq
zzn3T//kEEe5aTxefLlyQ+1aDlgMiUFRCvxzFMGDcRCmOj1gqakzksXgrRwR0nVl
5x68X4L8d6Nif9CQm/GalM+H0hmuC21Y7FVmBwLa7cgyvaSF3sNCYawqZMVj06yF
tz7ckAfA1UlaJv8GTaBEWKX4TbA2EcRMwTB824b/LUKqHXlY/okhu1TcVP1qYz1f
6JJdDAirfF6ZQ3thOixBzl3ZunJYaLKH5dSyXWKAhZrWI4XflykLRmlkYG6//o60
C6EhhV2Z2dam7InnoCOFjJhuf15HuQ3rhn/4RjxC9ux1VM7BysW0mqkTwO73Uypw
rr8DA75s
=9ash
-----END PGP SIGNATURE-----

--d9+GHhPSK4x84B7K--
