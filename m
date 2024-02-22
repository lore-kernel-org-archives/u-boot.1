Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EDDC48BF8
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 11:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F5398809A;
	Thu, 22 Feb 2024 12:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vmgy++6P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 507468808D; Thu, 22 Feb 2024 10:36:32 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 923B488082
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 10:36:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5d3907ff128so6727648a12.3
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 01:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708594585; x=1709199385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yF9ks++Dmhajcc1FZAqmK68/RdfFazMv3WakqDnSuN0=;
 b=vmgy++6PS3X8KU0Bv68gIvpMymISFdzOl38NEPgh2alJ1bk0IyFQHHPc7KXhTCIMPR
 4QR0F/n3a2FBTdHc+cBiseybAkRLPFJWDtnmZwAFfni550mO4n7b8bpravLn4OrdXx+C
 WbMcm1dW0Rg72WTJ6IaLJsoM26DD40iCrER0+bxBTTslt96X8u+tfAyPy+vhp8pTiEak
 k7FztvREDUrttmlpG7I2xM9Gb39Ziq8WSBDlTUDVV8F8YDTOTbRoOu+JVilaA6beY95O
 TUKPqd3Yg9PLwOXv+xR8YTHWi/ojdwJvn4hQVzxj8MOY4bVQCtBrvGt7biwOM/kFI18s
 lGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708594585; x=1709199385;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yF9ks++Dmhajcc1FZAqmK68/RdfFazMv3WakqDnSuN0=;
 b=GV7FxhccR1fmadCxYtHz+q9w+F3LEa0J/L6/Tt9mTfe38i5w+OdkiAAuBZ/f+DRayS
 DhVf/J4bZ0TOkn1KVt6Esijjv+ooFMSE5xg1R0YkEnD8f9QR+g3XiN2Aj6u3MVPRybFc
 1LHAeFVVWHFU3PW1e1S7cfmEvkGFFCU7tr/G+X4AAYUPe4/29EURMKAIL1U/0+jlCRji
 BfHETfH7ixFwX+roSfyt+haJZxlTVqr+4mCPpIkRAd2IOuufL40nWniEtG80Yp+3SinU
 mwwiy8zo0OljG37inMKtK5cPveBwKCvBLAgTfmghSN0Kcr4h4c4/5/rGFfgd0O3Ed/bA
 ng3Q==
X-Gm-Message-State: AOJu0YytCscGuQiZtb5DCdt+1gUiCsWWubPzx97ZdggxKqjiQ6gsemuJ
 dbYkV1fl5HOZz47rc4/EnfO0+QBqq5QFg1cEuCIWKapEbVWlAu1YqHkQYS9V9Gbv+cGHIY8HPGC
 Z
X-Google-Smtp-Source: AGHT+IFpbR5W6/z/rvF6CHOuejTvOQEo1Clvkl7NShhJbLa0mt25rDMv3NVPTFXhThgKmVFn5e8BmQ==
X-Received: by 2002:a05:6a21:2d8e:b0:19c:8d73:721b with SMTP id
 ty14-20020a056a212d8e00b0019c8d73721bmr26774719pzb.57.1708594584829; 
 Thu, 22 Feb 2024 01:36:24 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.115]) by smtp.gmail.com with ESMTPSA id
 u20-20020a056a00099400b006e47300e4edsm6208404pfg.183.2024.02.22.01.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 01:36:24 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com,
 mark.kettenis@xs4all.nl, festevam@gmail.com, nm@ti.com,
 andre.przywara@arm.com, ijc@hellion.org.uk, paul.barker.ct@bp.renesas.com,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 00/11] An effort to bring DT bindings compliance within
 U-Boot
Date: Thu, 22 Feb 2024 15:05:56 +0530
Message-Id: <20240222093607.3085545-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Feb 2024 12:24:07 +0100
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

Changes in v6:
--------------
- v6_dt: https://github.com/b49020/u-boot/tree/v6_dt
- Patch #3: Incorporate fix for sandbox CI failure.
- Patch #6: Incorporate shell script comments from Marek.
- Patch #8: Incorporate documentation review comments from Paul.

Changes in v5:
--------------
- Rebased on tip of master (050a9b981d6a835133521b599be3ae189ce70f41)
- Created v5_dt branch for testing purposes:
  https://github.com/b49020/u-boot/tree/v5_dt
- Patch #6: Added support to cherry-pick fixes in subtree update script.
  Also, used https:// instead of git://.
- Patch #7: Fixed inappropriate documentation update.
- Patch #8: Document how to cherry-pick fixes from devicetree-rebasing
  tree.

Changes in v4:
--------------
- Switched subtree to be imported as dts/upstream sub-directory rather
  than devicetree-rebasing sub-directory to better suite U-Boot
  directory structure.
