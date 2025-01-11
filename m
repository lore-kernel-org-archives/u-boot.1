Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20589E7719C
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E4E28060C;
	Sat, 11 Jan 2025 01:00:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h8CDmjY3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5EE7806C6; Sat, 11 Jan 2025 01:00:54 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71EB2800D0
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:00:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-844ef6275c5so84288339f.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553650; x=1737158450; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMfyaR6RJqBfD3er8C32Qdvs+olSMFXco2LY62vKR8Y=;
 b=h8CDmjY35yXIhiFYBvua1FdX1RdiD7fgEXWwesYH5kItMDXTyU2HZk1NZgSnkvPFrb
 n6kmn4BlLDZqNB1mkgfCb/3dMSGg9zivWrVT4YMWA7UENdkJSipCz5YJJYIysoC+e6i3
 I/u+ZAKcwikmCHm5lHrCinXnXsj1xJkL/xQTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553650; x=1737158450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XMfyaR6RJqBfD3er8C32Qdvs+olSMFXco2LY62vKR8Y=;
 b=nn7VZh5fNZGAgWuQMwOKMyz53+pPYJsfs5C+BSFOJl7o2+UPPW0Y/3MxssAMLejALN
 y7I9jKe2u/XsGtKz4jvDhao2HUUqJtHepVN7rF9BETv6O7sNsCYNyCW8SKerUjy4J8kd
 j3eDmu35XdsRq0ZkjypvFZsCxk1/A+xCxbC76tTU4AMP0xlLvDMbH/Sw1nP3qJWJexvr
 XShuWwSP7HRkxNL4Fv5BPEVUrumuegpVsDIy1AQLyy0wpub+rJ4DZLL6b+lBrVgtZEah
 tbDzwt6ihUML4h4QRd/GGdnoumAki76vNojk/P2leXndspN+xbN3wd+CpC9OjcwpcLMW
 T9bQ==
X-Gm-Message-State: AOJu0YyEOW97Q3LymyyMNaU9PX4wdcaDe2UOqq828JOquuZnwQWm+T0I
 rea4zPThpvNlm0x7Q4Q3BdeESt+QgFb0AZmHHZPk1ktViYNtalPtocp+OnNvTvVmCJYl7JbydiI
 =
X-Gm-Gg: ASbGncuHVUwZSmVReDW7c0I2ESkouHhN64X0apPJmPR/BLQT0SlGv95ZUyiQw1NwjSA
 fSvoNUzyzwFp5EuuCVQH2LsJK65n8hp3rM/ZAif52IkdisVafN1KY7ZIpYiAAbbDK2iHjSsTJ2X
 9diV9fr+cmRXznkOVubIZq8Tj1/bkqO/ZRl0+iyeMbmebvWijtPnuUP2BKbyNHtbCJWQ4GhZY9X
 xi6QxBYu7XPHm7hca3N9oW2O5n4c1ge335nthXcTLL2pLeyYexe0k5tWYCCtLwLDSF911MVALIg
 PhJtOkqashpHQ0BItQ==
X-Google-Smtp-Source: AGHT+IHyEcnPgW5ORH2s9HrWGSVaBBjPm5JOkVzGxoOOx1Uza5JNrjj6AF0JRXVwQTZxa0utM+bOrQ==
X-Received: by 2002:a05:6602:c86:b0:84a:4f3a:fa2a with SMTP id
 ca18e2360f4ac-84ce00536e7mr1124959239f.1.1736553650363; 
 Fri, 10 Jan 2025 16:00:50 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:00:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 03/30] abuf: Allow use in host tools
Date: Fri, 10 Jan 2025 17:00:02 -0700
Message-Id: <20250111000029.245022-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

Some header files included on the host are moving to use abuf, so adjust
the header-inclusion to bring in size_t correctly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/abuf.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/abuf.h b/include/abuf.h
index 76e314b9a47..de21cefade4 100644
--- a/include/abuf.h
+++ b/include/abuf.h
@@ -9,7 +9,11 @@
 #ifndef __ABUF_H
 #define __ABUF_H
 
+#ifdef USE_HOSTCC
+#include <sys/types.h>
+#else
 #include <linux/types.h>
+#endif
 
 /**
  * struct abuf - buffer that can be allocated and freed
-- 
2.34.1

