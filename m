Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AE5C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 07:44:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E162B87AA9;
	Wed, 10 Jan 2024 08:44:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ne/JZ6/q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6097087938; Wed, 10 Jan 2024 08:44:10 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22FEF8795F
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 08:44:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a28b1095064so405324566b.2
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 23:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704872645; x=1705477445; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bA8dIPyuevVt49I0mtLgTHbxtNgE3Zzcp8vc5MXLjDA=;
 b=ne/JZ6/q4g1M7G2bedtDsdGaVLlZ+l4rOTg/I8Ccpl3zA8CqDWfxSycmha5Z9xOqNO
 Po4S4KuqgLH5WXtSjaBilukqNZrxgaKp9hs0ZMN2PLK1X1ZnFwe8HjXXvET33wTDkNKq
 WGt0ZOUyj/dQQycudLLkjLrCwRE3UlZnXs2lIGIHTgmIKgH7dWzAC7F9RCZ8qCzFJfqG
 m7zMSRPqz5qdtipjvOTrehzI42nczy/T4a9JSs0yFdfijfkZ/NIFRf9Vk1jqBzEaod6t
 jWMc4/ZOlmA+vPsjYgV5s7JJCAhHKJmfHvPHT5/08JFAMeCpHJCnxmgG4YIGuS5vg90g
 HDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704872645; x=1705477445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bA8dIPyuevVt49I0mtLgTHbxtNgE3Zzcp8vc5MXLjDA=;
 b=dTLw/uJJOU9OqXnybn9KNoN07dhBALoq7/ydOFikaZv2fo2V4Du+h/KpslCZ2rPRL0
 FQM4SCInyvjN5GgRQda3K/TTOSQlI7bfamYpwG6ugAzdCHtqUVM4TajNog0GZKfIKUje
 HEDyiiMTnsTUDuUDbBmDFTfAabBGGuZ248B3MLBhC3LVQQVH1YxPiltazjTqsclTDNpW
 ODsOu/H3XGkaaiBpFzXK2Hvr1dhu6+CVmHCpuTdOrIDNbkNIo2fG015pwd/HQC7a8NgS
 Me1isBx6cE5A2ZwKspc96xt1IDt/CKyuLWetvxplFX/RgWny7dK/EKXTLbqmLnaM6uKl
 S/hA==
X-Gm-Message-State: AOJu0YxMTEHclgmcimeJ58nve/wQDNQxpDB1Q5Qu95KMNfynpqmdzxZm
 RrJy7wpjuRIIKsAMlgJOxkI=
X-Google-Smtp-Source: AGHT+IGR4BJPEE8USOVp0Bl2VAXXk5S7zSUuo0cIE5M81J5izW29sqQ9iAgGDnuqVzurbyg0Jw0/CA==
X-Received: by 2002:a17:906:e47:b0:a29:8b1d:d62f with SMTP id
 q7-20020a1709060e4700b00a298b1dd62fmr172029eji.258.1704872645300; 
 Tue, 09 Jan 2024 23:44:05 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 lh13-20020a170906f8cd00b00a2bd425eab2sm312282ejb.2.2024.01.09.23.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 23:44:05 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 05/10] video: tegra20: dc: add PLLD2 parent support
Date: Wed, 10 Jan 2024 09:43:37 +0200
Message-Id: <20240110074342.38331-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240110074342.38331-1-clamor95@gmail.com>
References: <20240110074342.38331-1-clamor95@gmail.com>
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

