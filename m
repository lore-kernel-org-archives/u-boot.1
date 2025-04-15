Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C601C369B8
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 21:20:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6061C82BBF;
	Tue, 15 Apr 2025 23:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zM8GiUT8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B19A82BF6; Tue, 15 Apr 2025 23:18:39 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 067C381F0D
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 23:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so56106825e9.0
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 14:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744751916; x=1745356716; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O0Zm8Na5fwVuYfu9BObkGOuH/jGZrLK/SEqltjGvPys=;
 b=zM8GiUT8xw+IZC46ZYh89bm8L7JiMNGw5yWSd0fSK8tpzO0qLA5j8mpSjsK9rWh1fQ
 lZnUuADp5Uf9hVXcmmKc0gZC6zdZPQ3XOLinjlmG8DvhkPjPIdbbzACSAHoClCnPk+yr
 MCnbPLNLvq3tW4LM7tTwDb9fvmT/9lO5+CJnrTVV9zxpulZjnZtUDuPkZptdyWxJg1ii
 Rm2xHbC++wDDZhAHwcrOedoXja1wKKMZD/mP0GXCF2FA5dSeSAawx51T1/BIWnJRhQXw
 gGfp/0d3me/Wd9tel014WN9/HzZVm3vZmjjjM8yNW6xjBPNytXXrU9Yuelo7HtwpXFtb
 qaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744751916; x=1745356716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O0Zm8Na5fwVuYfu9BObkGOuH/jGZrLK/SEqltjGvPys=;
 b=XSOmAjfsWTMRRw57m+lfeYsTWETR+ZGBcTo3jwd4tNF04h+saS0G3pQX4ol8ytd4+J
 ImtTRYYXN+L9U30BxUAGExmSJI2tg/F86/gR0vKqHwgTrduqSuFoj2OVUR9wq+6ZAnK2
 h9aH9Fqer6IWONhGpyBEcmNsdzrHJg+YViIEW82zsa+yb5JyTwVKw6fhldIPR3cskVi5
 A/cSWlEscW0Ybw0xr8NnJHHxovZx9ve98lq0PC8cBADaC82kzb0txJCI/4wGO6635G5N
 EYLNVybnKPLZEd85figMV1xEV/KhYtlhmItD6B1sms48ZAd468h1CY9AfBmt9kfVNdFn
 sakA==
X-Gm-Message-State: AOJu0YyuFCjyJbag/dPeTBAq7NLWSv+wIh1SEdIkSAt/GNfj3C59OI8V
 YuGW+OqPSHEMlA04fyqDt7fdo4GTPjwgw0Xjr+smbSLV9Vv8mPVMVnfLprNvgPJSuHOK4OFBEl+
 e7gY=
X-Gm-Gg: ASbGncuwpxyRy9G5P1axr+bokAh4toMufSXVHcT3WrEgTgvBnk4bw2ErL9TNGBmW7NB
 GyB5+NpYhOjyZRDaspdAr60GnX449f+mzfIJbgUIwb3vSh3gdt1mlSgzEmTQf7L+5DGQm04oRyi
 C/OkV+5zxvSf886lldJJrJ+CJ4oHfspF+43jKmwq2XDMQ6tYi6D/R2hcrjhyLggciHe/SsPHUY1
 r3rBHcEYA36TiPNluQ9kxuftnoj1JMcASMejqOgRIy0i8vBSGxWw4IKPzoi4WB9zs6dUxoLzTfo
 GlD9ju1s7tL5vQx3MsMM+ZPG5lJSlRHqIoDTl/kp0Cn7l2UNk/wX9RkJOyo=
X-Google-Smtp-Source: AGHT+IFgMxCi7X/Nmwv8TmlRima8rMwyeShBK2QMSVAYSbH5DrcdQ5H7IGNNBaSS4iLWgaVNrJ7DPg==
X-Received: by 2002:a05:600c:8709:b0:43d:683:8cb2 with SMTP id
 5b1f17b1804b1-4405a015cb2mr6233295e9.14.1744751916112; 
 Tue, 15 Apr 2025 14:18:36 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43cce3sm15530917f8f.74.2025.04.15.14.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 14:18:35 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>, Hanyuan Zhao <hanyuan-z@qq.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Ramon Fried <rfried.dev@gmail.com>, Romain Naour <romain.naour@smile.fr>,
 Tom Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v2 09/11] net: lwip: allow DM_DSA=y when NET_LWIP=y
Date: Tue, 15 Apr 2025 23:17:44 +0200
Message-ID: <20250415211819.1254435-10-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415211819.1254435-1-jerome.forissier@linaro.org>
References: <20250415211819.1254435-1-jerome.forissier@linaro.org>
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

Now that the DSA tests in test/dm/dsa.c are compatible with NET_LWIP,
remove the dependency of DM_DSA on NET.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/net/Kconfig | 1 -
 net/Makefile        | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 933bad9b00b..3d338a81e81 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -48,7 +48,6 @@ config DM_DSA
 	bool "Enable Driver Model for DSA switches"
 	depends on DM_MDIO
 	depends on PHY_FIXED
-	depends on !NET_LWIP
 	help
 	  Enable driver model for DSA switches
 
diff --git a/net/Makefile b/net/Makefile
index 41edbacabc9..d63f62b7c8a 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_NET)      += arp.o
 obj-$(CONFIG_CMD_BOOTP) += bootp.o
 obj-$(CONFIG_CMD_CDP)  += cdp.o
 obj-$(CONFIG_CMD_DNS)  += dns.o
-obj-$(CONFIG_DM_DSA)   += dsa-uclass.o
 obj-$(CONFIG_CMD_LINK_LOCAL) += link_local.o
 obj-$(CONFIG_IPV6)     += ndisc.o
 obj-$(CONFIG_$(PHASE_)DM_ETH) += net.o
@@ -39,6 +38,7 @@ CFLAGS_eth_common.o += -Wno-format-extra-args
 endif
 
 ifeq ($(filter y,$(CONFIG_NET) $(CONFIG_NET_LWIP)),y)
+obj-$(CONFIG_DM_DSA)   += dsa-uclass.o
 obj-$(CONFIG_$(PHASE_)DM_ETH) += eth-uclass.o
 obj-$(CONFIG_$(PHASE_)BOOTDEV_ETH) += eth_bootdev.o
 obj-$(CONFIG_DM_MDIO)  += mdio-uclass.o
-- 
2.43.0

