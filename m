Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51452C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 08:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1324877F8;
	Thu,  4 Jan 2024 09:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PQsa8hJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E424870FF; Thu,  4 Jan 2024 09:19:17 +0100 (CET)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9A67877F8
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 09:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7cbf98dd9efso672873241.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 00:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704356351; x=1704961151; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UO5DwziMROSBF5JJMhyVc2R3+UJvQpROvonbnYACnks=;
 b=PQsa8hJW+OgSdDwQvac0ldDmj0+u+PXvRMleTkIsRf36Ec/OqBeE0aUfytY09pEIBG
 zTRf8m4TjGUXLjexRRmL3tuH8ovNswc0OJ2SdBmdrpa3ScS5lbbfMqrdq0aIDMoAqjTu
 vFFOIN06Oo6woIb+DiJQJY2HyTK4/l3iMW1UizIlNabSS7+GPMbkb5WURdGctS7OkQYA
 jlpKKwLpv/CMT+JXCbNWH1s4/5R+ZMWhM/TosUyXsX+KQfzZ1Ba9Cz56ywKfDVVVt0Lt
 y9GFVuqhLcnt9xyanmMesqn7tQTy3xD2lM78OOTpwPZcIahIkLFdCNKKMma8Y6UF5SAz
 254Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704356351; x=1704961151;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UO5DwziMROSBF5JJMhyVc2R3+UJvQpROvonbnYACnks=;
 b=CIf9ztatkpQ17J8tQwO4iPoqhdGnFnXs13sW6QeMCCvkUXZKpPrA1UZX/rHAaOfIoO
 MwUToJ7+efjR69IiS6j587OSbhW8PBsPKO2GyEnJiYUhPyyyT5o9yDUSJqco806eaFYq
 Fr54GQiwOxqOTaXMrz/qkgbF64tolv7FMpItiNaB18hwYDIuhHVyOkwTSTK/9u2+8/Is
 BO7T2OWwycNY0JlSn4Djz07bEl/2MtFPFQClKuMYqnzxyFYiG6K1ib7VyQDWMvvakAwt
 7kJzsbneQSKI3BXgLDx+oB5EMK/BxH1uXtoVihlftMCNqfmZ/DUSBeQ8PC5izE8g2e3B
 YLyQ==
X-Gm-Message-State: AOJu0YyIB1EHCgnFButbcIeqVzGh89KZdTrCyABQclKK8gUeYAKtTnDg
 lnW4nVTeXkCkytKnB3zrzr7Q1AvduDFRbveoLG63M3ZuOEkehw==
X-Google-Smtp-Source: AGHT+IG1DZl6hNTwiB9EwnWnCaTBuxo9OIISjjaSRlyQ70lOkSZKysiQTsn7hbcTBqtR1IXG1KPs3TUoNxRznj0Z+Jw=
X-Received: by 2002:a05:6102:440a:b0:467:85d1:2732 with SMTP id
 df10-20020a056102440a00b0046785d12732mr75513vsb.3.1704356350933; Thu, 04 Jan
 2024 00:19:10 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <5602ebb2-25c9-4f0e-88b7-64662874d0f4@amd.com>
In-Reply-To: <5602ebb2-25c9-4f0e-88b7-64662874d0f4@amd.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 4 Jan 2024 13:48:59 +0530
Message-ID: <CAFA6WYNeVq9pM9Uau6bQdUMNw40-1sMHOGuYs4mfa3bX6Ob2TA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] An effort to bring DT bindings compliance within
 U-Boot
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
 mibodhi@gmail.com
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

Hi Michal,

