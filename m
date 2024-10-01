Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE49CEACDF
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 16:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 172D189212;
	Tue,  1 Oct 2024 18:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WoOaDtvl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AE668923B; Tue,  1 Oct 2024 18:03:53 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FE9589212
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 18:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2e09d9f2021so3819191a91.0
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 09:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727798629; x=1728403429; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v91BdpbFDp19sDkbOmY5Qds46Y10EoSStX7WLsph0ZY=;
 b=WoOaDtvlS7n7fml1Uz2bYTLCIyEqHe64HVPyoYMEq55tEge6nOAy2uaF5M9h7Q0+50
 CNtoESXKbvXK1x3P8DixkH9yziL0ghr7zTg2zBHqefox9D2mAekviUOODrgaqDZfYClJ
 enw2p73zNUwKQXJ6CdyhE69/IAfhhTEZ6ctqMZDDM2QMr+Y0Z/biiMdMFLAzwtvGCsXU
 MQQgmgSqSa3yegPtTyhL7zz+cb35nc1o+serpxKW0x/k0E2I2MTHaKOtdAqNWpNeAP0/
 5Tg2/38fiNM6rfjEH0KNBIhulhoUHBAUln2SNTjc1djduAqu1hfFgA54E9xSrXtBaa+7
 MH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727798629; x=1728403429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v91BdpbFDp19sDkbOmY5Qds46Y10EoSStX7WLsph0ZY=;
 b=Pg8KYbLsYNVEh5vWkn7pZNez7aXwbciQ9/LUNm45mA36EWrsdT328HQuLS0S6l4WtA
 DH0IAKDBPINbx6BiGF0xHSaViNAgjpDfb0+inXkXTXz/4PNx+YClUu4X2k4KdeatFgOW
 GpIS/ZebC/emSO0ZnwHSjCpxV58iCN0fkYAkS27pQAvryu6skxNRkmcaPehQfFopyPk3
 JONnk9ksijtBPRlIth2Ighnvv4jrtKfNoufmi5ED0x+EbpBO7HD9jaQKF358e9nv3a/P
 OJcf9ktW8ex1aGeNvwTSkZa70v4kLAd3pX8v9fdUin7Mi1uDEjQb5lpWudQmx70pX84x
 IYYQ==
X-Gm-Message-State: AOJu0YxYMDg15c4s7g+73f1lL/fwdv2sMJuCH5/xdyoimo+MOPRqoJVP
 +0edhIyRVAvWhjkQqJbeCrJRg8AZ+fhE6b6JBHzz4YYIBvwic7/r802ynVrDSeM=
X-Google-Smtp-Source: AGHT+IE7ZeN625h1dlLRybQ21UbIFftzs260+jBN/w7Awc+NY8ME7t1RwWMeacTWtJXJ//yBiUlUPQ==
X-Received: by 2002:a17:90b:4b42:b0:2e0:9fe3:d3b0 with SMTP id
 98e67ed59e1d1-2e1848e2c65mr196909a91.27.1727798628987; 
 Tue, 01 Oct 2024 09:03:48 -0700 (PDT)
Received: from localhost ([111.184.129.17]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e0b6c73ec3sm10442443a91.17.2024.10.01.09.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:03:48 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Subject: [PATCH 1/1] arch: arm: dts: imx8mm-cl-iot-gate.dts: add no-mmc-hs400
 to mmc2
Date: Wed,  2 Oct 2024 00:03:24 +0800
Message-ID: <20241001160324.3894617-2-paulliu@debian.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001160324.3894617-1-paulliu@debian.org>
References: <20241001160324.3894617-1-paulliu@debian.org>
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

From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>

The eMMC device on imx8mm-cl-iot-gate seems not support hs400.
When booting 6.1.0 kernel we got the following error.

    mmc2: mmc_select_hs400es failed, error -110
    mmc2: error -110 whilst initialising MMC card

Add no-mmc-hs400 to mmc2 node solves the problem.

Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP i.MX U-Boot Team <uboot-imx@nxp.com>
---
 arch/arm/dts/imx8mm-cl-iot-gate.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/imx8mm-cl-iot-gate.dts b/arch/arm/dts/imx8mm-cl-iot-gate.dts
index 425701204a..aa6ca070bf 100644
--- a/arch/arm/dts/imx8mm-cl-iot-gate.dts
+++ b/arch/arm/dts/imx8mm-cl-iot-gate.dts
@@ -350,6 +350,7 @@
 	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
 	bus-width = <8>;
 	non-removable;
+	no-mmc-hs400;
 	status = "okay";
 };
 
-- 
2.45.2

