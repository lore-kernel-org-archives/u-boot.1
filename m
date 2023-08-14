Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9CDC001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:43:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1D18869D2;
	Tue, 15 Aug 2023 00:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HDRP8OGk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46FF6869E2; Tue, 15 Aug 2023 00:41:29 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FF65869B9
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3497a6119abso15677505ab.3
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052886; x=1692657686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RlTjoo1sEF4GkRvkRfHx/uVw2G9pR8IJDDm3xwZqK60=;
 b=HDRP8OGkkFYVPDUz4HwTXwuigRE//Vy5jF6C3S3dKAVsLLPbmxyRpPJF5zLS6JZi2G
 vXktXENchpJ0aaqrDyRzYacA/zXBKfvhL8dyD53sHlKcQC926cqUxiImDq3Ons01hj2B
 ggw81ErZT14vnmDtY3uhgJKDKYqq5fc2hWiO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052886; x=1692657686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RlTjoo1sEF4GkRvkRfHx/uVw2G9pR8IJDDm3xwZqK60=;
 b=d8KpAJco/W0bcuTYDquAm/Rzc4CKvNMIfodRWjna6Njo/mwe55/01HdIWQ/2RkkgUn
 AXqLcYqE+xEZGLbwLYj2ElKZfkT34THHkgYBvP7ZiwlxIb9F8joKMnFB1eQwkG8SfSzS
 UNHCOS4F6W+U6nn/nmavxGJPheQq/8V+8k8aZ+oZTt1SCK5EYdoR2DD+v3Jiz8Wq53Hg
 NWKjPpYve7P22DsxhHtHOtFOijOhUpli86sFiQJOY8cCV8qw0m2MkAjjAHZIy6das3qb
 SXSOZmsPv/8pLdw5+J3fofqynFM8IyhcBG3amyyJQWb/ywM70v+868pOLu+Zpyx6sqqj
 kSeQ==
X-Gm-Message-State: AOJu0Yywo2dOFYAXlA8Uj+SDKWtAJfe78xButFan/bRxPRboGwP3FNTN
 Fab2IJk6uTATkTAZqpN+qYiUHgULlqcchFsJQtU=
X-Google-Smtp-Source: AGHT+IGD8VufSLBzuqcxsJEWbDS6epccB1BHV3BNcE4U2fwMC0+11m72f931Waxd9EoWR5vEv8psEg==
X-Received: by 2002:a05:6e02:1a49:b0:349:4e13:28a6 with SMTP id
 u9-20020a056e021a4900b003494e1328a6mr16357474ilv.12.1692052885714; 
 Mon, 14 Aug 2023 15:41:25 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a056e02080300b0034886587bdcsm3485091ilm.18.2023.08.14.15.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:41:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 12/19] expo: Export scene_menuitem_find() for use in internal
 code
Date: Mon, 14 Aug 2023 16:40:32 -0600
Message-ID: <20230814224047.535491-13-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230814224047.535491-1-sjg@chromium.org>
References: <20230814224047.535491-1-sjg@chromium.org>
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

Make this function available to other expo code so we can use it to look
up a menu item.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene_internal.h | 12 ++++++++++++
 boot/scene_menu.c     |  4 ++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index 60b143440785..23e29cb349b0 100644
--- a/boot/scene_internal.h
+++ b/boot/scene_internal.h
@@ -222,4 +222,16 @@ int scene_iter_objs(struct scene *scn, expo_scene_obj_iterator iter,
 int expo_iter_scene_objs(struct expo *exp, expo_scene_obj_iterator iter,
 			 void *priv);
 
+/**
+ * scene_menuitem_find() - Find the menu item for an ID
+ *
+ * Looks up the menu to find the item with the given ID
+ *
+ * @menu: Menu to check
+ * @id: ID to look for
+ * Return: Menu item, or NULL if not found
+ */
+struct scene_menitem *scene_menuitem_find(const struct scene_obj_menu *menu,
+					  int id);
+
 #endif /* __SCENE_INTERNAL_H */
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 57ffb523ff3f..602fe24580af 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -33,8 +33,8 @@ void scene_menu_destroy(struct scene_obj_menu *menu)
 		scene_menuitem_destroy(item);
 }
 
-static struct scene_menitem *scene_menuitem_find(struct scene_obj_menu *menu,
-						 int id)
+struct scene_menitem *scene_menuitem_find(const struct scene_obj_menu *menu,
+					  int id)
 {
 	struct scene_menitem *item;
 
-- 
2.41.0.694.ge786442a9b-goog

