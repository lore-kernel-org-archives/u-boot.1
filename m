Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CDDCD4F52
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 09:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FFF68469A;
	Mon, 18 May 2026 11:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DPzlNTSU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FFAB84676; Mon, 18 May 2026 11:01:01 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F13E983EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 11:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48fe26a177cso12821435e9.1
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 02:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779094854; x=1779699654; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q5PKZ0zUS0IYiu6+bPNCP2JdmK9qxjXm4M3I4UvOha4=;
 b=DPzlNTSUPH3ODpaMxPjL7a6Na73ngCf7jH66uXE7O1LV5JsEK5UbydFDNZO7OBYn++
 Yw4hCye2QDU/+QE3iEgRaodyChsQrcV7jgKQNG2WDokfrSEiLuku9u/cXHjTixu347gP
 XhABo+yzLpJP9C2XojBNZqyAcfBqoLPhVc+PnKgJHiDOKiqfAsuh0F2LeKZM35u3SZ/U
 MHnX8wURBIJz0EN5UBoAAN+iqKXQlqAll1qy4hI2kzjMufivElE2hRA3Xh/my19DpgTF
 l156y8fY6R9ZUpuOf1K3+Mv4ohS0FT7QOCX9YwniLsG65OvNMspEtjXoC8MfQgY1eOD2
 bS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779094854; x=1779699654;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q5PKZ0zUS0IYiu6+bPNCP2JdmK9qxjXm4M3I4UvOha4=;
 b=RpJ9WdG7ik+6MNtymfGZn1hoKA/JRhAx18iPrYVNhpX2rh3rfamFmkl4P4+Hhw7Hif
 jBQ/VeAeDESP+3F1hw96fuEmgIzMs8/f9BKEwSMA4Ybsl/tlg++AGVVBjVqtYT3CB9TI
 FipLevtrlvU3UKo3ekrG889aWKIv9SU90XoqP53Kms/+avXJklBNgpGRDeptHHB84ZuA
 MybtP2Y5FcIGhx9Tx/czNT9Ye6tM94ted0h3nwNg16SMlia2NPMTescsogAwmCBGtrWV
 7wVsCQG4/vaqh5zXPsc14yQzijkkgf3HNhnXGIPkdoqTIzpVYWaa/5p+ZQChzgszbiTX
 9B0g==
X-Gm-Message-State: AOJu0YwWr0IKooHpJ5z8JjzRk1k6qtfC4gMWCOFnSMUJQLWc2/KrF4SY
 hVMlARYJwFkinyoCAkn/zch5cy2SC1+3qpjQ9E9gXenna6Fp3X7OewQYj0iryYuTsQ8=
X-Gm-Gg: Acq92OEGHKWDGGqcF1oVW6VVNXpQM83dlIssoaP3TNZ0++JSPv4YAtZC/zTsdNLUN15
 qAK+pGD+strOi/oTjQu4m9JhqqYjVWOiZ0m3eLZ/AG4NxFIzYD7ZZDKgpwFAKmJlj4gXLe2xJdU
 eoMEttpPhPFuM3fN3uweKxkhlq+OqB1TpI/AkJBGz/bq8BP9Q7U9tpCJczFijXOmH35mXQFp08n
 NsMQ4sFtG4p2UORvaU+lzAmnTxnt6n8ppFmbWYjHTqfL7wI+u7JsockPZFweJCh6iOJVQXv2Dw7
 iZhyL0QI8Oh8YqNTa6lMVVkHyXgV77VI7EzKmtYJ6gzFr6heuNnZkXV1tNmsprLQ8UP81Ep8x97
 Efp4+ykaOG/c9dknIqepvAlKFGcT9vHs5RX8sBT32q5xEWP/kQ5qljWZf+t7+wKu7qurQ15OEYp
 1WgkD66jeb02qZpjoEbkWrD2IGvJAH144m3A6TLfWxXVhRSZnsCtfaIvrXUQBYTcRwjlA3YJPxL
 z+Oonk=
