Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE21EC27C78
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 14:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3EF287923;
	Sat, 22 Jun 2024 16:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AAxUtySt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63126879AF; Sat, 22 Jun 2024 16:36:23 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E240878E2
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 16:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a72459d8d6aso1399566b.0
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719066981; x=1719671781; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hh2Bp6Fi0+BCvqGwCIWrQpgkA916kcZH6xOeRZN+M30=;
 b=AAxUtyStxbvFTvRGrmmbLQojokOGMDSrqVUmz4hSKWpEAnbK6vsFMa/GL+4yaqxpio
 F5aOKceYsSFa3WoamXRKt/3EP6tfPlJ2btxO2duCZP2yY+SxmASVYRxwKlkPcl/DMfJI
 JFXoYGL5hB6Vc4xchIniN7nTjK+yxM1EaKRrCYqXaSIrYmAzBB+0pvRjzgYVfDxpLfUG
 lyhydjx2mfkylmM8PdNB9Rj1akbPsopruzosWrvRMZk5QNoKnaoLZP4pvl0Ae1gIJDtT
 6YKYqtCQUZM+lqrU6XgHff4WxgoFSvLnrxxglHJFnaP7CX33Mlg/t4G7xLVvNrFUEzCF
 3KEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719066981; x=1719671781;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hh2Bp6Fi0+BCvqGwCIWrQpgkA916kcZH6xOeRZN+M30=;
 b=d27Yni4HPXketNYoLp7+WFqm5W1egl2grtfoKFtlH/N1JjEODu7tf6cKXql5d5KN7D
 GMAfEspnAFlPKlO/WmcjSZxm/Gv08TxeJfy1XW92QbJcvrr9AH5AQsy0HqlK/AqivLbv
 hV1kYt68+Wbb727YpBQCZimUaH9JyIcZeNW9r491/OZRzyFVH+9SsAZPG2YB7CW1QHZP
 +x0NDFafT3O8MFM9YMk683XQgs1zQMCsjL2vbrW1SQhqivSUwV2hpWUcHWSPbSzNMvSg
 5+pSSNZXv3qPhg7KKCh+X8I4h0Im5GMba8i3U+ity+kms4YdLkHSxarXAj/VpiUoAi9t
 EzXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVecC3zk9alCx4wzCMizXIMAehQndcumJgNi7ex2i6KOJBbeSUA0swWIz/wCNUoKtNXPZ4GtdwqITL72cfborKzb1CNeA==
X-Gm-Message-State: AOJu0YzSYshnN8Fkh8jQNEJPNbZXb3FQA42YWwqwgHV+7IFHWI5FyXmR
 3dKeHfTIbiOO8d6zCHRbXg0tLx2NvToHVIcUByVHwMuW+hv9MhDLHBup5E8Y0kY=
X-Google-Smtp-Source: AGHT+IGiJliT0nWZUKW9rhiSjxt09OqEwh+d0+m34Az4AGF16IRvQ6ryU0SlIjhBCispI57YfSY9Zg==
X-Received: by 2002:a17:906:e28c:b0:a6f:b1fa:aa24 with SMTP id
 a640c23a62f3a-a7245b45af4mr1725966b.5.1719066980480; 
 Sat, 22 Jun 2024 07:36:20 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf54a534sm204005366b.136.2024.06.22.07.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 07:36:19 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: sjg@chromium.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Michal Simek <michal.simek@amd.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
Subject: [PATCH 0/7] The great TCG deduplication saga
Date: Sat, 22 Jun 2024 17:35:36 +0300
Message-ID: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

Hi all,
A while back some TPM measured boot code was moved out of EFI in order to
support !EFI boot methods, e.g bootm, booti etc.

Back then we decided to move the code in the TPM subsystem directly.
In hindsight, we should have created a different library file that hosts
all the TCG specific bits, but better late than never!

Since the algorithms that the TPM supports are only known at runtime, we
unconditionally enabled all hashing algorithms. Simon reported some breakage
lately due to size limitations and he wanted to remove some of the supported
algorithms from those configs.  But that's not always safe depending on what
the user expects the TPM to do.

If MEASURED_BOOT or EFI_TCG2_PROTOCOL is enabled our Kconfig will enable
all supported hashing algorithms. Nothing changes there.

This is an attempt to allow users to add a TPM and not enable measured boot
via EFI or bootm and at the same time, control the compiled algorithms for
size reasons, without shooting themselves in the foot.

Functionality has been added that checks the TPM active PCRs banks against
the one U-Boot was compiled with. If all the active PCRs banks are not
enabled refuse to extend a PCR but otherwise leave the TPM functional.

patches #1, #2 have been reposted and are fixes from the code moving
patches #3, #5 get rid of duplicat header entries
patch #4 moves the TCG code out of the TPM in its own file
patch #6 refactors a function so we can use it in both TCG & TPM now
and finally patch #7 adds the desired functionality

The u-boot CI seems happy, my internal CI that tests EFI measured boot in
various scenarios is happy and the EFI eventlog hasn't changed at all pre/post
patches.
I haven't manged to test bootm etc, but that code hasn't changed at all and the CI
tests are passing. Eddie any chance you can test it?

Ilias Apalodimas (7):
  tpm: fix the return code, if the eventlog buffer is full
  efi_loader: fix the return values on efi_tcg
  efi_loader: remove duplicate TCG algo definitions
  tpm: Move TCG into a separate library
  efi_loader: remove unneeded header files
  tpm: Untangle tpm2_get_pcr_info()
  tpm: allow the user to select the compiled algorithms

 boot/Kconfig              |   4 +
 boot/bootm.c              |   1 +
 include/efi_tcg2.h        |   9 +-
 include/tpm-v2.h          | 541 +++++++--------------------
 include/tpm_tcg2.h        | 349 +++++++++++++++++
 lib/Kconfig               |   6 +-
 lib/Makefile              |   2 +
 lib/efi_loader/efi_tcg2.c | 124 +++---
 lib/tpm-v2.c              | 767 +++-----------------------------------
 lib/tpm_tcg2.c            | 732 ++++++++++++++++++++++++++++++++++++
 10 files changed, 1335 insertions(+), 1200 deletions(-)
 create mode 100644 include/tpm_tcg2.h
 create mode 100644 lib/tpm_tcg2.c

--
2.45.2

