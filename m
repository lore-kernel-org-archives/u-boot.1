Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A0CC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CC4F87790;
	Mon, 27 Nov 2023 14:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uLzCDeF1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F5818778B; Mon, 27 Nov 2023 14:01:38 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87B5887784
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50aab0ca90aso5982583e87.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090095; x=1701694895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XssoNv4AmYjbApoxGC5tf3SzLYQGdDcwU9wew6wFVmg=;
 b=uLzCDeF10vJOVbbwU73EllgdSnjEMYOS/nwvZUWAMlgkCP7dxJIEXPSNnA17mRpCDT
 4Z3BGiyoV510OiOmzMBrygQ+uwX/h09LPsnxit9ycH/c2WblDc5WAgjS7/8n2Ew/JxOk
 k4Go2j3b78u5AWWR1ona4Recsupa05ItA7u8qsnwMgQOTucvRmr21UsuSrxU91uuyoSm
 bm3ufsh+89VcpUH+yL1sKGPYLFnV8Acad2W72MwqpY/x0gzRaP7YnqCpC4k8+W2H5Xmv
 KG+kWPocLR2nRLL6kxgm1x0b8MWCMnrcJRv/6xwoyNnXjPGG7iefs3axkr5ynio8+4l2
 WvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090095; x=1701694895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XssoNv4AmYjbApoxGC5tf3SzLYQGdDcwU9wew6wFVmg=;
 b=bXACVY49Ptt8QqDSRHvAYDqpEqe0w8lczir5FIOWAbmM9HwfZThQj3rue4dLhlk/A3
 UED4RJ/XCm2hYMeP5Ndf3L12W32FxchbxCBVpKa0pq5lFTIvlONz0pAYolxgTu8bX0u4
 sEjgBZ/4EIXwH9KwrFsOLbS/7omu6QoSjbRW2QXuFwaHeBM2vI9MaFvNN2N3NjdGeXFi
 bLxPykCo8PZ65zxyPAaSXF/6mE4nfHn68sdkArgiiC7pjy0cZKT4Yi2dL3ifmc33pdoA
 tyFPkjPpOlxSDEKAspTVlXTKf2AERsp8jkkxFMPRosD85MPvKo4Y90RedyT5Nw5e1U6c
 dljg==
X-Gm-Message-State: AOJu0YwG4DchrDq4LmmGnLfi+skQJMyPAcPePqlgzq2uREIVcpzcEMQL
 OC3mg5wtHrnb+mgKI+UmtnwxZPmMM0UZL7tm8TXf8Q==
X-Google-Smtp-Source: AGHT+IGyNdL0MoeoPw1VyVfZK0qVyhp1RSPV++RKpo3pT8hE3JQeV9f7gf75DftqdpJESVhhRh/JOQ==
X-Received: by 2002:ac2:4c4b:0:b0:503:38f2:6e1 with SMTP id
 o11-20020ac24c4b000000b0050338f206e1mr10407752lfk.5.1701090094591; 
 Mon, 27 Nov 2023 05:01:34 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:34 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 37/43] configs/rcar3_ulcb_defconfig: increase size
Date: Mon, 27 Nov 2023 18:57:20 +0600
Message-Id: <20231127125726.3735-38-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

Increase allowed binary size to fit lwip code.
u-boot.img exceeds file size limit:
  limit:  0x100000 bytes
  actual: 0x106c41 bytes
  excess: 0x6c41 bytes

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 configs/rcar3_ulcb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/rcar3_ulcb_defconfig b/configs/rcar3_ulcb_defconfig
index acbc3147ce..9c3ecf40c6 100644
--- a/configs/rcar3_ulcb_defconfig
+++ b/configs/rcar3_ulcb_defconfig
@@ -112,3 +112,4 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_STORAGE=y
+CONFIG_BOARD_SIZE_LIMIT=1081344
-- 
2.30.2

