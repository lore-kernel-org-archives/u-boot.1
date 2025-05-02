Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E2BC3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 403C482B81;
	Fri,  2 May 2025 16:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b5BSsPSC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5587682BD6; Fri,  2 May 2025 16:48:50 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D96682B7E
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-85db3475637so110913439f.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197326; x=1746802126; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j+U+9exebC5BjbzfJEmbuQh1JJU5RuyhmM89rcu1kXI=;
 b=b5BSsPSCCdmw9luam02q3a2nXtAr7PIRGJxilna7o4J39z/kf2sLJW0HOX0AjeeDO+
 rix0TMhU4nHg0mP3rO5yjWdcamtbSWV+XvpkcZ+5aVI4wz0FxzIjxu/S+9Mph3dP40TR
 OP1/3bJZfRRnGlGFWr9p7fhpDm/3sk/S0Actk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197326; x=1746802126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j+U+9exebC5BjbzfJEmbuQh1JJU5RuyhmM89rcu1kXI=;
 b=YyX9qqEYEbMH88sNOncUP+0HoalBM/l58z7FGdL0P1DIQ56Ki75p8s4q67to0uWNGD
 7Hu+fELaGyPYhorijacYk2fAx8yP/GdAKCeUS7tFeZ/KcR6xZKFTJFq7xrFb1HCI3ZZB
 H5Y47zS6M5M7FyldwnN09KI0SfW+7ROmCwM2LbybP9/fRshIK4sYP/mPvOIw+StXZ/DQ
 yigr3kCVPfzsDpjv4eE7rPrOK05FGOIolmVzfX3V4gK1+VZpN6+PzXKfLutgcxeM9zQx
 xJwn0IuIOlzX99IR3c+c3vIV8/77Lf1L/fjiQFqEqdIUSuWUr0PvXedlunv5G+h+HEL+
 sYGg==
X-Gm-Message-State: AOJu0YxrugcAaafOAFXLd3lH4wJ+dTYLHRUvU1uTJzfyiW/yvChfnu7y
 HBsUZ4bEBads2e1jbGO3QKo5e+2yCaLjwiGjkZt3LMOQF4NIFkmredjg5H8ozDWLA3szMTqhRCI
 =
X-Gm-Gg: ASbGncvYtEDKuGkCFhEQ6tIbS33ZWJ0dDaKhJaAoLNSpKvRt/Agq/YHfCwGS5N1IpMx
 DukWxmc7U0cefEAoO024ljPDGstbufsGY0l0O4he+vJ7cqERuHUhN9JEcrQswf15AnLbnwO4hrY
 dvfESrN7iJO/XRF/WQbE7UdhhZjWHOvyL1qKfvf0cSNzzAGBFudQOqdBF23ytLdRV+PD5K4Dz1Z
 AUXKISAnjWT/bM1J2KNfTHtFr9HbLRXsh706wazhEwM9xY+96Lwlrt0nAMGXNzqADFYySvu26Es
 I7wfwig5mcnG5KMyNp5Mw6TtEnNMHJKS0GglmhINsvTVnlyMSRXm8xsw2s7UOdYTApzDtHXczTr
 IRA==
X-Google-Smtp-Source: AGHT+IFlBv6BldNGZaJJe0edc4LDfkEsaMhUw+iAsqoNa6aNX3o9RSG5PM9j2hx3EAIQyr/TiC1GNg==
X-Received: by 2002:a05:6602:2bf2:b0:85e:16e9:5e8d with SMTP id
 ca18e2360f4ac-864a3dde2fcmr712312339f.7.1746197326128; 
 Fri, 02 May 2025 07:48:46 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 42/60] expo: Allow strings to be editable
Date: Fri,  2 May 2025 08:46:40 -0600
Message-ID: <20250502144718.313633-43-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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
index debdb60022b..4404fcb67e9 100644
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

