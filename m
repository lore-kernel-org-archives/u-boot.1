Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CB3E66882
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B43789438;
	Sat, 23 Nov 2024 22:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 554AC893C9; Sat, 23 Nov 2024 20:57:44 +0100 (CET)
Received: from cavan.codon.org.uk (cavan.codon.org.uk
 [IPv6:2a00:1098:84:22e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FC22891B4
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 20:57:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mjg59@codon.org.uk
Received: from fedora.. (23-93-16-71.fiber.dynamic.sonic.net [23.93.16.71])
 by cavan.codon.org.uk (Postfix) with ESMTPSA id 9F6BA407DD;
 Sat, 23 Nov 2024 19:57:40 +0000 (GMT)
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: u-boot@lists.denx.de
Cc: Janis Danisevskis <jdanisevskis@aurora.tech>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/10] Fix efi_bind_block.
Date: Sat, 23 Nov 2024 11:55:08 -0800
Message-ID: <20241123195616.305687-10-mjg59@srcf.ucam.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241123195616.305687-1-mjg59@srcf.ucam.org>
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 23 Nov 2024 22:49:00 +0100
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

From: Janis Danisevskis <jdanisevskis@aurora.tech>

efi_bind_block had two issues.
1. A pointer to a the stack was inserted as plat structure and thus used
beyond its life time.
2. Only the first segment of the device path was copied into the
platfom data structure resulting in an unterminated device path.

Signed-off-by: Janis Danisevskis <jdanisevskis@aurora.tech>
Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
---

 lib/efi/efi_app_init.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/lib/efi/efi_app_init.c b/lib/efi/efi_app_init.c
index 9704020b749..cc91e1d74b8 100644
--- a/lib/efi/efi_app_init.c
+++ b/lib/efi/efi_app_init.c
@@ -19,6 +19,15 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+static size_t device_path_length(const struct efi_device_path *device_path)
+{
+	const struct efi_device_path *d;
+
+	for (d = device_path; d->type != DEVICE_PATH_TYPE_END; d = (void *)d + d->length) {
+	}
+	return (void *)d - (void *)device_path + d->length;
+}
+
 /**
  * efi_bind_block() - bind a new block device to an EFI device
  *
@@ -39,19 +48,23 @@ int efi_bind_block(efi_handle_t handle, struct efi_block_io *blkio,
 		   struct efi_device_path *device_path, int len,
 		   struct udevice **devp)
 {
-	struct efi_media_plat plat;
+	struct efi_media_plat *plat;
 	struct udevice *dev;
 	char name[18];
 	int ret;
-
-	plat.handle = handle;
-	plat.blkio = blkio;
-	plat.device_path = malloc(device_path->length);
-	if (!plat.device_path)
+	size_t device_path_len = device_path_length(device_path);
+
+	plat = malloc(sizeof(struct efi_media_plat));
+	if (!plat)
+		return log_msg_ret("plat", -ENOMEM);
+	plat->handle = handle;
+	plat->blkio = blkio;
+	plat->device_path = malloc(device_path_len);
+	if (!plat->device_path)
 		return log_msg_ret("path", -ENOMEM);
-	memcpy(plat.device_path, device_path, device_path->length);
+	memcpy(plat->device_path, device_path, device_path_len);
 	ret = device_bind(dm_root(), DM_DRIVER_GET(efi_media), "efi_media",
-			  &plat, ofnode_null(), &dev);
+			  plat, ofnode_null(), &dev);
 	if (ret)
 		return log_msg_ret("bind", ret);
 
-- 
2.47.0

