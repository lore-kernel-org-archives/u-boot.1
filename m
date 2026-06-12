Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977B4CD8CA8
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 11:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE0548056B;
	Fri, 12 Jun 2026 13:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G9gkLuYL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C463839A8; Fri, 12 Jun 2026 13:32:22 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7182D8005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 13:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490a76757e5so6406675e9.2
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 04:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781263939; x=1781868739; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1v87gPF9S4cl6EZhy0rUDG1HK4EqYqWKrVKzr1Sbzdg=;
 b=G9gkLuYLiOTy06DVNEwNdg+oDBT77WZnH99CMvtpAQiSy9SEa2FQUzu4T3X8ePIfeV
 gX0L1Tq7P2uSbovz3iOupu9PDl+PWecMVSSMOBVPlX/um87Tx6HZ4vN7py4DjsU+PiRa
 JaERtAODdq0gQ6XHd6jnkNd33s7BboD0Dh6ft7BhiZd8Lib+B/YwNvTwcO/4QE02i8Nx
 M+OxcpuR1YaAr4xw27d0RfqsQiSZ6Pn6wHo1jClW4aPUt8eAG3P2vVsKd6qcDR7+dP8/
 Q0a9XNoidI+liGi/GyIk2Z2/Onwo/9XeUFpDegOVcSTudHB38M2NV077dXxxjqejv8bi
 d+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781263939; x=1781868739;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1v87gPF9S4cl6EZhy0rUDG1HK4EqYqWKrVKzr1Sbzdg=;
 b=mE1TkAXXRraWDob8sgMJrGnsmJWewNNSSMzDdeFKaG8EcUBjQZPU2t/bPZuli1fLs+
 lZKob1J6ZZOMASJIt2jljxeKiKjplAtf3CsYiCHR/vK1jvwkhEybMUI9vaJm4JyMp2x9
 cyjVrwgJFFwa4TTvxdJmdcDbvPYtuSOlQ+JW/C1OZH2TfU6ArWs233ZutlNi2bc9IUR/
 oLDrgtjpeaDeu7gPVcDFDpp39Jz66vwQoj6oCGbZoJ1apyIPVlZgDYH9kXLPmv/cbq0L
 gdWpkXuLCnDbTv/wLrp80ZjLBbuG4ndwlMu7fIh7rj/5+B/s3p+WF/zwxLqMO6RF4FP7
 UGeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OCVCmfNLKlvc2KxKL+TkxEiI+i5uuujnEwxSDKrXsy99nVYgTOnCAdlpHk13JCn6jhK+yYZg=@lists.denx.de
X-Gm-Message-State: AOJu0YxzMler6w7jsf/AHYKin7U4t/q48TghX6fojAlPXOZSQltgQoq9
 L9fwwxF2aWm6zq4Oh1xAMdrvw0AQysnnW9PxM8DH3+21HF0I6jyQgxnYaIS6X4jVJGU=
X-Gm-Gg: Acq92OGHQh46j53X46a7OjPcFwHsmnSEspwHRoBRYdTtwx9Rmq9oVCT0YnZS5QNF1CH
 KMJWwMf0FEtIgkhZO+WAOoJMIqYuhj5fcY807jt6Yr4rdPVsBsI3wcTog0/A2T3RzW7SCSIEyzZ
 l00S5n8PzxUGtVLEPfWpr7Fw7ScAP9ZO92sSdx8IBE6jN/5OvpPGPnrRQSbvS+6r1V+wCXdHTQQ
 KNAOn2nNHUXwWCNbJ75hroFffWFqL1l8izH5+OEXyRfUGOz0ql+F5ymxB/C52Fi2bBHYG12J9Lr
 HJ7wRFwYBCmoT6Gj1H9/yyNAMQbogwr3s0xMBoDD3vxQDOFT85sXmZbd8EeJQAEL8Xq2UMeZlww
 5bkamr42he6MOtS2m6SjP0Bp2CkqWwtY8Q0yYpxcCoSQ7TyVwdTYehM7KFx7xFh1BwjvANItz0N
 RFmMFwqGm9rG4ynY4tglmGxk0aVWVOBr5bAa0dcPkAPQ2RsdjBPZhe5Xq4CmJQ4JpBMxfHJ0++F
 w==
X-Received: by 2002:a05:600c:3153:b0:490:b8e6:be40 with SMTP id
 5b1f17b1804b1-490ec4fed29mr32159005e9.21.1781263938838; 
 Fri, 12 Jun 2026 04:32:18 -0700 (PDT)
Received: from lion.tail248178.ts.net (p5b29e032.dip0.t-ipconnect.de.
 [91.41.224.50]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263923sm5101905f8f.2.2026.06.12.04.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 04:32:17 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Anshul Dalal <anshuld@ti.com>, Casey Connolly <casey.connolly@linaro.org>,
 Dhruva Gole <d-gole@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] armv8: mmu: don't panic when unmapping a page which isn't
 mapped
Date: Fri, 12 Jun 2026 13:31:00 +0200
Message-ID: <20260612113144.458665-2-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.53.0
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

If a caller tries to unmap a single page which is already part of an
unmapped block, set_one_region() will panic since there isn't a valid
block or table to contain the page. Detect this case explicitly and
return since no action needs to be taken.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
Depends on my previous series which fixes unmapping regions

https://lore.kernel.org/u-boot/20260608-b4-mmu-unmap-fixes-v6-0-ac0764cccf40@linaro.org/
---
 arch/arm/cpu/armv8/cache_v8.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 6c85022556ad..472887b5d99b 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -1003,8 +1003,13 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
 	int levelshift = level2shift(level);
 	u64 levelsize = 1ULL << levelshift;
 	u64 *pte = find_pte(start, level);
 
+	/* Trying to unmap a region which is part of an already unmapped block, nothing to do */
+	if (pte_type(pte) == PTE_TYPE_FAULT && attrs == PTE_TYPE_FAULT && size < levelsize) {
+		return size;
+	}
+
 	/* Can we can just modify the current level block/page? */
 	if (is_aligned(start, size, levelsize)) {
 		if (attrs == PTE_TYPE_FAULT) {
 			if (pte_type(pte) == PTE_TYPE_TABLE && level < 3)
-- 
2.53.0

