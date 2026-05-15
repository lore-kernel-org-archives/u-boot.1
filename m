Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAE4CD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4C79846EB;
	Fri, 15 May 2026 20:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J1gpe5Qy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99C638469D; Fri, 15 May 2026 20:10:21 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 677E1846EB
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nathbappai@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2bc763e2ba8so875205ad.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778868618; x=1779473418; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m44Vph+ixgVVKI4unKp60p3tw+IubkkXsfer/7XDtqE=;
 b=J1gpe5QygmWCCpeaUB88tWDxD8lLIi7LqCXiqHmXtf1pQ9tOw/ecZZKYUHls4Wrzp2
 meixj8T8MmvDx2l/zwDVG1BlJptUd8eb1K4FL/ohMu4+jptaKghfEY2pdix+O90iVS0X
 6Pnj94Nf/fcPsGNhBA9zyMxEpnz/NiEglYNMmTb8oIozvclHWrXs3KgdDvMXVleCJk+I
 YpUJQIe1alRogSbckrES5KxGp8ytXW4Lg1z9o7HOK8e7Irca47InyGqtfb1yuKZJolq/
 PEbrRqV6/javHc1SFb1a5uyoc+1bYoqfnZCKlAqnkXNduHczzJ3q+auXXhjiMnE4wEX/
 R35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778868618; x=1779473418;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m44Vph+ixgVVKI4unKp60p3tw+IubkkXsfer/7XDtqE=;
 b=sDR6K8uIdWhNAa5xeMaTOvXITEjkbLE2+u6SlN4dv1aduZDv1XGNsDW4Nyl3vZ/nBc
 jgfdiAmiqnyuOnTWZHzpU4bJY1X1FyNG5sNU8l2dG1Ohuf7vQ4EJSmj1VX5NgHSonNTS
 DGDlD5GQ+TGJM6FTJeWgS1U2E6EY7CLOWBHZtDiL338HCysG4rxAC3c5YUWSedlzmizn
 KPD6jxVF1mxM/M1eqKTu/dRzEryKdynEkD/+GWtjTO1chFJkUNwmQRjAfAJqpglwbZHQ
 gNLH/t4zariHcJ27MYHoN8DSNMDwlhgCMIHdDL5h11492wVtdBbaxuJW3NxgbRlii6GT
 enjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BAVMwcPnDrJlSLieHPBVEp4mM0uwBteBKAzWTr9ODD2SQOzfufjd+RvKOD57jFBBluMEZcto=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1AVtCvuxw0iugNSnXfPYvtaIbR49OayeFRUas8ziZzkPaT63B
 SbxV8BzPDIpJ7PNPgi1bVIILXdByeMOJicnZBvGY31kz4bOmw+J++VGr
X-Gm-Gg: Acq92OEnNB7AQww4iDH9hMsmG/Q8Uq8Tv4+CNDJc7YhcK7x4NbGyEYHmDMfSEA1rNAA
 PPFSdZaIIs0J7BwdM9geR51e0I2CeNaR7y4bVHOitYUDlDMHt1nTkNKuKpB85CA71L+/7jsEWgW
 fW+l95w7DA6PLmvmUS0xQYiKhgpHlASc1VZSQn4lkvubMX6ljars1vohrI1kNFQEuHpYJcDeyxU
 nQ6JJfrNF7EZi2yaBtqRaUt4LlQZIj4C44wp1VltoBDJbqytdfCD9La0nsHI9LREkBabV1q8jGK
 tfolOE25ZH4GzdxK6VtuMx315+KlaFpzOT2K2NNMi3Xu2NNUHCIKqlYl/m+Dby7IDIbA2kAKb24
 E5J1ERRUFcWyn2Ribu/qlUbo2fSCdwwBj79RAku0tfbsjzwTKm1SQ2oJjjUueukvxAp9HjcbpjI
 QZiFQIlj0uPathl8kKehdL1gcSwOXSjav/J+SV3lM=
X-Received: by 2002:a17:903:2b0d:b0:2bc:db02:d1e6 with SMTP id
 d9443c01a7336-2bd7e9e75bamr55844005ad.38.1778868617806; 
 Fri, 15 May 2026 11:10:17 -0700 (PDT)
Received: from [192.168.0.102] ([43.251.88.142])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2bd791e0b11sm42338535ad.18.2026.05.15.11.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 11:10:17 -0700 (PDT)
From: Biswapriyo Nath <nathbappai@gmail.com>
Date: Fri, 15 May 2026 18:10:02 +0000
Subject: [PATCH v2 1/3] phy: qcom: Add SM6115 and SM6125 to QMP UFS PHY driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-ufs-sm61x5-v2-1-0a35d083d2da@gmail.com>
References: <20260515-ufs-sm61x5-v2-0-0a35d083d2da@gmail.com>
In-Reply-To: <20260515-ufs-sm61x5-v2-0-0a35d083d2da@gmail.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Biswapriyo Nath <nathbappai@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778868606; l=1238;
 i=nathbappai@gmail.com; s=20260118; h=from:subject:message-id;
 bh=Sf6L1E7rvpDnlXnBt8K7EaumWWup2kX2gLWIsQCwz9M=;
 b=vsEnIPCKziJFNJ4TB35ArQw87UXes2A/SdH1gdH8cn2YPQt6lQ1ks8/ncThxD6uMxxwxYddCV
 LNTS+rqg7VbB9PbROJFP1jkgLpaHl+Wb39h2L9U2QjhKOzMplbd9p5Y
X-Developer-Key: i=nathbappai@gmail.com; a=ed25519;
 pk=slmb/9yXbet+KTiT3EYLCp0p0MEOYa3EdjUXP+HXfjg=
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

The UFS on SM6125 can reuse SM6115 configuration, just like Linux.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
---
 drivers/phy/qcom/phy-qcom-qmp-ufs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
index 80eba734a633..3df88189a907 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
@@ -1741,6 +1741,8 @@ static const struct udevice_id qmp_ufs_ids[] = {
 	{ .compatible = "qcom,milos-qmp-ufs-phy", .data = (ulong)&milos_ufsphy_cfg, },
 	{ .compatible = "qcom,sa8775p-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg, },
 	{ .compatible = "qcom,sdm845-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
+	{ .compatible = "qcom,sm6115-qmp-ufs-phy", .data = (ulong)&sm6115_ufsphy_cfg, },
+	{ .compatible = "qcom,sm6125-qmp-ufs-phy", .data = (ulong)&sm6115_ufsphy_cfg, },
 	{ .compatible = "qcom,sm6350-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
 	{ .compatible = "qcom,sm7150-qmp-ufs-phy", .data = (ulong)&sm7150_ufsphy_cfg },
 	{ .compatible = "qcom,sm8150-qmp-ufs-phy", .data = (ulong)&sm8150_ufsphy_cfg },

-- 
2.54.0

