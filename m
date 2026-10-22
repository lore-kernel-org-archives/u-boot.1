Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FB3606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qac/govQ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pZyt976+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EBB860821;
	Thu, 22 Oct 2026 19:03:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O-zAeS03PYwz; Thu, 22 Oct 2026 19:03:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9394A6088D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695787;
	b=q7HDZOPzhLwkBNPHQ2nM62Gi/nCT+IFuzRLs950msJ4N6OhTQIzbnrizppA6E+USfYKB
	 5djo2C3iaJKpfB7eOM6sB6l/V92qr3pXcBqxEowhGQxXlqP4g+hgHNRc0pPB89bpyV18p
	 kjdGTBvaM+wmBzwGfx8ZgHnQOWkZBSWIAXbinaiBZizdlvpo9BnQ6UzzklL3XnlZS622a
	 bHR4vvNL+etFXAPjdF9GIOSYOCZHXnBQ2BROE6LDXo869dDs2IDryJV6AEx85p5dzcdMx
	 bQvqW/7ywr+sGC0EArqFs/7EA5EdzF/F7mDmHE8PBkOwtVd3w3WYwkLSs813Ie8ZItQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695787;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0/A7soAvN0s240Bq8jfwWlPxco4m5DHjoRPutY2F8fk=;
	b=QwySY/CXVAXycDQT4KytwP0esMKOvabdIVQ3EReCEKPOHiBA0vYvmdqO1yRlnjw8k+/9
	 o+84dd9HxoRwPs079ncoNwalKOUB3pXFZtCR5ivFoBy1hHbyabz3pE4yZSXrXpyIEvYOo
	 HJMroBMhF7RMbJkFrI8VYp/ZW7rQmbQhEjLo6bGs/oeHv+HQ4Wg8zq2BV9rbcmTfdUdNm
	 ZSGLRR5hdCHvw0C28IkQk24GjYvbQsWBNVujt2pL3QhJeREh16l1g3StaaCEQ+EZk1Vxi
	 ysF3EzHd5iDyeTDftxCPB4dlQxNtEILC1yxekkBBlw4D1eeTpMDGglki4Eg3a9gXveA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695787;
	bh=0/A7soAvN0s240Bq8jfwWlPxco4m5DHjoRPutY2F8fk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qac/govQHiA+rFfKfm7BrgVfWF8dw7hmRbBEOpWKAKsR52nw3tybZYXRHsB8YiesH
	 PY62Rb49WttZ7Y9iOYx+fM1wLmutxEYtf0/HknJEVy1mFDEzaerDMX0y1+3DohstQA
	 ZOXvh5KwiV3hD1t7VBZM0iOoHrkteAyLxverLosiMuLMo9Ail1SUQhYj7Wi085ERmL
	 R4Jd4d0GZdt9CHQCY+UKkFn2J+99n2xMDGOc5r0HXEQAdP8Y+PLBH9VeyKUJWBLVEQ
	 rlYJrssagqm0R4L5Y0RyGgridLLIjPvjUudkNrdEfdw0xtL4ENAvdnpLSUCH0Hgwkh
	 z6fYRxATpRjzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9394A6088D;
	Thu, 22 Oct 2026 19:03:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 174C53A7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F1ED840199
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WRtwTdVZPpup for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:02:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C9954400B1
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695776;
 b=I310dU58j2G5aofNpZlLCq7RawF9yoZe/f+/1wCoR7HQ5/ZsIOApn82yPvU3wJN4vTwX
 mcDRzt/IOek+GVkD4MUBFQ7mXRL16EEiyL/B2HpP42V67dmJKj6/hA3ss7jE7YRuOI2wb
 nQ3dsbE/bTGzWVL5dpSMAu1QHXAKP6ckVA6gG8G74ZYDEAmAA7cplB8j6/k25geqrvfSI
 ripbsmLxxZ1rXAzb5TGtP4tX80X8Gc7vmaZYxa2IJQM18lK+zVa5CLOCpKK0tDijpFRxu
 vwc7Mh5OIJu8UyxbCjhQjkY5jMrz9L077W3sn7N3bCgOrfN3vlIzbh3KNzdxryMmfSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695776;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=0/A7soAvN0s240Bq8jfwWlPxco4m5DHjoRPutY2F8fk=;
 b=QzW3szDvBXwMdqIMhZoS4TZZ5rqVXRf38x2SE6I7yUywaPlEujLdmbBpdDDvxJqfHsm8
 l2c/TsWMKnF2AbuCFkFoohwuoa/h6HfvZS6xqyHoGkmf1BThEwYWig/PnQn/vbFJ5wMi4
 S8b/1PrNN6l5XdEnsmgOqdn/c9/jnVX2opRLRzYp1hf9Xl8GriUhog57S7JJVViCMKSRP
 Wf2RKizkIs5Il/Dm3X6NzNXQ8uwFz1DMGZbHx5pe80RkQ7SGqFAESf8Fff+jTmoKig5a5
 5sJ9DCv1X9Ku23zbhavaydtXkskaO606JSBu60dv801IPVdYeBTiNBOWOyNZOOGDXfQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pZyt976+; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pZyt976+
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C9954400B1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:55 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48e011d370dso112984f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792695773; x=1793300573;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0/A7soAvN0s240Bq8jfwWlPxco4m5DHjoRPutY2F8fk=;
 b=pZyt976+B4biOzViP4DeZ6BpsZ4VI1jA69NnG6dxbk6i3OsEfYMRaQ3Ufc7zRC+v+r
 +MP+cq7iFqTu/sV8RaAw3FOUbx4QMvuCL5giUSOpYOy8Wsy5LCPpUbEP0sy0tvew0c2M
 OZtGlYEXm8rEeQYX42U7JSEvqyIPy0IRvH3TG6nPeYcJAQ3pkiXctjjPM9IiZKXtsRLl
 dOEPA/2GQqgfl5wjSLpfCGngQR71S6xc9yzQitXOw566kGpuOuyH/8nnBGlkremM5aBx
 qI8RDUDRao0jCAEa8iWEJR3/uW+ObrY8NWnyRZJos1cM67dG3jsAmWDV7VZ0VN3KPfYt
 1G9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695773; x=1793300573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0/A7soAvN0s240Bq8jfwWlPxco4m5DHjoRPutY2F8fk=;
 b=FAQIZvDwYqNzBPkOlOUjh5tFZD4brIsz/nt/j68C2S/Qr8/JkGztTwH6r4pX08WEFA
 fBeD1K/yalF0WnD4Yr8s/yr6ltkyCgAt6G5+fXs5MJtOPpw84pzVQ1j4+t72vVEr4H5j
 hi+VnxUfDUWi7zsDovQw55iLP4W5fGBiJkbVPWvUiarzdcjv/FY1rChLDNajp4cuq9Zi
 rvq0KX8YCxlGkGr50EvLTTVlsyW4OzvYGIGnexmWgadMJuEngnDIzFi/tfTvt5myaIvL
 87huzDlcStTljkOz7WcVdDjZFLCajFbV6ieiZog2/DkLGlR1axxMM3hk8X3+VmvhS04p
 m1Vg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHo3kYw4jbbVN2v2BHrREyqcTnkBTcQAGRPEpNp5w7Kmx2DB7lX6++CDHlv7IHbRTU0SklGyI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYILgytJGgkb3rZUctvFrWCKH5lYKMAm3C77h/iFZX17A7cWYHCT
 PxXDMoYUCltYrFlg/FMQlmC8g5DDli9j97I5usZLlNmNrFhcXuu3GBuK
