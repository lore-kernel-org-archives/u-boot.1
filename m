Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B5EEE49A4
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 03:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2235F87283;
	Tue, 22 Aug 2023 05:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fD+QDCFh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5699587249; Tue, 22 Aug 2023 05:17:19 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AC4D871EC
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-34bb6d58f84so11316485ab.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692674234; x=1693279034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RG2oExopEjnny29pL4LlnCz50vnQYlC71lv2/0opNJE=;
 b=fD+QDCFhW/rthUN/Xq47mPr49/hBK9ueLlqfzLyFa1lVV2PIGZXKVaOb7/3FnBPZcQ
 DdBTk0TLXXBL6y2elm6jKFh8dQVDtKAoB2U8g9/bLFua6pOABmznmMYL0JMI+A4ogEIN
 Vgn6lHk1S1LmEt0w0bbvKfcC9FawOOlWjMZkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692674234; x=1693279034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RG2oExopEjnny29pL4LlnCz50vnQYlC71lv2/0opNJE=;
 b=CfXz9UitDdFaGeV9/yz0toIZ+WzaiMYlC+Sq6QIGCDB9NW5rTGZPwyW3VVvpMtqJvS
 pCZpGcVm58rwFJmJNwEwFz1GDlCqjwxmHIOWsSDxgClJnj9Gc+mGTLZ933CX2VORxyxn
 529VgwB/Ecpi3VsVE0vx/NC00BI42j73VTWVQ7mur5bpDSbJuWTtwX+Gtny2R4ny/k5r
 eWzfYcxHNT8sCD2EdLhJgePEtvm0BtsNImdHuomVJmHirDcyLcMIAVDXZo3BwE81PIF9
 oMiK0TUIc0SxZGCsKSdJbdQ5ApxAkbI7IYEBImCYx4LlXODaPEIG4Wr46Pvlw9cdN/eN
 AM8g==
X-Gm-Message-State: AOJu0YzG0uSOxFHXzSnmLzJDZU7GHBjzBo/Pd3+28hMjuRlzzQslxgmK
 qQm3x6DJCPA8FoskX6cY+EU8opTzQxZIwg2mCc0=
X-Google-Smtp-Source: AGHT+IFa0/O+ykotA34wa9YWku8RzlRgJTHOeXrIt3JHGUfTEJOCOM7npCBr6YLYSjq7tzIz6yoeyQ==
X-Received: by 2002:a05:6e02:c05:b0:348:1a1c:3ed9 with SMTP id
 d5-20020a056e020c0500b003481a1c3ed9mr11285823ile.11.1692674234729; 
 Mon, 21 Aug 2023 20:17:14 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 gv14-20020a0566382e4e00b0042b37dda71asm2722735jab.136.2023.08.21.20.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 20:17:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Graf <agraf@csgraf.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 06/14] event: Export event_type_name()
Date: Mon, 21 Aug 2023 21:16:53 -0600
Message-ID: <20230822031705.1340941-7-sjg@chromium.org>
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

Export this function so it can be used with initcall debugging.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/event.c  | 2 +-
 include/event.h | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/common/event.c b/common/event.c
index 7e2590eb0400..55f6932ef62c 100644
--- a/common/event.c
+++ b/common/event.c
@@ -49,7 +49,7 @@ const char *const type_name[] = {
 _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
 #endif
 
-static const char *event_type_name(enum event_t type)
+const char *event_type_name(enum event_t type)
 {
 #if CONFIG_IS_ENABLED(EVENT_DEBUG)
 	return type_name[type];
diff --git a/include/event.h b/include/event.h
index 0e3222c2e243..062b5847897e 100644
--- a/include/event.h
+++ b/include/event.h
@@ -230,6 +230,14 @@ void event_show_spy_list(void);
  */
 int event_manual_reloc(void);
 
+/**
+ * event_type_name() - Get the name of an event type
+ *
+ * @type: Type to check
+ * Return: Name of event, or "(unknown)" if not known
+ */
+const char *event_type_name(enum event_t type);
+
 /**
  * event_notify() - notify spies about an event
  *
-- 
2.42.0.rc1.204.g551eb34607-goog

