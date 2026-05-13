Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCFECD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 04:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBC2C83CD3;
	Wed, 13 May 2026 06:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hxc0CUy6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3488483FB0; Wed, 13 May 2026 06:13:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4BF4836AC
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 06:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1778645602; x=1779250402; i=xypron.glpk@gmx.de;
 bh=bQm1gIXSXx6PxTuicyDO9i0tLhwXnE1nnShM3EpofSc=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=hxc0CUy6NsCK8a9zXiXp/70KutIsiD5bJNhWZ0iBKfOtJSdIForxBT0Q3xvcWuee
 xDTanK5a3mTqxeEh2jdqr20YUgfFlJnCKs6rsdoI3Ve9PZ1ztgCN5haXGD7XE3rp6
 19Kb09oDBf4vOGaAh3OV7QvisMrhGFmHqeXqbKg4gfvf6+OmlkfxCW5PFAfWTkgWL
 PhzYgnpgI78EAjkRJBg1YogD+8w8NAZ3jdmUZ657q0Ud+y+donyqe89hxXd7Onbms
 EicQi0eu/Tw+g2zny+mEI4qrha8ycBFI7CQHitNtr+1qWiqyrQGunQviniwCPtX7V
 aUGhoTmtgUOGoZtR4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQe5u-1wjTmB3AkY-00V8SS; Wed, 13
 May 2026 06:13:22 +0200
Date: Wed, 13 May 2026 06:13:14 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Daniel Golle <daniel@makrotopia.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Martin Schwan <m.schwan@phytec.de>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Benjamin ROBIN <dev@benjarobin.fr>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Shiji Yang <yangshiji66@outlook.com>, Aristo Chen <jj251510319013@gmail.com>, 
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_5/8=5D_doc=3A_fit=3A_add_dm?=
 =?US-ASCII?Q?-verity_boot_parameter_documentation?=
User-Agent: Thunderbird for Android
In-Reply-To: <731b6abb01956fa028697aad167e6f705b187ecd.1778637233.git.daniel@makrotopia.org>
References: <cover.1778637233.git.daniel@makrotopia.org>
 <731b6abb01956fa028697aad167e6f705b187ecd.1778637233.git.daniel@makrotopia.org>
Message-ID: <489A2B5F-17AB-4220-AEEF-705C544F973D@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vYuQwRDgEofXVPEn0pPvT5DsEPxVyZCKk2BWffiupZKp5kKgDG7
 94FNJoOyfLmHPjqclqZm+R4lpHBw9O+vZ8zvBO6CfeIpH7KTJh+KdRx5j0O7qk2REOgz5u/
 EKSrMJ7TVIyyka4Gp0PBl583zuDAo5Iu4tMa6eMP4xFYX5HZywe3m6Ax/0s1GPt+omhWZ/8
 g8QJX/hOvt9vPvdYdWe8A==
UI-OutboundReport: notjunk:1;M01:P0:R8BwNF94LOU=;N7rnbXg1i6BIrDGJ/IC1jgeBepi
 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
 359kb6bN3yBkgicJRU=
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

