Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49107C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 10:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC01980824;
	Wed, 29 Jan 2025 11:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KoNYhkmi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BAEA80824; Wed, 29 Jan 2025 11:21:12 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 641F9807E1
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 11:21:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so44183285e9.1
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 02:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738146069; x=1738750869; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WAS2gVOGqreKuVsFAsUb7ms0bWCdZ342D1YtgyxX4mQ=;
 b=KoNYhkmi7WIEIgrRe499a+QWte0yjpq6Vq2Njedv6nHi4G/MrNxFn2cnpyYA6Dr2C/
 q5HTXy7jkC7a0XDTyzvvV6UKT8+ufFTWl2pkmI6S3Qv0lZKUIcI6EbP0H0CrKTG+TdJ2
 rCwE4TQJmTLJCGkKtvkqAy8eW3PjkBKzXYnnZkjFSfqC8grOfmfj+jUt8IZNSR7KTrSY
 NNaajQj29g1aVlVLQP9MHx6xvILBMlL6pLAXOjGoMJGhvpPNE4BhnICpnVHAuKjtfUC5
 +dzqEfySRZ8IkomUBpHNEo+Y3AKaTwPcdnoAuiKMdqfYCE+WC8d+P2mbeZ53DfrZ0I/T
 U4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738146069; x=1738750869;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WAS2gVOGqreKuVsFAsUb7ms0bWCdZ342D1YtgyxX4mQ=;
 b=CsJ7nL1u/hJknWU01F6swL0CyK27lhTOZiqm7JZyUIYZ75yGVnH4wfjtPtmVXgSXGc
 U+v3jRHALbP6rZP1UsMeWiqsPZO6EENadvJ8vqR19xkliprplqAttMyPtOPyrSSRYGGs
 oy0aaDoT8rqMMFHKls1XrlXHd3usYq5rgIDkbwx2zttI6ngnWuiGUNx/SnYGQz+VDKjG
 16rTGBPMDjmSeF0U+lGpRh/gksJ/t+sCyZaT4WErhIIhT8G8KnKcLZ4GjTOL+Dpjc6AW
 FcL6Kl2uK63gmKe/7L1cMiSsQx2XFJEY4Z4zAcP5+ITeURVinQcyZ4OZF6pR+JcQU+8F
 Sg/g==
X-Gm-Message-State: AOJu0Yxcbj9WVVa8/zFwv2XSMr32vYENq9O4X6PRw/rDwV2SYmfMfACI
 d53WEGve7s1vrz6PURdT1rwzlxuydqbZeXfdmmBPfgqP0QDyBcAfxwf9KI55f3WvLCDw+6yntb1
 /
X-Gm-Gg: ASbGnctcAZZZvOyLFDOc4v18F59IUXH4wvezFrZ82mjNNT9cvqhMFrsXnLXTKcISPGd
 a1207YUj2h67N320GnbPwzut0viseCy3bxSuooYJSCb//2VgJ2Cnpm3u/rwJigMulvNeEPrwgFj
 CLnaznTgagUYdM7g3gp7fNi0biPoa7y9/Rp9+4oD16gWSX5uAXmZFZVOhcrJysXPVm93e3M9HOZ
 BlAM/AujoyF6VJuNDJeZgqodFw1ZuUoXBnkWO58KzzmFNbhXAa1e8xvex6i2r9V+7ASiph2t/3Z
 05sX1ez05nw6hJa/bOvkKnIGZtQ3rMcXR0w3/GsylCqSWf28V4pGfYhkYNCf8euvHn+p
X-Google-Smtp-Source: AGHT+IHQ3eJT+tm8cI4c2Kx/jijbJcy+s6eaGr/Xn76ZkAkxj7yzouEufPGDgGAna6eYOGDuCGzlAw==
X-Received: by 2002:a05:6000:1849:b0:385:dea3:6059 with SMTP id
 ffacd0b85a97d-38c52097553mr2098853f8f.49.1738146068718; 
 Wed, 29 Jan 2025 02:21:08 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc32f6bsm17295095e9.26.2025.01.29.02.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 02:21:08 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: ilias.apalodimas@linaro.org,
	raymond.mao@linaro.org
Subject: Pull request for tpm-master-28012025
Date: Wed, 29 Jan 2025 12:21:02 +0200
Message-ID: <20250129102102.1844476-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
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

The following changes since commit a517796cfa5d8f4ca2f0c11c78c24a08a102c047:

  Prepare v2025.04-rc1 (2025-01-27 16:38:46 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-master-28012025

for you to fetch changes up to 8895ff8ae2186b53b4a073966ef16b09c12a69b8:

  tpm: get tpm event log from bloblist (2025-01-28 09:09:32 +0200)

The CI https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/24375
didn't show any errors

Please pull
/Ilias
----------------------------------------------------------------
We have use cases where a previous stage boot loader doesn't have any
TPM drivers. Instead of extending the hardware PCRs it produces an
EventLog that U-Boot later replays on the hardware.

The only real example we have is TF-A, which produces the EventLog using
hashing algorithms created at compile time. This creates a problem to the
TPM since measurements need to extend all active PCR banks. Up to now
we were exiting refusing the extend measurements.

TPMs can be instructed to change their active PCR banks, as long as the
device resets immediately after a reconfiguration. U-Boot can now scan
the active TPM PCR banks, the ones U-Boot was compiled to support and the
ones present in an EventLog. It the reconfigures the TPM on the fly with
the correct algorithms.

On top of that it's adding code to retrieve the EventLog from a Transfer List
entry instead of a DT entry (if present).
----------------------------------------------------------------

Raymond Mao (9):
      tpm: add TPM2_Shutdown command
      tpm: add TPM2_PCR_Allocate command
      tpm: add wrapper and helper APIs for PCR allocate
      tpm: add PCR allocate into the eventlog handling
      tpm: PCR allocate during PCR extend to disable the unsupported algorithms
      board: qemu-arm: select TPM_PCR_ALLOCATE
      bloblist: add api to get blob with size
      tcg2: decouple eventlog size from efi
      tpm: get tpm event log from bloblist

 cmd/tpm-v2.c                 | 128 ++++++++++++++++++++-
 common/bloblist.c            |  17 ++-
 configs/qemu_arm64_defconfig |   1 +
 doc/usage/measured_boot.rst  |   1 -
 drivers/tpm/Kconfig          |   9 ++
 include/bloblist.h           |  18 +++
 include/efi_tcg2.h           |   2 -
 include/tpm-v2.h             |  53 ++++++++-
 lib/Kconfig                  |  12 ++
 lib/efi_loader/Kconfig       |   9 --
 lib/efi_loader/efi_tcg2.c    |  15 +--
 lib/tpm-v2.c                 | 259 ++++++++++++++++++++++++++++++++++++++++++-
 lib/tpm_api.c                |   4 +-
 lib/tpm_tcg2.c               | 111 ++++++++++---------
 test/common/bloblist.c       |   4 +
 15 files changed, 556 insertions(+), 87 deletions(-)