On Wed, 3 Jan 2024 at 18:24, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 12/28/23 12:57, Sumit Garg wrote:
> > Changes in v3:
> > --------------
> > - Patch #4: Minor commit message update
> > - Patch #5: Replace CONFIG_* with Kconfig options
> > - Patch #7: Dropped Makefile portion and enabled OF_UPSTREAM for SoC
> >    instead.
> > - Patch #1, #3, #6 and #8: Picked up review tags
> >
> > Changes in v2:
> > --------------
> > - Patch #1: excluded gitab CI config check and added commit description.
> > - Patch #3: s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/
> > - Patch #4: s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> > - Patch #5: s/U-boot/U-Boot/
> > - Patch #6 and #7: Picked up review tags
> >
> > Prerequisite
> > ------------
> >
> > This patch series requires devicetree-rebasing git repo to be added as a
> > subtree to the main U-Boot repo via:
> >
> > $ git subtree add --prefix devicetree-rebasing \
> >        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
> >        v6.6-dts --squash
> >
> > Background
> > ----------
> >
> > This effort started while I was reviewing patch series corresponding to
> > Qcom platforms [1] which was about to import modified devicetree source
> > files from Linux kernel. I suppose keeping devicetree files sync with
> > Linux kernel without any DT bindings schema validation has been a pain
> > for U-Boot SoC/platform maintainers. There has been past discussions
> > about a single DT repo but that hasn't come up and Linux kernel remained
> > the place where DT source files as well as bindings are placed and
> > maintained.
> >
> > However, Linux kernel DT maintainers proposed [2] for U-Boot to rather
> > use devicetree-rebasing repo [3] which is a forked copy from Linux
> > kernel for DT source files as well as bindings. It is tagged at every
> > Linux kernel major release or intermideate release candidates. So here I
> > have tried to reuse that to bring DT bingings compliance as well as a
> > standard way to maintain a regular sync of DT source files with Linux
> > kernel.
> >
> > In order to maintain devicetree files sync, U-Boot will maintains a Git
> > subtree for devicetee-rebasing repo as `devicetee-rebasing/` sub-directory.
> > It will be regularly updated with every new kernel major release via
> > subtree pull as follows:
> >
> > $ git subtree pull --prefix devicetree-rebasing \
> >        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
> >        <release-tag> --squash
> >
> > The RFC/prototype for this series has been discussed with Linux DT
> > maintainers as well as U-Boot maintainers here [4]. Now we would like to
> > reach out to wider U-Boot community to seek feedback.
> >
> > [1] https://lore.kernel.org/all/CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com/
> > [2] https://lore.kernel.org/all/CAL_JsqKEjv2tSGmT+0ZiO7_qbBfhTycbGnhJhYpKDFzfO9jzDg@mail.gmail.com/
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> > [4] https://github.com/u-boot/u-boot/pull/451
> >
> > Changes
> > -------
> >
> > Traditionally, U-Boot placed copies of devicetree source files from Linux
> > kernel into `arch/<arch>/dts/<name>.dts`, which can be selected via:
> >
> > CONFIG_DEFAULT_DEVICE_TREE "<name>"
> >
> > SoC/board maintainers are encouraged to migrate to using mirrored copies
> > from `devicetree-rebasing/` into `dts/arch/<arch>/<vendor>` via:
> >
> > CONFIG_OF_UPSTREAM=y
> > CONFIG_DEFAULT_DEVICE_TREE "<vendor>/<name>"
> >
> > An example have been shown for Amlogic meson-gxbb SoC and corresponding
> > derived boards via patch #7 and #8.
> >
> > Devicetree bindings schema checks
> > ---------------------------------
> >
> > With devicetee-rebasing Git subtree, the devicetree bindings are also
> > regularly synced with Linux kernel as `devicetree-rebasing/Bindings/`
> > sub-directory. This allows U-Boot to run devicetree bindings schema checks
> > which will bring compliance to U-Boot core/drivers regarding usage of
> > devicetree.
> >
> > Dependencies
> > ------------
> >
> > The DT schema project must be installed in order to validate the DT schema
> > binding documents and validate DTS files using the DT schema. The DT schema
> > project can be installed with pip:
> >
> > $ pip3 install dtschema
> >
> > Note that 'dtschema' installation requires 'swig' and Python development
> > files installed first. On Debian/Ubuntu systems:
> >
> > $ apt install swig python3-dev
> >
> > Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
> > installed. Ensure they are in your PATH (~/.local/bin by default).
> >
> > Recommended is also to install yamllint (used by dtschema when present).
> >
> > Running checks
> > --------------
> >
> > In order to perform validation of DTB files, use the ``dtbs_check`` target:
> >
> > $ make dtbs_check
>
> I have been following your guidance here and I have also seen it to work but not
> sure why. Anyway I have strong suspicious that any Makefile rule is not right.
>

Thanks for taking time to test DT schema checks. It looks like your
suspicion is correct.

> I am getting this issue.
>
> /bin/sh: line 1: @: command not found
> make[1]: *** [devicetree-rebasing/Bindings/Makefile:68:
> devicetree-rebasing/Bindings/processed-schema.json] Error 127
> make: *** [Makefile:1181: dt_binding_check] Error 2
>

I was able to reproduce this issue once I installed yamllint on my
Ubuntu machine.

>
> devicetree-rebasing/Bindings/processed-schema.json is not generated properly
>
> I am using the latest dt schema
> $ dt-validate -V
> 2023.12.dev6+gfb80ec43c204
>
> and no issue to run it from Linux source code that's why I expect it is not
> issue with my PC in general.
> Do you know what can be wrong?

The issue here is basically due to old U-Boot Kbuild infrastructure
which isn't in sync with Linux kernel. This Kbuild commit [1] changes
aren't present in U-Boot leading to this issue.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3a2429e1faf40b2aaa481aa4b001a74d222c7e8b

Following change to adapt bindings Makefile to old U-Boot Kbuild
expectation should resolve this issue:

diff --git a/devicetree-rebasing/Bindings/Makefile
b/devicetree-rebasing/Bindings/Makefile
index 8b395893bd8..7d08372691c 100644
--- a/devicetree-rebasing/Bindings/Makefile
+++ b/devicetree-rebasing/Bindings/Makefile
@@ -47,9 +47,9 @@ quiet_cmd_mk_schema = SCHEMA  $@
                      rm -f $$f

 define rule_chkdt
-       $(if $(DT_SCHEMA_LINT),$(call cmd,yamllint),)
-       $(call cmd,chk_bindings)
-       $(call cmd,mk_schema)
+       $(if $(DT_SCHEMA_LINT),$(call echo-cmd,yamllint) $(cmd_yamllint),); \
+       $(call echo-cmd,chk_bindings) $(cmd_chk_bindings); \
+       $(call echo-cmd,mk_schema) $(cmd_mk_schema)
 endef

 DT_DOCS = $(patsubst $(srctree)/%,%,$(shell $(find_all_cmd)))

If this works for you then I will include it as a separate patch for v4.

-Sumit

>
> Thanks,
> Michal
>
