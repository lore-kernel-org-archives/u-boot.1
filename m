Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20F8C35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 598098212F;
	Wed, 19 Mar 2025 15:56:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mf/bj2in";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F26D382107; Wed, 19 Mar 2025 15:56:33 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E707C8215E
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so34339625e9.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396191; x=1743000991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l9QD4Z9kr5JhXnNx6KgYvBfejvormbbJjUVqSX4XWMc=;
 b=Mf/bj2inHITEQkxURjxZmvohXKc600Alu+db4m9b5+0S6zuOLG7qwwzs7elANwvvOm
 cyp/46h9EuXfBqmN4IIi1sEYFiffAaCuUb1H/4+kncxmZIhIh+4ixwCgvRN050EIzLmp
 iVFyFyQLtBzKbWB/OEQz+U/VWlcM39f45xmhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396191; x=1743000991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l9QD4Z9kr5JhXnNx6KgYvBfejvormbbJjUVqSX4XWMc=;
 b=R6k7VFw24aa6SQgm3I9Dw85mG4GkTiVpTdHAbkVot8+DeME0v8A71i+A/cjCeUOgx8
 2E0bMaszAgwne1SvcTSyhirdW88iWtU1hgHAaNFy9G0Qv/BTCFL7U0TtVnrE8r04MPZY
 WG1BLw2NrOfWTM67lDMRm/aPFY/sU2Qc9FBROUvPIajEPbJ0uGRLV29ogT+q/Y82koi6
 1o/MGpotHH7CIJi8rRqqmcqvr522CPaoLvQ1r3su1EkhXMX3t7pcT5gm2Uyx8MfVmRA0
 ZOs2/QthnK/0VhWxOMHmnVKIEEgbq64cysI45dxA72XwfHTnqY6rVKxitO6M+wcHwF5q
 6fbw==
X-Gm-Message-State: AOJu0YxkD16UuTJe5zo/XsfQBwTPlPWh/bIYLtVWO+InKzd5CmVy5AuE
 U3xaPf3KaV+z39SHx6KH/vVwg2+anruv4/2BeMLemhtowMxNgoyEeQjyPMpkT0q+vvt0a/udYIM
 =
X-Gm-Gg: ASbGncvTEmd/i3TRM/tZLmjnx4SDM4UocR6D6cSHrhsveVZBQ7L6n9Mz2E6E9/C4ceF
 BnI2VqxbbzLbvWNfihxtchDjNaIbWwDM08x1IVrJuFUXyQpxQLFTxSQqRw9JQX8qRNp1NoRlwAx
 peKoY0J04pXlB98tjqmqN5YBdqPn/J37GicJaiWptgd5jT8Lo4uA8q51cU4YH3rAfMquI9m5nrM
 3OXzs39IZY2cYGICe6k7LaFx1E+7/H0+I4MeaB9pEMfhT/UpcWjo6RmEhECpHUL+zowmyZvs3+/
 xG3voj/63UJuPkg/vawJyBdDfDY44zv29ZmFzXlTBQ==
X-Google-Smtp-Source: AGHT+IEiuJiFCP0rsiJDP/sUbZsO0ar/Ww1LebotCCmovyxbiSwGbZolV5B+M+yui/X5td9F9goJQw==
X-Received: by 2002:a05:600c:5795:b0:43c:fbbf:7bf1 with SMTP id
 5b1f17b1804b1-43d43bd41eemr26010705e9.30.1742396190731; 
 Wed, 19 Mar 2025 07:56:30 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 34/52] expo: Allow strings to be editable
Date: Wed, 19 Mar 2025 15:54:39 +0100
Message-ID: <20250319145512.2391122-35-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
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