- Since we now have v6.7-dts tag available now, so switch subtree to
  that from its beginning.
- Patch #2: Incorporate build fix to adjust Bindings Makefile rules to
  old U-Boot Kbuild infrastructure.
- Patch #3: Incorporate fix to resolve rk3399 migration issue reported
  by Simon.
- Patch #4: New patch to reuse upstream DT includes by U-Boot as per
  Brian's use-case for TI K3 SoCs.
- Patch #5: Added a note to OF_UPSTREAM Kconfig option.
- Patch #6: New patch to add script dts/update-dts-subtree.sh as per
  Rob's comments.
- Patch #7: Separate patch to align documentation to use Kconfig symbols
  instead.
- Patch #8: Clarify subtree uprev schedule as a separate documentation
  section. Also, fixed documentation typos.
- Patch #9: Added commit description.

Changes in v3:
--------------
- Patch #4: Minor commit message update
- Patch #5: Replace CONFIG_* with Kconfig options
- Patch #7: Dropped Makefile portion and enabled OF_UPSTREAM for SoC
  instead.
- Patch #1, #3, #6 and #8: Picked up review tags

Changes in v2:
--------------
- Patch #1: excluded gitab CI config check and added commit description.
- Patch #3: s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/
- Patch #4: s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
- Patch #5: s/U-boot/U-Boot/
- Patch #6 and #7: Picked up review tags

Prerequisite
------------

This patch series requires devicetree-rebasing git repo to be added as a
subtree to the main U-Boot repo via:

$ git subtree add --prefix dts/upstream \
      https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
      v6.7-dts --squash

Background
----------

This effort started while I was reviewing patch series corresponding to
Qcom platforms [1] which was about to import modified devicetree source
files from Linux kernel. I suppose keeping devicetree files sync with
Linux kernel without any DT bindings schema validation has been a pain
for U-Boot SoC/platform maintainers. There has been past discussions
about a single DT repo but that hasn't come up and Linux kernel remained
the place where DT source files as well as bindings are placed and
maintained.

However, Linux kernel DT maintainers proposed [2] for U-Boot to rather
use devicetree-rebasing repo [3] which is a forked copy from Linux
kernel for DT source files as well as bindings. It is tagged at every
Linux kernel major release or intermideate release candidates. So here I
have tried to reuse that to bring DT bingings compliance as well as a
standard way to maintain a regular sync of DT source files with Linux
kernel.

In order to maintain devicetree files sync, U-Boot will maintains a Git
subtree for devicetee-rebasing repo as `dts/upstream` sub-directory.
U-Boot will regularly sync `dts/upstream/` subtree whenever the next window
opens with the next available kernel major release.
`dts/update-dts-subtree.sh` script provides a wrapper around git subtree
pull command, usage from the top level U-Boot source tree, run:

$ ./dts/update-dts-subtree.sh pull <devicetree-rebasing-release-tag>

If required it is also possible to cherry-pick fixes from
devicetree-rebasing tree prior to next sync, usage:

$ ./dts/update-dts-subtree.sh pick <devicetree-rebasing-commit-id>

The RFC/prototype for this series has been discussed with Linux DT
maintainers as well as U-Boot maintainers here [4]. Now we would like to
reach out to wider U-Boot community to seek feedback.

[1] https://lore.kernel.org/all/CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com/
[2] https://lore.kernel.org/all/CAL_JsqKEjv2tSGmT+0ZiO7_qbBfhTycbGnhJhYpKDFzfO9jzDg@mail.gmail.com/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
[4] https://github.com/u-boot/u-boot/pull/451

Changes
-------

Traditionally, U-Boot placed copies of devicetree source files from Linux
kernel into `arch/<arch>/dts/<name>.dts` which can be selected via setting
"<name>" when prompted for `DEFAULT_DEVICE_TREE` by Kconfig.

SoC/board maintainers are encouraged to migrate to use synced copies from
`dts/upstream/src/<arch>/<vendor>`. To do that enable `OF_UPSTREAM` for the
SoC being used via Kconfig and set up "<vendor>/<name>" when prompted for
`DEFAULT_DEVICE_TREE` by Kconfig.

An example have been shown for Amlogic meson-gxbb SoC and corresponding
derived boards via patch #10 and #11.

Devicetree bindings schema checks
---------------------------------

With devicetee-rebasing Git subtree, the devicetree bindings are also
regularly synced with Linux kernel as `dts/upstream/Bindings/`
sub-directory. This allows U-Boot to run devicetree bindings schema checks
which will bring compliance to U-Boot core/drivers regarding usage of
devicetree.

