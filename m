Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2685EC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 16:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E7828806C;
	Wed, 27 Mar 2024 17:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ArJEkeZS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49DBE88035; Wed, 27 Mar 2024 17:24:13 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2B5488127
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 17:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 79E1D615C5;
 Wed, 27 Mar 2024 16:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D1DC43394;
 Wed, 27 Mar 2024 16:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711556648;
 bh=m2VxTS9tX9MH7nSxgHFoawuN5tRMM0jTQ+d+QJZghJE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ArJEkeZSNdoTuTFLIu8uu/A6BW8RiSo5WXCtrNjOkUgx6GJZSgYDSn/p0rCRBoyp1
 ljNTnvSxLD+E/2X/8OMarM+bPlfTu/+u+fRnth+tPdxOyHhGkXWrWEzqHy4MX9/0Rw
 gxI0PprnfOnfdBfg/IxDMwXyJj4MVsYnULFW075zaVyiiCpoDcEVegFfkd16mkeFaW
 M29p1Fi6aHcvcf6h/Abe2X4K8ymA9OceNS/bA3DfN/eKYN0oV1G8mmrFMvXs1+9coh
 +9DWqvdDTnB6Zv+JhUNUY+sdF94ozh1VSoVvpWaUrYCyPcYjgSjVau+T4wSSCfcctr
 pfZeeHWCDHdyQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v3 07/18] arm: mvebu: turris_omnia: Disable Atmel
 SHA node if not present
Date: Wed, 27 Mar 2024 17:23:44 +0100
Message-ID: <20240327162355.24584-8-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240327162355.24584-1-kabel@kernel.org>
References: <20240327162355.24584-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

If the FEAT_CRYPTO feature bit is present in MCU features, the board
crypto is implemented by MCU and the Atmel SHA chip is not present.
Disable Atmel SHA device-tree node in that case.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 board/CZ.NIC/turris_omnia/turris_omnia.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index b2f0088e5e..3b7a71bdad 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -1007,6 +1007,25 @@ static int fixup_mcu_gpio_in_eth_wan_node(void *blob)
 	return 0;
 }
 
+static void fixup_atsha_node(void *blob)
+{
+	int node;
+
+	if (!omnia_mcu_has_feature(FEAT_CRYPTO))
+		return;
+
+	node = fdt_node_offset_by_compatible(blob, -1, "atmel,atsha204a");
+	if (node < 0) {
+		printf("Cannot find ATSHA204A node!\n");
+		return;
+	}
+
+	if (fdt_status_disabled(blob, node) < 0)
+		printf("Cannot disable ATSHA204A node!\n");
+	else
+		debug("Disabled ATSHA204A node\n");
+}
+
 #endif
 
 #if IS_ENABLED(CONFIG_OF_BOARD_FIXUP)
@@ -1020,6 +1039,8 @@ int board_fix_fdt(void *blob)
 	fixup_msata_port_nodes(blob);
 	fixup_wwan_port_nodes(blob);
 
+	fixup_atsha_node(blob);
+
 	return 0;
 }
 #endif
@@ -1211,6 +1232,8 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	fixup_msata_port_nodes(blob);
 	fixup_wwan_port_nodes(blob);
 
+	fixup_atsha_node(blob);
+
 	return 0;
 }
 #endif
-- 
2.43.2

