Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE9BC83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 20:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5127586611;
	Mon,  4 Sep 2023 22:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gZxB2Dy2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5878386824; Mon,  4 Sep 2023 22:55:10 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAFE7864A7
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 22:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.skvortzov@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-500913779f5so2953119e87.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 13:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693860907; x=1694465707; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9tLWo1tgPi02wBQW75DL2/OClNayJ5JLsp4mmyGRPuI=;
 b=gZxB2Dy2VhxcFVQkfm/C3owEo/zUrQkNGND20kqJpgyObHKfC9pt+OszAgkrXkh5ED
 FW1IqvgGKn5Jbs4YchTzlQa+b8aNHDcK/KMXj3tk5U2Q2aWKfZ3P4WmSCDF5cQ7cSbMH
 z/l37XmTLQ1JTulpfcHtvMvDCDpPrIX9N/1gUbZgI+Xzz8WH+Eqevti/IIF84d9+p+mg
 s/oObAtxnICIHVSbOGpu+hLYXnf/vW8zlcFG3iY5JwPDcXmFfIOKgEuLLbjqiDAL1QwY
 jIpX5oDTUbkYUY+XwXwCZYJgV2z/EWFT7xmlDSb8f0mt1KXSG5iOKqdhEvgq/uC1UMFB
 OkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693860907; x=1694465707;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9tLWo1tgPi02wBQW75DL2/OClNayJ5JLsp4mmyGRPuI=;
 b=da3nTaVxYlicc2sMHfzPNcF+OYTOTIJqLrKicHJot1noXiu5RTklM9nwEARqsfdRhw
 gsMkaHE6Ysj0sP+IgpUp/LX506XAJNRsaIRjmMRv8wHmkflw93hdcx0ljQVpyH7E3NHM
 eXaTYBGlrIhkS/Sz/isS9/fbpFIwmjLHQbNPW1eHEXfUOurXOa6ZU7CK1TlxE9dG9GUo
 3O/3Q/KidIPgKn4zpQQ2evIM9261ddouUyKxfhjpCKA1aoeC6vNpMY0Nj8KgK//h01PA
 JE3s/tPHMwRWOXQ2PiAZ14K1LsWcPcZpCDdwBsf/HVYiU4e8KZZY08u7QmETeRaJUicj
 emsA==
X-Gm-Message-State: AOJu0Yyxdisep2rFfMcYAdmerzaLMyBPXeulmnFOg4zdOfg+kdxsYw71
 RuMAuTxKIb0O0mKi1yjIl0E=
X-Google-Smtp-Source: AGHT+IErYBCJVVsdBU8wRgwTg774wceRH2XhcYiAqOyc3JBWB44OYJbN7b5ZJD93TbVqLadR18RM6g==
X-Received: by 2002:a19:5f54:0:b0:500:863e:fc57 with SMTP id
 a20-20020a195f54000000b00500863efc57mr6850263lfj.25.1693860906511; 
 Mon, 04 Sep 2023 13:55:06 -0700 (PDT)
Received: from localhost.localdomain
 ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
 by smtp.gmail.com with ESMTPSA id
 i22-20020ac25236000000b004fcdf99be86sm1930905lfl.239.2023.09.04.13.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 13:55:05 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, u-boot@lists.denx.de,
 Samuel Holland <samuel@sholland.org>, Jarrah Gosbell <kernel@undef.tools>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH] sunxi: board: provide CPU idle states to loaded OS
Date: Mon,  4 Sep 2023 23:54:30 +0300
Message-Id: <20230904205430.1647654-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.40.1
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

When using SCPI as the PSCI backend, firmware can wake up the CPUs and
cluster from sleep, so CPU idle states are available for loaded OS to
use. TF-A modifies DTB to advertise available CPU idle states, when
SCPI is detected. This change copies nodes added by TF-A to any new
dtb that is used for loaded OS.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 board/sunxi/board.c | 120 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index f321cd58a6..e88bd11a99 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -870,6 +870,125 @@ int board_late_init(void)
 	return 0;
 }
 
