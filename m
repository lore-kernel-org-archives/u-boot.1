Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252B3C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50C3F888F6;
	Wed, 24 Jul 2024 17:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hofwURbb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB410889D9; Wed, 24 Jul 2024 17:09:58 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A98D4888F6
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-397cdb4bf11so11606675ab.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833795; x=1722438595; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TAL629Mz8pL7sJib6DHmJp+XjaCQ1GbRoDybiLi+aCo=;
 b=hofwURbbWucgtC7vFOGpPAARnFQp/m6TxW22sboRpFbzS4kHD1OOS7xjSq8d1eE4Ld
 D6h3lpq+2+MlLmYQDHa6v/K4O1XKNkw6G2EOUGFwcO+qG4r9mFrZnBK6GVmqWjguW4d0
 3CxrWeSQHmaPBFlkaAZBNCA+GPCo0Dn7hCVks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833795; x=1722438595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TAL629Mz8pL7sJib6DHmJp+XjaCQ1GbRoDybiLi+aCo=;
 b=Yk5A8AWxI7mGcU6VB9h1Rtj4uuFvv+5YU3QSfL6WLR81JcUp0/eiwd3e0K9UotGJ4A
 M8n3e3LC7Z0yP6oMg1wDmk5rW3qSQ7Yo/CQfEDFc3EDe/iKk32bf+T/CE5soLHbCPcwh
 gQ30qQ+NZnA2F7CHIeZTAU2tZVJFdJpUdApF0keFxyByywLkJ7R9arOiQRlpm+FfBD5L
 I6tjfiQ1SLto9/i5bQ69ahdkUZOUdhCd6/QfgcrPOdDZie1NRo1RtuwaWJucBaxxAZXp
 4DIOPeKsVl6ablU4ps2Vy0sgS9yiBK8aaqSv7m1ZL/QnfWrZHklWvGecbJtLFCIqwipw
 1jAg==
X-Gm-Message-State: AOJu0YzU94o/HotqnljaP6o7VQ7fOw0Db7kpw5B6s2Igp/x7+3MSThsR
 oA/t475pqdXCWpFOqTimoRZ1SNim4ui1EgNlohThtsz1rWca5gc8nyLCtPPqX0PU6m3y/YmZva8
 =
X-Google-Smtp-Source: AGHT+IGGXs/vFWJwckQ9YBCBWTSio/89GpUXleWnnIXAP5JdzLlKrsXuf+LOmE9HpQmua5qszHBtUw==
X-Received: by 2002:a05:6e02:180e:b0:376:410b:ae69 with SMTP id
 e9e14a558f8ab-398e9134f42mr192282155ab.15.1721833795285; 
 Wed, 24 Jul 2024 08:09:55 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Raymond Mao <raymond.mao@linaro.org>, Shiji Yang <yangshiji66@outlook.com>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH 20/35] board_f: Move new_bloblist to boardf
Date: Wed, 24 Jul 2024 09:09:07 -0600
Message-Id: <20240724150922.2343249-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

This value is only used before relocation. Move it to the new boardf
struct.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/board_f.c                  | 11 ++++++-----
 include/asm-generic/global_data.h |  4 ----
 include/board_f.h                 |  4 ++++
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 83f14560cda..1e698d31841 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -626,8 +626,8 @@ static int reserve_bloblist(void)
 	/* Align to a 4KB boundary for easier reading of addresses */
 	gd->start_addr_sp = ALIGN_DOWN(gd->start_addr_sp -
 				       CONFIG_BLOBLIST_SIZE_RELOC, 0x1000);
-	gd->new_bloblist = map_sysmem(gd->start_addr_sp,
-				      CONFIG_BLOBLIST_SIZE_RELOC);
+	gd->boardf->new_bloblist = map_sysmem(gd->start_addr_sp,
+					      CONFIG_BLOBLIST_SIZE_RELOC);
 #endif
 
 	return 0;
@@ -710,10 +710,11 @@ static int reloc_bloblist(void)
 		debug("Not relocating bloblist\n");
 		return 0;
 	}
-	if (gd->new_bloblist) {
+	if (gd->boardf->new_bloblist) {
 		debug("Copying bloblist from %p to %p, size %x\n",
-		      gd->bloblist, gd->new_bloblist, gd->bloblist->total_size);
-		return bloblist_reloc(gd->new_bloblist,
+		      gd->bloblist, gd->boardf->new_bloblist,
+	gd->bloblist->total_size);
+		return bloblist_reloc(gd->boardf->new_bloblist,
 				      CONFIG_BLOBLIST_SIZE_RELOC);
 	}
 #endif
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 8f88ce09f4a..a23925ba9b3 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -394,10 +394,6 @@ struct global_data {
 	 * @bloblist: blob list information
 	 */
 	struct bloblist_hdr *bloblist;
-	/**
-	 * @new_bloblist: relocated blob list information
-	 */
-	struct bloblist_hdr *new_bloblist;
 #endif
 #if CONFIG_IS_ENABLED(HANDOFF)
 	/**
diff --git a/include/board_f.h b/include/board_f.h
index 1eba236a961..05aa51510c2 100644
--- a/include/board_f.h
+++ b/include/board_f.h
@@ -26,6 +26,10 @@ struct board_f {
 	 * @new_bootstage: relocated boot stage information
 	 */
 	struct bootstage_data *new_bootstage;
+	/**
+	 * @new_bloblist: relocated blob list information
+	 */
+	struct bloblist_hdr *new_bloblist;
 };
 
 #endif
-- 
2.34.1