Am 13=2E Mai 2026 04:09:29 MESZ schrieb Daniel Golle <daniel@makrotopia=2Eo=
rg>:
>Add documentation for CONFIG_FIT_VERITY which allows U-Boot to
>construct dm-mod=2Ecreate=3D and dm-mod=2Ewaitfor=3D kernel command-line
>parameters from dm-verity metadata embedded in FIT filesystem
>sub-images=2E
>
>The new document covers the relationship between FIT loadable indices
>and the /dev/fitN block devices that the Linux uImage=2EFIT block driver
>creates, provides a complete =2Eits example with a dm-verity-protected
>SquashFS root filesystem, describes all required and optional dm-verity
>subnode properties and explains how mkimage generates the verity
>metadata automatically=2E
>
>dm-verity is only supported for external-data FIT images (mkimage -E);
>mkimage aborts with an error if the flag is omitted=2E
>
>Signed-off-by: Daniel Golle <daniel@makrotopia=2Eorg>
>Reviewed-by: Simon Glass <sjg@chromium=2Eorg>
>---
>v4: no changes
>v3: clarify that hash-start-block only equals num-data-blocks when
>    data-block-size =3D=3D hash-block-size; in the general case it is
>    data_size / hash-block-size
>v2: trim minimal =2Eits example to user-provided properties only and
>    remove stale references to a verity superblock
>
> doc/usage/fit/dm-verity=2Erst | 284 ++++++++++++++++++++++++++++++++++++
> doc/usage/fit/index=2Erst     |   1 +
> 2 files changed, 285 insertions(+)
> create mode 100644 doc/usage/fit/dm-verity=2Erst
>
>diff --git a/doc/usage/fit/dm-verity=2Erst b/doc/usage/fit/dm-verity=2Ers=
t
>new file mode 100644
>index 00000000000=2E=2Eeddce9e7cf7
>--- /dev/null
>+++ b/doc/usage/fit/dm-verity=2Erst
>@@ -0,0 +1,284 @@
>+=2E=2E SPDX-License-Identifier: GPL-2=2E0+
>+
>+FIT dm-verity Boot Parameters
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>+
>+Introduction
>+------------
>+
>+Linux's dm-verity device-mapper target provides transparent integrity
>+checking of block devices using a Merkle tree=2E It is commonly used to
>+protect read-only root filesystems such as SquashFS images=2E
>+
>+When a FIT image packages the root filesystem as a loadable sub-image of
>+type ``filesystem`` (``IH_TYPE_FILESYSTEM``), the verity metadata can be
>+stored alongside the image data in a ``dm-verity`` subnode=2E U-Boot rea=
ds
>+this metadata at boot time and generates the kernel command-line paramet=
ers
>+that Linux needs to activate the verity target, eliminating the need for
>+an initramfs or userspace helper to set up dm-verity=2E
>+
>+This feature is enabled by ``CONFIG_FIT_VERITY`` (see ``boot/Kconfig``)=
=2E
>+
>+Prerequisites
>+-------------
>+
>+* **Linux uImage=2EFIT block driver** =E2=80=93 the kernel must include =
the FIT block
>+  driver that exposes loadable sub-images as ``/dev/fit0``, ``/dev/fit1`=
`,


The dtb file format of FIT images only guarantees 4 byte alignment=2E Does=
 that match with the requirement of file-system drivers including dma acces=
s if the FIT is for example on eMMC? Or do we need a mechanism to enforce h=
igher alignment in FIT images?

Best regards

Heinrich


>+  etc=2E  The driver assigns device numbers in the order loadables appea=
r in
>+  the FIT configuration=2E
>+
>+* **dm-verity support in the kernel** =E2=80=93 ``CONFIG_DM_VERITY`` mus=
t be
>+  enabled so the kernel can process the ``dm-mod=2Ecreate=3D`` parameter=
=2E
>+
>+* **CONFIG_FIT_VERITY** enabled in U-Boot=2E
>+
>+How it works
>+------------
>+
>+The implementation is split into a **build** phase and an **apply** phas=
e,
>+both of which run automatically within the ``bootm`` state machine=2E No=
 boot
>+method needs to call verity functions explicitly=2E
>+
>+**Build phase** (``BOOTM_STATE_FINDOTHER`` =E2=86=92 ``boot_get_loadable=
()``)
>+
>+1=2E After all loadable sub-images have been loaded,
>+   ``fit_verity_build_cmdline()`` iterates the configuration's
>+   ``loadables`` list=2E
>+
>+2=2E For each loadable that is an ``IH_TYPE_FILESYSTEM`` image **and**
>+   contains a ``dm-verity`` child node, a dm-verity target specification=
 is
