Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA85C3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:46:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 577B082A59;
	Mon,  5 May 2025 17:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZqeacPjK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBF9C82AE1; Mon,  5 May 2025 17:44:22 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2CB382153
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-acec5b99052so880071766b.1
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459860; x=1747064660; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oks+WlDNvHWDoDD0M/R6WD8BRrOLk8LUILLHb5Rqeig=;
 b=ZqeacPjKaszFE7P9VCPo9k5wIaDcQUPCMiiPnvu90W/Vf5sLQu4/LVm3QoMWyif3q2
 FqhRFNwzNyl033+5td5s1/jlS2xnscBTNGt7MyQA2gLzbDbP//yhgthxwZ6//c26820A
 XoCO/az5u3FcvkO8jiFPEoEfvamU1hXLeeK4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459860; x=1747064660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oks+WlDNvHWDoDD0M/R6WD8BRrOLk8LUILLHb5Rqeig=;
 b=CcEoCfvTbHUEDh97xiAp3nBrMblyMOkCNM4Xxmq110MbwzJHDl6Nw2a0ngg8EZjvp9
 BnbRVfg7rHMPl7n6D9iO0PS5mvEU698pE0LCMRsAz55MhK97rW+aGxKaZMlcnpn3402V
 TP9iWqkR+7rJWevg3HT+Kh9pJgI0+RPv5pm4irqVpmSpSwGPgtcdyJzhlNJPBQbif8wv
 2maCsY6ltjnHJL8J1uPK2bPWHBkYaV+bmbNVTIQRH9yT3uJbI18azXVwOZIp7DE+/WAC
 c1mnzUCbzyOKHOVJ4Rx0Ja+rjvHEa0U1m+998MUypPxpMeWEvDTZWuKeRqJ72wfnTGv4
 dJWA==
X-Gm-Message-State: AOJu0Yw/jDSP3tE9Of+aMVrmdSGSzRP/QsFJL3M6cxwJadQ1cLMUQW/p
 7dRuXUNBJeHSpqm1jBwK4AR1j9q1E9sWw7EJG1up8/cX1d0KgO7crytrhrwAZuXlK0toXOYNu77
 rQ21W7eQ=
X-Gm-Gg: ASbGncsoxJIrZaxURWt9lQLsQ48E0zbW20nFRshYKWkmZQzMK7UVcSvmOWxpT+3uaiV
 76LYFfAh/7PfYGXYggIy9a5gXN8wN8iqbXlUTfNDMg8VvAdkjlonRlmRE1GjRE1OnpoGcYrret3
 dCgft4mkRjKOoXsNeOs9QHsR4BGVt9th80y4/3SEiv1w50cqnc0/Bmk9tQJKQEYTyorFYesGqBb
 gLmsNJBdswdew3iIRiR0QzqgmPePpcJK5v7GedykqYXuNR1iJX/ZFVO9p1fgM7u6RhFzwMwPgTB
 QxKMOG+DdY2Avwsh3kG0CaLsqRf01m8TzlGl
X-Google-Smtp-Source: AGHT+IE8bFQ7JHIzhp0brPU3OwbTdbSKfL/FLXOEV2MDvHQZzH2XwRrMFBg85TTaF2DJ4mBUGtgUvA==
X-Received: by 2002:a17:907:9411:b0:aca:aeb4:9bd6 with SMTP id
 a640c23a62f3a-ad1a48bc8cfmr647176566b.10.1746459859617; 
 Mon, 05 May 2025 08:44:19 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa778188acsm5561762a12.35.2025.05.05.08.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:44:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 18/19] expo: Honour the textline edit_id when building
Date: Mon,  5 May 2025 17:42:56 +0200
Message-ID: <20250505154308.2911248-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505154308.2911248-1-sjg@chromium.org>
References: <20250505154308.2911248-1-sjg@chromium.org>
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

There is no need to create a new ID and it makes it harder for tests to
locate objects. Use the ID provided in the file, if any.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/expo_build.c | 6 ++----
 test/boot/expo.c  | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/boot/expo_build.c b/boot/expo_build.c
index d97347e1725..9a99a21e5e0 100644
--- a/boot/expo_build.c
+++ b/boot/expo_build.c
@@ -286,7 +286,7 @@ static int textline_build(struct build_info *info, ofnode node,
 			  struct scene *scn, uint id, struct scene_obj **objp)
 {
 	struct scene_obj_textline *ted;
-	uint ted_id, edit_id;
+	uint edit_id;
 	const char *name;
 	u32 max_chars;
 	int ret;
@@ -301,7 +301,6 @@ static int textline_build(struct build_info *info, ofnode node,
 	ret = scene_textline(scn, name, id, max_chars, &ted);
 	if (ret < 0)
 		return log_msg_ret("ted", ret);
-	ted_id = ret;
 
 	/* Set the title */
 	ret = add_txt_str(info, node, scn, "title", 0);
@@ -311,10 +310,9 @@ static int textline_build(struct build_info *info, ofnode node,
 
 	/* Setup the editor */
 	info->err_prop = "edit-id";
-	ret = ofnode_read_u32(node, "edit-id", &id);
+	ret = ofnode_read_u32(node, "edit-id", &edit_id);
 	if (ret)
 		return log_msg_ret("id", -ENOENT);
-	edit_id = ret;
 
 	ret = scene_txt_str(scn, "edit", edit_id, 0, abuf_data(&ted->buf),
 			    NULL);
diff --git a/test/boot/expo.c b/test/boot/expo.c
index b97a04e1102..b025e48469f 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -819,7 +819,7 @@ static int expo_test_build(struct unit_test_state *uts)
 
 	ut_asserteq_str("name", exp->name);
 	ut_asserteq(0, exp->scene_id);
-	ut_asserteq(ID_DYNAMIC_START + 24, exp->next_id);
+	ut_asserteq(ID_DYNAMIC_START + 23, exp->next_id);
 	ut_asserteq(false, exp->popup);
 
 	/* check the scene */
-- 
2.43.0

