Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290FEC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E38788B92;
	Fri, 19 Jul 2024 12:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="clg13V5s";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WpMH+gSk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACAB688BA6; Fri, 19 Jul 2024 12:30:23 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABE7888B8A
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:30:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WQQt43CP7z9sdB;
 Fri, 19 Jul 2024 12:30:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XlMWaxvb+kO2x0aRuu7nrmTHw8gWfha3ZvhfvPdcm4E=;
 b=clg13V5sBH93x1N4Ek2nVDxnbBH+2do8eZyvJ75k90VfZzhpJncI5RDs+peMnHQKvCaB5t
 eNmaCIHpwj/cXjwBmHqm9/94I1l6VxrBD4EFyBSz6x9N+OGAZbX3+7EtNTT3UL4aAYc4Xl
 OGA/L9/qDuur+HEm4vst+ELuRDd1JBbVl/Q93fYo4kGM1pWIvukDcLVNm5FSRZIhOAGpL4
 opI1Ncu4rJVlss2kK+gclpJsvZVCXEau0oHP8GRi7kfXvnunJ+tyPO4zFdf3DWaW746IFU
 G6bHRqrMlgJhAolRWeIlseMDxuSsVcxoQFB7HExhn71KNE/MrGrHxQANpEg7tA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XlMWaxvb+kO2x0aRuu7nrmTHw8gWfha3ZvhfvPdcm4E=;
 b=WpMH+gSkVdttWDzV9VP2uvOL9X8nBRcPrZtT+l9s1Tu4PnBLKmLDu/k36x4oE36Rjpb7bq
 l7AkKL4B72OQdNgT+lLFdfZQXO/lZBBc4u/xG+i1qFYHJFWw7beLkvgqnds0+KOYOCy85u
 felOX+MhuS9DxP9PIRj/RnYtZFoLsHcoPrIkvl0p2zbtnp6aWdERylU3b/F1h0kJB2J8Pd
 re5S6UUS0fzdAuT+ZQ7Mpf509C+zsLHHu+g0j9hwjwYjbnQKS4ITKZIBEPg//yxQd0eGHT
 JEU7bCblUykBDhirHboKCemIhcbLypMM7tTicxiWVPQIltyaxwyOtsnE+16DgA==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 08/37] board: compulab: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:28:02 +0200
Message-ID: <20240719102934.322997-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
References: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qe7xnukkmr9tshg933hj7uzcn1c4gpcg
X-MBO-RS-ID: 3cf376d4351677d19e6
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
 board/compulab/cm_fx6/cm_fx6.c | 1 -
 board/compulab/cm_fx6/common.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/compulab/cm_fx6/cm_fx6.c b/board/compulab/cm_fx6/cm_fx6.c
index 4a6cc3e5630..c6d33c32ccd 100644
--- a/board/compulab/cm_fx6/cm_fx6.c
+++ b/board/compulab/cm_fx6/cm_fx6.c
@@ -252,7 +252,6 @@ I2C_PADS(i2c2_pads,
 	 PAD_GPIO_6__GPIO1_IO06 | MUX_PAD_CTRL(I2C_PAD_CTRL),
 	 IMX_GPIO_NR(1, 6));
 
-
 static int cm_fx6_setup_one_i2c(int busnum, struct i2c_pads_info *pads)
 {
 	int ret;
diff --git a/board/compulab/cm_fx6/common.h b/board/compulab/cm_fx6/common.h
index debef15880f..17b56ddc283 100644
--- a/board/compulab/cm_fx6/common.h
+++ b/board/compulab/cm_fx6/common.h
@@ -31,6 +31,5 @@
 #define CM_FX6_SATA_NRSTDLY	IMX_GPIO_NR(6, 6)
 #define CM_FX6_SATA_PWLOSS_INT	IMX_GPIO_NR(6, 31)
 
-
 void cm_fx6_set_usdhc_iomux(void);
 void cm_fx6_set_ecspi_iomux(void);
-- 
2.43.0

