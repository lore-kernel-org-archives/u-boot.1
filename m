Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F822CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:47:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 239DF84927;
	Mon, 25 May 2026 17:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VrTgODiN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CD9E84936; Mon, 25 May 2026 17:47:33 +0200 (CEST)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3D83848E7
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-6314a0eefb1so3049122137.2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779724050; cv=none;
 d=google.com; s=arc-20240605;
 b=dXo0ie0bOZsrfLjvFmsUQGdtigZ8TA98hmrT8oNBFePWyvqKdBy7+A2j/jC7Hz4T2m
 MIDk6Nv0i0NE8vUW1G5KWJl/Bef8i25oHHiQCTebon6J+sPF6+b9HmRGnaA4MFk2ZV0e
 I4anzt5xTKmWklO1kK9DxFlvw+C6Pf5KpNqKqmPqy1gCaRFIdXVUY0y6y75yg4nT12k/
 nxvsFo+kSa2PumeINjToRibFq44Ap/V8c0sob6ng43IcOOuHmyPxuoR1FRJQI/Ziosq2
 9OFg5oyqGY1ItaMM8gSPkpzB6cywq3Q/Nwt2kSMdUKytP5MnoOSUT3xiUe9Pgj0OQdOU
 gk5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0oXN5eu2jX+krvOJ2tQWH81G+XNURLnIvWXfjix3hNk=;
 fh=KNrddjmml7OIhCcvuN7ja9fLuJV4M5J1qa3rCC9UkAo=;
 b=Cx4zH1Iz9z1unJjHe4kGKb3nmSqRS56WcN+SMsaRTBVgZJ4ml4yIi7XjdWg11i7wtc
 PrKX1CIh4NoibutSETp11S9k/GA2gcrD2z7X2yErKFv3okJqqz+n1yu31uMVa9ARy+WA
 8qXd2a8HI5z9M1FbxEZIv7wh9+ELhsWRp7BhNNg7MG4ONocpr45IWpzHpe1HKbb2vx8v
 +5FQ2ZGGHjPK+gosLxEafqwCFifybTDdcprkApWmXl+8b4Xlzlb8iLC1t4NTkEoL9tj4
 6K6nGz1Ua3K9VcP9gYqiwVVo2zGbrWeZPvsSoX0hVg+kbH8ze45PLVMC9ynSo2kNAmya
 JK9Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779724050; x=1780328850; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0oXN5eu2jX+krvOJ2tQWH81G+XNURLnIvWXfjix3hNk=;
 b=VrTgODiNThXShR1J0NfI6wgbBfmUGpr06hBvxn1xAzyjDgtWyIW1skLAeLsxI89ROp
 6NP5RaJSdGABxcbYZKjge6eH13mmTs3dn89Dipk9ZL/tT3o0O+U1bR368ejK3uZFDpqq
 PrUfY4ohfr0BSiVnkBOCoP1NjulvI2AtUOi3Aljou1217hgZMP7P6qUQo/J6nFrP48BC
 37Q9zYGtkH5Pe2MyfIheDn8dOPEb9FMXgoBxGz8YkVJEXm0c6ZicjmQEbeJbqv4cEFje
 As8sq9QNrIXJoGFpFyAWeuC4IpX88hP3W0WfAWYwxLmnOTJruF+pxQRQoGskTXhluQ6h
 jnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779724050; x=1780328850;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0oXN5eu2jX+krvOJ2tQWH81G+XNURLnIvWXfjix3hNk=;
 b=EHiqw4VyMp7ibIysvnR0oweWLGwRtcq23we7ROUjy6D8qfTVVsH8ZNLNOocyXzwIQe
 UX1L+zvEaTYJDta5bXOzqswblJ3Gh0xN7NpRQGCsWxUNAicqS2KMVK5WcFjzU0eJ8gpM
 C1AqqbaivHe/9frkL6ajFqe1IQME7dI4SC7Q75fe0hlq46/M4QlHoDK21ZRyVroYoODs
 Xdxy7BK7gDvjIasVDiL/9DGxn8UpqhqEU6x2G4pA4PpOu8jDd0j+QDBsn0o9eUSs6vpS
 PxZRdnan9uBrYBMwlM+kYCFuekgMRLZAUadqNI9n4ghSBZwQVmyz3lcA2ywCqGSTBZQF
 ZVdg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+k/MFqlYmUf44cxOrSj6cDUXUtedvJ+szAjXfQvaTYR6cM2w5W2UUjBGUbbA0sQrCxxYppPo8=@lists.denx.de
