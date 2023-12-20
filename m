Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C729BC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 10:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B529876C4;
	Wed, 20 Dec 2023 11:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bc54Xx+L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C88FA86CF4; Wed, 20 Dec 2023 11:39:15 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A8D3876CA
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 11:39:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrejs.cainikovs@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50e23c620e8so5590253e87.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 02:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703068752; x=1703673552; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZvBHzwiIxx+OnzL1eK8v52Qpr4vWmh85jI5DG4tIkLg=;
 b=bc54Xx+LvqrwXdcdF2DUHO3TnXc1LgGX16CZA+fEXlaUKbe5FZn0jyeRWe+eY4Rxjo
 RUwtiicVL8HpCDVlQWyt7toaJVxIoX7uKPqB55mRfY/D9C/mu5qHb8UkchK/rjcuStRi
 MxHM9xEEy5MIpD9QSrHXv0VdQ3Rnjgp3t8hYPG0w4cVDoFc+rKYIWrD8gKE7yPdtygwj
 Le5rgE7s48z/LJQ2Kdl1U9/XrrIUBmPxIP8k4N/fZVUXw1y5ck+jpDPQDE4VAn46nv2A
 HIvX4FScWn1j1EYzIY4UMTZNccOPBQxXWB13KKM1uH06KYDxvXoArNuDynfXunYuYMZM
 Xqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703068752; x=1703673552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZvBHzwiIxx+OnzL1eK8v52Qpr4vWmh85jI5DG4tIkLg=;
 b=QCT0PbK9J8B5DHyh3QQ/1Riz94MTq7+4FzvFPD9O35XvoVdSPIh+ILNhWuxAeXpdKd
 xGYjgpB6In6SSoRwgdD0s8XS81DtD9ScIQMmYm0eUz8OwC4QhBVYPi6LrKZhJp7X+VRI
 ejKXuObHnQCP2X023t1JyXi6UfDaqaGMXYGEc4bnAfK33tPR8PQmfSpgSiYOTYvpi0B4
 RBS/bK+S+G0zGF0q1k2hypKICIiyQKjMcB3NrKsVF/+9+9tYWlxVuWYpC8rNOSt11l2d
 3zDxpRzxr+/KUXcsmmHbT/AZ/loanAfJXdNCBVmXmRMyy56cKwOCwRIhxDD+1WBYFYFb
 nX9A==
X-Gm-Message-State: AOJu0Ywhl4vtI+NtANdWBqag74sKg+lMqQdSn4cHcqyueNz69mfVIMWZ
 PvrR44IWP8iAFRw2lIofKB4m0TS85vKi9A==
X-Google-Smtp-Source: AGHT+IGUPsm7W/r1KWr2p8aIDxftB5vWLE5r8J/jkqLeZxB2oK+9DIyZpJFcrx0SfFhjibpvqEn+aA==
X-Received: by 2002:a05:6512:3f1c:b0:50d:1e51:507b with SMTP id
 y28-20020a0565123f1c00b0050d1e51507bmr9886407lfa.44.1703068751324; 
 Wed, 20 Dec 2023 02:39:11 -0800 (PST)
Received: from andrejs-nb.int.toradex.com (77-59-154-235.dclient.hispeed.ch.
 [77.59.154.235]) by smtp.gmail.com with ESMTPSA id
 f19-20020a056402195300b005537b00132asm2259932edz.91.2023.12.20.02.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 02:39:10 -0800 (PST)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: u-boot@lists.denx.de,
	"NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1 1/3] apalis-imx8: remove -u-boot.dtsi include
Date: Wed, 20 Dec 2023 11:38:09 +0100
Message-Id: <20231220103811.228515-2-andrejs.cainikovs@gmail.com>
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
 arch/arm/dts/fsl-imx8qm-apalis.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/fsl-imx8qm-apalis.dts b/arch/arm/dts/fsl-imx8qm-apalis.dts
index bc7c75d3372..e089ddb8468 100644
--- a/arch/arm/dts/fsl-imx8qm-apalis.dts
+++ b/arch/arm/dts/fsl-imx8qm-apalis.dts
@@ -9,7 +9,6 @@
 /memreserve/ 0x80000000 0x00020000;
 
 #include "fsl-imx8qm.dtsi"
-#include "fsl-imx8qm-apalis-u-boot.dtsi"
 
 / {
 	model = "Toradex Apalis iMX8";
-- 
2.34.1

