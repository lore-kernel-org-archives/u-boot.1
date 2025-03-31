Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2457C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:32:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 017978205A;
	Mon, 31 Mar 2025 14:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="raVjvbCy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 388FE81F7E; Mon, 31 Mar 2025 14:31:48 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A34B82027
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so3766162f8f.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743424305; x=1744029105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y421ZCXdbIuk+CO6p9JQkLRemHxOxOFsYoJqtKMt0Rc=;
 b=raVjvbCyvLAg4zcNPZsTjCku/GYpKkG7Q13izobhq4L1AVmlbmGHFSL2skCHJ5jTXs
 51yV6ahEduKdfQuoAKrIrhsX3Ronm5JivPYJxf/1XIHSE/y0jNQq1StOPP1UbAbu4jjs
 sfD4zGD6ZtksnqHld/iFjjvDTZTRmjJg4gU4Yh55iaZ4CANwMQFoMAora/Sjlx+Sctdm
 7E91MxFW/KlMg+43T7Jhi4EyqWNfDi9FcBfsaqeJuP1d2xXnhasSwojh4ZQ8mTfnGRjE
 r+l6VH3DpxnNK809wsrcaJnAgsSeSZOuNxLyupupiG/82LivfCv0VE4IcXWRfmAG5wc3
 BpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743424305; x=1744029105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y421ZCXdbIuk+CO6p9JQkLRemHxOxOFsYoJqtKMt0Rc=;
 b=xTpkw0MyaJfJkMx79ZlstWJt5yG9WSdTPRYO91nyAdABAPGY5RIlBlgnvVkTOfiTXt
 w3f4wO3oWiq8B8oKJrZ4RLh5DJDIiwpvqe49Bht+z6+zNVtMO+1DIQ05H9zJMVCrLdvj
 3CReZSEWYmpRtnQkw2H8rSPdgf94ceQ9269jP7uYYQrAVqXaMY6i1YfXMDP0kM8dYkkB
 Ww/uuXkkMFIe+5hCJJvCNJXUDrG/9nlYmTurmaocu3XXTVrW5m8HGKr6TnVIUW+z7SG/
 hCe2Wxt4fDfRJ3CFcBNyp104TOwm36NlE4RtwjFmUxbnvsB1LvjfvCctaDri91qH+My+
 1EgQ==
X-Gm-Message-State: AOJu0YzceroX6qSkWtfFt8xG3knfWAfNBTCcW/5+2qNFQnNVMwBFk2g0
 AaTfx9v08e/+4exqiXidJ0BWF4VzwkCrRlOOU62a4XDls6dFhGcLBl2qvLIHQ/XSD33e/5pb6GF
 2h0oBXg==
X-Gm-Gg: ASbGnctObbcNjW3WX8VtpIXZbT574DRQ39jAAzOwxUrorCBkWVQM4VpY1Qqzzcqm58i
 8mzkjPfTKLqmCoAsxBw7tKb/qRBacOrJFZHPzvr3ie4gVIg1H2On6ZDt7y30u75L/wvxZZ4a4nd
 UJ37+gjMWk0uFZkjjAtol8RTdKfF9H9rI316TPpuzFnMpBWZCDIrFnl9Xbg/nXykOXG5WCzvGq1
 d9AfVw+M3naoaLfAMaz5WUGNOh42WM1iVXzuDYs2xQlsvREpBTkqCy+0W5qrm9rWE4GBqbsL2sC
 1IIGNZWqk7215uBWl/timy2qiNc+OTwbYiG1H84fbz5r4ujQCKpD
X-Google-Smtp-Source: AGHT+IGGkiTsPl5iO+qT7jUMlg/MypQEf1w2rYNufUgkQGWV8da1aaEhSlI9ZuTaGBOXgMnGvmFWBA==
X-Received: by 2002:a5d:5f91:0:b0:390:e7c1:59c4 with SMTP id
 ffacd0b85a97d-39c120de736mr7436775f8f.13.1743424304767; 
 Mon, 31 Mar 2025 05:31:44 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:f23c:25c9:dc74:be1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6589e4sm11337029f8f.10.2025.03.31.05.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:31:44 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v5 08/16] cyclic: invoke uthread_schedule() from schedule()
Date: Mon, 31 Mar 2025 14:31:02 +0200
Message-ID: <20250331123120.2025062-9-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331123120.2025062-1-jerome.forissier@linaro.org>
References: <20250331123120.2025062-1-jerome.forissier@linaro.org>
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
Reviewed-by: Stefan Roese <sr@denx.de>
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

