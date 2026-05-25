Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59EDCD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DCFC848FC;
	Mon, 25 May 2026 17:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Am7Cfgaq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8801284903; Mon, 25 May 2026 17:33:34 +0200 (CEST)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BD03848BD
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-63129bf2af0so3551597137.2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:33:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779723211; cv=none;
 d=google.com; s=arc-20240605;
 b=OL7Y2OlzItU+3vq5AeJLanCj1QyOjyXKLJQjxOmO7BCh91Aq/XimrRiC+BrpsxrGC1
 iMel0FS7Qw9Lr7Ma1iFiQdcfRXjKj+QXtvem+NiXwQaesJsSOWxCqNELErIGDIdormRz
 lwrWkWcv/is3guZbtZ4byHAzRlngKRpBeIr6xWvuebXa0rBrR+gLujV03i3YdOpE1S8V
 2/FnKGG8xQCRINi62hlsO5ef3D3wXzl+D6h1BZJY1uERqxacuW7Rq4Y5xDE1vAHh4Y6l
 DZ2ey6Z1BEoEeiquj4vzs0Y1zjFGhHY23fABhpTu7w4IUoFu3RuIf+BHIkpjVL3+5gUb
 g3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sY+kBJxGZxMFgTRDQHE0luySZp9i5wVYvufs2AMPe7k=;
 fh=JMvhdiNKgPuH5aluaH9k9ogeptnQGqay9fJOFgXPYis=;
 b=KG7jU+kxL7FPoKxOFASlwSv68tqPrbG1GFo7OY78+l4he0olKsR2ORYf36B6+AiirD
 rjaiOH8udVFFPtp+PvUsXZ1omu0NS0Iz4sUGbun6QgZ8k0cGyLgP93sOLSt6k26nDImc
 XE4A111wrbzE3474ktjOP8oN1V1/xxl1R+hXy9WnUsDVp0LHwIqtvVLnIe9amEywMS/+
 bpI5vFqNmAuZ1/quENCBwIeiVf1E7/OlyW+saInpMUUTm+Fql2GiEkqoy1zJOR5h3lG6
 bjMyPOdgMurlze8TPIKhhbLQfvDHAVFC9KqCptDIlOGv9gHFjyffYFkueRhYfPpBOuK9
 uZ5A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779723211; x=1780328011; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sY+kBJxGZxMFgTRDQHE0luySZp9i5wVYvufs2AMPe7k=;
 b=Am7CfgaqsiChCTHN9+/fHOaoCklDdeFr/pD4r1yJZUfvxCLnY63ybhVX+0gDPtRfsi
 obV8QfnxbzdbSYy98/XPvSsHDppw9fTQSYftVqM3tb1gIt6vXu44lv2dfsYDJXK2IsB2
 VCZALWIFZX7bfMju66KhH3bBIeJJwbTDnh/bL1Ncb5jjn+hdumLae2H9bKH5Uwxq06Gl
 mJK6hnVVhJ54yTDb63jx+tdnP7mxqrxkHvwHIgBnAZppGTHfT++GW+tvPO/8h7hqtjC3
 98YL+tFSB+k1cuTInXJH9a3kT6T1vkSJn9IkGUIdGn35YvIAJHsZJfE/jNSwY/Vzz0UK
 yiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779723211; x=1780328011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sY+kBJxGZxMFgTRDQHE0luySZp9i5wVYvufs2AMPe7k=;
 b=iRK/m8Bz9GhvIPaZVPJ3csZgG0az/J1mV/NC5Qn0mkItGbk2XUgr+MB4JukN5ylsO4
 UbTXlhH59+w7hF0u+B84Gn91zdDdZOgIwS3UxOnCQSBhWcCzd3hnle1jJDPNnKH+EwOO
 KhumHSHQH6+Zfz0UXO/wj9AbXiZ9D2GxHqBOA6fWRcYLNuy1NrOoNhciplfbhWQV10g1
 64ELHlg+e8lFF5B78TxcZRweIOArDTp5+V4OxLa5apofmt3uUhmj0EiRKSUEQ1UBkM2k
 vmkNTymIFA8HF7dnvKhu/Pe976rlVc1CzrxVbqvzjQmqN0X/e5jBoN0PCAay/zZzKRbo
 FYCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/WIHHBFJrByvkTd3sabJ4md2Olr0uvfsgbe8Ga3icSwx7L53oqTrQEtZHD9hC6gsQTZ9mU+8w=@lists.denx.de
