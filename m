Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF2FC3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60B3981EDD;
	Mon, 31 Mar 2025 14:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i4UpjmjW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DB3381703; Mon, 31 Mar 2025 14:31:46 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3440381FC8
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3996af42857so3536511f8f.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743424303; x=1744029103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uHZKSG0xtRYRdde4r+bICyY03DcqDMhunPskeFUaEDU=;
 b=i4UpjmjWAmMX1QtRAi4qIpGqHsSCz8OphWW+Ywca609MKQdy9j5wLhB6/9s+zz6vVv
 EaLJJB2RefI3G4xUEnGPJvRg3t3GjfLbd89A/LnrFHxLlXFvyb8zG/WED3jo44bjcMRk
 NcG7GXdsQ/0dI5L0UglZoVVuLKDzXQ45Ta19P41VZjzEguGO2r9XbHRgVfkhVYT/ZvNE
 CGHs8veOx1nuC2GvAZrOvKgfX4KNaQKGy87I41JJzLTpfpdNh+1BPck7JefxIVbO/7bE
 0i8UnlHV9Frmbq7K8LlaCFG2NevGi/+o36/iSPIs1XggkyfcnxNVArhIhEZftnRo6n6R
 FzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743424303; x=1744029103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uHZKSG0xtRYRdde4r+bICyY03DcqDMhunPskeFUaEDU=;
 b=mi2+PlVYs2BrEMaLA2PKI6nEo2P7MKTTKJJRTCFCQcuCXu/pZVVedl0O6V1JXn9ian
 B2Y51OQAwIj4yhl8QlpSpicRMEaChN1CjwgrP5hdZrcPEA5W4Ej8/PtRSYW6hjuRllLj
 5DtbWHgpQ7mSo/tQwJUowSHCdjTk5MQ6fXbFYBdevepDOLIT8IpTnJVwV034n6fS9rYL
 KCcaqtUg0+Uf3ZeYPqtU2049wNUdl2ODswQ9wr5Y5dbU070EPc2aDMt7FeZRwmG/VRuM
 qoNDLrC5H+/FQymgAKaZ8UvLgdhhohTtccLuK3zSSmp/7MFmv4993pMxkaOUFOxQ5Xw/
 itmA==
X-Gm-Message-State: AOJu0YzJ+yXVzL9VBDGYpdE8eyql9Raxx27rF5F3JDIybhgqezx7e2Tr
 o0wEwnpX03U8VhavDyxLavYLU8zVrrGprnNnGvz+Tv9iYAWlr+K9sGmAFXA15pMDhplN46QCnfU
 TWRJgtg==
X-Gm-Gg: ASbGncsinjKxStaKNk8mkvYAO7me4VbZdMXbq73yVqkIHZ+CnLvYkP3mbD5Z9aH1Mp6
 RVe+ZtFP0Rbs3EODroh3cmh0PdYt/JDL17ToOszHeWQ2+DUdexSl0oO5ktR3ddtPj3fkfpKjsUz
 eJQX1nYrzcmZyGBqDCd2P1+xIfr5+/v+PbnVIg19xDVtebLmKgfCUemsqZBMFmprlzliWAn47Ae
 tDC9wnvj0AQ3+3fhzCWmNenL8XCtT8vOz2zvCv7tc9+MlgRFStDR19+plHv6EWh/qLVCG5V0Vqy
 X085jMfhrcVLkmHdTHL1H2zxkBYCnKkbNxzGj+OT3RX1D9i0kzGX
X-Google-Smtp-Source: AGHT+IFvDIZQY44Ew9LYDuKJg0bjy+JVzg35iuOPmYK7lhBaVAcLoO6OR8cEkTgnhq/v2OW6yY65dA==
X-Received: by 2002:a5d:64c3:0:b0:399:6d8a:3f with SMTP id
 ffacd0b85a97d-39c11ba42eamr6731464f8f.27.1743424303464; 
 Mon, 31 Mar 2025 05:31:43 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:f23c:25c9:dc74:be1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6589e4sm11337029f8f.10.2025.03.31.05.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:31:42 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 07/16] uthread: add uthread_mutex
Date: Mon, 31 Mar 2025 14:31:01 +0200
Message-ID: <20250331123120.2025062-8-jerome.forissier@linaro.org>
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

