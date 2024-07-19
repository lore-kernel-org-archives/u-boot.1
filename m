Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18424C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:31:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A4C388B8C;
	Fri, 19 Jul 2024 12:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="r4/uKxax";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="b6jweISy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6E0788B9D; Fri, 19 Jul 2024 12:30:21 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0843488B4F
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:30:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WQQt331NWz9tXp;
 Fri, 19 Jul 2024 12:30:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uk4DzoNArApLWn/IrTaFP2AJz1WSxaySSjyuEWTS5A=;
 b=r4/uKxaxh/+iEOemYhCOrsyxM3q0+rRR+E5/npzfIdqkMPBbt9cFcqE5DkOW/nZNsJ/wlH
 KCv0PBZXJPQ2TyLKbhU1kz3tg917xOkC3gMpbxaetMkGqnZ99peXbrvUMx21m45j/ITWn2
 sbIwVzC0tVGF3rCN97bD+D79aY3y+ZXCIXc+PelL2ioR1TXFxDbHRYRQR/3+e4kkJd67L5
 KWBJQXkUBuakFy51IJOkFcvym6FLJK0Bn/aTWm7Yy2W4pPhl1JN6NcLMFAOMn4WUZPhmZH
 l/M87ryLPD5ODEanhpGDVCU4zG8T7SJonwBeUj9DZMfebF9jYtJ31spkQC1moQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uk4DzoNArApLWn/IrTaFP2AJz1WSxaySSjyuEWTS5A=;
 b=b6jweISy6LvS6i9uB+FIAIpBHlAGVFbwMV6+NkQlky7AzfpOJH3oSNIXyv88cRkKMb1FQy
 Z5xYappnvjpI3qoBAK5SCnXbqwK20oki960c7IHLO9B4rzQ4suM7hf7umF2YQhqad+PR10
 FNRv6QGHhcypMw3A9K1MCsxaYEqNbwm37abapjsmKDN+hfk7OEYaV4n7yqjNnlhVvsaSIS
 DSZTjfYPw6labOEjtIL2pybz0JAzSk04SZIwIPwafZVnNPGsaBATERF8+okeXSNNcy5Ytr
 EnuaKyQaNm4EtzukCdsSYR6/FeEhJAw/PiXe3pRK/bOdDJzsCW6zXt3upNGCxA==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 07/37] board: cobra5272: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:28:01 +0200
Message-ID: <20240719102934.322997-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
References: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8hibbcqodmpo5usq6z98pthms4gpu4pn
X-MBO-RS-ID: 95d1e5b903256703d7e
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
 board/cobra5272/flash.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/board/cobra5272/flash.c b/board/cobra5272/flash.c
index 157b71da85e..616842e62f4 100644
--- a/board/cobra5272/flash.c
+++ b/board/cobra5272/flash.c
@@ -61,7 +61,6 @@ Done:
 	return;
 }
 
-
 unsigned long flash_init(void)
 {
 	int i, j;
@@ -112,7 +111,6 @@ unsigned long flash_init(void)
 	return size;
 }
 
-
 #define CMD_READ_ARRAY		0x00F0
 #define CMD_UNLOCK1		0x00AA
 #define CMD_UNLOCK2		0x0055
@@ -133,7 +131,6 @@ unsigned long flash_init(void)
 #define ERR   2
 #define TMO   4
 
-
 int flash_erase(flash_info_t *info, int s_first, int s_last)
 {
 	ulong result;
@@ -267,7 +264,6 @@ static int write_word(flash_info_t *info, ulong dest, ulong data)
 	if ((result & data) != data)
 		return ERR_NOT_ERASED;
 
-
 	/*
 	 * Disable interrupts which might cause a timeout
 	 * here. Remember that our exception vectors are
@@ -317,7 +313,6 @@ static int write_word(flash_info_t *info, ulong dest, ulong data)
 	return rc;
 }
 
-
 int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 {
 	ulong wp, data;
-- 
2.43.0

