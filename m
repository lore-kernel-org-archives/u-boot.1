Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AEEC35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:03:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F1EE827A6;
	Wed, 19 Mar 2025 15:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GJDIzgxo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4847782107; Wed, 19 Mar 2025 15:56:50 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A8D482115
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso6051585e9.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396207; x=1743001007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ev1+2sRgSRl4qmwvv9a3EYTWZI+1/i8IOqRqog5LjQ=;
 b=GJDIzgxoNnqkAU2NmLdk6uLQe2Yo/jTPKxcvEcsnIdEurhHU3vhimi4I+VAGNGcGpC
 yFterQac3QnT4uJcuax03x0RLN1pBvxjsUdacljBvxRjwMdr4fesWT0rXG9Sk72XtXRz
 I6qqqwA40udf6zOIw2M8v6OinXRUa/wcXHVqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396207; x=1743001007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ev1+2sRgSRl4qmwvv9a3EYTWZI+1/i8IOqRqog5LjQ=;
 b=SEMhHWTaJ0Fel1OL6WrzIXfdKOjtc3TCkzR0zM3rY7JPE7ulcM18HfD0trrxt0k5ko
 b9F2Z4Pyy3Qg5A4V92Yf5vIi3f+gjcRuIqBGJJS4tPyssqnv1be7+Vzte0xl1NB1ywpe
 jiJOIlRD0/dl+98xOU2vrz7tR/wxd+vscHnb4iJMq1a1opoKrywPHBXuzZETM0nItkRM
 gZvXfCQ8HGk76eiw8rJvuPq0B0h/yAY704h6JqvSg7b1o5zN7tIgOjKZrGugd+Tc2pH2
 lc5H4vk8jlov0tLYZGCCaZ6Yc47ywSahWPkhihmHxD2sSp0iIvL0QX0n2m4iHDXo5s80
 DStw==
X-Gm-Message-State: AOJu0YxYE8CO374r/sfU38kOaSo1aN/U1eKo1ADnudwneYKu/tLMxa71
 jvBu4XPdajgwdE4efSjOvLYS+Nq88bfZPXKWSpSed0mOQH5gjV+DMXA/c7sBjQeq1PUgh7mtTU0
 =
X-Gm-Gg: ASbGncuID6JQJd0RFmQ/S35xpRKnrRE/tulN2yPtLP44Yr4X2reT/FnWFjjCoK2T0pW
 YqWMyDYwK9D1OJDWXdOhBOnqOtxB+Y8YPIdFpxSWzvNJvY0lTQ5ixt+ZZFHEFTMYSJlaESE+1dX
 DfgRdApBZ3m64uyY5AArqackS/xO+/Ib2DSXL+fDTxU51vmmsSBRBvX5PTUNEz37vKRZi6LCmQN
 1ux+gcWDhl45gnIkFASBAhZiW4aHJ+YjqQsEs4l2RO3NXMQfNnS1/mWT2U5ZsbMOtjszroGYJxr
 c1iLHoGqaAHxWWy8Q1ZOO2TS0i4jgtXxwF9gK9Lvyg==
X-Google-Smtp-Source: AGHT+IFpx/goTCMhmyV6/9M7gi/Ak2DG/N1glJ/HwAVxxXjcfDyIrXvz3Rk1q1y9S7euKIvb2QH5qg==
X-Received: by 2002:a05:600c:5856:b0:43b:bfa7:c7d with SMTP id
 5b1f17b1804b1-43d3b95f76fmr60066125e9.2.1742396207081; 
 Wed, 19 Mar 2025 07:56:47 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 43/52] expo: Add forward declarations to scene_internal.h
Date: Wed, 19 Mar 2025 15:54:48 +0100
Message-ID: <20250319145512.2391122-44-sjg@chromium.org>
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

Provide some forward declarations for types used in this file, to keep
the LSP happy and avoid errors if the caller happens not to include the
required header.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

