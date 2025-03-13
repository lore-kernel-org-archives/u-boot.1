Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA1DC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 16:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64DEF80FF7;
	Thu, 13 Mar 2025 17:53:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uke8rgXU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7788280F9C; Thu, 13 Mar 2025 17:53:06 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 398D280756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 17:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-476b89782c3so14237401cf.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 09:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741884783; x=1742489583; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AzXx3JHNv/g4i1yJvyAKjXYKOKB1ns29GWhQtaRWGqI=;
 b=uke8rgXUrRNpuIKPZJl+8y3aZyrEN9STlcLQmb5RsCRMlA8I9avwetT4StwSkToHPg
 WfeO73Vi9/+NmTXrtN1cl6b0wirBlqQ2R0gLmSBRfW2+7L00wwmtWA2e/f32um9clml2
 TQ36/L3Jdy2xjSP1SmRDV2gYtoxpWKzw5JZ5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741884783; x=1742489583;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AzXx3JHNv/g4i1yJvyAKjXYKOKB1ns29GWhQtaRWGqI=;
 b=tZj+FbqBeiv6desnkS7M5050C/PAcUP7vGfIHvPMiVS21DCRcmWRbhqisuEnbNmUH0
 DXC4nDTV3z5Lcg4nTNFACU/ieGbibGCqke5q08ewSdgLY9cygCv4jHMHv7LQd3DQ9pcU
 FhfUmfFTKCpG2jwOXnMc2c9jzL4rEWYyDvdl894c25gY4ODFq+c4Zs0VcB3/bIDO61+H
 6PGv5VdAg6XZNlijrCd/NVv0rhBvorG8D/hpbKmzD8Hpen0Jct8255w0ru0lwL4iad4V
 fXAj5HUv8TNlT/oc0AZQWyEy29/fLAW1TlQfqq2qMrZA5hX+VZoeicbGCtbE4yW5X8ey
 KDRg==
X-Gm-Message-State: AOJu0YwaUmwhlyl+S+sBLDHSTkjhPbRdzWQZeygRkojO6XoAmwEsMBvr
 w1Sdxztn6bcRpuRmNsbwEbhgM7DVNwiNzODtdBJ/fDZu9FBU2JrC8Y4s1dgwsts=
X-Gm-Gg: ASbGncspRfsAmwLat7oLYe4nU7jvMXKb9oc49KLP3qqqYTttHfc3YzL3r+eT4/2+ZmT
 z6HEnGpAvIfUeXZamMUew2WCCCKuTSd/mHW4m28veg/IFfp/yTaO6/jtQnD3Ce9bIeYe/Ilwdgy
 8FMNNRvnCi77o489mk+4VAs7/QuBwJEDn5DL+pWDnc7QKB9TB8t+VN3oSEAouz5Bf0tdy0uIR/Z
 UCnaH7h6QUMaStubujGNIKpuP3MWq7k/yLD1/efm67OFOHEcJRnwGblqsEr6QVpdvxpXAUDCtmR
 Jg9q02dU3incbv2Vadv9AyeCfixVY2FZQKI+d2Jed8gWhw==
X-Google-Smtp-Source: AGHT+IF8YMrK7jmJyz70LEKtQkBtz4SRipKhTfARRfZO74bcIsqnK9PCJAYebZRIKp/JDi0wZKO/iw==
X-Received: by 2002:a05:622a:148:b0:476:7dfd:fd66 with SMTP id
 d75a77b69052e-4769947fdb7mr193875671cf.1.1741884782854; 
 Thu, 13 Mar 2025 09:53:02 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb82c1b7sm11021371cf.74.2025.03.13.09.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:53:01 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:52:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 09/10] doc/develop/py_testing.rst: Update section on
 filesystem images
Message-ID: <20250313165258.GI2640854@bill-the-cat>
References: <20250306232256.4150882-1-trini@konsulko.com>
 <20250306232256.4150882-10-trini@konsulko.com>
 <A3E7ACFE-6292-42FF-9703-63EB7106019B@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pJcqRAZ829BuXWqN"
Content-Disposition: inline
In-Reply-To: <A3E7ACFE-6292-42FF-9703-63EB7106019B@gmx.de>
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


