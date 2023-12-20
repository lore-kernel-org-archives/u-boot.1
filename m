Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB8DC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 10:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFB8286CF4;
	Wed, 20 Dec 2023 11:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OcLe9vke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE538876C8; Wed, 20 Dec 2023 11:39:16 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C7E8876C4
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 11:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrejs.cainikovs@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-54f4f7e88feso7589116a12.3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 02:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703068752; x=1703673552; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGXmKbVMU2+Qp/Js5XW4TU2OECmH9Ci+jrhwwpQKmVE=;
 b=OcLe9vkeFm2OpE+SNtehrLiL5PGZVmIPQKFxrC9ttk9hXARPfLNvXsEm4jpH+wnaEp
 uASx3k1jF+EmVEa15dstfYZPxz2ibj/r2nZ8nR/Rnwst8xhnCFM7rbk+bHu2a3H85z6p
 Xz8szZO5V03ljPe354XS7Ro6c5UuTAsr7ta5fnWHSiiC599SxOg+G/GJAZDzboiHfE2D
 VIy2qhH1INZj4CYlgGRbadshpUyRISOHaYaBQXfgsQRYKEmFwig76K79phWyW1J46Wow
 1Br3dChpwelDurgNpBUCFPl98ePaxf3Z8XbBe2g39jHNPmLxgjMrh2ydYhNva89NMdyG
 /z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703068752; x=1703673552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CGXmKbVMU2+Qp/Js5XW4TU2OECmH9Ci+jrhwwpQKmVE=;
 b=mL+e66OIFroBoSo0tRYmwEbdsaB16hrtu+iFbGixkG+mlCofA/HlcO6XfzWuwMUK2v
 BepG9EcEs9UQYCwv5ykeEaVD3fqGOG2C2aBe5/cQTWTTRRvkVR1+C9/k2+TKyCJoQZGx
 DAu0r9riIu9iKijNg0o+BG3QNS+Ya6JiROxko43Xj43hwT2YMh53RaLSVEhpCP4vK2+I
 zAWo0Sl3TqmjokGWhGNF+ZsTuQ9k6UPPlcjKvDg4EAsJ3xk4wyNWXw4JFxmr70ZhkWm1
 JcQ1z0cVFfLmxvKwGTuOkPMUh2nXjlfAwHPWPYuNlEWjFPaLbgwAfchW+xt/MfhEj9TJ
 4ZCg==
X-Gm-Message-State: AOJu0YytK9AnvH+g3xz9W24dQ6bo4sRIjRtwNO39GX0azSrRSkqKDCbD
 BDwwTJTPri/jYvOXrzXMbeAg55TaMvi/Vw==
X-Google-Smtp-Source: AGHT+IHnS375P4gsM7tJGp/os4Dzc0B33sXY1UC4dAXKrwQJHZSq2D5gjpeVt93Y/ysn13hMnGmn/w==
X-Received: by 2002:aa7:df18:0:b0:553:7407:eb02 with SMTP id
 c24-20020aa7df18000000b005537407eb02mr2257716edy.58.1703068752190; 
 Wed, 20 Dec 2023 02:39:12 -0800 (PST)
Received: from andrejs-nb.int.toradex.com (77-59-154-235.dclient.hispeed.ch.
 [77.59.154.235]) by smtp.gmail.com with ESMTPSA id
 f19-20020a056402195300b005537b00132asm2259932edz.91.2023.12.20.02.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 02:39:11 -0800 (PST)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: u-boot@lists.denx.de,
	"NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1 2/3] colibri-imx8x: remove -u-boot.dtsi include
Date: Wed, 20 Dec 2023 11:38:10 +0100
Message-Id: <20231220103811.228515-3-andrejs.cainikovs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220103811.228515-1-andrejs.cainikovs@gmail.com>
References: <20231220103811.228515-1-andrejs.cainikovs@gmail.com>
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

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

This file is included automatically since quite some time now.

From documentation:

U-Boot automatically looks for and includes a file with updates
to the standard devicetree for your board, searching for them in
the same directory as the main file, in this order:

<orig_filename>-u-boot.dtsi
<CONFIG_SYS_SOC>-u-boot.dtsi
<CONFIG_SYS_CPU>-u-boot.dtsi
<CONFIG_SYS_VENDOR>-u-boot.dtsi
u-boot.dtsi

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 arch/arm/dts/fsl-imx8qxp-colibri.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/fsl-imx8qxp-colibri.dts b/arch/arm/dts/fsl-imx8qxp-colibri.dts
index df992ac6396..295090ad711 100644
--- a/arch/arm/dts/fsl-imx8qxp-colibri.dts
+++ b/arch/arm/dts/fsl-imx8qxp-colibri.dts
@@ -6,7 +6,6 @@
 /dts-v1/;
 
 #include "fsl-imx8qxp.dtsi"
-#include "fsl-imx8qxp-colibri-u-boot.dtsi"
 
 / {
 	model = "Toradex Colibri iMX8X";
-- 
2.34.1

