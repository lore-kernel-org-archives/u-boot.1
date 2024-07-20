Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49653C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08B4888CB6;
	Sat, 20 Jul 2024 14:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UW0DFcxC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DXYm0bQd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C3CB88C6E; Sat, 20 Jul 2024 14:43:58 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B059C88C93
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WR5nm3Mxpz9sjK;
 Sat, 20 Jul 2024 14:43:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ydwBcUo3zfVfp3ehAbuBXi3BFvIEaHzIxDMCO5v2jTY=;
 b=UW0DFcxCw2qvyvChcqA9Ykeqe/4DGR6zOf6PKGK7bzdnaKG8JV+oQFb5CvAUx6tGNe3pYY
 IiZPSFaVUFjBYr1XH/PXEolmMPsYDVyUOVMtyLD9rYdsFF0FRpvY6F+5zqttxRycUeqTcA
 ML8xprR1yT2gfwBs3DB6gfKio8tkdIS1s5eZ52nDn60uurWso7h20KpBdf+yrvVevKdy70
 4A20mBGDDk9eaZh4nF+AI75CLcxGxOMPbpCiVPlyz1a8ILX/3rDFxnW5yu3jNDl01wxLp7
 pjpIuXKCnblcPr/iKnWyGwe9zK36tZZyuN8DWw5V8Pxl8P/d9KWI17LIFq12Xg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ydwBcUo3zfVfp3ehAbuBXi3BFvIEaHzIxDMCO5v2jTY=;
 b=DXYm0bQdRcdfaqTpMb+DJz5Ucil+bHconsepX9g3ugW9fy1kU73uuQMZ+BIayPXCHlwTIf
 MvCtDemLBzo3/D5yZOGxewe5sDcPi6PKp3A7d6PGERlwK2Cu7UgO7hs3sqGMy54W+ErdGw
 RtvURsDMsNhcet7LXISCEuKxy9Colc8HnDuElObiP7Ys++D7v/ldSCKJ4pSkTqVLQZmL0e
 ODbtQa5GgqYGORg0xLAsh2b7SzZO9tCH9gDwqG122s6EoqnsOtAsgzxUX8+P427lC5zxhJ
 F0RjuBZtxSHa4qGqlPQIVzAUjh+pacFHYWdI30cdgpj+1w12YyjJrvf16BG1Gw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 26/40] drivers: remoteproc: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:51 +0200
Message-ID: <20240720124239.7553-26-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 40b11d1d56b4c49ac41
X-MBO-RS-META: i53ushzomc389gxwhjanc5rma7no7cdj
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
 drivers/remoteproc/rproc-uclass.c    | 1 -
 drivers/remoteproc/ti_k3_r5f_rproc.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-uclass.c
index 3ba2b40dca3..e64354dd52f 100644
--- a/drivers/remoteproc/rproc-uclass.c
+++ b/drivers/remoteproc/rproc-uclass.c
@@ -518,7 +518,6 @@ int rproc_is_running(int id)
 	return _rproc_ops_wrapper(id, RPROC_RUNNING);
 };
 
-
 static int handle_trace(struct udevice *dev, struct fw_rsc_trace *rsc,
 			int offset, int avail)
 {
diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
index ef2c1872249..d78b3fa1bbd 100644
--- a/drivers/remoteproc/ti_k3_r5f_rproc.c
+++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
@@ -42,7 +42,6 @@
 #define PROC_BOOT_CFG_FLAG_R5_MEM_INIT_DIS		0x00004000
 #define PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE		0x00008000
 
-
 /* R5 TI-SCI Processor Control Flags */
 #define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT		0x00000001
 
-- 
2.43.0

