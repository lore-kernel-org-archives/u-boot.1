Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2A1C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 08:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB31C8447D;
	Thu,  7 Aug 2025 10:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FNZbvdXx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 367B083AD5; Thu,  7 Aug 2025 09:45:50 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08E5583A43
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 09:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cn.liweihao@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-31f017262d9so677952a91.1
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 00:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754552746; x=1755157546; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+OyTk/e+om99idGPZKx1NhK5aHSLhItFAJAbscflYoU=;
 b=FNZbvdXxXk5CNzshflbgCURN+dNlmY/AsJubkSslbVfCrdfQnY8IO8u/D+bNWwpAq5
 NOGuj5KcuJ8MFZ4yCjynTci4FEQrrWvg7mwc7qIp15ArKHucpdXXllrUrgzIf6xD9D0w
 tcl1O9v4Bxe78KoKcSew+ghZK2XFEFNuxpEKiGfCdCg1qYDAAAhxz8EmbXrMdsd80qcU
 jd6CegdZQDF67enJNMB7WCgkB5BVtKloVbgBraLrNHbWsjcQYl3c+bgYs3rcKAvVVhrF
 7nb5JL6ebLrIlmgdtBpFzL1omqc/Wzx+I1Q0awRg9CBAuVzyWVmZbV/N+0f7tzwLxm3A
 a+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754552746; x=1755157546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+OyTk/e+om99idGPZKx1NhK5aHSLhItFAJAbscflYoU=;
 b=YooR+/OsrV9xeTkyDrcxADm9uuq4zvlxpPHtcjZY/3O4Qos6wEg5ZNagONx1HoTt1Z
 Ikl54++W7rv1KM7l4rlkmmjVONq8hjmoDnWgDW+8YGkuMsDMyRbLAsVO1l46zR05tyDq
 b0prCwIYn1Y8MIiZBwOFLRZm3grGNbt3wjmeo9FmBPdmNWF80f4F7f5TlthfG1WA5ItM
 e8HbQk6No8MPF3Lw/AAdBnMw/C7N7cKm699H/yYEp6UDinPCjbxM1uwt1bXErDzE+4Kj
 KEp5AY9y28/eIhujF3DMLANUrLBwrVghuuER87XuJPg+sD3he2lwIvQLlz9v3cLnY07i
 BRgw==
X-Gm-Message-State: AOJu0YyTEXla6Q5p9DHKGxD4jZm6D0xBbmnsOBh2Ijg2OL7vWc6VkcpL
 mOaVZBlQmQnHXMB0MW9/vJTn+1hxSqArQUD+jGUhtNdR/uss8Nhs3HEul8zmfV3s
X-Gm-Gg: ASbGncuJZHu02CMCLMGN9/D937ukpqPxUWP5R1ahGpmkg6cED2sJ3HebYNdAXhMUMX8
 Fi+xUitD59Uep0Sk3G++zlCBFrjcYe9u0MbNxclNe3ttLpoLdGeJ9HtR6oZIgAZgHBILKW7YhKT
 i1msPrFUMUU+0Z7K9LIFnoKMEn1pNT/jTkgRHMeehiP8Ufatkifr+9q9FVrrw7ZdXVbytXjdzgf
 NBq54a4JjJ1YmhXmzNWM+QrEYNi2hvCm6R3YMqtW1wF9zoE5cvRJx1lS8VWqlqah+5CHEtxMns3
 W3rPI+w+tY8C9+WvN45+47mbl+EKBzC9dwP83k0i57WhSRYaCEIFdL4K5PoKzNvRmR1TubwIKvH
 Pwn22DLtOFLgGb5liLQYCOOmnx0xzRGBG5ZJ4
