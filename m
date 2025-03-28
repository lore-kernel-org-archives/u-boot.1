Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B35C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C7AA82116;
	Fri, 28 Mar 2025 14:08:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K0dV0T9q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03E182166; Fri, 28 Mar 2025 14:08:33 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A017781273
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-85da5a3667bso63383639f.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167309; x=1743772109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAO+5Ne6QrXhXzGf51vtzwD/+Uyix4H/uccqu+AEpIk=;
 b=K0dV0T9qvx/gWgHBmoMFx3axRVJFanfk69umRZR6a8tqUvK6SBNOPpBXMl4r8BLkxO
 sxZpg7vR5pUi8d4Nj07F10f2ckncHqvLjtfxbC3JrF1j0brbgR7va8ugW+wvi/1z+RqL
 Zj220S6tpgFN2xG2sk4ieRyuz5hBwi6tOLY2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167309; x=1743772109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jAO+5Ne6QrXhXzGf51vtzwD/+Uyix4H/uccqu+AEpIk=;
 b=fyLCpSg29u695j5LO8Qn34jvhaygnkZypaYd+X6FaRu26fWfVgdPvkPvxWga3qc6mt
 Cs5qSubIh31iBFsskYjXpbbSB/pIB40fCpScPNDeZVMCeK3zFF1YOtElFe4WYE6zXq0s
 arp0/wEKvXcRSxI6qDx2ScMuXKsSK9zxClsUto4i8T2d7yNxOOpuJAunNL++SBiZyUSt
 JB+kQGvNZIb4sH+HkM9TaNU4EYSGYsVsSwgzeKlU0Qno0PPsCyxOBc9cJG0KcPoJAOdh
 8Jn9N5NkpbIeRdg2upUw1uwyukZoANgqBcZ3Pum8yJoH5CCS8ME6LQpCGlFUgOIbOxe3
 3f6w==
X-Gm-Message-State: AOJu0Yxk+NGKKleXRqqFnGoIkN/q/HOnfHlKZeTc3RpdTv/68TNcrn46
 07rHjHIN3WvZuYIZ2UStgCj6jfuOPd22ErI6UpMQo33Fb6WJKJ0j4m0f93xnHH3yyDlaT+Rkjio
 =
X-Gm-Gg: ASbGnctAuU0jvLu+zyQh53xH2Yg7sJiPYaBm7kv86pBKigsjCaqmp3SexPJXzYFrlUt
 RkIWWr6JfXpDnwhom9zKh91CpxzwaJPAVANQt3nQygBF2eLVJE2XGf2hh95zFe8M9urFgzFgeyW
 q4YXq7oP84zf5JvjBjsSXmN4CpSPwzBhu6tXLm6xw18n4qYvIKBjGhojYE5j/YF6gI2a9Ma2T1L
 uvoTtmS3ZfXMCoJyT7UJmsR7ZwCQH2W4mFtMC6X1p5VquizPZRxZLgS5EENQcevH4ZJ6cEzNC+Q
 O/IlQg8ozRY5QfCuEhuFKhZIkHyGwNsEKWQ2d3eF1M41xBFG27UKse4Ip8//foj2NkG0xjvE3gD
 iJxQWmg==
X-Google-Smtp-Source: AGHT+IFKWL00UuDOm3uD5Bq3JoYYKoC8nRl7ty0YbRhnVmghWTY1lQB/9S6ymjD7wdrl8Oxv4C/2oA==
X-Received: by 2002:a05:6602:3719:b0:85b:3791:b2ed with SMTP id
 ca18e2360f4ac-85e820a0c8emr889063539f.8.1743167308721; 
 Fri, 28 Mar 2025 06:08:28 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 38/56] expo: Allow strings to be editable
Date: Fri, 28 Mar 2025 07:06:25 -0600
Message-ID: <20250328130713.2612648-39-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

In some cases dynamic text is needed, e.g. for a menu countdown. Add a
function which handles this, allowing the caller to take control of the
text that is shown on each render.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/expo.c      | 21 +++++++++++++++++++++
 include/expo.h   | 17 +++++++++++++++++
 test/boot/expo.c | 11 +++++++++++
 3 files changed, 49 insertions(+)

diff --git a/boot/expo.c b/boot/expo.c
index ee635116abc..a0be1404f1c 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -104,6 +104,27 @@ const char *expo_get_str(struct expo *exp, uint id)
 	return NULL;
 }
 
+int expo_edit_str(struct expo *exp, uint id, struct abuf *orig,
+		  struct abuf **copyp)
+{
+	struct expo_string *estr;
+	struct abuf old;
+
+	list_for_each_entry(estr, &exp->str_head, sibling) {
+		if (estr->id == id) {
+			old = estr->buf;
+			if (!abuf_copy(&old, &estr->buf))
+				return -ENOMEM;
+			*copyp = &estr->buf;
+			if (orig)
+				*orig = old;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
 int expo_set_display(struct expo *exp, struct udevice *dev)
 {
 	struct udevice *cons;
diff --git a/include/expo.h b/include/expo.h
index 32d69f269a7..7c6ab4bf630 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -469,6 +469,23 @@ int expo_str(struct expo *exp, const char *name, uint id, const char *str);
  */
 const char *expo_get_str(struct expo *exp, uint id);
 
+/**
+ * expo_edit_str() - Make a string writeable
+ *
+ * This allows a string to be updated under the control of the caller. The
+ * buffer must remain valid while the expo is active.
+ *
+ * @exp: Expo to use
+ * @id: String ID to look up
+ * @orig: If non-NULL, returns the original buffer, which can be used by the
+ *	caller. It is no-longer used by expo so must be uninited by the caller.
+ *	It contains a snapshot of the string contents
+ * @copyp: Returns a pointer to the new, writeable buffer
+ * Return: 0 if OK, -ENOENT if the id was not found, -ENOMEM if out of memory
+ */
+int expo_edit_str(struct expo *exp, uint id, struct abuf *orig,
+		  struct abuf **copyp);
+
 /**
  * expo_set_display() - set the display to use for a expo
  *
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 96c5943f394..a50e9f721de 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -707,6 +707,7 @@ static int expo_test_build(struct unit_test_state *uts)
 	struct scene_obj_menu *menu;
 	struct scene_menitem *item;
 	struct scene_obj_txt *txt;
+	struct abuf orig, *copy;
 	struct scene_obj *obj;
 	struct scene *scn;
 	struct expo *exp;
@@ -774,6 +775,16 @@ static int expo_test_build(struct unit_test_state *uts)
 	count = list_count_nodes(&menu->item_head);
 	ut_asserteq(3, count);
 
+	/* try editing some text */
+	ut_assertok(expo_edit_str(exp, txt->gen.str_id, &orig, &copy));
+	ut_asserteq_str("2 GHz", orig.data);
+	ut_asserteq_str("2 GHz", copy->data);
+
+	/* change it and check that things look right */
+	abuf_printf(copy, "atlantic %d", 123);
+	ut_asserteq_str("2 GHz", orig.data);
+	ut_asserteq_str("atlantic 123", copy->data);
+
 	expo_destroy(exp);
 
 	return 0;
-- 
2.43.0

