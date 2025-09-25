Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3555CAC5B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91B4783542;
	Thu, 25 Sep 2025 22:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FiqvfkIs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F90F835B9; Thu, 25 Sep 2025 22:51:34 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07112833ED
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-74c7d98935eso729301a34.1
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758833491; x=1759438291; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=fZflg8jBqtnnhM7hqbKp9EeE+hyc1L8hBj1rlrKnpXM=;
 b=FiqvfkIszkYHVPdH1PcSLbJ3MD0zRjza4kPWiQGx5ZVuVIfd/nITgzC7f+S9YA0zTp
 6FMh5nI6hRLs9fbjUmDU+y/6OgsHfrSSzz6ILTJ506eoBgqKRFamtwcWOrMhEG6XTe/3
 MfF/rsch5SGljOtQIBOBe8V871pit2/3DxI1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758833491; x=1759438291;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fZflg8jBqtnnhM7hqbKp9EeE+hyc1L8hBj1rlrKnpXM=;
 b=jEdoBZd+AVhAItNnWvpycEcAGU6NH6KP06orecGC+5mOIxfO+iq+SOjxHiRVq4dvd8
 dt6SzBquIAEh1AzSLqiNL7UN3RksRZ0FrYVxuznJVGxX3Y5QaKxMLAL7NMJoC5LcJOd2
 QCtpQwxlicWVQtezHv97jwxEMMPTeYCyv3hWxTytQ52UXqNIEZOfX1owJBCQio41l+QZ
 kwfHByDBpZ9Xrv6Md0x+yeaD+Rh9EasAJ77AFgIfOk08eNQflSQ2QFL5z5cx0Q9kyHTi
 Ej0Z3LFx0ga3pcTFjGLZlFTkwgye6s7W87gfVax0s/zsKpJyYQqfmN42ZbKhKq6jrqQw
 MDzw==
X-Gm-Message-State: AOJu0YwUtepB6Gh6YA6OXqd+9hI9LV6CSF6JRvvdiGhmbAg1pn/yBJWU
 kRVumvBiRckhfZCtPAY3IXfXWVxdgmBPVqr5lIbMdvjmk9L6BotYDCvVMEhHTKE6yDR4ub78eRi
 MyDdiHPQ=
X-Gm-Gg: ASbGncuO0A1iIBvh5httKH6nwFusiJd+Oi3Aokrl5r2T+50aQ0YZNzSgWqj11rkUtjJ
 1iQSQy8lmVS14zC/Zcq4fvI4fDOSUln0IL7TdnXSuVsnsEk8FuS6qwA/3HNdtcPTzUeDR90tFZ8
 FwZYnTTLlaaecKP5iKaTas8z/U7al1enNcZ02uxlrmnTUOi1Iql6UhkQ2L0JyjJXpb1MtbHkeVX
 bq1IzgaztwBqirmsI0EqIgNBSx454ZkcR0JEd6uqiHiBMXSYFXQnn/w8V1cNDYmhL5C/OhfzTFT
 fK0WYB+91n7LBNiqr6Gyk3E1SWc7P88kVXEfw5TmisIu4vXJQs9b7wdq4Po35q6x66mJyF81JQv
 /WAY/76hVCQM6s4nxpsjL5sLjtSnT8fc87DEjjZdnElIjvA6u8dNsGdD5qqQE+6PPCfTdPg==
X-Google-Smtp-Source: AGHT+IEWqrSqLOpf1simpMCmDoJmCnZlU4srNRsQoYjGhVZuFyY4oTChZwD17tFErcE1OvgVRr4ltw==
X-Received: by 2002:a05:6830:369a:b0:795:6dfd:1094 with SMTP id
 46e09a7af769-7a04e8cae40mr2235448a34.31.1758833490778; 
 Thu, 25 Sep 2025 13:51:30 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a234b0a895sm613969a34.19.2025.09.25.13.51.29
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:51:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] sandbox: Add more dummy cache functions
Date: Thu, 25 Sep 2025 14:51:28 -0600
Message-ID: <20250925205128.3561934-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

In order for cmd/cache.c to link we need to add dummy icache functions
to mirror the dummy dcache functions as well as another dcache flush
function.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/sandbox/cpu/cpu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/sandbox/cpu/cpu.c b/arch/sandbox/cpu/cpu.c
index 6db8739e66bb..b8fabd07d0b3 100644
--- a/arch/sandbox/cpu/cpu.c
+++ b/arch/sandbox/cpu/cpu.c
@@ -335,6 +335,10 @@ int dcache_status(void)
 	return 1;
 }
 
+void flush_dcache_all(void)
+{
+}
+
 void flush_dcache_range(unsigned long start, unsigned long stop)
 {
 }
@@ -343,6 +347,19 @@ void invalidate_dcache_range(unsigned long start, unsigned long stop)
 {
 }
 
+void icache_enable(void)
+{
+}
+
+void icache_disable(void)
+{
+}
+
+int icache_status(void)
+{
+	return 1;
+}
+
 /**
  * setup_auto_tree() - Set up a basic device tree to allow sandbox to work
  *
-- 
2.43.0

