Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFCCD3B9AB
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 22:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAF8E83106;
	Wed, 10 Dec 2025 23:28:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AI0lNTCn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A3F38312A; Wed, 10 Dec 2025 23:28:28 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72C568309A
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 23:28:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7881b67da53so3358187b3.1
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 14:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765405704; x=1766010504; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gklEsw9qCW5RKQfI/qxrBg0lXxsPlaRAT191xRckHto=;
 b=AI0lNTCncq3y7cCDe1AIcQay08Z/L/eKVpp1PyOiR1u5ziiEgQMF5QdDQ4WmK/HaSv
 kLDrrgqodF+oXU+9yN/KhSxWkAH4Et8wk/IdY2SlyyrAM2I7HepWiikGdCEiBkwFLcV2
 jMPgI0MMovah5P/q6kQhlf07vjW4NGNLKghHfnX7/XlnAYfNYwCWsgRxYdHTni0E1ajZ
 cINywWIKQGQiyGvlMQToTObzYbyreIIUqBJXda2oi6YwZ1X2tseGIaAl9R/sSlV5pRk5
 U6WYesgSO0ptXmrUJBizs6uRvpDADsIXIyk0SOzdpr5qSAIr/xDRwkopCGYegjfmqE7E
 ZLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765405704; x=1766010504;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gklEsw9qCW5RKQfI/qxrBg0lXxsPlaRAT191xRckHto=;
 b=NPC0djSXCQ5hZrh1MvFtIKjBr3RgEE7Fj8Hw8JAP9xR/Gq06A9DYJ8fJzpDVfqusVl
 2zkIHEJHlC2rr2ySNddC96HLEacsk9aNu8Myo6QqVfF8q/w+IIEXERGZaFLkKQKnFhoE
 VL/ueVJuDZX8Q3NUdLQiDVeoLAUzCJfGimTUVERXrmhrCUTLQGGcNro0UyoPW59hrtkD
 mvnoWFf9lHj/qKLkrFPqg1fK691HcHsg6eELAgrqxCdku/Cg5/avtacItxSfBL/vMI4s
 X6VEp+a2BMrYWqK60UmQ1jXhLxsK1siZYum7weYJYi9SE8cAG7mfs3eAWNHUNwJmWGCe
 3mBA==
X-Gm-Message-State: AOJu0YwzV2TNbut/PXW0Q/SFXx3MMJVifJQwN1Z4fYlgzwKMdkKzwim5
 H2w21WbjDErDyaveMELHZqfBLgMQBN/7G448czXUx3RVD0l4QlJUvooIRO4itA==
X-Gm-Gg: AY/fxX5akX6gMVhtRirmitt4iSTDoaSYMIkXYJUhHH7iq82zj8tBswl9Wq5WNAGqdkD
 8k7/8AgfwfrtOtECb6hIMsFbpAFuaQYXXdrTbAIQw4bkf+MuePlsUjmJ1mXsZI++TkkprZf9uqC
 WEaZhM6jAJB5AzAJLKb5B1Hindks3srZFC121LS4+yiohfVo4cDFWy8/2pr3L1qO+H/OBWYwoFb
 AYlzycxdf836//Rwkd+fjUO4wyYRVChLYZRFCGtDJ/09+pFz1y/QLX6bGKWHdOd4W5Un5gviolk
 zJOYAvrL10LR8qkT4uvSIS8gCc25m6079Drrw/UW3Z1Ye/HfSmIP8KAcpWNwKLWZWQc4H2xnLQO
 k7gfRcTZg6ZKOixWTg9pc7Trxyv6YZMWG5APMLFKXCtDLzfgpAh4ESnEJrSCanfrVnx6j3w4ezG
 wdmStnoWzrvnbM+xpTs+QtjtvCL6+qc8joJzkn/NHe0/ceAcjWfUeJveL3D43lUuIPRRVQpjBkj
 w==
X-Google-Smtp-Source: AGHT+IH3ZzRcnwSOoTHqnhdx59hkXxThmHNOYhADGcq5Ekv+kww2K3sxBJVc+tGNQVv50VslPcFGVA==
X-Received: by 2002:a05:690c:9684:b0:786:5789:57d1 with SMTP id
 00721157ae682-78c9d76d12cmr32456127b3.52.1765405704393; 
 Wed, 10 Dec 2025 14:28:24 -0800 (PST)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78d69debae9sm3294007b3.56.2025.12.10.14.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 14:28:23 -0800 (PST)
From: Tony Dinh <mibodhi@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stefan Roese <stefan.roese@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>,
	Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH] arm: kirkwood: Remove unnecessary watchdog GPIO for ZyXEL
 NSA325 board
Date: Wed, 10 Dec 2025 14:27:05 -0800
Message-ID: <20251210222754.23535-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.47.3
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

Watchdog was already disabled in board/zyxel/nsa325/kwbimage.cfg.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 board/zyxel/nsa325/nsa325.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/board/zyxel/nsa325/nsa325.c b/board/zyxel/nsa325/nsa325.c
index 38340b33c8b..894c2ef293c 100644
--- a/board/zyxel/nsa325/nsa325.c
+++ b/board/zyxel/nsa325/nsa325.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2014-2023 Tony Dinh <mibodhi@gmail.com>
+ * Copyright (C) 2014-2025 Tony Dinh <mibodhi@gmail.com>
  *
  * Based on
  * Copyright (C) 2014  Jason Plum <jplum@archlinuxarm.org>
@@ -51,11 +51,10 @@ DECLARE_GLOBAL_DATA_PTR;
 #define HDD1_GREEN_LED		BIT(9)
 #define HDD1_RED_LED		BIT(10)
 #define HDD2_POWER		BIT(15)
-#define WATCHDOG_SIGNAL		BIT(14)
 
 #define NSA325_OE_HIGH		(~(COPY_GREEN_LED | COPY_RED_LED | \
-				   HDD1_GREEN_LED | HDD1_RED_LED | HDD2_POWER | WATCHDOG_SIGNAL))
-#define NSA325_VAL_HIGH		(WATCHDOG_SIGNAL | HDD2_POWER)
+				   HDD1_GREEN_LED | HDD1_RED_LED | HDD2_POWER))
+#define NSA325_VAL_HIGH		(HDD2_POWER)
 
 #define BTN_POWER				46
 #define BTN_RESET				36
-- 
2.47.3

base-commit: b2195f0e62292fdf36be6d8bdfc9efc23ae30c5c
branch: master
