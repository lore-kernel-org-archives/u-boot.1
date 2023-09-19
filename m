Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF79CE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73C9586C33;
	Tue, 19 Sep 2023 20:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XV0ter2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B5BC86C33; Tue, 19 Sep 2023 20:09:50 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A94886BFC
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-34df2a961a0so20941915ab.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146986; x=1695751786; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kTkcUIE4kNEaIiuQpBp67lq90HlYQoFGSaqCHTdwHeI=;
 b=XV0ter2ifvKssUINXhVhKeTGxK7SRShyhPo9Lja6HdzGgzEt6ehZecqMt6u60naCsU
 UuW4DjhaHHQKi0CJHEFV4AngkPhAy12sA8byet9P0c656RDD9szkvXgiq4CAw842ede4
 AgKubqy7LZzsW98BNkFyKxx6ibk2SofJmaQPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146986; x=1695751786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kTkcUIE4kNEaIiuQpBp67lq90HlYQoFGSaqCHTdwHeI=;
 b=sx3K0MKATvVJ0qN3JIBD3n++U377SzLlDYjahzYwdHSNkR6hCg/PdmxidO05sOlPLe
 74BFVJ2OfZ9EQVr4iojPjnT0sgCkUfu+06WTsnleVKGjrD11f0OUdKMbf/qhxcCURj+q
 rPr69au1dRxNb0rLdx2d5kNxfvDbQpSyzK0H6x3Gc3UzrdfJIjQomJLIqXUHkBeU4JVE
 m+lMiDgBk4Xx+USvrWG1TWySJPLtKtltihNrSjLdskfSftMyhhRuC0WIQ4w6KYncwZkD
 ltBaWkw30bxPWjotZIXmhoK4YN9kQ2HLswvt8liQCKL15fO7CzHqzuedkyez3H2hI0ym
 QxYw==
X-Gm-Message-State: AOJu0Yw6wkMmfCZtdwxnT9teLShd24voYAss/4qFRGif3G9ISdnfUch8
 Q6goQH9pL1p7HwoRN9DlA8D7LDFvSwxce1AL064=
X-Google-Smtp-Source: AGHT+IFLFks9cI8bO0h6JfLfAFiDs+Vns5tO8BjWONmfzXIm/cghb++gqyu/fYWbnBSi8zT5LHvdZA==
X-Received: by 2002:a05:6e02:156b:b0:34f:75eb:f81 with SMTP id
 k11-20020a056e02156b00b0034f75eb0f81mr602747ilu.5.1695146986683; 
 Tue, 19 Sep 2023 11:09:46 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 24/36] expo: Add a function to write a property to a devicetree
Date: Tue, 19 Sep 2023 12:08:54 -0600
Message-ID: <20230919180918.2904313-25-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230919180918.2904313-1-sjg@chromium.org>
References: <20230919180918.2904313-1-sjg@chromium.org>
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

When the devicetree is too small for the property being written, we need
to expand the devicetree and retry the write.

Put this logic into a function so it can be reused.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index b7329c3245e..bb194af77bd 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -269,6 +269,28 @@ static int get_cur_menuitem_text(const struct scene_obj_menu *menu,
 	return 0;
 }
 
+static int write_dt_string(struct abuf *buf, const char *name, const char *str)
+{
+	int ret, i;
+
+	/* write the text of the current item */
+	ret = -EAGAIN;
+	for (i = 0; ret && i < 2; i++) {
+		ret = fdt_property_string(abuf_data(buf), name, str);
+		if (!i) {
+			ret = check_space(ret, buf);
+			if (ret)
+				return log_msg_ret("rs2", -ENOMEM);
+		}
+	}
+
+	/* this should not happen */
+	if (ret)
+		return log_msg_ret("str", -EFAULT);
+
+	return 0;
+}
+
 static int h_write_settings(struct scene_obj *obj, void *vpriv)
 {
 	struct cedit_iter_priv *priv = vpriv;
@@ -285,6 +307,7 @@ static int h_write_settings(struct scene_obj *obj, void *vpriv)
 		char name[80];
 		int ret, i;
 
+		/* write the ID of the current item */
 		menu = (struct scene_obj_menu *)obj;
 		ret = -EAGAIN;
 		for (i = 0; ret && i < 2; i++) {
@@ -304,20 +327,11 @@ static int h_write_settings(struct scene_obj *obj, void *vpriv)
 		if (ret)
 			return log_msg_ret("mis", ret);
 
+		/* write the text of the current item */
 		snprintf(name, sizeof(name), "%s-str", obj->name);
-		ret = -EAGAIN;
-		for (i = 0; ret && i < 2; i++) {
-			ret = fdt_property_string(abuf_data(buf), name, str);
-			if (!i) {
-				ret = check_space(ret, buf);
-				if (ret)
-					return log_msg_ret("rs2", -ENOMEM);
-			}
-		}
-
-		/* this should not happen */
+		ret = write_dt_string(buf, name, str);
 		if (ret)
-			return log_msg_ret("wr2", -EFAULT);
+			return log_msg_ret("wr2", ret);
 
 		break;
 	}
-- 
2.42.0.459.ge4e396fd5e-goog

