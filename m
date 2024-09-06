Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D060CE7B11
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 20:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E5A288580;
	Fri,  6 Sep 2024 22:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ewdAClh7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2255B88D21; Fri,  6 Sep 2024 22:41:58 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0340F8855C
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 22:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6bf9ddfc2dcso13862526d6.1
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 13:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725655315; x=1726260115; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3X4ENUEsGNpXNRmyCTlQPjClLMaZkqkRk0pS4k3tXCs=;
 b=ewdAClh7l60UMTPrsGNd5wSzSKUCuHhs2ZL7uRhBwV23r/48/BjpKAUI18HDmQqLhA
 H6cL2qtHzr578ytINdJvvy4v0cMg0IlUHNpQOovk8hMBG3r4VmnfUtMaTe8Xpx9PAuL8
 a0Wf1CEXwokUPOGj/p0GMiL758BH8qAybBUOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725655315; x=1726260115;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3X4ENUEsGNpXNRmyCTlQPjClLMaZkqkRk0pS4k3tXCs=;
 b=OPxizaw9hQa2L6MqO9UABzshH+LauIlbRXS7+syQZ061Aca11WWwn8ACOKDAJgwDkR
 V1h1iUfra0uo6Xgp27kuVxUmEpXr3mT8uwAW44vYmafs7gzDXSGG4fyj13vxlV1KDSo4
 sus09lj9UiolsSmx5Y0ZPfEutS6rLM/WxeOpGv0sQ6d/pEsWns1/tRsviuonwNKYP6Rm
 JV4TwjHkaeFg4lrtcIhB7Q7Pgk1NhbqHulUBP6JghDeTiGp4+QSntNuYScRjKNLbUpnQ
 JZnorHwWXUml3Ee4ThTvGR8xXFlfVj+cYN0ZvwrUkEtq+8vdy22kA8G7lQmtxJE+avDA
 zs1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYxIcN/UKuoRKwKogPT/xS8jNmyFnedG27uJXQ9uSrKJ6TfI98nv8g/kY5xoEO0o+qzOM7AhY=@lists.denx.de
X-Gm-Message-State: AOJu0YwYtQxcEhp4YycVNEUvp1ylZAdbSGkGk8JBE0IolQwCiWMbUGOA
 8brrlEeLFwreeo3hy1YjtPtzdba0NTyioCY195Ln3OYwo2II7X2QDPfNNHex1l4=
X-Google-Smtp-Source: AGHT+IHlyMtWHYMQEa9dL7PhgEvkgDwB3pmJvsIjoJSMiJJcZ90cXqmfD1ECwywmj814CJRyu/vlSQ==
X-Received: by 2002:a05:6214:2b9d:b0:6c5:de4:3edb with SMTP id
 6a1803df08f44-6c5284f61c9mr43065176d6.29.1725655314668; 
 Fri, 06 Sep 2024 13:41:54 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5202de586sm19498036d6.65.2024.09.06.13.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 13:41:53 -0700 (PDT)
Date: Fri, 6 Sep 2024 14:41:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de,
 bmeng.cn@gmail.com, sr@denx.de, pbrobinson@gmail.com,
 mbrugger@suse.com, maximilian.brune@9elements.com
Subject: Re: [PATCH v2 00/28] Implement ACPI on aarch64
Message-ID: <20240906204150.GJ3879073@bill-the-cat>
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
 <CAFLszThpJqJbQYS2qkbTM+__d+AUD-p_Xj5YZiPyNupK6TAZQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5Y+0QXwfWWbeywbn"
Content-Disposition: inline
In-Reply-To: <CAFLszThpJqJbQYS2qkbTM+__d+AUD-p_Xj5YZiPyNupK6TAZQA@mail.gmail.com>
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


--5Y+0QXwfWWbeywbn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2024 at 02:00:57PM -0600, Simon Glass wrote:
> Hi Patrick,
>=20
> On Fri, 6 Sept 2024 at 01:22, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Based on the existing work done by Simon Glass this series adds
> > support for booting aarch64 devices using ACPI only.
> > As first target QEMU SBSA support is added, which relies on ACPI
> > only to boot an OS. As secondary target the Raspberry Pi4 was used,
> > which is broadly available and allows easy testing of the proposed
> > solution.
> >
> > The series is split into ACPI cleanups and code movements, adding
> > Arm specific ACPI tables and finally SoC and mainboard related
> > changes to boot a Linux on the QEMU SBSA and RPi4. Currently only the
> > mandatory ACPI tables are supported, allowing to boot into Linux
> > without errors.
> >
> > The QEMU SBSA support is feature complete and provides the same
> > functionality as the EDK2 implementation.
> >
> > The changes were tested on real hardware as well on QEMU v9.0:
> >
> > qemu-system-aarch64 -machine sbsa-ref -nographic -cpu cortex-a57 \
> >                     -pflash secure-world.rom \
> >                     -pflash unsecure-world.rom
> >
> > qemu-system-aarch64 -machine raspi4b -kernel u-boot.bin -cpu cortex-a72=
 \
> > -smp 4 -m 2G -drive file=3Draspbian.img,format=3Draw,index=3D0 \
> > -dtb bcm2711-rpi-4-b.dtb -nographic
> >
> > Please note that the current implementation still requires a DTB to be
>=20
> The word 'still' suggests that it won't one day. But U-Boot uses
> devicetree for its configuration so this will always be the case. I
> suggest removing 'still'.

Pointing over at x86 where we have dts files, yes, please remove the
word "still" and perhaps otherwise reword a few things. U-Boot is happy
to pass along ACPI and so forth to the OS, but will continue using
device tree internally.

--=20
Tom

--5Y+0QXwfWWbeywbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbbaQcACgkQFHw5/5Y0
tyxlMQv9Eb0YmCM0dgikomBZvwYeNQDIHuqsw6hhrCPFWgtBeRAwzgmOk8QQheRA
TElhicvb1ZcTBJpYFNjBno3OYdgA0hYG91f0UOuvvY5k6d/yyNPwMQL8HVZwcivN
nojKCA+R3QWuaCNh2UfU+xGoY34l3z/fZSm19GDmzYlSfqbAyTCspHLHTg9E9Ero
I0cjiGMUXqtZljGl7K61eGedp2bXr9XqdBlggVD4xChS1y34IHSiIRaR8e6bhi20
QDXzX1xLM3zpihPoRpcQsH/1uKHDhhge9PAU+NXwyJZGPuVtuOyoxBLBnZuULQLX
XpPF+URd5LhlLZ9eHzp7/LRc5omaXALKW9sQZy6ensgLpTlRU26BpitLRgaSa1o6
sTyckLut4tBXZtf3I/I3jCaX4eXErjm0xA1hCMSqXAFNTJx7ISIKeZXDY7WooNHu
HVJ34Zn+4MXelAsStacVUgW4tDneup+CvU5oga8jRsMsGI06dhXf1I9gEQyKJidf
0q9SPCpL
=7YAY
-----END PGP SIGNATURE-----

--5Y+0QXwfWWbeywbn--
