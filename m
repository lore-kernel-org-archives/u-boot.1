Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90BBCD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 08:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3943F8486A;
	Sat, 23 May 2026 10:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MsmpH+y/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62D438486D; Sat, 23 May 2026 10:55:36 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BD6C84867
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 10:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e6201aeb2aso226480a34.3
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 01:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779526533; x=1780131333; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SpJlVka4zEfu6h+99uxh01lvQ/52AFNc4a4dQtBobYg=;
 b=MsmpH+y/gHa0ApS+6UmPchP446+uETgG4LZKH2pnQZ8+tJjxSUi0p9w/LPbX35p44W
 a3ICU9M8lsnRivgEZMCV5TfEV5ZLNHHBkwnJFbFD4AANStJJO+1G7pfCNJqtJKVTSLpm
 YRNqK0iMHrCzY+ze3C9ug8nGmSlP4ag0V2meY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779526533; x=1780131333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SpJlVka4zEfu6h+99uxh01lvQ/52AFNc4a4dQtBobYg=;
 b=iCmHt5oRXwso3uXtlIWikW3tbf+vgk2nQx5N0jBhNNXwD7oVU58AqekeiTG3EYuKoG
 FDTVnP6RX2Z5Q24ffEuaSl1QEvFRgJOLqvoJ8HfPTfALqlFtAERMnPECovrTgKeCpHLo
 iUHTVCZIcazBJzYjNqpPQCyUJOGZWiS07jfuePK8svczP78p75FytftR8cwxkhOYTy/C
 odwGHMXwavg8e7X41HSvQ2f61xYkajlDXHNMtIVldj9XDWy21pwkGQCti59mmAp7E0Q2
 YyRyHzehCsY9Ec4LNhlWYxZN9/yT/MzP82kENOJvC6NAfKNC4cpHTcmfij6fraoONQJO
 USsw==
X-Gm-Message-State: AOJu0Yxj8tgWvNfwI/4wJcjbtxLY9+nabGB3HPL1TLvdr1HaJAW4HJRZ
 A4gS6qlmsu1Od9gagskzosTuX7+O7VYHt5R2zSC+rYHImJ2GBsdFwQnIcV1NPDrfwuJcbCJmMKI
 5y8uQqY15
X-Gm-Gg: Acq92OGvEFIElsLoVtKTNJhNdXSXkg4cAnjXkW1tepIswG3gGwgIw4zuOn16kwvhKOC
 AEU4kw5WyHMTZpMH+HBu2i1ZthZFVCrQndASXqhqkGFh6JLTitInPz709MOo0QnFFF2QmieXW/6
 gPuh60sXgvKOnUxL23q71+72tCxhIQFryLt4Ki+B7zlj8qp0G/idgj9+a1/Rs7ILT9hnrZ0jbjR
 jh6ivcxZarWzrbmQe24VrFKfxdIzzfpjTc1/TnTF9I0bIAwz49kHPNUK/niVUv4UCURaeORvNLg
 QLTRSJi/2oSxKfQKipZ7PUOx8EHF0P1ZL6ZEupHcwwNroYXkeQIW/5nwigqLO9YVDtjwGBELvnw
 mCbPoq1+E8a7olD2mfM1TZDhXYVpZuBDQ+3ocupdvsiHb9C+zOV2fN/mOrLeDAyrTbGhg9baqZk
 Da50qwy0an9YYiRWQ1JQ==
X-Received: by 2002:a05:6830:610d:b0:7dc:e30d:6498 with SMTP id
 46e09a7af769-7e5fec0fbddmr3876927a34.1.1779526532916; 
 Sat, 23 May 2026 01:55:32 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60666ae5fsm2893602a34.24.2026.05.23.01.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 01:55:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/11] sandbox: Find disk images in the persistent-data
 directory
Date: Sat, 23 May 2026 02:54:46 -0600
Message-ID: <20260523085455.750591-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523085455.750591-1-sjg@chromium.org>
References: <20260523085455.750591-1-sjg@chromium.org>
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

The sandbox mmc, scsi and usb-flash drivers open their backing files
from plat->pathname as given. Test images are about to move out of
the source tree into the persistent-data directory, so the drivers
need to find them there.

