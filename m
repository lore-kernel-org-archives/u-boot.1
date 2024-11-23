Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F54EE66889
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 21:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EE9289432;
	Sat, 23 Nov 2024 22:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=dominik.wernberger@gmx.de header.b="W30SxuQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36242884B0; Sat, 23 Nov 2024 22:47:38 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E062A893F7
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 22:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dominik.wernberger@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732398449; x=1733003249;
 i=dominik.wernberger@gmx.de;
 bh=inAbOi7KG8PLkTspCjzhA81iqVvc35b07rSHgROPxEw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=W30SxuQjt+ZTagK7FBZIhQGwIYU3uH+DMhHG5xzxaSCbapDZ+kzYc7dF5yXdUlkN
 GZ9oMuHvzsBBxbm1jpd3RdZzEj7fxbmsLqTiJBWL5YAYudAZMA99Mq55Le1Z0y53O
 zEvLmDuc2jDTDrxX6AXK7sNADrKk9GxBhiNXJkkCWaR8X1p4SXyhI2Q4WFXb7PBVN
 e4j+fhM8docvr94n528ZpkC0cqYqZfoOBekYM7Tj/fPBs9PKEsKWZbjoeBL6hKKPq
 1c+Rmio7KYJEyXJ/IJpw1Ix9gIxTSxLqC/FdrGl2/8UwY8g5RALkiViyvmHdzuVWE
 2cfe68mnf91yfVj2/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from doms-pc.fritz.box ([87.162.74.135]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8XTv-1tk9tg1xT7-00wqJU; Sat, 23
 Nov 2024 22:47:29 +0100
From: Dominik Wernberger <dominik.wernberger@gmx.de>
To: u-boot@lists.denx.de
Cc: marek.vasut+renesas@mailbox.org, jagan@amarulasolutions.com,
 michal.simek@amd.com, tudor.ambarus@linaro.org, venkatesh.abbarapu@amd.com,
 Dominik Wernberger <dominik.wernberger@gmx.de>
Subject: [PATCH] spi: Fix missed rename from SPI_ADVANCE to
 SPI_STACKED_PARALLEL
Date: Sat, 23 Nov 2024 22:47:08 +0100
Message-Id: <20241123214708.44405-1-dominik.wernberger@gmx.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hZJ6C/VPuxmHoIIb1kpSmUHViZCsorio58O2meakzQ7A0hRnGTk
 tE3wwDTZq/AJ5ncwWz9v03awuuj4Zd+vPPgH4c3vepiyFvNV1y1ePlSKTtMDa76Ri1RMcap
 ml2vhNbCnDUf7eBuHFvX6Tc6H8Ibv3Ma1HqpO+authv2ixHPULYXvHCWhxRWDLmjwqbNcl2
 siDMq6DHiK7APCQzI+ecg==
UI-OutboundReport: notjunk:1;M01:P0:7QA7XvSkrYo=;soY65L0WfA2KSX+yfPaQ7EF3NaL
 Wmh7A2Hpd8t7L0YTyrivsycE7sqpUJ33Rtpyw+7DcbumXRxr1XayI26ZWzGkCNh41gN8wiCun
 VrcZd+75vMcUFME2m15HdO0vBpTZS8sVj3SLMRNwPB+Ei17rzfPFicNTD87bGxOTc49l4DpV6
 OB0xjkncWsuvJ7oJPoP+cHQdxpQlNAIID7EoxtdKXqigHpjEHWC/SJo0DdXrpYiY/i7MJDDEJ
 yS9fkI6VmqSvtvcRJT7QaWmw615rK1vJa//h/8+5OMT60hsf+X9yiU6k1GmzFlhjT4Myg7kV7
 kUP8Xq6MoVDp/rN0qzxEYv8jQewPStScSivRLqdkRWg4hHs4RMfRPU5PywFfUT7pNFoUSOH/2
 s5ySpBNKOI0s0Cl+sZl8N5c30AqqDea5hsNGfzx9xUPVNpzYEWFn8CHNYdzMIoEu6fDcu/kRb
 435sBwlH+TgRYEytgtLCe8XlaW3Na6LE2ub4zFBAFv1qbcKBSzgHWg7t6XKaWgZse2kxy+28O
 yCjRJgnHi9oKU8lNO9AgnVDT9bAGKICj2V+OlLDQ09yNUeCEC66uYlcqZWI6r8N1dYrFbH14E
 D3c4wfXAudOOkbkEMK6SaXRWcL2yX9zj0xK0EHZRXx3gtSHM9LdgfRXkJZVsANaBSR0SvXRD9
 d9mXtlYWmGS98xRAeNYO03+OB2xkEHry1UyQrtdslYooO6XMqCx2j4oY20RKeUYi+IcN8foki
 3lIf9Ao1R7PQCGwAV5t7lFyF3ZVSybOmeY9UMvki/mEreXAI0AASm2ou64STZWsXTEb3lCFXM
 eUFXgccG3gDCprTc/GWzTqbm8T9s9kOMSZwS2N2hCjJxIiHuwsaYHmuaj08LnPbI4Yld7oi55
 yf3oLmoSpBN4zEL6Dr8J+SUVtQmD2jtexczr/VBIfc/nB8mW0Z/sPRbua
X-Mailman-Approved-At: Sat, 23 Nov 2024 22:49:33 +0100
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

See https://lore.kernel.org/u-boot/20241026201741.171073-8-marek.vasut+ren=
esas@mailbox.org/

Signed-off-by: Dominik Wernberger <dominik.wernberger@gmx.de>
=2D--
 drivers/spi/spi-uclass.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index 36b7d383aa..d604975374 100644
=2D-- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -446,7 +446,7 @@ int _spi_get_bus_and_cs(int busnum, int cs, int speed,=
 int mode,
 	slave =3D dev_get_parent_priv(dev);
 	bus_data =3D dev_get_uclass_priv(bus);

-#if CONFIG_IS_ENABLED(SPI_ADVANCE)
+#if CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)
 	if ((dev_read_bool(dev, "parallel-memories")) && !slave->multi_cs_cap) {
 		dev_err(dev, "controller doesn't support multi CS\n");
 		return -EINVAL;
@@ -515,7 +515,7 @@ int spi_slave_of_to_plat(struct udevice *dev, struct d=
m_spi_slave_plat *plat)
 	int mode =3D 0;
 	int value;

-#if CONFIG_IS_ENABLED(SPI_ADVANCE)
+#if CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)
 	int ret;

 	ret =3D dev_read_u32_array(dev, "reg", plat->cs, SPI_CS_CNT_MAX);
=2D-
2.34.1

