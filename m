Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27B2CE9D78
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 16:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8059A83FBD;
	Tue,  6 Jan 2026 17:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rh0AM+Yp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17C1783FBE; Tue,  6 Jan 2026 17:22:45 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0750183FBC
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 17:22:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6505d3b84bcso1753996a12.3
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 08:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767716562; x=1768321362; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d42no8oOWNuLoJZyuKAxUFSyuVU7Qi/cdItGDmsdwjI=;
 b=Rh0AM+YpcaafdLW7lKWsbqZ30IkcWDlfS2ptJosN4alCbvmgnVzVHcLh9Ujrm1f7c/
 NOiVMFwt+YmzhtJ8PsGFwvfmkSCcknImSzRYrGJD0LK2p48lFXWsSnJ/7i8N5hIccVB+
 ttHeXbDkrIxFlV3sNWFX8mxsamsWTkYd4ZE9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767716562; x=1768321362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d42no8oOWNuLoJZyuKAxUFSyuVU7Qi/cdItGDmsdwjI=;
 b=RznDQMLeBC2DDceLP/IY8S3lNfQhGHiQx6gwRkmI2az44KpgC6MvFGShhrMmOuGjMe
 PNN7KzRh+MiysZD+ARciGk8Uu2A1eKaEf5+zlhZvSp4IeZF9K61oAUKNfpOrrHDQo3rz
 Zf8M2p/E92V4N5cyEKT/El+dOvM2xy4owLjAzeRnQSQakV0365Lroy0TEKA1c4DBh25y
 0DbjaXJUpyq605Y0tf8qYqpoWST2fN54NTS7boOZgJlDYyrAIF+E/zhezyu/yf4rh+zH
 XRQ9uPWe7RZQLgXCOlX1aE1BH7cBqyJ7LsFKcwQyA/s0emTLQ5E1SFxIOpi5dmducHyi
 O1Ow==
X-Gm-Message-State: AOJu0YwL//0oeIvFCKt/dJyzMUGBJcutX+Qx4JxH3098VBd6QbId8Lbo
 y+93Q6qd/cCCn0i7oEJtGiRS3YUoZ+F6nonjVt/rhTkSLJAflPQhrpariwvCaVZi2OTeZyvVBGV
 M5K0KQnaCYSMw3rvIQ5OLYKez2RrTtt+92raSOlbO
X-Gm-Gg: AY/fxX7G7g547Tm0EnRuZEmP96hvMr/GVnkFiStC6QYQSVfnVydmQqWwz9kGEQm4NOg
 bvr0NJwZc43TeT1QksSSyzK3K+ThBvWfwsJuPZ/xhJtn6tn+yV84huyK2g8CgE0og+lTTKemY4x
 GXwIOUeanJ7gfrH2sxqCGMlkfpXELG18BAtMUm0yklhsWvvAzTxmUCD9jJaVby+jkVNsyPgJlna
 LLAOrdC1Wj1qLZd924BWgwkKZK0T7LtYMZsv+y+Y1EcZ/213CVhIs5/7DDYzXR2kaV0sg==
X-Google-Smtp-Source: AGHT+IETxHEYNbVjkkoHQXYanZ4RRMdVeDWDkxNVmTZSCz2ly4bv/R4SKeStpTrntAaxkQEr9Grh45QCHSSOZx3UvEo=
X-Received: by 2002:a17:907:d7c9:b0:b81:ec75:d649 with SMTP id
 a640c23a62f3a-b8426ad935cmr395490866b.27.1767716562331; Tue, 06 Jan 2026
 08:22:42 -0800 (PST)
MIME-Version: 1.0
References: <20260106111034.889964-1-Wojciech.Dubowik@mt.com>
 <20260106111034.889964-4-Wojciech.Dubowik@mt.com>
