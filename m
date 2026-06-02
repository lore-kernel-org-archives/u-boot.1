Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDF4CD6E5D
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 00:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 040DD848BF;
	Wed,  3 Jun 2026 02:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="eItoB9Ku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3490284852; Tue,  2 Jun 2026 22:51:40 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0940283EF9
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 22:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-43bfe055ffbso5552850fac.1
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 13:51:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780433496; cv=none;
 d=google.com; s=arc-20240605;
 b=bSnACCgZ9VbudaHB79hF5D5DUsVuyxotANnm34fKtHfHZA0RsS/wLTweCNFJaUvDee
 LKGU6u0EFPe+vQKlha3nqtAWPeNBOGBZjx9OQfYhsxzVGHAcY2uQD4Z2yxCUVMkmzZPP
 sR30XLmCzTVCahYj/R2rcaYcWZeZhpPJOUWtV4xJCNb7PVc1KAGqrPCvbU0ayeBGl3Ou
 F9Z+lg0Zz91qTkodtJWHiZxjvTZ0qZNCLuh33UIvSuadsNaSaaUlN18lN8LYnZ3Q5SBa
 9rWDN8pS3ysvcbh1Panv8KkoDa4YTmEZgqd660n30mN8DsnoAi5CazUAwBIcXX13CNWP
 HY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XuUD5KSh4bex9uDbGvPuxMhB0w7yY1+qBQs8pUM46qQ=;
 fh=Izbdq19tYuaSLEnUqWglopKcXodM0RqGCEWrXQtICcs=;
 b=LtD/IVcmTg30HMB9LGolxUuBn2XHBK+hYMIUTXQOC5vaFchkGj8WmQLYIZ9TLP6W82
 IngaHYiWUHijsu1vH9Brqiylu2W6d6pNyB1oMSdIrS5EDkcTp0dEsxK6LorQRiaBz+3B
 +sd12Y0zKEak9e1L7uHblHzxsM/O8c5xXtmX1cYTMlRFxRYAzRJyN0PC7yhdMFaXlDiY
 Wfo9T+zPiVoEvubXPzVCdp9IPYa52VEdV885fCsyGXPDTvEQWwhI6KML+mRqEgW5WRkq
 VxVkiwE7ZGMFEMpOPswubsFmvaAy1dc4saqfh3KfqWLmm36BmHQffl9to+jbzNQDFCBS
 PVLg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1780433496; x=1781038296; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XuUD5KSh4bex9uDbGvPuxMhB0w7yY1+qBQs8pUM46qQ=;
 b=eItoB9Ku8W+95m/6qhM4c/8zTi0qjrro/r1mmTIlZHVmncSZC92EU3zsOyI3UiQvD5
 1Mt+0Bp8hQ1e0/ynD9L/CCIBuPw0f0R1X/yjNzAL8T5lrWxqlHgoue2y3NBGfFbR5Yt2
 Rq+ARXH+gz9B7f7o5BbuQn6pO5yxWbQyllT+X0kkI7qo/cScmiBv9/elVNplHzg6QkiR
 UzPXjmCN6DZ5W6wgB2iEmQoFJpC4WTJMQPEL3oL2ND/ZsTy6AOjmiRZagebcNWLJofuM
 TkNftMieMOExQf+ATNV7g7UO6wM9KOYcx0zin2+8HKuAaLPO7lYkSAQqnpmGcdABLjjX
 t2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780433496; x=1781038296;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XuUD5KSh4bex9uDbGvPuxMhB0w7yY1+qBQs8pUM46qQ=;
 b=B92NjcWZrD0RGMTaaAfCLng5kYH7Gm5TX9u4TwX2ytzq70Nxz5Abjc0o6it8D8YCIB
 1MoMFGlbn5SdwdlopxjYPoecF3YstGcs6h8Y9AKwGkldaENoshwG/FNE22pXpwnvipxW
 fJwPNbB/jL1emcr5qlNv8C7bhMoiybemesPinCGe2hq6A9FkGPXzaXFLjps9xd5ECBCX
 1MHWaZPaYwIW4kkjmyz60lVB2MOPGwbZQ0GyxGSjKqfHoOgsESgme4r2EtfeoJp+v7At
 8VG6PEkAR/EFRNi90aJ75JjMAAIhcEN2ss1JEtLhsHVr/EpJjybCERJoWkFsPL6IdFZU
 IPaQ==
