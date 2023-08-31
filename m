Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A5BC83F29
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:56:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67D158657D;
	Thu, 31 Aug 2023 05:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PhpYGjxp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F6FC8657D; Thu, 31 Aug 2023 05:53:48 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC8F986584
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:53:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7926de0478eso39145339f.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693454024; x=1694058824; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XKld7XwUNdq+uzEi2wzObCpRmZoK7d8OAuu98dQDmcU=;
 b=PhpYGjxpuS/ad0x73pJdTQJXOBrdP2tkZ8x2VG9y1pymC7tQayGwFmmqGK6E1MLuRt
 bY7kP0VJmYAxXMc6/X3O/Sq0Vq7/paF7IYNPHl8j19TOFVU27Ff92L9o0XdwgZXVZbQU
 77dKxQTRvzga3ei9bmvlODuFd5nh/W7WQlktM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454024; x=1694058824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XKld7XwUNdq+uzEi2wzObCpRmZoK7d8OAuu98dQDmcU=;
 b=JVb2ixp9eAUeJXwMyka7kFjnnnGGNTtgYxeDX8qhLwd7Vv/zd08qmeRZQd2hBKXlm2
 inKOpYwSoZ0ROOCJpEZBVLLrfkmTIZgq3x2H08ZFYCqqbEVDoTLKoLXkHFHQ9Rq9gNWV
 2kjA1gRUCzzJSGLyw+LzXUxgPHJVjLL+ZdUXx5v20BjLVwnfvYsYwVAB+AoVHiBf7yaX
 oN8Eenf28QrKqOlOAxHAXRL0CIb/X0JtKSn2lFUJ+iXldMdgBxrfVLMBiymxDLyM/nRG
 FNznmumgXIpn+2tDt7dt6HRjnAu6pUgTfDjV9FjFb4fcuNEz0uLglr4+bPUAMEbgr+4u
 +/OQ==
X-Gm-Message-State: AOJu0Ywewyoolf6rwHpBX/m8I4RAROFmUP6KtKmJf+nig2rCMKVUluxA
 bDoCbn6Zb+IS4wgRAQJUMNe/Js6oQVdsp+CccV0=
X-Google-Smtp-Source: AGHT+IEuK6ZWfYTYKbF2LvUklk9OVVzEMbID++0AxyH+sOggdH4ZD4bH2MALJpnPEu75GU3NeMsZHw==
X-Received: by 2002:a05:6e02:1568:b0:346:15f5:2667 with SMTP id
 k8-20020a056e02156800b0034615f52667mr1453730ilu.4.1693454024450; 
 Wed, 30 Aug 2023 20:53:44 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dy47-20020a0566381d6f00b0042036f06b24sm160002jab.163.2023.08.30.20.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:53:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 18/19] boot: Join FDT_FIXUP_PARTITIONS with related options
Date: Wed, 30 Aug 2023 21:53:12 -0600
Message-ID: <20230831035319.2316665-19-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230831035319.2316665-1-sjg@chromium.org>
References: <20230831035319.2316665-1-sjg@chromium.org>
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

(no changes since v1)

 boot/Kconfig | 8 ++++++++
 lib/Kconfig  | 9 ---------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index a7dea0a0623b..023446130282 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1476,6 +1476,14 @@ config OF_STDOUT_VIA_ALIAS
 	  incorrect when used with device tree as this option does not
 	  exist / should not be used.
 
+config FDT_FIXUP_PARTITIONS
+	bool "overwrite MTD partitions in DTS through defined in 'mtdparts'"
+	depends on CMD_MTDPARTS
+	help
+	  Allow overwriting defined partitions in the device tree blob
+	  using partition info defined in the 'mtdparts' environment
+	  variable.
+
 config FDT_SIMPLEFB
 	bool "FDT tools for simplefb support"
 	help
diff --git a/lib/Kconfig b/lib/Kconfig
index bfab2f3165a7..eb2b10161824 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -953,15 +953,6 @@ config VPL_OF_LIBFDT_ASSUME_MASK
 	  0xff means all assumptions are made and any invalid data may cause
 	  unsafe execution. See FDT_ASSUME_PERFECT, etc. in libfdt_internal.h
 
-config FDT_FIXUP_PARTITIONS
-	bool "overwrite MTD partitions in DTS through defined in 'mtdparts'"
-	depends on OF_LIBFDT
-	depends on CMD_MTDPARTS
-	help
-	  Allow overwriting defined partitions in the device tree blob
-	  using partition info defined in the 'mtdparts' environment
-	  variable.
-
 menu "System tables"
 	depends on (!EFI && !SYS_COREBOOT) || (ARM && EFI_LOADER)
 
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

