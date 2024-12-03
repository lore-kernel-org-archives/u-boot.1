Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617EEE77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3ACF89688;
	Wed,  4 Dec 2024 00:46:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oaAZ713W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E515689688; Wed,  4 Dec 2024 00:46:20 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 974B98969D
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3a7e108b491so19302705ab.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269575; x=1733874375; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pSi9T0jwsyOTf7U8m2OZryThc774EjL0fNn9zqgfeG4=;
 b=oaAZ713WQDZ96C4vysTIFMKgJgwxHyxVDKYTC0NIsUgHZEtRBqhxH37xprfsNBc2HI
 4wZ84k32n/28moosB++Hk+/jO9Ju3ZDb3ZzQVJGSDA2xwye0tdbcEen4C9owdul1bwpN
 RrVQ8ZWdzvAGoHotwAjZtV7iyxAB0HjrD71BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269575; x=1733874375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pSi9T0jwsyOTf7U8m2OZryThc774EjL0fNn9zqgfeG4=;
 b=svnrbBDU/RudhMXoNi2ghqQ2Cz+12jUDDjmEnqOYNPGW3trz/Zswn6aRWveH1/N8i5
 OmD2CyRn2ZTpZpKpyNL8hlSniiI1TBGWx6dAu0GGyHEu8wOcxfG2JpJ9/0JdWBiBzrP0
 OQ/A4qROvsY/vqaA/40620midZQPwG71/Db3uGo1HE0ti7Bee5zWIJDF9jPH/bo4aRGu
 e/Oq1mXjUDxF2ISsGeaUKAD4cqrg2DoqPd9wuds1GgT6vi5H5u6Gk6ncEMA8ERbgi0DB
 6GEC03xPyjkDdbxX3f6CVB0e65bmE/b2EP5TK+sc+dv7HdouLUVu4yi6bS4zeb8/O85f
 Ye7A==
X-Gm-Message-State: AOJu0Yy1sc/dvUNeO05k+ZACLi1/Qpl70+3QiavURioCDHR0hY4O8yzt
 ON/XUaWHzP/wZMl+WKmbf/tW4aFvbcrXJMLyP9JCNOQnzC0BiCqMPiZDWEM/A3z2uBI/ty9PrhU
 =
X-Gm-Gg: ASbGncvgdEQqa+VA3U2aalJl9qLmmQovB3+zpOk1SQqtIikMuQRRGlvOrY/91pHlYKt
 7lC/NYZT7Xh4qoUDx5OEnh7gp9pPJx2WAmLB/4STvJHRthmwCl/qjm8FYRep28EpqNOQTZEyqxx
 4+ZsnUjTf4G/ZCs1im0Nwr2+5MOccrJq/+PLWeCnKw61dQhW0jA7QdBWMzu1MbhZzINzcDvtnZd
 uMlbnAlBTSMz3MIwdQ2qCKECGiywwtH7KjSPzIUAs3svE0VxfMGa29M8WeDAyTcvn4vn/kHkMAv
 0CDT0h/J7y0=
X-Google-Smtp-Source: AGHT+IFxEx1L/YopJ+wnssZE2Q9MV3Py8ft01/LQCMUmhBSYOT87EN8fImoLExLKERaiTHhSdNZqBg==
X-Received: by 2002:a05:6602:27c5:b0:83a:a746:68a6 with SMTP id
 ca18e2360f4ac-8445b5519cbmr667838539f.5.1733269575620; 
 Tue, 03 Dec 2024 15:46:15 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:46:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2 02/41] x86: Rename zboot_run() to zboot_run_args()
Date: Tue,  3 Dec 2024 16:45:20 -0700
Message-Id: <20241203234559.2938192-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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

Rename this function so we can (later) create a zboot_run() function
which looks the same as bootm_run()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/zimage.c | 4 ++--
 boot/bootmeth_cros.c  | 6 +++---
 include/bootm.h       | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index 73a21bc8f03..53fc81f57a2 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -436,8 +436,8 @@ int zboot_go(void)
 	return ret;
 }
 
-int zboot_run(ulong addr, ulong size, ulong initrd, ulong initrd_size,
-	      ulong base, char *cmdline)
+int zboot_run_args(ulong addr, ulong size, ulong initrd, ulong initrd_size,
+		   ulong base, char *cmdline)
 {
 	int ret;
 
diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index c7b862e512a..ea4c9ed830f 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -446,9 +446,9 @@ static int cros_boot(struct udevice *dev, struct bootflow *bflow)
 	}
 
 	if (IS_ENABLED(CONFIG_X86)) {
-		ret = zboot_run(map_to_sysmem(bflow->buf), bflow->size, 0, 0,
-				map_to_sysmem(bflow->x86_setup),
-				bflow->cmdline);
+		ret = zboot_run_args(map_to_sysmem(bflow->buf), bflow->size, 0,
+				     0, map_to_sysmem(bflow->x86_setup),
+				     bflow->cmdline);
 	} else {
 		ret = bootm_boot_start(map_to_sysmem(bflow->buf),
 				       bflow->cmdline);
diff --git a/include/bootm.h b/include/bootm.h
index 61160705215..154fb98cfcd 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -273,7 +273,7 @@ int bootm_process_cmdline(char *buf, int maxlen, int flags);
 int bootm_process_cmdline_env(int flags);
 
 /**
- * zboot_run() - Run through the various steps to boot a zimage
+ * zboot_run_args() - Run through the various steps to boot a zimage
  *
  * Boot a zimage, given the component parts
  *
@@ -289,8 +289,8 @@ int bootm_process_cmdline_env(int flags);
  *	to use for booting
  * Return: -EFAULT on error (normally it does not return)
  */
-int zboot_run(ulong addr, ulong size, ulong initrd, ulong initrd_size,
-	      ulong base, char *cmdline);
+int zboot_run_args(ulong addr, ulong size, ulong initrd, ulong initrd_size,
+		   ulong base, char *cmdline);
 
 /*
  * zimage_get_kernel_version() - Get the version string from a kernel
-- 
2.34.1

