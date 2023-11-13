Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16B4C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 03:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D386E8710B;
	Mon, 13 Nov 2023 04:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VSsi59pi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B802086CB1; Mon, 13 Nov 2023 04:00:16 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62F8686E95
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 04:00:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-357cf6725acso16230645ab.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 19:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699844409; x=1700449209; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YtnmoLyeXAii1/OSr4Tr9kCdgqn+bBfXyxn+2dcom2g=;
 b=VSsi59pi2bPRte7eT0TvHWVawjPqXuu6S7C1EjZv92U5Uycok8k6rEE18knvAOysm/
 R8puMyygSC0Wa2SWUKmriEUY16kwOnRHlks/kYV1dSfAvuVk+VbM+2CZwRIKuQtX0xBl
 R9b20DlL9w0m2z08HB+YrQBf3Byut+LXDgPRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699844409; x=1700449209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YtnmoLyeXAii1/OSr4Tr9kCdgqn+bBfXyxn+2dcom2g=;
 b=b+AcIBSN17hgZlVVHbW3ic3wT4EiFB3fZO0IczxYgDYDga0zLZJZkQ6g8pSLKXh+Z0
 azmLpEJ0ao3CNqKhNwtef4XLKRbXsKKDSZA/8ORQTYqP9RWkL1V2GeYatlgI9CYRV60G
 redO5OekQ4fJDNaDlLPR3TGaAz57OnDZKJxo7QCyBjkh9wHliArmMELHapwy8RFOegfK
 oDrLfSAz/Bjk34CCj7CEB0vDJD2oKAlOf5sTo30qbsVr5yJO2qONqPNpxk2tBDBWl1ko
 corhAtbYLHKdkfeRxvj1gkXayfZdQI61Oq5959ftbTxMiHyx65eWkx+2VZezJzN52iQr
 JLmA==
X-Gm-Message-State: AOJu0YxC3w7LjYF3KvQwx5kPIqJQDrQ1FOBvXX0m8lZTphMZVvB9eJIw
 xhIS727n18GPI1iNtRuhKM7oEy/jDX4awT6PUFsWgg==
X-Google-Smtp-Source: AGHT+IHoGVrxJFjNGcdGf2gawfIwTGyjhbgXgIhKK9f5qHzgJUgu92VJ+FX71YgajCvb0mxWvqRFKw==
X-Received: by 2002:a05:6e02:160b:b0:359:417b:50de with SMTP id
 t11-20020a056e02160b00b00359417b50demr10616132ilu.15.1699844408944; 
 Sun, 12 Nov 2023 19:00:08 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a92cf50000000b0035134215863sm1350914ilr.55.2023.11.12.19.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 19:00:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Baruch Siach <baruch@tkos.co.il>,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 4/9] solidrun: Use checkboard() instead of show_board_info()
Date: Sun, 12 Nov 2023 19:58:24 -0700
Message-ID: <20231113030001.240020-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231113030001.240020-1-sjg@chromium.org>
References: <20231113030001.240020-1-sjg@chromium.org>
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

Boards can use a sysinfo driver if a particular model name is needed.
Update this board to use checkboard() directly, rather than having a
weak function laid on top of a weak function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 board/solidrun/mx6cuboxi/mx6cuboxi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/board/solidrun/mx6cuboxi/mx6cuboxi.c b/board/solidrun/mx6cuboxi/mx6cuboxi.c
index e119330bc0c1..8edabf4404c2 100644
--- a/board/solidrun/mx6cuboxi/mx6cuboxi.c
+++ b/board/solidrun/mx6cuboxi/mx6cuboxi.c
@@ -381,6 +381,7 @@ static bool has_emmc(void)
 	return (mmc_get_op_cond(mmc, true) < 0) ? 0 : 1;
 }
 
+/* Override the default implementation, DT model is not accurate */
 int checkboard(void)
 {
 	request_detect_gpios();
@@ -496,12 +497,6 @@ int ft_board_setup(void *fdt, struct bd_info *bd)
 }
 #endif
 
-/* Override the default implementation, DT model is not accurate */
-int show_board_info(void)
-{
-	return checkboard();
-}
-
 int board_late_init(void)
 {
 #ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
-- 
2.42.0.869.gea05f2083d-goog

