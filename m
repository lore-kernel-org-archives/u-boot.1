Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EED8C7EE39
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 12:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0094882F6A;
	Sat, 28 Jun 2025 14:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WUmlFLQl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A62781D5D; Sat, 28 Jun 2025 14:25:33 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B947E82B34
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 14:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D5EF5462D6;
 Sat, 28 Jun 2025 12:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A30B8C4CEEE;
 Sat, 28 Jun 2025 12:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751113522;
 bh=iRKf/rQ54Ynxvq+YR6fIJt2ISpAmtuWanR7r1NvA1xo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=WUmlFLQlKCDX08nYQXjBOppPtSayP9bvblmcJNoYt2UH90VsaLWDCHGmW45UTIqZD
 1RDQqda1M8BK2UMYzlnxSE3DyM0G4azqOG7H1x6AhbbwC1RD3E3I4oVcyI1UiLnZY+
 11JXr5lmzc8zgq4s9kXftVKaVYoy085Wg86vtk9uECHncl1Dg0Jm9Xfa5c6jufL4t3
 P5q8VwbqShckwoqQJcr+IyYg6h3NOOBov5QTgMlFh5e0R3QdKlLdyRWNuLZKMYdk6X
 ikgwg1fqHDG1J0pFYl8sCV/5A45F7U/27IOHWPDuZ8QjVEgcQqHEcbl7YYYN9yFIO/
 nCTzxghFSxCng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9F4C54ED1;
 Sat, 28 Jun 2025 12:25:22 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Sat, 28 Jun 2025 20:25:21 +0800
Subject: [PATCH v3 3/7] image-android.c: Add null check to bootargs and cmdline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-sc7180-android-boot-v3-3-105098a19165@gmail.com>
References: <20250628-sc7180-android-boot-v3-0-105098a19165@gmail.com>
In-Reply-To: <20250628-sc7180-android-boot-v3-0-105098a19165@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, gchan9527@gmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751113519; l=2557;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=j5YCixUsDKdzdfkhZDGwCtyoe5eH8Vhi1xe40CBHgcc=;
 b=F2G/zbr48b1CKRuvoj0OmHbexF71U4MUdLPG2j72s1B4dQPB9F48jHNbEwMVd+4dUKSP3p9cH
 j+GbdWW9oinBHbZvVd8yFDxLxG16KgIkhFKOeAMAsIE4Na2iJ549K9g
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Sat, 28 Jun 2025 14:35:07 +0200
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

With some manual testing, when bootargs and/or cmdline from android boot
image is absent there will be some unhandled behavior happened.

So add null check to all these const char values.

Signed-off-by: George Chan <gchan9527@gmail.com>
---
 boot/image-android.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index 26e2fc21929..422f254c78d 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -299,15 +299,20 @@ int android_image_modify_bootargs_env(const char *cmd, const char *cmd_extra) {
 	char *newbootargs;
 	int len = 0;
 
-	if (bootargs)
-		len += strlen(bootargs);
-
-	if (cmd && *cmd)
+	if (cmd != NULL && cmd && *cmd)
 		len += strlen(cmd) + (len ? 1 : 0); /* +1 for extra space */
 
-	if (cmd_extra && *cmd_extra)
+	if (cmd_extra != NULL && cmd_extra && *cmd_extra)
 		len += strlen(cmd_extra) + (len ? 1 : 0); /* +1 for extra space */
 
+	if (len <=2) {
+		puts("Error: neither bootargs, ccmdline or cmdline_extra found!\n");
+		return 0;
+	}
+
+	if (bootargs != NULL && bootargs && *bootargs)
+		len += strlen(bootargs);
+
 	newbootargs = malloc(len + 2); /* +2 for 2x '\0' */
 
 	if (!newbootargs) {
@@ -317,22 +322,24 @@ int android_image_modify_bootargs_env(const char *cmd, const char *cmd_extra) {
 
 	*newbootargs = '\0'; /* set to Null in case no components below are present */
 
-	if (bootargs && !IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS))
-		strcpy(newbootargs, bootargs);
+	if (bootargs != NULL && bootargs && *bootargs
+	    && !IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS))
+		strcat(newbootargs, bootargs);
 
-	if (cmd && *cmd) {
+	if (cmd != NULL && cmd && *cmd) {
 		if (*newbootargs) /* If there is something in newbootargs, a space is needed */
 				strcat(newbootargs, " ");
 		strcat(newbootargs, cmd);
 	}
 
-	if (cmd_extra && *cmd_extra) {
+	if (cmd_extra != NULL && cmd_extra && *cmd_extra) {
 		if (*newbootargs) /* If there is something in newbootargs, a space is needed */
 				strcat(newbootargs, " ");
 		strcat(newbootargs, cmd_extra);
 	}
 
-	if (bootargs && IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS)) {
+	if (bootargs != NULL && bootargs && *bootargs
+	    && IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_PREPEND_ENV_BOOTARGS)) {
 		if (*newbootargs) /* If there is something in newbootargs, a space is needed */
 				strcat(newbootargs, " ");
 		strcat(newbootargs, bootargs);

-- 
2.43.0