>+   built by the helper ``fit_verity_build_target()``=2E
>+
>+3=2E The dm-verity target references ``/dev/fitN``, where *N* is the
>+   zero-based index of the loadable in the configuration=2E  This matche=
s the
>+   numbering used by the Linux FIT block driver=2E
>+
>+4=2E The resulting fragments are stored in ``struct bootm_headers``:
>+
>+   ``images->dm_mod_create``
>+     The full dm-verity target table=2E Multiple targets are separated b=
y ``;``=2E
>+
>+   ``images->dm_mod_waitfor``
>+     Comma-separated list of ``/dev/fitN`` devices so the kernel waits f=
or
>+     the underlying FIT block devices to appear before activating
>+     device-mapper=2E
>+
>+**Apply phase** (``BOOTM_STATE_OS_PREP``)
>+
>+5=2E Just before ``bootm_process_cmdline_env()`` processes the ``bootarg=
s``
>+   environment variable, ``fit_verity_apply_bootargs()`` appends the
>+   ``dm-mod=2Ecreate=3D`` and ``dm-mod=2Ewaitfor=3D`` parameters=2E
>+
>+**Bootmeth integration**
>+
>+  Because the fragments are stored in ``struct bootm_headers``, a boot
>+  method can check ``fit_verity_active(images)`` between bootm state
>+  invocations=2E A typical pattern splits ``bootm_run_states()`` into tw=
o
>+  calls -- one for ``START|FINDOS|FINDOTHER|LOADOS`` and one for
>+  ``OS_PREP|OS_GO`` -- and inspects ``fit_verity_active()`` in
>+  between to decide whether to add a ``root=3D`` parameter pointing at t=
he
>+  dm-verity device=2E
>+
>+FIT image source (=2Eits) example
>+-------------------------------
>+
>+Below is a minimal ``=2Eits`` file showing a kernel and a dm-verity-prot=
ected
>+root filesystem packaged as a FIT=2E Only the three user-provided proper=
ties
>+(``algo``, ``data-block-size``, ``hash-block-size``) are included; ``mki=
mage``
>+computes and fills in ``digest``, ``salt``, ``num-data-blocks``, and
>+``hash-start-block`` automatically (see `Generating verity metadata`_ be=
low)::
>+
>+    /dts-v1/;
>+
>+    / {
>+        description =3D "Kernel + dm-verity rootfs";
>+        #address-cells =3D <1>;
>+
>+        images {
>+            kernel {
>+                description =3D "Linux kernel";
>+                data =3D /incbin/("=2E/Image=2Egz");
>+                type =3D "kernel";
>+                arch =3D "arm64";
>+                os =3D "linux";
>+                compression =3D "gzip";
>+                load =3D <0x44000000>;
>+                entry =3D <0x44000000>;
>+                hash-1 {
>+                    algo =3D "sha256";
>+                };
>+            };
>+
>+            fdt {
>+                description =3D "Device tree blob";
>+                data =3D /incbin/("=2E/board=2Edtb");
>+                type =3D "flat_dt";
>+                arch =3D "arm64";
>+                compression =3D "none";
>+                hash-1 {
>+                    algo =3D "sha256";
>+                };
>+            };
>+
>+            rootfs {
>+                description =3D "SquashFS root filesystem";
>+                data =3D /incbin/("=2E/rootfs=2Esquashfs");
>+                type =3D "filesystem";
>+                arch =3D "arm64";
>+                compression =3D "none";
>+                hash-1 {
>+                    algo =3D "sha256";
>+                };
>+
>+                dm-verity {
>+                    algo =3D "sha256";
>+                    data-block-size =3D <4096>;
>+                    hash-block-size =3D <4096>;
>+                };
>+            };
>+        };
>+
>+        configurations {
>+            default =3D "config-1";
>+            config-1 {
>+                description =3D "Boot with dm-verity rootfs";
>+                kernel =3D "kernel";
>+                fdt =3D "fdt";
>+                loadables =3D "rootfs";
>+            };
>+        };
>+    };
>+
>+With this configuration U-Boot produces a kernel command line similar to=
::
>+
>+    dm-mod=2Ecreate=3D"rootfs,,, ro,0 <data_sectors> verity 1 \
>+        /dev/fit0 /dev/fit0 4096 4096 3762 3762 sha256 \
>+        8e6791637f93cbb81fc45299e203cbe85ca2e47a38f5051bddeece92d7b1c9f9=
 \
