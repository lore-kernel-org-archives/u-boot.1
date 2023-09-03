Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DABC83F2D
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 20:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCDE68698D;
	Sun,  3 Sep 2023 22:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SGZ5L4aL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99C498698D; Sun,  3 Sep 2023 22:57:11 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBA7186951
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 22:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52a1ce529fdso997202a12.1
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 13:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1693774627; x=1694379427;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Er+cmfuY24AtPiDqGJnBw1eBcMXGQAsBK3WVqoQh17c=;
 b=SGZ5L4aLoFm7RYOOb6xZJq6T0OjLN0KreJlWnNhtBNqztrCoPBFNNHb0FHzAyF4+P+
 VfppK/njfCwDe/LrVRaL3FM8SvDxhU/jvZmAsRVHqRUYMU+21inJe0Gxz60cobziswCf
 ZwkbpEZqawGtBLD97IK49D0IBfGL6udc1tlD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693774627; x=1694379427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Er+cmfuY24AtPiDqGJnBw1eBcMXGQAsBK3WVqoQh17c=;
 b=gypMnuddjm8W7Qlz178Mjrk9jzL1PHppZ7oVpcoDovaEPjwith3+cbqp5ibT+XWaaJ
 EGB7RBh7Yys6JKrB4S+lYTR8eJSmsb6toQlxUlD/9bpvsMGqVdyKVvcr0w1mQKLx3xFE
 SjMQl7/w3AlmfIHKSZHi9OLrS4vCz5urqwBFIssrTWcQAdgyF/tnsT1X4/QMcXvbonR/
 yJURAyTG0rVczvyh1MDlFi9IMZlep9c2d1guKa1Y1hPXxOdXDuZ5pRStSyG79ZjXwzZX
 2IKX9mQrV2hpaCSCn9jStEJIa55WhfRjaHcbbFxoKxoGQdGg2ODhmQZ3dijTr33vqvvh
 exhw==
X-Gm-Message-State: AOJu0YztI7IeHeZ+Z4bObY22gSW1MLzX6zB3agtgZwf+mohTfcn7yIJb
 2WpTIvEAL/vfMA1Sv46LJwG1Yb1j3eR0jS7NOUOi2A==
X-Google-Smtp-Source: AGHT+IFZokVpkIALkymREVl770Jn/Lhpe9ZTqtD74yuWoi4ctLwpq4Wpccj/woooJ+AJ9PLOB/31TQ==
X-Received: by 2002:a05:6402:517c:b0:52a:38c3:1b49 with SMTP id
 d28-20020a056402517c00b0052a38c31b49mr5692154ede.40.1693774627148; 
 Sun, 03 Sep 2023 13:57:07 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-54-71-141.retail.telecomitalia.it. [79.54.71.141])
 by smtp.gmail.com with ESMTPSA id
 v22-20020aa7d9d6000000b0052568bf9411sm4850232eds.68.2023.09.03.13.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 13:57:06 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [RFC PATCH 1/5] ARM: dts: stm32f469-disco: sync with Linux 6.5
Date: Sun,  3 Sep 2023 22:56:59 +0200
Message-Id: <20230903205703.662080-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230903205703.662080-1-dario.binacchi@amarulasolutions.com>
References: <20230903205703.662080-1-dario.binacchi@amarulasolutions.com>
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

Sync the devicetree with linux 6.5 for stm32f746-disco board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/dts/stm32f469-disco.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/stm32f469-disco.dts b/arch/arm/dts/stm32f469-disco.dts
index 6e0ffc1903be..c9acabf0f530 100644
--- a/arch/arm/dts/stm32f469-disco.dts
+++ b/arch/arm/dts/stm32f469-disco.dts
@@ -119,7 +119,7 @@
 		};
 	};
 
-	panel-dsi@0 {
+	panel@0 {
 		compatible = "orisetech,otm8009a";
 		reg = <0>; /* dsi virtual channel (0..3) */
 		reset-gpios = <&gpioh 7 GPIO_ACTIVE_LOW>;
@@ -138,7 +138,7 @@
 	status = "okay";
 
 	port {
-		ltdc_out_dsi: endpoint@0 {
+		ltdc_out_dsi: endpoint {
 			remote-endpoint = <&dsi_in>;
 		};
 	};
-- 
2.34.1

