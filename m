Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED83CD4F3C
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 22:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1714846D5;
	Mon, 18 May 2026 00:52:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TxyPG+Yg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C777845E3; Mon, 18 May 2026 00:52:00 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 637EF8468A
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 00:51:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7df05fc49e5so1857039a34.3
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 15:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779058314; x=1779663114; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iPd0+OXsKTAcNrNCkaEFGT9z9N7yyZ4CPDwhfI21zeg=;
 b=TxyPG+YgSbuql8wDGsA34QiEQvbv/l03K0h0WXaDhbBro41p3S0S0TnVBE9BdVoo0U
 3pY72t+7IL/y4UPO9jVFO90O3wSsbci4CUC7WWZzZEU8tcl3dCNH5MtP91qbdLwJvtVX
 qYJPlhBb/1oCy+4rieFOkQD/G7VN06MNqjp0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779058314; x=1779663114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iPd0+OXsKTAcNrNCkaEFGT9z9N7yyZ4CPDwhfI21zeg=;
 b=OIq4Mi7keF7PQeftPvvlDDrigd7XQPVZGggGQzt0jFX4OjjMf043O5NDurNAJTr6lU
 sJshbOqVcKbLTCvLa/fYvmzs1UDvYS0goHwoX4ZjZJHwEGHGJbVk2zK1BsrUMWlWc3aN
 q3BKZeZcuuj7KDUijJBrggA9U2KusSz95KJDOg5hiPVL1pYR3HF0XbXuyRi7yhdjsQ+R
 bcdX4J6ZdXn3cSKIkcosUfo575EBeAUeKZaJ13Xdi2aDa6S+anlmHwzAD/VzMAsH6ey4
 YtYmvUsOn0T2K5tt6a+XQIrxqTM2lI2m2I4etWRHMRqOS+f3yzUGJWx712qC5q/KF35z
 wwxw==
X-Gm-Message-State: AOJu0YwV6fJ4MMsKcGqjpoVqsPI65Kg0w+dyqv2Ga/YLa5jBtcZQubku
 5b6ks4Xut2K23j8AyY0LW1V2avJKfwmln5hMOXzz/o8cDDYGb9Ql9iSQ2rOdXAphG69VGNR7/av
 zA1DwDssN
X-Gm-Gg: Acq92OFvsiYjpkXsuAFgzh6/GeIyRoKrYb5DUGIuNrkJMFzlw7kSKSyIaYHjrhvHczn
 +Ow3cI1rX1j3Np4NKgu6FmgZsfShhHL4+eP1G0pPvOyQ1Ej3cEpKMfg2OGJa3BVZrfzEUdDGjxX
 tliEBK66puNRfxEE2h1zrIu/t5RWOL5+FAzxQuLQXmmGjU69/1EvGfwg4iemlnH3RgKY4JUBMW5
 YpArnbslAgAD//Kippw1BNzfv+c5kgvr5yIQZOOLTmpPk7g8lu2/ygj2ISa1HWeCUcFxr0jUEpI
 hKVl8H+zynGnAr449HuStCJdFTfl7hfb4XvI2a89nGKptrSzNAXvSbwRddH3MFabKZeJg1E4GOl
 XlZaT/ZSJfawPvNuRTuA+NBQdlu73kMRDsi8EXJK+VMhLo9RDAYDYpGlnd0JacoP61mGCo+iW8B
 3/DHub5fRwFSQrSsCqlWU6CWenPZpA
X-Received: by 2002:a05:6830:3907:b0:7d7:f158:1f44 with SMTP id
 46e09a7af769-7e4fa052482mr9120515a34.21.1779058314605; 
 Sun, 17 May 2026 15:51:54 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4983asm6386357a34.26.2026.05.17.15.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 15:51:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/11] sandbox: Find disk images in the persistent-data
 directory
Date: Sun, 17 May 2026 16:51:08 -0600
Message-ID: <20260517225122.2966807-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517225122.2966807-1-sjg@chromium.org>
References: <20260517225122.2966807-1-sjg@chromium.org>
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

