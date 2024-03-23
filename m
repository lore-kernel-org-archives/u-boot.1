Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1C7C54E67
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 18:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89C6087D46;
	Sat, 23 Mar 2024 19:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rclb4/XF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2944B87EDF; Sat, 23 Mar 2024 19:07:30 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B730387D87
 for <u-boot@lists.denx.de>; Sat, 23 Mar 2024 19:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 18BE4CE094D;
 Sat, 23 Mar 2024 18:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884C1C433C7;
 Sat, 23 Mar 2024 18:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711217240;
 bh=aHAgSBn+nphHSjHeo6N0OQJ3LUst52GFRP7eOzoptPA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Rclb4/XFYvux1MwY/GotN0yLKIUpyDeLeGhAi+H0eAF98KDTOnzw/oh/u0yzaN1EV
 vKeykVo9twhY/6cSmluSn9fKOZcCjfCWt4lHO57E1Ca3QbObL1KKd8IIj8MPmOlNBz
 AvF4J5n8zggZLHRL54vCanvQgxuR2CxvhsXZMudym6F+fcEonhsqxLSDCb0aGuq1jH
 S/+TCLbPk0rDG8nAynEYxfYp1hfs6ni19mTifjY1V5vLCVDMX30dorOzq8Ev5aAwps
 PfUmgkb//heryAooDwEfTxdsQRkO4PZHS6ANU/pZxwrJ93S8xB6pUqzIX3QR303Mol
 aoaWfyd/cODsw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v2 03/18] arm: mvebu: turris_{omnia,
 mox}: Don't print model two times
Date: Sat, 23 Mar 2024 19:06:56 +0100
Message-ID: <20240323180711.5498-4-kabel@kernel.org>
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

Since commit 8cd4bf7dc9ba ("turris: Use checkboard() instead of
show_board_info()") the model is show two times during boot:
  Model: Turris Omnia
  Model: Turris Omnia

This is because the common function show_board_info() shows it, and
Turris' checkboard() also does.

Remove the second print.

Fixes: 8cd4bf7dc9ba ("turris: Use checkboard() instead of show_board_info()")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 board/CZ.NIC/turris_mox/turris_mox.c     | 5 +----
 board/CZ.NIC/turris_omnia/turris_omnia.c | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/board/CZ.NIC/turris_mox/turris_mox.c b/board/CZ.NIC/turris_mox/turris_mox.c
index 3489bdd74b..1a2f60e3d1 100644
--- a/board/CZ.NIC/turris_mox/turris_mox.c
+++ b/board/CZ.NIC/turris_mox/turris_mox.c
@@ -565,13 +565,10 @@ static void handle_reset_button(void)
 int checkboard(void)
 {
 	int i, ret, board_version, ram_size, is_sd;
-	const char *pub_key, *model;
+	const char *pub_key;
 	const u8 *topology;
 	u64 serial_number;
 
-	model = fdt_getprop(gd->fdt_blob, 0, "model", NULL);
-	printf("Model: %s\n", model);
-
 	ret = mbox_sp_get_board_info(&serial_number, NULL, NULL, &board_version,
 				     &ram_size, NULL);
 	if (ret < 0) {
diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index 6c2d7da528..87e33d88c4 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -933,7 +933,6 @@ int checkboard(void)
 	int err;
 
 	err = turris_atsha_otp_get_serial_number(serial);
-	printf("Model: Turris Omnia\n");
 	printf("  MCU type: %s\n", omnia_get_mcu_type());
 	printf("  MCU version: %s\n", omnia_get_mcu_version());
 	printf("  RAM size: %i MiB\n", omnia_get_ram_size_gb() * 1024);
-- 
2.43.2

