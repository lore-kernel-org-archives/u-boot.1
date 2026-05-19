Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F00CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 18:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45AA38488A;
	Tue, 19 May 2026 20:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m72ObeZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E99284852; Tue, 19 May 2026 20:29:03 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25EEA8486A
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 20:29:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dca4debedaso4145980a34.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779215339; x=1779820139; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BLhKZPYnZALMOvmYUJDT+bSAY/pbeCHf3zGNkjaIQFg=;
 b=m72ObeZVNsDPKNklFmh7HE4XCBeM44Yuq2tE7lBXfsc5NaDR6vkdZ5xAnyUJlLmMjy
 y2ZnD0J2v8jmEvjJu/ilvDoaqaiwHOPbY85EQDVhLU9dGSKt5K27IH3fqeBcBrvYxJPm
 rX6bmV3RPNc8I4VAguxQJlbAYmh1cLCz+/2W0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779215339; x=1779820139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BLhKZPYnZALMOvmYUJDT+bSAY/pbeCHf3zGNkjaIQFg=;
 b=auo49M+lWkhfNHW9n71ArHiZ/3rWmrw0iZdBilWqIXBu10187k2vApljQTsmoI2wQi
 /cahmBN3kPgpydrgfoAqIx6OAOe6A//+iw/3drOAH8yuci+KF6vC0BktCnzJ1sayku5O
 89DZmaREYLK/S70MGjnbVmJw8EkypEdjthBAh+tDcT7J9AfA0Um6MvNiQsR/5DwQ+z/9
 Tex9hn5KQhse/yoCIRsZl+oTaijICmDOm9tBJkIFaEM/QjU++HKxmt86NPk8G5rItYE+
 1y/rwaOZ4abXlrsP0aCyez/fMZgRPkeRwYXj6tF5Z9evo0sQApwZYkUMFILU/63tE4Bm
 oWXw==
X-Gm-Message-State: AOJu0YwBqKh66tFNfhwaPdhNbO/BEbxfAthEAAjakhLexr6c7CKZgpbZ
 9tnPq2UMdq2rTqe6WMaMQBkvuvUm3Ed+SsbnT7SYi7TiGclykz+kd9jfAzqkYfXkEmfMhmG92qX
 pTljomI3918+b
X-Gm-Gg: Acq92OFYMQygpzSc0ZsO9PA86fw6TYcr1LPTIJIaKs8aUzS4WbMDhYUNuR1RujZ7O6Q
 p7G9+Iwh4gRISz+vepiC7DShKpfIs9Cd9CBtvpnCVT5/KvEpLlGCHgf5hBtbJ5NcLFp9MzY6Neq
 Puw1obaRGpKNa8TROs/s7wf/zpdHPlEQJ3XqrvctRMOVhurBqx6dYOhbRFqisTMOqSrM0GJkCU+
 /Fdhtmu5Y8irz65J3u/drWhuVV7vq6KtLUkZEZIz8slL4bOygYAd/joVwCpV8KwbsRIy9Jbxwj4
 yRcyrtDS2GiwjWHughnXYq13C2rQI3V7dB+Gi6ynshovsYxLw4MWKAbjf9W9Fx/7bBmn76S/PN9
 ABsxTzazaZF26Ay7mQQFjdskVD0XU/fX87DZ6fals+PerrJ+khabELliF0s1U+KWm7KV9TyPNwp
 EcDbxNbvAwzQa1+RGX+8WQk4zu4y7Ui00+IMyIYiE2j68w4XH/6ofKHHPMJ9HSgVhtKMY5xFcWv
 3/3uVHj3hsDKvU17XwrExnu3smz+eMa6FqM7qDhBI5P+sOlim37XQknDTK5R4H+8Mj1s0NIy2g=
X-Received: by 2002:a4a:ee07:0:b0:694:914f:c18f with SMTP id
 006d021491bc7-69c94294299mr12297589eaf.3.1779215338897; 
 Tue, 19 May 2026 11:28:58 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d046130cbsm7851379eaf.5.2026.05.19.11.28.58
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 11:28:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/2] event: Guard more of the prototypes with an EVENT check
Date: Tue, 19 May 2026 12:28:56 -0600
Message-ID: <20260519182856.865924-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519182856.865924-1-trini@konsulko.com>
References: <20260519182856.865924-1-trini@konsulko.com>
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

To make sure we cannot encounter the case where code is written to use
the event framework, but EVENT is not enabled, guard most of the header
with a build-time check. This will promote the case in question to a
build time failure and not a runtime debug issue.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/event.h b/include/event.h
index 3ce5f992b04e..71fb14391f25 100644
--- a/include/event.h
+++ b/include/event.h
@@ -308,6 +308,7 @@ static inline const char *event_spy_id(struct evspy_info *spy)
 #endif
 }
 
+#ifdef CONFIG_EVENT
 /*
  * It seems that LTO will drop list entries if it decides they are not used,
  * although the conditions that cause this are unclear.
@@ -348,6 +349,7 @@ static inline const char *event_spy_id(struct evspy_info *spy)
 	__used ll_entry_declare(struct evspy_info_simple, \
 		_type ## _3_ ## _func, \
 		evspy_info) = _ESPY_REC_SIMPLE(_type, _func)
+#endif
 
 /**
  * event_register - register a new spy
-- 
2.43.0

