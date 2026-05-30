Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6E2CD6E49
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 15:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DF208405A;
	Sat, 30 May 2026 17:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=mediastek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mediastek-com.20251104.gappssmtp.com header.i=@mediastek-com.20251104.gappssmtp.com header.b="nTQ0R8Ox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F62084693; Sat, 30 May 2026 17:35:52 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E55908405A
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 17:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=mediastek.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=cobenhan@mediastek.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-36baec934b6so1078157a91.0
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediastek-com.20251104.gappssmtp.com; s=20251104; t=1780155348; x=1780760148;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fy8SKVMdY1XbzWZ9no3oZ9cg7vpmUVccwM8U4R8f5n8=;
 b=nTQ0R8Oxk/zvLbMMY+wiAl0vTEFOpfAZAfydCxjkboryx+Rz4lJ/zOUHr4N8Q9DxMp
 lQmRWGgIlanL3blxazYVKQ5+rHDMqqjnQYo9uI4hFimpbAexXBi+d4aiaefpqKRy7iMu
 uwwmpHrmVo6FXsHDE0+RMIVR9+diIlhiPBi9RXwmXUludds9Fwbtp7RckbhIIwHFsgU5
 j1VMyZyP88iJuMYkjVmopqeUx3AmmsS0ZlIaq/AEDO+Bvit7MWSBAZfE9q7W+cApmXpJ
 +1DqG3I8tvN4qsYlI5ImoDsuJ4PVebBpD0QyUL9Bzlu7b45XPRVFC+IgY499PeIaTUls
 kdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780155348; x=1780760148;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fy8SKVMdY1XbzWZ9no3oZ9cg7vpmUVccwM8U4R8f5n8=;
 b=XDQvk+yCvVwn2ZNgK1l8Sq1ya+bQcdSE4MPmwqKnw7ddsQ6XQ61ffpOixc+TDy22nl
 Pk+5UiK+fw8OTUEsXQrZtWWk3nqykOZgknmp7WcQmbd1/AQPAb0s8fTkm3lgpDQh+tNp
 kY5fd8tLkcnFlPvTiIkQj1tmlTLpGnrfm6vNhJcADmfAeX4/GB/MdCxLcJCHs9ay+bYE
 ceulwTyZGfVH1MV0fWDdPlnOzpKrYebM0xqWx6oaW9IOSnDROYBrAGu5OjE5Xq/n4EQU
 RajmzkIy/gfN3vj7txdgsS06/9LIcfcOmg/G0QCsrABJqppDceTt2XQ0fnValp8+x5gE
 xB5w==
X-Gm-Message-State: AOJu0YwBGhiMTIdRHNvvDRL26PZFTL1Xb0XDVvlKEX87JxpoVoglBspX
 6NvZaPkSCXc2XvgLw9p/VLAdMYHkbZFjyZ6aB5kQz7avRSvQDi2SVGCf6mhb1HF152iqDy2/4gf
 q7Tz6
X-Gm-Gg: Acq92OGrj8hJg6yQrH3HEgXVO0/eRoe4NoWpgPcqLgNpaBqTKiY8pUjdZ5Oncp+FC9e
 RKp6FcRHhgE85ddbvYzSEFpCJ+8vaHd5s+Og0BtmOkucuEZLgZjBqo9hozi+G9uAbksyQ6u7G3t
 tSpedZF4MFeJkZGzqvrAXK5mDw2Iq86jRL6QXh2R9r/Na+HVGjdJAAzx2rR30O3mGBcUvAeW2p6
 CVHAZgF8efT7Fo3Wn3vJiXduOJGzYMTYTDnywozZsC0sWg4EcgTMKSQLP08wcaUrrXa2BrroP6G
 QiTXaCZcmQw48hzQuVIJDOKu8wikcY7DWJsT+Pvo+38bu4b4qO22Dkv1soraEjnuF6c7alulI5M
 1rsfRH8MD+Qq50eA9TsOQCBry5ajcX4K9u8zODFQ+D82PfzZ1nWz0KlW+u8BYZSxU4WNfHF860X
 daplvFfUWSwqOW6wfPVzDgWIMrmLaOZlS7UAgTjJ02OswS4vPM
