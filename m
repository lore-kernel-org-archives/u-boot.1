Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51003107637D
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 14:16:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01C6E84105;
	Wed,  1 Apr 2026 16:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nx0f5ImA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C165784101; Wed,  1 Apr 2026 16:15:34 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBB2383CE3
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 16:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4887d4c6234so23069095e9.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 07:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775052932; x=1775657732; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LclK/WFnKQsMrtdNvHDrf15plVujXWqfACmvsP31Zb4=;
 b=Nx0f5ImAIQUYWJGkks45BiOJJXVE1ulS8U3715nKNMD4ab0kMafrH9ty+w+CDfC73g
 kI0nsjODwWTH1yLH8Pnvk67/IXDm/MeuaElpw4BwHO5u4Tg7DvN/OBSPdHB+sGPmqvEb
 PpcoyYr2NeAtKvxMLVY396qqK8LXXEIc201nfAtxUyRD0olWUFbP/Jxy4xUs5iIFGHLB
 vvTRb5odkFTmtJN0yMCYmE1H1Or5qqHVmBC88SzYEk3EYAU6X+uF61tctVvB2B0HymhK
 va8C+b4VONydKTOd1qJ5erxecyZ6CWszd0gQnnmHpk6dROEeUTHO5+NO/hVdWWGstGT5
 AHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775052932; x=1775657732;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LclK/WFnKQsMrtdNvHDrf15plVujXWqfACmvsP31Zb4=;
 b=RKhd5lcCRVAQ/HzegMpYx/Ukte52LtV/UfBFQuE9+6vyQm9YN0BcrOgogvKA/GdrHd
 opAjqKLijf+ppI3T4T8ACWsoyAJDHq5hljc7lJnhKkhczNryNsqn1zfNaPR8wPLi/sV5
 mQSZxjdLzcrOArCfkIH2ZoEFkYoo4/aCgBh8JpYZ1jqTNSq+MQD6uz1fEtBFdJdWIgmH
 AuyAYk50MNPYfx62t4a82qFV8dvXWftgSVH5LIfjo56EVlBHQQouRgbtZTyPMY64LuYZ
 E9C4GJwkr5CbTgv5ufBKpU3Mu1JPqCs5Q5f9G2dl0VNdvaFGO//szY2fXUtyWmuTECzW
 cJRg==
X-Gm-Message-State: AOJu0YzZr2oUziMQdqm+s6OTyWA2jVUkMbHvhFXyYjWK74d5wbL/hZw1
 kOF+fsqwcu9YWv5qP5FRz/x7BY35IuYH5PoDoMuoqgCjdlXobKWum0yNpeHvIdzGTRY=
X-Gm-Gg: ATEYQzxWWagKSPGF5E3VDs+YQt/KxOE51pNQIX2Ss4ybFIjfWztfwGhyOr5QDy+pF6r
 RLiDrMgRsqf/V2lUm4E8IUdmkirVAx7us+POotEUj/vI5bztcxbQgFpEjM0r+iSurehk56kTMR8
 7c3qDAB9rlcO0aMH6790J1BT1DCV+uIhaTe8fexnkzmgAWVf2tiiTsQyfe8ueUMzZz2cUuItyN9
 Y08NflmEJm9xKhQwYiydZD7UfcRWq+vYdRhQUIMPWm4kx+8pm4aX9yTIpoVOJsMf14b7Ke7gb8e
 Z0KdKQ1UIMjzNBolfXHiYc4Ak//TX8wYATqtfbC2Gz+bf/6zsej9vhJXaZVTYArH4YBAfVSx9NZ
 QJUxAnwkHN69YZme5reUT91f54CC+kuZa4Etw9KTDtICEsj8gJ+zUnrL4AIle5lKANmH4ePmKUq
 jKkgzY+Qe94iwdH/WxsvvOXwBiqmffKW/lc9jb4rCi0ablfjpqez+ZyneUPVR/eXz9ZKGa
X-Received: by 2002:a05:600c:818f:b0:485:3423:727d with SMTP id
 5b1f17b1804b1-48883595de9mr60140335e9.26.1775052932026; 
 Wed, 01 Apr 2026 07:15:32 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8bcaf8sm43224135e9.27.2026.04.01.07.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 07:15:31 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 01 Apr 2026 16:15:22 +0200
