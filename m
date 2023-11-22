Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF6EC61D9B
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 13:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0477587605;
	Wed, 22 Nov 2023 14:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="suh6CiGH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C71286F67; Wed, 22 Nov 2023 14:12:06 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B63AB87250
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 14:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-db40898721fso485724276.3
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 05:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700658718; x=1701263518; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3IBH/fB3H0/3uZi2Chn+IjerEZBGBPrCa9MBcMvq9yw=;
 b=suh6CiGHTuuN/NKpV5EeqZa6WUtTvOuwuN8wd0F/dn496o1i3E0ilA8L5vr7ktijEw
 l81TkOamWCjm/2boEGsSZfKORPBUHJs/CLngEUKX+EHU/MjnyPPzWFOR40byL9pRZwaU
 a8coZm864Ez1iExT1sWBocWVu9m1u47f1zpNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700658718; x=1701263518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3IBH/fB3H0/3uZi2Chn+IjerEZBGBPrCa9MBcMvq9yw=;
 b=AtmnoRbYh+F3K2bLEUcKgfwvXzR9h4eQt4dsPeAQgxMX4eNZ1G+6kcc6I1G1GIVnzg
 j1sNEygga0Q+TTWHc95CKTfVq4D0hMlZ4joBjQutH1wXLoh0iVOax6N1tMidYSWcOVte
 98GXRr1PkcN1MtlJYQgHKmoVY3+EBoJGUuZCjPiYmgNoLKF2VKsJhEb/qmvKpqALWgVS
 uFECfUQuDLfVegWjc7vOsI5c2VHbmDWbx9pCrInvyblTKCDjCa5j8XPyUr+eGMLc5kkH
 dnYjB36z1/DTyu4rbedV8x2eHBCejhvgFzzr0+aAYD3DAqV/ZU6yLQ9YNx1WJcxv+a9t
 p2gg==
X-Gm-Message-State: AOJu0YxW5UAayl2aLQEG3dXDdxaqS+UzEwWtqU9lAFmDpypjgOuPaOQY
 al/eLor01IDgst/eIkCN2Q8QpO14Xd9l4zNTNhvnqg==
X-Google-Smtp-Source: AGHT+IFYZXLh0kFFgqtOrZflJ4s5kowXQmoCgoP1bxCskd+OREDctxmUGMZ/mBE1Erf19uNmkkx8Ag==
X-Received: by 2002:a25:ec0c:0:b0:d9a:45d7:4eae with SMTP id
 j12-20020a25ec0c000000b00d9a45d74eaemr1954793ybh.62.1700658717988; 
 Wed, 22 Nov 2023 05:11:57 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 x63-20020a254a42000000b00c64533e4e20sm1367511yba.33.2023.11.22.05.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 05:11:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 03/11] sandbox: Add <linux/types.h> to asm/global_data.h and
 asm/io.h
Date: Wed, 22 Nov 2023 08:11:46 -0500
Message-Id: <20231122131154.2444690-3-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122131154.2444690-1-trini@konsulko.com>
References: <20231122131154.2444690-1-trini@konsulko.com>
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

We need <linux/types.h> in these files as we reference Linux types.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 arch/sandbox/include/asm/global_data.h | 2 ++
 arch/sandbox/include/asm/io.h          | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/sandbox/include/asm/global_data.h b/arch/sandbox/include/asm/global_data.h
index c6977735029d..001b2b53c1c8 100644
--- a/arch/sandbox/include/asm/global_data.h
+++ b/arch/sandbox/include/asm/global_data.h
@@ -9,6 +9,8 @@
 #ifndef	__ASM_GBL_DATA_H
 #define __ASM_GBL_DATA_H
 
+#include <linux/types.h>
+
 /* Architecture-specific global data */
 struct arch_global_data {
 	uint8_t		*ram_buf;	/* emulated RAM buffer */
diff --git a/arch/sandbox/include/asm/io.h b/arch/sandbox/include/asm/io.h
index 31ab7289b4bd..1ccb25a0fe1e 100644
--- a/arch/sandbox/include/asm/io.h
+++ b/arch/sandbox/include/asm/io.h
@@ -6,6 +6,8 @@
 #ifndef __SANDBOX_ASM_IO_H
 #define __SANDBOX_ASM_IO_H
 
+#include <linux/types.h>
+
 enum sandboxio_size_t {
 	SB_SIZE_8,
 	SB_SIZE_16,
-- 
2.34.1

