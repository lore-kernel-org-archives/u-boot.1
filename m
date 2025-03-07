Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF16C282D1
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 00:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE1A8808A2;
	Fri,  7 Mar 2025 01:41:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EN4Hoe8t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B626580EB1; Fri,  7 Mar 2025 01:41:09 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADE46805D7
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 01:41:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e53ef7462b6so1140864276.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 16:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741308059; x=1741912859; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gRIH90R4dUJC/varTYjYUS+bGZmbzDNdXZ3jCvndFHE=;
 b=EN4Hoe8tcd4QBVZ7vEwitjc+F4Xy34oF9WRtvIwpSP6jq8E7g8RXMhNaNfSTicUktB
 uI8d6mhWVcZDB5KxMIsvUsJmnuMEBIJJwTyJCt9uy0FTphkEvtErfweAPmV7SzitgMqe
 kS1KteoQUZetMd7MxxLacebnOsb4j+KOuM8D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741308059; x=1741912859;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRIH90R4dUJC/varTYjYUS+bGZmbzDNdXZ3jCvndFHE=;
 b=ubo8mTFvvRkw4yLJ+Ypldvx0VXswHP6tanDq4JxuGgeZ3dnmAAAoUfZ0kPWrgNrFbY
 hBUU8xR17/UKcETpDbZ8GthkPYegwS716bKbSSn54qw7CUiExmpIKIDvawSQv1FO72uN
 W30mQa1x92BDm9miG6gWOgnHx1cZZsoeNdpJaS8IIFktGE7XUYONGO0TLXOyqxtdfX4R
 T68lD3XF5aZc515HRAiMimi8Vg1AJzjr1GM0RNvcDPH53ENlQCSKH5o7hMcY0Nyb7j2p
 z0rt/jR+gHSf0m7dBlNjMbASdKWjrejPkSBUfYVtj9ON86j+qyaxx8Ro2yX+VRxc0NJS
 60FA==
X-Gm-Message-State: AOJu0YxVQPIJL0pWVC4mWJJTB16D2Pu7waPZ01XMJYG8wBdgU9DBmmJg
 b9ZHErqj5tn0KzmaE6H8w2Are9bRgzc8Wq5gnifEzocIIFAhfqTZMGb+BE4ybHk=
X-Gm-Gg: ASbGnctj3eT+lFQN0Y63BnuyqFWPm5yjlB0pfej+0tRHaKCANY2KtxKCwoLDCIdwKdS
 jKOtvebcn0bvbUwswIGjXB8AW263QkkMlG29nX0iBkU7KZINdadU23fF5w7/aS6OqJn9HN7ljKY
 9Tp5aQ41hm/Azd1HVOzQHRfC9lA/2RxMfF4tMFmMrknDwDVNJvEqArws1Wr0AGxNtMkzZaQX71U
 091fgAl3JOLsE5ENFD5pKDtLjq8I0QxBrHCtIW82q6T32I9uvi1Ocuv5oVphUIgo4Jeyna0jTS0
 SybF9Qyxq1D6Fy5EkwgIHulsDzVD775AfpCL+xKS1xwzag==
X-Google-Smtp-Source: AGHT+IGsozZLV6QA6/MYdUp53M/ed/3uNCmOzAQv+MXEaJRdxktWSzh3hxqypELclJgJuUe6c8J2GQ==
X-Received: by 2002:a05:690c:45c1:b0:6fb:1f78:d9ee with SMTP id
 00721157ae682-6febf2fa005mr22227447b3.15.1741308059314; 
 Thu, 06 Mar 2025 16:40:59 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a1c0dcsm5170177b3.23.2025.03.06.16.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 16:40:58 -0800 (PST)
Date: Thu, 6 Mar 2025 18:40:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 09/10] doc/develop/py_testing.rst: Update section on
 filesystem images
Message-ID: <20250307004056.GH2640854@bill-the-cat>
References: <20250306232256.4150882-1-trini@konsulko.com>
 <20250306232256.4150882-10-trini@konsulko.com>
 <A3E7ACFE-6292-42FF-9703-63EB7106019B@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PsoKiAQuUsjOuWZ2"
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


--PsoKiAQuUsjOuWZ2
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

Good points all, thanks.

--=20
Tom

--PsoKiAQuUsjOuWZ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfKQJQACgkQFHw5/5Y0
tyzrCQv/eOxmSYsLkuLvVl3oJ36luZGtAKqRBn3Yrf2ZDXWlPUz/hjLldIt2h0MC
TYA8IlWYDD1+ygZmiC6zyJocAUanlkrq8MM1rC1dP4HIdFNKh2/HEGWu9VoubUqA
6PDDxQm7X/tZHSRQtOXKjhbyuvJDao3s1+eWjBV57Om62xT2KAsCzg5OEiubsvEz
3nHCCCdv9Iq9M8N03sPsgKhmJw/0WLaQAMeNNYGz07zP6PlEqThgyhIA1p12lH0x
lyZYRhmCaBQArcj/667OA+X9C4bVi6RwtKyiwZtm3Km9xI2wh7ByIr8Mgd80t4R9
f+lQCCBQGgCMsBOXSACE1diKT03ql+nIW/I0yGy/4uGdSKflrKAAACSJbB4zdEY0
swYiSP3xey95tm1DDqgygh8ReudwdLR/owYzUeK6yfgt2zGz/yw7xOz7nrkJmUjG
oFClUOhNaDLHpYpdeAu6H04g3mcX30xhIMNS08lT6KVyQNlbbu9OH4dLBGjwvugw
0shkgynE
=/E04
-----END PGP SIGNATURE-----

--PsoKiAQuUsjOuWZ2--
