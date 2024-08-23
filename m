Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9183C5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 20:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B921788C72;
	Fri, 23 Aug 2024 22:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aw4j1VVI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 834A388C72; Fri, 23 Aug 2024 22:48:43 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68E8D88BB8
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-81fd925287eso81655439f.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 13:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724446120; x=1725050920; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CanB/Gvo8puF3XkUGNW8QcP2kttXCr7Cr53gforT/YU=;
 b=aw4j1VVIUoQgoWMPpwUDakg36M4JaupCSlDNp5ziAG80YGocGRYeKurbEC4HSId5Nv
 L2w3SQnIDDiTdreiAZ0Z+rKdG+uy7vksdyHrvdbQIhGWGa28SUVbdpYTnyhDrSmIqtjZ
 JLUyOzuRKjFJ5BoBhyg3VQAGEvANd31Rnl+NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724446120; x=1725050920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CanB/Gvo8puF3XkUGNW8QcP2kttXCr7Cr53gforT/YU=;
 b=cgPgoz+foFrAGJynUks/NBBEstvu66oSi84MHFe3k1/M962cYtGY7ranYaOTr+P4gS
 +LmkS9XllTP+3W3KRZrsJlPn/pkD7oeemTO8SMFhtMCmXlqTwmxzOUnp+3hogQ8WWgIP
 doy46zX9+RbplwfVNshVDj9Bi40jdhzebpaXj8Xz/nYofNzjqz7gJwts3hfjrUskcLB0
 mwY+19FTAIw0EdNWqok9PsS7jZgAZlAEYyTGpCbOLlnxUsCSg1emZsYQIlHn7hkpC+Ro
 eeO2cJvcrnyYewcT5DPhj9m531bCtvIwN8ULocRx5MiSVsZ93u8J+TDFa+wacGuui1LL
 jsmw==
X-Gm-Message-State: AOJu0YwBIa+d+eQej3wshbiX9QeIvuowx50pn6eOM2V8+F9wEdSSWnHy
 bzr1qwCb6MuYbm7986/roqnCa0Al+B/squ1i5ip8k8cCQfW1FpEs6bG/8Tf+Qt4nrtQ5r7c+M4k
 =
X-Google-Smtp-Source: AGHT+IHjh0ZZlY2gZIKBjK586JS7fRd5CDU8lcqMcu3CyVaH075C2PwjsRgN0b9KN++yig6L3kdvvg==
X-Received: by 2002:a05:6e02:1947:b0:39b:4ec2:c5c1 with SMTP id
 e9e14a558f8ab-39e3c9c06a6mr32066455ab.18.1724446120094; 
 Fri, 23 Aug 2024 13:48:40 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e67addsm15698375ab.4.2024.08.23.13.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 13:48:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Nam Cao <namcao@linutronix.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v2 2/8] bootstd: Avoid calling unavailable block functions
Date: Fri, 23 Aug 2024 14:48:18 -0600
Message-Id: <20240823204824.443631-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823204824.443631-1-sjg@chromium.org>
References: <20240823204824.443631-1-sjg@chromium.org>
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

When BLK is not enabled but BOOTSTD is, some features of standard boot
become unavailable. Add a check for this in the only site that is
currently apparent.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootdev-uclass.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 7c7bba088c9..e10be2baa30 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -434,6 +434,9 @@ int bootdev_find_by_label(const char *label, struct udevice **devp,
 	struct uclass *uc;
 	enum uclass_id id;
 
+	if (!CONFIG_IS_ENABLED(BLK))
+		return -ENOSYS;
+
 	ret = label_to_uclass(label, &seq, &method_flags);
 	if (ret < 0)
 		return log_msg_ret("uc", ret);
-- 
2.34.1

