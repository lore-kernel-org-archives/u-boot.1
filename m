Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BBCC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5638877D6;
	Sun, 12 Nov 2023 01:11:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BHYUHEGI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4F4886F8D; Sun, 12 Nov 2023 01:10:33 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D20E870E6
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3594560fa09so13133275ab.0
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747787; x=1700352587; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E3rGO7bPWuoZVylovNNVhvkkk27yiqLp2tUExWRsoP0=;
 b=BHYUHEGIJTqn6Z0ameFlagu81+pntXDMeiiObxrUYzyWBeqW8/XxBxzrQAXH29X4pu
 de2AxeBBQN20OVMzjJvO2ODQ/QR5iWw8m/M4CbefatPS4Ly5GKw0FPEP+O24OJ707Skz
 8+HZAVjgM7omwV9t9HkWtUT6kN3dk7iXexXmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747787; x=1700352587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E3rGO7bPWuoZVylovNNVhvkkk27yiqLp2tUExWRsoP0=;
 b=JIQtzhgE4mCtrALA/Ochu04vAW6XF1d7PgDWpE0ZoxdQhqd/34aDh6p+h2GvMmDR0T
 0bao1lTl2rx4S37RgkheYJeSzI7VpbxD7zHKUwCDo2Mu+MKfOWvy7FY493owrxd/Yi0i
 mMcyFOUV5RFjlYZCd1WRWF89QtL4IVi1nduwNH4QJW1gH3nw+bjp/08jiOkR3n4cAs4Z
 nbN99oep68jGPdmhmc2kc/x4xJDmYb8Rf8C3+SLNvYNPSAlDl+5mZlxqp/RopvgFeaRL
 gr5M8NZl/fK94jqf6lszdDw60ftlXtlFlMC438/5q8Fu9nWWUcZr7FKbxY469pnty2Dh
 Z1Jg==
X-Gm-Message-State: AOJu0YwY//XBEuPZKnOqVgk3ODM58UP1lOHC6CmRU4or6eXRhJBACGvS
 N3eynZ7ESWQ+MzuzXhV9UKAd4VIM0BOgQRIqgZeBPA==
X-Google-Smtp-Source: AGHT+IEGseYucHF41L1qiAFU6G8ThPeLNPARGo/7BNzoD3d5Ohv3SMj82b/nAelIqQGZtEOP7461Tg==
X-Received: by 2002:a05:6e02:1789:b0:359:4223:5729 with SMTP id
 y9-20020a056e02178900b0035942235729mr4903342ilu.1.1699747786903; 
 Sat, 11 Nov 2023 16:09:46 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Jerry Van Baren <vanbaren@cideas.com>
Subject: [PATCH 18/29] fdt: Allow use of fdt_support inside if() statements
Date: Sat, 11 Nov 2023 17:09:03 -0700
Message-ID: <20231112000923.73568-19-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112000923.73568-1-sjg@chromium.org>
References: <20231112000923.73568-1-sjg@chromium.org>
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

Most of the fdt_support.h header file is included only if OF_LIBFDT or
OF_CONTROL are enabled. This means that calling functions defined in
that file must happen inside an #ifdef

This is unnecessary, so reduce the condition to just !USE_HOSTCC

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/fdt_support.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/fdt_support.h b/include/fdt_support.h
index 2cd836689821..feda0d997409 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -7,8 +7,7 @@
 #ifndef __FDT_SUPPORT_H
 #define __FDT_SUPPORT_H
 
-#if (defined(CONFIG_OF_LIBFDT) || defined(CONFIG_OF_CONTROL)) && \
-	!defined(USE_HOSTCC)
+#if !defined(USE_HOSTCC)
 
 #include <asm/u-boot.h>
 #include <linux/libfdt.h>
@@ -418,7 +417,7 @@ int fdt_valid(struct fdt_header **blobp);
  */
 int fdt_get_cells_len(const void *blob, char *nr_cells_name);
 
-#endif /* ifdef CONFIG_OF_LIBFDT */
+#endif /* !USE_HOSTCC */
 
 #ifdef USE_HOSTCC
 int fdtdec_get_int(const void *blob, int node, const char *prop_name,
-- 
2.42.0.869.gea05f2083d-goog

