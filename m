Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471EFE95A7E
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:19:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A41F86F1C;
	Sun,  8 Oct 2023 01:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Uz+8+PYH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35B1286D3F; Sun,  8 Oct 2023 01:12:23 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FC4086EBC
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-59f82ad1e09so41929937b3.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720299; x=1697325099; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ByGQwHxCrWRSYOeQqA6EffvO8D2bUD7pEAy4TDotNV0=;
 b=Uz+8+PYHfBf+9ryLvkhScfcgSTggROPiR8LcQFwFBi8MUcKgrzlsCn7XCUdJBkHASf
 I0inYp/LcdU5metnCCduPGwFpcgqZRb53BZOdOTq2P/5JV5oFEvYpwXrzdr4inxF7rnR
 CFTcq34zyv9nU9oFqVvSSJHZxwHYUU6GC0HDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720299; x=1697325099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ByGQwHxCrWRSYOeQqA6EffvO8D2bUD7pEAy4TDotNV0=;
 b=l96ByNeGuQHNctFLYP6BTkRoRS7N11oP0s07SbSDQe/zkzqtUnmw2y8PqJU0Hh1on3
 kXDrbftuw8yq6Tsk2CWhXc/ropzB/uNJxuO+rGQ6A47VJ5rQ1vwN6ret89ZcOmmJRI4k
 rvcGkg2uY5vmUVCIKdVmNdJJoKnaQ19TjPHyXcT5P8CfSGGG6sO7NCnbGUkp/il1NMk8
 cnxO3jLUAAUgRwCVhRA+vHnH2eocQvCijfQrFJ8ZetnNbam2tWdzc8568EAUiD7kCYF+
 d7Qh64AnJSe4c5wD3a/ggJTLwVz8c9S6fsu1LRYWQbAY2J0XSESSTQRBn0BliCmPmOXy
 Ospw==
X-Gm-Message-State: AOJu0Yw9LN/9+avVH2iGpPYbHoatWN24Fo+qikswoj4SHydLu/82NL9A
 UdW/b8pSXFPtlveronNlLg0rt1Uoe3icm20rAWQc+Q==
X-Google-Smtp-Source: AGHT+IG+zpO+ASafuvti8DzFQQM5HRMLLIh/4YNdw/Wcj/70aWzPXElu5My7GSDAmDbRIt3SrttmBnEBbGVzgIwldSk=
X-Received: by 2002:a0d:d744:0:b0:5a1:d11e:b745 with SMTP id
 z65-20020a0dd744000000b005a1d11eb745mr15641916ywd.24.1696720299271; Sat, 07
 Oct 2023 16:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231006100737.343745-1-n-francis@ti.com>
 <20231006100737.343745-2-n-francis@ti.com>
In-Reply-To: <20231006100737.343745-2-n-francis@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 7 Oct 2023 17:09:59 -0600
Message-ID: <CAPnjgZ2RAwdZxZMccwcLL5QLs-HyBcx6B=LLKfVSjSb0qpjGxg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] binman: openssl: x509: ti_secure_rom: Add support
 for bootcore_opts
To: Neha Malcom Francis <n-francis@ti.com>
Cc: trini@konsulko.com, alpernebiyasak@gmail.com, u-boot@lists.denx.de, 
 vigneshr@ti.com, u-kumar1@ti.com, a-nandan@ti.com
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

Hi Neha,

On Fri, 6 Oct 2023 at 04:07, Neha Malcom Francis <n-francis@ti.com> wrote:
>
> According to the TRMs of K3 platform of devices, the ROM boot image
> format specifies a "Core Options Field" that provides the capability to
> set the boot core in lockstep when set to 0 or to split mode when set
> to 2. Add support for providing the same from the binman DTS. Also
> modify existing test case for ensuring future coverage.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Link to J721E TRM: https://www.ti.com/lit/zip/spruil1
> Section 4.5.4.1 Boot Info
>
> Changes in v3:
>         - updated function comments
>         - removed inconsistency in setting bootcore_opts to 32
>
> Changes in v2:
>         - included TRM link in commit message
>
>  tools/binman/btool/openssl.py           |  6 ++++--
>  tools/binman/entries.rst                |  1 +
>  tools/binman/etype/ti_secure_rom.py     | 11 +++++++++--
>  tools/binman/etype/x509_cert.py         |  3 ++-
>  tools/binman/test/297_ti_secure_rom.dts |  1 +
>  5 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
> index aad3b61ae2..86cc56fbd7 100644
> --- a/tools/binman/btool/openssl.py
> +++ b/tools/binman/btool/openssl.py
> @@ -155,6 +155,7 @@ authInPlace = INTEGER:2
>              C, ST, L, O, OU, CN and emailAddress
>              cert_type (int): Certification type
>              bootcore (int): Booting core
> +            bootcore_opts(int): Booting core option (split/lockstep mode)

Please indicate what possible values are allowed

