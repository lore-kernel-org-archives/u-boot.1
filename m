Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1CA606EEB7
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JRNkGqrL;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=oie6CdI3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E63E817B0;
	Sat,  7 Nov 2026 14:34:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QXFnlgdSVHoF; Sat,  7 Nov 2026 14:34:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1DC1181B99
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062068;
	b=QSD6VF2zWpgCZsImCSt3ImCbggFPdiURgX9MJ9yFWbFqa3fQ3LjmGT+feTe+jSXGmD6r
	 WfFT3KnIiaJPktPcG6LPt1zFNWAD058NjoEMWCo1y2+W4j+0qQROvcqng0NhKwTefilcq
	 YwJjR5DHDTyPcCsFbNFsbIBOkQIq6cj++Nb3hjAA/HCSJqM9++y8MqYiyaybXqqVMbvJz
	 /9RJ3WR/dDD/7J4KymzNg+Z7n9EcM8wg2I6LYV65MJe/8VLOKvot6+ynZYU1qs+4gZHIr
	 k+0tjnDGYxvHcW5miOK++c3zwMkg3pYKQsu1ptXSX4MzPeCVZcOja9H3J94PqZIi6TQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062068;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VyrYOb8Rmibtp5fnT4bzXXwRTdsMObfkxaB4EvsPDi4=;
	b=aw/qVyL1Pw1QKwEd1WjWFXXVfOIxjmMVGQ2LU6QWKC7AN+DDDMZCurr9agisdjBcxETl
	 Mke8Umg/qcogVSw8QyqPHDCd7OaY5fQGQw0ZYD29cWmbbPqj+CTvDoZwkfHa3CwyVHYVE
	 mlF/Fzd9a4EW1/UCuQlQqWOQi5rkQcDJb78KlgyK94wDztBvhGrz5gmZv86T6UK83LVSw
	 HDlEO2ue0vFy+axGiBzQB96ViEBzIr034VVelgthDVRxigiU3I+MRQ0pXx/1MTYYhKBFl
	 RYs45VBeks19HSOFFyKBpo/cmmiUYeemBPjl8uLUoaxPTIH06ZyoPLLtx/7wG1TB9Gg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062068;
	bh=VyrYOb8Rmibtp5fnT4bzXXwRTdsMObfkxaB4EvsPDi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JRNkGqrLxzgJjyzu4o/hIfJuRZ5F3gPhigG+7JiysCNeHyEi3lXj5E+XBDEXi3dOq
	 49XwK5veuarLqJHem+ayzMzv2cbbQ3y2m9HapaAQ6QaZ5az8YnPrf28YT3xJfRv2l6
	 IJWDLPcAqU6hycnEDukbP05kx85xy+uFPrn/XdUXXBGrq7V39czyGyswwusNACxKEo
	 lt4tr3X2OVr5tyTYiKl9VyxPLJPhZzXamN7bSN5jgEd0l/9hTrcQ5S2QZlakoPZM84
	 oGMIAEVxA74C7p4tTjcz275B1cucB6DtxSFopZstD5Rh7gnwzin8OZmPStGl+G8263
	 Rj+SQ/GDov2bA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DC1181B99;
	Sat,  7 Nov 2026 14:34:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F880211
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6128B4075F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 04Eu9fN-66lV for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7561940757
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=oie6CdI3
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7561940757
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:55 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4922dbcee23so818223f8f.0
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794062033; x=1794666833;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VyrYOb8Rmibtp5fnT4bzXXwRTdsMObfkxaB4EvsPDi4=;
 b=oie6CdI3M05vGLf6cF25lji6KQmVR+IvmgW7vdCY8CTi9lMYwxV0xWS//04sw02TfI
 umh5OG6g8nPkPKoWYvvYMIDdXPLXSDNwG0g1nO7ixY23gGSaIf4CljJ7ccF3qTJJQDDU
 Urz5rm0LuU5DsIAbzBJEMbHPpBAvZymeH7AWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062033; x=1794666833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VyrYOb8Rmibtp5fnT4bzXXwRTdsMObfkxaB4EvsPDi4=;
 b=Wy4lzOvXyHsfCLv8jmzdXsAkMwvYIDIPRjeA2Z3vTqOaHwoJiE2okbrOR5B7nLT/OX
 GMg7LESrRDEJBwid4QIB6uShOWz3gUA48Mwzp/ehPiGhyMOTcAz63OZNNGnm+lGI8eTY
 SP9qh0gCb1EEyL6uAn/ku4UIJUl8lUOv6GHpS1Wl6dJL7/oFfvrle/oQ/dI6WVAz9RZX
 29BAfVXQNVbnySsmbQAvVu3BGHcrZnKibzannwMRJDdblDhI6p6GiXEQ3vowBH6G9b6u
 iJi3BZlXtpdtXitVv6zlPo1jBW6GF85KqposDxHca7UZdMCTs/KcmxOMGz7pvRdPnt1W
 iW2A==
