Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A13C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:57:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75DA688C4D;
	Fri, 19 Jul 2024 12:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="i4EypKOr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dzX+6R1t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6327C88C33; Fri, 19 Jul 2024 12:50:56 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8174288C15
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WQRKp1xQqz9sdB;
 Fri, 19 Jul 2024 12:50:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sBXza+tZ9d9SSWn3pCvyvf+3oLd8mXMMiMN/nisxh8c=;
 b=i4EypKOrOw+49N3kKshJezVJCvTfxuBzPgfRfdI/bXNPN/hoaWaUJygLdGceU09qqliklP
 dP97l6eGBcL/GXz+hqz6h8WHMb5fiK3XALe0Rl4FAQUGqxKDlOLHiRwA7PnVBwZbZpTbkq
 YRaA5cEz6pRAnI4HXLlpjKRxJcbWJCA2iIcMtjh2mcLHJE5W8v5mzNtOFdis0f5VC5DCic
 TR8YLWs6dTsbFQca3APQn40FFU2ATLZNovgYK7QKmS92D4Lpy2+v1aURytPVaHTvO07CGK
 VQC9hXVDMsaUW4eYT5JiFgmMgr/0Ga4f6YvJYpOrKobXlNLpQO5DQ/6kbFxGTA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sBXza+tZ9d9SSWn3pCvyvf+3oLd8mXMMiMN/nisxh8c=;
 b=dzX+6R1t6SKR2bXhpPDtAsC9yREb+Tv8NAIkFiGHGdThvL1bioWkQzmJuehAjoYZTi7CxD
 4xvr1hyFJvl+Rdordcfcy5IBThP+urW5tmuSdOhQ10D2cb7ur6wpdQ8u4SqozugL8HTbAd
 VpcTbv8HLdZHY4BlvKCMSaeYeVJQrEhN4jKk8DTK9axyFrtSRg+JldHq/pTHpbNXmDsRXk
 H0I/1kknnAZVfAV0wS1yR2IZdd2tUphBuJPZh9N+roefaWouK34ZtoLIurf01brhmNjaJU
 difm9TVtkzXA60pxraZiIkBcN6RGftWdqiSdugHKsjhR5S4SRgKewbDzDx1YsA==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 37/37] board: xilinx: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:49:14 +0200
Message-ID: <20240719104948.323791-37-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: nynwerizzwgp7hoedo9tktw1k1erfb9n
X-MBO-RS-ID: 8bd572fa2bc64c27b51
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
 board/xilinx/zynq/zynq-microzed/ps7_init_gpl.c | 2 --
 board/xilinx/zynq/zynq-zc702/ps7_init_gpl.c    | 2 --
 board/xilinx/zynq/zynq-zc706/ps7_init_gpl.c    | 2 --
 board/xilinx/zynq/zynq-zed/ps7_init_gpl.c      | 2 --
 board/xilinx/zynq/zynq-zybo/ps7_init_gpl.c     | 3 ---
 5 files changed, 11 deletions(-)

diff --git a/board/xilinx/zynq/zynq-microzed/ps7_init_gpl.c b/board/xilinx/zynq/zynq-microzed/ps7_init_gpl.c
index 602a789e775..e7f1d6ef5ec 100644
--- a/board/xilinx/zynq/zynq-microzed/ps7_init_gpl.c
+++ b/board/xilinx/zynq/zynq-microzed/ps7_init_gpl.c
@@ -4060,7 +4060,6 @@ unsigned long ps7_post_config_3_0[] = {
     //
 };
 
