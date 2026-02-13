Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B637EF99C0
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 17:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBF7583AA9;
	Fri, 13 Feb 2026 18:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ffHSEn/c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5564E83AAB; Fri, 13 Feb 2026 18:53:06 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09A5183015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 18:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-65940221f7eso2045909a12.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:53:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771005178; cv=none;
 d=google.com; s=arc-20240605;
 b=N2FXXO+JDqsGmUEBVPRa/HB1SwcJVTl4/jZqOmzJfh2wH+a2gFo8nUEIabbD35Do2/
 8zgOP80X43LTbqWZChDhDVBHLIfPLnImkwdBgKNDIpZzd3LRlXHcE+MuurRam+VGhzmo
 WNJJoEEQB1YDivMU3WV08I0vo2f4zcZFDO4CZU1VXUuTMIyB9H0KXSfwTL6fb6dgVpmF
 DD1KN3WoEvq+z8x+OYn+3bJtQGB51YgD83zZg1w9l+kZ1JbvTjJ8VkhuCkMHyvGm+Okx
 W6gGNYBI4ufHyFbPd0QEVE5Tp77B9s/jixG6CWwxU7Yypwgk8TS9EtsETKkG3sNTg2Lk
 myjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zCq1sZprPoywjpMYxt2ray9G8t0UHfdd9ixBaZfniM0=;
 fh=znTsNXZaDoMwZuM97NMa6Is3FS+nMIG9A+buLF6i1/Q=;
 b=lK20cz+Z3okIHouncXmsAuWSJh8FIcCcwKJibr9SKaxpbe+RIWkr7Ef1tiG6D9HhQ/
 QjHR6UDOz4QPPBZkxq+XgVSCKb4qhiKVDa1EI6TRulKo4YMA1gf4A5Em2LlCdPM/Iaqy
 KQTTRSD58rO37y1RGFrFjj+b87uoVaBWKFuh9wX+0N1zCnKEuHVy44vVd4PgwsWuBBaN
 722+WhRzptKrxeq/P0MawztcAzg78TgINAN3FkMc7saxTePOaeROGu8SRjE4dpUX/nUf
 qlPwwW42v2iYThVQ1Bo0DtwdyFraY5yxDyRtneKkMaV0LWwZh7y+E3I+HEc5QOalaPIX
 Wynw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771005178; x=1771609978; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zCq1sZprPoywjpMYxt2ray9G8t0UHfdd9ixBaZfniM0=;
 b=ffHSEn/c8bJiuBQDeA5/A3kJM4iOPJCVSA0mEd0yOLB7La3MMZBLfr8S+2UG6c8QSn
 XJnQYcfDlDP2C6Fm/AAfx5nd+XOogf789p2VPUib9D3nZaL+Y40SdRW9BdqGiQtl+98J
 xnd/dfVVEZSzFFJqBXmn35KKH5Zy3WvxibtRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771005178; x=1771609978;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCq1sZprPoywjpMYxt2ray9G8t0UHfdd9ixBaZfniM0=;
 b=NgBEUJyKB/eKrX2YvqsSotjaddo3QSMgp+oge1GMGp1U4rFraStBoTSA35U1e5WF1O
 TbBb7ml72aOp2dTuOOHZPqaIF2LgrtUHgKNv3/JtVjeIIqcefjaCxNmEZuAYQ/TEP3Gy
 U+5wyUmB70oueA/XvNBTkBi6ldEvh5THnjPB9DKTqkuPNSa6qjoiifhhUeKOWRVVNsFh
 3zhf828ccp4yXk7f4om4eM+RJ7Yd0vlXdUWRyMyUuy0xmQZs+Fg5+sg9jAtYfUK1G/Zr
 mBjr4ksHH44d6XbSwyLBhvY1hRv5MDPrUTumnN+o8SFZHvxTIK3rlhCE7WH/dzFpFwRM
 ASRw==
X-Gm-Message-State: AOJu0YxI8ivmpIFNtuULAUThlzVOlAZnP9ozSWx7WOhYGJfI0Bmm2jrF
 Swbxl0/zEXUwBOtojMuFh4jxwQ7pbHa9WXHjggKmQ7ioN+v+tp2NyaX7DDQ3khXGpLI0EZz6CFk
 yROFcypBNplFoZ39/Eg8NwOjg131cLrBNP9hCbFAiOigslnjwXoB9dA==
