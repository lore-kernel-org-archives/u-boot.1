Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77AFCAC5AE
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 23:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5163835CB;
	Thu, 25 Sep 2025 01:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aftY16nG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 687DF83666; Thu, 25 Sep 2025 01:31:27 +0200 (CEST)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47802835C9
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 01:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-54a8f6a2d80so152740e0c.3
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 16:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758756683; x=1759361483; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=0jStqQnbxQSKypGDxgCXLZhmM4KNanvuE7lmiTYghj0=;
 b=aftY16nGjhRl8fX/SOHqKPxscoAKUUAFKBhH0KEMR4Unfl/FPIjNE+97G/4mXvWICV
 mEPFiWFg0kBzchMFK35tuYbVmlQnVZE9V1NHMlY630g3hlHLD/p+NyRc/k27Px4vgi6q
 MJSqXBymmuYbOc+7Yn+QsdRUnBQnIMz5+S79FAcR/xPAKYv0HixJVJJsgSeyn50ngRfe
 Dh8C+8p0j/aHrudHZT2wIlOTDsZCpibuzvLnJ0KIUEtDWvjpSy4zaVsxfq3gJ7ZK6Dt9
 V++orkJIiI31CE6vnh/zdnI3FBQZieZUBQMdWR9vRQU0oAIHi/rF+MhB36f4hA2K55h7
 TNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758756683; x=1759361483;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0jStqQnbxQSKypGDxgCXLZhmM4KNanvuE7lmiTYghj0=;
 b=Hs+KtCyArQF3MamTf7SLeEwoMj+ffC3iEgatxZIEg8Dq3sDNYOim6jGP07hQ9mUiaA
 /4vi5Cl6WdFp9uHhpBAUFh4dvjxYIrZn6KMlc958WOZfxAQKPnRRKqCOJvJg1QV8c9v6
 PKN76m3U7BPIVvilOnbbW52DdmPC0R9/6e+EFFP9q25DA6wsqcHyfRJYVkLG2iHU5rAZ
 MH/o3PplTrNi6Wqk3dzENcb4tE08rYabA+dv57VkkQ0Ju5mgmZEQGZ//YIAgJRqJPdMc
 7k5M/aPJwUW3Wec67nqesrUw/3G4Y3vEvDhEXNnVRgc7P1NYY6MxDWgdx6d6XIA9XorF
 kA5Q==
X-Gm-Message-State: AOJu0YxpxouVMhfqg36YG5RATjRA6Hn2+4xXes5X0LLTjFBF5QfwowvC
 DProO/n4HZvdBIKIGFxzEgpbOtvzAnnu1lL2R3VS0viTxKRCVvlTJtZA9hUm0Pgk6Un7a7V9/TL
 ZeIfx
X-Gm-Gg: ASbGncuzzmoIfFz2ELhrqr8OODEsIFS27/Dx525zILKJ3Jj9VvgxDC4j2ZuQj5AONE+
 wa4WVTsIgNE8Mbwhjq7ZpT7B1S71SojEHE5ay0JCUZ9jUTPZ7aM4WEMpLjNU8FNtMJGCmjHlCbz
 NwJdVjffAGcMB7uSJDWh0TCptLEfFxhUKOkLAOsSLYRtqz3uzWEu0G65ESjCRezDgV2gvCIjKuv
 9Yw8+R7Nlzt8xTKYdgAP9CSsPhFZGBoXbiyY47KWK3kTtfUSdJumJaE9hGstUNZ581ORmH5LyiU
 0Gnp5dyXX0T3Lq2+PR/NwzjuQNX1SEgm/mvqJ9RqfL/ZlDpZGHV+JmvclB7idpsrnejca7bqrdd
 PHEypQ5HMJmDpngp1V6hztOmIelMY1SfBazoTmqwMnK/ybbh8
X-Google-Smtp-Source: AGHT+IHfRll2ZKBWXNh3MVs0PybARCIqJDgm/SrNK7cmG5dAV+IlEiA5+9uRCtzkqWiKROAuordglA==
X-Received: by 2002:a05:6122:2510:b0:53f:8fcb:b630 with SMTP id
 71dfb90a1353d-54bea0d9256mr791644e0c.4.1758756682683; 
 Wed, 24 Sep 2025 16:31:22 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.192])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-54bede0587asm101577e0c.30.2025.09.24.16.31.21
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 16:31:22 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de
Subject: [PATCH v6 0/2] Improve disk image detection in efi_bootmgr
Date: Wed, 24 Sep 2025 17:31:18 -0600
Message-ID: <20250924233120.454116-1-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset="utf-8"
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

Enhances the process for identifying disk images within the EFI boot
manager. Utilize part_driver_lookup_type() to verify the validity of a
downloaded file as a disk image, rather than depending on file
extensions.

part_driver_lookup_type() is now used in the prepare_loaded_image()
function in the EFI boot manager to detect partitions on a block device
created from a downloaded image. This allows the boot manager to boot
from any disk image that can be recognized by a partition driver, not
just ISO and IMG images.

Update prepare_loaded_image() to create the ramdisk block device
internally, obtain the blk_desc and use part_driver_lookup_type() to
detect a valid partition table.

In try_load_from_uri_path(), try prepare_loaded_image() first to detect
disk images, and fall back to PE-COFF detection only if that fails.

Include part.h in the EFI loader and export part_driver_lookup_type and
add its prototype and documentation in include/part.h. This makes the
partition-driver lookup available to other code paths that need to
detect partition tables on a block descriptor.

---
Changes in v6:
- Fix U-Boot CI build error.
- Split changes in two commits for clearer review.

- v5 link: https://lore.kernel.org/u-boot/20250905172330.135550-1-javier.tia@linaro.org/
- v4 link: https://lore.kernel.org/u-boot/20250903214417.431985-1-javier.tia@linaro.org/
- v3 link: https://lore.kernel.org/u-boot/20250829155415.90634-1-javier.tia@linaro.org/
- v2 link: https://lore.kernel.org/u-boot/20250808213627.649669-1-javier.tia@linaro.org/
- v1 link: https://lore.kernel.org/u-boot/20250805162158.117876-1-javier.tia@linaro.org/

Javier Tia (2):
  part: Export part_driver_lookup_type for external use
  efi_loader: Improve disk image detection in efi_bootmgr

 disk/part.c                  |  2 +-
 include/part.h               | 21 +++++++++++++++
 lib/efi_loader/efi_bootmgr.c | 51 +++++++++++++++++++++++++-----------
 3 files changed, 58 insertions(+), 16 deletions(-)

-- 
2.51.0

