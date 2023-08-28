Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8B3C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 20:40:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B93C805C9;
	Mon, 28 Aug 2023 22:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pG6h16h2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DBFB86496; Mon, 28 Aug 2023 22:40:04 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3F2B805C9
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 22:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E1BC53F1FC; 
 Mon, 28 Aug 2023 20:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693255201;
 bh=K+dkcEaPWbwCYjsvkGoEay+VmmPDKiH9PWdN6m3zedo=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=pG6h16h2zk/jMOWONtIkzVa2Bk+Gc3P4jhouVLaVwmYqOo5nU11ZAfzddSkosjmqD
 DxrgzYeWtNKXDQe1zhW2SgYuzzy3HwRpZrz2haw3dwNwA6jDAbYQL0VRFx4k6tvVXD
 oW7YtGt9FQIdXa6x6SL9QpTerkqqhdkXhOr+vcwdQHc9+dLlCYg6OK6o/bp3iwNJoa
 wOK8tw37aGzlIE1x1b+Fg0e96265cOLqxAQj66RhQa/HOTf1wFSWbSjw0nD+VmmcRu
 81pRk04xnpqKK3jyGLZNJtwLPG/GhZ+tbhdGyEmKLUJ6YdFLH5xDU+lJGSRO4wlzrD
 TEDV5PtIFE9/Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] video: fix typo in video_sync_all documentation
Date: Mon, 28 Aug 2023 22:40:47 +0200
Message-Id: <20230828204047.91300-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

%s/there/their/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/video.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/video.h b/include/video.h
index 269915160b..16f7a83f8d 100644
--- a/include/video.h
+++ b/include/video.h
@@ -260,7 +260,7 @@ int video_fill_part(struct udevice *dev, int xstart, int ystart, int xend,
 int video_sync(struct udevice *vid, bool force);
 
 /**
- * video_sync_all() - Sync all devices' frame buffers with there hardware
+ * video_sync_all() - Sync all devices' frame buffers with their hardware
  *
  * This calls video_sync() on all active video devices.
  */
-- 
2.40.1

