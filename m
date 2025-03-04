Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7981FC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:34:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FD0E81658;
	Tue,  4 Mar 2025 16:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mwsRpaAO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF1EE80F56; Tue,  4 Mar 2025 16:32:13 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E28C8141E
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43bc30adad5so15212475e9.1
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741102295; x=1741707095; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/tQpAU9Ufu4oscV00uBWRYXlYx78X3scV+Lb4K1pCw=;
 b=mwsRpaAOkgDH8ZyXdV4+5tbNnfQPJgNpBhLhh5cB3gXJHdQPZCYmjSU/qYbCgtMM/A
 b6rFDoD4y4HmttE0to5OUJKXrWrvsoA/UlcLPh6+11po1jiRM2v1+eTGbpPCBoHGnSE9
 U0NvCTF60ciEYSm9PqpqVJ7x4Nw3aGMJednIE4BZVx20D3kN5vvn7FCMkdluXIXSsAOG
 nipOLUhojmvy49Fs5u/6kztJo0sNuqdOCmrYtIPJzspLY7arqy7XoYkqKV5ruJ4nlaZz
 Vtui1rx0j3fKWfp/qnf49Xquy28F54sYVBISH8JrQlP17SCCMk2wRpkPXjJ8tpu8+ZPK
 HLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102295; x=1741707095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W/tQpAU9Ufu4oscV00uBWRYXlYx78X3scV+Lb4K1pCw=;
 b=Xd37z5scK0LOcs329ylj2RzByJHVGzL/3IjTfUysymlT7CAl2PNqUZBs4rojs7at96
 vj/wRZ2IET9HugH83Hek1ZmFiPYl1XsZpJCH9fK/llgvsajIwOBFVL+Z36wi9aZKUwxR
 L59DE02EMvGxDpnnUjU30xvzLJalTdToprBJDwgddOW84wqtIU94T0NP7/9atyAs5f0y
 L2Gqwtx2lUWsD5smIF1V5gVy+eo0L1ALKxrrhXCDn0DXoOZH0ppi8Cvm9AtdnVYc+Sdc
 kp4RHMCzKEznkx3TNaeOVt9GluBCAicu7Xq+Ozyy2smELS+kjaWbivDcsMjEZIDSqJkV
 kl3Q==
X-Gm-Message-State: AOJu0Yyn63dH16BkGk463svK/9h6+rYB3kKAxjkwAn5pLfn8X7QhIC2m
 6gNo536DKpltu1aAgxf5LujeeW4fPwJn1abp59F+ebs2rA0bTw2BVVweDFdKyXMaG1gxMA7xCc5
 x
X-Gm-Gg: ASbGnctBiLTtFreWCNcOx++h7QiLb7CezgcMk2J8heULJ9tdqkkGdLeMdtW5yRrsRlf
 ir+Tr2eQMPHHf8T+OeBW+CQdc09mYVdQHpQDz6FfRJJPJjbZc2X263s34Opx30r23dZ2FSlDRiD
 PV5oVtHXXDNbnOD+pug3CUEjbhzRZoqfzn6WR11TvgqEShC3oShigroE+Zw55plr5d9jqEbeHmN
 ao7A68qUv53QHUen4WdwdFQAG5tb0m91hzYcH8ZeO/2PWR070tNG1QmTWJEPY+C/pj+XW25KXUv
 Bg2i1cB69vKe1WqDozg2UVaf0faklBKdJ9XcXWjiJoIOYpcyLGbuxw==
X-Google-Smtp-Source: AGHT+IFFfWg0tvpiiOuCIYpvfTfL5ulxjIkPniKuOxJfzXppfi7kfDnquyFu2ykc8n43y2RZy9d89g==
X-Received: by 2002:a05:600c:5127:b0:43b:c965:954d with SMTP id
 5b1f17b1804b1-43bc96595cdmr37986635e9.1.1741102295016; 
 Tue, 04 Mar 2025 07:31:35 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:771e:3d0f:d9c9:2f92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485db82sm17669254f8f.88.2025.03.04.07.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 07:31:34 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v3 07/14] cyclic: invoke uthread_schedule() from schedule()
Date: Tue,  4 Mar 2025 16:24:55 +0100
Message-ID: <20250304152510.2832340-8-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304152510.2832340-1-jerome.forissier@linaro.org>
References: <20250304152510.2832340-1-jerome.forissier@linaro.org>
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

Make the schedule() call from the CYCLIC framework a uthread scheduling
point too. This makes sense since schedule() is called from a lot of
places where uthread_schedule() needs to be called.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 common/cyclic.c           | 3 +++
 include/u-boot/schedule.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/common/cyclic.c b/common/cyclic.c
index fad071a39c6..b695f092f52 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -16,6 +16,7 @@
 #include <linux/list.h>
 #include <asm/global_data.h>
 #include <u-boot/schedule.h>
+#include <uthread.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -100,6 +101,8 @@ void schedule(void)
 	 */
 	if (gd)
 		cyclic_run();
+
+	uthread_schedule();
 }
 
 int cyclic_unregister_all(void)
diff --git a/include/u-boot/schedule.h b/include/u-boot/schedule.h
index 4fd34c41229..4605971fdcb 100644
--- a/include/u-boot/schedule.h
+++ b/include/u-boot/schedule.h
@@ -3,6 +3,8 @@
 #ifndef _U_BOOT_SCHEDULE_H
 #define _U_BOOT_SCHEDULE_H
 
+#include <uthread.h>
+
 #if CONFIG_IS_ENABLED(CYCLIC)
 /**
  * schedule() - Schedule all potentially waiting tasks
@@ -17,6 +19,7 @@ void schedule(void);
 
 static inline void schedule(void)
 {
+	uthread_schedule();
 }
 
 #endif
-- 
2.43.0

