Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3BDEE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 03:18:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC6D1871C1;
	Tue, 22 Aug 2023 05:17:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jvo4aEbZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B2F387267; Tue, 22 Aug 2023 05:17:20 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8137871BD
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-77ac14ff51bso145863639f.3
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692674236; x=1693279036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+j0ZBTGg5+76+0axpXnHOEzoFT7gVKkUgzIIwtva8s4=;
 b=Jvo4aEbZjhUCmcjYnhvYWVukIySFXV4+nawTPJc5Cal6nUHhvcJsb8YFBPZUGFyqmM
 rFx+reB7BJDtSKyJK+l2FC7e5qdVTXZY5wtoXozY1BshbVMKZ9J8J2QtumbmD4rskmbN
 CXSUSEoRM7VBRxnQFe3RJ9QW+LAhTQDOUoPwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692674236; x=1693279036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+j0ZBTGg5+76+0axpXnHOEzoFT7gVKkUgzIIwtva8s4=;
 b=kYOkbaDvRQHXb/CKCKIRtgLfQ7SCsZaV7sTiiZ7Uca2TQtuT1U+BeIRMW8Xct2RFi6
 37UgvKO2OxdGLVqGKqBr6SlQAz2eOkqXGGrrdEqvsDBMHTzHnHk1fPcLKjRmW8h6EQAY
 YStLC5gSifMvpBGP6/MAqnwns21CznZGXfA7EI/+Vgkg3DtHYv4RbTcb0vAtC+nvlyYw
 QLdbNygzd7RTTl6/IYeEIaVEK02GvZqorlNvHRuGRwU0griloZFa+bAIzV8KElKZ4gsw
 KLrCMSZHvjHJ3MrnadSIm+QvoxXJObRwWX8iqbs6ov1zt+/MPqbcHSbE5KYK8cv6Tiob
 zPQA==
X-Gm-Message-State: AOJu0YxD7DK9/9j5UQ7I20t1QvznROqNnACUfuU2sjYj4Ptg/IGCOrPV
 ee2i9OrkigRHVRij2Csi+wTXVOLTcGJTb9vnzEE=
X-Google-Smtp-Source: AGHT+IFm6snZrB1qySPclIDUOEP3PUb8JuwjUjBZudkFaUTuUr9tdyQIHJjXIdyqYD1nB4KQXea4zg==
X-Received: by 2002:a05:6e02:1ca8:b0:34a:c751:28ca with SMTP id
 x8-20020a056e021ca800b0034ac75128camr11120002ill.15.1692674236304; 
 Mon, 21 Aug 2023 20:17:16 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 gv14-20020a0566382e4e00b0042b37dda71asm2722735jab.136.2023.08.21.20.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 20:17:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Graf <agraf@csgraf.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 08/14] initcall: Support manual relocation
Date: Mon, 21 Aug 2023 21:16:55 -0600
Message-ID: <20230822031705.1340941-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822031705.1340941-1-sjg@chromium.org>
References: <20230822031705.1340941-1-sjg@chromium.org>
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

Move the manual-relocation code to the initcall file. Make sure to avoid
manually relocating event types. Only true function pointers should be
relocated.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/board_r.c   |  6 ++----
 include/initcall.h |  7 +++++++
 lib/initcall.c     | 10 ++++++++++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index 85860861f0ac..7c1fbc69ed6d 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -813,10 +813,8 @@ void board_init_r(gd_t *new_gd, ulong dest_addr)
 #endif
 	gd->flags &= ~GD_FLG_LOG_READY;
 
-	if (IS_ENABLED(CONFIG_NEEDS_MANUAL_RELOC)) {
-		for (int i = 0; i < ARRAY_SIZE(init_sequence_r); i++)
-			MANUAL_RELOC(init_sequence_r[i]);
-	}
+	if (IS_ENABLED(CONFIG_NEEDS_MANUAL_RELOC))
+		initcall_manual_reloc(init_sequence_r);
 
 	if (initcall_run_list(init_sequence_r))
 		hang();
diff --git a/include/initcall.h b/include/initcall.h
index 62d3bb67f089..208effd8d13e 100644
--- a/include/initcall.h
+++ b/include/initcall.h
@@ -35,4 +35,11 @@ typedef int (*init_fnc_t)(void);
  */
 int initcall_run_list(const init_fnc_t init_sequence[]);
 
+/**
+ * initcall_manual_reloc() - Do manual relocation on an initcall sequence
+ *
+ * @init_sequence: NULL-terminated init sequence to relocate
+ */
+void initcall_manual_reloc(init_fnc_t init_sequence[]);
+
 #endif
diff --git a/lib/initcall.c b/lib/initcall.c
index 33b7d761dc7e..480490ea239d 100644
--- a/lib/initcall.c
+++ b/lib/initcall.c
@@ -97,3 +97,13 @@ int initcall_run_list(const init_fnc_t init_sequence[])
 
 	return 0;
 }
+
+void initcall_manual_reloc(init_fnc_t init_sequence[])
+{
+	init_fnc_t *ptr;
+
+	for (ptr = init_sequence; *ptr; ptr++) {
+		if (!initcall_is_event(*ptr))
+			MANUAL_RELOC(*ptr);
+	}
+}
-- 
2.42.0.rc1.204.g551eb34607-goog

