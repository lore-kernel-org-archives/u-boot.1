Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A570CE7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:22:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CFB786E45;
	Tue, 26 Sep 2023 16:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SjFvRYLP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32ADB86DF0; Tue, 26 Sep 2023 16:16:15 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC93F86E41
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-34961362f67so27308835ab.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737763; x=1696342563; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sb7bBWAiDNoaqdOtKTmuTaynVR7GHKOEwpPsieeGxKY=;
 b=SjFvRYLP+r223Pyd6+GLHdNDWQCxEB343+9HBQOu56wtoTQy34Kd3f+WU57OZW2ydh
 jIwdhCokn+ThvAmVFk6+Zar/TXB01x1sbEG0doyGuj9zFov9M7Icla3SM3acx0FfC5VC
 uGQvSCF2D3srpyccZw8dFb69Wkb8/R+Bi0+dU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737763; x=1696342563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sb7bBWAiDNoaqdOtKTmuTaynVR7GHKOEwpPsieeGxKY=;
 b=Dn76i4GVKiFdlwki/OaJyCdvceqP2w4EJ4cfCM7gnhyXK3mvqw9nwF07axjio4UTmN
 iA9wmYdr0Ze+SZT2GptsD2yNvq1kHm1gEz64BrX5MuhYs2TMNv5iU/IsLbXOb9n9D9qJ
 W+A+bEREL887BhaI5/C/d6sr5byi5M0bqiWJ8W6TSWFuk3dpk8coAA55lLu/1cLpgiQK
 q+ZsmrlwP/QzKtOq15XA6PSM6CVUpUpIDSVSt88UAlXiB5/jMu0MZTAGqEsLLelFxKG4
 ATwdRU7xAIHqg+IJ0V+YFW2olAKjbenEs/y03OoAMCHB4iccOw5PGxPd50ckAv11jhaa
 PLnA==
X-Gm-Message-State: AOJu0Yxe1DJbxKt+jV9ZXloOYEB9b1Lg5WbJuepFR0QorAFkelCgWgSM
 ZuVwHK7vmd7zL75wfLUUvMAipZLlXocoei7se9o=
X-Google-Smtp-Source: AGHT+IFzkh+wUcYKh2Ly5i8XWam9kz13x0DiAH/j7PRjtZN/TIvzD7wxcV8TPl0HV3XHKKGVIy0Izw==
X-Received: by 2002:a05:6e02:170d:b0:34c:b4b5:765 with SMTP id
 u13-20020a056e02170d00b0034cb4b50765mr2980774ill.5.1695737763119; 
 Tue, 26 Sep 2023 07:16:03 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:16:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 40/44] command: Include a required header in command.h
Date: Tue, 26 Sep 2023 08:14:54 -0600
Message-ID: <20230926141514.2101787-41-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

This uses ARRAY_SIZE() but does not include the header file which declares
it. Fix this, so that command.h can be included without common.h

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/command.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/command.h b/include/command.h
index ae7bb4a30b05..8aebf7a95bf8 100644
--- a/include/command.h
+++ b/include/command.h
@@ -15,6 +15,9 @@
 
 #include <linux/compiler_attributes.h>
 
+/* For ARRAY_SIZE() */
+#include <linux/kernel.h>
+
 #ifndef NULL
 #define NULL	0
 #endif
-- 
2.42.0.515.g380fc7ccd1-goog

