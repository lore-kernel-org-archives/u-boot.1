Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DECC7115B
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 18:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8BC782BA1;
	Fri, 20 Jun 2025 20:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K2AY9C4r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15BCF80C83; Fri, 20 Jun 2025 20:50:17 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9929382D2B
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 20:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6065251725bso1548402eaf.1
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 11:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750445411; x=1751050211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r3/OxTYJfB40epq9m7qJSSx+jld3rN8Vn9ju3fu7zzI=;
 b=K2AY9C4re8cRB+EL5R/JU7zeUr0FNY5zQ/szKyDvM/klcng8APUeMAkhnxl7DfFYmL
 2BZ5Rsok8vNFrvyQD8qhjzYIzG1HfgqPK2B2HXr2HH7y2ZkhjTMiIQI1onkUu4pGwRJV
 Zwvju/jHP09GHeP0xE5SQGdX/P9bf1EPSi5mOPmjSJM60uc62WTEE4lakea0LOep3+pA
 wh27CYDuvc7BFgbv09RrjMOqxXtwnhPWeD1ySRYMMWI9mPzEynay4qn2SOt42OAUL/3Y
 NGg5QT/Hzm5U47RBqZa4A6bILh4Z0lYq+GSDoBYg4umD2BW6g5qoFouGeJnqKL1EPgAf
 juyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750445411; x=1751050211;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r3/OxTYJfB40epq9m7qJSSx+jld3rN8Vn9ju3fu7zzI=;
 b=HvOSWfGiKUwgbwk/vKtA6f/P6GSGGTB8QtAdZtBu+E5jtR7CTDxlUflk7G5aNNL9+Z
 WF9EJPsrFCsVop8toB/e1xH1jqMrasDloHQhzfdoPSMPQe567Yq5+M1uSSRbC7mtxdcM
 ILCQEzJFzB3ZTrN3V68mQrAo4u66Xd5zxO6mjEwTuiYf6pKzKj8AIS1OQ/Kvm4f7B0No
 0EONxLEzEuyDbRWdvLlOZBkHj2Ck5wkRYvuMnctAXYk/6aPuz3RjjhSGtBnsEm7yxh04
 qBTgrTuU+4lf4Ai49IzAusEjsrMJkLvd8Jt2ETTDCZMSKmJ/ax4hpv06+c+jJjX15Y7A
 gM6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2v906NKUjssEN+VTdL6Vs3FSvp4uSCihGfgIKeetAf7vUdsiYRVxw345NQeZ22oMF6fcLPj0=@lists.denx.de
X-Gm-Message-State: AOJu0YwezDlecTdaoaowjACbOUCg5m0Ta5mM4L09lTm1eveA/rMpnzPz
 3REnnL3PHL8ITTV+XluVF9X7GtQ5vbBJonGD35puUTnZkaGahuHueIDVAONmCeW+nt8=
X-Gm-Gg: ASbGncvJpnX0kRZHkbulWat2EGs3ZLhFgB14d0FkBmV+2YssWtVoIBm3Y96Gmc8tQXZ
 W68PUtPQvXKpMl36tCKSnw+86sWoOwkAoE6pv063wWzza02cFBLTzQLjWWoWR6YQsSzIwNk8u0C
 IifPCPbwz7fmwKqAJMlrL86ExZ4iCWj1tSsow9jnSfq74U1wO+1d4YnoagvFpm8/R1SZucme/GI
 RcnKd19OoGdC0zfamwxTjFx6pykJJCA+kT6NZ9noYsNh8pi9x5QO+okjTd7Q1KV5lW54XLAkEE+
 9bgpbc9zZmkhKANSlZa9jqUDsRawRQ2e8LaDfCIV8UwDJARG6NfdWiMFknsxJ+2c3P9l8IEHBZL
 J0KebWUg=
