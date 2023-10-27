Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE03CC25B67
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 08:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDBB687C1D;
	Fri, 27 Oct 2023 10:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T7nqHFk8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28FB287C15; Fri, 27 Oct 2023 10:26:32 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4301087C0E
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 10:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50797cf5b69so2525510e87.2
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 01:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698395189; x=1698999989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3wAw5LDOglxf9VQBepswseXzI3AUpshqMI4S0gYa5Y=;
 b=T7nqHFk8mDmshdm5sfEQ0ZKg6r+dYXSoXm1QTdIb2hxQKmB+5CGyhTQYS/P+8qw3T3
 p8mSOECpPYSfN3JfeHarvsKvZlrK0er0xTdYo/tqmE0mlv2gSpx/RJBh83ro4wfPoBTP
 5OD9xwOLz9dpOTrHXKdLCd1D+twGGwMYsUiFFmNgH0VbiS25ddlRsw1V6BYmxUhz1ovQ
 idpNuZwWxMnQRAnZSuaT+YXypw8BVcgLkMGqakR49pfsYu1ibHoEMlcHV0JQXeAG7O3P
 aTNDAJIJeTOvJMGOxFe4uzvRLAdqeukETe6s8iQXT6gMjdRUXb9QqOcagpTVmSWkt21B
 oilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698395189; x=1698999989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B3wAw5LDOglxf9VQBepswseXzI3AUpshqMI4S0gYa5Y=;
 b=B35GPUdTVBKNsL+CMK9yrTvC79+Br6zTbSCg7KuxZgzMdBa4Fy3ij+S8TT0mjNCC1l
 dD6iCFpunZo5zM/0jE7//9QyR+ehk8rq7vghVBaiSnEbgY3KNhLe4fBKlJUESTKw4c9G
 6EFeg67BA7EVc0u5lh0SZErSlG2Wa/ZecFxg++k+7A2zUxDScjBMmK2M8DZx+pSl9mVq
 WT8hLZC5cTzVTOKRm+JtVP2MP52E2MbFdplv2BNZ69NS+K3Tw1wRDzdzTnMTgKFQxfgx
 Ezj7Ii2GFYmUGxvGPvUWDrl+VlPd7MhqNMBuLMEJZKwZ278lRfoBz27NZu8jmfCCRHax
 CGyQ==
X-Gm-Message-State: AOJu0Yw/ioM6EPpsPV+fN7/CNtBKESNT7Or5uuC+a5JQLutIWltJi9ad
 C7h6kBh8tOdr7HtN05dlYAQ=
X-Google-Smtp-Source: AGHT+IElLMt99M9z/u3oTFr/C7ic4ZPA563EOexbwcDgbauTiMe+je9VfwsA6Q9rHfLJNunXfcUPLA==
X-Received: by 2002:ac2:5226:0:b0:507:9a00:c169 with SMTP id
 i6-20020ac25226000000b005079a00c169mr1222955lfl.5.1698395189161; 
 Fri, 27 Oct 2023 01:26:29 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 u15-20020ac248af000000b004fdd6b72bfdsm183445lfg.117.2023.10.27.01.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 01:26:28 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v9 1/8] power: pmic: palmas: support TI TPS65913 PMIC
Date: Fri, 27 Oct 2023 11:26:08 +0300
Message-Id: <20231027082615.306943-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231027082615.306943-1-clamor95@gmail.com>
References: <20231027082615.306943-1-clamor95@gmail.com>
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

Existing PALMAS PMIC driver is fully compatible with TI TPS65913
PMIC found in many Tegra 4 devices, like Tegra Note 7 and ASUS
TF701T. TPS65913 shares same structure of regulators like TPS659038
so data can be reused.

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # NVIDIA Tegratab
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/power/pmic/palmas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/pmic/palmas.c b/drivers/power/pmic/palmas.c
index eb83c88d56..b2e8a2930c 100644
--- a/drivers/power/pmic/palmas.c
+++ b/drivers/power/pmic/palmas.c
@@ -88,6 +88,7 @@ static struct dm_pmic_ops palmas_ops = {
 
 static const struct udevice_id palmas_ids[] = {
 	{ .compatible = "ti,tps659038", .data = TPS659038 },
+	{ .compatible = "ti,tps65913" , .data = TPS659038 },
 	{ .compatible = "ti,tps65917" , .data = TPS65917 },
 	{ }
 };
-- 
2.39.2

