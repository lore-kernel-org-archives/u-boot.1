Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B2EC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A16388BE8;
	Fri, 19 Jul 2024 12:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xuWtEBoY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xuWtEBoY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A337788BB5; Fri, 19 Jul 2024 12:50:30 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8656788BC6
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WQRKJ2BCdz9sls;
 Fri, 19 Jul 2024 12:50:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SYruK1VFnf3jLypX6RnU4S5ap1fcobevNtd6Q7nD3PA=;
 b=xuWtEBoYJ7FYflTRjaCgSKX49L/JNAUYvwXY/u+MMKxZ72LJE8YoNHnyy6AGufibAXxsMr
 6csVRsfmvOVU4lWKwXxTn5cu6rVEoiNI73mUSCigByIBDJUSjRbBy9isoK4eYVqXdpQO70
 o1yiGv7YsR2+CH0Y9qQVXCX0ytYd+fb668zoM4KtU+tbTVyyjz/jSfSxV5rOFd6hDfJrSA
 OQAFMXe1scGXKlTAsOEwz/XlqMvg5Gi4gO+gkCWDbu5SBGxuyGjWlpCzyXb3TgEMsWBtcd
 WgjWpNzEgntwy0KRW7FhHmB0e4M/fSvVk1v0987GHavttfqI0IHTQKs1FUFK9Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SYruK1VFnf3jLypX6RnU4S5ap1fcobevNtd6Q7nD3PA=;
 b=xuWtEBoYJ7FYflTRjaCgSKX49L/JNAUYvwXY/u+MMKxZ72LJE8YoNHnyy6AGufibAXxsMr
 6csVRsfmvOVU4lWKwXxTn5cu6rVEoiNI73mUSCigByIBDJUSjRbBy9isoK4eYVqXdpQO70
 o1yiGv7YsR2+CH0Y9qQVXCX0ytYd+fb668zoM4KtU+tbTVyyjz/jSfSxV5rOFd6hDfJrSA
 OQAFMXe1scGXKlTAsOEwz/XlqMvg5Gi4gO+gkCWDbu5SBGxuyGjWlpCzyXb3TgEMsWBtcd
 WgjWpNzEgntwy0KRW7FhHmB0e4M/fSvVk1v0987GHavttfqI0IHTQKs1FUFK9Q==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 12/37] board: dhelectronics: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:48:49 +0200
Message-ID: <20240719104948.323791-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: raz7wthtaeu1xw1eg76hgqgmrnsrmkr4
X-MBO-RS-ID: 7cc853d16de4e10d3f8
X-Rspamd-Queue-Id: 4WQRKJ2BCdz9sls
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
 board/dhelectronics/dh_imx6/dh_imx6_spl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/dhelectronics/dh_imx6/dh_imx6_spl.c b/board/dhelectronics/dh_imx6/dh_imx6_spl.c
index 3a5495ea18e..a50763e1926 100644
--- a/board/dhelectronics/dh_imx6/dh_imx6_spl.c
+++ b/board/dhelectronics/dh_imx6/dh_imx6_spl.c
@@ -541,7 +541,6 @@ static int spl_dram_perform_cal(struct mx6_ddr_sysinfo const *sysinfo)
 	return ret;
 }
 
-
 /* DRAM */
 static void dhcom_spl_dram_init(void)
 {
-- 
2.43.0

