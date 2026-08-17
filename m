Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F047C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:32:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 661B1406E5;
	Mon, 17 Aug 2026 15:32:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lciQ5DfCjkKs; Mon, 17 Aug 2026 15:32:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2781B40715
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786980762;
	bh=M5owiKbTWY3aHbVmvqANKI3mw/2KBjqMgoLmqbos6a4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qu+NyTro/aJ1OcY8kpXSTXaNFDtJ1jhHqaMFA9+EtMD5ds30xfd6qbS3HkT+bQZBd
	 nFDNSdmBLaf7/dxeAD3mZVxfq4ULFmB+WFzk1SFs+WE0cWxW2R2sl6XNllD/RPIl+o
	 s7ZJHH+OPxQvZghZQOoRVHtq9n71OM7exDMZieUKYaVRFPG7s7NhxP0teCc72RDwZY
	 k8BFtZWbdV9IeqezB1MAwv3NSkUVL9EyxXZlD7u5xrSofX6lnJ06aKhbO4GXrNsbyS
	 SWKtT32v4NWn9fG1yPxcVVR7bskZAbK9XuCvoyUtSSoGOTuWybxSB1BxyL21RfbQzq
	 UAjwwgRcLTudw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2781B40715;
	Mon, 17 Aug 2026 15:32:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A91723F
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:32:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C6356078F
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:32:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7XsegJdzwtBa for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:32:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 521D66072A
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 521D66072A
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=JzD0eV8d
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 521D66072A
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:32:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 5560AB00548;
 Mon, 17 Aug 2026 17:32:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786980757;
 bh=PMwUYaLT4nY2qcxkOLq0JgnCoF6IMG6aBiKNXOjqZ3c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JzD0eV8d1FHo4/22aSeA1OB+5BPyZfvhNLDnyJIoBc+57i7G0jTkocvHDB2ZY3XjK
 2Ud8hbIqKbomohJSLRebAPdRCCWgjFKcxQ8a/tvTXx3NTAhFyIrTYuqWQBeUpedKdY
 4MzNmNdG71ori49Qw0njLUOb+m5hlpYFGRjbbtdEtSf/NZcQveOWjW4Bbd0ZF9u9VZ
 JKGy3dbFtxeLgJYFbHWrQJYF7Wf/m5KB2MPUO7RzzAbTPaST7FhVroO0QJuMWM4/xc
 Vn71kyvDd/oc8crtOyPy9vYO+9KHO/8K4eWJlOb4OjqQltzhgdA4Uo8OFLIp5qSrp4
 BSu9t3jqLu4hg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 02/23] doc: board: nxp: add the Nodebox v3 CPU Module
 (nbxv3)
Date: Mon, 17 Aug 2026 17:31:20 +0200
Message-ID: <20260817153144.1951036-3-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817153144.1951036-1-vjardin@free.fr>
References: <20260817153144.1951036-1-vjardin@free.fr>
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Document the Free Mobile Nodebox v3 CPU Module: how the port is laid
out next to the LX2160ARDB / QDS boards, the module overview, the boot
NOR layout, the kernel FIT that carries the management complex
artefacts per carrier, the boot flow (mcinitcmd at initr_net, lazy DPL
apply, provisioning over JTAG semihosting) and the environment
variables an operator is expected to touch (carrier, mcmemsize,
nbxv3_vdd_mv, the fsl_bootcmd_mcinitcmd_set sentinel).

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 board/nxp/lx2160a/MAINTAINERS |   1 +
 doc/board/nxp/index.rst       |   1 +
 doc/board/nxp/nbxv3.rst       | 255 ++++++++++++++++++++++++++++++++++
 3 files changed, 257 insertions(+)
 create mode 100644 doc/board/nxp/nbxv3.rst

diff --git a/board/nxp/lx2160a/MAINTAINERS b/board/nxp/lx2160a/MAINTAINERS
index 6f78e6e45d1..64e48823dfe 100644
--- a/board/nxp/lx2160a/MAINTAINERS
+++ b/board/nxp/lx2160a/MAINTAINERS
@@ -61,3 +61,4 @@ F:	board/nxp/lx2160a/nbxv3/
 F:	include/configs/nbxv3.h
 F:	configs/nbxv3_tfa_defconfig
 F:	arch/arm/dts/fsl-lx2160a-nbxv3.dts
