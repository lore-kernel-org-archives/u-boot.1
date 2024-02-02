Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE19C4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 13:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A60687C7B;
	Fri,  2 Feb 2024 14:07:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w8VMDsv9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCD3387C78; Fri,  2 Feb 2024 14:07:14 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 146AA87C7B
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 14:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d958e0d73dso6195805ad.1
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 05:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706879229; x=1707484029; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jTp7WRmJjSv/n60Wl5ntm7/E/DeVXPBvn58BiICXmBY=;
 b=w8VMDsv9m5vTLpbBX8BPKDdpnFS55wuTDAUYDUVm7srTwyP5HF4vFl7Q2vxilAid7Y
 PveyO3oPeTee7pEWVoSjlYoqB7F8mmGVksPqlvtye3u3VPvENa86sAigpOujHRBY+jkH
 l5eS2EV5ebeyrARbp5JZAQGsr2/IIcTdEhKo2H3Obxc8pxpPHqtOgKIZfgC3P3swva6p
 5Mwk5M2HD3gYHNJEGWp9O7v5lOzVQ6h8OJZowp9QoncrZuyVdarNc5ZvuXDF7TPxHln/
 9wBs/dNbOWWVlIgPcgPzbt0A0opA6R6onc0t8FUNKa7k2nqbFLPTz3tXEVPzaBwsqMGS
 5Y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706879229; x=1707484029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jTp7WRmJjSv/n60Wl5ntm7/E/DeVXPBvn58BiICXmBY=;
 b=Gk1yjlJzSiBWhWnQMv6i7e6IzsJM+TdN2n98cF0OSrgxAkGAxUzWxap1DNqFp877qT
 0ouVbv/G2GC33niKdrTbP9fPVmQggUHUDZri5s4tRlADWQBz5LYEUl1tYqW6kmSgJu+w
 WpZcZqwcpUyN2bO6faxEcVamHcCxwJPk7Ph1+6Bkd7tekhvqWYMNxoIno3dTV02gc+dG
 x4lchfk/WsgATC6pSUXC48vfAxaIWoUH1TdbX28nLXRfzfBQp2Sa6gOStTcB3DEgxHix
 EMgVJ6vwSbj5QT3tuygmly5cw/77lUvTViX/m/nnrAPPD9dyx7nrePhgBPhQt09uJH2A
 douA==
X-Gm-Message-State: AOJu0Yye7Q+gSiQ+L1y4txw0c3iZz3pW0p3PwFOjDzpuLAzQbIW3fVz6
 7dzMGHDF/tRMk2gOvNym+uXzmENxOijRNlnOfp2gTuS9fsvOsY/S982X/MqMXy/CNPf82qLJ61q
 R1aU=
X-Google-Smtp-Source: AGHT+IFHObvFXB8rrghDes+swKlqcoup9431vWrwEJ2IrWvacENLtE/nzLZZEw3dVN6JE6mI8CJ3BA==
X-Received: by 2002:a17:902:d50a:b0:1d9:14ac:239e with SMTP id
 b10-20020a170902d50a00b001d914ac239emr3106630plg.28.1706879229011; 
 Fri, 02 Feb 2024 05:07:09 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUCVh4VbLLEkIhOkafzpd9YeTCzlbdN33k/NRZq/mX/4+M/meqk98jthCxIty6CrFWL0PkotnvVU87fRv+EsXF1r9WvcD4dicUo/AWKR6tYh/cBomCnah/F+x5CxL6ZbciZiUI6FSPxO+y1dTrl09jx9/WNurAvPfeQKzAO/dU5GDwshfFTvX8F6blr5dCin1l8KWuNRCX2pBxy8/b7tDwxyu8hclyPhPRsFz8he+dtk2/YndOThDpg7mtCXpO1qxBQ5LRFlL6TLmK5v5xZqzsoKyV0to1/FkVFOTlctxPDvuErGD9axIpzOZDv1fTj4opVrL7I2PLIKVIpGgg7HUB9YHQSX7ymrBf94sADlWrNqsvdlQUSQgfQN6L4wswGPUcRzgdDdcKeOziNPshwOZuumsZs92e7qouDFzvcsQ953ch7Wr7nUH7DV6By/jy+8p04MH+6RpzqgfjdLE3jtNmqJdGaX/xjJV7Rechw6zngO3CbRDKp5LKM1qJlSo1fTOX5N+tSeGtPfCDcggB6i0kaR6zGWQs770szS2sB0Vz0gte+lVPofQI+xcJD/L3dWVC7ettX9GQObP2z7IOgOj84B8ZCj9eaB13Wmt3GQTONn6np+F8BwamFZHVIzz9EPyOSvBygYexRxKaYDmB3FwBBvNqobAxxtti1Ca1EBxXErvk2jnHtfloYqzm7ZxbbxOvF8etFHvpSW9UwIF7ECss9myY5WH1or70z2yx/I3JXPj3Wf4AnhyW7AmJrTCB0SXxbFtT2vk4uaQzRi09YwswQjzfo8ZWAK6RI9uxjhTSy/dHGpbKapteLDAp8qGhQHJcxOwA9Z0HWOIvOmxSoKuAicj2C/JSqSYt7fXc8IKbIcdjna8QSPgmqesgn8dsp6FaApzqn56cvDu3IeATTgPu6VBGCbwp5rH+N
