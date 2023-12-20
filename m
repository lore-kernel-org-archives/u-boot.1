Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AA0C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 04:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9C8B876A2;
	Wed, 20 Dec 2023 05:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y4VCjjnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3F8E876DE; Wed, 20 Dec 2023 05:47:28 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D72786E05
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a2343c31c4bso438332366b.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703047646; x=1703652446; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gCoGNdlub+A0eS2q8EVMjVMtjoiGAQiN7d3JWRT38bQ=;
 b=Y4VCjjnUy3ZRuqLi/3tTK5A6umHpEiUj5EqnIqc+oZAjhfjcsOOEdJ/3+oiAxSIm58
 Tq0MGi7jJ1wB0Lafa9tR5Unywhsz3uUfhIQs7Y+qRNY9lugXyf5KZ6jynC5+uAtLKmhh
 ei3gKq9d1rB7IdXFB/Ocx3VonJuPfDUQy73fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703047646; x=1703652446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gCoGNdlub+A0eS2q8EVMjVMtjoiGAQiN7d3JWRT38bQ=;
 b=XjVbXKDhateJiiiYVU2P2tjE0cNWBT1XykTIq2QSApb/NvqAESut1G9uEvbT74qQIl
 pK30UUgVAnQYQyrt8WMhHdyA4uSnWonT9nnUXb9NgMwgS0tmq5Cvs7Dz7mQotlKFAUmX
 wff4OK4cQFB0QabCRdi9QQDaDXgoGPPdEJAKt/T8WwdAvACY8g18isKFGo6n8Sgn5yux
 J/1QqnPwlP721W9Fe4ULHOx01O+8Oe7pMwuAeKf46hqG+2wBg4+TU80rUb/mj0yS0Rm/
 XjmarWSSBCnDgUwD1RIDRRFqSyPqidnNGinHDRJUMb7kSZoXU0EwXiRLxrYHYF4lagVW
 XGFQ==
X-Gm-Message-State: AOJu0Yxeww4z/1FYEviqqpa1lKkx/ShMIeSPSez5tIMZrMusGJG+HoRB
 M7xk8qcLfhLGKMzYeAOxfwR28O95e3eXI0E2FqOWzw+pXU8I+3zzBeI=
X-Google-Smtp-Source: AGHT+IEuC0GlPLX3lx6Rsa9poEQ2A/5iRNUFyEIMQDzW1d+RJ/AOC9X2I3pxxmeyB/k3n/wjYgVTMiGze2AD+4ztYio=
X-Received: by 2002:a17:906:ccce:b0:a23:4ca5:5e3 with SMTP id
 ot14-20020a170906ccce00b00a234ca505e3mr1646634ejb.80.1703047645571; Tue, 19
 Dec 2023 20:47:25 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-3-sumit.garg@linaro.org>
In-Reply-To: <20231214135103.1606605-3-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:47:13 -0700
Message-ID: <CAPnjgZ2v5WZ4aEOTqrGB7mxdmVAMYsHc8A7+YgUKubL51dp9WQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] Makefile: Add support for DT bindings schema checks
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

On Thu, 14 Dec 2023 at 06:51, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> This adds the build infrastructure for checking DT binding schema
> documents and validating dtb files using the binding schema. Here we use
> devicetree-rebasing directory to provide the DT bindings.
>
> Dependency:
> -----------
>
> The DT schema project must be installed in order to validate the DT schema
> binding documents and validate DTS files using the DT schema. The DT schema
> project can be installed with pip::
>
>     pip3 install dtschema
>
> Note that 'dtschema' installation requires 'swig' and Python development
> files installed first. On Debian/Ubuntu systems::
>
>     apt install swig python3-dev
>
> Testing:
> --------
>
> Build dts files and check using DT binding schema:
> $ make dtbs_check
>
> Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
> use for validation. This makes it easier to find and fix errors
> generated by a specific schema.
>
> Note, at this point dtbs_check is an optional build target as there are
> many warnings generated due to custom DT properties used by many
> platforms in u-boot. It is expected with these checks that compliance
> with DT bindings to take place. Once that's done it can be added to CI
> builds to remain compliant with DT bindings.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  Makefile             | 20 ++++++++++++++++++--
>  scripts/Makefile.lib | 17 +++++++++++++++--
>  2 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 750bbdb1b71..d8d168cd4c3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1158,12 +1158,28 @@ endif
>         @# disabling OF_BOARD.
>         $(call cmd,ofcheck,$(KCONFIG_CONFIG))
>
> -PHONY += dtbs
> +PHONY += dtbs dtbs_check
>  dtbs: dts/dt.dtb
>         @:
> -dts/dt.dtb: u-boot
> +dts/dt.dtb: dtbs_prepare u-boot
>         $(Q)$(MAKE) $(build)=dts dtbs
>
> +dtbs_prepare: prepare3
> +
> +ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
> +export CHECK_DTBS=y
> +endif
> +
> +ifneq ($(CHECK_DTBS),)
> +dtbs_prepare: dt_binding_check
> +endif
> +
> +dtbs_check: dt_binding_check dtbs
> +
> +DT_BINDING_DIR := devicetree-rebasing/Bindings
> +dt_binding_check: scripts_dtc
> +       $(Q)$(MAKE) $(build)=$(DT_BINDING_DIR) $(DT_BINDING_DIR)/processed-schema.json
> +
>  quiet_cmd_copy = COPY    $@
>        cmd_copy = cp $< $@
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 16bbc277a9f..27b9437027c 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -356,8 +356,21 @@ endif
>
>  dtsi_include_list_deps = $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_include_list)))
>
> -$(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) FORCE
> -       $(call if_changed_dep,dtc)
> +ifneq ($(CHECK_DTBS),)
> +DT_CHECKER ?= dt-validate
> +DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
> +DT_BINDING_DIR := devicetree-rebasing/Bindings
> +DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
> +
> +quiet_cmd_dtb = DTC_CHK $@
> +      cmd_dtb = $(cmd_dtc) ; $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
> +else
> +quiet_cmd_dtb = $(quiet_cmd_dtc)
> +      cmd_dtb = $(cmd_dtc)
> +endif
> +
> +$(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) $(DT_TMP_SCHEMA) FORCE
> +       $(call if_changed_dep,dtb)
>
>  pre-tmp = $(subst $(comma),_,$(dot-target).pre.tmp)
>  dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
> --
> 2.34.1
>

This is great.

Can you put the commit message in doc/ somewhere?

Regards,
Simon
