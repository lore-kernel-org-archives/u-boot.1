Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15E1C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 13:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29C5C84AC3;
	Tue, 30 Jun 2026 15:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QWwPtKwt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 430AD84A86; Tue, 30 Jun 2026 15:39:45 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5847084A67
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 15:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shofiqtest@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5aea9d606f0so3847683e87.3
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 06:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782826782; x=1783431582; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eFj2L/otFA5Kiz/DkkZ0peWQbVlheawVZyyXg+ZRJGM=;
 b=QWwPtKwtvclvDJbfNXJmt1bh1C2Wzc3hOPcuzLerppJ3byyDr2aZJbPIhYheO+l+Gu
 wkQ39eKJs4i1B5oVH/wRFGmxbYpoNBVYEFLV7ElQVWPw6aIB0NB0xrvhZSBgmAA8n3c1
 PfHdt9RFoc4HYh3eo3TBRoIJ2Z6OuIbyvQEZCn7wzxF5ex3YP5fdTZFvIHks0CMizeSV
 2MCWGsh3oe5mqDwXwEWGDrR4L3LvTdlnoAAAPolT1SAqchLlbU0431dEC9KST3gXuEih
 c3exuZfZtVAFlR1XBHQmf6oFkgOu8Mr29O3yiCDagOVu0e76LUQ2KvWPMNBhI/d+f4db
 rR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782826782; x=1783431582;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFj2L/otFA5Kiz/DkkZ0peWQbVlheawVZyyXg+ZRJGM=;
 b=aTgC5i69Hm44V8CG+S620xBsiL4+22ZHYakmsVpGxXWjho6FdwQGKjXHpmY1iQMxol
 Y02aCG2TBDoBs19tmww/LhX/m0wVyfkzZsfab3B7dEGS2YXZ6N63ROeNCbAVLsnt/xyu
 e9+joYmVdz5Q4yqQOYh8CAT8oT3s9v7Vxpfbxonx2EiErtG0+5pU8JKSRq7fk7S0Pktf
 8SLWrIfCZ5qqFH44moIFT+b1quxJZlDiZlp+nwnszjUeUcLSPXXIMP+VDLW6I7YP7+70
 xf/KObcCxjt/geSpQNGz/UBFMd5THB22TV6liJKwRGEuXwp4YGrmBUY5DLz0aac3WSVR
 8Z4A==
X-Gm-Message-State: AOJu0YyDBVfvZUXquh4neGu5XZJQM7XhpYQWVu8O52gr50Q3rxoWUnBM
 VjIAZ7B81iQEe3536BhcasAscttvAiEffTfhKyrbEwGor6wBy2ZN7aBsIQGlIhcvXh5BMA==
X-Gm-Gg: AfdE7ckywxfFfzJmHOaXDopepwk4dusLe7sEpasRaGric8jnhqeVFduxD94c4/78h0e
 /vquv/qN8/FeatrQrHCRwbC9R86U5cLryLbZQfjYWf7fXgWaXOYz+u2UdfBdsusEHI0bZ+prtc1
 /lTq9hM1ENd12600d0y2x/0TFLi43Z0SvTLta0edA8h4kAFXMDp/WodK2zIvyNp+pR2Xdb0Gi3f
 7eJj8qm1rw8ohKgfr0ffMJ36nLWMhtwMFS8dctiUOpTd4EehWdUBRXsCILnWVMvPNoRpR5Eoytz
 CLaNGVzxLTAxWuvvq5vGIX+Qjw8fYUTKtVLbjUlj8Tjh9pH4oxANLaJKB8UCawrBDZhe+1/sCfQ
 YjfE7wBWDb2HYPLP38p4SrBFS8/tOURZ+GzmiDj8mky0fe5rx0vTlKiWenb7+ih7/+ODB3/0rw/
 OCSU9Nu/pMN+P9OFzccEGZTCsu7AQe3OZYvfN+YOWE/tE5Gg==
X-Received: by 2002:a05:6512:1248:b0:5ae:b2cf:8204 with SMTP id
 2adb3069b0e04-5aec10a3841mr268575e87.2.1782826782092; 
 Tue, 30 Jun 2026 06:39:42 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aebe33378dsm587003e87.1.2026.06.30.06.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 06:39:41 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: u-boot@lists.denx.de
Cc: ian.ray@gehealthcare.com, HuanWang@gehealthcare.com,
 Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH] ge: common: vpd_reader: fix errloc array size in verify_bch()
Date: Tue, 30 Jun 2026 16:39:39 +0300
Message-ID: <20260630133939.1472106-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Jun 2026 15:40:02 +0200
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

errloc stores bit positions of errors returned by decode_bch().
The maximum number of correctable errors is ecc_bits, so errloc
must have ecc_bits entries.  The array was allocated with data_length
entries instead, which is the number of EEPROM data bytes -- orders
of magnitude larger than needed and incorrect.

Fixes: b418dfe16e62 ("board: ge: make VPD code common")
Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 board/ge/common/vpd_reader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/ge/common/vpd_reader.c b/board/ge/common/vpd_reader.c
index 2422db38013..b3f9e96615d 100644
--- a/board/ge/common/vpd_reader.c
+++ b/board/ge/common/vpd_reader.c
@@ -66,7 +66,7 @@ static int verify_bch(int ecc_bits, unsigned int prim_poly, u8 *data,
 		return -1;
 	}
 
-	unsigned int *errloc = (unsigned int *)calloc(data_length,
+	unsigned int *errloc = (unsigned int *)calloc(ecc_bits,
 						      sizeof(unsigned int));
 	int errors = decode_bch(bch, data, data_length, ecc, NULL, NULL,
 				errloc);
-- 
2.51.1

