Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73BEF513ED
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 02:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A467B839A8;
	Fri,  6 Mar 2026 03:37:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZXLEqIEe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18BC483F9A; Fri,  6 Mar 2026 03:37:10 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3258583F7F
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 03:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-899f27df3d1so53976056d6.3
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 18:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772764625; x=1773369425; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kKNlHAvq0fH+RnE8ScxM867wu/lcJq29quv+zhG9gQY=;
 b=ZXLEqIEes3NE03mGuVBuqDFxm8/PjTa+QaTC3fR1s19aZnvvxmT+7BYoH/VXryloU0
 xVNJefwAcqlfd5g/VxEan+KJl/arztOIToCuVG1rmejm5boElMuZBjayJQ3sCSYgctR8
 rMjFhu6nTY2ugRLQyYUArGmZXunst1jo+bjV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772764625; x=1773369425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kKNlHAvq0fH+RnE8ScxM867wu/lcJq29quv+zhG9gQY=;
 b=LOuagVnx6xaz+AJrkhI3mb22ZH+rnpvp0YK7gCBXv8iSLwsXOzluWdE0v9KtyHyb5i
 dSI89K5eV6HbfLWXWByPCEl+GhotzpzBZeL56L5SuP1mfPjBgSXl9Nl14cS60Z1/1Ra3
 GUpy3W4DQxyfhrQv6i58lnkQEUvaqqjq0t9wNty82Me05gHeT+7UbZZ/BpkaGq40Sg+B
 zBqzNoWjTwgTBTvkMi+AvDN/fVMNxQVUxH8dIiHGSL74Ptp49OA/tSag7WmPAHnfWOkl
 m36+sYZ77JnwQqzD15DO3jnm8ELd09/UWntG3+LWWzG1pijf+tLo0tEZ73+lCrzFC1s/
 x7vA==
X-Gm-Message-State: AOJu0YyHowX7Mb31rravmGwnNz8o9ZvvbrjmJxcbTfBkuCzapIoCZtx6
 m+5yjAIZvjqvCXVIxlUqabRBlC52A9vcXBfgYb0sjwvS+yDpxcXHLGfzmg1V4HtDYh7D8Ujr+1z
 ISE0=
X-Gm-Gg: ATEYQzw5F+ijLoTqCLZkSbgmG0EMdEJjfC26X1SxA9pQ9GsHQTi/1dErRnX+tA66DaX
 YvzaLBq8fcaKRNO0D+1QIfpFPNhCXfFxYyxQ/dGMhT0/VKkw6bHtWS+9KgHMiXgcRBTA8hK3ZA1
 GRRUYN/V0HO7KV+pw3YjH4memrZDrOp+ufKP+IfG9gZmnQCtslR61ukTrOCoOocroDtw1LVSOD2
 rNL8cWXpZ0sgqPtGUz3IHmGnhjMnmqGCHd/ZrXe/K30Ur5THvRV1scqaED4iXNL51AG4VBtD4e0
 Cjy+n5a06tXpa6GkNR/nwfLghbELTB+V8TEufwLG2b/JheRaQnF9xSjGy/b6KbvzWX0VB8lOAU+
 y8C4rqJOHTvpqr/xqLtLVcqHKdnzlcLnZeKUluzXJnnbaiuvWv7q/Zveqaa/XeqlyAvO3xthJqA
 YTOtF2Fxx7wtw9/P0Rp30yLwQqQoio
X-Received: by 2002:a05:6214:d0d:b0:89a:8be:9d3c with SMTP id
 6a1803df08f44-89a30a340d4mr6538996d6.16.1772764625539; 
 Thu, 05 Mar 2026 18:37:05 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a316e8eb2sm1063436d6.35.2026.03.05.18.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 18:37:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Aristo Chen <jj251510319013@gmail.com>
Subject: [PATCH v4 03/17] bootstage: Add some missing dummy functions
Date: Thu,  5 Mar 2026 19:36:12 -0700
Message-ID: <20260306023638.2678886-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306023638.2678886-1-sjg@chromium.org>
References: <20260306023638.2678886-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Neither bootstage_fdt_add_report() nor bootstage_report() has a dummy
double for when bootstage is disabled. Add them.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v3)

Changes in v3:
- Move earlier in the series so bootm_final() can use bootstage from the start

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

