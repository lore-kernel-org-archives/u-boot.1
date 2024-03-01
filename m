Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E82CC5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 10:42:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60FFB87E70;
	Fri,  1 Mar 2024 11:42:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AUspBx0J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05BE487DE2; Fri,  1 Mar 2024 07:17:32 +0100 (CET)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 167BA87D7C
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 07:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4727ca88800so562156137.1
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 22:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709273845; x=1709878645; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KgYXkM45W5rzcrzJJuCIwT2/uUlNuR58rM2M1XihuTg=;
 b=AUspBx0JR88PttjNie3amHu0N52fJ3kDj4BZLgVAv5sjZmAJQjWmtZsa+u/s3REwVc
 wjF4e2VOC77/ejYcoziFPMMHexAC5oPLvPFn1+JX1679Kc/SDNSaZBdN1cvX4xXIs2KT
 URtUFhwcGRVNwRRuRJeDFPmCdT5uE5cksaociVBMQ7as6zIwQNtL7beXqit9GBitI5CP
 j+HRkPq2KtCtGLQVr+Rg2+YpDkBpGELiU2cBgtcOxuf6lqTyCsvTbVh/SlaxRqood6K5
 +DYiWePHki3K7j8Z/vBEZ8gXcF91+V78P9CzAIJe3WeVS/s5H3g4v/FFgJTbUfsXY4UO
 +Bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709273845; x=1709878645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KgYXkM45W5rzcrzJJuCIwT2/uUlNuR58rM2M1XihuTg=;
 b=u42L2+t+yzplF0Nuin784us6Jg6BcIc63yKxEx6RuyJuMp7dfaqCZezOQJ0bh9j5tb
 134guIMcrhV1jBPHPEls9EJK+J/luyNmTIasQ8if/NtI3hbwqNEUi+enB5u5xrQGw9pK
 EOhjPGeKzaa+z8Yp0FqQl0NtWoZAVmJOecR3c6rldVLurq8W23qkrDRpBrFMDg+SR1qh
 czvbvd9NMS1en9fk5qJvLXAFJQ4DS2jsXe9q8iPK9FuwMZbRsuyZtD5S983fz48L1rmu
 cUUXm34R4kW7ejf8qnFOWZY+JmpgWPSsv6s9T69tER4b2TGh/V9OatbMkLwHE+WHzadE
 Iryw==
X-Gm-Message-State: AOJu0Yzz7aQIPYS7CQGe2k7dMLcjD8HyxrwtU2SpyzLHGtri92uRpQHM
 Bx2yPPLdAawiK128G24Ac+PGwpAqr0luDZQwmErkzlk8aj8+/RVrnVV+3isGRapg9rK5vBudFHo
 7LajKCagyoWo/ifvJfXZnEO5KeA60ZrryHcer7g==
X-Google-Smtp-Source: AGHT+IEhH1bj/C/FBamHXdsY+gOYj43LkQIRIeeh2OVX7IP4ckHlUj0BTAZEcm3JBjJMVHVLtxQjvLwAoJ//P1XCC1E=
X-Received: by 2002:a67:b408:0:b0:472:7227:b1f8 with SMTP id
 x8-20020a67b408000000b004727227b1f8mr457347vsl.19.1709273844663; Thu, 29 Feb
 2024 22:17:24 -0800 (PST)
MIME-Version: 1.0
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
In-Reply-To: <20240222093607.3085545-1-sumit.garg@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 1 Mar 2024 11:47:13 +0530
Message-ID: <CAFA6WYP4ioYxdY+3EQz-FT_eO5gOmAME+7BcXD4vWuqhLV2uAQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] An effort to bring DT bindings compliance within
 U-Boot
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, sjg@chromium.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl, festevam@gmail.com, 
 nm@ti.com, andre.przywara@arm.com, ijc@hellion.org.uk, 
 paul.barker.ct@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 01 Mar 2024 11:42:18 +0100
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

Hi Tom,

On Thu, 22 Feb 2024 at 15:06, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Changes in v6:
> --------------
> - v6_dt: https://github.com/b49020/u-boot/tree/v6_dt
> - Patch #3: Incorporate fix for sandbox CI failure.
> - Patch #6: Incorporate shell script comments from Marek.
> - Patch #8: Incorporate documentation review comments from Paul.
>

I haven't heard any major feedback/comments for v6. So can you pick up
this series for the U-Boot -next branch? As you may already be aware
that it is a dependency for [1] [2] [3]. Also, we would like to move
all new Qcom platforms to use upstream DT too.

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=396399
[2] https://patchwork.ozlabs.org/project/uboot/list/?series=396742
[3] https://patchwork.ozlabs.org/project/uboot/list/?series=396992&state=*

-Sumit

