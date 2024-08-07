Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C82C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 19:55:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76D4A88D58;
	Wed,  7 Aug 2024 21:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qdo55iUM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6919F889D4; Wed,  7 Aug 2024 21:54:36 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54F1D88D73
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 21:54:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4266f3e0df8so1481775e9.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 12:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723060473; x=1723665273; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c7wvb87HMZERBTWLcE0Zw9te/52TrDk6pCneIGETCws=;
 b=Qdo55iUMLY+LW4qRnup0bNKSB/Vi03DTyXZMhx/36W0BG27D9u6F9iXvEcehKnC8Vp
 FDddhvSi23zfxRzUTQuVYOY9wwLVO0RNdc5zHKu2pcOrjeMCWXwywh8jBur69rsncEeY
 ylopcshDTlyoNWL2tjN8brVSYeKXhJkn9NYa3m8G5DEWkfUwiDwSX2nl+xiLK92CUdtJ
 djJ5MhEqiaiDP1fgjLT0ZaQ/nbteaILs6rdZ/gbZOmPvLuY51LAFiyTD7bdBTgguDCv9
 6Xy2fc9NSJmwEIeMQC/UaBj/ZQdkbQRSTGtzew2eQicRnFmk/+RLFnhwsS0SVgZ4XeR8
 d+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723060473; x=1723665273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c7wvb87HMZERBTWLcE0Zw9te/52TrDk6pCneIGETCws=;
 b=PNLylOkGXFetqtVNIYvh97uXNIoUh6hGJ6LHpQxYboeVYanPZBSRJdR83GX7U5q4mS
 YapgcEgik6w5LTMXzrpkpMIqgrIZtGgVHc5Mk4NHdIYLsMIQdjoDbiIaSfKttZFZnidZ
 diIzWM5qsTh3dH4YtmRTniZ2E77bFXJoJCCkZOGJSCZJH2eBLOGW9zwbv9hoVTVLMi83
 TLBJfFW82zlT5XZ1GFGZaG0Ztl4gHCNr7rp1+G+WBjU1T0sxPGXqjSxjMovDRmZF/dIW
 Fo7sNPBb9I+7h6RrcUXY7rkENjmtGLPtW9CSMMaTXSX2fYATzjXtPB/nR4oaBm0QJyQY
 PIwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/lmWJV7/LGN+JVD1Q9jI0GwLKCtAEG17LU8foOaO0n4R5YdEmKd0cTMwJsD0cDQOUHol+ESi+VXUkCxXi/FcARL9dOg==
X-Gm-Message-State: AOJu0YyHz37z5hLw9WL5cMlNhUxA6IC5A4swJv49LcBKSaMeO7MHaVJh
 Na+IQax+yP05Vd9wpXfZ3b0SYTw0YeVVt4NapApTcrFYcvy0ilc1
X-Google-Smtp-Source: AGHT+IFuN32Moz15ghAS3lV/R74VAVxfBWb7iC3I/FMeZTv85L8xs1Dlm+4mg4J70evVQVtB2MDomw==
X-Received: by 2002:a05:600c:3d8d:b0:426:6710:223c with SMTP id
 5b1f17b1804b1-428e6b03f2cmr134820975e9.9.1723060473137; 
 Wed, 07 Aug 2024 12:54:33 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-429057a8802sm44383765e9.21.2024.08.07.12.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 12:54:32 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
Subject: [PATCH v2 6/9] tftp: implement support for LED activity
Date: Wed,  7 Aug 2024 21:54:09 +0200
Message-ID: <20240807195413.30456-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807195413.30456-1-ansuelsmth@gmail.com>
References: <20240807195413.30456-1-ansuelsmth@gmail.com>
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

Implement support for LED activity. If the feature is enabled,
make the defined ACTIVITY LED to signal traffic.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 net/tftp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/tftp.c b/net/tftp.c
index 2e073183d5a..45c2455336a 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -10,6 +10,7 @@
 #include <efi_loader.h>
 #include <env.h>
 #include <image.h>
+#include <led.h>
 #include <lmb.h>
 #include <log.h>
 #include <mapmem.h>
@@ -192,6 +193,9 @@ static void new_transfer(void)
 #ifdef CONFIG_CMD_TFTPPUT
 	tftp_put_final_block_sent = 0;
 #endif
+#ifdef CONFIG_LED_ACTIVITY_ENABLE
+	led_activity_blink();
+#endif
 }
 
 #ifdef CONFIG_CMD_TFTPPUT
@@ -301,6 +305,9 @@ static void tftp_complete(void)
 			time_start * 1000, "/s");
 	}
 	puts("\ndone\n");
+#ifdef CONFIG_LED_ACTIVITY_ENABLE
+	led_activity_off();
+#endif
 	if (!tftp_put_active)
 		efi_set_bootdev("Net", "", tftp_filename,
 				map_sysmem(tftp_load_addr, 0),
-- 
2.45.2