X-Google-Smtp-Source: AGHT+IF1Eatcj0rVB6hEvVnTTjtyiGtcSV9EA1EU3B7n8vBiwt13Aqe0tla5WeonJCnXi3gLqplv6w==
X-Received: by 2002:a05:6820:999:b0:611:66d6:8c2e with SMTP id
 006d021491bc7-61166d68ca1mr835794eaf.1.1750445411305; 
 Fri, 20 Jun 2025 11:50:11 -0700 (PDT)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6115b68edc8sm322296eaf.7.2025.06.20.11.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 11:50:10 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2] board: samsung: e850-96: Load LDFW in board_late_init()
Date: Fri, 20 Jun 2025 13:50:10 -0500
Message-Id: <20250620185010.11400-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
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

As stated in 5e847f7729b3 ("efi_loader: call efi_init_early() earlier"):

    efi_init_early() creates an event hook for block device probing.
    It has to be called before any block device is probed.

Indeed, efi_bl_init() registers EVT_DM_POST_PROBE event, which calls
efi_disk_probe() whenever any block device is probed. And to make that
hook work, the initialization of all block devices was put after
efi_init_early() in initcall_run_r():

    INITCALL(efi_init_early);
    INITCALL(initr_nand);
    INITCALL(initr_onenand);
    INITCALL(initr_mmc);

Because LDFW firmware is being read from MMC, attempt to load LDFW in
board_init() causes MMC driver to be probed. And because board_init() is
executed before efi_init_early(), the hook mentioned above won't work
for MMC devices anymore. So EFI disk objects won't be created, which in
turn makes the EFI subsystem non-functional, showing next symptoms:
  - 'efidebug dh' output is empty
  - attempt to add boot devices in 'eficonfig' shows this message:
    "No block device found!"
  - 'bootefi selftest $fdtcontroladdr' shows this warning:
    "Cannot persist EFI variables without system partition"
  - booting GRUB with 'bootefi' runs minimal GRUB shell which doesn't
    see any block devices as well, probably because EFI vars weren't
    passed

Load LDFW in board_late_init() instead, as it's called after
efi_init_early(). This fixes the described problem and makes it possible
to run EFI apps like GRUB correctly, add entries in 'eficonfig', and
makes 'efivar --list' command in Linux rootfs actually show EFI
variables.

The only user of LDFW at the moment is the TRNG driver, and it's probed
later, only when it's going to be used (e.g. on "rng" command). So it's
fine to load LDFW in board_late_init(). Now the corresponding call order
will look like this:

    efi_init_early()
    initr_mmc()
      mmc_probe()
        EVT_DM_POST_PROBE -> efi_disk_probe()
    board_late_init()
      load_ldfw() -> fs_read(), blk_dread()
    exynos_trng_probe()

Fixes: ccfd8de541a8 ("board: samsung: e850-96: Report LDFW loading failures")
Fixes: f04e58cc9788 ("board: samsung: e850-96: Load LDFW firmware on board init")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---

NOTE to custodians: If it's still possible, please take this patch for
2025.07, as it makes EFI functional on E850-96 board.

Changes in v2:
  - Squashed both patches into one

 board/samsung/e850-96/e850-96.c | 9 +++++++++
 configs/e850-96_defconfig       | 1 +
 2 files changed, 10 insertions(+)

diff --git a/board/samsung/e850-96/e850-96.c b/board/samsung/e850-96/e850-96.c
index 0bef68d2fb20..3bbd95201b5f 100644
--- a/board/samsung/e850-96/e850-96.c
+++ b/board/samsung/e850-96/e850-96.c
@@ -18,9 +18,18 @@ int dram_init_banksize(void)
 }
 
 int board_init(void)
+{
+	return 0;
+}
+
+int board_late_init(void)
 {
 	int err;
 
+	/*
+	 * Do this in board_late_init() to make sure MMC is not probed before
+	 * efi_init_early().
+	 */
 	err = load_ldfw();
 	if (err)
 		printf("ERROR: LDFW loading failed (%d)\n", err);
diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index 5facd418260c..e4c6aa28e0b7 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -19,6 +19,7 @@ CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_DEFAULT_FDT_FILE="exynos850-e850-96.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_BOARD_LATE_INIT=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_ABOOTIMG=y
 CONFIG_CMD_NVEDIT_EFI=y
-- 
2.39.5

