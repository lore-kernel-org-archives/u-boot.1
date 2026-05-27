Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AF8CD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 12:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ABC084855;
	Wed, 27 May 2026 14:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="MiLGGXsU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CD608341A; Wed, 27 May 2026 13:26:09 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 572F9803C6
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 13:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-516d65a15f6so52387841cf.1
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 04:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1779881166; x=1780485966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CIXhZDmPrA0JFbXFarkHjccf8LPO/e9bVk2UKat4cGw=;
 b=MiLGGXsUJSEy+SwCq9uea8mx4IqW72Lw6Nf2giuLllGBRzsPjYGqcf3UsFI6kss/4q
 waM+f3md3EijJZ03cjdjoOINw0LRmwPLspaMoIXzY5C748MBhczElUY4ZZWS/g7K/xNB
 NBSw9dY7yYH3wOSPOZel3huuRfOHJt4FhssdIY68Kbqru6FA3IBKN4n/nYiJEQeP82xn
 131mG29aPCxgzNjZeYW97sRtfaDD4TC6jvJARchO81+3oQCPAobJogpPixaDMSllToAt
 wAcyFE72DF04OU6FknSDELPMTOmZBolqjk7ZRHmj/cpywYi1ptOVRpw01rsvttMkOfzx
 bkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779881166; x=1780485966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CIXhZDmPrA0JFbXFarkHjccf8LPO/e9bVk2UKat4cGw=;
 b=k32eNzJZ2YZh0U8nXzJSkVPjZw3x4IQ3Qj5FhmsMEjn5pQl71zT18hHeRZ5nAsDICo
 vOxKcpokiqva0Xf9gP5UInZfTWPNcOipN+fYnewQlu79nP+kFJBpuKDxDCeRY4SKKImw
 Q/1hnSSrrhN3KNqNGlZlPp5za8mwS7ZYZM5jZUV/DNNWYhvNcQHcBBYinJV3OzuKjGqH
 SYRjvilSOuy9mcSIccgxPXelApc/53uDlFiSJmJfjdxgVo4C6ntQGlW8JONGCbxgxuDG
 851RGuGjC/Gk50/4iiPOGChuUxYNEa49BmBEk3x2Naf2B97y5EOSGjd1VUinw4YFhhat
 ZP3Q==
X-Gm-Message-State: AOJu0YxJrwSjHuAPMfwCZbScQyFE92cCMWBtWVoJALnjAslAY1D+ADRW
 0lvckGzDvedVL0OkR5sE+k7xKJclW5Yy1w8sT54Kz42eJcryAKWy0CEtLWS26HUASCSTEE4kMsy
 bPe0y7rzqaA==
X-Gm-Gg: Acq92OFtuMVZp2u2t3i1BBBnBAjTXEvNnFJMtW1KRdNGNRDa/ETW4uwVdlT4SbZyl66
 +hHFR43uG0Xwg4MGZ4lsCDLggwg4GyUXa7GI9gKAWBfKJxtFTauui/kyYbC1e5chqxOEdqJEaTu
 SDNoD6RWySOr0tPbee928NxunFV0/lgF008AB1t2Um8hEgttk7zkCHkakhm2SCc9qszEOOc0DWd
 wqFzv+vYHOH5oPz7ORaxcOyc4W+YX4xwHE0b327EVBBpNa9JPz3Wj72QoYTq/EKpkNXh/vNjPdn
 8/RiAsU6q1wtnzE7eblj/tliWPEYJQIv2rJR0CGzPHT7En56vo6YLZuJ8ps4LuNyAfq3b1wG+MY
 w+7dpXiVBQWeExc9nw7FP+vVSLtBwhUDxO0AoteQw8d+j++dq4yETSrF3EG5giptLEdI5dyME/m
 /0GLiwV8Y0hOtTshAKS/wsrZD50jEHwvsug3bs64AOHyEa4KDvN2gYgARu
X-Received: by 2002:a05:622a:1aa3:b0:516:ca56:a44d with SMTP id
 d75a77b69052e-516ca56a64bmr274567821cf.6.1779881166149; 
 Wed, 27 May 2026 04:26:06 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc355d25bsm588693366b.27.2026.05.27.04.26.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 04:26:05 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de,
	sjg@chromium.org
Cc: trini@konsulko.com,
	vr@binarly.io,
	Anton Ivanov <anton@binarly.io>
Subject: [PATCH v3] image-fit: Limit recursion depth in fdt_check_no_at()
Date: Wed, 27 May 2026 12:26:02 +0100
Message-ID: <20260527112602.18818-1-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260526105626.52611-1-anton@binarly.io>
References: <20260526105626.52611-1-anton@binarly.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 27 May 2026 14:57:27 +0200
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

fdt_check_no_at() recurses into every subnode without a depth
limit. A deeply nested FIT image can exhaust the stack and crash
U-Boot.

Add a depth check using FDT_MAX_DEPTH to bound the recursion.

Signed-off-by: Anton Ivanov <anton@binarly.io>
---
Changes in v3:
- Update From and Signed-off-by to personal email

Changes in v2:
- Rewrite commit message to be concise per maintainer feedback

 boot/image-fit.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index b0fcaf6e17f..0e225ecd0c2 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -41,6 +41,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #include <bootm.h>
 #include <image.h>
 #include <bootstage.h>
+#include <fdt_region.h>
 #include <upl.h>
 #include <u-boot/crc.h>
 
@@ -1643,20 +1644,24 @@ int fit_image_check_comp(const void *fit, int noffset, uint8_t comp)
  *
  * @fit: FIT to check
  * @parent: Parent node to check
- * Return: 0 if OK, -EADDRNOTAVAIL is a node has a name containing '@'
+ * @depth: Current recursion depth
+ * Return: 0 if OK, or error value
  */
-static int fdt_check_no_at(const void *fit, int parent)
+static int fdt_check_no_at(const void *fit, int parent, int depth)
 {
 	const char *name;
 	int node;
 	int ret;
 
+	if (depth >= FDT_MAX_DEPTH)
+		return -FDT_ERR_BADSTRUCTURE;
+
 	name = fdt_get_name(fit, parent, NULL);
 	if (!name || strchr(name, '@'))
 		return -EADDRNOTAVAIL;
 
 	fdt_for_each_subnode(node, fit, parent) {
-		ret = fdt_check_no_at(fit, node);
+		ret = fdt_check_no_at(fit, node, depth + 1);
 		if (ret)
 			return ret;
 	}
@@ -1696,7 +1701,7 @@ int fit_check_format(const void *fit, ulong size)
 		 * attached. Protect against this by disallowing unit addresses.
 		 */
 		if (!ret && CONFIG_IS_ENABLED(FIT_SIGNATURE)) {
-			ret = fdt_check_no_at(fit, 0);
+			ret = fdt_check_no_at(fit, 0, 0);
 
 			if (ret) {
 				log_debug("FIT check error %d\n", ret);
-- 
2.53.0

