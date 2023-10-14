Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA21CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 06:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D5BC86EE2;
	Sun, 15 Oct 2023 08:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OFz3HuBG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F52086538; Sun, 15 Oct 2023 08:23:55 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8C26865B9
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1dcf357deedso2048020fac.0
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697350965; x=1697955765; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GTWqIpe2EdJalNqjIkwZKEHsWJsNwB9xc4ncHuBKMSo=;
 b=OFz3HuBG4yq2dGDuwrcUeWtenf9zZogRwaigpa3lCzlKwrtH2wmq6HLdM2T+3mHkTH
 XM95O0ImqLRhagt9IiVcF0r9jLxi/4S6SrfukxgCWsNlmBcj62zekbM1VOnlBk8xIjn0
 Tk+9ngoMUXEm+zd75GtkAud6xL2+ItLg3IxAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697350965; x=1697955765;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GTWqIpe2EdJalNqjIkwZKEHsWJsNwB9xc4ncHuBKMSo=;
 b=W8pAQu3Pd0knVkVMpFeJkoq50iBP7nZVOMNndhkqhNWqAUPSrjTGX9aIqrD4qMI2dm
 3VigRdoDwLciBluraSgCRemuenbmhCWz0kvWI7DPdi3kAfWnd8hp48yvOB/KGKHOQqzu
 XWaU+9Kcm5FbDuPQHb1SiFJ+fX2FcTNVP+wzAz/e33JHbP/EWtASwUbZ3hEgsUfzuM6+
 e5ScfPu7/ou5XaT77wiuSLhG1awDvQVnVCtUoJv4alsIv84egfv7JvqXobrzulwyn0x+
 SWRrowPbyQxg1RlOWrOH8tuuJ/VAK4Ww5ir/NxODm6CXpxVZ4A28A4qShiNE8fDQ+ICi
 nBfA==
X-Gm-Message-State: AOJu0YzYENA9DJPx3VWX5FYnnj21GOt7uYhYvuGGiINMBJ2Y8PZ4qnUL
 /IJp4qKoyxLnaM9lJHAUVZE2bBJiHY4h0u7nU5LsOA==
X-Google-Smtp-Source: AGHT+IHVrrysaXPv4QB+jBaUVRhFxJRJqmpmH12XXrB/rbAnMc4frBX7ImJ2wscVwfRhde0JUz8B7Q==
X-Received: by 2002:a25:ac5f:0:b0:d9a:c4cf:a06a with SMTP id
 r31-20020a25ac5f000000b00d9ac4cfa06amr7674969ybd.36.1697294968110; 
 Sat, 14 Oct 2023 07:49:28 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 vu8-20020a05620a560800b007743671a41fsm1519297qkn.72.2023.10.14.07.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 07:49:27 -0700 (PDT)
Date: Sat, 14 Oct 2023 10:49:25 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: Re: [PULL] u-boot-usb/master
Message-ID: <20231014144925.GW3119521@bill-the-cat>
References: <20231013192414.18833-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Oe+HcXIIBAQUxcoD"
Content-Disposition: inline
In-Reply-To: <20231013192414.18833-1-marex@denx.de>
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


--Oe+HcXIIBAQUxcoD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 09:24:09PM +0200, Marek Vasut wrote:

> The following changes since commit 86700279645921fb2c28c41711deb7d7ed75bc=
29:
>=20
>   Merge branch '2023-10-12-assorted-TI-platform-updates' (2023-10-12 17:0=
2:51 -0400)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git master
>=20
> for you to fetch changes up to bc8e94c902d8b5a24d6b31963fc26058b54986ef:
>=20
>   usb: gadget: atmel: fix transfer of queued requests (2023-10-13 13:42:1=
0 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Oe+HcXIIBAQUxcoD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUqqnIACgkQFHw5/5Y0
tyxHsgv+LHckOrqy0dcP1FVdTBfv0sIARjEOzM/ORahAq6Zv/0yTR+gICn+AjC0D
3hmzy8bdFjlImbNLS9x1FnFrM8t8saBJyCNIF11BFRAz7AKqxxtayUvg1EgZHg1I
x5gz0CpXQdqF2Mp46NniUBofd9iYqmblab64O/SOrkEM0B8MTN6fz1ZlrhUhog15
vrSAN1D4FxQsNSC7HHpgVgL6iKSOOXJQDwKgpkD6ujG+7wuAEdY9cstryiSTF20S
QgzdVa6qNzRuQx2KjwVw7LnNBqjhsXUlGLeTpE2E9IIlVvpCVthl4fy5rSh8jHuk
N0Yf6dERwqSBFfNOfRg2f+FQdlPyoLNdn6ThQ3U7jgsaXr/sESRs8iz6tHkZ3Wu5
Fx+wWSjy1e4TtmX2N0Zue7f16UQh9rFfcvWpjkGopBKIkT7k6ZwGndik0UCxocqC
H150gN6xkG0Nsg2YGxt1ePtRTrqQl1rwQcWcw9OmUinz+RnQKDVYvX+evo1cqFOB
fPDbFKcy
=1RHC
-----END PGP SIGNATURE-----

--Oe+HcXIIBAQUxcoD--
