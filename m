Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3AFC47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 17:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A810A87A0B;
	Tue, 16 Jan 2024 18:14:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fNhNhlWT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBFDE86F67; Tue, 16 Jan 2024 18:14:37 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB64487A18
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 18:14:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6ddef319fabso4556008a34.1
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 09:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705425274; x=1706030074; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5YNPlhJytwclbnPZso5l+tBazJTAx0BgcunMJhm9IU=;
 b=fNhNhlWTJzscuYNu77cmTcl6ufE6T9WpqcxtLQiGyb72Me3yNevtQnAOazH0OnCJ41
 BLbsyIA8eFCnWo7G32FsV5KkghfUcc3D5W6F2XNwBs4MkwDEkV3YY3/tmdXiChEXbeg4
 hLRoY2Smub2BBc6xXsAW9LezVp3a8VmoynmotFuumAcrt0sheu2AshxSb0vPIp+MoFIO
 5GhTU03329yG+e7Goa0F7aFrT4BlG3Z4ikIYm2/JD4S0erXOdXMWFwmOiMWlE+HFRh4e
 ZB1pKEb9KHi0r4gnVEnaMGqbQggzrJ2ANCjOz74pJvDKzz/SZ7NSckOgnBB/X+4c/GNa
 nCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705425274; x=1706030074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5YNPlhJytwclbnPZso5l+tBazJTAx0BgcunMJhm9IU=;
 b=ayc3FDl6vUUJB5BUcEqRwY29lgzpePmAMBFalZXu0h7L4M4uLZ8erLA17MnWmR/ed6
 ohaTgAFFMgaR2O+X+t9wiD8TdNOQEZDnOFdISCllvCWyql8HkHzXSz/mO7yHrhDtS/3O
 TnF3NRlmro6lAfrkb2hRZmNtcrH/akQIKZ4V+LFcgFJlK9cjuFCfKWQOKnWyPLqSawI3
 SLHGY0t07BG5q/sDr79u05+KMg7Iz7lSOPmd+7NGcupffcBvsljnjyJvb6pVagP6exp0
 1VlIfNdTFETM8zsq1YxpIUQ9lLqD6VxWGFFmz/EhJhCTAzHsknUiDLyNOG6LIGnUavlD
 H15g==
X-Gm-Message-State: AOJu0YxSFdH+H75C96khomlxihc1f7V4ddJvYUH3z66xUohXJ0mwYmhm
 hBpVZd5CfQTcxh0XO09Wac+xRxICdj7tMLbLlIUC5r0xYTM=
X-Google-Smtp-Source: AGHT+IFD6AY5RIk+7VsURayKtd8x/7awtXqQnf917OjkDeNMr2W8dF8hTPNODYCaPxMaPwq+CnvXKg==
X-Received: by 2002:a05:6830:1da9:b0:6dd:ef0b:4f62 with SMTP id
 z9-20020a0568301da900b006ddef0b4f62mr6162672oti.77.1705425273867; 
 Tue, 16 Jan 2024 09:14:33 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 bp43-20020a05622a1bab00b00427e0e9c22dsm4988291qtb.54.2024.01.16.09.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 09:14:33 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Fabio Estevam <festevam@denx.de>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Yang Xiwen <forbidden405@outlook.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Peng Fan <peng.fan@nxp.com>, Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <seanga2@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v6 5/7] arm: armv8: save boot arguments
Date: Tue, 16 Jan 2024 09:13:50 -0800
Message-Id: <20240116171356.376801-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116171356.376801-1-raymond.mao@linaro.org>
References: <20240116171356.376801-1-raymond.mao@linaro.org>
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

Save boot arguments x[0-3] into an array for handover of bloblist from
previous boot stage.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- New patch file created for v2.
Changes in V5
- Drop the dependence on OF_BOARD.

 arch/arm/cpu/armv8/start.S | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 6cc1d26e5e..91cdd03947 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -370,5 +370,19 @@ ENTRY(c_runtime_cpu_setup)
 ENDPROC(c_runtime_cpu_setup)
 
 WEAK(save_boot_params)
+#if (IS_ENABLED(CONFIG_BLOBLIST))
+	adr x9, saved_args
+	stp x0, x1, [x9]
+	/* Increment the address by 16 bytes for the next pair of values */
+	stp x2, x3, [x9, #16]
+#endif
 	b	save_boot_params_ret	/* back to my caller */
 ENDPROC(save_boot_params)
+
+.section .data
+.global saved_args
+saved_args:
+	.rept 4
+	.xword 0
+	.endr
+END(saved_args)
-- 
2.25.1

