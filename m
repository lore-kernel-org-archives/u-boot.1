Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F28C369CA
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08A66832BC;
	Fri, 18 Apr 2025 16:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HMeNkWfH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C26C832AF; Fri, 18 Apr 2025 16:11:41 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10B928321D
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so13681395e9.0
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744985498; x=1745590298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=30iCggiQxsg+n7n81V9I0g3OaEhSTqDQMaxbYhLD4SI=;
 b=HMeNkWfHYoMfYnwjXrAgtWXzTI4uI+A9ufD3AgVNAPhH9UX8TYktdvf4Ts1h0F6IBU
 oCszz05eIuk2/VA8rkGMSAAB6qV3zAlbWHRwESTSC8ogl3Bn7uqpp/JZEe5HAF9ZtxJK
 jsldiVkB5nvTtHf/j22MAkxCYQv4xgM0dusg0VeYcEdKxx04Qf8sivgP411j6eXCH67P
 C6ADA4CQ1ADaL+vjnUu9hVqWVCxYg66GmOwWcBcA0Oho406v6ADifGhzbvfU/zEHaWmJ
 fc/T5AuDcs2h6LLEqzFAas0sr0LgE7pNpsrzJorSsaqiuJbIAzAjxf7X7WiINUo2cnp7
 WL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985498; x=1745590298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=30iCggiQxsg+n7n81V9I0g3OaEhSTqDQMaxbYhLD4SI=;
 b=Cd3XI3l07VeSu0RBHY8gJkuajYDUzx/3cRGe7CzbHSkOQLW29ox/Jz0ExQa5NJwSCd
 aLWA48pGuxCBIBv9P/LLlZd/QpIQgK6OgE2ca0hKuNIl7ci9+2d8nNgN4acJhztz6Nxh
 XYmVkx73fmeC7YMYYpedjWPD8L3JM5TStQhS33F/83liNd+NORPPJo1NJGinRy5Kuy3t
 jYz6GPqGKJa702kGY1F9YXxFNECKsJ8F97cjNTHMxkJuFLEFQRpz67AWdkFbRxPntkHy
 gNPwILDUETLWzpf1nIBXyIdzVhFfvCFOEyjtIv5fXtLx3/Ln0qGrlg+kKpVQlQ4B6WIz
 LnhA==
X-Gm-Message-State: AOJu0YxZLZUCpxuSLAk9GLg0xaFZ1UZ2qsHGiiNQ9EQAHe1s7MucH4wN
 Hwc2e8aowlL7iSBcnNT4xMo28MApzlU2veEMTWSSVulMFCcSbKmq3F7DwCWnHtOW8xuaRqDqxyH
 YxtDZ3w==
X-Gm-Gg: ASbGncupkpXVNGpUBKIeHgujA6Zxg4cviDylzqXJr43nFdklSh438Y7sgUR6Jx+gcr2
 bHEfKDWOyJZYrj7wbaPD6XRdHYUAmFmuq9Q1ViyNgGuzlVff5PfgVaKAzEcoE2092vbl8g1+jzD
 zDsc/v1AaUPxE4U2j/vBOqzlGVt4rdOg3dDtva61u2izG45Cpocw0K0up9qEnosVMPuu+cI/3xB
 4lz274XPzV3rqqjBmefX9yKxP2Ng8t2MWbtg93TuZ+v/isrdZjzSqNfex+qGUfjVKXbbNRFP7AG
 BsDdKXLFiRxu03vh9gYbmlBQXyASyM1afBddtAPFjufaIdXGHA==
X-Google-Smtp-Source: AGHT+IFo9L2CwvKL2JlQPhNomQRScrxuDFs94uQ0l4CpI4HS4ud9NR5Rh7Q8Vx090DsspOpD0vct2Q==
X-Received: by 2002:a05:600c:3b9b:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-4406aa872fdmr28696685e9.0.1744985498282; 
 Fri, 18 Apr 2025 07:11:38 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1526:5ffd:d63c:cc85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbcc3sm23734385e9.19.2025.04.18.07.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:11:37 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 07/17] uthread: add uthread_mutex
Date: Fri, 18 Apr 2025 16:09:35 +0200
Message-ID: <20250418141114.2056981-8-jerome.forissier@linaro.org>
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

Add struct uthread_mutex and uthread_mutex_lock(),
uthread_mutex_trylock(), uthread_mutex_unlock() to protect shared data
structures from concurrent modifications.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

Changes in v6:
- uthread_mutex_trylock(): return -EBUSY instead of EBUSY

 include/uthread.h | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/uthread.c     | 27 +++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/include/uthread.h b/include/uthread.h
index f796a16f25f..89fa552a6f6 100644
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
index aa264b1d95f..062fca7d209 100644
--- a/lib/uthread.c
+++ b/lib/uthread.c
@@ -8,6 +8,7 @@
  */
 
 #include <compiler.h>
+#include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <malloc.h>
@@ -136,3 +137,29 @@ bool uthread_grp_done(unsigned int grp_id)
 
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
+	return -EBUSY;
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

