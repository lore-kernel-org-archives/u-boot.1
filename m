Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9A9CEACEA
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 17:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 826D28925F;
	Tue,  1 Oct 2024 19:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Go95oFDN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CBEB88A34; Tue,  1 Oct 2024 18:02:09 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C38588D35
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 18:02:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37cc60c9838so3303505f8f.1
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727798527; x=1728403327; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cc04F5Um7Z2jluqs2zDelUDOFW5Hx+T7t7r+bt8jt/w=;
 b=Go95oFDNT4BQ8O3dk1w/LO+vPnNDYHHbWYRIAGce9UXnc6DkrNW+ROrEWDhnJ6PwY0
 wDUO5jNnztLS+ceXnt7UlLWN6A2tRupQAsglhpcFGymzRVv6Bp6m6+SLH+H1bL5e6S5b
 QiS0Fay/20UxMicjZfHlPPktvmno7eVRohaQheOIzgfLyPGPRVVlUJtjUkaM+ax5Mnxc
 d7I9yr4hNcKyCHot1FawRvs4h7Cu8TdHnWyDUZtsbBrghlBJ2aCeg3NY0JGUFaxCGm62
 QdCHLD8JCtyN3pp4Nsk0nJAop16ZOnZ8qC292Och9mU3nqjHSLQaIp2o4ujRl43md9Sg
 wmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727798527; x=1728403327;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cc04F5Um7Z2jluqs2zDelUDOFW5Hx+T7t7r+bt8jt/w=;
 b=Ls45UgdF5bMFQgXiCRaqoeBqz0w7blJ5Z1bd0OgS+Yozu3hA0sGS/GvkOLoXse8ybf
 Kr86ofl3CTHNOzBXZQj9qv+1C8fKZC6Ke7c6EgXVe6vDCUyG1qMmx21LFiJwCGBdAH+2
 8ilzn0YF4PkSpsFhn1GY0RtyCF7xmoe4djCvjETpN/44+WCOKJtvGE94pK7MRFCfVtHD
 EjgohIgSmcSOetW4zhkRFoiqWlUkiF9dTxKuSUytG2gzS+NUNpwvML/Tn5jEcfnTy4Wu
 2dz9H2KwMCu1wf+eJRgpVBTTeHix5ilrt83QRq2uTil5jlcr/AunclbNqW/Q0YU8DZJ9
 wkHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ0ObLERktozmZGZS+YnUu5BOImgKbhWlc/oVMjJ/wMNNB4LPjKMQFwUrrhwULTd0rWtTvpmY=@lists.denx.de
X-Gm-Message-State: AOJu0YwucOO1AUcOfn2D4F72EFj/A3itO/W2oylmn8QypgF+wSL6WoBQ
 3QbDPIbODQBWAP1480pDSDQDPPvvyWZ1uHySw1B7bAN/AcCouE5V
X-Google-Smtp-Source: AGHT+IFD0BTRpajWuFiNNko/NG3wPss2830Si6sbCJUbWRbPO5jS9V/0ckw0WiGVZvMe32wYtmDRHg==
X-Received: by 2002:a5d:59ac:0:b0:374:badf:3017 with SMTP id
 ffacd0b85a97d-37cfba36371mr26515f8f.33.1727798526414; 
 Tue, 01 Oct 2024 09:02:06 -0700 (PDT)
Received: from vitor-nb.. ([2001:8a0:e622:f700:a11e:2260:557c:e884])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd566a41fsm12107646f8f.45.2024.10.01.09.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:02:06 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de,
 ivitro@gmail.com
Subject: [PATCH v1] arm: imx: imx8m: soc: Fix VPU fdt disable fixup
Date: Tue,  1 Oct 2024 17:01:52 +0100
Message-Id: <20241001160152.336121-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Oct 2024 19:17:42 +0200
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

From: Vitor Soares <vitor.soares@toradex.com>

With the introduction of downstream Linux 6.6, the iMX8MP VPU block
control node in DTS was renamed "blk-ctl@38330000" and will not match
the ones found in `node_path_imx8mp` resulting in the node not being
disabled on the VPU-less variants.

Add an extra node_path entry for imx8mp VPU block control that match
with downstream Linux.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 arch/arm/mach-imx/imx8m/soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index be38ca528850..4c224382021e 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -955,6 +955,7 @@ int disable_vpu_nodes(void *blob)
 		"/soc@0/video-codec@38300000",
 		"/soc@0/video-codec@38310000",
 		"/soc@0/blk-ctrl@38330000",
+		"/soc@0/blk-ctl@38330000",
 	};
 
 	if (is_imx8mq())
-- 
2.34.1

