Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA695C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 16:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1AE0887BF;
	Fri, 12 Jul 2024 18:07:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wph8XjcA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57805887CB; Fri, 12 Jul 2024 18:07:41 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2540887BF
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 18:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5c690949977so1115228eaf.1
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 09:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720800457; x=1721405257; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TnlwrcuDjVeKB6k1uF9IH25T+eajAPJtXigkfRaN1bA=;
 b=Wph8XjcANpE9x32jHsSYArR+NdqeZBgIH4JGgp726585qkZesTKdWSy5yBuwOkCH9V
 e8XLbvG5Lyq/GGpzItYIcwoKwCQVsgW0f4YTV+Xhy9LCNwXAPSAlshcqQUWgsNHdsuhv
 8HJWWUyAs7RRabA/ozfmfmwfsJN1rh2PyN/HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720800457; x=1721405257;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnlwrcuDjVeKB6k1uF9IH25T+eajAPJtXigkfRaN1bA=;
 b=D/8a8nT7TrEqlO+W+MP2WKuTODYurr9XjwADR6sq1TQ7zghRvAojHJEv5GqLNUDqky
 UiyhixEmpocPIq9Gdhdqfsxl/WxtrtUquZMalmM4hJPZK3uAVhUuX7I8RRzbqrq5t6fc
 PPLU10GzGuPo7EM0vhWxwHiHgWXvS0kFbYTivDBz3KAuK4dHT1aY7PlxrQOftdkkGPJF
 eSjkXkaINnlY/LTRH03KwZR/s3yaslUPp95g6YMtYet+DL3vWhFhf50F0Ue7l1wjHOsn
 p9JPSbmXHPUMqZIrgTTTVjb4cGv4fiFxRsyIPlpZdVHstEJiNHVrt0xG8vwtJl0lzhP9
 rPJQ==
X-Gm-Message-State: AOJu0YxVkov2IMw6HuLATIUD7rmqxelRIkeeiWaT/GaDkmAP7PwDjide
 C4t57+qT8CrxJVx6pIkh31wVacUr5chgp+8cOX9sqlui/7tyfiS7WOV70AlQCZ8=
X-Google-Smtp-Source: AGHT+IH/5B8OV6XhY8GQ1lUlrW4jjnhSDba4k1t+dCvuf/LF3QehZ3xUBlf/g2o04trf/zkrq1ZZHw==
X-Received: by 2002:a05:6820:308b:b0:5cc:64e5:d002 with SMTP id
 006d021491bc7-5ccdfb804f4mr2538135eaf.8.1720800457596; 
 Fri, 12 Jul 2024 09:07:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c68cd72a81sm1165794eaf.9.2024.07.12.09.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 09:07:37 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:07:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20240711
Message-ID: <20240712160734.GR38804@bill-the-cat>
References: <87bk34m5w9.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J3fsvXeBHRzYRM/b"
Content-Disposition: inline
In-Reply-To: <87bk34m5w9.fsf@baylibre.com>
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


--J3fsvXeBHRzYRM/b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 03:09:58PM +0200, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Please find some new developments for master:
>=20
> Usb gadget:
> - A welcome cleanup: epautoconf workaround is dropped to use
>   .match_ep() instead
> - Introduce handle_interrupts() op for USB_GADGET_GENERIC, which
>   allows a per-driver interrupt handling
>=20
> Fastboot:
> - Fix mssing include when building with TCP only
>=20
> Thi CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pi=
pelines/21552
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit 7c9c5c0562347dccb8ac89148784a34de402ea=
9e:
>=20
>   Merge patch series "xtensa: Enable qemu-xtensa board" (2024-07-04 16:11=
:08 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-20240711
>=20
> for you to fetch changes up to b091d3872833a4b8d088ee41348a2d4ff48067cc:
>=20
>   include/fastboot.h: add missing types.h include (2024-07-09 09:15:37 +0=
200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--J3fsvXeBHRzYRM/b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaRVMQACgkQFHw5/5Y0
tyxTWgv/ZTeCAfwjNQaELaBerwA2NRzpYOdRDSGUaPn68LboTPFdUW4S675yVP6m
PCcG41UDpZlLFZ9BK/Jd6zslH9qE1v/7YZctDvObBiBIf+vmlpf0+zmRijGiNGo9
5s6TLgztfqXWG3qebXxjnCzzBa0jyJvARoMdo4ad6HhfjNzRjmzYRDiaCRj7Lws1
sWpYuHExJrsdHqU1X0A4X2LdK4alVF0fNSteLi2ghXQQ2ST1jnGH3OXNb6cd2fWX
w+Gi66Fr5ncGfuTccJv6XvUAs43BjYwKJlW+08e+bZjcjFZj3SpKGa/j8XNMZ1Z/
DhzvLCiWsOzrf2Ahze2l8wjbL8w3Fh77JSCf1lSmf72XctnPiT0W1GEhyVi9ZEV5
w2E+709P11i4Th4lNP6V2eKJGeRNMoSQRyfbytoZOfC2TL1ZYIOhMg6Y4C/6gd3K
nRVyJNRS2sZLAuQvxmBZn/zJ4yeNH6C4S9xB5bM9KDCsF49SR/mQz68hvDt9fq0B
4v05x86D
=sONg
-----END PGP SIGNATURE-----

--J3fsvXeBHRzYRM/b--
