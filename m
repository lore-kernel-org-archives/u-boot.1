Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945E9C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACC6D8655E;
	Thu, 31 Aug 2023 05:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dmRJjJmC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CB718658D; Thu, 31 Aug 2023 05:53:49 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89FF086586
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-794e0e8b588so17092339f.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693454025; x=1694058825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XoS3qRzg+EHHOpK2NCwe3wlUpx7/816qSLk/yTyjbqY=;
 b=dmRJjJmCCj8YJ065b8rSyeDdYheNUpTt0nehXjeie8NfntV9aWYKTvUVuLtNBG6sXv
 dOGJdWO/pXfqK1ahzO3JfEpB9oxxqzGweSwfR5gSgzLuFmmEn+JSw+TB8QCjmgtd/YWH
 e/qsukrbb3ZGwY9GdOnHcWHG3u7tzyrHYrl4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454025; x=1694058825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XoS3qRzg+EHHOpK2NCwe3wlUpx7/816qSLk/yTyjbqY=;
 b=Yq0UDDCbg6r+if6WiV5lkclYEJQvbfDkUmOCa2893m7SGfGCbhjCGn5DrvnDNL8Feq
 k0OZWDRCTL1d09jAEcu3pe7esftlTT8louNMxdJJSB3yiM3mLH4kclaW+PAZFmuOwkio
 kOe2BHQ/YlN0AByihe1zctYRC/Wznq/1gpDiikiBfO1bwgAbdhcrOiBw9LzqZ2rPyTO2
 ueCcdsuNBL4M3wnuQgPjPA5CbM9giJ24wDDg6/vLXiJsze4klrlv2aFqMLsjJ3XrmOzS
 D1Xq+q82y6vYjWaQAiMnGfQX64IDFZygWKtAkIXSptEX64rpYNf/199rHag3Es17E7ju
 VdHQ==
X-Gm-Message-State: AOJu0YwpnvsCXI5cplfhjH/VOl9qNzcsJ4d7/h8nBd96KW8mXOt5Ux/i
 5+8miZldfeU9qcV3W0+xKzUeX5HGKbUERSIp34I=
X-Google-Smtp-Source: AGHT+IF3XpRQwHOKPmu91Kkvg4X4YJkVzVX5OyEVYZcPMQOquqx8DZgci3RC7H30hnz6BHL7BK4aIg==
X-Received: by 2002:a6b:6e09:0:b0:783:56f2:e733 with SMTP id
 d9-20020a6b6e09000000b0078356f2e733mr4492355ioh.4.1693454025194; 
 Wed, 30 Aug 2023 20:53:45 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dy47-20020a0566381d6f00b0042036f06b24sm160002jab.163.2023.08.30.20.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:53:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 19/19] boot: Join ARCH_FIXUP_FDT_MEMORY with related options
Date: Wed, 30 Aug 2023 21:53:13 -0600
Message-ID: <20230831035319.2316665-20-sjg@chromium.org>
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

 boot/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 023446130282..257f4cc085e1 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -693,14 +693,6 @@ config SUPPORT_RAW_INITRD
 	  address of the initrd must be augmented by it's size, in the following
 	  format: "<initrd address>:<initrd size>".
 
-config ARCH_FIXUP_FDT_MEMORY
-	bool "Enable arch_fixup_memory_banks() call"
-	default y
-	help
-	  Enable FDT memory map syncup before OS boot. This feature can be
-	  used for booting OS with different memory setup where the part of
-	  the memory location should be used for different purpose.
-
 config CHROMEOS
 	bool "Support booting Chrome OS"
 	help
@@ -1492,6 +1484,14 @@ config FDT_SIMPLEFB
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
2.42.0.rc2.253.gd59a3bf2b4-goog