Add struct uthread_mutex and uthread_mutex_lock(),
uthread_mutex_trylock(), uthread_mutex_unlock() to protect shared data
structures from concurrent modifications.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 include/uthread.h | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/uthread.c     | 27 +++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/include/uthread.h b/include/uthread.h
index ec3034c097a..87292b604ca 100644
--- a/include/uthread.h
+++ b/include/uthread.h
@@ -50,6 +50,23 @@ struct uthread {
 	struct list_head list;
 };
 
+/**
+ * Internal state of a struct uthread_mutex
+ */
+enum uthread_mutex_state {
+	UTHREAD_MUTEX_UNLOCKED = 0,
+	UTHREAD_MUTEX_LOCKED = 1
+};
+
+/**
+ * Uthread mutex
+ */
+struct uthread_mutex {
+	enum uthread_mutex_state state;
+};
+
+#define UTHREAD_MUTEX_INITIALIZER { .state = UTHREAD_MUTEX_UNLOCKED }
+
 #ifdef CONFIG_UTHREAD
 
 /**
@@ -94,6 +111,44 @@ unsigned int uthread_grp_new_id(void);
  */
 bool uthread_grp_done(unsigned int grp_id);
 
+/**
+ * uthread_mutex_lock() - lock a mutex
+ *
+ * If the cwmutexlock is available (i.e., not owned by any other thread), then
+ * it is locked for use by the current thread. Otherwise the current thread
+ * blocks: it enters a wait loop by scheduling other threads until the mutex
+ * becomes unlocked.
+ *
+ * @mutex: pointer to the mutex to lock
+ * Return: 0 on success, in which case the lock is owned by the calling thread.
+ * != 0 otherwise (the lock is not owned by the calling thread).
+ */
+int uthread_mutex_lock(struct uthread_mutex *mutex);
+
+/**
+ * uthread_mutex_trylock() - lock a mutex if not currently locked
+ *
+ * Similar to uthread_mutex_lock() except return immediately if the mutex is
+ * locked already.
+ *
+ * @mutex: pointer to the mutex to lock
+ * Return: 0 on success, in which case the lock is owned by the calling thread.
+ * EBUSY if the mutex is already locked by another thread. Any other non-zero
+ * value on error.
+ */
+int uthread_mutex_trylock(struct uthread_mutex *mutex);
+
+/**
+ * uthread_mutex_unlock() - unlock a mutex
+ *
+ * The mutex is assumed to be owned by the calling thread on entry. On exit, it
+ * is unlocked.
+ *
+ * @mutex: pointer to the mutex to unlock
+ * Return: 0 on success, != 0 on error
+ */
+int uthread_mutex_unlock(struct uthread_mutex *mutex);
+
 #else
 
 static inline int uthread_create(struct uthread *uthr, void (*fn)(void *),
@@ -119,5 +174,10 @@ static inline bool uthread_grp_done(unsigned int grp_id)
 	return true;
 }
 
+/* These are macros for convenience on the caller side */
+#define uthread_mutex_lock(_mutex) ({ 0; })
+#define uthread_mutex_trylock(_mutex) ({ 0 })
+#define uthread_mutex_unlock(_mutex) ({ 0; })
+
 #endif /* CONFIG_UTHREAD */
 #endif /* _UTHREAD_H_ */
diff --git a/lib/uthread.c b/lib/uthread.c
index c3f6c84c234..dae3ec758fd 100644
--- a/lib/uthread.c
+++ b/lib/uthread.c
@@ -8,6 +8,7 @@
  */
 
 #include <compiler.h>
+#include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <malloc.h>
@@ -137,3 +138,29 @@ bool uthread_grp_done(unsigned int grp_id)
 
 	return true;
 }
+
+int uthread_mutex_lock(struct uthread_mutex *mutex)
+{
+	while (mutex->state == UTHREAD_MUTEX_LOCKED)
+		uthread_schedule();
+
+	mutex->state = UTHREAD_MUTEX_LOCKED;
+	return 0;
+}
+
+int uthread_mutex_trylock(struct uthread_mutex *mutex)
+{
+	if (mutex->state == UTHREAD_MUTEX_UNLOCKED) {
+		mutex->state = UTHREAD_MUTEX_LOCKED;
+		return 0;
+	}
+
+	return EBUSY;
+}
+
+int uthread_mutex_unlock(struct uthread_mutex *mutex)
+{
+	mutex->state = UTHREAD_MUTEX_UNLOCKED;
+
+	return 0;
+}
-- 
2.43.0

