Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF56E9A055
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 17:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D8DD83D0F;
	Thu, 19 Feb 2026 18:51:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oGmYF7sz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A34F383D3D; Thu, 19 Feb 2026 18:51:52 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6E6883D0F
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 18:51:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso10835055e9.2
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 09:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1771523510; x=1772128310;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h8DpYVjladhvWDx1P1+TyQplxDeEaGAqMxXk9vBFzcI=;
 b=oGmYF7szJFFmpVT6oNMH0hW0AJ9el4mrLFV3qOIf4YkufQEnKXYXHthl9o/AX9iD0f
 kPZK0rPWhV7z1FpmwCm6Yr555HQ5WFMkCrETnyhYFnQtqHtywhNHvAJnOaLjuaILxTVJ
 VppA6d9oHDnqjyTXNgDspXXoTIPgZUScECQbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771523510; x=1772128310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h8DpYVjladhvWDx1P1+TyQplxDeEaGAqMxXk9vBFzcI=;
 b=usQ/s0PEvu9ZgicvyTu0u6SbrtH+VUONiDpQwFklH1fiXlY3K8M60xgeeavM5boNmq
 0JpB5mLF4zhYi0NX/aKdI1pW80yWAP8eZW/YtneLr4ZErQtHMhEhMqirEjq6Woga6PLg
 anr52m6J+pRv65iASQHPh6aBOq+xDjBwecWrYFLHtO+GRlH7ePW8AT68UKXjdGUCEMwv
 DKMfnEchUoMCQG0JBBfqDkqNB2x8dVlzMoK5BZPIW8/hD+4610oW7GPuJC0W2MBdvXfo
 2nQBR2+7ZF/rYE6/ayaUGsBfn6WJBlMdu20p/D94fXcOYcdE+5863lIq/3T4/i0guyu9
 jP2A==
X-Gm-Message-State: AOJu0Yx9JAXAQHJXcUfNV6/x3/1CE2aDsVOIgXy2MXoT/cas4H6ibN5b
 tVMbxv7DM/vTebeDWh7vcZyrNCp0BRxgGRXaJwmf/O1w/BxPT3wWG7RpMGDyymkgNUSs887VNZk
 LjvOz
X-Gm-Gg: AZuq6aJT92LIzm/2rkehTl5IaToSqi2BqsMB9UuwZcw7C3NKhpgWxV9rEaOoB6ZdIFL
 Lbm3RuNXjxRh2q/uSXmZ3dpmQZctTVJ+3GucbC+hVaOo3GZX9Zs8HWMlRuO1JPhinx69Aebw1ri
 8aaSS2Z10UPgOHrvQI7i1mwPIREhnGG8uehczSNgMr6JiX1bVeTBaNI8B0ujA/pZsilo2DBdsoW
 Dp5rGECRZall97dr9ObKGiy3EOUrVeaUAn48pDvODuYBYo1w5GvbRuldKesjVoaYMZDilxFzdiw
 WngBMANLCk6xZI5z856/bFri7zmDKb29hy5WR6AF1kuvC1GG0GC+S+9hB7X0DLVLuZYOLabgkMz
 Tet6NISrd/v2Rwnk7t9nT5jkl90h5TUkD82i2tpTJ5DmG2ymD0girZISLsgchm/EFjXV5/UQRFJ
 vaK79TOVIBIO6HoHah352tqWbrDg4hUEU0ZMrd8RSNnN7Cohl04lnBP6cnhP1Mf6Pxtn2tySmkR
 bDpru1HzTbwK2GLRk+Q7hNeW/XuI0khI+lO+bOUFfyPllSyxqxi7eccJd3gDDfD29Eo1utXzJKk
 5aGan1uU5lIeoqKfCzGennH/
X-Received: by 2002:a05:600c:4687:b0:47a:935f:618e with SMTP id
 5b1f17b1804b1-48371061414mr370502845e9.15.1771523509863; 
 Thu, 19 Feb 2026 09:51:49 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b0e63sm35485005e9.2.2026.02.19.09.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:51:49 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 linux-amarula@amarulasolutions.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/8] spi: add support for bits-per-word setting
Date: Thu, 19 Feb 2026 18:51:12 +0100
Message-ID: <20260219175130.2839234-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
References: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
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

Allow dynamic configuration of the SPI word length. This is required
for controllers and slaves that need to operate with non-standard
word lengths, such as 9-bit wide transfers.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/spi/spi-uclass.c | 19 +++++++++++++++++++
 include/spi.h            | 12 ++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index 49b584c648d6..a4a3b6c25b7d 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -91,6 +91,20 @@ void dm_spi_release_bus(struct udevice *dev)
 		ops->release_bus(dev);
 }
 
+int dm_spi_set_wordlen(struct udevice *dev, unsigned int wordlen)
+{
+	struct udevice *bus = dev->parent;
+	struct dm_spi_ops *ops = spi_get_ops(bus);
+
+	if (bus->uclass->uc_drv->id != UCLASS_SPI)
+		return -EOPNOTSUPP;
+
+	if (!ops->set_wordlen)
+		return -ENOSYS;
+
+	return ops->set_wordlen(dev, wordlen);
+}
+
 int dm_spi_xfer(struct udevice *dev, unsigned int bitlen,
 		const void *dout, void *din, unsigned long flags)
 {
@@ -144,6 +158,11 @@ int spi_set_speed(struct spi_slave *slave, uint hz)
 	return ret;
 }
 
+int spi_set_wordlen(struct spi_slave *slave, unsigned int wordlen)
+{
+	return dm_spi_set_wordlen(slave->dev, wordlen);
+}
+
 int spi_xfer(struct spi_slave *slave, unsigned int bitlen,
 	     const void *dout, void *din, unsigned long flags)
 {
diff --git a/include/spi.h b/include/spi.h
index 2783200d663e..a92f54a7404b 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -729,6 +729,18 @@ int dm_spi_claim_bus(struct udevice *dev);
  */
 void dm_spi_release_bus(struct udevice *dev);
 
+/**
+ * Set the word length for SPI transactions
+ *
+ * Set the word length (number of bits per word) for SPI transactions.
+ *
+ * @slave:	The SPI slave
+ * @wordlen:	The number of bits in a word
+ *
+ * Returns: 0 on success, -1 on failure.
+ */
+int dm_spi_set_wordlen(struct udevice *dev, unsigned int wordlen);
+
 /**
  * SPI transfer
  *
-- 
2.43.0

