Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0292C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD24388B80;
	Fri, 19 Jul 2024 12:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="R1IRmE+m";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="R1IRmE+m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CB7D88BA9; Fri, 19 Jul 2024 12:50:24 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E0CF87E96
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WQRKB14dVz9tXk;
 Fri, 19 Jul 2024 12:50:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tVpPZA5O8nfO7YYwVL0YAJ3o+2wt5ZvTkVkAsiwxnG0=;
 b=R1IRmE+mCsiJUBNEQpgNcYbrXZCfRy3TEW478c7jy9EYnT9XDtd8i6IVvdVWtpmQJfaRwi
 dqZt8fQkxwx6TkPU7g2n9tBmSjKvTYjxmTt2tr5s+1Yi92lH5KF02/GeVgtrkRW7rbLfmK
 hD8aLHS/QUSJ1SJB11O2slM+3TBmt/roPsdg4tgPDF0bKTHqvxbMgGfYBRrJbghahygHUG
 W3lnb+stcYOglc0dBBc4OHJHWt2x0HzCjPIFD8UtItAP/KUElIzrEo1k4C6Ab+PbxFFmBh
 4AfszMdxyxeTMsYBwjMwSWA8l/lu1R55K3xLy9tifgb6y4KTy3xOxhS76dwFlA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tVpPZA5O8nfO7YYwVL0YAJ3o+2wt5ZvTkVkAsiwxnG0=;
 b=R1IRmE+mCsiJUBNEQpgNcYbrXZCfRy3TEW478c7jy9EYnT9XDtd8i6IVvdVWtpmQJfaRwi
 dqZt8fQkxwx6TkPU7g2n9tBmSjKvTYjxmTt2tr5s+1Yi92lH5KF02/GeVgtrkRW7rbLfmK
 hD8aLHS/QUSJ1SJB11O2slM+3TBmt/roPsdg4tgPDF0bKTHqvxbMgGfYBRrJbghahygHUG
 W3lnb+stcYOglc0dBBc4OHJHWt2x0HzCjPIFD8UtItAP/KUElIzrEo1k4C6Ab+PbxFFmBh
 4AfszMdxyxeTMsYBwjMwSWA8l/lu1R55K3xLy9tifgb6y4KTy3xOxhS76dwFlA==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 06/37] board: cadence: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:48:43 +0200
Message-ID: <20240719104948.323791-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1584caa0e97a43f0a41
X-MBO-RS-META: koy3ds71xrfmb76m3fytkquyz9j7tns9
X-Rspamd-Queue-Id: 4WQRKB14dVz9tXk
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
 board/cadence/xtfpga/xtfpga.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/cadence/xtfpga/xtfpga.c b/board/cadence/xtfpga/xtfpga.c
index 6b92fe31c0e..5e6470d771f 100644
--- a/board/cadence/xtfpga/xtfpga.c
+++ b/board/cadence/xtfpga/xtfpga.c
@@ -23,7 +23,6 @@ DECLARE_GLOBAL_DATA_PTR;
  * (Print information about the board to stdout.)
  */
 
-
 #if defined(CONFIG_XTFPGA_LX60)
 const char *board = "XT_AV60";
 const char *description = "Avnet Xilinx LX60 FPGA Evaluation Board / ";
-- 
2.43.0

