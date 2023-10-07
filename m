Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0B1E95A68
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3AD186F7D;
	Sun,  8 Oct 2023 01:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bnkI/uK6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3581A86F58; Sun,  8 Oct 2023 01:14:40 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B3C686F11
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3526c9c401aso12619515ab.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720401; x=1697325201; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vtSetA4qHjfOloCFtNzvSJJZnoL2c0o/R8elzmRu/HU=;
 b=bnkI/uK6zxPKVEXjBb1rO52GgOgCUgGrJHyQ15JlvbPq8AxPYurP+S4etMSLGlIkSK
 ZfxcTPdJSJH4/ca4tgZy2cd/naa0w9pbKDCnEkXv2d2YXl9ntCz1A0Sha5wYwZdsvw5z
 E2A6MzI9YgTocB9M0bMH8/y9G+oC0VlEy5Z0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720401; x=1697325201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vtSetA4qHjfOloCFtNzvSJJZnoL2c0o/R8elzmRu/HU=;
 b=qUXOBs6ws8nxf7lhceDoZd+k3xgwICQiOFQs4wab04Gxf1sUfUq01x67X7LK1ncLPK
 c2qoGcYtHLpLLdpV0lOq7TwJ6RHhhgcekKjN42lal2M5K1jAAuji6MmRwi9PN4ErD/QQ
 0RMUhiKAm2Wav/tSNtwcOpeKhN7ezkJ7ZsubreTd0ClEvYMw3sXxzq5GZ+sY7HVmXwQR
 kk/LE8jCzc6n6C9FIJTfer8anzsu/ioKoR+5VRuupTsuFfh5NTd3YnQYCCBDOEgb8cfd
 lM3OUvMDw7H9cmsNGROzOJWwjgk5DxjoQurtEKGTT99VbyrfLOM5Rsvz0aXqKWcK9zje
 WZIA==
X-Gm-Message-State: AOJu0YyaVMlKk3LG52452phYjbDd7EsJmAqQi1AH8wyVNtnl6Xlhaaxj
 Vw9BL/QH7q1rJp5UpOm+2JxduSfbNycSRVqhvIg=
X-Google-Smtp-Source: AGHT+IFaGZ9KnIa0cwRvMsKlIY6cVUGW1ua09fJAsjeM4U1pmHJUA3+aIm3Y+wwFWRi22Y686CCmzg==
X-Received: by 2002:a05:6e02:b24:b0:348:c606:bd1a with SMTP id
 e4-20020a056e020b2400b00348c606bd1amr7364273ilu.15.1696720401244; 
 Sat, 07 Oct 2023 16:13:21 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 21/27] video: Dont require the font command
Date: Sat,  7 Oct 2023 17:12:40 -0600
Message-ID: <20231007231255.277623-22-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

While it is nice to have the font command, using 'select' makes it
impossible to build the console code without it. Change this to use
'imply' instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index ab927641bb7a..21ea5c860cca 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -180,7 +180,7 @@ config CONSOLE_ROTATION
 
 config CONSOLE_TRUETYPE
 	bool "Support a console that uses TrueType fonts"
-	select CMD_SELECT_FONT
+	imply CMD_SELECT_FONT
 	help
 	  TrueTrype fonts can provide outline-drawing capability rather than
 	  needing to provide a bitmap for each font and size that is needed.
-- 
2.42.0.609.gbb76f46606-goog

