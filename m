Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56CAFD9E1E
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8D2683E96;
	Fri, 27 Feb 2026 00:01:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N5RVEGQe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D76CE83D1A; Thu, 26 Feb 2026 22:27:46 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3AD183642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 22:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-59e5ea93a1aso1230053e87.1
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 13:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772141264; x=1772746064; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vNNuuq9SjWJBUMJ1CcV8K0fwTD8oMtC7547+HsfwMpw=;
 b=N5RVEGQeS2A5+bRbX1PAGdmj4W3O7EXwsIOMS0bt0SH0ZbbDu7myXJR/WKL9A0isox
 IZXPKB356vDa7wGQyoopcD1os4zweX7OlcI8Hoy5I5Nu/MBpLWezQYW/LSmTAhluvK5n
 to+/d1kUs8pniWCIWkuJ9xHp/4+6NbCtA7SiQI6GJo7nSckGkBznR5XCtV2Pf1Uf1sHF
 sonBS+0TjZl8KpgQjIbSuvtTM69tI5NjPpmVFRhud5XgJHRtKvOCLGWu/qm4i2+ipf7U
 CYXHqUr1PvL17tCfSbSUiGvZP2T94oeok47GxS+QCt9j5CCEq1fZ2coFEddFLWTWz4+D
 izfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772141264; x=1772746064;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vNNuuq9SjWJBUMJ1CcV8K0fwTD8oMtC7547+HsfwMpw=;
 b=V/KX3PB2ikrCNwF24TmHDUoa5hIa+0ffFtn2aRelY5qiB7y1V7JXBB4mhrN41NPvow
 +J21uD4kFJuRpgTY7+HfP4mjszoVyXko0KhuDSMb2WPU/KdL63HzCikB8oID4DiKT3Yv
 SBI68yAx7am4vJt5HVBHZ1oVPnjypV8xq1vBhdy21pbMEET6StjhVJ0dKjbi11nWp0J3
 BWVcb0vjjjFSd579mMHuV+81nbs2Rm5oQXUph7k1t16VCxO8/fSiRCDwBsr2GPH8AfYy
 VlNldEK2oJPiJQAPRoIArTxwSvY4IzzRIHYL2e3B9r2VVZuuP1Eji0G38BvcMrm0Ho1u
 BTLw==
X-Gm-Message-State: AOJu0Yz507Sg7Jcotbp//S0ez75tNGzGCCBUaX3BEVDK57RgGaKNKTt2
 m3bODHdJ/yUGMR2hNrkH/MwyQG1qHKGl7WOZtbNmmUU6VjwRxXyz9vK317gfXBRH74w=
X-Gm-Gg: ATEYQzydVrlRI+L3mMYxylDPpdPL/ugxsFNxQUhEneo2kjsArfHlDp9/VTsEQjpAxF4
 xrvdtAnsijI5bLDpilGajNJRLJORJJAm2BX7v94KeJxjCyEuJVl73iiEXF2L6oVB0TDBLi0smyn
 KVd+fp6BJauQipjZIBqfrThTfIDGnBCAaCGpsvRDYeoijlt8JescKPLxOfOkcTIpI+fTR4jqHPK
 2yYTEcV4U6/4XPC03NWGoYP4zEVOrdYQI6urUPZmQJLNiKxYqDuY0mTwfmW6HaWN2ZDBBGd637a
 7aj+AtNzdmwcU4Nf8S4P3/3BKsG79xg7rdMhRM4Xl7cHy9gfT6u1gGhBeBlEg5lDy3+mJNaDQ76
 qV2u3JbrdMUfG4ckqXkajlUCoI4m28KpCLL9iZ74kgc+74yK48wj8fjmj4qo5kAsBPDpRm33Zrr
 axDlJfE8E3WRF/mYndLz49i5kihtZzq2yMEwg5VEWAMuzf7uWHgWb/5ZAbFe70I1fJhBseqjbln
 0r9u6+JQC7MLEIoux4PV3ihl1GXAZZC3opPr34bIqR79Os4
X-Received: by 2002:a05:6512:3b8f:b0:5a1:4c8:a622 with SMTP id
 2adb3069b0e04-5a10ff833a5mr194083e87.1.1772141263690; 
 Thu, 26 Feb 2026 13:27:43 -0800 (PST)
Received: from lnb0tqzjk.rasu.local (46-138-124-225.dynamic.spd-mgts.ru.
 [46.138.124.225]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a109de967csm1336783e87.83.2026.02.26.13.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 13:27:43 -0800 (PST)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: u-boot@lists.denx.de
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] linux_compat: fix NULL pointer dereference in get_mem()
Date: Fri, 27 Feb 2026 00:27:28 +0300
Message-Id: <20260226212728.61889-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Feb 2026 00:01:16 +0100
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

Add NULL check after memalign() call in get_mem() to prevent
potential NULL pointer dereference (CWE-476).

The function memalign() can return NULL on allocation failure.
Dereferencing the returned pointer without checking for NULL
may cause a crash in low-memory conditions.

Changes:
- Add NULL check after memalign() allocation
- Return NULL on failure, consistent with function semantics

This fixes the static analyzer warning:
  linux_compat.c:34: dereference of memalign return value without NULL check

Reported-by: static analyzer Svace
Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 lib/linux_compat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/linux_compat.c b/lib/linux_compat.c
index 985e88eb397..e4a3293e3af 100644
--- a/lib/linux_compat.c
+++ b/lib/linux_compat.c
@@ -32,6 +32,9 @@ struct kmem_cache *get_mem(int element_sz)
 	struct kmem_cache *ret;
 
 	ret = memalign(ARCH_DMA_MINALIGN, sizeof(struct kmem_cache));
+	if (!ret)
+		return NULL;
+
 	ret->sz = element_sz;
 
 	return ret;
-- 
2.39.2

