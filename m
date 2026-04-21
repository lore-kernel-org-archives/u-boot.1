Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815B0F8FA78
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 14:24:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B0DB841C8;
	Tue, 21 Apr 2026 16:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="YOkygLOI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DACC183BC8; Tue, 21 Apr 2026 16:24:40 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7B8B83C51
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-479dc6d26e3so847145b6e.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776781477; x=1777386277;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TkeoBT99LPnAjg7i+H4uCoYpBE/CL9PmVWgt4zE3tGQ=;
 b=YOkygLOIkupmVELhe45cFbsuRGZdHLkIkaqrLoKyGU62aLE2JDB5ZvZW1oNJlBpoUz
 wDqvYrSEYo+9tMe9b0xTa2fawlXNwo83SP1fVCd8gAZF0gNYTdjB3Nzi7P0BWE+1qrEy
 g+mIALxOVTcOtQzxBmXKV98iOg31gQLCmzu9tn4hy/POj7tnZdfdCejMu36EZpaqH5t7
 MuDC56/WqsJ67AnZ37VJHKy7dRRp9ULI6/e8gaeLeSkAm+C5MvUSf9YHcPUQleC45F/g
 uwjQ5uuo2vZWSVsMr6KCcFO8AGAE7xUYxh8SZQVZpQ0U0Ml5RBzjEXvN+/Z8Q7RsqzZx
 bAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776781477; x=1777386277;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TkeoBT99LPnAjg7i+H4uCoYpBE/CL9PmVWgt4zE3tGQ=;
 b=eAYt11PiuoXZyU9HrYwd7vCWBe15ZwTUms3CM2WT14Tmo6V5VtsebYUOvNVV50Qavl
 s4TbMuqBFqHDuOGB5ZlrleLIAJh18S6mPqu9rOOLzdbyfVfgRVCEHfsXJpLBRvVOI9Mw
 de0R/EY18DzxYoRYpS/1xoIBvxfFyillux8b/eujN6AVIhnyIMHlmdDphzZVVA4esygF
 x8SMc9Zw42w7smPLs73cntiIuiAeDHIDn/Al9tOsuKsDMkuu/SKEK0hG2O7HAivuCiPg
 U+8Y/Q8HjKMhYzScSmT8n5DVcZvorZJ1wIQHZvqtH4JwbbsCU1ZgWH+kghImD6uqP13g
 6/0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QkQh5MdiWIkZqUTrfHglgcsej+TnSIineSGdtb13gdgwqWNzAZTPCxmQLo9JMqI00jMDrl2g=@lists.denx.de
X-Gm-Message-State: AOJu0YwBDYADm2QV+ZopnlJxmuVaheqO568J4VUFYK6itDIUxHKACarq
 jK/xJLogkHfTaSAAOzyZDu985W5PtDslxTlyiwSnB0SfDaxWcENVBy1ThrNZ/BIlZQc=
X-Gm-Gg: AeBDies2wFp1yShfoPN6XL0vBQ5B+BW1Xr6Ww1pE0pEznYgeXU13vBcVxn3y9Yj9M33
 NtkapqdR7gkBXp84KZD/6M2ty8Cc3VxxuXXnyRQf+g1bdiDlx+U7TgFYPUr74xhQkWX5/G8iLaY
 DbH5f3rB+yHZFYe13fDhATe8cL/g1IpEGCUVWAw0qEkobrNa3uJnFcACvrUX2bKNf3+RMPTWtqN
 JW1u06fhBykRa6S/HCvk/5qnmLFDaus+A+1JqMfkinW3JPNvhsaXk72ldNBd4Gyb7PyO6r6Iqs/
 ypGISHR+1HDAK1kaTQaV6YcHk23ccG2Y+JkHgLTdgICantVXUYblVNTIlfkEc/Qfxn2yoUfnVWf
 ZAyp4HXt5TDssRw1Z8MJt98z6T+UXMjEs7Rdn2mqLzfIThC0E/cPBCHbUD8XwsTrLsixZI1COXk
 AupeOQk4JmddNnY73AGCts8OvZOryizww/iTk54A4=
X-Received: by 2002:a05:6808:309c:b0:479:db65:8db0 with SMTP id
 5614622812f47-479db65944emr3692511b6e.3.1776781477310; 
 Tue, 21 Apr 2026 07:24:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:dc5a:64e5:1cd3:94d5])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4799fead505sm9217965b6e.2.2026.04.21.07.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:24:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 21 Apr 2026 09:24:04 -0500
Subject: [PATCH 1/3] mmc: mtk-sd: enable DMA on mediatek,mt8189-mmc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-mmc-mtk-sd-fixes-v1-1-5b840c546af2@baylibre.com>
References: <20260421-mmc-mtk-sd-fixes-v1-0-5b840c546af2@baylibre.com>
In-Reply-To: <20260421-mmc-mtk-sd-fixes-v1-0-5b840c546af2@baylibre.com>
To: "ht.lin" <ht.lin@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 =?utf-8?q?Weijie_Gao_=28=E9=AB=98=E6=83=9F=E6=9D=B0=29?=
 <Weijie.Gao@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=761; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=GPjwiHzK4fE6IEZ72RMQYWnvGTEDeEyH8Bv0CLx9PVE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp54iQ1NBJfjpfrMGcdBX0nb4G5HsYlkCadT/8K
 wnoqoYfAOOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaeeIkBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AEx0H/1LAzTWxiBLWiE3l5Ngy7ppVjZVLCZLdnCQnYaj
 c6CCFoH/KbrsRv6/2UNGSwaCq1sTFBd4ZLSESe6sg5M4EuwFZxU8levvW+r1GQo/Q3N6uCulHP/
 /orX6J9e4LQHHoE2GX5pwYUv2d8Y+jH5jLoSZXVhto0PdTOOmA0OnFHDz3WncA8cf6qlUXSasV7
 56PO1uR+fnUW5T4vTAXX1ifwyBfNdUdOY/zTDCppVD1YRm+xKsOIQVo58fKK3djRR7rerw4PQqJ
 7uNcg+7QU2+FizG/oSPYUDUCe5iJFVtE458poRHZNnDBhhuIa9NUy6XdAVFEAwR2iG05vxGJDX+
 4JL4=
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

Enable DMA on mediatek,mt8189-mmc compatible. The issue that was
preventing DMA from working correctly was fixed by the
get_effective_memsize() implementation in commit a7c682565b4b ("arm:
mediatek: add support of MT8189 SoC family").

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/mmc/mtk-sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
index 7a4bdee7496..d2472ae7efe 100644
--- a/drivers/mmc/mtk-sd.c
+++ b/drivers/mmc/mtk-sd.c
@@ -1987,6 +1987,7 @@ static const struct msdc_compatible mt8189_compat = {
 	.busy_check = true,
 	.stop_clk_fix = true,
 	.enhance_rx = true,
+	.use_dma_mode = true,
 };
 
 static const struct udevice_id msdc_ids[] = {

-- 
2.43.0

