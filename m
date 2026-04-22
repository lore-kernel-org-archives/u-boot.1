Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3040AF9EDE8
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 14:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D838A84324;
	Wed, 22 Apr 2026 16:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VNa3B+eN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 336C4842E6; Wed, 22 Apr 2026 16:32:00 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B06C0842E6
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 16:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-50e5ad864a6so30581041cf.0
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 07:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776868314; x=1777473114; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MnOix4t5SDSjTmsq3YKDD9MvoLlV1GsfOpJKAbgcM2c=;
 b=VNa3B+eNa/al6p4HcGnelExnYfejdc6nH14AnKVdNc3NZzhfXi0bp1L8nwFyx5FwGo
 4SuZ62uMYmBk5ea0L3N/TW1y4z7cBLx+PVyJLsYDutN4zIqf6By96IU6jya41/7+SBaM
 nrsv3nRVeZKxAi+V7m38H/hSu3nVteVQH5EEn1EKsMq8/XX70yI/N1ygAniTbSyzl4MR
 64xxsSfvGjZbsXcxSod090PfGuNa6LFO9hMN2BImBWrbAJSTwhNmwrEQSMhTrOM6ezu6
 cdNcPsfNQ3CXuuT1jhSQlYTRR4z0ZKzHsVX5OPQMD+BU6rs4LGy8EiCRDqLs9CY7UrvZ
 Oi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776868314; x=1777473114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MnOix4t5SDSjTmsq3YKDD9MvoLlV1GsfOpJKAbgcM2c=;
 b=MB0fGwJKtnt+qY/3qvcxmGbenA32G/SAyX4ZCz/pYj+poJzqhNWocD2rEjGMWMFCtu
 zLMoSNssylwIfQNFaaq8Pn43m5G1QOPDWX63MxEDTRpm2vQoL42iDXLDAk4nJcrB7G3U
 o2cq391IiydgIn0luiOCzoacsY9vzGlCPst8n+CBIL4BR1K4j+NanZIBY13L6jCVG+3u
 vyACtbS8ow3JzeQpzsZrRW8UCDgLZ50MjvmhmD2D4tSgJd+jl/0VTbvTb7o7pCUkJRc9
 Tp+0SN7qjPjof2YiQk+FVnG975liv3gpSz2sbZr03vJorTIRNrKO03O54sEqjASrgGNS
 1/8Q==
X-Gm-Message-State: AOJu0YyNAjcY25b5mhv5LjA0H0FXhax6buB1uy5o12jZ3PDaR93SIneZ
 xzfZhCu6ZcuxD9P4SWr4DUcdL8dhYmFj8EGVn99Bk77m8tB9t3/dY0qPe7dNDkpt2Kc=
X-Gm-Gg: AeBDieuaVzakIB3jH2S4q77fdT78N/YDeSVqH+prKMTF/JXQHCU6uHXl+iz4ya7MElL
 im6wrBGpxPsLWJM/NXnQK94QkMyv4/elFtue6t28Q0MiBtC+pK/8sZWsgPlJv3xbDJjT+nasKcP
 3hWVJYwWGAn9+ZBhDpcwLn2bhUgeHwH3zyPwEBzHz4TcqU0IfsPu+kVvFhQiC3m1mX5Ur3pRopS
 k1tE4ogski9nHzaq6jcVRBFgME4EI5t3rVPyvvmJ4mqazcQIviYY6+1+TCYDmQJT8WhTbAIkOnu
 YUKHO16zlyrNBilx3zDZPK/hMKORGSD8bc3K0L9fz8EfgnwGCTPMCzmFs7K77QUuhtvjaLGal0y
 Q82J0yoZSvb4ghfmfvSwduPgR3bgO+J4pBBdRwvXiwbmdq2ucMooTPzdqrqUHebIKBLYG1MEC2T
 LY+pstG7jJ7F0FTPRaqpIWlf6Czf0Lcz7aSHjwHdWyiEOJJSvz8GUhi+Vnd3f0inZHoJQtVJUhE
 LlmjL4NSd0dC4sNdH23GA==
X-Received: by 2002:ac8:5907:0:b0:50f:b732:202a with SMTP id
 d75a77b69052e-50fb732261amr96802141cf.27.1776868314389; 
 Wed, 22 Apr 2026 07:31:54 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e394903dfsm138772501cf.26.2026.04.22.07.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:31:54 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH 09/16] spi: fsl: add support for Spacemit K1 SoC
Date: Wed, 22 Apr 2026 10:31:05 -0400
Message-Id: <20260422143112.1329478-10-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260422143112.1329478-1-raymondmaoca@gmail.com>
References: <20260422143112.1329478-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Make FSL QSPI driver supporting Spacemit K1 SoC.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 drivers/spi/fsl_qspi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/fsl_qspi.c b/drivers/spi/fsl_qspi.c
index 65ab3e306d7..5692510a558 100644
--- a/drivers/spi/fsl_qspi.c
+++ b/drivers/spi/fsl_qspi.c
@@ -267,6 +267,14 @@ static const struct fsl_qspi_devtype_data ls2080a_data = {
 	.little_endian = true,
 };
 
+static const struct fsl_qspi_devtype_data spacemit_k1_data = {
+	.rxfifo = SZ_128,
+	.txfifo = SZ_256,
+	.ahb_buf_size = SZ_128,
+	.quirks = QUADSPI_QUIRK_TKT253890,
+	.little_endian = true,
+};
+
 struct fsl_qspi {
 	struct udevice *dev;
 	void __iomem *iobase;
@@ -870,6 +878,7 @@ static const struct udevice_id fsl_qspi_ids[] = {
 	{ .compatible = "fsl,ls1021a-qspi", .data = (ulong)&ls1021a_data, },
 	{ .compatible = "fsl,ls1088a-qspi", .data = (ulong)&ls2080a_data, },
 	{ .compatible = "fsl,ls2080a-qspi", .data = (ulong)&ls2080a_data, },
+	{ .compatible = "spacemit,k1-qspi", .data = (ulong)&spacemit_k1_data, },
 	{ }
 };
 
-- 
2.25.1

