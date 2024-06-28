Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDB4C3064D
	for <u-boot@archiver.kernel.org>; Sat, 29 Jun 2024 01:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F016885DF;
	Sat, 29 Jun 2024 03:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XTKbtyV3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7215488578; Fri, 28 Jun 2024 19:35:52 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F957881EC
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 19:35:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a7194ce90afso99111166b.2
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719596150; x=1720200950; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Yk7IAxQOJChTQaXdDtw9J76THMfaXyZ16AHt5lVfT0=;
 b=XTKbtyV3XN76xTRv8Brq3WQLOKhaoHsz8DlXAL66xFa+T572GgczPD79vGWHhMP+to
 RwlZ0kmzCCtznMvUfOOd5oqO6N9eKFjbNA35BV8hyzg3juHdNNdifE9/oByCPuxEXtyW
 m6Ts1WIcyjkFR3nCL7QKwWxx5K/fajvioWC5liiVkjgnOCwu0SebjCwmzpvmLCtHSYvh
 GjmQtYZ9vIzKVrc5dJ6CX6VhdQPPvpliuKzU6lJXu3nGCuLA/JumnZKWf8L4GmfP0Id/
 7cvNfs07+JMOaYb7ny7svoEnnyqGzij6aHPZpUZsxmgZi7CQEbXEQkr610f5jSfvNR+x
 ZlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719596150; x=1720200950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Yk7IAxQOJChTQaXdDtw9J76THMfaXyZ16AHt5lVfT0=;
 b=p9uz/vjuuylXjgCnTXOgoJ73TFbJvozv2emcASobCa/rRkN8hlzImn1PMtNupapNaL
 g/N/wAJHgV2dYTitc6HClHNjth8CAjt8LLmOvy6mWBfCc2d46+8kXNr1J/NDTKM4egcC
 e9TH+cNqh7G2La1i+OSKXxtzJGZ/rAPp9Js3rDGat0D52cGNSjzshK7e+ad5WrtBGxnk
 lSEF2M8L2tTljGjbUcYw14vVo9d5ZgH2RtoJBm/x7/Se+pbWejyS23eznAnUtDtgmVrp
 glhYuzv5dfV5g4eyNdD6u5/OOqgfr4f/dus0QiJtZxQCvT4hOKEhVjHp8aGhBqZ8Dqk0
 tx3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5KL9a5kLvv7T06Yzwoc3BEfrYPBtskBla/9APuM1t/jdBrPZ2xQ0VFCqPtLWHWtQEiCpecMbFyZ1neqoupS0STusPgw==
X-Gm-Message-State: AOJu0YzoMZD4xH/IWKuk40v4DzuLTZlBF3/ZNqahuXHA1XC/Q1B39Bju
 /7ranohj2UjtOQIt6wpvJGSGkkJZCQzV/jTz95ml8OiG88VN+yD20d74qHzCHJQ=
X-Google-Smtp-Source: AGHT+IHOteg67kcWJfjd1CzS2ltbCgAIFxfX1NTm1oNtpaSRpbelHBB2tC7Ud2VIDlPphxrrZ+m4uw==
X-Received: by 2002:a17:906:4a12:b0:a6f:d085:9e32 with SMTP id
 a640c23a62f3a-a716593e3efmr1145275566b.76.1719596149802; 
 Fri, 28 Jun 2024 10:35:49 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:b996:e85b:4fbf:5c89])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aafb9e4csm96214666b.95.2024.06.28.10.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:35:49 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: trini@konsulko.com,
	hs@denx.de,
	pro@denx.de
Cc: vassilisamir@gmail.com, quentin.schulz@cherry.de, u-boot@lists.denx.de,
 Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
Subject: [PATCH v4 3/3] drivers: bootcount: Fix typo in documentation
Date: Fri, 28 Jun 2024 19:35:43 +0200
Message-Id: <20240628173543.129207-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628173543.129207-1-vassilisamir@gmail.com>
References: <20240628173543.129207-1-vassilisamir@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 29 Jun 2024 03:11:20 +0200
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

The bootcount documentation was using "unattended" while it probably
intending to say "unintended"

Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
---
 doc/api/bootcount.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/api/bootcount.rst b/doc/api/bootcount.rst
index 9435a7ef15..968c679c3c 100644
--- a/doc/api/bootcount.rst
+++ b/doc/api/bootcount.rst
@@ -49,7 +49,7 @@ The format of the file is:
    * - u8
      - upgrade_available
 
-To prevent unattended usage of ``altbootcmd``, the ``upgrade_available``
+To prevent unintended usage of ``altbootcmd``, the ``upgrade_available``
 variable is used.
 If ``upgrade_available`` is 0, ``bootcount`` is not saved.
 If ``upgrade_available`` is 1, ``bootcount`` is saved.
-- 
2.25.1