--pJcqRAZ829BuXWqN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 01:08:33AM +0100, Heinrich Schuchardt wrote:
> Am 7. M=E4rz 2025 00:17:11 MEZ schrieb Tom Rini <trini@konsulko.com>:
> >Now that we have no users of "virt-make-fs" nor users of "sudo" for
> >creating disk images update the documentation. We remove packages that
> >are no longer required (and related text) as well as be firm in our
> >wording around not using "sudo".
> >
> >Signed-off-by: Tom Rini <trini@konsulko.com>
> >---
> >Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >---
> > doc/develop/py_testing.rst | 22 +++-------------------
> > 1 file changed, 3 insertions(+), 19 deletions(-)
> >
> >diff --git a/doc/develop/py_testing.rst b/doc/develop/py_testing.rst
> >index b50473039be4..ea1329c44b17 100644
> >--- a/doc/develop/py_testing.rst
> >+++ b/doc/develop/py_testing.rst
> >@@ -41,13 +41,11 @@ will be required. The following is an incomplete lis=
t:
> > * dfu-util
> > * dtc
> > * openssl
> >-* sudo OR guestmount
> > * e2fsprogs
> > * util-linux
> > * coreutils
> > * dosfstools
> > * efitools
> >-* guestfs-tools
> > * mount
> > * mtools
> > * sbsigntool
> >@@ -64,23 +62,9 @@ The test script supports either:
> >   physical board, attach to the board's console stream, and reset the b=
oard.
> >   Further details are described later.
> >=20
> >-The usage of command 'sudo' should be avoided in tests. To create disk =
images
> >-use command virt-make-fs which is provided by package guestfs-tools. Th=
is
> >-command creates a virtual machine with QEMU in which the disk image is
> >-generated.
> >-
> >-Command virt-make-fs needs read access to the current kernel. On Ubuntu=
 only
> >-root has this privilege. You can add a script /etc/initramfs-tools/hook=
s/vmlinuz
> >-with the following content to overcome the problem:
> >-
> >-.. code-block:: bash
> >-
> >-    #!/bin/sh
> >-    echo "chmod a+r vmlinuz-*"
> >-    chmod a+r /boot/vmlinuz-*
> >-
> >-The script should be chmod 755. It will be invoked whenever the initial=
 RAM file
> >-system is updated.
> >+The usage of the command 'sudo' is not allowed in tests. To create disk=
 images
>=20
> Can we add the reasoning here:
>=20
> Using elevated priviledges can lead to security concerns. Furthermore not=
 all users may have administrator rights. Therefore the command 'sudo' must=
 not be used in tests.
>=20
> >+we have helper functions located in `test/py/tests/fs_helper.py` which =
is to be
>=20
> %s/is to be/shall be/
>=20
> I would rather use 'shall' in accordance with RFC 2119 for clarity.
>=20
> >+used in any tests that require disk images.
>=20
> %s/require/require creating/
>=20
> We have tests coming with prepared images  (efi_selftest_disk_image.h). O=
ther tests might require a downloaded ISO (see the pmem patch series).

All good points I've now addressed in v2.

--=20
Tom

--pJcqRAZ829BuXWqN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfTDWMACgkQFHw5/5Y0
tyxUFQwAgEy1V4QD5SCSkLS+9mI3qVoH/BLXQTFa5gG6sq/JVdToQQ10twlIp050
Ci2DLWNHONg33notyRLMWPSdLgRg7sZlRw4AWkGEz5hR8qTzakWQM9F/h2WaoY7g
GeYHCTZfJg1kQ9q1DYxr5jgYUDHUOs35gimJ87LPIADGBW/NrpkYxCCXT5XjgW0/
7JW5YvQw0OetQUvFfLHGy9EcVC6p/VV+pIQES8xjksuMNitIEXiBbQ3vnd5rPz6W
PysoB+ns2g/yxWxcgEuI946fGg7o5Izb3w523xSzXvtGsjy4rveqxoJhuHqoFTBh
RZoapgsi72CGTy3lWwpiIIVksE8xf3v6JrRo0F29H812SzqmBazS1k6vEiu8TQGk
/G9XAqXsz39Va+eEf3pDeMA/UCx3XGyBGqYaJx0uvRjQeDBit92U53T7g89dTXxC
6Wso9WLpkM9BygWnPMjqd9IAsO2Z7VpLXpbD78fXvYRsqD0YE69nTqvX4AYPKdat
XUKV9k/Y
=XYSn
-----END PGP SIGNATURE-----

--pJcqRAZ829BuXWqN--
