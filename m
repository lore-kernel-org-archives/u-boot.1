Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD8AE95A67
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 21:36:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B440C86D4A;
	Sun,  8 Oct 2023 23:36:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iJ6sPv0m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FD4886C58; Sun,  8 Oct 2023 23:36:53 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8213E86C58
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 23:36:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79fb64b5265so172795239f.1
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696801010; x=1697405810; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JecMC8jYp22BkzqLFqg8HU4sWDA5NpvwW1C/ETWSXrg=;
 b=iJ6sPv0mexjT55XH24cqttieR5Lz/7mFvPjQHPtqlDV9y3HekU00NyW81NHWBK/CTI
 TNZqYQznfj2TmylnVALSlEKdJE4h+LcX+F7/yMYTiqXv7kitU8b/JIcjQZvX0emXiogK
 7NcapN3rY+qC/ulxNJPjH43UJcEeDgpnfZmJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696801010; x=1697405810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JecMC8jYp22BkzqLFqg8HU4sWDA5NpvwW1C/ETWSXrg=;
 b=E62LRb8FWXAyjT3GPkdg50LZNTf4XcgzmYW1OFO9ef9y/fgHppg50aymWaxrp9aBPO
 rgFs8HlLJUjM6z6h812Z6Va6EO4wkSmHLkiKL51u/4PJfuOCl/SvgpqcIiHA3WHicAhy
 dh0P0YWbv8fSTjv2x0If7wEWQGpyJ8rGLD6Of1Q1+C759UubMBFJ5uF5TtsqPA47HBTx
 xT3lNkF7NzAemDiCv5BuZ90eaPTn1q/CiE8h7aRYG8f/AVLYyY82c/3kQawmLQ9bCxlC
 aA98/BI2k0fA5X+ZhYH8sWrLZ+POVjX5yFu2751V7cTi9nSkinUa4XjwUQRNAdH1UFx8
 q/GQ==
X-Gm-Message-State: AOJu0YxDvsHQ0lzM9DihOfngBgyXWXLyGQ0MV15JaM88Sg2pj5WV9BlX
 OhdcODTqX7aGAczjTcdlXu4E2vmbWVoI67IpTMM=
X-Google-Smtp-Source: AGHT+IG7xgLHiapzxtzZEG95jc7D8bHcn+JtBnpl4M52RZk4ZLSkaVC/G0/GmZIG2iMY8Mmc/cldNw==
X-Received: by 2002:a6b:da03:0:b0:794:c91e:1e8 with SMTP id
 x3-20020a6bda03000000b00794c91e01e8mr14594197iob.5.1696801010067; 
 Sun, 08 Oct 2023 14:36:50 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 f12-20020a02cacc000000b00430bb70004dsm1751826jap.103.2023.10.08.14.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 14:36:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 0/5] smbios: Deal with tables beyond 4GB
Date: Sun,  8 Oct 2023 15:36:39 -0600
Message-ID: <20231008213646.622002-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
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

When the malloc() region extends beyond 4GB on ARM we may end up with
an SMBIOS table in that region.

Add support for writing an SMBIOS3 table, which supports a 64-bit
address.

Note that this problem does not happen on x86 since it requires the
tables to be placed just below 1MB in memory, unless
CONFIG_BLOBLIST_TABLES is enabled.



Simon Glass (5):
  smbios: Refactor 32-bit code into an else statement
  smbios: Move the rest of the SMBIOS2 code
  smbios: Use SMBIOS 3.0 to support an address above 4GB
  efi: Use the correct GUID for the SMBIOS table
  smbios: Require the caller to align the SMBIOS table

 include/efi_api.h           |  4 ++
 include/smbios.h            | 27 ++++++++++---
 lib/efi_loader/efi_smbios.c | 12 +++++-
 lib/smbios.c                | 77 ++++++++++++++++++++++---------------
 4 files changed, 82 insertions(+), 38 deletions(-)

-- 
2.42.0.609.gbb76f46606-goog

