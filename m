Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00253C67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 18:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84D1E87EA9;
	Tue,  9 Apr 2024 20:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="X5HOkUqH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C06387F01; Tue,  9 Apr 2024 20:05:08 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67A0687DCA
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 20:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 471F83F148; 
 Tue,  9 Apr 2024 18:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712685905;
 bh=69ZLQIYq+IVoTOjoe7gnvMTCu1LfvaeDkUbEgZdGNdw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=X5HOkUqHzhJ0nhATFIk5+N28LZnD6FWU/qaaOw0u9/8a1hk4uz/TYahAwJg2lQBCj
 YG3/0jHhauJTnxc7Bwh983NSLVrvbovK8sloVLsbpk3VAQLBE52WaaO+8+6VxfBNjd
 5uWEB6W7zLPEL8hMOnDNRG8DSbpLVgBuaJ/N5IDX43YiDQEVJUj0iijriXzvUMN6nN
 SzuxzvyejH24C5aF7eas4mlT1nlAXs72KhqWBxb2hM6dp6szncDxpmsuC919ht+mvt
 y82J4Icax+L3EpOfKeonPLmxncAIABkum/GIaaMtw7LOyPK7MtPoHuyqJrAgyBSFE5
 iTkW0MPQWJVSA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] fs: fat: convert change month correctly
Date: Tue,  9 Apr 2024 20:04:56 +0200
Message-ID: <20240409180456.39581-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The month is stored in 5 - 8. We need to shift it by 5 bits.

Cf. Microsoft FAT Specification, 2005-08-30

Fixes: 13c11c665320 ("fs: fat: add file attributes to struct fs_dirent")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/fat/fat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 14e53cf2d5a..2dd9d4e72dc 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -1254,7 +1254,7 @@ out:
 static void __maybe_unused fat2rtc(u16 date, u16 time, struct rtc_time *tm)
 {
 	tm->tm_mday = date & 0x1f;
-	tm->tm_mon = (date & 0x1e0) >> 4;
+	tm->tm_mon = (date & 0x1e0) >> 5;
 	tm->tm_year = (date >> 9) + 1980;
 
 	tm->tm_sec = (time & 0x1f) << 1;
-- 
2.43.0

