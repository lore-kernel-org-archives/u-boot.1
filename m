Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F97C07E97
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 10:11:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AFDA8754A;
	Wed, 29 Nov 2023 11:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="lip7N2W0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01FFD87645; Wed, 29 Nov 2023 11:11:24 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17D7386A19
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 11:11:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a02cc476581so884414466b.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 02:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1701252681; x=1701857481; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jw+nH0Oli8J6PbeYRY1C6ggkrUZDk3KY6ZfNrT6JHHs=;
 b=lip7N2W03bDfxyiyF7aaW/5nuYEu2GPJoQY+SD+1/WkAP8kS2D4nb8HNc8qlBpJtcU
 Ltx/jljuV9yS0hWy2YpjVd6SFcLd+7Y3cduqhQG7YMln8yz3r5pprgblNXlyofa19c5R
 NB2rgiPPnOp0hi6+mhHvZp6CuZo+s+ydPFD4RVci8foSAr4r4PTqLOUDlDL6dG0fAcXc
 LjrQDnakqq5N5ndEezHydfUTsNaXufrzEDe9uOHv+srufwlAydctx3W30o/FKE9clMoK
 90GSmzSyctw7rT2khQXP93rmrnbjlyQirgaQztKUEiTg3QPUNUyURzvvLdnIQkKwnU02
 H5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701252681; x=1701857481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jw+nH0Oli8J6PbeYRY1C6ggkrUZDk3KY6ZfNrT6JHHs=;
 b=xI2g1vanLeCObEV/LIDwMaMjzT/twpU7qnZNq0t5UHrv3envWj4R9Vv1i1MzaXggqP
 obg4BhypuFCjO9BCbcUxiQxnW56UxihncRINaEcDksIjHX/92hnCwmg97coZAl8HwLsn
 C7HsJMv9lVVMJQzQ14zODPOq/CpCe8ODMNQUEGNRp/Qsa8Au4ft95S6AV6BBseP0CdlG
 Y4jd9o7xp6moKbwoMz6Gl8TeZwC1z3pv9+pZ0I4I5pMnft8wAQejXfnAZqXM3woARoDO
 m92wUxuyK6XJYajLmWkJClc0xjzhGz9ZaonrnInfgYcnNTKJBjbXIwgbQUskCsYK5fAF
 c2zw==
X-Gm-Message-State: AOJu0YyYWYoo/+dUEnqJliNuWlBPZ7rio6k2v+LG2eGEeKmL+XIf/Knm
 +RcZHR5z7sXgcZu1XeikrQgETQ==
X-Google-Smtp-Source: AGHT+IH0gs6M53+D5Vl0Gqz81WOEdCX/mcIlTO46TPOmXftM1yr36VCeK7dkn3uQXfyFd7BTI2r2yw==
X-Received: by 2002:a17:906:6a05:b0:9e6:2dcf:e11e with SMTP id
 qw5-20020a1709066a0500b009e62dcfe11emr15444635ejc.5.1701252681388; 
 Wed, 29 Nov 2023 02:11:21 -0800 (PST)
Received: from fedora.. ([213.149.38.84])
 by smtp.googlemail.com with ESMTPSA id
 t17-20020a170906a11100b00a015eac52dcsm7691384ejy.108.2023.11.29.02.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 02:11:20 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: sr@denx.de,
	u-boot@lists.denx.de
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 2/3] arm: mvebu: Espressobin: move network setup into a
 separate function
Date: Wed, 29 Nov 2023 11:11:07 +0100
Message-ID: <20231129101117.60177-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129101117.60177-1-robert.marko@sartura.hr>
References: <20231129101117.60177-1-robert.marko@sartura.hr>
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
Reviewed-by: Stefan Roese <sr@denx.de>
---
Changes in v2:
* Rebase on top of current master and resolve conflicts

 board/Marvell/mvebu_armada-37xx/board.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mvebu_armada-37xx/board.c
index 1471caa9a6..f532486b70 100644
--- a/board/Marvell/mvebu_armada-37xx/board.c
+++ b/board/Marvell/mvebu_armada-37xx/board.c
@@ -301,14 +301,12 @@ static int mii_multi_chip_mode_write(struct udevice *bus, int dev_smi_addr,
 	return 0;
 }
 
-/* Bring-up board-specific network stuff */
-static int last_stage_init(void)
+static int espressobin_last_stage_init(void)
 {
 	struct udevice *bus;
 	ofnode node;
 
-	if (!CONFIG_IS_ENABLED(DM_MDIO) ||
-	    !of_machine_is_compatible("globalscale,espressobin"))
+	if (!CONFIG_IS_ENABLED(DM_MDIO))
 		return 0;
 
 	node = ofnode_by_compatible(ofnode_null(), "marvell,orion-mdio");
@@ -358,8 +356,17 @@ static int last_stage_init(void)
 
 	return 0;
 }
-EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
 
+/* Bring-up board-specific network stuff */
+static int last_stage_init(void)
+{
+
+	if (of_machine_is_compatible("globalscale,espressobin"))
+		return espressobin_last_stage_init();
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
 #endif
 
 #ifdef CONFIG_OF_BOARD_SETUP
-- 
2.43.0