X-Gm-Message-State: AOJu0Ywx8yaSDiWRgxm/VWnuhafV7cPiF4xMz8UD1mKBslM4TBL871Hr
 CDus9B5snI+I2Sf3D8KrQoYPb1F8QtjGv4Hw4zOkEIXVoosufEkzT8cUnOxVGY8Cc9PpRXfaB9s
 hymMbyPYI7UiYSb1vQ2dMh/xUwJLM3HaUwjWQB/FIJn8Gkczl9Msvuhkvs/ee
X-Gm-Gg: Acq92OE4Q2z5/EbUggUH2PHg/GNkKsjPNoz4zcRc27+XL6qWDo67vWhuxlAcvfObLE5
 0Gtl/4i+tEZMlrdRg6FrcfYdqIFHaYiv+5t5u4H2ML3XTWY68l4r4nea40W/ZQetNrYGzcbXts8
 qHj1/GF+PDqUC/iKiNw0YtYHJUWa8dbVuoItREqW+oAD48mrjmwuYcZHRCZhT1W0qpA2Q5cKE4M
 QWPMhBs1Oinlp1nzPkX4t53Sm4XpPLJrg20PpZ0UMHwBll742UmQmttABUqh9cnuF1XRbeyMEhc
 XofsmeWD6DsOsqQSPw==
X-Received: by 2002:a05:6870:8274:b0:43e:942:dfab with SMTP id
 586e51a60fabf-440dbb23a7bmr468815fac.33.1780433495651; Tue, 02 Jun 2026
 13:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260527112518.16085-1-anton@binarly.io>
 <20260602183052.65247-1-anton@binarly.io>
In-Reply-To: <20260602183052.65247-1-anton@binarly.io>
From: Anton Ivanov <anton@binarly.io>
Date: Tue, 2 Jun 2026 21:51:24 +0100
X-Gm-Features: AVHnY4KQ7jidC7KPSisOSwwiKgRhAgjxF6s_RFtpEP42ONosboLDRp3LhmkzY5o
Message-ID: <CAPWaX56oz=ORd+2A7HfDYTJZUw+6SjP_x3w4uRLt6S=6bwzyMg@mail.gmail.com>
Subject: Re: [PATCH v4] image-fit: Validate external data offset and size
To: u-boot@lists.denx.de, sjg@chromium.org
Cc: trini@konsulko.com, vr@binarly.io
X-Mailman-Approved-At: Wed, 03 Jun 2026 02:23:44 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

For this fix, offset/len could be made uint32_t, as was done in the patch
titled "image-fit-sig: Validate hashed-strings region size", but this
would require changing the prototypes of fit_image_get_data_position(),
fit_image_get_data_offset() and fit_image_get_data_size(). Please confirm
whether this is acceptable.

Thank you,
Anton


On Tue, Jun 2, 2026 at 7:30=E2=80=AFPM Anton Ivanov <anton@binarly.io> wrot=
e:

