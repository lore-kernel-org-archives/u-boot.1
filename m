Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11427FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 18:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A7A38467B;
	Mon,  4 May 2026 20:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ajtw8oVo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3BE0846F0; Mon,  4 May 2026 20:58:02 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4111E8467F
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 20:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so645533f8f.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 11:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777921079; x=1778525879; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hpXKglQlM+HKBITV6Gur5s0TY2oSDyJ142sCl+1ZVOE=;
 b=ajtw8oVod+Vkd1VcZdYB/MhjsFnkOy83As+TYZF53sswUmvPbFfTCB6Zpxkr2DYtt6
 ls2sxH34/IK8WNK2brTDcCCll5HDn7BuDvojam4yIbqNGqRcSmzcKCwPcdMcnb5KaTE5
 P0TmUf5sqXOOdcpfUMfa3ED4t0wLk8Z/e5bgmR1QgZ3sCtX7QVTNbYCSn7cnfyQ+duRy
 hwPchs+0zonx8xDXdlpIM/17y9BgO6RiwDbJ71sibsFfz3Ea8aziHwA1JjbTyDWcawSO
 Og7T2P3IHlEiu1NFwlUHDDoVr05GHMlF8VrCAWvOIDGgjU8j/LOCGLho4wD3VHnx4xhf
 PQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921079; x=1778525879;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hpXKglQlM+HKBITV6Gur5s0TY2oSDyJ142sCl+1ZVOE=;
 b=hYzGQ2XCW0ChWK6xmWAVfxptRcuENxB9aNyOzGGXY2owmXOu6F5bhNuJctdp+XXdGB
 X6zRQN99Q1Gu18MHliDZQWiKPk7NItEWZYchnHrEqhS5xQXSNCvjwG3JCBnleeLxKQCn
 xcGvaj9reFUWye3GJCkKyEBNx05b7Uy41PJSYSx2phLBzflUKgb1F+d/fhBxU0NOeMrN
 QlbeZLbfeMYJdsg1kRVIx3xUgOuE1UTyP5N8ZiOuaiq8y+MoUoKLYKe1MW6PWhCMP3/k
 SCxmsQTsicAS44aNao58hOZOZijqnxo62FEvX3a6UdpfG+pZlJgm9N48PDlyoRMiFZby
 uZ8g==
X-Gm-Message-State: AOJu0YzpXJpNBZi4QSZXPhpJhLqtnBZmZC067cf1rsmasTiHAOJSB+tU
 uNLC16PfWDARGVKR6Yuxxm+Ewgg8+HDYHGo5iKoRW6D+D6l9icalAl3rXxP5c5k4+KM=
X-Gm-Gg: AeBDiesCmzE6VORXxzDViVwYZ793zb5maJgKNujpwsS36DxCLqTWUSKbKuTMCB2oGSF
 wilkCdnIfVN6xI54t86yki2m0Cnzv9x6VeYLxehtHyD+TfG/Wq8aohIjMaZV9j5/sq+pCMwQmK5
 l1+uq7ByclddpeGoQUrKYmTikFJcaw2duAEz6IWe+APoytKsAKMtnhIiZWUivEAcNGp6MdBoCij
 VUAn6jYMJEDDLuLXnPSHy4isXFkZSp0eroG997iSEGl6W5qxfCZ3P5tGTc+EtOenITxfW+sBGxT
 2JLF9g13i/1Ba8L6g88eYa9iUwjASrRK+FZsGKufbOXtXmA+/ZRUZmMHemSmASqaL2v9A9d9zUT
 vNAN/Oh3Jmmio8intJo+XdL+5OVpi7RnQQQjFxllDLiv3WjfICBmFSVlRcZMzpyy9KqQvGDKeBF
 9EeEaad3AklhhgXkylkBd6fqo3+8z/GVaCzLE9Eb3MEpcxFNYtDoKvm9JZxF0ZxTPFrAdBHYdkp
 7mFuSSwikfXhNBQiA==
X-Received: by 2002:a05:6000:3108:b0:43d:75ec:26e7 with SMTP id
 ffacd0b85a97d-4500623ffacmr191260f8f.33.1777921078526; 
 Mon, 04 May 2026 11:57:58 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4500f9c2cd5sm2861f8f.23.2026.05.04.11.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 11:57:58 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 04 May 2026 20:57:41 +0200
