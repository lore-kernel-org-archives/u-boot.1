Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3107ECCD187
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 09:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64B4280422;
	Tue, 14 Oct 2025 11:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jnbbOdp3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A850D807B1; Tue, 14 Oct 2025 11:49:28 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D385802C1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 11:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e3af7889fso27782535e9.2
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760435366; x=1761040166; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6PNOX7IpwmKt+hxSPNtNdA6aUs38E4Syei0U9GCN4V8=;
 b=jnbbOdp331zaLOitzHeGE1Uom5GAs2E5t4+lzWul6ovJ7UWEevN5KpwsuWM7C/2xx4
 Cgim7ZrrXAiX1DO2aYdRcD7bp7Z0iUe5GjgJoKElFGDVFhoZ1QAjbx6TyqxqwM2JEj8x
 OH6P4cSfXcaZMHeOHLdqZegX1pQLLw5c+T1bmnWev3XksT+1WanVNPndG5s0y6TQPTLy
 12Qe9kh2qNLRTiCEr/B0ffhyCqOT60GhdU+TzHRhj+VDzY8mT57hjqLBcpWcWl4m+UXp
 S4izN5A5Wpz7WJqZI2zbyYQZKUbhszLAiQiW+QEMGWMuQiL8AJVOJ1iIxcrlEJjGctNh
 l6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760435366; x=1761040166;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6PNOX7IpwmKt+hxSPNtNdA6aUs38E4Syei0U9GCN4V8=;
 b=LmTsw44WAHF7py69fB5S22tT2TqCbQ6BJbd5262NbjMf34sivl6D77CD+5HZbktJME
 jtGN5jM/RIl323Ba+1zhZKT5ND88OHimUSm4c9cqGGNw9mc45N+iI/trK9y5excDKod6
 D3XJsV7KugETca/vbxkK0+Qo/k0ZqGQbA/UwfYJEAioXXbVY2vG3fYAsl4bdGv+7gHNx
 OG7XD8uT4j00bE/VWqcl4EA4DBBQ/RjR74bWizGLqwn8K2H+MUyCPinOFtt34G53A1mp
 2rRqRkQpzNX6iuCP4Jod4I38TMqANcWDtzkOWyi4Fb0RjTPJZEO/5Y2c/DBrzZhrNvU+
 Hzqg==
X-Gm-Message-State: AOJu0YzdwItJPAN0fDoVs2+iGSxORHKapEefdxuKIdE4fT0ARgqYloVP
 owC/ZJqZuI33y9kbl3/9SNBeEOHDl71qjoa5S9wfzSXQq0LHbGsFqDNlrmj6B1zaCdKxBFJBY2Z
 r8LUh
X-Gm-Gg: ASbGncv7/kpqwyG5BnfMy1tPKrxxNEZ6RKYsxepMDHrjktQbp3GntDE6tqXmKgk9enj
 FEWxAqD5GcF4Hbkqv9GTgWPMvx3KdRtpRiq6ryzZocytS1XQDLlzg+XLOEsynShk0HEFnVamLdE
 CLwsYhFcWRJVSn++oSy4+792ESNeL9eei+CGJcHtH+tkHkbsUB7Q/COX1a9r/Hrp37zJurHu882
 YTtK3uGb0AuoPtndH8IuvF8V2Yln31b/J+7H3KumQS9VSuFa9JWt7m2/G0zOBUC0TZctOha3fyr
 NuPAP9lhlP3fpiWjISipRziwLBj2PoFEEN0507+QLkMHlQsnJltBJQVGIDgKUmtPB4XtCUafIZw
 ZUkSXW9lsZ38nsE7qPN4zWsSUAdKqSvZXL95VM8YjSHi0qfseGBB/JQe6G3Rkt3O3UwECo93nd8
 6wfq5dusu3ByRFQXeKaeSr+eTBRA==
X-Google-Smtp-Source: AGHT+IH1zeEozuSr9n8LDqSApLPApoZsaZefEkzOMpe9idEFdaHmrLYlZ7Gr+ME9RKerEuQ1YDqtqA==
X-Received: by 2002:a05:600c:1d18:b0:46e:3901:4a25 with SMTP id
 5b1f17b1804b1-46fa9aef67bmr141832095e9.20.1760435365756; 
 Tue, 14 Oct 2025 02:49:25 -0700 (PDT)
Received: from hera ([95.164.180.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb4983053sm231159515e9.8.2025.10.14.02.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 02:49:25 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com,
	xypron.glpk@gmx.de
Cc: javier.tia@linaro.org
Subject: Pull request for mix-next-14102025
Date: Tue, 14 Oct 2025 12:49:15 +0300
Message-ID: <20251014094915.15693-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.51.0
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

A multi-pr including some EFI, TEE and TPM changes.
Since the changes are small I included all of them in a single PR. 
Let me know if you prefer 3 different ones.

The following changes since commit 4e4a9de31de2a5f395ee25c59e4026422fbcb27e:

  Merge branch 'next' of git://source.denx.de/u-boot-usb into next (2025-10-05 09:50:57 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/mix-next-14102025

for you to fetch changes up to 377bc19fd92074bd32e6b29b9133037238ca54dd:

  tpm: Make U_BOOT_DRIVER entries unique (2025-10-14 10:42:27 +0300)

The CI seems happy
https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/27905

Heinrich, I changed a log_err() to log_warning() as explained here [0].
Please let me know if you have any objections.

[00 https://lore.kernel.org/u-boot/CAC_iWjK96Xzv0TwQ3CCp+2q84d0hZ7w0Qr154vM0C38aThyR=g@mail.gmail.com/

Please pull!
/Ilias

----------------------------------------------------------------
TPM changes:
Make all drive names defined with U_BOOT_DRIVER unique

TEE changes:
Rework things such that sandbox will also traverse the optee directory
when SANDBOX_TEE is enabled, but only build one of the optee-specific
files when OPTEE is enabled.

EFI changes:
Up to now we were relying on the file extension to accept and load
an image over HTTP. We expected images to be either .iso or .img.

By wiring up internal existing functions we can try to mount any
file extension and reject it only if mounting fails.
part_driver_lookup_type

----------------------------------------------------------------
Javier Tia (2):
      part: Export part_driver_lookup_type for external use
      efi_loader: Improve disk image detection in efi_bootmgr

Tom Rini (2):
      tee: Rework Makefile logic
      tpm: Make U_BOOT_DRIVER entries unique

 disk/part.c                    | 18 +---------------
 drivers/tee/Makefile           |  4 +---
 drivers/tee/optee/Makefile     |  2 +-
 drivers/tpm/tpm_tis_infineon.c |  2 +-
 include/part.h                 | 21 ++++++++++++++++++
 lib/efi_loader/efi_bootmgr.c   | 49 ++++++++++++++++++++++++++++++------------
 6 files changed, 60 insertions(+), 36 deletions(-)
