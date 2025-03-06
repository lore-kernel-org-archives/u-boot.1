Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA85C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F191881C84;
	Thu,  6 Mar 2025 17:05:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jB8PY4+k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E66681BC5; Thu,  6 Mar 2025 17:05:49 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A788881A10
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-854a68f5aeeso11434839f.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277145; x=1741881945; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lI7UsEiDr7GPONq3BEGUnwYtyuIpbYnDulGI8rnd9Y=;
 b=jB8PY4+kAyzKKnxqg/X0uwPZXiLqu59yWeEOMxLIBZzIZJXhWq2Ibm6dzdPC+0zVSa
 48ZDcRgrcCYYG4cU75YcQdZbkNWJ1YIxT9AuoWyl7cDGCdYIVZlgMocuc1UXAT47OXnG
 1O2M/fbvjsUf9bPLTqlp8Bf8PmRwtnHelKaDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277145; x=1741881945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+lI7UsEiDr7GPONq3BEGUnwYtyuIpbYnDulGI8rnd9Y=;
 b=LkxpmqQivc5oi0PderhtLAZHtyDvfDrFXuizRjqnyLcXRqqZwKFx9bajyWnokTzDJH
 zBjCpz66xj9/JHWXA4+rosASjTIgiKlP2Y4XRErsJTpdqK2dv3KDD/7B+pZ+AIKjHk1k
 hb3zu3Yj56te6V3bqty00s2K/3S21wMWJV6b0GuOxqMCNLsg9DHSBowN06JZK8tin6kG
 WwwBZjFuliWuLMnSnGKtbMzZzG97jrFZQiwRul4iT8dC2kgCuYi/M15z/Ymq4KUMj1fg
 zWXQhtTWTUE6THzxRRqt/0nnYt6ePm7iqKp5bNrtFi7hTBa8qXKeinCZoXWC1gwMLQaL
 LaKw==
X-Gm-Message-State: AOJu0Yw0KIUlRCr4N7BJteTU42Xe6kNX6SO9p6lPdiW3V2fXFg7BkkQp
 Dfiis1j0oqkrREKIyxFwNyL0kSSsdRN3UKwj3Sqo5nXK1720YdQIfCOHqbqc+ogDkN/5t0deF3M
 =
X-Gm-Gg: ASbGnctZJLl2D24blU9qJbCAuCmbs8w0znL/ACJ1YQWzf6kJRbP1xsp26bDU5WlQO9S
 z7d4MEpWOF+6cv3EgpuoJEHx0myjk8wJt8n3Pz0PW8awCRvWGZamyVe7xXp2S7yeyuuv26gmC+x
 IRrtvjyhQGMRoXF+QVe//4UWQnghTXtn+mVikeKLjl24NZCYWWXpi/IM1opABN3mObPcyQcLN7G
 yucXU7vjU3jmiOd7uQbIQ2sltN30JNI1HPGvHcN1lZXFSLCSRRjRWqNq34vqpq4yOdXlQxJeJG3
 FmzpAfgS9OQJPBmKYSyZyL77h6k+E4GMMxuwKmgI0qHRnXQNLYVMT8z9se6TD5YgWTlnfSEiGJ5
 C5gJDpQ==
X-Google-Smtp-Source: AGHT+IHqHy1t47bm/lqUC7IwcaSnXyvFO6eptegI26YnNDdCQFltopSZaofLsLfsKkNWDkRoSy7Ucg==
X-Received: by 2002:a05:6e02:1906:b0:3a7:820c:180a with SMTP id
 e9e14a558f8ab-3d42b9a3ba1mr92523815ab.19.1741277144714; 
 Thu, 06 Mar 2025 08:05:44 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 27/47] x86: emulation: Set an MTRR for the RAM
Date: Thu,  6 Mar 2025 09:03:54 -0700
Message-ID: <20250306160428.3041057-28-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

