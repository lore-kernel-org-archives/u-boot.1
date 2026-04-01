Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4B9107637D
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 14:15:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 062D0840CC;
	Wed,  1 Apr 2026 16:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YFmalPzq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B910840AA; Wed,  1 Apr 2026 16:15:30 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC5183CF5
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 16:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so13019765e9.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775052928; x=1775657728; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OJvm8hJq5dvTL5t+nuiKKxZ20+5uLhO/dmppj5+JcmU=;
 b=YFmalPzqPa5zddTkWcgjORxrdVIf0GLEatKRRuCldOdL+kunurwM+JBU53T0+LDssL
 WPJjq1MzcOJIBA3Rcc6h+hGq3WeqXN6xBUavMyFrl7OFFt2cMbas/qCFRgimmcT3AJGh
 ngqv6fVqGkz62K5l95Qk3C1QvnLifAIXSLSC8zyEtIxOevLhe3b/1myVe9ObdoIc2AZ7
 1aUpW0+1ShMVUa/kaFe6OUN6Yy/mTJrVdbSHsMph63nW/OliniD2vTegeRV26VsQmeCW
 5VNNCpT8q6uO+rluiX9VF5mww9s6oDQNBTN5L94ffW5syboRxBpfIro93nBPURQheo48
 TxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775052928; x=1775657728;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OJvm8hJq5dvTL5t+nuiKKxZ20+5uLhO/dmppj5+JcmU=;
 b=J7/zkP6Dr3bYr0+YX1mdjuqHS6pjOABlMJkD3B6+a0+evXqGyJwNAPanpWEA9sQXXk
 Ja51kQxnLiFsR3VMUhyRjZf5CMb6vbLivwsE9SezC9GKVkHZ+ydohBmCd8/4rbap/roV
 U2k/QonFV7ty+GeBLCagbUZoItsrQCQg55KrtsCemobnqDzRB4gi/XWwG5+jhW3NFk9V
 hLZnG+8VS1z1U2UwAAfc9t+bnwmmpemGeughIOM4N4Qa7WYm+UpYaUtH6PWv61+rq0+A
 9WTt8lAl2Uoqbl0s33XDGnmb8mkAxtrUL7jgjf4OZ/of3skLjBdsRrhjYDE13P3Afrmw
 4UuA==
X-Gm-Message-State: AOJu0YzFSo8BEpwHYDFouOFVVKzwMCaG83KFj4peJ832K8fLP6UI3m4d
 BqTgu6+MRdsxuMNPHk6azkeY8799iO+R+ypiN82uFt4r8Vt6kyIlpqMh0+ELjOemvFw=
X-Gm-Gg: ATEYQzxZ2pEr+Df68SFJ8vWWB4hyTKk8prkAmZPXADYIUbOqYlg+bZeStPE1yoIAKU8
 zECvc75rznFooB7/v+WgGDXpQJ7lvCSithMeiDRe0XMm0NsiVd2hIW06i08Rpjdr8EBTedZLgy4
 DObknMFsnOtkmZBtzvTrdJpS3HgaC+VTn+Ht9rcb6e4o7nU7fG22yt4njmkJxAtsHJSazGYMASj
 rtnquk24jL7n+beUkmJHu3EeELvnzP4JnyjUdym1+GLF+RmJvP+j1W0Lqz0uEnpqrbDE7tvWihS
 +sUFirkrO0XmgWBNygFMw4uUV2UW6vRep4zWR3xi53dC64QN3HI03lJjIca2ZT9S9xU1bvVWDhj
 J0hTGHqvwxx0nMWESrvXjI9tEa9sKr9F5w8CGgjEWxJIUATsgrak+8FhbSTjOO6uWN8wmKMfukF
 dZkJ9TieZ3B1dkXd7430a/mr77uMv7aqIzwufoeSm7we4FSQlFL8Hg53g7bWsIZEnSII+4
X-Received: by 2002:a05:600c:8184:b0:485:3428:774c with SMTP id
 5b1f17b1804b1-48883575bfbmr59613225e9.4.1775052927751; 
 Wed, 01 Apr 2026 07:15:27 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8bcaf8sm43224135e9.27.2026.04.01.07.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 07:15:26 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 01 Apr 2026 16:15:19 +0200
