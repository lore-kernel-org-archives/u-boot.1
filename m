Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAF6C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:27:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0467B8186D;
	Sat, 15 Mar 2025 15:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aS9RjdUD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07D8580ECC; Sat, 15 Mar 2025 15:27:16 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11F5F80F9A
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so3400575e9.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048831; x=1742653631; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YQfL4L6uYerdOiZWpujGOWu5RaO1Hox5ZOiRJHUzlu0=;
 b=aS9RjdUDJiu/q1tQ54d/WRaDokM5ufRjH/M3KW9ND5/xTpuuZOtM4XEglt2nGYPvzX
 oiKYDmBDQgHgfsaGlLLAdqePDhyBtL/68C6xeDP+X6JXuLzxs8Fk1zfxxzE6si98PHLD
 ftF+QV6GuR9c4NhpeoJcbXI61tgzE4Jn0leUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048831; x=1742653631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQfL4L6uYerdOiZWpujGOWu5RaO1Hox5ZOiRJHUzlu0=;
 b=DaJZZiY1qqclrmCTmD8bNtmWLPAHs7sK8iAxeNoglr296UFWEHFBYc7SEdU2gybRGZ
 ilbVRdlRpHwK8aOGx2TrzCgKRLuPBaplmqWZ7LSdRx0I4MrvvDxssp7I7pB5f05kzcQu
 2juryvJp0mwi8/yQGoi/DUlZ7b1gjNJF3b3DJMi6zjou3DxiEM1AiRjp94oXv22HkBqt
 bPZwRFxyHBHbpLGqr6wKhvZ5e0Oh5bbef7Pn+wmFxRfDQ1cwiFZJb2zSdDpBhzVsYu9x
 d5WohOExxl6Zh4G+oLgZXkWKPrJW8asEJY6kvWQsjwokqwKnWGFzoQ6nEDD0NPzDIPLr
 bRxQ==
X-Gm-Message-State: AOJu0YzzNgjG2Pl2yuq0Fi58DH8TpIZEeJadcX7eArGgw9foDqgPrUcc
 D+YOeXp60LJ1xJPpsfq/FXvdFRFySweC/Pqu9cT2vtnBdJbOCgIQ8Muzr0MaD+qUjaNUzGXDhhB
 jNQ==
X-Gm-Gg: ASbGncvXqZjeHkiXi4CC3+wVV/JeLjGIDOoamEVPVFtlxLwEnLHyzqvv6iYNKpvuMYQ
 6Dois6gYIbvpb+jH4o7qG3MybEKy49nuofyFlfjRydYcw77bowcn5ageAB99DNLCTAi6zVzReSK
 7n6LO34kM6uFNNyBnGdJ9LKrhtQRM7WtqhZep/Vx+M5P5InumVUDhZLPWb81bz2sNGFZmRhAzyj
 4zAaiyJ0gSXfmJ/yi9Q81xrWa1NX2YJhRTR099EHxiqQVmXBxSt1cT5Nf1SKima3zB/3t+t4nEF
 wBLm6oeb96TzG2IkUkxll6KLRk8UmFYBC8OGUYt7c/M4HYP8837y
X-Google-Smtp-Source: AGHT+IGP6GLuULuLifjJl55ggA+6KeiJTUVtuCinu8M+k/ztp81ES3e2fxtcWWfO3M8ImuHAXoAxVA==
X-Received: by 2002:a05:600c:210d:b0:43b:c305:3954 with SMTP id
 5b1f17b1804b1-43d18081271mr111579235e9.8.1742048831244; 
 Sat, 15 Mar 2025 07:27:11 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 02/46] sandbox: Correct a typo in mapmem
Date: Sat, 15 Mar 2025 14:25:22 +0000
Message-ID: <20250315142643.2600605-3-sjg@chromium.org>
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

This should say 'cast', not 'case', so fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/mapmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/mapmem.h b/include/mapmem.h
index f496c96d16c..8ec03d59f0b 100644
--- a/include/mapmem.h
+++ b/include/mapmem.h
@@ -33,7 +33,7 @@ static inline phys_addr_t map_to_sysmem(const void *ptr)
  * nomap_sysmem() - pass through an address unchanged
  *
  * This is used to indicate an address which should NOT be mapped, e.g. in
- * SMBIOS tables. Using this function instead of a case shows that the sandbox
+ * SMBIOS tables. Using this function instead of a cast shows that the sandbox
  * conversion has been done
  */
 static inline void *nomap_sysmem(phys_addr_t paddr, unsigned long len)
-- 
2.43.0

