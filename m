Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E7BC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 19:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A418817EC;
	Thu, 13 Mar 2025 20:14:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741893255;
	bh=ytXvrHh/BvIZIQmU/sp5t7lZczh2Mnd77v1ouQWlScc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZulV7fluvtc+9H74hOlUpCPKD5puPup5EPtr+FMBH/DcUJX2b8gUo5tBn3z8tgT4G
	 Fy0dz/YQtynDN/8ecB0IGgUUcG9LsBLOqBLeW3UrZDofrrgJSY9EXxlTx3fUwaoo7C
	 rIw1JYPaVcAF/Sxj/Wa6bqpBP3mSYIvhNodPgoZqIvSNOPbtob8xZ+ujxxqJxBg/Vc
	 Mtzw3VZqO/DMebJb78YrDlYML986zQYHDhjPP2PDfJ16jCb/QJLNHUMs38r97d4uBk
	 DcyBmb/491zu0C+MR8tf1pTaoPzKWY1bGMRd2UtgUacoi6kUe6AXXVpWqkoe67LsRk
	 ibrH+ZCVyUvcg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81BF580F9C; Thu, 13 Mar 2025 20:14:13 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7898E8175D
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 20:14:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="QaCl5J0O"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 977391020211A; Thu, 13 Mar 2025 20:14:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741893250; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=ytXvrHh/BvIZIQmU/sp5t7lZczh2Mnd77v1ouQWlScc=;
 b=QaCl5J0OIwOHzpZzR1JgplEH3LbTMeC3StBdHmmbN6ZlTs+9zaroNsZUSa3rvXEwetzhYh
 9+VRJZwrIOnouWoZDevN8jDToO34ex5ymLZhAjuwKQA0jFp4+L/PYr/+n8/f6r8qpO0G0D
 ZpwysismUyRFb/wXLUR1H3SbRc8EYjLOpazlLUdoVdtiIaU1Q9BWqT1XWM0CzYa4ZHJJ2/
 AV6Hn7zNxiuaLNDD5YfxIhHe5pPtbjbfbAX7gPGryrvM1nYfR/r4xQoQdj9drHUVNmH/t1
 mkudcT7MFcEXzuDXz6ddEWfGKAax2wAjD3xM8mcDv2vBszCL6f66r1ZPrRiCZw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 01/11] cmd: fs: Add generic mkdir implementation
Date: Thu, 13 Mar 2025 20:13:17 +0100
Message-ID: <20250313191348.170054-2-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313191348.170054-1-marex@denx.de>
References: <20250313191348.170054-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Add generic implementation of the 'mkdir' command to create directories
in filesystems using the generic filesystem API.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Hiago De Franco <hiago.franco@toradex.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Add RB from Tom
---
 cmd/fs.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/cmd/fs.c b/cmd/fs.c
index 3faf7627447..bccc3a129bd 100644
--- a/cmd/fs.c
+++ b/cmd/fs.c
@@ -85,6 +85,20 @@ U_BOOT_CMD(
 	"      device type 'interface' instance 'dev'."
 );
 
+static int do_mkdir_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
+			    char *const argv[])
+{
+	return do_mkdir(cmdtp, flag, argc, argv, FS_TYPE_ANY);
+}
+
+U_BOOT_CMD(
+	mkdir,	4,	1,	do_mkdir_wrapper,
+	"create a directory",
+	"<interface> [<dev[:part]>] <directory>\n"
+	"    - Create a directory 'directory' of partition 'part' on\n"
+	"      device type 'interface' instance 'dev'."
+);
+
 static int do_fstype_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
 			     char *const argv[])
 {
-- 
2.47.2

