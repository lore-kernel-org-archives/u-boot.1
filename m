Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560AA606A895
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 22:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CZz1RV6v;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jZFLRDJ7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3171360835;
	Mon, 16 Nov 2026 22:34:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k9ry3noKUXAN; Mon, 16 Nov 2026 22:34:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4F3DF60801
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794868456;
	b=pqZz9whohqxk3j5mMJNk6S2OKGXayGNMaxkMttG/CnYWPnW223D+1jV+9frlmz5izjbZ
	 A22+9yubIOrQPzoFxv9Z+0mu5OLWEeK7fPTOssFEgT1KIeSo2ONBO1mSd8DJ5B8ZyPZS0
	 EOxpnTrC66XbmfukPvvx2HlGDkqDoP4fVSuzh4Y/NSg0wzmdAOmxBDorzt/szWhRMXGe7
	 m3eLaePOisCwChIeSPXio/QKQE5DB+Isk+HvxuFSx0WSsCEjKXs+Asx2WeNiT1XjPzybr
	 NGrqIB8KlRPxbhtFqjG6OOl/8FD2skXwhIeYJ+Om/Unu/m0FoetItLe7ZCEtCkVMrlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794868456;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1IM6tMZHIUQiFAmz+dcC2y2rsWddHhMzIbVoy04+83s=;
	b=YghVoNBFJz/4nj2Em6Wy3XHrmti5QY/Bl3I/H1IWP4z543HfBnyDSbFwDHcY0hYMSS0y
	 jSDsLFh/3W6UYLryTeSMRheBbu/oct2x+2kM/Z2jGrlaQmNOZObVQrpFQlUL2ArdDp/ko
	 GsZrQIG9vvT1idPZ5yZa5BMQyZ5664GkR9zDRMO0vsk40K8vrjwQFOaE9ITfmx65M6JZS
	 u4dutwXlZ1iEYBW7aOh2L/bQQf5E6bHgPNwwxBlxegB1+bcPDLy+oxNHz9j63Vnx0t1P4
	 X6hSrjQO5DNl/LagiHIK66AXBabOu/eTkpVn8UYLXYELZJmdXAk7uMh7F4a3ZC2saBQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794868456;
	bh=1IM6tMZHIUQiFAmz+dcC2y2rsWddHhMzIbVoy04+83s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CZz1RV6vKpLSCBOlyWbV3URfBLQrFxb3UhzixBjmtM03K2ZY/bXfTCf/zcZBea8Vr
	 qpRG7TZunWb0+L4SBBU3LFkRfY91jwOZFW04Naj+tVBPQbsk/Jn32lQefRvaBUyXal
	 SGG1W6R5av6trbEsguPwc5R8C/adW+FZhFUi57jPpRRXHvJTBURp0aUV5XDyKaQgXg
	 lLyJmn/Un4iiMywX9qwXrmIaX+yfAE5v3xESbsH3Sug4rlCncRKmAIatIBoBnQaac6
	 mByRCdNPEo5zZDFvV4HIuvkpbHJOP1qN8fMYYcVb+wDiIZh5s3mu6hbE/5HN0/JqHR
	 VFXYmCfHI4+4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F3DF60801;
	Mon, 16 Nov 2026 22:34:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 50D69109
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:34:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E8CC80DBA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:34:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UANzwx2ng6Ji for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 22:34:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7D5B480DB8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jZFLRDJ7
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D5B480DB8
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:34:14 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-702dedeb70dso3124660eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794868453; x=1795473253;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1IM6tMZHIUQiFAmz+dcC2y2rsWddHhMzIbVoy04+83s=;
 b=jZFLRDJ7K0E8uNSwh6wb014zD7GvEKkOhn6aF3iOlrisdQq5toBvNNnYlXCRZWmmyI
 jzH93z/0Mu2SsM7P/AcNC02v3Dve+CHXoUfohwtFQP/uqAZapvuhryAFbCuObEWmqO1t
 Nf5PplLG2O7LK++SlLVNKomGDDkZZUJZZzJ93ynsu5gMENWiASW74KFpwMVyYNUa3+dk
 qTAWCQ9uvvJOiOgrR0Q4LpvSzJU1Ji7aickFYpmoJoWueHT//UMllEjIvfJ+B/2lTgiL
 ZctA3aQza/DGY0v6ROEnfnBhBsWGKw/hs31bzMCgEnOh7dmDAaMBh2CjQeJSputbBsy1
 Wlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794868453; x=1795473253;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1IM6tMZHIUQiFAmz+dcC2y2rsWddHhMzIbVoy04+83s=;
 b=dZ74T4+81Y2TwE4DHMCSy2ptKE6ODq1mhkKsGNUaC1JZtNK/ThdM1j2lHbvQfx0yB/
 ZQa6oij2j7b05sr34ppo/hLUEkliEuIQN5l1fhucLwXJFZiuwIqqfTlfZHWultHQYr6S
 CNqXbKI0A3V80kHXX0V60KU1tVVf7tQYcSJ3k9TYZYAwD6W5lvxqEJkoe7OAYuLKWZua
 JuqNX7+GoC6hodo+6g+B1xW3bdjPFuEuW7cEBgpw48Ve+/2AGFX64WtOcqrgWo7iVSGz
 By2F00OrjtksIs7OS7mBnX+2RmCOtLlSYLO1wpjEkJFIM7cnG3VLNVVLHYxaluR1EgQJ
 Sx5g==
