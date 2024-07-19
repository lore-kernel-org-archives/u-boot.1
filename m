Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2131CC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD3DE88BE9;
	Fri, 19 Jul 2024 12:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bKIv6irE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NT3gtGBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35D9388BDB; Fri, 19 Jul 2024 12:50:41 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD66F88BF3
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WQRKT3Rvlz9tXk;
 Fri, 19 Jul 2024 12:50:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gXhr18MzDiWG9vqKkasTJwZxR2VEYCRtI76YbrM8O7Q=;
 b=bKIv6irE7emK5JrsR1+5X9N/LLCWy1t57F/JnMq1XBeWHCOyX2p8fwK2OrmeeQCy8/0mN0
 Bde32gMeoXeVbNwCRLIHTf6xRpxdNEf7vgs5hvvKe3YhnyLRNKm4KWHncpc83BPUrXwSFS
 lQxrj5qNq+4W9u/o1yJAX0mhTt6UGsqiDVKPEpjsd7QY4xrF2I6pOYTwVMr3uf/mxJGYPL
 nAbNLm59qQy+Sm5ri7jIWDSYyVMfnUhsWBY66ayG9Hh6AP330RFo0CcnfoLwUp26gexxdZ
 HZpXO9EA86esMf0A2RXd+wSvWrk/xMgFBPnbGw5DH/W8YmaeQu/ERz056MikIQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gXhr18MzDiWG9vqKkasTJwZxR2VEYCRtI76YbrM8O7Q=;
 b=NT3gtGBsBfxKfdWqOcnBsnBN1mtQJoDR1R6jKMDBMoj9JQj7nBmH8CA6x8uuJCaELLnifl
 b2P1g2dZvD6MKBlmLbLSEMtR8DXi4EkRYRSuQUtpRDoDpXx3Xe841Ziy4qk1/61QdRU1aJ
 c3eMauVHmjR0OzbU+BbMPz/mD0tyyYirn2LBMTTnnYBRbNdadKCnBNN+ZHiJJYnWyQVpMR
 ObBm5XxcoYNy318Gok54mFBW2HaFDukfCQpm/fhs7oMKvZf/xgbF5K4+70ShKYvbh7kjBU
 RbEC+bNi/2RatjEftx3gWE4BhtjDPzkwCRt7ogRCxgy8b06NcHXdQZN9c0E6dg==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 20/37] board: kontron: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:48:57 +0200
Message-ID: <20240719104948.323791-20-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ay51hk4m5qq6er6fsha3d7wx5jwh5y8t
X-MBO-RS-ID: 571e472c493a1993f1a
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
 board/kontron/pitx_imx8m/pitx_imx8m.c | 1 -
 board/kontron/pitx_imx8m/spl.c        | 2 --
 2 files changed, 3 deletions(-)

diff --git a/board/kontron/pitx_imx8m/pitx_imx8m.c b/board/kontron/pitx_imx8m/pitx_imx8m.c
index a908aee9ecc..2ee97169c6f 100644
--- a/board/kontron/pitx_imx8m/pitx_imx8m.c
+++ b/board/kontron/pitx_imx8m/pitx_imx8m.c
@@ -84,7 +84,6 @@ int board_phys_sdram_size(phys_size_t *memsize)
 	return 0;
 }
 
-
 #ifdef CONFIG_FEC_MXC
 #define FEC_RST_PAD IMX_GPIO_NR(1, 11)
 static iomux_v3_cfg_t const fec1_rst_pads[] = {
diff --git a/board/kontron/pitx_imx8m/spl.c b/board/kontron/pitx_imx8m/spl.c
index 475e52f6231..bd5981bf694 100644
--- a/board/kontron/pitx_imx8m/spl.c
+++ b/board/kontron/pitx_imx8m/spl.c
@@ -28,7 +28,6 @@ extern struct dram_timing_info dram_timing_4gb;
 
 DECLARE_GLOBAL_DATA_PTR;
 
-
 static void spl_dram_init(void)
 {
 	struct dram_timing_info *dram_timing;
@@ -89,7 +88,6 @@ int board_mmc_getcd(struct mmc *mmc)
 	return 0;
 }
 
-
 #define USDHC_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE | \
 			 PAD_CTL_FSEL2)
 #define USDHC_GPIO_PAD_CTRL (PAD_CTL_PUE | PAD_CTL_DSE1)
-- 
2.43.0