X-Received: by 2002:a17:90b:55c7:b0:35a:10b6:1208 with SMTP id
 98e67ed59e1d1-36bbe1bdf82mr7221640a91.14.1780155348382; 
 Sat, 30 May 2026 08:35:48 -0700 (PDT)
Received: from localhost.localdomain ([112.170.45.78])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36bc6a34ca9sm5144042a91.9.2026.05.30.08.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 08:35:47 -0700 (PDT)
From: Coben Han <cobenhan@mediastek.com>
To: u-boot@lists.denx.de
Cc: hs@nabladev.com, trini@konsulko.com, cobenhan@mediastek.com,
 wojciech.szamocki@nokia.com, bigunclemax@gmail.com, peng.fan@nxp.com
Subject: [PATCH] i2c: designware: fix i2c probe error
Date: Sun, 31 May 2026 00:35:34 +0900
Message-Id: <20260530153534.1010094-1-cobenhan@mediastek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 30 May 2026 17:45:09 +0200
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

Probing i2c slave device just needs its device address.

A certain type of chipsets such as RTC S35390A have no offset,
which means address length should be 0.

But the current designware_i2c_probe_chip function requires
offset 0 and its length 1.

This causes the designware-i2c to be initialized again and again.

Furthermore, after booting into kernel, the designware-i2c kernel
driver complains its controller timeout.

This patch fixes this misbehaviour in such way that  only device
address is issued, no reinitialization needs when target device
not detected, the designware-i2c kernel driver continues working.

Signed-off-by: Coben Han <cobenhan@mediastek.com>
---
 drivers/i2c/designware_i2c.c | 45 +++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/designware_i2c.c b/drivers/i2c/designware_i2c.c
index 8ad716f410e..69aeb266612 100644
--- a/drivers/i2c/designware_i2c.c
+++ b/drivers/i2c/designware_i2c.c
@@ -740,13 +740,46 @@ static int designware_i2c_probe_chip(struct udevice *bus, uint chip_addr,
 {
 	struct dw_i2c *i2c = dev_get_priv(bus);
 	struct i2c_regs *i2c_base = i2c->regs;
-	u32 tmp;
-	int ret;
+	u32 start_time, ic_status;
+	int ret = 0;
 
-	/* Try to read the first location of the chip */
-	ret = __dw_i2c_read(i2c_base, chip_addr, 0, 1, (uchar *)&tmp, 1);
-	if (ret)
-		__dw_i2c_init(i2c_base, 0, 0);
+	if (i2c_wait_for_bb(i2c_base) < 0)
+		return 1;
+
+	dw_i2c_enable(i2c_base, false);
+	writel(chip_addr, &i2c_base->ic_tar);
+	dw_i2c_enable(i2c_base, true);
+
+	writel(IC_STOP, &i2c_base->ic_cmd_data);
+
+	start_time = get_timer(0);
+	while (1) {
+		ic_status = readl(&i2c_base->ic_status);
+
+		if ((ic_status & IC_STATUS_TFE) && !(ic_status & IC_STATUS_MA))
+			break;
+
+		if (readl(&i2c_base->ic_raw_intr_stat) & IC_TX_ABRT) {
+			readl(&i2c_base->ic_clr_tx_abrt);
+			ret = -EREMOTEIO;
+			break;
+		}
+
+		if (get_timer(start_time) > I2C_BYTE_TO) {
+			ret = -ETIMEDOUT;
+			break;
+		}
+	}
+
+	start_time = get_timer(0);
+	while (1) {
+		if ((readl(&i2c_base->ic_raw_intr_stat) & IC_STOP_DET)) {
+			readl(&i2c_base->ic_clr_stop_det);
+			break;
+		} else if (get_timer(start_time) > I2C_STOPDET_TO) {
+			break;
+		}
+	}
 
 	return ret;
 }
-- 
2.34.1

