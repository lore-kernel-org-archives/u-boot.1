Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E01C3ABB6
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 03:00:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9626B820EB;
	Tue,  6 May 2025 05:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LTIPY7yX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77ABD800D7; Tue,  6 May 2025 05:00:04 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E6B482162
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 05:00:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b1f7f239b31so5231181a12.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 20:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746500399; x=1747105199; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KcRv+g+fenSHjQVgAbMNxyH2qL7/xvg4xSTqmnSvcZY=;
 b=LTIPY7yXl7sKgOCFc3TzqHliNq2oW0ZOkFN4Y5s4f/eOH0LkayYevv2nME0YEGBbx/
 eZpvdwU28p4kNSfQf4oyUBYwR9tG4JLxHB7dU4uMuMqVJyD/uMILbt8YKLs82c4Xq+Ep
 XGIGMZhmFy3ohdqCZJZJBGCvYHR0TFr58DJGLFL8u7JycHtB/WVt6lb067A4pVDH9/QX
 IXa+ZMOEBNZCHYu24sbzWteM+uWF1518e3fl2TUG27S0eSeZSzsvlUaxudVT5n7SJK11
 41jVGNzH4+lfl7cXd0hZJgGO2Ui8QfhBTpFVDHf1FHDCgIqxLQG6wYpVVorIh3wJy9fM
 3e5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746500399; x=1747105199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KcRv+g+fenSHjQVgAbMNxyH2qL7/xvg4xSTqmnSvcZY=;
 b=cIOKGWrEiKKZsFzKHfwyfOc9X4mApmcDG82EDJU72xTvyEGnrXhaKvtdvqpMegt6Zl
 UQ4oouqN4E2GiRtXFSfWDKT9DPvrbHUf9cH/4WsfMf52dAW9RYcai8uwUODRvyCFoZov
 gx8GMM/qo2knkR8GimCTv5nMLWrfp+xjHsanoWVEfJqNmyz/Up35I39I7GCTUlg8IC64
 ZNIAvj4KfB3T5PcNE0Z8O1kV92PETHcM//2LARc4mz0Rf1KOenCGxsAtm1xRk+ISpnPR
 gmpDWr01O8ChkRtCuM4sVDM6Y1OT6IVVcO+g7Gt6LbcbnpwAHE4Tx4dAwsf9cQLnjcku
 uDfA==
X-Gm-Message-State: AOJu0YzumpmYSp4jV5KlqW3OtaBpZBvNJ5DRDmmTCz6n+GPL6rrBE+V9
 1l540nSj2JCg86JfVvkt9keBTI2MKHj25endQuQI4qxg0Pk/Gib3Y3fxZQ==
X-Gm-Gg: ASbGnctK+5xCk9c3Sh+30LyX06srdNQt/IoL9I80CLw8nmroOVX58Z7Xy8jz6s+E24r
 wGmoqL97bgvWU0ixt0yRvxUimJ4WsYvhgaHj00WgZXgerHC2YqSBdO3/Sc5TO4SK24Ls7G5FHKQ
 Q9lTzQQYB3o+58+kInUEMtWsNUnN8WAg7gwLPmlPTavue0j0VNy6XaXPTXWnF2VxIOxf9VhJJkZ
 bvQMKQvjuS/0uPye66GhdOpaW/5c3AFF3qlhzW78Po7jCvFMIoyXKdhZO3J/FUBxbmnPEdxGHjo
 K/405NYwpXj5iuEu7dN9uKPXjcz8CFBHb2Hs02jWfBki5phREIy5/M+VmVR7atmaBfqPvytBmam
 OF4ZpzvtDwnRBKKPFBf5xuNp+lSqf
X-Google-Smtp-Source: AGHT+IGHCkvmp/JDEavMiEhaXmrCUjkPGUUUKhbH6hUjYHgHbxvc/i9UECntCXXwofpRG/SWlQNDdQ==
X-Received: by 2002:a17:903:124a:b0:21a:7e04:7021 with SMTP id
 d9443c01a7336-22e3282d3d5mr22305815ad.24.1746500399459; 
 Mon, 05 May 2025 19:59:59 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1521fa63sm63019285ad.123.2025.05.05.19.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 19:59:59 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Stefan Roese <sr@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tony Dinh <mibodhi@gmail.com>,
 Walter Schweizer <swwa@users.sourceforge.net>
Subject: [PATCH 2/2] arm: kirkwood: Remove Synology DS109 board reset_misc
Date: Mon,  5 May 2025 19:58:43 -0700
Message-Id: <20250506025843.11019-3-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506025843.11019-1-mibodhi@gmail.com>
References: <20250506025843.11019-1-mibodhi@gmail.com>
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

Remove DS109 board reset_misc() function. U-Boot generic reset is enough.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 board/Synology/ds109/ds109.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/board/Synology/ds109/ds109.c b/board/Synology/ds109/ds109.c
index 4f397578182..f3a914cc515 100644
--- a/board/Synology/ds109/ds109.c
+++ b/board/Synology/ds109/ds109.c
@@ -97,24 +97,6 @@ int board_init(void)
 	return 0;
 }
 
-/* Synology reset uses UART */
-#include <ns16550.h>
-#define SOFTWARE_SHUTDOWN   0x31
-#define SOFTWARE_REBOOT     0x43
-#define CFG_SYS_NS16550_COM2		KW_UART1_BASE
-void reset_misc(void)
-{
-	int b_d;
-	printf("Synology reset...");
-	udelay(50000);
-
-	b_d = ns16550_calc_divisor((struct ns16550 *)CFG_SYS_NS16550_COM2,
-				   CFG_SYS_NS16550_CLK, 9600);
-	ns16550_init((struct ns16550 *)CFG_SYS_NS16550_COM2, b_d);
-	ns16550_putc((struct ns16550 *)CFG_SYS_NS16550_COM2,
-		     SOFTWARE_REBOOT);
-}
-
 #ifdef CONFIG_RESET_PHY_R
 /* Configure and enable MV88E1116 PHY */
 void reset_phy(void)
-- 
2.39.5

