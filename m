Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3658AC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:54:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35C8088C0B;
	Fri, 19 Jul 2024 12:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NEbA7QPs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QliuNdI1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A534688BE9; Fri, 19 Jul 2024 12:50:43 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18CB188BD6
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WQRKX6HbYz9sls;
 Fri, 19 Jul 2024 12:50:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XaT+LS+To0/kxjO40jyvetQxpscGFvwuczsmYYB7YfQ=;
 b=NEbA7QPs6NelGxvGz8muM7+khkKbNj/1yJ4xq7czN6O0bDaUJKFLJtA07Juv1wYmqz1oYP
 cJfHzT2rkYS7AI0AGr0Iu9BHQqZrKGxKNBUhp98j6YZ+6ye3Y4Ze2KL+bS1zaDXNAKYqXx
 LFkHGAeijUg29Qpw0xluOJVE/u/f8s2XwZJjJe+mP4yv+K+v0IG57Q9f+46QOxmrHlmE1O
 DedBKaQ/4hSa7tH4GpA98sFAKyAtCEpIBw6JBTXFrHg1T3+Gs8NpatdWR9KE3lDi8j7pPj
 KIG+o1CNW1xwhiOhvpoqSNH/U3bquvgrE/xx0Gt3xIGGceJz5Yb/yKASbUe8Zg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XaT+LS+To0/kxjO40jyvetQxpscGFvwuczsmYYB7YfQ=;
 b=QliuNdI1vUk+yKkNJpKEYRWG2Q1fD3O99vRYKsLqtUmYIW1bRV+bN6KoWdsvOh+9PmyQ0T
 4YSS2Ko4WkT/aW6VtPNkn0qvQi+nRhMPADiazZ6QEWMDdVO2xsJGDrQWULnSyRMpVVdXCe
 Bixrfq4I3bdgYCC84CfC8rm0ppimhfKmqTEpCwm+++4TS+/c4NjgcUtEw2MPIysja7YDWE
 Rwss6BMcnrK4xswJ9dxctlz8h96rHQhnXIRyPOazPEr/EXmYNXOj8RMMHRIbm14SH4qCaN
 TOmSIqYJOSJRaOezl9heKoo1nj906igOJ+6o/kAxuOwXBMT0ZOtoID86clBC8w==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 23/37] board: mntre: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:49:00 +0200
Message-ID: <20240719104948.323791-23-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4zdonaemym9ehcoijw3n6hso649f75j9
X-MBO-RS-ID: 7fecbc65d6c9cdb703d
X-Rspamd-Queue-Id: 4WQRKX6HbYz9sls
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
 board/mntre/imx8mq_reform2/imx8mq_reform2.c | 2 --
 board/mntre/imx8mq_reform2/lpddr4_timing.c  | 2 --
 2 files changed, 4 deletions(-)

diff --git a/board/mntre/imx8mq_reform2/imx8mq_reform2.c b/board/mntre/imx8mq_reform2/imx8mq_reform2.c
index ebc490e24b1..6ee1c5c52a1 100644
--- a/board/mntre/imx8mq_reform2/imx8mq_reform2.c
+++ b/board/mntre/imx8mq_reform2/imx8mq_reform2.c
@@ -28,14 +28,12 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-
 #define WDOG_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE)
 
 static iomux_v3_cfg_t const wdog_pads[] = {
 	IMX8MQ_PAD_GPIO1_IO02__WDOG1_WDOG_B | MUX_PAD_CTRL(WDOG_PAD_CTRL),
 };
 
-
 int board_early_init_f(void)
 {
 	struct wdog_regs *wdog = (struct wdog_regs *)WDOG1_BASE_ADDR;
diff --git a/board/mntre/imx8mq_reform2/lpddr4_timing.c b/board/mntre/imx8mq_reform2/lpddr4_timing.c
index e5303db0f80..96d2a3fc6c7 100644
--- a/board/mntre/imx8mq_reform2/lpddr4_timing.c
+++ b/board/mntre/imx8mq_reform2/lpddr4_timing.c
@@ -312,7 +312,6 @@ static struct dram_cfg_param lpddr4_fsp0_cfg[] = {
 	{ 0xd0000, 1 },
 };
 
-
 /* P1 message block parameter for training firmware */
 static struct dram_cfg_param lpddr4_fsp1_cfg[] = {
 	{ 0xd0000, 0 },
@@ -352,7 +351,6 @@ static struct dram_cfg_param lpddr4_fsp1_cfg[] = {
 	{ 0xd0000, 1 },
 };
 
-
 /* P0 2D message block parameter for training firmware */
 static struct dram_cfg_param lpddr4_fsp0_2d_cfg[] = {
 	{ 0xd0000, 0 },
-- 
2.43.0

