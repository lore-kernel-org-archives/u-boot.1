Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C159D11180
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 16:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D02DA88E14;
	Sun,  3 Nov 2024 17:12:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hs/qC/jg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62CEB88E96; Sun,  3 Nov 2024 17:12:47 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A584F88E14
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 17:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbe3ea8e3fso25418506d6.0
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 08:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730650363; x=1731255163; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=00p46He0uwYY7zR7x4g2S9o7CA9m9HtnjXpsYoLlPu4=;
 b=hs/qC/jg16U7fh0BfFsoQpcMrVrfyKVJ77sZviWC7wMQQscttjbkHd2vRZL1lyzWAH
 e9vZdhjKZTrxXQsCxzu1z3VuwDyOevr5x+jsEArTuGNSAZqsFs7QTldReU5HnyH4g1l/
 fTpgWLelLdlKrBKq14m7/Ia8vaJu/xb5jMVKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730650363; x=1731255163;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00p46He0uwYY7zR7x4g2S9o7CA9m9HtnjXpsYoLlPu4=;
 b=GE2vNAQ+uPciWSL0K8AcPTv9koav+tA+wOmWjd6bPg+kd3qQ5DDjo4USMJ8L0Sf/zo
 v+HHv8ggJbg12Mvlf7eAavVyO270X7R5vx5XUDjDRDF7SqExxInZwJ0kFs/gZEvEwYIZ
 tLFPvCV+rny+/OETqPYBzcCHZrG5EPFaWPb4HjTsq2SIuTPSYW5O6/cyjPde3cBOkGHv
 TW1Piy2ik6+NSgO9MHdS6YUQeavwMwMxSYNijzwMTK11smxYdbPTeufxUhSUmGjbCbUN
 i8JrZsp4teMbaQKWu1EYjJcUiRtcuynTqqoDzLHOdEbNKSpqT8QbfaTIGqd27A6pLBUi
 7uKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv6c4OAkSJPXSt2KUPVNVzm6yeQ0BXgWdQgbT6bLiVxtoMyJ7VjJTSzhmVDoSDXkROq2dRnM0=@lists.denx.de
X-Gm-Message-State: AOJu0YxSKOz99Un5YdiCIZ4f8XxETutggrs/J9xh0M8gg6pz81wNaxRL
 3hSowJ3xB+f0RrnAcBTV9Oc2s+aWAmDL2oLJwf/s551J/yo4gY6WYszs99lqr/Q=
X-Google-Smtp-Source: AGHT+IGHL4UicMWrNlasnAMB4mhQOj4YD0BNOIsVdaOAvRnSSUWvoe5I9cCMAJMrUMinXEjN4LhEfA==
X-Received: by 2002:a05:6214:3f88:b0:6cb:e952:8096 with SMTP id
 6a1803df08f44-6d351b35b82mr186222976d6.50.1730650363381; 
 Sun, 03 Nov 2024 08:12:43 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d35415b421sm39659796d6.97.2024.11.03.08.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 08:12:42 -0800 (PST)
Date: Sun, 3 Nov 2024 10:12:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] configs: enable UNIT_TEST on qemu_arm_defconfig
Message-ID: <20241103161239.GD3600562@bill-the-cat>
References: <20241103071200.82853-1-heinrich.schuchardt@canonical.com>
 <20241103071200.82853-4-heinrich.schuchardt@canonical.com>
 <ae7eadd9-175f-4903-b272-71bf9c862e3f@canonical.com>
 <20241103155001.GC3600562@bill-the-cat>
 <6414da69-8cb0-414c-8f6a-02f104559e4a@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nFSH6B2nOMnxxBU0"
Content-Disposition: inline
In-Reply-To: <6414da69-8cb0-414c-8f6a-02f104559e4a@canonical.com>
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