X-Gm-Message-State: APuU4Z9BCWFbPujzYjhvwjQ16ssX6G4CmNFcVTI7quaEzijqLAYDs5YI
 5sccSwkcQ+dFACwm/VDPtQbK+3Mgz9xO/XcmdHXGQKUd/jTWjoWl++Av7agri+ficIg=
X-Gm-Gg: AYBFou3bGpWu5x5hQLBa0oO4CgZ6rUwF7iR+S01toqeGUQmjnyqbNZHv589OLBKn/0A
 WtcZuWHoH5LtqaYX/ofg7yByAa9Uk3XqqoGhZK9r6baM9IzCii82Ntli9hh+HrVN9rXIcpozfiJ
 +IjT9/YxX0LgQAIKVZWlfr4CMhPt6pFBArE9s7lF3A9GmganG1wI5pASB0wSoSouH+kv42ITnj5
 TSNJ9CauUymSJoZKZ+1CVd3zbpbdbgiXrIpAnbZP1qceFBFH6YT3GJBLxIX8/Ogzr6SIiEb/W/z
 nL2kvGXmj6tR+zKR0OEVmaGd5Y1ZW3AfpZY5XcfmFuE2u7SZ446dAsCe5S+0Q41vy7OAPVBZmAw
 UDvgbBs54hw7z4qdWD63e3KqrliB68qU7pKzsfOPOvcG4RsN1Sn34ZdCTCnb70n1vbH6D11m38D
 u8bgr34Q5aFj6uiGIA0wANupcHB8e50hcaT6Z0lfm6lXu1pOqc3igHC09yfK8OyXdNLCTMjS2Kw
 OKhGLx57HOq4UBw9HtzK9SMKJ5QRUVsyEal0krJlSwFD3qbL4/O2JzcUK7TzCVx9VXk3nazQrtE
 l0QnecfaS0j5H5fskFPugEazq1bjz5wgsg==
X-Received: by 2002:a05:6808:11c7:b0:4e9:69e9:59c3 with SMTP id
 5614622812f47-56e6531a679mr9423833b6e.67.1794868452989; 
 Mon, 16 Nov 2026 14:34:12 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7056:3b5b:7d85:4921])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70c58f9bsm10173280b6e.13.2026.11.16.14.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 14:34:12 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 16 Nov 2026 16:32:48 -0600
Subject: [PATCH v3 7/8] arm: mediatek: pass reserved memory on to the OS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-mtk-mt8189-tfa-fdt-v3-7-ca423d2d8038@baylibre.com>
References: <20261116-mtk-mt8189-tfa-fdt-v3-0-ca423d2d8038@baylibre.com>
In-Reply-To: <20261116-mtk-mt8189-tfa-fdt-v3-0-ca423d2d8038@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4045; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=7tosm7f+RFklofI9UzmDj368KeMzLbcGO2eLxUQWfzI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq+4S+dinZThlg7jNH9fS/LQyGwKUuZxoz3hHDY
 SWOxQxGdmGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavuEvhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AvkIIAIBQAl124g2wfwV0f512Kx+Bg67V37BQekF1xbs
 +Jet7gNzdj18Q3K1tBwQHxNXObZS4+ZLnkZ4JiiWaHYrKaV7RGKZ7X4MdUTL4x59dBf5zuvmZzQ
 GaZ1ECFtDNIAv52Ipj9/+2WfsT09yQHPw9FlbQPkVyYMgGYwMz8KUyN7z+M/JU0YcPzsletyLR9
 aYg6JBP4Busw8MFHIdl8F8/lmJadcFb9EhAgjG/QacXHXKSFYMZcJrIzxb26AZMmUIZCaB+l8UU
 IgeqeUuoIpLfqU33rqlYbu92gxs5F936rxGK9ajYb4AAw7nw1P6dBCPlOJjcvDhyuePLnYABVrc
 gyYc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Copy the no-map reserved-memory regions of the control devicetree into
