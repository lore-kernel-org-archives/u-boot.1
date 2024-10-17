Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98255D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:24:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F4D68912F;
	Fri, 18 Oct 2024 01:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i/1xMPbm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45C1B890D0; Fri, 18 Oct 2024 01:24:40 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21732890C1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-83a9be2c0e6so64264739f.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207477; x=1729812277; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8j5B/bVfr7fDqACj3VYwPsRW6dIrJdHJdj9+e1e4UO8=;
 b=i/1xMPbmLfuHSgks8G4O8ERNGoWKH5TA+olFsaUJ+WCc9AFLiHdldCInpqvkA+pO3b
 WfazGvXlicsIvSB5dv5UtP/4kEOGCc/qLECgnfGH2H2Z4lhu0KgbiM8xLuYXCP0JyXAe
 0wYIEHMxTU+cZ8s+SfglsTudRGw7JMtKdzFik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207477; x=1729812277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8j5B/bVfr7fDqACj3VYwPsRW6dIrJdHJdj9+e1e4UO8=;
 b=APbblQMcQ0taK/Cd/eyfXjxENzGPyCuGGay3Iucg+AP7iIK0oBZ18704BmGTurPGrh
 eEFWG2UTX5leU9EAh66c2xh8kuCG15x17AaSmCVFSg3xDqHXaigNBp9J9YTKLT5mHmMo
 hQu/HelDVlLZdAzuQQpTBLLysmHpcY/ZY1A3qJrD4+/L7J86BpWgIPlay8mN8HiOrwBK
 XViebyJM5s8SWOR6Ut5udmioIKQez9BMJp62HnJQ2F2GHe4M5JjjYdiaJJdXld1HtZJv
 finFaJW2xVGUnlAXHHh2+NRPNMkCZZhAmrgz7I88LwGWnJrEaKQTpJ8omUOzi2dJkLqm
 PKvg==
X-Gm-Message-State: AOJu0Yzr/0Ly5ymBJ1n3QYiGeUGsW768QdciqWpNqh0p7O+hf3C2F4yF
 spDCs6xyhSuPb8MDPvNo9WpLP9EHVX0JYiTOEDPNOgeRpo8anOa5TrBdBdlX+v0Ebnj1tzH63ns
 =
X-Google-Smtp-Source: AGHT+IGHWtGRoQgO7Fb8Y0GqGjPzTGdJy0CoIhFgAzX3Dp3yW3aN2a0nZGfLsUESt1ShAZDCohGpDg==
X-Received: by 2002:a05:6e02:1fe7:b0:39d:2939:3076 with SMTP id
 e9e14a558f8ab-3a3f40b1593mr3572605ab.25.1729207476694; 
 Thu, 17 Oct 2024 16:24:36 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:24:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 01/34] alist: Mention the error condition in
 alist_add_placeholder()
Date: Thu, 17 Oct 2024 17:23:40 -0600
Message-Id: <20241017232413.724808-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

Update the function comment to note that this function can return NULL
if it runs out of memory.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/alist.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/alist.h b/include/alist.h
index 68d268f01af..0343946bc4a 100644
--- a/include/alist.h
+++ b/include/alist.h
@@ -151,8 +151,9 @@ void *alist_ensure_ptr(struct alist *lst, uint index);
  * alist_add_placeholder() - Add a new item to the end of the list
  *
  * @lst: alist to add to
- * Return: Pointer to the newly added position. Note that this is not inited so
- * the caller must copy the requested struct to the returned pointer
+ * Return: Pointer to the newly added position, or NULL if out of memory. Note
+ * that this is not inited so the caller must copy the requested struct to the
+ * returned pointer
  */
 void *alist_add_placeholder(struct alist *lst);
 
-- 
2.34.1

