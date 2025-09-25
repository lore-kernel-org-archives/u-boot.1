Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33099CAC5B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 22:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99AA4802C1;
	Fri, 26 Sep 2025 00:48:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GauDhMXO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AA868309D; Fri, 26 Sep 2025 00:48:44 +0200 (CEST)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CE7E80107
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 00:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-54b21395093so927956e0c.0
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 15:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758840520; x=1759445320; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7rJc6SkE54klSHBy8e9t8vkjaSLRTBeEu0/gNdnc7gU=;
 b=GauDhMXOO0otVJWgn4H+AMWsSr5g+L9cEBLi19QmPAB3sjBEheh7SYGxFZTuMzQsR5
 V08rg+OiJRNyGlNFbaNlSDJVIiMp6GfiI20/T9p3lRFI/M5e24qFkgi9GuHktyftbQss
 R2jMef2uyXGA42Bv+hQbpczdhakmn7k1ilXM1lPUQklK6JRrUDArE8aI5Bh/RjPLezpw
 lU5ZdQSNjmDGpw+Ze4ZxeSWhgyMbFpcERqGNXJMjsmDd2oegyJQrnYWHqLkxdj6D64xk
 VR33n6W9YOYr9OVcz8VOuMqwtPSsD8KEz8ILkvvW/xHLyHFnAELRz4okmYjQJvnKI2Nu
 ViNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758840520; x=1759445320;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7rJc6SkE54klSHBy8e9t8vkjaSLRTBeEu0/gNdnc7gU=;
 b=FL33K3Ci4jLncqJCiQNc/rSKZ0twntu4rW7Rmq19a36KBt2cIFzccbXUn9wF2DKrTS
 KpzFlASSPnerj8661JMLZEInLMT8dXAkODt/QiVXGYQEazKLmfxd/LTdwdS5bD69svNv
 6g3OYXleF3xnECE9pXCQziWs5RXiUA/jLSN37kkKPop/LoLTu/4jBQCMjnAig7E9uEsb
 oFfqq8Ocl3oX5I7X2711CPoKwb3kB8hSZbP88bjPp0cI0Hsdu2BTSA6Py6QW4qFQiLEw
 GfEhAOHPr1UfKKIRoBtLntlmHnCrgj1vbz5yRcNUX4NeSp5ZlC4wAmwKXhraZCsLYdvI
 SS/A==
X-Gm-Message-State: AOJu0YxV9JHQMJMx3m7/8R9FDITpoDB0siZRlQ7Oo08T9AUju260f4iw
 0zg93vqhKAnbbO0hkAjZwQjT9K/cKq+BBB/zC5+s/cQwbO95LDZwDYV+g54D2H/y2J9eO8vEBMe
 /zR3J
X-Gm-Gg: ASbGnct5CDZQiHnyyB/vfHcuyOZhSeNuOcFfh8u9rCGkjtylSr5PXqsE4zZZWk5Dg9s
 bDyUxVxvYh8suE5CsXtLuFukhia930LTrHZnY2JBxPE4FMb9z6iBg6yoUgc1ciXvvgqJFGmwXTB
 jhCv+N/o1TBNBg2t9DC0RqmRYUZlHqXqUROgpwjAVjtAdElnSJ0Ne9aOR/uxOVwmggdithuOFEB
 riIlossfAiEHxYRfQWvmz42gyULOVQo7hh99qLRn0kgEjjtzboEFlnuQgGMi5G1Mch7I3R9x8EM
 +8SRbYedqUYLUcGNkIUchn4ES9g+Ao2nHJ7ewAv1PTwzpeswJRI0HD1FTt16BFkypwVgLdPgdNg
 QV9RBR0QMZNAZMQ1tD9zR3cC0Hwu4n+9u88FKOca6vHgPGZ/m
X-Google-Smtp-Source: AGHT+IGA5I1Odu8+KLLbptOmsvAbqd04UdxMmmAYzY7vr3YFVm52odpRv93SA0Jv5/Xz/8gC/v29jw==
X-Received: by 2002:a05:6122:4584:b0:54a:1ec6:b1ab with SMTP id
 71dfb90a1353d-54bed271549mr2235219e0c.0.1758840520061; 
 Thu, 25 Sep 2025 15:48:40 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.192])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-54beddf9c76sm673866e0c.28.2025.09.25.15.48.39
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 15:48:39 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de
Subject: [PATCH v7 0/2] Improve disk image detection in efi_bootmgr
Date: Thu, 25 Sep 2025 16:48:35 -0600
Message-ID: <20250925224838.567562-1-javier.tia@linaro.org>
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
Changes in v7:
- Fix U-Boot CI build error. Passing CI: https://github.com/u-boot/u-boot/pull/816
- Remove duplicate kerneldocs from part_driver_lookup_type, as it's included in part.h

- v6 link: https://lore.kernel.org/u-boot/20250924233120.454116-1-javier.tia@linaro.org/
- v5 link: https://lore.kernel.org/u-boot/20250905172330.135550-1-javier.tia@linaro.org/
- v4 link: https://lore.kernel.org/u-boot/20250903214417.431985-1-javier.tia@linaro.org/
- v3 link: https://lore.kernel.org/u-boot/20250829155415.90634-1-javier.tia@linaro.org/
- v2 link: https://lore.kernel.org/u-boot/20250808213627.649669-1-javier.tia@linaro.org/
- v1 link: https://lore.kernel.org/u-boot/20250805162158.117876-1-javier.tia@linaro.org/

Javier Tia (2):
  part: Export part_driver_lookup_type for external use
  efi_loader: Improve disk image detection in efi_bootmgr

 disk/part.c                  | 18 +------------
 include/part.h               | 21 +++++++++++++++
 lib/efi_loader/efi_bootmgr.c | 51 +++++++++++++++++++++++++-----------
 3 files changed, 58 insertions(+), 32 deletions(-)

-- 
2.51.0