X-Received: by 2002:a05:600c:828d:b0:48e:6db3:ff2e with SMTP id
 5b1f17b1804b1-48fe61eb313mr207224965e9.15.1779094854331; 
 Mon, 18 May 2026 02:00:54 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5ab3977sm265269425e9.9.2026.05.18.02.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 02:00:53 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v5 0/4] armv8: mmu: fix region unmapping and optimise
 set_one_region()
Date: Mon, 18 May 2026 11:00:49 +0200
Message-Id: <20260518-b4-mmu-unmap-fixes-v5-0-7802245a40a2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NTQ6CMBhEr2K69jOllBZdeQ/jovQHaoSSFhoN4
 e62uNHEuHyZmTcLCtpbHdBptyCvow3WDQmq/Q7JTgytBqsSI4IJwxXm0FDo+xnmoRcjGPvQAQr
 DNSaSSaoMSsPR6y1Iu8v1zWFublpO2ZQbnQ2T88/tNZa59/cgloBBCMk5Yarmqjrf7SC8Ozjfo
 vwQ6YejID8dNDmMaGpMDKNcHr8c67q+ACwm+YgLAQAA
X-Change-ID: 20260507-b4-mmu-unmap-fixes-1f7e02c6c4df
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2155;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=cuih+zXOzi2iv1dBeRK4kGcQTGk/KUYG2ONzWSxYqUY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhiyuqy5PtLgifaaLLNy0tHClR4Z36xKmILPUg/XLt6wze
 rY88p99RykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIN0uGPzxaX9mSYpjZZJl+
 RvTVKTtt27PQW269zWxB/fvMOb+d9jD8U9zcf9nwiemdOUGrt11RUniYzunZbC7ZLP7dvEvitPn
 UMAA=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Currently trying to unmap a region results in slow and largely broken
behaviour as we unnecessarily split blocks and manually set thousands of
individual 4k pages instead of higher level blocks.

This series fixes the behaviour of set_one_region() so that it works properly when called to unmap regions. See patch 4 for details.

Patches 1 & 2 improve the existing debug functionality, the pagetable
dumper will now print most explicitly unmapped regions (since they still
have their PA intact), as well as adding a new function which does a
very basic software TLB lookup to help with debugging.

Patch 3 de-duplicates some code by moving the loop that always surrounds
set_one_region() calls into its own function, this also helps with
readability in the calling functions.

Changes in v5:
- Fix logic in set_one_region() so that pages are correctly unmapped
- Cleanup get_tcr() use in a few places
- Minor improvements/cleanup to tlb_debug_lookup()
- Link to v4: https://patch.msgid.link/20260512-b4-mmu-unmap-fixes-v4-0-fab802f647c9@linaro.org

Changes in v4:
- Fix the new set_regions() common function to never call
  set_one_region() with level = 0 to match existing behavjour.
- Link to v3: https://patch.msgid.link/20260507-b4-mmu-unmap-fixes-v3-0-aac7726d87d5@linaro.org

Changes in v3:
- Reworked entirely to be correct, v2 would cause unrelated pages to
  get updated too if the region was inside a block.
- Added additional patches with debugging improvements and code cleanup
- V2: https://lore.kernel.org/u-boot/20260504183721.646712-1-casey.connolly@linaro.org/

---
Casey Connolly (4):
      armv8: mmu: add a function to help debug TLB lookups
      armv8: mmu: teach the pagetable dumper to show explicit FAULT maps
      armv8: mmu: commonize the set_one_region() loop
      armv8: mmu: fix and optimise explicitly unmapping regions

 arch/arm/cpu/armv8/cache_v8.c    | 180 +++++++++++++++++++++++----------------
 arch/arm/include/asm/armv8/mmu.h |   7 ++
 2 files changed, 115 insertions(+), 72 deletions(-)
---
base-commit: a6f6947e43fba91de3ec5d0390eee7eb1a6a80f7

// Casey (she/they)

