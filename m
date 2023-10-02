Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353C5E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A085B87256;
	Mon,  2 Oct 2023 03:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WwMM/bS3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9224C87254; Mon,  2 Oct 2023 03:17:57 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 456B087234
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-79f82b26abfso561333639f.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209377; x=1696814177; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gl3X0xI53XjBuGVwFhWPktFYHy255FHxFMP1grC5Qvs=;
 b=WwMM/bS3M3b4WZ3fbNvUAfDqxq8mElF0AM4vwknW38t73rMp1I3GTi2JbhUusjcm3M
 nYYcPqyXxmu11N6KCNNyTW/eaUFJOmjrX5jzsai/7i03UWrYbl4FNak0z+s6ZXvVgSbt
 kiIY6MQydkN+guD2hCPn9wXi5z1bMsMsepI1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209377; x=1696814177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gl3X0xI53XjBuGVwFhWPktFYHy255FHxFMP1grC5Qvs=;
 b=DnL+oLcWdSY5Q7Kq+WsEBCzoBo1jbWDJonjj607duxtEYSgSOlZg9obYb76yXaM8bE
 NngPxC8kKnVDWo1hjdAETmmWamA6C6JC1Wsnz2uCn+II4hgE5S7X5zS+M8QcXaGjgqDb
 eDG0yy6qsT63Ty06ZI9G5cMbyp26yOk7g8ZGjRnmY7Spfmkd5rb3AVxglQ8ZWAjNwn9r
 1gO4iHhIBLpxhrL8Zhen6DuckNhyZQredAqOUSzg5fkmxO7twOsYCeQRKDDQUUFtQ8z5
 ZQFiutb/QGD/+buLM4GIjigrNTUqvycrM5lrOd9h3+RFn4yLQn/Ci6ilPFrACy1Wei68
 DVNQ==
X-Gm-Message-State: AOJu0Yx1C9HPnVFPG6Yo8UBMIZMBgKWxggvrrQwDBkOUuJAMFgn8OvdM
 wDbVfUBHVvY3IsPrBysojWVBalpiKPQrmyQLGR8=
X-Google-Smtp-Source: AGHT+IFZ9i1TqOGCSfhiyK24TNInqHW44Gnz1/La0QlU40oeK5eWp0CvlU8IxpmJQEU0kgWtzj9yxw==
X-Received: by 2002:a5d:8851:0:b0:794:d7e8:d239 with SMTP id
 t17-20020a5d8851000000b00794d7e8d239mr11782380ios.17.1696209377720; 
 Sun, 01 Oct 2023 18:16:17 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 14/34] sandbox: Add a dummy booti command
Date: Sun,  1 Oct 2023 19:15:24 -0600
Message-ID: <20231002011553.463514-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

Add basic sandbox support for 'booti' so we can start to boot the test
ARMbian image. This is helpful in checking that it is parsed correctly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/lib/bootm.c     | 7 +++++++
 cmd/Kconfig                  | 2 +-
 cmd/booti.c                  | 2 +-
 configs/tools-only_defconfig | 3 ++-
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/lib/bootm.c b/arch/sandbox/lib/bootm.c
index dc8b8e46cb41..a748ba650b12 100644
--- a/arch/sandbox/lib/bootm.c
+++ b/arch/sandbox/lib/bootm.c
@@ -78,3 +78,10 @@ int do_bootm_linux(int flag, int argc, char *argv[], struct bootm_headers *image
 
 	return 0;
 }
+
+/* used for testing 'booti' command */
+int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
+		bool force_reloc)
+{
+	return 0;
+}
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 34e1c91a15a9..987f7d8cf623 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -305,7 +305,7 @@ config CMD_BOOTZ
 
 config CMD_BOOTI
 	bool "booti"
-	depends on ARM64 || RISCV
+	depends on ARM64 || RISCV || SANDBOX
 	default y
 	help
 	  Boot an AArch64 Linux Kernel image from memory.
diff --git a/cmd/booti.c b/cmd/booti.c
index 6ac39193db80..a20e65196f72 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -75,7 +75,7 @@ static int booti_start(struct cmd_tbl *cmdtp, int flag, int argc,
 	unmap_sysmem((void *)ld);
 
 	ret = booti_setup(ld, &relocated_addr, &image_size, false);
-	if (ret != 0)
+	if (ret || IS_ENABLED(CONFIG_SANDBOX))
 		return 1;
 
 	/* Handle BOOTM_STATE_LOADOS */
diff --git a/configs/tools-only_defconfig b/configs/tools-only_defconfig
index 3f588ea69bee..b54d2cefa100 100644
--- a/configs/tools-only_defconfig
+++ b/configs/tools-only_defconfig
@@ -6,8 +6,8 @@ CONFIG_SYS_LOAD_ADDR=0x0
 CONFIG_PCI=y
 # CONFIG_SANDBOX_SDL is not set
 CONFIG_ANDROID_BOOT_IMAGE=y
-CONFIG_FIT=y
 CONFIG_TIMESTAMP=y
+CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 # CONFIG_BOOTSTD_FULL is not set
 # CONFIG_BOOTMETH_CROS is not set
@@ -16,6 +16,7 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run distro_bootcmd"
 # CONFIG_CMD_BOOTD is not set
 # CONFIG_CMD_BOOTM is not set
+# CONFIG_CMD_BOOTI is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_EXTENSION is not set
 # CONFIG_CMD_DATE is not set
-- 
2.42.0.582.g8ccd20d70d-goog