X-Gm-Gg: AYBFou3pdFK6J30Aj92gHDOrR9WoTQWLQrUwfVXSN3PIO4JYfYd88tJOvzXEk1zWYBF
 rH4Zq4Q56QNTMXb5WV6HxaUW79/tOVSyEnq6Kik7PU/9exNtTRdJI6Q9BaBTukheab4aHZnEf2q
 3CcdZ/09txpfsOB9uZLR6jHefKrOExFgTqmKLobkMG34XgmlqzVkPzz5EhFwgXA6S5kBFJeDD5j
 ZivmDK4rILiy7AuEszbbBM2MK1d/Hf0dP7n3q4kGWeT0ahNmc+xuH1hmfSeFA4JZ020owu+QUtT
 OOrP7iqpV2/AM7FVAuM9A3AlRojL1hExx9M/Atd2dTOyUcKj+Zst4iO8t5jKmC9EHy9lSGljGxx
 NnQbnB+FMlSUgcyLmKQZ1NdL+40AIffd8i/YxlQ86VXPEc48vPrhKNxzlVy50fsbpAgWUVE4JW1
 sEaJFVtMdgxOR1SkS0vaa9hF127fFCxnuR7Gtwt9AzQkSKqeuD6n0o+c4elBQR1Y19opcSBbJib
 Hs3O0iRQw3EQgX8S6adzau4JQ3f52H5Vxa9VclL0MEAeWeozhRxJpyROyz9J/z4ARmkR3Mx6BD8
 IBW5KlToGFW7b/Dg5Vne3g2Hjg34OEWkWFiDAjEASVJgdvOvR6E8ZHq2zEsu
