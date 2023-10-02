Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E386E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 886BA87128;
	Mon,  2 Oct 2023 03:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IRc0zUeq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87C0E870BD; Mon,  2 Oct 2023 03:14:42 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36BBB870BD
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-35135f69de2so39685255ab.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209254; x=1696814054; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WEuq2Fe4/y/arvdW0c1D1t/g2XDmr8Qpk/aV8dn4gJI=;
 b=IRc0zUeqr8uffH/2OeN3/h0ThNs1uIFPDvrZ7sV9/6gOx3X6rSfxwGnPmJgmssSrC3
 UnSPjMpyrIgjFoGGE3Mvdp2KgGwKIpEJmZnIQWm4pMvNpC3wy0um9zEIdzKFmCLwJXpb
 z0Z5dCyjKxO4hC0OfnJGy8G8rM8YapyCUxyFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209254; x=1696814054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WEuq2Fe4/y/arvdW0c1D1t/g2XDmr8Qpk/aV8dn4gJI=;
 b=PNzht1cbzLmcmbdPQ1AZE+TY5fg/shCNyzGijoHmeYODAlCISmt42G3drPHUUS9IOv
 Abge2O5vxEIA+JV0llgXQPa/wxxrARWQFi2BoCeutZ9q8zQMOKDOtkMj3pEiiQs1KahV
 s/RW23CLym/Cm+sHiFyXE92w7Eq5jXpEE0/Pt5F1+Hhfx6ZaJILAGBVK9jvuf4/Z6lFv
 FEyh5Jk5dx4MsxIphPb/USWxxM5yo7rR5AnlNqyC1gY5NOrp4REh+wFJyQoSZQAo/ZvP
 x5J4zOJd2kLgDkID+pypf//Mn0Mwg1YQqwgXhSJcxwkMHWJwHNibzpLYOVPJip43sFOM
 /VbA==
X-Gm-Message-State: AOJu0Yz9mB8vXa7TH3EFZP9KZVAyX1olxBDPaDfR34b9/IFC1Z+9o7IZ
 OPZpo1FCrKfQsS7rvxdvKFdxNDCp4AaCZsQmAVo=
X-Google-Smtp-Source: AGHT+IEvKtJPjwCLEjzTwviM7vIyGIQ72rnG6StZVrqmhj5HNl7M1OsMkKJWegd3fJHfO677YaA45A==
X-Received: by 2002:a05:6e02:13c7:b0:34b:ae9b:d039 with SMTP id
 v7-20020a056e0213c700b0034bae9bd039mr10107004ilj.18.1696209253828; 
 Sun, 01 Oct 2023 18:14:13 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 24/36] expo: Add a function to write a property to a
 devicetree
Date: Sun,  1 Oct 2023 19:13:28 -0600
Message-ID: <20231002011349.461284-25-sjg@chromium.org>
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

When the devicetree is too small for the property being written, we need
to expand the devicetree and retry the write.

Put this logic into a function so it can be reused.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/cedit.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index b7329c3245ee..bb194af77bdc 100644
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
2.42.0.582.g8ccd20d70d-goog