Try the persistent-data directory first via os_persistent_file() and
fall back to the original pathname when the lookup fails, so absolute
paths and files already in the current directory keep working.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/mmc/sandbox_mmc.c        | 13 +++++++++++--
 drivers/scsi/sandbox_scsi.c      | 15 ++++++++++++---
 drivers/usb/emul/sandbox_flash.c | 14 +++++++++++---
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/sandbox_mmc.c b/drivers/mmc/sandbox_mmc.c
index a24520f2e78..42a80c7499c 100644
--- a/drivers/mmc/sandbox_mmc.c
+++ b/drivers/mmc/sandbox_mmc.c
@@ -170,11 +170,20 @@ static int sandbox_mmc_probe(struct udevice *dev)
 	int ret;
 
 	if (plat->fname) {
-		ret = os_map_file(plat->fname, OS_O_RDWR | OS_O_CREAT,
+		const char *fname = plat->fname;
+		char buf[256];
+
+		/*
+		 * Try persistent data directory first, then fall back to the
+		 * filename as given (for absolute paths or current directory)
+		 */
+		if (!os_persistent_file(buf, sizeof(buf), plat->fname))
+			fname = buf;
+		ret = os_map_file(fname, OS_O_RDWR | OS_O_CREAT,
 				  (void **)&priv->buf, &priv->size);
 		if (ret) {
 			log_err("%s: Unable to map file '%s'\n", dev->name,
-				plat->fname);
+				fname);
 			return ret;
 		}
 		priv->csize = priv->size / SIZE_MULTIPLE - 1;
diff --git a/drivers/scsi/sandbox_scsi.c b/drivers/scsi/sandbox_scsi.c
index 544a0247083..97afeddc2e9 100644
--- a/drivers/scsi/sandbox_scsi.c
+++ b/drivers/scsi/sandbox_scsi.c
@@ -104,9 +104,18 @@ static int sandbox_scsi_probe(struct udevice *dev)
 	info->block_size = SANDBOX_SCSI_BLOCK_LEN;
 
 	if (priv->pathname) {
-		priv->fd = os_open(priv->pathname, OS_O_RDONLY);
-		if (priv->fd != -1) {
-			ret = os_get_filesize(priv->pathname, &info->file_size);
+		const char *pathname = priv->pathname;
+		char buf[256];
+
+		/*
+		 * Try persistent data directory first, then fall back to the
+		 * pathname as given (for absolute paths or current directory)
+		 */
+		if (!os_persistent_file(buf, sizeof(buf), priv->pathname))
+			pathname = buf;
+		priv->fd = os_open(pathname, OS_O_RDONLY);
+		if (priv->fd >= 0) {
+			ret = os_get_filesize(pathname, &info->file_size);
 			if (ret)
 				return log_msg_ret("sz", ret);
 		}
diff --git a/drivers/usb/emul/sandbox_flash.c b/drivers/usb/emul/sandbox_flash.c
index b5176bb30ce..82aa7062865 100644
--- a/drivers/usb/emul/sandbox_flash.c
+++ b/drivers/usb/emul/sandbox_flash.c
@@ -339,11 +339,19 @@ static int sandbox_flash_probe(struct udevice *dev)
 	struct sandbox_flash_plat *plat = dev_get_plat(dev);
 	struct sandbox_flash_priv *priv = dev_get_priv(dev);
 	struct scsi_emul_info *info = &priv->eminfo;
+	const char *pathname = plat->pathname;
+	char buf[256];
 	int ret;
 
-	priv->fd = os_open(plat->pathname, OS_O_RDWR);
-	if (priv->fd != -1) {
-		ret = os_get_filesize(plat->pathname, &info->file_size);
+	/*
+	 * Try persistent data directory first, then fall back to the
+	 * pathname as given (for absolute paths or current directory)
+	 */
+	if (!os_persistent_file(buf, sizeof(buf), plat->pathname))
+		pathname = buf;
+	priv->fd = os_open(pathname, OS_O_RDWR);
+	if (priv->fd >= 0) {
+		ret = os_get_filesize(pathname, &info->file_size);
 		if (ret)
 			return log_msg_ret("sz", ret);
 	}
-- 
2.43.0

