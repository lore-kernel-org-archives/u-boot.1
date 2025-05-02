Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4743EC3ABA3
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 06:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1F5E8070C;
	Fri,  2 May 2025 08:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R2XkHUGA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C18180FDE; Fri,  2 May 2025 08:51:49 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 157D98059D
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 08:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so1190572f8f.2
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 23:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746168706; x=1746773506; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jvqo3sXWziR8Flkh0fsHX/laX/gCDKF6x4XRvzgY4Q4=;
 b=R2XkHUGAt7OVjgJ/wLiaXP5ELjlG2UbD2x4sDkazu0HmKmItuiP5NjsB8aMr/KG5yx
 u8VLLoELwEIpzWLcPhLbxcOBDJZGVkbaLZnCbf+v0ls/CDhLpfLqwbug3xo15QXHmtX6
 3gcYFpUS6CJPs9u+S7PbRDXYZFuxy+97xRwprRrxlhFQGfvX9vZd8HMH2CziQ5ntNWYa
 jbvmSpAUBL2X8Z6MPdoRCr//2VW4KcG8bQfI8ocIQNf6xe4TeKiI4mKzToIV7QMcFrbv
 gi0R+bMyOOsZm8xvhIAqWAkQOBWK0SldJkLAdY7NO0rRfCmPcfCb5wdCfKEtjzR0mot/
 ZhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746168706; x=1746773506;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jvqo3sXWziR8Flkh0fsHX/laX/gCDKF6x4XRvzgY4Q4=;
 b=hCi5hhhesWBZbbuHM9UW3HcTrwHrchOb0IRFgQynhjajhjDQNSk9StZ+xE1wQl5gec
 qT2kCCJOThPMMKQ+IcUJUTxrvfRgM9cCJZ599Wd8fpQryi2ymLX9CozXTBW5unKR+QRx
 Nt0bgdAGYeCgcJI2i6YHf7QwkdDfw1KWAKEx9pH1BRHD3kwU7AKHlKpNLUghnSR5+1Qn
 QJtZyahP83Mfu4g8iFFh3Y6TyePxYKb9NxlVYOVXzKwi8M6ha8F3n1iMawJvRU3YfhvO
 FBZ4tSxf53icuEGZxmtalI7hCfgMffPIh+QkNaFu84dtisSZ7wQosj5QcuTBpNipl05C
 V22Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn+WGFkVSLR/W748ikDgc5nB6Zf5aUk6Mvc6jEIQNA9HwMJqSIk22Orhc7L1kpzampKstGkKg=@lists.denx.de
X-Gm-Message-State: AOJu0YxFzS2fV5LJIkQAtY3+FO+0AQD65bVqeHsQv4SBoR0+UfU/GJjD
 oeJhFxphrvkdzNuD93zAXzhDfYBcrUhmovMMbXB1RN5wgQunTxpld2tTDbVTQp8=
X-Gm-Gg: ASbGnct2CT+QVEOKQyBuwhXAMeMrMqjaKDcHh0HCcQnCW9NrD7rJNFzvh7IhEX6iJoW
 CzaC9sY8VxWL/wDRIEgxB/3g9sptbmWWjcbyDMxnmmd/R1VcSJZuctc4AMA+wzgoNVzqobXYGpu
 RvwM8/LOUoD1CA8wuQ8yUuRK7qnaBszXmqdSyo16PZ8XbDTqrffOud3BzMzugMd/v5uZuFeH+yE
 CW/OxpTUHhYmbVhEOP1TotF9S0K6agurYRLR5376obfMz02YCYvA0/CbqAXOcr+3r6B0wSkdqQC
 8SiFTkml02pS5pnFaLWHGnJi+Q0lxl/iC2pWst0FjdoHpIi78KYybe5bA+wVTQ==
X-Google-Smtp-Source: AGHT+IH3ERCJL7wsWYOR2zV3do8JLHVQP0huSgFpIItt+jX/OPTNJ7j7EhbAsoynDbXnGbVFiuueZw==
X-Received: by 2002:a05:6000:2908:b0:3a0:88d5:7fca with SMTP id
 ffacd0b85a97d-3a099ad29fbmr995361f8f.12.1746168706470; 
 Thu, 01 May 2025 23:51:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0c3dsm1301109f8f.12.2025.05.01.23.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 23:51:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 02 May 2025 08:51:45 +0200
