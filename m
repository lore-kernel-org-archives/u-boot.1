Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C98E6400F
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 03:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B683807C0;
	Sun,  5 Apr 2026 05:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qxN21goE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wEFe28wH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93B9484020; Sun,  5 Apr 2026 05:53:18 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4C1380433
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 05:53:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fpJTS2vf9z9t3P;
 Sun,  5 Apr 2026 05:53:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775361196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pgwLsoUpwiLhSbfQ7pTaXrZ0cOBMXm4pSdaSVxKQrPU=;
 b=qxN21goE/BE6VkpPi/CjDRPbN1CB9A2flpKbMrKufm5XA0zPs8Bxed8Q0FCQ7NuiMyRYTq
 LvIOaskLfeTljQcA++IIN+6ZoUSfpHdLwem4m03pULL+otIC8qIiGFZ6puyK6o5xlZPgIH
 gh/1XjlYCiouNIBPjsUCVPe0UADlakn01HqHvZlZnI5sNXMtRPKNsmnM7nL8UPI+CIzJaT
 lN7pnpar6P7hMi1qogZMycVJMKTRV5P4xFWY/ObDn5qun0EndgTlx7p9peUY6KVCMF8zKD
 AWZnAmEvkIci0s12Qwn+1NTdTj0AIr6G9CU16oFmyuLuR33QUw7sb3Ce62gPCg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=wEFe28wH;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775361195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pgwLsoUpwiLhSbfQ7pTaXrZ0cOBMXm4pSdaSVxKQrPU=;
 b=wEFe28wHhOc+GPcCuwB0kvl+8zU9sDwS9IKBmET6eYVbpXrT7241KyQ7ECGBZY1fjgets4
 CYsu2MPD5i9mT89zpERe7pEOO7s3m+2BeXJ+wA8bIxNJqf7jS8zqFzcWmEXSri/cPvk6zy
 3kjBhQxAHFNtLGnsNJG9fzUyOGJDHmk4n1BlSphrsXiMLbIv5EcQVvsNzo9EjabMcjwDyj
 hzq1kasgDEvEz1aRf7dMJeWkGZB64eWwNb8mubnvjVN+jDENoe4134XzgCusxzh/zZP8SG
 LouVD47o/dPfZni2Y+2sR2qgj+hkxuSxU5IcKaV+5fBcitgb4sBpVm6W7d3ndQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Enable SMC command on all R-Car 64-bit systems
Date: Sun,  5 Apr 2026 05:53:03 +0200
Message-ID: <20260405035313.348469-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9ks7z4rpn76yghjoi4sbcse6spbn7a1a
X-MBO-RS-ID: 3fb2a1562ef75275443
X-Rspamd-Queue-Id: 4fpJTS2vf9z9t3P
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

Enable the 'smc' command on all R-Car 64-bit systems. This command is
useful for interacting with EL3 firmware, testing interaction with the
PSCI provider or OPTEE-OS.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/renesas_rcar64.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/renesas_rcar64.config b/configs/renesas_rcar64.config
index c2cb88dc157..554fcdebad8 100644
--- a/configs/renesas_rcar64.config
+++ b/configs/renesas_rcar64.config
@@ -1,6 +1,7 @@
 #include <configs/renesas_rcar.config>
 
 CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_SMC=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_TEMPERATURE=y
 CONFIG_DM_THERMAL=y
-- 
2.53.0

