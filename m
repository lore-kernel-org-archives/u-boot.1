Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B72AC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 10:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FC3687A30;
	Mon,  8 Jan 2024 11:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mpIGsQUi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E839787A80; Mon,  8 Jan 2024 11:50:59 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DEEC87A70
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 11:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a29da3d61f6so168787666b.3
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 02:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704711057; x=1705315857; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZG+3CU3Ylyq34dMaXO4ZcAaD9vwzwCLIV3CUc973E4=;
 b=mpIGsQUiTZkLpCHzfHV1XTxgRBTtjiSk/dRkTM9IbBuX565liznpOsuXMC50rgVdRH
 0LzEmVhD5DapJyfzx7MqRzoouTeWunvQfNHGpCZwTji29rixtw7dzGb4YoMk6X7rgcXu
 vaxb2iA+aW3yHvsKu0bZUX0C8Z0Aks1TRHz9Eg8t2O1Zfa5nuTkYGxE8L/UdQLhQjAiP
 iD4htROYwYSTyXj3RMEmSz2fzvw66T55dXsJej/NiFJwwba+HfIJihsWbWwoYDJGariM
 hC075cwswae2rzEbpjFiM9wdWQOhPxT41Hg1Lq35jLeTUM5EyObRcuxi0/TCtXV9XBtt
 3CTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704711057; x=1705315857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZG+3CU3Ylyq34dMaXO4ZcAaD9vwzwCLIV3CUc973E4=;
 b=qPFWMGGk8JKw6hDOcCHZhIMvPD2BAg/JDZLnA+Z/7BkpBYSHjDaTNXUup5fZCSfYyX
 PRAj1db2DU87ppWjEuRclakMIaELjQVlOkdeHBVbMN+d+zxA+/bV+obwI5DNhjXl8MmL
 1j36JdG7V3AOQ90VFLEJK5i70Ovu/VMUfU+hgrX3PrI5VjSk1nyFe+xJZlJyRMC1hA/S
 iMX3op9ph3dU4iFci+3RktRWHaP4pDZ3MO9zd/kocKLEbLtexjFoTgBYri8yXVo79xUL
 U2N/0NbNFOokINrRAPJyDSGGCNvkVmVrjYQEP9+RDX6ep0VlYK/Bcl+vpjKxe+Q88e7J
 VDOQ==
X-Gm-Message-State: AOJu0YwpbjZ93e6T2uM4s5eYwYSf+b5pBTHWeP08+Ym1K/VRKhjninwc
 iT8pSnY6Q2rgTCjiDD7YTEA=
X-Google-Smtp-Source: AGHT+IFqux4q0LQfdvLonEF91XuFWGqlNgbHAArh0lqprpKeyV2yaxGbafGKse5y4XwhZtwjUc2GTA==
X-Received: by 2002:a17:906:374e:b0:a2b:55a:9e13 with SMTP id
 e14-20020a170906374e00b00a2b055a9e13mr152671ejc.11.1704711056784; 
 Mon, 08 Jan 2024 02:50:56 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 26-20020a170906309a00b00a26ae4fb50asm3821141ejv.89.2024.01.08.02.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 02:50:56 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 4/9] video: tegra20: dc: add PLLD2 parent support
Date: Mon,  8 Jan 2024 12:49:57 +0200
Message-Id: <20240108105002.243149-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240108105002.243149-1-clamor95@gmail.com>
References: <20240108105002.243149-1-clamor95@gmail.com>
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
index 09917376cc..f2b2dcd48a 100644
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

