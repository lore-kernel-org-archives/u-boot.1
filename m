Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA00CD42B85
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 883F28946A;
	Tue, 12 Nov 2024 14:59:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XQGl6++A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBE1689467; Tue, 12 Nov 2024 14:59:58 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6A968944E
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-83ac05206f6so209826239f.2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731419995; x=1732024795; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDQHRykeD2siZkp3SdZVX/gTKcUyUVClK4ffd8KjLtc=;
 b=XQGl6++Ai9XDdGa6oZ2SfR9pGL+A9BKRrv5gayiqKqj1Lwivh+NwPe9zQEL9YEYBU1
 /U8jsr+aHU20nP6KzYPPTIZ7gY+pu6eM2dTtXRtGvRyn6hxFqkThRhXpHa/5/6MgsEY5
 03QDASntBA7zr2qpaJpTgZ3SfvvQGtfBuVilI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419995; x=1732024795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FDQHRykeD2siZkp3SdZVX/gTKcUyUVClK4ffd8KjLtc=;
 b=TIpQN5+tx+ZGlfmp8auhB8P5koT2QZPCpGorByCr6iL5ZIdcJM5Y3y2Op/u3nWR8iB
 8lbs5e6mlclsLD0g3ZpmH3BERiRlaMTAWRNSuKKPl+ZfF1zDMYmAGoh5X5fXtM3XV5wE
 3dJieKxJ3udw5ZkZqoEVNN+1Ld640PMz9bdzUkdF0chEfwHpKQr41eBOQ5Me1BqJtRM/
 iLIkY0B1hFmjamkF0NMYF+gUaI2TQhubt6rekY+jThMzeoa4cfSecq7Fwxux67xMHFG7
 tetjO2jGgnWOcOHLtBEdgbHgcTmwUNnnHM/6LlUkJ5UlJpLHbNYjVs4LO2lPFmDxk7hm
 3PRg==
X-Gm-Message-State: AOJu0Yy96QeFRecYtiNeOU1zAr/nKCa23YswkdsZDPNupVE2gSjjzoKz
 xGWgR7nBct9sb0m92+8dAWWQuLYLnj0D0b5L4mbPVDNx7ioXExG6UD2LdanGo/wRB9pPxua+Y3s
 =
X-Google-Smtp-Source: AGHT+IFKNo4jWyXQojh3vpDCmK91UgRdug6P+jTGuJ2vNYiNZUoeHmOPIjuLKeHkIS+h4EEs6qj0bA==
X-Received: by 2002:a05:6602:1550:b0:834:f6d2:bfca with SMTP id
 ca18e2360f4ac-83e032fb757mr1891553039f.9.1731419995041; 
 Tue, 12 Nov 2024 05:59:55 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.05.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:59:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/18] x86: Drop the message about features missing in 64-bit
Date: Tue, 12 Nov 2024 06:59:06 -0700
Message-Id: <20241112135911.630586-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112135911.630586-1-sjg@chromium.org>
References: <20241112135911.630586-1-sjg@chromium.org>
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

 arch/x86/lib/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index 2586a81093b..715c8cdc3ac 100644
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
2.34.1

