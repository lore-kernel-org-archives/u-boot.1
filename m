Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE77EC8738
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D6EE86B22;
	Thu,  7 Sep 2023 18:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Iy/gnYdH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30A5186A93; Thu,  7 Sep 2023 18:00:03 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C43F986A4B
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34ca22e3b3dso4505015ab.3
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102397; x=1694707197; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yDGCTSywjcd0z42qkg2QgJKHb6GW5Oxd9JVCn8uvlE=;
 b=Iy/gnYdHGDLOf6E6/OhMdDMvsn7fA3E69/xmofc5Rgn6iq+9TIkbKoHTM++DUJSOM3
 Q9XTe+WLmYMP6Vk8+X3a1lOoXdQ6rD8dvXDZFGrN39Hyq6HByodZxH7CzkO8rqt20xCG
 prgQSkgggNTphdncz6xFdi5W15HqWNcb2D2hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102397; x=1694707197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yDGCTSywjcd0z42qkg2QgJKHb6GW5Oxd9JVCn8uvlE=;
 b=EKCsrvsbf+jdlKtAscAooCbzh7J3MqQC6sqyr6sptYBO2/yBjqhCRLii8zDNFCcy+v
 MTcJSg9cv3Z8W0/hUtvi4XJ+sd773TmDotAJ6fCOkqNd1Wal1wBUDVo7BoAX6KcWPgen
 jgXHaaSMRvLOg8DUDD8ItjhKYyKSvOMDZGOoSrT8S4VFwMu4caGkjdubVKOI9umvd2Pz
 2CL27R2LMO90nFectem46priL5Ef2DePdfUXsD0Atf1QzW496aucMBskkfD2tlBtiZeT
 qS7ugB/mYYuAxWdNfJ6Jy+M7WOUl4PPKsC7z1lHVg/yQGjwZAY3qXN1Du5NnJsqUBC/5
 nYaQ==
X-Gm-Message-State: AOJu0YzZviL4LgjJeoieV+4gJvOi3FdD9WabkQBT2Y4k2KjegOAnvO/j
 fKXwG96XQxIC4FTpLRDENiSEpPQ59t4XuIqDw84=
X-Google-Smtp-Source: AGHT+IGf0wKfpSCGTczGd46q5k3uhaKrQrEJMClMVn3HMsm2Bkeipa9CYSTcw5Q5IfzsOjrYML8+MA==
X-Received: by 2002:a05:6e02:1be2:b0:34c:e16d:6796 with SMTP id
 y2-20020a056e021be200b0034ce16d6796mr147727ilv.16.1694102397459; 
 Thu, 07 Sep 2023 08:59:57 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 22/22] boot: Join ARCH_FIXUP_FDT_MEMORY with related options
Date: Thu,  7 Sep 2023 09:59:27 -0600
Message-ID: <20230907155933.48511-23-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155933.48511-1-sjg@chromium.org>
References: <20230907155933.48511-1-sjg@chromium.org>
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

Move this to be with the other devicetree-fixup options.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Drop patch 'Move SYS_RX_ETH_BUFFER into the network menu'

 boot/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 235c5a7a9933..a01e6cb8aafe 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -693,14 +693,6 @@ config SUPPORT_RAW_INITRD
 	  address of the initrd must be augmented by it's size, in the following
 	  format: "<initrd address>:<initrd size>".
 
-config ARCH_FIXUP_FDT_MEMORY
-	bool "Enable arch_fixup_memory_banks() call"
-	default y if OF_LIBFDT
-	help
-	  Enable FDT memory map syncup before OS boot. This feature can be
-	  used for booting OS with different memory setup where the part of
-	  the memory location should be used for different purpose.
-
 config CHROMEOS
 	bool "Support booting Chrome OS"
 	help
@@ -1490,6 +1482,14 @@ config FDT_SIMPLEFB
 	  the presence of the simple frame buffer with associated reserved
 	  memory
 
+config ARCH_FIXUP_FDT_MEMORY
+	bool "Enable arch_fixup_memory_banks() call"
+	default y
+	help
+	  Enable FDT memory map syncup before OS boot. This feature can be
+	  used for booting OS with different memory setup where the part of
+	  the memory location should be used for different purpose.
+
 endmenu
 
 endif # OF_LIBFDT
-- 
2.42.0.283.g2d96d420d3-goog

