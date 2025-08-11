Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE33C87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 10:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E65383335;
	Mon, 11 Aug 2025 12:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LUO7ue8G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CA6E8334A; Mon, 11 Aug 2025 12:47:30 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A372D82FCA
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 12:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-459ddf83023so25193915e9.0
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 03:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754909247; x=1755514047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lXS50i6WIEXLofL2AHxE3fCLiJxZaWxph2VcG+FXa60=;
 b=LUO7ue8Gg5n4xPVCuPSqPWPW0D96KCHmJT2TMxbGVKMb6jGSg7R02E5VM5io1GEUv3
 XOaTxDPSpejKffhL1RaFO4GvZOWEfaDAkxjM/UW/BvOeGtQMyMr49H+i3XbwXnOFaySC
 d4kig2385u8Rq73Z2aySqzqvk9TcwsiHucvexUUqlXXI5X0TuLV6UpBcw7BVdOT70Bdu
 ZztQG2XFqDkJq9lHrH+/YFghXF2t+tbGH0MHXyKxRfIuIy3otYCR7InxtJ6FAZGaZdJM
 7E1NUcYQ70zmRUffKTE2MvyBKRM079UGNXHMRWt28jFNo2jFglSpQCATrH1wey9oR6v3
 U+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754909247; x=1755514047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lXS50i6WIEXLofL2AHxE3fCLiJxZaWxph2VcG+FXa60=;
 b=aBNNRR8FuJDWj1zdjGpLDuS6kWSaooHzenlBKVQHxzjeqRkQp1wxgWbBhOdq8Z121I
 JT0avEqa/t0RRy2yqpwm4h70EB+RTobTft+KQpATc5Da5dX246y8r1KN5TVz5WqWV5Hf
 tGN56gsIejs1f8ZoHcWLhVnv8UUZn15K/Mt9qwiiJT5ThKFsFAnO4gHONgN7VABVeTLB
 W5slYOAQ88IKCbOUs/KtpfL6I02nVXXGQcgYXrvQ1F/7kwxydDq2gkAzGWA1TbeuRZcp
 tawYTc6cjyHErDMiSaOgt0fMkNrWr+Hg5wIt1GvR/tnyIpmosQrlN7SY/VHWU2/UP94K
 Ab6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe1FBqR+1NUyV8CoWgn6NwaW3vkiOdYuqYm4BZSo2S0gnwPwBhsNyUbZ7EEHzi5qDsbR6J0P8=@lists.denx.de
X-Gm-Message-State: AOJu0YwIfi1oTYZqVvmnVkdGst628CnfNlLzhfha6mfFmnrGKtonZHwf
 d82n3I+DTkNa8u223rk2BQ3CVmCCdB3hHpUUBubM6vn9lyHrtI9dh7RUSdWzVPenxfo=
X-Gm-Gg: ASbGnctXvQYm0qXvPdSIIWmdqYIBrX5usX9dRPCl7BLsigV0mIfpyBQ1E834MAlheii
 TgzbZtPRXaHgJdclEi+P4QTiLt9GNa1uW/WYTUoISpdKZcXY1iOvLxZPfzuFdpVRaWfENTgi/DX
 XAF3ZgYMXQzwPyXtXXYNqq7j7IN/SyyJ4CSf9o9w5ZjRlSkPZ8ySBzdYTpRHsIonDaqe8fzjqh5
 1fwduyvleyobuL5Xyh5Qc9yVhAlGezH2IiCCkYtRxG7fNmDm1Jr0rUGwvkzNcN8U/s3dr6+0DP4
 CX3g4ZDdsZtrqe8Z72ByJP8igLu5OUCJ0sb9fC70Ri08sXsueEQ7JZ9Mc/gvCU+6a5VYRgi5Iod
 uTnxz1OK9QYrYj8j9mFG3M5VbP0DeICD9kLF7ktj7xCDSxxrVUxdfyHJFzRUuLFpbysGR1Xz4MI
 w=
X-Google-Smtp-Source: AGHT+IEwAQ9ARpJnmYLbdG93Fp5ydzY5DLtbLRwQqB6mEyeRTPY++rwUQwVSpJX/2n9+8c4eAPAm+A==
X-Received: by 2002:a05:600c:46cb:b0:458:a7fa:211d with SMTP id
 5b1f17b1804b1-459f4f3b207mr94116715e9.29.1754909246911; 
 Mon, 11 Aug 2025 03:47:26 -0700 (PDT)
Received: from lion.tail248178.ts.net (p4fc3dd6f.dip0.t-ipconnect.de.
 [79.195.221.111]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e577d0f5sm250839295e9.0.2025.08.11.03.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 03:47:25 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sam Day <me@samcday.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: [PATCH] mach-snapdragon: fix erroneous lmb allocations
Date: Mon, 11 Aug 2025 12:45:13 +0200
Message-ID: <20250811104710.1896382-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.50.1
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

In 6e4675b8e5d8 ("lmb: replace the lmb_alloc() and lmb_alloc_base()
API's") an additional allocation was mistakenly introduced resulting
in ${kernel_comp_size} containing the address of a second 64mb region
rather than the actual value of KERNEL_COMP_SIZE.

Additionally, in b40d7b8f72f1 ("Merge patch series "lmb: use a single
API for all allocations"") merge conflict resulted in an additional
128mb allocation for ${loadaddr} when CONFIG_FASTBOOT is enabled, where
it should actually be set to the same value as ${fastboot_addr_r} to
respect size constraints (and since it doesn't seem to interfer with
any bootflows).

Fixup both of these, freeing up 192mb of memory.

Fixes: 6e4675b8e5d8 ("lmb: replace the lmb_alloc() and lmb_alloc_base() API's")
Fixes: b40d7b8f72f1 ("Merge patch series "lmb: use a single API for all allocations"")
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index fc921a4be269..5fb3240acc5a 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -533,21 +533,24 @@ int board_late_init(void)
 	status |= !lmb_alloc(SZ_128M, &addr) ?
 		env_set_hex("ramdisk_addr_r", addr) : 1;
 	status |= !lmb_alloc(KERNEL_COMP_SIZE, &addr) ?
 		env_set_hex("kernel_comp_addr_r", addr) : 1;
-	status |= !lmb_alloc(KERNEL_COMP_SIZE, &addr) ?
-		env_set_hex("kernel_comp_size", addr) : 1;
+	status |= env_set_hex("kernel_comp_size", KERNEL_COMP_SIZE);
 	status |= !lmb_alloc(SZ_4M, &addr) ?
 		env_set_hex("scriptaddr", addr) : 1;
 	status |= !lmb_alloc(SZ_4M, &addr) ?
 		env_set_hex("pxefile_addr_r", addr) : 1;
 
 	if (IS_ENABLED(CONFIG_FASTBOOT)) {
 		status |= !lmb_alloc(FASTBOOT_BUF_SIZE, &addr) ?
 			env_set_hex("fastboot_addr_r", addr) : 1;
-		/* override loadaddr for memory rich soc */
-		status |= !lmb_alloc(SZ_128M, &addr) ?
-			env_set_hex("loadaddr", addr) : 1;
+		/*
+		 * Override loadaddr for memory rich soc since ${loadaddr} and
+		 * ${kernel_addr_r} need to be different for the Android boot image
+		 * flow. It's typically safe for ${loadaddr} to be the same address
+		 * as the fastboot buffer.
+		 */
+		status |= env_set_hex("loadaddr", addr);
 	}
 
 	fdt_status |= !lmb_alloc(SZ_2M, &addr) ?
 		env_set_hex("fdt_addr_r", addr) : 1;
-- 
2.50.1

