Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A57DC52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4493B88E5C;
	Wed, 21 Aug 2024 18:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GqBG186V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68D5B88E1C; Wed, 21 Aug 2024 18:19:57 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C254988E47
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-704466b19c4so3975735a34.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257193; x=1724861993; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YPd+Ch017cy7orQCCOGHE5CKq25/pinKVOT47eMs6SI=;
 b=GqBG186VpP/vwjA4gqIoGistXY/rTYdd/c1eZMfGgYTgGheRagkW+Eh7sX9kvk9sNo
 glxO+6yWh9Njgj4Nzqe49mAL4/hhiM/67fZ2nAxa49orDFXxmuewd3SSagwHH9UxTrok
 BYjeI6kN9o6qacwow3WVpKmFgnd8W4tTfaX10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257193; x=1724861993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YPd+Ch017cy7orQCCOGHE5CKq25/pinKVOT47eMs6SI=;
 b=T9q7JYCXNVk6bFtzP8ZmH/uNU5gs0SJLGOSy8wIL4abc4ypAcBDZGC/6uzFXRR/u4U
 U2xq4SRhry4Em6DmSfWToMFrQkzLYD1pWvE9CTB2M93qFYVz5nWt6uGClITni5w/1dW3
 nAecurfJRpG+CjX+wbeirFmFvHn0I2XX3sqs2rVaPqhZcdbrOjOM/Isdun6q23kSFHJ+
 RG6uRSQ4Fp1JVEIOH7k6fVtcYIfKSL8X/4OFCG2iKFbx85ecs914RWTDW0OM5sLobaaI
 YWjE+Jlnx5IzUK6NHxzEWGQQj+/EVIRC+AW3bUe4QdBxqJ+qnDnt7SPjAdfKs9QBetws
 qcLA==
X-Gm-Message-State: AOJu0YxIiwXRqQ0kOsF1T0KgjzLRA2OEF1Sde4/xYFBlV0x5kBiSy51W
 4n65x/VPiS1o5qerM4trjPuNsrCzZXuWfvvGBcs2U3Kege1V4Xf0tnF1N5MR9Fo1DbLlq5vPeMY
 =
X-Google-Smtp-Source: AGHT+IFhht4zuDp89RcqJzeoWELjrRpQon+EZUIxw2Gh25thVZtJ8mN+/vU+Dr36tnZauDfpfy7agQ==
X-Received: by 2002:a05:6830:2801:b0:70b:3a21:2ebc with SMTP id
 46e09a7af769-70df8895826mr3848092a34.33.1724257193468; 
 Wed, 21 Aug 2024 09:19:53 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 19/35] board_f: Move new_bootstage to boardf
Date: Wed, 21 Aug 2024 10:19:11 -0600
Message-Id: <20240821161927.695717-20-sjg@chromium.org>
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

 common/board_f.c                  | 7 +++----
 include/asm-generic/global_data.h | 4 ----
 include/board_f.h                 | 4 ++++
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 046d9f45f8b..0c24e3ae618 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -596,7 +596,7 @@ static int reserve_bootstage(void)
 	int size = bootstage_get_size();
 
 	gd->start_addr_sp = reserve_stack_aligned(size);
-	gd->new_bootstage = map_sysmem(gd->start_addr_sp, size);
+	gd->boardf->new_bootstage = map_sysmem(gd->start_addr_sp, size);
 	debug("Reserving %#x Bytes for bootstage at: %08lx\n", size,
 	      gd->start_addr_sp);
 #endif
@@ -686,9 +686,8 @@ static int reloc_bootstage(void)
 #ifdef CONFIG_BOOTSTAGE
 	if (gd->flags & GD_FLG_SKIP_RELOC)
 		return 0;
-	if (gd->new_bootstage) {
-		bootstage_relocate(gd->new_bootstage);
-	}
+	if (gd->boardf->new_bootstage)
+		bootstage_relocate(gd->boardf->new_bootstage);
 #endif
 
 	return 0;
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 325777dc539..915dad503a2 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -335,10 +335,6 @@ struct global_data {
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

