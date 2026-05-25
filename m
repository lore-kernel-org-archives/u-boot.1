Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D0BCD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:46:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A12CB84927;
	Mon, 25 May 2026 17:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oJMnDGCM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D8E684928; Mon, 25 May 2026 17:46:47 +0200 (CEST)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21F8E84859
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-95fa8111713so1783276241.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779724004; cv=none;
 d=google.com; s=arc-20240605;
 b=NIAFBM7ro2t3o2bA1xIVhx1jvOC2kPBBqSwTtNAc+ONOM+Y2P2bCp59aDRYn2ySLj1
 /EELBIff+FPEB0eqEOurr9bvT5Lqp7dQ287OOe3ZHCMVKLHYe9HasOL/lov/5MMV8UHn
 QJEm2abNMp9Pi8Q+49KHVRS5uSzgRp4Rfzs3F13+gmNk5rQhKljWbNxRtdT2F2EaXoZv
 BKhtuhJ7idSTB+y6ZIg3sT0Iy5K9MJnmUGtlR9oM6NLEoP6bUbelrF0n8+CXiArUDORx
 8vWUKqK/feLWY2fcYYNLD/vg3XdPBeAtrUzaelOiPT8wCFTV+rd9to8y9dvipw90uXLS
 A6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pAGZXGhbfmF0Wc/Cwp6dDbqz9+VqMRxI85VHKjcpvvw=;
 fh=1u+KArE6AkcX7wEk9B4wSEjo+gydh4S1BxobRcltr2I=;
 b=JHq9s/+rjIaPTLcSiZvHqX8e94/p7xtR556HtuvENLyJavAOrfdGhj3zeR6RhW0ANS
 9JTqQ/NIeAV2PkY8VUBKKoQ0y9447INzzmDoH3mAApMXR+Xb7xuV9a4P2oROZ8d5fGxq
 43HtOtW6XLz6J7/W1A/lHnMH2dTNI4KCqwi9jtT3Sk8VjeX6lmcYlPAPDEj7mBKcOK9i
 ZDBGwfmn+WR1t5CeBXvCwL1QdPQHVqKUrM/V47a8cFSZG5eavH5ZKZOPXvSCaFBKx3mK
 qcfcVppFH/jO7FgW/baXDXURfJ38sOKHeeRqUMJgWvlPD5XNqZW95T5ftn12ZpHuvQa2
 Vuzg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779724004; x=1780328804; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pAGZXGhbfmF0Wc/Cwp6dDbqz9+VqMRxI85VHKjcpvvw=;
 b=oJMnDGCMhmSt2CRovHMh2AVcUExeNGPON8k1qp5qn456srYyXMWbWh3kqs8mRSCFoN
 MxmHaO2f6mFNbvFe0wLkdtbQt5oiio5sthTrIaOOvcgJutU9EFotUpobevmxuV1nFpT0
 uad88Y3arpJGfV9frk+sA9P/rHqAunIlCDbghNctfBNcZx5kYopgTB4Myj1m9+nU62OO
 HPnle7zbylIMDwG8gsf3Snvx4Lj3GfmtdUwC4AvugVPAPZKlT7XqZuvAlYBu6fU6KQKt
 CpXATlQa0QTQqQA273f/lC6cgu8IdA5IkoG2bQt43MOLlU17EQpZ0DgbS+y/YJNHAk3Q
 msvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779724004; x=1780328804;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pAGZXGhbfmF0Wc/Cwp6dDbqz9+VqMRxI85VHKjcpvvw=;
 b=nL4foGnDlFUz0KmC/d6dlz35cKqYdXWHg7IOhlI6bIiW26ugx3sp2QDdQAPUfWWFOm
 hd2cTMEDtES+rk21G96nTl+u/3HjcfOCL0myLEOLb4EpjBljz5wz4Piyd1oxFFV41bNU
 55jvnc4cG2lCHbaYQc0/yxgNfwNaV6sX36qeya6eVdMSOcBUTApV84q/zgN2/jCs4R/M
 1+NO/P6UtQc1OntVO9749ca0LkuS5lDAyhjC3jJmiE4pKBYgNWOTg5rVEChNeS0UClQI
 cpneQrBv74hyW/7Xhg45FS4SSggvHfxhglLMihp3Q4PuVDIl2BQMDwh5VJy5aO5SAydB
 TEnw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/TV4P3HSwDF1DknomdzAKU4L2fXWfLkJK/mmFxDftPaCkJhdBvvCpgfuyWDe4amA1B6z1HIts=@lists.denx.de
