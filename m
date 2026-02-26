Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3728EFD9E1E
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 706AE83E81;
	Fri, 27 Feb 2026 00:01:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fSkptx2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F75983D1A; Thu, 26 Feb 2026 22:05:22 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A83E283642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 22:05:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5a1046f62d0so1430811e87.1
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 13:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772139920; x=1772744720; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s8Zs0Gh0Wn6Ugwpz24Kq8wR5rWC4YzeuifZ6QZF8pcU=;
 b=fSkptx2HWQEKr6YlLDbIGf/M/aXflFP4MneETF1wG393TNXeivTKeGugpD/3FGpDfz
 rz5gyQP+yhN45NPFKsZjJaXW8Lu+5JrrAcBHR2s3yIWQmptwRjnCkSl7mVjV59pdIt2+
 o7NBHn0ie4mv6WanJcrsYjX2K9eYPeML8lCBdwJajsZmCkjw4XxWap0D4QDQLgl6gtq6
 BagtvVqYnF0dkXoITbm+Mb3VySXQpftapkvHT1xZ1MfK5owuVfitcmwwnW+pR/oq+XWP
 LDZeMfUNbJYiN02WwfBxMVY5cCQZ7WcDhN7S7IUgRRJMkeQOa/gZR9xzJSiT0C/Htaaq
 iFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772139920; x=1772744720;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s8Zs0Gh0Wn6Ugwpz24Kq8wR5rWC4YzeuifZ6QZF8pcU=;
 b=veZp7YspugOs/Kh2yFpX5rW6i4F3sQ3pi4mB59e7eJsZ1xTsyy3wJTY8/v26W2Xx5m
 fdtf3rUp8kIccrUZIINxGrLriuP03oakoYhJ7dsVPHyH3T6FB3zT/0Szq/Wgv1s1oBBj
 yhX+BTP6ZDve06X8eUiFfpyCSIFs8sRJB/Bb6FdogI73O9xCyJHBPsVm2Id6MJF87xNO
 QXrjSStNnICq058pYohaqLFDA6DltsOGKnuL/GIS9BvxPipywyJplCXKIzNM6NJ35rMY
 WpYtovQAJnE6TJoRKfwInZy6Lq9Y3aR/bbz3sPJcNM/irDcqbMS0a5EQ2skukfBp3Mb5
 cfeQ==
X-Gm-Message-State: AOJu0YyZe2zIQTq0iDfyBaj9KgKllMTzIT3nyXG24zusbCA+adManWc0
 bq707dYSSUEkSzaYI4yGFDOqBJkpm2cg9nA4O8iADb7fHFwxjKtGUVActSUqmq7wzHM=
X-Gm-Gg: ATEYQzwIPw9W+/wiJBkjaymmnZ/fQKMnjt7MlAdX8zsUFmIhv2B2/JyQYyN0o1W1b6y
 QPnZmQ+YKEsr0NcHWcM2hIEprCvGTuxqd3NiS2BGr5NkJj/i2o5XFFkDvuEn2BMrJNcttaQMO+4
 thTNYs/PqBHkaxdGDOggaJMmTlKvtfI07G0o3x26a+hrP4GJi74btAXOkLSZho7KXhRnYJs0Qbv
 blGg/scCNerBojsNCjf/bQ+IAvxq3E2EMVv8hRExOJBEdNq4V63x8pEm/7dOh9hzY1HqSBuvIGB
 d9Lo20URnTeBiGk75b26S1xSaHax1D2tWDl873YHq/WBQA5qCllDGp+hfsDaFOwckkZ4c8lAr4c
 cYUyjnfEa/PPTypZ/Fb1kAO1WYt7SH4KBvED6CZOq9RpNIHXFVxPe/KM+qSy7IQHWtsrjmCk+d4
 m+GW4H8mAQbj5sreNbDQlxckPnD2XtIsixhskhcR6y6xOkdLUC8EDxm0yye86/SZcNSSy/q5NSe
 BqdUY9ZauI4wQxNa8/Mf2fxNpsLK+i2nTwoESyCCOKdvvhh
X-Received: by 2002:ac2:4c45:0:b0:5a1:2ea:985a with SMTP id
 2adb3069b0e04-5a10ffa22a5mr195948e87.21.1772139919553; 
 Thu, 26 Feb 2026 13:05:19 -0800 (PST)
Received: from lnb0tqzjk.rasu.local (46-138-124-225.dynamic.spd-mgts.ru.
 [46.138.124.225]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a109e0193esm1333892e87.48.2026.02.26.13.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 13:05:18 -0800 (PST)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: u-boot@lists.denx.de
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] kconfig: fix buffer overflow in conf_get_default_confname()
Date: Fri, 27 Feb 2026 00:05:13 +0300
Message-Id: <20260226210513.58593-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Feb 2026 00:01:16 +0100
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

Use snprintf() instead of sprintf() when building the full config path
to prevent potential buffer overflow.

The function previously used sprintf() to concatenate SRCTREE environment
variable with the expanded config name into a fixed-size buffer
fullname[PATH_MAX+1]. Since getenv() can return arbitrarily long strings,
this could lead to writing beyond the buffer boundary (CWE-120).

Changes:
- Replace sprintf() with snprintf() with proper size checking
- Add validation of snprintf() return value to detect truncation
- Emit conf_warning() if the resulting path exceeds PATH_MAX
- Return the unprefixed name as fallback on error, preserving behavior

This fixes the static analyzer warning:
  confdata.c:119: buffer overflow via getenv() tainted input

Reported-by: static analyzer Svace
Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 scripts/kconfig/confdata.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index d587b10d7f8..756e613fa47 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -152,7 +152,11 @@ char *conf_get_default_confname(void)
 	name = expand_string(conf_defname);
 	env = getenv(SRCTREE);
 	if (env) {
-		sprintf(fullname, "%s/%s", env, name);
+		int ret = snprintf(fullname, sizeof(fullname), "%s/%s", env, name);
+		if (ret < 0 || ret >= (int)sizeof(fullname)) {
+			conf_warning("configuration path too long");
+			return name;
+		}
 		if (is_present(fullname))
 			return fullname;
 	}
-- 
2.39.2

