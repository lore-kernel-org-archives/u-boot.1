Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED2BC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 03:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BBB08703A;
	Mon, 13 Nov 2023 04:00:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lDEwVGQI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C47286EE0; Mon, 13 Nov 2023 04:00:11 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F70F869CA
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 04:00:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7a6774da682so172642639f.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 19:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699844406; x=1700449206; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ESKY6UFRlZP2fiWiVM7oHOllUkZ37sGeduFwm5TEuWI=;
 b=lDEwVGQIKcL/XXQmmIQc6lYtLmhavVLgi8lZxzbq4s7CVesi+sG1no/mFKtyHs02fB
 ep1mM4cqx7Dr/52hkYygbXdsJc7VkGLLanWkPbBsnKNz+yYKgYnp9itk0gCxXM20bwnO
 69tqVMFWPv31skJCFFO6nEewqKyuhJuNRvcxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699844406; x=1700449206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ESKY6UFRlZP2fiWiVM7oHOllUkZ37sGeduFwm5TEuWI=;
 b=FRDNtWbe+WBBYkoppI73f95/JEvEtlsdYgwzum0TorDWCkkr/wOYSehnJZdNY9LvC4
 nXq9n34iASZguJsbpooBW/hXLqnlSCcZNTjMb0cefZAR/LHFCUw/CUBG4NjR8reXeV+G
 VCF0sgnPSjJetIrLh8NblUinqexM4RnvGFDeSWrT6iDgzZGj80O9BJE8/NbEsGYwG1WR
 Ir0JPcTo+yoTa+BSXaqO7mX0+V92NrCYBrmBmL8FunPFeLh8hMGnDwi5FZYSz+9Cb42G
 5kiRBwMxJtqm7nBIhpDBfvx45YlwqvGOHv0rsqLnwGvzmS2oZx6p1/Z75c7MHEP2Z9bg
 abCw==
X-Gm-Message-State: AOJu0YyPA2On3Hivutp4ei6ZxRE3N977Ki6FqApdL2eSjeaBlmH0Di7V
 ZtGxZgdi65Z43pjfQgCNnqR6DSp5oKc5EJf5excaBA==
X-Google-Smtp-Source: AGHT+IHYmgY/m43qa6fwFkyfYnzoLP1Z1xaEdTgva0RDWH8xcgqsP02bb68SW83DFhdNozTcFwhwPQ==
X-Received: by 2002:a05:6e02:b2a:b0:359:4e76:fbf4 with SMTP id
 e10-20020a056e020b2a00b003594e76fbf4mr8596600ilu.13.1699844406630; 
 Sun, 12 Nov 2023 19:00:06 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a92cf50000000b0035134215863sm1350914ilr.55.2023.11.12.19.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 19:00:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Artur Rojek <artur@conclusive.pl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/9] board: Move show_board_info() comment to header file
Date: Sun, 12 Nov 2023 19:58:21 -0700
Message-ID: <20231113030001.240020-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231113030001.240020-1-sjg@chromium.org>
References: <20231113030001.240020-1-sjg@chromium.org>
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

Move this comment to its prototype and tidy it up a bit.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/board_info.c |  6 ------
 include/init.h      | 11 +++++++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/common/board_info.c b/common/board_info.c
index e0f2d9392204..3185793da4a7 100644
--- a/common/board_info.c
+++ b/common/board_info.c
@@ -15,12 +15,6 @@ int __weak checkboard(void)
 	return 0;
 }
 
-/*
- * Check sysinfo for board information. Failing that if the root node of the DTB
- * has a "model" property, show it.
- *
- * Then call checkboard().
- */
 int __weak show_board_info(void)
 {
 	if (IS_ENABLED(CONFIG_OF_CONTROL)) {
diff --git a/include/init.h b/include/init.h
index d57a24fd00dd..9a1951d10a01 100644
--- a/include/init.h
+++ b/include/init.h
@@ -292,6 +292,17 @@ int misc_init_r(void);
 
 /* common/board_info.c */
 int checkboard(void);
+
+/**
+ * show_board_info() - Show board information
+ *
+ * Check sysinfo for board information. Failing that if the root node of the DTB
+ * has a "model" property, show it.
+ *
+ * Then call checkboard().
+ *
+ * Return 0 if OK, -ve on error
+ */
 int show_board_info(void);
 
 /**
-- 
2.42.0.869.gea05f2083d-goog

