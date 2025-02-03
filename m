Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1247DC02196
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:45:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C9968081A;
	Mon,  3 Feb 2025 18:43:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FOZH6Ivn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E21A807E1; Mon,  3 Feb 2025 18:43:53 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75CF6801DE
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:43:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3eba347aa6fso2963425b6e.3
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604629; x=1739209429; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c0ogsf6L7unCumw+UKaBqCr1nGemwlMTbSz1F0ivccg=;
 b=FOZH6IvnWPICM+S8Eah+b7ly5R4qTkXGpUUoG/hcv4PF31pEOOUO9Gsopr8W4eIUQ9
 9yVX8EIk5ijazPu+0iXqwZNTCMSXUJ3V0vvWlTGxXzxcvE58R/DcpM6SK+wk/YtXo3si
 zLgESDrkPA/VR/H5F+Sfyix3FrM5xrpNWA7Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604629; x=1739209429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c0ogsf6L7unCumw+UKaBqCr1nGemwlMTbSz1F0ivccg=;
 b=h42+slfvEdofu0RdCWYuVTYoPIhsjdkrkoNNZQQD4EtHYGjLLNF3SnBDa9lFDljDQp
 LhCJ+JGnaaPHr/kpXYMrezrcBTb1hcwWdsrU2kS0TK3YFfXd8KfVYJmgw1CsmfI3GFko
 c62EDlXQY1ggobbf/03T8i9L9nVuqEyTLKd49guvG5JyThpz8Vh74jUMGlbHFinSD6lM
 mhTtxHBSngZDSa1l7Z9YLDGhVnSG84czuGMq49kYpbrMuR976gYq51hF2qKLVuknMUol
 ZCZ8UrQdPBuJPKOR/pSHBR4NwAALAxrI5kyiUGqSoxCZliBbxb/EzkAW7BqngTmpKFKQ
 p3OA==
X-Gm-Message-State: AOJu0YxHY5ZfAD5K/N/vO1eUhz2UpUVHAa3o4eSaCDPUjoSAtg2iQ77P
 ziIwtxGBl3QbCT/WWscUN7qvHE1SlEMHewyWvlkU6L1B/QiGZuXA4SpA11utajAIq4RS7PIcTBg
 =
X-Gm-Gg: ASbGncsfYQqH6PiJzD84/sid3XaGVbzsFBi2UNSGTCAsrKLX2tHgXXAfu+bn1ZqA6oL
 OFzv5RtIwwXjaAH7nRIQ/F0Y6TEY+u8m9kRESVxg7/+nMWxlhj4aR9Z3zI/n4+frMFKhP58CHtu
 AImVbEdlBT4WhDzlg+R362QFCFdTDqwz4EEPDEtanHWPTeKiCBkUtIKwKkA3qpBoUlHPKgcGH2U
 /mGjcLMN9CN22vwtc0d9tNsLCVIgG74i8qpsaBzM+WyqWgaHOwldpDoio1CB9h35BBfaSFf9EGs
 H1O+viHLSH+Vn1ZH81TXQcCRK6glO7BUHddoLTsWZ3dmb+y1Ld5Q
X-Google-Smtp-Source: AGHT+IGG/FwQts/sO3LZGSQEjkOEjQABHi5gYq3MzZMK4nR9NyXY6yTXKae2osQ+01AA1zHppb+UMA==
X-Received: by 2002:a05:6808:3c8e:b0:3e6:3860:596b with SMTP id
 5614622812f47-3f323a10239mr16021825b6e.8.1738604629681; 
 Mon, 03 Feb 2025 09:43:49 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:43:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Janne Grunau <j@jannau.net>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/32] efi: lmb: Avoid access to _start
Date: Mon,  3 Feb 2025 10:42:08 -0700
Message-ID: <20250203174245.1331464-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

The app does not have this symbol. Also the memory where the app is
loaded is not under U-Boot's control. Disable this reservation for
the EFI app.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/lmb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 588787d2a90..420eae4d0b8 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -560,7 +560,8 @@ static void lmb_reserve_uboot_region(void)
 		lmb_reserve_flags(rsv_start, bank_end - rsv_start + 1,
 				  LMB_NOOVERWRITE);
 
-		if (gd->flags & GD_FLG_SKIP_RELOC)
+		if (!IS_ENABLED(CONFIG_EFI_APP) &&
+		    (gd->flags & GD_FLG_SKIP_RELOC))
 			lmb_reserve_flags((phys_addr_t)(uintptr_t)_start,
 					  gd->mon_len, LMB_NOOVERWRITE);
 
-- 
2.43.0

