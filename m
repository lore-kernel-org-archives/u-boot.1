Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3F3CF3973
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 22:52:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0CF8892AF;
	Fri, 20 Sep 2024 00:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hkJ0oGwu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A87A892B5; Fri, 20 Sep 2024 00:52:16 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EBC288A24
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6c3561804b5so10138066d6.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 15:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726786333; x=1727391133; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6dj5tRZSHYWj62+si7aUqHRT5Ayf9pqO/p01Dnbrup8=;
 b=hkJ0oGwuzvlqGQ+HbiIWjb8hvBAv29cA2cGmYoElFHCWfL0kL6pimQC8VlQCyNGwkq
 BJgLB2/Mr/Xbx5/qv4i72x/YjeAGCUJP6w/t+qp5Cdqsyf9wV1DrJd4jpQIq/cBCqQuU
 1nZyTYwAKRTrMoX+l2ANRl4akXa8e+crRdzmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726786333; x=1727391133;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6dj5tRZSHYWj62+si7aUqHRT5Ayf9pqO/p01Dnbrup8=;
 b=k99hEWAoFqMoqeJAfaPiQlgfp8BfrQdy/SSTi+kdqjo/Vafjd81+RSiRN3xqUApKFl
 Vqt83w00Sc76Y0irmnBkIKPXfuEYayVCcw7jeGGrIpjCeyqHlvTTMZyBq2krzN9bNMAE
 qpE3V6G0FmIZ7W8xA3vCo0fI9KM63ITpKBPM2r+sl7+RANVWe7k4lCggSyUHai17+ZwD
 6lTGD2qDZnmNnyCFJvG6uGBnnfNtKafUneySrNlfhXfJHaMjkqI0Z+WPk6booxO8AFnR
 H50eb2se6SZ2/gOlAEbJGiJpruXg8lGs5Ehot12Y+tHnRhvTI6n93p/Ha2zzsvnmR+eY
 fIgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmOK9FzNvoa02EpHqKsOSqrqj/o2IU86p/i2R6uw33GIn2KTE6H5JezVYPHJsEyfwzA59j7QY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4I2HSPJE984H2mKBgDF8RNHGYEJAEJSwqhcXpaRL4tco9VwDK
 l7MlwPuitB6eGv/B+BT6jc93zjwZ9MtvbtTtu6BCpUmHiLV/uoWnQfM4DVtOveo=
X-Google-Smtp-Source: AGHT+IGujnxv6/6dGZb7Vl/dJhaxxafuWLVNxvMKPh+pdP/mCEsWXQTU05XpG8B7Dkxif824zfXqhg==
X-Received: by 2002:a05:6214:320b:b0:6c5:3177:eaed with SMTP id
 6a1803df08f44-6c7bc810717mr11657316d6.36.1726786332948; 
 Thu, 19 Sep 2024 15:52:12 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e461437sm11537926d6.41.2024.09.19.15.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 15:52:11 -0700 (PDT)
Date: Thu, 19 Sep 2024 16:52:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 14/30] efi_loader: Allocate and write ACPI tables
Message-ID: <20240919225208.GY4252@bill-the-cat>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-15-patrick.rudolph@9elements.com>
 <ce2fa4a5-bb75-4dae-b035-405af0870991@gmx.de>
 <CALNFmy2B_iObakJ83eXYvPEOJ4Ecf20-8S=s30fpBQwnwPNhMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h3991j8nOgpfqsBp"
Content-Disposition: inline
In-Reply-To: <CALNFmy2B_iObakJ83eXYvPEOJ4Ecf20-8S=s30fpBQwnwPNhMQ@mail.gmail.com>
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


--h3991j8nOgpfqsBp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 02:45:30PM +0200, Patrick Rudolph wrote:
> On Thu, Sep 19, 2024 at 2:39=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@=
gmx.de> wrote:
> >
> > On 11.09.24 08:24, Patrick Rudolph wrote:
> > > Allocate memory for ACPI tables inside the efi_loader and write out
> > > the tables similar to SMBIOS tables. When ACPI is enabled and wasn't
> > > installed in other places, install the ACPI table in EFI. Since EFI
> > > is necessary to pass the ACPI table location when FDT isn't used,
> > > there's no need to install it separately.
> > >
> > > When CONFIG_BLOBLIST_TABLES is set the tables will be stored in a
> > > bloblist. The tables are still passed to the OS using EFI.
> > >
> > > This allows non x86 platforms to boot using ACPI only in case the
> > > EFI loader is being used.
> > >
> > > TEST: Booted QEMU SBSA (no QFW) using EFI and ACPI only.
> > >
> > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > Cc: Simon Glass <sjg@chromium.org>
> > > Cc: Tom Rini <trini@konsulko.com>
> >
> > Could you, please, describe how QEMU SBSA is passing the ACPI table to
> > U-Boot and where you convert this to a bloblist. I could not find this
> > in patches 1-13.
>=20
> I doesn't. All ACPI tables are generated within U-Boot.
>=20
> >
> > Please, provide a test that we can run on our CI.
> How would such a test look like?

Similar to the existing QEMU ones found in .gitlab-ci.yml and
=2Eazure-pipelines.yml

--=20
Tom

--h3991j8nOgpfqsBp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbsqw0ACgkQFHw5/5Y0
tywYYgwAmO0UJ5a1uU+mh/p7zJEykpFZvSX4sg3ESxhgc2EC88gEOBViiAP9SLgu
N5F19t9vKJaGAL5Ain87Utgf/9RuW9aP5VqK5uL9nBZF582XQzLAGwnWn/1V7bsw
VdO8taoQzjsgUCG+vSUMhyb6BycXTQtFs7fasLIlqK7/hddhrUeUWJkg85u0+FbE
Gs9eYm+dh8Yq2KD6X5FI+1IxJNarAUZVYAcAsbgJJdHXpGSAxQ3cpybyCmhBoxu9
ig39UJrd+cbcV52pksdFhVKojON50OOLswPewY1iqUVCWV3l2jvyx+SwLANu5mak
XXB2YlsZUjE6ycH/5CkI4UBgEcNyClzNfe/hWm9iAnEgzxYxYWYki27CYCGZyGPU
UMGOqPf+1D3wVoDUKRZUi1l+AsQFLjLm+uxCKbJjBivWKuCwSJg3lSqr+KrKMxmw
UOubQiK47nfNQvXS6XaRUcMo405pXLRaUtU0XukYkFpG/sLicxfWVlkfO8lCrRpW
/iBXGkPR
=FV9p
-----END PGP SIGNATURE-----

--h3991j8nOgpfqsBp--
