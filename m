Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C17BFD3772
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A9F884183;
	Wed, 25 Feb 2026 17:20:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Vd7tA5Pa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3284D84179; Wed, 25 Feb 2026 17:20:01 +0100 (CET)
Received: from mail-wm1-x32b.google.com (unknown [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7825384137
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48378136adcso41482295e9.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1772036338; x=1772641138;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+RdgwCIFcBUgakrQ/69px0Mb4WK7f682IsrQihAe0k=;
 b=Vd7tA5PardU2s1mVahQ6nQ6ZbQ0xPIfUTjhPbOwwcocPS8/5O27KCSFcqP+0AphGR7
 Lpu561KMqNn1S4p8WYlYgwgRaQYS4YnB1sS/3mXHpvY6SmbvHnal77PwupoAsCJCXDfi
 LaEMEyHNutqqbw9YH9x/M9NlSG+fs/iS3YMXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772036338; x=1772641138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d+RdgwCIFcBUgakrQ/69px0Mb4WK7f682IsrQihAe0k=;
 b=Ipm8Miok6nerJ9jcAdz3mdBMEMumsSl7a33OTx/BzyniamaAyiz1/2GBSjMJx7HbhU
 nlFxg9sal0egMHdXvYgkrQb5+lvkJp+8F0NzqmYCT2AcMWz+zgntnLf7QJsh4yqrx2Cx
 uDgynga4mz+TRS02zsjMAymGLkmni9dHNOtxz7hGGg8nleiUb8daVBbLKp10cB2Y0OM7
 CG9Dqw3K5JOIZquf9ZZG/JZSgiYfpO0XE5+9OZRbk9daUldx3GRU/3kiOcm0ZX6hxoQX
 HNm4r2mf/FEQo6nNVQKJAPetj6irYLe+3yLKmc+jOvLIYAd+RBxpqlhdlVlu6gIuSPPU
 R2/w==
X-Gm-Message-State: AOJu0YyWT6S/iTODhkELaFXT4HiYC0u3n6wsPsjZFItcRrorlW2MYKy1
 RFpFDZ8+TtK+pm3R3oWAaCkBq/owoAAS4/rQ1H9Q3V1lODHlLDs8iPzRXhcROEP8Q97OdrrWA8u
 NrsSg
X-Gm-Gg: ATEYQzz/ri55+HxO+JOx9x/H6EgLgkWVX8PhO+nzFHcM388aNLi4i4X1okU+TATb8ef
 2sU8kZv6QbpqKJqZMC7ZuHmD11UXyyptzfApnryWLPyOmD6U5QZR7MukI9FsTXuxpFcURBZR6P9
 z/ZaUztPAJDEyPZjLlfmRW/ffkQ6aK5Rr03XSR5frqscRJ3aCiGrwMxJu0Rve0TkNTqUkREoliD
 FB+ND8ZC6GL+601UpF9DXSqh+8FtwuNbPd3wksMA5QWhZjm58pg96hR6lhDYNVNzhRKGiw3DnGc
 /aHYcjGOJeWNEc5PsGtCQeRZm5hAv0eivwueHgx8XV/lU8HJDZ2v1SXLAayLPh0GwNiYwDXLYbu
 h9Iy3D37BqEs0Szmw5jfX4NOFIvwmvb2W7uBBm6coQwTWgP5jmzaQ+mBX2Hg6A/UaBaSbvN0mS4
 xqxDdjAniwnZPP73oIAZggrx5mGy7RaBQVa+4rzvptf5E1Rixbo/qqTLixR2vwpHpXu/IlvZWTr
 xXwaZ++Mto1tDviDuM1kAL308JDNQTTsWFtFH9rMHV6McHo
X-Received: by 2002:a05:600c:6815:b0:483:7783:537b with SMTP id
 5b1f17b1804b1-483c21a54d7mr18617235e9.24.1772036337675; 
 Wed, 25 Feb 2026 08:18:57 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.43.111])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f19f5sm186562265e9.1.2026.02.25.08.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:18:57 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <simon.glass@canonical.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/9] spi: add support for bits-per-word setting
Date: Wed, 25 Feb 2026 17:16:52 +0100
Message-ID: <20260225161851.2475274-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
References: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
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
Reviewed-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v3:
- Add Reviewed-by tag of Simon Glass
- Store the default value in struct dm_spi_slave_plat and copy it
  in struct spi_slave

 drivers/spi/spi-uclass.c | 22 +++++++++++++++++++++-
 include/spi.h            | 14 ++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index 49b584c648d6..f70c04994252 100644
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
@@ -215,7 +234,7 @@ static int spi_child_pre_probe(struct udevice *dev)
 
 	slave->max_hz = plat->max_hz;
 	slave->mode = plat->mode;
-	slave->wordlen = SPI_DEFAULT_WORDLEN;
+	slave->wordlen = plat->wordlen;
 
 	return 0;
 }
@@ -582,6 +601,7 @@ int spi_slave_of_to_plat(struct udevice *dev, struct dm_spi_slave_plat *plat)
 	}
 
 	plat->mode = mode;
+	plat->wordlen = SPI_DEFAULT_WORDLEN;
 
 	return 0;
 }
diff --git a/include/spi.h b/include/spi.h
index 2783200d663e..5a98b1cad65e 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -77,11 +77,13 @@ struct dm_spi_bus {
  * @cs:		Chip select number (0..n-1)
  * @max_hz:	Maximum bus speed that this slave can tolerate
  * @mode:	SPI mode to use for this device (see SPI mode flags)
+ * @wordlen:	Word length in bits to use for this device
  */
 struct dm_spi_slave_plat {
 	unsigned int cs[SPI_CS_CNT_MAX];
 	uint max_hz;
 	uint mode;
+	unsigned int wordlen;
 };
 
 /**
@@ -729,6 +731,18 @@ int dm_spi_claim_bus(struct udevice *dev);
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

