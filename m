Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2075C25B79
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 15:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0934880A7;
	Wed, 15 May 2024 17:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dxMfCW9C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A298D8826D; Wed, 15 May 2024 17:05:02 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C94D88013
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 17:05:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 2AA0ACE14E9;
 Wed, 15 May 2024 15:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F288EC2BD11;
 Wed, 15 May 2024 15:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715785491;
 bh=CfxGm1OX5VQ/btYoiTsZm/owbPxeLkQPM0AMMg5KDXo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dxMfCW9CSO2MkRZNyehnpif5+ilxtG/rNQdW/ZLuRMxQAom9kKnUXXtklOIfIsP6+
 /8rEOR8E1u+Wl9UTuvLZIzU+PvPspn/jfvmpe/18gLJDxOFFf/YQMeEHDYDzQaeaGZ
 +YA7u2xMOKkgcHuRfy7sesxWdokpycIRBECHgPw3vGuQFKwv3WzNtu+CRSWpAmFu8m
 8v81rpRyG3lmSXyuHndih3Z16FmyxW7wz5usyfX3MhoNZEAqtslpaeYlTW2YpSLouo
 DIDhiQdJ2pR1mD5WCsmFk1Y29TFUSybdetB5UjFcpVTwDnO1fq5p8DZO3ox+nfzMvQ
 EkMneWHNZgeIQ==
From: Conor Dooley <conor@kernel.org>
To: u-boot@lists.denx.de
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/2] board: microchip: icicle: make both ethernets optional
Date: Wed, 15 May 2024 16:04:31 +0100
Message-ID: <20240515150434.406916-3-conor@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240515150434.406916-1-conor@kernel.org>
References: <20240515150434.406916-1-conor@kernel.org>
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

From: Conor Dooley <conor.dooley@microchip.com>

A given AMP configuration for a board may make either one, or neither
of, the ethernet ports available to U-Boot. The Icicle's init code will
fail if mac1 is not present, so move it to the optional approach taken
for mac0.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 board/microchip/mpfs_icicle/mpfs_icicle.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/board/microchip/mpfs_icicle/mpfs_icicle.c b/board/microchip/mpfs_icicle/mpfs_icicle.c
index 5fd0ec66a9..4d7d843dfa 100644
--- a/board/microchip/mpfs_icicle/mpfs_icicle.c
+++ b/board/microchip/mpfs_icicle/mpfs_icicle.c
@@ -79,18 +79,6 @@ int board_late_init(void)
 	char icicle_mac_addr[20];
 	void *blob = (void *)gd->fdt_blob;
 
-	node = fdt_path_offset(blob, "/soc/ethernet@20112000");
-	if (node < 0) {
-		printf("No ethernet0 path offset\n");
-		return -ENODEV;
-	}
-
-	ret = fdtdec_get_byte_array(blob, node, "local-mac-address", mac_addr, 6);
-	if (ret) {
-		printf("No local-mac-address property for ethernet@20112000\n");
-		return -EINVAL;
-	}
-
 	read_device_serial_number(device_serial_number, 16);
 
 	/* Update MAC address with device serial number */
@@ -101,10 +89,13 @@ int board_late_init(void)
 	mac_addr[4] = device_serial_number[1];
 	mac_addr[5] = device_serial_number[0];
 
-	ret = fdt_setprop(blob, node, "local-mac-address", mac_addr, 6);
-	if (ret) {
-		printf("Error setting local-mac-address property for ethernet@20112000\n");
-		return -ENODEV;
+	node = fdt_path_offset(blob, "/soc/ethernet@20112000");
+	if (node >= 0) {
+		ret = fdt_setprop(blob, node, "local-mac-address", mac_addr, 6);
+		if (ret) {
+			printf("Error setting local-mac-address property for ethernet@20112000\n");
+			return -ENODEV;
+		}
 	}
 
 	icicle_mac_addr[0] = '[';
-- 
2.43.0

