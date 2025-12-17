Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDFFD65C49
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 14:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B01083B2C;
	Wed, 17 Dec 2025 15:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44C9D83B32; Wed, 17 Dec 2025 15:01:20 +0100 (CET)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [45.157.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5018D83B21
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 15:01:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dWb7K6P1Sz4Yn;
 Wed, 17 Dec 2025 15:01:17 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dWb7K2Gdtz4T9; Wed, 17 Dec 2025 15:01:17 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 17 Dec 2025 15:01:10 +0100
Subject: [PATCH] cmd: bdinfo: fix incorrect Kconfig options check for
 print_eth()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-bdinfo-lwip-v1-1-849cf060bf12@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avIrBNSMKmrRAvNsQZCRaEC8e5Jy
 7f4v0LBTFhgYRUy3lQohg4xMNhPEw7k5LpBjlIJKTS3joKP/HoocURjlZ38rI2AXqSMnt7/tm6
 tfeQAlYRdAAAA
X-Change-ID: 20251217-bdinfo-lwip-eeab5b6f97a1
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
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

CMD_NET_LWIP has never existed so it cannot be right. I'm guessing the
intent was to allow print_eth() to be called when NET_LWIP is defined
(NET means "legacy networking stack" as opposed to NET_LWIP which is the
 newest (and incompatible) stack). There probably was some mix-up
between CMD_NET and NET options.

The dependency on CMD_NET seems unnecessary as it seems perfectly fine
to run bdinfo without CMD_NET (build and run tested). So let's instead
make the dependency on NET || NET_LWIP.

Fixes: 95744d2527cb ("cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 cmd/bdinfo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index 20c8c97f0cd..09fe8067642 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -152,7 +152,7 @@ static int bdinfo_print_all(struct bd_info *bd)
 	bdinfo_print_num_l("relocaddr", gd->relocaddr);
 	bdinfo_print_num_l("reloc off", gd->reloc_off);
 	printf("%-12s= %u-bit\n", "Build", (uint)sizeof(void *) * 8);
-	if (IS_ENABLED(CONFIG_CMD_NET) || IS_ENABLED(CONFIG_CMD_NET_LWIP))
+	if (IS_ENABLED(CONFIG_NET) || IS_ENABLED(CONFIG_NET_LWIP))
 		print_eth();
 	bdinfo_print_num_l("fdt_blob", (ulong)map_to_sysmem(gd->fdt_blob));
 	if (IS_ENABLED(CONFIG_VIDEO))
@@ -193,8 +193,8 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		case 'a':
 			return bdinfo_print_all(bd);
 		case 'e':
-			if (!IS_ENABLED(CONFIG_CMD_NET) &&
-			    !IS_ENABLED(CONFIG_CMD_NET_LWIP))
+			if (!IS_ENABLED(CONFIG_NET) &&
+			    !IS_ENABLED(CONFIG_NET_LWIP))
 				return CMD_RET_USAGE;
 			print_eth();
 			return CMD_RET_SUCCESS;

---
base-commit: 47b50fb1125c539d80ed3e7f739c02c6486e1b52
change-id: 20251217-bdinfo-lwip-eeab5b6f97a1

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

