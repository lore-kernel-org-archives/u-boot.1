Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0347C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE51888E66;
	Wed, 21 Aug 2024 18:20:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Viz9hCVE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C019F88E34; Wed, 21 Aug 2024 18:19:57 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3F9588E2A
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7093d565310so5156995a34.2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257194; x=1724861994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HTB7aksRC+20mBPioJzN0gIff7/jeakOo2t8CxY9ozU=;
 b=Viz9hCVEFHdqyFO9UxaErkeYWNJ9hzYhLHJ3i+JhUt2GKOt1C9yN1to5qeY1wDpbfU
 WX0HtuRz55s4tgqkmN7ciJoYkrT7i5mnMjBf3/WobJHDNd7uwRZ5RodLvt1LHNOyD25W
 2pbRQ631ZaejtuBchEsTKLlO40QiVhfTs+hoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257194; x=1724861994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HTB7aksRC+20mBPioJzN0gIff7/jeakOo2t8CxY9ozU=;
 b=kmg9atj9ifquOF3/buWsk1CiV18rTMlfWcT2m6Grgkj1kf9CZL2nMbmxCXR1ldpA5T
 Mprs9rq/G9AwqjXlu+nYPW4mB2ZfKjbaBbgPmUwwfPAB3y7oFZm04POKLSw4SGEHkX+F
 cognbxjAZarxe6AfnFz46CV4LgUQ3Kr4ZZBpHoWvTPTJlKRAdFY/QkXUcrBMD3aX65GR
 60eS6EC4UxUp3t4bK//LjuyjB/y0aSXi2tvBT8Q355tGyz2e951p/rJ6ms9DhD5XkDbn
 Tf+5BefCia0sNVy96GL6B5yhPeNa88HgRc2I3DnRI3JbyKZk+HBKmg2YEEBakQm1K0Z3
 +o1w==
X-Gm-Message-State: AOJu0Yxm/Kb+qpA/Hqyn/vBD1LtwyqtpBXL9igirjPHXm9gaWn7dS1FG
 YSDVgXtrLC3Hp6W/LulWyVMJsiR3xyXMR49VrMnORSN8ciUW9ZtcdNiiB/DqK33ThZxpI2Ro+8Q
 =
X-Google-Smtp-Source: AGHT+IG+OI7U7ouDJvIaayX0R428DWkZlaE9OagWseia8fvLRz6JbrNbjlhLxVFqkxpKMnnjfJcWkA==
X-Received: by 2002:a05:6830:d82:b0:708:b083:86c8 with SMTP id
 46e09a7af769-70df8853d7amr3508879a34.21.1724257194336; 
 Wed, 21 Aug 2024 09:19:54 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 20/35] board_f: Move new_bloblist to boardf
Date: Wed, 21 Aug 2024 10:19:12 -0600
Message-Id: <20240821161927.695717-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

(no changes since v1)

 common/board_f.c                  | 11 ++++++-----
 include/asm-generic/global_data.h |  4 ----
 include/board_f.h                 |  4 ++++
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 0c24e3ae618..eb74bfa428a 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -627,8 +627,8 @@ static int reserve_bloblist(void)
 	/* Align to a 4KB boundary for easier reading of addresses */
 	gd->start_addr_sp = ALIGN_DOWN(gd->start_addr_sp -
 				       CONFIG_BLOBLIST_SIZE_RELOC, 0x1000);
-	gd->new_bloblist = map_sysmem(gd->start_addr_sp,
-				      CONFIG_BLOBLIST_SIZE_RELOC);
+	gd->boardf->new_bloblist = map_sysmem(gd->start_addr_sp,
+					      CONFIG_BLOBLIST_SIZE_RELOC);
 #endif
 
 	return 0;
@@ -704,10 +704,11 @@ static int reloc_bloblist(void)
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
index 915dad503a2..544195391bd 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -395,10 +395,6 @@ struct global_data {
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

