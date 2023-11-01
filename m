Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F21BC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 16:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C245D87D0B;
	Wed,  1 Nov 2023 17:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mKDhmAf2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9001487AD4; Wed,  1 Nov 2023 17:28:34 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80031876CB
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 17:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7789aed0e46so484518685a.0
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698856107; x=1699460907; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N5q/vTzWqIYFizZ1NiikAoWChwdM2YlHvm6xXYYLOas=;
 b=mKDhmAf2H3Az+JiMFmgTY4sRq7Fuwe0vV/aYZLgsHrk5Zrfq6tqsnvbF78GIMbPqVq
 flsJoCQgqAVaC0XFqln6OgGmZiYcqJe9qKte3IZm5zymHc0hEe1IeU3bp3Df2qy3uPI6
 K8nv1zpmceyBDHA09vOl9WJJVBqWV/V2Mr1Q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698856107; x=1699460907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N5q/vTzWqIYFizZ1NiikAoWChwdM2YlHvm6xXYYLOas=;
 b=u2rdQdIJMQiN5BweOPeak+1euQMGL7YFM3HRVw3zEj1FzQzI4FNaY6G1wixZ96q/6t
 /4mkJEE0GaiTcLCzoPONJkUyiwC25AILqAOiUz4DG6pUJ3o2gwAp83AlDvt42t77sRpd
 Gmkh/5jXhnOzWgidGJ5BNGnx8aJM6KcZXi1+jxijqUD6umbs+xqlTaQEZ9ISvv3Y5Iv9
 dc1MbaZ8/sx8RdckaonwsB/BxJgjqXIDLjh0I4AJgazf9l45/MEpTX9KaDZxc7ESroCm
 fe4v4XDq61OybSY6jpIO54tGIzzt2neokhAvpJhyh2ptT+40WqXh0QC0rGan+yJ3iNIU
 0gBg==
X-Gm-Message-State: AOJu0YyvelK/YmeHdCuPumd+vPg3eNVhm5Ve2Z7LkDtEVNnGKF3g0Qu6
 lYSFGfO1OSW1XMVzz+bDmkKhNZ/KGseNZ+TuUW9QyQ==
X-Google-Smtp-Source: AGHT+IH5HrthJCSWbykdoHu3p1gpZnj7Sg5UKlNoNZJLw2b5rnvcVxmsQzyR+AlIyqSBlvPrAUx3FA==
X-Received: by 2002:a05:6214:2488:b0:658:22f8:4e51 with SMTP id
 gi8-20020a056214248800b0065822f84e51mr26195243qvb.1.1698856106821; 
 Wed, 01 Nov 2023 09:28:26 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0cecc3000000b0065b21f1b687sm1610238qvq.80.2023.11.01.09.28.26
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 09:28:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 02/20] powerpc: Switch <asm/global_data.h> to <linux/types.h>
Date: Wed,  1 Nov 2023 12:28:06 -0400
Message-Id: <20231101162824.3755579-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
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

In matching other architectures that have their global_data.h need to
bring in a types.h header, switch to <linux/types.h> on PowerPC.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/powerpc/include/asm/global_data.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/global_data.h b/arch/powerpc/include/asm/global_data.h
index 6ed21c781fe4..43d71f5caec0 100644
--- a/arch/powerpc/include/asm/global_data.h
+++ b/arch/powerpc/include/asm/global_data.h
@@ -9,7 +9,7 @@
 #define __ASM_GBL_DATA_H
 
 #include <config.h>
-#include "asm/types.h"
+#include <linux/types.h>
 
 /* Architecture-specific global data */
 struct arch_global_data {
-- 
2.34.1

