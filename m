Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F61C4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 08:04:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E8A386758;
	Thu, 11 Jan 2024 09:03:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XR3c/b4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72B87878C8; Thu, 11 Jan 2024 09:03:57 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6871086611
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 09:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.home.xypron
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6133441BB2; 
 Thu, 11 Jan 2024 08:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704960234;
 bh=VMRXrk1sv3keSRAcz7cDCkhlIPMN5RIPV7SCes4e5+k=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=XR3c/b4AJWbARwFoieReoFSGoHGspxTA+v00S4SqZOQzwEdPQfr1IVBmt1sSvWB0o
 eVRHvaLhRCrcNtJ3bMyBovQ0AJrdDfFWB8E9iW2ths9oyNq3cz0tPXnjux9xByA7V7
 27GtiVCq5re8vi/YqeT5ePVflNfm5TOyVCdg+rPXu+Y3wsrzdIMgpnTCDvRVIRz6yC
 eA+rWwBtjzgw127nI6UPOUmLEoy6CfFpluUiuQ4Rz61rWZtWIDTmE7zUNl1ZteNGXe
 ALVFik1cZJh2M9ZpARZpXnMnK4d3X5joPHjT2FJ1FEAs6lqynA/aMw4CcSxii7pxCk
 xuuwAKFS+8sng==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] sandbox: move sandbox specifics to booti_setup()
Date: Thu, 11 Jan 2024 09:03:43 +0100
Message-ID: <20240111080344.112746-1-heinrich.schuchardt@canonical.com>
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

Instead of checking a configuration setting in booti_start() adjust the
sandbox implementation of booti_setup().

Write a console message when trying to run the booti command on the sandbox
indicating that it is not supported.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/sandbox/lib/bootm.c | 4 +++-
 cmd/booti.c              | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/lib/bootm.c b/arch/sandbox/lib/bootm.c
index 8dbcd9ff7d..44ba8b52e1 100644
--- a/arch/sandbox/lib/bootm.c
+++ b/arch/sandbox/lib/bootm.c
@@ -85,5 +85,7 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 		bool force_reloc)
 {
-	return 0;
+	log_err("Booting is not supported on the sandbox.\n");
+
+	return 1;
 }
diff --git a/cmd/booti.c b/cmd/booti.c
index 898df0f889..b9637b3ec3 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -74,7 +74,7 @@ static int booti_start(struct bootm_info *bmi)
 	unmap_sysmem((void *)ld);
 
 	ret = booti_setup(ld, &relocated_addr, &image_size, false);
-	if (ret || IS_ENABLED(CONFIG_SANDBOX))
+	if (ret)
 		return 1;
 
 	/* Handle BOOTM_STATE_LOADOS */
-- 
2.43.0

