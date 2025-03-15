Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22C2C28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:31:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C4FE81DD6;
	Sat, 15 Mar 2025 15:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GU+gORBk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F2FC81D1F; Sat, 15 Mar 2025 15:28:10 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C68181D65
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso3798925e9.2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048886; x=1742653686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lI7UsEiDr7GPONq3BEGUnwYtyuIpbYnDulGI8rnd9Y=;
 b=GU+gORBki94cCaOoBVNM0SWIxoIbSHIEa77121HJepYoct6P3HIhjp5nXM8f7SMtRW
 KJdK9rYrlt3x1xWlYj/Nz3QvkePsz6Uisnt4skL5E28WPxHuAeJfEp1/E3PuINQIJIAB
 6jiZhZlh4KMWTmvz+CqH9p9/pzK6wXdDzSmQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048886; x=1742653686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+lI7UsEiDr7GPONq3BEGUnwYtyuIpbYnDulGI8rnd9Y=;
 b=S8KkTx3PC1jK8uZHpAb38Cf1I6VNirhOmd2L2AKpZxgh/G2o9kF0p5mVOgHfBYunar
 VaAnUakZnDR0pd4CL5qWQeBjJdDVP8xVQeha6J/uk9lSvAWdA4dAhwKD4nzxL8Z/SrWt
 5rln23nYUb2xJuxMyPt61/v+fWy/q1/hgkn5BK/h/hStQ+8jbJjL6MBuSZMzXMeIrOXl
 qearzch8vN2aqFeXJX7w0gcFc7mdsuMzLfm9mVVQpmIb7f2FNL/T32obclAuMgYbKDYU
 ucf5jI2HM5tV8tRVcXrvSJwIkT08V/DT7Ub9sQ9GaNaBm36GeW4avYw1FYXru3FV5m6s
 D3Fw==
X-Gm-Message-State: AOJu0YwFJnHbZaCIOG467BNZw9Rsh8F/ZOVKtjia+qW147KapMmOjJNU
 iYbJpDQ45QOmuZuQqTa2Q5dPulaM6S4qkbVffQBM8vUvuNHp8upN2QIZ3dWv9l2e0wN/474969g
 2jw==
X-Gm-Gg: ASbGncsG++MMLLmg9yY5AS1AUl/Mh0DBC7zajp3yYokOTT7qfnhDvjH2/Ro9b8U33Bs
 SGYJFC7dIMlbqPKadx0JnF+vTaXUfLixs3xeLDgl2wuJ+t6vS7vEsCY0vOiC3z5VH6Rj9IkmjYi
 gg5vXqKHcdyw82gVAT/ls7zBQ9xrLnUwtL4fDgsH6i0evEQnz1U3CrTBB0t3kKReNv4v9SwnZKs
 ch13GiyrwRtwTJBKavI7FBZ4v2w/HnsZFT1dCWSSZelUg0YMzuvHBIQ84fkjjZ6iDGUBRo1SfA+
 nP0AqUJAlQOsdXjFKTMDW41TEvuy6DLv74l39I92uTzPtd8BZ6YO
X-Google-Smtp-Source: AGHT+IFXmml/6FU4y7epKeeQo168Yij7D4EVX6bD32fMEewcM3ug8iVZZSvWgQQdhZrQOmn+E/glQQ==
X-Received: by 2002:a05:600c:350a:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-43d1ec8643amr86699355e9.16.1742048886065; 
 Sat, 15 Mar 2025 07:28:06 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 27/46] x86: emulation: Set an MTRR for the RAM
Date: Sat, 15 Mar 2025 14:25:47 +0000
Message-ID: <20250315142643.2600605-28-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

QEMU likes to have an MTRR set up, just like real machines. Add an MTRR
which covers the total RAM size.

This does nothing on machines without MTRRs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Support memory sizes above 3GB properly

Changes in v2:
- Add new patch to set an MTRR for the RAM in QEMU

 arch/x86/cpu/qemu/dram.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/cpu/qemu/dram.c b/arch/x86/cpu/qemu/dram.c
index 62a301c0fd3..ba3638e6acc 100644
--- a/arch/x86/cpu/qemu/dram.c
+++ b/arch/x86/cpu/qemu/dram.c
@@ -4,7 +4,9 @@
  */
 
 #include <init.h>
+#include <spl.h>
 #include <asm/global_data.h>
+#include <asm/mtrr.h>
 #include <asm/post.h>
 #include <asm/arch/qemu.h>
 #include <linux/sizes.h>
@@ -44,6 +46,22 @@ int dram_init(void)
 	gd->ram_size += qemu_get_high_memory_size();
 	post_code(POST_DRAM);
 
+	if (xpl_phase() == PHASE_BOARD_F) {
+		u64 total = gd->ram_size;
+		int ret;
+
+		if (total > SZ_2G + SZ_1G)
+			total += SZ_1G;
+		ret = mtrr_add_request(MTRR_TYPE_WRBACK, 0, total);
+		if (ret != -ENOSYS) {
+			if (ret)
+				return log_msg_ret("mta", ret);
+			ret = mtrr_commit(false);
+			if (ret)
+				return log_msg_ret("mtc", ret);
+		}
+	}
+
 	return 0;
 }
 
-- 
2.43.0