+static int cpuidle_dt_fixup_copy_node(ofnode src, int dst_offset, void *dst_blob,
+				      u32 *count, u32 *phandle)
+{
+	int offs, len, ret;
+	struct ofprop prop;
+	ofnode subnode;
+
+	ofnode_for_each_prop(prop, src) {
+		const char *name;
+		const char *val;
+
+		val = ofprop_get_property(&prop, &name, &len);
+		if (!val)
+			return -EINVAL;
+		if (!strcmp(name, "phandle")) {
+			if (ofnode_device_is_compatible(src, "arm,idle-state")) {
+				fdt_setprop_u32(dst_blob, dst_offset, name, *phandle);
+				(*phandle)++;
+				(*count)++;
+			} else {
+				log_err("Unexpected phandle node: %s\n", name);
+				return -EINVAL;
+			}
+		} else {
+			ret = fdt_setprop(dst_blob, dst_offset, name, val, len);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	ofnode_for_each_subnode(subnode, src) {
+		const char *name = ofnode_get_name(subnode);
+
+		if (!name)
+			return -EINVAL;
+		offs = fdt_add_subnode(dst_blob, dst_offset, name);
+		if (offs < 0)
+			return offs;
+		ret = cpuidle_dt_fixup_copy_node(subnode, offs, dst_blob, count, phandle);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+static int cpuidle_dt_fixup(void *blob)
+{
+	ofnode idle_states_node;
+	ofnode subnode;
+	u32 count, phandle;
+	const struct property *prop;
+	int offs, len, ret;
+
+	idle_states_node = ofnode_path("/cpus/idle-states");
+	if (!ofnode_valid(idle_states_node)) {
+		log_err("No idle-states node in old fdt, nothing to do");
+		return 0;
+	}
+
+	/*
+	 * Do not proceed if the target dt already has an idle-states node.
+	 * In this case assume that the system knows better somehow,
+	 * so do not interfere.
+	 */
+	if (fdt_path_offset(blob, "/cpus/idle-states") >= 0) {
+		log_err("idle-states node already exists in target");
+		return 0;
+	}
+
+	offs = fdt_path_offset(blob, "/cpus");
+	if (offs < 0)
+		return offs;
+
+	offs = fdt_add_subnode(blob, offs, "idle-states");
+	if (offs < 0)
+		return offs;
+
+	/* copy "/cpus/idle-states" node to destination fdt */
+	ret = fdt_find_max_phandle(blob, &phandle);
+	if (ret < 0)
+		return ret;
+	phandle++;
+	count = 0;
+	ret =  cpuidle_dt_fixup_copy_node(idle_states_node, offs, blob, &count, &phandle);
+	if (ret < 0)
+		return ret;
+
+	/* copy "cpu-idle-state" property for all cpus */
+	ofnode_for_each_subnode(subnode, ofnode_path("/cpus")) {
+		char path[32];
+		fdt32_t *value;
+
+		prop = ofnode_get_property(subnode, "cpu-idle-states", &len);
+		if (!prop)
+			continue;
+
+		/* find the same node in a new device-tree */
+		ret = ofnode_get_path(subnode, path, sizeof(path));
+		if (ret)
+			return ret;
+
+		offs = fdt_path_offset(blob, path);
+		if (offs < 0)
+			return offs;
+
+		/* Allocate space for the list of phandles. */
+		ret = fdt_setprop_placeholder(blob, offs, "cpu-idle-states",
+					      count * sizeof(phandle),
+					      (void **)&value);
+		if (ret < 0)
+			return ret;
+
+		/* Fill in the phandles of the idle state nodes. */
+		for (u32 i = 0U; i < count; ++i)
+			value[i] = cpu_to_fdt32(phandle - count + i);
+	}
+	return 0;
+}
+
 static void bluetooth_dt_fixup(void *blob)
 {
 	/* Some devices ship with a Bluetooth controller default address.
@@ -914,6 +1033,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	setup_environment(blob);
 	fdt_fixup_ethernet(blob);
 
+	cpuidle_dt_fixup(blob);
 	bluetooth_dt_fixup(blob);
 
 #ifdef CONFIG_VIDEO_DT_SIMPLEFB
-- 
2.40.1

