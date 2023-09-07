Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293DCEC8738
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 15:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD59586A82;
	Thu,  7 Sep 2023 17:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hEhz+Azi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49DC686A4F; Thu,  7 Sep 2023 17:58:38 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 892A586A5F
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-79275d86bc3so48916339f.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102313; x=1694707113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fkZwhdJhENBpESEt/sV3VsPfKYGqPD6jYJ4ieFQB6A4=;
 b=hEhz+Azi8vf5OtNzloq4FITO50Cey3oUOEsn+RgURB4KOiAagZFwFScxVBsJ/ql62W
 W6b4xqs1tXHyJqMQzjqe9msuC0y6prY84yiFSDKwEpJNsLf+f2K1stYgbOQhSThr2FQT
 WOV8Qy/VK/BvkZoPkWEV2x3hp/YJ6MU8hdAK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102313; x=1694707113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fkZwhdJhENBpESEt/sV3VsPfKYGqPD6jYJ4ieFQB6A4=;
 b=KyXfPUuWUoEba+NhFLZfSg/Aqv1/u2qRQ8Ln/Qt/3ItBcfwX57bpYvEXZ+WoCyVTQc
 scy7h3ck+4REvni/3JS18WnUF2+HzVxKE3xIROK9YGXclDCxUFeHuBOxm6nWEXviFrHd
 U12csn0Zbzt+AmL+YQ4aOP/lDuuJqm7VVJLrL1ZfYfKpKGP4RbmpYWaz+QRCRP2OHMX/
 28dLg8/sahJQUYyIAolwDZiI/A4JeUnLXkoaCxB5GAY6OyTses0tO7+jp6WC/lyQdZp3
 NMdrmRdY2xUmrVFtBXFUwMXpXAnwEahAqZ7X+j7SbfCMsSz4R1T5KIcdbnifrZRol7Ej
 jeEw==
X-Gm-Message-State: AOJu0YwHgkK2YltLLvSYb0t9skKLqenK7xEPGkJZvBYPRliudqlEiBO/
 /cUSaD+7ng2N1dGogrP4wBcxS26vdQdmXkhSne8=
X-Google-Smtp-Source: AGHT+IE2yo+OV6zSPmrmX4H8sxg5VSA7IR+RBIbj1pl018cX11zPNpyCrbhdXlKJkgwvv1QGYGWSLg==
X-Received: by 2002:a5e:c00a:0:b0:783:60f7:ade9 with SMTP id
 u10-20020a5ec00a000000b0078360f7ade9mr152288iol.5.1694102313182; 
 Thu, 07 Sep 2023 08:58:33 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a02b881000000b004317dfe68e7sm5498839jam.153.2023.09.07.08.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:58:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 3/9] x86: Add some log categories
Date: Thu,  7 Sep 2023 09:58:15 -0600
Message-ID: <20230907155825.48056-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155825.48056-1-sjg@chromium.org>
References: <20230907155825.48056-1-sjg@chromium.org>
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

Add some missing log categories to a few files.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v1)

 arch/x86/cpu/broadwell/sdram.c | 2 ++
 arch/x86/lib/tpl.c             | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/cpu/broadwell/sdram.c b/arch/x86/cpu/broadwell/sdram.c
index f477d513efce..d30ebee021ea 100644
--- a/arch/x86/cpu/broadwell/sdram.c
+++ b/arch/x86/cpu/broadwell/sdram.c
@@ -5,6 +5,8 @@
  * From coreboot src/soc/intel/broadwell/romstage/raminit.c
  */
 
+#define LOG_CATEGORY UCLASS_RAM
+
 #include <common.h>
 #include <dm.h>
 #include <init.h>
diff --git a/arch/x86/lib/tpl.c b/arch/x86/lib/tpl.c
index 18b05b2f6720..273e9c8e1ca1 100644
--- a/arch/x86/lib/tpl.c
+++ b/arch/x86/lib/tpl.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2018 Google, Inc
  */
 
+#define LOG_CATEGORY	LOGC_BOOT
+
 #include <common.h>
 #include <debug_uart.h>
 #include <dm.h>
-- 
2.42.0.283.g2d96d420d3-goog

