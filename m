Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1550C531DC
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 13:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 224368881C;
	Fri, 16 Aug 2024 15:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=johanneskirchmair.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=johanneskirchmair.de header.i=@johanneskirchmair.de header.b="UNxiibhO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBE7A88AB9; Fri, 16 Aug 2024 09:35:12 +0200 (CEST)
Received: from mx8.mail-out.lima-city.de (mx8.mail-out.lima-city.de
 [91.216.248.210])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C548B889A6
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 09:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=johanneskirchmair.de
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=mailinglist1@johanneskirchmair.de
From: mailinglist1@johanneskirchmair.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=johanneskirchmair.de;
 s=securedbylima-20161106; t=1723793701;
 bh=8uE3Qmvf6k6Yk06hdiHErYFH3KV+ItNRixWXAul1KbQ=;
 h=From:To:Cc:Subject:Date:From;
 b=UNxiibhOHRsqgpp7Ktscr9BOTrI+yaP61VoYGFSJCwW8nhYSwmkQ6xcj0pwYHfPHL
 zkYHFpHxfx689p6QuvjPztVQwkqNgUklWa1/jNQzbp6sBhD+tk3LnE6W9DMGjrUu4X
 gtWlRVhTZZUTwv6ANAhHGpPwP8KY7uwobPnq2osw=
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Johannes Kirchmair <johannes.kirchmair@skidata.com>
Subject: [PATCH] spl: fix error handling of spl_fit_read
Date: Fri, 16 Aug 2024 09:33:32 +0200
Message-Id: <20240816073332.279025-1-mailinglist1@johanneskirchmair.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Aug 2024 15:36:32 +0200
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

From: Johannes Kirchmair <johannes.kirchmair@skidata.com>

Returning negative values from spl_fit_read leads to u-boot crashing.
The return value of spl_fit_read is compared with an unsigned value.
Returning negative values leads to the check not detecting the error.
Not detecting the error leads to crashing.

Returning zero in case of an reading error is fine. It indicates that
nothing was red.

Signed-off-by: Johannes Kirchmair <johannes.kirchmair@skidata.com>
---
 common/spl/spl_fat.c | 2 +-
 include/spl_load.h   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index bd8aab253a..345bc55149 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -53,7 +53,7 @@ static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
 
 	ret = fat_read_file(filename, buf, file_offset, size, &actread);
 	if (ret)
-		return ret;
+		return 0;
 
 	return actread;
 }
diff --git a/include/spl_load.h b/include/spl_load.h
index 1c2b296c0a..b411d9daa1 100644
--- a/include/spl_load.h
+++ b/include/spl_load.h
@@ -17,8 +17,8 @@ static inline int _spl_load(struct spl_image_info *spl_image,
 {
 	struct legacy_img_hdr *header =
 		spl_get_load_buffer(-sizeof(*header), sizeof(*header));
-	ulong base_offset, image_offset, overhead;
-	int read, ret;
+	ulong base_offset, image_offset, overhead, read;
+	int ret;
 
 	read = info->read(info, offset, ALIGN(sizeof(*header),
 					      spl_get_bl_len(info)), header);
-- 
2.34.1

