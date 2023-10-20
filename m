Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3549C001DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 00:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A5CA870AB;
	Fri, 20 Oct 2023 02:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kpb52XF0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E137870AB; Fri, 20 Oct 2023 02:47:50 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C0A687051
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 02:47:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ca79b731f1so574545ad.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697762866; x=1698367666; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6SHwqfXjDiQuzXx/rCOdTYc43GKoa4jr7d+xG8WhA4k=;
 b=kpb52XF01TgR9vDF96QcNGmr9idig64NNRaZ/YgRvVRM530VaHDv8dBYmaZJT9vKYY
 aC2x5jxStQse3mE6t3s+FokkfRcKbM7pRtjnK2WWJHQ/hQp+y4F2CaV++csCquFV9or9
 3uWxKyxSSdIpj7Du1bkbXUqh2kd9wyjCc82u5r6ArHofytWU+wPAR/yk5cEu5iQfPFZ2
 EYT9cjVWUOSbdF0HPyFBK3M9luxsuy/NZx6TNfuAz9p0YkT03bK4xHDee9649RFN2w9I
 IdLrG4yLWVLCelmgl3hDHi0Tn2uJildQsnshqW/xgnlXfEUG1T4s+QThtMR1WxfLTyak
 v1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697762866; x=1698367666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6SHwqfXjDiQuzXx/rCOdTYc43GKoa4jr7d+xG8WhA4k=;
 b=TTBgw442pAluV4bOjTh+1gPWEX9yEqZ7XM0SiYm6X6W69jfj6UkecJl6zmrsySv9qs
 9idT34AkQZuvgfDHtbs+dMa+5WqZMO6mR+Jx07punK82EzI1lQZEovUaJeuGZAbl2djl
 hs5EwwXuNUKrGFzufESJqyUtOJJ6pryeDVY6dUUubXAEhgwVDyE6mW9FVDYjB7+MQTtO
 aKMvNE6yYaoe+QhNLVUv7BlI9R5xPUQLoDGC0ImmKabGuaH+9NJTKOBejN63t+TAoRPJ
 kPGotbQF9QVeT05NYwCEOzF47srLTJ/lKqR0QIt7oqjKv3iisRqGf7bhBRpJQsR3Nv9A
 /gQQ==
X-Gm-Message-State: AOJu0YyGjfgJ7Mxq2LbZ5nsjvewC8G8a2KlZvMMNAHl03VXM9HiSlbul
 vCNDoov6bDAup56xA2jrRY1ey6+NMyk=
X-Google-Smtp-Source: AGHT+IGFkTyYCUBfIAu7vi5gz02s6BAP0NieYRl0CtWp590+pZEnmnIbENkdWycbqmxU3565lnXdzw==
X-Received: by 2002:a17:902:e291:b0:1ca:273d:232 with SMTP id
 o17-20020a170902e29100b001ca273d0232mr528153plc.0.1697762865597; 
 Thu, 19 Oct 2023 17:47:45 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:854e:96c:819c:d26a])
 by smtp.gmail.com with ESMTPSA id
 ix5-20020a170902f80500b001bb750189desm307540plb.255.2023.10.19.17.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 17:47:45 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: marex@denx.de, peng.fan@nxp.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH] clock_imx8mm: Add a stub for imx8mp_fec_interface_init()
Date: Thu, 19 Oct 2023 21:47:35 -0300
Message-Id: <20231020004735.1913081-1-festevam@gmail.com>
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

When CONFIG_DWC_ETH_QOS_IMX=y and CONFIG_FEC_MXC is not selected, the
following warning is seen: 

arch/arm/mach-imx/imx8m/clock_imx8mm.c: In function 'board_interface_eth_init':
arch/arm/mach-imx/imx8m/clock_imx8mm.c:914:24: warning: implicit declaration of function 'imx8mp_fec_interface_init; did you mean 'imx8mp_eqos_interface_init'? [-Wimplicit-function-declaration]

Fix it by adding a stub for imx8mp_fec_interface_init() to handle this
case.

This follows the same approach done on imx8mp_eqos_interface_init().

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/mach-imx/imx8m/clock_imx8mm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-imx/imx8m/clock_imx8mm.c b/arch/arm/mach-imx/imx8m/clock_imx8mm.c
index 986870799d36..5cf97a5ea952 100644
--- a/arch/arm/mach-imx/imx8m/clock_imx8mm.c
+++ b/arch/arm/mach-imx/imx8m/clock_imx8mm.c
@@ -904,6 +904,13 @@ static int imx8mp_fec_interface_init(struct udevice *dev,
 
 	return 0;
 }
+#else
+static int imx8mp_fec_interface_init(struct udevice *dev,
+				     phy_interface_t interface_type,
+				     bool mx8mp)
+{
+	return 0;
+}
 #endif
 
 int board_interface_eth_init(struct udevice *dev, phy_interface_t interface_type)
-- 
2.34.1

