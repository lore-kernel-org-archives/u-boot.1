Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4259C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 12:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56168875A1;
	Thu, 26 Oct 2023 14:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UrmnhO7B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADCDF87581; Thu, 26 Oct 2023 14:16:46 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 856E38760A
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 14:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6bcef66f9caso138604b3a.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 05:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698322603; x=1698927403; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AZklbldjQj8IaYm6tMad6eExXVPEh6Gns8iU3CbI+Gk=;
 b=UrmnhO7B7D9TDrtIE/GSgcdfl9zR7jJODISLOozO5Eld2TVq3RUafqwtHD5F2QWmUD
 5EypKOnjbXQwhqoKe7AB6xgHRZlQ+XywW2EKgeSXswMoDWlYeOPG902fjygwqWkcJeA4
 smFQVWM0F9ny08Btr17w3dM/8gY6EwK2txT0MNXbjkXeoDmWRkEnWH6r11l3fA4N6CaI
 1JI9HYfyNQhCJNqPBahVRm/cP8m+6OMW6c3AtEC8EGbMgn5ME7TvcTl1XCwxxpQlGG8T
 r5PvXqbq5AUrjIhSrjLNNhifwBPnoC7RGzyvh5EMhEpdBJpCR28svIPRC6a0DQrXcWTL
 dF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698322603; x=1698927403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AZklbldjQj8IaYm6tMad6eExXVPEh6Gns8iU3CbI+Gk=;
 b=NdAKs4Kn8rtzJ2GcoNdXV2A2Y4qLDJblFJjfpdAzxDu1K2ZizchafumOcpvWPXBYx/
 qxlmZ0mtsJFC709nrSP5cbv6q6voOLUkhsWkxg9td29cLq4AyK3eaVUgW26dfrK+ZNnc
 6xuOgqjA44YDCBvxF3qWXNSS0QJOB1OttxAsI3qGV9SC0y4ZGINFjmNvOHA4KJ5TTRVn
 IZpvZqn+GK8r8MZvpPV7BrofZHSoQqiX2FH7/ntqh+uqD9D2fBnDmaYdJjC1ZsWXd3nn
 cvclGRp6oyoW6saNxr0y5h3I19Jlfyfk8Mp2xpt59660FUNsUrZkeLlYRbgwrWhXQKxW
 JWQg==
X-Gm-Message-State: AOJu0YxAzTiwALEaUCnABuyyKkvrARbqVx5Vw3rdYe+4kXSCMcox+KnU
 dSexXIfbsVB3Ah2fFf/YNqC1MLv82Mc=
X-Google-Smtp-Source: AGHT+IH8kz/FCjSD8vs4tPpHH8wUhfuZOI9STWa2MD6vaV5z3kciiRcckfUb+9TdX1Psj/XhekoHzA==
X-Received: by 2002:a05:6a20:8f05:b0:163:57ba:2ad4 with SMTP id
 b5-20020a056a208f0500b0016357ba2ad4mr21988217pzk.2.1698322602757; 
 Thu, 26 Oct 2023 05:16:42 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:4887:380:b001:41f4])
 by smtp.gmail.com with ESMTPSA id
 i3-20020aa787c3000000b006be047268d5sm11410739pfo.174.2023.10.26.05.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 05:16:42 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH] imx8mp_evk: Select CONFIG_NET_RANDOM_ETHADDR
Date: Thu, 26 Oct 2023 09:16:36 -0300
Message-Id: <20231026121636.3227582-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

On an early revision of the imx8mp-evk that I have access to,
the MAC addresses fuses are not programmed, causing failure to bring
the Ethernet interfaces.

Fix this problema by selecting CONFIG_NET_RANDOM_ETHADDR so that
random MAC addresses are assigned and the Ethernet ports become
functional out of the box.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 configs/imx8mp_evk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index d538b85c1f8c..08998a63e756 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -74,6 +74,7 @@ CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_IMX8MP=y
-- 
2.34.1

