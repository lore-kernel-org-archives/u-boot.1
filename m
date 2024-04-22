Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC2FC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 09:16:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C66E38806A;
	Mon, 22 Apr 2024 11:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nniJClbp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 649A088289; Mon, 22 Apr 2024 11:16:49 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E31087EF7
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 11:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AF52A3F16A
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 09:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713777406;
 bh=dJ/ZW6j4Q/X6epNGCsIEFWquYBQvlv/esz7R0Y/VlIg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=nniJClbpizWq+lYJKoWZlOAk47RzH7jLCPYiVN+W35d3y9jreyuSyVaf0vwH5rY8u
 5gGdLgKY616SFDxvCyau1YGXsZtpEC9V19eQdkSnwvsEwOyoS+tP64cq9BkdBkHOzy
 rjJCkj6T1QgLEuUeXQcuMqyczwfO64LzrrnSYg7j61gmsWTJ0AUXcCJFPcFbrhci4p
 s/sEHNshfCi14+ISoDioBfHxI4lRbO6/XvXzAvz8FUfY8hWNoyEGMUTNXPaeOUOzgh
 dVxNcDzaflVLMWllbI1LrH3SiE+SEOZdxtUnDSND/XtyWc4ft3CchWx+aqe8WPdA0p
 aFVTocBWIPF3A==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-418f8271081so14405675e9.3
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 02:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713777406; x=1714382206;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dJ/ZW6j4Q/X6epNGCsIEFWquYBQvlv/esz7R0Y/VlIg=;
 b=hnK+ElyKv0JZ8OYPURKZbbgNt4q65mjXtCUBD3zzVWl955DRmKk6W4LqH7UyGq/jwv
 e/I6SjOnRnOgVoC9HfeJB+nHdok/aA/RgdK2rB/q68/d8clsX/3rUHEQCqm1K3gu2yrK
 qufY5syH7SKz8vazLPNM5wyTnWCFmoCYqtPO8oWO5C6V0AcHGipPyWlL3uI8UMp68VqM
 wK8kJk8HLXXxpUZGKFkyG80+E9eHT4n7+pQ2rVgciIDDx1zICh+R2K0+f7BLKMEg41gM
 UeNmDIqgoBIzos83BOjXZqHMR+M0g5alnj4oaAkSa8cnXjD2ECTKZEC8YX4uKHaeGGR9
 6CXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkRhjAO86u/SoEhx/1wfaVT+mLgaa7Y5Dx2VSzxktPAEsNqal6p201TzaziaoQ61AddQh5bzuro9DSW/sSN9MljZojQg==
X-Gm-Message-State: AOJu0YzFjMAsWhuE4aGZqk1xYXUrkIQ0l2kCOhg1NyKuPCc4VkwDIY23
 0k/jnaNzpkV13FnXn1HXxEu31EnKEkbh+/13t1om607V53bU+gO4UsnWgRiKp02nAgJALfyEQ/Q
 enc5hoXnpWM6Y4UH/9nfHyIDzyopyt2BVKfyLqTyMRu5GE6sfBqADnyQZyjz7AMs8Qaw=
X-Received: by 2002:a05:600c:1389:b0:41a:8b39:8040 with SMTP id
 u9-20020a05600c138900b0041a8b398040mr499899wmf.20.1713777406299; 
 Mon, 22 Apr 2024 02:16:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSSRr6T/XY5lwQzUkgbkX4x8PisZrC8akcBzea5ICM7y0W1ByfpiUoQ6my7lr+CBVgxIpeeg==
X-Received: by 2002:a05:600c:1389:b0:41a:8b39:8040 with SMTP id
 u9-20020a05600c138900b0041a8b398040mr499880wmf.20.1713777405951; 
 Mon, 22 Apr 2024 02:16:45 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a05600c198d00b00417da22df18sm19638529wmq.9.2024.04.22.02.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 02:16:45 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] efi_loader: do not install dtb if bootmgr fails
Date: Mon, 22 Apr 2024 11:16:34 +0200
Message-ID: <20240422091634.83909-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

If the UEFI boot manager fails, there is no point in installing the
device-tree as a configuration table.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_bootmgr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index c64cbe82402..2b0d3137338 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1209,15 +1209,15 @@ efi_status_t efi_bootmgr_run(void *fdt)
 		return CMD_RET_FAILURE;
 	}
 
-	ret = efi_install_fdt(fdt);
-	if (ret != EFI_SUCCESS)
-		return ret;
-
 	ret = efi_bootmgr_load(&handle, &load_options);
 	if (ret != EFI_SUCCESS) {
 		log_notice("EFI boot manager: Cannot load any image\n");
 		return ret;
 	}
 
+	ret = efi_install_fdt(fdt);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
 	return do_bootefi_exec(handle, load_options);
 }
-- 
2.43.0

