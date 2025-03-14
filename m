Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B8EC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 12:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C6D581CA8;
	Fri, 14 Mar 2025 13:58:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lmYrtcUC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A1188197D; Fri, 14 Mar 2025 11:07:51 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D6F68007D
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 11:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eichest@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so1671152f8f.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 03:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741946868; x=1742551668; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NFWhUu+2GUHvkyQBb/wNzWL+ZIW34uQf1uxyPkVBciA=;
 b=lmYrtcUCjgFhkVLMowQY8ZNf1DAvmMZoqbfSUZqu4LDA6tJNISpft0kxDefeF7bClB
 6GsRvFq+lJGvda7e0dSa0Q43/2mUaHLUAwBf2hzuKeF3g/O4AfVWWm6uoTdRAt1Ydbvf
 OVYoOOo6d4zFa3ryOzQDcVitR3chC+ygKYvkzdAP3yHfBztQ2pJZvLkwXz2vJ0xqhr5g
 yHcMfCMywJrXlY+ZdFcXTa7WDPsyPAuubLj1iaUu5CVQE1JF4da0DreQBBZL4j0lokFi
 w2qu2weEMXYsRM5tXPeqGNjPLiy3SredtdiEHYbn5Kc55Z57BRolE41K8dxEcfdsHmTT
 HvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741946868; x=1742551668;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NFWhUu+2GUHvkyQBb/wNzWL+ZIW34uQf1uxyPkVBciA=;
 b=LIq/KJzXqlqB1kOkydvOYtDYsPqr6kfGEsocrwRoqslXHe6eyBJbgNUFeFJGWePCS+
 2+DZTEgrLfwLWk2lc9U32+AR8JbVUG+O4hgXQmzQyT5HZ3xhA2YytKAjrkIq7US2N/Jb
 ALlWAzdCjRVi+goMxT+sJnvkrDyBBrgc7SwzqexGVQK9apZSflbsk65V5DS5+J0Ci6ZC
 utDIxkwP7DRBpov5ZGRNgNAkRvusSbT/QT8QEyWU79qxE5wVBbBG31YWaoFMEnAUbkqV
 pbkHvWVr4SXSmZXCXrg+BQz8uK3OCoY4cWYhXgPVs8NAkQ4D4FYKWpPGDtWlp3VnwTBE
 tiew==
X-Gm-Message-State: AOJu0YyXBtjli9VhwWUTM2dDiozUTs38OQMby753Bfccazt/j7J80Jl6
 LiPgltjQ5l/r5gEoG5tyVnE0wN0ElM8GT/67F9zaBBxy1YB2n0XCgx4WSA==
X-Gm-Gg: ASbGnctE5JcilZyvl6voP/YkotucoVzpOg3V7Qs+m+fLwCP5FrxGS6lOVPf6d22YKAQ
 NOsxVAWXvE8A9m5uAcKV+1oFP5Nhd/tAhTemN+spzwbH2L9lZcgv2r+HldcdTnyHiSA5+6GZkEE
 otEg6wke2kicySuVRNpfLMZeg9qUsstz6UIiHc9gEWvB0MRoz0OKprS+D+8Hsmb3jYySt/9OBEU
 +iR/926tlKEc56c/2EBKeedRa9Dla87g4Z1t4SAGws29HZQfrrqwzlQxdKXMISTQbOkb+XEALGr
 hKAU2v+UON0uis+qzcOO+yLxH1CQTFkvAp63eU6KH+WoYSTJ
X-Google-Smtp-Source: AGHT+IG+z72zf4H5kET6gs15ajTupH+rOJSVWgdjU65MTioTvWVaPHGK/FRrJUr8xUKd2Ziq7+J4EA==
X-Received: by 2002:a05:6000:2c2:b0:391:4835:d8a8 with SMTP id
 ffacd0b85a97d-3971d234ddfmr2199554f8f.1.1741946868472; 
 Fri, 14 Mar 2025 03:07:48 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:2ecb:7807:e8b8:81f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1ffbcf00sm12126305e9.10.2025.03.14.03.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 03:07:48 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: trini@konsulko.com, stefan.eichenberger@toradex.com, s-k6@ti.com,
 w.egorov@phytec.de, n-francis@ti.com, emanuele.ghidoli@toradex.com,
 francesco.dolcini@toradex.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] common/memsize.c: Fix get_ram_size() original data restore
Date: Fri, 14 Mar 2025 11:06:49 +0100
Message-ID: <20250314100734.23777-1-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 14 Mar 2025 13:58:22 +0100
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The get_ram_size() function fails to restore the original RAM data when
the data cache is enabled. This issue was observed on an AM625 R5 SPL
with 512MB of RAM and is a regression that became visible with
commit bc07851897bd ("board: ti: Pull redundant DDR functions to a common
location and Fixup DDR size when ECC is enabled").

Observed boot failure messages:
  Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
  Authentication passed
  Starting ATF on ARM64 core...

The system then hangs. This indicates that without a data cache flush,
data in the cache is not coherent with RAM, preventing the system from
booting. This was verified by printing the content of this address when
the issue occurs.

Add a data cache flush after each restore operation to resolve this
issue.

Fixes: bc07851897bd ("board: ti: Pull redundant DDR functions to a common location and Fixup DDR size when ECC is enabled")
Fixes: 1c64b98c1ec4 ("common/memsize.c: Fix get_ram_size() when cache is enabled")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 common/memsize.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/memsize.c b/common/memsize.c
index 86109579c95..8fa1b0e2a00 100644
--- a/common/memsize.c
+++ b/common/memsize.c
@@ -82,6 +82,8 @@ long get_ram_size(long *base, long maxsize)
 			addr  = base + cnt;
 			sync();
 			*addr = save[--i];
+			if (dcache_en)
+				dcache_flush_invalidate(addr);
 		}
 		return (0);
 	}
@@ -90,6 +92,8 @@ long get_ram_size(long *base, long maxsize)
 		addr = base + cnt;	/* pointer arith! */
 		val = *addr;
 		*addr = save[--i];
+		if (dcache_en)
+			dcache_flush_invalidate(addr);
 		if (val != ~cnt) {
 			size = cnt * sizeof(long);
 			/*
@@ -101,6 +105,8 @@ long get_ram_size(long *base, long maxsize)
 			     cnt <<= 1) {
 				addr  = base + cnt;
 				*addr = save[--i];
+				if (dcache_en)
+					dcache_flush_invalidate(addr);
 			}
 			/* warning: don't restore save_base in this case,
 			 * it is already done in the loop because
@@ -112,6 +118,8 @@ long get_ram_size(long *base, long maxsize)
 		}
 	}
 	*base = save_base;
+	if (dcache_en)
+		dcache_flush_invalidate(base);
 
 	return (maxsize);
 }
-- 
2.45.2