>+        aa7b11f8db8fe2e5bfd4eca1d18a22b5de7ea39d2e1b93bb7272ce0c6ca3cc8e=
" \
>+    dm-mod=2Ewaitfor=3D/dev/fit0
>+
>+dm-verity subnode properties
>+----------------------------
>+
>+User-provided properties (required in the ``=2Eits``):
>+
>+=2E=2E list-table::
>+   :header-rows: 1
>+   :widths: 20 15 65
>+
>+   * - Property
>+     - Type
>+     - Description
>+   * - ``algo``
>+     - string
>+     - Hash algorithm name, e=2Eg=2E ``"sha256"``=2E
>+   * - ``data-block-size``
>+     - u32
>+     - Data block size in bytes (>=3D 512, typically 4096)=2E
>+   * - ``hash-block-size``
>+     - u32
>+     - Hash block size in bytes (>=3D 512, typically 4096)=2E
>+
>+Computed properties (filled in by ``mkimage``):
>+
>+=2E=2E list-table::
>+   :header-rows: 1
>+   :widths: 20 15 65
>+
>+   * - Property
>+     - Type
>+     - Description
>+   * - ``num-data-blocks``
>+     - u32
>+     - Number of data blocks in the filesystem image (computed from the
>+       image size and ``data-block-size``)=2E
>+   * - ``hash-start-block``
>+     - u32
>+     - Offset in ``hash-block-size``-sized blocks from the start of the
>+       sub-image to the root block of the hash tree=2E
>+   * - ``digest``
>+     - byte array
>+     - Root hash of the Merkle tree, stored as raw bytes=2E Length must =
match
>+       the output size of ``algo``=2E
>+   * - ``salt``
>+     - byte array
>+     - Salt used when computing the Merkle tree, stored as raw bytes=2E
>+
>+These values are the same ones produced by ``veritysetup format`` and ca=
n
>+typically be obtained from its output=2E
>+The ``digest`` and ``salt`` byte arrays correspond to the hex-encoded
>+``Root hash`` and ``Salt`` printed by ``veritysetup format``=2E
>+
>+Optional boolean properties (when present, they are collected and append=
ed
>+as dm-verity optional parameters with hyphens converted to underscores):
>+
>+=2E=2E list-table::
>+   :header-rows: 1
>+   :widths: 30 70
>+
>+   * - Property
>+     - Description
>+   * - ``restart-on-corruption``
>+     - Restart the system on data corruption=2E
>+   * - ``panic-on-corruption``
>+     - Panic the system on data corruption=2E
>+   * - ``restart-on-error``
>+     - Restart the system on I/O error=2E
>+   * - ``panic-on-error``
>+     - Panic the system on I/O error=2E
>+   * - ``check-at-most-once``
>+     - Verify data blocks only on first read=2E
>+
>+
>+Generating verity metadata
>+--------------------------
>+
>+``mkimage`` automates the entire process=2E When it encounters a
>+``dm-verity`` subnode, it:
>+
>+1=2E Writes the embedded image data to a temporary file=2E
>+2=2E Runs ``veritysetup format`` with the user-supplied algorithm and
>+   block sizes=2E
>+3=2E Parses ``Root hash`` and ``Salt`` from ``veritysetup`` stdout=2E
>+4=2E Reads back the expanded file (original data + Merkle hash tree) and
>+   replaces the image's ``data`` property=2E
>+5=2E Writes the computed ``digest``, ``salt``, ``num-data-blocks``, and
>+   ``hash-start-block`` properties into the ``dm-verity`` subnode=2E
>+
>+Images with ``dm-verity`` subnodes **must** use external data layout
>+(``mkimage -E``)=2E ``mkimage`` will abort with an error if ``-E`` is
>+not specified=2E
>+
>+Usage::
>+
>+    # Create the filesystem image
>+    mksquashfs rootfs/ rootfs=2Esquashfs -comp xz
>+
>+    # Build the FIT (dm-verity is computed automatically)
>+    mkimage -E -f image=2Eits image=2Eitb
>+
>+``veritysetup`` (from the cryptsetup_ package) must be installed on
>+the build host=2E
>+
>+=2E=2E _cryptsetup: https://gitlab=2Ecom/cryptsetup/cryptsetup
>+
>+=2E=2E note::
>+
>+   ``veritysetup format`` is invoked with ``--no-superblock``, so no
>+   on-disk superblock is written between the data and hash regions=2E
>+   The Merkle hash tree is appended directly to the image data within
>+   the FIT external data section=2E  ``hash-start-block`` is therefore
>+   computed as ``data_size / hash-block-size`` (the offset of the hash
>+   region in units of ``hash-block-size``)=2E  When ``data-block-size``
>+   equals ``hash-block-size`` this happens to equal ``num-data-blocks``=
=2E
>+
>+Kconfig
>+-------
>+
>+``CONFIG_FIT_VERITY``
>+  Depends on ``CONFIG_FIT`` and ``CONFIG_OF_LIBFDT``=2E
>+  When enabled, ``fit_verity_build_cmdline()`` and
>+  ``fit_verity_apply_bootargs()`` are compiled into the boot path=2E
>+  When disabled, the functions are static inlines returning 0, so there
>+  is no code-size impact=2E  Works with both the ``bootm`` command and
>+  BOOTSTD boot methods=2E
>diff --git a/doc/usage/fit/index=2Erst b/doc/usage/fit/index=2Erst
>index 6c78d8584ed=2E=2Ed17582b1d64 100644
>--- a/doc/usage/fit/index=2Erst
>+++ b/doc/usage/fit/index=2Erst
>@@ -11,6 +11,7 @@ images that it reads and boots=2E Documentation about F=
IT is available in
>     :maxdepth: 1
>=20
>     beaglebone_vboot
>+    dm-verity
>     howto
>     kernel_fdt
>     kernel_fdts_compressed

