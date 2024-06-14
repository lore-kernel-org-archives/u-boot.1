Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9031AC27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41ADC889C5;
	Fri, 14 Jun 2024 14:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="C6/pZtHB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A975D86784; Fri, 14 Jun 2024 14:20:01 +0200 (CEST)
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com
 [91.218.175.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C26F6889CD
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=contact@jookia.org
X-Envelope-To: jagan@amarulasolutions.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1718367599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nh98bDQEFpoNVCkl1wGgAwa0yRgYBuJCHqpg+Q097q0=;
 b=C6/pZtHBMDEJO1zu8regQPxynmrV6ecsV9jBq5ShpDJKT1+yf+8NfIwrja3n0D9ReUzofA
 3IWeCD8U2nxgsKqLtZLSEIQFa7wnCvP/DJ6k9g6GakvO2nMXbPQ67ZOgsX8tnwrdoTWo20
 JO6dXJxvqZRuxsfWwSZa9va+vf9mBJ0MWefgVe/5HOsSOg+mBh4Jx6R+yqjtZ2moRLLGq3
 qGO1akIFoCKUHN6H7p7dd1XH1pobs6efMLVfL0Ol0YoJ7TLdCzcRfSNc03gtE1QKvPYqxw
 sljL6eHtADKjh02DWChIT9A9leHT8gKHUoMQPlh3nxYb8qfhtLkpp6bJvUA31g==
X-Envelope-To: agust@denx.de
X-Envelope-To: u-boot@lists.denx.de
X-Envelope-To: trini@konsulko.com
X-Envelope-To: contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
Date: Fri, 14 Jun 2024 22:18:44 +1000
Subject: [PATCH 4/5] spi: softspi: Support setting wordlen
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-mipi_dbi-v1-4-946eb82f8533@jookia.org>
References: <20240614-mipi_dbi-v1-0-946eb82f8533@jookia.org>
In-Reply-To: <20240614-mipi_dbi-v1-0-946eb82f8533@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1718367549; l=1136;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=LlOMILhhtJXcTwEWP8peUufBWk2IZMPYBZb1Mqq11vw=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgPs7MDd2XR
 g2uRE9caV1lPPPeu0VzIG9fPrrVmYyAhLcAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAiW4fj06Q5RqThDYIdO9PN5a
 KDFOflPOgAv2dTGdY88nlfFRzff1rwa2FleA/MFiCdatcgXrfZYD6hhZXr68XCgUAAP+n
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:/gEvgms/9HpbgpcH+K7O4GYXmqkP7siJx9zHeEWRZTg
X-Migadu-Flow: FLOW_OUT
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

The bit-banging soft SPI driver supports any word length, so just
blindly return support for all of them.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/spi/soft_spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/soft_spi.c b/drivers/spi/soft_spi.c
index 0fa14339bd..4f2161f0bf 100644
--- a/drivers/spi/soft_spi.c
+++ b/drivers/spi/soft_spi.c
@@ -204,6 +204,12 @@ static int soft_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	return 0;
 }
 
+static int soft_spi_set_wordlen(struct udevice *dev, unsigned int wordlen)
+{
+	/* Support any wordlen as this driver clock out bits individually. */
+	return 0;
+}
+
 static int soft_spi_set_speed(struct udevice *dev, unsigned int speed)
 {
 	/* Ignore any speed settings. Speed is implemented via "spi-delay-us" */
@@ -223,6 +229,7 @@ static const struct dm_spi_ops soft_spi_ops = {
 	.claim_bus	= soft_spi_claim_bus,
 	.release_bus	= soft_spi_release_bus,
 	.xfer		= soft_spi_xfer,
+	.set_wordlen    = soft_spi_set_wordlen,
 	.set_speed	= soft_spi_set_speed,
 	.set_mode	= soft_spi_set_mode,
 };

-- 
2.45.2

