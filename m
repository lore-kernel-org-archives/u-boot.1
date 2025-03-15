Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF74C28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10F5A819B1;
	Sat, 15 Mar 2025 15:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ax/U6lcn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E03E6819B1; Sat, 15 Mar 2025 15:27:40 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED4A581BEE
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso4290585e9.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048858; x=1742653658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b18O0mXBGODv+uK2kOscdQzbGBpYEBF3/6yNBnZfDEs=;
 b=ax/U6lcnbtEeB2dxNx5auhsa1b0/oYfUVILyI5Pq+y010eDH1hs/ivYY6VZmdAdajp
 udbV6Y2nNGKYLsVzKD4HF1SAe6o6sExpFZzeCyBwlOqZs55ZOjKjsZP4ykQB+FSj6vec
 jFABXCuGlmPSh+OoaKTAInpAFLfTAMiiyF5kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048858; x=1742653658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b18O0mXBGODv+uK2kOscdQzbGBpYEBF3/6yNBnZfDEs=;
 b=qnNpKELbbqdEmV65kNSBvMkS69SnqHKsXf9cDQYUT1415hYcW+GYio9WfdEDk7CdQx
 pfRc6twf/WTi8TDtNEbBhV9CR5MXt39DffchlGyf6RZEkklhwJXD8a0jPen+1ETd9TvU
 YU3L+ZYC7g8jOaOqbx/vl8YX0Frrv30nw+cM/2Byz8zOFI+Fja0MJxKH75L6wYF82LD+
 WhKpmoES10MZinE4apGhmQpW+MgKarvhuDgWNtPF5P8/+lrTwLIEfalUn07mDYXS2Ulz
 TnErwCstB2buYwiyWMxe3XSo7ogbk0wfuBKzK4NEZUw02gO6iA8woaPCTCk1bdY3lNTu
 MXug==
X-Gm-Message-State: AOJu0Yz7Hxy/5L8GxLlghPxlZLxUBg0X3mq36vsVDjp6HW07hO9n+7Si
 4RldoJ5DC1HZDChgppnIv9glW/TxZmMvkFADp+lLTRVnq9WjBdnFbfgted5FOj9A6rg1rKUhZW4
 rMg==
X-Gm-Gg: ASbGncteTteR/uwSQwpwIjcTLzbEZy97MD4AmgASIGkAW1AnUvbwyLGlxCG2B9mh+hP
 6bkO7VekgfPKyjUhlebvIL+CBmO8FvUvzFUKL6HF3B7fWnGXC8KE+0rkn6XQkoZMmQgANvO73Jo
 fq6JoeSvHbz7IGUoFfdGWYdDXOVp1mPcBy0aPh+E0S2fSb/OkCvAbjWlIVj6FCKpe/fvZvxf0Qp
 h7x/t5jN8UBDoPrR6tyyBN6HjStMc9xbbz/f7T2ekTCUXsTMzBgxauj2LtrEO+cQzk6q9evmLrh
 NiqUYjeyTstoLeGIg0kkrlqBjX6sedM0YKVV9m5GQA==
X-Google-Smtp-Source: AGHT+IGPlk5bM7HiHbj+q5Y388ma78BjKCoAW2w4XmMuAC1puuvIaDbkYK5mzgFarnh+xZe2u/5Lgw==
X-Received: by 2002:a05:600c:4e8d:b0:43c:fe85:e4a0 with SMTP id
 5b1f17b1804b1-43d1ecb3aafmr82710985e9.7.1742048857847; 
 Sat, 15 Mar 2025 07:27:37 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 14/46] x86: Drop the message about features missing in
 64-bit
Date: Sat, 15 Mar 2025 14:25:34 +0000
Message-ID: <20250315142643.2600605-15-sjg@chromium.org>
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

This functions normally and has done for a while, so drop this scary
message.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index 47cf9c862b5..0a6a761987e 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -281,7 +281,7 @@ void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
 {
 	int ret;
 
-	printf("Jumping to 64-bit U-Boot: Note many features are missing\n");
+	log_debug("Jumping to 64-bit U-Boot\n");
 	ret = cpu_jump_to_64bit_uboot(spl_image->entry_point);
 	debug("ret=%d\n", ret);
 	hang();
-- 
2.43.0

