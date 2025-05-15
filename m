Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED71C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA60582B32;
	Fri, 16 May 2025 01:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="saiHDSXc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EC2A8129F; Fri, 16 May 2025 01:42:18 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD6C682A1C
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-72bc3987a05so1260768a34.1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352534; x=1747957334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pa+g3O0/jMm2Npbyqlk/WwLRvqRG0QtJlm5my21Qj+o=;
 b=saiHDSXclQKLzqEbH8c/9EAEqMR0hlh0teOG3VMqo4//VG02ySwy2tjPcn04+j+aj2
 +/Dz2IGcU6yH/200Ap5Ag80oKPojIlP/tZhYG/SFVoFs6qvgn2SyeqifiP7E2HRzonoN
 XNcBn/UhyYLf3xWHf1KBeGUGE1s9L989LIDmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352534; x=1747957334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pa+g3O0/jMm2Npbyqlk/WwLRvqRG0QtJlm5my21Qj+o=;
 b=BcSj3+gMZVrnzfqycatbdkD0uAYljBB/cfGDGmx3FCoQbKSvAXsL7r+Z4SwN3rgdjd
 Wk3ablcTgoPdfEXHchLj4prqqh+HaMOIRrJk2XMQzu4xIgeKU3AK6LS5oxEVC6BOOb/U
 t84ocdmP1N3QjpL4Kc6iq4DjL0ALgGPpgA0HJSX18PF5miUjfSyLNfhkkhwSH5MIT1O2
 UtRdGRx7cy+gR/MzKXJb0cCYYFHbBl93i8bEcyg2iIEkrCPaHie1b89MeyVUmaa/uump
 xNsCZTy44hF0NJsF/SkEiMadW2hwFiXGVxlklpVaxpoKnJIBpMzsSLp3s5G2JnoOnVHq
 2NBA==
X-Gm-Message-State: AOJu0YyZbANgfaPq+YZH+TzSW9/5mrWdyK6c2a+uOrogTNSrqE0AtgqX
 62NS+Jz+1q+BaCPRo+yx0gkyI8/NHr117eJnTt3uXTVsftXzR9xdJN5c0OAbwGJu8k8cy9B16D3
 C7qjcUho=
X-Gm-Gg: ASbGncvFXSibMXvsHNTNhT6RalDox31uIkv7Tbbm/gVVS+LN/sutqc/kh+1c2tjUW/7
 WRDbeFwRQm+sSFqHqYSH8eQWud2H08L6rsZc41RlCh0SVNSXQfybMpeR2cBw7s2CY5y2UPI12TA
 9OrkJGQ3w02lSp+HW1UuRIOXVKy/FRF/MnZb6OVPPKrJ81ovCSTHWK4p/f9fTbFyRhUApxURV6A
 G1ekgene6+aLR26CPhr9EeGakpwHcDWAhbWuDR9uGWHpuDgf33ZgAufa+LMGX4KylHTPUlw6AFM
 LMmhQ4HJLmFHLAuxMEHbDcaOyqutba1Rnh1EvIfXkpUuPwmR30E8jPn94MzDFC9FpsjRYPK+sjY
 7fSh7VmWYn+85xVhFp+HMygwIfg==
X-Google-Smtp-Source: AGHT+IGd5j7SVSWt26Lpe8w6C3o1UH5fUFNCHFXkaGjtIM/3T4JHNFxJjV3xgn3IH7qraFOl15nbZg==
X-Received: by 2002:a05:6830:3981:b0:72b:9422:aec with SMTP id
 46e09a7af769-734f6e0ec00mr946914a34.8.1747352534471; 
 Thu, 15 May 2025 16:42:14 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Viacheslav Bocharov <adeep@lexina.in>
Subject: [PATCH v3 13/22] amlogic: Include env.h to permit reading the
 environment
Date: Thu, 15 May 2025 17:31:42 -0600
Message-ID: <20250515234154.1859366-14-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515234154.1859366-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

This file reads from the environment but does not include the correct
header. Update it.

Reviewed-by: Viacheslav Bocharov <adeep@lexina.in>
Signed-off-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
- None
---
 board/amlogic/jethub-j100/jethub-j100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/amlogic/jethub-j100/jethub-j100.c b/board/amlogic/jethub-j100/jethub-j100.c
index b770a1f8c537..9e87fb9f9d73 100644
--- a/board/amlogic/jethub-j100/jethub-j100.c
+++ b/board/amlogic/jethub-j100/jethub-j100.c
@@ -5,6 +5,7 @@
  */
 
 #include <dm.h>
+#include <env.h>
 #include <init.h>
 #include <net.h>
 #include <asm/io.h>
-- 
2.43.0

