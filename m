Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A23FE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39222870D2;
	Mon,  2 Oct 2023 03:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QKPVwxu+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39E9687239; Mon,  2 Oct 2023 03:18:11 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E54B87178
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-79fe99a5f29so249065439f.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209386; x=1696814186; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UFsbFVKzTmwa7dFIkPaqueMQ/NY3xdCxttMz4X04WWk=;
 b=QKPVwxu+gfiwoMYhqRmuoJ+l1n7cQbzZpKuuYNybE6zMsKPYVhg3OKepgIHLatRthF
 24muhzq1ICuXziqHzqewq9ycYdE06G/hV9HLgfR5p7sCu0tBxWLaejZrFljCuJdPmLGS
 IKfg4ffSSdQn4vJOhtUfxqahV4ktrlQ3HBdNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209386; x=1696814186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UFsbFVKzTmwa7dFIkPaqueMQ/NY3xdCxttMz4X04WWk=;
 b=m5PHoeDXSD2YjDceEBUesvF8blaFompaCBB/dKu8k71tdLYf1IT2CkvRLTAJ6hR9DN
 quir2FUWDOvLriwqqHWheZ0Y2iHLITpWj6ceoJ7CcFMdiV2Uuo1fkyA6w/SKvcQIkFUX
 s7QJiUtmd2KLMPQSzBH6SlIKME61ZhiNdsuZiDuvl+kJ8xpqYTn10IKHBT6odXrAb8xd
 hO4HrOpeNVAECO7ZJxqYstEi6XcSXUdSWrnvu2rmEBE8bEfXX9s4FwFTNThClF7J3cGj
 3I61Mrwx6JKQA6ElhtiouWuL+6XUAz1sfaBg5gKsSoPJcJVio6N0Ojym3m5EMdCjr73C
 AICg==
X-Gm-Message-State: AOJu0YySFAGnEJd6kMyTs/mKU5Joy8O0YLpgON+Jnml5EQlh63/0g+91
 FEaQcbZwVdEF3+jK1Jp/BLEII4UbkyBkliLNRAo=
X-Google-Smtp-Source: AGHT+IHBm0uyuAo4h0Q9hCMP55apggYgQSI+HyOKW+tKpeWho4owRxybclU25olQrtNIGBH/e+nxmg==
X-Received: by 2002:a5e:8705:0:b0:787:1990:d2ec with SMTP id
 y5-20020a5e8705000000b007871990d2ecmr11038258ioj.12.1696209385958; 
 Sun, 01 Oct 2023 18:16:25 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 22/34] expo: Add a little more cedit CMOS logging
Date: Sun,  1 Oct 2023 19:15:32 -0600
Message-ID: <20231002011553.463514-23-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

Add some more logging in the CMOS read/write code. Tidy up a few
comments while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index a53a4f289906..cc1d5b763577 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -585,7 +585,7 @@ static int h_read_settings_env(struct scene_obj *obj, void *vpriv)
 
 		/*
 		 * note that no validation is done here, to make sure the ID is
-		 * valid * and actually points to a menu item
+		 * valid and actually points to a menu item
 		 */
 		menu->cur_item_id = val;
 		break;
@@ -719,6 +719,7 @@ int cedit_write_settings_cmos(struct expo *exp, struct udevice *dev,
 	}
 
 	/* write the data to the RTC */
+	log_debug("Writing CMOS\n");
 	first = CMOS_MAX_BYTES;
 	last = -1;
 	for (i = 0, count = 0; i < CMOS_MAX_BYTES; i++) {
@@ -786,6 +787,7 @@ static int h_read_settings_cmos(struct scene_obj *obj, void *vpriv)
 	}
 
 	/* update the current item */
+	log_debug("look for menuitem value %d in menu %d\n", val, menu->obj.id);
 	mi = scene_menuitem_find_seq(menu, val);
 	if (!mi)
 		return log_msg_ret("seq", -ENOENT);
@@ -820,7 +822,7 @@ int cedit_read_settings_cmos(struct expo *exp, struct udevice *dev,
 		goto done;
 	}
 
-	/* read the data to the RTC */
+	/* indicate what bytes were read from the RTC */
 	first = CMOS_MAX_BYTES;
 	last = -1;
 	for (i = 0, count = 0; i < CMOS_MAX_BYTES; i++) {
-- 
2.42.0.582.g8ccd20d70d-goog