X-Forwarded-Encrypted: i=1;
 AL+hErGKd1S6SciQD4LFAkdCz+UfQC4OcbWqviZgzxb67digT9eAkVhXylD6ohjh8ew2U5QkTN3jwfU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9fZdjeln4IQoWCEOhp32Pp2YEm/V2JA3XBoT5PPA54ec01hoqx
 CwRP7xEhd0ZDmaeUvhO0y4rJspaHVwZKSI9Vm3cPc7SYrv6WcPmbX3K14bsfcKl0png=
X-Gm-Gg: AYBFou1ASkppKypB/MW+sGrNCURj4vjNUv8GhLXTgccIDNDTYaltnKeE2EilPQfScWq
 AqNxliI1e/hm1TbK54Rnu8Tp55dGQZgK9ZjSRmCdoF3w4ln4eJMtEnXTU7UfvkQNfHC9GwG7v3l
 F8bTAn3bF4qxTD33EqVFIN6QDiQX9wvKSCaPC09EEfyFGzquhhAtE0EhFE6CjmBxVr8yUu10tx/
 Nzj+WVJ6h4cQHC3p034jiFq5CnLzAoJDRn0jac4rBT0TX24B5rqL0UiWcb7WqVzra1yCNSqR1mI
 jgMaceOnWLEI+B8pkS5UfHVOBGE3VfkzZneer1mnMxarWcYd9Jxz5obAe25dpQA1e0pK6J3Kyes
 ObgZgE5nhwd3U6XjmXM3K5tQdItDRhBJalfJpwm5AWxWcbK9T8loYsUbj8hG0BmpxpwNCmUWGvK
 NbqU7N6Lhn9RGkH36tbjjR+qyV52n89rKGE/fRUs4tudgRBY1ihDxfodThIXXeTBPXzbEFlupLO
 a8Vwc9xbhldEhTfEmL1ZyGJ3PwuJB3rnM3eiEVn3VFKFJin+gHGIfEymP0hUDe4EcPB3pVJliRV
 LfTyn4oDDDcQI0hK3qclRvUcqG8TZikhlEIOUqTTZ/Dj2aEF4ah80nNXL+rfebOkGmzzAuFOrKf
 MfDnIvgjsrk3fVA3xIFAXYAkJvn5s5BHfC+Rh3TpiKCufPPAlCy635BFORrmDge7NYI3ucwpyFh
 4mvk55dscpN95HhGT4jssYN7Fp+z3BfyH0D17wDu02XqQqX2Y=
X-Received: by 2002:a05:6000:4a03:b0:48e:412:3829 with SMTP id
 ffacd0b85a97d-492764aede3mr10972759f8f.15.1794062033225; 
 Sat, 07 Nov 2026 06:33:53 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:52 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 34/35] board: engicam: stm32mp2: support FWU A/B bank bootup
Date: Sat,  7 Nov 2026 15:32:24 +0100
Message-ID: <20261107143241.2236511-35-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable the FWU multi-bank update. The FWU metadata are stored in the
boot device, so point the "fwu-mdata-store" property to it at runtime.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 ...m32mp257d-engicam-microgea-rmm-u-boot.dtsi |  6 +++
 board/engicam/stm32mp2/stm32mp2.c             | 40 +++++++++++++++++++
 configs/stm32mp25-microgea-rmm_defconfig      |  6 +++
 3 files changed, 52 insertions(+)

