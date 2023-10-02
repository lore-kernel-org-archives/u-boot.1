Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF7BE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:28:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86447871B4;
	Mon,  2 Oct 2023 03:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K+T9oW7D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33E558711F; Mon,  2 Oct 2023 03:14:53 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99CC0870EC
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-352308c0799so17520715ab.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209256; x=1696814056; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5YWMomkGdZaAvryfqZhaiPVRyljwM01wNy2xF5E2uxg=;
 b=K+T9oW7D9Lbl/bggSDosqLJYpkqEJINsYxQIm/KqC/9fUxy+NCSfTa/6QtIUy5r02r
 NHJdOR9Q3OVoaJaGaJGjyOcbjTTSYg6h+KP7eNNMPyR33CMYV/INf2oLtm92DZ+O8TU0
 9KnHDsr9yvSNCGQ8Bw4cYXzRMROXodzj//66U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209256; x=1696814056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5YWMomkGdZaAvryfqZhaiPVRyljwM01wNy2xF5E2uxg=;
 b=ZIZ4CbeVSd6sHidGKLwMkOrw9ivJPoU099IDw407rd+Ia8L1FmtNrq/evTrC40w9Rv
 VLz6Y4NrlKugD0NVpPWumfJzpo/aePfSIII/zWXZoipYbFaZD0/5ASHER2PTTqmF7gSM
 v3MKy7R3th+MDBvuHAv2ORF46GlLhVRror3xy8ol0NpUdD8B9LSFosp32kijgKzO8+3K
 ucbRGTUFrFDbQbqXm/CmBdQpv72NH6zYmCUUXYcpCpgwb75Ljp2l9ockrUjSDn7mKc3Z
 QpWI6Pw10+3K7H++CcU7OW+lF5aPeeacaAn1938T6tgmTl2PwYNWKqW4vUR1kWqBFWUX
 IVvg==
X-Gm-Message-State: AOJu0YyABVx/QIHYcSgpwAIRdM7K88wBALlBBehVHNnCeY9YIlRC8V8/
 Z1hHIFM3s0o2e8NI6/dnsXs9b5iii3JuZHY2OyI=
X-Google-Smtp-Source: AGHT+IHGySx3h0EG6Ru5wRtqxFqYTzj0hLxmjQzd971D+TcNmVZBGYd8QeACbXwpaehy2bRdIZ9SfQ==
X-Received: by 2002:a05:6e02:219d:b0:34f:d674:63e8 with SMTP id
 j29-20020a056e02219d00b0034fd67463e8mr14059005ila.22.1696209256040; 
 Sun, 01 Oct 2023 18:14:16 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 27/36] expo: Add some scene fields needed for text entry
Date: Sun,  1 Oct 2023 19:13:31 -0600
Message-ID: <20231002011349.461284-28-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011349.461284-1-sjg@chromium.org>
References: <20231002011349.461284-1-sjg@chromium.org>
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

Add the CLI state, a buffer to hold the old value of the text being
edited and a place to save vidconsole entry context. These will be use
by the textline object.

Set an upper limit on the maximum number of characters in a textline
object supported by expo, at least for now.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene.c   | 10 ++++++++++
 include/expo.h | 14 ++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/boot/scene.c b/boot/scene.c
index 314dd7c6e849..0b44a13748ab 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -32,6 +32,14 @@ int scene_new(struct expo *exp, const char *name, uint id, struct scene **scnp)
 		return log_msg_ret("name", -ENOMEM);
 	}
 
+	abuf_init(&scn->buf);
+	if (!abuf_realloc(&scn->buf, EXPO_MAX_CHARS + 1)) {
+		free(scn->name);
+		free(scn);
+		return log_msg_ret("buf", -ENOMEM);
+	}
+	abuf_init(&scn->entry_save);
+
 	INIT_LIST_HEAD(&scn->obj_head);
 	scn->id = resolve_id(exp, id);
 	scn->expo = exp;
@@ -57,6 +65,8 @@ void scene_destroy(struct scene *scn)
 	list_for_each_entry_safe(obj, next, &scn->obj_head, sibling)
 		scene_obj_destroy(obj);
 
+	abuf_uninit(&scn->entry_save);
+	abuf_uninit(&scn->buf);
 	free(scn->name);
 	free(scn);
 }
diff --git a/include/expo.h b/include/expo.h
index b192d55665ab..c470f5be34d3 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -7,11 +7,14 @@
 #ifndef __EXPO_H
 #define __EXPO_H
 
+#include <abuf.h>
 #include <dm/ofnode_decl.h>
 #include <linux/list.h>
 
 struct udevice;
 
+#include <cli.h>
+
 /**
  * enum expoact_type - types of actions reported by the expo
  *
@@ -121,6 +124,9 @@ struct expo_string {
  * @id: ID number of the scene
  * @title_id: String ID of title of the scene (allocated)
  * @highlight_id: ID of highlighted object, if any
+ * @cls: cread state to use for input
+ * @buf: Buffer for input
+ * @entry_save: Buffer to hold vidconsole text-entry information
  * @sibling: Node to link this scene to its siblings
  * @obj_head: List of objects in the scene
  */
@@ -130,6 +136,9 @@ struct scene {
 	uint id;
 	uint title_id;
 	uint highlight_id;
+	struct cli_line_state cls;
+	struct abuf buf;
+	struct abuf entry_save;
 	struct list_head sibling;
 	struct list_head obj_head;
 };
@@ -180,6 +189,11 @@ enum scene_obj_flags_t {
 	SCENEOF_OPEN	= 1 << 2,
 };
 
+enum {
+	/* Maximum number of characters allowed in an line editor */
+	EXPO_MAX_CHARS		= 250,
+};
+
 /**
  * struct scene_obj - information about an object in a scene
  *
-- 
2.42.0.582.g8ccd20d70d-goog

