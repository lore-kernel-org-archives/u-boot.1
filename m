Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F06C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1054C88548;
	Mon, 24 Jun 2024 23:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F5tBWN82";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23E818852D; Mon, 24 Jun 2024 23:04:38 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C26E188568
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-424720e73e0so42678465e9.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719263075; x=1719867875; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SgKyKJvRxrzHLDzZymGyPACBzjoYAUijZTCxAgiEaAs=;
 b=F5tBWN823vlbSIepcZcdKXUA6gwmVnXjKfc5ILHcjxeXBrYG5HemZt8aC03BAeDqir
 X4EhJ5T2RcaGW8VnPkxLi+ET/y+rEtfJ/O2Oo1UdfNVFbz/XbOvAp9pDFKGIS186/Np2
 HgjedvW4JfQuUhTz3OamTPHVIoYVCO1eK+57w8oeFxKyhHSMEj9LQo5rgLeHxFPGXNxY
 JRZhIP9k+MocTv6bWYnDbUnUxGfV+KbihQPeVa5v7zRQ03u8Js0q1oN1TS7sSUgJkA0J
 QjNuc+HMKNUzVwVfRdVOxJDHkcDlplvaxXxH+LjLjkqlortpJSEtDvo9InyiSKpCiuXW
 XR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719263075; x=1719867875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SgKyKJvRxrzHLDzZymGyPACBzjoYAUijZTCxAgiEaAs=;
 b=kl8JbiERdfEoiBKlILdzrBVmTJPCLe65juJ6MVEyiLlmoSxI4d2TKWWFhzwkv4d6Kn
 sFX0OV9cZfffmYRx5aEqG+/UiM0cgk2lSMk57Elz1q/SCcQOzhtw5AklKgSQQ4mzXPNC
 mYPhxIGD8yHHo7qqb/gcqQhbB65SdYy5zQ3FdodS53VA9bJgL+w6rfRvTJHTu/2btqbt
 uO/8Af8BbEc0c9QoWf6eXYTg9jaeMHozCIT1a5G6XIKv9wEBEozqaActZkRM9vrfVEia
 C+RdvBrOtU3Py2glmdhimsafuXYbFanCs5dyPgxgVpaYCj8yiZm/JvE0cOxxUzoys6PG
 6qTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhxGMQ1bKQ3q11ypVmpA5i6MlaMF++Y5pST+zk9de4s7uDOC1T7Ewma2siHtyCbXDfZGeS8D7rPeRGpmu/6uqzFjkffQ==
X-Gm-Message-State: AOJu0YxbHoithhMPMlYAqGmSW4k/ATEm1GMOrB2yjQZ/KvZcsANFBdVI
 uTLQQxYJ6uzQGpdXZBXhyP4xGXUHeXuXbxkOgJ5tHt4YLI9eJxHY
X-Google-Smtp-Source: AGHT+IFeCrlvSZy0jOJtK/w2tBHmubLkEUZOebIpB6Forzf7s7No+7ZXfFrl1Y5qglrE2EPhLeihGw==
X-Received: by 2002:a5d:4712:0:b0:35f:1128:2514 with SMTP id
 ffacd0b85a97d-366e7a0fc96mr3631284f8f.32.1719263075268; 
 Mon, 24 Jun 2024 14:04:35 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3664178f5f7sm10968228f8f.19.2024.06.24.14.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:04:34 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, John Crispin <john@phrozen.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sergei Antonov <saproj@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Marek Vasut <marex@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH v4 06/14] serial: mediatek: add support for bus clock and
 enable it
Date: Mon, 24 Jun 2024 23:03:32 +0200
Message-ID: <20240624210418.19324-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624210418.19324-1-ansuelsmth@gmail.com>
References: <20240624210418.19324-1-ansuelsmth@gmail.com>
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

Upstream linux also provide the additional optional bus clock.

Add support for it and also enable the baud and bus clock on probe.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/serial/serial_mtk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
index 3f569c68f22..78e8d9dc735 100644
--- a/drivers/serial/serial_mtk.c
+++ b/drivers/serial/serial_mtk.c
@@ -76,6 +76,7 @@ struct mtk_serial_regs {
  *				driver
  * @regs:			Register base of the serial port
  * @clk:			The baud clock device
+ * @clk_bus:			The bus clock device
  * @fixed_clk_rate:		Fallback fixed baud clock rate if baud clock
  *				device is not specified
  * @force_highspeed:		Force using high-speed mode
@@ -83,6 +84,7 @@ struct mtk_serial_regs {
 struct mtk_serial_priv {
 	struct mtk_serial_regs __iomem *regs;
 	struct clk clk;
+	struct clk clk_bus;
 	u32 fixed_clk_rate;
 	bool force_highspeed;
 };
@@ -220,6 +222,10 @@ static int mtk_serial_probe(struct udevice *dev)
 	writel(UART_MCRVAL, &priv->regs->mcr);
 	writel(UART_FCRVAL, &priv->regs->fcr);
 
+	clk_enable(&priv->clk);
+	if (priv->clk_bus.dev)
+		clk_enable(&priv->clk_bus);
+
 	return 0;
 }
 
@@ -250,6 +256,8 @@ static int mtk_serial_of_to_plat(struct udevice *dev)
 		}
 	}
 
+	clk_get_by_name(dev, "bus", &priv->clk_bus);
+
 	priv->force_highspeed = dev_read_bool(dev, "mediatek,force-highspeed");
 
 	return 0;
-- 
2.45.1

