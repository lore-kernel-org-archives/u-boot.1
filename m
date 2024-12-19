Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011F4E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 21:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30F6680326;
	Thu, 19 Dec 2024 22:42:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="JaDzsupl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC9018021D; Thu, 19 Dec 2024 22:42:14 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 205ED8021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 22:42:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 6F541120014;
 Fri, 20 Dec 2024 00:42:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6F541120014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1734644529;
 bh=5N2R+EDEgHmA18NbxJ92hqX+MBsaGdvjs6CQKnLvn1E=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
 b=JaDzsuplHvGSw1/sfrplyRbQ/UHRzGc4kUe4FeZg3KgV/rF+2fpTquqfCl6sk5iTn
 5a8xICClUMsqqqeQxlKnaqtWsa4s52tmxRLIjVfh7iTBT4XYoclL4P/O3vZV4BcUzK
 GSzQdU6X/U851BMEbjzjhZ+OsHdI1esRhE9hR1yWV/Ac2nvUi6W84TnMPV5z1Kf+jG
 5AWEUvmGyHtn1lE+d/PYmoqU0YDx0S29+mrNy7JOmCBY+iOM8xz2Ps5rx63eadPGXZ
 jg4ol42FpuhAIe2S+5RPZFktnqRHPGD+fGjbw9kXtA70BRgQp0tVu+96Jx8mnEuu4F
 NbOzdHPUtkkWA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Fri, 20 Dec 2024 00:42:09 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
Date: Fri, 20 Dec 2024 00:42:08 +0300
Subject: [PATCH 1/3] include/fdt_support: fix docstyle to comply with
 kernel-doc requirements
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241220-board_fdt_chosen_bootargs_improvements-v1-1-f6a7181787c5@salutedevices.com>
References: <20241220-board_fdt_chosen_bootargs_improvements-v1-0-f6a7181787c5@salutedevices.com>
In-Reply-To: <20241220-board_fdt_chosen_bootargs_improvements-v1-0-f6a7181787c5@salutedevices.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Tim Harvey
 <tharvey@gateworks.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>, Sam Protsenko
 <semen.protsenko@linaro.org>, Devarsh Thakkar <devarsht@ti.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, <rockosov@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734644528; l=15978;
 i=ddrokosov@salutedevices.com; s=20241008; h=from:subject:message-id;
 bh=4k1Usn9S1NdWWcRPw9YQJuLfMAlgdf5cwdOsejMOg3E=;
 b=ZEfm0C9p3QUuqhAqKki6rd7Cyn8nSoOn3KvKYrqYKoeaZ/894QIizgDJJNes3hhCDQ4xDcgEe
 mShQLZzfvCkCj4wemsaAeWiOLLZuQ4W+V+zLGmAchVLsVuS/uX/OnRQ
X-Developer-Key: i=ddrokosov@salutedevices.com; a=ed25519;
 pk=J6t8z4aofCVwzR1Xs7royc+IGyQcL0cTby92cz3i8B4=
