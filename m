Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21664C0755A
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:08:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 214FF8776D;
	Mon, 27 Nov 2023 14:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mIukFIsn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD2B587768; Mon, 27 Nov 2023 14:01:29 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C21F18776D
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50baa2a278bso2510598e87.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090087; x=1701694887; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9UH09jI+7bijLaFnwiMWPF4kBD28fasUUqQYjzL1w8Q=;
 b=mIukFIsn1vh6dgj1QQ/2ez3YFOH9WSpFp/TC9TmP+ptufAlHGYopXcL3EIfmqPJiWV
 Vxr5PJX9CQHn/jCZaaZR5Omp19asKaXvfPmPFRaJG5RWBmcgicWmOQ2N8zFjb5vT0qyt
 j0DDHJL2qzxMzlyQXzEmpf3H9hIcFDGcf4C5T8h0UyCXKWr1XHCUcBX1GnCbbf4acr6R
 KAIDGxKmCquToYL51VDpSTeQgmJioCcc6fn2NHJTHLNJPBqOlXLFb7niB/z2dtAkthvi
 WIXpsfFdt+OUyw2ElR68lpwLw2Hjbo/8xgA7MGTpL6GG7bsMXOcle9NW50YzDoft8SPp
 QfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090087; x=1701694887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9UH09jI+7bijLaFnwiMWPF4kBD28fasUUqQYjzL1w8Q=;
 b=JIQhPTT1CmQmxFZZUp9YwUgvo7sXE1MWeZoDSaha+o4BZGzAr9J5w09+HZoNySgWaZ
 0Lg0vkCNAVWrZbyONcAz2G65D9QGEkuN3g/oyuQ3uitMt9zFeaglMZObGXFS0Mj3izTa
 2ZKhI1653zYF5ib6vNQidSxypCpeyCGyB53Bkr1byU8s03syry7LsSQROtugVVBFnt4D
 mEH33VIuk3hF/xORAqm5KYBQdFi+gWnf16KMfNBLZGQMlWcRFP3QZwaHA9BD6YqNxXKY
 NH++HQwh10iRDAyAdH0LUKlhAcf2oj8Pm7YUi9DYIxYBzPx0yleZKrA5LIPpJ07U7eCr
 /atw==
X-Gm-Message-State: AOJu0YyzSfCmP6IxyvZW6Hs2XLC/p8fRpF79xbbO3jlAb7+wClI4aYPv
 oI/dSRPl1FWMIuxI2bATsc1FbheUbbDVq2ZVwNMcSg==
X-Google-Smtp-Source: AGHT+IHOLEdgEVmDk2wIH1tTrI6P5XHkSn5cZOylMjY8frR7l/n3JXcngJLxKIF6xDgNfSgt+Y1Pqw==
X-Received: by 2002:a05:6512:3b8e:b0:505:79f2:5c6c with SMTP id
 g14-20020a0565123b8e00b0050579f25c6cmr6140064lfv.6.1701090085681; 
 Mon, 27 Nov 2023 05:01:25 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:25 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 33/43] configs/am335x_evm_defconfig: inc SPL size
Date: Mon, 27 Nov 2023 18:57:16 +0600
Message-Id: <20231127125726.3735-34-maxim.uvarov@linaro.org>
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

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 configs/am335x_evm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index f048e60f7f..9fd608bd76 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -124,3 +124,4 @@ CONFIG_WDT=y
 CONFIG_DYNAMIC_CRC_TABLE=y
 CONFIG_RSA=y
 CONFIG_LZO=y
+CONFIG_SPL_MAX_SIZE=0x29000
-- 
2.30.2

