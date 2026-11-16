Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67294606A322
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Bh0Lx25E;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=lLpBzbLG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 450B88104B;
	Mon, 16 Nov 2026 17:35:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pryp4Kd25UyM; Mon, 16 Nov 2026 17:35:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8444181036
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850558;
	b=mr7DyuF/OO1XD3U3jkmPTcDwYLiIYnCI4JNpTg0FHC7f1k94rdHDADIowGFPNzTGMC5i
	 B4cCMPIdX6C8VwICENr0m9RR5oOjNJuhN4hiunkyluqYNnxZZoW6287nubQvyW8Gn5lIN
	 aN1w41X+txYh2I+BaQB/sYGFCJuk68Em+Lux3Ughl/QZwt+4IqgiTrHiFFN1PQVVYv87F
	 lsJtBp6rtIfeJQfm8nGnjo+QxCgYekpR2hgkRC4lGrswqcqcSsOcira9Ud6jbioGBM2fI
	 /oZbuZUXd80NcGEdpRUS9yoaMUdmsadwbex2U3ib52RLjq+qEohlhs5T6d+uUNXHrUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850558;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=voJL0ipbVIkuAzi4mB5wqobKI4sMOWsa4Ducoe1pLsE=;
	b=W4vYN7ryBmbx9pGYzLDlIrkG+jYDxZQ2AgL4YtIHvPBMTZMeKW5coQircrPXwSsSjXFY
	 pFlcNhYicNFCpzy+ic6s+ahoY0ecytuyv8W+F8hfsOcTc7BinN7inzYqKG5jaGk7i+EOK
	 7NE4IHrqX4pvUfXaQxxtyDtG297saemPwX2ytlcl4+1Ni9fnwPZY4huNY/ptss2bOniej
	 /2nusMNRtu49EIKcUAwfnkSG2RKAfiPZ0SfM9qwGTLUSneBZ4C992nx2tNHE2ZNzHkaxd
	 ObkK+kmcJt/W3jZnpWPh5CQ/nVvno9yg77vBxFN/tnr+5eic5kSDLF/JLRQsOSnjv4g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=lLpBzbLG;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850558;
	bh=voJL0ipbVIkuAzi4mB5wqobKI4sMOWsa4Ducoe1pLsE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Bh0Lx25E3lY5eHiPYRSgRPVlffMEXH9gEbI0zmIa6kD3w+qAcGTl4Z+ZPgHVQYQKp
	 Hwv9vgifJpOcPXfjqpADBdtSDIrzDUJbNb/yf7NX2+rUKAHRAaIpmI8TIp7e27ihCD
	 LnF/gLidopFP4bz1HyL8X+Y9uFRVeqvWbFnVi5hUVmJZPZUl5dTcu0BxSWwNxjrO5X
	 BxKHrpvcdh4kFI5UrT0w7m/MhCJ9ESbqfH08f6RzQzhtxZMlmd5DZA/Ngi0Wu6s/N0
	 h6PDAflGWngkRrZ20F8LkrQT6fL6yNUGWRQggUugjJOloRw/2RPD/888GxMsmSBv0k
	 un7ElLEtpF2Nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8444181036;
	Mon, 16 Nov 2026 17:35:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D7701E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1FCD18104D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BIqRBVc-DFEC for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:35:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2B4A28104B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=lLpBzbLG
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B4A28104B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:55 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jSw4l4GQ0zMlDm;
 Mon, 16 Nov 2026 18:35:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=voJL0ipbVIkuAzi4mB5wqobKI4sMOWsa4Ducoe1pLsE=;
 b=lLpBzbLGxl8Wx5oAiqB7Mh8C9GoUbl+bYJzaUCa0eGVWp2Q+QKyBuBuCfVOwDtZXBaoFC3
 7EOJxaOdknMwc/yiPY0lIeXBy3/2acOwdblFif1r0kgnXjovFnNIMPgmZw7+/TDkYf+WVr
 mmwNcmR/8LsGiDvn9yf9ukX1MAmi5adlAcQwni+QWs+LTqBi7I0HFg084HPumS9EUyjorZ
 wRO/d5Xl7aO4jf25M/gmWEixE6XdsKEEzDplIUYKl/euHrzI0wICn4cAfM/XZOUc2FjEKz
 tiKg13Wv0L8S7/l/H2fnWsKMdYvoTMNuUswUMqMi5ITIuzeYjFklEmUTsuESSQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/20] clk: altera: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:40 +0100
