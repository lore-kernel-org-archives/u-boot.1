Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246BAC83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 15:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CEA6863CF;
	Mon,  4 Sep 2023 17:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DsV8oGwi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F5D5863C3; Mon,  4 Sep 2023 17:21:26 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C58E86940
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 17:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-58fc4d319d2so15455777b3.1
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693840882; x=1694445682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=tR4RDVHf/pyh6fCmi12HdjDkWzSXlCj5tduU95YtF1M=;
 b=DsV8oGwiPyz/lRTbdYTqrNircWwuKuJgmrxY0ziNYccOB+0gcrtmsFW6al75+u5EAy
 rvTQof7/xx4mEK+ahu16O5lFKWfaCtecC5OGpRItAfMIPyrW18IdGnZrdsbyMPmoaFDP
 8CqhbJMk04M9IYgm9d0EfrOfY8ibn8pUYr6rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693840882; x=1694445682;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tR4RDVHf/pyh6fCmi12HdjDkWzSXlCj5tduU95YtF1M=;
 b=IS6qdVo7OSQwaJvFIsl3Eu/7IAS7m2HqWbLgGQc4p2HedHlhk5sLka0HKaUIZjMFmM
 6vuLoBZaBtce4K21+aJDziLXrgOu3Vdo85fGpQKPS9nGowqBDTG2FNz9YpSIEm+S1g6o
 Zdb3mhguXp7CBYRYx2d4NVhJf6UPMFQ/OiZ7bE54y30N2OU5dSQUDyoR+nPQxY/5qNp9
 7u00G55xPUBrZAigXrCOGch4VXZ4hI+16DKNUeiZH1AVmV3aQX7BDORJm0Seynx2ecKR
 DdrC3QmSwHJnGktZnQfsbGiUrLrXN3B7XVrXyf8beTOnffW2jUtalIGUAi3zJP6XVWtd
 dTIQ==
X-Gm-Message-State: AOJu0Yy4kPmiUmAJumrvi/PJ/e68A+B5YlPH7FZxZVPgAKfE7ZSZOXd5
 a2Hnk4DJ/o9btYiuf4dcSedEp42CNTBaltQYHcfAEw==
X-Google-Smtp-Source: AGHT+IFyGYmSLQvZTBrkVFSifu4QP/8WrPKqVSksmsnj0wz/lhVDXwjVjAue+2lDglV7jp50GODOJA==
X-Received: by 2002:a81:4f10:0:b0:592:2a17:9d88 with SMTP id
 d16-20020a814f10000000b005922a179d88mr10762556ywb.47.1693840882060; 
 Mon, 04 Sep 2023 08:21:22 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-977e-7fa5-b64a-ed15.res6.spectrum.com.
 [2603:6081:7b00:6400:977e:7fa5:b64a:ed15])
 by smtp.gmail.com with ESMTPSA id
 x184-20020a0dd5c1000000b00576e5af0249sm2632397ywd.20.2023.09.04.08.21.21
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 08:21:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] event.h: Documented some newly added portions better
Date: Mon,  4 Sep 2023 11:21:20 -0400
Message-Id: <20230904152120.634858-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

After the merge of v2023.10-rc4 to next include/event.h needs to be
fully documented in order for documentation builds to complete.  Rewords
two of the event_t descriptions to be docbook style and better match the
rest of this enum.  Fix two typos (flag->flags) in other comments.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/event.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/event.h b/include/event.h
index c37deae94527..311df878c4a5 100644
--- a/include/event.h
+++ b/include/event.h
@@ -94,18 +94,19 @@ enum event_t {
 	 */
 	EVT_MISC_INIT_F,
 
-	/*
-	 * Emitted before relocation to set up Firmware Support Package
-	 *
+	/**
+	 * @EVT_FSP_INIT_F:
+	 * This event is triggered before relocation to set up Firmware Support
+	 * Package.
 	 * Where U-Boot relies on binary blobs to handle part of the system
 	 * init, this event can be used to set up the blobs. This is used on
 	 * some Intel platforms
 	 */
 	EVT_FSP_INIT_F,
 
-	/*
-	 * Emitted just before jumping to the main loop
-	 *
+	/**
+	 * @EVT_LAST_STAGE_INIT:
+	 * This event is triggered just before jumping to the main loop.
 	 * Some boards need to perform initialisation immediately before control
 	 * is passed to the command-line interpreter (e.g. for init that depend
 	 * on later phases in the init sequence).
@@ -222,7 +223,7 @@ typedef int (*event_handler_simple_t)(void);
  *
  * @func: Function to call when the event is activated (must be first)
  * @type: Event type
- * @flag: Flags for this spy
+ * @flags: Flags for this spy
  * @id: Event id string
  */
 struct evspy_info {
@@ -241,7 +242,7 @@ struct evspy_info {
  *
  * @func: Function to call when the event is activated (must be first)
  * @type: Event type
- * @flag: Flags for this spy
+ * @flags: Flags for this spy
  * @id: Event id string
  */
 struct evspy_info_simple {
-- 
2.34.1

