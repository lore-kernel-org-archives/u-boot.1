Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9079E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BA32874AE;
	Mon,  2 Oct 2023 03:23:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OF77Pb0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CFB287487; Mon,  2 Oct 2023 03:22:49 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3420487255
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9b27bc8b65eso1592474766b.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209757; x=1696814557; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i9WpIgl6ALNsBF1U3f/q2vPZHl9aYQ9WC7x7kuxvWL8=;
 b=OF77Pb0hKYUAVK7LWmMfqdafCvq++yxXavnUteyAtrsiRGC2VoU79fAjZyisAUev+n
 e9gukRBl4oo0l9gGdj9sAjb2uP6iCRJDU2YiJtHG3aVIy9/z4dYDNUufulBNI4BEVOtx
 7g9SFMu6yZGupiFOJNNgPqVu25mwijRhKutnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209757; x=1696814557;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i9WpIgl6ALNsBF1U3f/q2vPZHl9aYQ9WC7x7kuxvWL8=;
 b=l9/r4uQVoacS3eo++I73AGHi4KoEEjdLlvcnZX17hEy/iN33xckcUIk+l9okTea+6B
 DAbUPZAmC8/5ezOsG3yiQU1OYfCz+zdYvXOXPAuPqcWwc0W9VktLOs1w11e/iAABwJEW
 JTzclUiSwLYVFD72r0bJrQK8jjLRjWn5WqDo9oZobh57UlPLsqsvIrpc2Itn8O+P3M+n
 H0TIFxBu5X0GkD7mATMO5yQHtGR2QgiqcF0M2kivUnnbtQ1Hjy1M+b0HULAq5/zG6f8g
 LlOYScdeXKCwpMRd23NGoOJeG40bIxPkuXoDnfCC6/7vfxNEiIwqrNugwICnQPAcambG
 AKzA==
X-Gm-Message-State: AOJu0YzsMQDQwEdDSVGPWkRGJ5uHZrcAVbb3j25GmI9Txj5C5hx7o9bS
 CcyuXT8TLsOey0GhglHw8w9Po4qLRlNyKaMBMFmzaQ==
X-Google-Smtp-Source: AGHT+IFx5Tx9+olR+R7rR48fJL0tBqr8ZyOskZwLGKGMCuvjsr20QjxJNKCKAanRDgIB/ku4vGlRLbneYWeke1wcBK0=
X-Received: by 2002:a17:906:51db:b0:9b2:abda:2543 with SMTP id
 v27-20020a17090651db00b009b2abda2543mr10077353ejk.65.1696209756852; Sun, 01
 Oct 2023 18:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230927040751.622194-1-n-francis@ti.com>
 <20230927040751.622194-2-n-francis@ti.com>
In-Reply-To: <20230927040751.622194-2-n-francis@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:16:53 -0600
Message-ID: <CAPnjgZ2jiWVDpcW9LaMMNOkVoueaUm0GWftE67qXbxSwjwJjYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] binman: openssl: x509: ti_secure_rom: Add support
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

On Tue, 26 Sept 2023 at 22:08, Neha Malcom Francis <n-francis@ti.com> wrote:
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
>  tools/binman/btool/openssl.py           |  6 ++++--
>  tools/binman/etype/ti_secure_rom.py     | 12 ++++++++++--
>  tools/binman/etype/x509_cert.py         |  3 ++-
>  tools/binman/test/297_ti_secure_rom.dts |  1 +
>  4 files changed, 17 insertions(+), 5 deletions(-)
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
> diff --git a/tools/binman/etype/ti_secure_rom.py b/tools/binman/etype/ti_secure_rom.py
> index 9a7ac9e9e0..780f132ea5 100644
> --- a/tools/binman/etype/ti_secure_rom.py
> +++ b/tools/binman/etype/ti_secure_rom.py
> @@ -32,6 +32,7 @@ class Entry_ti_secure_rom(Entry_x509_cert):
>          - core: core on which bootloader runs, valid cores are 'secure' and 'public'
>          - content: phandle of SPL in case of legacy bootflow or phandles of component binaries
>            in case of combined bootflow
> +        - bootcore_opts (optional): split-mode (0) or lockstep mode (1) set to 0 by default

core-opts is what it is called in your .dts so you should use the same
name here. Please also regen the entries.rst file

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
> @@ -103,11 +105,14 @@ class Entry_ti_secure_rom(Entry_x509_cert):
>              else:
>                  self.cert_type = 2
>              self.bootcore = 0
> -            self.bootcore_opts = 32
> +            if self.bootcore_opts is None:
> +                self.bootcore_opts = 32

How come it is 32? I thought it was 0 or 1 (as documented above)?
Please add docs to explain this.

>          else:
>              self.cert_type = 1
>              self.bootcore = 16
> -            self.bootcore_opts = 0
> +            if self.bootcore_opts is None:
> +                self.bootcore_opts = 0
> +
>          return super().GetCertificate(required=required, type='rom')
>
>      def CombinedGetCertificate(self, required):
> @@ -126,6 +131,9 @@ class Entry_ti_secure_rom(Entry_x509_cert):
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

When you add args to a function, please update the function comment.

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
>                 };
>                 unsecure_binary: blob-ext {
>                         filename = "ti_unsecure.bin";
> --
> 2.34.1
>

Regards,
Simonm
