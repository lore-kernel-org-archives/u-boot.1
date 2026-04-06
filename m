Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72292F46C78
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 19:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06943841DD;
	Mon,  6 Apr 2026 21:46:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SkCY2o1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78C0183936; Mon,  6 Apr 2026 21:21:58 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 726D08352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 21:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-89cc68655f8so45515716d6.0
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 12:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775503314; x=1776108114; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2DYyt7uEVwCnP84l5G8RvHRS5XSBJMzriRwtU/iMoI=;
 b=SkCY2o1T3lhu1tVNP9V1tdkC8jzRunofQnD5jXFPwRjRo9XxhAQlit9X3DMmsxqxQ9
 1Q+8npjkb33dVPezOzcZ5iYor0o05Cxw6YiLrpky7oKG2C747Yht+IOf0uHhuRymw/4w
 RoSNTE0R4efdVBrNFGez6hFD7vDlz2mnC8+2tGr79DMfcdJoGormRGVKMdn5+JpX7i5D
 UtVoLzEZ5lsWXjA7Ufq0M/KRqWXnfBbXNm6zOGDOqGm3OYPTgDpt/Sk2yXtlF78JqrVq
 SK6x/LAeXimRthF7wZLeGDUure73vI4DHwC6HPXyyoa2yCWemcYppiiQX2kmoVCvFxFT
 Z3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775503314; x=1776108114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z2DYyt7uEVwCnP84l5G8RvHRS5XSBJMzriRwtU/iMoI=;
 b=Z3yQFDtk8ddFCmBEEdHhx8HGYMgKdsv7L6vFPa3VYUkKglzwXsMmWQmgCUcWglKQss
 zIcIA4sDVJ6ko4GFZzDRnd91kScgZ1n5jBs4YyD4dyCSSFBKJ51YzrohlxNXdO3ZOkpR
 DEOROd2+2zcnCZwvZVWtSkgco174VUkqomFvekkCbOa5xyWUB4Q7FE3cMRuiIVVI9IwH
 PMYPmROCZ1jdc0NKKok+mnT7tzwYbB7TiaSN0F7s1H/hFE/xrN4tovc1pWGGgDegFrK/
 +PfTzF7nYVyi+KIsKxnVVPHymmzsVX63hd/Lu7ETBSHB+1gURNB3OAX/5myvgQAon57W
 btbQ==
X-Gm-Message-State: AOJu0Yw+TfzRIFHiYVUjAhFokZSWmMqCTayW1ea53wXacLerU/9ZOL3y
 bGvuKK0BPpN5vN6peU06YLoXOoTaSj7yQb+6jF/r5tiJvagp45UV70bMJ1z2zjGZ
X-Gm-Gg: AeBDievKHKsml9NpbHpF+EiioAwRtLB31o5RyjnbG4bZCoMc+3oUaeCHsgICzE+C+aa
 +OjCfcil7jAWe2XREKZsP8+fjjHe9lZt6OVOrIT/jYMXsNuXmJYrQMSqnwWq6FJqOc2h6fWlvm5
 1ZtMmBpAK7YR4Am5+sYqK7qecKJUUuEUqUQOK08vOOSORJRmv6PPP4I3StOQK0zkKwo+cXy86Xz
 I/XVIMQdz150mWeZgDmHM8D9niJnYQo10W/pLLAwtMG10wDlv7tvbl+4EqfShWV7ZBiupuGLehj
 IMANsbDPGT1lF6+v9jXmbjnLonPz8JsgovBhZtOSQq7W5kp3YgqKI+c70Btjxw0aQN01nLM8uCG
 SCk0G3FaYNISN1FpEsFvIvnKO/3iJDCg+1JCRkC1u6JpgArZUp/xydid54Qh7W5OFF5aFDjfjWE
 wLjsQ6oPZOqvIP/ZiyWsi5tipZ4CQtQG9OhQ==
X-Received: by 2002:a05:6214:5083:b0:89c:da80:bf38 with SMTP id
 6a1803df08f44-8a5ee02f9f0mr252584066d6.31.1775503314493; 
 Mon, 06 Apr 2026 12:21:54 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a596e03dc6sm150191166d6.34.2026.04.06.12.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 12:21:54 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Ozan Durgut <ozndrgt@gmail.com>,
 Ozan Durgut <ozan.durgut@analog.com>
Subject: [PATCH v3 13/13] arm: sc5xx: add missing boot env selectors
Date: Mon,  6 Apr 2026 15:06:15 -0400
Message-Id: <70bb308932cfb35bccf60bf901dc6b1fe6c2b3c1.1775500819.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775500819.git.jcethrid@gmail.com>
References: <cover.1775500819.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Apr 2026 21:46:28 +0200
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

From: Ozan Durgut <ozndrgt@gmail.com>

Define the boot options for SC598 SOM EZ-LITE so the shared ADI boot
environment includes the expected boot commands for this board.

SC598 SOM EZ-LITE board environment utilizes the shared ADI boot
environment, but it does not define any of the USE_* boot mode selectors.
Without those selectors, the shared env does not generate the board boot
commands such as `spiboot`. This leaves the default `bootcmd=run spiboot`
without a matching environment command and breaks autoboot.

Fixes: c9e893d ("board: adi: Add support for SC598")
Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
---
 board/adi/sc598-som-ezlite/sc598-som-ezlite.env | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index c7d7932064a..ab1acabef53 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -3,4 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+#define USE_NFS
+#define USE_SPI
+#define USE_RAM
+#define USE_MMC
+#define USE_USB
+
 #include <env/adi/adi_boot.env>
-- 
2.34.1