Message-ID: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: giyjmcjsr71zc9omgremqdq53ct6mcu6
X-MBO-RS-ID: 42a5bfd8fad802e29ff
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/altera/clk-agilex.c  | 2 +-
 drivers/clk/altera/clk-agilex5.c | 2 +-
 drivers/clk/altera/clk-arria10.c | 2 +-
 drivers/clk/altera/clk-mem-n5x.c | 2 +-
 drivers/clk/altera/clk-n5x.c     | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
index 426f400159c..b29a7ee145f 100644
--- a/drivers/clk/altera/clk-agilex.c
+++ b/drivers/clk/altera/clk-agilex.c
@@ -784,7 +784,7 @@ static int socfpga_clk_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
-static struct clk_ops socfpga_clk_ops = {
+static const struct clk_ops socfpga_clk_ops = {
 	.enable		= socfpga_clk_enable,
 	.disable	= socfpga_clk_disable,
 	.get_rate	= socfpga_clk_get_rate,
diff --git a/drivers/clk/altera/clk-agilex5.c b/drivers/clk/altera/clk-agilex5.c
index 92b91a9dfc8..3a5ac3a3e8e 100644
--- a/drivers/clk/altera/clk-agilex5.c
+++ b/drivers/clk/altera/clk-agilex5.c
@@ -733,7 +733,7 @@ static int socfpga_clk_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
-static struct clk_ops socfpga_clk_ops = {
+static const struct clk_ops socfpga_clk_ops = {
 	.enable		= socfpga_clk_enable,
 	.get_rate	= socfpga_clk_get_rate,
 };
diff --git a/drivers/clk/altera/clk-arria10.c b/drivers/clk/altera/clk-arria10.c
index 081f8f2b7aa..fb409d1094c 100644
--- a/drivers/clk/altera/clk-arria10.c
+++ b/drivers/clk/altera/clk-arria10.c
@@ -170,7 +170,7 @@ static ulong socfpga_a10_clk_get_rate(struct clk *clk)
 	return rate;
 }
 
-static struct clk_ops socfpga_a10_clk_ops = {
+static const struct clk_ops socfpga_a10_clk_ops = {
 	.enable		= socfpga_a10_clk_enable,
 	.disable	= socfpga_a10_clk_disable,
 	.get_rate	= socfpga_a10_clk_get_rate,
diff --git a/drivers/clk/altera/clk-mem-n5x.c b/drivers/clk/altera/clk-mem-n5x.c
index 149e3016dd3..595daec9f7c 100644
--- a/drivers/clk/altera/clk-mem-n5x.c
+++ b/drivers/clk/altera/clk-mem-n5x.c
@@ -114,7 +114,7 @@ static int socfpga_mem_clk_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
-static struct clk_ops socfpga_mem_clk_ops = {
+static const struct clk_ops socfpga_mem_clk_ops = {
 	.enable		= socfpga_mem_clk_enable
 };
 
diff --git a/drivers/clk/altera/clk-n5x.c b/drivers/clk/altera/clk-n5x.c
index 6fdc4e11baa..742d365966e 100644
--- a/drivers/clk/altera/clk-n5x.c
+++ b/drivers/clk/altera/clk-n5x.c
@@ -592,7 +592,7 @@ static int socfpga_clk_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
-static struct clk_ops socfpga_clk_ops = {
+static const struct clk_ops socfpga_clk_ops = {
 	.enable		= socfpga_clk_enable,
 	.disable	= socfpga_clk_disable,
 	.get_rate	= socfpga_clk_get_rate,
-- 
2.53.0

