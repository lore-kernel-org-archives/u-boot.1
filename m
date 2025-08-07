Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8473C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 05:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58B73843E4;
	Thu,  7 Aug 2025 07:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AaxaZ3VS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F3C1843E4; Thu,  7 Aug 2025 07:33:04 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B97F783C08
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 07:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-31ecd1f0e71so781737a91.3
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 22:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754544780; x=1755149580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYaNIgFjhqLUR08t4P6UZWbqIfNOJVFw0/T0NjKlFWk=;
 b=AaxaZ3VSjYyAx69MGNlDKZTqRhn1Ks8mCd7GvF4QTAwZLsUw8ONOIRnFSpmdDGR7go
 rNh59WBi7oYOmqv+VQtJE+XQxZFCvOdqH9tUIzMHvZ5KLxa65wvIijWlqJeUQJ+WYMKa
 9M/k4JMb+Bkvtgg0TiTubgUI9lfnqNQtkMGKOCg4YcMbVMxYtR1LFA7UIlf7WoWe6RrS
 XN1Jm/6X9lz9aSHY7ziAWswcifY7VuiKVnIg/g0LMRy4JOj5icfEskAmke+pVaGUrm8q
 xJBorBithGwgI55lvGFsa9eYvPmYwll9uF8OvZlGrFbdz+oTF1UdTYOZM5Um/rz7eGVw
 UcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754544780; x=1755149580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pYaNIgFjhqLUR08t4P6UZWbqIfNOJVFw0/T0NjKlFWk=;
 b=OL2FctV0RN6htSXaQiMD5xaBEOMK/npMaxQesmMuz9pb4MvdDr3SCR77YJ2PvSLh0P
 mkX5UtIlmceZQQr5Xj/WDgufqk/Vm9AbyPdvASYRsFld3eGJWBAXqF303XUOLQWHj1J9
 55DFVC3njBYp+7N4Y4iXS9K3/i8vp/tpe+bBSPiuPKfoAyyd5HV23ZxeC7kRVSFsCwWq
 Vz+2ctvHA7VxYtocX1d28hx5OV1Nqh16EguqKKDgDAEYMflB7fg1+kGQbAjlJ+6hn9g8
 XqDbYjXTqWUQx9d9jylsSslfHUHWM3mdotj4qcZqUWyItSGmEXFvy+HPcduWYiv1ZK4n
 jcag==
X-Gm-Message-State: AOJu0YzTG/vOLWR+xnchzdCJIpYm7RpqnWS+3+K4XCtSlEJKsnxFMXkU
 KxhTIfVqDQBNORLnq2fGRhUkm67E9zPRGYyo6DNPZ5BcOYZINUNClrku
X-Gm-Gg: ASbGnct//5LxlB0q5hTcvTT7RiPeUFCKiH9R0iglwwMHCLoF1lAJeNqqK7y6oCaxiiY
 ZbT/QqiD4U7h14Jk49JKtefKeGFxDqjE3JsVn7PWK981calqhdZyznzp7D2VadjiTatg2SnlPiA
 fpry2lz1O4b8JaEjPl8lPZ7eE4fLxnidqwUsLF7joLmNuLmBNlVT6CzOu8DWvQgk3fQ39Noreb7
 egBlcpPlcZdeFWhmtSmSsdQ4jI1T4QtUHzlNodyh8h1ZdzMBoXz1YG/a3OAwpkWR04U34eWxTwJ
 LpbGjyxe8dOVoRF7b8J+KanFT4EN1RbOwEzDs46xTuXJD5U0SQLu1E9oqhsiKFV2N1qDvL8hTcn
 xy8IONzO1fs82JmblU+nUao4FKiOR9VeAZw==
X-Google-Smtp-Source: AGHT+IF7xj0JSJiUixAkU4Xo3vmTeWapC6GBWEbdRysWNGZIeAHBBIFs0aQzg05gaGwFC/XLE0B5cQ==
X-Received: by 2002:a17:90b:278e:b0:321:2407:3cec with SMTP id
 98e67ed59e1d1-3216754f6d6mr7819199a91.16.1754544780201; 
 Wed, 06 Aug 2025 22:33:00 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3216126c98fsm4384084a91.21.2025.08.06.22.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 22:32:59 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 YSCHU@nuvoton.com
Cc: u-boot@lists.denx.de,
	Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v2 6/7] misc: npcm_host_intf: Disable pending KCS/BPC
 interrupts
Date: Thu,  7 Aug 2025 13:32:23 +0800
Message-Id: <20250807053224.2169557-7-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807053224.2169557-1-JJLIU0@nuvoton.com>
References: <20250807053224.2169557-1-JJLIU0@nuvoton.com>
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

