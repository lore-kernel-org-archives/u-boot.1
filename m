Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CAB1091916
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 20:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 984F08407E;
	Thu, 19 Mar 2026 21:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AQ2PMCe8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C740583FE9; Thu, 19 Mar 2026 21:02:18 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BCEB83FED
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:02:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-67c11d3ecc5so705407eaf.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773950532; x=1774555332;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mr+pD5IeYBuKQzQVbA6zcFw+Yjq6cSdCkF+I1fTT7EA=;
 b=AQ2PMCe8N2zPGsKQkVXjAAT0WzT40/VtocPjWE2jOAC3Qq743Fa+ZlXjcSzX4XanVc
 1z9KvoFLKeLMEeq7lpTa9Hi0TQvKk+aK3TMfLOMA80LP9FXNidCQfPzR9plDsSSPsHWb
 asVGNDLfcbSLwYzPTPofwYQ22vifgBIzIIQq8kEQHjM5jChlhweOHMzlb07/qt1R5VbV
 BQxFFXz47pNa6wgPrc7dOggIvHh3BeX4V5/bUsoj+6a9u/kNtV7v1ou7Iz4dJI6yxUsr
 qWC1XklCBsCcVlR18Y1fWmYj9fMT4ZVcsQAt5T4cOYzD7P6aP+YYgD1v2ojd6FwyIJ+3
 f7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773950532; x=1774555332;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mr+pD5IeYBuKQzQVbA6zcFw+Yjq6cSdCkF+I1fTT7EA=;
 b=TKPVqJ9XcXxHc8t0/8J48+STPaJ+fV8xir7y+BvX1yDMCj2frRyMhcL6Qp1PXwBiAz
 55hmO9TJWTwTDae0PadxvNvJBkB7EW2IvhITr0/FUQdFl06VXUOBpZx8rq5WPn5BnyK3
 X+Lui5IHfsciOHD/CKlJi/wVAsEP7peSih7NP7y+YSqg+o8HKlUtVY1Xm7gOErUvIAhH
 q2VJB0/rV1Dov7ww83I594U99nTwnahDVhEK1q3IgGnqmPlguHm6N/JB/VI/zR4mFkwz
 55DkdzA5jcYuCXw0XnyykquWN+n7flp7FQETRhZKTVqcCdX1Qk3JFu9i1141lCnW0vRA
 mTKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5aA/nSl64vuAPxL3LwDzxBR8+SyWpU9dYQLhlMHa3OWbWyQi6dLqYUWStoJDwASPKFEcF3sI=@lists.denx.de
X-Gm-Message-State: AOJu0YyUBfAUD7mZemmES1odpXbj4NnEGIIyea5ndi0eD66SgJ4rdAcH
 dM+f6n2fFEzFyWjHKYjoQHk35JPhXn9E7F27yFFVzY7VTA+kY1zPlhCe2qcSO48ZOoc=
X-Gm-Gg: ATEYQzzT6np7c45qRqaMMpD9b7HcheCVVoIE9oiT585LxBbPNlyqRxUzU2F5v6dy+XW
 bgJtspK6Q8mB9prgqqwKHTWpWjtoiVTlD7Qb9kt9vEQRJhBGN+vXKAsYbDKp7lfWjDgNrmmvXPQ
 osHDAvVGs/SLCSWT/a2RPiaKGftngG2bXLmaoFMVly/h1F8HCWdp73FhNVdgKOJOBFZ9ndZ+udG
 lg4Yeg+EOomprkVAGrxZPrbgUgCeMnPfvHuE7qVT0eXs5m0hP+bJworBex/Be6n2U/DZdzFjYE9
 qHPHKJJrGVATXoqTEf1L2IzajnK+Eme4TGr/x2mzwj0uJAeELtUXj0j6gVEggOz6axDSUctKelN
 ButOw6PjhzOVSuq4SPGLAFN0/LVMJ/HqWwTLsfaibWAICyjo5yRCO5t33Oj2XlLMFLkiEWXy9dF
 o644uQ029A1/XuKykQtEMVr3kjoIxe
X-Received: by 2002:a05:6820:4c12:b0:679:88aa:7531 with SMTP id
 006d021491bc7-67c23005c59mr522100eaf.62.1773950531930; 
 Thu, 19 Mar 2026 13:02:11 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252acd32sm2826eaf.3.2026.03.19.13.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:02:11 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Mar 2026 15:00:07 -0500
Subject: [PATCH 04/17] arm: mediatek: mt8183: remove call to
 fdtdec_setup_memory_banksize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-mtk-init-fix-dram-v1-4-6171ec141f40@baylibre.com>
References: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
In-Reply-To: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=G/tC2FyOMeDUC0+6irU6W7uzVoYvsf2QZL9nbVZliC0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpvFXhF6wPJ/8FCq00ddG/vyN6QabFpJ/TDM4sf
 aWLYuJRBfmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabxV4RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AvgYIAJmFIqOj5nyhwCgf4bjPbceZ/YJpDD3OHh6uoTV
 0XnyeW0RgUNuyUJTcpFGMwrWpk8kgawkvqVgd7CdKM3ua8l0s3viWnjvZHbqJYhkRaNBAHQTy7d
 PLMtE1KNM+z51ld8DCuSBQI4Sv/FNghFUQ82Ca+WnmYSQehsb9+3XNg1cqajC3Pqrf174VEfqrJ
 +Lz+B73+6/iygh7w89zN9cxHmKYWWs1QAJ+fiE6wkG+37UhdrzPjX4ReVef3G/e3lpBAvOjeNxk
 Qck7tMtzjESXKWi3JC3hJjLmvyWEEj1YTYUOnaKT7/k54nfWWvWzCiHkbRACoL1K54ofeqZ4Dwn
 LaiQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Remove an incorrect call to fdtdec_setup_memory_banksize() in
dram_init() for mt8183.

fdtdec_setup_memory_banksize() populates gd->bd->bi_dram[bank].start
and gd->bd->bi_dram[bank].size base on the "memory" node in the device
tree. However, calling it from dram_init() is too early because gd->bd
has not been allocated yet.

gd->bd->bi_dram[0].start and gd->bd->bi_dram[0].size are already
correctly initialized later in dram_init_banksize(), so we do not need
to replace the removed function call with anything else.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8183/init.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8183/init.c b/arch/arm/mach-mediatek/mt8183/init.c
index 5c3c96e126b..8797261368e 100644
--- a/arch/arm/mach-mediatek/mt8183/init.c
+++ b/arch/arm/mach-mediatek/mt8183/init.c
@@ -20,12 +20,6 @@ DECLARE_GLOBAL_DATA_PTR;
 
 int dram_init(void)
 {
-	int ret;
-
-	ret = fdtdec_setup_memory_banksize();
-	if (ret)
-		return ret;
-
 	return fdtdec_setup_mem_size_base();
 }
 

-- 
2.43.0

