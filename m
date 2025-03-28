Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7D8C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27A93826AD;
	Fri, 28 Mar 2025 14:08:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MzDc+bxi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61A8A826AD; Fri, 28 Mar 2025 14:08:51 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3338382166
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3d59c8f0979so9016825ab.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167327; x=1743772127; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7YxZ9XUQelNIOSJkECh2l9Qqbb29IYxIAYnS4ZS0P9I=;
 b=MzDc+bxiSj8KzS8Z+0yCP2J0yB44wZVYxysbuYffosSBRK00EjDNHu89kNWei4O7+o
 +w7USH1mHBTnD/BmzO8M4cCTAiVkIVoLqWaMGFXdLwlYXAhqD0XcpEIUnQ40cRwS56ia
 RdkXfirctyfuBzF6qTuHvlIj5cLOK2Mfi2dAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167327; x=1743772127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7YxZ9XUQelNIOSJkECh2l9Qqbb29IYxIAYnS4ZS0P9I=;
 b=v2/GPfDSpkAVjmRKMS6Ef0VqP1OOHewE2MNkGKtTa/eBspioedNh+jJIgZV4WFBSsP
 FfWBWDIImP2SLY5hxK9bvRHyNEILS6JN7urep1yDAt9xAjE5nqu8mAjnaApCvv99NHm7
 r/CiHug9EhrxF+6ZSxRqUStCXBcRXgbL5x1qD12WYnG3lkJoJQwuG3DiHg3kDudXQzII
 MH12ANWjCCIqGPdvvJCK9/51W8UnShR8pYoaUFuc2P6iFSw7hY83oHuSWY8qmBT5ieZ0
 DWV9sg9YFspWGObiYEHbpayi8a/tUtjJE8sG3Ylmluvf9RzvZUDUnMahpJfLhuSj8zzR
 khnQ==
X-Gm-Message-State: AOJu0Yy9ZIgPfpE7JunYXLLwxqxa8hG5IF5FzNR2FRx3wB4E58JxWbGq
 9FqptTZ+u3GuZnwDe/r7rzyuJ9URNKBLwgJsUzGFpst3wiN9Cw/0B2aQUxqjWhdPLgX5LSKpwz8
 =
X-Gm-Gg: ASbGncs2GJh7nH0qk/CKiabV0i2Ifnj5cUy1FJtw2AeiaBhYZ8ftQQrJo9DtWegEcOO
 juNnPt4+gX0TaaIVo/MKX6c7LZHAAruXWuSXUZERCtFPwnLAvEVdu4F5kk8rDpjzDvqVoT7F8Cu
 Eek1WTsjaC9Rm62HkD8Yg7FlKd8hpsKbiO1Aq0Yrs2DEQ7gzrC/ZPwDOB/N6iYj1Sz16m+Oa+g8
 7OXZgunXF88+rcQBn4ImaEIUJ4ecvyZC95F/dhtUXOiswmap7/9FSXGod9Q4BW4Dl/WQq93Mknb
 uInyi1KB6JPa7wgPe7UA7Dl5hNRfB5xBKcPwdAMkg0edhhGjXr9PlpQ3ai9DaSzd6j3FpnQMPRl
 7n4j8iQ==
X-Google-Smtp-Source: AGHT+IEBLUjf1zRPVbX74PCXDRARG1YxAZNtSCbRDFvxrZb0DKEfvsXsebMUvPCDNicAC6LyVaL7qg==
X-Received: by 2002:a05:6e02:4401:20b0:3d2:af0b:6e2a with SMTP id
 e9e14a558f8ab-3d5d6c832eamr16678795ab.5.1743167327271; 
 Fri, 28 Mar 2025 06:08:47 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 47/56] expo: Add forward declarations to scene_internal.h
Date: Fri, 28 Mar 2025 07:06:34 -0600
Message-ID: <20250328130713.2612648-48-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

Provide some forward declarations for types used in this file, to keep
the LSP happy and avoid errors if the caller happens not to include the
required header.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene_internal.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index 760cc629b86..95927472875 100644
--- a/boot/scene_internal.h
+++ b/boot/scene_internal.h
@@ -9,8 +9,21 @@
 #ifndef __SCENE_INTERNAL_H
 #define __SCENE_INTERNAL_H
 
+#include <linux/types.h>
+
+struct expo;
+struct expo_action;
+struct expo_arrange_info;
+struct expo_theme;
+struct scene_obj;
+struct scene_obj_menu;
+struct scene_obj_textline;
+struct scene_obj_txtedit;
+struct scene_txt_generic;
 struct vidconsole_bbox;
 
+enum scene_obj_t;
+
 typedef int (*expo_scene_obj_iterator)(struct scene_obj *obj, void *priv);
 
 /**
-- 
2.43.0

