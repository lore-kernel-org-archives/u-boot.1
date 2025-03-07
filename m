Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227ACC282D1
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 00:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50FD4808A2;
	Fri,  7 Mar 2025 01:08:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LH+yUe2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9192F80E94; Fri,  7 Mar 2025 01:08:40 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AFBE805D7
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 01:08:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1741306115; x=1741910915; i=xypron.glpk@gmx.de;
 bh=IfMnPwZmy0k0LkfL2n51FBIO6x9VVTcxASTX+A4s3FY=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=LH+yUe2hr+W/FUc4rM8iEOcRNI64omhr905nyG0DDuH4DRXi5Er0uAom5z8Q0wm8
 ZnMibmPwnhwRlRX3EAR4gcY97NOZHXIkVYQvNZaZ+3BBGJVONQRyMm10pk3hNCguP
 TIbdFTv2i071ul8FBZEc+ZEEetr3zX22ITnRm50lrYTweFYL1qVvFKVbvZXWZPVC3
 Sbi108BC0KsQS+8+QUQu3NcYRJRW0v4Td/EC+R/AZJMnGDH+Ell9iruaJ8WOaf/Jq
 FJYYI4g13uO1yp6HpV94Vx1JFkcTCqOmDhbjahx77TERE6RV6UUoaqUu1d/jwAuJ0
 T5ADkGOjgVc9qmjMRQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYXm-1tOOa436uU-00jIAm; Fri, 07
 Mar 2025 01:08:34 +0100
Date: Fri, 07 Mar 2025 01:08:33 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_09/10=5D_doc/develop/py=5Ftesting?=
 =?US-ASCII?Q?=2Erst=3A_Update_section_on_filesystem_images?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250306232256.4150882-10-trini@konsulko.com>
References: <20250306232256.4150882-1-trini@konsulko.com>
 <20250306232256.4150882-10-trini@konsulko.com>
Message-ID: <A3E7ACFE-6292-42FF-9703-63EB7106019B@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RzPHd/3cxCUUcFD9DxexoGRURzD4NfgLFYbxHJRmWgNDAUnmfPA
 4prxI8LTc33xEMwmK0hvr+vTbE2ujprl1IONKo0T5dRtcDQsNsPGiJuXy3BZ68fMUUkSd3W
 tIEsWYMgfV27vInkUnNxA9VMrIogxUPyRg7lCcyYvKPHPhh4fqHsMzWEE1sIUHNYgGB6UIW
 xzWKJvisBeyaj/mSKi5/w==
UI-OutboundReport: notjunk:1;M01:P0:qwLaNlUvjnI=;8N+6s5nf+vzadL09WyS019WlJY4
 nNp2TLtCFiTeZp8ChV5tEKi2hWiyyxJ0lolU5HWJS99D21n5vdb4UswtCHGWHZ+RnTc5N6PDz
 SmJpYlC01ou3PmQLGyI+3JwrduHdMJjraf3fsWTMPbvyaYiQRAb6C5oC1cj7H53FQDZv5ukcB
 Y+HWJySGvzfGHZ+6z2lLLdQknbWPa6j8LcWgwWgkZUgxpshqs5OTQiLVqJUtMgEzeZ9iH3aNn
 GOms2A1pq9NaY1uf2cXQYifw5vU16g69YdSdXDAOCq43gsOiTIJ1nTyDLUjSZxFB59ncUbFP0
 7k7TeF4fNm0qHiJzLjnLbPpX2/bqZ4mYU8XWlQfvfUJ0Jx6bEl6cE9Kjb8ahKFEm7qT+TgT8+
 ujhim9LT8YqWncc+asWVzJOWz9JONlSf6SW/XYnM45G76yDW62gjs82sqR8jt4v11G8VCtyUu
 5knS2LelXQwTxrTV33DdHiiCdFrOKb3VO3leA+doIH0kVchxWEE4WiUKdytfhgxDyfdvd+02d
 +Ibv3qpOQ0ntnNAHhpuXetG2Zq0lVK2SCyjhVaDXpc2WmuORf9+iM4gBLhVe0jC8rpCGdZUrj
 ni8EJeVqJTIWjA7fVJ3oeRozGUyoDe2bHnQhmvjXdIy6d/agYroY0LbqiCZBoqyfdlnLDHiNO
 tff6ItQHnYiIPazGXRomez7JwwWJFC9slFXlhxk4FvPfsECGkl+u9Ozo/8IwyNhxqYSqgKQ0q
 2333Z4IP5WCfAkFdAcayiQ8f6RcPQxayMTEWcbCu7btw7rpmoPhcyikODC0xpt/+cAfZY+MKt
 4A08l7Co4IA0/xSl3cyjJC7qIiIrSNyUssZ7Qba3jHrbtVx+pLXN5dIWS3KszEBqbAgo0jiJv
 SIvrdJzDjnREb+HVouXG5oD0x60X3GsEmcBbrHwJwioylzYtQ1MwB/0ajGoC7JJc22erG4t1z
 Q0diNHHJIXwle0rKfTl0A9JU/ZJ/cxm0C5QzK5l9SzP2/qZcjgdWbKRSyfjxF6r6AdSZgbAID
 dewOwqcJDABMufK2+omIBoxl5ZZYpGZBPSNDpc4YqthIX15BmYWQlyXEu35OQW8XPN5HcDT/W
 D7cefxSl960GNKnJ8QwgqsqKTaiVcXJ4XDaD7L34kyDAZl2jST0XHnjiLldUt2FD3S8AGSr7P
 JSmJfR4LlIBuFMe6Hnbn75EVLmdjN9l6uPjqd6yHsNUKKDhoVIwPn5sBGwhcbzPYkiKj7igEn
 EgEV7okcgAF1Go4ukFzDS5NH1j0NJsjGF+Bt5u9LhxN4/xTa5Xc8Xh2AKV8m9HNqCU6w5sRd0
 aYGLFU5mFmUy/OgSXbJxpur6s38l5ycbSOJOS8PpyX83rUBzXGMHrvb6tyJxPRHBQJBm19Rgi
 0o6YMA+4JItZ42ZTFZ3E1cOs+/fz4aL002uBSwfFvFabuwUtqowe4SJmHb
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

