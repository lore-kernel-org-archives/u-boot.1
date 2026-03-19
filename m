Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A048F1091927
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 21:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F326A8400F;
	Thu, 19 Mar 2026 22:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fGdmWFmS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2601B83FED; Thu, 19 Mar 2026 22:36:35 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45DEC838FA
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 22:36:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d74c1157a4so935113a34.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 14:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773956190; x=1774560990; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTOWYrCEIqjo8l2Idhkg4Q1Lomw90K4EqjkzAaGeBfY=;
 b=fGdmWFmS6wQx4AAS9TAOTBtbQCBYxLrLGnbOnCcCFgMVbu3P83s2mWg6E5q3H3K9Fj
 Zwz3pyPbZqnzjA0UcuRg2/pxojmc3chmyTaXEXxSw7nSurha0Xs/2Z8Sv7C62kbeOfZ3
 WQ2W5VozH2Yqo+dGxw0gSjWCRo5X2I1eVKgxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773956190; x=1774560990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XTOWYrCEIqjo8l2Idhkg4Q1Lomw90K4EqjkzAaGeBfY=;
 b=QQrpVoAdbr/k58/05wbq40hJmCCcBn2d0gEdnGmRtI6Fzoe/SGdVGW11Mi7x66g65j
 75680+GSOUR+cn219hbtkiyTdkFqc0ckEhjr4VwAGSbXzOWkhAPtUtd8VKoQSViGDeuC
 GaeDP0ZXrZ+NErzuhZnJivDpxgBsdNPmbN1/YIzuhz5ifmjwsqpIyFzpxidKye4GaUo7
 Zl3NYuktfeAM7g4bEZOeaKpbn10dZJDQ+pZE+bKZmdsgizNB8ETzl56iq+WNVijlGV8b
 lXOU/q+rUWgt/HmZd/UrONsnYyDEtCG4lnEoZ/SKVCV8d/n9j556f5TghYuuyvKDm/eF
 2B4w==
X-Gm-Message-State: AOJu0YzMreYy4c+2esf71N+KgpqVxPvQ+Z+BNoI4fp54cVoUfClPHGRT
 XnNwB7ivZf95FSTOOwrTqPwXEviO/R4X5GStfK8OLIiQvIgIBa+D6LhcVWEml9JIWe3PY9OKrKd
 bMAQ6LQ==
X-Gm-Gg: ATEYQzwOTwYwcxaT5B7q0iENUHei/YLXQhm+OrXMDdoazJui81Jyi9DmUbVkplrsTtS
 V1NjbktUhy+G1lWQIxLayipR1xABDlYD0dDDylcl39C4ubTlvYP7/Hd026Ptrwnass8YzEOrk4f
 xSfU+Kw7HLYK+QnXhXUUvR+nIO0MfLx5ZTibz2B0JUNEKyc+7W1SOASXa4pjIYcEu+LKtjgpof+
 4LwK23L59krMBLnhcNSkSqMza+ggFzuYp9RqDK+xZPYyEpV4hS/wJSdP1tImndk+UFMevXnqx3j
 VxQDtqnxZDx4uQGJ8DSWFiwxvloxSsnonklnedT4MK+EAx3hARppcp+6vJClMVf7euCfGGA+Y2p
 agTxDwjBKckt/slmigoci50jYcEXA2duPCefHo2wIkhoXHmWYvb2x8MOaVwI1N7DbWhg/EObme4
 fONwLOxTjFQ0NG3vbq9w==
X-Received: by 2002:a05:6830:67f7:b0:7d7:e029:a1be with SMTP id
 46e09a7af769-7d7eae5b487mr520014a34.5.1773956190446; 
 Thu, 19 Mar 2026 14:36:30 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac17b0asm545724a34.9.2026.03.19.14.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 14:36:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <simon.glass@canonical.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 01/15] dm: Fix linker list alignment for ll_entry_get()
Date: Thu, 19 Mar 2026 15:35:31 -0600
Message-ID: <20260319213551.267031-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319213551.267031-1-sjg@chromium.org>
References: <20260319213551.267031-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

The extern declaration in ll_entry_get() lacks the __aligned(4)
attribute present in ll_entry_declare(). When the compiler sees an
unaligned extern reference to a linker list entry in the same
compilation unit as its definition, it may increase the section
alignment beyond the expected struct size. This causes gaps in the
linker list array, which the alignment checker reports as failures.

For example, sandbox_dir is both defined and referenced via
DM_DRIVER_GET() in sandboxfs.c. The compiler applies 32-byte
alignment to its section instead of the 4-byte alignment from the
definition, creating an 8-byte gap before it in the driver list.

Add __aligned(4) to the extern declaration in ll_entry_get() to
match ll_entry_declare()

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/linker_lists.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linker_lists.h b/include/linker_lists.h
index 0f4a2d686e2..2bc5326f681 100644
--- a/include/linker_lists.h
+++ b/include/linker_lists.h
@@ -266,7 +266,8 @@
  */
 #define ll_entry_get(_type, _name, _list)				\
 	({								\
-		extern _type _u_boot_list_2_##_list##_2_##_name;	\
+		extern _type _u_boot_list_2_##_list##_2_##_name		\
+			__aligned(4);					\
 		_type *_ll_result =					\
 			&_u_boot_list_2_##_list##_2_##_name;		\
 		_ll_result;						\
-- 
2.43.0

