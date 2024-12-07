Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56EEE7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 17:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B40AA88FB4;
	Sat,  7 Dec 2024 18:26:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MLDciX23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28228893D1; Sat,  7 Dec 2024 18:26:20 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAA0D89442
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 18:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-84198253281so203054139f.0
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 09:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733592374; x=1734197174; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eeeo3LTMEVCfjxPdDZS28oi5ekOzg9BHJWxs4WVPUYg=;
 b=MLDciX23klDc9i4PRujjcU9w9iXgp8mtd6iJ97smkNx+6x+50UOEtUw+R/wcFjDgOT
 fU7Dvh4rk5cFyas9j+fA1CFNbkSbTzcH1pxYMdNv2UyqhgGbxCTyioFsEAC079Fm+x1J
 Bl5MnPSfH01rP27HUEo30Qou+39sdfq3xE9EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733592374; x=1734197174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eeeo3LTMEVCfjxPdDZS28oi5ekOzg9BHJWxs4WVPUYg=;
 b=Rp76H3IRmtrS3PQ+dvcvTa0JNPIe4hBl7ltODih/iSNxN4AFBqDlIFnYhR6/AVfLwo
 3eacutAlks8owx8MlGsi/bgm+kRtRoGUjY0sYw6/mqRXU2XtH6+whfdoHmNNKnhTSAvY
 kOwjvW+xIc7XkEhkjAhoXaqipYyM0/2MzwzoOeG0yuwF0sSrm7eqoSxKQtS5kwU2JlB3
 20daHiay7cBLV+Vz7QwNmNaDBZ2zdB062PENthp3jnVwO9lI4rDN/XDAKU/XGMCoTq5/
 r2BPvxkISGwPN6ikZo4CfeAy0UuUPhsyd6mBVErhAuqxVSVPdvXV37FmQvlZiVEsKOJc
 8Jkw==
X-Gm-Message-State: AOJu0Yz5JgtxiVShJMAs+okFHoSVQttcqm+/dm+zmbB582q7TWjDVX/o
 dUC8ay11u7OOl19w2zgcDeyEi7NZiscJckmyUXUgVj8Vgd8GAXxL5OfI+hdsAeBdMq0DTyvK/BA
 =
X-Gm-Gg: ASbGncsePhoyXA3VS1OTOA5pTZhadnKdeIEc9I7zoQ19D/eS6bNlJHezEhS1lJKt/NJ
 +A6OuTGznD0lEc8/CAghxWtWEoHKTDfvJppKo08RCxGj5wBfslCcoTkCXYdZ9nSzRn0pyOlxC+j
 QvxR/P6GpiJA1+qKGttywrQWcSxcYRNOq7YzDE5l7mgDxzVpqGeT7ZZcK/8OM4iiryxvQnTuWNj
 dDDL71Q8Al7n+/hYLDTqWiviyXeI3hfTz17TDyt+PJCMIJ3ASnTaSh0PckUUWLmHUujU0R5OBw4
 YPNzg24Rlf4=
X-Google-Smtp-Source: AGHT+IGSGZVxYuoq5MIXasSwS80c1DdTh76bTFHOiNnHYV4/jcxAIwfe49SdWR9rJyP2rpfDjsXRZQ==
X-Received: by 2002:a05:6602:640d:b0:843:ea96:f707 with SMTP id
 ca18e2360f4ac-8447e23ad98mr678143139f.8.1733592374720; 
 Sat, 07 Dec 2024 09:26:14 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a7080csm171745739f.45.2024.12.07.09.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 09:26:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 06/19] malloc: Show amount of used space when memory runs
 out
Date: Sat,  7 Dec 2024 10:23:59 -0700
Message-Id: <20241207172412.1124558-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241207172412.1124558-1-sjg@chromium.org>
References: <20241207172412.1124558-1-sjg@chromium.org>
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

Show a bit more information when malloc() space is exhausted and
debugging is enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add field names into the message

 common/malloc_simple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/malloc_simple.c b/common/malloc_simple.c
index 5a8ec538f8f..f0f90a095bd 100644
--- a/common/malloc_simple.c
+++ b/common/malloc_simple.c
@@ -26,7 +26,8 @@ static void *alloc_simple(size_t bytes, int align)
 	log_debug("size=%lx, ptr=%lx, limit=%x: ", (ulong)bytes, new_ptr,
 		  gd->malloc_limit);
 	if (new_ptr > gd->malloc_limit) {
-		log_err("alloc space exhausted\n");
+		log_err("alloc space exhausted ptr %lx limit %x\n", new_ptr,
+			gd->malloc_limit);
 		return NULL;
 	}
 
-- 
2.34.1