X-Gm-Gg: AZuq6aJ32pyVklaFqToJhjmepKsVPri4bMshs8M2dgdHBUH5198ZTC58zaAX+PfPlCr
 MYApuOnzLxyOZ929FXNqBKaRiNxmh4NEWbhZT8q7qfxsoHNPD3wyd71wV9mbgkAzB9+dSLiI6By
 lnQd4cHEJx5ohpz5y/NJrprvHEVxaE8FvfnSVnG/e3mXKl99t9UJf2WCfOCJeYvSRpI/t+d9vi0
 ezwZ8xM7n1D0RjZgmu3BxvGsQTHCJlVgEdnsUxQrNEF7/FDHM6Xk/uZ+bp78PF59TPNsp7p5sHu
 l9o7Fw==
X-Received: by 2002:a17:907:6e8d:b0:b87:365d:26b8 with SMTP id
 a640c23a62f3a-b8face249a3mr185077566b.35.1771005178302; Fri, 13 Feb 2026
 09:52:58 -0800 (PST)
MIME-Version: 1.0
References: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
 <20260128080515.1275941-7-Wojciech.Dubowik@mt.com>
In-Reply-To: <20260128080515.1275941-7-Wojciech.Dubowik@mt.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Feb 2026 10:52:44 -0700
X-Gm-Features: AZwV_QhujmMp87M5VL0hEaf1UVIsSQxAbQyx_Hr44-MCR3tR5n8N06lHAr4NKns
Message-ID: <CAFLszThiCuO23=m6zcVw4EHt2HdYX2Dei-91eLdieo9sQA08RQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] test: binman: Add test for pkcs11 signed capsule
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, simon.glass@canonical.com, 
 quentin.schulz@cherry.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Wojciech,

