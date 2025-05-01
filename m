Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8677DC369D9
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C722B80BAD;
	Thu,  1 May 2025 03:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G47gEOfb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B51E8070C; Thu,  1 May 2025 03:14:35 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6C858070C
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22438c356c8so4338405ad.1
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746062071; x=1746666871; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bU5/Xo7bEoCEf5u8wsMFGUzTgcSKCUUG/ZKxgOZ/1zM=;
 b=G47gEOfbk8gvoJw9xJl/xGpNKewuEQSl386fC1lRf2nALn265LBDtTfFDlmgSEjewV
 mELqWBwIOEyq5NtiPtlPaXbRfd59fhqsAxS27pMxRY5B2LLtNLIrJ1FfqisZUK1Viil8
 q0rgB6DF0C/Gvdo4FnLLL+CP1PU366jfkwI67SMD7IiuYvbbbNfGLcQeDURC3gtoKaqp
 +Im4CSAGQSGn5uqvSK7Pf/9KsCjvL+wDr7pgVkaFQB5/rtJEuMO5HNImCKBBsLOdk1DE
 PwPHPKrQI+q9wuFrv28m+J6kyTFiJkI9QeaMT1ciwF0XsstQPo5wNI0sZpHbk9Gfeh/u
 WiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746062071; x=1746666871;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bU5/Xo7bEoCEf5u8wsMFGUzTgcSKCUUG/ZKxgOZ/1zM=;
 b=nii+P6PBbup0G5F2qUNqT9MA9j+ASIfXo9HpjzUf+DRxaaHbXWnstumGhvfv5JQFh9
 z5iVbt3mmTOnrxs9jl1L3/2wj8fkfZkA8xjYs2L/7H4Gz9o1d9+GvpW3oQMAAZuXkLPZ
 02SYH3v8qsXRPDSo18sZ8v/0zD/pv24KMCb1JTd32vmrAxtm1aE2wRYWQ37Z+FVUsD1W
 OmResa8ZbWmzGhCH3/IRfj+IUWOrfNbkPLcf+gk2IjhwUBNBPVzFbcZc/qZ1/zTutXLB
 UiAtnxrZ2INXwTADncQImQfMAUUTg05F9xCoYov+VRaQRBua+m5MYTBT6QUc3wYf74l6
 CXPA==
X-Gm-Message-State: AOJu0Yyfy4Qf9UUBnF+PM2HGPgyUkYhOLAc+rYQnVGzuFCJUU8jasK3z
 vFEzVHWeYPPuI9EfVmwfFL8dpb6j3t9s7h02PYwHsNOidHWjdn4GsRCgTHmT
X-Gm-Gg: ASbGncth1W5YIZcPqV2tqAzzGmJGPXV/qogrZr7GYj8W1D7x2XJzhMFeC3eNI2NMT5i
 7UL2RPt4enifTS9bpfOWpwrl+TT1KmAZQKLXvNWIAJMoC2S67Kh9oTSD7eKe87tQBUXCROaob6W
 UkFpL643dWeyrlQEOGTy1XjcjSO56hMm7RZGdXm6WKcRhWEhEwG0D0XbR4zQmXmIHS69bYAI58c
 RTVF3z+QfHBp4MoFnRB1OqYl6vlUeQ2h1TawO82CnFelJA7dnQ/eSoRv5OMiVGfehHmAzZ6En2C
 23xmFZXfg7/g1voU90Mb3p3Bni9kFv3w/+cLNxb4B8yHRKcAWw==
X-Google-Smtp-Source: AGHT+IHD4MLCPgoMhTKbDwEc1PC1/NnwMaYmjjm9c0khoS28PPlcBXNEn9cQv/zwHUcW/DfIXVkCog==
X-Received: by 2002:a17:903:1b43:b0:215:acb3:3786 with SMTP id
 d9443c01a7336-22e08427350mr9625155ad.19.1746062071122; 
 Wed, 30 Apr 2025 18:14:31 -0700 (PDT)
Received: from adriano.. ([190.215.87.40]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52214fdsm128736615ad.251.2025.04.30.18.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:14:30 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, o451686892@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 0/2] efi_loader: fix initrd loading
Date: Wed, 30 Apr 2025 21:15:12 -0400
Message-ID: <20250501011514.2209452-1-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
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

This series replaces the series "Fix initrd loading in efi_bootbin".
This series consists on a couple of fixes for initrd loading when
booting an EFI binary. The first patch fixes
36835a9105c ("efi_loader: binary_run: register an initrd") and also
fixes the error handling of the initrd LoadFile2 protocol installation
(see the commit for details). The second patch fixes a small typo
on efi_binary_run_dp. Patches are sent together as the typo
propagates to the first patch.

Adriano Cordova (2):
  efi_loader: bootbin: split initrd registration and installation
  efi_loader: fix typo initd_sz to initrd_sz

 include/efi_loader.h             |  8 ++-
 lib/efi_loader/efi_bootbin.c     | 16 +++---
 lib/efi_loader/efi_bootmgr.c     |  7 ---
 lib/efi_loader/efi_helper.c      | 11 +++++
 lib/efi_loader/efi_load_initrd.c | 84 +++++++++++++++++---------------
 5 files changed, 69 insertions(+), 57 deletions(-)

-- 
2.48.1
