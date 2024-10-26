Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C75D10BE8
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 08:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C11DF88DF1;
	Sat, 26 Oct 2024 10:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xUkyNrTj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DC3E88F4A; Sat, 26 Oct 2024 10:06:05 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 452BF88936
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 10:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5cb72918bddso3575828a12.3
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 01:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729929961; x=1730534761; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ufpBCztf+TlgQkx7qSVcFF8D9ArmhE3XG4iZwBgkxEk=;
 b=xUkyNrTjCQsNZwN1xVktQR1U5Jz2Pe3litxrEJYLUvit9M871wnJnLeMIutvww929b
 v9gVJ/cdXhPikchlLdP4duL1qTqE7MOI/QmaGmmax+02s1/5LPIIMmF8WDMKhuJMGrQW
 QKmsbwmHzGxvnxRKn/s8jLinvuUrupsgH3m1GSnaTCUQ6s3BxaeTvDYMHFHsKariBHck
 WnclUfvd1BjJnLKmSs525PhczTbBIjs22ueOiiOmeCnWRZjeku48KBx/U5YOgtIY9jl4
 mh3/mk6cc5homjYyQRdttzfCtevZ8ob9XOpkSzQ6BxkDczS7OV1hotc3MhyDfkF5wrL3
 E8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729929961; x=1730534761;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ufpBCztf+TlgQkx7qSVcFF8D9ArmhE3XG4iZwBgkxEk=;
 b=DvI85yObdLD4ktHGKzjZw7UiUuNjTlsvsJylVIVfW/6hPWrVzX90uWJPJFp+zMGmJs
 CJS5EIhVlTRs87UOkmFFIPf1uvIWqaywLEAB1++iJtDujn48PMZW5TouomZZJJuV+8Rw
 hY200w8GF3H1xO5fRnwT8l6zFGByzPG2mGNE/niPknMvvWG+/GzKoj8yqibxUUPsBNw/
 mmTHE6DnFvxnx+1IU62dFKpWoikztzBL+R8Uem1p+VbTtHV5z+2i+LrUnhqcYaGhkCvb
 tXfNY0Y1u9QOHQqYUQxdRRtGuqGePwP2jDsGtHUDaQfMGLrbNk/bMeInpwGY89Nili34
 P9qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKbOdPCKKy8dY6BKjfYDCtu4+B2ITCjbjNLqTVaI0Oe2bnsGG4bn96tJE4VodbTqagg3OjFPc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6Uvr1o1yXCps5eQSHwo9skzChBXx/fKx/DZnpM0LsUzMSizQ/
 Ddcg75XQLfZDy9DFeA/LaUXV15G3FdDz2Pv3hzpCFWr5oTPRsLh0h17IrHRdJ1Y=
X-Google-Smtp-Source: AGHT+IFcOxI6ADdmbgjtbZ6DT5SnlbYOBSx8LcDMLrVyMjoUH2Dr7pVMvDM6Y0bzz1DYJ8WGG0zMXw==
X-Received: by 2002:a05:6402:5107:b0:5c8:ae9e:baba with SMTP id
 4fb4d7f45d1cf-5cbbf8868bbmr1374034a12.2.1729929960602; 
 Sat, 26 Oct 2024 01:06:00 -0700 (PDT)
Received: from hades.. (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb6255e20sm1339235a12.12.2024.10.26.01.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 01:05:58 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH] disk: Mark static functions in part_efi.c
Date: Sat, 26 Oct 2024 11:05:53 +0300
Message-ID: <20241026080555.135472-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Mark all the functions that are only defined locally as static and
quiesce W=1 warnings

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 disk/part_efi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index 7f04c6ecd69e..cb2fcc2bab2d 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -216,7 +216,7 @@ int get_disk_guid(struct blk_desc *desc, char *guid)
 	return 0;
 }
 
-void part_print_efi(struct blk_desc *desc)
+static void part_print_efi(struct blk_desc *desc)
 {
 	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
 	gpt_entry *gpt_pte = NULL;
@@ -258,7 +258,7 @@ void part_print_efi(struct blk_desc *desc)
 	return;
 }
 
-int part_get_info_efi(struct blk_desc *desc, int part,
+static int part_get_info_efi(struct blk_desc *desc, int part,
 		      struct disk_partition *info)
 {
 	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
-- 
2.43.0

