Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098B7C83F17
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 21:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8492836D1;
	Thu, 10 Jul 2025 23:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=yngvason.is header.i=@yngvason.is header.b="VZrcUtbt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF40D82AFC; Thu, 10 Jul 2025 19:32:03 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2F4F83653
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 19:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=yngvason.is
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andri@yngvason.is
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so783641f8f.0
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 10:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yngvason.is; s=google; t=1752168720; x=1752773520; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=12rNqt+SU6rZyivdY+m6w7uy0C8Lf7hknOS0lg4ux68=;
 b=VZrcUtbtnNofOdY64tdkCyhZxDZuS0/eeqNl6tVuY1iKQ612EztXZUg1YcbwMEdbJS
 9fLK5oPwta5Piz4ah9otVMZ9aOUSTsN6h3RMzwu2ie/vfthldjPQFeTJdNY1krajvqg8
 WLBTKZQ1loLkX49yhjb+W2WPaLoFZxpzLjVi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752168720; x=1752773520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=12rNqt+SU6rZyivdY+m6w7uy0C8Lf7hknOS0lg4ux68=;
 b=Vc+oJB1PL/5olpFC9z31lySxSOW4zUPYTrdT4B1/XB5Ssp6eoMf4SxYhbCIjFOyXlJ
 EEjFJCHkHpP1LA9fxkjC63AKVdoW/xI4t5dLxG/HtF2CVxVQYMfdIS09NElzoB/+DgzE
 RGMscGJdFb/Txc7q7YXTbKPnoJ/u95d9eYFkmn0ta2ycl7rAfyadOOuv5piIMECxFnxX
 Md4Tn8NT2sh737+OFup9ERPDys+1aqT8y8tV+8nDLKIGNm4kYLirlzbmmog+YLLlR72f
 VTnfI7OyPrSjSras+B3kQDjjM4lnJ+HsNHvXTiJwkVg4iHphrLSsk8fMpM3daudVbK5s
 haWQ==
X-Gm-Message-State: AOJu0Yz6rj9qo3TcYiDyj7pow5TbiO8bLj/ZmOXuL6j2ZqazzlUy9irB
 ZAR1QED+88gFyxeVB9hrgjd4/3ImPyX+OQ6PZ2aIzvP8fkGsKyRJJVuohk5VorTz4vAeTWwD1Py
 f0Z2azpVuQg==
X-Gm-Gg: ASbGncvXDx9r6/SGGTMBBeDQQ38+E8uIoB03yb5C8LboMZ5vCYwTcSYHCdMXLnySYSm
 TGfS4QNVEVEFtZjY5Fp2lQFQQbYWXSfH56tt3+rFBf3mwFlKIXAiBz8LBE7d7ppKY1sYfwFHVtP
 jGjbjfdItcIZufaI3FhGmCApiv/HmY9RBxF3BfqAKHGsZMs+YN+DZFoj6z+UjZZ6nBYokzdTtc6
 RKovL2srPXXZ63DhB5CwwPi7qSZwQ90vVEsfGhs+U3mWintDlRAaUE08tPhuauLEHFFZ4YB+5w/
 SQ07+Gr/ywc21vaCDIOAvumLRMwggmXn4Obt7EhE0wHU1OzJYr5vL6/s8t1Vkl6IgdAQQf5ucpq
 VBKY9uPfjNb8hAU/epXy8/v6tttDMNEM1OA==
X-Google-Smtp-Source: AGHT+IHa2b95chviNJ7CAtgpV4KgF66unOQlW0tfe3aNvYa2lQStE1kOPfWvi3XJIPKThzHCMJl+sg==
X-Received: by 2002:a05:6000:2711:b0:3a5:8a68:b81b with SMTP id
 ffacd0b85a97d-3b5f18e2906mr234364f8f.44.1752168720138; 
 Thu, 10 Jul 2025 10:32:00 -0700 (PDT)
Received: from andri-workstation.turninn.appdynamic.com
 ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d732sm2442227f8f.52.2025.07.10.10.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 10:31:59 -0700 (PDT)
From: Andri Yngvason <andri@yngvason.is>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Andri Yngvason <andri@yngvason.is>
Subject: [PATCH 2/3] phy: rockchip: usbdp: Add rk3576 config
Date: Thu, 10 Jul 2025 17:31:53 +0000
Message-ID: <20250710173154.1244430-2-andri@yngvason.is>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710173154.1244430-1-andri@yngvason.is>
References: <20250710173154.1244430-1-andri@yngvason.is>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Jul 2025 23:56:14 +0200
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

Signed-off-by: Andri Yngvason <andri@yngvason.is>
---
 drivers/phy/rockchip/phy-rockchip-usbdp.c | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index 9deec47ae46..17e8fb65552 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -813,6 +813,28 @@ static const char * const rk3588_udphy_rst_l[] = {
 	"init", "cmn", "lane", "pcs_apb", "pma_apb"
 };
 
+static const struct rockchip_udphy_cfg rk3576_udphy_cfgs = {
+	.num_phys = 1,
+	.phy_ids = {
+		0x2b010000,
+	},
+	.num_rsts = ARRAY_SIZE(rk3588_udphy_rst_l),
+	.rst_list = rk3588_udphy_rst_l,
+	.grfcfg	= {
+		/* u2phy-grf */
+		.bvalid_phy_con		= { 0x0010, 1, 0, 0x2, 0x3 },
+		.bvalid_grf_con		= { 0x0000, 15, 14, 0x1, 0x3 },
+
+		/* usb-grf */
+		.usb3otg0_cfg		= { 0x0030, 15, 0, 0x1100, 0x0188 },
+
+		/* usbdpphy-grf */
+		.low_pwrn		= { 0x0004, 13, 13, 0, 1 },
+		.rx_lfps		= { 0x0004, 14, 14, 0, 1 },
+	},
+	.combophy_init = rk3588_udphy_init,
+};
+
 static const struct rockchip_udphy_cfg rk3588_udphy_cfgs = {
 	.num_phys = 2,
 	.phy_ids = {
@@ -842,6 +864,10 @@ static const struct udevice_id rockchip_udphy_dt_match[] = {
 		.compatible = "rockchip,rk3588-usbdp-phy",
 		.data = (ulong)&rk3588_udphy_cfgs
 	},
+	{
+		.compatible = "rockchip,rk3576-usbdp-phy",
+		.data = (ulong)&rk3576_udphy_cfgs
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.50.0

