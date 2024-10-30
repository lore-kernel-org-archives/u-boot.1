Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A08D6B6DA
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 21:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B519F89228;
	Wed, 30 Oct 2024 22:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="qqP5+cV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EEFF8925A; Wed, 30 Oct 2024 22:18:12 +0100 (CET)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17CC688E17
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 22:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3kKIiZwcKBp8LNQHSYEFNNFKD.BNLT-ANNSKHRSR.CDMW.CD@flex--moritzf.bounces.google.com
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6e3705b2883so5337517b3.3
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 14:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1730323089; x=1730927889; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=c3SB9z+kWUIO7cOsw6jJLs/PXwPg1sUdsqrQN17781c=;
 b=qqP5+cV/Ika03va1Bf6v54JHo3Shbt+GG6vHJyt6FTvUVt68PSmXoDicPGmoBDuu/J
 +TpFXuRDvN/ajzE26udGcBsKWsaIc2aULdMYzIOXqCOcIyohpir2Cx116/BJG/GaruyN
 LQ9t54dkRJigCgXLNwMAqz0Fu7twKSOYC4tNZOlPWFGJcQUxsFTbETRdvwSsFPdv4mg3
 cM3BN5buvVuMI2xGsPkphDuseIvFM/RAGL5BzlpWoxfI50+Po9A8wkXqK/sRdHwIKmsX
 4uCahPOMuYt2RecZNUnt3adftulDH78vj9RngngXZdtVTfug/WZDKesaQPW6h7V2C+N4
 3Lbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730323089; x=1730927889;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c3SB9z+kWUIO7cOsw6jJLs/PXwPg1sUdsqrQN17781c=;
 b=WDeac7Q3ospbGwCyrWrK+D7vbEHnc8y0a7YPs8vg60D1B8yK2mCzm0uxsyhrJnCjpr
 FUXt1YQj9nmuR5xTw+xF6ZrCY9Ej5aE1p4S6cWRw9dEGFUZ5+5p5Y7Jc8mf/BSktq3/n
 MHtvmyeKw4dOD1aFVCrz496/uxkzSLtB2ZaKndFI5x2mpwXq1CPXSsKJj+EaWsfYc6e/
 QSzQZ4wQFPEthYQ2JYxmjYDcNZ/MlUPgj9oJS6M2a336PYn0uhKvXwluS8PWT2uut+j6
 pNKkoioaewyhXPCmqw3yh1qrN1+Ms1t98XbZDJuFEat1a7QCLS+0zGok78MDSsLusYul
 hbXw==
X-Gm-Message-State: AOJu0Yw38XsHevwxQTVndscsbTwGqA0pZt8hS/O8ug6C5igZpJ/6id4C
 eFLhbQwo2ur92NURlqd4VFway/48CDZr9Et7kcyl7mZVZpIqEVHvD1yQZBZWJ4Fpk5dQWW2F7U7
 hoh6SAUsrknbFVOXL9cNI0Anv4QCE48CMZrc7GyCOSNM7vjCySaT7APUvZ68dZ65KdUx7B8V/ue
 sryWVU1q4jLUNvFSFGw+AjkEV1tr8gfLb66RM=
X-Google-Smtp-Source: AGHT+IECTxHz+AYpfB/OXSuSqTpao7VI7ZQDe63gluTqU3pfs5RVhFIV+Szkiu7eb8swIQgWQD0PlqfgrSNV
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:13f:f0c:ac12:c151])
 (user=moritzf job=sendgmr) by 2002:a05:690c:4d4a:b0:6dd:fda3:6568 with SMTP
 id 00721157ae682-6e9d8a50acdmr8632407b3.3.1730323088659; Wed, 30 Oct 2024
 14:18:08 -0700 (PDT)
Date: Wed, 30 Oct 2024 21:17:48 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030211748.1264005-1-moritzf@google.com>
Subject: [PATCH v2] lib: efi_loader: Fix efi_dp_from_mem() calls
From: Moritz Fischer <moritzf@google.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com, 
 pwildt@google.com, Moritz Fischer <moritzf@google.com>
Content-Type: text/plain; charset="UTF-8"
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

The function expects an end address but is being called with
an size instead.

Fixes: 6422820ac3 ("efi_loader: split unrelated code from efi_bootmgr.c")
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Moritz Fischer <moritzf@google.com>
---

Changes from v1:
- Fixed second callsite
- Remove superfluous cast

---
 lib/efi_loader/efi_bootbin.c     | 1 +
 lib/efi_loader/efi_device_path.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index a87006b3c0..bf38392fac 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -137,6 +137,7 @@ efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
 		 */
 		file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
 					    (uintptr_t)source_buffer,
+					    (uintptr_t)source_buffer +
 					    source_size);
 		/*
 		 * Make sure that device for device_path exist
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 9de3b95d07..d7444588aa 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -1073,7 +1073,8 @@ efi_status_t efi_dp_from_name(const char *dev, const char *devnr,
 		efi_get_image_parameters(&image_addr, &image_size);
 
 		dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
-				     (uintptr_t)image_addr, image_size);
+				     (uintptr_t)image_addr,
+				     (uintptr_t)image_addr + image_size);
 	} else if (IS_ENABLED(CONFIG_NETDEVICES) && !strcmp(dev, "Net")) {
 		dp = efi_dp_from_eth();
 	} else if (!strcmp(dev, "Uart")) {
-- 
2.47.0.163.g1226f6d8fa-goog