Subject: [PATCH v2 06/11] compat: add kref implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-casey-ccf-compat-v2-6-414d5b7f040b@linaro.org>
References: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
In-Reply-To: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=4465;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=IsUyr94uAbhBQSS9jsTFSHJPICURKHi5YxAKX4Vf8eI=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzGlWvP6QmRqfZa0g5pW7Tir22mvPx175fTM8fs/qu+
 Cv6u/NGRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIayOG/77O9r0TNmZm7aw5
 rynt/zL0e/s2sV0f+BeX2qTYc94xVGf4Z1lSei7icfyLaYLvep+yXfJUt921eGKo45KWXVd1frK
 zeQEA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This is a very basic port of Linux' kref, we don't actually need atomics
so we just use a simple counter. This is used by CCF to free unused
clocks.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 include/linux/kref.h | 124 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/include/linux/kref.h b/include/linux/kref.h
new file mode 100644
index 000000000000..30927047d549
--- /dev/null
+++ b/include/linux/kref.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * kref.h - library routines for handling generic reference counted objects
+ *
+ * Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
+ * Copyright (C) 2004 IBM Corp.
+ *
+ * based on kobject.h which was:
+ * Copyright (C) 2002-2003 Patrick Mochel <mochel@osdl.org>
+ * Copyright (C) 2002-2003 Open Source Development Labs
+ */
+
+#ifndef _KREF_H_
+#define _KREF_H_
+
+#include <linux/compat.h>
+
+struct kref {
+	long refcount;
+};
+
+#define KREF_INIT(n)	{ .refcount = REFCOUNT_INIT(n), }
+
+/**
+ * kref_init - initialize object.
+ * @kref: object in question.
+ */
+static inline void kref_init(struct kref *kref)
+{
+	kref->refcount = 1;
+}
+
+static inline unsigned int kref_read(const struct kref *kref)
+{
+	return kref->refcount;
+}
+
+/**
+ * kref_get - increment refcount for object.
+ * @kref: object.
+ */
+static inline void kref_get(struct kref *kref)
+{
+	kref->refcount++;
+}
+
+/**
+ * kref_put - Decrement refcount for object
+ * @kref: Object
+ * @release: Pointer to the function that will clean up the object when the
+ *	     last reference to the object is released.
+ *
+ * Decrement the refcount, and if 0, call @release.  The caller may not
+ * pass NULL or kfree() as the release function.
+ *
+ * Return: 1 if this call removed the object, otherwise return 0.  Beware,
+ * if this function returns 0, another caller may have removed the object
+ * by the time this function returns.  The return value is only certain
+ * if you want to see if the object is definitely released.
+ */
+static inline int kref_put(struct kref *kref, void (*release)(struct kref *kref))
+{
+	if (--kref->refcount == 0) {
+		release(kref);
+		return 1;
+	}
+	return 0;
+}
+
+/**
+ * kref_put_mutex - Decrement refcount for object
+ * @kref: Object
+ * @release: Pointer to the function that will clean up the object when the
+ *	     last reference to the object is released.
+ * @mutex: Mutex which protects the release function.
+ *
+ * This variant of kref_lock() calls the @release function with the @mutex
+ * held.  The @release function will release the mutex.
+ */
+static inline int kref_put_mutex(struct kref *kref,
+				 void (*release)(struct kref *kref),
+				 struct mutex *mutex)
+{
+	return kref_put(kref, release);
+}
+
+/**
+ * kref_put_lock - Decrement refcount for object
+ * @kref: Object
+ * @release: Pointer to the function that will clean up the object when the
+ *	     last reference to the object is released.
+ * @lock: Spinlock which protects the release function.
+ *
+ * This variant of kref_lock() calls the @release function with the @lock
+ * held.  The @release function will release the lock.
+ */
+static inline int kref_put_lock(struct kref *kref,
+				void (*release)(struct kref *kref),
+				spinlock_t *lock)
+{
+	return kref_put(kref, release);
+}
+
+/**
+ * kref_get_unless_zero - Increment refcount for object unless it is zero.
+ * @kref: object.
+ *
+ * This function is intended to simplify locking around refcounting for
+ * objects that can be looked up from a lookup structure, and which are
+ * removed from that lookup structure in the object destructor.
+ * Operations on such objects require at least a read lock around
+ * lookup + kref_get, and a write lock around kref_put + remove from lookup
+ * structure. Furthermore, RCU implementations become extremely tricky.
+ * With a lookup followed by a kref_get_unless_zero *with return value check*
+ * locking in the kref_put path can be deferred to the actual removal from
+ * the lookup structure and RCU lookups become trivial.
+ *
+ * Return: non-zero if the increment succeeded. Otherwise return 0.
+ */
+static inline int kref_get_unless_zero(struct kref *kref)
+{
+	return kref->refcount ? kref->refcount++ : 0;
+}
+#endif /* _KREF_H_ */

-- 
2.51.0

