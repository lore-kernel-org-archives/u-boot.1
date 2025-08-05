Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C087EC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 09:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D054A83642;
	Tue,  5 Aug 2025 11:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bbD4L9Ju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A16883642; Tue,  5 Aug 2025 11:20:18 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFB5F81D5D
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 11:20:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-76bddb92dc1so4866459b3a.0
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 02:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754385614; x=1754990414; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYaNIgFjhqLUR08t4P6UZWbqIfNOJVFw0/T0NjKlFWk=;
 b=bbD4L9JuiuEloRyaNPs6szn4s3C9EPK9diYWyIs9rrB6Xc5rLGpb8dK0RnMYD9vRlp
 RB9TOV3Hhkbmq6tMZHT1+0IBrobMQdImhXjA+VAp6ZcMl9Ep/92ID7zB3QvEgpNWYeHi
 c6uQ5OaBY7hbeOyU48HWJzvfFfg9WtevRq8wTqBk6zGZfK1h3D7tFHYRk9vnzNVgnlLs
 mfCFaVMniVAqEtDTTZtLa1ycGiax2AMdtioGkNGet+4d3MQtHtQSnzseUdPZkOkIK1gD
 QNjGlRDjF5KFKwAPcNQCe5i3D15+/tPXxcmSJcETtaj5hgb05mzdKXXEBm62KbNmORcg
 Bunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754385614; x=1754990414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pYaNIgFjhqLUR08t4P6UZWbqIfNOJVFw0/T0NjKlFWk=;
 b=kSLSJjDlpskbIxnT3Iq9UTMTJdsC/aHIbwmLTYjD70Sd32BUAutSL9ODZ76Qe+OgYc
 kFWsCOUfHbuakfKXeglp6ozW0TOsN1xGky7+/e8DIvtkrAH9gfgdSg2bfZRddotBY6XB
 iTViaYUc/dQ3fhQsVzy2hRZ7cPI1x6fFQzK3UzO0WFJX/BBF8yqY0Dn2Le/AAXYY1z7i
 12vX2VL3q1kjZmE2vd6EzFLhfHilssLp73kv412iwVPsfKF65JiWs/PN0LkoiewFwfqF
 G/JX7ola1o9XCHpj4C+IdIeK8iKu31pXx7FDC3QFIgbI1OnH30E74Z3zrJNatO6XHXOc
 4ytA==
X-Gm-Message-State: AOJu0YyDD/7Pio7sqXB6GGwWCWogTTmEpFnX/GBsMK3WfnnaCKjs9ncp
 X7xa3pYv3Pa0+MtwK+3q/vn2iViFJrSMYExy2AbZqvWNJEAT/lwgS73B
X-Gm-Gg: ASbGncsFQ3jiEv1XBooNEdN9WJ+He8jkGF6MvaOz8PMMrfKkRhX38x4OKj5CYot/nNo
 fcE/qDXsZco0MmMDPTlVLxx+mIZZv862T5hsJDfJxFMbX4aQRMA28Y0W04PWv/J08ToevNu6+Tl
 273SPCuRURRoWjNCtEbw2FU+154N7f0BdNQHLwhUA+kQVTketF/BGBhRVs+L7pwLh7yqgEGSGRc
 I6DqE973All5C+Qp2XhKavBrjFef7nr0JIJWWU1eGVYtYguRL+JZ8hsvT7vQLSuxO0CYfya+5Fr
 Zd1KRBqdYQ2hmOj5bPbBKTvgY6jtAZymI/Phoefacov/SIHOk155mpov8MaH4Hrt1tqVrBz6vx9
 gH4zkLa5f1YO4ZTtyMALy6B2IuUz/OVXvEw==
X-Google-Smtp-Source: AGHT+IEokeDCQy1am4iNwTXNqI1LesniFECiuea40ETY5jj1JSO+wMzm8muTaf+SXLqSM/HXeeticw==
X-Received: by 2002:a05:6a20:7d86:b0:23d:45b2:8e21 with SMTP id
 adf61e73a8af0-23df91328b9mr17864322637.37.1754385614421; 
 Tue, 05 Aug 2025 02:20:14 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce89125sm12495185b3a.33.2025.08.05.02.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 02:20:13 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, YSCHU@nuvoton.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v1 8/9] misc: npcm_host_intf: Disable pending KCS/BPC
 interrupts
Date: Tue,  5 Aug 2025 17:18:49 +0800
Message-Id: <20250805091850.2051096-9-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805091850.2051096-1-JJLIU0@nuvoton.com>
References: <20250805091850.2051096-1-JJLIU0@nuvoton.com>
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

If there is an unhandled KCS/BPC pending interrupt after reboot,
the KCS/BPC Linux driver may trigger interrupts immediately upon
registering the irq. However, since the driver is not yet initialized
to handle them, this can lead to unexpected behavior.

To prevent this, disable KCS/BPC interrupts in u-boot to avoid pending
interrupts from being raised before the Linux driver is fully initialized.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 arch/arm/dts/nuvoton-common-npcm8xx.dtsi |  2 +-
 drivers/misc/npcm_host_intf.c            | 21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/nuvoton-common-npcm8xx.dtsi b/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
index be06b2a0cae..6866005336f 100644
--- a/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
+++ b/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
@@ -141,7 +141,7 @@
 
 			host_intf: host_intf@9f000 {
 				compatible = "nuvoton,npcm845-host-intf";
-				reg = <0x9f000 0x1000>;
+				reg = <0x9f000 0x1000>, <0x7000 0x40>;
 				type = "espi";
 				ioaddr = <0x4e>;
 				channel-support = <0xf>;
diff --git a/drivers/misc/npcm_host_intf.c b/drivers/misc/npcm_host_intf.c
index 2c89bd7a167..e3b0663625b 100644
--- a/drivers/misc/npcm_host_intf.c
+++ b/drivers/misc/npcm_host_intf.c
@@ -45,10 +45,20 @@
 #define ESPI_TEN_ENABLE		0x55
 #define ESPI_TEN_DISABLE	0
 
+/* KCS/BPC interrupt control */
+#define BPCFEN			0x46
+#define FRIE			BIT(3)
+#define HRIE			BIT(4)
+#define KCS1CTL			0x18
+#define KCS2CTL			0x2a
+#define KCS3CTL			0x3c
+#define IBFIE			BIT(0)
+#define OBEIE			BIT(1)
+
 static int npcm_host_intf_bind(struct udevice *dev)
 {
 	struct regmap *syscon;
-	void __iomem *base;
+	void __iomem *base, *kcs_base;
 	u32 ch_supp, val;
 	u32 ioaddr;
 	const char *type;
@@ -104,6 +114,15 @@ static int npcm_host_intf_bind(struct udevice *dev)
 	/* Release host wait */
 	setbits_8(SMC_CTL_REG_ADDR, SMC_CTL_HOSTWAIT);
 
+	kcs_base = dev_read_addr_index_ptr(dev, 1);
+	if (kcs_base) {
+		/* Disable KCS/BPC interrupts */
+		clrbits_8(kcs_base + BPCFEN, FRIE | HRIE);
+		clrbits_8(kcs_base + KCS1CTL, IBFIE | OBEIE);
+		clrbits_8(kcs_base + KCS2CTL, IBFIE | OBEIE);
+		clrbits_8(kcs_base + KCS3CTL, IBFIE | OBEIE);
+	}
+
 	return 0;
 }
 
-- 
2.34.1

