Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB30DC3ABC9
	for <u-boot@archiver.kernel.org>; Sun, 18 May 2025 12:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2AD482A25;
	Sun, 18 May 2025 14:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d0OUrNFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29DB4803DF; Sun, 18 May 2025 13:16:48 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 210888059D
 for <u-boot@lists.denx.de>; Sun, 18 May 2025 13:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 713EE4365B;
 Sun, 18 May 2025 11:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BC61C4CEED;
 Sun, 18 May 2025 11:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747567002;
 bh=heAO5x0xb/U/RSKHs1mpd38FYX9e3eVeXoH+Hs/D6oE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=d0OUrNFkbIE+jLSyUSWF7OCEf/z5WgLtyAIswTJdU4xgN8MZJmX9Z3cQUUU7nVKcP
 THbcy8OOYgcE1nKsTBzHttX3CnALPm7LSfdEAByVXIBY0JrkllCfXWJvCJaxbOP2CB
 alot5Y31CrFHQOOiw1afKgwd6QSArRWVEUeMOTp4eNoqVuZjUpIPlzSfeoHXSYRMON
 HCI0ppbZpHCJ+VMlUfoB7b3tt5MTKfsgkzZW/DJX+WEhjRa4/Ae9HOfg9pBEx9hFfs
 ToYO89v0BMk29i9jURPNMI3S7kxily3tMovhdSkc2uVxkc7AYadF3crRCLT9UeMijs
 FZ9CRoMJluA9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEF1C3ABC9;
 Sun, 18 May 2025 11:16:42 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Sun, 18 May 2025 19:16:18 +0800
Subject: [PATCH v3 1/3] boot/image-android: Workaround kernel/ramdisk
 invalid addr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250518-android-boot-v3-1-02c8768e131f@gmail.com>
References: <20250518-android-boot-v3-0-02c8768e131f@gmail.com>
In-Reply-To: <20250518-android-boot-v3-0-02c8768e131f@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 George Chan <gchan9527@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747567000; l=3325;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=EFFSdG3QJbIwHPF9GXOo9SwvQPg4VgLraDIxs5ZRWlE=;
 b=UKBO2x9gk2LZuNgpL9eo8MbUTXsWlLDdFGm8sEmVonLdMtIGJlTPudRSt+NbgU/SD/rEVRqX4
 g5fIg9uZIORCftJInWAxrmYazSpwOs85vDiuLkTcBW0gEzxBm41Qoyw
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Sun, 18 May 2025 14:45:03 +0200
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

Some androidboot image have invalid kernel/ramdisk load addr,
force to ignore those value and use loadaddr instead.

There is a concern on exposing the whole memory to image loading is
dangerous. Also, since it's not always possible to change the load
addr by repacking the boot.img (mainly due to AVB signature mismatch),
we need a way to use kernel_addr_r and ramdisk_addr_r.

Suggested-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: George Chan <gchan9527@gmail.com>
---
 boot/Kconfig         | 11 +++++++++++
 boot/image-android.c |  9 ++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 30eb5b328d7..b9bbfe9ce88 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -11,6 +11,17 @@ config ANDROID_BOOT_IMAGE
 	  This enables support for booting images which use the Android
 	  image format header.
 
+config ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
+	bool "Android Boot Image ignore addr"
+	default n
+	help
+	  This ignore kernel/ramdisk load addr specified in androidboot header.
+
+	  There is a concern on exposing the whole memory to image loading is
+	  dangerous. Also, since it's not always possible to change the load
+	  addr by repacking the boot.img (mainly due to AVB signature mismatch),
+	  we need a way to use kernel_addr_r and ramdisk_addr_r.
+
 config TIMESTAMP
 	bool "Show image date and time when displaying image information"
 	default y if CMD_DATE
diff --git a/boot/image-android.c b/boot/image-android.c
index 1746b018900..ab7c08eeb89 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -268,7 +268,8 @@ static ulong android_image_get_kernel_addr(struct andr_image_data *img_data,
 	 *
 	 * Otherwise, we will return the actual value set by the user.
 	 */
-	if (img_data->kernel_addr  == ANDROID_IMAGE_DEFAULT_KERNEL_ADDR) {
+	if (img_data->kernel_addr  == ANDROID_IMAGE_DEFAULT_KERNEL_ADDR ||
+	    IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR)) {
 		if (comp == IH_COMP_NONE)
 			return img_data->kernel_ptr;
 		return env_get_ulong("kernel_addr_r", 16, 0);
@@ -464,7 +465,8 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
 	 */
 	if (img_data.header_version > 2) {
 		/* Ramdisk can't be used in-place, copy it to ramdisk_addr_r */
-		if (img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
+		if (img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR ||
+		    IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR)) {
 			ramdisk_ptr = env_get_ulong("ramdisk_addr_r", 16, 0);
 			if (!ramdisk_ptr) {
 				printf("Invalid ramdisk_addr_r to copy ramdisk into\n");
@@ -488,7 +490,8 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
 	} else {
 		/* Ramdisk can be used in-place, use current ptr */
 		if (img_data.ramdisk_addr == 0 ||
-		    img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
+		    img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR ||
+		    IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR)) {
 			*rd_data = img_data.ramdisk_ptr;
 		} else {
 			ramdisk_ptr = img_data.ramdisk_addr;

-- 
2.43.0


