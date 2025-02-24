Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2573AC021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41C8380FDE;
	Tue, 25 Feb 2025 00:07:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cfdAtR6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3B2280FD1; Tue, 25 Feb 2025 00:07:27 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0C9280FDE
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-854a68f5afcso132671239f.0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438443; x=1741043243; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b18O0mXBGODv+uK2kOscdQzbGBpYEBF3/6yNBnZfDEs=;
 b=cfdAtR6cPpwQH4cwwo+7YyzFhAPodYffYoWGbVU8fpbXDFK1Nanem33HzdCu83nohC
 XmtUlV7n7aub91xe05iTiAMwoHhD1MeoDcaOOvyHk1mWCLvtzgE+HdseKNhQpcww7Iwq
 5hpFcogRFmbDBZmY6Dv94tJlLodpLcOMvLhIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438443; x=1741043243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b18O0mXBGODv+uK2kOscdQzbGBpYEBF3/6yNBnZfDEs=;
 b=Pnb9rQnKFc3yXnMyXTwHhzQWl6BO7+hONhRO9tcDFXGkPb1T/SjAbisp0rMpWVmUKX
 52pijZ9IPAbHjd0EhcxZ4VIQuQuGxM9V5AKCDjzaCr/p6BBTFBY8j8VxZYsNVIsfLX2l
 9myI8YtOKWeKxv0SBK1OlMybwUjfGfz9yVHcPwsrSkcWZD4sSVWOoOFBLZSifRLyG7k9
 +5pf4qC+dFuw5l5wLbbgo8LN5Cmt4Dp7gcQtUoE33Hz5Iyn1VJt2jMZx9+Sb6wVyX1t4
 MHfIKTXSOpyyak53JzF4j6FNkxlPCZ1nFKt1ZG88NJ4WeY/deJbAcA3JJ+Y15Zj7J511
 FyGw==
X-Gm-Message-State: AOJu0YwI4/Ht49kjVByLSowqpI7/iA00ExYlLwo7Y1LZXFBSyxkkKHpZ
 odjEqy2JIvn9vEaNh1MsnvCP1x4WJvlPhdyA1SKVcNZEwZt5rUTOkaIGTGuP9H/X4FLl6uQ3Gg8
 =
X-Gm-Gg: ASbGncuaiMTqIobmwv39Urhj7TEPK7N2le5EqQcx6ccBhO4hkvnF8xM8vXGLHoSY0qG
 3VUBdcTm64w2D6fhFkreA0Le+EWs+jIbBpybxThDiuTPFfLuVXSlPfqqL4wffH44p+ZiaNCMBdh
 vNrjdT6yk2mp3rICJlkep43tZG88aA6xxjvP7fq0p4P3AmcBWv8RHc7C6OjbQok1uiQl/VJpnlS
 PzLikcsZVD3lkXGk+S9rAyzQKFjfL+Q30Az31Rb0xZXdhFS3RsTWltS/7Mrl6NgWCPVoV/OPje/
 4a5SlMMt7Uq9O/U1R2PeWoWjuM6Zps1LtlEQP1LVyxEKyg+G7HJNDrxglpO0DZU=
X-Google-Smtp-Source: AGHT+IGBrxd+gfarMg5VxBygpYZhb+VHyfBYGSI0D94QG4Lj1egM6j/FcHlARiKSZJUw3F3B7GNpRA==
X-Received: by 2002:a05:6602:154c:b0:855:b3e9:7662 with SMTP id
 ca18e2360f4ac-856201567abmr172132539f.4.1740438443574; 
 Mon, 24 Feb 2025 15:07:23 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 12/44] x86: Drop the message about features missing in
 64-bit
Date: Mon, 24 Feb 2025 16:06:01 -0700
Message-ID: <20250224230640.2665206-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