> Changes in v5:
> --------------
> - Rebased on tip of master (050a9b981d6a835133521b599be3ae189ce70f41)
> - Created v5_dt branch for testing purposes:
>   https://github.com/b49020/u-boot/tree/v5_dt
> - Patch #6: Added support to cherry-pick fixes in subtree update script.
>   Also, used https:// instead of git://.
> - Patch #7: Fixed inappropriate documentation update.
> - Patch #8: Document how to cherry-pick fixes from devicetree-rebasing
>   tree.
>
> Changes in v4:
> --------------
> - Switched subtree to be imported as dts/upstream sub-directory rather
>   than devicetree-rebasing sub-directory to better suite U-Boot
>   directory structure.
> - Since we now have v6.7-dts tag available now, so switch subtree to
>   that from its beginning.
> - Patch #2: Incorporate build fix to adjust Bindings Makefile rules to
>   old U-Boot Kbuild infrastructure.
> - Patch #3: Incorporate fix to resolve rk3399 migration issue reported
>   by Simon.
> - Patch #4: New patch to reuse upstream DT includes by U-Boot as per
>   Brian's use-case for TI K3 SoCs.
> - Patch #5: Added a note to OF_UPSTREAM Kconfig option.
> - Patch #6: New patch to add script dts/update-dts-subtree.sh as per
>   Rob's comments.
> - Patch #7: Separate patch to align documentation to use Kconfig symbols
>   instead.
> - Patch #8: Clarify subtree uprev schedule as a separate documentation
>   section. Also, fixed documentation typos.
> - Patch #9: Added commit description.
>
> Changes in v3:
> --------------
> - Patch #4: Minor commit message update
> - Patch #5: Replace CONFIG_* with Kconfig options
> - Patch #7: Dropped Makefile portion and enabled OF_UPSTREAM for SoC
>   instead.
> - Patch #1, #3, #6 and #8: Picked up review tags
>
> Changes in v2:
> --------------
> - Patch #1: excluded gitab CI config check and added commit description.
> - Patch #3: s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/
> - Patch #4: s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> - Patch #5: s/U-boot/U-Boot/
> - Patch #6 and #7: Picked up review tags
>
> Prerequisite
> ------------
>
> This patch series requires devicetree-rebasing git repo to be added as a
> subtree to the main U-Boot repo via:
>
> $ git subtree add --prefix dts/upstream \
>       https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>       v6.7-dts --squash
>
> Background
> ----------
>
> This effort started while I was reviewing patch series corresponding to
> Qcom platforms [1] which was about to import modified devicetree source
> files from Linux kernel. I suppose keeping devicetree files sync with
> Linux kernel without any DT bindings schema validation has been a pain
> for U-Boot SoC/platform maintainers. There has been past discussions
> about a single DT repo but that hasn't come up and Linux kernel remained
> the place where DT source files as well as bindings are placed and
> maintained.
>
> However, Linux kernel DT maintainers proposed [2] for U-Boot to rather
> use devicetree-rebasing repo [3] which is a forked copy from Linux
> kernel for DT source files as well as bindings. It is tagged at every
> Linux kernel major release or intermideate release candidates. So here I
> have tried to reuse that to bring DT bingings compliance as well as a
> standard way to maintain a regular sync of DT source files with Linux
> kernel.
>
> In order to maintain devicetree files sync, U-Boot will maintains a Git
> subtree for devicetee-rebasing repo as `dts/upstream` sub-directory.
> U-Boot will regularly sync `dts/upstream/` subtree whenever the next window
> opens with the next available kernel major release.
> `dts/update-dts-subtree.sh` script provides a wrapper around git subtree
> pull command, usage from the top level U-Boot source tree, run:
>
> $ ./dts/update-dts-subtree.sh pull <devicetree-rebasing-release-tag>
>
> If required it is also possible to cherry-pick fixes from
> devicetree-rebasing tree prior to next sync, usage:
>
> $ ./dts/update-dts-subtree.sh pick <devicetree-rebasing-commit-id>
>
> The RFC/prototype for this series has been discussed with Linux DT
> maintainers as well as U-Boot maintainers here [4]. Now we would like to
> reach out to wider U-Boot community to seek feedback.
>
> [1] https://lore.kernel.org/all/CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com/
> [2] https://lore.kernel.org/all/CAL_JsqKEjv2tSGmT+0ZiO7_qbBfhTycbGnhJhYpKDFzfO9jzDg@mail.gmail.com/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> [4] https://github.com/u-boot/u-boot/pull/451
>
> Changes
> -------
>
> Traditionally, U-Boot placed copies of devicetree source files from Linux
> kernel into `arch/<arch>/dts/<name>.dts` which can be selected via setting
> "<name>" when prompted for `DEFAULT_DEVICE_TREE` by Kconfig.
>
> SoC/board maintainers are encouraged to migrate to use synced copies from
> `dts/upstream/src/<arch>/<vendor>`. To do that enable `OF_UPSTREAM` for the
> SoC being used via Kconfig and set up "<vendor>/<name>" when prompted for
> `DEFAULT_DEVICE_TREE` by Kconfig.
>
> An example have been shown for Amlogic meson-gxbb SoC and corresponding
> derived boards via patch #10 and #11.
>
> Devicetree bindings schema checks
> ---------------------------------
>
> With devicetee-rebasing Git subtree, the devicetree bindings are also
> regularly synced with Linux kernel as `dts/upstream/Bindings/`
> sub-directory. This allows U-Boot to run devicetree bindings schema checks
> which will bring compliance to U-Boot core/drivers regarding usage of
> devicetree.
>
> Dependencies
> ------------
>
> The DT schema project must be installed in order to validate the DT schema
> binding documents and validate DTS files using the DT schema. The DT schema
> project can be installed with pip:
>
> $ pip3 install dtschema
>
> Note that 'dtschema' installation requires 'swig' and Python development
> files installed first. On Debian/Ubuntu systems:
>
> $ apt install swig python3-dev
>
> Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
> installed. Ensure they are in your PATH (~/.local/bin by default).
>
> Recommended is also to install yamllint (used by dtschema when present).
>
> $ apt install yamllint
>
> Running checks
> --------------
>
> In order to perform validation of DTB files, use the ``dtbs_check`` target:
>
> $ make dtbs_check
>
> It is also possible to run checks with a subset of matching schema files by
> setting the ``DT_SCHEMA_FILES`` variable to 1 or more specific schema files
> or patterns (partial match of a fixed string). Each file or pattern should
> be separated by ':'.
>
> $ make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml:rtc.yaml
> $ make dtbs_check DT_SCHEMA_FILES=/gpio/
> $ make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml
>
> Sumit Garg (11):
>   CI: Exclude devicetree-rebasing subtree for CONFIG checks
>   Makefile: Add support for DT bindings schema checks
>   scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
>   Makefile: Allow upstream DT subtree to provide DT includes
>   dts: Add alternative location for upstream DTB builds
>   dts: Add script to uprev dts/upstream subtree
>   doc: devicetree: Align documentation to use Kconfig options
>   doc: devicetree: Updates for devicetree-rebasing subtree
>   MAINTAINERS: Add myself as devicetree-rebasing maintainer
>   dts: meson-gxbb: Switch to using upstream DT
>   dts: meson-gxbb: Drop redundant devicetree files
>
>  .azure-pipelines.yml                    |   3 +-
>  .gitlab-ci.yml                          |   3 +-
>  MAINTAINERS                             |   5 +
>  Makefile                                |  23 +-
>  arch/arm/dts/Makefile                   |   8 -
>  arch/arm/dts/meson-gxbb-kii-pro.dts     | 140 ----
>  arch/arm/dts/meson-gxbb-nanopi-k2.dts   | 426 ------------
>  arch/arm/dts/meson-gxbb-odroidc2.dts    | 414 -----------
>  arch/arm/dts/meson-gxbb-p200.dts        | 100 ---
>  arch/arm/dts/meson-gxbb-p201.dts        |  26 -
>  arch/arm/dts/meson-gxbb-p20x.dtsi       | 250 -------
>  arch/arm/dts/meson-gxbb-wetek-hub.dts   |  58 --
>  arch/arm/dts/meson-gxbb-wetek-play2.dts | 119 ----
>  arch/arm/dts/meson-gxbb-wetek.dtsi      | 292 --------
>  arch/arm/dts/meson-gxbb.dtsi            | 870 ------------------------
>  arch/arm/mach-meson/Kconfig             |   1 +
>  configs/nanopi-k2_defconfig             |   2 +-
>  configs/odroid-c2_defconfig             |   2 +-
>  configs/p200_defconfig                  |   2 +-
>  configs/p201_defconfig                  |   2 +-
>  configs/videostrong-kii-pro_defconfig   |   2 +-
>  configs/wetek-hub_defconfig             |   2 +-
>  configs/wetek-play2_defconfig           |   2 +-
>  doc/develop/devicetree/control.rst      | 159 +++--
>  dts/Kconfig                             |  16 +
>  dts/Makefile                            |  17 +-
>  dts/update-dts-subtree.sh               |  48 ++
>  dts/upstream/Bindings/Makefile          |   6 +-
>  dts/upstream/src/arm64/Makefile         |  14 +
>  scripts/Makefile.lib                    |  50 +-
>  30 files changed, 283 insertions(+), 2779 deletions(-)
>  delete mode 100644 arch/arm/dts/meson-gxbb-kii-pro.dts
>  delete mode 100644 arch/arm/dts/meson-gxbb-nanopi-k2.dts
>  delete mode 100644 arch/arm/dts/meson-gxbb-odroidc2.dts
>  delete mode 100644 arch/arm/dts/meson-gxbb-p200.dts
>  delete mode 100644 arch/arm/dts/meson-gxbb-p201.dts
>  delete mode 100644 arch/arm/dts/meson-gxbb-p20x.dtsi
>  delete mode 100644 arch/arm/dts/meson-gxbb-wetek-hub.dts
>  delete mode 100644 arch/arm/dts/meson-gxbb-wetek-play2.dts
>  delete mode 100644 arch/arm/dts/meson-gxbb-wetek.dtsi
>  delete mode 100644 arch/arm/dts/meson-gxbb.dtsi
>  create mode 100755 dts/update-dts-subtree.sh
>  create mode 100644 dts/upstream/src/arm64/Makefile
>
> --
> 2.34.1
>
