Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A37DC47DAF
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 16:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E29387E81;
	Sat, 20 Jan 2024 17:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ipGAWJPO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C58787EEC; Sat, 20 Jan 2024 17:56:22 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00EA587EAB
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 17:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a2d04888d3dso190033866b.2
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 08:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705769778; x=1706374578; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bA8dIPyuevVt49I0mtLgTHbxtNgE3Zzcp8vc5MXLjDA=;
 b=ipGAWJPOIYiiewYb6GwpXcZOmfZXXcU3jifuqRNZ2HprY9BhOriE2TA4mscJgmzJ9f
 DpR5LVP8TtZh3WhX5DCYDNPVZ0twNrn9busNG45ewwoa94VycfM29YJggnSF6MFg/8Dy
 Dx71sHPkVaNQj3+eoe+1K5urBRZTuDHooxYTDp4olkoBT5CzrAHXBMiWQuCavVhMrUpg
 41CyTAm6VQcQd3WejAKV9aM+HN4D0wR3Bti2x6QBWw0BdKlmZ0tTNWsBtrLFfdpcCnJ7
 L/0ysTYJDj4gMuO70UvZ7RrUtf2njUoaYCF+eF0oIxS8nZt4EFvQFIkfBjv7IED6Fr1p
 uaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705769778; x=1706374578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bA8dIPyuevVt49I0mtLgTHbxtNgE3Zzcp8vc5MXLjDA=;
 b=sHbU2aEq9xuy/yrqCTgwYC+Rf9PNE0KfE7Lj+aAFCEPhYo/4/nAxHflV5igW7u0p+t
 GPhvV41fPQc2YgC3HPvPdONDTJjfmwnjNti1c4Iyn4z4A/iKg7OAr3B2ully3ILYuVAg
 1et3NDWnlALYynANFVMU8gLcLtpPWOfQhlId5XWroghuwVV9Ivq2pRTQOU0dYvNefixn
 IGAAxREdG2J+uJyHY8jrfSs+Rtiy7V02XDN4By0WcDWcTRxArU3egoiaVgCCb8AnqpA4
 UF0U9YHjn7WIIrlXsdcCCIynjIo5Oat6YiUI4WaA7BG6NoMt69A6P3aEZno/HE6FG5Ct
 BLZA==
X-Gm-Message-State: AOJu0YzFL2J0G3iDU/+1OW8KMSYFScqVCPMfhT6t7J9GUT3xpgdjSJck
 ozXIcgq/Ng/SCGMMJZRfRDxjNtflCnvr8R6t4IY5plCdmD33Oxgb
X-Google-Smtp-Source: AGHT+IEk3ag18W6SKOaQTpFv2Y4XjkooRfDu3Qagzj4asEsCGfpHLsvTclsAi2UX6Xk/FOs5VzfuLQ==
X-Received: by 2002:a17:906:eb58:b0:a29:160a:11fc with SMTP id
 mc24-20020a170906eb5800b00a29160a11fcmr818743ejb.103.1705769778267; 
 Sat, 20 Jan 2024 08:56:18 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 ca13-20020a170906a3cd00b00a2c869be22dsm11311548ejb.143.2024.01.20.08.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 08:56:18 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v5 05/13] video: tegra20: dc: add PLLD2 parent support
Date: Sat, 20 Jan 2024 18:55:35 +0200
Message-Id: <20240120165543.10226-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240120165543.10226-1-clamor95@gmail.com>
References: <20240120165543.10226-1-clamor95@gmail.com>
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

T30+ SOC have second PLLD - PLLD2 which can be actively used by
DC and act as main DISP1/2 clock parent.

Tested-by: Agneli <poczt@protonmail.ch> # Toshiba AC100 T20
Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101
Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper E1565
Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 0e94e665ef..56a23b3c97 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -304,6 +304,12 @@ static int tegra_display_probe(struct tegra_lcd_priv *priv,
 	if (priv->dc_clk[1] == CLOCK_ID_DISPLAY)
 		rate /= 2;
 
+#ifndef CONFIG_TEGRA20
+	/* PLLD2 obeys same rules as PLLD but it is present only on T30+ */
+	if (priv->dc_clk[1] == CLOCK_ID_DISPLAY2)
+		rate /= 2;
+#endif
+
 	/*
 	 * HOST1X is init by default at 150MHz with PLLC as parent
 	 */
-- 
2.40.1