Am 7=2E M=C3=A4rz 2025 00:17:11 MEZ schrieb Tom Rini <trini@konsulko=2Ecom>=
:
>Now that we have no users of "virt-make-fs" nor users of "sudo" for
>creating disk images update the documentation=2E We remove packages that
>are no longer required (and related text) as well as be firm in our
>wording around not using "sudo"=2E
>
>Signed-off-by: Tom Rini <trini@konsulko=2Ecom>
>---
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>---
> doc/develop/py_testing=2Erst | 22 +++-------------------
> 1 file changed, 3 insertions(+), 19 deletions(-)
>
>diff --git a/doc/develop/py_testing=2Erst b/doc/develop/py_testing=2Erst
>index b50473039be4=2E=2Eea1329c44b17 100644
>--- a/doc/develop/py_testing=2Erst
>+++ b/doc/develop/py_testing=2Erst
>@@ -41,13 +41,11 @@ will be required=2E The following is an incomplete li=
st:
> * dfu-util
> * dtc
> * openssl
>-* sudo OR guestmount
> * e2fsprogs
> * util-linux
> * coreutils
> * dosfstools
> * efitools
>-* guestfs-tools
> * mount
> * mtools
> * sbsigntool
>@@ -64,23 +62,9 @@ The test script supports either:
>   physical board, attach to the board's console stream, and reset the bo=
ard=2E
>   Further details are described later=2E
>=20
>-The usage of command 'sudo' should be avoided in tests=2E To create disk=
 images
>-use command virt-make-fs which is provided by package guestfs-tools=2E T=
his
>-command creates a virtual machine with QEMU in which the disk image is
>-generated=2E
>-
>-Command virt-make-fs needs read access to the current kernel=2E On Ubunt=
u only
>-root has this privilege=2E You can add a script /etc/initramfs-tools/hoo=
ks/vmlinuz
>-with the following content to overcome the problem:
>-
>-=2E=2E code-block:: bash
>-
>-    #!/bin/sh
>-    echo "chmod a+r vmlinuz-*"
>-    chmod a+r /boot/vmlinuz-*
>-
>-The script should be chmod 755=2E It will be invoked whenever the initia=
l RAM file
>-system is updated=2E
>+The usage of the command 'sudo' is not allowed in tests=2E To create dis=
k images

Can we add the reasoning here:

Using elevated priviledges can lead to security concerns=2E Furthermore no=
t all users may have administrator rights=2E Therefore the command 'sudo' m=
ust not be used in tests=2E

>+we have helper functions located in `test/py/tests/fs_helper=2Epy` which=
 is to be

%s/is to be/shall be/

I would rather use 'shall' in accordance with RFC 2119 for clarity=2E

>+used in any tests that require disk images=2E

%s/require/require creating/

We have tests coming with prepared images  (efi_selftest_disk_image=2Eh)=
=2E Other tests might require a downloaded ISO (see the pmem patch series)=
=2E

Best regards

Heinrich

>=20
> Using `virtualenv` to provide requirements
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

