Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77B4C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 21:32:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F32EA81FAB;
	Fri,  2 May 2025 23:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FBw5KlXZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FE6C820E1; Fri,  2 May 2025 23:32:26 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C81B81F7E
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 23:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4034118aeb7so341897b6e.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 14:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746221542; x=1746826342; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XpmSzQG/9RIHz9V9peHobSt9tznU41tEBPhGVhvbphw=;
 b=FBw5KlXZNBbpiJBPvN44/HSNDmRpOIH3wQbhVIAb8HEzkCSolylO3ZpUo5JTRqSrJb
 KbHn0DXsun2Y6iV1jLTUTdqkNiM+eezsn//MsOemT+tejTDe1pyi34VCbYQU2P44KbDm
 2USbyrp1wAgXHErrXwycJJg9XGouVr6rZGy+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746221542; x=1746826342;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XpmSzQG/9RIHz9V9peHobSt9tznU41tEBPhGVhvbphw=;
 b=mJPj/+oWfHiiCcYZRJexpDskyYGIsk6Bu1qqHvPwFubaDjNrHla43ThLK4mm/MFPg3
 Q2BaXHEr+QNK8ra2YffPhOd/K2cFQ6C1GBTPIQTd4vN4BXIE7UySv+fGDYzQJwQadwbv
 mQF3EQBqBdez2cX9kfjvDG2tHgDw7CssI2XOA4Hc98LkQEB3LFC7VkGv4lz1C02pgZNG
 QvW3wnuEtafy0DsRhwWZCVstJwmZFpDLGyZJdzwTbZYu8sUiaEJOHGfuMhy5/yJfmTQ2
 emZV62n2HMiZaVHsAZiEIwP9krHMoc1rt+jNTh5IS7FCWkW8YLRv9HU3D7sNbP6pYO54
 zRvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe9I5Z2VZ31lXfJa3Sr5EOZno5ecueFOssilHUUuJK8NwRxK1RG8z7bw48/XGPk/CFaJo6qpg=@lists.denx.de
X-Gm-Message-State: AOJu0YxIUJ1oM+basjJq18Da/91zvpdANIYxMOz3Ad0EzgorBTpwL7HH
 vAM2kefK7EA/cd00XHWJ2gpjPW/9jUJ8D4hQvQzh3ADyJwNnZ0ht0q5OkmkcK+E=
X-Gm-Gg: ASbGncvi2xUZ8INCwsE1DRRkgGxqmFaW9oVuHCumbUQP8tytxtgbYo8Jc+2EAauYVa6
 Bo2QoOVXnwkHg0lM4hve8zEb/qLPYRR9intNnyQnPTY2EGDyU62rSVsYz+hTWd940sUKEFdP4o4
 Kgvh8UJBQCsik/+iSCj424RVcz3wf3/pGiyBwMJDRqCbe//58NriLa4L7WfY16WG41wLS17/prs
 fCy+1AFevyIxtlnd85EGSHt0XGWAnXz3wyZkoCNOjKySMVs/fFRiG53eEXDHHUJW2cOUEM74gZ1
 v2IEd4NtPtdpPzGgN+gqi2aS8MseRhkb3L+shus4Pe23MAxvtl0pMEiU80hE0cYABLtiDwXwzeo
 vqw==
X-Google-Smtp-Source: AGHT+IH57pVJ8UTlSbggvxJ3fIKmlYYcHKB6exZXy7YRirqW+AcDQu9PKAgpO7k7fW34hae7ony0Xw==
X-Received: by 2002:a05:6808:3a0a:b0:400:8252:a657 with SMTP id
 5614622812f47-40341166234mr2823318b6e.5.1746221542184; 
 Fri, 02 May 2025 14:32:22 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4033dc82d91sm751941b6e.44.2025.05.02.14.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 14:32:21 -0700 (PDT)
Date: Fri, 2 May 2025 15:32:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Sukrut Bellary <sbellary@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Raghavendra Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] Add support for eCAP PWM and LCD pin mux
Message-ID: <20250502213218.GA1379719@bill-the-cat>
References: <20250423084249.197101-1-sbellary@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZU5a2h+jbQWq8vpY"
Content-Disposition: inline
In-Reply-To: <20250423084249.197101-1-sbellary@baylibre.com>
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


--ZU5a2h+jbQWq8vpY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 01:42:46AM -0700, Sukrut Bellary wrote:

> This patch series adds the support for
>=20
> 1. In am33xx SoC[1], enhanced capture (eCAP) supports auxiliary PWM (APWM=
).
> This series adds the PWM driver support for the APWM feature for eCAP on
> AM33xx. AM335X_ECAP0_IN_PWM0_OUT is used to enable the backlight.
>=20
> 2. Fix build warning in ti-ehrpwm driver in dev_deb().
>=20
> 3. Enable eCAP0 PWM and LCD pin muxing to support splash screen on
> AM335x EVM[2].
>=20
> [1] AM335x TRM - https://www.ti.com/lit/ug/spruh73q/spruh73q.pdf
> [2] AM335x EVM - https://www.ti.com/tool/TMDXEVM3358
>=20
> per discussion on the earlier patch series,
> https://lore.kernel.org/all/20250319202516.3300444-1-sbellary@baylibre.co=
m/
> dropping the device tree changes in this series due to OF_UPSTREAM
> conflict.
> As we are dropping the DT patch, started with the new series instead of
> V2.
>=20
> This series doesn't contain defconfig changes since we don't want to
> enable LCD, splash screen and PWM support by default.
> Enabling splash screen and PWM support in defconfig causes u-boot crash
> on AM335x based beaglebone black. This will be handled in a separate
> patch.
>=20
> Sukrut Bellary (3):
>   pwm: ti: am33xx: Enable Auxiliary PWM using eCAP
>   pwm: ti: am33xx: Fix build warnings in dev_dbg()
>   board: ti: am335x: Enable eCAP0 PWM and LCD pin muxing
>=20
>  board/ti/am335x/mux.c       |  47 +++++++++
>  drivers/pwm/Kconfig         |   6 ++
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-ti-ehrpwm.c |   2 +-
>  drivers/pwm/pwm-tiecap.c    | 198 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 253 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pwm/pwm-tiecap.c

This currently introduces a failure to build on am335x_evm and other
variants of the TI EVM:
       arm:  +   am335x_evm
+(am335x_evm) board/ti/am335x/mux.c: In function 'enable_board_pin_mux':
+(am335x_evm) board/ti/am335x/mux.c:435:50: error: 'lcd_pin_mux' undeclared=
 (first use in this function); did you mean 'nand_pin_mux'?
+(am335x_evm)   435 |                         configure_module_pin_mux(lcd_=
pin_mux);
+(am335x_evm)       |                                                  ^~~~=
~~~~~~~
+(am335x_evm)       |                                                  nand=
_pin_mux
+(am335x_evm) board/ti/am335x/mux.c:435:50: note: each undeclared identifie=
r is reported only once for each function it appears in
+(am335x_evm) board/ti/am335x/mux.c:438:50: error: 'ecap_pin_mux' undeclare=
d (first use in this function); did you mean 'nand_pin_mux'?
+(am335x_evm)   438 |                         configure_module_pin_mux(ecap=
_pin_mux);
+(am335x_evm)       |                                                  ^~~~=
~~~~~~~~
+(am335x_evm) make[3]: *** [scripts/Makefile.build:256: spl/board/ti/am335x=
/mux.o] Error 1
+(am335x_evm) make[2]: *** [scripts/Makefile.xpl:548: spl/board/ti/am335x] =
Error 2
+(am335x_evm) make[1]: *** [Makefile:2119: spl/u-boot-spl] Error 2
+(am335x_evm) make: *** [Makefile:177: sub-make] Error 2

--=20
Tom

--ZU5a2h+jbQWq8vpY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgVOdoACgkQFHw5/5Y0
tyws0Qv/cTQdDPoDZd06Dk8Ec9v+Av8NnmASomUJOp40zOXaJ6ZpJkJziaGFlagc
xldivjlLIx0T6K7lkQjDN+jZrzyy0zH9XmUVf/J/lHPef8ymSNPZkwKKpUQq+Uf/
lVECD5aDQgb0pK5Zr4I2dysjxgDnch/iJTNfTGKSfS7Nm1QMePanBf1xdGXYFTKg
6Tvz0OVS6S/8hC446tj+qW1Zd8MK+XBaRBdNUM5X533gBOH11txDIJ84P1Wu+xnG
5x+hSho1XP0j1V6UAznD5Dc+eLXwipSxGK0vByLabsJ1mWvTM7zoFKm2vXCvNdPm
DvdSE0uMiAoU4uhb3k85EqjrEAp4WXgTdGysTQfAwwLofFZEKgNJYcIeGw5NUTjf
U12mYvd2UvRkjfddFNAPxGgf3j7+l5vuZf2bgCHPAypeea3Hk6Zu+MjPslo9MWhn
op85BCJyY5wgkyphvu0/Og/n9Ik9RtrUsioRcKLMUhvB6VuwbCWTsawVQ0RlUUW7
VxwnVIK8
=dAkJ
-----END PGP SIGNATURE-----

--ZU5a2h+jbQWq8vpY--