X-Gm-Message-State: AOJu0YwrEbBi+O8t6/pEa6X4HCSjgVBLFHFe83IfPs0V0FAAhbtK6X8q
 1hfAKXutwiA9xIHMva/0dIWZpKlKKRhYAwm5VWOfybcbDAUUjxL19mcwT9KXRPKqM0OQ/pc+KSV
 BodR1gsUGlZoJLKjMqrZgg9U3c2UqaRk=
X-Gm-Gg: Acq92OGY157Kqdl7pCs9KzykrQHJqxvbS4+/KI9JSrotiW4TDCtnD7A6wZFynLrReJh
 SJuoVPhGYA9oMdq7M6TqPMhI64YOKffK0jESmXB5P7phulNQb+GXeMeIUjuGJmOkpFv2E8WeYGl
 Jka6FDRqTgt4yBnEvx8iKEtE1gyyZhGkp5hEUXKU0Ht9qqJaAJd+ujqYqdP5vonuGL3JMfJOB4o
 WzdEc7oYOxqj8PWSY6ove5DePxUY0Qm8B+S2qUD2AxtfTTSVDBcJkbL1S2KNjTYyThhmIYSnPSf
 nEWZfWKx
X-Received: by 2002:a05:6102:3ec6:b0:650:a5d1:ee1d with SMTP id
 ada2fe7eead31-67c7754a9fcmr7149596137.10.1779724003891; Mon, 25 May 2026
 08:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
 <20260525135241.88348-15-philippe.reynes@softathome.com>
In-Reply-To: <20260525135241.88348-15-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 25 May 2026 11:46:32 -0400
X-Gm-Features: AVHnY4LK6srdeJC6xqb6zFBbikduDqy3cxpp3pwr7bvf1oYYaW1toTda8zkV8rY
Message-ID: <CAMDkj5zVngGj3t06J=h=YSWF2vpPfV6+RpK-nrANXJVp97iuOA@mail.gmail.com>
Subject: Re: [PATCH v6 14/15] test: py: vboot: prepare test for global
 signature with ecdsa
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
> The vboot tests only consider rsa for test with global signature.
> To prepare the integration of test with ecdsa test, the signature
> algo is now explicit.
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
>  test/py/tests/test_vboot.py                          | 12 ++++++------
>  ...binman-pss.dts =3D> sandbox-binman-rsa2048-pss.dts} |  0
>  ...sandbox-binman.dts =3D> sandbox-binman-rsa2048.dts} |  0
>  ...pss.dts =3D> sandbox-u-boot-global-rsa2048-pss.dts} |  0
>  ...-global.dts =3D> sandbox-u-boot-global-rsa2048.dts} |  0
>  5 files changed, 6 insertions(+), 6 deletions(-)
>  rename test/py/tests/vboot/{sandbox-binman-pss.dts =3D> sandbox-binman-r=
sa2048-pss.dts} (100%)
>  rename test/py/tests/vboot/{sandbox-binman.dts =3D> sandbox-binman-rsa20=
48.dts} (100%)
>  rename test/py/tests/vboot/{sandbox-u-boot-global-pss.dts =3D> sandbox-u=
-boot-global-rsa2048-pss.dts} (100%)
>  rename test/py/tests/vboot/{sandbox-u-boot-global.dts =3D> sandbox-u-boo=
t-global-rsa2048.dts} (100%)
>

Looks good to me. Thanks!
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>


> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> index 4e4d9529031..22865f653c5 100644
> --- a/test/py/tests/test_vboot.py
> +++ b/test/py/tests/test_vboot.py
> @@ -503,7 +503,7 @@ def test_vboot(ubman, name, sha_algo, sig_algo, paddi=
ng, sign_options, required,
>                            dtb)
>          run_bootm(sha_algo, 'multi required key', '', False)
>
> -    def test_global_sign(sha_algo, padding, sign_options):
> +    def test_global_sign(sha_algo, sig_algo, padding, sign_options):
>          """Test global image signature with the given hash algorithm and=
 padding.
>
>          Args:
> @@ -512,14 +512,14 @@ def test_vboot(ubman, name, sha_algo, sig_algo, pad=
ding, sign_options, required,
>                      rsa signature algorithm.
>          """
>
> -        dtb =3D '%ssandbox-u-boot-global%s.dtb' % (tmpdir, padding)
> +        dtb =3D '%ssandbox-u-boot-global%s%s.dtb' % (tmpdir, sig_algo, p=
adding)
>          ubman.config.dtb =3D dtb
>
>          # Compile our device tree files for kernel and U-Boot. These are
>          # regenerated here since mkimage will modify them (by adding a
>          # public key) below.
>          dtc('sandbox-kernel.dts', ubman, dtc_args, datadir, tmpdir, dtb)
> -        dtc_options('sandbox-u-boot-global%s.dts' % padding, '-p 1024')
> +        dtc_options('sandbox-u-boot-global%s%s.dts' % (sig_algo, padding=
), '-p 1024')
>
>          # Build the FIT with dev key (keys NOT required). This adds the
>          # signature into sandbox-u-boot.dtb, NOT marked 'required'.
> @@ -528,11 +528,11 @@ def test_vboot(ubman, name, sha_algo, sig_algo, pad=
ding, sign_options, required,
>
>          # Build the dtb for binman that define the pre-load header
>          # with the global sigature.
> -        dtc('sandbox-binman%s.dts' % padding, ubman, dtc_args, datadir, =
tmpdir, dtb)
> +        dtc('sandbox-binman%s%s.dts' % (sig_algo, padding), ubman, dtc_a=
rgs, datadir, tmpdir, dtb)
>
>          # Run binman to create the final image with the not signed fit
>          # and the pre-load header that contains the global signature.
> -        run_binman('sandbox-binman%s.dtb' % padding)
> +        run_binman('sandbox-binman%s%s.dtb' % (sig_algo, padding))
>
>          # Check that the signature is correctly verified by u-boot
>          run_bootm(sha_algo, 'global image signature',
> @@ -582,7 +582,7 @@ def test_vboot(ubman, name, sha_algo, sig_algo, paddi=
ng, sign_options, required,
>      try:
>          ubman.config.dtb =3D dtb
>          if global_sign:
> -            test_global_sign(sha_algo, padding, sign_options)
> +            test_global_sign(sha_algo, sig_algo, padding, sign_options)
>          elif required:
>              test_required_key(sha_algo, sig_algo, padding, sign_options)
>          else:
> diff --git a/test/py/tests/vboot/sandbox-binman-pss.dts b/test/py/tests/v=
boot/sandbox-binman-rsa2048-pss.dts
> similarity index 100%
> rename from test/py/tests/vboot/sandbox-binman-pss.dts
> rename to test/py/tests/vboot/sandbox-binman-rsa2048-pss.dts
> diff --git a/test/py/tests/vboot/sandbox-binman.dts b/test/py/tests/vboot=
/sandbox-binman-rsa2048.dts
> similarity index 100%
> rename from test/py/tests/vboot/sandbox-binman.dts
> rename to test/py/tests/vboot/sandbox-binman-rsa2048.dts
> diff --git a/test/py/tests/vboot/sandbox-u-boot-global-pss.dts b/test/py/=
tests/vboot/sandbox-u-boot-global-rsa2048-pss.dts
> similarity index 100%
> rename from test/py/tests/vboot/sandbox-u-boot-global-pss.dts
> rename to test/py/tests/vboot/sandbox-u-boot-global-rsa2048-pss.dts
> diff --git a/test/py/tests/vboot/sandbox-u-boot-global.dts b/test/py/test=
s/vboot/sandbox-u-boot-global-rsa2048.dts
> similarity index 100%
> rename from test/py/tests/vboot/sandbox-u-boot-global.dts
> rename to test/py/tests/vboot/sandbox-u-boot-global-rsa2048.dts
> --
> 2.43.0
>
