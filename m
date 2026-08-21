Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33152C5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED7E361034;
	Fri, 21 Aug 2026 13:17:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tqnTZVc-QIAE; Fri, 21 Aug 2026 13:17:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318072;
	bh=NoG/V0srZNFlKDZwUqOu7okd7l/iDJ2z7w/Tlwdqi64=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZQ71LX5xwVSgiwRRWKqasT2gSIWRIVgP168QawUZgWz7KadYJHVsWl9R2i9/pAurc
	 uk5MZno8/QEJdyJ08o37Y+ZagWUeDhXxAyvqH6vFSthznmG3pO42TJIeLLUh8FBJpr
	 I9BAwRcKSVfuxI+RB7TbMGoGoEauJEmSyVO+pRAfixcfLBp16vGUgmiW8FuEKTFHCO
	 SEohI4lICDov6npcj1CeTIv/1UMkTaTOeou2kG1qOchMQje3y4vhF230rRFCWXseWf
	 38p7pJYtr1q2s8PzW7X00mTFU0r4RkYTZdwd8zB+t0GSBPqyjbyBF+ZcvuaIRwD9MX
	 LGHyQJAZoAYJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D44DE60DD4;
	Fri, 21 Aug 2026 13:14:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EEC3279
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 07:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C86D408BE
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 07:10:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qd4asRStmrXU for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 07:10:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=O03nOhDZ
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5EA4B408BD
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 07:10:04 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69fc9f25118so818460a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 00:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787296202; x=1787901002;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NoG/V0srZNFlKDZwUqOu7okd7l/iDJ2z7w/Tlwdqi64=;
 b=O03nOhDZP4uG1oED5Q41RW79oQgMWJUDWWpDvTJ6ilC+KNyh8UaEXvu9WT14L1jeVS
 BSMHJUEWt1YMizv8sG6V6WMcZQ6jPryyWU+2MUgkgBr6oqDR/V5Dy3N0orUT2gu9z2wi
 oqhIyEQC6SLUaNx/c9nze1EScapyDBcdqYOui5RQp1p4nNin+HEHcmKdkUyZ9UxP61Of
 wzrm9HpJwwOPDqdJbkvxOvL5jgGpIrOLtFrJmfCrREGsRcgdK0C3XYpdQ0xxRKH11xww
 jmJe8dEiDCgAINqUSYBiGb78VYW0qwUJbcRoCeZikRuruVPaxISR8jBoGdfYs7EU0czS
 5EvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787296202; x=1787901002;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NoG/V0srZNFlKDZwUqOu7okd7l/iDJ2z7w/Tlwdqi64=;
 b=B5jiJqDFE2ohExPUj8OlHf4Lfjdh1W4zcCp2d0u3FwimXrOrn3YhbzHi2rtFyAd4gP
 nOH+IniW7O4Gdw1e8UxLrJZso3ogG0Bo2EWcJ+4ZmJxvsJ0MCze71cidd3D8efrDDbaR
 zzp41/jsO6le7kiieRTg35ih9nzkSIhj5TeGyyjt4HDdJX6zjwPac0lbcnVzbT8TYNNk
 d/hExnA+SlCuedrAXZBib1rOWk3v+yvb8RyllDM2aGyEsjnV079W6uyMJ8U05bps8n3C
 jIDX0HoIKQVoeXl7tDSIaKm3WkGXeE0/fuiNYh2Cs0fDbZGVOGtDempeB1/PPXZE6hYs
 g4dw==
X-Gm-Message-State: AFuF++mpkLvxMQQg/dhDaqeT1HE8Lmr4GHrUrqbBcG2phXMuYSka1RG7
 YFa8uOyWeR/hsk0wgyVkwmVUi86D6pQcds7VKOARXfCkf1+OzMCzhYHC6lmBeYBG
X-Gm-Gg: AR+sD13jBpCk8MZ1XYuX8PheW/E/RVjNa6TNYiIvxEjsp01PnFaJxFA6ADDUHL0r1dB
 E0Mf4oECIpRH3hlD9H+kS/SG6q5PjkRqXnV5JvG6aXpcCxuOQlHBT3J4UrCnjhg+Sr6Vo6xjydb
 iGkM9HLgVguTRl8bGbQmJXSHcRY2DlpaqpdG3k9wq7584sR+vk9O5BwRkFpT1HknxWQBLbwgkk8
 5tLGIRnrpSUiWZ7yOf9N8NHUwMuNxzWShfk7Rj5j88V0oR7idHiZV9W998NMSh9qaspXBlxa6yr
 33/DX7HLvigWEmaCP6woNNyaDzGUqi2coIpzM4ajsBcaPJ1qxCyx8Owj/JWMKCAGMgu5a/faPad
 Ipi50glQh+a+CSvhuc2U3Ju0mtrsGsPkuEMLiEiMdS/U1MjMzTOWTEDHHoKv/K2/LIxdsTOnFzq
 PbDvcsJkvvuX5sPuJYS9f+rzd7TLFbDMwIKFu1YRA+5JW5TOqwjJKgqA==
X-Received: by 2002:a17:907:c243:b0:c16:2e4f:a372 with SMTP id
 a640c23a62f3a-c246a5f45b5mr517155466b.13.1787296202196; 
 Fri, 21 Aug 2026 00:10:02 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2458b0933csm346239866b.18.2026.08.21.00.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 00:10:01 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, trini@konsulko.com, franz.schnyder@toradex.com,
 stefan.eichenberger@toradex.com, emanuele.ghidoli@toradex.com,
 sjg@chromium.org
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1] toradex: {aquila, smarc, verdin}-imx95: add board_fix_fdt
Date: Fri, 21 Aug 2026 09:09:51 +0200
Message-ID: <20260821070958.6997-1-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:12:32 +0000
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

