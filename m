Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E868EC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:50:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF5FD88BA0;
	Fri, 19 Jul 2024 12:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ScQv4qyF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="E8sXSqp3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3207B88B92; Fri, 19 Jul 2024 12:50:22 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B73887E96
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WQRK80XW5z9sRZ;
 Fri, 19 Jul 2024 12:50:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gCX1RGOcNDUEyrHqURr93nw7bbkK1B1oMIme+AJs210=;
 b=ScQv4qyFGpCg6InqYy14H00gBLP02dEgfSCJC64IRC30K6uSfHVMf5v8NLYSprqol32YZz
 mo2KIKSf8PztcS45WQHTyXFjv75vRauwD3mC/gLsIKiWiAegaA/6fYavOpFTNJtHXBK/8X
 NVkWLa5goB1DML9qpfZ+yzZWVsOwvLnFeBinehDAqiz9BUWHmm/9qsqeny6GAWE2CwGNPk
 gecO3SeUKDau9dz4stL88Qdhz+VMUE9ouRF+Ix60jHma5RNeppLFcE9i9GJCA7xaAK8Nml
 dOuyETI6Pjm6bbcv9o7UuLItDB3yipO19ZCUgobM7z5vGX2xJ2wi7X02Z4HmGQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gCX1RGOcNDUEyrHqURr93nw7bbkK1B1oMIme+AJs210=;
 b=E8sXSqp35H134Fm4AaJBGvBt4Io55ZE/zOYhODpLvcdyjEZ8RzWYZH0NtkmCQCvGNyK7Cb
 nuICuK+N6yZfSqYIw/kMn35HBY/CsUKqcCytC8CPjj+16X19v3t4WMuebP+4TlKWCiB+Lm
 zNPvdVSkmyfTTb5UFe2LnimKA8LOeS+grpB9oe/lhY+3Gw/i6VDI6Q0wD8mjJnuTK06Mr1
 an8c1qDnVF3MpJrchgZQEH8AJ1kgXGLdEnQkY6k313dNgBW2Yawa2vcmf+8WooXaZSc6TT
 EEu+k6R9xZ+RSIeOrCmJ/4GzPvPDBcJtzQAGH9HM6VOpWRIRkM88FRdcMsnr6A==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 04/37] board: aries: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:48:41 +0200
Message-ID: <20240719104948.323791-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4o5qr3hfn1mq1o9wj4dyqdkj67icxabh
X-MBO-RS-ID: 2b6d9a89965791a67c5
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
 board/aries/mcvevk/qts/iocsr_config.h | 1 -
 board/aries/mcvevk/qts/pll_config.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/aries/mcvevk/qts/iocsr_config.h b/board/aries/mcvevk/qts/iocsr_config.h
index dbcc1d719d4..3084c6a4eb8 100644
--- a/board/aries/mcvevk/qts/iocsr_config.h
+++ b/board/aries/mcvevk/qts/iocsr_config.h
@@ -655,5 +655,4 @@ const unsigned long iocsr_scan_chain3_table[] = {
 	0x00004000,
 };
 
-
 #endif /* __SOCFPGA_IOCSR_CONFIG_H__ */
diff --git a/board/aries/mcvevk/qts/pll_config.h b/board/aries/mcvevk/qts/pll_config.h
index 62cf6796afc..fc1ba89819a 100644
--- a/board/aries/mcvevk/qts/pll_config.h
+++ b/board/aries/mcvevk/qts/pll_config.h
@@ -80,5 +80,4 @@
 #define CFG_HPS_ALTERAGRP_MAINCLK 3
 #define CFG_HPS_ALTERAGRP_DBGATCLK 3
 
-
 #endif /* __SOCFPGA_PLL_CONFIG_H__ */
-- 
2.43.0

