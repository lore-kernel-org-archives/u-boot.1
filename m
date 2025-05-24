Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AA0C54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 15:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6AA6835AA;
	Sat, 24 May 2025 17:41:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MFTTeViS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1321835AA; Sat, 24 May 2025 17:41:28 +0200 (CEST)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C595E82B70
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 17:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd43.google.com with SMTP id
 ca18e2360f4ac-86142446f3fso16222039f.2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 08:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748101285; x=1748706085; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5L8cZnILOx6i2MPNxk8jt6JbuLaTu3gDX4LaRWmLj5k=;
 b=MFTTeViSSFYMzDbO35IKphhgpeDrs1LrUssOuijxcG31DmXawdKssi0qQ0poQNj0cf
 rLrBI23VhfJFr7CHOeLDHGykIFuJC1xrka0w7JWvSJsUGZBjV/rH6qsE0IwpuZvSZ3H1
 4/ghxIl/jhyvYc/OT+RvNGDTD4B6VeGz1Q8WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748101285; x=1748706085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5L8cZnILOx6i2MPNxk8jt6JbuLaTu3gDX4LaRWmLj5k=;
 b=OrevzIsCNqOK1j2KX7fY90ZJEqGMsacsajeTei9+JSCOG9xr9sMwH36ru40gMUG7hN
 t3l9oEmWhHkZx83TYscVo00hd2Qd4PiEwrakAzajF0L2d6Vp2ryXjvhs/Cq+c9QZ/Q7G
 6h6ep0N5CyTTKakuq6VuWX0/0Wb/nuSmrNPCAM8e3BVXurG5yc3WahCcfrRLXRaaba8X
 YzuOXqeI7E4vjzf+fbHeinuUZhnKe3X1FmapdP6ECf7/v4EaUzwobbrE1SkKFih62KjL
 HL8rQ/k+4c91mbLo0lME0Klcy9gTPgYBagThaZO06BdZ2W7OQO1F40bjrJToBUfyYY8e
 /bDw==
X-Gm-Message-State: AOJu0YyLwq0+1o7wR8UqxfIl8KJaEeECgtCDsGPVz3tyC3sIHI4HdWt/
 1Y0/gdWtG3gJWl8EOkPmn6fnB0p89wYo7hJpLCp/rP0es9aCtj+MMUzElVMcssywVG298zyNCog
 loKDRcQLMZEs=
X-Gm-Gg: ASbGncu+y0pphrukSbLMmXIB/r4KT/+QXrOYjyfM1h0GtzotMI9SHRFqzWO3bSFA4Xr
 D4hVPIKe/Gc5c2SqUmlYwoPXCyLvrSB4h/p4UfqxI+ZkMEiFtvqsIDUmQL5lb22t1n8v7Hhzfx1
 J7QHZW/K+vtl2dg0PcA8MeRCM6dO2jWkvnr7vsdwFriTlRfVMVLljuwfkEHaKrIXAx2cMD7K/Cn
 Vjb+GuZltnc4P1bEbDqLsrfI+mCwv6ahvXf1kpHuW07SjO27kSX4EIxpPA5iebLVvtdvQ0Or+FF
 VUJ0DB8wLdIn0nPKd5Fna2xc71ifkSW5SK/E3wUOjgqF56cF/YX0hTIH/aO2Wio9AJ/gbyU80c+
 96ZL7daWpXPu/
X-Google-Smtp-Source: AGHT+IHtuP5lMfwmMjo/CKIyTQIzuA5OxEp3NaSz2Lvkrlw4AMjITNjwJxqTFEcT+4c+GFk5CTgnDQ==
X-Received: by 2002:a05:6602:371a:b0:85b:538e:1faf with SMTP id
 ca18e2360f4ac-86cbb893ea5mr315732339f.7.1748101284997; 
 Sat, 24 May 2025 08:41:24 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc4b1543sm4040779173.121.2025.05.24.08.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 08:41:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/6] expo: Indicate with the pointed-to item has changed
Date: Sat, 24 May 2025 09:41:08 -0600
Message-ID: <20250524154117.1217190-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250524154117.1217190-1-sjg@chromium.org>
References: <20250524154117.1217190-1-sjg@chromium.org>
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

Allow the caller to detect when a keypress has actually resulted in a
change of the item that is pointed to.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene_menu.c | 22 ++++++++++++++++------
 include/expo.h    |  3 +++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index fd16cad6521..fe44bd42133 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -410,6 +410,7 @@ int scene_menu_send_key(struct scene *scn, struct scene_obj_menu *menu, int key,
 {
 	const bool open = menu->obj.flags & SCENEOF_OPEN;
 	struct scene_menitem *item, *cur, *key_item;
+	bool changed = false;
 
 	cur = NULL;
 	key_item = NULL;
@@ -433,19 +434,28 @@ int scene_menu_send_key(struct scene *scn, struct scene_obj_menu *menu, int key,
 					     struct scene_menitem, sibling)) {
 			item = list_entry(item->sibling.prev,
 					  struct scene_menitem, sibling);
-			event->type = EXPOACT_POINT_ITEM;
-			event->select.id = item->id;
-			log_debug("up to item %d\n", event->select.id);
+			changed = true;
 		}
+		/*
+		 * issue an event even if the pointer did not move, so the
+		 * caller knows that an attempt was made, e.g. to cancel an
+		 * autoboot timeout
+		 */
+		event->type = EXPOACT_POINT_ITEM;
+		event->select.id = item->id;
+		event->select.changed = changed;
+		log_debug("up to item %d\n", event->select.id);
 		break;
 	case BKEY_DOWN:
 		if (!list_is_last(&item->sibling, &menu->item_head)) {
 			item = list_entry(item->sibling.next,
 					  struct scene_menitem, sibling);
-			event->type = EXPOACT_POINT_ITEM;
-			event->select.id = item->id;
-			log_debug("down to item %d\n", event->select.id);
+			changed = true;
 		}
+		event->type = EXPOACT_POINT_ITEM;
+		event->select.id = item->id;
+		event->select.changed = changed;
+		log_debug("down to item %d\n", event->select.id);
 		break;
 	case BKEY_SELECT:
 		event->type = EXPOACT_SELECT;
diff --git a/include/expo.h b/include/expo.h
index 5eb3299284c..6acbc54c648 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -65,12 +65,15 @@ enum expoact_type {
  * @type: Action type (EXPOACT_NONE if there is no action)
  * @select: Used for EXPOACT_POINT_ITEM and EXPOACT_SELECT
  * @select.id: ID number of the object affected.
+ * @select.changed: true if the selection has changed since last time (only
+ * valid for EXPOACT_POINT_ITEM)
  */
 struct expo_action {
 	enum expoact_type type;
 	union {
 		struct {
 			int id;
+			bool changed;
 		} select;
 	};
 };
-- 
2.43.0

base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
branch: expa
