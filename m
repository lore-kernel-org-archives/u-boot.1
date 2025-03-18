Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3526C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 13:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D78CF810F4;
	Tue, 18 Mar 2025 14:23:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d4b+VIrP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41C46800B6; Tue, 18 Mar 2025 14:23:40 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CEE1800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 14:23:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22401f4d35aso104255385ad.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 06:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742304216; x=1742909016; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8LAmF5txgOMIHH3bYbRmMfv+DK4X4pe9JIxrsUUDyeU=;
 b=d4b+VIrPjKootdMcC0g5jenmPS3zxZlUtlCJGiCtqD/GlnFeOZLPtX6HUmYTjx7L4+
 X4VZfT4OIbDNew8Y49swO3WOZOYiKw0dUbZ9gw0pArO05wVMe4W5VMzHOmjYZOHMYnF3
 HGIyqC5NProtpaGCSm1D6WoydLfD7+0DHAObsxa0JNCjXtZhkNB1m5k4CVehSHrbHOKW
 GUC2fCnHXQ8MTSEfdCdQ+z0v8ghtXaGn6tRAoxmOrSBaYT3dPO2KILUEYp1uZmvmLpGD
 aK4x9rMaG4vb39KveMgHewmuyTtn7DDlBRRD+9Kb1NWm8RQ4I6rFXED/vEew5PhQWOoU
 gVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742304216; x=1742909016;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8LAmF5txgOMIHH3bYbRmMfv+DK4X4pe9JIxrsUUDyeU=;
 b=gBLp64ZNU81ScWAqMiJMQsd+JBM7ef3fy2x5U3l3flpcIwmqoiMtvlCvQHNg29ISSK
 nkz0P9nZeXLZ1wgZQWnPxa+VjA8IYuY3CWWhETlBOErtDO744cmziND4rWyFWDmH6iMq
 ddWhFoHdilYYv/3JqHiFgG+eaBnvVW9H98SUm08NT/pKKjkRRYwUan3G1cUIdoOHhg4b
 pz5V5FuF9y2QzfZpdRKiit1qXhjLYgHPB1Nfbx9eu9mx/g/JFf4V1yMqDSmjnlBGgth5
 oWfInoBlW6dVVuBfkEnNAQNgtuDN2lr7lqqpiPa71NdbE86No4xhgjeCQnS0kNhOWFaj
 SEeQ==
X-Gm-Message-State: AOJu0YwRALJIYflGucsRT2m1JZSyMxAovH4drTb+jYth9NM9n96JXPGX
 ynaWeesTkzKfeIWkeENFFYECV+cR/81Sx0iVL1v8lm4rF6eRgcfh9ySXLGTuSW8=
X-Gm-Gg: ASbGnctB9VbqFvLYzhffzveuWLTtJvHyo3oz/tui9gzSof10t8qqf/sraJz/VK1FgvZ
 V4bv/LE2+KPTtkfxQyFoGeCleaVRO7AXMVohPaUurEh3tqg69pL4JUfLOfgZDAoupMHWyq14CUQ
 PBIyeNC/vJt57Org3B6Mnjr4iNg4yM/h8iT5BrMn2z1YSJj6IvQbWI52bLPaGmQ0GShJt2G5z5G
 6xov71pqcio0T9rdGkdPm5Keu3pgBRSRB3jNBuKJcAXkVs+8fZPDxXWBv2h4/5IP7q2mBF71dGT
 J0sd/U4kai8+F8HQPhoROmHybLJ7wONaK3XT2/wtLZvpJ09TDbviHJMP
X-Google-Smtp-Source: AGHT+IEJmGtaOuVtv2mVdtN5Fpar0svWu3G4VDf6W+2LfdMVknuDqIYqaBizwxJNobrUpNvAhJ9/RA==
X-Received: by 2002:a17:902:e801:b0:224:1eaa:5de1 with SMTP id
 d9443c01a7336-2262c554e0fmr47517395ad.18.1742304216480; 
 Tue, 18 Mar 2025 06:23:36 -0700 (PDT)
Received: from adriano.. ([2800:300:6f53:4a50:2bbd:7872:4328:2b1c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba70f3sm93685945ad.157.2025.03.18.06.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:23:36 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 0/3] Add initrd support to bootm EFI payloads
Date: Tue, 18 Mar 2025 10:23:44 -0300
Message-ID: <20250318132347.646703-1-adriano.cordova@canonical.com>
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

Next boot stages can acces an initrd via a handle with a specific device
path and an EFI_LOAD_FILE2_PROTOCOL installed on it. In U-Boot, this functionality
is currently only implemented when booting with the EFI boot manager. This series
implements this functionality also for the bootm command when the os is of EFI type,
e.g. when booting FIT images with an EFI kernel.

Adriano Cordova (3):
  efi_loader: efi_load_initrd: provide a memory mapped initrd
  efi_loader: binary_run: register an initrd
  bootm: add support for initrd in do_bootm_efi

 boot/bootm_os.c                  |  4 +-
 cmd/bootefi.c                    |  2 +-
 include/efi_loader.h             |  4 +-
 lib/efi_loader/efi_bootbin.c     | 20 +++++++--
 lib/efi_loader/efi_bootmgr.c     |  2 +-
 lib/efi_loader/efi_load_initrd.c | 71 +++++++++++++++++++++++++++-----
 6 files changed, 84 insertions(+), 19 deletions(-)

-- 
2.48.1