X-Gm-Message-State: AOJu0Ywwa6vYbUOTaIhpWF0ivUbxyEzmdpaE3d4ESItReEHEcnMM2L/u
 Rtel/MvrugSNu5hFUwIcZSkk/lwe2pjFDJoZoDVyhvGObR09msQeuyhCaVZm0sW6sHrBjb1fRir
 lzpzGvf1DGdKsdpD6ChOkB7ogjOR8ldI=
X-Gm-Gg: Acq92OEcZzVVrwhN+seF9kc5W2OnpKGXq5kJM7y3qPJ1C034tvKg3o2lUjSH3aF9Dya
 RL5ocYsgsj55kbjXwKUjSBTIj8wOTCNE2W2wt6U+C58vIs0kFUS9/7h0FrgMaRzg43VSZlxSKJB
 ElKd7wBqNZktfW2Uo87LDizi1iYDVnrvkHWAbc8dIdp53DCnS4BrNK16LPeguYLEY9hTRYINda/
 2nl0Aaxjyd95H6qcR5c4lSHoDlVaYAGoAhks5zg229nWzBmDNW1NtO65ORedcBi3D74sML3p3Dh
 ecV2Z2JdQovOc8aQ3d4=
X-Received: by 2002:a05:6102:3046:b0:631:487a:23ab with SMTP id
 ada2fe7eead31-67c7151ace8mr7784510137.5.1779723210881; Mon, 25 May 2026
 08:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
 <20260525135241.88348-9-philippe.reynes@softathome.com>
In-Reply-To: <20260525135241.88348-9-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 25 May 2026 11:33:19 -0400
X-Gm-Features: AVHnY4K2EeMv2Cpi14UwHFWobAm6U5MGkEhluq1BdrNQXqIrXzeVm7JvwedeuIU
Message-ID: <CAMDkj5w3=50aCWyzq=uK6jWkjyHvVWVaw03hrzN7PNNR2kt5uA@mail.gmail.com>
Subject: Re: [PATCH v6 08/15] test: vboot: add test for ecdsa
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
> This commit adds test case for ecdsa on fit, but not (yet) for
> the global image signature (preload).
>
> Reviewed-by: Simon Glass <simon.glass@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - initial version
> v3:
> - no change
> v4:
> - no change
> v5:
> - no change
> v6:
> - no change
>
>  test/py/tests/test_vboot.py                   | 29 ++++++++++++
>  .../vboot/sign-configs-sha256-ecdsa256.its    | 45 +++++++++++++++++++
>  .../vboot/sign-configs-sha256-ecdsa384.its    | 45 +++++++++++++++++++
>  .../vboot/sign-configs-sha256-ecdsa521.its    | 45 +++++++++++++++++++
>  .../vboot/sign-images-sha256-ecdsa256.its     | 42 +++++++++++++++++
>  .../vboot/sign-images-sha256-ecdsa384.its     | 42 +++++++++++++++++
>  .../vboot/sign-images-sha256-ecdsa521.its     | 42 +++++++++++++++++
>  7 files changed, 290 insertions(+)
>  create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
>  create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
>  create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
>  create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa256.its
>  create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa384.its
>  create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa521.its
>

Looks good to me. Thanks!
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>


> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> index 496d314c649..4e4d9529031 100644
> --- a/test/py/tests/test_vboot.py
> +++ b/test/py/tests/test_vboot.py
> @@ -94,6 +94,9 @@ TESTDATA_IN =3D [
>      ['sha256-pss-pad', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', Fa=
lse, False, False, False],
>      ['sha256-pss-required', 'sha256', '-rsa2048', '-pss', None, True, Fa=
lse, False, False],
>      ['sha256-pss-pad-required', 'sha256', '-rsa2048', '-pss', '-E -p 0x1=
0000', True, True, False, False],
> +    ['sha256-basic-ecdsa256', 'sha256', '-ecdsa256', '', None, False, Fa=
lse, False, False],
> +    ['sha256-basic-ecdsa384', 'sha256', '-ecdsa384', '', None, False, Fa=
lse, False, False],
> +    ['sha256-basic-ecdsa521', 'sha256', '-ecdsa521', '', None, False, Fa=
lse, False, False],
>      ['sha384-basic', 'sha384', '-rsa3072', '', None, False, False, False=
, False],
>      ['sha384-pad', 'sha384', '-rsa3072', '', '-E -p 0x10000', False, Fal=
se, False, False],
>      ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', False, False, =
True, False],
> @@ -287,6 +290,29 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padd=
ing, sign_options, required,
>          utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %s%=
s.key '
>                            '-out %s%s.crt' % (tmpdir, name, tmpdir, name)=
)
>
> +    def create_ecdsa_pair(name):
> +        """Generate a new ECDSA key pair
> +
> +        Args:
> +            name: Name of the key (e.g. 'dev')
> +        """
> +
> +        if sig_algo =3D=3D "-ecdsa256":
> +            curve_name =3D "secp256r1"
> +        elif sig_algo =3D=3D "-ecdsa384":
> +            curve_name =3D "secp384r1"
> +        elif sig_algo =3D=3D "-ecdsa521":
> +            curve_name =3D "secp521r1"
> +        else:
> +            curve_name =3D "unknownCurve"
> +
> +        utils.run_and_log(ubman, 'openssl ecparam -name %s -genkey -noou=
t -out %s%s.pem' %
> +                     (curve_name, tmpdir, name))
> +
> +        # Create a certificate containing the public key
> +        utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %s%=
s.pem '
> +                          '-out %s%s.crt' % (tmpdir, name, tmpdir, name)=
)
> +
>      def test_with_algo(sha_algo, sig_algo, padding, sign_options):
>          """Test verified boot with the given hash algorithm.
>
> @@ -537,6 +563,9 @@ def test_vboot(ubman, name, sha_algo, sig_algo, paddi=
ng, sign_options, required,
>      if sig_algo =3D=3D "-rsa2048" or sig_algo =3D=3D "-rsa3072" or sig_a=
lgo =3D=3D "":
>          create_rsa_pair('dev')
>          create_rsa_pair('prod')
> +    elif sig_algo =3D=3D "-ecdsa256" or sig_algo =3D=3D "-ecdsa384" or s=
ig_algo =3D=3D "-ecdsa521":
> +        create_ecdsa_pair('dev')
> +        create_ecdsa_pair('prod')
>
>      # Create a number kernel image with zeroes
>      with open('%stest-kernel.bin' % tmpdir, 'wb') as fd:
> diff --git a/test/py/tests/vboot/sign-configs-sha256-ecdsa256.its b/test/=
py/tests/vboot/sign-configs-sha256-ecdsa256.its
> new file mode 100644
> index 00000000000..4d0ef903a78
> --- /dev/null
> +++ b/test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
> @@ -0,0 +1,45 @@
> +/dts-v1/;
> +
> +/ {
> +       description =3D "Chrome OS kernel image with one or more FDT blob=
s";
> +       #address-cells =3D <1>;
> +
> +       images {
> +               kernel {
> +                       data =3D /incbin/("test-kernel.bin");
> +                       type =3D "kernel_noload";
> +                       arch =3D "sandbox";
> +                       os =3D "linux";
> +                       compression =3D "none";
> +                       load =3D <0x4>;
> +                       entry =3D <0x8>;
> +                       kernel-version =3D <1>;
> +                       hash-1 {
> +                               algo =3D "sha256";
> +                       };
> +               };
> +               fdt-1 {
> +                       description =3D "snow";
> +                       data =3D /incbin/("sandbox-kernel.dtb");
> +                       type =3D "flat_dt";
> +                       arch =3D "sandbox";
> +                       compression =3D "none";
> +                       fdt-version =3D <1>;
> +                       hash-1 {
> +                               algo =3D "sha256";
> +                       };
> +               };
> +       };
> +       configurations {
> +               default =3D "conf-1";
> +               conf-1 {
> +                       kernel =3D "kernel";
> +                       fdt =3D "fdt-1";
> +                       signature {
> +                               algo =3D "sha256,ecdsa256";
> +                               key-name-hint =3D "dev";
> +                               sign-images =3D "fdt", "kernel";
> +                       };
> +               };
> +       };
> +};
> diff --git a/test/py/tests/vboot/sign-configs-sha256-ecdsa384.its b/test/=
py/tests/vboot/sign-configs-sha256-ecdsa384.its
> new file mode 100644
> index 00000000000..10427b43659
> --- /dev/null
> +++ b/test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
> @@ -0,0 +1,45 @@
> +/dts-v1/;
> +
> +/ {
> +       description =3D "Chrome OS kernel image with one or more FDT blob=
s";
> +       #address-cells =3D <1>;
> +
> +       images {
> +               kernel {
> +                       data =3D /incbin/("test-kernel.bin");
> +                       type =3D "kernel_noload";
> +                       arch =3D "sandbox";
> +                       os =3D "linux";
> +                       compression =3D "none";
> +                       load =3D <0x4>;
> +                       entry =3D <0x8>;
> +                       kernel-version =3D <1>;
> +                       hash-1 {
> +                               algo =3D "sha256";
> +                       };
> +               };
> +               fdt-1 {
> +                       description =3D "snow";
> +                       data =3D /incbin/("sandbox-kernel.dtb");
> +                       type =3D "flat_dt";
> +                       arch =3D "sandbox";
> +                       compression =3D "none";
> +                       fdt-version =3D <1>;
> +                       hash-1 {
> +                               algo =3D "sha256";
> +                       };
> +               };
> +       };
> +       configurations {
> +               default =3D "conf-1";
> +               conf-1 {
> +                       kernel =3D "kernel";
> +                       fdt =3D "fdt-1";
> +                       signature {
> +                               algo =3D "sha256,ecdsa384";
> +                               key-name-hint =3D "dev";
> +                               sign-images =3D "fdt", "kernel";
> +                       };
> +               };
> +       };
> +};
> diff --git a/test/py/tests/vboot/sign-configs-sha256-ecdsa521.its b/test/=
py/tests/vboot/sign-configs-sha256-ecdsa521.its
> new file mode 100644
> index 00000000000..a65593ec64b
> --- /dev/null
> +++ b/test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
> @@ -0,0 +1,45 @@
> +/dts-v1/;
> +
> +/ {
> +       description =3D "Chrome OS kernel image with one or more FDT blob=
s";
> +       #address-cells =3D <1>;
> +
> +       images {
> +               kernel {
> +                       data =3D /incbin/("test-kernel.bin");
> +                       type =3D "kernel_noload";
> +                       arch =3D "sandbox";
> +                       os =3D "linux";
> +                       compression =3D "none";
> +                       load =3D <0x4>;
> +                       entry =3D <0x8>;
> +                       kernel-version =3D <1>;
> +                       hash-1 {
> +                               algo =3D "sha256";
> +                       };
> +               };
> +               fdt-1 {
> +                       description =3D "snow";
> +                       data =3D /incbin/("sandbox-kernel.dtb");
> +                       type =3D "flat_dt";
> +                       arch =3D "sandbox";
> +                       compression =3D "none";
> +                       fdt-version =3D <1>;
> +                       hash-1 {
> +                               algo =3D "sha256";
> +                       };
> +               };
> +       };
> +       configurations {
> +               default =3D "conf-1";
> +               conf-1 {
> +                       kernel =3D "kernel";
> +                       fdt =3D "fdt-1";
> +                       signature {
> +                               algo =3D "sha256,ecdsa521";
> +                               key-name-hint =3D "dev";
> +                               sign-images =3D "fdt", "kernel";
> +                       };
> +               };
> +       };
> +};
> diff --git a/test/py/tests/vboot/sign-images-sha256-ecdsa256.its b/test/p=
y/tests/vboot/sign-images-sha256-ecdsa256.its
> new file mode 100644
> index 00000000000..009003bb601
> --- /dev/null
> +++ b/test/py/tests/vboot/sign-images-sha256-ecdsa256.its
> @@ -0,0 +1,42 @@
> +/dts-v1/;
> +
> +/ {
> +       description =3D "Chrome OS kernel image with one or more FDT blob=
s";
> +       #address-cells =3D <1>;
> +
> +       images {
> +               kernel {
> +                       data =3D /incbin/("test-kernel.bin");
> +                       type =3D "kernel_noload";
> +                       arch =3D "sandbox";
> +                       os =3D "linux";
> +                       compression =3D "none";
> +                       load =3D <0x4>;
> +                       entry =3D <0x8>;
> +                       kernel-version =3D <1>;
> +                       signature {
> +                               algo =3D "sha256,ecdsa256";
> +                               key-name-hint =3D "dev";
> +                       };
> +               };
> +               fdt-1 {
> +                       description =3D "snow";
> +                       data =3D /incbin/("sandbox-kernel.dtb");
> +                       type =3D "flat_dt";
> +                       arch =3D "sandbox";
> +                       compression =3D "none";
> +                       fdt-version =3D <1>;
> +                       signature {
> +                               algo =3D "sha256,ecdsa256";
> +                               key-name-hint =3D "dev";
> +                       };
> +               };
> +       };
> +       configurations {
> +               default =3D "conf-1";
> +               conf-1 {
> +                       kernel =3D "kernel";
> +                       fdt =3D "fdt-1";
> +               };
> +       };
> +};
> diff --git a/test/py/tests/vboot/sign-images-sha256-ecdsa384.its b/test/p=
y/tests/vboot/sign-images-sha256-ecdsa384.its
> new file mode 100644
> index 00000000000..567de687a06
> --- /dev/null
> +++ b/test/py/tests/vboot/sign-images-sha256-ecdsa384.its
> @@ -0,0 +1,42 @@
> +/dts-v1/;
> +
> +/ {
> +       description =3D "Chrome OS kernel image with one or more FDT blob=
s";
> +       #address-cells =3D <1>;
> +
> +       images {
> +               kernel {
> +                       data =3D /incbin/("test-kernel.bin");
> +                       type =3D "kernel_noload";
> +                       arch =3D "sandbox";
> +                       os =3D "linux";
> +                       compression =3D "none";
> +                       load =3D <0x4>;
> +                       entry =3D <0x8>;
> +                       kernel-version =3D <1>;
> +                       signature {
> +                               algo =3D "sha256,ecdsa384";
> +                               key-name-hint =3D "dev";
> +                       };
> +               };
> +               fdt-1 {
> +                       description =3D "snow";
> +                       data =3D /incbin/("sandbox-kernel.dtb");
> +                       type =3D "flat_dt";
> +                       arch =3D "sandbox";
> +                       compression =3D "none";
> +                       fdt-version =3D <1>;
> +                       signature {
> +                               algo =3D "sha256,ecdsa384";
> +                               key-name-hint =3D "dev";
> +                       };
> +               };
> +       };
> +       configurations {
> +               default =3D "conf-1";
> +               conf-1 {
> +                       kernel =3D "kernel";
> +                       fdt =3D "fdt-1";
> +               };
> +       };
> +};
> diff --git a/test/py/tests/vboot/sign-images-sha256-ecdsa521.its b/test/p=
y/tests/vboot/sign-images-sha256-ecdsa521.its
> new file mode 100644
> index 00000000000..74ed45b21b8
> --- /dev/null
> +++ b/test/py/tests/vboot/sign-images-sha256-ecdsa521.its
> @@ -0,0 +1,42 @@
> +/dts-v1/;
> +
> +/ {
> +       description =3D "Chrome OS kernel image with one or more FDT blob=
s";
> +       #address-cells =3D <1>;
> +
> +       images {
> +               kernel {
> +                       data =3D /incbin/("test-kernel.bin");
> +                       type =3D "kernel_noload";
> +                       arch =3D "sandbox";
> +                       os =3D "linux";
> +                       compression =3D "none";
> +                       load =3D <0x4>;
> +                       entry =3D <0x8>;
> +                       kernel-version =3D <1>;
> +                       signature {
> +                               algo =3D "sha256,ecdsa521";
> +                               key-name-hint =3D "dev";
> +                       };
> +               };
> +               fdt-1 {
> +                       description =3D "snow";
> +                       data =3D /incbin/("sandbox-kernel.dtb");
> +                       type =3D "flat_dt";
> +                       arch =3D "sandbox";
> +                       compression =3D "none";
> +                       fdt-version =3D <1>;
> +                       signature {
> +                               algo =3D "sha256,ecdsa521";
> +                               key-name-hint =3D "dev";
> +                       };
> +               };
> +       };
> +       configurations {
> +               default =3D "conf-1";
> +               conf-1 {
> +                       kernel =3D "kernel";
> +                       fdt =3D "fdt-1";
> +               };
> +       };
> +};
> --
> 2.43.0
>
