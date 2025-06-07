Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0681C5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 12:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4C9A82B33;
	Sat,  7 Jun 2025 14:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="vJYeYTQF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE1F5828F8; Sat,  7 Jun 2025 07:25:32 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D50E382A9E
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 07:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1BE0744E34;
 Sat,  7 Jun 2025 05:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4393BC4CEF0;
 Sat,  7 Jun 2025 05:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749273926;
 bh=zmOZkEyqrcfa9LhBmo/EYJaA8VZfYR3CeqEhjfNVOjU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=vJYeYTQFC9/SInOIfj+szT5uqJ+w5plbvTq42CJ4Jq1DJAuyE6tNUW2NDdANOOGN7
 QdQMG7he0HOiscAxJ2xuaSoqKkKEByljLHM9QLsolhG5IOeJtOcyJY329VQIWhSJ77
 5CReB0KqqRJbxgjOdAbvUnQ032vVlFTM8uqCdcVInzUTjO+FURgHt9GiZhjAcleo2a
 ymEACRL+IlnNbaCLE1M/+sGdPLPDg+Y6AR25b5sRE7mwlymCPyt4rpICvKFzs1naVK
 XJAgBT64XSRjJiVs9V+qXNWfpoZ16csPoFhv/oWICtYQBFWlW93leBslV+iaT/OAhI
 dVzqg64FAKWmQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 33F94C677C4;
 Sat,  7 Jun 2025 05:25:26 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Sat, 07 Jun 2025 13:24:57 +0800
Subject: [PATCH v2 2/5] bootm: Append bootargs value when bootmeth_android
 provide cmdline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250607-sc7180-android-boot-v2-2-2df5d7f61124@gmail.com>
References: <20250607-sc7180-android-boot-v2-0-2df5d7f61124@gmail.com>
In-Reply-To: <20250607-sc7180-android-boot-v2-0-2df5d7f61124@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, gchan9527@gmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749273923; l=1531;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=QzAXV3TUQetJKh/4eaQeq6FcGlY9YPKgygVu64gQGpI=;
 b=6ZvEpk2UuUnhKluGqJBf8KOch/v8uzE/QQO7dJmDhv97U6CZDmjP8pjq9IlL1ZH8qM9vMYYv3
 UlqPnk5vWa2BtOU8BYFD0OTrHNBex545DECprBAsh2kntL8kYiCIEl3
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Sat, 07 Jun 2025 14:23:14 +0200
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
Reply-To: gchan9527@gmail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: George Chan <gchan9527@gmail.com>

Old logic wipe bootargs env with cmdline, new logic maintain the
value by prepending cmdline value to bootargs.

Signed-off-by: George Chan <gchan9527@gmail.com>
---
 boot/bootm.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index f6aa32746b7..888684a91f5 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1152,11 +1152,38 @@ int bootm_boot_start(ulong addr, const char *cmdline)
 
 	snprintf(addr_str, sizeof(addr_str), "%lx", addr);
 
-	ret = env_set("bootargs", cmdline);
+	if (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS)) {
+		char *bootargs;
+		char *newbootargs;
+		bootargs = env_get("bootargs");
+		ret = strlen(bootargs) + strlen(cmdline) + 2;
+
+		newbootargs = malloc(ret);
+
+		*newbootargs = '\0';
+
+		if (*newbootargs) /* If there is something in newbootargs, a space is needed */
+			strcat(newbootargs, " ");
+		strcat(newbootargs, cmdline);
+
+		if (*newbootargs) /* If there is something in newbootargs, a space is needed */
+			strcat(newbootargs, " ");
+		strcat(newbootargs, bootargs);
+
+		/* force to terminate the string */
+		memset(newbootargs + MAX_CMDLINE_SIZE - 2, '\0', 1);
+
+		ret = env_set("bootargs", newbootargs);
+
+		free(newbootargs);
+	} else
+		ret = env_set("bootargs", cmdline);
+
 	if (ret) {
 		printf("Failed to set cmdline\n");
 		return ret;
 	}
+
 	bootm_init(&bmi);
 	bmi.addr_img = addr_str;
 	bmi.cmd_name = "bootm";

-- 
2.43.0


