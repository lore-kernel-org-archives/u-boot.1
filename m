Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E027D5CC95
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 09:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8168833C6;
	Tue, 16 Dec 2025 10:35:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="ao/AAOcD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31B2683710; Tue, 16 Dec 2025 10:35:27 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 665148334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 10:35:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7b89c1ce9easo5039539b3a.2
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 01:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1765877721; x=1766482521; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cjkQ9ct2G9vXl+QaZh/ON4a94bbDUsYRMSdnv7LmAzU=;
 b=ao/AAOcDAUj2hoAanRNA7wFr8w8eIpOP0HiQoRiQi/1Zjl5anMEaiqYH/EYnfjdEOI
 wVbLN+o5IBp3tOqXq1REr8KFG+qsbHHJvT7HG/NzqhguoCn2tFliVe7t+oKULuBvYy+T
 JzU6exWyTprBdsCP1JyXSLM9BvYPpxJeUl2xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765877721; x=1766482521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjkQ9ct2G9vXl+QaZh/ON4a94bbDUsYRMSdnv7LmAzU=;
 b=HpLfrkLI0ZK5ppdtGXmk5US+Z0m/JfR1P4DBb83CmXS42QSdO7cO+VmFk+tuZmHrmF
 SlHCuEltl1pKvJDKjS8rXTnBzAyUfEA6fte+ZwftFcaMZyVYhgWcLSrBg/8CBT8Q5kaQ
 lVE+SEEPWrm0+hmMohN47r4JsIM8lV91VLHLFlyCtl3QC777xBd61x2tG/YXAdyMY3qF
 79BHzkooU7r0DE2eJp0mEUVJ5A6PsPneCKzQLmx3j0ZfVT74M267spbUp0RLbSH202lc
 d6X2Aut+/ZdCHQXsFvrgUbUarOI5rZl1vp3Zw4GdJCjXCtbB8ChHK11N3kP6caikxGeZ
 Wd8Q==
X-Gm-Message-State: AOJu0YwqQfk8FGEJd+4GHgZhchcjgAB+ykSGvOQ1SocWRt+zaTyOerQu
 5TOLOWSQVe5tmvDr3AlgkGCr9C5x62WkXmeNb84mWHUM1InS4nuh3csF8LJsRJ9JFbo=
X-Gm-Gg: AY/fxX6FASOeeD0WdqXZvTOKWDisEoGmJAVAHLCs8fDE5rWsmlwe3VXtiHi6BOMI/ut
 FETxTE8Pfa6ePRu7JdlexPpfJav4ta8DEEBbNnLje6Bq/PRgpU/Zr0aMR+YQa6EF5KlJb758J7p
 KyvjYOQvCTLjt0YW3S+c7J5DchNcrqujeMUTjQlN3+wihdnYGseTD3IaTew7jgxME6iqiIV7bvV
 wvayaNA5b/3HhH2SPFn9KTCCOwvR/Zgh0PeVMUpVMLJt4GNp0i6QUjIDQ2dXubH1BX9GPB/JRSx
 5+VJ9LdZE3FJxRWL+sxODCdbtRSWrh98zXCpbbl5wLkrlpiS8Irf7KVoU5I6P/uz0KlLJ6sXAOM
 y1e1eOB74L8GI0H9qT4HODw3O728n8NW/0CZsDLobQbQ62zDuihMj0wC2kvhSGsdYaMvs+Xss7z
 R1
X-Google-Smtp-Source: AGHT+IEk7Nhg7sDbooVckmXs6hP7lKyil0TmnDlXX8quAYc+uWkFVlPIDEH7iur7pJHXcgAk8vKQ2w==
X-Received: by 2002:a05:6a20:258b:b0:366:c321:9fc6 with SMTP id
 adf61e73a8af0-369afa082a3mr13310353637.48.1765877721611; 
 Tue, 16 Dec 2025 01:35:21 -0800 (PST)
Received: from kinako ([2400:2200:654:c7e4:78b2:fce0:1e9:b13a])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c0c264211cbsm14635814a12.11.2025.12.16.01.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 01:35:21 -0800 (PST)
From: Daniel Palmer <daniel@thingy.jp>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH] lib: elf: Fix typo
Date: Tue, 16 Dec 2025 18:35:13 +0900
Message-ID: <20251216093513.424736-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
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

I guess someone had EFI on the mind when writing the comment
and wrote EFI instead of ELF.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 lib/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/elf.c b/lib/elf.c
index e767a42a3b3f..a92d0d30c666 100644
--- a/lib/elf.c
+++ b/lib/elf.c
@@ -188,7 +188,7 @@ unsigned long load_elf64_image_shdr(unsigned long addr)
  * A very simple ELF loader, assumes the image is valid, returns the
  * entry point address.
  *
- * The loader firstly reads the EFI class to see if it's a 64-bit image.
+ * The loader firstly reads the ELF class to see if it's a 64-bit image.
  * If yes, call the ELF64 loader. Otherwise continue with the ELF32 loader.
  */
 unsigned long load_elf_image_phdr(unsigned long addr)
-- 
2.51.0

