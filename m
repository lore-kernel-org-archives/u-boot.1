Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC48C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 13:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 118B682BBF;
	Thu, 15 May 2025 15:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="F9r7ZunJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B3AE82B54; Thu, 15 May 2025 15:12:57 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 687EF82BA1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 15:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a0b308856fso526246f8f.2
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 06:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747314775; x=1747919575;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0PUck3BMWPfWUBq2621uRDOXcGLVjyN47c/ykxnPHc=;
 b=F9r7ZunJUfqSThWpIEwLKWX9dVvSZkvp010XbYAnhVU3TexO9odyYUZ60tZlsEFJWU
 h3BwdJ5NnE70w7e5x6RJKYpBJF+fHEzDb1L0ifZSMqJNLmYmtt4zIvC2vOzQbCNz0KzL
 Sd67x5UgGoQlb0sofWNawJ/eQMLNARjKg45to=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747314775; x=1747919575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g0PUck3BMWPfWUBq2621uRDOXcGLVjyN47c/ykxnPHc=;
 b=pcfYH2lkfDJhF2j1F9A1uu5ORfcm0BSGlm4clPaWfwALXGSiiE77vbbsHduS+r86cb
 Kz4vz1erPP3+DGjgwIZQDxuo0DOxiuQk9hHmdrpBWXXgCYaGRax+FXUiqWbOR2WzG3kT
 U6e+oCMemJbGJvh61pA8eFca8WRHSftkjA3hpW+a67rNW//bi7O/AUYE/cqDZ3cACueH
 W1/WfS2SAnJeCGLRbLGsevhpy145EmKID2oFmqwyBuTPeCvS9RN4q4i7YS4C/qYynO6n
 Rz5u8yxkJ03+QbULZ6i+NorWp7ucRogDpJTmbp9p4aKVIj/5xEodrVdSwZUI1vJS/nnr
 GWjA==
X-Gm-Message-State: AOJu0YzYyQvYwWmYwU3KfT2Pz9wiyNvYH4MQTWCKT7UpZfNQqsMUx4Ov
 XsStWt0eZ72Sy2YCTJdYAvQCRSTHIf34dzFgmilPHmxpUvS1kCv+xtyoiBiaXdxuHgbZ7Gaz7Hp
 8QEqAEA==
X-Gm-Gg: ASbGncvxbanx+hwhaQqrQr9+M/NHDZRR2yOPbCqZsOTCB4n+UaK/RRLjd24mfwig9Yh
 PidKvv3lfQUmBXl6X5GkmnUJZYpUzhbcnjdwT8vMJ1ChXt8FxY/IwvD98NIwraJE5WYKiH0Jqth
 genPr2Db3cMxoUUibrgBZO8iBRnXO8zktQfGzuUVe5DE/jOjEKybBvDeB0Vga2dKRfar+Qjf6ub
 RsiYhtcCYYEwVYtNBqeLC9IwFSiyoQcL2zkMtfivwLUG53ej7KB92TKre0GFV4ZJ33NKNUwvgj+
 s1K3jbYvTQrIWnkJkaWlR1OFbbjIOsZuFM6pbiPJQT8I0YWnlwMuXI/hYqcQ7J2V3Oih5YMoDpU
 01k/5PhQHhiAuMA2QidZR2QHw7HP12eWzJOsmHeqxyvM=
X-Google-Smtp-Source: AGHT+IEsTQfT4QYcBgmJNIzvKjapul2G7jSh+slwPoCQnf9iBJNh0Of0FpVSDwjcmY2LynFccbaF3w==
X-Received: by 2002:a05:6000:430d:b0:3a3:40d2:8499 with SMTP id
 ffacd0b85a97d-3a3499516dbmr5987824f8f.58.1747314774653; 
 Thu, 15 May 2025 06:12:54 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.client.m3-hotspots.de
 ([46.189.28.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39ef811sm65516825e9.35.2025.05.15.06.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 06:12:54 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 3/3] serial: mxc: restore booting for imx8mn_bsh_smm_s2
Date: Thu, 15 May 2025 15:12:42 +0200
Message-ID: <20250515131246.784206-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515131246.784206-1-dario.binacchi@amarulasolutions.com>
References: <20250515131246.784206-1-dario.binacchi@amarulasolutions.com>
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

The commit dda454e933c6 ("serial: mxc: Support bulk enabling clocks")
breaks the booting of the BSH SMM S2 board.
Restore proper booting of the board even in case of failure of either
clk_get_bulk() or clk_enable_bulk().

Fixes: dda454e933c6 ("serial: mxc: Support bulk enabling clocks")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/serial/serial_mxc.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/serial/serial_mxc.c b/drivers/serial/serial_mxc.c
index 28f4435d01dd..b09a5fe0f7a4 100644
--- a/drivers/serial/serial_mxc.c
+++ b/drivers/serial/serial_mxc.c
@@ -310,22 +310,31 @@ int mxc_serial_setbrg(struct udevice *dev, int baudrate)
 	return 0;
 }
 
-static int mxc_serial_probe(struct udevice *dev)
+#if CONFIG_IS_ENABLED(CLK_CCF)
+static void mxc_serial_enable_clk_bulk(struct udevice *dev)
 {
 	struct mxc_serial_plat *plat = dev_get_plat(dev);
-#if CONFIG_IS_ENABLED(CLK_CCF)
 	int ret;
 
 	ret = clk_get_bulk(dev, &plat->clks);
 	if (ret)
-		return ret;
+		return;
 
-	ret = clk_enable_bulk(&plat->clks);
-	if (ret)
-		return ret;
+	clk_enable_bulk(&plat->clks);
+}
+#else
+static mxc_serial_enable_clk_bulk(struct udevice *dev)
+{
+}
 #endif
-	_mxc_serial_init(plat->reg, plat->use_dte);
 
+static int mxc_serial_probe(struct udevice *dev)
+{
+	struct mxc_serial_plat *plat = dev_get_plat(dev);
+
+	mxc_serial_enable_clk_bulk(dev);
+
+	_mxc_serial_init(plat->reg, plat->use_dte);
 	return 0;
 }
 
-- 
2.43.0

