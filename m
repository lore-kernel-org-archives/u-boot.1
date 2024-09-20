Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC9FCF58E5
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 014EF893CF;
	Fri, 20 Sep 2024 10:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZAsD6BUE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8990989406; Fri, 20 Sep 2024 10:13:28 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A47B893BE
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f75b13c2a8so20929451fa.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726820006; x=1727424806; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HXyW4pRsSCcVIRcKTWYcvGRzZT6vG8TSb3yXObrbxdM=;
 b=ZAsD6BUE531KzPBt7sM6xuUYZpgxIG4BhjfzeFvAjbmVAJU62iYGjAYuls7MMuClBr
 R+jPyyEje3rbZ1wtBLKVerW+s6toixY3xsL7iKLtar8SjcGJ7S1YjgOa66cjRVj2VkAs
 /ng6yZfVmPVDsu4ZkzBI34cvUGnPX/BOi9+wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726820006; x=1727424806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HXyW4pRsSCcVIRcKTWYcvGRzZT6vG8TSb3yXObrbxdM=;
 b=NoZCuUnDbDUbGOTDHTYvcTMIIdRX9YctcZ6QW/JDH6/8dMZvxCTx71AyT+uwsBJIpy
 nO6txqixOWqKdRWI4c8qsnwZHv+6+OXUtrfCTbNyYBHMTEMaV7JBYIeJcwYmi9qMIbny
 YwDXjg9yhDNj3IznUEXfy7ZG2Er7NMhK26zjrS42GeEZZQxX9lx4XH28FevMVCsJsvBI
 xD+BrGSjN0YNlliEx7h20qQXUEcu49zqjnJdJgFEPjxw5XrS1l/xtHsh0RNsgB0BEPtV
 BXdRjZ1LAzQaB7DjGSogmgjaSBbsXLYPsZSya6H9LJcwNVkF3qD3AOYygV7DjuUUTVIy
 qUbQ==
X-Gm-Message-State: AOJu0Ywp2Kh0MURnFIFjVzDqnXOsTfBWsz+r5h0hxLbHO0P8GLl7fmoJ
 dvyxlKKMdYApNLQ/wQealuSTiNqRS2VwERtPDJFSXYZfzfFZ+qSw5o6AbUIcHfBNAHP4WfaPQ1D
 T/X7s
X-Google-Smtp-Source: AGHT+IG5mndTc747tTjKNr21MFmDZNFY1zcsV/iDZHmV/9xvPHcPgJe0DpeJiPUJnhHATk7RTEQSPQ==
X-Received: by 2002:a2e:bc22:0:b0:2f3:af4b:224 with SMTP id
 38308e7fff4ca-2f7cb2f8e66mr13992091fa.8.1726820005594; 
 Fri, 20 Sep 2024 01:13:25 -0700 (PDT)
Received: from chromium.org ([83.68.141.146]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc88cf7sm6804447a12.90.2024.09.20.01.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:13:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Nam Cao <namcao@linutronix.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v2 03/18] bootstd: Avoid sprintf() in SPL when creating
 bootdevs
Date: Fri, 20 Sep 2024 10:12:42 +0200
Message-ID: <20240920081309.140426-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081309.140426-1-sjg@chromium.org>
References: <20240920081309.140426-1-sjg@chromium.org>
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

The name of the bootdev device is not that important, particular in SPL.
Save a little code space by using a simpler name.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootdev-uclass.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 807f8dfb064..79d4d990edb 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -16,6 +16,7 @@
 #include <malloc.h>
 #include <part.h>
 #include <sort.h>
+#include <spl.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dm/uclass-internal.h>
@@ -278,8 +279,13 @@ int bootdev_setup_for_sibling_blk(struct udevice *blk, const char *drv_name)
 	int ret, len;
 
 	len = bootdev_get_suffix_start(blk, ".blk");
-	snprintf(dev_name, sizeof(dev_name), "%.*s.%s", len, blk->name,
-		 "bootdev");
+	if (spl_phase() < PHASE_BOARD_R) {
+		strncpy(dev_name, blk->name, sizeof(dev_name) - 5);
+		strcat(dev_name, ".sib");
+	} else {
+		snprintf(dev_name, sizeof(dev_name), "%.*s.%s", len, blk->name,
+			 "bootdev");
+	}
 
 	parent = dev_get_parent(blk);
 	ret = device_find_child_by_name(parent, dev_name, &dev);
-- 
2.43.0

