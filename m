Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C73E748E7
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 20:46:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DABE87081;
	Sat, 30 Sep 2023 22:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K4FC0loa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FD0A87082; Sat, 30 Sep 2023 22:45:57 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1FEB87081
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 22:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-65af7e20f39so74081716d6.2
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 13:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696106749; x=1696711549; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TAlLxC0arnUoH9brhJjTSn8NLGUCNBCECPhFlGze9PA=;
 b=K4FC0loa5lhf6Fx9lGn+qX0Fz1KNDXqlKX6gMm7XcPKKrf0r+3rKtPSA4BNiDm7DFc
 NsEBpRCW/06kS8vOLv08kviYAZjyHxEpsA74Mc8MlxHsasQsJzXgygVzOcYh+8nU1ioG
 CAXu+vYUuYcwIRJ1psMjhO84Pl4qXj8X39S6q5MdlVKRhcf88QJAoM4ahkuvygarh5Jj
 q2U1ajtN8+6jNrDcoSlV+EOYJLQ0dndO2Ja812y9f1m0GqfoOwqugulf1nQR6EOCxbG0
 NyDFYtUbsfy55PZAH1mq3ZhY3HzSV5BbZ9R1XABmDuXsC3a+kz9pClk7vu/RnNB0wA2h
 BKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696106749; x=1696711549;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TAlLxC0arnUoH9brhJjTSn8NLGUCNBCECPhFlGze9PA=;
 b=BDA+uE5yOtkE+KasCG1o7Uu46GQEZd2zp9BzZd36FbM5+qc2HKwkcJTW6WzyzczbFQ
 hXqdWEB+RV4uGT4Ctjl9fNtOTLnmx0AjPIi19hb/q7e6WqSBQ5DCi6VczfMUZpTL48p4
 tJ/YDVb24LAHyfRy5It/OETlxQWqyPyxCR4YWB2S0Q3+CXkgWJdUIeX6VPhY3tF7WlCy
 EU+e+OmLevBnn0PMsoUJqlOsPFisa+jmbNL90OfCDDKh+Pys3oIkA9vG4pxSsr+0Km7i
 8boZG4q1Grb/9GHTlOsUmNKRqiyVhFElrOlrDDu0zOTvCmxnE3yRUQTYl1eY23eFtr+G
 70hA==
X-Gm-Message-State: AOJu0YxI3rxQQEq8mjbB3o8C/lXomN6r8akDXsjaCqYt7C+/T2U4yINb
 MQlUBHW88jmwKjhCN7row7DD+/6QA9g=
X-Google-Smtp-Source: AGHT+IEvZM5rtbHkqyLvJn0tUQpxIJyEvjBUUC5l1+lIXHbwrsIB2ia1WWTpUo1aP68RdTEyNDfAhw==
X-Received: by 2002:a05:6214:419b:b0:65b:55f:6d35 with SMTP id
 ld27-20020a056214419b00b0065b055f6d35mr7680358qvb.37.1696106749115; 
 Sat, 30 Sep 2023 13:45:49 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 b28-20020a05620a127c00b00767d4a3f4d9sm2199225qkl.29.2023.09.30.13.45.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Sep 2023 13:45:48 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Ramon Fried <rfried.dev@gmail.com>,
 Marek Vasut <marex@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] misc: fs_loader: Fix alignment of fs_loader driver
Date: Sat, 30 Sep 2023 16:45:46 -0400
Message-Id: <20230930204546.515776-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
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

DM_DRIVER_GET will redeclare the fs_loader driver without the correct
alignment. This causes GCC to use the default section alignment of 32
bytes. This in turn creates a gap in the linker list due to the padding
required to achieve the correct alignment, corrupting all further entries.
Use DM_DRIVER_REF instead, which doesn't redeclare anything.

Fixes: 0998a20cfc6 ("misc: fs_loader: Add function to get the chosen loader")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 drivers/misc/fs_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index ccf5c7a8037..1ffc199ba1e 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -316,7 +316,7 @@ int get_fs_loader(struct udevice **dev)
 		return ret;
 
 	/* Just create a new device */
-	ret = device_bind(dm_root(), DM_DRIVER_GET(fs_loader), "default-loader",
+	ret = device_bind(dm_root(), DM_DRIVER_REF(fs_loader), "default-loader",
 			  &default_plat, ofnode_null(), dev);
 	if (ret)
 		return ret;
-- 
2.37.1

