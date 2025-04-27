Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E71C369D3
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 12:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A644B8210A;
	Sun, 27 Apr 2025 14:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R+jgX52v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43CF880C93; Sun, 27 Apr 2025 13:25:36 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E3B381F45
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 13:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A0E7E4A6C2;
 Sun, 27 Apr 2025 11:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62431C4CEED;
 Sun, 27 Apr 2025 11:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745753130;
 bh=Uwid/yDLxaBMEdq3wpAmKDtdhtE7FSHIvEs1UTOsXpc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=R+jgX52vtbxMNXsXw1Z7wmyTjQGCA+qadO4qd8KwKviHxTUqa5U9ZyJRejDcPZ7JW
 DIJbA1DvannateYDFhguKr1Etx/E91Tp8tN4led7viOTP6qaKI6o28iK/1cnJBXlDB
 ge23qWYkbkEnvjRgY5fqIwVl3GDJRKBzAedA8670mPCfVK5OLhtXNfNH46o/SQ3C5Q
 wPplXwnkLXwaVwarkTJHcGHBrWEvRDsl2tq/SuazJ5hkdbMlarJHFvcu2wNmq0YDuC
 BUdHmpkFiXaAWw3S3PusC6NxH9/52f/3lB1wr8ckfwrWEYbcgtVxRs81WCEpVeO5Zo
 aU3PyQ3cLLPJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 58162C3ABA1;
 Sun, 27 Apr 2025 11:25:30 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Sun, 27 Apr 2025 19:25:22 +0800
Subject: [PATCH 3/3] mach-snapdragon: Add support to append string to
 kernel cmdline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250427-android-boot-v1-3-bb6b37c9c9f1@gmail.com>
References: <20250427-android-boot-v1-0-bb6b37c9c9f1@gmail.com>
In-Reply-To: <20250427-android-boot-v1-0-bb6b37c9c9f1@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 George Chan <gchan9527@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745753127; l=4761;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=o7bGSV43vn8ZvzoBQQve0mT/ZvEW3snfpALQNmkOzQw=;
 b=XMDEfms/ZZVY36lxd8bUxhqfeFyfHPvEr0rKLJ9bHiLVm1G5wiP01BYLzpOsb4wzSJmXt8j2L
 4SellYvP8VfDZSL6k/JzYU4hxzro1IvJfYh9Inmr2rhT71etV+gdaoE
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Sun, 27 Apr 2025 14:43:01 +0200
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
Reply-To: gchan9527@gmail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: George Chan <gchan9527@gmail.com>

Add support for blindly appending string to bootargs env_param and let
boot process take care of it.

Signed-off-by: George Chan <gchan9527@gmail.com>
---
 arch/arm/mach-snapdragon/Kconfig | 11 +++++
 arch/arm/mach-snapdragon/board.c | 97 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 976c0e35fce..ee65bbd1313 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -45,4 +45,15 @@ config SYS_CONFIG_NAME
 	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
 	  will be used for board configuration.
 
+config SYS_BOARD_CMDLINE_APPEND
+        bool "Snapdragon SoCs based board cmdline append string"
+        help
+          Allows to specify the Snapdragon SoCs based board kernel cmdline override.
+          will be used as the custom board bootloader cmdline booting OS like Android.
+
+config SYS_BOARD_CMDLINE_APPEND_STRING
+	string "String to append"
+	default ""
+	depends on SYS_BOARD_CMDLINE_APPEND
+
 endif
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index deae4d32378..9b1dad8752d 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -46,6 +46,103 @@ static struct {
 	phys_size_t size;
 } prevbl_ddr_banks[CONFIG_NR_DRAM_BANKS] __section(".data") = { 0 };
 