diff --git a/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi b/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
index 8a3723baa116..3055d661d849 100644
--- a/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
@@ -10,6 +10,12 @@
 	config {
 		u-boot,mmc-env-partition = "u-boot-env";
 	};
+
+	/* moved to the eMMC, when booting from it, by board_fix_fdt() */
+	fwu-mdata {
+		compatible = "u-boot,fwu-mdata-gpt";
+		fwu-mdata-store = <&sdmmc1>;
+	};
 };
 
 &ltdc {
diff --git a/board/engicam/stm32mp2/stm32mp2.c b/board/engicam/stm32mp2/stm32mp2.c
index 64317f271ed7..e15141677775 100644
--- a/board/engicam/stm32mp2/stm32mp2.c
+++ b/board/engicam/stm32mp2/stm32mp2.c
@@ -12,6 +12,7 @@
 #include <env.h>
 #include <event.h>
 #include <extension_board.h>
+#include <fdt_support.h>
 #include <log.h>
 #include <splash.h>
 #include <asm/arch/stm32.h>
@@ -217,6 +218,45 @@ int splash_screen_prepare(void)
 }
 #endif
 
+#if CONFIG_IS_ENABLED(OF_BOARD_FIXUP)
+/*
+ * The FWU metadata are stored in the boot device, the SD card or the
+ * eMMC, so point the "fwu-mdata-store" property to it. The phandle is
+ * replaced in place, since the devicetree is already in use.
+ */
+int board_fix_fdt(void *blob)
+{
+	u32 bootmode = get_bootmode();
+	unsigned int instance = (bootmode & TAMP_BOOT_INSTANCE_MASK) - 1;
+	int node, store;
+	char alias[8];
+	u32 phandle;
+
+	node = fdt_node_offset_by_compatible(blob, -1, "u-boot,fwu-mdata-gpt");
+	if (node < 0)
+		return 0;
+
+	switch (bootmode & TAMP_BOOT_DEVICE_MASK) {
+	case BOOT_FLASH_SD:
+	case BOOT_FLASH_EMMC:
+		break;
+	default:
+		return 0;
+	}
+
+	snprintf(alias, sizeof(alias), "mmc%u", instance);
+	store = fdt_path_offset(blob, alias);
+	if (store < 0)
+		return store;
+
+	phandle = fdt_get_phandle(blob, store);
+	if (!phandle)
+		return -ENOENT;
+
+	return fdt_setprop_inplace_u32(blob, node, "fwu-mdata-store", phandle);
+}
+#endif
+
 int board_late_init(void)
 {
 	const char *fdt_compat;
diff --git a/configs/stm32mp25-microgea-rmm_defconfig b/configs/stm32mp25-microgea-rmm_defconfig
index 0f1b7db7abc8..73f8f7cf96b6 100644
--- a/configs/stm32mp25-microgea-rmm_defconfig
+++ b/configs/stm32mp25-microgea-rmm_defconfig
@@ -14,10 +14,13 @@ CONFIG_CMD_STM32KEY=y
 CONFIG_MFD_STM32_TIMERS=y
 CONFIG_ENV_OFFSET_REDUND=0x940000
 CONFIG_TARGET_MICROGEA_STM32MP257=y
+CONFIG_FWU_NUM_IMAGES_PER_BANK=3
+CONFIG_OF_BOARD_FIXUP=y
 CONFIG_SYS_MEMTEST_START=0x84000000
 CONFIG_SYS_MEMTEST_END=0x88000000
 CONFIG_API=y
 CONFIG_SYS_MMC_MAX_DEVICE=3
+CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
@@ -25,6 +28,7 @@ CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
 # CONFIG_BOARD_INIT is not set
 CONFIG_SYS_PROMPT="STM32MP> "
 # CONFIG_CMD_BDI is not set
+CONFIG_CMD_FWU_METADATA=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_ADTIMG=y
 # CONFIG_CMD_ELF is not set
@@ -119,3 +123,5 @@ CONFIG_WDT_STM32MP=y
 CONFIG_WDT_ARM_SMC=y
 # CONFIG_UBIFS_SILENCE_DEBUG_DUMP is not set
 CONFIG_ERRNO_STR=y
+CONFIG_FWU_MULTI_BANK_UPDATE=y
+CONFIG_FWU_MDATA_V2=y
-- 
2.43.0