In-Reply-To: <20260106111034.889964-4-Wojciech.Dubowik@mt.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Jan 2026 09:22:20 -0700
X-Gm-Features: AQt7F2r7K6WAWEQfsuDg6kuzZ74ijm6JYtG-35OqURlnrUf7Mk6AH_r-cBQ3g_0
Message-ID: <CAFLszTgb4NfoXKjU-9ZMnAnqOHUd=OvazhCU5qkyromjNAqafg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] test: binman: Add test for pkcs11 signed capsule
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, trini@konsulko.com
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

On Tue, 6 Jan 2026 at 04:11, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
>
> Test pkcs11 URI support for UEFI capsule generation. For
> simplicity only private key is defined in binman section
> as softhsm tool doesn't support certificate import (yet).
>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
>  tools/binman/ftest.py                         | 46 +++++++++++++++++++
>  .../binman/test/351_capsule_signed_pkcs11.dts | 20 ++++++++
>  2 files changed, 66 insertions(+)
>  create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>

nits below

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 21ec48d86fd1..cb5d69982772 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -7532,6 +7532,52 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>
>          self._CheckCapsule(data, signed_capsule=True)
>
> +    def testPkcs11SignedCapsuleGen(self):
> +        """Test generation of EFI capsule (with PKCS11)"""
> +        data = tools.read_file(self.TestFile("key.key"))
> +        private_key = self._MakeInputFile("key.key", data)
> +        data = tools.read_file(self.TestFile("key.pem"))
> +        self._MakeInputFile("key.crt", data)
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
> +        softhsm_paths="/usr/local/lib/softhsm/libsofthsm2.so \
> +                /usr/lib/softhsm/libsofthsm2.so \
> +                /usr/lib64/pkcs11/libsofthsm2.so \
> +                /usr/lib/i386-linux-gnu/softhsm/libsofthsm2.so \
> +                /usr/lib/x86_64-linux-gnu/softhsm/libsofthsm2.so"
> +
> +        for softhsm2_lib_loc in softhsm_paths.split():
> +                if os.path.exists(softhsm2_lib_loc):
> +                        softhsm2_lib = softhsm2_lib_loc
> +
> +        with open(softhsm2_conf, 'a') as f:
> +            f.write(f'directories.tokendir = {softhsm2_tokens_dir}\n')

This 'open' should specify an encoding, but normally we use
tools.write_file() to write simple files.

> +
> +        with unittest.mock.patch.dict('os.environ',
> +                                      {'SOFTHSM2_CONF': softhsm2_conf}):

It's fine to mock this if you like, but in general we just set the
variable, e.g. os.environ['SOFTHSM2_CONF'] = softhsm2_conf

> +            tools.run('softhsm2-util', '--init-token', '--free', '--label',
> +                      'U-Boot token', '--pin', '1111', '--so-pin',
> +                      '222222')
> +            tools.run('softhsm2-util', '--import', private_key, '--token',
> +                      'U-Boot token', '--label', 'test_key', '--id', '999999',
> +                      '--pin', '1111')
> +
> +        with unittest.mock.patch.dict('os.environ',
> +                                      {'PKCS11_MODULE_PATH': softhsm2_lib,
> +                                       'SOFTHSM2_CONF': softhsm2_conf}):
> +                data = self._DoReadFile('351_capsule_signed_pkcs11.dts')
> +

should have a single blank line

> +
> +        self._CheckCapsule(data, signed_capsule=True)
> +
>      def testCapsuleGenVersionSupport(self):
>          """Test generation of EFI capsule with version support"""
>          data = self._DoReadFile('313_capsule_version.dts')
> diff --git a/tools/binman/test/351_capsule_signed_pkcs11.dts b/tools/binman/test/351_capsule_signed_pkcs11.dts
> new file mode 100644
> index 000000000000..c8c06805daf9
> --- /dev/null
> +++ b/tools/binman/test/351_capsule_signed_pkcs11.dts
> @@ -0,0 +1,20 @@
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

Regards,
Simon
