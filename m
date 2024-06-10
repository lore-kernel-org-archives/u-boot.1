Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17034C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 16:13:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61B7B8861E;
	Mon, 10 Jun 2024 18:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F38E58862C; Mon, 10 Jun 2024 18:13:56 +0200 (CEST)
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::bc0f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18E1F885FB
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 18:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VycLV4mMxzNsx;
 Mon, 10 Jun 2024 18:13:54 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VycLV1YwNz2Sx; Mon, 10 Jun 2024 18:13:54 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 10 Jun 2024 18:13:46 +0200
Subject: [PATCH] smbios: only look for a SYSINFO udevice if SYSINFO support
 is enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-smbios-sysinfo-v1-1-587e100a9d92@cherry.de>
X-B4-Tracking: v=1; b=H4sIADkmZ2YC/x3MMQqAMAxA0auUzAaaIha8ijioTTWDrTQginh3i
 +Mb/n9AuQgr9OaBwqeo5FRBjYFlm9LKKKEanHWt7cii7rNkRb1VUswYlok8+46JAtToKBzl+of
 D+L4fAEUvj2AAAAA=
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14-dev-a6ee3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

If SYSINFO support isn't enabled, it's a given that uclass_first_device
for UCLASS_SYSINFO will not find anything, therefore let's skip the test
entirely.

This allows to get rid of the following debug message that may be
confusing:

Cannot find uclass for id 118: please add the UCLASS_DRIVER() declaration for this UCLASS_... id

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 lib/smbios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index b190b010f30..a822acd48e9 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -571,7 +571,7 @@ ulong write_smbios_table(ulong addr)
 	int i;
 
 	ctx.node = ofnode_null();
-	if (IS_ENABLED(CONFIG_OF_CONTROL)) {
+	if (IS_ENABLED(CONFIG_OF_CONTROL) && CONFIG_IS_ENABLED(SYSINFO)) {
 		uclass_first_device(UCLASS_SYSINFO, &ctx.dev);
 		if (ctx.dev)
 			parent_node = dev_read_subnode(ctx.dev, "smbios");

---
base-commit: 4f836fb324ba500ecabdba4146c3ca9e1600cdf5
change-id: 20240610-smbios-sysinfo-dca17e76e11d

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

