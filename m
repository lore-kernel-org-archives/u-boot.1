Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15368C47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:43:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C59087B52;
	Wed, 17 Jan 2024 18:43:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C516B87B8D; Wed, 17 Jan 2024 18:43:13 +0100 (CET)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [IPv6:2001:1600:3:17::bc0d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87E70879ED
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 18:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
 by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TFYBR0VjDzMq9Sf;
 Wed, 17 Jan 2024 17:43:11 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TFYBQ2Vy3zvk; Wed, 17 Jan 2024 18:43:10 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH v3 6/6] rockchip: theobroma-systems: fix modified boot_targets
 detection
Date: Wed, 17 Jan 2024 18:42:53 +0100
Message-ID: <20240117-env_default_theobroma-v3-6-316c25a6733f@theobroma-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117-env_default_theobroma-v3-0-316c25a6733f@theobroma-systems.com>
References: <20240117-env_default_theobroma-v3-0-316c25a6733f@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
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

U-Boot proper automatically modifies boot_targets to swap the order in
which MMC storage media are used for standard boot based on which MMC
storage medium was used to load U-Boot proper. This is however only done
if the user has not changed it manually, therefore a check between the
default and current value is done.

This used to work fine until the migration to standard boot where
boot_targets value size in the default environment went above the 32
characters that env_get_default function can return, thus resulting in a
truncated variable.

Therefore the check between default and current value would always fail.

By using the newly added env_get_default_into function, a buffer of
the appropriate size can be allocated on the stack to get the whole
value of boot_targets in the default environment and thus fixing the
check.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 board/theobroma-systems/common/common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/board/theobroma-systems/common/common.c b/board/theobroma-systems/common/common.c
index eb21d4c4550..864bcdd46f8 100644
--- a/board/theobroma-systems/common/common.c
+++ b/board/theobroma-systems/common/common.c
@@ -21,7 +21,9 @@ int setup_boottargets(void)
 {
 	const char *boot_device =
 		ofnode_read_chosen_string("u-boot,spl-boot-device");
-	char *env_default, *env;
+	char env_default[sizeof(BOOT_TARGETS)];
+	char *env;
+	int ret;
 
 	if (!boot_device) {
 		debug("%s: /chosen/u-boot,spl-boot-device not set\n",
@@ -30,7 +32,9 @@ int setup_boottargets(void)
 	}
 	debug("%s: booted from %s\n", __func__, boot_device);
 
-	env_default = env_get_default("boot_targets");
+	ret = env_get_default_into("boot_targets", env_default, sizeof(env_default));
+	if (ret < 0)
+		env_default[0] = '\0';
 	env = env_get("boot_targets");
 	if (!env) {
 		debug("%s: boot_targets does not exist\n", __func__);

-- 
2.43.0

