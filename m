Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13315C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBC91889C8;
	Wed, 24 Jul 2024 17:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BCkGBf5m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8737A887F5; Wed, 24 Jul 2024 17:09:57 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68D3888998
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3970f9331deso28076865ab.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833794; x=1722438594; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mRjMO8wyMGAwXzMHOZJed3qkgZQ4qbilseR+UtnYrGI=;
 b=BCkGBf5mNJeyrwdjhK+XYxm1dOXxCF1JTeqtaiEBFXFMueJe2RSQUv8k6Pw5OQH3Aj
 rpHCb9yID5CPpzCXswo6RZMaCaBZDraGZ9f2tK8NMmQXdHgW3i1xtDpV2FGzxdt/HUfd
 sZ64SqnZDAIv1apvn5KVTKMEkhwNWhmhtWO0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833794; x=1722438594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mRjMO8wyMGAwXzMHOZJed3qkgZQ4qbilseR+UtnYrGI=;
 b=iSFMhilugMXguHciP+niznXR37G7HBZZ70HTxjNcXuZFqqrzxgvzdq9QITYtEAB+G0
 CRYYLyFX4QytjJnjMV/gVo33biYZ2zJlVBhlPNxtfVpUTs6UC8qpe9XVg9ySpz81GbdA
 DBBiS0xz5i03azqCeUOit2/o+Eex15o5+49Pd/pQphzMcppWPMaOEA9ixuzL4cY/ozVx
 36/qQ/xaYwWQM+pPNgV8uOQQDH9isHoYdhzsSwxoE3/JYw+yWu6RsJz+pbsFJU+NBmNk
 8dmwLyzStQSCqpP5WWv3vh9NUW1OAtFZbhOuY2/P0y4opsXIaNoHxugHvoUoh1MsoJJc
 yXXQ==
X-Gm-Message-State: AOJu0YwdHlB3gr0C+Ew3eOG5Y0s/4fZQQtVpfBaHnOFbfIT4a63alCsS
 8rwJAa3AxrdZdg2jAsS99TbCAOQgtTExNywayfS4if6g3NDS0l4pUO5EDv29Ua/DJ9eQ1CfEcUA
 =
X-Google-Smtp-Source: AGHT+IFP2NNlWTGZSgtqU0T3Sc3/+4TJ8fyoiXbFWa2bMtzFk32vVKOMZfuinYY1YZhxv7Ju2H4l9g==
X-Received: by 2002:a92:c88b:0:b0:397:95c7:6f5d with SMTP id
 e9e14a558f8ab-3993ff98150mr129200835ab.11.1721833794057; 
 Wed, 24 Jul 2024 08:09:54 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Raymond Mao <raymond.mao@linaro.org>, Shiji Yang <yangshiji66@outlook.com>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH 19/35] board_f: Move new_bootstage to boardf
Date: Wed, 24 Jul 2024 09:09:06 -0600
Message-Id: <20240724150922.2343249-20-sjg@chromium.org>
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

 common/board_f.c                  | 10 +++++-----
 include/asm-generic/global_data.h |  4 ----
 include/board_f.h                 |  4 ++++
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 71194cccdb5..83f14560cda 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -595,7 +595,7 @@ static int reserve_bootstage(void)
 	int size = bootstage_get_size();
 
 	gd->start_addr_sp = reserve_stack_aligned(size);
-	gd->new_bootstage = map_sysmem(gd->start_addr_sp, size);
+	gd->boardf->new_bootstage = map_sysmem(gd->start_addr_sp, size);
 	debug("Reserving %#x Bytes for bootstage at: %08lx\n", size,
 	      gd->start_addr_sp);
 #endif
@@ -685,13 +685,13 @@ static int reloc_bootstage(void)
 #ifdef CONFIG_BOOTSTAGE
 	if (gd->flags & GD_FLG_SKIP_RELOC)
 		return 0;
-	if (gd->new_bootstage) {
+	if (gd->boardf->new_bootstage) {
 		int size = bootstage_get_size();
 
 		debug("Copying bootstage from %p to %p, size %x\n",
-		      gd->bootstage, gd->new_bootstage, size);
-		memcpy(gd->new_bootstage, gd->bootstage, size);
-		gd->bootstage = gd->new_bootstage;
+		      gd->bootstage, gd->boardf->new_bootstage, size);
+		memcpy(gd->boardf->new_bootstage, gd->bootstage, size);
+		gd->bootstage = gd->boardf->new_bootstage;
 		bootstage_relocate();
 	}
 #endif
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 81becbac2ad..8f88ce09f4a 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -334,10 +334,6 @@ struct global_data {
 	 * @bootstage: boot stage information
 	 */
 	struct bootstage_data *bootstage;
-	/**
-	 * @new_bootstage: relocated boot stage information
-	 */
-	struct bootstage_data *new_bootstage;
 #endif
 #ifdef CONFIG_LOG
 	/**
diff --git a/include/board_f.h b/include/board_f.h
index d9c793fbeb1..1eba236a961 100644
--- a/include/board_f.h
+++ b/include/board_f.h
@@ -22,6 +22,10 @@ struct board_f {
 	 * @fdt_size: space reserved for relocated device space
 	 */
 	unsigned long fdt_size;
+	/**
+	 * @new_bootstage: relocated boot stage information
+	 */
+	struct bootstage_data *new_bootstage;
 };
 
 #endif
-- 
2.34.1

