Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609ACEDE99F
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 10:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CADB86680;
	Thu, 14 Sep 2023 12:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="BaxfghLq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BAB086A82; Thu, 14 Sep 2023 12:16:50 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DF1A86AEB
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 12:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso101684166b.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 03:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1694686607; x=1695291407; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8IlXkQwH0Qd4CCzWNKRfBq1a0NJtivmITMFE5Yb/Zw=;
 b=BaxfghLqWdgV9IA5PwtJ5HVyBTEPCUDhbNyB1Mf1Hv5s8mONfimHJfRuh1WMn7BnjC
 ytoQ1C/l7pw/Ugk5TyTgukVIqF1D5xz6JWQLjzSUnAKntcZaDayHeRpLbM05paN70nr3
 qcDxg+ndA5ryp0s/ulsS+CnxoLLfHLi1v11zA3cGI/NstxzQhTApPdg9oz6qyvkKSQ3R
 5MJcsK7JiMwF+mt6OCgIiRwwfZGfO2Jx4ieAnRuXOGpzGDfF2qclSH0xXYYyozA6c8yZ
 /QVWGw5Csb8YJq3SUwA/80PevEbKNOTkf96tiXzwOT00BdF+YY3syHvndEpWkPg+bIWl
 fxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694686607; x=1695291407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g8IlXkQwH0Qd4CCzWNKRfBq1a0NJtivmITMFE5Yb/Zw=;
 b=lJak27kQXcwaTrmX+s8IvLikLmzVRDzFEesJB8Pcu+iFcEEjhPi9ZeaQVcSdocZ1U0
 INGPpDziAPjpees7donFvMrc5KPJWC8bz//IxRJKGacC4vWXxikYofVT4fJIkFdTgdCL
 WqJJY7ErIe4x5nD3DQU9flV9S8w2jyBmnOodJQRr5gNm2MEvej+QyIY08AtoUZM8YlHS
 p7MMPIei8+UsCthC5ddT0dZDOLeTDYa8R/8RglnmOY99P8Oc3zVhQsy9bwjj9aJJxhAs
 /4OGyybeiv8+FoBx0UgRr+rDbjUUOPAeX5gQgnGeD97OOmwbFtSTkxbv7h9jjQmSqwUm
 7wZQ==
X-Gm-Message-State: AOJu0YyQSHWxmGz1PYnn7qygA+Sox25MBewXkkSc5sGitjVYbbPHyBZi
 pHBGD6iSSgQb7vUcWyd0npQeBQ==
X-Google-Smtp-Source: AGHT+IFKijLof+UJccHOpsYfDik7h0RwIlPhyfU6zMZmpt5eTiJoXl5AMh51o7A3hG7vxzIAaL44fw==
X-Received: by 2002:a17:907:7745:b0:9a9:f239:d874 with SMTP id
 kx5-20020a170907774500b009a9f239d874mr4049798ejc.58.1694686607032; 
 Thu, 14 Sep 2023 03:16:47 -0700 (PDT)
Received: from fedora.. (dh207-96-100.xnet.hr. [88.207.96.100])
 by smtp.googlemail.com with ESMTPSA id
 y3-20020a17090629c300b009929d998abcsm783253eje.209.2023.09.14.03.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 03:16:46 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: sr@denx.de,
	u-boot@lists.denx.de
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/3] arm: mvebu: Espressobin: move network setup into a
 separate function
Date: Thu, 14 Sep 2023 12:16:33 +0200
Message-ID: <20230914101642.1603383-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914101642.1603383-1-robert.marko@sartura.hr>
References: <20230914101642.1603383-1-robert.marko@sartura.hr>
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

Currently, Esspresobin switch is being setup directly in last_stage_init()
which makes it hard to add support for any other board to be setup.

So, lets just move the switch setup code to a separate function and call it
if compatible matches, there should be no functional change.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 board/Marvell/mvebu_armada-37xx/board.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mvebu_armada-37xx/board.c
index da325e8c75..6527155c6e 100644
--- a/board/Marvell/mvebu_armada-37xx/board.c
+++ b/board/Marvell/mvebu_armada-37xx/board.c
@@ -300,15 +300,11 @@ static int mii_multi_chip_mode_write(struct udevice *bus, int dev_smi_addr,
 	return 0;
 }
 
-/* Bring-up board-specific network stuff */
-int last_stage_init(void)
+static int espressobin_last_stage_init(void)
 {
 	struct udevice *bus;
 	ofnode node;
 
-	if (!of_machine_is_compatible("globalscale,espressobin"))
-		return 0;
-
 	node = ofnode_by_compatible(ofnode_null(), "marvell,orion-mdio");
 	if (!ofnode_valid(node) ||
 	    uclass_get_device_by_ofnode(UCLASS_MDIO, node, &bus) ||
@@ -356,6 +352,16 @@ int last_stage_init(void)
 
 	return 0;
 }
+
+/* Bring-up board-specific network stuff */
+int last_stage_init(void)
+{
+
+	if (of_machine_is_compatible("globalscale,espressobin"))
+		return espressobin_last_stage_init();
+
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_OF_BOARD_SETUP
-- 
2.41.0

