Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460D9C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 22:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 624BE876FB;
	Thu,  9 Nov 2023 23:34:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="X4HMwkgy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 994D987703; Thu,  9 Nov 2023 23:34:45 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A696C87707
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 23:34:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-507bd64814fso1924245e87.1
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 14:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1699569280; x=1700174080; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lP99R7Re4+eyph4+QxsshskSoc/t3S+jM/AIZRcPfHU=;
 b=X4HMwkgyRgZPYvSnobQMzUgbxwm6w8s/tReDlCJQdAcTK1hq0S11D1uEajJcpXoGf+
 Es099DFIT1B++IJ59gCiCaIUlPNlPZSE3ZilmNBqVawaUCi+h4FBA0YTq/vM37Z4ViW9
 CR7bKWifTr+BNLHuwBDdZVRL31tgx5Q+6NzIUwce0D9/Q7w5Lv7x4wrxmRSqBnCxggb3
 3oMSbkzHIfdlQavPCgKtghOJk9Ys/9yNWMjKW+KESsqXaLAXp5soXtYKqzLIFElIgL4Q
 o2q2WNdVN4+9HiVL4X5IsxZgrTdbH737RErjtqhB3Ru3ILkRmbKHIBOVh2nglLUH5MBo
 aNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699569280; x=1700174080;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lP99R7Re4+eyph4+QxsshskSoc/t3S+jM/AIZRcPfHU=;
 b=UNRMFfawAjT3xrw4aDLYOt3sjB1hyxDlwt6AcKyW3eNYagHfNMFGI+KfaH8FJNE46Q
 Dq89birfFlRgcxBY1wKO8CU0WveZk15vYSfz9+fWFUI3o2cMzKL7Ld2gilzjw+4wDAE/
 dVhO3GX6/lTFFFG2sbRr2uMB24HBRxD1zLN/k4+MMy10/WktEyWNlHA5r7g3TYq4udDx
 WQmuNDA8wQJ3ZFKiON59/8xS8bZCrcEdJ0B6H5yR6+sq1FRxItddIcNE87fiOIHrM6TR
 IqvsCe4/k+Fpiiqkx2ePndXKjGtjFbuMrp0fxZht/aQ/jxfrqpK8XkeYwIw/uOPb1g5+
 uE/g==
X-Gm-Message-State: AOJu0YzIER0/RC7qmFHWpdfSVCX9F+Sn2pRDBJb3tEEQuv/ol9it+Zz2
 RjLIaUKVR/RgRwtW3vzNKCzXymDjDGquq8r5fiA5PqVJ
X-Google-Smtp-Source: AGHT+IFMU69DUa1UtHy8nU5uGHHMZZHitrsOLPo9s+Z+V5Ns1T+KB3l46r428um4W8n9RZqPBmMuaw==
X-Received: by 2002:ac2:4116:0:b0:503:261d:eab8 with SMTP id
 b22-20020ac24116000000b00503261deab8mr2162428lfi.28.1699569279821; 
 Thu, 09 Nov 2023 14:34:39 -0800 (PST)
Received: from igor-thinkpad.. ([37.30.10.18])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a0565123d8f00b0050944953095sm1182322lfv.43.2023.11.09.14.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 14:34:38 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v1 1/2] poplar: use random mac address
Date: Thu,  9 Nov 2023 23:34:34 +0100
Message-Id: <20231109223435.706053-1-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
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

Set CONFIG_NET_RANDOM_ETHADDR=y, which sets random eth address in
case there is no configuration provided neither in CONFIG_ETHADDR
nor in "ethaddr" env variable.

This fixes the problem:
poplar# dhcp
Error: ethernet@9841000 address not set.

Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
---

 configs/poplar_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/poplar_defconfig b/configs/poplar_defconfig
index f0ab2319a4..b6e0c3166c 100644
--- a/configs/poplar_defconfig
+++ b/configs/poplar_defconfig
@@ -22,6 +22,7 @@ CONFIG_CMD_USB=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x20000000
 CONFIG_FASTBOOT_BUF_SIZE=0x10000000
-- 
2.34.1

