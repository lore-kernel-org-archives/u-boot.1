Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1330BC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:13:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 312888141D;
	Thu,  6 Mar 2025 17:06:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eEwb6web";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9507681761; Thu,  6 Mar 2025 17:06:15 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F315381335
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:06:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3ce868498d3so2618295ab.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277171; x=1741881971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gy4PnU4eNP1M48v0FBfuALibXDChaUG2OjKS5qLKdZU=;
 b=eEwb6webPfbvY+7DiBsjpCxIg2FMxaWJgB6VQeobThjTFZblgXP4I6Z4tpSdGMMibI
 +wOZZG7OndWC0LOK9K1Yr5gfu5eTSwz5Rq8zxO5Sb1IXhkT6J4hlTNck1twyntAlbg4U
 vVKqnfj4IcwHdJORSdAyp7c98HhS3NMM8hZfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277171; x=1741881971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gy4PnU4eNP1M48v0FBfuALibXDChaUG2OjKS5qLKdZU=;
 b=M08Sja7cRY2872JVS/kB/tI8FTYsJMHmnWkstkEr+WQBbupmQQoUqOA+FiDyWZvJK7
 lUyLuf/ZVYGp2CXvL7tsqXswZidEuwkfo/KBXqDilFI09gaEa5rOxu5NPMXWExuoIg2M
 4QHOInKRV1NE7ifxAASzuuFzdWO/7X1J5LDgHHCJ5eFnWkSeDhtJveiHNuBIvykn7/VG
 J1ywuyzvX9xm+DCEc/vbzQlZquCMBSshjLBFZpac1jWH/NaqD3EcS3QJHbmRbWaTcvux
 I0e2XF9PTC1oAWQxFapZGwLXfTwQDoesmkV9AHARJQHKQnfWLLIVsNoCGRsVTArBgXYk
 LBig==
X-Gm-Message-State: AOJu0Yzw0AtPIWZ6ihJeX0qiea13B90aLAWKAPbhv7M84yL4BLfV5M7d
 c1YJYkGMLMdo7FhQLFYC3guFzcKkpDs/6lg4XI9jssPbHohT4qkXfXGsCYof0QaWQVdZIbWtYfk
 =
X-Gm-Gg: ASbGncuyk0NTcDfz8oqJ1fCxCMaCz6YuS6xkBhI/qDIfrZEvofZakkjnmBXWPxyyU4/
 s5FSikEDj5cEatDqU33s/awHztpxgu6FTZ0M6IyIO2ewhV7MVf52BUL6x05fCQTqEwgTqoqwuPF
 wneJBkD9i8Oqg7i5+17tiG9/boVKAZS6A065j/cIw3DyO8DnDupYRll9JQySQqTq5IO7y5VJTN2
 EjK4NSzbc2Aodno148qQsywaU7jWpgwUWVjH9ahOwMZ78m/6kKHIzD6hzv4Ba+6alvidgeuvF1D
 eQ28W8lRKUUyPYgZUtw9oZT7qARztIuOIuQGE6ThF0IBlE/RHhcdtRYJpTKby9sPO5IlRWYfljR
 5KXMT4w==
X-Google-Smtp-Source: AGHT+IHGDf7WOZOffQU7hZBdAPyux5HsfAUAJaCtV8pwd/SzcAm4zK36Spa9D9B9HpVi39EhdTdWWQ==
X-Received: by 2002:a92:ca0b:0:b0:3d3:ff5c:287 with SMTP id
 e9e14a558f8ab-3d44196fe0bmr291445ab.14.1741277171045; 
 Thu, 06 Mar 2025 08:06:11 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:06:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 39/47] boot: Handle running out of labels
Date: Thu,  6 Mar 2025 09:04:06 -0700
Message-ID: <20250306160428.3041057-40-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

If only a single label is provided in the list, bootdev_next_label()
does not operate correctly and reads beyond the end of the pointer list.

Fix this by adding a new check. Also add a note to convert this array
to an alist

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to handle running out of labels

 boot/bootdev-uclass.c | 3 +++
 include/bootstd.h     | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 9e4c3db2dc1..3791ebfcb42 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -579,6 +579,9 @@ int bootdev_next_label(struct bootflow_iter *iter, struct udevice **devp,
 	struct udevice *dev;
 
 	log_debug("next\n");
+	if (iter->cur_label >= 0 && !iter->labels[iter->cur_label])
+		return log_msg_ret("fil", -ENODEV);
+
 	for (dev = NULL; !dev && iter->labels[++iter->cur_label];) {
 		const char *label = iter->labels[iter->cur_label];
 		int ret;
diff --git a/include/bootstd.h b/include/bootstd.h
index c39058c0787..ac3c1922fcc 100644
--- a/include/bootstd.h
+++ b/include/bootstd.h
@@ -24,6 +24,9 @@ struct udevice;
  * This is attached to the (only) bootstd device, so there is only one instance
  * of this struct. It provides overall information about bootdevs and bootflows.
  *
+ * TODO(sjg@chromium.org): Convert prefixes, bootdev_order and env_order to use
+ *	alist
+ *
  * @prefixes: NULL-terminated list of prefixes to use for bootflow filenames,
  *	e.g. "/", "/boot/"; NULL if none
  * @bootdev_order: Order to use for bootdevs (or NULL if none), with each item
-- 
2.43.0

