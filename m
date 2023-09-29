Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00361E743D3
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 00:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C153286E86;
	Fri, 29 Sep 2023 02:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="WLxtuBo4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E76286E76; Fri, 29 Sep 2023 02:47:26 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDF8186E61
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 02:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4753542B2A; 
 Fri, 29 Sep 2023 00:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1695948441;
 bh=EZ+kZbTL6n71oPDgHRh3nWZyW+jlwtwokIBs5t/r4LI=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=WLxtuBo4qt5NErF36weOtFUpbbHvZo1vNxx+HxuPSWOnbh6HhkQZNANFG98aJJ8n1
 YBs6B4jydVKBQ3ZQr/YOpORg/EXT7ovGfsO2I62hTWTlZMAmKnTBGE/8V+SJsPGtxT
 yc/B6MNjRwbhqIYdpSf9xGDsIq8alB+Arvm6C0LYZ5K15KGQJ1nhfC+97xlzU2jX+k
 iXes2vfBCuJpYrcR6kkdRmsk3o0/fojKha0bleEchJQ7rNbBSKsAmc7ZFhbguTjXm6
 twkMl8ovJwHCbaoy5kfFyKmf03vq4HMkuh2rDcGlrKx7jr2NYmRoBPWMDk7+A98eWc
 CIek4VzgaUEbw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Michal Suchanek <msuchanek@suse.de>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] stdio: fix stdio_deregister_dev()
Date: Fri, 29 Sep 2023 02:47:17 +0200
Message-Id: <20230929004717.37413-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929004717.37413-1-heinrich.schuchardt@canonical.com>
References: <20230929004717.37413-1-heinrich.schuchardt@canonical.com>
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

When copying the name of a stdio device we must ensure that it is NUL
terminated before passing it to strcmp() to avoid a buffer overrun.

Truncating the name field leads to failure to deregister a stdio device.
When copying we must ensure that the name field sizes match.

Addresses-Coverity-ID: 350462 String not null terminated
Fixes: 5294e97832a6 ("stdio: extend "name" to 32 symbols")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 common/stdio.c      | 6 +++---
 include/stdio_dev.h | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/common/stdio.c b/common/stdio.c
index 010bf576af..e3354f092d 100644
--- a/common/stdio.c
+++ b/common/stdio.c
@@ -259,7 +259,7 @@ int stdio_register(struct stdio_dev *dev)
 int stdio_deregister_dev(struct stdio_dev *dev, int force)
 {
 	struct list_head *pos;
-	char temp_names[3][16];
+	char temp_names[3][STDIO_NAME_LEN];
 	int i;
 
 	/* get stdio devices (ListRemoveItem changes the dev list) */
@@ -272,8 +272,8 @@ int stdio_deregister_dev(struct stdio_dev *dev, int force)
 			/* Device is assigned -> report error */
 			return -EBUSY;
 		}
-		memcpy(&temp_names[i][0], stdio_devices[i]->name,
-		       sizeof(temp_names[i]));
+		strlcpy(&temp_names[i][0], stdio_devices[i]->name,
+			sizeof(temp_names[i]));
 	}
 
 	list_del(&dev->list);
diff --git a/include/stdio_dev.h b/include/stdio_dev.h
index 7f18102052..4e3c4708f8 100644
--- a/include/stdio_dev.h
+++ b/include/stdio_dev.h
@@ -17,6 +17,7 @@
 #define DEV_FLAGS_INPUT	 0x00000001	/* Device can be used as input	console */
 #define DEV_FLAGS_OUTPUT 0x00000002	/* Device can be used as output console */
 #define DEV_FLAGS_DM     0x00000004	/* Device priv is a struct udevice * */
+#define STDIO_NAME_LEN 32
 
 int stdio_file_to_flags(const int file);
 
@@ -24,7 +25,7 @@ int stdio_file_to_flags(const int file);
 struct stdio_dev {
 	int	flags;			/* Device flags: input/output/system	*/
 	int	ext;			/* Supported extensions			*/
-	char	name[32];		/* Device name				*/
+	char	name[STDIO_NAME_LEN];	/* Device name				*/
 
 /* GENERAL functions */
 
-- 
2.40.1

