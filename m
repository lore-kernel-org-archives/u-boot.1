Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A18C02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3BA080B9E;
	Fri,  7 Feb 2025 19:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Td/4QE1k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7925D80AE1; Fri,  7 Feb 2025 19:31:57 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C45080819
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-84ceaf2667aso158856739f.3
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953113; x=1739557913; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmB8xHYzQ+0fEAsZ2gk5zKjvVZ/pvzqDen7KeTnzCpU=;
 b=Td/4QE1kc76w/ze8u96hiTCa+oopXYl/bd2qSNwatx3PmvoDtc7wfM8ahq1AkMhlKM
 TCkmOTb+tI/oU0jwa5IjmGIPzRMbiZ0HuZlHsDjSmwhFG9pgjxkxN4SqIYG8znhJXJhE
 wE/LxAiCt3bBLmcu9WCWU4OMEkmJ85pMolL/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953113; x=1739557913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bmB8xHYzQ+0fEAsZ2gk5zKjvVZ/pvzqDen7KeTnzCpU=;
 b=WWweJSvM3gvh5Oa6TM2E79ZcOMzL/7nIg1AvRzzfKsKqFW0KUEkwdWrD3GmdnULdZ+
 xTeim3d8il1/6PwFNUd5CVN9MuB+4pcYHbRGC+iim8XGVx4QrfBBSD0Wu5cbeUzQRvMt
 WWMnZFAOmFDpS3IC8cDj4krRc9y+FKmNF+VP7aOXsrPQWLgObVFalnmtz8DweaQPZkff
 dqLBBT/+TKrooj1S4xnORIkX0CX+9Luwa+G660Lrh2oCH4PpwJOCY70ntONWO9EtoNRh
 rddIsJvo/f4fSlIbBCfdXIP7yPlfCPV7hITN9oobzrSjBCIOpYaipfOiXn1uzOULC0NU
 SHBA==
X-Gm-Message-State: AOJu0YydrRvIU2HHZBBdoDcXlI+pIE3NP8pahwoHZkJ6A3W9GvqIGCvA
 sWtYCqlCxAGC/9Es1ghdm7uLgArEP5EbSOuSMu9IlS+TvOgDG15gSS3Eej5cjglJqliBGhQ8FNw
 =
X-Gm-Gg: ASbGnctzWN6r3yqZ5gAaOWoz5GkKwLUimeDnD+9JyS+W0fA2HcT3s0Sz4Obzw80024S
 SK02zkGxeYHsCSgNn6CLNf5wNmHROGezkgGt+AotRoXxwA4oqqNdBKfQrwilWxsLvWgobas7g3V
 ugrDVvDQP143t85HNHyWeXYB2VIrYSmVFr/cCp5v4UjH0v8YI5bKPQdCe0KutljmxrWgpg2x8m2
 53K/7Nsnx3JB6b2fnAwG32faRk4bJ5bQjIhBeUVyKKiXk5s0X88MiH29YAin5o5Sl0V9rg7DNrN
 3kebO9zp+Ay0cQBx7/e5oX6+Hr5xqNvENRp2oxo5T8V6AeR3QIo1
X-Google-Smtp-Source: AGHT+IGi7hrunGI9GUAiYtSCtYNEc8dWgcGriDFrEAUDIQ8Epz+y9SNT2EOaRFWGkajo4RAZz6lW/g==
X-Received: by 2002:a05:6602:4017:b0:841:8d66:8aea with SMTP id
 ca18e2360f4ac-854fd88ad87mr474802539f.2.1738953113541; 
 Fri, 07 Feb 2025 10:31:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:31:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 11/29] test: Move fdt-overlay-test rule into test/
Date: Fri,  7 Feb 2025 11:30:42 -0700
Message-ID: <20250207183121.117663-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
References: <20250207183121.117663-1-sjg@chromium.org>
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

The Makefile rules for tests should be within test/Makefile so move the
'fdt-overlay' rule over.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 Makefile      | 1 -
 test/Makefile | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e0f58cccd00..6fa233030b3 100644
--- a/Makefile
+++ b/Makefile
@@ -893,7 +893,6 @@ ifdef CONFIG_POST
 libs-y += post/
 endif
 libs-$(CONFIG_$(PHASE_)UNIT_TEST) += test/
-libs-$(CONFIG_UT_FDT_OVERLAY) += test/fdt_overlay/
 
 libs-y += $(if $(wildcard $(srctree)/board/$(BOARDDIR)/Makefile),board/$(BOARDDIR)/)
 
diff --git a/test/Makefile b/test/Makefile
index 5ef8c379cb2..99d4797d968 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -21,6 +21,7 @@ ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += boot/
 obj-$(CONFIG_UNIT_TEST) += common/
 obj-$(CONFIG_UT_ENV) += env/
+obj-$(CONFIG_UT_FDT_OVERLAY) += fdt_overlay/
 obj-y += log/
 else
 obj-$(CONFIG_SPL_UT_LOAD) += image/
-- 
2.43.0