> fit_image_get_data() uses the data-position, data-offset, and
> data-size FIT properties without bounds checking. A crafted FIT
> image can specify values that cause out-of-bounds read during
> signature verification of an untrusted FIT.
>
> Validate that the external data offset and size are non-negative,
> and that the data region fits within the FIT image bounds.
>
> Signed-off-by: Anton Ivanov <anton@binarly.io>
> ---
> Changes in v4:
> - Add test for external data bounds validation
> - Clarify vulnerability reachability in the commit message
>
> Changes in v3:
> - Update From and Signed-off-by to personal email
>
> Changes in v2:
> - Rewrite commit message to be concise per maintainer feedback
>
>  boot/image-fit.c            |  16 ++++
>  test/py/tests/test_vboot.py | 165 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 181 insertions(+)
>
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index b0fcaf6e17f..b657142f626 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -1084,8 +1084,24 @@ int fit_image_get_data(const void *fit, int
> noffset, const void **data,
>
>         if (external_data) {
>                 debug("External Data\n");
> +               if (offset < 0 || offset > UINTPTR_MAX - (uintptr_t)fit) =
{
> +                       printf("Invalid external data offset: %d\n",
> offset);
> +                       return -1;
> +               }
> +
>                 ret =3D fit_image_get_data_size(fit, noffset, &len);
>                 if (!ret) {
> +                       if (len < 0) {
> +                               printf("Invalid external data size: %d\n"=
,
> len);
> +                               return -1;
> +                       }
> +#if CONFIG_IS_ENABLED(FIT_SIGNATURE)
> +                       if (len > CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE) -
> offset) {
> +                               printf("FIT external data is out of bound=
s
> (offset=3D%d, size=3D%d)\n",
> +                                      offset, len);
> +                               return -1;
> +                       }
> +#endif
>                         *data =3D fit + offset;
>                         *size =3D len;
>                 }
> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> index 55518bed07e..85a1bd56af6 100644
> --- a/test/py/tests/test_vboot.py
> +++ b/test/py/tests/test_vboot.py
> @@ -563,6 +563,171 @@ def test_vboot(ubman, name, sha_algo, padding,
> sign_options, required,
>          ubman.restart_uboot()
>
>
> +@pytest.mark.boardspec('sandbox')
> +@pytest.mark.buildconfigspec('fit_signature')
> +@pytest.mark.requiredtool('dtc')
> +@pytest.mark.requiredtool('fdtput')
> +@pytest.mark.requiredtool('openssl')
> +def test_vboot_ext_data_bounds(ubman):
> +    """Test that malformed external-data properties are rejected.
> +
> +    A signed FIT with external data exposes 'data-position',
> 'data-offset' and
> +    'data-size' properties. U-Boot must validate these before hashing th=
e
> image
> +    components, otherwise a crafted FIT could trigger an out-of-bounds
> access
> +    during signature verification.
> +
> +    These checks are independent of the hashing algorithm, so a single
> signing
> +    configuration is enough.
> +
> +    This works using sandbox only as it needs to update the device tree
> used
> +    by U-Boot to hold public keys from the signing process.
> +    """
> +    sha_algo =3D 'sha256'
> +
> +    def run_bootm(test_type, expect_string):
> +        """Run a 'bootm' command in U-Boot and expect it to fail.
> +
> +        This always starts a fresh U-Boot instance since the device tree
> may
> +        contain a new public key.
> +
> +        Args:
> +            test_type: A string identifying the test type.
> +            expect_string: A string which is expected in the output.
> +        """
> +        ubman.restart_uboot()
> +        with ubman.log.section('Verified boot %s %s' % (sha_algo,
> test_type)):
> +            output =3D ubman.run_command_list(
> +                ['host load hostfs - 100 %s' % fit,
> +                 'fdt addr 100',
> +                 'bootm 100'])
> +        assert expect_string in ''.join(output)
> +        assert 'sandbox: continuing, as we cannot run' not in
> ''.join(output)
> +
> +    def sign_fit(options):
> +        """Sign the FIT
> +
> +        Signs the FIT and writes the signature into it. It also writes t=
he
> +        public key into the dtb.
> +
> +        Args:
> +            options: Options to provide to mkimage.
> +        """
> +        args =3D [mkimage, '-F', '-k', tmpdir, '-K', dtb, '-r', fit]
> +        if options:
> +            args +=3D options.split(' ')
> +        ubman.log.action('%s: Sign images' % sha_algo)
> +        utils.run_and_log(ubman, args)
> +
> +    def create_rsa_pair(name):
> +        """Generate a new RSA key pair and certificate.
> +
> +        Args:
> +            name: Name of the key (e.g. 'dev')
> +        """
> +        public_exponent =3D 65537
> +        utils.run_and_log(ubman, 'openssl genpkey -algorithm RSA -out
> %s%s.key '
> +                     '-pkeyopt rsa_keygen_bits:2048 '
> +                     '-pkeyopt rsa_keygen_pubexp:%d' %
> +                     (tmpdir, name, public_exponent))
> +
> +        # Create a certificate containing the public key
> +        utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key
> %s%s.key '
> +                          '-out %s%s.crt' % (tmpdir, name, tmpdir, name)=
)
> +
> +    def set_external_data(prop, value):
> +        """Set an external-data property of the kernel image.
> +
> +        Args:
> +            prop: Property name
> +            value: The new value of the property
> +        """
> +        utils.run_and_log(
> +            ubman, 'fdtput -t x %s /images/kernel %s %#x' % (fit, prop,
> value)
> +        )
> +
> +    def make_signed_fit():
> +        """Build a fresh signed FIT with external data.
> +
> +        sign_fit() overwrites the FIT, so a new one is built before each
> test
> +        case mutates its external-data properties.
> +        """
> +        make_fit('sign-configs-%s.its' % sha_algo, ubman, mkimage,
> dtc_args,
> +                 datadir, fit)
> +        sign_fit('-E')
> +
> +    tmpdir =3D os.path.join(ubman.config.result_dir, 'ext-data-bounds') =
+
> '/'
> +    if not os.path.exists(tmpdir):
> +        os.mkdir(tmpdir)
> +    datadir =3D ubman.config.source_dir + '/test/py/tests/vboot/'
> +    fit =3D '%stest.fit' % tmpdir
> +    mkimage =3D ubman.config.build_dir + '/tools/mkimage'
> +    dtc_args =3D '-I dts -O dtb -i %s' % tmpdir
> +    dtb =3D '%ssandbox-u-boot.dtb' % tmpdir
> +
> +    bcfg =3D ubman.config.buildconfig
> +    max_size =3D int(bcfg.get('config_fit_signature_max_size', 0x1000000=
0),
> 0)
> +
> +    create_rsa_pair('dev')
> +
> +    # Create a kernel image filled with zeroes
> +    with open('%stest-kernel.bin' % tmpdir, 'wb') as fd:
> +        fd.write(500 * b'\0')
> +
> +    testcases =3D [
> +        ('negative data-position',
> +         {'data-position': 0xFFFFFFFF}, 'Invalid external data offset'),
> +        ('negative data-offset',
> +         {'data-offset': 0x80000000}, 'Invalid external data offset'),
> +        ('negative data-size',
> +         {'data-size': 0xFFFFFFFF}, 'Invalid external data size'),
> +        ('off-bounds data-position',
> +         {'data-position': 0x7FFFFFFF}, 'FIT external data is out of
> bounds'),
> +        ('off-bounds data-offset',
> +         {'data-offset': 0x10000000}, 'FIT external data is out of
> bounds'),
> +        ('oversized data-size',
> +         {'data-size': 0x7FFFFFFF}, 'FIT external data is out of bounds'=
),
> +        ('off-bounds data-position',
> +         {'data-position': max_size + 1, 'data-size': 0},
> +         'FIT external data is out of bounds'),
> +        ('off-bounds data-offset',
> +         {'data-offset': max_size + 1, 'data-size': 0},
> +         'FIT external data is out of bounds'),
> +        ('oversized data-size',
> +         {'data-position': 0x0, 'data-size': max_size + 1},
> +         'FIT external data is out of bounds'),
> +        ('in-bounds data-position',
> +         {'data-position': max_size, 'data-size': 0}, 'Bad Data Hash'),
> +        ('in-bounds data-offset',
> +         {'data-offset': max_size, 'data-size': 0}, 'Bad Data Hash'),
> +        ('in-bounds data-size',
> +         {'data-position': 0x0, 'data-size': max_size}, 'Bad Data Hash')=
,
> +    ]
> +
> +    # We need to use our own device tree file. Remember to restore it
> +    # afterwards.
> +    old_dtb =3D ubman.config.dtb
> +    try:
> +        ubman.config.dtb =3D dtb
> +
> +        # Compile our device tree files for kernel and U-Boot. These are
> +        # regenerated here since mkimage will modify them (by adding a
> +        # public key) below.
> +        dtc('sandbox-kernel.dts', ubman, dtc_args, datadir, tmpdir, dtb)
> +        dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
> +
> +        ubman.log.action(
> +            '%s: Test signed FIT with malformed external-data properties=
'
> % sha_algo)
> +        for desc, props, expect_string in testcases:
> +            make_signed_fit()
> +            for prop, value in props.items():
> +                set_external_data(prop, value)
> +            run_bootm('Signed config with %s' % desc, expect_string)
> +    finally:
> +        # Go back to the original U-Boot with the correct dtb.
> +        ubman.config.dtb =3D old_dtb
> +        ubman.restart_uboot()
> +
> +
>  TESTDATA_IN =3D [
>      ['sha1-basic', 'sha1', '', None, False],
>      ['sha1-pad', 'sha1', '', '-E -p 0x10000', False],
> --
> 2.53.0
>