--nFSH6B2nOMnxxBU0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 03, 2024 at 04:56:40PM +0100, Heinrich Schuchardt wrote:
> On 11/3/24 16:50, Tom Rini wrote:
> > On Sun, Nov 03, 2024 at 04:45:41PM +0100, Heinrich Schuchardt wrote:
> > > On 11/3/24 08:12, Heinrich Schuchardt wrote:
> > > > The lib_test_uuid_to_le test fails on 32-bit systems. But we never =
caught
> > > > this in our CI because we never ran any of our C unit tests on 32-b=
it.
> > > >=20
> > > > Enable CONFIG_UNIT_TEST on qemu_arm_defconfig.
> > > >=20
> > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.c=
om>
> > > > ---
> > > >    configs/qemu_arm_defconfig | 1 +
> > > >    1 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
> > > > index d042aea49bb..cc4f4540fd5 100644
> > > > --- a/configs/qemu_arm_defconfig
> > > > +++ b/configs/qemu_arm_defconfig
> > > > @@ -67,3 +67,4 @@ CONFIG_TPM2_MMIO=3Dy
> > > >    CONFIG_USB_EHCI_HCD=3Dy
> > > >    CONFIG_USB_EHCI_PCI=3Dy
> > > >    CONFIG_TPM=3Dy
> > > > +CONFIG_UNIT_TEST=3Dy
> > >=20
> > > Before merging this patch we also have to fix the lib_test_dynamic_uu=
id
> > > which fails on 32-bit.
> >=20
> > Is it the test, or is it the UUID changes? I didn't go so far as to
> > revert the UUID changes when I hit this on Pi 3 32b, just poked Caleb on
> > irc.
> >=20
>=20
> While on 64-bit the expected GUID is generated (both on sandbox and
> qemu-riscv64_smode_defconfig), the generated GUID on 32-bit does not match
> the expected value. The generated GUID should be the same irrespective of
> the system.
>=20
> Once we have fixed 32-bit little endian, we should start testing big endi=
an.

Right. What I mean is, did this work prior to Caleb's UUID series that
was merged with:
commit 35394e1ea77ba0ad971d9115bd965a2403c0e031
Merge: 9eb0d731d800 7de51622a2cf
Author: Tom Rini <trini@konsulko.com>
Date:   Fri Sep 13 08:20:25 2024 -0600

    Merge tag 'efi-next-20241024' of https://source.denx.de/u-boot/custodia=
ns/u-boot-efi into n
ext

Or has it always been wrong? To me, Patrick's report implies that it used t=
o work.

--=20
Tom

--nFSH6B2nOMnxxBU0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcnoPQACgkQFHw5/5Y0
tyxnngv+O0E8yqsgCQopNoRp0zKb3qMddBTGEzFZicORg+aGHZs8yzbaain4wJKl
cC+cNd6aWzk6XKPgvbf5tFDFwYumI5kKlzR4Earm13sOCUbxE37eah3Mahed/Zf+
VOnqAuLbQ6/icEZo/4QEdXlC4oDFm7/SMpk37qFLS7Mrvqlaj/zp705eWZxzurTq
6zOMGs5p8mxo3AXFdPLXn5xKaV/TYvpblCxYYJriGoUZGnUkkI3eFyjvY218Krua
P8I1/etumY1mj9kn0ziQzxL7D4I+IpnOaC9BUlD+41XWn5W4LwJQCttmOhDTL3Z3
u2KUbAG0XNoY5tSPJ9sHH0DfvH6+Wi9B5WxCJzRj+29RiVhLdfGYjC1GajxnlX8n
zzWjuzC2KRD7o8q9gBdk7VxbXErj6B+y7LZtctmHEbxaWPD5n6lHf/Uh4K9D5icq
pOs+Sb9WFVvalJOY4bkDBBPP81GwoD73fvsLEuH//M0N8VG5rIjFQkCPV/pIwVPK
YDZnHJAo
=kqOL
-----END PGP SIGNATURE-----

--nFSH6B2nOMnxxBU0--
