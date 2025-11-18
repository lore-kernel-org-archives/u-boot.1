Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6FECF2562
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 23:22:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E320883E3A;
	Wed, 19 Nov 2025 00:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y9HQkDi2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30BA181D6A; Wed, 19 Nov 2025 00:21:30 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B170383C62
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 00:21:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-657044fea68so131061eaf.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763508086; x=1764112886; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iE1f8rbZXx7qDMxqpujuuj1AZwQ6EVUU0xIOyopiolQ=;
 b=Y9HQkDi2V1PXg6PABXOCcJcgrVhzYSsto4YEujH5aHEwEZ8u7pxft1RwzRv/VDU4V3
 P5qaSVeQGrFTdbvMUGjOxTPNa80Ly4K7wYWzFsMCASsmTf2myfeOlI61iEj5xjsUudqK
 +sBavOm9V3XCuarDq6YXccq+HLNIyU0jI5vsH/R6PV2mp1luywd9cJNMO1ZxpOz5Bgc9
 Ws/SJR6HQC8D5Y5JjSkERc5YDEXjK8So+LY+LqkTYAbleUt2zuH+ff3n723uTCUhRAWw
 Nm8Vgnvg/oqwLaCYuAFOYr8iSWfdY4Xdagc5DSRsB4UmJw+MY1C3jqJ6c51/o89BSYOC
 OCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763508086; x=1764112886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iE1f8rbZXx7qDMxqpujuuj1AZwQ6EVUU0xIOyopiolQ=;
 b=E6u6M1VxFfBIdYa5ksYIS/JMOjMAZCFeB/iy2xa0rShIxx1NI7L/COBTifwFpViV/u
 mMKl/uJoXZaE7mLlc1JXE2TRMt+FBjPVHV5Apfsw0yO+a6GmxfshnjAj5OiyixZ7JGel
 yB5b6VBa0v020zKUEKBzOsIwcn744Q2QSWRBg6YcXeE+KQGCBNuPDgt0Mk2vdCUfUwk6
 k9ogF8ot9o5lQSZAPBXrN7IY5E4aKZJDxpG4+PqDoUja5Nwj7jGeENZ63W7nutyQr1mQ
 cYbBPCTXXodqaWQonxht1gHPSekFlPHC7AC9YA42/IvPBG8aytqd0wejLjANh5+OiSUQ
 Pujg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMIioaXhqALntn78bdiFVteXjSJd+j9XKavUjFgxCxMFhuvJO1XLsIq1Zy2aVCSaAPbID6yqc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7J/kTr3vsMJ6oVWhd+dr77lHwxWaRfWi8v6nEuI50bBidgrVs
 CrsSPnklkiT/4wv37wt90gtodlQewTZiYSH2NDQTiAnJ9qKHNZXXS5TpubPyyyBC9ho=
X-Gm-Gg: ASbGncvgRjL5nWrA+t17FiIFRF7Krq8d6/9GYcSNyFKgQHAZnCHLXNNohGOfVPkJ0W+
 606mni4BZLFYARaE/tI5yx5SAmCVaWX11QF0IoMz9HhEO8TkHmK0ee4ce236mTaRckvK2OvhIaL
 N6esXf0qbLOw1h7qoU0zYee+gozgvqZDLHs/EV14shmBQFIZybEtC3PuTsVfCHO21ilnMX3ck5u
 RQ5/vab2onHpafM/ogmlIfr82tR3XD5tz8DJbze8k50f6KyuZBTKcPzBNNEgX8tk8NLPIKbItdP
 5j3L5xsuqRwM2A7wvOtzOUJQLKTDGUHm5VpWq3Op0qGZe8SX1ELUJLLuVTFP8aciuM6egTVxPGy
 NiqDsRN9RIJFEwgxg16tLDoF+xxap4YTuvjUoyrjjM2Uh0KvmA39Mbaho8FB0wphM0APF1831qM
 /f4Ar5McxnYA+13nejr6Yt
X-Google-Smtp-Source: AGHT+IHUwuXg2kKa4zuYwUo9/F2q+p3bAuEUBylt+UeL28TOXfE0CXAz3cb24AR0RHYrF7wrx/cONA==
X-Received: by 2002:a05:6808:6f86:b0:44d:be91:afe9 with SMTP id
 5614622812f47-450f1148073mr211791b6e.27.1763508086448; 
 Tue, 18 Nov 2025 15:21:26 -0800 (PST)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with UTF8SMTPSA id
 006d021491bc7-65748180aedsm3308517eaf.0.2025.11.18.15.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 15:21:25 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.denx.de
Subject: [PATCH v3 6/6] board: samsung: e850-96: Enter DFU automatically on
 USB boot
Date: Tue, 18 Nov 2025 17:21:19 -0600
Message-ID: <20251118232119.17928-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118232119.17928-1-semen.protsenko@linaro.org>
References: <20251118232119.17928-1-semen.protsenko@linaro.org>
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

Doing USB boot on E850-96 is most useful in two cases:

  1. For unbricking the board
  2. During the bootloader development

In both cases a U-Boot binary is being re-flashed to eMMC. The most
convenient way to update U-Boot in eMMC is by using DFU. Implement
entering DFU flashing mode automatically when U-Boot is executed on USB
boot. That makes it easier for users to re-flash U-Boot without even
having serial console running, e.g.:

    $ ./smdk-usbdl
    $ dfu-util -D u-boot.bin -a bootloader

See [1,2] for details.

Entering DFU mode is implemented by setting corresponding environment
variables:

    bootcmd="dfu 0 mmc 0"
    bootdelay=0

Do not save the U-Boot environment though, to avoid falling through to
DFU mode on a regular eMMC boot.

[1] doc/board/samsung/e850-96.rst
[2] https://gitlab.com/LinaroLtd/e850-96/tools/dltool/-/tree/uboot

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - This patch is added in v3

 board/samsung/e850-96/e850-96.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board/samsung/e850-96/e850-96.c b/board/samsung/e850-96/e850-96.c
index 3aa4992a36d5..415505f2561c 100644
--- a/board/samsung/e850-96/e850-96.c
+++ b/board/samsung/e850-96/e850-96.c
@@ -209,6 +209,12 @@ int board_late_init(void)
 	else
 		load_firmware_blk();
 
+	if (bootdev_is_usb()) {
+		env_set("bootcmd", "echo \"Entering DFU mode...\"; "
+			"dfu 0 mmc 0");
+		env_set("bootdelay", "0");
+	}
+
 	return 0;
 }
 
-- 
2.47.3

