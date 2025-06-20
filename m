Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90690C7115B
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 02:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D32E82D39;
	Fri, 20 Jun 2025 04:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UY3dFSZs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A417E82D88; Fri, 20 Jun 2025 04:26:04 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B3B782D34
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 04:26:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72bc3987a05so830234a34.1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 19:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750386360; x=1750991160; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8fqpV8p75oQjigV1jTWftiIvxgkaLTFyd9SIkmgReY=;
 b=UY3dFSZsD7LTkUL/E1Mmpy86UOmzPmX7fApXaKrDEw5csIpoOyyLobEG2nXGWfiGZB
 F6tcaSDFKt81QUBmQixrave/+ZtxcGMbVbx7r2S1DqKEQLb1X59m4daqCGx5HtowliFf
 W2HYEc41nV5QqtUdjGjTBKf1BMMFNMLqU7j6KW4VcQR26DuSyDTTM75luIPu3Htxhzk7
 0Jo+d8Edf+qQMi1k7anm6W23+RCX9iagukfWrJhh+QJ18fYJp2ZXzEoVgu5uFdHuKg+h
 LCKaYcC5/SYUsb232GiNWHnqDaIk/dwg+EUF5UGKaB8leQiMGFyE/Kj0ub/02pwL28oJ
 j6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750386360; x=1750991160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j8fqpV8p75oQjigV1jTWftiIvxgkaLTFyd9SIkmgReY=;
 b=aVjt0j7ocUs5fhxc5iTIooY2RsQn+PDNAKRg1+vSl4zepBIYZQAuB2i3sRGqVlzMn/
 76nXyvTOXiMJLfOyCGcEpLuItEE3NogvreRFyM2NKvwiXUjuO5iL1AJtF4stN5xv7eiM
 plx44fpRSJNh5ia23FjFhz6o0IANuQ/hAf4x/EgWFyYph2LbdmAdaaWONN942ssx2KkL
 eNh9S0JvCobu9TcIj7QwCfhVhUk372AlSUeZX9tUa+QIGWKxVvh2/CASSyHSxYDK91RE
 KpE75TbYp6WnSqvfdxch73Cu39N9+eJ/K7j1LmtF7QtEjRY+G3GeJSBV8+4RUyqgBLHL
 P1qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZlkNUKue+2QRgD/Z7jbTFH5vpZ420UQmEmsqfxqnbV++Ou+GyCh7B8RRzU2o+6yfy4KcShzA=@lists.denx.de
X-Gm-Message-State: AOJu0YwSR6TJEzgybKU1IX+3OXJzrUb53AuBDJN0TxtzH6Rszsoj3U2Q
 uixj/24tljlE/0SpYfJHc2zrIUc5O1+MSf18/SBI+8QlfqnlmpjzZS88EdmLE7KOamE=
X-Gm-Gg: ASbGncvRU2gS+JTpxVsJ6tJvBaNju4kgGMbPmfX3zh3mnfHySECGKXECfBVSSq5dyUM
 oL9Y25pk5VjR0To2Q7Ipf0+r43860N+K86LDJjz8yoEKXU2/yF96AHbdUTyu6Lvyj28+fjMYV7W
 rH/LPHhjprkvdRSDEZdSE0uAen6uQFYN6gZ6ksskllt5/MDHiZILD2Zdako4EGxxD00ptHnmJBY
 iftv7xh+xpK+HmdH1/sMuNk4wFRurUNT3xPMIE7xnvMWCzN75USPJd9XnPTNr6ZlhWxOhXICpEO
 kIdl0dl99ZJfn8LzoiR2RrxIlaypNgZGT3wFkynFGsVTMNP12//u7SkP/zQ6+hi1bAYcanhW
X-Google-Smtp-Source: AGHT+IGjg735Mwud0cOiEQxzAidDbVT64dz7poU/5OVm0+jZOXl5jLKmdHkJ44qKGV/kPuBfLlrf/w==
X-Received: by 2002:a05:6830:719c:b0:72b:9422:aec with SMTP id
 46e09a7af769-73a930498b6mr563774a34.8.1750386359783; 
 Thu, 19 Jun 2025 19:25:59 -0700 (PDT)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a90cbb5ccsm157060a34.58.2025.06.19.19.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 19:25:59 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 2/2] board: samsung: e850-96: Load LDFW in board_late_init()
Date: Thu, 19 Jun 2025 21:25:56 -0500
Message-Id: <20250620022556.10363-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250620022556.10363-1-semen.protsenko@linaro.org>
References: <20250620022556.10363-1-semen.protsenko@linaro.org>
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
 board/samsung/e850-96/e850-96.c | 9 +++++++++
 1 file changed, 9 insertions(+)

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
-- 
2.39.5