Subject: [PATCH v2 13/15] mach-snapdragon: support parsing memory map from SMEM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-b4-modernise-smem-v2-13-c01ec2ff3886@linaro.org>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
In-Reply-To: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=22061;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=OWV/THyVx4fmUueNYzLjBl2TjR5rB7sqm6fP2t9wZw8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhswfb+Qnn8m5cdlRvuaxza0J5z3sPhz8buNn8/jJFtE9l
 7irMj9v7yhlYRDkYJAVU2QRP7HMsmntZXuN7QsuwMxhZQIZwsDFKQATcRZi+MMr4Cj65Hn5LEGT
 S4eKf9w+sfHE+VXXljvvtjNe2r82oX8Xw39H8VuCJy7+e39rfq3si7NtzEI1xvuumE65vHQHs6N
 K64S1AA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

It is possible to derive the memory map for a Qualcomm platform from the
SMEM shared memory region. The memory map is populated by the preloader.

Introduce support for parsing this data and using it to populate
U-Boot's memory map. Since we aren't yet sure if this will work for
every platform, it is not yet used in all cases, if U-Boot is booted
with an internal FDT which has the memory map defined, this will
be used instead.

If the FDT is internal FDT with no memory map defined, then U-Boot will
try to use SMEM. This should remove the need to define the memory map
statically in a U-Boot overlay for boards that don't chainload.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/Kconfig                     |   1 +
 arch/arm/mach-snapdragon/board.c     |  45 +++++---
 arch/arm/mach-snapdragon/dram.c      | 172 +++++++++++++++++++++++++------
 arch/arm/mach-snapdragon/qcom-priv.h |  17 ++-
 arch/arm/mach-snapdragon/rampart.h   | 194 +++++++++++++++++++++++++++++++++++
 5 files changed, 386 insertions(+), 43 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a8fcfe76296c..1da0677d85b3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1140,8 +1140,9 @@ config ARCH_SNAPDRAGON
 	select DM_RESET
 	select POWER_DOMAIN
 	select GPIO_EXTRA_HEADER
 	select OF_CONTROL
+	select QCOM_SMEM
 	select SPMI
 	select BOARD_LATE_INIT
 	select OF_BOARD
 	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index a2d97ad77910..7610891191fd 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -29,16 +29,18 @@
 #include <lmb.h>
 #include <malloc.h>
 #include <fdt_support.h>
 #include <usb.h>
+#include <soc/qcom/smem.h>
 #include <sort.h>
 #include <time.h>
 
 #include "qcom-priv.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
 enum qcom_boot_source qcom_boot_source __section(".data") = 0;
+enum qcom_memmap_source qcom_memmap_source __section(".data") = 0;
 
 static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
 
 struct mm_region *mem_map = rbx_mem_map;
@@ -109,18 +111,18 @@ int board_fdt_blob_setup(void **fdtp)
 		      (phys_addr_t)external_fdt);
 
 	/* Prefer memory information from internal DT if it's present */
 	if (internal_valid)
-		ret = qcom_parse_memory(internal_fdt);
+		ret = qcom_parse_memory(internal_fdt, true);
 
 	if (ret < 0 && external_valid) {
 		/* No internal FDT or it lacks a proper /memory node.
 		 * The previous bootloader handed us something, let's try that.
 		 */
 		if (internal_valid)
 			debug("No memory info in internal FDT, falling back to external\n");
 
-		ret = qcom_parse_memory(external_fdt);
+		ret = qcom_parse_memory(external_fdt, false);
 	}
 
 	if (ret < 0)
 		panic("No valid memory ranges found!\n");
@@ -373,23 +375,39 @@ static void configure_env(void)
 
 	qcom_set_serialno();
 }
 
