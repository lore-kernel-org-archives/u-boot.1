Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9C7C79FA0
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 15:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05F2E606B1;
	Mon,  7 Sep 2026 15:35:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uia7LvkL4DLt; Mon,  7 Sep 2026 15:35:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0C71C60693
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788795313;
	b=Y766zkem+1COU2AvZTfNuTXgzwcSs+hOvGLxI0n0C96ZnEW1dlOLja+Dwh/3JpVftL5r
	 LocPzT6pII9Z9kswrv9sXWHdlVkl1QNPtiYapBllP5S42E8a+z2L6gdWvaN1EA3QHd7gK
	 dWx6do51HBPcmWncCXOGra1GTvgQzVmV3m9wqOXP36v0cj9KDIZH35SbPboqpQs7Wyz8T
	 MdaBHDeuoQSmvZqGGGGvqzdv07zzQ0S0e9gNTl4uOCr2Siz2ksfEzk4SbbjO+AcfTJgzg
	 TIkjzCSzGcqEJVM/FNsUwxaIoO/Uax2eJlAYgIe+OflZfYW9k9pVne1VOQ6Ca07KU9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788795313;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tAFGHK0GLy0ceZhcWmXjUmc9baN78kF5I24SQEMqMZQ=;
	b=YhTAws4r6Z8OFmKElPck5Kf5FEGxG+xpW9tQOrt7p3nG2QH1bnWvDXQN9uCMZWa2CdTI
	 N1Qh//Gl5D47aEA9Vh9E1u9ma07/pvPAAOwrTYxj/objfCgSaz8EFSWndbgfCR3wm+X0W
	 4EqxZhztxpA5mNJYYXrIm7dUgFTchIP0u5iNN4uRH/cgeTFAcw8WR30CRqs+VsWiA5Mtc
	 HzFkTQKH5/ExC5nkubsh1U939DkNAqf3k+cDgKYBPi0SupWoByQVxav9nSobCSa5vkMlG
	 XgpBcmou61LoDL29iSPgDDgZj/ILJMsIuJeY0EzSrFJCBqXtOHBVxQYs8ayh/AnxlPg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788795313;
	bh=tAFGHK0GLy0ceZhcWmXjUmc9baN78kF5I24SQEMqMZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jmFT872PrYDkr+LqaHTOfJQ6yOWP+M7rntfKZPfRNP3N9MAfsylwi079Zwp1AikNk
	 g+uY+9IIVNZRZ8molGzOshSi7V9X4Y3cIeFhH8Oca+Y5/Uzf77D2BAaqpgGC9KmO/z
	 gLDV0Oti0MBzTOepMOaZK4jMzkmgmXxdQJDldfJCZ0h8XhhBN3TiN9VGPiuYc/gUXo
	 GLF88wzNwpzQ2DePcG8nB00ecZ36JCdJySbEkwmmMVkDdto3/G/6ODHEsT8o9wxncb
	 OAxWmq7B1Ta8bEt3i0up9tI4lTAF+G33x2XICPVz1/xPXM9ZYgrvLk5+o/4XgCKLuT
	 L3bRsezh3a4kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C71C60693;
	Mon,  7 Sep 2026 15:35:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F47349D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 855E440103
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:35:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U2JmMTqq36tS for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 15:35:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8CAD64005A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788795310;
 b=YGSJICtIOoDJPBmV18/HZeP/x3Xk2h5grfda19/0Sxwvy4upUYm3oVc88qX9JcAHsISj
 ENeY5IDHybCd/e/oT5wyFvp2HxPqwDcpRNvStsqHQdhFf4l0vJqDEWI7DA5Vn8DcrQhSV
 IY34CcmViwFhfpotzbplRE6BsdwOh6WnIiyiZtoUCzDb1jO8wrNJ6u/PiEF823gszZ8BZ
 DlLLWWJ2qJv+O9chWkrvJgB/LCpO5MR4bRUvjhVJvXk51odSoip+DiaMIyF9bCEUhwMGi
 5e9tmvKvbAPaQ6iy/LsiYc/9uYT4z87uugLjyISHjSuMM3DKmc18q4nFXfJRGGJDUNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788795310;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=tAFGHK0GLy0ceZhcWmXjUmc9baN78kF5I24SQEMqMZQ=;
 b=ZRwa6yaVV2v0/sZUso8J+KFHTIKnWMEz70FDkwdBCq8FYAskGHH1jb9BVa5IXyFokHU9
 KRu0diUTzGvezPKc3i1+Q6H/XsghC8ANAMc4t3hkZDS/cCcZWtSddoU1+91WslOX8H7qp
 BaMF+5n0G42GNoXf7tsWJEY8rYft3lY96cKzZnJHtv+AqOsUeuMz+7dpn8+ZI5UGfKRGy
 l5YgAB0E8F86ZL92Dqa5/DKE91sByKTOgo6LPxMvmvOoD8RoAV/cAktpHhNkIfRlMhV7s
 O4TyCM8KOqirYyx0cOq9Gr15OGoQHiIz1KbKQBpNLGiCGyzksPF8SCcMI7A6slbqwtQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=oJwCaO9t; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=oJwCaO9t
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8CAD64005A
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id E72CEB00571;
 Mon,  7 Sep 2026 17:34:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1788795308;
 bh=12TCbCRewN1Bj4hILs4xzIGaDRwGng9VOv5P3Gc/EQA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oJwCaO9t3o0Zg0Xe1N5pDVz5w9GI2s4fm1XWVhc87NiMpkM2oOpjopI2lAfrBGU+4
 4zgRpEKHYMGbWKPyPS5DJFsYJCGvG6Vc26/RxtEnzVn6qWKgzlHXHhon1wMY5m4pnK
 ZbprWar3C7I2P2HA1PCTGQm7FdYon6axNjJ7DgpByH96qBq4nIXgrQt32Qmk+VUNEq
 wVh925zCrKHWBV3z4aw0OM2JWlHeS9a8U6mhP3zH4hz7UqEOxERjwrQC4BKKBR33+N
 uqT7fjhC+kJBWWE9q2Tf7gbmoJpSxOky0qlQt7X7hAgRCnF0yX7PrnxQmRpSHOF+uf
 WAI0fVA6PLOfg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Simon Glass <sjg@chromium.org>, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 2/8] doc: board: nxp: add the Nodebox v3 CPU Module