-
 unsigned long ps7_pll_init_data_2_0[] = {
     // START: top
     // .. START: SLCR SETTINGS
@@ -8263,7 +8262,6 @@ unsigned long ps7_post_config_2_0[] = {
     //
 };
 
-
 unsigned long ps7_pll_init_data_1_0[] = {
     // START: top
     // .. START: SLCR SETTINGS
diff --git a/board/xilinx/zynq/zynq-zc702/ps7_init_gpl.c b/board/xilinx/zynq/zynq-zc702/ps7_init_gpl.c
index 9343683f4d7..48001269cd7 100644
--- a/board/xilinx/zynq/zynq-zc702/ps7_init_gpl.c
+++ b/board/xilinx/zynq/zynq-zc702/ps7_init_gpl.c
@@ -4167,7 +4167,6 @@ unsigned long ps7_post_config_3_0[] = {
     //
 };
 
-
 unsigned long ps7_pll_init_data_2_0[] = {
     // START: top
     // .. START: SLCR SETTINGS
@@ -8483,7 +8482,6 @@ unsigned long ps7_post_config_2_0[] = {
     //
 };
 
-
 unsigned long ps7_pll_init_data_1_0[] = {
     // START: top
     // .. START: SLCR SETTINGS
diff --git a/board/xilinx/zynq/zynq-zc706/ps7_init_gpl.c b/board/xilinx/zynq/zynq-zc706/ps7_init_gpl.c
index 6b153aa3796..76ef5d9323e 100644
--- a/board/xilinx/zynq/zynq-zc706/ps7_init_gpl.c
+++ b/board/xilinx/zynq/zynq-zc706/ps7_init_gpl.c
@@ -4136,7 +4136,6 @@ unsigned long ps7_post_config_3_0[] = {
     //
 };
 
-
 unsigned long ps7_pll_init_data_2_0[] = {
     // START: top
     // .. START: SLCR SETTINGS
@@ -8421,7 +8420,6 @@ unsigned long ps7_post_config_2_0[] = {
     //
 };
 
-
 unsigned long ps7_pll_init_data_1_0[] = {
     // START: top
     // .. START: SLCR SETTINGS
diff --git a/board/xilinx/zynq/zynq-zed/ps7_init_gpl.c b/board/xilinx/zynq/zynq-zed/ps7_init_gpl.c
index 6f2edf16c24..67642798b41 100644
--- a/board/xilinx/zynq/zynq-zed/ps7_init_gpl.c
+++ b/board/xilinx/zynq/zynq-zed/ps7_init_gpl.c
@@ -4026,7 +4026,6 @@ unsigned long ps7_post_config_3_0[] = {
     //
 };
 
-
 unsigned long ps7_pll_init_data_2_0[] = {
     // START: top
     // .. START: SLCR SETTINGS
@@ -8195,7 +8194,6 @@ unsigned long ps7_post_config_2_0[] = {
     //
 };
 
-
 unsigned long ps7_pll_init_data_1_0[] = {
     // START: top
     // .. START: SLCR SETTINGS
diff --git a/board/xilinx/zynq/zynq-zybo/ps7_init_gpl.c b/board/xilinx/zynq/zynq-zybo/ps7_init_gpl.c
index 04d2e5f1375..6a3236ce2d2 100644
--- a/board/xilinx/zynq/zynq-zybo/ps7_init_gpl.c
+++ b/board/xilinx/zynq/zynq-zybo/ps7_init_gpl.c
@@ -4082,7 +4082,6 @@ unsigned long ps7_post_config_3_0[] = {
 	/* */
 };
 
-
 unsigned long ps7_pll_init_data_2_0[] = {
 	/* START: top */
 	/* .. START: SLCR SETTINGS */
@@ -8313,7 +8312,6 @@ unsigned long ps7_post_config_2_0[] = {
 	/* */
 };
 
-
 unsigned long ps7_pll_init_data_1_0[] = {
 	/* START: top */
 	/* .. START: SLCR SETTINGS */
@@ -12477,7 +12475,6 @@ unsigned long ps7_post_config_1_0[] = {
 	/* */
 };
 
-
 #include "xil_io.h"
 
 unsigned long *ps7_mio_init_data = ps7_mio_init_data_3_0;
-- 
2.43.0

