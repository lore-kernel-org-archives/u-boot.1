Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A51C47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBD0587E58;
	Tue, 23 Jan 2024 18:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ihH6BA81";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D305187D63; Tue, 23 Jan 2024 18:17:12 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3299387D6B
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a26f73732c5so504138666b.3
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706030227; x=1706635027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bA8dIPyuevVt49I0mtLgTHbxtNgE3Zzcp8vc5MXLjDA=;
 b=ihH6BA81rrLre0hBVVS22cmhhqg+D2DncIRejYYALbM5z1D5B1fptVZHz+y0wv++fn
 fG8lRoG756dDlnyeNLPg86I8zYUtGHpdJ1/v84ql5q17GgQMLw3XVefKNHvH5TV06Jl5
 /k2gzkj311T+VN3OBbSMQ+WiJewr31pi00S1i3A/bsoOJeZnVjALPILvRJnpjOPUOvxV
 ppwgQDAjL2xicRhA2pBWTcVzrZZhgF+Y2MmIit55GbltE53WPAwT74SepdqTiZp2eD99
 m/myBEfrx35bl6LVypefBOmjvxkzFmkj/m6/ahx1OsmV7tXeAIfWlNQBLoevIjMx3BiC
 7cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706030227; x=1706635027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bA8dIPyuevVt49I0mtLgTHbxtNgE3Zzcp8vc5MXLjDA=;
 b=mcKfsGkn+Jm+3qUUzZARUA5J+YzTN064QXuORg/L+f8ECjEsDHwgFwNvH/8afFyGhk
 WzJGqM5C0M0RvnhiTvJipGQpKq2JsruW/t+8zmnIzcnY3UcRuIrJYd6hHZHkAg6ZS3tr
 4AE3e5uQG8Z6pZfUbYi/fQhAgYjsAzSV1Mo5Y6o/iorrJlomdxoc5w7PNJzKOsiOnrOt
 add7nnZvndiQuIDydoCStMqJH7+MNK/b3cbbXdx16OaDu+CTB3Ykjoch4KJ7yU1riT0o
 ndJYCaWUHyAHCR2hwuwx3qoma7D9WSuW7brvvEj09iDAhkNoMEhtAXWvYFBEgFZP5XIQ
 XC9g==
X-Gm-Message-State: AOJu0Yy1od8eP4Rb9wmb2bc8Ef1ghXfFVvlhipF+W0ymYBjN/Tzyv6o1
 dx+WoVNFxMReAN9U7NKexAHVfzkm1TIzNro3Q2WO4Vdl8aa6VR+x
X-Google-Smtp-Source: AGHT+IHtHANZCCEDeKFDv6jJP/r98NeTINiryga0s8ihc69X8CPZJxOHH4R0lvMQDNGNF4VvrG0VSg==
X-Received: by 2002:a17:907:9843:b0:a30:e893:4a35 with SMTP id
 jj3-20020a170907984300b00a30e8934a35mr73340ejc.155.1706030227696; 
 Tue, 23 Jan 2024 09:17:07 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 m27-20020a1709060d9b00b00a2c7d34157asm14269068eji.180.2024.01.23.09.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:17:07 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 05/18] video: tegra20: dc: add PLLD2 parent support
Date: Tue, 23 Jan 2024 19:16:20 +0200
Message-Id: <20240123171633.246057-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123171633.246057-1-clamor95@gmail.com>
References: <20240123171633.246057-1-clamor95@gmail.com>
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

