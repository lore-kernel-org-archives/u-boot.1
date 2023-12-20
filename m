Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF74C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 04:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07BC187530;
	Wed, 20 Dec 2023 05:47:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HuD6MtEu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19FEC86E05; Wed, 20 Dec 2023 05:47:34 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A77E8875E9
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:47:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a268836254aso93306066b.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703047651; x=1703652451; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MGBwOuSzTgvJ564O2l/POGSwftHo++A8lNWRav5U1qY=;
 b=HuD6MtEu6wsBDgwqe9uQNcxEon8N0JNKFHnYMvpCJLXxajnllsuNtzLASxwkestx0O
 1fbd7u+rADpGj5Si0ZqNE2bK1RKiBO/BhCm9jA1bAUaf6LeaqprI2287r9QQdiLzjEUI
 7W+RC0KzO689gwIW14BDn6nyd+EyRE1ZGAYKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703047651; x=1703652451;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MGBwOuSzTgvJ564O2l/POGSwftHo++A8lNWRav5U1qY=;
 b=JCB2F5S+G8XlryCrEEQ+2UcoNHhSB/oxBFwaOMBuvi4i7j3+b1UEVTP4pQsBn3NuBR
 +PqdpC7n0dpRvgbCt0pFpOeOo5x5n79tS2NBzNQqspgOUpEa6TgyAJM2HwbFqE4ndkd/
 xSBb19Itm5aZ4Gv8h9sZ7XD5ykjF6g1ZfJPUe2r3+PefT74/HcMafe3cAGxT+t2GlsgF
 uEGrp3qawsVx5/2Pa6zvkSt80RYEV2UvCHbdXAeLTIYZjVtqMUXWvsdW2ttbSZPIVHKe
 HmkymH6vQSO+sawmXvWGdXj+E6/b5tgvtmGMtLn8AWizeLzsE5gyOmE3+adzGuyziFwa
 SdtA==
X-Gm-Message-State: AOJu0YxqeXqZj2MJq0k+SesD5S/YIHLBaFkmRD9cN9+aWs56mZG/Q5iT
 ceYvZlXvajnWMf0gqBdCK12mOpmWjy30n/pSsz9+1Gys7ipcuRnI8QE=
X-Google-Smtp-Source: AGHT+IHbjHcRfRJu/ZrWR1Hgxpw6NDtClFIZVJjHkzGFgEVcdEeXYka8IgZBxf2DVdDRxMHXHjY1nCGSAK3APRmIxd0=
X-Received: by 2002:a17:906:1447:b0:a23:65de:419c with SMTP id
 q7-20020a170906144700b00a2365de419cmr1808741ejc.144.1703047650886; Tue, 19
 Dec 2023 20:47:30 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-6-sumit.garg@linaro.org>
In-Reply-To: <20231214135103.1606605-6-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:47:19 -0700
Message-ID: <CAPnjgZ38rEbOH-nPktG=O2iD3RKpzoEX1BrmF9TnGyFWPKgppw@mail.gmail.com>
Subject: Re: [PATCH 5/8] doc: devicetree: Updates for devicetree-rebasing
 subtree
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de
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

Hi Sumit,

