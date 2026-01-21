Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83D8C44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA15383AE9;
	Thu, 22 Jan 2026 00:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Yc8zfQsu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77EE583A83; Wed, 21 Jan 2026 23:38:30 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B3FE8341A
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 23:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-45c962424daso123179b6e.2
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 14:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769035107; x=1769639907;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4IXhTPq/Tu5/cvm696RfAMGUfeSzrLJI7lwO3X/PHCA=;
 b=Yc8zfQsub9506dhzbwVkKy/F1bCQDcuEMYw1kdfHsrFFo+bCCwqGtMcAOJH/1W1eiS
 IfQM7KWeojuo1setZEGKaZNGilCc19eJNf9BmVrnqiZDINa2GduKMttgf9cJawishPiQ
 zY2f1yGd4cMmrVifGjEUOC2inonpt36rEVOxCKcaDlNU1Jwyt67u2dUB4DwDov4EV7Ze
 LNArWFqdLXPksk9K+MEe42NeRyhXtrDBytCkPgRYmjqQanxBmX9YnWDFqgyYs/pvUJkh
 smf+JC3I54Rt2ad9rGhTsPSvzgFoHLl6avsohjGmxfIPamVeM8XBMYL9/9Khr1MXWYSK
 ME/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769035107; x=1769639907;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4IXhTPq/Tu5/cvm696RfAMGUfeSzrLJI7lwO3X/PHCA=;
 b=pmMo4ivptzmGJBxrfBIJS8MYjl9TOkl40OpSuMlMUCyv14ba+eaZ78Tw4Rbya/m2JH
 afTOAu73V8ZaP96gOMtM/jJBAM/Ujx8BLCDf7mY6cFD2/9QWasXb9g4ZPCwonsVnDrCV
 4binG7BV4aTP2hInY/Q+A+pBaWxtTslIo53CxTu+x/qyW2SJ0GFCH6ZCPtJMPB8Wcdbm
 uqp0KPBMJasOsIAsPVZQPl+ALKiuYNWuzZ7Mkm1Tr2wnVXiX/noKcoaqhEK4uC76WSez
 lphWRYgoYYYIhIz+0wvpVZuT4NymzKHHAs8Ru4KBnVDbzc7UrKMZZRjOiHWUStojeMfd
 oi2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCURnqVKX6flteE17lpzgBYpnTk9fTPDuDRjw9ZxHwmIzHMpMANS1SVoAfyVM0ImJhRGfDf8ad8=@lists.denx.de
X-Gm-Message-State: AOJu0YzfkbjgL2NqLf/Yv8TwbaRXDSSfuV1yHO84BUQYSsXHM1oJ+xHO
 0KMlTOZAoZepfjoPlSCLCGsOMkFyIgjpNx21DxCwQTgBC+j7VWfr0xOgFynT1AqleRY=
X-Gm-Gg: AZuq6aJX4L0UNLJIRM33mS+HMoo/gFxeynfM2up0tVYK7njdJpaKbkupsCK4PNXIJxK
 zAamw6lCeF9AhGVW+7ei87EvpouqX8JjYFYVMg1R0kfdJzgoWZRwGcQ81goMDMXIlBJ/6eoUu8U
 YBEG5gJ7J4MFfup8WbR6re4PbaaHlPvTgLLjMwqTPK4mzEhiCPAuoM1+mzSIeP9StjnC5AdnCxx
 7EAV3j1IJwdhnxJs7Y0QXwp99Qx8NQ61/5Nt4Qim/Lwbje4/m6GJLFxnfVTiAjd3YlHG/3msY8X
 16fFJ6fBmQmmYo7uG+0i0uKm3VHsy8/LiGtJWaBFsEjdFD8gPf2ekqppwy4pNI3NL6Gb3VVwR86
 ouGJ3orIUdr77FbjzVaqWNa2EA1lUoESCSqHigOJq/lhRe3K26bZBa5VF/8++ieHoSPOLTGt+L0
 v8h7717wkmiVJUsm5iEa0Grng=
X-Received: by 2002:a05:6808:309c:b0:459:b48b:c731 with SMTP id
 5614622812f47-45c9d6b913amr7463616b6e.2.1769035107120; 
 Wed, 21 Jan 2026 14:38:27 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9a8b:7a9:24fa:a0a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044bd150dasm12452458fac.14.2026.01.21.14.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 14:38:25 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 21 Jan 2026 16:36:25 -0600
Subject: [PATCH 2/3] mmc: mtk-sd: fix misaligned brace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-mmc-mtk-dma-support-v1-2-3764b487c087@baylibre.com>
References: <20260121-mmc-mtk-dma-support-v1-0-3764b487c087@baylibre.com>
In-Reply-To: <20260121-mmc-mtk-dma-support-v1-0-3764b487c087@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=489; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=hUYH3BVmqP07ty0lvfifakvwDEg9H3C+PgUr5izpfas=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpcVVR093/RBv1+b2HADhLpiPOvviTajirbzO/e
 1lotzsZjxiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaXFVURYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AVDcH+wR5jJr8gVaW+sft3eEWCid+Gf+Son8j1pevX7z
 BE1+qou/3XdwcCKH1BlMAHGd77y8hDAF1amSsLKzVp5QW1ONNhuDcGfAavoaP6gJpzfTajxHIeS
 JpT/QmeJkf/SkGdvy91lhkes4f2e0Ym7c0A87SiITotaGzts7ipzcNG3KQBnAQFGa5AqPgO3T8S
 PrwrA09Yz0U9cPsCJTwbtdma1/LXXq4/1fanpOdenczaTfzy79qzIb+9tWEhP92OG8NW1Qnh9Tu
 1ZkEEEd2mNx9JIshXbKVRpJbWlhHxkOl+GhPLkn4oxVF/I6A/qzR9sHS+tSg0HYLDotGOe99Poe
 VrAI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 22 Jan 2026 00:20:22 +0100
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

Indent a brace for proper code style.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/mmc/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
index 69f54a342c6..d434363508c 100644
--- a/drivers/mmc/mtk-sd.c
+++ b/drivers/mmc/mtk-sd.c
@@ -657,7 +657,7 @@ static int msdc_pio_read(struct msdc_host *host, u8 *ptr, u32 size)
 
 			break;
 		}
-}
+	}
 
 	return ret;
 }

-- 
2.43.0