-void qcom_show_boot_source(void)
+static void qcom_show_boot_context(void)
 {
-	const char *name = "UNKNOWN";
+	const char *boot_source = "UNKNOWN";
+	const char *memmap_source = "UNKNOWN";
 
 	switch (qcom_boot_source) {
 	case QCOM_BOOT_SOURCE_ANDROID:
-		name = "ABL";
+		boot_source = "ABL";
 		break;
 	case QCOM_BOOT_SOURCE_XBL:
-		name = "XBL";
+		boot_source = "XBL";
 		break;
 	}
 
-	log_info("U-Boot loaded from %s\n", name);
-	env_set("boot_source", name);
+	log_info("U-Boot loaded from %s\n", boot_source);
+	env_set("boot_source", boot_source);
+
+	switch (qcom_memmap_source) {
+	case QCOM_MEMMAP_SOURCE_INTERNAL_FDT:
+		memmap_source = "INTERNAL_FDT";
+		break;
+	case QCOM_MEMMAP_SOURCE_EXTERNAL_FDT:
+		memmap_source = "EXTERNAL_FDT";
+		break;
+	case QCOM_MEMMAP_SOURCE_SMEM:
+		memmap_source = "SMEM";
+		break;
+	}
+
+	log_info("Memory map loaded from %s\n", memmap_source);
+	env_set("memmap_source", memmap_source);
 }
 
 void __weak qcom_late_init(void)
 {
@@ -458,9 +476,9 @@ int board_late_init(void)
 
 	configure_env();
 	qcom_late_init();
 
-	qcom_show_boot_source();
+	qcom_show_boot_context();
 	/* Configure the dfu_string for capsule updates */
 	qcom_configure_capsule_updates();
 
 	return 0;
@@ -648,11 +666,14 @@ void enable_caches(void)
 	gd->arch.tlb_emerg = gd->arch.tlb_addr;
 	gd->arch.tlb_addr = tlb_addr;
 	gd->arch.tlb_size = tlb_size;
 
-	/* On some boards speculative access may trigger a NOC or XPU violation so explicitly mark reserved
-	 * regions as inacessible (PTE_TYPE_FAULT) */
-	if (fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") == 0) {
+	/*
+	 * On some boards speculative access may trigger a NOC or XPU violation so explicitly mark
+	 * reserved regions as inacessible (PTE_TYPE_FAULT)
+	 */
+	if (qcom_memmap_source == QCOM_MEMMAP_SOURCE_SMEM ||
+	    fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") == 0) {
 		carveout_start = get_timer(0);
 		/* Takes ~20-50ms on SDM845 */
 		configure_reserved_memory();
 		debug("carveout time: %lums\n", get_timer(carveout_start));
diff --git a/arch/arm/mach-snapdragon/dram.c b/arch/arm/mach-snapdragon/dram.c
index ad73b685a935..af5f3c84882c 100644
--- a/arch/arm/mach-snapdragon/dram.c
+++ b/arch/arm/mach-snapdragon/dram.c
@@ -9,8 +9,12 @@
 #include <asm-generic/unaligned.h>
 #include <dm.h>
 #include <log.h>
 #include <sort.h>
+#include <soc/qcom/smem.h>
+
+#include "qcom-priv.h"
+#include "rampart.h"
 
 static struct {
 	phys_addr_t start;
 	phys_size_t size;
@@ -47,8 +51,12 @@ static void qcom_configure_bi_dram(void)
 
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
 		gd->bd->bi_dram[i].start = prevbl_ddr_banks[i].start;
 		gd->bd->bi_dram[i].size = prevbl_ddr_banks[i].size;
+		debug("Bank[%d]: start = %#011llx, size = %#011llx\n",
+		      i, gd->bd->bi_dram[i].start, gd->bd->bi_dram[i].size);
+		if (!prevbl_ddr_banks[i].size)
+			break;
 	}
 }
 
 int dram_init_banksize(void)
@@ -57,8 +65,124 @@ int dram_init_banksize(void)
 
 	return 0;
 }
 
+#define entry_field(v, e, field) (v == 0 ? ((struct ram_partition_entry_v0 *)(e))->field : \
+				 (v == 1 ? ((struct ram_partition_entry_v1 *)(e))->field : \
+				  ((struct ram_partition_entry_v3 *)(e))->field))
+#define entry_start(v, e) entry_field(v, e, start_address)
+#define entry_length(v, e) entry_field(v, e, length)
+#define entry_category(v, e) entry_field(v, e, partition_category)
+#define entry_domain(v, e) entry_field(v, e, partition_domain)
+#define entry_type(v, e) entry_field(v, e, partition_type)
+
+/* Parse memory map from SMEM, return the number of entries */
+static int qcom_parse_memory_smem(phys_addr_t *ram_end)
+{
+	size_t size;
+	int i, j = 0, ret;
+	struct usable_ram_partition_table_header *header;
+	u32 ver;
+	void *entry;
+	u32 entry_size; // Size of each RAM partition entry (version dependent)
+
+	ret = qcom_smem_init();
+	if (ret) {
+		debug("Failed to initialize SMEM: %d.\n", ret);
+		return ret;
+	}
+
+	header = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_USABLE_RAM_PARTITION_TABLE, &size);
+	if (!header) {
+		debug("Failed to find SMEM partition.\n");
+		return -ENODEV;
+	}
+
+	ver = header->version;
+	debug("SMEM RAM partition table version %u. %u entries\n", ver, header->num_partitions);
+
+	switch (ver) {
+	case 0:
+		entry_size = sizeof(struct ram_partition_entry_v0);
+		entry = ((struct usable_ram_partition_table_v0 *)header)->entries;
+		break;
+	case 1:
+		entry_size = sizeof(struct ram_partition_entry_v1);
+		entry = ((struct usable_ram_partition_table_v1 *)header)->entries;
+		break;
+	default:
+		pr_warn("Unknown SMEM ram partition table version!\n");
+	case 2:
+	case 3:
+		entry_size = sizeof(struct ram_partition_entry_v3);
+		entry = ((struct usable_ram_partition_table_v3 *)header)->entries;
+		break;
+	}
+
+	debug("SMEM RAM partition entry size: %u bytes\n", entry_size);
+
+	/* Check validy of RAM */
+	for (i = 0; i < header->num_partitions && j < CONFIG_NR_DRAM_BANKS; i++, entry += entry_size) {
+		debug("Entry %d: [%#010llx - %#010llx]\n", i, entry_start(ver, entry),
+		      (u64)entry_start(ver, entry) + entry_length(ver, entry));
+		debug("          cat: %#04x type: %#04x domain: %#04x\n", entry_category(ver, entry),
+		      entry_type(ver, entry), entry_domain(ver, entry));
+
+
+		if (entry_category(ver, entry) != RAM_PARTITION_SDRAM ||
+		    entry_type(ver, entry) != RAM_PARTITION_SYS_MEMORY)
+			continue;
+		if (!entry_length(ver, entry) && !entry_start(ver, entry))
+			break;
+
+		prevbl_ddr_banks[j].start = entry_start(ver, entry);
+		prevbl_ddr_banks[j].size = entry_length(ver, entry);
+		*ram_end = max(*ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_banks[j].size);
+		j++;
+	}
+
+	if (j == CONFIG_NR_DRAM_BANKS)
+		pr_err("SMEM: More than CONFIG_NR_DRAM_BANKS (%u) entries!", CONFIG_NR_DRAM_BANKS);
+
+	return j;
+}
+
+static void qcom_parse_memory_dt(const fdt64_t *fdt, int *banks, phys_addr_t *ram_end)
+{
+	int offset;
+	const fdt64_t *memory;
+	int memsize;
+	int i, j;
+
+	*ram_end = 0;
+
+	offset = fdt_path_offset(fdt, "/memory");
+	if (offset < 0)
+		return;
+
+	memory = fdt_getprop(fdt, offset, "reg", &memsize);
+	if (!memory)
+		return;
+
+	*banks = min(memsize / (2 * sizeof(u64)), (ulong)CONFIG_NR_DRAM_BANKS);
+
+	if (memsize / sizeof(u64) > CONFIG_NR_DRAM_BANKS * 2)
+		log_err("Provided more than the max of %d memory banks\n", CONFIG_NR_DRAM_BANKS);
+
+	if (*banks > CONFIG_NR_DRAM_BANKS)
+		log_err("Provided more memory banks than we can handle\n");
+
+	for (i = 0, j = 0; i < *banks * 2; i += 2, j++) {
+		prevbl_ddr_banks[j].start = get_unaligned_be64(&memory[i]);
+		prevbl_ddr_banks[j].size = get_unaligned_be64(&memory[i + 1]);
+		if (!prevbl_ddr_banks[j].size) {
+			j--;
+			continue;
+		}
+		*ram_end = max(*ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_banks[j].size);
+	}
+}
+
 /**
  * The generic memory parsing code in U-Boot lacks a few things that we
  * need on Qualcomm:
  *
@@ -76,48 +200,36 @@ int dram_init_banksize(void)
  * We can't use fdtdec_setup_memory_banksize() since it stores the result in
  * gd->bd, which is not yet allocated.
  *
  * @fdt: FDT blob to parse /memory node from
+ * @fdt_is_internal: is the FDT one embedded into U-Boot or was it provided by a prior
+ *		     bootloader stage? This determined if we should try to rely on SMEM
+ *		     (internal FDT) or error. We currently assume that if we are passed
+ *		     an external FDT then it already has the memory map populated.
  *
  * Return: 0 on success or -ENODATA if /memory node is missing or incomplete
  */