X-Originating-IP: [172.28.162.51]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189961 [Dec 19 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 49 0.3.49
 28b3b64a43732373258a371bd1554adb2caa23cb,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; smtp.sberdevices.ru:7.1.1,5.0.1;
 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/12/19 19:16:00 #26891781
X-KSMG-AntiVirus-Status: Clean, skipped
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

No errors from kernel-doc with this patch applied:
$ ./scripts/kernel-doc -v -none include/fdt_support.h
    include/fdt_support.h:17: info: Scanning doc for arch_fixup_fdt
    include/fdt_support.h:37: info: Scanning doc for fdt_root
    include/fdt_support.h:48: info: Scanning doc for fdt_chosen
    include/fdt_support.h:59: info: Scanning doc for fdt_initrd
    include/fdt_support.h:100: info: Scanning doc for fdt_fixup_memory
    include/fdt_support.h:115: info: Scanning doc for fdt_fixup_memory_banks
    include/fdt_support.h:148: info: Scanning doc for fdt_fixup_display
    include/fdt_support.h:176: info: Scanning doc for fdt_record_loadable
    include/fdt_support.h:205: info: Scanning doc for ft_board_setup
    include/fdt_support.h:218: info: Scanning doc for board_rng_seed
    include/fdt_support.h:231: info: Scanning doc for board_fdt_chosen_bootargs
    include/fdt_support.h:251: info: Scanning doc for ft_system_setup
    include/fdt_support.h:266: info: Scanning doc for fdt_shrink_to_minimum
    include/fdt_support.h:301: info: Scanning doc for fdt_copy_fixed_partitions
    include/fdt_support.h:314: info: Scanning doc for fdt_translate_address
    include/fdt_support.h:327: info: Scanning doc for fdt_translate_dma_address
    include/fdt_support.h:342: info: Scanning doc for fdt_get_dma_range
    include/fdt_support.h:464: info: Scanning doc for fdt_get_cells_len
    include/fdt_support.h:480: info: Scanning doc for fdtdec_get_child_count
    include/fdt_support.h:500: info: Scanning doc for fdt_kaslrseed

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 include/fdt_support.h | 169 +++++++++++++++++++++++++++++---------------------
 1 file changed, 100 insertions(+), 69 deletions(-)

diff --git a/include/fdt_support.h b/include/fdt_support.h
index 9447a64e060da4c4f6e1c1b509dd477c29e040f4..ed4f5ba26c19b2d0afcc43c46bdee3c211c0441a 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -14,11 +14,12 @@
 #include <abuf.h>
 
 /**
- * arch_fixup_fdt() - Write arch-specific information to fdt
+ * arch_fixup_fdt() - write arch-specific information to fdt
+ *
+ * @blob: FDT blob to write to
  *
  * Defined in arch/$(ARCH)/lib/bootm-fdt.c
  *
- * @blob:	FDT blob to write to
  * Return: 0 if ok, or -ve FDT_ERR_... on failure
  */
 int arch_fixup_fdt(void *blob);
@@ -33,27 +34,33 @@ u32 fdt_getprop_u32_default(const void *fdt, const char *path,
 				const char *prop, const u32 dflt);
 
 /**
- * Add data to the root of the FDT before booting the OS.
+ * fdt_root() - add data to the root of the FDT before booting the OS
+ *
+ * @fdt: FDT address in memory
  *
  * See doc/device-tree-bindings/root.txt
  *
- * @param fdt		FDT address in memory
  * Return: 0 if ok, or -FDT_ERR_... on error
  */
 int fdt_root(void *fdt);
 
 /**
- * Add chosen data the FDT before booting the OS.
+ * fdt_chosen() - add chosen data the FDT before booting the OS
+ *
+ * @fdt: FDT address in memory
  *
  * In particular, this adds the kernel command line (bootargs) to the FDT.
  *
- * @param fdt		FDT address in memory
  * Return: 0 if ok, or -FDT_ERR_... on error
  */
 int fdt_chosen(void *fdt);
 
 /**
- * Add initrd information to the FDT before booting the OS.
+ * fdt_initrd() - add initrd information to the FDT before booting the OS
+ *
+ * @fdt: Pointer to FDT in memory
+ * @initrd_start: Start of ramdisk
+ * @initrd_end: End of ramdisk
  *
  * Adds linux,initrd-start and linux,initrd-end properties to the /chosen node,
  * creating it if necessary.
@@ -63,9 +70,6 @@ int fdt_chosen(void *fdt);
  *
  * If @initrd_start == @initrd_end this function does nothing and returns 0.
  *
- * @fdt: Pointer to FDT in memory
- * @initrd_start: Start of ramdisk
- * @initrd_end: End of ramdisk
  * Return: 0 if ok, or -FDT_ERR_... on error
  */
 int fdt_initrd(void *fdt, ulong initrd_start, ulong initrd_end);
@@ -93,29 +97,35 @@ void do_fixup_by_compat(void *fdt, const char *compat,
 void do_fixup_by_compat_u32(void *fdt, const char *compat,
 			    const char *prop, u32 val, int create);
 /**
+ * fdt_fixup_memory() - setup the memory node in the DT
+ *
+ * @blob: FDT blob to update
+ * @start: Begin of DRAM mapping in physical memory
+ * @size: Size of the single memory bank
+ *
  * Setup the memory node in the DT. Creates one if none was existing before.
  * Calls fdt_fixup_memory_banks() to populate a single reg pair covering the
  * whole memory.
  *
- * @param blob		FDT blob to update
- * @param start		Begin of DRAM mapping in physical memory
- * @param size		Size of the single memory bank
  * Return: 0 if ok, or -1 or -FDT_ERR_... on error
  */
 int fdt_fixup_memory(void *blob, u64 start, u64 size);
 
 /**
+ * fdt_fixup_memory_banks() - fill the DT mem node with multiple memory banks
+ *
+ * @blob: FDT blob to update
+ * @start: Array of size <banks> to hold the start addresses.
+ * @size: Array of size <banks> to hold the size of each region.
+ * @banks: Number of memory banks to create. If 0, the reg property
+ *         will be left untouched.
+ *
  * Fill the DT memory node with multiple memory banks.
  * Creates the node if none was existing before.
  * If banks is 0, it will not touch the existing reg property. This allows
  * boards to not mess with the existing DT setup, which may have been
  * filled in properly before.
  *
- * @param blob		FDT blob to update
- * @param start		Array of size <banks> to hold the start addresses.
- * @param size		Array of size <banks> to hold the size of each region.
- * @param banks		Number of memory banks to create. If 0, the reg
- *			property will be left untouched.
  * Return: 0 if ok, or -1 or -FDT_ERR_... on error
  */
 #ifdef CONFIG_ARCH_FIXUP_FDT_MEMORY
@@ -135,14 +145,17 @@ int fdt_find_and_setprop(void *fdt, const char *node, const char *prop,
 void fdt_fixup_qe_firmware(void *fdt);
 
 /**
+ * fdt_fixup_display() - update native-mode property of display-timings
+ *
+ * @blob: FDT blob to update
+ * @path: path within dt
+ * @display: name of display timing to match
+ *
  * Update native-mode property of display-timings node to the phandle
  * of the timings matching a display by name (case insensitive).
  *
  * see kernel Documentation/devicetree/bindings/video/display-timing.txt
  *
- * @param blob		FDT blob to update
- * @param path		path within dt
- * @param display	name of display timing to match
  * Return: 0 if ok, or -FDT_ERR_... on error
  */
 int fdt_fixup_display(void *blob, const char *path, const char *display);
@@ -160,18 +173,21 @@ static inline void fdt_fixup_crypto_node(void *blob, int sec_rev) {}
 #endif
 
 /**
+ * fdt_record_loadable() - record info about a loadable in /fit-images
+ *
+ * @blob: FDT blob to update
+ * @index: index of this loadable
+ * @name: name of the loadable
+ * @load_addr: address the loadable was loaded to
+ * @size: number of bytes loaded
+ * @entry_point: entry point (if specified, otherwise pass -1)
+ * @type: type (if specified, otherwise pass NULL)
+ * @os: os-type (if specified, otherwise pass NULL)
+ * @arch: architecture (if specified, otherwise pass NULL)
+ *
  * Record information about a processed loadable in /fit-images (creating
  * /fit-images if necessary).
  *
- * @param blob		FDT blob to update
- * @param index	        index of this loadable
- * @param name          name of the loadable
- * @param load_addr     address the loadable was loaded to
- * @param size          number of bytes loaded
- * @param entry_point   entry point (if specified, otherwise pass -1)
- * @param type          type (if specified, otherwise pass NULL)
- * @param os            os-type (if specified, otherwise pass NULL)
- * @param arch		architecture (if specified, otherwise pass NULL)
  * Return: 0 if ok, or -1 or -FDT_ERR_... on error
  */
 int fdt_record_loadable(void *blob, u32 index, const char *name,
@@ -186,37 +202,39 @@ int fdt_pci_dma_ranges(void *blob, int phb_off, struct pci_controller *hose);
 int fdt_find_or_add_subnode(void *fdt, int parentoffset, const char *name);
 
 /**
- * Add board-specific data to the FDT before booting the OS.
+ * ft_board_setup() - add board-specific data to the FDT before booting the OS
+ *
+ * @blob: FDT blob to update
+ * @bd: Pointer to board data
  *
  * Use CONFIG_SYS_FDT_PAD to ensure there is sufficient space.
  * This function is called if CONFIG_OF_BOARD_SETUP is defined
  *
- * @param blob		FDT blob to update
- * @param bd		Pointer to board data
  * Return: 0 if ok, or -FDT_ERR_... on error
  */
 int ft_board_setup(void *blob, struct bd_info *bd);
 
 /**
- * board_rng_seed() - Provide a seed to be passed via /chosen/rng-seed
+ * board_rng_seed() - provide a seed to be passed via /chosen/rng-seed
+ *
+ * @buf: a struct abuf for returning the seed and its size.
  *
  * This function is called if CONFIG_BOARD_RNG_SEED is set, and must
  * be provided by the board. It should return, via @buf, some suitable
  * seed value to pass to the kernel. Seed size could be set in a decimal
  * environment variable rng_seed_size and it defaults to 64 bytes.
  *
- * @param buf         A struct abuf for returning the seed and its size.
- * @return            0 if ok, negative on error.
+ * Return: 0 if ok, negative on error.
  */
 int board_rng_seed(struct abuf *buf);
 
 /**
- * board_fdt_chosen_bootargs() - Arbitrarily amend fdt kernel command line
+ * board_fdt_chosen_bootargs() - arbitrarily amend fdt kernel command line
  *
  * This is used for late modification of kernel command line arguments just
  * before they are added into the /chosen node in flat device tree.
  *
- * @return: pointer to kernel command line arguments in memory
+ * Return: pointer to kernel command line arguments in memory
  */
 char *board_fdt_chosen_bootargs(void);
 
@@ -229,13 +247,14 @@ char *board_fdt_chosen_bootargs(void);
 void ft_board_setup_ex(void *blob, struct bd_info *bd);
 
 /**
- * Add system-specific data to the FDT before booting the OS.
+ * ft_system_setup() - add system-specific data to the FDT before booting the OS
+ *
+ * @blob: FDT blob to update
+ * @bd: pointer to board data
  *
  * Use CONFIG_SYS_FDT_PAD to ensure there is sufficient space.
  * This function is called if CONFIG_OF_SYSTEM_SETUP is defined
  *
- * @param blob		FDT blob to update
- * @param bd		Pointer to board data
  * Return: 0 if ok, or -FDT_ERR_... on error
  */
 int ft_system_setup(void *blob, struct bd_info *bd);
@@ -245,6 +264,9 @@ void set_working_fdt_addr(ulong addr);
 /**
  * fdt_shrink_to_minimum() - shrink FDT while allowing for some margin
  *
+ * @blob: FDT blob to update
+ * @extrasize: additional bytes needed
+ *
  * Shrink down the given blob to 'minimum' size + some extrasize.
  *
  * The new size is enough to hold the existing contents plus @extrasize bytes,
@@ -254,8 +276,6 @@ void set_working_fdt_addr(ulong addr);
  * If there is an existing memory reservation for @blob in the FDT, it is
  * updated for the new size.
  *
- * @param blob		FDT blob to update
- * @param extrasize	additional bytes needed
  * Return: 0 if ok, or -FDT_ERR_... on error
  */
 int fdt_shrink_to_minimum(void *blob, uint extrasize);
@@ -277,9 +297,12 @@ static inline void fdt_fixup_mtdparts(void *fdt,
 #endif
 
 /**
- * copy the fixed-partition nodes from U-Boot device tree to external blob
+ * fdt_copy_fixed_partitions() - copy the fixed-partition nodes
+ *
+ * @blob: FDT blob to update
+ *
+ * Copy the fixed-partition nodes from U-Boot device tree to external blob
  *
- * @param blob		FDT blob to update
  * Return: 0 if ok, or non-zero on error
  */
 int fdt_copy_fixed_partitions(void *blob);
@@ -287,39 +310,45 @@ int fdt_copy_fixed_partitions(void *blob);
 void fdt_del_node_and_alias(void *blob, const char *alias);
 
 /**
- * Translate an address from the DT into a CPU physical address
+ * fdt_translate_address() - translate an addr from the DT into a CPU phys addr
+ *
+ * @blob: pointer to device tree blob
+ * @node_offset: node DT offset
+ * @in_addr: pointer to the address to translate
  *
  * The translation relies on the "ranges" property.
  *
- * @param blob		Pointer to device tree blob
- * @param node_offset	Node DT offset
- * @param in_addr	Pointer to the address to translate
  * Return: translated address or OF_BAD_ADDR on error
  */
 u64 fdt_translate_address(const void *blob, int node_offset,
 			  const __be32 *in_addr);
 /**
- * Translate a DMA address from the DT into a CPU physical address
+ * fdt_translate_dma_address() - translate a DMA address to a CPU phys address
  *
+ * @blob: pointer to device tree blob
+ * @node_offset: node DT offset
+ * @in_addr: pointer to the DMA address to translate
+ *
+ * Translate a DMA address from the DT into a CPU physical address.
  * The translation relies on the "dma-ranges" property.
  *
- * @param blob		Pointer to device tree blob
- * @param node_offset	Node DT offset
- * @param in_addr	Pointer to the DMA address to translate
  * Return: translated DMA address or OF_BAD_ADDR on error
  */
 u64 fdt_translate_dma_address(const void *blob, int node_offset,
 			      const __be32 *in_addr);
 
 /**
+ * fdt_get_dma_range() - get DMA ranges to perform bus/cpu translations
+ *
+ * @blob: pointer to device tree blob
+ * @node_offset: node DT offset
+ * @cpu: pointer to variable storing the range's cpu address
+ * @bus: pointer to variable storing the range's bus address
+ * @size: pointer to variable storing the range's size
+ *
  * Get DMA ranges for a specifc node, this is useful to perform bus->cpu and
  * cpu->bus address translations
  *
- * @param blob		Pointer to device tree blob
- * @param node_offset	Node DT offset
- * @param cpu		Pointer to variable storing the range's cpu address
- * @param bus		Pointer to variable storing the range's bus address
- * @param size		Pointer to variable storing the range's size
  * Return: translated DMA address or OF_BAD_ADDR on error
  */
 int fdt_get_dma_range(const void *blob, int node_offset, phys_addr_t *cpu,
@@ -431,12 +460,12 @@ int fdt_overlay_apply_verbose(void *fdt, void *fdto);
 int fdt_valid(struct fdt_header **blobp);
 
 /**
- * fdt_get_cells_len() - Get the length of a type of cell in top-level nodes
+ * fdt_get_cells_len() - get the length of a type of cell in top-level nodes
  *
- * Returns the length of the cell type in bytes (4 or 8).
+ * @blob: pointer to device tree blob
+ * @nr_cells_name: name to lookup, e.g. "#address-cells"
  *
- * @blob: Pointer to device tree blob
- * @nr_cells_name: Name to lookup, e.g. "#address-cells"
+ * Return: the length of the cell type in bytes (4 or 8).
  */
 int fdt_get_cells_len(const void *blob, char *nr_cells_name);
 
@@ -446,11 +475,12 @@ int fdt_get_cells_len(const void *blob, char *nr_cells_name);
 int fdtdec_get_int(const void *blob, int node, const char *prop_name,
 		int default_val);
 
-/*
- * Count child nodes of one parent node.
+/**
+ * fdtdec_get_child_count() - count child nodes of one parent node
+ *
+ * @blob: FDT blob
+ * @node: parent node
  *
- * @param blob	FDT blob
- * @param node	parent node
  * Return: number of child node; 0 if there is not child node
  */
 int fdtdec_get_child_count(const void *blob, int node);
@@ -468,9 +498,10 @@ void fdt_fixup_pstore(void *blob);
 /**
  * fdt_kaslrseed() - create a 'kaslr-seed' node in chosen
  *
- * @blob:	fdt blob
- * @overwrite:	do not overwrite existing non-zero node unless true
- * Return:	0 if OK, -ve on error
+ * @blob: fdt blob
+ * @overwrite: do not overwrite existing non-zero node unless true
+ *
+ * Return: 0 if OK, -ve on error
  */
 int fdt_kaslrseed(void *blob, bool overwrite);
 

-- 
2.43.0

