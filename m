Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DF1C83F0F
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 10:35:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A4F883018;
	Tue,  8 Jul 2025 12:35:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fxoj8xYz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9AD583285; Tue,  8 Jul 2025 12:35:48 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6B8283018
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 12:35:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-60c93c23b08so8162569a12.3
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 03:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1751970946; x=1752575746;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3CU/+drHFp8PcC5IG9+Bm0H+xiYldM9zyN+F3h9CV1E=;
 b=fxoj8xYztCIi5odUwxaKHZ3spQJXl+F+OTXfx3b10emeXjXd8kIfAi29kcHU89T+ZL
 /d1oOxe7wNjAJ03f52dkRpjF+EK1lhoOV/VY945SlP+beH8QC2MiU6Uam57zNy/0MsjY
 FGB0PQ7qbb+Uf4TC4LGmSDatPm2dHGandSkWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751970946; x=1752575746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3CU/+drHFp8PcC5IG9+Bm0H+xiYldM9zyN+F3h9CV1E=;
 b=N8y6j5nLY9if+XtkPZDp+bf+W3MHiuMzS8ZU2iwaCFrnsSqhCa0tQL1cvdJb7BYcYv
 0ts5eElIEjPzGcGuLg/1FJLJbhHtTlE51TuMP9NLtCUjKA5PlQ5buEYvnJxWgDbOR30H
 9dLTL16/L4mBVEDCAtYhKubNZM5V5H1YkWNEiK4GDsSxGJGIeqcHu5CFznKrs0cNJ6s5
 ZWWKl65RHLM7PJBLzTGKIoWjF1NrSjWngYu64DUzVmBIVoHT47SWASDdd9uC2bQ6VwH7
 P+Z9Qbe9ET0nVJziaAX1k+2nq76hzM+rNmMr7pR07QnPQ/LSxJD72vMU2F3WW9+SfY1Z
 IkMw==
X-Gm-Message-State: AOJu0YxnKpFwcmtl/gQt896mNvSK/o7Mq7gNeufsEAjibj5z45cMa1Bw
 YLOYKjUe58f/mWC8zKamu8u0/UxCzAcqvSY0TqtZs/4/iDyMHeMTjBZOKGASNq5mpdwygx72bL8
 hshugM4I=
X-Gm-Gg: ASbGncvb6UWyKvQZM22mUcWNmwTghstceHg7e9Ow/JYI/eezVH1OKMk9G7gsJQDZ1J5
 ACLDfvc32DATqA5WRByIXBCOWjJGdJZDV+vQvjGUZGZb6bGyP/cUUW+D/40sajJa2XXS9jmJawK
 F2+MLs+YS8+ZkVAv9/1+oTrfAfBBKuiTUlAP8c+HeSbfbKVDfMgx9fvU8Fq779htdPvpf8YdMLw
 zCHbBDeOUUhvXfEuA0627LpNG2DBjdniupbDHRddktuPfBqCTkibxzeUpc0QPTrxGB5aQVsfTf7
 hcfUiL3arQmgdB1ngxQiKGm8j7DaKKyE94LQWut0+gQNdo9wbpJlC15cdqB17Bbn/jep0eIJvZt
 I43AxES72SlwsO6h3Upg9bMcF1XywI2ITEtsPS17bI428afzocXta55w0Sr7+iYUOK912AzcWTQ
 ==
X-Google-Smtp-Source: AGHT+IEiPXyFkpQefo1gjMvy24v3yuRPBL2FS88DRSvZH6xUoIWUqukXuv2yBc3RLT3sc73JOk3meQ==
X-Received: by 2002:a50:ab19:0:b0:60e:f46:326d with SMTP id
 4fb4d7f45d1cf-60fd35d678bmr10328856a12.33.1751970945582; 
 Tue, 08 Jul 2025 03:35:45 -0700 (PDT)
Received: from panicking.amarulasolutions.com
 (mob-176-246-194-172.net.vodafone.it. [176.246.194.172])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60ff11c3e83sm5373473a12.66.2025.07.08.03.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 03:35:44 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] configs: imx6ulz_smm_m2b: Add board watchdog reset
 configuration
Date: Tue,  8 Jul 2025 12:35:29 +0200
Message-ID: <20250708103537.27632-2-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708103537.27632-1-michael@amarulasolutions.com>
References: <20250708103537.27632-1-michael@amarulasolutions.com>
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

Add the configuration that allow to reset the board from reset
cmd

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---

 configs/imx6ulz_smm_m2b_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/imx6ulz_smm_m2b_defconfig b/configs/imx6ulz_smm_m2b_defconfig
index 3d7530431fd..36f5922ea10 100644
--- a/configs/imx6ulz_smm_m2b_defconfig
+++ b/configs/imx6ulz_smm_m2b_defconfig
@@ -67,6 +67,8 @@ CONFIG_DM_PMIC=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_MXC_UART=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_IMX_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
@@ -78,3 +80,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_SDP_LOADADDR=0x877fffc0
 CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_IMX_WATCHDOG=y
-- 
2.43.0

base-commit: b379335f141e3ddca0cdbb5d9d39af0444530542
