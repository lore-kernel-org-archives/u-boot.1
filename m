Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EF7C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 08:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A509E843E2;
	Thu,  7 Aug 2025 10:08:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VBcZ9ut9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2447F8440E; Thu,  7 Aug 2025 10:08:28 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14E8B83AFD
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 10:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-455fdfb5d04so3547525e9.2
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 01:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754554103; x=1755158903; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sdrXNz6gP5UZckQ8VhCckCyZmyIVd9u1PeDllxczDZo=;
 b=VBcZ9ut9R8aK6XYVTmrr+gSmRI+4lW5ZoOkj+inJUVJsyJPNjDcbbsG1xAUlVLmO5n
 XjAy5JsfgdlOl+7Lf9WNADEfOie4HHp7enwYG78npMBDQrgofOTx3d+L/skZoPZvbP7u
 cxHOZQxK0Q+2ox31CIw+H24XdwFEzP+4xDSaXnZjpG7Ki02WD6/K2I1m6t+M718kbjrH
 +E6aDMw/UaJNc0nmD44T0fpF47hXfZkUyNiQYNhW20j1bt5wvplX0IRx5gYUgx7czlTi
 XCFc7m99Ptg1cSih6v2p2Ald955/7wqD9V8+iVG4CdbwIKAECR/oSpSNImMO5vSYQn/y
 W/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754554103; x=1755158903;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sdrXNz6gP5UZckQ8VhCckCyZmyIVd9u1PeDllxczDZo=;
 b=LihOwRpu/kbpYZUpKqVW+s3ey9j2rJyEWDQLH88YkSHb8kkIfqUa1bNQ5G4ZP9UABY
 Uato057yrNLaymx3aVIlD45mrD2iBNaqQn8OaXUSsHqIzW8euyig6q3MO5Fa/xv6x4Fb
 S5kKiUMgayFSdVfN5+S4B8qbEoaIQQ8PQJzUqMi75hp/Uv8pfb+T9kt4XJKQKTN23RAv
 An7U2aasvM4GIVRaaNvvxgU3bgzZIwluX/xtxl3MC4WxiNiQvK79fAHvHz8NMAqwsrxx
 +JMyMXFbC7Ve/73ZPqujbgkxBFiLSD97lgjmAeVA8n8yUyqihraTtb+TfX743bmm2a0V
 ajyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw9QUoBG+OzYtRDGyTE4HKYHL9LVwj/KFeiTUVjkYunXnEJ3s+eoWkXCfT6KrBmxJGcPo3PUg=@lists.denx.de
X-Gm-Message-State: AOJu0YxFBy0XU/9vSYw3Iu3kEJBN7DWqshJOWloKQmr3P3e5dWEBAmHV
 wFv0vymgEXPyI6aupBWSiM9iPW4Hpl6zLCHCTP7xi2RsRY7Lm6xrrzCLo2hoTjCEw4s=
X-Gm-Gg: ASbGncuCNCYWW+MJZpJ2u6embTOmrW8eede9/r0tAJMWS/nL+KU0kvxuut12fg5b+VP
 bAPmGTBY7wY95Va1NE8O7AhVnaADWiuYFZRa+rooeBN6TawQgplTbMeoKIxeawDYO5qde/0TGyt
 7BTf1LJZEJxBc2XabddPhFQIlFloE3xsUA/QFDl6ranUERKwxnDiwGgDseUwIASLiwXxos7/jZu
 aOyGNUtUsF0kVj/YVnHCVXewVpy15U2K6Fib5IPH1TNYJrXJIsBv2oKZiBYZ8WX/NT3Jkvm96ae
 i8Uv7erUH2DKw588hezF+YX715XC6sg60wBD0S3AL7qVam54IaqQi0+sGQMTSwOjabWb1D77Cy/
 3GthmYi15SGAeTb/2q4Hbx+BNAHw5JFr1BpzbgBCdfZXcprEX56hHQjQ=
X-Google-Smtp-Source: AGHT+IGj0iNCSfxP4vcvGrnAXPVN8rIGqDHyoAVNcX97HG4hS52t2jMGqwHldSqcs1K/zVA2HmHRkg==
X-Received: by 2002:a05:600c:1e03:b0:43c:f0ae:da7 with SMTP id
 5b1f17b1804b1-459e7a8ea40mr50486865e9.7.1754554103370; 
 Thu, 07 Aug 2025 01:08:23 -0700 (PDT)
Received: from hera.. (ppp089210243039.access.hol.gr. [89.210.243.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459eff7918csm13639665e9.25.2025.08.07.01.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 01:08:22 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, u-boot@lists.denx.de
Subject: [PATCH 1/4] test/py: Correctly restore the DT after capsule tests
Date: Thu,  7 Aug 2025 11:08:14 +0300
Message-ID: <20250807080819.1058411-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
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

Some capsule tests are changing the sandbox DT to test various features,
e.g authenticated capsule updates, versioning support etc. However, no one
restores the original DT and the CI pops errors looking like

/u-boot
Bloblist at 100 not found (err=-2)
Failed to find FDT file '/tmp/sandbox/persistent-data/scratch/EFI/CapsuleTestData/test_ver.dtb'
initcall_run_f(): initcall fdtdec_setup() failed

if sandbox is restarted.

So let's restore the proper DT after done with the capsule testing.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 test/py/tests/test_efi_capsule/capsule_common.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/py/tests/test_efi_capsule/capsule_common.py b/test/py/tests/test_efi_capsule/capsule_common.py
index 04dabc176c4d..8c66411929e8 100644
--- a/test/py/tests/test_efi_capsule/capsule_common.py
+++ b/test/py/tests/test_efi_capsule/capsule_common.py
@@ -137,6 +137,8 @@ def do_reboot_dtb_specified(u_boot_config, ubman, dtb_filename):
         dtb_filename -- DTB file name.
     """
     mnt_point = u_boot_config.persistent_data_dir + '/scratch'
+    old_dtb = ubman.config.dtb
     ubman.config.dtb = mnt_point + CAPSULE_DATA_DIR \
                                 + f'/{dtb_filename}'
     ubman.restart_uboot()
+    ubman.config.dtb = old_dtb
-- 
2.49.0