On i.MX95 SoCs, peripherals like PCIe, the display pipeline (DPU, LVDS,
MIPI-DSI), the 10G ENET port and the Cortex-M7 core can be fused off.
U-Boot already fixes up the OS device tree accordingly in
ft_system_setup(), but its own control device tree keeps those nodes
enabled, so U-Boot might bind and probe drivers for hardware that are
not present on the SoC.

Enable CONFIG_OF_BOARD_FIXUP and implement board_fix_fdt() for Aquila,
Toradex SMARC iMX95 and Verdin iMX95 by calling
imx9_uboot_fixup_by_fuse(), mirroring the i.MX95 reference board
implementation.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 board/toradex/aquila-imx95/aquila-imx95.c | 8 ++++++++
 board/toradex/smarc-imx95/smarc-imx95.c   | 8 ++++++++
 board/toradex/verdin-imx95/verdin-imx95.c | 8 ++++++++
 configs/aquila-imx95_defconfig            | 1 +
 configs/toradex-smarc-imx95_defconfig     | 1 +
 configs/verdin-imx95_defconfig            | 1 +
 6 files changed, 27 insertions(+)

diff --git a/board/toradex/aquila-imx95/aquila-imx95.c b/board/toradex/aquila-imx95/aquila-imx95.c
index a5b26ef3dc3..a413f2fee62 100644
--- a/board/toradex/aquila-imx95/aquila-imx95.c
+++ b/board/toradex/aquila-imx95/aquila-imx95.c
@@ -42,3 +42,11 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	return ft_common_board_setup(blob, bd);
 }
 #endif
+
+#if IS_ENABLED(CONFIG_OF_BOARD_FIXUP)
+int board_fix_fdt(void *fdt)
+{
+	/* Remove nodes based on fuses. */
+	return imx9_uboot_fixup_by_fuse(fdt);
+}
+#endif
diff --git a/board/toradex/smarc-imx95/smarc-imx95.c b/board/toradex/smarc-imx95/smarc-imx95.c
index d09ce8a52ab..d8132c1abb9 100644
--- a/board/toradex/smarc-imx95/smarc-imx95.c
+++ b/board/toradex/smarc-imx95/smarc-imx95.c
@@ -42,3 +42,11 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	return ft_common_board_setup(blob, bd);
 }
 #endif
+
+#if IS_ENABLED(CONFIG_OF_BOARD_FIXUP)
+int board_fix_fdt(void *fdt)
+{
+	/* Remove nodes based on fuses. */
+	return imx9_uboot_fixup_by_fuse(fdt);
+}
+#endif
diff --git a/board/toradex/verdin-imx95/verdin-imx95.c b/board/toradex/verdin-imx95/verdin-imx95.c
index 7c0804c1d1c..e54ac309db4 100644
--- a/board/toradex/verdin-imx95/verdin-imx95.c
+++ b/board/toradex/verdin-imx95/verdin-imx95.c
@@ -78,3 +78,11 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	return ft_common_board_setup(blob, bd);
 }
 #endif
+
+#if IS_ENABLED(CONFIG_OF_BOARD_FIXUP)
+int board_fix_fdt(void *fdt)
+{
+	/* Remove nodes based on fuses. */
+	return imx9_uboot_fixup_by_fuse(fdt);
+}
+#endif
diff --git a/configs/aquila-imx95_defconfig b/configs/aquila-imx95_defconfig
index bb3d475ef4d..8dc6780d98b 100644
--- a/configs/aquila-imx95_defconfig
+++ b/configs/aquila-imx95_defconfig
@@ -27,6 +27,7 @@ CONFIG_WATCHDOG_TIMEOUT_MSECS=30000
 CONFIG_SPL=y
 CONFIG_SPL_RECOVER_DATA_SECTION=y
 CONFIG_PCI=y
+CONFIG_OF_BOARD_FIXUP=y
 CONFIG_SYS_MEMTEST_START=0x90000000
 CONFIG_SYS_MEMTEST_END=0xA0000000
 CONFIG_REMAKE_ELF=y
diff --git a/configs/toradex-smarc-imx95_defconfig b/configs/toradex-smarc-imx95_defconfig
index 9abadb0ed1a..fcc006d1d2c 100644
--- a/configs/toradex-smarc-imx95_defconfig
+++ b/configs/toradex-smarc-imx95_defconfig
@@ -27,6 +27,7 @@ CONFIG_WATCHDOG_TIMEOUT_MSECS=30000
 CONFIG_SPL=y
 CONFIG_SPL_RECOVER_DATA_SECTION=y
 CONFIG_PCI=y
+CONFIG_OF_BOARD_FIXUP=y
 CONFIG_SYS_MEMTEST_START=0x90000000
 CONFIG_SYS_MEMTEST_END=0xA0000000
 CONFIG_REMAKE_ELF=y
diff --git a/configs/verdin-imx95_defconfig b/configs/verdin-imx95_defconfig
index daf41a8b830..47a800d5ba6 100644
--- a/configs/verdin-imx95_defconfig
+++ b/configs/verdin-imx95_defconfig
@@ -27,6 +27,7 @@ CONFIG_WATCHDOG_TIMEOUT_MSECS=30000
 CONFIG_SPL=y
 CONFIG_SPL_RECOVER_DATA_SECTION=y
 CONFIG_PCI=y
+CONFIG_OF_BOARD_FIXUP=y
 CONFIG_SYS_MEMTEST_START=0x90000000
 CONFIG_SYS_MEMTEST_END=0xA0000000
 CONFIG_REMAKE_ELF=y
-- 
2.55.0

