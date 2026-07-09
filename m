Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C64C44501
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBB8F84BDA;
	Thu,  9 Jul 2026 15:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k5fuhAln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 567F084BDB; Thu,  9 Jul 2026 15:44:19 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A2A584AFF
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 15:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7eb29ed2bbdso292967a34.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 06:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783604656; x=1784209456; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WdlXiEhUp8Rzcdf3df+jSREY5ethQ8mHb/zsQlcQeZ4=;
 b=k5fuhAln1N0UIm7LG8lkWR8AeE9hTNAzKLC7e9vS1jlLkLqZRHyuWjJNXW17Ak2uuG
 kp/TsKBj8EJ/huwz8bHV6B5S8APWcm8u4k0pXkZg42kCZfL90qDSMrr0VxFL2OiQV5mF
 aXc9nOJgwSO2GbE0U7k+WA/J7O7Fd5vIETxrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783604656; x=1784209456;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WdlXiEhUp8Rzcdf3df+jSREY5ethQ8mHb/zsQlcQeZ4=;
 b=XZhP6gYtE6Rb/T6Bs8u0JHh0UVe+EqWMxCbaK1vmm6EHzLYmoN+fUXycYIneUlKY4q
 ilR6XqnFFgCbvqMiEwIywDM8oxT6NRZXxBGs7sYsmV6nMAFQfvfuubhnJl/vvv0FwlcT
 T+dTXXh6rGLVOXkI+2FqntsnO2tslDxTDaxeI0mV8nahdufPT1r5Haq/YY+Nm4+2Ixpc
 onuCLtk08eIeuEMUHWksj8HzdE8wVwtLI0XcEEL/4yFdXfH1i80daSj9rQmlzLcErVPj
 cCq2rsHcy/Lve8OF/UQBT9JYbGpuP/s8Wa1FPgxpN4+t10WuWyVp5gITMNgjLTMutniw
 S9GQ==
X-Gm-Message-State: AOJu0Yzg5uiZrbQnk5M1S7KoedLRC7t1w9walBo+QDyuW3YUoC+VuJUc
 DirTtyxLJolnw+t8Nz1SjWTtnq4F0irendRnc4KcxH8d4LD5jciPW2TiiCtbv43JunOeWuQVWV5
 8sWDmfFs=
X-Gm-Gg: AfdE7ckqzEaGEKyDBx+lRrA16ijTDaQsW1Rh6/62ysTr7Bqa3HjfvSQuEOc5tVhfqnR
 aqg0FNnR4JEq3nom5+4Ovuqatu713LbRBlFFq6vTp2PXYWOIEfM3NzPW/+LY3Yg8hPcb1H/rI6v
 33P9IdM41J5cmW9cgo0QohkuKvIOgZf8iBoGuU5aT7EagWFdCSGC9UxCFxv7WVDDKCpp+5QRTCS
 0e/Hq8/BvS4uVsAcVzr5ZZ5o3WXM0tHbEadAUp6Fib8tg31dLQkcsJHIM9aV0254Mx5MponVSq1
 F0108kskbJOhRy6TfqRh+DfgQayk+5CLqR7YuHRBwuatmOYgG+mqfNaaF7S+qqOFsJyKfWhfoer
 +e4lGZmAoJY+Pm+b0lmwlEWjfEtNkTC42rA4COE/VDdkznurAdWWsnJzI8LXj1n+qrgGu0I6RIC
 otfpuw9avXyRcgUKqWHVGbLtNLDJ/Adw+dyWWUv8AHpQiSx/3+3ESTraVbxGGL/toMM9fdLsZzl
 r40TcYlpApHKlcGg7TL/yaoU6Ye+AzykjRJDA==
X-Received: by 2002:a05:6830:6737:b0:7e9:b4cf:683c with SMTP id
 46e09a7af769-7ebd0033de6mr5427296a34.28.1783604655739; 
 Thu, 09 Jul 2026 06:44:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcafda2ffsm4116946a34.12.2026.07.09.06.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 06:44:15 -0700 (PDT)
Date: Thu, 9 Jul 2026 07:44:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 09/11] Kconfig: serial: Depend on correct xPL symbol
Message-ID: <20260709134413.GY749385@bill-the-cat>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-10-jonas@kwiboo.se>
 <20260709015300.GT749385@bill-the-cat>
 <c43c2a98-b6aa-46da-a74d-0601287534c2@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nKdEE1LJxJKlM6Dd"
Content-Disposition: inline
In-Reply-To: <c43c2a98-b6aa-46da-a74d-0601287534c2@kwiboo.se>
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


--nKdEE1LJxJKlM6Dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2026 at 09:27:07AM +0200, Jonas Karlman wrote:
> Hi Tom,
>=20
> On 7/9/2026 3:53 AM, Tom Rini wrote:
> > On Wed, Jul 08, 2026 at 10:05:35PM +0000, Jonas Karlman wrote:
> >=20
> >> Change xPL_SERIAL_PRESENT symbols to depend on the xPL_DM_SERIAL symbol
> >> intended for the related xPL phase instead of the DM_SERIAL symbol
> >> used for U-Boot proper to make CONFIG_IS_ENABLED(SERIAL_PRESENT) guards
> >> work as intended.
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >> ---
> >>  drivers/serial/Kconfig | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> >> index e221800d5d06..f125061fe184 100644
> >> --- a/drivers/serial/Kconfig
> >> +++ b/drivers/serial/Kconfig
> >> @@ -71,7 +71,7 @@ config SERIAL_PRESENT
> >> =20
> >>  config SPL_SERIAL_PRESENT
> >>  	bool "Provide a serial driver in SPL"
> >> -	depends on DM_SERIAL && SPL
> >> +	depends on SPL_DM_SERIAL
> >>  	default y
> >>  	help
> >>  	  In very space-constrained devices even the full UART driver is too
> >=20
> > Using the database option to qconfig.py, this is not equivalent. There's
> > 901 platforms today that enable SPL_SERIAL_PRESENT, and 344 that enable
> > SPL_SERIAL_PRESENT but not SPL_DM_SERIAL. Now it's possible that there's
> > no functional change here. Something like "pinetab" would be a single
> > platform to check the size changes on as it's SPL_SERIAL_PRESENT=3Dy and
> > SPL_DM_SERIAL=3Dn.
> >=20
>=20
> This discrepancy is likely due to the 'default y' and the strange
> 'depend on', based on my observation xPL_SERIAL_PRESENT is mostly used
> to guard U_BOOT_DRIVER() and other DM related functions, so I do not
> expect any functional change after these changes.
>=20
> Also did quick build tests of pinetab_defconfig and there was no binary
> change to spl/ before or after this series.

OK, good to know, thanks. I'll grab the series and do the world build
before/after test.

--=20
Tom

--nKdEE1LJxJKlM6Dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak+lrAAKCRAr4qD1Cr/k
ClxyAQC/uzcQH5OFxX7J8LocMNSFmXpMqEpWnoOVEgksGk7BXQD9GiEMK4I6Ctni
EySZbb0KPff/Cf7Zl6UtOXR2hu9CtAM=
=HcRE
-----END PGP SIGNATURE-----

--nKdEE1LJxJKlM6Dd--
