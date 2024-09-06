Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E103EE6FE34
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 17:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7662188CD8;
	Fri,  6 Sep 2024 19:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nguyzOao";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pnWs7l6r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0349388D2D; Fri,  6 Sep 2024 19:12:53 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27226885F5
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 19:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4X0jTt6bdlz9t1T;
 Fri,  6 Sep 2024 19:12:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725642770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mx8MalJChVuhgc5vE9XZBEN8rrNND16DV6TWMeC95kQ=;
 b=nguyzOaovDggqdwh3mwYlrqK8ehvTJupTZc3BmvaEhJDWN5NcAtTq86SrdDzEHlIoQmYS8
 Vdpvc18Fnh2zUNff6IRoQ+8X2XycVLj6M/vm5EhZmVkhkmxtW14Gp77JOKO6IbEuYzoSQQ
 el0W9rs+skV5AI3us0/N8I5tQnvLZpAlFEpB1PVTSEjYlGIQVtAgJvFc6VdwgNsqJdy+7F
 l7uyFjdrdhLwwB+/TIbAQ6Oq8AfP89S8La/QwPkNsPA0AvinEZmJLW/QhBtjxfojDseVxF
 imFJKjulNTpTLvMGz5W0l4vm7aCesdFi3noL5RUgldXkIqNNjNugOZZsGJEwkw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725642769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mx8MalJChVuhgc5vE9XZBEN8rrNND16DV6TWMeC95kQ=;
 b=pnWs7l6rc6+XWUfW3b3r/C/TatBUkgJZBM66Qeswfa7x8F3dbIiJrKa9WzNsmlkVNqXq2q
 lv2C4VLNhhyyB+9vYXtfo7DkUg4hLwr5TCxdpSrUcbY4RM/rMqkkkN2SWhjaUAWv+lHhzx
 KR+FYaWP1DTl9+510DsUUMBwjhRUw3oHGMNbfvtDegwXO8IX4Socm0pk5KC6OI077RgosJ
 pr9bBQpx8bAtsUHH8q3TYp/b0joGz/pHUapuLZv8gSDUZX2PDc4tQDNY0ZV4OwLr0KUfZL
 6CCIhG1JHz1fg7BM0ySlWIxHx6AAe0pp8PV9NAi2SkPPuriQgT1MTww85alUSg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] cmd: osd: Depend on OSD
Date: Fri,  6 Sep 2024 19:12:23 +0200
Message-ID: <20240906171235.91502-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: obtp68183t97yps57w6qddso89csi58e
X-MBO-RS-ID: cc240593c5f59b13ff1
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

The OSD command calls functions from video_osd-uclass.o ,
which is built only when CONFIG_OSD is enabled. Add the
missing dependency into Kconfig.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 43f78a5aeb1..8d1762c4e11 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1494,6 +1494,7 @@ config USE_ONENAND_BOARD_INIT
 
 config CMD_OSD
 	bool "osd"
+	depends on OSD
 	help
 	  Enable the 'osd' command which allows to query information from and
 	  write text data to a on-screen display (OSD) device; a virtual device
-- 
2.45.2