+#ifdef CONFIG_SYS_BOARD_CMDLINE_APPEND
+/* (1) kernel cmdline support length is limited, which is (256..4096)
+ * (2) detain ref to COMMAND_LINE_SIZE of kernel header.
+ * (3) assumed null terminated.
+ * (4) Test shows that 1024 is working...
+ */
+#define COMMAND_LINE_SIZE_4_14		1024 /* ok make it default */
+static char bootargs[COMMAND_LINE_SIZE_4_14] = { 0 };
+const static char *soc_bootargs = CONFIG_SYS_BOARD_CMDLINE_APPEND_STRING;
+
+/* sort by importance to avoid some important value got wiped out */
+const static char *soc_bootargs_default = \
+" msm_drm.dsi_display0=dsi_nt36675_tianma_vid_display:" \
+" androidboot.lcmtype=dsi_nt36672c_tianma_fhd_video_display" \
+" androidboot.hwname=joyeuse" \
+" androidboot.secureboot=1" \
+" androidboot.keymaster=1"  \
+" androidboot.bootdevice=1d84000.ufshc" \
+" androidboot.boot_devices=soc/1d84000.ufshc" \
+" androidboot.verifiedbootstate=orange" \
+" androidboot.multisim_config=dsds" \
+" androidboot.cpuid=0xdc1467b8 " \
+" androidboot.dp=0x0 androidboot.baseband=msm" \
+" androidboot.fpsensor=fpc" \
+" androidboot.hwc=VDF_TWO" \
+" androidboot.hwlevel=MP" \
+" androidboot.AdcVol1=463 androidboot.AdcVol2=1306" \
+" androidboot.hwversion=4.90.0";
+
+/* fixups are put here:
+ * (1) androidboot.android_dt_dir this is to abuse the param to get rid of
+ * old fstab in device tree, and let search fail.
+ * (2) in case of fstab.qcom is in use but default boot.img have cmdline but
+ * do not specify the value, it will result expecting "fstab" instead of
+ * "fstab.qcom" and boot fail. so add a default value at last of cmd here.
+ */
+const static char *fix_bootargs = \
+" androidboot.android_dt_dir=/tmp/" \
+" androidboot.fstab_suffix=default" \
+" console=ramoops ";
+
+const char *get_board_support_bootargs(void)
+{
+        return soc_bootargs;
+}
+
+const char *get_board_support_bootargs_fixup(void)
+{
+        return fix_bootargs;
+}
+
+const char *board_fdt_chosen_bootargs(const struct fdt_property *fdt)
+{
+	int j;
+	char *env_prop = env_get("bootargs");
+	const char *soc_prop;
+	const char *fix_prop = fix_bootargs;
+	const char *fdt_prop;
+
+	soc_prop = (strlen(soc_bootargs) == 0) ? soc_bootargs_default : soc_bootargs;
+
+	fdt_prop = (fdt == NULL) ? "" : fdt->data;
+
+	if (env_prop == NULL)
+		env_prop = "";
+
+	debug("\n");
+	debug("fdt bootargs: %s\n", fdt_prop);
+	debug("env bootargs: %s\n", env_prop);
+	debug("soc bootargs: %s\n", soc_prop);
+	debug("fix bootargs: %s\n", fix_prop);
+
+	/* since android init parse androidboot property on a
+	 * first-come-first-serve manner so dtb valus come first and
+	 * then u-boot defaults and board specific fixups
+	 */
+	snprintf(bootargs, COMMAND_LINE_SIZE_4_14 - 2, "%s %s %s %s",
+		env_prop , fdt_prop, fix_prop, soc_prop);
+
+	/* remove all carriage return */
+	for (j = 0; j < COMMAND_LINE_SIZE_4_14; j++) {
+		if (bootargs[j] == '\0')
+			break;
+
+		if ((bootargs[j] == '\n') || (bootargs[j] == '\r'))
+			bootargs[j] = ' ';
+	}
+
+	/* trim to max length */
+	bootargs[COMMAND_LINE_SIZE_4_14 - 1] = '\0';
+
+	debug("out bootargs: %s\n", bootargs);
+	debug("total length: %d\n", j);
+	return bootargs;
+}
+#endif
+
 int dram_init(void)
 {
 	/*

-- 
2.43.0


