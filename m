Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0450CD7494F
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 00:34:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A3DB891CC;
	Wed, 30 Oct 2024 01:34:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tDUg39Ed";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45027891CC; Wed, 30 Oct 2024 01:34:10 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81C2B891BB
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 01:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9932aa108cso912486666b.2
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 17:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730248447; x=1730853247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b+wGRAfCHFhRyQ60sMdBaHSKF2tfaMtKsVoXB3auaRk=;
 b=tDUg39EdRchmlL/jvLz+7aJo+fgPJ1bcs21AkAMOFj39LFEIaFHBtnxGkIUqC5U3Nq
 XG3ZO+0Vs8NhfKG2VN9SM6xPe9OTFPPJ52aHS5dyEy1QsnuOHKk36MVorgfHs2eAFP8z
 dJgwujDfJOTeDixCwm+bLNAnOKCx/VNN84nZeqKbP8eB7RsbMTQvO0xUSyxc6LKIriNR
 gAgko2rHEM3YAPuBBfNu/QkROMVNr6QA9QWgTddi+WgSjL606SW8dvCqgDzp1ykdKkQx
 zwOTHeopB8Dt0hpbm7jG76LoVtSIBzW9wlumACpHhI0sdHQ3ZbCjAm4O4MbUzDGrXqtL
 vhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730248447; x=1730853247;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b+wGRAfCHFhRyQ60sMdBaHSKF2tfaMtKsVoXB3auaRk=;
 b=QYwcO9JJhn4+lXRq7yxA950YSVniVeDSEmC1fR/4JAUJb93Nwab/pRfoMUBk4p97PK
 RgjwLgomkW2SDmMy9bXBHDGWLYIVYDkkvopfFl8q1PXbVRRr3g0KI1fTpzRkqMikilDo
 zIGWBgJ1xwf8yuUCvq7hjs+wBvfM0ynbp6aTX6yef3zlswqvLueL1YuW+lcCAH0IgJb7
 j7mZfvG4JR4aXFKcqVviXm7ivuA77TDjIVN0IC/x+7wwx8kFzEHyObWVcU+DzNs8rkCh
 CnHRfp7i16pQkjD7OOAATPnsjn5YFXe036Ct/EDya+ld0KOL4zo6hMrec/eiDbS9Gum8
 YlCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP7/QOVdoXymuSsa5Bwv8YHu3rVhx1g9XA731ycxPNR48jadyzX5YwdyGSQVmpXOclvTToMZs=@lists.denx.de
X-Gm-Message-State: AOJu0YwTKNceCnLYXTIcQaixTnzna+eG+tAkOktElJ9Wk7NnU/Mqq6vO
 HfBd0RJPZ7O3cffENGUzi2yZcj+Pto+NeEzkHcDfHtBOaJx6dTEofhrOIfgIrhE=
X-Google-Smtp-Source: AGHT+IHNvm05/Pd+vd7Iw3Z3pVISOiubv2KtI5sgNedjWQCkCCW/nRazCEIsgYy0iyjh47f+oKwmFQ==
X-Received: by 2002:a17:907:2d87:b0:a99:ea2c:59d1 with SMTP id
 a640c23a62f3a-a9de5f0f9d8mr1273214366b.26.1730248446898; 
 Tue, 29 Oct 2024 17:34:06 -0700 (PDT)
Received: from lion.caleb.rex.connolly.tech
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b32455a14sm527361766b.178.2024.10.29.17.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 17:34:05 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <kettenis@openbsd.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
	u-boot@lists.denx.de
Subject: [PATCH] lib: uuid: fix 32-bit support
Date: Wed, 30 Oct 2024 01:32:55 +0100
Message-ID: <20241030003317.2901772-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.47.0
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

In 22c48a92cdce (lib: uuid: supporting building as part of host tools),
some instances of simple_strtoull() were accidentally replaced with
strtoul() instead (spot the difference!).

To keep compatibility with building as part of host tools, re-implement
this via a new hextoull macro to handle both cases.

Fixes: 22c48a92cdce (lib: uuid: supporting building as part of host tools)
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
Reported-by: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
---
I've build-tested this but don't have the hardware set up to easily test.
---
 lib/uuid.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/uuid.c b/lib/uuid.c
index c6a27b7d044d..59f07a9a5834 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -34,8 +34,11 @@
 
 #ifdef USE_HOSTCC
 /* polyfill hextoul to avoid pulling in strto.c */
 #define hextoul(cp, endp) strtoul(cp, endp, 16)
+#define hextoull(cp, endp) strtoull(cp, endp, 16)
+#else
+#define hextoull(cp, endp) simple_strtoull(cp, endp, 16)
 #endif
 
 int uuid_str_valid(const char *uuid)
 {
@@ -289,9 +292,9 @@ int uuid_str_to_bin(const char *uuid_str, unsigned char *uuid_bin,
 		return -EINVAL;
 	}
 
 	if (str_format == UUID_STR_FORMAT_STD) {
-		tmp32 = cpu_to_be32(hextoul(uuid_str, NULL));
+		tmp32 = cpu_to_be32(hextoull(uuid_str, NULL));
 		memcpy(uuid_bin, &tmp32, 4);
 
 		tmp16 = cpu_to_be16(hextoul(uuid_str + 9, NULL));
 		memcpy(uuid_bin + 4, &tmp16, 2);
@@ -326,9 +329,9 @@ int uuid_str_to_le_bin(const char *uuid_str, unsigned char *uuid_bin)
 
 	if (!uuid_str_valid(uuid_str) || !uuid_bin)
 		return -EINVAL;
 
-	tmp32 = cpu_to_le32(hextoul(uuid_str, NULL));
+	tmp32 = cpu_to_le32(hextoull(uuid_str, NULL));
 	memcpy(uuid_bin, &tmp32, 4);
 
 	tmp16 = cpu_to_le16(hextoul(uuid_str + 9, NULL));
 	memcpy(uuid_bin + 4, &tmp16, 2);
-- 
2.47.0

