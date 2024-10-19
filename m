Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D975D3C916
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AE6F88EAD;
	Sat, 19 Oct 2024 17:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hMam5euM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD05E88E8C; Sat, 19 Oct 2024 17:22:31 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C598587D1A
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-8377fd760b0so125383239f.2
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351348; x=1729956148; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=atBda3d1Dymyob+sIUziu47HQROuujsZQq24eFbO6HY=;
 b=hMam5euMMJduj/rQ6cRTGCZ2MoK0Ib9RXr1nMA0+WbryJ4NTg/u0z75DQmFoWF5WSy
 k7UZZwQETTgJzwEE5c55a/W5GonQzxYYc9d6zHP2paRLKaS3pgRtc3Yw1YmxeL98A5vE
 j45Hjw+Nw7lDpw1qgKjMLKWxQbq2/E5X37hW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351348; x=1729956148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=atBda3d1Dymyob+sIUziu47HQROuujsZQq24eFbO6HY=;
 b=uSKFgFCssGbX7nFSd5ywwDjpFWwKU3dF9DQ5Rn2TvM9B9yhkOh52q5idR4xVuEJbGT
 9m+syKm0WZ4to3gohZ0xA26DD+iTqXj5es61MCR9hWY7Z2sjSajkZ1NUoWnOoZNG8kx7
 54Es1Oml65APr1VM1axqJjKtn1rIotPJDcGoNfTq1thRyFAF6U3buFE6Wi8UBm+URrnb
 f3HjupJPLOFySUCmYwjEHKgff0Il4pfypXDG1kcvzbHXPZyaISWQqzGjg9cK7nMB2pgN
 LknvpkY6Rf4XsWSZFAwP/dcy1V6W3qpeS+8KwCn4EHOvZZKb0tmclScvvYiwjkVnXnk/
 NcEQ==
X-Gm-Message-State: AOJu0Yy1FFh4yJFROL4KEeYQbi+Int7b2djHSzCRGx4VYe7Zm+F+zBou
 wzq6eZXblqg+9ed2ikQUggg1FHwVxrHzoDEigRsSroZzu118CNBWZ3S/l6QYxWrpIjI6OA1TUqk
 =
X-Google-Smtp-Source: AGHT+IG0QHCuYovkNcxQcvnhVTncfz8knls1Nfm67J9cxoja9B+KvBr8D8Yjy0dtk+Pkd8OUg/oKNg==
X-Received: by 2002:a05:6602:2dc8:b0:838:9b6:46a3 with SMTP id
 ca18e2360f4ac-83aba6727c6mr480443539f.15.1729351348440; 
 Sat, 19 Oct 2024 08:22:28 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 01/31] alist: Mention the error condition in
 alist_add_placeholder()
Date: Sat, 19 Oct 2024 09:21:41 -0600
Message-Id: <20241019152211.1014896-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
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

(no changes since v1)

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

