Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45682CD128A
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 21:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56408882D9;
	Sun, 31 Mar 2024 23:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L39LKsnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75D7187F77; Sun, 31 Mar 2024 22:03:43 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 876D687D45
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugeneuriev@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-515ac73c516so3548229e87.0
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 13:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711915421; x=1712520221; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wVkt/rIBjeu9Yqfi63A9RbaAeLYqqut84gRhnOzbIZM=;
 b=L39LKsnU76p3f7c0JQxZGwNK9sswMDzU0uKh4iy199DLbhaXdqrNIETeYfl56gXPge
 noXiDzhgNqhlkpDPSVXLYG+zKGqY89GRpNpCkcngNmoZBjIUaD17SoV4W6/jRdNwe5Pi
 Cfm9ooeHLPdPhzByU0lcN/42RSU7CghB/XQBFDOKz6io3TTq/A7krVOmfJBxDFH58Meu
 TV29bCt6sxP91YQ7j2VDI/exfUQ24qSOyH16USkxqtWoHtsN3UTd2krplboNX7ONn/sV
 4Yyufe8mEyzB8iA7Dc87YzyYjtBMqutEsssngcox6PXxiwl7CAtiICTFJwHEdjJJu4YU
 sGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711915421; x=1712520221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVkt/rIBjeu9Yqfi63A9RbaAeLYqqut84gRhnOzbIZM=;
 b=kHaPg45jJr32Th65y3m2TADonjh77vUiJt2c+OplKgrX/VCVyWVoBYfzfoTAaCzgxY
 /p8Vk85Iupf7QMZENaGJTXmR0bIdmdFiF0Wag7Ow6O6eSvs0eWrTS3fcPrfYUv/2Gg16
 ky8+BSAMXlgpWil24x5Gv2LRZ9BOEuLPuc+lvC1/7GJkd7D8SeKPoSFBrXOLX9qzPByq
 soWmSvLRf5uYnZNoR22ftOawQy3p/l/q3//zsfO74ySfsY9E8m9OVigC1ZjJ1hOsc6tN
 ojFCSjmI3o/egPInaxqYYlOl1WyJVZA24RJdO2FWYqIHOFIAXosFs0YYp2AsKvkSfNzO
 MHUA==
X-Gm-Message-State: AOJu0Yx6eIetWqMGQ2j/wuY4/Exs8IGVDlfV4s0VV+fZv2XmuMKV1cGj
 8b9IieO3t0ykp7LJI6v3Pkq5TYd8FA6lmwW0P50a1yA7kEgCtpAz
X-Google-Smtp-Source: AGHT+IGDYBdhxsYcGBueqog56ZpQk8Xq91TQ6hZMISkWw6KjLcXctzfMmB8yhZ+0KbQNNzMFcmugzw==
X-Received: by 2002:a05:6512:3102:b0:513:dd84:a088 with SMTP id
 n2-20020a056512310200b00513dd84a088mr3975833lfb.21.1711915420761; 
 Sun, 31 Mar 2024 13:03:40 -0700 (PDT)
Received: from BlackProtonRN.clients.gtk.su ([185.16.100.35])
 by smtp.gmail.com with ESMTPSA id
 l5-20020ac25545000000b00516a08ce8f8sm425000lfk.269.2024.03.31.13.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 13:03:39 -0700 (PDT)
From: Eugene Uriev <eugeneuriev@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Eugene Uriev <eugeneuriev@gmail.com>
Subject: [PATCH 8/9] mcheck: add stats, add a comment with test results
Date: Sun, 31 Mar 2024 23:03:26 +0300
Message-Id: <20240331200327.29141-9-eugeneuriev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240331200327.29141-1-eugeneuriev@gmail.com>
References: <20240331200327.29141-1-eugeneuriev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 Mar 2024 23:00:15 +0200
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

My tests have been run on an U-Boot (of older version)
for ARM (64bits).

Signed-off-by: Eugene Uriev <eugeneuriev@gmail.com>
---

 common/mcheck_core.inc.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/common/mcheck_core.inc.h b/common/mcheck_core.inc.h
index bade03598f..2f11ac567f 100644
--- a/common/mcheck_core.inc.h
+++ b/common/mcheck_core.inc.h
@@ -48,6 +48,13 @@
  * rather in compile-time, by MCHECK_HEAP_PROTECTION macro. That guarantees that
  * we haven't missed first malloc.
  */
+
+/*
+ * Testing
+ *  This library had been successfully tested for U-Boot @ ARM SoC chip / 64bits.
+ *  Proven for both default and pedantic mode: confirms U-Boot to be clean, and catches
+ *  intentional/testing corruptions. Working with malloc_trim is not tested.
+ */
 #ifndef _MCHECKCORE_INC_H
 #define _MCHECKCORE_INC_H      1
 #include "mcheck.h"
@@ -70,6 +77,8 @@
 // avoid problems with BSS at early stage:
 static char mcheck_pedantic_flag __section(".data") = 0;
 static void *mcheck_registry[REGISTRY_SZ] __section(".data") = {0};
+static size_t mcheck_chunk_count __section(".data") = 0;
+static size_t mcheck_chunk_count_max __section(".data") = 0;
 
 typedef unsigned long long mcheck_elem;
 typedef struct {
@@ -102,7 +111,7 @@ static void mcheck_default_abort(enum mcheck_status status)
 		msg = "bogus mcheck_status, library is buggy\n";
 		break;
 	}
-	printf("\n\nmcheck: %s!!!\n\n", msg);
+	printf("\n\nmcheck: %s!!! [%zu]\n\n", msg, mcheck_chunk_count_max);
 }
 
 static mcheck_abortfunc_t mcheck_abortfunc = &mcheck_default_abort;
@@ -173,6 +182,7 @@ static void *mcheck_free_helper(void *ptr, int clean_content)
 			break;
 		}
 
+	--mcheck_chunk_count;
 	return (char *)hdr - hdr->aln_skip;
 }
 
@@ -212,6 +222,10 @@ static void *mcheck_allocated_helper(void *altoghether_ptr, size_t customer_sz,
 	for (i = 0; i < CANARY_DEPTH; ++i)
 		tail->elems[i] = MAGICTAIL;
 
+	++mcheck_chunk_count;
+	if (mcheck_chunk_count > mcheck_chunk_count_max)
+		mcheck_chunk_count_max = mcheck_chunk_count;
+
 	for (i = 0; i < REGISTRY_SZ; ++i)
 		if (!mcheck_registry[i]) {
 			mcheck_registry[i] = hdr;
@@ -283,6 +297,8 @@ void mcheck_on_ramrelocation(size_t offset)
 			printf("mcheck, WRN: forgetting %p chunk\n", p);
 			mcheck_registry[i] = 0;
 		}
+
+	mcheck_chunk_count = 0;
 }
 #endif
 #endif
-- 
2.25.1

