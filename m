Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B19ED5AE75
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 09:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 761AA88B64;
	Thu,  7 Nov 2024 10:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="izM6YbLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FBE288C4D; Thu,  7 Nov 2024 10:39:03 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A348688B4B
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 10:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9BE1B40286; 
 Thu,  7 Nov 2024 09:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730972339;
 bh=KNgryzr35H2KkTvKvkXh7t09JvYhzLPNphevkUoaATw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=izM6YbLXlNUJXXqL+P82Orh2G54RIrzWFFUptv5N9iUx32TRW+ZX6fXya3InA6B2R
 uLJkpAlD7KwywIfDJahuUNKGwoGg1tQiBRNIlZpjaF/B4C9h8auLq+DGsV++POgJBZ
 7PilCu5RzIVT81Y4Z9whdOWAGg/cscDMoaTiHLDEoUldCMMZ8MMsokoJX0S5sDkXEK
 pXg2503O3ef6PbrgJBEz1WxOKYxEr/VtPRWdUzWgBv37Xv41eptom9cX9u2TPLKyyj
 JsacPpGY11rBIIf+haii44UfM8FkPPJRo8bmq5jotzqb5NwWhu5VpdBxpy1VdCT5gk
 6ya5y9gSGMpgQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] fs: ext4: correct error handling
Date: Thu,  7 Nov 2024 10:38:53 +0100
Message-ID: <20241107093854.42184-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

After calling strdup() check the returned pointer.

Avoid a memory leak if the directory is not found.

Reported-by: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Fixes: 22fdac381f98 ("fs: ext4: implement opendir, readdir, closedir")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/ext4/ext4fs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index dfecfa0b4e8..1727da2dc6d 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -213,7 +213,7 @@ int ext4fs_opendir(const char *dirname, struct fs_dir_stream **dirsp)
 	if (!dirs)
 		return -ENOMEM;
 	dirs->dirname = strdup(dirname);
-	if (!dirs) {
+	if (!dirs->dirname) {
 		free(dirs);
 		return -ENOMEM;
 	}
@@ -224,6 +224,8 @@ int ext4fs_opendir(const char *dirname, struct fs_dir_stream **dirsp)
 		ret = 0;
 		*dirsp = (struct fs_dir_stream *)dirs;
 	} else {
+		free(dirs->dirname);
+		free(dirs);
 		ret = -ENOENT;
 	}
 
-- 
2.45.2