the devicetree passed to the OS when MTK_DRAM_DESC_HANDOFF is enabled.

The control devicetree describes the memory reserved for firmware such
as BL31 and OP-TEE, and the boot stage that initializes the DRAM adds
regions whose location depends on the DRAM fitted to the board. An OS
devicetree loaded from elsewhere does not necessarily describe these
regions, but the OS must not use them.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/Kconfig     |  6 +++-
 arch/arm/mach-mediatek/Makefile    |  3 ++
 arch/arm/mach-mediatek/dram_desc.c | 58 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 0e5ffb2e68f..fec9601e80c 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -347,6 +347,8 @@ config MTK_DRAM_DESC_HANDOFF
 	bool "Require the DRAM description in a transfer list"
 	depends on BLOBLIST
 	depends on SPL_BLOBLIST || !SPL
+	depends on !MTK_TZ_MOVABLE
+	select OF_SYSTEM_SETUP
 	help
 	  The DRAM size and the memory reserved for the DRAM controller depend
 	  on the DRAM fitted to the board, so the devicetree built into U-Boot
@@ -354,7 +356,9 @@ config MTK_DRAM_DESC_HANDOFF
 	  describes them instead, with a devicetree overlay in a Firmware
 	  Handoff transfer list.
 
-	  Make SPL stop if it does not receive such an overlay.
+	  Make SPL stop if it does not receive such an overlay, and pass the
+	  no-map reserved memory regions of the control devicetree on to the
+	  OS.
 
 config MTK_TZ_MOVABLE
 	select ARCH_MISC_INIT
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 65c95f34ef5..0f237ecc992 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -4,6 +4,9 @@ obj-$(CONFIG_ARM64) += armv8-mem-map.o
 obj-y	+= cpu.o
 obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
+ifndef CONFIG_XPL_BUILD
+obj-$(CONFIG_MTK_DRAM_DESC_HANDOFF) += dram_desc.o
+endif
 obj-$(CONFIG_$(PHASE_)MTK_FIRMWARE_AB) += spl_ab.o mtk_ab.o
 obj-$(CONFIG_$(PHASE_)MTK_BROM_DOWNLOAD_AGENT_FASTBOOT) += download_agent.o
 
diff --git a/arch/arm/mach-mediatek/dram_desc.c b/arch/arm/mach-mediatek/dram_desc.c
new file mode 100644
index 00000000000..8022b213cc7
--- /dev/null
+++ b/arch/arm/mach-mediatek/dram_desc.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 BayLibre SAS
+ */
+
+#include <fdt_support.h>
+#include <fdtdec.h>
+#include <stdio.h>
+#include <string.h>
+#include <asm/u-boot.h>
+#include <dm/ofnode.h>
+#include <linux/ioport.h>
+#include <linux/libfdt.h>
+
+/*
+ * Pass the no-map reserved memory regions of the control devicetree on to the
+ * OS. Besides the static firmware regions, these can include regions that an
+ * earlier boot stage added, at addresses that depend on the DRAM fitted to the
+ * board.
+ */
+int ft_system_setup(void *blob, struct bd_info *bd)
+{
+	ofnode node, subnode;
+	int ret;
+
+	node = ofnode_path("/reserved-memory");
+	if (!ofnode_valid(node))
+		return 0;
+
+	ofnode_for_each_subnode(subnode, node) {
+		struct fdt_memory carveout;
+		struct resource res;
+		char name[64], *at;
+
+		if (!ofnode_read_bool(subnode, "no-map") ||
+		    ofnode_read_resource(subnode, 0, &res))
+			continue;
+
+		strlcpy(name, ofnode_get_name(subnode), sizeof(name));
+		at = strchr(name, '@');
+		if (at)
+			*at = '\0';
+
+		carveout.start = res.start;
+		carveout.end = res.end;
+
+		ret = fdtdec_add_reserved_memory(blob, name, &carveout, NULL, 0,
+						 NULL, FDTDEC_RESERVED_MEMORY_NO_MAP);
+		if (ret) {
+			printf("Failed to reserve %s at %pa-%pa: %s\n",
+			       ofnode_get_name(subnode), &res.start,
+			       &res.end, fdt_strerror(ret));
+			return ret;
+		}
+	}
+
+	return 0;
+}

-- 
2.53.0