Dependencies
------------

The DT schema project must be installed in order to validate the DT schema
binding documents and validate DTS files using the DT schema. The DT schema
project can be installed with pip:

$ pip3 install dtschema

Note that 'dtschema' installation requires 'swig' and Python development
files installed first. On Debian/Ubuntu systems:

$ apt install swig python3-dev

Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
installed. Ensure they are in your PATH (~/.local/bin by default).

Recommended is also to install yamllint (used by dtschema when present).

$ apt install yamllint

Running checks
--------------

In order to perform validation of DTB files, use the ``dtbs_check`` target:

$ make dtbs_check

It is also possible to run checks with a subset of matching schema files by
setting the ``DT_SCHEMA_FILES`` variable to 1 or more specific schema files
or patterns (partial match of a fixed string). Each file or pattern should
be separated by ':'.

$ make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml:rtc.yaml
$ make dtbs_check DT_SCHEMA_FILES=/gpio/
$ make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml

Sumit Garg (11):
  CI: Exclude devicetree-rebasing subtree for CONFIG checks
  Makefile: Add support for DT bindings schema checks
  scripts/Makefile.lib: Statically define *-u-boot.dtsi files location
  Makefile: Allow upstream DT subtree to provide DT includes
  dts: Add alternative location for upstream DTB builds
  dts: Add script to uprev dts/upstream subtree
  doc: devicetree: Align documentation to use Kconfig options
  doc: devicetree: Updates for devicetree-rebasing subtree
  MAINTAINERS: Add myself as devicetree-rebasing maintainer
  dts: meson-gxbb: Switch to using upstream DT
  dts: meson-gxbb: Drop redundant devicetree files

 .azure-pipelines.yml                    |   3 +-
 .gitlab-ci.yml                          |   3 +-
 MAINTAINERS                             |   5 +
 Makefile                                |  23 +-
 arch/arm/dts/Makefile                   |   8 -
 arch/arm/dts/meson-gxbb-kii-pro.dts     | 140 ----
 arch/arm/dts/meson-gxbb-nanopi-k2.dts   | 426 ------------
 arch/arm/dts/meson-gxbb-odroidc2.dts    | 414 -----------
 arch/arm/dts/meson-gxbb-p200.dts        | 100 ---
 arch/arm/dts/meson-gxbb-p201.dts        |  26 -
 arch/arm/dts/meson-gxbb-p20x.dtsi       | 250 -------
 arch/arm/dts/meson-gxbb-wetek-hub.dts   |  58 --
 arch/arm/dts/meson-gxbb-wetek-play2.dts | 119 ----
 arch/arm/dts/meson-gxbb-wetek.dtsi      | 292 --------
 arch/arm/dts/meson-gxbb.dtsi            | 870 ------------------------
 arch/arm/mach-meson/Kconfig             |   1 +
 configs/nanopi-k2_defconfig             |   2 +-
 configs/odroid-c2_defconfig             |   2 +-
 configs/p200_defconfig                  |   2 +-
 configs/p201_defconfig                  |   2 +-
 configs/videostrong-kii-pro_defconfig   |   2 +-
 configs/wetek-hub_defconfig             |   2 +-
 configs/wetek-play2_defconfig           |   2 +-
 doc/develop/devicetree/control.rst      | 159 +++--
 dts/Kconfig                             |  16 +
 dts/Makefile                            |  17 +-
 dts/update-dts-subtree.sh               |  48 ++
 dts/upstream/Bindings/Makefile          |   6 +-
 dts/upstream/src/arm64/Makefile         |  14 +
 scripts/Makefile.lib                    |  50 +-
 30 files changed, 283 insertions(+), 2779 deletions(-)
 delete mode 100644 arch/arm/dts/meson-gxbb-kii-pro.dts
 delete mode 100644 arch/arm/dts/meson-gxbb-nanopi-k2.dts
 delete mode 100644 arch/arm/dts/meson-gxbb-odroidc2.dts
 delete mode 100644 arch/arm/dts/meson-gxbb-p200.dts
 delete mode 100644 arch/arm/dts/meson-gxbb-p201.dts
 delete mode 100644 arch/arm/dts/meson-gxbb-p20x.dtsi
 delete mode 100644 arch/arm/dts/meson-gxbb-wetek-hub.dts
 delete mode 100644 arch/arm/dts/meson-gxbb-wetek-play2.dts
 delete mode 100644 arch/arm/dts/meson-gxbb-wetek.dtsi
 delete mode 100644 arch/arm/dts/meson-gxbb.dtsi
 create mode 100755 dts/update-dts-subtree.sh
 create mode 100644 dts/upstream/src/arm64/Makefile

-- 
2.34.1