>              load_addr (int): Load address of image
>              sha (int): Hash function
>
> @@ -225,7 +226,7 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
>                    imagesize_sbl, hashval_sbl, load_addr_sysfw, imagesize_sysfw,
>                    hashval_sysfw, load_addr_sysfw_data, imagesize_sysfw_data,
>                    hashval_sysfw_data, sysfw_inner_cert_ext_boot_block,
> -                  dm_data_ext_boot_block):
> +                  dm_data_ext_boot_block, bootcore_opts):
>          """Create a certificate
>
>          Args:
> @@ -241,6 +242,7 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
>              bootcore (int): Booting core
>              load_addr (int): Load address of image
>              sha (int): Hash function
> +            bootcore_opts (int): Boot core option (split/lockstep mode)
>
>          Returns:
>              str: Tool output
> @@ -285,7 +287,7 @@ sysfw_data=SEQUENCE:sysfw_data
>  [sbl]
>  compType = INTEGER:1
>  bootCore = INTEGER:16
> -compOpts = INTEGER:0
> +compOpts = INTEGER:{bootcore_opts}
>  destAddr = FORMAT:HEX,OCT:{load_addr:08x}
>  compSize = INTEGER:{imagesize_sbl}
>  shaType  = OID:{sha_type}
> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> index 801bd94674..b401f9426a 100644
> --- a/tools/binman/entries.rst
> +++ b/tools/binman/entries.rst
> @@ -1900,6 +1900,7 @@ Properties / Entry arguments:
>      - core: core on which bootloader runs, valid cores are 'secure' and 'public'
>      - content: phandle of SPL in case of legacy bootflow or phandles of component binaries
>        in case of combined bootflow
> +    - core-opts (optional): split-mode (0) or lockstep mode (1) set to 0 by default

Here it is 1 but below it says 2

>
>  The following properties are only for generating a combined bootflow binary:
>      - sysfw-inner-cert: boolean if binary contains sysfw inner certificate
> diff --git a/tools/binman/etype/ti_secure_rom.py b/tools/binman/etype/ti_secure_rom.py
> index 9a7ac9e9e0..17c50cefa1 100644
> --- a/tools/binman/etype/ti_secure_rom.py
> +++ b/tools/binman/etype/ti_secure_rom.py
> @@ -32,6 +32,7 @@ class Entry_ti_secure_rom(Entry_x509_cert):
>          - core: core on which bootloader runs, valid cores are 'secure' and 'public'
>          - content: phandle of SPL in case of legacy bootflow or phandles of component binaries
>            in case of combined bootflow
> +        - core-opts (optional): split-mode (0) or lockstep mode (1) set to 0 by default
>
>      The following properties are only for generating a combined bootflow binary:
>          - sysfw-inner-cert: boolean if binary contains sysfw inner certificate
> @@ -69,6 +70,7 @@ class Entry_ti_secure_rom(Entry_x509_cert):
>          self.sw_rev = fdt_util.GetInt(self._node, 'sw-rev', 1)
>          self.sha = fdt_util.GetInt(self._node, 'sha', 512)
>          self.core = fdt_util.GetString(self._node, 'core', 'secure')
> +        self.bootcore_opts = fdt_util.GetInt(self._node, 'core-opts')
>          self.key_fname = self.GetEntryArgsOrProps([
>              EntryArg('keyfile', str)], required=True)[0]
>          if self.combined:
> @@ -97,17 +99,19 @@ class Entry_ti_secure_rom(Entry_x509_cert):
>              bytes content of the entry, which is the certificate binary for the
>                  provided data
>          """
> +        if self.bootcore_opts is None:
> +            self.bootcore_opts = 0
> +
>          if self.core == 'secure':
>              if self.countersign:
>                  self.cert_type = 3
>              else:
>                  self.cert_type = 2
>              self.bootcore = 0
> -            self.bootcore_opts = 32
>          else:
>              self.cert_type = 1
>              self.bootcore = 16
> -            self.bootcore_opts = 0
> +
>          return super().GetCertificate(required=required, type='rom')
>
>      def CombinedGetCertificate(self, required):
> @@ -126,6 +130,9 @@ class Entry_ti_secure_rom(Entry_x509_cert):
>          self.num_comps = 3
>          self.sha_type = SHA_OIDS[self.sha]
>
> +        if self.bootcore_opts is None:
> +            self.bootcore_opts = 0
> +
>          # sbl
>          self.content = fdt_util.GetPhandleList(self._node, 'content-sbl')
>          input_data_sbl = self.GetContents(required)
> diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
> index d028cfe38c..fc0bb12278 100644
> --- a/tools/binman/etype/x509_cert.py
> +++ b/tools/binman/etype/x509_cert.py
> @@ -136,7 +136,8 @@ class Entry_x509_cert(Entry_collection):
>                  imagesize_sysfw_data=self.imagesize_sysfw_data,
>                  hashval_sysfw_data=self.hashval_sysfw_data,
>                  sysfw_inner_cert_ext_boot_block=self.sysfw_inner_cert_ext_boot_block,
> -                dm_data_ext_boot_block=self.dm_data_ext_boot_block
> +                dm_data_ext_boot_block=self.dm_data_ext_boot_block,
> +                bootcore_opts=self.bootcore_opts
>              )
>          if stdout is not None:
>              data = tools.read_file(output_fname)
> diff --git a/tools/binman/test/297_ti_secure_rom.dts b/tools/binman/test/297_ti_secure_rom.dts
> index d1313769f4..1a3eca9425 100644
> --- a/tools/binman/test/297_ti_secure_rom.dts
> +++ b/tools/binman/test/297_ti_secure_rom.dts
> @@ -9,6 +9,7 @@
>         binman {
>                 ti-secure-rom {
>                         content = <&unsecure_binary>;
> +                       core-opts = <2>;

here ^

Do you think there could be a binding file in dt-bindings/ for this value?

>                 };
>                 unsecure_binary: blob-ext {
>                         filename = "ti_unsecure.bin";
> --
> 2.34.1
>

Regards,
Simon
