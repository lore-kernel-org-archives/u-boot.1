Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31A7C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 18:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 775E88272A;
	Sat,  4 Nov 2023 19:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bkKRrkcS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA29D803AC; Sat,  4 Nov 2023 19:47:26 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32A65870BC
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 19:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (unknown [159.148.28.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CFD59416C2; 
 Sat,  4 Nov 2023 18:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699123638;
 bh=Auyr+MrhH21BDJ33jsMSsJDJJ6LPQEZJf4/OUnE0o+o=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=bkKRrkcSjYKNyx1g/dH0lkaoYn4QPs2CWj2hLvktn65B3dDEwAsQNpCIIK4v0Rj/0
 Jdl958dTuJLxp3VhM6D3q2A1bcJbgMniSsdZLaHr2IAumNF/zZqp8cl13l3aRhQR3Q
 lRlHyDhW8pXaF2HZzsrpEkUOj3JughyR8WU2U+4V/6brrYi8klmIbyKkEfp5JHZjoi
 W6Fl74eX4T7aIWR6H7ze58YxbrvgvICGVMTV2CsRK3a5P9dZE5XzWRhJSw0e+BlRFJ
 reKvgmaSIjRBvFeKpXTVhNglxu2d85k/XwFMXRncBGo+T3LjWGrPeS5CkZVtTkTWL5
 VNORPvESJOVQQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] dm: fix misleading messages
Date: Sat,  4 Nov 2023 20:47:16 +0200
Message-Id: <20231104184716.13743-1-heinrich.schuchardt@canonical.com>
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

When no RNG device exists for a driver referenced via U_BOOT_DRVINFO() we
get messages like:

    No match for driver 'arm-rndr'
    Some drivers were not found

This is misleading as it is not the driver that was not found, it is the
device that is not found. Correct the messages.

Reported-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/core/lists.c | 2 +-
 drivers/core/root.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/core/lists.c b/drivers/core/lists.c
index 8034a8f48d..e39d3acc97 100644
--- a/drivers/core/lists.c
+++ b/drivers/core/lists.c
@@ -97,7 +97,7 @@ static int bind_drivers_pass(struct udevice *parent, bool pre_reloc_only)
 			if (CONFIG_IS_ENABLED(OF_PLATDATA))
 				drt->dev = dev;
 		} else if (ret != -EPERM) {
-			dm_warn("No match for driver '%s'\n", entry->name);
+			dm_warn("No device for driver '%s'\n", entry->name);
 			if (!result || ret != -ENOENT)
 				result = ret;
 		}
diff --git a/drivers/core/root.c b/drivers/core/root.c
index d4ae652bcf..29c918eb73 100644
--- a/drivers/core/root.c
+++ b/drivers/core/root.c
@@ -167,7 +167,7 @@ int dm_scan_plat(bool pre_reloc_only)
 
 	ret = lists_bind_drivers(DM_ROOT_NON_CONST, pre_reloc_only);
 	if (ret == -ENOENT) {
-		dm_warn("Some drivers were not found\n");
+		dm_warn("Some devices were not found\n");
 		ret = 0;
 	}
 
-- 
2.40.1