On Thu, 14 Dec 2023 at 06:52, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Encourage SoC/board maintainers to migrate to using devicetree-rebasing
> subtree and maintain a regular sync with Linux kernel devicetree files
> and bindings.
>
> Along with that add documentation regarding how to run DT bindings
> schema checks.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  doc/develop/devicetree/control.rst | 108 +++++++++++++++++++++++------
>  1 file changed, 86 insertions(+), 22 deletions(-)
>
> diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
> index cbb65c9b177..12ef55ed368 100644
> --- a/doc/develop/devicetree/control.rst
> +++ b/doc/develop/devicetree/control.rst
> @@ -1,5 +1,6 @@
>  .. SPDX-License-Identifier: GPL-2.0+
>  .. sectionauthor:: Copyright 2011 The Chromium OS Authors
> +.. Copyright 2023 Linaro Ltd.
>
>  Devicetree Control in U-Boot
>  ============================
> @@ -22,12 +23,11 @@ for three reasons:
>    hierarchical format
>  - It is fairly efficient to read incrementally
>
> -The arch/<arch>/dts directories contains a Makefile for building the devicetree
> -blob and embedding it in the U-Boot image. This is useful since it allows
> -U-Boot to configure itself according to what it finds there. If you have
> -a number of similar boards with different peripherals, you can describe
> -the features of each board in the devicetree file, and have a single
> -generic source base.
> +The U-boot Makefile infrastructure allows for building the devicetree blob
> +and embedding it in the U-Boot image. This is useful since it allows U-Boot
> +to configure itself according to what it finds there. If you have a number
> +of similar boards with different peripherals, you can describe the features
> +of each board in the devicetree file, and have a single generic source base.
>
>  To enable this feature, add CONFIG_OF_CONTROL to your board config file.
>
> @@ -68,8 +68,21 @@ a binary file. U-Boot adds its own `fdtgrep` for creating subsets of the file.
>  Where do I get a devicetree file for my board?
>  ----------------------------------------------
>
> -You may find that the Linux kernel has a suitable file. Look in the
> -kernel source in arch/<arch>/boot/dts.
> +Linux kernel Git repository has been the place where devicetree files along
> +with devicetree bindings are stored and maintained. There is devicetee-rebasing
> +(dtrepo_) which maintains a forked copy of devicetree files along with bindings
> +at every Linux kernel major release or intermideate release candidates.
> +
> +In order to maintain devicetree files sync, U-boot maintains a Git subtree for
> +devicetee-rebasing repo as `devicetee-rebasing/` sub-directory. It is regularly
> +kept updated with every new kernel major release via subtree pull as follows::
> +
> +    git subtree pull --prefix devicetree-rebasing \
> +        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
> +        <release-tag> --squash
> +
> +You may find that the `devicetee-rebasing/` sub-directory has a suitable
> +devicetree file for your board. Look in `devicetree-rebasing/src/<arch>/`.
>
>  If not you might find other boards with suitable files that you can
>  modify to your needs. Look in the board directories for files with a
> @@ -81,18 +94,21 @@ Failing that, you could write one from scratch yourself!
>  Configuration
>  -------------
>
> -Use::
> +Traditionally, U-boot placed copies of devicetree source files from Linux
> +kernel into `arch/<arch>/dts/<name>.dts` which can be selected via::
>
> -   #define CONFIG_DEFAULT_DEVICE_TREE  "<name>"
> +    #define CONFIG_DEFAULT_DEVICE_TREE "<name>"
>
> -to set the filename of the devicetree source. Then put your devicetree
> -file into::
> +However, it has become combersome over time for each SoC/board maintainer to
> +keep devicetree files in sync with Linux kernel. Thereby, SoC/board maintainers
> +are encouraged to migrate to use mirrored copies from `devicetree-rebasing/`
> +into `dts/arch/<arch>/<vendor>` via::
>
> -   arch/<arch>/dts/<name>.dts
> +    #define CONFIG_OF_UPSTREAM=y
> +    #define CONFIG_DEFAULT_DEVICE_TREE "<vendor>/<name>"
>
> -This should include your CPU or SOC's devicetree file, placed in
> -`arch/<arch>/dts`, and then make any adjustments required using a u-boot-dtsi
> -file for your board.
> +This should include your CPU or SOC's devicetree file. On top of that any U-boot
> +specific tweaks (see: dttweaks_) can be made for your board.
>
>  If CONFIG_OF_EMBED is defined, then it will be picked up and built into
>  the U-Boot image (including u-boot.bin). This is suitable for debugging
> @@ -156,8 +172,9 @@ ways:
>  Adding tweaks for U-Boot
>  ------------------------
>
> -It is strongly recommended that devicetree files in U-Boot are an exact copy of
> -those in Linux, so that it is easy to sync them up from time to time.
> +With devicetee-rebasing Git subtree, it is ensured that devicetree files in
> +U-Boot are an exact copy of those in Linux kernel via mirroring into
> +`dts/arch/<arch>/<vendor>`.
>
>  U-Boot is of course a very different project from Linux, e.g. it operates under
>  much more restrictive memory and code-size constraints. Where Linux may use a
> @@ -170,8 +187,8 @@ constraints are even more extreme and the devicetree is shrunk to remove
>  unwanted nodes, or even turned into C code to avoid access overhead.
>
>  U-Boot automatically looks for and includes a file with updates to the standard
> -devicetree for your board, searching for them in the same directory as the
> -main file, in this order::
> +devicetree for your board, searching for them in `arch/<arch>/dts/` in this
> +order::
>
>     <orig_filename>-u-boot.dtsi
>     <CONFIG_SYS_SOC>-u-boot.dtsi
> @@ -200,6 +217,52 @@ to specify a list of .dtsi files that will also be included when
>  building .dtb files.
>
>
> +Devicetree bindings schema checks
> +---------------------------------
> +
> +With devicetee-rebasing Git subtree, the devicetree bindings are also regularly
> +synced with Linux kernel as `devicetree-rebasing/Bindings/` sub-directory. This
> +allows U-boot to run devicetree bindings schema checks which will bring
> +compliance to U-boot core/drivers regarding usage of devicetree.
> +
> +Dependencies
> +~~~~~~~~~~~~
> +
> +The DT schema project must be installed in order to validate the DT schema
> +binding documents and validate DTS files using the DT schema. The DT schema
> +project can be installed with pip::
> +
> +    pip3 install dtschema
> +
> +Note that 'dtschema' installation requires 'swig' and Python development files
> +installed first. On Debian/Ubuntu systems::
> +
> +    apt install swig python3-dev
> +
> +Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
> +installed. Ensure they are in your PATH (~/.local/bin by default).
> +
> +Recommended is also to install yamllint (used by dtschema when present).
> +
> +Running checks
> +~~~~~~~~~~~~~~
> +
> +In order to perform validation of DTB files, use the ``dtbs_check`` target::
> +
> +    make dtbs_check
> +
> +It is also possible to run checks with a subset of matching schema files by
> +setting the ``DT_SCHEMA_FILES`` variable to 1 or more specific schema files or
> +patterns (partial match of a fixed string). Each file or pattern should be
> +separated by ':'.
> +
> +::
> +
> +    make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml:rtc.yaml
> +    make dtbs_check DT_SCHEMA_FILES=/gpio/
> +    make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml
> +
> +
>  Relocation, SPL and TPL
>  -----------------------
>
> @@ -261,8 +324,9 @@ used it before Linux (e.g. snow). The two projects developed in parallel
>  and there are still some differences in the bindings for certain boards.
>  While there has been discussion of having a separate repository for devicetree
>  files, in practice the Linux kernel Git repository has become the place where
> -these are stored, with U-Boot taking copies and adding tweaks with u-boot.dtsi
> -files.
> +these are stored, with U-Boot taking copies via devicetree-rebasing repo
> +(see: dtrepo_) and adding tweaks with u-boot.dtsi files.
>
>  .. _dtspec: https://www.devicetree.org/specifications/
>  .. _dtlist: https://www.spinics.net/lists/devicetree-compiler/
> +.. _dtrepo: https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
> --
> 2.34.1
>

OK, ignore my comment about docs.

Regards,
Simon
