Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1C0D63936
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:36:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7969A8964F;
	Wed, 20 Nov 2024 14:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EICuDfXj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53B5689327; Wed, 20 Nov 2024 14:36:40 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD9CA89270
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7ea7e2ff5ceso5029620a12.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732109796; x=1732714596; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MatQYF0ittPqr2+4SVWxRUeuuoNTpnpoOHKaCnHzFoc=;
 b=EICuDfXjL+qyPNUkvx1nO4qmKJQHWRXora5WlR2FQ7Hq8iKzzpgdynITHsdfAciQLm
 Vbe4/5gxpigeD0Bo1M0y5zModCJJCrUmoKSxwDTtFTGY4O+wMvTDCx/bPN468vfAjbhk
 3GRmsEfrIGMkUyZFMBusGSWd0FzRPgTcN0SdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732109796; x=1732714596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MatQYF0ittPqr2+4SVWxRUeuuoNTpnpoOHKaCnHzFoc=;
 b=CE6m7mrA4/13YFebG/3LXRi4jj+/PSdCIR6UE/6aLLMvHdIaeTJQNUPm/ucBnO0UA3
 zv1WwWXgkkSViPwDbqbdDFZMG2aRuXmaKnzLBVrBH4AVAiPXH8hbuzoB0N0A3GDCmQ/e
 HuLUO5BcNrMyee3Mfd1cMt20AlJIO+7jz+Jgf4IXNry8B9hZLmXJ9qfa8kGBzgO0+oa2
 cP6C6PLJ8ZuJiR8+Hibf1CSUQAgmuzH3pjc4dJ2kpoc+nITFp7vf5xoHyuxT2hgjyuNA
 nevt70otM4PxXHgqSnCHMFil67T/pM7EQ4Oeo1xcPn01o8BBZbPPB2idh2gR6hj9msjY
 mMiQ==
X-Gm-Message-State: AOJu0YzMAOuHObvTji+Yyl/wbsFSHDAdHXTu4KVAtNrs4peIiMPCboVz
 XsZuynCTJyHxWTp42kiiEGAaxnRmYNTGVcsYvLVjngMBzTYLSb9ZSAKBH9T+mczDIQpTuoR5VWR
 yEPl85l4Zsh/J8033a1kShQMCIETMjyJW8osINAMaZQFHpTY=
X-Google-Smtp-Source: AGHT+IGk1RdFuSfyOM67Ww0CLB+YaIXnArZsw+QF4Y5+S903Xlz7doleX29XoMZ9VRhku/qXimYZhtE3d6b97DMp1io=
X-Received: by 2002:a05:6a20:3417:b0:1db:ddde:33e2 with SMTP id
 adf61e73a8af0-1ddaff54bbemr3229799637.29.1732109796302; Wed, 20 Nov 2024
 05:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20241120100911.885418-1-paul.henrys_ext@softathome.com>
 <20241120100911.885418-2-paul.henrys_ext@softathome.com>
In-Reply-To: <20241120100911.885418-2-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:35:48 -0700
Message-ID: <CAFLszThV+sQ6Hj5TW=8JyLz-Ta_GTJhkXxfNHY-caeN0dpaZtg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] tools: binman: Replace 'fit, sign' by 'fit,
 keys-directory'
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de, al.kochet@gmail.com, paul.henrysd@gmail.com
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

Hi Paul,

On Wed, 20 Nov 2024 at 03:09, Paul HENRYS
<paul.henrys_ext@softathome.com> wrote:
>
> mkimage can be used for both signing the FIT or encrypt its content and the
> option '-k' can be used to pass a directory where both signing and encryption
> keys can be retrieved.
> _get_priv_keys_dir() is also renamed as _get_keys_dir() and adapted to support
> both signing and encryption nodes in the FIT.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
> Changes for v3:
>  - Adapt the code after changes made in commit 133c000ca334
>  - Rename property 'fit,sign' as 'fit,keys-directory' since this is not only
>    about signing but passing a key directory to mkimage for both signing and
>    encrypting
>  - Update the tests and documentation accordingly
>
> My initial changes proposed in v1 and v2 has been outdated by the changes
> proposed in commit 133c000ca334.
>
>  tools/binman/btool/mkimage.py           |  8 +++----
>  tools/binman/entries.rst                | 13 ++++++-----
>  tools/binman/etype/fit.py               | 31 ++++++++++++++-----------
>  tools/binman/ftest.py                   |  2 +-
>  tools/binman/test/340_fit_signature.dts |  2 +-
>  tools/binman/test/341_fit_signature.dts |  2 +-
>  tools/binman/test/342_fit_signature.dts |  2 +-
>  7 files changed, 32 insertions(+), 28 deletions(-)

