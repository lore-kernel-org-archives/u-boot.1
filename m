Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1B7C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 962DA881AE;
	Mon, 15 Apr 2024 14:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06E1C881B6; Mon, 15 Apr 2024 14:44:13 +0200 (CEST)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::bc0b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 068B287B82
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 14:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VJ6LL49X8z1T2;
 Mon, 15 Apr 2024 14:44:10 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VJ6LL0SXCzJnv; Mon, 15 Apr 2024 14:44:09 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 15 Apr 2024 14:43:57 +0200
Subject: [PATCH] env: mmc: print MMC device being read
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-mmc-loadenv-dev-v1-1-4dd649e0c298@theobroma-systems.com>
X-B4-Tracking: v=1; b=H4sIAAwhHWYC/x3MQQqAIBBG4avErBvQqKyuEi1C/2qgLBQkiO6et
 PwW7z0UEQSRhuKhgCRRTp+hy4LsNvsVLC6bKlXVqtYNH4fl/ZwdfGKHxBauNZ02Gn1HuboCFrn
 /4zi97wfLsy3qYQAAAA==
To: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
X-Mailer: b4 0.13.0
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

This prints the MMC device being read similar to how we print the MMC
device we write to when e.g. calling saveenv.

One of the side effects is that the boot log now shows from which MMC
device the env was loaded:

Loading Environment from MMC... Reading from MMC(1)... OK

This is useful to identify which MMC device the environment was loaded
from for boards where there are more than one (e.g. eMMC and SD card)
without adding some debug messages manually.

Sadly, there's no way to know which of the default or redundant
environment is being read from env_mmc_load before env_import_redund is
called so it is printing a bit later (and possibly after error/warning
messages).

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 env/mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/env/mmc.c b/env/mmc.c
index da84cddd74f..7afb733e890 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -436,6 +436,7 @@ static int env_mmc_load(void)
 
 	ret = env_import_redund((char *)tmp_env1, read1_fail, (char *)tmp_env2,
 				read2_fail, H_EXTERNAL);
+	printf("Reading from %sMMC(%d)... ", gd->env_valid == ENV_REDUND ? "redundant " : "", dev);
 
 fini:
 	fini_mmc_for_env(mmc);
@@ -475,6 +476,8 @@ static int env_mmc_load(void)
 		goto fini;
 	}
 
+	printf("Reading from MMC(%d)... ", dev);
+
 	ret = env_import(buf, 1, H_EXTERNAL);
 	if (!ret) {
 		ep = (env_t *)buf;

---
base-commit: b03b49046af5dfca599d2ce8f0aafed89b97aa91
change-id: 20240415-mmc-loadenv-dev-ced678171e98

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>

