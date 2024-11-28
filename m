Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C9ED70DEB
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD86589D20;
	Thu, 28 Nov 2024 20:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="caNb3DVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BE6989D46; Thu, 28 Nov 2024 20:13:50 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D90528938D
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-71d4ff749baso492195a34.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821226; x=1733426026; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Mc2SOHZscXBipI6MC5Tl7VBc9MmxrFpy3A5HNEHk54=;
 b=caNb3DVrJpd5qoHh97Dq7h8IPy1ovwKx7ag+Cj06kgMD8hQGw5IXOkKltXf+zYO5y5
 fn20ExBNn0r68ICqXq2x4LWJP4bgRMHzeMphQPqf1x/DB2wol6xJx0d1y9zeHUJ4E5eq
 CBfVHuPKjj7ikWUJXyrbJpa6m8qCynPcE6Bpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821226; x=1733426026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Mc2SOHZscXBipI6MC5Tl7VBc9MmxrFpy3A5HNEHk54=;
 b=P6PiU5kk1ARojHfmqWXnWRWBRRQFBV5hbu242eeoT3Pznb4sthfFNudZjBROOBq+fb
 jIuJyk/sZHxJouCGYUckfKs/swInRMHPyFoqEbtI55xuFYlYXKRahZ90ydK02zuSxcZr
 NUak8Ea/kGP4cpQgo8lAf31SYbolHlhUF3HV5mFoiFGwRzZSTE1muLrACseXZW1xS/ee
 ex/iAy8vIOuTdxkWuIkO+Sjr2YqwdhirDIEor/AWZAw4dCtlwblgen45I8dkuopUn0CS
 GCwCkmKwY71fJmuuQicg31i5Mj2n36MeiQ0iZEcdXc8zOSqiw5eS1lwdJkEELW3oO/6E
 jZ8Q==
X-Gm-Message-State: AOJu0Yz9H3rmDvwqiS/I1lRXlxElllvdxNRaS9FyIeEFeve10yJn5VCA
 isXTpE3cUHgv3Z8ZtKXHItB0rd8f7CFVmY5ETFTTPih7gddI3pkBYfC0M7yplHYUbPO6UwSMbgU
 =
X-Gm-Gg: ASbGncvGJCYRDdY4ytPm6ImM8Zwc1PkCQvEgHJuK7ON/ditYuE5qNmIXoK8j608zlSn
 6kdM7/AvEWxnnalPBh5CaN5loQ7Wv/YqV3FmZ1fEXzbjcJFAIgRXLBziJGGXnO7LauWS/9mW32y
 f2pRT4Rh4tgAWiyj6kkzgb3mgOr9NBtK0PvM+pGr2UrcyP4gP6oe5fDOmyvlVuOCzKfWpPUFnjH
 jlIj0D9x2jnL3Z1lLqWeEZMNG+kML/keagMxr58/3J0og==
X-Google-Smtp-Source: AGHT+IH+e+eK4WpiNXhlUUkZEpmiW2V/DlugMBX4XDXaBL+hHg5+WAx+3uDc/Eg2hY/1oqaADw5VKw==
X-Received: by 2002:a05:6830:925:b0:71d:4ec6:8600 with SMTP id
 46e09a7af769-71d65ca3b44mr9916734a34.13.1732821225796; 
 Thu, 28 Nov 2024 11:13:45 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 24/28] efi_loader: Correct address-usage in copy_fdt()
Date: Thu, 28 Nov 2024 12:12:40 -0700
Message-Id: <20241128191244.900006-25-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128191244.900006-1-sjg@chromium.org>
References: <20241128191244.900006-1-sjg@chromium.org>
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

Update this function to work correctly with sandbox

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index fd89ef6036f..72902a5ade3 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -486,12 +486,11 @@ static efi_status_t copy_fdt(void **fdtp)
 		log_err("Failed to reserve space for FDT\n");
 		goto done;
 	}
-	/* TODO(sjg): This does not work on sandbox */
-	new_fdt = (void *)(uintptr_t)new_fdt_addr;
+	new_fdt = map_sysmem(new_fdt_addr, fdt_size);
 	memcpy(new_fdt, fdt, fdt_totalsize(fdt));
 	fdt_set_totalsize(new_fdt, fdt_size);
 
-	*fdtp = (void *)(uintptr_t)new_fdt_addr;
+	*fdtp = new_fdt;
 done:
 	return ret;
 }
-- 
2.34.1