Subject: [PATCH] net: mdio: mux-meson-gxl: set reversed bit when using
 internal phy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-u-boot-topic-mdio-mux-gxl-bit28-v1-1-399f6c3db154@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIBrFGgC/x3NQQqDMBBG4avIrPtDmmAJvUrpwpjRDlRHkigB8
 e4NXX6b907KnIQzPbuTEh+SRdeG+62j8TOsM0NiM1lje9Mbix1BtaDoJiOWKIplr5jrF0GK9Rg
 e0bgweXbeUatsiSep/8PrfV0/MwMTYXEAAAA=
X-Change-ID: 20250502-u-boot-topic-mdio-mux-gxl-bit28-a6d03bf8e383
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Da Xue <da@libre.computer>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=zTJoWKUCYaJ+JTk9qHMoBRiWtUADaEfro8L/suVST7w=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoFGuBqWdAidMyi9YN1ynArFf8CC9iinwrPABLfZZ9
 oMQ/k7mJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaBRrgQAKCRB33NvayMhJ0WxCEA
 DDAGNEX+sUkBB6OkOPhXnss0LPhuWHbYz2/ZgRwuvPPbFgjB690cBu93nRpy0u450Iziqut6KBUv/V
 1aVThyoJaLpNWahJv83D+gyCud4f9s8nR830Wd/bhj9yac0EuZz/kXiSKfoQNY3zWjB5V2Z3ZNCDQ6
 JKSOGxkXtuo8foo2afV1xtaam2fJBuQfcCrJzVOxG0Rtg9/eqf5eC+BlQDF9cA1+n4a4ZJmWgc19YZ
 6rIk5j3zoE8DGuK9JU+Lu8RQdl7IVKXICSoCzwOW4ELp8UZ6cU7VK8toHW/6PHffVIleJbcmzN+/jz
 ItXvoREyJhqwAPHQlRFeHa/1NvQ4822cGAgvaqX1/4X5kQuMJKTIYkRA3hjrMn5tq5IhSpN4FhLeDq
 DPQhtiW9N2qKCRv+Dzf+SdwNDoQAlsNMfjfSaOvecOLuRmy+eTUsoPUblxv3RVZ+/OJIDmHyYKY9sz
 zcnu5vfMfRIrIpIbwNMv9z7kCx4xiiHwiHw7WzyIJ5s6el0R450ZI0OZgcdegGyoni4Vyc9sFWo5T6
 EwknbB+ZKW4ke65yHG+RplqcIoJrEBJdVz2c3oFWoEgYI2UWCQhXzcou/37LoEBoZOK4aZEmMUdwAM
 QcBPQnNCtaLmCUfF5iSrs7+uviipHlueR89ePpOudaKXVLKmycx/j8ZGpPrQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

This bit is necessary to receive packets from the internal PHY.
Without this bit set, no activity occurs on the interface.

Normally u-boot sets this bit, but if u-boot is compiled without
net support, the interface will be up but without any activity.

The vendor SDK sets this bit along with the PHY_ID bits.

Ported from the Linux change at [1] from Da Xu merged in
commit [2].

[1] https://lore.kernel.org/all/20250425192009.1439508-1-da@libre.computer/
[2] b23285e93bef ("net: mdio: mux-meson-gxl: set reversed bit when using internal phy")

Suggested-by: Da Xue <da@libre.computer>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/net/mdio_mux_meson_gxl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio_mux_meson_gxl.c b/drivers/net/mdio_mux_meson_gxl.c
index 8ef3ae598b77fabf7b992900141d309708428b13..31898ed437e4857dd7027d311ab496be3e448d16 100644
--- a/drivers/net/mdio_mux_meson_gxl.c
+++ b/drivers/net/mdio_mux_meson_gxl.c
@@ -19,6 +19,7 @@
 #define  REG2_LEDACT		GENMASK(23, 22)
 #define  REG2_LEDLINK		GENMASK(25, 24)
 #define  REG2_DIV4SEL		BIT(27)
+#define  REG2_REVERSED		BIT(28)
 #define  REG2_ADCBYPASS		BIT(30)
 #define  REG2_CLKINSEL		BIT(31)
 #define ETH_REG3		0x4
@@ -66,7 +67,7 @@ static int meson_gxl_enable_internal_mdio(struct mdio_mux_meson_gxl_priv *priv)
 	 * The only constraint is that it must match the one in
 	 * drivers/net/phy/meson-gxl.c to properly match the PHY.
 	 */
-	writel(FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
+	writel(REG2_REVERSED | FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
 	       priv->regs + ETH_REG2);
 
 	/* Enable the internal phy */

---
base-commit: 98a898e58499c78245e4fe36ee404b1b1208e32b
change-id: 20250502-u-boot-topic-mdio-mux-gxl-bit28-a6d03bf8e383

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

