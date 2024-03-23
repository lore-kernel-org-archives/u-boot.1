Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD62C54E58
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 18:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D880C87E2E;
	Sat, 23 Mar 2024 19:07:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="no/UC6G0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 001DF87ECC; Sat, 23 Mar 2024 19:07:33 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A076879DC
 for <u-boot@lists.denx.de>; Sat, 23 Mar 2024 19:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id EBF6DCE094D;
 Sat, 23 Mar 2024 18:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68496C433C7;
 Sat, 23 Mar 2024 18:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711217245;
 bh=zxdf9y013E21sSsgjDpo/KYGEIjOQZ9YHgxrRkRpIOk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=no/UC6G0kHuPvbLzp0gm3u/CYszI8PFhXfzBLIHnUV0b6859uipWw1oJ7Qi5nWYad
 2JcZ6Q6KwyNWsKiSW1rqMiIciC461TWmaKSwAxKQJ8mea/J4s592O7BRd7cgaLMmqh
 Rl4MX0gsdSti9GOR6JRSN/Tv3jJ/0x6xneiwYJ5c98j4x9UFcDn8y/6oSLpjaQOqAH
 Is/mqgO+cttiGL3nEWOxveBMffoMYrU6+MHA7EfMB03yLZKSJHbI/F1UwgECMGxts9
 O1+3VmNjz2NFxXsf7gbkdUIVhSAb4JWxmDgGc7dvqxzlubqBF0y23qfrSTT1+kyEjL
 ede/DGkYlS0uw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v2 07/18] arm: mvebu: turris_omnia: Disable Atmel
 SHA node if not present
Date: Sat, 23 Mar 2024 19:07:00 +0100
Message-ID: <20240323180711.5498-8-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240323180711.5498-1-kabel@kernel.org>
References: <20240323180711.5498-1-kabel@kernel.org>
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
index 896c14bb99..6f3aae55a8 100644
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