+F:	doc/board/nxp/nbxv3.rst
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
index 00000000000..2c27ada7165
--- /dev/null
+++ b/doc/board/nxp/nbxv3.rst
@@ -0,0 +1,255 @@
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
+The U-Boot port lives next to the LX2160ARDB/QDS boards under
+``board/nxp/lx2160a/`` (``TARGET_NBXV3``, ``configs/nbxv3_tfa_defconfig``)
+and reuses their SoC level code. Board specific behaviour is wired
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
+Module overview
+---------------
+
+- Boot: TF-A (BL2 trains the DDR, BL31 hands over) then U-Boot as the
+  BL33 payload, from a single FlexSPI NOR.
+- DDR: two DDR4 SODIMMs with JC42 SPD temperature sensors.
+- Storage: on module eMMC on eSDHC2.
+- Ethernet: DPMAC17 through RGMII1 to a Realtek RTL8211FD-CG
+  (management port, ``lanconsole0``); the LX2160A management complex
+  (MC) drives the DPAA2 data path.
+- PCIe: PCIE3..PCIE6 root complexes routed to the carrier connector.
+- USB: two xHCI host controllers.
+- I2C: IIC1 on module management bus, IIC2..IIC4 and IIC6 to the carrier
+- SPI: DSPI1 on module management SPI (ZL30733 DPLL), DSPI3 to the
+  carrier.
+- Power: MPS MPQ8785 PMBus regulator on the +0V8_VDD core rail, per die
+  VID fuse voltage trim.
+- Watchdog: SBSA generic watchdog, 120 s timeout default.
+
+Boot NOR layout
+---------------
+
+The layout is shared with TF-A and the flash assembler:
+
+============ ========================================== ==========
+Offset       Content                                    Size cap
+============ ========================================== ==========
+0x000000     PBL (RCW + PBI + XIP BL2)                  1 MiB
+0x100000     FIP (BL31 + BL33 U-Boot)                   4 MiB
+0x500000     U-Boot environment                         64 KiB
+0x800000     DDR PHY firmware FIP                       1 MiB
+0x1000000    Kernel FIT                                 16 MiB
+0x2000000    free                                       224 MiB
+============ ========================================== ==========
+
+The environment is stored in the boot NOR (``ENV_IS_IN_SPI_FLASH`` on
+SPI bus 3, the ``spi3 = &fspi`` alias). SPI bus aliases at the prompt:
+``spi0`` = DSPI1 (module management),
+``spi2`` = DSPI3 (carrier),
+``spi3`` = FlexSPI (boot NOR),
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
+``dpl-``). It is set on every boot by ``board/nxp/lx2160a/nbxv3/carrier.c``
+from the compile time ``NBXV3_CARRIER_DEFAULT`` when the environment does
+not define it, and is deliberately not saved. To pin another carrier::
+
+  => setenv carrier nbv32 && saveenv && reset
+
+Boot flow
+---------
+
+``mcinitcmd`` runs automatically at ``initr_net`` through the shared
+``mc_env_boot()`` hook: it reads the FIT from the boot NOR, extracts MC,
+DPC and DPL to DDR, starts the MC and queues the DPL with
+``fsl_mc lazyapply``. By the time U-Boot prints its
+prompt the DPMACs are live and ``ldpaa_eth`` has bound ``lanconsole0``, so
+``ping`` / ``dhcp`` / ``tftp`` work immediately. At ``bootm`` time the
+queued DPL is applied and the kernel boots with the full topology.
+
+``lazyapply`` (not ``apply``) is mandatory: an eager apply puts the MC in
+the "deployed" state and the ``ldpaa_eth`` probe fails with
+"DPL is deployed. No device available".
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
+                           0x70000000 (1.75 GiB). The 256 MiB platform
+                           default is too small for the full DPAA2 surface
+                           of this module: the MC crashes in ``global_init``
+                           at QBMAN portal allocation ("MAJOR mem. manager
+                           memory allocation failed"). Override with
+                           ``setenv mcmemsize`` (256 MiB minimum).
+fsl_bootcmd_mcinitcmd_set  Sentinel read by the shared fsl-layerscape
+                           ``board_late_init()``. Without it ``bootcmd`` and
+                           ``mcinitcmd`` are overwritten with the LX2160ARDB
+                           defaults (``sf probe 0:0``, raw blobs at the RDB
+                           offsets), which do not match this board. Leave
+                           it set.
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
+                           (1.0.0 behind each root complex): they train
+                           only after Linux releases PERST#, so their
+                           streamID LUT and msi-map / iommu-map are
+                           pre-provisioned. See README.pci_iommu_extra
+                           in arch/arm/cpu/armv8/fsl-layerscape/doc/.
+mdio_list                  ``mdio list`` with a banner, run from
+                           ``preboot``, so the boot log shows which PHY
+                           drivers bound.
+PS1 / ps_refresh           Interactive prompt (``nbxv3> ``); ``ps_refresh``
+                           rebakes PS1 from ``${ethact}`` and ``${ipaddr}``
+                           (run from ``preboot``, and by hand after ``dhcp``).
+preboot                    ``run mdio_list ; run ps_refresh``.
+========================== ==================================================
+
+All ``bootm`` invocations select the carrier configuration explicitly
+with ``#conf-${carrier}``; without the suffix ``bootm`` uses the FIT's
+default configuration, which is whatever carrier the FIT was built for.
+
+Boot time board hooks
+---------------------
+
+At ``EVT_LAST_STAGE_INIT`` the board prints a status of the MPQ8785
+core regulator (``pmbus`` command ready without ``pmbus dev``), a
+telemetry status of the PMBus PSU bricks bound to the generic PMBus
+regulator driver, applies the VID fuse voltage trim to the +0V8_VDD
+rail, probes the ZL30733 / ZL30643 DPLL identification registers
+(``dpll_info`` re-runs it) and enables the +3V3_FAN rail. Each hook
+returns silently when its device is not described.
+
+The ``u-boot,nickname`` device tree property renames the DPAA2 Ethernet
+devices to role based names (``lanconsole0``, ...) through an
+``EVT_DM_PRE_PROBE`` spy.
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
+- ``regulator list`` / ``regulator info +0V8_VDD`` / ``regulator value``:
+  the UCLASS_REGULATOR view of the same chip. Do not
+  ``regulator disable +0V8_VDD``: U-Boot's regulator uclass does not
+  enforce ``regulator-always-on`` on the disable path and this is the
+  SoC core rail.
+- ``temperature list`` / ``temperature get``: JC42 DIMM sensors
+  (``ddr-top``, ``ddr-bottom``), the QorIQ TMU and the MPQ8785 die.
+- ``i2c bus`` / ``i2c probe``: the on module buses and the IIC6 carrier
+  mux tree (each PCA9548 channel is its own bus number).
+- ``mdio list`` / ``mii info``: the RTL8211FD on ``emdio1``.
+- ``gpio status``: the SoC GPIO controllers with their line names; the
+  gpio-hog children are applied at GPIO probe.
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

