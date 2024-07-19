Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD470C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:31:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B87788BA0;
	Fri, 19 Jul 2024 12:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HBx4giCY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TFqZTwrZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B81F188B8A; Fri, 19 Jul 2024 12:30:23 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7833D88B95
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WQQt22136z9snx;
 Fri, 19 Jul 2024 12:30:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tVpPZA5O8nfO7YYwVL0YAJ3o+2wt5ZvTkVkAsiwxnG0=;
 b=HBx4giCYUNp02jJx6cnx/1NwWysBOJWL7Gmmjm3wP5vsx5gaNo/qsPrOX7EjacEMrP9lVc
 Q6GEqanXv2LkLx4sUUEizHyKgNd1FK9+3ph1SCezNEr70K/ssXqwQnVSA9tZAp6N9VFDt/
 VxXcrlmLpSyyryi66FuuV2Y8DP2n3wnxuXD3XDJQC+5blIzjVwpwRG5g3MIEwATMVMXpQ6
 uovAQNEPU7MUWdFQbmguVs3yewyqU2RFHLlTzKaNC4Od9jR0Dig+dJi951l8+pyKWOcnJS
 Mxq2mIezLpEZB7DcuVEQ8ci3MV5vqJO0k4KBzEsXuuVmJqIVhjAHNTrmrTDUhQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tVpPZA5O8nfO7YYwVL0YAJ3o+2wt5ZvTkVkAsiwxnG0=;
 b=TFqZTwrZJQ05r+HhAr+KiBQsKckkmW9/aIqXvRu/KfOeLlW6RLGoQhQqCeCc8MZcV2Q/vF
 twkKgVkkj6kfpgi3HDiqh5O2pRHThkJ3IwizYgVZRELN5f57Ia4RlvoEWVLD/KlpDTzWtr
 wdFBGUNTt4yXMkFky5N+M74VO/aQaw7OD2OZcGgIlcQHFrUoN27VP09yVl1v2z53jtEtQ0
 IvOCaEMmiwZjcwet+Yl74dY8K1zhEesCK9iHE0+csaxXJ3KVOhrfhL24OpMQMg23RKXBgY
 u+AeNdyxfDdm6BceI0eyey1WictkveQo7i2Og8yamoG4Dk1cE5pyVCu4dELneA==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 06/37] board: cadence: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:28:00 +0200
Message-ID: <20240719102934.322997-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
References: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: przahr6z5nm1tt7s3hpnmuy9fk7yc87q
X-MBO-RS-ID: 65ad5d454a739263219
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

