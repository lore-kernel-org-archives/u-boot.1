Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CACCF6BE1
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 00:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B25384027;
	Wed,  7 Jan 2026 01:32:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iZLZQOxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 432EB84033; Wed,  7 Jan 2026 01:32:37 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E9C83A26
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 01:32:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-455749af2e1so163901b6e.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 16:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767745953; x=1768350753; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JBtkBZIloMjC/5f7RZQ1gCQMbukFamoHpgfGdYPTejk=;
 b=iZLZQOxC6c8ixlr1vSDmX8C0JaACFI4GMR2KwqzB9mIU0MSo09WQUJJ9ihfNMUNAAy
 ySjN3LiAUu7oxabBZYAjO6QDL+6cfnTFuISzspVtRq45RWR6NncJjUiExMtgPpEKXCqB
 8Gq4wSYkYajJsR6EmUyYHh9Fk7xQq2f6LSgPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767745953; x=1768350753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JBtkBZIloMjC/5f7RZQ1gCQMbukFamoHpgfGdYPTejk=;
 b=Ej/Rk+UQKnc8LqCQMe3LOuOCdcYYc08aa7bmTqtMrIkI5NGv7LL5tZS7gRlYKOexza
 8k+va9Z8Jq8rwAIQc2+ogKefZ0GCmyeMkI6CoYIoc7kbU/amKmzAHVBFMx/gbTn3DADk
 1PxEmm4rCxsNjkmnSqEdZjRrWHJZkvd8fMLWxJPVgWL8OlZqXAqLu0qLR0C15JUn41qz
 Swvx4oieHGJcu+m84SiCbdsnBskmSFNH0XSlR7/6P1M6DhqcLZPNQDUwu7K7gWokQujN
 dfTh5uPLaOO43rKmAiZiyiz9gdLzSUtkFaKVwPPbb3JAE9w3p15/baaoY4fu0jvYzXEn
 GZ2g==
X-Gm-Message-State: AOJu0Yzu4v5hEgWCZo8pmzcfUuqF3q294+d82u7kOE4J2FU2eBt2fynr
 MJQEX4310IIIJEiNs2ZLl7UbUYQaXy2YsEIEBxYaipRfOvhfru2oBLX88UM8q+uln3zmHAh+l1M
 kKi4=
X-Gm-Gg: AY/fxX6OuKvFpK5p6D2NQ4QZBmDaYid8+/LxtMhRHeXM2esdC5dH5uxPJYy/bXRGq5o
 OhHhMlxDY874Ob84zhT/bJsAXqk4BZ2kkEu82t69ZZYTt51wxMYCLTOj5SoGQu3WGDrphjjwppD
 EmBxDtGWGe0DFemO5tmQTgv7fCsQ2wnS1ZwKSJe9MAlXo9BnohAL3LCt5YiLTUTU8b7FbtOIY94
 QfTQWWbcpAhKulyfWjjXp4ZS4wp3Mttr09AdEJutc1Oqv/chdndKtOARwznjiZbnBMrwOWcnq++
 EMrTdcCFVaygv4A6Fyq0dDmUabQiuonhdPiXnt57Lo8NBlMCYeNSgHEMKAlM1Hr+BQ2vV4bf0WN
 MmQZ1nehw1tDlWLTBnnF4/+j29cxdDxpgD7vzCAywQwBXmtD0r5JGeEbMrxUyYbGy+Ij3SJE1vB
 z0v2ez7PsWu1O+B/KPeBPdu8s6AMs=
X-Google-Smtp-Source: AGHT+IGs8yQuX1cL1O35sKwuB6T02rjVCgiilfH5iaiKsjqJJGmEDLSudqJ59k66jyz7lTbx/6h69g==
X-Received: by 2002:a05:6820:4903:b0:65d:38e:40f2 with SMTP id
 006d021491bc7-65f545b30dfmr380876eaf.2.1767745952952; 
 Tue, 06 Jan 2026 16:32:32 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48ab2d00sm1631458eaf.0.2026.01.06.16.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 16:32:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Simon Glass <simon.glass@canonical.com>,
 Aristo Chen <jj251510319013@gmail.com>
Subject: [PATCH 04/10] bootstage: Add some missing dummy functions
Date: Tue,  6 Jan 2026 17:31:21 -0700
Message-ID: <20260107003131.3064800-5-simon.glass@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107003131.3064800-1-simon.glass@canonical.com>
References: <20260107003131.3064800-1-simon.glass@canonical.com>
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

Neither bootstage_fdt_add_report() nor bootstage_report() has a dummy
double for when bootstage is disabled. Add them.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 include/bootstage.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/bootstage.h b/include/bootstage.h
index 528d0ca0614..62fb99110f0 100644
--- a/include/bootstage.h
+++ b/include/bootstage.h
@@ -435,6 +435,14 @@ static inline uint32_t bootstage_accum(enum bootstage_id id)
 	return 0;
 }
 
+static inline void bootstage_report(void)
+{
+}
+
+static inline void bootstage_fdt_add_report(void)
+{
+}
+
 static inline int bootstage_stash(void *base, int size)
 {
 	return 0;	/* Pretend to succeed */
-- 
2.43.0

