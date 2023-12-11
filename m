Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C06C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 09:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C85287719;
	Mon, 11 Dec 2023 10:01:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CNRmqmq3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 194AD87721; Mon, 11 Dec 2023 10:01:44 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D718B876C7
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d04c097e34so32405635ad.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 01:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702285300; x=1702890100;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oSNbSHvYxZmXQ44u/a1g+gZnsUNQRHVUJGU7gTP45bs=;
 b=CNRmqmq3Z5Tuy09oHcQSaTvGQV9n+x0U/1KYBueO42BmnR2vYXzxYHGk43bPMXQhcB
 Bgf82bwbk1nSm7oQVumgLnyLjPdODfwG2S2uP2cUxdguJqC9s4IKDdfmb9hI7MOUXK9O
 wo56R7My+2WSCyjuOH8H+RlEFUma8rv+TCIdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702285300; x=1702890100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oSNbSHvYxZmXQ44u/a1g+gZnsUNQRHVUJGU7gTP45bs=;
 b=CSderwR/nXsfyKE2piHAphVb/wCUchxOmaRF/YFyo4lHyWMMuiikkiIXTy/ULobMPt
 mqloMDvfdALnSOiBj6DBMH/O4prOmUHHfcIqHRpFjYQE5T3dymMaZgsJHCTpd8WbAaKW
 7CyHw3bqGX97/YH4Fk2IxU9YkFkeHmbnFeyqUTGzHM60kuMSTKWZ9qO8mOij5Iiz+B13
 Nn7ynaW/vtMM337uOqhGRxgWRw0JX0rr6RCS3N+g3+hj3XK4+4fy42N6+AMZd4yZZgWB
 DTW9pzNf7Pw8/zuR8vfzvYmeXhFCJ8SF7JmyFp2euw3GKfl9DFvIx0jE9AqL4AkwRqe9
 q6sg==
X-Gm-Message-State: AOJu0YzvpZUe00avX77rrhUJq/1FszS4KNrgIcNVMK6VqkYx1ku7vqyB
 5pS4urTT5jifrSS7xjbKOsPtNQ==
X-Google-Smtp-Source: AGHT+IE9Vh5r81/RmMILgxwXg0zPKRYSzIwlJb2Nv0Cteiv30JbKmiLAuOCAd9dbx3URBB9qbMvSjg==
X-Received: by 2002:a17:903:2342:b0:1d0:700b:3f78 with SMTP id
 c2-20020a170903234200b001d0700b3f78mr6694892plh.50.1702285300174; 
 Mon, 11 Dec 2023 01:01:40 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a170902d39500b001cfb93fa4fasm6080779pld.150.2023.12.11.01.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:01:39 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de, Da Xue <da.xue@libretech.co>,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 14/17] ARM: dts: rk3328: Enable VOP for bootph-all
Date: Mon, 11 Dec 2023 14:29:36 +0530
Message-Id: <20231211085939.5478-15-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211085939.5478-1-jagan@amarulasolutions.com>
References: <20231211085939.5478-1-jagan@amarulasolutions.com>
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

Model: Firefly roc-rk3328-cc
DRAM: 1 GiB (effective 1022 MiB)
Video device 'vop@ff370000' cannot allocate frame buffer memory -ensure the device is set up before relocation
Error binding driver 'rockchip_rk3328_vop': -28
Some drivers failed to bind
initcall sequence 000000003ffcd5e8 failed at call 000000000021a5c4 (err=-28)
 ### ERROR ### Please RESET the board ###

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/dts/rk3328-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boot.dtsi
index a9f2536de2..5258fec566 100644
--- a/arch/arm/dts/rk3328-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-u-boot.dtsi
@@ -68,3 +68,7 @@
 &spi0 {
 	bootph-all;
 };
+
+&vop {
+	bootph-all;
+};
-- 
2.25.1

