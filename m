Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D8CC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 351AB88C3F;
	Fri, 19 Jul 2024 12:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PyEwXe38";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nv1t02IU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A766388C10; Fri, 19 Jul 2024 12:50:50 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D589388BD7
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WQRKh4dV4z9tXk;
 Fri, 19 Jul 2024 12:50:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ry/REQKcKuOwr5cidgUpiVYqkCXi2IjVyibE3dOi3+A=;
 b=PyEwXe38IQdw0QsFty2K2LHwdS37FJ0fcmqcH0ISJ+04TlQ4bSV+8jOr2A+QFF2XyCSeqz
 sgbQUKu9J0BuX4mjGN2qYBqz/epcir78maWJ97ucb8yopSlGK0or5skSfBcLOR3MAiJt7K
 /MlE9MiRP7Bx2YF5aSeXYGs35vV6OBVgrwBiWXbGsxzVf/BBJKHHQ8yZ1vG1SruYSnTD53
 /30dc+sS3uYsJk8SySYkDj96loxoKM1upfSpzLQIZrnDgRK8ykv65mekOW+YO+a9LI4xop
 wyz3Pe6kkuwerCD0eq7cl10GL+M7mrHyDFvQUpC+NzhPZxZ50mOZpcuomYkwRQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ry/REQKcKuOwr5cidgUpiVYqkCXi2IjVyibE3dOi3+A=;
 b=nv1t02IUkxMjC1u7/R8w+P43Dcv1PfyjQscDbSCSd8Dp+RG+PXihSeuUYx6YPQLBlzSbLp
 qlstwziSeSTajQT2geizShZ3u5yRQ6iOK0fC6rv2p6i56TyLyeby3kSQPLINExWMyZcUiz
 Mt1Yg1ZjSjsNAinbzDDLByOCXcDDLTmtX3CW//Pqlc88HMF0msJ8fA1THSt18recccjtQS
 LVaAWDNsGzgYWqCU63J0BV1WBp4xcsvwAXLUGAiA+YfUtvMK9Lf49bXOTH11anFZrSvohK
 f6l7d8aLIQ2ZGkpqCns9vKur+9Q539hffu4zqiY9tnLILK4S0cl8/T4f1lAKKQ==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 31/37] board: tcl: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:49:08 +0200
Message-ID: <20240719104948.323791-31-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 54960a2d49ffe023b91
X-MBO-RS-META: ki3kn44pnqik999313dusob4oygxn85a
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 board/tcl/sl50/board.c | 1 -
 board/tcl/sl50/mux.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/tcl/sl50/board.c b/board/tcl/sl50/board.c
index 2e54ede62d6..484b4e24428 100644
--- a/board/tcl/sl50/board.c
+++ b/board/tcl/sl50/board.c
@@ -348,7 +348,6 @@ int board_eth_init(struct bd_info *bis)
 			eth_env_set_enetaddr("eth1addr", mac_addr);
 	}
 
-
 	writel(MII_MODE_ENABLE, &cdev->miisel);
 	cpsw_slaves[0].phy_if = cpsw_slaves[1].phy_if =
 				PHY_INTERFACE_MODE_MII;
diff --git a/board/tcl/sl50/mux.c b/board/tcl/sl50/mux.c
index 6d89c4a3998..2e2bd63f870 100644
--- a/board/tcl/sl50/mux.c
+++ b/board/tcl/sl50/mux.c
@@ -107,7 +107,6 @@ static struct module_pin_mux mii1_pin_mux[] = {
 	{-1},
 };
 
-
 void enable_uart0_pin_mux(void)
 {
 	configure_module_pin_mux(uart0_pin_mux);
-- 
2.43.0

