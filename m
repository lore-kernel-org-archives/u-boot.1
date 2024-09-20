Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E0ACF9C69
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 02:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47A148891B;
	Sat, 21 Sep 2024 04:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GQ3ghK+U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B06F187E30; Sat, 21 Sep 2024 00:52:06 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9BF78785E
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 00:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cbb08a1a5so22578855e9.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726872723; x=1727477523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3z42g+gFzdLZFSr9JS0gJsU8ZEGF1SU5Wl47Lcqd0lQ=;
 b=GQ3ghK+UkjjSK+JczDOF373x2/LhQ2RptrC5tjVJumyYPKdLTWjF54rGqKZ7v8sw8I
 6RK6QUID5piRRt+XED4kFUCsDZLez41/fk2xDNOQmnoITei1oxerLHFK2frnX4kyAVYS
 LjxRLXRZud8YC4NjlpkkCvxGHYFTFHZmBXZ/uK7pFDBe5Xriry+rqoLMkprCPXT9NbHL
 gTofEp+ejxwSAUT/ii5pdqsBWy5igKOLvuFPt/iw5XMs38eg1v+PRSMTVPUraztwiUKZ
 t4KpjeVVslc0SWrCmb5QbLMq/rV+9DpilKC/lunP+/DoNCOtTSkukRSoRaS1XoriRpM3
 ev4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726872723; x=1727477523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3z42g+gFzdLZFSr9JS0gJsU8ZEGF1SU5Wl47Lcqd0lQ=;
 b=vwS7t6/RyJd0Eu3RKfleeGNz2lbd3VLthLA1By19t1pxt1LwRrxPXaxBmdJcfwFy+C
 XkVmnJQmed5F20GpLsXqRI+pc+ogK5nHY6rMPXWZGMclThU8GCDNKSU0X+JNmkPVuP5a
 tVJJUEreLULzJCgqQCyfa0KnLU3dt3MOsMmyO5qRUGstSLpGnkEM3VLvN6fiJJPgiIfl
 VH324yiKeRMQwn+bOqR6pPhd/wCfpOJSzqbCLsyjXXnBWsKglEfPAvVOeM2NDjKftD47
 OkJN9hb0vPtS4nlktuf7bH4Be732wq7MXeeteOJvcS+5usbGpJi8glH2RoP7z9ntHveJ
 1D6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+CzLuA1ln1nHeNhVKRpupqyKylTkjOG2/uQ1M6WgVJc9Kqb9gs8nCWJ+BYbIAu2Ta/eRmOP4=@lists.denx.de
X-Gm-Message-State: AOJu0YxmPMcyix3G9+EFPauqCJN8BwR/Qlqj4XwKL8cPJZNz0CKJIDfA
 kdwJ0Xc+/ydS790lbVcWvEuCTNftgtd4+xOctMMw6dH4RG1jb0a8
X-Google-Smtp-Source: AGHT+IEVFmRpG4o+qwxm1Bc0Gn3Nvyloyx5pm1wsgNByBukZ1XAD2k41eIeyUm8Elt6x3rlxgMx5hA==
X-Received: by 2002:a5d:4f0a:0:b0:371:8f32:557e with SMTP id
 ffacd0b85a97d-37a4235a22dmr2647327f8f.39.1726872723175; 
 Fri, 20 Sep 2024 15:52:03 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-378e73e837csm18850516f8f.27.2024.09.20.15.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 15:52:01 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sean Anderson <seanga2@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: [PATCH v4 08/11] ubi: implement support for LED activity
Date: Sat, 21 Sep 2024 00:50:01 +0200
Message-ID: <20240920225101.2008-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240920225101.2008-1-ansuelsmth@gmail.com>
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Sep 2024 04:37:11 +0200
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
make the defined ACTIVITY LED to signal ubi write operation.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 cmd/ubi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 0e62e449327..56d7da82629 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -14,6 +14,7 @@
 #include <command.h>
 #include <env.h>
 #include <exports.h>
+#include <led.h>
 #include <malloc.h>
 #include <memalign.h>
 #include <mtd.h>
@@ -488,10 +489,18 @@ exit:
 
 int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t size)
 {
+	int ret;
+
+	led_activity_blink();
+
 	if (!offset)
-		return ubi_volume_begin_write(volume, buf, size, size);
+		ret = ubi_volume_begin_write(volume, buf, size, size);
+	else
+		ret = ubi_volume_offset_write(volume, buf, offset, size);
 
-	return ubi_volume_offset_write(volume, buf, offset, size);
+	led_activity_off();
+
+	return ret;
 }
 
 int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size)
-- 
2.45.2

