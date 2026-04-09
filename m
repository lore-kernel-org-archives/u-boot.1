Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA9DF364B8
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 20:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A08DD83CF5;
	Thu,  9 Apr 2026 22:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="JCsVe4+5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D8F584199; Thu,  9 Apr 2026 22:32:05 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEB0884154
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 22:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4670676ba03so513489b6e.1
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 13:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775766715; x=1776371515;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HqH8m2NM9QB2dWjt55PmpMF6t9NEOjINIpwEnI5H0GU=;
 b=JCsVe4+5FjREsKTOz/9m1W65YvQoBULuFMshaLN3USk73/LFFJT1vKioQ86n7NKuDJ
 nv2vGzV5YeI0AvhmPm6qC73c2tccf4Tyi7cdeyWyEt6cHmrqEbEjvBryA4xwwYC4VsYh
 RDWFOxryy27tB9mFa5Hdw2gaXf9emVqzyNMeUCSmZorcZ3SEo6qvEu7n9lZ3neS4o+nd
 oRgWfCppsS5Ri57Up2C4IEyWJ1CIfb/fCo1gbArLZ58aJ7Q5zj+bm6dg3bnGUwYmcoRz
 A2dFz2O7m/Q5eppFIBZEse+yu7T5Rv6Px8KAMCtl1MvjQoAn6VywNwMFoxMBxjaaJjBl
 K1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775766715; x=1776371515;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HqH8m2NM9QB2dWjt55PmpMF6t9NEOjINIpwEnI5H0GU=;
 b=ZttghFHeOWmxpb2+Ea9XZ4lPm4pACQQdUYuy40zQ0r+BOxA497rzRpS6CTwenXi3Sp
 BruYd5baoihi1vpFYtbX18zANXxRZtOdg38g7F8u2v9WnJK0rWuRgK4oNy3U14c0BK1y
 NkJvF6amMaX+XgtJYDkxMiuu6CPAif+ALXsMEkl1c7rFSooBGMungLydNgtun2g1mOEP
 MSwSfyseYvKBG9dz1Y5spG8q1OwtL5CZ1+Ob9b8Ac7SvOBB1Ev3jFpg8D5rdq8Y90XXJ
 0UOuj2jmVNuQQFkoONamz8YhI65BeGNksdWMiEswC1J7ZIxkhEeD2cvm61G5gVaJeJwz
 0aJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6gwktlrl6/DKaU9P52FSNud223xsd/9HdTVPY9HvVcf0FuByVgv9hQIi2844iHlUwhBdNdyk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2FhZawxn9Y2KoydYu2QL2ievERQcjBnc24j1t+OjnnZf/VEmi
 d+CdkLA3DUok2+xLg9pDd8ST8z/kbXIabVM0CEiNwQQfwQaehjJH4BTvFk5+SHxRxuI=
X-Gm-Gg: AeBDiesPsovsbintclqS96Hs8ghaeFOYwRE5l9EcBGXSjSwIDSutWk+b9JzMnHwosWn
 gyHEG8Bwa65waPztmtiXS0ekTNdMxNV/TEtqk6yR+QDeoR1PdVETidxNShWDule5FyeBaoz2hXe
 p2g2v7s0P4C7Iwa7prImgxruJ1KARcaVB0E93Zszs2CJZIQvUgVd1DFgQxAaWVbKMVacc4JpLAw
 zTtRXERBIoawQ0wrmsP8w3KCrQ+i1vhv9fRLtksLXqTaVIM/YOilwi9aVyf62o30RGpKFjdSYq5
 gMnSptGeOxn0PFcsnxMl9ajv8YGZuRong18vmGtt56feyBfTLO9HzaHGBfooseTX+1M7KW/zlse
 gsDIGor1FD2MWjUWcFdh0MGbxd9qGaAvcsDAiuWyhmeuylr9+I65Lrtw4XfqmVYxmx/2Z5BSPea
 iiIZkWWgeQ5P4u11DSnSraXQXdcKJ4
X-Received: by 2002:a05:6808:191a:b0:460:f435:2aa1 with SMTP id
 5614622812f47-478a0f16b51mr356979b6e.46.1775766715416; 
 Thu, 09 Apr 2026 13:31:55 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a548:cf0c:d054:fd01])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a101b75esm293075b6e.6.2026.04.09.13.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 13:31:55 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 09 Apr 2026 15:30:36 -0500
Subject: [PATCH v2 4/8] power: pmic: mtk-pwrap: drop PWRAP_SLV_CAP_DUALIO
 on mt6359
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mtk-pmic-fixes-v2-4-73e83aa6345b@baylibre.com>
References: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
In-Reply-To: <20260409-mtk-pmic-fixes-v2-0-73e83aa6345b@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=aK9XEyDHUyzM+ulTJ19riprphW9f2KRas9w5FMHVKtM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp2AyRtf8P2DlY7/F5B67JTSK5QdWIVoKNkwr2i
 aDvJcC85zSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadgMkRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AbPIH/1isf3VlnmzhjbmiWRebU1qFzHVm2pYGbm3pWcO
 GQkcYdwqNAeylFKeGKa6sXx7mdIX47ycITFsQ4YpAJtvdiOlHVuc/GQcON6FXigbE+etSjUqKjw
 PkbNPUXyoiRa5ousm9WxYdFw9tuS4aaGs5o5HVy4eqAThP1wVtPIUbgr8sFN1MUzjSOdQMbDqkS
 +/xModz2CrNfckLIxgq7oqWaiznEUnrohSlfrRs3zqCEbPpns3529r/deG0CQe0WmfK3WOMnFBN
 azUWwWWOR4xV+UMMeZ7scHKldtEfIT6Y0mUONR3poByaasucQQ7M1mS/gNoqJcz0wP+N2OE7yNI
 c/8k=
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

Drop the PWRAP_SLV_CAP_DUALIO flag from the mt6359 PMIC definition. The
mt6359p variant of the PMIC does support dual I/O.

Prior to this change, the driver would attempt to write to the
PWRAP_DEW_DIO_EN register, which was not defined, so would write
register 0 (DONE2).

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index 38ae44f0abf..64c483b2f3b 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -647,7 +647,7 @@ static const struct pwrap_slv_type pmic_mt6357 = {
 
 static const struct pwrap_slv_type pmic_mt6359 = {
 	.dew_regs = mt6359_regs,
-	.caps = PWRAP_SLV_CAP_DUALIO,
+	.caps = 0,
 };
 
 static const struct udevice_id mtk_pmic_ids[] = {

-- 
2.43.0

