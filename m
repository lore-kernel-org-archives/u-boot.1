Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201C2C61DCB
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 09:43:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9244383A41;
	Sat, 21 Feb 2026 10:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="R6u7XraZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8F4383DCB; Sat, 21 Feb 2026 10:43:01 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9122883936
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 10:42:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48371119eacso28813395e9.2
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 01:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1771666979; x=1772271779;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5SpwVBfDTYR9+u4Mo5qtV6hRcGkLnuLeVILyHGsncm8=;
 b=R6u7XraZK4UcuheCzxjEtv5nGsbejqdivp0R9KuubD0v6s88JXNd13kMTZ0K0SIrhq
 9kSx7nlTqehA0frXb0ESFMiR/U0zYWXQDB80ho36u99PZ4IM0znSJgEM4c6hbq4a2EfV
 cqM9eDVkHM0Cc4V//hx1JAqUMyrVjC0ALgx4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771666979; x=1772271779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5SpwVBfDTYR9+u4Mo5qtV6hRcGkLnuLeVILyHGsncm8=;
 b=P/wP9tlHQ0gwnG9Z9cen6UyNt/+FdwEFCstBBZ5VuLqYoh3F0AlNmZpRHwAMtvW8B0
 /yNskM78BqJk5FND4hBkSP9lWCZHmrmMmbyMjYyTJcdf3DLENofZ0JzlrO2h73hRteAS
 MlJBwQTyv/Ld7Nh+U3+WwQZRbTMBD9pFy84XRfX86oDzbZPamXfU2ErF96kRfHQVaj+P
 ACxrfEEqz3OmOajycBbwcuJQBRPvP3h6ckGD/0xwbG+lfVIpzNo3FIztddOVy1H2mYSy
 kztg0wy9l92pL6Ie3UzyDsQRt9Eo13ybttnUDNlWxDeojGdTk3lXi9mB6YZJlVPS76Ru
 epJw==
X-Gm-Message-State: AOJu0YwGGCNN0MNwCrICqa8Kny+QHsrjgmaFOltv9gFdOW15mWd+T0I/
 XCJJjzOmc+OQjnwc8kJq1Cg5kcO79OYiTKMarS2zPnWQ9uqaqJ+3BYk+D1xE3BSx0Up7E5pLHrl
 0rtRY
X-Gm-Gg: AZuq6aIRsdEOcDrYGeh9srLfqkVHzoJFtCGQ8h93E7Y4ZLt86MfOM19LG/LY4DN287H
 q6kP1HDt1g/uC2zjKpNNEc3kJaK4Yu/KdQisNv6TVJRscC2nds50CUS3dj+k8v5JQwN5f9kRLWf
 DQV8SAW/W7joQwvd79IX/v1uu/k3ui5r8sklcde2J1Ca/u+AdusrFCGsJzUSepFM4UqK0+7v2Bn
 mCttCHa4vhhHEYwFCTzYShCShpl7Y+TVxzrQOSNM+5XxlXYIRzdNMwF6jca77/GydQigjaDK6TG
 avFZAOU1S6lMrLa70pjQAAJDiVvNFbdMbO5Ho+CedvCEi5Cv+VVEAwbnmB0h4fMpSam2tTC01yb
 KWuqQz/fJQiEyZp5GhjgLRSWNvmfU9ZSosrcFHEdWegOqVymlq/1E1BuwlOaniWPqxr9q9sveAl
 4HfMvx2YiVOH1qIE+/QnDa4fhfDlNLERXlbmyTkws7iAytM0STGL73Cz5ZBnXZOGDUEtuS+01EU
 RgI7aNVmiRJ5wO/Z+0TShzpSgFzlPeeynytA0J1JZdZmyPploCn2cCt9ulqowZO6SOYk7p3/HJ1
 Ytr5VrMLANGEkFuYbrrieo2T
X-Received: by 2002:a05:600c:64ce:b0:47f:b737:5ce0 with SMTP id
 5b1f17b1804b1-483a96378f0mr35132405e9.23.1771666978815; 
 Sat, 21 Feb 2026 01:42:58 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a42f3968sm42694225e9.19.2026.02.21.01.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 01:42:58 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/8] spi: add support for bits-per-word setting
Date: Sat, 21 Feb 2026 10:42:15 +0100
Message-ID: <20260221094252.3103034-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260221094252.3103034-1-dario.binacchi@amarulasolutions.com>
References: <20260221094252.3103034-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v1)

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