I think it is good to be able to specify the keys directory and not
just rely on Binman's input path. But do we need to remove the
fit,sign property? It is the signal that signing should be done.,
although I understand that there is a key directory too.

If we need to remove it, please do that in a separate patch.

Perhaps we also need a signal that encryption should be done?

>
> diff --git a/tools/binman/btool/mkimage.py b/tools/binman/btool/mkimage.py
> index 78d3301bc1..3f84220fb1 100644
> --- a/tools/binman/btool/mkimage.py
> +++ b/tools/binman/btool/mkimage.py
> @@ -22,7 +22,7 @@ class Bintoolmkimage(bintool.Bintool):
>
>      # pylint: disable=R0913
>      def run(self, reset_timestamp=False, output_fname=None, external=False,
> -            pad=None, align=None, priv_keys_dir=None):
> +            pad=None, align=None, keys_dir=None):
>          """Run mkimage
>
>          Args:
> @@ -34,7 +34,7 @@ class Bintoolmkimage(bintool.Bintool):
>                  other things to be easily added later, if required, such as
>                  signatures
>              align: Bytes to use for alignment of the FIT and its external data
> -            priv_keys_dir: Path to directory containing private keys
> +            keys_dir: Path to directory containing private and encryption keys
>              version: True to get the mkimage version
>          """
>          args = []
> @@ -46,8 +46,8 @@ class Bintoolmkimage(bintool.Bintool):
>              args += ['-B', f'{align:x}']
>          if reset_timestamp:
>              args.append('-t')
> -        if priv_keys_dir:
> -            args += ['-k', f'{priv_keys_dir}']
> +        if keys_dir:
> +            args += ['-k', f'{keys_dir}']
>          if output_fname:
>              args += ['-F', output_fname]
>          return self.run_cmd(*args)
> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> index e918162fb4..1b1d73ef17 100644
> --- a/tools/binman/entries.rst
> +++ b/tools/binman/entries.rst
> @@ -864,12 +864,13 @@ The top-level 'fit' node supports the following special properties:
>
>              fit,fdt-list-dir = "arch/arm/dts
>
> -    fit,sign
> -        Enable signing FIT images via mkimage as described in
> -        verified-boot.rst. If the property is found, the private keys path is
> -        detected among binman include directories and passed to mkimage via
> -        -k flag. All the keys required for signing FIT must be available at
> -        time of signing and must be located in single include directory.
> +    fit,keys-directory
> +        Look for a directory where signing and encryption keys are stored.
> +        If the property is found, the keys path is detected among binman
> +        include directories and passed to mkimage via  -k flag. All the keys
> +        required for signing and encrypting the FIT must be available at the
> +        time of signing and encrypting and must be located in a single
> +        include directory.
>
>  Substitutions
>  ~~~~~~~~~~~~~
> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> index b5afbda41b..e0c1ac08d8 100644
> --- a/tools/binman/etype/fit.py
> +++ b/tools/binman/etype/fit.py
> @@ -102,13 +102,13 @@ class Entry_fit(Entry_section):
>              In this case the input directories are ignored and all devicetree
>              files must be in that directory.
>
> -        fit,sign
> -            Enable signing FIT images via mkimage as described in
> -            verified-boot.rst. If the property is found, the private keys path
> -            is detected among binman include directories and passed to mkimage
> -            via  -k flag. All the keys required for signing FIT must be
> -            available at time of signing and must be located in single include
> -            directory.
> +        fit,keys-directory
> +            Look for a directory where signing and encryption keys are stored.
> +            If the property is found, the keys path is detected among binman
> +            include directories and passed to mkimage via  -k flag. All the keys
> +            required for signing and encrypting the FIT must be available at the
> +            time of signing and encrypting and must be located in a single
> +            include directory.
>
>      Substitutions
>      ~~~~~~~~~~~~~
> @@ -518,14 +518,14 @@ class Entry_fit(Entry_section):
>          # are removed from self._entries later.
>          self._priv_entries = dict(self._entries)
>
> -    def _get_priv_keys_dir(self, data):
> -        """Detect private keys path among binman include directories
> +    def _get_keys_dir(self, data):
> +        """Detect private and encryption keys path among binman include directories
>
>          Args:
>              data: FIT image in binary format
>
>          Returns:
> -            str: Single path containing all private keys found or None
> +            str: Single path containing all keys found or None
>
>          Raises:
>              ValueError: Filename 'rsa2048.key' not found in input path
> @@ -533,11 +533,14 @@ class Entry_fit(Entry_section):
>          """
>          def _find_keys_dir(node):
>              for subnode in node.subnodes:
> -                if subnode.name.startswith('signature'):
> +                if (subnode.name.startswith('signature') or
> +                    subnode.name.startswith('cipher')):
>                      if subnode.props.get('key-name-hint') is None:
>                          continue
>                      hint = subnode.props['key-name-hint'].value
> -                    name = tools.get_input_filename(f"{hint}.key")
> +                    name = tools.get_input_filename(
> +                        f"{hint}.key" if subnode.name.startswith('signature')
> +                        else f"{hint}.bin")
>                      path = os.path.dirname(name)
>                      if path not in paths:
>                          paths.append(path)
> @@ -587,8 +590,8 @@ class Entry_fit(Entry_section):
>          align = self._fit_props.get('fit,align')
>          if align is not None:
>              args.update({'align': fdt_util.fdt32_to_cpu(align.value)})
> -        if self._fit_props.get('fit,sign') is not None:
> -            args.update({'priv_keys_dir': self._get_priv_keys_dir(data)})
> +        if self._fit_props.get('fit,keys-directory') is not None:
> +            args.update({'keys_dir': self._get_keys_dir(data)})
>          if self.mkimage.run(reset_timestamp=True, output_fname=output_fname,
>                              **args) is None:
>              if not self.GetAllowMissing():
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 156567ace7..adab65e579 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -7885,7 +7885,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>              str(e.exception))
>
>      def testFitSignNoSingatureNodes(self):
> -        """Test that fit,sign doens't raise error if no signature nodes found"""
> +        """Test that fit,keys-directory doesn't raise error if no signature nodes found"""
>          if not elf.ELF_TOOLS:
>              self.skipTest('Python elftools not available')
>          entry_args = {
> diff --git a/tools/binman/test/340_fit_signature.dts b/tools/binman/test/340_fit_signature.dts
> index 9dce62e52d..97c0cbd05e 100644
> --- a/tools/binman/test/340_fit_signature.dts
> +++ b/tools/binman/test/340_fit_signature.dts
> @@ -11,7 +11,7 @@
>                         description = "test desc";
>                         #address-cells = <1>;
>                         fit,fdt-list = "of-list";
> -                       fit,sign;
> +                       fit,keys-directory;
>
>                         images {
>                                 u-boot {
> diff --git a/tools/binman/test/341_fit_signature.dts b/tools/binman/test/341_fit_signature.dts
> index 77bec8df1e..4a4da7e589 100644
> --- a/tools/binman/test/341_fit_signature.dts
> +++ b/tools/binman/test/341_fit_signature.dts
> @@ -11,7 +11,7 @@
>                         description = "test desc";
>                         #address-cells = <1>;
>                         fit,fdt-list = "of-list";
> -                       fit,sign;
> +                       fit,keys-directory;
>
>                         images {
>                                 u-boot {
> diff --git a/tools/binman/test/342_fit_signature.dts b/tools/binman/test/342_fit_signature.dts
> index 267105d0f6..9c61aea044 100644
> --- a/tools/binman/test/342_fit_signature.dts
> +++ b/tools/binman/test/342_fit_signature.dts
> @@ -11,7 +11,7 @@
>                         description = "test desc";
>                         #address-cells = <1>;
>                         fit,fdt-list = "of-list";
> -                       fit,sign;
> +                       fit,keys-directory;
>
>                         images {
>                                 u-boot {
> --
> 2.43.0
[..]

Regards,
Simon
