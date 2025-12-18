Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572B6D711CC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8A4D83869;
	Fri, 19 Dec 2025 00:23:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eRU5ns87";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4166B836AC; Fri, 19 Dec 2025 00:23:05 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6A1F835FD
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:23:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4511744b411so599852b6e.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766100181; x=1766704981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aG1zl1ZUSLcO8xcgQkY6pQILhqlNgfSsjoiJHFfKBIw=;
 b=eRU5ns87sopwRIr1QO2vF0BfIKtYfMV+HRaGrRcdR9KB0zc96s0k8lgEb9yLNKpmGw
 EaOn0XNxySLvyk6Fz32JDe6BgHu5XHCA3m7Oh07jTTuJbAH74iPCDjsxg5uTtB1vh8zK
 tP7hY8IbDsQLLchKDcuFIvQ+hRtCNZlO7HOss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100181; x=1766704981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aG1zl1ZUSLcO8xcgQkY6pQILhqlNgfSsjoiJHFfKBIw=;
 b=XTrk2+MgwTnV5+fdnYiDeTY/5QUfDwAvnf7UQuRMdQpibYDhFILbD8+vXhDJcx3wqp
 gs+IaMbJ0BD91Vst8MdwkZKH/FuCmBvpRlKoU/8kVet/zrJ74oDO2j3PyqhS4o8vLEJY
 u4OqJggklHsf02ZChJKiBC3TGKXQ1kdqP97Z+Y7nR77/i7TM5ij93Z73WwXrbuXx0+v7
 Np6ik0sDTZ8oIvg1pwSe+ULSgMBsthl0sAg3QKq3XCpfpOUPYXVf8QPpTGlBRuPXi30W
 dLZuNpLuz1Qovw9uq/j+oDmARznPfxI7qLBILKZFeD+Xos0c/5ni4F7WZGjIpEiZ+R8y
 T3qw==
X-Gm-Message-State: AOJu0Yw52W+GsCTHBa4DIIL1jmGGue5E13o867UX2riQOwhqSK5M3v3b
 6mIdRf6DrHof8HkA7SQhS7Awv1lvv7sOEkeJqd/4Zmsdig/wdYiojX/a1+5HfD6yKupPoiJnVu1
 czCo5BJM=
X-Gm-Gg: AY/fxX6iIDwIJMYCEH8+Dw34fDLcIwt6jEqTulaWH1ft9wGm8sYm0P9RKFVkWiezEAu
 AgsSupqlZtASFMacikZpYOIWEiAgWVPQwPGKtvdzwIz/JDWV/SPOwmCVj3dOxnUEhnyhV7fC1X+
 isC0rUFyxQ6stx9xlUun7dSUHL9m1RNQ7up7TJZc6JXOmmmjjIijpk2uonRwlBBe/wSEXyAZUw0
 +M1wB74PyOITEAc5wE1M/+BiCSRhkjktDl1yVNXjrg/Tjl9fLXadANRwF9CLHcdhrWOwHJGE+lE
 vAQut/qpRA+FHUmToRg3oCzPyMVMZXo69Kwn/PswiH65ajXXPMjVr9GvnXmwrqebZEHbq4wjWHF
 oTztpi4TwDXM2TxM9TDZGlqz2X0N6kzreWtgNdRvJq7HpksMNkUaG9/bkEHhbbsFv/nLXcrDkM5
 T5WWOCbAl6ESxKn7NNKYVkslDT3wE6iqipfJEXJukz4rg48Gj1x32YzyLzFan1ITs=
X-Google-Smtp-Source: AGHT+IE/2gOwcS8p4vSTsEhm7oCKjU8OKCe9lnQxT3TllwBK28E8C8SCrIeqjIZqyqUwnPOIedjEGw==
X-Received: by 2002:a05:6808:1a1c:b0:455:dee5:8b58 with SMTP id
 5614622812f47-457b20608e3mr723344b6e.20.1766100181307; 
 Thu, 18 Dec 2025 15:23:01 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3cc0928sm295333b6e.10.2025.12.18.15.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:23:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Darek <x64x6a@gmail.com>
Subject: [RFC PATCH 3/9] lzma: Update 9.20 -> 9.22
Date: Thu, 18 Dec 2025 17:10:15 -0600
Message-ID: <20251218232255.3934258-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218232255.3934258-1-trini@konsulko.com>
References: <20251218232255.3934258-1-trini@konsulko.com>
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

These are only upstream changes and nothing local.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 lib/lzma/LzmaDec.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/lib/lzma/LzmaDec.c b/lib/lzma/LzmaDec.c
index 954380af52ab..c6ff8ef26758 100644
--- a/lib/lzma/LzmaDec.c
+++ b/lib/lzma/LzmaDec.c
@@ -1,5 +1,5 @@
 /* LzmaDec.c -- LZMA Decoder
-2009-09-20 : Igor Pavlov : Public domain */
+2010-12-15 : Igor Pavlov : Public domain */
 
 #include <config.h>
 #include <watchdog.h>
@@ -455,8 +455,9 @@ static void MY_FAST_CALL LzmaDec_WriteRem(CLzmaDec *p, SizeT limit)
 
     p->processedPos += len;
     p->remainLen -= len;
-    while (len-- != 0)
+    while (len != 0)
     {
+      len--;
       dic[dicPos] = dic[(dicPos - rep0) + ((dicPos < rep0) ? dicBufSize : 0)];
       dicPos++;
     }
@@ -984,28 +985,22 @@ SRes LzmaDecode(Byte *dest, SizeT *destLen, const Byte *src, SizeT *srcLen,
 {
   CLzmaDec p;
   SRes res;
-  SizeT inSize = *srcLen;
-  SizeT outSize = *destLen;
-  *srcLen = *destLen = 0;
+  SizeT outSize = *destLen, inSize = *srcLen;
+  *destLen = *srcLen = 0;
+  *status = LZMA_STATUS_NOT_SPECIFIED;
   if (inSize < RC_INIT_SIZE)
     return SZ_ERROR_INPUT_EOF;
-
   LzmaDec_Construct(&p);
-  res = LzmaDec_AllocateProbs(&p, propData, propSize, alloc);
-  if (res != 0)
-    return res;
+  RINOK(LzmaDec_AllocateProbs(&p, propData, propSize, alloc));
   p.dic = dest;
   p.dicBufSize = outSize;
-
   LzmaDec_Init(&p);
-
   *srcLen = inSize;
   res = LzmaDec_DecodeToDic(&p, outSize, src, srcLen, finishMode, status);
+  *destLen = p.dicPos;
 
   if (res == SZ_OK && *status == LZMA_STATUS_NEEDS_MORE_INPUT)
     res = SZ_ERROR_INPUT_EOF;
-
-  (*destLen) = p.dicPos;
   LzmaDec_FreeProbs(&p, alloc);
   return res;
 }
-- 
2.43.0

