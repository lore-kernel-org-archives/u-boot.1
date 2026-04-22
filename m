Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441E5F9EDDB
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 14:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F05D843E4;
	Wed, 22 Apr 2026 16:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aBwui5rE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75DDE84368; Wed, 22 Apr 2026 16:32:15 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7809984372
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 16:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-50d6ab4476eso54497901cf.2
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 07:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776868329; x=1777473129; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2W2VmNbJ523zXunxGjidDwxZqBDpi+fzLc3etzSO/OE=;
 b=aBwui5rEHYTeJjEM918xJ+HKGrRD7oVVCZmc17td3EyLp/5yY84dpequbfsqngFaia
 Q0CGA74aKOx5KcKSIIAJ42lyW44wbDXhZ2/ZhyxefWLw5QgFuA8oJUDwrPFpwxFTE2nU
 ddganRTKLl7PO69EdpZRR5nNzLukIAq8kGhBZfdKK8O6F/pT9YW3a8tiZOnX7nqfwqik
 sy5jFtSLLa32ktYuAlXcowIoousSfAA7bdFr00JEftgWJNqFxuEK+sNUvGR+vR4siymN
 yYzxiXqoflYtKARosfSXBIZDrOAcpAMzLnUjoi2kKYdo4cT2PtL0S+kjXv5qUoTEBKIK
 6RPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776868329; x=1777473129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2W2VmNbJ523zXunxGjidDwxZqBDpi+fzLc3etzSO/OE=;
 b=QeOg9+6VQTMROqI2QGxCVHWKOdY7DcrGcWN/S21/LO9QolbhnDfA8gJAEo6zzWqd6b
 x8buxLPp2cJo0cFlIpNtUxUfrG6jlssa+lMdgzemAfLIqAyVg16FrGZcQy6QD+JEqvqt
 2c3WHAy7MamI9S4GWGHbXibd1DSzshplsjEt2BLGhplA922m0Kn9dM5ZTybQb8ME9ITl
 2fINySUPPiNrOVfi0lXpALmhtZBupG2QwwRbIgsoDVk0ByA+Jd11ZCyeuxiM0zsNfb3e
 kVpKc4taooNFhW3rIkHzxk1dUw3JNgbMwDLbqHoxSyXFWoA/IYSlkJlIShZcU009XSpO
 ox0Q==
X-Gm-Message-State: AOJu0Yx/5o6MuXsLoHm9S284iviKrX/QxqbKLoGZlOv83psYYfP3VTpC
 3eECk8p3QSaHsAq6zB6xLCzAmVV3CINuoFoq8DnOloU8306+9l2xoh7f2x6gS/saQQ4=
X-Gm-Gg: AeBDietzw5M+hPrbNcu4h44qBQ6AJFfNWIp/w9exSARW4bo55FyvcoExYCAUutEDeoP
 a3rwqDkuiJubW5rs4hxIjVjUntgq9wVwgKyXimJmkbeP1a5PrS73R4oV1QUMvbUjxlFEsmUn6UV
 3mFddvFEMtTUefnYA51+hOZBtwcccz2yvJwxP9x9f8zbw65K3Iq6ni6WqK5a9lcrvsf1Hc+RTtn
 8TH8peljn3CdeMY6nPC3HkjzEHKQY7sWWciG80S/fWP2jAeNS+Fao/kdy+Q96g9261QTP+KvowH
 DPng9bjRpK103X+VVmjLPzEVPO7mfsqFMMvDryB/zsUtS4KTHEdhofktyaHrBWPX6gO703jpxQ6
 XI7hLTBvWImA3V48AqIRv8Z4hkQywH7mAWUk3U+pf/EniJya5ouDiGzPNWdq4gfg/knnZl+y6ve
 rTcAq5Ye3xjPbBMhzwSv6adt4zN1iYH5eZuud4Jmfjy/7sqHBnN4sH/6Wiope8edX9x5dA3Q1oQ
 eGCUS4HBHoj4BcARxzjpA==
X-Received: by 2002:ac8:578c:0:b0:50f:be8b:f803 with SMTP id
 d75a77b69052e-50fbe8bfb47mr56072851cf.29.1776868328958; 
 Wed, 22 Apr 2026 07:32:08 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e394903dfsm138772501cf.26.2026.04.22.07.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:32:08 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH 15/16] spacemit: k1: Add support for mmc regulator
 initialization
Date: Wed, 22 Apr 2026 10:31:11 -0400
Message-Id: <20260422143112.1329478-16-raymondmaoca@gmail.com>
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

Initialize the 1.8V supply for the MMC I/O domain to ensure proper
voltage configuration for MMC interfaces. This is required for
reliable operation of the MMC controller.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 board/spacemit/k1/spl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 9b30bc9ea7e..2556dfe047a 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -196,6 +196,9 @@ static void set_vdd_mmc(void)
 	ret = regulator_get_by_platname("vdd_1v8_mmc", &dev);
 	if (ret)
 		panic("Fail to detect vdd_1v8_mmc (%d)\n", ret);
+	ret = regulator_set_value(dev, 1800000);
+	if (ret)
+		log_warning("Fail to set vdd_1v8_mmc as 1800000 (%d)\n", ret);
 	ret = regulator_set_enable(dev, true);
 	if (ret)
 		log_warning("Fail to enable vdd_1v8_mmc (%d)\n", ret);
-- 
2.25.1

