Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E341C54F32
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 12:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48B7D88A3E;
	Wed, 28 Aug 2024 14:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kreFt7yX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF37E889B3; Wed, 28 Aug 2024 14:10:48 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E44D888868
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 14:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-371893dd249so3548911f8f.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 05:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724847046; x=1725451846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u+YU0Cxzg10TEhNipO2Qc2Z0ZtHICueW3QwSRonIsTk=;
 b=kreFt7yXqdRCFywa2QJGrk0/3JWIufPdSLWwlxyslE1qb2+SmPkfqm7NyDWGv88XQR
 jCdmsa+OZjBjNAU6+wQHDIO4cXuYIVReli3V8owcS7dNECtMlM2b0oTHc37/ieWQjOhO
 j76rP+7dE+bmSwqCYlyzyhNkJDmVPl7hIzHCNEq0S5RZ9k0PPBAATEGT3Ew6iV/IA6Ps
 ZIxLf5up0qec+E8OurjwH3vUZmNDnYwUy4LipdwOrrkL1snxwVCyVgJ+p0O7k2bHQaNZ
 frbQiVWiHgc8pFrEDdTxwc8mSg652oONiwyA5hgeIu4c55H8D7w8JRoVduyQQRLgG42R
 5dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724847046; x=1725451846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u+YU0Cxzg10TEhNipO2Qc2Z0ZtHICueW3QwSRonIsTk=;
 b=nhrXM6SVhUncNZGm3dC1AYU5Ta6em//eIHPJIQ8uFQj1EXGzU7BkuWyAserObuHU27
 gMfkA2yS7g+wUGeg0Xe/H7msmnrCnfwYROuSCFniNh+ATF/SrHJGpqs5ij+nh+OwyIU9
 OvXU2HyoWWlpbNGOf8HDjY2jmrkr26S39nVhtDvnG5/+TS+aBz5k7/tiwX3H3Hm3n8YH
 uVhDUorPVdIB2iTkaN9XTM7AB7SVbNiBgiPwDFpItnCtUBYvvsjizdl90E8MouxN/rqi
 aIgcN02Wz4NjaQIlPqi8NWZpOsv5SIlqZSl0haEu3MNe47E5tDI2/rZ0XYIIcQBukFRL
 188g==
X-Gm-Message-State: AOJu0Yz14zbC1QdDUmHyyqWcTh4dWVPXrWMy0qHm7PKfhSqM7MN4uCoF
 RctewfPGoNeOewx5M9Oq/O4GNrq5X9Ib0/w6vAbs4MK1ihgKtUHAMckGzsKw0PQ+JAAEcW4zTZP
 50wEiuw==
X-Google-Smtp-Source: AGHT+IGSIazDHuCdNCDM/DYWVAdujiDyQldwViu+x2XkpmBnciiqQQezZOmDeGoAcrXj11Gd3qQgrg==
X-Received: by 2002:a05:6000:104d:b0:371:8763:763c with SMTP id
 ffacd0b85a97d-373118642e9mr11062564f8f.33.1724847046096; 
 Wed, 28 Aug 2024 05:10:46 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:8ac3:aada:f033:985a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639687csm19470365e9.8.2024.08.28.05.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 05:10:45 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/13] arm: omap2: add missing #include <netdev.h>
Date: Wed, 28 Aug 2024 14:10:27 +0200
Message-Id: <fbbe33f617e25f80b5d541edd13ed8bd8035b6e4.1724846454.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724846454.git.jerome.forissier@linaro.org>
References: <cover.1724846454.git.jerome.forissier@linaro.org>
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

emac.c implements cpu_eth_init() so it needs to pull the corresponding
header file.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-omap2/omap3/emac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap3/emac.c b/arch/arm/mach-omap2/omap3/emac.c
index 7348e92cab..1e30a06361 100644
--- a/arch/arm/mach-omap2/omap3/emac.c
+++ b/arch/arm/mach-omap2/omap3/emac.c
@@ -9,6 +9,7 @@
 #include <net.h>
 #include <asm/io.h>
 #include <asm/arch/am35x_def.h>
+#include <netdev.h>
 
 /*
  * Initializes on-chip ethernet controllers.
-- 
2.40.1

