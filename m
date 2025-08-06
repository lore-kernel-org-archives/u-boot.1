Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE291C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 22:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B808C83AFD;
	Thu,  7 Aug 2025 00:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cbbzcoi3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90D8483457; Thu,  7 Aug 2025 00:27:38 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0BEF83B0E
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 00:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-306db05b292so161923fac.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 15:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754519238; x=1755124038; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=127HV3DeMcQt3edH3LDO8ncD+TXb10BATZDQwm/W/Hs=;
 b=cbbzcoi3A8NvNl0Z8jwx+3n6Gz4pYMMMkioeDb1VWHbvO0C9RC+FdXtx7A6b9er2nw
 EEVavpnVvCGJ19OtjScs4oJK+gfaQgoD2Bqtu/+TezQygLuqdGjd+AuGNZAiRKiNmMZ7
 iyEo3SD1jjHrqMfP5SQgR1IOrGFvx+cmKPbA14ukUnFg3UbPdFuJM8wrT9/06jCJDG2P
 8qta08T0l+ozHAJe/Kq2ubCI5S/JopQm/uAB5tsqzO9EAKJpcN/C8qbaRvT7UYi0ZhXg
 u9C8rrgrktpEErv/8o1XzALCIzXk/4OPUk0SPDa8KYU/Yqj6SLbBggncb6j9UJ3eeUEF
 V/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754519238; x=1755124038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=127HV3DeMcQt3edH3LDO8ncD+TXb10BATZDQwm/W/Hs=;
 b=CETVpyQ9e3q01Oyz4AEhTs1KotV5CDOg6nMPWeZ0Ue6J5AwqAeYdl7iFK1wfKQaMP4
 7KD91qDo+e82MUtvVRT6VHr6LfsgG8IwjPdvlx62J7oucfAYzECK+rF7kasRlp8SeGWP
 RebHSUp+KlnEtISabZxQM0Anpf4SA5yqKdealGZhmCjYjWcPafMBtAW6ZAc+DtTt6abK
 pJ+KoDipQDmx5+Mj0mwXkucj/z5ygnZv9cWZVxCU2JvM23yZv+zwxY3lM7bn3cLMHiKa
 7m0YSBBqVpJP9wAk3AUOjhymlR4nxvmdhnqsAovT6zjsmY8Y45Rc+ZBesZf3dREY4hlE
 unSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUELpFSlYwUsL85cfzqc39PuPwBMQQA4lay09szsNMIVcduVfiZ8ijbeqFZffcMQ5rIfI3HqkU=@lists.denx.de
X-Gm-Message-State: AOJu0YxbPzItYTA5jEzhd+41lKGUtzP870+Olim+CEeVofOFze18kgRm
 NT449wLQOFcKutOPP6K64nyD2QZwpfJkNyT9J4qlq2vEI0bA6RvKlowQj6iFz89cu/c=
X-Gm-Gg: ASbGncvpunqLEip0n92VHQmbGxs5OuDck+J2QIRvzqEBgwDj+jrj2Y0ip4/s3dpvtMK
 I7dI8nW9RH9KO9ggJjAHb7mAqkcPQKJfZ5p+Em7nOV0+iB3vsFkiFbXGH+q1ZtCNGMC4SZEfLG4
 G317OygB1q4Cf3HyVY1l/Jftwbg6JkFT6G3tM5EtimXrI6grfZqLT082bvnS+/wwxzcrzVVZXhd
 EApiEofPhf6Fmgy/mDvnxi0ZEEcRiLEVCAciKpuAtZ/MBV9u0DkDjcNkHD60Il0Fd+/h28AvV4x
 dvRmcewyj6v2TiGA2F2sE94eVE19O4du26S21fGuQZVz/G31sh3A48tHQIROT1CX8yGQep8tHuN
 Da4LW0BQqUi2T0tDpyqhZn5M1qQ==
X-Google-Smtp-Source: AGHT+IGcfT5xnE4ZgnPg3D6+vhrXzcpEsINZNC5OPfmIC/bEC52HmPXuQV0mwjSoNHfFe9U/eNZzKA==
X-Received: by 2002:a05:6871:d40f:b0:2ff:a4c2:b52c with SMTP id
 586e51a60fabf-30be2cd7b2dmr3305912fac.34.1754519237599; 
 Wed, 06 Aug 2025 15:27:17 -0700 (PDT)
Received: from localhost ([136.49.61.16]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74186caaa8asm3644702a34.2.2025.08.06.15.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 15:27:17 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 07/10] board: samsung: e850-96: Add bootdev var to choose boot
 device
Date: Wed,  6 Aug 2025 17:27:07 -0500
Message-Id: <20250806222710.23773-8-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250806222710.23773-1-semen.protsenko@linaro.org>
References: <20250806222710.23773-1-semen.protsenko@linaro.org>
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

Provide a way for the user to select which storage to load the LDFW
firmware from, by setting the corresponding environment variables:
  - bootdev: block device interface name
  - bootdevnum: block device number
  - bootdevpart: partition number

This might be useful when the OS is flashed and booted from a different
storage device than eMMC (e.g. USB flash drive). In this case it should
be sufficient to just set:

    => setenv bootdev usb
    => env save

assuming that the USB drive layout follows the same partitioning scheme
as defined in $partitions.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 board/samsung/e850-96/e850-96.c | 40 ++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/board/samsung/e850-96/e850-96.c b/board/samsung/e850-96/e850-96.c
index b5f6ba23432e..3df241edde2a 100644
--- a/board/samsung/e850-96/e850-96.c
+++ b/board/samsung/e850-96/e850-96.c
@@ -9,6 +9,7 @@
 #include <init.h>
 #include <mapmem.h>
 #include <net.h>
+#include <usb.h>
 #include <asm/io.h>
 #include "fw.h"
 #include "pmic.h"
@@ -136,21 +137,40 @@ static void setup_ethaddr(void)
 		eth_env_set_enetaddr("ethaddr", mac_addr);
 }
 
-int board_late_init(void)
+/*
+ * Call this in board_late_init() to avoid probing block devices before
+ * efi_init_early().
+ */
+void load_firmware(void)
 {
+	const char *ifname;
+	ulong dev, part;
 	int err;
 
-	setup_serial();
-	setup_ethaddr();
-
-	/*
-	 * Do this in board_late_init() to make sure MMC is not probed before
-	 * efi_init_early().
-	 */
-	err = load_ldfw(EMMC_IFNAME, EMMC_DEV_NUM, EMMC_ESP_PART,
-			LDFW_NWD_ADDR);
+	ifname = env_get("bootdev");
+	if (!ifname)
+		ifname = EMMC_IFNAME;
+	dev = env_get_ulong("bootdevnum", 10, EMMC_DEV_NUM);
+	part = env_get_ulong("bootdevpart", 10, EMMC_ESP_PART);
+
+	if (!strcmp(ifname, "usb")) {
+		printf("Starting USB (bootdev=usb)...\n");
+		err = usb_init();
+		if (err)
+			return;
+	}
+
+	printf("Loading LDFW firmware (from %s %ld)...\n", ifname, dev);
+	err = load_ldfw(ifname, dev, part, LDFW_NWD_ADDR);
 	if (err)
 		printf("ERROR: LDFW loading failed (%d)\n", err);
+}
+
+int board_late_init(void)
+{
+	setup_serial();
+	setup_ethaddr();
+	load_firmware();
 
 	return 0;
 }
-- 
2.39.5

