Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFCEC369CA
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51716832FE;
	Fri, 18 Apr 2025 16:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gclyxUu0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9098832E6; Fri, 18 Apr 2025 16:11:41 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C228E8327A
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso19936875e9.1
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744985499; x=1745590299; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T7y64nRkt+jVoLpphpzyDqiLu3YG1kfVphGiAgljCfI=;
 b=gclyxUu0taUX/MCgP7ntmAvHjCDJnk1k7pmiFaTj/+gKwTwm3pya0OJG+viqZbWpGA
 Qfd4Q2rCb+9DlWrOL58OerwX2GxdeiibbIzWNqsmcoN6MLdfevCNTiojHS3ufU8InnSD
 561KgAdjGQEvuXpdnr5jYsLm1epKAJ8+pS+U2sNzZ11VPMQZM6gSDH/6RvkzYvMd4WuS
 HH8GtMwxzLyNtI9FGrrPxlk4JFPacrgrmU+mr0h8wUUEn7+rlkErMOtxV1N8BN6u+Kxx
 HKQh/cECPCm9s1kvjYVGvBpWiF3QMIrZ+aeVz1eo82EyR3y0cuGdIWSFCRDuUiVpSvmH
 zMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985499; x=1745590299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T7y64nRkt+jVoLpphpzyDqiLu3YG1kfVphGiAgljCfI=;
 b=bEgSSEN2giCrJ+9H1B0KSaUk6mZvIWOAlXlotNG3x0RV7TdmJbGrjoVGrFi/5Wy4lG
 q8pSTCX+qPSNdcCkbAtTGZ3Lgfd8LQcpFsJBfeP7lDJ27H5C0iRd53eY9sLh8p4lywaD
 /oAiMZT26dA9LwGak24SxxW2jdwsXpDhW7WRs3Wg1U4K3R3vhaJZDkreIpSE77KbOPFJ
 t0vQ/dx9rkUg+hXIRv078ywsN0lopWl79OIrrQnYJMjsDDv+iA6stmzbImx8atgAYaC6
 XGhu6+x7I0lKmO82IbBFTIPBV/k3eSlmUTmJr4J+trU27BwPTh+umIKNOaBmG5ge8QKs
 Lj4Q==
X-Gm-Message-State: AOJu0YyF6bfzmmvOaPvMIKrtpIwoBSfiSMR5DALEZxhSOXvY4msGp4/q
 mMTjn/heAowH8SZ9HCouehDD4AKWZDDnpyt0mJTXkDhJ33tnVVtqSjF/ey/0ayKApAk0ZpYiU5E
 wRskSIA==
X-Gm-Gg: ASbGncvKNw4ETDCfxBErqDV0n8uq5PafJqpUqogqywz8ARz3oZCCPrsZ2iH9YipbHGs
 Nqvs10nlFoorIWaWcNrAVtFJVojnClJqawL7DPZRI120sYzdERk7nB208fNSbspRYtyIpsI+VNr
 yRqVfEndVsFUFjcmDq0SVUwEa+tDXV9ADOPYPuZzoik5YzRhCXGAtREaq8iPZ047H9BVCa+ZNfK
 xB/F7j6rZqDPtGJWWj8QxnTi0Th+nr1VcXYLtj55YAMCOus93ds1oDy4czNnUqKT/UCzFBAyXIG
 +AZKfb9bUsmBlSfYbhX3nFJNFLaW1fCa7lSLm5BAzYejSjXJtQ==
X-Google-Smtp-Source: AGHT+IEiy2+42tr9/DIZwwrM5Ua+CyNN2UW60XG9ajPFxX4B3Xpeqo0n7b9DS8gwG+HjPdGUZMDtng==
X-Received: by 2002:a05:600c:350a:b0:43c:e7ae:4bc9 with SMTP id
 5b1f17b1804b1-4406ab7a56dmr18843825e9.1.1744985499111; 
 Fri, 18 Apr 2025 07:11:39 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1526:5ffd:d63c:cc85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbcc3sm23734385e9.19.2025.04.18.07.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:11:38 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Stefan Roese <sr@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 08/17] cyclic: invoke uthread_schedule() from schedule()
Date: Fri, 18 Apr 2025 16:09:36 +0200
Message-ID: <20250418141114.2056981-9-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418141114.2056981-1-jerome.forissier@linaro.org>
References: <20250418141114.2056981-1-jerome.forissier@linaro.org>
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

(no changes since v1)

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