X-Received: by 2002:a05:6000:26c5:b0:48c:8126:a260 with SMTP id
 ffacd0b85a97d-48e26427bd6mr13530369f8f.6.1792695773005; 
 Thu, 22 Oct 2026 12:02:53 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e37a0e841sm189495f8f.54.2026.10.22.12.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:02:50 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Zhengping Zhang <zhengping.zhang@airoha.com>,
 David Lechner <dlechner@baylibre.com>, Wayen Yan <win847@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 15/16] net: Add support for Airoha AN7583 MDIO Controller
Date: Thu, 22 Oct 2026 21:01:57 +0200
Message-ID: <20261022190206.666950-16-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022190206.666950-1-ansuelsmth@gmail.com>
References: <20261022190206.666950-1-ansuelsmth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Airoha AN7583 SoC have 2 dedicated MDIO controller in the SCU
register map. Add a dedicated driver for it ported from linux kernel.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/Kconfig       |   7 ++
 drivers/net/Makefile      |   1 +
 drivers/net/mdio-airoha.c | 221 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)
 create mode 100644 drivers/net/mdio-airoha.c

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index c057504cf66b..a93268736a4f 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -118,6 +118,13 @@ config AG7XXX
 	  This driver supports the Atheros AG7xxx Ethernet MAC. This MAC is
 	  present in the Atheros AR7xxx, AR9xxx and QCA9xxx MIPS chips.
 
+config MDIO_AIROHA
+	bool "Airoha AN7583 MDIO interface support"
+	depends on DM_MDIO
+	help
+	  This driver supports the MDIO interface found in Airoha
+	  AN7583 SoC.
+
 source "drivers/net/airoha/Kconfig"
 
 config AIROHA_ETH
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 96ec6fb187a8..5f712ca241e2 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_KSZ9477) += ksz9477.o
 obj-$(CONFIG_LITEETH) += liteeth.o
 obj-$(CONFIG_MACB) += macb.o
 obj-$(CONFIG_MCFFEC) += mcffec.o mcfmii.o
+obj-$(CONFIG_MDIO_AIROHA) += mdio-airoha.o
 obj-$(CONFIG_MDIO_GPIO_BITBANG) += mdio_gpio.o
 obj-$(CONFIG_MDIO_IPQ4019) += mdio-ipq4019.o
 obj-$(CONFIG_MDIO_MSCC_MIIM) += mdio-mscc-miim.o
