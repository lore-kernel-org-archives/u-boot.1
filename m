Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492B9CA0FED
	for <u-boot@archiver.kernel.org>; Sun,  7 Sep 2025 01:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 306B9838C1;
	Sun,  7 Sep 2025 03:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZUj1zpni";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LRvchaf9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 087E88394E; Sun,  7 Sep 2025 03:01:33 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFAB8837B9
 for <u-boot@lists.denx.de>; Sun,  7 Sep 2025 03:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cKBcB4VtDz9tK1;
 Sun,  7 Sep 2025 03:01:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757206890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2ubiSFdT/P7SYbkoVGusgxRitmEPfh+5mwnBmTQBSH0=;
 b=ZUj1zpniDxlhsy+X9wuyX4UmAIBKuhvlWKW9AznmkpbSaA6YsbcUcWVwQp73+TXVl9dUPT
 +cx0EOnXMJtKTpRpqyfqdAEjfeiB9Qg0qxowWKQAyRYo0MejzC8E/S9QguZGaYoKa4cRUv
 ozPE9hzA4wMfexvs2GLfcKXH3lKW3vxLm/VHSVa+ELoFDld/ZKxO6MeuJZpXnUzmBo1woG
 d9hbuvMtCv06pyEUMiYn/HrDscVpYWdJ/hADRO14eKifBi8X76/1LpLpyAXemBncmq3oHw
 mtbYW0GFbv76ni4KATlReOBECFmF+3VEP3UfLY2KpMltMKQd0KO6RepErWBhQw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=LRvchaf9;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757206888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2ubiSFdT/P7SYbkoVGusgxRitmEPfh+5mwnBmTQBSH0=;
 b=LRvchaf9DdLAOgS8kP1wJhwVLHPMxIv40Xet9ZUHUD+ClIXlOrDg7Ma1qU+9ppS+RBwSPN
 t3csSgsuV8yb9w/n09ty+jsjVjppfqn1Gt1QoZSf6hnYFCf3iBNvnon6kOyaB0YzWI5rfs
 gHWVQz/l1T1h54neojHYmMmjyQeB7AylU/jHlPcFv8kDpf9UiPwMPqkZLvID6g9MBYNuN1
 S6CMPhq6oEg35WKAwUye9KNVJ77m1pAmXqIYUVnYVxvB9M5DCU4jSMOC9FnaSPIpjHtU12
 VSgw1rxl3jp99xXQVJDH0gzVrz7AebkdQ9RuxfaxL3r1PI/+8ntOzMksKg0aYg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] board: dhelectronics: Check pointer before access in
 dh_get_value_from_eeprom_buffer()
Date: Sun,  7 Sep 2025 03:00:46 +0200
Message-ID: <20250907010103.667681-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fabf295522fba346cee
X-MBO-RS-META: 3m47j87begzxjkiyhyp6t6oqdtbcm3g3
X-Rspamd-Queue-Id: 4cKBcB4VtDz9tK1
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

The eip pointer in dh_get_value_from_eeprom_buffer() might be NULL.
The current NULL pointer check happens too late, after the eip was
accessed in variable assignment. Reorder the two, so the NULL pointer
check happens first, and any access second, otherwise the access may
trigger a hang or other undefined behavior.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 board/dhelectronics/common/dh_common.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/board/dhelectronics/common/dh_common.c b/board/dhelectronics/common/dh_common.c
index 9f8e5754d8c..aeabd617374 100644
--- a/board/dhelectronics/common/dh_common.c
+++ b/board/dhelectronics/common/dh_common.c
@@ -131,14 +131,17 @@ int dh_read_eeprom_id_page(u8 *eeprom_buffer, const char *alias)
 int dh_get_value_from_eeprom_buffer(enum eip_request_values request, u8 *data, int data_len,
 				    struct eeprom_id_page *eip)
 {
-	const char fin_chr = (eip->pl.item_prefix & DH_ITEM_PREFIX_FIN_BIT) ?
-			     DH_ITEM_PREFIX_FIN_FLASHED_CHR : DH_ITEM_PREFIX_FIN_HALF_CHR;
-	const u8 soc_coded = eip->pl.item_prefix & 0xf;
+	char fin_chr;
+	u8 soc_coded;
 	char soc_chr;
 
 	if (!eip)
 		return -EINVAL;
 
+	fin_chr = (eip->pl.item_prefix & DH_ITEM_PREFIX_FIN_BIT) ?
+		  DH_ITEM_PREFIX_FIN_FLASHED_CHR : DH_ITEM_PREFIX_FIN_HALF_CHR;
+	soc_coded = eip->pl.item_prefix & 0xf;
+
 	/* Copy requested data */
 	switch (request) {
 	case DH_MAC0:
-- 
2.50.1

