Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B585E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 15:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E860089638;
	Fri,  6 Dec 2024 16:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HZPExr4X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A6D68962F; Fri,  6 Dec 2024 16:41:23 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D82289620
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 16:41:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-53e3778bffdso610256e87.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 07:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733499680; x=1734104480; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bI/tzbrNeU/ZkYjxfkyRG8/9PVPpu0Gmg1Oh695pgNI=;
 b=HZPExr4XDvXIUvVfuzfgY7kVBiRF7ECpApDRPcxzYnit7q3PLFU9nT7y7ER7+Jug8g
 9owOpy2HxjfwGOrccsxsEaRpfli/3inOU3r3eHpH5gBTS4RAOFYDp1FN01XtIr/eXy3n
 p8Dep0vt0tGYEVPr9t/hlNATlyI0R7AgWxUyOyhgJba19QJdZtv/cQB89hPkYxy1vU08
 sJRDgdR7aAbzQjjWVTvmNtwNZ+NLpBO5za3VJQRjY0VhQMbOIPqo3MyKIZrpTdSNyF6x
 J8L4nIBhMfSi92V7N21ss0RrNscssMwH7PLLEojtmZQ43df22SIcRv3J+8J3lRPqQog7
 vQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733499680; x=1734104480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bI/tzbrNeU/ZkYjxfkyRG8/9PVPpu0Gmg1Oh695pgNI=;
 b=cZRtegqr/F6vwiORLBb2e9Yeqvm+gKgUD8mPTIX0Mma6pSjpmW4JgqLTiWUjRxYnMZ
 Aa8VqIZhkQpVj58YkhTmF41Ca1HTQugErzxJ8ThOnuHknDri7GqEzqkHM1g0wisvHadK
 PtD4Dc2nqkASI6qDBlmf/ziO6f0w0ZCY9a/SY05l+bxELkku1GWcGNcfTSjgTwtJOwy/
 CFXrmSioU//7/uUMU7rJJbwC8Ti3dJ3I6cm05m3fs8Wi5nmMR063n/dko/Dv79F3WieP
 WJ3HqGMxkG7+nJ8Cw13sqF4vKfcMY4pi+Y5/czDJiB39jaQ4rgKIVfJUVo4X1qWFvtZC
 B5Zw==
X-Gm-Message-State: AOJu0YyzJUCuL4/S9cgHtJn9jHXir+Slew6mXl7qq/NEh3EVIOgPcUnU
 RZNxMcU9Zh29o53bdizCj2Lc7D51SJSO6VmKNc9LhNXnyyALwBBW
X-Gm-Gg: ASbGnctvi1i//R/b9QirSI0/V7LYagtbfbtBgaHM8vETOBco98qjN6JLB+6DClUU5aO
 edUzK4t5BAplUETBFAiPXFJ0+IechKBZwjKwJvYRMwgmkOZkuFacNZBFvIV0GX4PuYgJf9A93pu
 mUDOCmFl9S53QzI+1W0QWA8v5KGTJq+NmRdvHf0oXHiHsoOm6HQHXv5b7nFsgyH80ztRqpYLCGV
 DHxfeyaHi5Om+xglzJE+akPMYANiJSQNYjEpHXo
X-Google-Smtp-Source: AGHT+IFjK1QRhFer0A43MmGj7JaMG0oznzt5a7dvoObzKLWCMWJN9g2cR71TQYk6rsIqDiJhqQAA7w==
X-Received: by 2002:a05:6512:3196:b0:539:8fcd:510 with SMTP id
 2adb3069b0e04-53e2c2b6578mr1132094e87.20.1733499680169; 
 Fri, 06 Dec 2024 07:41:20 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53e34a49561sm154154e87.83.2024.12.06.07.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 07:41:19 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 Michal Simek <michal.simek@amd.com>, Sumit Garg <sumit.garg@linaro.org>,
 Ye Li <ye.li@nxp.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Jim Liu <jim.t90615@gmail.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/2] gpio: fix request of PMIC GPIO child
Date: Fri,  6 Dec 2024 17:40:50 +0200
Message-ID: <20241206154050.48353-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206154050.48353-1-clamor95@gmail.com>
References: <20241206154050.48353-1-clamor95@gmail.com>
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

If correct PMIC child was found it should be requested as well.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpio/gpio-uclass.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index e776906fe73..e6c00c48722 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -1160,6 +1160,14 @@ static int gpio_request_tail(int ret, const char *nodename,
 			/* if loop exits without GPIO device return error */
 			if (device_get_uclass_id(desc->dev) != UCLASS_GPIO)
 				goto err;
+
+			ret = uclass_get_device_by_name(UCLASS_GPIO, desc->dev->name,
+							&desc->dev);
+			if (ret) {
+				log_debug("%s: getting GPIO device failed %d\n",
+					  __func__, ret);
+				goto err;
+			}
 #else
 			debug("%s: uclass_get_device_by_ofnode failed\n",
 			      __func__);
-- 
2.43.0

