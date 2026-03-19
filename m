Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D23E1091926
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 21:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1A1D84142;
	Thu, 19 Mar 2026 22:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z4u8/8Y6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ADAA8414E; Thu, 19 Mar 2026 22:37:00 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33DEA838FA
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 22:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d7ebe11bffso15048a34.0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773956216; x=1774561016; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1LOz6dcqUGLjD+7ULLRSZJ8BbKrFeZ1Q9h/Zq1ckGQ=;
 b=Z4u8/8Y6vUAt0iO7H6/QUQmN6ZCC6RA/WzyYjeHz2DSJFaFI0KKD/osQK7jGHo5TRT
 ul/vu2QjjTQvDkMq9VcG/H3vXDmctT315zUstfh6cTRKG5syQOQQVzc4gyO7EZ/ghHTP
 0roDjQOfSOO6BKzEVnVyCAxSO8sDGXpxpFesU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773956216; x=1774561016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y1LOz6dcqUGLjD+7ULLRSZJ8BbKrFeZ1Q9h/Zq1ckGQ=;
 b=a+ShszScrX+2OT7c3mT8Q+JCnIp9D8yE48As6uCglFasuXr8na28fluh+BNupjxej1
 sVp+b9JNshpfHB+Z7g3DIPKK7WVoeMd8qSIIhIy+Ut2etrKCHi7OyGRl3WZdvalI1FbF
 VueookcPg32fW4LdaB1iXiQk4lXYSVL3AtoUfh0Xgh94UNyBbq7F2vLBmwyiQaZhUMk8
 aQWvwMZ3rwrMhI/NWapB/X6UTbnjVixk4MluskZDrffujzxyNDlJ35isGGONosL5f5lv
 +StPC4l1Lu0citsr+e1SUFbeizFGLuviVBDFp5zyrT9MIjhGgKi6ktiGd33Y/Zb5C9kq
 hF8w==
X-Gm-Message-State: AOJu0Yw1cCYc2q3H72JqJ3dlj3NsvIu0G3QerVGQ2KfGZLzher9m67Ps
 0U0Kqkyvf1YNHqaKDe7v7xS0B1F2b7GyR6S1v9aNK3m2nQR2YOeGHfjWQzggboO4R4hSln7CqpF
 1CeOwXQ==
X-Gm-Gg: ATEYQzwGc1ikrwWtlbVotgmQRBaKeVIu2bsLTcFZDLql47Qdtu813Au56XJeggePj7f
 LQUsd46us5uWsWzR9qmIjPlJjMhCZMmFSY9UCbVtMBPfvAgGo6wiD/4nmBvU2xQZ76F94metvhX
 H5JBdzaeMhWljUJ/fRteY4HUlsL+o5wlIXxZURTBJOyHAOGtLwu7CLfcGn2lqUVgmeunm+pomqm
 MtmEFSBG+/HjzyyHBGaeqw6Yv1pXLmmRpq5wHorABhAx/fugsqkZtx6lZ3Aa0eMH2IY6/iKwGzL
 yGJfiXRm0xmSAgf/f6g8tlRttYtZAcA7llDb2wTKGfRwyHjONf7PYKV/A9sRlfpy2Qd3Hpq23Xe
 nX/oIhhCSDWEstfhXkLyK7CMz1h8vr4G7JBe8u35d6X0a18uRVkHuETz26Efvv0E3ODhBVOyhJ8
 Dg1tOi/CDhYmc30lJNHw==
X-Received: by 2002:a05:6830:4104:b0:7d7:570b:6800 with SMTP id
 46e09a7af769-7d7eafa2362mr469416a34.23.1773956216376; 
 Thu, 19 Mar 2026 14:36:56 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac17b0asm545724a34.9.2026.03.19.14.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 14:36:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 14/15] sysreset: Use device_get_uclass_ops() for adjunct
 support
Date: Thu, 19 Mar 2026 15:35:44 -0600
Message-ID: <20260319213551.267031-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319213551.267031-1-sjg@chromium.org>
References: <20260319213551.267031-1-sjg@chromium.org>
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

Update sysreset_get_ops() to use device_get_uclass_ops() instead of
directly accessing dev->driver->ops. This resolves the correct ops
pointer for both primary sysreset drivers and adjunct registrations.

When DM_UC_ADJUNCT is disabled, device_get_uclass_ops() maps to
device_get_ops() so there is no code-size cost.

Other uclass headers with a similar xxx_get_ops() macro can adopt the
same pattern to support adjuncts.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/sysreset.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/sysreset.h b/include/sysreset.h
index ff20abdeed3..108a7af7ca5 100644
--- a/include/sysreset.h
+++ b/include/sysreset.h
@@ -7,6 +7,8 @@
 #ifndef __SYSRESET_H
 #define __SYSRESET_H
 
+#include <linux/kconfig.h>
+
 struct udevice;
 
 /**
@@ -62,7 +64,12 @@ struct sysreset_ops {
 	int (*get_last)(struct udevice *dev);
 };
 
-#define sysreset_get_ops(dev)        ((struct sysreset_ops *)(dev)->driver->ops)
+#if CONFIG_IS_ENABLED(DM_UC_ADJUNCT)
+#define sysreset_get_ops(dev) \
+	((struct sysreset_ops *)device_get_uclass_ops(dev, UCLASS_SYSRESET))
+#else
+#define sysreset_get_ops(dev)	((struct sysreset_ops *)(dev)->driver->ops)
+#endif
 
 /**
  * sysreset_request() - request a sysreset
-- 
2.43.0

