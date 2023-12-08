Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF1CC4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 22:32:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E9C3876AA;
	Fri,  8 Dec 2023 23:31:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HUESj3Vp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 969D1876C6; Fri,  8 Dec 2023 23:31:12 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DF898762F
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 23:31:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40c2c65e6aaso22785585e9.2
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 14:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702074667; x=1702679467;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MmvUmQV0CYJ5xeMBDgOVJIx7WYUEYy8T26nZgN7uRk=;
 b=HUESj3VpJnapvUfWipIq2f5aKLFRPmiDyDG/sQgpwKmT8mlz7QKET8o5i9HxoPG0Qt
 pg8a2qN1cdy4Y2TUbST1cr784qJJ2LQGBUYW3LLHkVBSVX8/3KdeHndHWf94FU1uMueq
 U9UzHmryoSUbf24EYa+V29Ku+PbIjj2NEwTDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702074667; x=1702679467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7MmvUmQV0CYJ5xeMBDgOVJIx7WYUEYy8T26nZgN7uRk=;
 b=w9/GhWhKF7DpTv7hnGC4o4fCng5odPYApYZWu6rk6CJcv73VgCMwVJc6Bs0+W8VKcc
 v6Sv2i0DxgP8y3vPKV0jnMgIU/IUA/8TNkPrWa77fl1mi6QhZS4flh8VnsJWdqrOSt+c
 CU/cPdaQHS2lCNLCpGiKg560AWtjncLtD1BYjjMnQ3vufHv9fFs95NOSQoooQJEvrggM
 JMLGrA2l9VHl3taceAjheufTqmg5KVrVLA5fbgHnQLhsiSGRUoOmVyZonjk+YcHWKZgS
 ULJQkDGVW8m9rIu66m1A9t3H3sB47uK32rNAsuhHwn4X8Anwqw7JAaFeQCcneaIQjZnP
 xubQ==
X-Gm-Message-State: AOJu0YwgUhY2YbzerWRZ33hhdBILiTH32UubV6CScHeLm7xBgxyx1Q+q
 Y/DekSd2o/IdqYZ3Idfv8tl79DiNiZJdIQ0WmPm2JQ==
X-Google-Smtp-Source: AGHT+IFyleortqOr/9Juo71PbYAC8VwH/N0x8H09Ct72aZmgOu5Ioxht9N6Bjmf+Jb1bVDmXHAlAng==
X-Received: by 2002:a05:600c:4296:b0:40b:5e4a:406c with SMTP id
 v22-20020a05600c429600b0040b5e4a406cmr317718wmc.140.1702074667088; 
 Fri, 08 Dec 2023 14:31:07 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c350b00b0040b4cb14d40sm6357863wmq.19.2023.12.08.14.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 14:31:06 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Hector Palacios <hector.palacios@digi.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Michal Simek <michal.simek@amd.com>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH v12 10/24] global_data.h: add GD_FLG_HUSH_OLD_PARSER flag
Date: Fri,  8 Dec 2023 23:30:11 +0100
Message-Id: <20231208223025.55076-11-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
References: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
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

This flag is used to indicate we are using the hush parser.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 common/cli.c                      | 2 ++
 include/asm-generic/global_data.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/common/cli.c b/common/cli.c
index 3916a7b10a..e5fe1060d0 100644
--- a/common/cli.c
+++ b/common/cli.c
@@ -268,6 +268,8 @@ void cli_loop(void)
 void cli_init(void)
 {
 #ifdef CONFIG_HUSH_PARSER
+	if (!(gd->flags & GD_FLG_HUSH_OLD_PARSER))
+		gd->flags |= GD_FLG_HUSH_OLD_PARSER;
 	u_boot_hush_start();
 #endif
 
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index e8c6412e3f..0a9b6bd92a 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -697,6 +697,10 @@ enum gd_flags {
 	 * @GD_FLG_BLOBLIST_READY: bloblist is ready for use
 	 */
 	GD_FLG_BLOBLIST_READY = 0x800000,
+	/**
+	 * @GD_FLG_HUSH_OLD_PARSER: Use hush old parser.
+	 */
+	GD_FLG_HUSH_OLD_PARSER = 0x1000000,
 };
 
 #endif /* __ASSEMBLY__ */
-- 
2.34.1

