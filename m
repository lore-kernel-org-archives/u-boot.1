Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EBCC52D72
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 19:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46C6C86BD3;
	Thu, 17 Aug 2023 21:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wqxs2rS7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0890886BD2; Thu, 17 Aug 2023 21:02:29 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4684386BE6
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 21:02:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-58d9ba95c78so1717247b3.1
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 12:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692298945; x=1692903745;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2+lDzANjWmHJM5/p9YxbeKt1CHuTlSTNOIXd4OsEMtY=;
 b=Wqxs2rS7wHINwGH+v8sipcxNwtD73jJiwpVT7CBtvPGn61xIRiZZd//Qwl5NxP6IPA
 C/DMUTtwHJZ8wl5KKFdu1I2/cWbbMIEEFf5A0o289Vu+qTgVSuaHC7WJ77MmtshKnF0d
 jCpRZvN56T1UIYQN5bPXN0GeepC/0FP2+Q9RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692298945; x=1692903745;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+lDzANjWmHJM5/p9YxbeKt1CHuTlSTNOIXd4OsEMtY=;
 b=XxRgv2P/T4sOMC23VebsJiMPtH3EKVZsAT5iunf82B592UrQI8UQKbI1yTyblbqdSx
 CenfDqzUAoeQs/kCf59KSABL0dR92exn5dOUKqcAhA7uu/F0JDJUOiUrMKEC85zWUu5Z
 1MIhP8ZKv4pAxHbWHuv40RK4YRdSuJQpA0TO/uvdySe8TYxL6KdrZ8YoU4z3e/v/Irmf
 tO5JaYe0jdHrbEcp31lGYvCz3agla3O6NgJjXq0/RsS3tsgwANbPkhSJdJn8wUwG8fBA
 th0hyWaM2I+rdyjxigA9drKe348svYhuWr5G84TJReNL2e2bwi54kunMpUKlHs725UKh
 dDRw==
X-Gm-Message-State: AOJu0YzFhLZ6FFQEGnz3TX+m6QEkBCZCo0XIEfPUGf/zGYoEjIOlYAdd
 colsw2UG2ngP6f06rSUyL9ZFzlBzszP38p2dn0Q5sQ==
X-Google-Smtp-Source: AGHT+IG2hU6sgxqWxrb+CZZZUwCSzN485SAFoYj3Rn/7w4wgCsfxavh8RUHwXvJ2kTgeq3PRAgOe3g==
X-Received: by 2002:a81:4f86:0:b0:57a:2389:63a4 with SMTP id
 d128-20020a814f86000000b0057a238963a4mr289427ywb.21.1692298944924; 
 Thu, 17 Aug 2023 12:02:24 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 l201-20020a0de2d2000000b0057a5302e2fesm48505ywe.5.2023.08.17.12.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 12:02:24 -0700 (PDT)
Date: Thu, 17 Aug 2023 15:02:22 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Martin Roth <gaumless@tutanota.com>, Bin Meng <bmeng.cn@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>
Subject: Re: [PATCH] CI: x86: coreboot: Update to latest coreboot
Message-ID: <20230817190222.GQ1515023@bill-the-cat>
References: <20230811181744.2833057-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h7sYcEpJek3hEBfz"
Content-Disposition: inline
In-Reply-To: <20230811181744.2833057-1-sjg@chromium.org>
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


--h7sYcEpJek3hEBfz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 12:17:43PM -0600, Simon Glass wrote:

> Use a recent coreboot build for this test.
>=20
> The coreboot commit is:
>=20
>    6f5ead14b4 mb/google/nissa/var/joxer: Update eMMC DLL settings
>=20
> This is build with default settings, i.e. QEMU x86 i440fx/piix4
>=20
> Add some documentation as to how to update it next time.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--h7sYcEpJek3hEBfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTebr4ACgkQFHw5/5Y0
tyz6hwv8DGfZjKBKo2S3Jh8/LFvVGg/AkxMe7vY3C1RCFvvTsfKlhK6ri4fzQV/r
lQG86TZ52l58+hVf7HjtroUQEwGTVOttLVde9Vm5SGrTcEw8VtaSu4xycsKl6IF3
AZCPSPchjPfPSyfmp+HXSQ6g0kK3BvdzQmamO3trD/3iRC6GZpGfky/g7F0J+KOH
tvY3+9QEtRXwe4C4wnC3pXRSzjqnJ+zMz8UO857R/8algGEwnfeWjeDJ9ZFgaxK0
tOWB6+ACroyZ9xa0fcCxVKKEm3ZlVmDUejsbLG0ZV/cDtNufkGP+JAJ04WrJwJgi
BJ+8TJSqEkbKJcFi0sCD+Z/ufd4Dojj9WIf9aJDN1bJYbvM+ypR2EJAb1LEhSMW1
zPX/pdk9xDO2E0v/CgfF2QuVLsez4L5cSgbHaE8NaZMidPjCmPwVeARfo4NAoRzL
sEAnCsfQHckHMYqRe5QYUH2TbfM3Jul6WfK41Px+nB2CHw2VLFDKJCf294PzamAz
sQP66EvN
=eMF8
-----END PGP SIGNATURE-----

--h7sYcEpJek3hEBfz--