Date: Mon,  7 Sep 2026 17:34:04 +0200
Message-ID: <20260907153411.2207773-3-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907153411.2207773-1-vjardin@free.fr>
References: <20260907153411.2207773-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Document the Free Mobile Nodebox v3 CPU Module

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

(no changes since v1)

 doc/board/nxp/index.rst |   1 +
 doc/board/nxp/nbxv3.rst | 212 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 213 insertions(+)
 create mode 100644 doc/board/nxp/nbxv3.rst

diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index b28e5b6ceb9..125df6e86de 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -29,6 +29,7 @@ NXP Semiconductors
    mx6sabresd
    mx6ul_14x14_evk
    mx6ullevk
+   nbxv3
    rproc
    psb
    quickboot
diff --git a/doc/board/nxp/nbxv3.rst b/doc/board/nxp/nbxv3.rst
new file mode 100644
index 00000000000..98d5cf9e17d
--- /dev/null
+++ b/doc/board/nxp/nbxv3.rst
@@ -0,0 +1,212 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Free Mobile Nodebox v3 CPU Module (nbxv3)
+=========================================
+
+The Nodebox v3 CPU Module is an NXP LX2160A based board.
+The module plugs onto several carrier boards (NBV30, NBV32, ...) which share
+one kernel image but differ in their device tree and DPAA2 data path
+configuration.
+
+The U-Boot port is for the CPU module that handles those carriers.
+It lives next to the LX2160ARDB/QDS boards under
+``board/nxp/lx2160a/`` (``TARGET_NBXV3``, ``configs/nbxv3_tfa_defconfig``)
+and reuses their SoC level code.
+The board specific behaviour is wired
+through ``EVENT_SPY`` hooks in ``board/nxp/lx2160a/nbxv3/`` and the
+dependencies each hook needs are forced on by hidden ``default y`` Kconfig
+bools under ``if TARGET_NBXV3`` in ``board/nxp/lx2160a/Kconfig``.
+
+LX2160A SoC overview
+--------------------
+
+Please refer to arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc for the
+LX2160A SoC overview.
+
+CPU Module overview
+-------------------
+
+- Boot: TF-A (BL2 trains the DDR, BL31 hands over) then U-Boot as the
+  BL33 payload, from a single FlexSPI NOR.
+- DDR: two DDR4 SODIMMs with JC42 SPD temperature sensors.
+- Storage: on module eMMC on eSDHC2.
+- Ethernet: DPMAC17 through RGMII1 to a Realtek RTL8211FD-CG
+  (management port, ``lanconsole0``), the LX2160A management complex
+  (MC) drives the DPAA2 data path.
+- PCIe: PCIE3..PCIE6 root complexes routed to the carrier connector.
+- USB: xHCI host controllers.
+- I2C: IIC1 on module management bus, IIC2..IIC4 and IIC6 to the carrier
+- SPI: DSPI1 on module management SPI (ZL30733 DPLL), DSPI3 to the
+  carrier.
+- Power: MPS MPQ8785 PMBus regulator on the +0V8_VDD core rail, per die
+  VID fuse voltage trim.
+- Watchdog: SBSA generic watchdog, updated to 120 s timeout default.
+
+Boot NOR layout
+---------------
+
+The layout is shared with TF-A and the flash assembler:
+
+============ ==========================================
+Offset       Content
+============ ==========================================
+0x000000     PBL (RCW + PBI + XIP BL2)
+0x100000     FIP (BL31 + BL33 U-Boot)
+0x500000     U-Boot environment
+0x800000     DDR PHY firmware FIP
+0x1000000    Kernel FIT
+0x2000000    free
+============ ==========================================
+
+The environment is stored in the boot NOR.
+SPI bus aliases at the prompt:
+``spi0`` = DSPI1
+``spi2`` = DSPI3
+``spi3`` = FlexSPI (boot NOR)
+so the boot NOR is always ``sf probe 3:0``.
+
+Kernel FIT
+----------
+
+The kernel and the LX2160A management complex artefacts ship as a single
+FIT image at NOR offset 0x1000000::
+
+  /images/kernel        Linux Image (zstd compressed)
+  /images/fdt-<carrier> Linux DTB, one per carrier
+  /images/ramdisk       initramfs cpio (optional)
+  /images/mc            MC firmware blob        (loaded at 0xa8000000)
+  /images/dpc-<carrier> Data Path Container     (loaded at 0xa9000000)
+  /images/dpl-<carrier> Data Path Layout        (loaded at 0xaa000000)
+  /configurations/conf-<carrier>
+
+``${carrier}`` selects the carrier set (``conf-<carrier>``, ``dpc-``,
+``dpl-``). It is set on every boot. For debug, to enforce another carrier::
+
+  => setenv carrier nbv32 && saveenv && reset
+
+Boot flow
+---------
+
+It follows the same than any lx2160 board.
+
+``mcinitcmd`` runs automatically at ``initr_net`` through the shared
+``mc_env_boot()`` hook: it reads the FIT from the boot NOR, extracts MC,
+DPC and DPL to DDR, starts the MC and queues the DPL with
+``fsl_mc lazyapply``. By the time U-Boot prints its
+prompt the DPMACs are live and ``ldpaa_eth`` has bound ``lanconsole0``, so
+``ping`` / ``dhcp`` / ``tftp`` work immediately. At ``bootm`` time the
+queued DPL is applied and the kernel boots with the full topology.
+
+``bootcmd`` is ``run mc_init || run provision_openocd_fit``: a module
+whose FIT slot is blank or corrupted falls through to the semihosting
+provisioning path.
+
+Environment variables
+---------------------
+
+========================== ==================================================
+Variable                   Purpose
+========================== ==================================================
+mcinitcmd                  Load the FIT, start the MC, queue the DPL
+                           (auto-run at initr_net). Set it empty
+                           (``setenv mcinitcmd``) and ``saveenv`` to opt out
+                           of the automatic MC bring-up, e.g. while the FIT
+                           slot is intentionally blank.
+mc_init                    ``bootm ${kernel_addr_r}#conf-${carrier}`` of the
+                           FIT already loaded by ``mcinitcmd``.
+linux_boot_fit             Read the FIT from NOR and boot it; assumes the
+                           MC is already running.
+host_boot                  Load the FIT over ARM semihosting (JTAG probe)
+                           and boot it. Mainly for bench iteration.
+provision_openocd_fit      Load the FIT over semihosting, erase the FIT
+                           slot, write it, reset. Recovers a module with a
+                           blank or corrupted FIT slot.
+xspi_bootcmd               Copy the FIT from the AHB mapped FlexSPI window
+                           (0x21000000) with ``cp.b`` and boot it. Fallback
+                           when the ``sf`` driver state is suspect.
+mcmemsize                  MC private RAM carve out at the top of DDR,
+                           0x70000000 (1.75 GiB).
+kernel_addr_r              DDR load address of the FIT (0xc0000000).
+fit_nor_offset             Offset (0x1000000) and size cap (0x1000000, 16 MiB)
+fit_nor_size               of the kernel FIT slot in the boot NOR, used by
+                           every macro that reads or writes the FIT.
+carrier                    Carrier selection, see above.
+ethprime                   ``lanconsole0`` (CONFIG_ETHPRIME): the RGMII
+                           management port is the default device for
+                           ``dhcp`` / ``tftp`` / ``ping``.
+nbxv3_vdd_mv               Millivolt integer in [600, 1100]: bypass the
+                           VID fuse and pin the +0V8_VDD core rail at that
+                           voltage. Unset = follow the fuse.
+pci_iommu_extra            Hotplug entries for the PCIe endpoints
+                           (1.0.0 behind each root complex)
+mdio_list                  ``mdio list`` with a banner, run from
+                           ``preboot``, so the boot log shows which PHY
+                           drivers bound.
+PS1 / ps_refresh           Interactive prompt (``nbxv3> ``); ``ps_refresh``
+                           rebakes PS1 from ``${ethact}`` and ``${ipaddr}``
+                           (run from ``preboot``, and by hand after ``dhcp``).
+preboot                    ``run mdio_list ; run ps_refresh``.
+========================== ==================================================
+
+Commands
+--------
+
+Board specific:
+
+- ``dpll_info``: re-run the DPLL identification probe (ZL30733 on
+  ``spi0:0``, ZL30643 on ``spi2:1``); a DPLL whose bus is not described
+  is reported "not reachable".
+
+Tree commands the board relies on:
+
+- ``pmbus telemetry`` / ``pmbus status`` / ``pmbus mps last``: the MPQ8785
+  core regulator is pre-selected at boot, no ``pmbus dev`` needed.
+- ``regulator list`` / ``regulator info +0V8_VDD`` / ``regulator value``
+- ``temperature list`` / ``temperature get``
+- ``i2c bus`` / ``i2c probe``
+- ``mdio list`` / ``mii info``
+- ``gpio status``
+- ``sf`` (boot NOR, ``sf probe 3:0``), ``mmc`` (eMMC), ``pci``, ``usb``,
+  ``eeprom`` (board ID EEPROM at 0x52), ``wdt``, ``rng``, ``dm tree``.
+
+Boot log
+--------
+
+The board hooks print one banner each before the prompt::
+
+  Carrier:       nbv30 (default, not saved - `setenv carrier <name> ...)
+  MPQ8785 @ i2c0:0x10  MFR_ID="MPS" ...
+    +0V8_VDD: VOUT=... uV  enabled=1
+  MPQ8785 (+0V8_VDD): VID handoff fuse=0x.. target=... mV ...
+  DPLL: ZL30733 @ spi0:0  info=0xa1 (EEPROM boot) id=0x0e95 rev=0x03
+  DPLL: ZL30643 spi2:1 not reachable (...)
+  === Nbxv3 probed PHYs ===
+  ...
+  nbxv3 lanconsole0 192.168.x.y>
+
+Building
+--------
+
+.. code-block:: bash
+
+  $ make nbxv3_tfa_defconfig
+  $ make CROSS_COMPILE=aarch64-linux-gnu-
+
+``u-boot.bin`` is the BL33 payload packaged in the TF-A FIP at NOR
+offset 0x100000.
+
+When ``${carrier}`` is not in the environment the board falls back to the
+compile time ``NBXV3_CARRIER_DEFAULT``, which defaults to ``nbv30``. To
+build a U-Boot whose fallback is the NBV32 carrier instead::
+
+  $ make CROSS_COMPILE=aarch64-linux-gnu- \
+         KCPPFLAGS='-DNBXV3_CARRIER_DEFAULT=\"nbv32\"'
+
+Provisioning a blank module over JTAG
+-------------------------------------
+
+With a debugger attached and semihosting enabled on the host, a module
+with an empty FIT slot boots to the prompt and ``bootcmd`` runs
+``provision_openocd_fit``, which loads ``fit.itb`` from the host
+directory over semihosting, writes it to NOR offset 0x1000000 and
+resets. ``host_boot`` boots a FIT from the host without writing it.
-- 
2.43.0

