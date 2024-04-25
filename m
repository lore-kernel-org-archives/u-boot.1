Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04D5C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 14:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2CE388FD8;
	Thu, 25 Apr 2024 16:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="rY4/Fnlt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAF3488080; Thu, 25 Apr 2024 16:36:34 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92E7488FD4
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 16:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a51f9ad7684so73026166b.2
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 07:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1714055792; x=1714660592; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhvK/Ygto9oeYN2EUP3dmZ9Ix/3oFSBPptIrw7cEZwQ=;
 b=rY4/FnltjQwqnreZ5xEJZt6vAngj62RquX6CMvlzlpVI6ZPjqeQlVtliCHoaE6nOWE
 7H4CFbolljE+lK4IjgbrFo9X2/HiO7dyqy7oooDgFW/ZTNg2HEbu84g5kQMaVyCzG6Yf
 Pa7wcp+Kzgw9m2ybttxUC7C0SBYyoEZiWKAe4+/8jjwb1fSxVBfolahK36++nSlnR77M
 smnH44hf5AQTSXXVwTdwHmF1TFJe0hKfH223DKeT8tsIKJ0IkhNeZ5mpXfERja5LVclV
 5AuIWFtHR6D0o3hZ4JztRTpTj/47histI16RkLcaWdCEmcITvZ8d6qtu2Yb/wt0euK2L
 UHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714055792; x=1714660592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhvK/Ygto9oeYN2EUP3dmZ9Ix/3oFSBPptIrw7cEZwQ=;
 b=uXr1tW+PTEQaXyhTjfIrLUvXBqV5pCJAOebY+aIIb9bbyT9X9c0pQL1KcJIbA4i9tl
 ogZEIy51fx8IeFngBv30rpqQ9JfvP0EWcAqpkRfcLEsO2micw9h52yjcOu1dSLa+d6Z4
 m5xALAjZ1IRi25BQcdpCfHV2GUDnuN80Nl+ID/gz3cCbLdC/rDUocmyxo/JFSUBcIc4z
 f99xTc6y5NDaE41kYXqYlF9xDIRmVtgOoVf0IQ7eo3bXMWVwzPyy8uUcTNJzXgEe4wAP
 NcTbwgLJE4eyYimiTDn6M/jbJbT+485ztJGjP9qECu9EoIqRXqwWJmj0bywrhOomRGwL
 DHyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0JC7CXkWDrJC8SCsKKBWN9TNjJp+rIBoZJiHdnfurd9NNtBxbiTAUQXRm64tqfE3NB35Wznpy5Xiuv8GrYy9nkLauAQ==
X-Gm-Message-State: AOJu0YxlYkCsdfP7r4x/inZN8hsMW5QHeLon+oR5sSku5ZH8Nba/pi0p
 e9dCfxf9KVt2IJSVcIIQXpviuIVQj+vFwTuefV8iczCkPyXzoImBykG741x7WAo=
X-Google-Smtp-Source: AGHT+IFXXY5xjYnxQTyFTpHnOdZq9MEqc8MpqI7SI5jlLhlb6oJjxDOvzwpGFC7IDQI9tOCPWMZDZA==
X-Received: by 2002:a05:6402:2033:b0:572:325a:8515 with SMTP id
 ay19-20020a056402203300b00572325a8515mr4327282edb.36.1714055792003; 
 Thu, 25 Apr 2024 07:36:32 -0700 (PDT)
Received: from fedora.. (cpe-188-129-47-40.dynamic.amis.hr. [188.129.47.40])
 by smtp.googlemail.com with ESMTPSA id
 l6-20020aa7d946000000b005723151e99asm1856781eds.95.2024.04.25.07.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 07:36:31 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: jagan@amarulasolutions.com, vigneshr@ti.com, trini@konsulko.com,
 u-boot@lists.denx.de
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/2] mtd: spi-nor-core: add 4-byte OPCODE support for Winbond
 W25Q256JV
Date: Thu, 25 Apr 2024 16:36:16 +0200
Message-ID: <20240425143627.54648-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425143627.54648-1-robert.marko@sartura.hr>
References: <20240425143627.54648-1-robert.marko@sartura.hr>
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

Winbond W25Q256FV and W25Q256JV share the same JEDEC ID, but only
W25Q256JV fully supports 4-byte OPCODE-s.

In order to differentiate between them we can use the SFDP header version
and apply a fixup post BFPT.

Based on upstream Linux commit ("mtd: spi-nor: winbond: Fix 4-byte opcode
support for w25q256").

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/mtd/spi/spi-nor-core.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 7615ba602f..8882b045ce 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3816,6 +3816,32 @@ static struct spi_nor_fixups macronix_octal_fixups = {
 };
 #endif /* CONFIG_SPI_FLASH_MACRONIX */
 
+#if CONFIG_IS_ENABLED(SPI_FLASH_WINBOND)
+static int w25q256_post_bfpt_fixup(struct spi_nor *nor,
+				   const struct sfdp_parameter_header *header,
+				   const struct sfdp_bfpt *bfpt,
+				   struct spi_nor_flash_parameter *params)
+{
+	/*
+	 * W25Q256JV supports 4B opcodes but W25Q256FV does not.
+	 * Unfortunately, Winbond has re-used the same JEDEC ID for both
+	 * variants which prevents us from defining a new entry in the parts
+	 * table.
+	 * To differentiate between W25Q256JV and W25Q256FV check SFDP header
+	 * version: only JV has JESD216A compliant structure (version 5).
+	 */
+	if(header->major == SFDP_JESD216_MAJOR &&
+	   header->minor == SFDP_JESD216A_MINOR)
+		nor->flags |= SNOR_F_4B_OPCODES;
+
+	return 0;
+}
+
+static struct spi_nor_fixups w25q256_fixups = {
+	.post_bfpt = w25q256_post_bfpt_fixup,
+};
+#endif /* CONFIG_SPI_FLASH_WINBOND */
+
 /** spi_nor_octal_dtr_enable() - enable Octal DTR I/O if needed
  * @nor:                 pointer to a 'struct spi_nor'
  *
@@ -4004,6 +4030,11 @@ void spi_nor_set_fixups(struct spi_nor *nor)
 #if CONFIG_IS_ENABLED(SPI_FLASH_MACRONIX)
 	nor->fixups = &macronix_octal_fixups;
 #endif /* SPI_FLASH_MACRONIX */
+
+#if CONFIG_IS_ENABLED(SPI_FLASH_WINBOND)
+	if (!strcmp(nor->info->name, "w25q256"))
+		nor->fixups = &w25q256_fixups;
+#endif /* SPI_FLASH_WINBOND */
 }
 
 int spi_nor_scan(struct spi_nor *nor)
-- 
2.44.0