X-Gm-Message-State: AOJu0YxqUhyOqx+thMQSGG/iOTHoY2wM9QMG7mXht0Rp9olphUqJRUsi
 Ghbhx+cDQs7+lMgLP6JQbJUQDPkU4uYN+PfEz46XZ1q5jjMH4pJl0sVgkZwOwCR0SVGZ4/VyodB
 YPTL/7FgEorKVQsHqFaiPiGl28W4xbpw=
X-Gm-Gg: Acq92OFtWf0ix29KGopODlDqPQrPDgPwgNVQogYwV2ChD/30Aoq+1+Ygq7wtx3rpPoJ
 0dGYg5ryFzXyN5ZlUR2jYF4lLYVO/Gi2pAjmxdRDVHfsaI72mrHlil9I0GbutVqIVIZlXnuw0E+
 SmLwxnSmgk6TpcYnEy11HCY5b4GEbhtLLnYcJk9TqFNDNSxEHHFacjkl0+dCYK928QYKkOIGMLD
 tyBNmazrw4UvP9+Cl3upiUKBzlpqsobcypUpWkj3HEwVvlCIwqi/q1ZC2JGE9PfaSlXtkhvTKyG
 CTeSlL+6
X-Received: by 2002:a05:6102:4bc5:b0:612:21f8:5afd with SMTP id
 ada2fe7eead31-67c79eba5d9mr6763336137.12.1779724049428; Mon, 25 May 2026
 08:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
 <20260525135241.88348-16-philippe.reynes@softathome.com>
In-Reply-To: <20260525135241.88348-16-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 25 May 2026 11:47:17 -0400
X-Gm-Features: AVHnY4J73I6wWoy-V8eXyj5usX6gQxvmKvNmuAqzO8jlOv3yLKQ_xmerH9Vi6_Y
Message-ID: <CAMDkj5xEJRHdF3R_dU+gJF-VBR5ZKpJ54-qGfsB1-gXc0GG_BQ@mail.gmail.com>
Subject: Re: [PATCH v6 15/15] test: py: vboot: add test for global signature
 with ecdsa
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Philippe,

On Mon, May 25, 2026 at 9:52=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> As now u-boot supports pre-load header with ecdsa, we
> add some tests to vboot with ecdsa pre-load header.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v3:
> - initial version
> v4:
> - no change
> v5:
> - no change
> v6:
> - no change
>
>  test/py/tests/test_vboot.py                   |  3 +++
>  .../tests/vboot/sandbox-binman-ecdsa256.dts   | 24 +++++++++++++++++
>  .../tests/vboot/sandbox-binman-ecdsa384.dts   | 24 +++++++++++++++++
>  .../tests/vboot/sandbox-binman-ecdsa521.dts   | 24 +++++++++++++++++
>  .../vboot/sandbox-u-boot-global-ecdsa256.dts  | 27 +++++++++++++++++++
>  .../vboot/sandbox-u-boot-global-ecdsa384.dts  | 27 +++++++++++++++++++
>  .../vboot/sandbox-u-boot-global-ecdsa521.dts  | 27 +++++++++++++++++++
>  7 files changed, 156 insertions(+)
>  create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa256.dts
>  create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa384.dts
>  create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa521.dts
>  create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dt=
s
>  create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dt=
s
>  create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dt=
s
>

Looks good to me. Thanks!
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>


> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> index 22865f653c5..e0366e06ddb 100644
> --- a/test/py/tests/test_vboot.py
> +++ b/test/py/tests/test_vboot.py
> @@ -102,6 +102,9 @@ TESTDATA_IN =3D [
>      ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', False, False, =
True, False],
>      ['sha256-global-sign', 'sha256', '-rsa2048', '', '', False, False, F=
alse, True],
>      ['sha256-global-sign-pss', 'sha256', '-rsa2048', '-pss', '', False, =
False, False, True],
> +    ['sha256-global-sign-ecdsa256', 'sha256', '-ecdsa256', '', '', False=
, False, False, True],
> +    ['sha256-global-sign-ecdsa384', 'sha256', '-ecdsa384', '', '', False=
, False, False, True],
> +    ['sha256-global-sign-ecdsa521', 'sha256', '-ecdsa521', '', '', False=
, False, False, True],
>  ]
>
>  # Mark all but the first test as slow, so they are not run with '-k not =
slow'
> diff --git a/test/py/tests/vboot/sandbox-binman-ecdsa256.dts b/test/py/te=
sts/vboot/sandbox-binman-ecdsa256.dts
> new file mode 100644
> index 00000000000..0e84b81078b
> --- /dev/null
> +++ b/test/py/tests/vboot/sandbox-binman-ecdsa256.dts
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +
> +       binman {
> +               filename =3D "sandbox.img";
> +
> +               pre-load {
> +                        content =3D <&image>;
> +                        algo-name =3D "sha256,ecdsa256";
> +                        key-name =3D "dev.pem";
> +                        header-size =3D <4096>;
> +                        version =3D <1>;
> +               };
> +
> +               image: blob-ext {
> +                        filename =3D "test.fit";
> +               };
> +       };
> +};
> diff --git a/test/py/tests/vboot/sandbox-binman-ecdsa384.dts b/test/py/te=
sts/vboot/sandbox-binman-ecdsa384.dts
> new file mode 100644
> index 00000000000..56faf67fe57
> --- /dev/null
> +++ b/test/py/tests/vboot/sandbox-binman-ecdsa384.dts
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +
> +       binman {
> +               filename =3D "sandbox.img";
> +
> +               pre-load {
> +                        content =3D <&image>;
> +                        algo-name =3D "sha256,ecdsa384";
> +                        key-name =3D "dev.pem";
> +                        header-size =3D <4096>;
> +                        version =3D <1>;
> +               };
> +
> +               image: blob-ext {
> +                        filename =3D "test.fit";
> +               };
> +       };
> +};
> diff --git a/test/py/tests/vboot/sandbox-binman-ecdsa521.dts b/test/py/te=
sts/vboot/sandbox-binman-ecdsa521.dts
> new file mode 100644
> index 00000000000..8e2fc3de31d
> --- /dev/null
> +++ b/test/py/tests/vboot/sandbox-binman-ecdsa521.dts
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +
> +       binman {
> +               filename =3D "sandbox.img";
> +
> +               pre-load {
> +                        content =3D <&image>;
> +                        algo-name =3D "sha256,ecdsa521";
> +                        key-name =3D "dev.pem";
> +                        header-size =3D <4096>;
> +                        version =3D <1>;
> +               };
> +
> +               image: blob-ext {
> +                        filename =3D "test.fit";
> +               };
> +       };
> +};
> diff --git a/test/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dts b/tes=
t/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dts
> new file mode 100644
> index 00000000000..f15ada3987c
> --- /dev/null
> +++ b/test/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dts
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       model =3D "Sandbox Verified Boot Test";
> +       compatible =3D "sandbox";
> +
> +       binman {
> +       };
> +
> +       reset@0 {
> +               compatible =3D "sandbox,reset";
> +       };
> +
> +       image {
> +               pre-load {
> +                       sig {
> +                               algo-name =3D "sha256,ecdsa256";
> +                               signature-size =3D <64>;
> +                               mandatory =3D "yes";
> +
> +                               key-name =3D "dev";
> +                       };
> +               };
> +       };
> +};
> diff --git a/test/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dts b/tes=
t/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dts
> new file mode 100644
> index 00000000000..24540ace249
> --- /dev/null
> +++ b/test/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dts
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       model =3D "Sandbox Verified Boot Test";
> +       compatible =3D "sandbox";
> +
> +       binman {
> +       };
> +
> +       reset@0 {
> +               compatible =3D "sandbox,reset";
> +       };
> +
> +       image {
> +               pre-load {
> +                       sig {
> +                               algo-name =3D "sha256,ecdsa384";
> +                               signature-size =3D <96>;
> +                               mandatory =3D "yes";
> +
> +                               key-name =3D "dev";
> +                       };
> +               };
> +       };
> +};
> diff --git a/test/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dts b/tes=
t/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dts
> new file mode 100644
> index 00000000000..72fa3b2c790
> --- /dev/null
> +++ b/test/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dts
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       model =3D "Sandbox Verified Boot Test";
> +       compatible =3D "sandbox";
> +
> +       binman {
> +       };
> +
> +       reset@0 {
> +               compatible =3D "sandbox,reset";
> +       };
> +
> +       image {
> +               pre-load {
> +                       sig {
> +                               algo-name =3D "sha256,ecdsa521";
> +                               signature-size =3D <132>;
> +                               mandatory =3D "yes";
> +
> +                               key-name =3D "dev";
> +                       };
> +               };
> +       };
> +};
> --
> 2.43.0
>
