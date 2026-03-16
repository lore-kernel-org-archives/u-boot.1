Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8C9F53D6C
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 21:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A5A084222;
	Mon, 16 Mar 2026 22:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rbMkLVhz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D15908421C; Mon, 16 Mar 2026 22:55:49 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A37F28414E
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 22:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-46703fb602fso1773331b6e.0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 14:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773698146; x=1774302946;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0pmKEPHzkhi0tYcTSmxYbo9xpb+VtbGgtQS5dWJ1YQ0=;
 b=rbMkLVhzaCZ9sfnhYacJS76wZ0ZwadaY2X2SCBpn3QNh3VlKsao5aF/GeNI/RBrObj
 FtmyFmgv8Ccp1d6C/0dkqBu35H2nqcvx5XLhGiAu/a9BsHm4U7BZbZz4pZ/fmVYCB8Ak
 zPx6mo+0Tps4D9FLjUyRNlgp5LjLWJsSyutm1Sg6UMnVWTsWB2+g51TLRLuLhdm/Q27P
 xE4rTu24wGqgxG9FWecJAomfmVBQrfnjnnwKAAmP8cI2Svk5sTIn4BNnV+Kc+GOsObdu
 6g3aKywrjQJH+6NrWaiJQT2I0BN7YuKbsjs/qP1dmFd0K17YTOARTqdRT+ZeGOdSKiCI
 U+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773698146; x=1774302946;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0pmKEPHzkhi0tYcTSmxYbo9xpb+VtbGgtQS5dWJ1YQ0=;
 b=JXuX7dRIiZ5T7cA4Omx2z+aScuSd8FSCJTAzXoL9DPgOLZDb7x1gPwTOS/wFbdE6x9
 lljnZ/9WGmdJNG6/3O4ckVtaIONDFJr8kTfftySYu6/QVl8lbo3Wz26SmPmLEG3flapg
 EJAkFj/LrEOtjdy5J4fAKEOUSci7oQd+0tR4zXboFz6banIIFfqkI3Udi4wf+HMDcKay
 ZorI9kUXljvEOlv6+BH/ek5WKpyoCYZFYBJaeFASbYvDo8d6dWTKRAo+r8mrrPtOvvs6
 nImMafxFaS7oR+8q2YaRySWRwiVMmW07/1ymv4F3/QQVLTFiwytx5U7pYgQ+bjMXfkhL
 kTNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+8JizrC+c2VdTkRQQ0umnsxwx8jG9LLTgF2D5P91ej4J1v1tnrl828sX/jD9b0ybxhyg424o=@lists.denx.de
X-Gm-Message-State: AOJu0Yzid4lPA/+BPszeVcNfN1zptDgNByWJFowTMTYvuLadt8d8WxHH
 wB7trkqAwg99TH8C+MeShCbV969FIu6nHHZqbNHjviA2h3UM4Gv7TdGfcbmkwMj68zo=
X-Gm-Gg: ATEYQzzqsdbOsGFl9nyElA4OobyLzbhKG8c0RBtUihPs1KSIV5G+gaGjNDJmthDclMM
 Ka1sFi3W85aQG3zPTaKXSWrk0cSLuSxA0E+9IZx5NmZqJnYmlqHhrYVkda9rPaP6xCOGZlWunXb
 Bq/gtzQ5bBSwARQZdQvy7HjTsYeomKymsXRQEvDKUiQ82Ms+ZEuxIRpDuKYMNgktDXuDBf2zh6I
 s1nB0WcGNwRO3FprDkRBhh1ai9x2SOj2sWoFfEU29wJfakeajJ9HclGZVuf3VquzCnmkh9hPALd
 iu9G671e+dNTmGySnEvO+OitBNeSLqe0A/azEIDBdMg7nIqufFNoVDoL5DuTtSpcrXBgLMgEK2J
 5OUi5fiKpj0fLIjAeW36n8NDRV4LcTlyNK5Qw9Wc+uiaybxW7/Z4kxEwk81qn+8UrwpjTmjTLXE
 qgZgzBjZIF3HQZ8jLP7ccpVYn6qwM=