Subject: [PATCH v2 03/11] string: add strdup_const and kstrdup_const
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-casey-ccf-compat-v2-3-414d5b7f040b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4099;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=5jwUMh0k+N1QnC8WW0D/qoE/XYGivWXyZ6pP2y+2UGs=;
 b=kA0DAAgReTBFn7kwMhcByyZiAGnNKHmggsWcTW3ArsECDhmbGF/UuHuzITyy/JVb9Aod6QUpv
 Yh1BAARCAAdFiEEF8imOYKt0z8ot6DQeTBFn7kwMhcFAmnNKHkACgkQeTBFn7kwMhc8AQEAk0fs
 J46w655p1IEnAosIiwCJQK3lw+VqGvyiXlHoqKoA/0J9VyFTEPZ0otojW1Ca/X7mexmtUkb6SrR
 aEEnFiiDO
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

Extend Linux compat by adding kstrdup_const(), backed by lib/string.c.
This leverages U-Boots .rodata section on ARM64 to avoid pointlessly
duplicating const strings.

This is used by the Linux CCF_FULL port and may be useful elsewhere
in U-Boot.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 include/asm-generic/sections.h | 19 +++++++++++++++++++
 include/linux/compat.h         | 13 +++++++++++++
 include/linux/string.h         |  2 ++
 lib/string.c                   | 31 +++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index d59787948fd1..48bd4fa86043 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -8,8 +8,9 @@
 #ifndef _ASM_GENERIC_SECTIONS_H_
 #define _ASM_GENERIC_SECTIONS_H_
 
 #include <linux/types.h>
+#include <stdbool.h>
 
 /* References to section boundaries */
 
 extern char _text[], _stext[], _etext[];
@@ -61,8 +62,26 @@ static inline int arch_is_kernel_data(unsigned long addr)
 	return 0;
 }
 #endif
 
+/**
+ * is_kernel_rodata - checks if the pointer address is located in the
+ *                    .rodata section
+ *
+ * @addr: address to check
+ *
+ * Returns: true if the address is located in .rodata, false otherwise.
+ */
+static inline bool is_kernel_rodata(unsigned long addr)
+{
+#ifdef CONFIG_ARM64
+	return addr >= (unsigned long)__start_rodata &&
+	       addr < (unsigned long)__end_rodata;
+#else
+	return false;
+#endif
+}
+
 /* U-Boot-specific things begin here */
 
 /* Start of U-Boot text region */
 extern char __text_start[];
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 623814516175..d4ba4d0088a0 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -66,8 +66,21 @@ static inline void vfree(const void *addr)
 {
 	free((void *)addr);
 }
 
+/**
+ * kstrdup_const - conditionally duplicate an existing const string
+ * @s: the string to duplicate
+ * @gfp: the GFP mask used in the kmalloc() call when allocating memory
+ *
+ * Note: Strings allocated by kstrdup_const should be freed by kfree_const and
+ * must not be passed to krealloc().
+ *
+ * Return: source string if it is in .rodata section otherwise
+ * fallback to kstrdup.
+ */
+#define kstrdup_const(s, gfp) strdup_const(s)
+
 struct kmem_cache { int sz; };
 
 struct kmem_cache *get_mem(int element_sz);
 #define kmem_cache_create(a, sz, c, d, e)	get_mem(sz)
diff --git a/include/linux/string.h b/include/linux/string.h
index d943fcce690c..a8a6cf4af505 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -103,8 +103,10 @@ size_t strcspn(const char *s, const char *reject);
 
 #ifndef __HAVE_ARCH_STRDUP
 extern char * strdup(const char *);
 extern char * strndup(const char *, size_t);
+extern const char *strdup_const(const char *s);
+extern void kfree_const(const void *x);
 #endif
 #ifndef __HAVE_ARCH_STRSWAB
 extern char * strswab(const char *);
 #endif
diff --git a/lib/string.c b/lib/string.c
index d56f88d4a847..302efe048b07 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -378,8 +378,39 @@ char * strndup(const char *s, size_t n)
 	new[len] = '\0';
 
 	return new;
 }
+
+/**
+ * strdup_const - conditionally duplicate an existing const string
+ * @s: the string to duplicate
+ *
+ * Note: Strings allocated by kstrdup_const should be freed by kfree_const and
+ * must not be passed to krealloc().
+ *
+ * Return: source string if it is in .rodata section otherwise
+ * fallback to kstrdup.
+ */
+const char *strdup_const(const char *s)
+{
+	if (is_kernel_rodata((unsigned long)s))
+		return s;
+
+	return strdup(s);
+}
+
+/**
+ * kfree_const - conditionally free memory
+ * @x: pointer to the memory
+ *
+ * Function calls kfree only if @x is not in .rodata section.
+ */
+void kfree_const(const void *x)
+{
+	if (!is_kernel_rodata((unsigned long)x))
+		free((void *)x);
+}
+
 #endif
 
 #ifndef __HAVE_ARCH_STRSPN
 /**

-- 
2.51.0

