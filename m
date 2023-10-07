Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08A2E95A66
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4886B86F78;
	Sun,  8 Oct 2023 01:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JWwqolat";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1334986E08; Sun,  8 Oct 2023 01:14:29 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF8DB86F07
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-351365e47f6so12292615ab.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720399; x=1697325199; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OP7cMGfjPuWnZo8sZEKOFVIP1vGHAU1h+USGtVez7m4=;
 b=JWwqolatq2uPWR1Tiyrf9ZqV3Et0KSuhwab0sf1AGiW18vBGEMkZCoC3yaMC33i4KD
 ymcHBjijMrh5/Gez8Pi0JkPZysiR6/aKbgdr/Vfcx7rpX8GcLTN2iOkfRsdt8N53qPmd
 C40aQ+8qUljNV7nwpm1c0SeagVm/+NQfBVBiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720399; x=1697325199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OP7cMGfjPuWnZo8sZEKOFVIP1vGHAU1h+USGtVez7m4=;
 b=JuYCZhpAB1/QCmQkXrVClFubwjpXY8FzFFGNWjXXo4fTNC1MSCnuT7Dg/uP/ezepUX
 9QiPOkhfFkIzJHcrz2oqf0v3TxP2cQjnQMK3HDyQP2ES8JWYk9dWqKVJN01iTeISVS2i
 FlwqbDYfe5kpIdAY9CDN6IVR7xz22FDeKimzQepYHX/sP3HFPLMbP4V7agQ30qmJ0W7L
 zm5evWarLPxDA7Pwqds6jgjgwjdAB90leHJeQJsPlGf0hIjdBXzm5rm+Tcx90RafAn29
 6iWqLnndviSZ8eKCclmjKQBOs09acpnwQChYMMeR/PHn0MC/MUil/Zy2xgogSFhPCeVe
 PXOQ==
X-Gm-Message-State: AOJu0YxN96/lwDss01ghIpgukxbE+yxAiuLosJlDtsrDZzcDQarYFY3Z
 0QunO+OgRDWzdlSJXSKAMzd/Mb0WzJkntDXBwK8=
X-Google-Smtp-Source: AGHT+IHxXOo+WAkvDlQDhpmb+I6quCvocj0ryJmsRsxDOn6VmmZ2NfJ8NQRIfPqqXyKBEgUqQtQCmQ==
X-Received: by 2002:a05:6e02:1988:b0:350:f956:91c4 with SMTP id
 g8-20020a056e02198800b00350f95691c4mr15230539ilf.4.1696720399557; 
 Sat, 07 Oct 2023 16:13:19 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 19/27] log: Allow use without CONFIG_CMDLINE
Date: Sat,  7 Oct 2023 17:12:38 -0600
Message-ID: <20231007231255.277623-20-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

When CONFIG_SYS_CBSIZE is not used we need an alternative. For logging
it seems that CONFIG_SYS_PBSIZE is a better choice anyway, so update
this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/log.c b/common/log.c
index b2de57fcb3b8..72a4de3274c7 100644
--- a/common/log.c
+++ b/common/log.c
@@ -206,7 +206,7 @@ static bool log_passes_filters(struct log_device *ldev, struct log_rec *rec)
 static int log_dispatch(struct log_rec *rec, const char *fmt, va_list args)
 {
 	struct log_device *ldev;
-	char buf[CONFIG_SYS_CBSIZE];
+	char buf[CONFIG_SYS_PBSIZE];
 
 	/*
 	 * When a log driver writes messages (e.g. via the network stack) this
@@ -268,7 +268,7 @@ int _log(enum log_category_t cat, enum log_level_t level, const char *file,
 		/* display dropped traces with console puts and DEBUG_UART */
 		if (rec.level <= CONFIG_LOG_DEFAULT_LEVEL ||
 		    rec.flags & LOGRECF_FORCE_DEBUG) {
-			char buf[CONFIG_SYS_CBSIZE];
+			char buf[CONFIG_SYS_PBSIZE];
 
 			va_start(args, fmt);
 			vsnprintf(buf, sizeof(buf), fmt, args);
-- 
2.42.0.609.gbb76f46606-goog