X-Google-Smtp-Source: AGHT+IFc+Eq1zcn2NVTZoTMYkCWyYS/9WI8AGY91aa+7UjdpYBVKLYnoEIa1FH64aJSX1oJ4wCC5ZA==
X-Received: by 2002:a17:90b:5284:b0:320:ff84:ceb5 with SMTP id
 98e67ed59e1d1-32166ca7c61mr9111568a91.16.1754552745797; 
 Thu, 07 Aug 2025 00:45:45 -0700 (PDT)
Received: from localhost.localdomain ([218.90.41.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-320f4909b8bsm16809202a91.16.2025.08.07.00.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 00:45:45 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: u-boot@lists.denx.de
Cc: antonio.borneo@foss.st.com, mk7.kang@samsung.com,
 gregkh@linuxfoundation.org, semen.protsenko@linaro.org,
 mikhail.kshevetskiy@iopsys.eu, bb@ti.com, justin.swartz@risingedge.co.za,
 lukasz.czechowski@thaumatec.com, robh@kernel.org, tharvey@gateworks.com,
 clement.legoffic@foss.st.com, marek.vasut@mailbox.org,
 dinesh.maniyam@altera.com, patrice.chotard@foss.st.com, festevam@gmail.com,
 jerome.forissier@linaro.org, quentin.schulz@cherry.de,
 andrew.goodbody@linaro.org, sumit.garg@kernel.org, ag.dev.uboot@gmail.com,
 rfried.dev@gmail.com, joe.hershberger@ni.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, seanga2@gmail.com, lukma@denx.de,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 trini@konsulko.com, WeiHao Li <cn.liweihao@gmail.com>,
 WeiHao Li <ieiao@outlook.com>
Subject: [PATCH 03/10] net: rockchip: rk3368: add set_to_rmii
Date: Thu,  7 Aug 2025 15:44:11 +0800
Message-Id: <20250807074419.336752-4-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807074419.336752-1-cn.liweihao@gmail.com>
References: <20250807074419.336752-1-cn.liweihao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 Aug 2025 10:26:22 +0200
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

Signed-off-by: WeiHao Li <ieiao@outlook.com>
---
 drivers/net/gmac_rockchip.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
index c8cfe7448d..1977853e75 100644
--- a/drivers/net/gmac_rockchip.c
+++ b/drivers/net/gmac_rockchip.c
@@ -552,6 +552,22 @@ static void rk3368_gmac_set_to_rgmii(struct gmac_rockchip_plat *pdata)
 		     pdata->tx_delay << RK3368_CLK_TX_DL_CFG_GMAC_SHIFT);
 }
 
+static void rk3368_gmac_set_to_rmii(struct gmac_rockchip_plat *pdata)
+{
+	struct rk3368_grf *grf;
+	enum {
+		RK3368_GMAC_PHY_INTF_SEL_RMII = 1 << 11,
+		RK3368_GMAC_PHY_INTF_SEL_MASK = GENMASK(11, 9),
+		RK3368_RMII_MODE_MASK  = BIT(6),
+		RK3368_RMII_MODE       = BIT(6),
+	};
+
+	grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
+	rk_clrsetreg(&grf->soc_con15,
+		     RK3368_RMII_MODE_MASK | RK3368_GMAC_PHY_INTF_SEL_MASK,
+		     RK3368_RMII_MODE | RK3368_GMAC_PHY_INTF_SEL_RMII);
+}
+
 static void rk3399_gmac_set_to_rgmii(struct gmac_rockchip_plat *pdata)
 {
 	struct rk3399_grf_regs *grf;
@@ -755,6 +771,7 @@ const struct rk_gmac_ops rk3328_gmac_ops = {
 const struct rk_gmac_ops rk3368_gmac_ops = {
 	.fix_mac_speed = rk3368_gmac_fix_mac_speed,
 	.set_to_rgmii = rk3368_gmac_set_to_rgmii,
+	.set_to_rmii = rk3368_gmac_set_to_rmii,
 };
 
 const struct rk_gmac_ops rk3399_gmac_ops = {
-- 
2.39.5

