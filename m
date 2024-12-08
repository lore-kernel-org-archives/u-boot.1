Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A349E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 10:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C5668960F;
	Sun,  8 Dec 2024 11:53:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B1cyFgE2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28ECF893BF; Sun,  8 Dec 2024 11:53:06 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F1FF895A9
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 11:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa560a65fd6so623284766b.0
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 02:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733655183; x=1734259983; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kRyP8CxyMSJR5NVN6FWTKtTSuN3cdpS5UQMXPY2mLgo=;
 b=B1cyFgE26CjKpLPGufrlr6d46v9ZU27aj3mjFObPlZyVcWcSwD+t8SJXi6y3xYnNuw
 58oqI2dZQPRO0mPhs6Na+Avsmw20TDDp4IljcpH59Y9XX60F404WGKHsoyQr8ObXF74k
 dGBpWqOKRSSNdZeu1d4GQ47o+VwNocmFgyk40IySP8ulKVYw113nuTFKBE5O23+RRpBp
 aUY+P3Xk9Zs4AOvdCrJYSoMLO444Sjl63sWevPW467/5ZueT02+ZHIBJc6gg2+4/zQ8i
 2p5vhoK8z4kRQvKWrIpYevVHOai4DnQO3W1CRPRYCa3Dv1hr7HEu37+dCBaZTqZcQavl
 keiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733655183; x=1734259983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kRyP8CxyMSJR5NVN6FWTKtTSuN3cdpS5UQMXPY2mLgo=;
 b=fdyz2bpIfBImnCWlQCa86YB5ios6mo4LkMJu7JbIBs5NCRkhNsV+qbJPLGtPdg+aTD
 oMsfbqwpSRvwWLEE5PVAVzUMgiEdGe6NWZxl6CSoQQLD8VRqfTQ5vvgL3rviH9QTyyrk
 +S/9QxKUnSQhzWc4mf3t5eqWJSGocsGF9/pMxg1SfL2Tq3NVkO1IYxPBTb8nCXGKrizm
 apwYIUMCpfgyZXD1VhU7i71Ry1k1tIw9sjOjyOMbe633qGlgNA7w8SDKRgbt0BxY15P0
 IdD569EfUdqEaTDJGZ4O8grdkD7IXLfLb9sEkBQfmOaoj6RTBtg94i7aJncVpoKZ1Edd
 aQpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTXYmgaG3gPPCJCcvOBr0UPd268beYxPDNy2WSSiPMoknQ6BaJ98Id34rRVaFjaLmrNSZWGsk=@lists.denx.de
X-Gm-Message-State: AOJu0YzsY7q1JH3KA9L6Mx3S5ejloHSwasBNbY2701qOwtwhVvjQvuFg
 rqzkGn5ETdY/BNTtPLqmI7cC9alWKfOxJ6Aa46vKr+rTMuEvxVrFLpoe5NCu6co=
X-Gm-Gg: ASbGncs05Dfgvd12ORI6PcQZu1/c7Q5opQpG6NTRajUDYBjbn2LbCChzbts5jIw37Iq
 h6Od07ucahuJ/43/ejbXr9ynfEbeiI4VfvBRM/QYVFzd5IxhyQhxmrWWeN/hXa2zmTJyA7EOMf6
 pOmeBGv1ZQ2VluVFeERsisBViMyK3w3Jj8V1OjdAlX8yM6yn5j+MFpxOLVmuH6tzt4l8/+ctgM9
 wQ499qJiBh9hJpWsxfm4SQmJInudGmqFEdWzU21+5jyexI5tdgLv8yFNTNROR+RFY2gNfKNHRpD
 9PWczKq3MppBfJxUbbcnFy8jm1s=
X-Google-Smtp-Source: AGHT+IGxtrZWcGqR2zq2pF3i+1AV4WI0IUJH6s3BjlhDsE1uZoSck4C/lBX8n7c2ZMoKLvzS5CRw7A==
X-Received: by 2002:a17:907:1c0c:b0:aa6:7867:a3d5 with SMTP id
 a640c23a62f3a-aa67867d7f6mr138170366b.29.1733655183593; 
 Sun, 08 Dec 2024 02:53:03 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa625e92fe3sm517768566b.51.2024.12.08.02.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 02:53:03 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nam Cao <namcao@linutronix.de>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [RFC PATCH 7/7] lmb: Rename _lmb_alloc_addr_flags()
Date: Sun,  8 Dec 2024 12:52:10 +0200
Message-ID: <20241208105223.2821049-8-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
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

After all the cleanups of the previous patches there's not point anymore
to define lmb_alloc_addr_flags() and _lmb_alloc_addr_flags().

Fix the incocistency of the flags type, which one function was
definining as uintn and the other as an enum lmb_flags and rename
_lmb_alloc_addr_flags() to lmb_alloc_addr_flags()

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/lmb.h |  2 +-
 lib/lmb.c     | 34 ++++++++++++++--------------------
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index a35a69d69f77..4f3c861b15a6 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -111,7 +111,7 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
  * Return: base address on success, 0 on error
  */
 phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
-				 uint flags);
+				 enum lmb_flags flags);
 
 /**
  * lmb_is_reserved_flags() - test if address is in reserved region with flag bits set
diff --git a/lib/lmb.c b/lib/lmb.c
index c09f1a1277ad..67bde60b74be 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -777,8 +777,20 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
 	return alloc;
 }
 
-static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
-				    enum lmb_flags flags)
+/**
+ * lmb_alloc_addr_flags() - Allocate specified memory address with specified attributes
+ * @base: Base Address requested
+ * @size: Size of the region requested
+ * @flags: Memory region attributes to be set
+ *
+ * Allocate a region of memory with the attributes specified through the
+ * parameter. The base parameter is used to specify the base address
+ * of the requested region.
+ *
+ * Return: base address on success, 0 on error
+ */
+phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
+				 enum lmb_flags flags)
 {
 	long rgn;
 	struct lmb_region *lmb_memory = lmb.available_mem.data;
@@ -802,24 +814,6 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size,
 	return 0;
 }
 
-/**
- * lmb_alloc_addr_flags() - Allocate specified memory address with specified attributes
- * @base: Base Address requested
- * @size: Size of the region requested
- * @flags: Memory region attributes to be set
- *
- * Allocate a region of memory with the attributes specified through the
- * parameter. The base parameter is used to specify the base address
- * of the requested region.
- *
- * Return: base address on success, 0 on error
- */
-phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
-				 uint flags)
-{
-	return _lmb_alloc_addr(base, size, flags);
-}
-
 /* Return number of bytes from a given address that are free */
 phys_size_t lmb_get_free_size(phys_addr_t addr)
 {
-- 
2.45.2