-int qcom_parse_memory(const void *fdt)
+int qcom_parse_memory(const void *fdt, bool fdt_is_internal)
 {
-	int offset;
-	const fdt64_t *memory;
-	int memsize;
 	phys_addr_t ram_end = 0;
-	int i, j, banks;
+	int banks;
 
-	offset = fdt_path_offset(fdt, "/memory");
-	if (offset < 0)
-		return -ENODATA;
+	qcom_memmap_source = fdt_is_internal ? QCOM_MEMMAP_SOURCE_INTERNAL_FDT
+					     : QCOM_MEMMAP_SOURCE_EXTERNAL_FDT;
 
-	memory = fdt_getprop(fdt, offset, "reg", &memsize);
-	if (!memory)
-		return -ENODATA;
+	qcom_parse_memory_dt(fdt, &banks, &ram_end);
 
-	banks = min(memsize / (2 * sizeof(u64)), (ulong)CONFIG_NR_DRAM_BANKS);
-
-	if (memsize / sizeof(u64) > CONFIG_NR_DRAM_BANKS * 2)
-		log_err("Provided more than the max of %d memory banks\n", CONFIG_NR_DRAM_BANKS);
-
-	if (banks > CONFIG_NR_DRAM_BANKS)
-		log_err("Provided more memory banks than we can handle\n");
-
-	for (i = 0, j = 0; i < banks * 2; i += 2, j++) {
-		prevbl_ddr_banks[j].start = get_unaligned_be64(&memory[i]);
-		prevbl_ddr_banks[j].size = get_unaligned_be64(&memory[i + 1]);
-		if (!prevbl_ddr_banks[j].size) {
-			j--;
-			continue;
-		}
-		ram_end = max(ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_banks[j].size);
+	/*
+	 * If using an internal FDT but the memory node is empty
+	 * then fall back to SMEM.
+	 */
+	if (!prevbl_ddr_banks[0].size && fdt_is_internal) {
+		banks = qcom_parse_memory_smem(&ram_end);
+		if (banks < 0)
+			panic("Couldn't find a valid memory map!\n");
+		qcom_memmap_source = QCOM_MEMMAP_SOURCE_SMEM;
 	}
 
-	if (!banks || !prevbl_ddr_banks[0].size)
-		return -ENODATA;
-
 	/* Sort our RAM banks -_- */
 	qsort(prevbl_ddr_banks, banks, sizeof(prevbl_ddr_banks[0]), ddr_bank_cmp);
 
 	gd->ram_base = prevbl_ddr_banks[0].start;
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index ce409314a98b..39dc8fcc76ad 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -2,8 +2,10 @@
 
 #ifndef __QCOM_PRIV_H__
 #define __QCOM_PRIV_H__
 
+#include <stdbool.h>
+
 /**
  * enum qcom_boot_source - Track where we got loaded from.
  * Used for capsule update logic.
  *
@@ -16,13 +18,26 @@ enum qcom_boot_source {
 };
 
 extern enum qcom_boot_source qcom_boot_source;
 
+/*
+ * enum qcom_memmap_source - Track where we got the memory map from.
+ * used for debugging and validation.
+ */
+enum qcom_memmap_source {
+	QCOM_MEMMAP_SOURCE_INTERNAL_FDT = 1,
+	QCOM_MEMMAP_SOURCE_EXTERNAL_FDT,
+	QCOM_MEMMAP_SOURCE_SMEM,
+};
+
+/* Set by qcom_parse_memory() */
+extern enum qcom_memmap_source qcom_memmap_source;
+
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 void qcom_configure_capsule_updates(void);
 #else
 void qcom_configure_capsule_updates(void) {}
 #endif /* EFI_HAVE_CAPSULE_SUPPORT */
 
-int qcom_parse_memory(const void *fdt);
+int qcom_parse_memory(const void *fdt, bool fdt_is_internal);
 
 #endif /* __QCOM_PRIV_H__ */
diff --git a/arch/arm/mach-snapdragon/rampart.h b/arch/arm/mach-snapdragon/rampart.h
new file mode 100644
index 000000000000..57f3dbb7eec0
--- /dev/null
+++ b/arch/arm/mach-snapdragon/rampart.h
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RAM partition table definitions
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#ifndef __QCOM_SMEM_RAMPART_H__
+#define __QCOM_SMEM_RAMPART_H__
+
+#include <linux/types.h>
+
+#define SMEM_USABLE_RAM_PARTITION_TABLE		402
+
+#define RAM_PARTITION_H_MAJOR  03
+#define RAM_PARTITION_H_MINOR  00
+
+/**
+ * Total length of zero filled name string. This is not a C
+ * string, as it can occupy the total number of bytes, and if
+ * it does, it does not require a zero terminator. It cannot
+ * be manipulated with standard string handling library functions.
+ */
+#define RAM_PART_NAME_LENGTH 16
+
+/**
+ * Number of RAM partition entries which are usable by APPS.
+ */
+#define RAM_NUM_PART_ENTRIES 32
+
+/**
+ * @name: Magic numbers
+ * Used in identifying valid RAM partition table.
+ */
+#define RAM_PART_MAGIC1     0x9da5e0a8
+#define RAM_PART_MAGIC2     0xaf9ec4e2
+
+/**
+ * RAM partition attributes.
+ */
+enum ram_partition_attribute_t {
+	RAM_PARTITION_READ_ONLY = 0,       /* Read-only RAM partition */
+	RAM_PARTITION_READWRITE,           /* Read/write RAM partition */
+};
+
+/**
+ * RAM partition categories.
+ */
+enum ram_partition_category_t {
+	RAM_PARTITION_IRAM = 4,                   /* IRAM RAM partition */
+	RAM_PARTITION_IMEM = 5,                   /* IMEM RAM partition */
+	RAM_PARTITION_SDRAM = 14,                  /* SDRAM type without specific bus information**/
+};
+
+/**
+ * RAM Partition domains.
+ * @note: For shared RAM partition, domain value would be 0b11:\n
+ * RAM_PARTITION_APPS_DOMAIN | RAM_PARTITION_MODEM_DOMAIN.
+ */
+enum ram_partition_domain_t {
+	RAM_PARTITION_DEFAULT_DOMAIN = 0,  /* 0b00: No specific domain definition */
+	RAM_PARTITION_APPS_DOMAIN = 1,     /* 0b01: APPS RAM partition */
+	RAM_PARTITION_MODEM_DOMAIN = 2,    /* 0b10: MODEM RAM partition */
+};
+
+/**
+ * RAM Partition types.
+ * @note: The RAM_PARTITION_SYS_MEMORY type represents DDR rams that are attached
+ * to the current system.
+ */
+enum ram_partition_type_t {
+	RAM_PARTITION_SYS_MEMORY = 1,        /* system memory */
+	RAM_PARTITION_BOOT_REGION_MEMORY1,   /* boot loader memory 1 */
+	RAM_PARTITION_BOOT_REGION_MEMORY2,   /* boot loader memory 2, reserved */
+	RAM_PARTITION_APPSBL_MEMORY,         /* apps boot loader memory */
+	RAM_PARTITION_APPS_MEMORY,           /* apps usage memory */
+	RAM_PARTITION_TOOLS_FV_MEMORY,       /* tools usage memory */
+	RAM_PARTITION_QUANTUM_FV_MEMORY,     /* quantum usage memory */
+	RAM_PARTITION_QUEST_FV_MEMORY,       /* quest usage memory */
+};
+
+/* Common table header between versions */
+struct usable_ram_partition_table_header {
+	u32 magic1;          /* Magic number to identify valid RAM partition table */
+	u32 magic2;          /* Magic number to identify valid RAM partition table */
+	u32 version;         /* Version number to track structure definition changes */
+	u32 reserved1;       /* Reserved for future use */
+
+	u32 num_partitions;  /* Number of RAM partition table entries */
+};
+
+/* Holds information for an entry in the RAM partition table */
+struct ram_partition_entry_v3 {
+	char name[RAM_PART_NAME_LENGTH];  /* Partition name, unused for now */
+	u64 start_address;                /* Partition start address in RAM */
+	u64 length;                       /* Partition length in RAM in Bytes */
+	u32 partition_attribute;          /* Partition attribute */
+	u32 partition_category;           /* Partition category */
+	u32 partition_domain;             /* Partition domain */
+	u32 partition_type;               /* Partition type */
+	u32 num_partitions;               /* Number of partitions on device */
+	u32 hw_info;                      /* hw information such as type and frequency */
+	u8 highest_bank_bit;              /* Highest bit corresponding to a bank */
+	u8 reserve0;                      /* Reserved for future use */
+	u8 reserve1;                      /* Reserved for future use */
+	u8 reserve2;                      /* Reserved for future use */
+	u32 min_pasr_size;                /* Minimum PASR size in MB */
+	u64 available_length;             /* Available Partition length in RAM in Bytes */
+};
+
+/*
+ * Defines the RAM partition table structure
+ *
+ * Do not change the placement of the first four elements so that future
+ * compatibility will always be guaranteed at least for the identifiers.
+ *
+ * The other portion of the structure may be changed as necessary to accommodate
+ * new features. Be sure to increment version number if you change it.
+ */
+struct usable_ram_partition_table_v3 {
+	struct usable_ram_partition_table_header header;
+
+	u32 reserved2;       /* Added for 8 bytes alignment of header */
+
+	/* RAM partition table entries */
+	struct ram_partition_entry_v3 entries[RAM_NUM_PART_ENTRIES];
+};
+
+/* Version 1 structure 32 Bit - Holds information for an entry in the RAM partition table */
+struct ram_partition_entry_v1 {
+	char name[RAM_PART_NAME_LENGTH];  /* Partition name, unused for now */
+	u64 start_address;                /* Partition start address in RAM */
+	u64 length;                       /* Partition length in RAM in Bytes */
+	u32 partition_attribute;          /* Partition attribute */
+	u32 partition_category;           /* Partition category */
+	u32 partition_domain;             /* Partition domain */
+	u32 partition_type;               /* Partition type */
+	u32 num_partitions;               /* Number of partitions on device */
+	u32 hw_info;                      /* hw information such as type and frequency */
+	u32 reserved4;                    /* Reserved for future use */
+	u32 reserved5;                    /* Reserved for future use */
+};
+
+/*
+ * Defines the RAM partition table structure (Version 1)
+ *
+ * Do not change the placement of the first four elements so that future
+ * compatibility will always be guaranteed at least for the identifiers.
+ *
+ * The other portion of the structure may be changed as necessary to accommodate
+ * new features. Be sure to increment version number if you change it.
+ */
+struct usable_ram_partition_table_v1 {
+	struct usable_ram_partition_table_header header;
+
+	u32 reserved2;       /* Added for 8 bytes alignment of header */
+
+	/* RAM partition table entries */
+	struct ram_partition_entry_v1 entries[RAM_NUM_PART_ENTRIES];
+};
+
+/* Version 0 structure 32 Bit - Holds information for an entry in the RAM partition table */
+struct ram_partition_entry_v0 {
+	char name[RAM_PART_NAME_LENGTH];  /* Partition name, unused for now */
+	u32 start_address;                /* Partition start address in RAM */
+	u32 length;                       /* Partition length in RAM in Bytes */
+	u32 partition_attribute;          /* Partition attribute */
+	u32 partition_category;           /* Partition category */
+	u32 partition_domain;             /* Partition domain */
+	u32 partition_type;               /* Partition type */
+	u32 num_partitions;               /* Number of partitions on device */
+	u32 reserved3;                    /* Reserved for future use */
+	u32 reserved4;                    /* Reserved for future use */
+	u32 reserved5;                    /* Reserved for future use */
+};
+
+/*
+ * Defines the RAM partition table structure (Version 0)
+ *
+ * Do not change the placement of the first four elements so that future
+ * compatibility will always be guaranteed at least for the identifiers.
+ *
+ * The other portion of the structure may be changed as necessary to accommodate
+ * new features. Be sure to increment version number if you change it.
+ */
+struct usable_ram_partition_table_v0 {
+	struct usable_ram_partition_table_header header;
+
+	/* RAM partition table entries */
+	struct ram_partition_entry_v0 entries[RAM_NUM_PART_ENTRIES];
+};
+
+#endif // __QCOM_SMEM_RAMPART_H__

-- 
2.53.0

