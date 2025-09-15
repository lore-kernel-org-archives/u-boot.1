Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA95CA0EE8
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 00:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AD9983106;
	Mon, 15 Sep 2025 02:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WxWGUGIi";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LF5F7w7s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40AD38313B; Mon, 15 Sep 2025 02:49:32 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ADE58309E
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 02:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cQ5yc72zFz9sWB;
 Mon, 15 Sep 2025 02:49:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757897369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hh2ZU7x7KTOWdTnQPPTp3q4mpPoGNihpOeJ59PkzgbE=;
 b=WxWGUGIi96fhZDu34dyJGnHvb/boid2ugVznnyjLcUbOvzQEM0Qf8vVrzBdl6ioMKkJyLv
 nni3ab2DrEY1KbhZ5KtzS9TrtTnh2fevkDXTuk88xrAWQjVRI3VIyM9EOmqU0tN7C1hlT6
 Rt/BPtb1Mof1Ve90jxxurtEGeFwSHU77JX/wtbL8IfITYWnypCqfuv8s8k3LGKwlkM1mGM
 V/ekS1VC1IjLmWYmBBjJ+dAVthd65VZ+pLnYj+OVswwQlnZiwFeHUjUWwa9wn1d3teHbmA
 vdpopCcIzvslDWz/wao6YzkDYHw7K96tPbLo8FZ5LhWkEblSQ40PeDaov2/78A==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757897367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hh2ZU7x7KTOWdTnQPPTp3q4mpPoGNihpOeJ59PkzgbE=;
 b=LF5F7w7s3myA2D6XZrbwaxK12vJFmhHAaAldvLBptoYKSe1JWvEk98C6yQ6DPuZfrmeVhr
 S5CcPLlhwyJHTRxQ/2rxP+5/4On+4pUk6NFv6Hp2rE5Nj714It3DVMW+G7rNYpovHzCa6m
 bQRh81KVS03AwcE7JZ6rTFR/wpIKAPn0dXD+P9WD7eNRfg57d3NKpTCYYI29LbyX8a2P31
 cdcOX9oU+napgL5TLaFzPnKB/hd0ii3Boec2mRbsSPUKaeijfwoCDUJmdnfYDjxAcFRXmr
 3jwgEIRQlKZoBmU3QHlRi+MefMLGvZuj06HGMolmqiE5uUx1nj0nrxkbTzIeEA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: stm32: Perform node compatible check for KS8851 early
Date: Mon, 15 Sep 2025 02:49:05 +0200
Message-ID: <20250915004915.222325-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1a3acfe2df7c67aaa1a
X-MBO-RS-META: s9dky1i1s57fft7shrkez5ar7o8ns4sy
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

Check the compatible string of ethernet1 node for KS8851 very early on,
before calling uclass_get_device_by_of_path() which might initialize
the device and possibly attempt to configure MAC address into device
which is not KS8851. Doing the compatibility check early prevent this.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 board/dhelectronics/dh_stm32mp1/board.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/dhelectronics/dh_stm32mp1/board.c b/board/dhelectronics/dh_stm32mp1/board.c
index a15348ad7e7..551094b9489 100644
--- a/board/dhelectronics/dh_stm32mp1/board.c
+++ b/board/dhelectronics/dh_stm32mp1/board.c
@@ -85,6 +85,9 @@ static bool dh_stm32_mac_is_in_ks8851(void)
 	if (!ofnode_valid(node))
 		return false;
 
+	if (!ofnode_device_is_compatible(node, "micrel,ks8851-mll"))
+		return false;
+
 	ret = ofnode_get_path(node, path, sizeof(path));
 	if (ret)
 		return false;
@@ -93,9 +96,6 @@ static bool dh_stm32_mac_is_in_ks8851(void)
 	if (ret)
 		return false;
 
-	if (!ofnode_device_is_compatible(node, "micrel,ks8851-mll"))
-		return false;
-
 	/*
 	 * KS8851 with EEPROM may use custom MAC from EEPROM, read
 	 * out the KS8851 CCR register to determine whether EEPROM
-- 
2.51.0

