Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5A7EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 13:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D872864B9;
	Wed, 23 Aug 2023 15:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GCbRO5AI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EC9F864D7; Wed, 23 Aug 2023 15:42:24 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87427864CB
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 15:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34cafafa50eso9402385ab.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 06:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692798141; x=1693402941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lXaNRDfrxT8Xa/DtyJ33xxBE++6rAXMm/Q9dN/Bw8Es=;
 b=GCbRO5AING+a0fsAgdME6mv4BcDfqYjemveimuXBuTu5x8ZEMT0kBCsrBxuKuXlcln
 SmJIFaIBFEIBEJaw+JZzIP7eFf7f61Q6mxR8E/b012RcJhpwIkxT1J4UVMZ7pSgikwUM
 XSWEtHvkXK/gFw0irfzbfP6Jz0siEsRphx4Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692798141; x=1693402941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lXaNRDfrxT8Xa/DtyJ33xxBE++6rAXMm/Q9dN/Bw8Es=;
 b=euntD457PfHhyRfgm92gCFG46BK/+hmKLGFkYrW5MptZi0IFOBp+toXPOa8ObFnTcK
 TPNe0Z4qhMCY4gifnxtGQ/BxRoJVbMF/uM/U/EAaKAzUlwqkYkCCq4zurjSIjqjiXslx
 uEJ4PiPYCf/mOD8BqT2VH02Vyz/ctzAflySeGM1KarF+aQ88T7V6Y8Pxy6sLA83NJV+I
 fX6VOOR+a9FrsLvSnw6MVJYUkCaxPfWnuzhRogW1kNfYZEsQc/ViIE+DWBONCByiZ7/9
 xWwDTsSkU1HptHnsyHPj3JvqwirGYW8rCpoT/6HZdNIdUfut8L0hB/0T4DkmK0dLlcSH
 yWXA==
X-Gm-Message-State: AOJu0YyvEluWR0Fp8Uh+sHVuPOW/G7XjI0dlvBRL84FrZyusRgHTRsjh
 mntt+zLwn0we+wDkfOKJSdEK/JBKB7wntQzyMBY=
X-Google-Smtp-Source: AGHT+IGYtbWtzN+BDgQWchHyT0uQ54748WwOEBrYfFZxzN93bJbCIK5spRilqYBCbNe3F0RsQSsnEQ==
X-Received: by 2002:a05:6e02:104b:b0:348:7396:184b with SMTP id
 p11-20020a056e02104b00b003487396184bmr2412259ilj.24.1692798141004; 
 Wed, 23 Aug 2023 06:42:21 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a02cdcd000000b0042b4f9ddecasm3800233jap.85.2023.08.23.06.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 06:42:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH 5/7] lmb: Tidy up lmb_overlaps_region()
Date: Wed, 23 Aug 2023 07:42:01 -0600
Message-ID: <20230823134209.1450567-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823134209.1450567-1-sjg@chromium.org>
References: <20230823134209.1450567-1-sjg@chromium.org>
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

Add a comment to define what this returns. Return a specific error when
no overlap is found.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/lmb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index bf30e0dc90b2..5f2ea45c3ba9 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -387,6 +387,13 @@ int lmb_reserve(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 	return lmb_reserve_flags(lmb, base, size, LMB_NONE);
 }
 
+/**
+ * lmb_overlaps_region() - Check if a region overlaps a given base/size
+ *
+ * @base:	base address of the memory region
+ * @size:	size of the memory region
+ * Returns: Region number of overlapping region, if found, else -ENOENT
+ */
 static int lmb_overlaps_region(struct lmb_region *rgn, phys_addr_t base,
 			       phys_size_t size)
 {
@@ -396,10 +403,10 @@ static int lmb_overlaps_region(struct lmb_region *rgn, phys_addr_t base,
 		phys_addr_t rgnbase = rgn->region[i].base;
 		phys_size_t rgnsize = rgn->region[i].size;
 		if (lmb_addrs_overlap(base, size, rgnbase, rgnsize))
-			break;
+			return i;
 	}
 
-	return i < rgn->cnt ? i : -1;
+	return -ENOENT;
 }
 
 phys_addr_t lmb_alloc(struct lmb *lmb, phys_size_t size, ulong align)
-- 
2.42.0.rc1.204.g551eb34607-goog

