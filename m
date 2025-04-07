Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7602C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E18B483010;
	Mon,  7 Apr 2025 19:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SH18fc9o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1643182FB8; Mon,  7 Apr 2025 19:00:09 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0EEF82F7C
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 19:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso779029166b.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 10:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744045206; x=1744650006; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qyKSG4UyH/XNCv3I9IaMJ5AdmQIq7wef5mlpjkYyxVs=;
 b=SH18fc9ovhUYUmCz2wGPR4UDbC2+Ke7r8PNrqyGxs0y0y2gyVMHdDmV9vaG5oLKY+Z
 HSxeTLqVCI9vSe0GFRqko7nc6KRNU2A0zWYw/+KSH/cbgQm6D/qCiciejNexX1AlctXH
 EDMJUc3ru1iYt0COkWskKHnXVr189kg0jdwLetF+IEISOx25meIVjsoBriQx4nH+Dz/N
 9KeNlMuZDk4o1DZWW9TWEBxw4oHkYTa40wZS5cKixoqq9p/vP1VDxR7L2pRkiJvy9w2O
 uKHlvHLnr4UiXXUhiBo4yJE17r9gftVFB3JkNS6h5SeSmf7Q9KeQJG9dQ21VUiYXv4pK
 zOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744045206; x=1744650006;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qyKSG4UyH/XNCv3I9IaMJ5AdmQIq7wef5mlpjkYyxVs=;
 b=HJhbrCztfuOp4YzXJajMooB9J8zdg5a7sI8bslfZftWnjugX/454tLISjMZMXpM0FX
 biEpEiiaxymtXoFxknJ1YpCjc166A+I1oJIQDah5Szy9n1s1Scqw2AgD5ZS5MEh/bOVm
 Pa0y0phF0YDhC4yYGmCUkInTuv8T8TLQhL4vvQDF7qbg4BFZ3UHUBE+2Iur1oM7NBbyu
 Q1GckiHUVVbGv6s4Aq23owVeTQcmh0gRWARiPYcPuavKyjj1XuUAs2ihbkcGTJW0GDqZ
 IHzNi8IUukL482p1lzCAuhbYMRPV+lbq2tvU8I20RxNqfyh0TjXOCYyRev/eKcfX5FeV
 Oy5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoiDkVTgTx3T8gRRgMo35J45Xl1S8HExV1xbNdeglHkpzXgpAd7QxkQ4Vk0NhCyz5ppljF6fY=@lists.denx.de
X-Gm-Message-State: AOJu0YzcB+HDzKYEFeqtRuHX/SWPG3n8V8rp55GiNQUkMLhjo7BJ04W1
 BlIlr6gk9ujxKCDddfscCjK18s9fs0IdziBQZK8wmycJsHbOrsS1aXqT77Z7gk8=
X-Gm-Gg: ASbGncvZM95kEjJMgz2S8F/bnl8hyaMw6PNky3dEuZJYA6XMdJIMhBhl4/k5XQwC2z2
 +UfktpgDcdeljf+Vg5ZiE8z6KTm3Lc+4usyBQn012MjI5UV42vlm0wSkranBVgOAqxhbFlrqoVe
 Xj4lfkYm32+kMLJ+inBVqm2OIbakmBY0SgpgOayxMkYQjSqZ7Xguhp+GVO5GkAP8BjeYD87/B92
 z6IlrEnKPJdwTtQVmgxZJ/WzZ9kjq7BRdlqi8c823lfKssBA80U/I9mgz+BZxdpMEDXVd/qQT/P
 4FQXsqO8S+LVJ1pixlPKSM5RvFXJIr91Kp6Y8/7/R1xHOnW0RGyZPyCA2g==
X-Google-Smtp-Source: AGHT+IFgk64z6BfjAmc/rsIcf/eZc7fGRv7RFM6iyaiPB8mknuo5/RKmBbQJSGnE3M0j32ooqJUuWg==
X-Received: by 2002:a17:907:3da2:b0:ac7:c59e:fc3e with SMTP id
 a640c23a62f3a-ac7e72b625emr864472566b.25.1744045206327; 
 Mon, 07 Apr 2025 10:00:06 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:b2e5:7ea8:e86c:3f99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea16aesm773603666b.70.2025.04.07.10.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 10:00:05 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 18:59:33 +0200
Subject: [PATCH 12/13] board: dragonboard410c: Use button_cmd instead of
 custom code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-db410c-fixes-v1-12-524aefbc8bb4@linaro.org>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
In-Reply-To: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.2
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

Simplify the board code by using the new BUTTON_CMD functionality, instead
of implementing this separately using C code. This allows disabling or
customizing this functionality if wanted.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 board/qualcomm/dragonboard410c/dragonboard410c.c   | 22 ----------------------
 board/qualcomm/dragonboard410c/dragonboard410c.env |  2 ++
 configs/dragonboard410c_defconfig                  |  2 +-
 3 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index 697e3c9b08b5c874912eb66ff4f0b3d32deaae01..4698b9d5e3e47a9b0389d9f6bafab9dd6db56a41 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -51,28 +51,6 @@ static void msm_generate_mac_addr(u8 *mac)
 	put_unaligned_be32(msm_board_serial(), &mac[2]);
 }
 
-/* Check for vol- button - if pressed - stop autoboot */
-int misc_init_r(void)
-{
-	struct udevice *btn;
-	int ret;
-	enum button_state_t state;
-
-	ret = button_get_by_label("vol_down", &btn);
-	if (ret < 0) {
-		printf("Couldn't find power button!\n");
-		return ret;
-	}
-
-	state = button_get_state(btn);
-	if (state == BUTTON_ON) {
-		env_set("preboot", "setenv preboot; run fastboot");
-		printf("vol_down pressed - Starting fastboot.\n");
-	}
-
-	return 0;
-}
-
 int qcom_late_init(void)
 {
 	char serial[16];
diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.env b/board/qualcomm/dragonboard410c/dragonboard410c.env
index 71f929b646cc305cf5223cd3462fe2350bc8093e..38399d65c640ee18261529ee3101b268700fa004 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.env
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.env
@@ -2,3 +2,5 @@
 initrd_high=0xffffffffffffffff
 fastboot=fastboot -l $fastboot_addr_r usb 0
 boot_targets=usb mmc1 mmc0 pxe
+button_cmd_0_name=vol_down
+button_cmd_0=run fastboot
diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
index 414dda6778c95eb3fdcd6ef522d8c7d0ef9219fa..449d48a3c004117b832ad620d49beb681a9bda68 100644
--- a/configs/dragonboard410c_defconfig
+++ b/configs/dragonboard410c_defconfig
@@ -14,6 +14,7 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_LOAD_ADDR=0x80080000
 CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 410C"
 CONFIG_REMAKE_ELF=y
+CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
@@ -22,7 +23,6 @@ CONFIG_SYS_CBSIZE=512
 CONFIG_SYS_PBSIZE=548
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
-CONFIG_MISC_INIT_R=y
 CONFIG_SYS_PROMPT="dragonboard410c => "
 CONFIG_CMD_MD5SUM=y
 CONFIG_CMD_MEMINFO=y

-- 
2.47.2

