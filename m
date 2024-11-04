Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EF3D1119A
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 01:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF1AF890FE;
	Mon,  4 Nov 2024 02:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="m2XWi32o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5491A8911A; Mon,  4 Nov 2024 02:49:50 +0100 (CET)
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com
 [IPv6:2607:f8b0:4864:20::a4a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D9DC88ED9
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 02:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3OigoZwcKBmsVXaRciOPXXPUN.LXVd-KXXcURbcb.MNWg.MN@flex--moritzf.bounces.google.com
Received: by mail-vk1-xa4a.google.com with SMTP id
 71dfb90a1353d-50d7265097eso1131412e0c.3
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 17:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1730684987; x=1731289787; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5wBS2MfxEIm+Ba327ldZknhhu1RLabedydjiCFyqJgE=;
 b=m2XWi32oiSlKtpYeU9cb6ISJRUkxKp5DtzjVZbclOFUYRoolVsjzyUT8dQyGY8f+Bs
 92jpPAuH4D4TlCY6a9x7hG4KHaw+V3GrtfSRHr1S25+h9tLtiTP4w8jxF6XLT5iPfiIP
 E5D7DtAbfY2Lw8+jBgUj3aEuTsijq+0OsYB/KBCt3+vEElXztmgmHTlTNj5U48TAeenQ
 tOCPtHyZHPCz8y8uaSxkmTtvhVpbI4XJuKMHXA66e7P6j7sZbaIP9W3ql6MvSznLZfGm
 fnR01Y4039DQcytRlvWJTXg+uI13L8eS/x1XH6LhkMEMRpxDAAD0xgdsBuf5bxIjpBok
 B4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730684987; x=1731289787;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5wBS2MfxEIm+Ba327ldZknhhu1RLabedydjiCFyqJgE=;
 b=njT+LIqBMddh/CN+ffxFl1SUWtIoko1Tn0YofT7Ts0ZfdsacP9dBt41ArtbaHiz3vv
 IVuM6da/YzO95ug7tNNG5sRKXYM8lyAC0LLlN+fFwSCs2hhtazV5MYDxQ9bT3N03Lhfq
 LCKpcyV8na1UnN+k7TTdUbCQZoPAaE/jeB5i31tCaZAaHIjX2cgD0oU8NzrugqXwxgHq
 Cv8OFiZbsttA4LgiM8medTGlkIYHpKFsHkK5D7NaaKIHobAikAnYhTlvvZDHL9n0QadB
 z1N0/vL4QEglNyj1hiLMCPRF+bhUf9ahwIwk40StV+RstZ+5/ino0uAnnu7g+TL34jyS
 YSUg==
X-Gm-Message-State: AOJu0YweZuggDVEJymniMush16ZO/HYo7CXvClUFpEfmGENQLcOYdlFd
 z7LU7Ytm5a2V7EtZNOFD+/Cbt7mlt96iNUwSXv9jQWpcjE82ZD66Mzi/w6weBVJxM8bTCLC7MZU
 BTyFEulIc6HzGmXlRLfD4N15GKoNbO755LUsnzIF1a2jOo94+yyiDpGcScfTEYoQC5Hl3UObg8Z
 zv4f7hkbGs6LpzULcQZRz9boygQRqPW51rq3E=
X-Google-Smtp-Source: AGHT+IGI8sB4y3L8wVFgchnWbwPlfX02CMgQDjOmE/5qUZ3u39PDIxkNMVh68i6y5SN4GT7r1ZO8VbZCwUrc
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:13f:f0c:ac12:c151])
 (user=moritzf job=sendgmr) by 2002:a05:6102:290e:b0:4a4:8bad:f129 with SMTP
 id ada2fe7eead31-4a8cfb25a52mr126059137.1.1730684986101; Sun, 03 Nov 2024
 17:49:46 -0800 (PST)
Date: Mon,  4 Nov 2024 01:49:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104014934.2542857-1-moritzf@google.com>
Subject: [PATCH] efi_loader: Change efi_dp_from_mem() to use size
From: Moritz Fischer <moritzf@google.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com, 
 pwildt@google.com, Moritz Fischer <moritzf@google.com>
Content-Type: text/plain; charset="UTF-8"
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

All call sites are using size rather than end addresses,
so instead - as previously done - calculating an end address
everywhere, just modify the function to use size and internally
calculate the end address

Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Patrick Wildt <pwildt@google.com>
Signed-off-by: Moritz Fischer <moritzf@google.com>
---

Thinking about this some more it seems more sensible to fix this
in the function rather than patching all the call sites;
it seems we even missed another call site.

- Moritz

---
 include/efi_loader.h             | 2 +-
 lib/efi_loader/efi_bootbin.c     | 1 -
 lib/efi_loader/efi_device_path.c | 7 +++----
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 291eca5c07..39809eac1b 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -858,7 +858,7 @@ struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
 struct efi_device_path *efi_dp_from_eth(void);
 struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
 					uint64_t start_address,
-					uint64_t end_address);
+					size_t size);
 /* Determine the last device path node that is not the end node. */
 const struct efi_device_path *efi_dp_last_node(
 			const struct efi_device_path *dp);
diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index bf38392fac..a87006b3c0 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -137,7 +137,6 @@ efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
 		 */
 		file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
 					    (uintptr_t)source_buffer,
-					    (uintptr_t)source_buffer +
 					    source_size);
 		/*
 		 * Make sure that device for device_path exist
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index d7444588aa..ee387e1dfd 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -977,7 +977,7 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
 /* Construct a device-path for memory-mapped image */
 struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
 					uint64_t start_address,
-					uint64_t end_address)
+					size_t size)
 {
 	struct efi_device_path_memory *mdp;
 	void *buf, *start;
@@ -992,7 +992,7 @@ struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
 	mdp->dp.length = sizeof(*mdp);
 	mdp->memory_type = memory_type;
 	mdp->start_address = start_address;
-	mdp->end_address = end_address;
+	mdp->end_address = start_address + size;
 	buf = &mdp[1];
 
 	*((struct efi_device_path *)buf) = END;
@@ -1073,8 +1073,7 @@ efi_status_t efi_dp_from_name(const char *dev, const char *devnr,
 		efi_get_image_parameters(&image_addr, &image_size);
 
 		dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
-				     (uintptr_t)image_addr,
-				     (uintptr_t)image_addr + image_size);
+				     (uintptr_t)image_addr, image_size);
 	} else if (IS_ENABLED(CONFIG_NETDEVICES) && !strcmp(dev, "Net")) {
 		dp = efi_dp_from_eth();
 	} else if (!strcmp(dev, "Uart")) {
-- 
2.47.0.163.g1226f6d8fa-goog