Received: from sumit-X1.. ([223.178.213.44]) by smtp.gmail.com with ESMTPSA id
 q23-20020a170902edd700b001d923684323sm1542407plk.195.2024.02.02.05.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 05:07:08 -0800 (PST)
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
 andre.przywara@arm.com, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 08/11] doc: devicetree: Updates for devicetree-rebasing
 subtree
Date: Fri,  2 Feb 2024 18:35:31 +0530
Message-Id: <20240202130534.1051438-9-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202130534.1051438-1-sumit.garg@linaro.org>
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Encourage SoC/board maintainers to migrate to using devicetree-rebasing
subtree and maintain a regular sync with Linux kernel devicetree files
and bindings.

Along with that add documentation regarding how to run DT bindings
schema checks.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v5:
- Document how to cherry-pick fixes from devicetree-rebasing tree.

Changes in v4:
- Switched subtree to be imported as dts/upstream sub-directory rather
  than devicetree-rebasing sub-directory to better suite U-Boot
  directory structure.
- Since we now have v6.7-dts tag available now, so switch subtree to
  that from its beginning.
- Clarify subtree uprev schedule as a separate documentation section.
  Also, fixed documentation typos.

Changes in v3:
- Replace CONFIG_* with Kconfig options

Changes in v2:
- s/U-boot/U-Boot/

 doc/develop/devicetree/control.rst | 117 ++++++++++++++++++++++++-----
 1 file changed, 97 insertions(+), 20 deletions(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 9a0cb90336df..4440d4b82c6a 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -1,5 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. sectionauthor:: Copyright 2011 The Chromium OS Authors
+.. Copyright 2023-2024 Linaro Ltd.
 
 Devicetree Control in U-Boot
 ============================
@@ -22,12 +23,11 @@ for three reasons:
   hierarchical format
 - It is fairly efficient to read incrementally
 
-The arch/<arch>/dts directories contains a Makefile for building the devicetree
-blob and embedding it in the U-Boot image. This is useful since it allows
-U-Boot to configure itself according to what it finds there. If you have
-a number of similar boards with different peripherals, you can describe
-the features of each board in the devicetree file, and have a single
-generic source base.
+The U-Boot Makefile infrastructure allows for building the devicetree blob
+and embedding it in the U-Boot image. This is useful since it allows U-Boot
+to configure itself according to what it finds there. If you have a number
+of similar boards with different peripherals, you can describe the features
+of each board in the devicetree file, and have a single generic source base.
 
 To enable this feature, select `OF_CONTROL` via Kconfig.
 
@@ -68,8 +68,14 @@ a binary file. U-Boot adds its own `fdtgrep` for creating subsets of the file.
 Where do I get a devicetree file for my board?
 ----------------------------------------------
 
-You may find that the Linux kernel has a suitable file. Look in the
-kernel source in arch/<arch>/boot/dts.
+Linux kernel Git repository has been the place where devicetree files along
+with devicetree bindings are stored and maintained. There is devicetee-rebasing
+(dtrepo_) which maintains a forked copy of devicetree files along with bindings
+at every Linux kernel major release or intermediate release candidates.
+
+U-Boot maintains a Git subtree for devicetee-rebasing repo as `dts/upstream/`
+sub-directory. You may find that the `dts/upstream/` sub-directory has a
+suitable devicetree file for your board. Look in `dts/upstream/src/<arch>/`.
 
 If not you might find other boards with suitable files that you can
 modify to your needs. Look in the board directories for files with a
@@ -78,17 +84,38 @@ modify to your needs. Look in the board directories for files with a
 Failing that, you could write one from scratch yourself!
 
 
+Resyncing with devicetree-rebasing
+----------------------------------
+
+U-Boot regularly sync `dts/upstream/` subtree whenever the next window opens
+with the next available kernel major release. `dts/update-dts-subtree.sh` script
+provides a wrapper around git subtree pull command, usage from the top level
+U-Boot source tree, run::
+
+    ./dts/update-dts-subtree.sh pull <devicetree-rebasing-release-tag>
+
+If required it is also possible to cherry-pick fixes from devicetree-rebasing
+tree prior to next sync, usage::
+
+    ./dts/update-dts-subtree.sh pick <devicetree-rebasing-commit-id>
+
+
 Configuration
 -------------
 
-Set up "<name>" when prompted for `DEFAULT_DEVICE_TREE` by Kconfig. Then put
-your devicetree file into::
+Traditionally, U-Boot placed copies of devicetree source files from Linux
+kernel into `arch/<arch>/dts/<name>.dts` which can be selected via setting
+"<name>" when prompted for `DEFAULT_DEVICE_TREE` by Kconfig.
 
-   arch/<arch>/dts/<name>.dts
+However, it has become cumbersome over time for each SoC/board maintainer to
+keep devicetree files in sync with Linux kernel. Therefore, SoC/board
+maintainers are encouraged to migrate to use synced copies from
+`dts/upstream/src/<arch>/<vendor>`. To do that enable `OF_UPSTREAM` for the
+SoC being used via Kconfig and set up "<vendor>/<name>" when prompted for
+`DEFAULT_DEVICE_TREE` by Kconfig.
 
-This should include your CPU or SOC's devicetree file, placed in
-`arch/<arch>/dts`, and then make any adjustments required using a u-boot-dtsi
-file for your board.
+This should include your CPU or SOC's devicetree file. On top of that any U-Boot
+specific tweaks (see: dttweaks_) can be made for your board.
 
 If `OF_EMBED` is selected by Kconfig, then it will be picked up and built into
 the U-Boot image (including u-boot.bin). This is suitable for debugging
@@ -155,8 +182,9 @@ ways:
 Adding tweaks for U-Boot
 ------------------------
 
-It is strongly recommended that devicetree files in U-Boot are an exact copy of
-those in Linux, so that it is easy to sync them up from time to time.
+With `dts/upstream` Git subtree, it is ensured that devicetree files in U-Boot
+are an exact copy of those in Linux kernel available under
+`dts/upstream/src/<arch>/<vendor>`.
 
 U-Boot is of course a very different project from Linux, e.g. it operates under
 much more restrictive memory and code-size constraints. Where Linux may use a
@@ -169,8 +197,8 @@ constraints are even more extreme and the devicetree is shrunk to remove
 unwanted nodes, or even turned into C code to avoid access overhead.
 
 U-Boot automatically looks for and includes a file with updates to the standard
-devicetree for your board, searching for them in the same directory as the
-main file, in this order::
+devicetree for your board, searching for them in `arch/<arch>/dts/` in this
+order::
 
    <orig_filename>-u-boot.dtsi
    <CONFIG_SYS_SOC>-u-boot.dtsi
@@ -199,6 +227,54 @@ option to specify a list of .dtsi files that will also be included when
 building .dtb files.
 
 
+Devicetree bindings schema checks
+---------------------------------
+
+With devicetee-rebasing Git subtree, the devicetree bindings are also regularly
+synced with Linux kernel as `dts/upstream/Bindings/` sub-directory. This
+allows U-Boot to run devicetree bindings schema checks which will bring
+compliance to U-Boot core/drivers regarding usage of devicetree.
+
+Dependencies
+~~~~~~~~~~~~
+
+The DT schema project must be installed in order to validate the DT schema
+binding documents and validate DTS files using the DT schema. The DT schema
+project can be installed with pip::
+
+    pip3 install dtschema
+
+Note that 'dtschema' installation requires 'swig' and Python development files
+installed first. Please, refer to the GCC build documentation for installation
+instructions :doc:`../../build/gcc`.
+
+Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
+installed. Ensure they are in your PATH (~/.local/bin by default).
+
+Recommended is also to install yamllint (used by dtschema when present). On
+Debian/Ubuntu systems::
+
+    apt install yamllint
+
+Running checks
+~~~~~~~~~~~~~~
+
+In order to perform validation of DTB files, use the ``dtbs_check`` target::
+
+    make dtbs_check
+
+It is also possible to run checks with a subset of matching schema files by
+setting the ``DT_SCHEMA_FILES`` variable to 1 or more specific schema files or
+patterns (partial match of a fixed string). Each file or pattern should be
+separated by ':'.
+
+::
+
+    make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml:rtc.yaml
+    make dtbs_check DT_SCHEMA_FILES=/gpio/
+    make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml
+
+
 Relocation, SPL and TPL
 -----------------------
 
@@ -260,8 +336,9 @@ used it before Linux (e.g. snow). The two projects developed in parallel
 and there are still some differences in the bindings for certain boards.
 While there has been discussion of having a separate repository for devicetree
 files, in practice the Linux kernel Git repository has become the place where
-these are stored, with U-Boot taking copies and adding tweaks with u-boot.dtsi
-files.
+these are stored, with U-Boot taking copies via devicetree-rebasing repo
+(see: dtrepo_) and adding tweaks with u-boot.dtsi files.
 
 .. _dtspec: https://www.devicetree.org/specifications/
 .. _dtlist: https://www.spinics.net/lists/devicetree-compiler/
+.. _dtrepo: https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
-- 
2.34.1