diff --git a/drivers/net/mdio-airoha.c b/drivers/net/mdio-airoha.c
new file mode 100644
index 000000000000..ac1fb13622e0
--- /dev/null
+++ b/drivers/net/mdio-airoha.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Airoha AN7583 MDIO interface driver
+ *
+ * Copyright (C) 2025 Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/ofnode.h>
+#include <linux/delay.h>
+#include <linux/bitfield.h>
+#include <linux/time.h>
+#include <miiphy.h>
+#include <syscon.h>
+#include <regmap.h>
+#include <reset.h>
+
+/* MII address register definitions */
+#define   AN7583_MII_BUSY			BIT(31)
+#define   AN7583_MII_RDY			BIT(30) /* RO signal BUS is ready */
+#define   AN7583_MII_CL22_REG_ADDR		GENMASK(29, 25)
+#define   AN7583_MII_CL45_DEV_ADDR		AN7583_MII_CL22_REG_ADDR
+#define   AN7583_MII_PHY_ADDR			GENMASK(24, 20)
+#define   AN7583_MII_CMD			GENMASK(19, 18)
+#define   AN7583_MII_CMD_CL22_WRITE		FIELD_PREP_CONST(AN7583_MII_CMD, 0x1)
+#define   AN7583_MII_CMD_CL22_READ		FIELD_PREP_CONST(AN7583_MII_CMD, 0x2)
+#define   AN7583_MII_CMD_CL45_ADDR		FIELD_PREP_CONST(AN7583_MII_CMD, 0x0)
+#define   AN7583_MII_CMD_CL45_WRITE		FIELD_PREP_CONST(AN7583_MII_CMD, 0x1)
+#define   AN7583_MII_CMD_CL45_POSTREAD_INCADDR	FIELD_PREP_CONST(AN7583_MII_CMD, 0x2)
+#define   AN7583_MII_CMD_CL45_READ		FIELD_PREP_CONST(AN7583_MII_CMD, 0x3)
+#define   AN7583_MII_ST				GENMASK(17, 16)
+#define   AN7583_MII_ST_CL45			FIELD_PREP_CONST(AN7583_MII_ST, 0x0)
+#define   AN7583_MII_ST_CL22			FIELD_PREP_CONST(AN7583_MII_ST, 0x1)
+#define   AN7583_MII_RWDATA			GENMASK(15, 0)
+#define   AN7583_MII_CL45_REG_ADDR		AN7583_MII_RWDATA
+
+#define AN7583_MII_MDIO_DELAY_USEC		100
+#define AN7583_MII_MDIO_RETRY_MSEC		100
+
+struct airoha_mdio_data {
+	u32 base_addr;
+	struct regmap *regmap;
+	struct clk *clk;
+	struct reset_ctl *reset;
+};
+
+static int airoha_mdio_wait_busy(struct airoha_mdio_data *priv)
+{
+	u32 busy;
+
+	return regmap_read_poll_timeout(priv->regmap, priv->base_addr, busy,
+					!(busy & AN7583_MII_BUSY),
+					AN7583_MII_MDIO_DELAY_USEC,
+					AN7583_MII_MDIO_RETRY_MSEC * USEC_PER_MSEC);
+}
+
+static void airoha_mdio_reset(struct airoha_mdio_data *priv)
+{
+	/* There seems to be Hardware bug where AN7583_MII_RWDATA
+	 * is not wiped in the context of unconnected PHY and the
+	 * previous read value is returned.
+	 *
+	 * Example: (only one PHY on the BUS at 0x1f)
+	 *  - read at 0x1f report at 0x2 0x7500
+	 *  - read at 0x0 report 0x7500 on every address
+	 *
+	 * To workaround this, we reset the Mdio BUS at every read
+	 * to have consistent values on read operation.
+	 */
+	reset_assert(priv->reset);
+	reset_deassert(priv->reset);
+}
+
+static int airoha_mdio_read(struct udevice *dev, int addr, int devnum,
+			    int regnum)
+{
+	struct airoha_mdio_data *priv = dev_get_priv(dev);
+	u32 val;
+	int ret;
+
+	airoha_mdio_reset(priv);
+
+	if (devnum != MDIO_DEVAD_NONE) {
+		val = AN7583_MII_BUSY | AN7583_MII_ST_CL45 |
+		      AN7583_MII_CMD_CL45_ADDR;
+		val |= FIELD_PREP(AN7583_MII_PHY_ADDR, addr);
+		val |= FIELD_PREP(AN7583_MII_CL45_DEV_ADDR, devnum);
+		val |= FIELD_PREP(AN7583_MII_CL45_REG_ADDR, regnum);
+
+		ret = regmap_write(priv->regmap, priv->base_addr, val);
+		if (ret)
+			return ret;
+
+		ret = airoha_mdio_wait_busy(priv);
+		if (ret)
+			return ret;
+	}
+
+	val = AN7583_MII_BUSY | FIELD_PREP(AN7583_MII_PHY_ADDR, addr);
+	if (devnum != MDIO_DEVAD_NONE) {
+		val |= AN7583_MII_ST_CL45 | AN7583_MII_CMD_CL45_READ;
+		val |= FIELD_PREP(AN7583_MII_CL45_DEV_ADDR, devnum);
+	} else {
+		val |= AN7583_MII_ST_CL22 | AN7583_MII_CMD_CL22_READ;
+		val |= FIELD_PREP(AN7583_MII_CL22_REG_ADDR, regnum);
+	}
+
+	ret = regmap_write(priv->regmap, priv->base_addr, val);
+	if (ret)
+		return ret;
+
+	ret = airoha_mdio_wait_busy(priv);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(priv->regmap, priv->base_addr, &val);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(AN7583_MII_RWDATA, val);
+}
+
+static int airoha_mdio_write(struct udevice *dev, int addr, int devnum,
+			     int regnum, u16 value)
+{
+	struct airoha_mdio_data *priv = dev_get_priv(dev);
+	u32 val;
+	int ret;
+
+	if (devnum != MDIO_DEVAD_NONE) {
+		val = AN7583_MII_BUSY | AN7583_MII_ST_CL45 |
+		      AN7583_MII_CMD_CL45_ADDR;
+		val |= FIELD_PREP(AN7583_MII_PHY_ADDR, addr);
+		val |= FIELD_PREP(AN7583_MII_CL45_DEV_ADDR, devnum);
+		val |= FIELD_PREP(AN7583_MII_CL45_REG_ADDR, regnum);
+
+		ret = regmap_write(priv->regmap, priv->base_addr, val);
+		if (ret)
+			return ret;
+
+		ret = airoha_mdio_wait_busy(priv);
+		if (ret)
+			return ret;
+	}
+
+	val = AN7583_MII_BUSY | FIELD_PREP(AN7583_MII_PHY_ADDR, addr) |
+	      FIELD_PREP(AN7583_MII_RWDATA, value);
+	if (devnum != MDIO_DEVAD_NONE) {
+		val |= AN7583_MII_ST_CL45 | AN7583_MII_CMD_CL45_WRITE;
+		val |= FIELD_PREP(AN7583_MII_CL45_DEV_ADDR, devnum);
+	} else {
+		val |= AN7583_MII_ST_CL22 | AN7583_MII_CMD_CL22_WRITE;
+		val |= FIELD_PREP(AN7583_MII_CL22_REG_ADDR, regnum);
+	}
+
+	ret = regmap_write(priv->regmap, priv->base_addr, val);
+	if (ret)
+		return ret;
+
+	ret = airoha_mdio_wait_busy(priv);
+
+	return ret;
+}
+
+static const struct mdio_ops airoha_mdio_ops = {
+	.read = airoha_mdio_read,
+	.write = airoha_mdio_write,
+};
+
+static int airoha_mdio_probe(struct udevice *dev)
+{
+	struct airoha_mdio_data *priv = dev_get_priv(dev);
+	ofnode ofnode = dev_ofnode(dev);
+	u32 addr, freq;
+	int ret;
+
+	ret = dev_read_u32(dev, "reg", &addr);
+	if (ret)
+		return ret;
+
+	priv->base_addr = addr;
+	priv->regmap = syscon_node_to_regmap(ofnode_get_parent(ofnode));
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	priv->reset = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(priv->reset))
+		return PTR_ERR(priv->reset);
+
+	reset_deassert(priv->reset);
+
+	/* Check if a custom frequency is defined in DT or default to 2.5 MHz */
+	if (dev_read_u32(dev, "clock-frequency", &freq))
+		freq = 2500000;
+
+	ret = clk_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	ret = clk_set_rate(priv->clk, freq);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static const struct udevice_id airoha_mdio_dt_ids[] = {
+	{ .compatible = "airoha,an7583-mdio" },
+	{ }
+};
+
+U_BOOT_DRIVER(airoha_mdio) = {
+	.name           = "airoha-mdio",
+	.id             = UCLASS_MDIO,
+	.of_match	= airoha_mdio_dt_ids,
+	.probe          = airoha_mdio_probe,
+	.ops            = &airoha_mdio_ops,
+	.priv_auto	= sizeof(struct airoha_mdio_data),
+};
-- 
2.55.0