On Wed, 28 Jan 2026 at 01:06, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
>
> Test pkcs11 URI support for UEFI capsule generation. For
> simplicity only private key is defined in binman section
> as softhsm tool doesn't support certificate import (yet).
>
> Add bintool support for p11-kit as it's needed in the test
> to find library path for softhsm2 module.
>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> Reviewed-by: Simon Glass <simon.glass@canonical.com>
> ---
>  tools/binman/btool/p11_kit.py                 | 21 ++++++
>  tools/binman/ftest.py                         | 66 +++++++++++++++++++
>  .../binman/test/351_capsule_signed_pkcs11.dts | 22 +++++++
>  3 files changed, 109 insertions(+)
>  create mode 100644 tools/binman/btool/p11_kit.py
>  create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts
>
> diff --git a/tools/binman/btool/p11_kit.py b/tools/binman/btool/p11_kit.py
> new file mode 100644
> index 000000000000..9d8d5d848b44
> --- /dev/null
> +++ b/tools/binman/btool/p11_kit.py
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright 2026 Mettler Toledo Technologies GmbH
> +#
> +"""Bintool implementation for p11-kit"""
> +
> +from binman import bintool
> +
> +
> +class Bintoolp11_kit(bintool.Bintool):
> +    """p11-kit -- support tool for pkcs#11 libraries"""
> +    def __init__(self, name):
> +        super().__init__('p11-kit',
> +                         'Pkcs11 library modules tool',
> +                         version_args='list modules')
> +
> +    def fetch(self, method):
> +        """Install p11-kit via APT """
> +        if method != bintool.FETCH_BIN:
> +            return None
> +
> +        return self.apt_install('p11-kit')
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 21ec48d86fd1..a66030c7a56f 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -7,6 +7,7 @@
>  #    python -m unittest func_test.TestFunctional.testHelp
>
>  import collections
> +import configparser
>  import glob
>  import gzip
>  import hashlib
> @@ -7532,6 +7533,71 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>
>          self._CheckCapsule(data, signed_capsule=True)
>
> +    def testPkcs11SignedCapsuleGen(self):
> +        """Test generation of EFI capsule (with PKCS11)"""
> +        data = tools.read_file(self.TestFile("key.key"))
> +        private_key = self._MakeInputFile("key.key", data)
> +        data = tools.read_file(self.TestFile("key.pem"))
> +        cert_file = self._MakeInputFile("key.crt", data)
> +
> +        softhsm2_util = bintool.Bintool.create('softhsm2_util')
> +        self._CheckBintool(softhsm2_util)
> +
> +        prefix = "testPkcs11SignedCapsuleGen."
> +        # Configure SoftHSMv2
> +        data = tools.read_file(self.TestFile('340_softhsm2.conf'))
> +        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf', data)
> +        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
> +
> +        with open(softhsm2_conf, 'a') as f:
> +            f.write(f'directories.tokendir = {softhsm2_tokens_dir}\n')
> +
> +        # Find the path to softhsm2 library
> +        p11_kit = bintool.Bintool.create('p11-kit')
> +        self._CheckBintool(p11_kit)
> +
> +        p11_kit_config = configparser.ConfigParser()
> +        out = tools.run('p11-kit', 'print-config')
> +        p11_kit_config.read_string(out)
> +        softhsm2_lib = p11_kit_config.get('softhsm2', 'module',
> +                                           fallback=None)
> +        self.assertIsNotNone(softhsm2_lib)
> +
> +        with unittest.mock.patch.dict('os.environ',
> +                                      {'SOFTHSM2_CONF': softhsm2_conf,
> +                                       'PKCS11_MODULE_PATH': softhsm2_lib}):
> +                tools.run('softhsm2-util', '--init-token', '--free', '--label',
> +                          'U-Boot token', '--pin', '1111', '--so-pin',
> +                          '222222')
> +                tools.run('softhsm2-util', '--import', private_key, '--token',
> +                          'U-Boot token', '--label', 'test_key', '--id', '999999',
> +                          '--pin', '1111')
> +                data = self._DoReadFile('351_capsule_signed_pkcs11.dts')
> +
> +        self._CheckCapsule(data, signed_capsule=True)
> +
> +        hdr = self._GetCapsuleHeaders(data)
> +        monotonic_count = hdr['EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT']
> +
> +        # UEFI standard requires that signature is checked over payload followed
> +        # by a monotonic count as little endian 64-bit integer.
> +        sig_input = self._MakeInputFile("sig_input", EFI_CAPSULE_DATA)
> +        with open(sig_input, 'ab') as f:
> +            f.write(struct.pack('<Q', int(monotonic_count, 16)))
> +
> +        # Verify dumped capsule signature dumped by meficapsule during
> +        # generation
> +        openssl = bintool.Bintool.create('openssl')
> +        self._CheckBintool(openssl)
> +        openssl_args = ['smime', '-verify', '-inform', 'DER',
> +                        '-in', tools.get_output_filename('capsule.efi-capsule.p7'),
> +                        '-content', sig_input, '-CAfile', cert_file,
> +                        '-no_check_time',
> +                        '-out', tools.get_output_filename('decoded-capsule.bin')]
> +        result = openssl.run_cmd_result(*openssl_args)
> +        self.assertIsNotNone(result.stdout)
> +        self.assertIn('Verification successful', result.stderr)
> +
>      def testCapsuleGenVersionSupport(self):
>          """Test generation of EFI capsule with version support"""
>          data = self._DoReadFile('313_capsule_version.dts')
> diff --git a/tools/binman/test/351_capsule_signed_pkcs11.dts b/tools/binman/test/351_capsule_signed_pkcs11.dts
> new file mode 100644
> index 000000000000..ae93bf83936f
> --- /dev/null
> +++ b/tools/binman/test/351_capsule_signed_pkcs11.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       binman {
> +               efi-capsule {
> +                       image-index = <0x1>;
> +                       /* Image GUID for testing capsule update */
> +                       image-guid = "binman-test";
> +                       hardware-instance = <0x0>;
> +                       monotonic-count = <0x1>;
> +                       dump-signature;
> +                       private-key = "pkcs11:token=U-Boot%20token;object=test_key;type=private;pin-value=1111";
> +                       public-key-cert = "key.crt";
> +
> +                       blob {
> +                               filename = "capsule_input.bin";
> +                       };
> +               };
> +       };
> +};
> --
> 2.47.3
>

I tried this out but I got a test-coverage failure (binman test -T):

tools/binman/etype/efi_capsule.py                          65      1    98%

Regards,
Simon