X-Received: by 2002:a05:6808:6509:b0:44f:ec23:2375 with SMTP id
 5614622812f47-46757050ad7mr7817104b6e.3.1773698146305; 
 Mon, 16 Mar 2026 14:55:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6995:28aa:eeda:102])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41791432d87sm17978547fac.1.2026.03.16.14.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 14:55:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/3] boards: mediatek: add Genio 520/720 SD card support
Date: Mon, 16 Mar 2026 16:55:13 -0500
Message-Id: <20260316-mtk-ext-mmc-boot-v1-0-1aae51a44705@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2O227CMBBEfyXyc7ckjnJpVFX8B+Jh7Sx0S2wHe
 4NAiH+vCTweaWbO3FWiyJTUUNxVpAsnDj5D9VEo+4v+SMBjZqVL3ZZ1pcHJCegq4JwFE4IAYtt
 h1/V1g6PKtTnSga/r5G7/4rSYP7Ly3HknIp2X7JJXTDlKCVfXUHy/VeWqctLXXxWwZ2GcIC3zH
 KLARUMJ1Wj7Vo9N39R6a/A2sYn0aYP7eVoMJoIMjmUoQuQj+43Pz9X+8fgHjE3ZZPcAAAA=
X-Change-ID: 20260312-mtk-ext-mmc-boot-aa67a77835ad
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=pNKcnqKqGCOiARz2ax7ka0YAchMsX/VsRREZJp4ell0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpuHxHnnOKE58oXDfNe7BGXLLZwEUraA9u2Ohlr
 xZcA2nZf6iJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabh8RxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AiiMIAId1NFWEykqT5ERH1v6y+4cl3UAAF/E+w9hkl/I
 /UKWxfshPNhYJLhY+DCzwzJV0zGEMXJpvFvQjp0LYzOeuP51Hru5GE+T6TCjRf37d7G5UeSBe+2
 G5mBVktEhEPMrp0LiCTy4E7QFeIANuCx2y3M4afuYnVPtclZECWEeBBZ7dlJnp1swYJLKAmRCLe
 tfuuiBDWH7Z7YgtIstTwewtufaLavKeVS37XCMBPvubvXCOGc3FVDPiTNZFOI6/yUBbRUNEYqgw
 NbXVaB5jM/p5fRHQTlkYSvKBxPDR5fIdduiUFn3CxoTGl+HwkyWbrVbn+z7w4o64CqOVTixJhAT
 vPxw=
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

Add required devicetree and defconfig changes to get SD card support
working out of the box on Genio 520/720 EVKs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (3):
      arm: dts: mt8371: add SD card nodes
      arm: dts: add U-Boot overrides for Genio 520 and 720 SD card
      configs: mt8189: enable GPIO support

 arch/arm/dts/mt8189.dtsi                      | 12 +++++
 arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi |  3 ++
 arch/arm/dts/mt8371-genio-common-u-boot.dtsi  | 28 +++++++++++
 arch/arm/dts/mt8371-genio-common.dtsi         | 67 +++++++++++++++++++++++++++
 arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi |  3 ++
 board/mediatek/MAINTAINERS                    |  3 ++
 configs/mt8189.config                         |  2 +
 7 files changed, 118 insertions(+)
---
base-commit: a27980786cfb3c430aa1c05da8e79180c584d221
change-id: 20260312-mtk-ext-mmc-boot-aa67a77835ad
prerequisite-message-id: <20260310-mtk-mt8391-initial-support-v2-0-1dc862d58532@baylibre.com>
prerequisite-patch-id: 0a3f0badfacd3b6aac95fd6eecdb52a06f6b2862
prerequisite-patch-id: f5bc405061da27bf21302c1e91d1f7764d4c52c2
prerequisite-patch-id: 127eaeb5c641928088383c6fa468ef0a15d88306
prerequisite-patch-id: 8bc3f4284773a4e83ffc94e9e4aad43956073ab6
prerequisite-patch-id: ee4692f65c9b54d9b599b13bd965581318a3f372
prerequisite-patch-id: 02919217d9a44bc91036b6e8a2c0dc4f54a0fb3c

Best regards,
--  
David Lechner <dlechner@baylibre.com>

