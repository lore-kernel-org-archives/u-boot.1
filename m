Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7E2C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:21:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30366887D3;
	Sat, 13 Jul 2024 15:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qjSEbqOm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YLv/6Uo0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D967887D3; Sat, 13 Jul 2024 15:21:10 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3E0D86E40
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WLpxv4B0zz9scS;
 Sat, 13 Jul 2024 15:21:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RGvC8nx1Y0x+PqADKexzaqjDG9qmfk2acvLxt7PcFI0=;
 b=qjSEbqOm5T2dKMb2A6Zj+rqi9uDtIoq007Lhk8M0O4ps/kZ5WC0IFrrTMxqXmXF5yKNr23
 Dl+aG6YwmlEZ3/+D8p0/wYQfUw+7yiEL+52meW+Dst8qhOYttGprLHq5Xif/7XxlVDviiO
 6UU6VHWMymejqAYRGykK4UPpIdRti8PnJCLGrGtLrQBSnJsdf2ZYZwjZPiz0KieSNBWFON
 LtRZAHU5WfTjGenm56OWoMd9oxgKDecGnZ9S5ZgeQ7SfADTkKv6ZiKS1f5vLWz7WC4o4TG
 Mf/PpV/wtjj7RUQ1+ATXpEgzxfYawziuxqLuCPGaW8rYPmPgZJbHU1RALkmRoQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RGvC8nx1Y0x+PqADKexzaqjDG9qmfk2acvLxt7PcFI0=;
 b=YLv/6Uo0qKLlz+aSQ3noDLCCOMzWljl7NZq0bji/CE0HavHuEASt2hYkRa77rdAj5zGWHi
 ld4cMAXdwNiX2puIu+/jB4XPrO5JpyjDsw2xSL3uzx3RoqGfnlvOzKKMJdVJq4DVC4L/yy
 DdqmCzfFx5hpKQ0mXYGpyqUOR3adhMwLZXRshR8rHTfYZp55tSWvwusF6Etz7pHH76rlaI
 EMT7EuwFC4lf7ODgNRpSuMqECy7qb7IiNYzhRUeWpKJs0oFLVvgftc2WCM1ezvMJlUGo87
 OdV2VvEDIXNIuzFPIywCDOAQOw9Heosda7NxkbfdaaRYCaSurv/9RPKvcfnlGw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/45] api: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:18:52 +0200
Message-ID: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f74ffa91ddec2149c73
X-MBO-RS-META: xykjtjrenx4si96uqdqxtw1bnibe6i3g
X-Rspamd-Queue-Id: 4WLpxv4B0zz9scS
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
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 api/api.c         | 6 ------
 api/api_storage.c | 8 --------
 2 files changed, 14 deletions(-)

diff --git a/api/api.c b/api/api.c
index d22132f62fe..b892c5c278a 100644
--- a/api/api.c
+++ b/api/api.c
@@ -180,7 +180,6 @@ static int API_get_timer(va_list ap)
 	return 0;
 }
 
-
 /*****************************************************************************
  *
  * pseudo signature:
@@ -230,7 +229,6 @@ static int API_dev_enum(va_list ap)
 	return 0;
 }
 
-
 static int API_dev_open(va_list ap)
 {
 	struct device_info *di;
@@ -262,7 +260,6 @@ static int API_dev_open(va_list ap)
 	return err;
 }
 
-
 static int API_dev_close(va_list ap)
 {
 	struct device_info *di;
@@ -297,7 +294,6 @@ static int API_dev_close(va_list ap)
 	return err;
 }
 
-
 /*
  * pseudo signature:
  *
@@ -376,7 +372,6 @@ static int API_dev_write(va_list ap)
 	return err;
 }
 
-
 /*
  * pseudo signature:
  *
@@ -462,7 +457,6 @@ static int API_dev_read(va_list ap)
 	return 0;
 }
 
-
 /*
  * pseudo signature:
  *
diff --git a/api/api_storage.c b/api/api_storage.c
index 3d2d9d6ef4c..c663e7df942 100644
--- a/api/api_storage.c
+++ b/api/api_storage.c
@@ -26,7 +26,6 @@
 
 #define errf(fmt, args...) do { printf("ERROR @ %s(): ", __func__); printf(fmt, ##args); } while (0)
 
-
 #define ENUM_IDE	0
 #define ENUM_USB	1
 #define ENUM_SCSI	2
@@ -144,7 +143,6 @@ static int dev_stor_get(int type, int *more, struct device_info *di)
 	return found;
 }
 
-
 /* returns: ENUM_IDE, ENUM_USB etc. based on struct blk_desc */
 
 static int dev_stor_type(struct blk_desc *dd)
@@ -159,7 +157,6 @@ static int dev_stor_type(struct blk_desc *dd)
 	return ENUM_MAX;
 }
 
-
 /* returns: 0/1 whether cookie points to some device in this group */
 
 static int dev_is_stor(int type, struct device_info *di)
@@ -167,7 +164,6 @@ static int dev_is_stor(int type, struct device_info *di)
 	return (dev_stor_type(di->cookie) == type) ? 1 : 0;
 }
 
-
 static int dev_enum_stor(int type, struct device_info *di)
 {
 	int found = 0, more = 0;
@@ -293,7 +289,6 @@ static int dev_stor_is_valid(int type, struct blk_desc *dd)
 	return 0;
 }
 
-
 int dev_open_stor(void *cookie)
 {
 	int type = dev_stor_type(cookie);
@@ -307,7 +302,6 @@ int dev_open_stor(void *cookie)
 	return API_ENODEV;
 }
 
-
 int dev_close_stor(void *cookie)
 {
 	/*
@@ -317,7 +311,6 @@ int dev_close_stor(void *cookie)
 	return 0;
 }
 
-
 lbasize_t dev_read_stor(void *cookie, void *buf, lbasize_t len, lbastart_t start)
 {
 	int type;
@@ -341,7 +334,6 @@ lbasize_t dev_read_stor(void *cookie, void *buf, lbasize_t len, lbastart_t start
 #endif	/* defined(CONFIG_BLK) */
 }
 
-
 lbasize_t dev_write_stor(void *cookie, void *buf, lbasize_t len, lbastart_t start)
 {
 	struct blk_desc *dd = (struct blk_desc *)cookie;
-- 
2.43.0

