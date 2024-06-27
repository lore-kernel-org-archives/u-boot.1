Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CBEC3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 09:20:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8D8B883B6;
	Thu, 27 Jun 2024 11:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="haBRYuE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F13C8852A; Thu, 27 Jun 2024 11:19:36 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 377F8884A7
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 11:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-366de090da9so3608162f8f.1
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 02:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719479972; x=1720084772; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9w+sUR2AVGoO5kGbs1GbQb9CzRrIlLYGbu0jwVoLkS8=;
 b=haBRYuE5ffmb7g/4KaPvnZ85U8sUlKq+isqhPYcqzMUYPu7OVSb8FJjVdIOmFdrCVY
 f5xkgebYdS+hejeMcv5UwNa4lOm2L39bLEBapXt5b8MEcP5Juw2MeFSBaIb/GXMRr1pi
 HTpP11v6V63Ok6XWYX/p9YquJNXkKNuiqiXBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719479972; x=1720084772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9w+sUR2AVGoO5kGbs1GbQb9CzRrIlLYGbu0jwVoLkS8=;
 b=PedxKAe/JJIpeNVv8Z+cLp8PUORqx9Ek/H3LBCivYIMCs6+BtQtfXSba8l7TCzfCX8
 B2+genEDOJ5UTsukCYBud9MviZY2Q/ocnXlxiLEZUKk96tj0eXdH14m0x3m37lweaPQ9
 VTvgU1LBT34rNGhJ9RnERtbSbrYwrU/uzUyi6bff7YLJ9b5JuRexLB7IN+QyQSufGG7e
 azeNqUOYhnxnv6JoaRcNr3Ysg8cqtSxWrTvOrHhKIxsz9oV+PrDjwdK9OBMdiXMR1WZo
 lWfLO60xXUNte9dCldrvEaPb9nQKEghEA5/s6oZ450zOdF0fkDqzlll6kpPSCFScH8H2
 XsUA==
X-Gm-Message-State: AOJu0YxhTpkwWxJq++8wM/OsidyzZQyn+YSgn449g9CJbX08t+FPkxvx
 fZx52sKnafcVMerIwIQ/+HG3jI365eGO48EVGBnIkvJYuVybNEMGiOno4I7wqGuRK0id0FT1b3K
 4BQ==
X-Google-Smtp-Source: AGHT+IG2CtDFQcvhA7uQmF7GeuRVsAjRg21Kwgi+ltJp4OnCG3W8WKeLSEnlnJkGkmn4RGSO5mVB0g==
X-Received: by 2002:a5d:65ce:0:b0:362:dbc2:9486 with SMTP id
 ffacd0b85a97d-366e963036cmr6827302f8f.68.1719479972630; 
 Thu, 27 Jun 2024 02:19:32 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367436a28f7sm1199818f8f.117.2024.06.27.02.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 02:19:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v6 2/8] binman: Collect the version number for mkeficapsule
Date: Thu, 27 Jun 2024 10:19:20 +0100
Message-Id: <20240627091926.374633-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627091926.374633-1-sjg@chromium.org>
References: <20240627091926.374633-1-sjg@chromium.org>
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

Now that this tool has a version number, collect it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/btool/mkeficapsule.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkeficapsule.py
index ef1da638df1..f7e5a886849 100644
--- a/tools/binman/btool/mkeficapsule.py
+++ b/tools/binman/btool/mkeficapsule.py
@@ -33,7 +33,8 @@ class Bintoolmkeficapsule(bintool.Bintool):
     commandline, or through a config file.
     """
     def __init__(self, name):
-        super().__init__(name, 'mkeficapsule tool for generating capsules')
+        super().__init__(name, 'mkeficapsule tool for generating capsules',
+                         r'mkeficapsule version (.*)')
 
     def generate_capsule(self, image_index, image_guid, hardware_instance,
                          payload, output_fname, priv_key, pub_key,
-- 
2.34.1

