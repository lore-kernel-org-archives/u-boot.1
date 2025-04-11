Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E8FC369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 18:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C23308421A;
	Fri, 11 Apr 2025 20:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CYt/n/HT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00A338421C; Fri, 11 Apr 2025 20:46:30 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C071084214
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 20:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2b8e2606a58so1066295fac.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 11:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744397186; x=1745001986; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=phOwi3aCv91gpsE9XwWHNa7vYvkMUD/S1N9orqGHbRs=;
 b=CYt/n/HTIuVnGHJKiydc9OKudNGflzucdofUN1IrMtYuAq6/NXoa0ErsVCyHVnn8cM
 5mgnJRK/fF9Ldary4gLFov6EKwm/QcZv25fphMxPBIyeOohtCoIZTj+fO5c1B2dYhwbs
 iCvvlOfoHuKCMC7jZabKFihI1hAAOFAAbPkTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744397186; x=1745001986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phOwi3aCv91gpsE9XwWHNa7vYvkMUD/S1N9orqGHbRs=;
 b=I7a4PB/4mak0AQ6p+oYSJTVy/v3CgLU6MSkd1SsEfT+tsx0jsIie1vuenDfHaqRrR8
 1Ipg5+xWbwfnL5Fil6pXLBcSufZn7utZG9E3uIE2Tr0UaLCDtpOjAaLZt/ZHqBK9Qk/Y
 CLDxi91AU1qBX85hJnJcVffboFHcXDveAKz3brsY9nVIL4wZ/ezvqUSJSkAEgB01wzqG
 RN5id/pIiha14ScSWBd8vQ3DSTb93ck1S94WXL1RBmQKrl/vGJF35OlUTHAmNbERwOUs
 xNVjulOIXU9Icxpk0uYoAK0lGqVdTpyjzQPZkSwn8MEWi4hL7DqPcvqrICqRzIKiGvxX
 Ct4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp+uZNHNxdEvWylg2kc1LhtFLkaGrdNmYK61nsXzPmItSVQhDR/W4gQNuSSqkgES+Wncd9LhI=@lists.denx.de
X-Gm-Message-State: AOJu0YzfVwJhHjq3UOV9kXDY7LilrfcWGykkdv/Rx1GAiaxOeTQHmdT1
 MJWevS+5mT5sPaC/MVU2hV8wwWSQy/yoz0MM9o69HPBjy1LNwxZ5KrRWr4qHQ80=
X-Gm-Gg: ASbGncujW+k4Q2vrkZLtedkG94YAYlB3cFwUEqnZK8svo57ctvyn/2OF2C78tiaUeG4
 lAuLk8cK1kxMqqH42lzYgHePZqE3BJsCirnf7Z+X61vYFkNGzEbXOSH12qCrFQE682RcYaUgO4d
 RT/gb9HQNQuFcEgJRsso5fw+2I7q48dMqisQWHsHy7pzn1yIGFOvSGxs7CMZZYA3oUcivqsQP6k
 QD1zoQ5Bi5NZ23QGM0ZkzKs/ynvOkJ0TqHbOU+9OvgCuXVKv932rRbwLu7Nejzm7rGpL3Es8wA1
 px7goqwNpgidWJLUJvITy3omK4Je6TMH77k0qVJsUpgZqiSz9GIMKwfLbtmwLjBOALQJNKXWo5w
 zww==
X-Google-Smtp-Source: AGHT+IFHP8MGb3J13RF3qk1M+p1Z/DIBtSdrQWo6Y1hTpK+4xh3Gek0Y3Ue5nkgQJF3+A4l29+TJCg==
X-Received: by 2002:a05:6871:3a94:b0:2c2:343d:1368 with SMTP id
 586e51a60fabf-2d0d5ef2893mr2763090fac.29.1744397175314; 
 Fri, 11 Apr 2025 11:46:15 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d09695a14csm1239107fac.15.2025.04.11.11.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 11:46:14 -0700 (PDT)
Date: Fri, 11 Apr 2025 12:46:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Yao Zi <ziyao@disroot.org>
Subject: Re: [RFC PATCH v1 1/7] efi_loader: make efi_exit_boot_services()
 call bootstage_report()
Message-ID: <20250411184611.GW5495@bill-the-cat>
References: <20250411153040.1772000-1-jerome.forissier@linaro.org>
 <20250411153040.1772000-2-jerome.forissier@linaro.org>
 <CAFLszThbA1fjziOrLFfRwFQ+aP=FZuF_M4cBYsnTZAqEMr8LTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vCRz+QWbqVkKQyzm"
Content-Disposition: inline
In-Reply-To: <CAFLszThbA1fjziOrLFfRwFQ+aP=FZuF_M4cBYsnTZAqEMr8LTQ@mail.gmail.com>
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


--vCRz+QWbqVkKQyzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 12:32:12PM -0600, Simon Glass wrote:
> Hi Jerome,
>=20
> On Fri, 11 Apr 2025 at 09:31, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> > CONFIG_BOOTSTAGE_REPORT is currently supported in the bootm command
> > only. Add support to the EFI boot.
> >
> > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > ---
> >
> >  lib/efi_loader/efi_boottime.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
>=20
> If you have time, could you take a look at unifying
> announce_and_cleanup() with the duplicate code in EFI?

And the duplicating code in arch/{arm,x86,riscv}. Maybe there's some
good place we can stick the bootstage calls, board_quiesce_devices() and
dm_remove_devices_active(). But maybe not, I'm not sure honestly.

--=20
Tom

--vCRz+QWbqVkKQyzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf5Y2sACgkQFHw5/5Y0
tyz5tAv+PucXuRQ/fu9LOzUZfUAUW7IrjGkqHR6vFGYw6Bf1VIyAxOACV4uFhbj9
tz0AX93uaWhWoIaYyl8LFDpz0C3XYENVIJGjOTC0IphPwShujEArBwryHUIy/6XU
XUo3+6u541mJAmFIxpeFvXzmhqo7UXMs6fJCliqplEMBEuheiYPyR6D3rNzg1PzC
r2RWeixeSUk14b6vdxRoq1Q1Mu88ewfEnOJr8lfHL6f2+PiDesRh8KceNg/p+9s3
VXDllEIbc2y6zoT54wQa8p0b9OoLeS6UVblqrKl6H6zFF3H9RtnSpxgQxNgZTtpC
nwvbnH3UiZY7uAfuFR0C09p1dUmcxfdrl0hHx9zvdjoewun2pjfosFVkA8qmKSk1
8M1STurdZXCQIEhMoSwkDKKCxSW1ranVNfpfwTeccebXvMqO1oCDrfovOyCgnQIe
aMEnL6jOo524H2c1u27aM3VXQAC98kSdockYpTjStfXm+VAA/+Vu21ApNfsh51Lv
7i7ZE6ki
=ZAB1
-----END PGP SIGNATURE-----

--vCRz+QWbqVkKQyzm--
