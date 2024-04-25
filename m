Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76559C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 14:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C48488FC0;
	Thu, 25 Apr 2024 16:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="AdHzbMHM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFB2E88FD6; Thu, 25 Apr 2024 16:36:33 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D89B488080
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 16:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5723edf0ae5so971170a12.0
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 07:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1714055791; x=1714660591; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lkuhd3Z9OBSws+Ugivb47MQEwAUIrDJTPPLs0tI1G6A=;
 b=AdHzbMHMSbfRp50pSe86OlcAk9aOHZM4ZbGMfnNeEoLqr3Mzdx4ins25d9glWqlHfI
 mBIcgpXEfmArYz/Cql80/8jQo7L4IqAX2VpXasswNzzw7huSEEnJ5vpqTsFWChZ4859a
 9PFLAlOvnCbN0Lg2LFx9QCQxWE4AdeWgZx1rabTJBHUdRsi2jk/nsQFXqceoU9DRueeC
 /J20ryPh4VSuKfCLOjuNiEMjCBpZRSnjFWMS2cN35+j2rnJ3Se5tiTobULQkQ5rDah53
 thvc60NODnU4CWlefZzf14sTCInsPsE7KRWs46ZQPNMMsMP1tIw4NXNb2C0yS7Ip5We0
 B9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714055791; x=1714660591;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lkuhd3Z9OBSws+Ugivb47MQEwAUIrDJTPPLs0tI1G6A=;
 b=F85zDzrrtT3ulm/01ZrxGx9v20wDsSEjP0Al1OeLR+F0clgJ+Ay+4Gr3TShFAcP8Se
 HIqGzai/gjmYy5OrMCaNVPvQNmMi7bdH7yQvd16fEVFoIW5AcSHw9lLtNUEQE8znEznd
 csvE13/ft9Cize6lmHPnKqs3DSI4VBRe7J0hxNlTDqE82Nn8z6QtiEjnxCg5qcj9LhX2
 eMxGCJp7cyFyR9R8+wyeGczTpKp0qMjtdu3BBdT0A4IcUhpyvD7ZMqFRMu3SAxYekQlJ
 ACloLbUSVuGRvhFm7mpM476Ulqd4Bn7l9wqxYXFpTPyPvF8kKzAFx8ohYizbvu5vxZLs
 Unaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ2hrlDPT9eJM+i+nyL8tpa5Em9YBqbn8TqcKqqRg/10Br3/RmN+3vLMPEIbtFIJteNgvIDy51wOeehgF+TDMhnvvWQw==
X-Gm-Message-State: AOJu0YxBw7pKZHGZWPpJUP8cbCTCwvV2jfEm4BgM+eLSmZZs17xtIiqW
 Bqwfv//RlT5HtlAxD4MCK7PedwdTAnzApx3kpZXAACuwHX8SctYo6AU6yA5Zy7Y=
X-Google-Smtp-Source: AGHT+IHe07qT8eOXbfJgBf2PHAZEjRx2+NnCzJ01NahzyHBhaFws9oDD5qS+hMh4T4DSO4pLQkeojQ==
X-Received: by 2002:a05:6402:2546:b0:572:2f0f:df37 with SMTP id
 l6-20020a056402254600b005722f0fdf37mr4640490edb.5.1714055790983; 
 Thu, 25 Apr 2024 07:36:30 -0700 (PDT)
Received: from fedora.. (cpe-188-129-47-40.dynamic.amis.hr. [188.129.47.40])
 by smtp.googlemail.com with ESMTPSA id
 l6-20020aa7d946000000b005723151e99asm1856781eds.95.2024.04.25.07.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 07:36:30 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: jagan@amarulasolutions.com, vigneshr@ti.com, trini@konsulko.com,
 u-boot@lists.denx.de
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/2] mtd: spi-nor-core: allow overriding 4-byte OPCODE support
Date: Thu, 25 Apr 2024 16:36:15 +0200
Message-ID: <20240425143627.54648-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
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

Currently, the only way to indicate 4-byte OPCODE support is by setting
the SPI_NOR_4B_OPCODES feature flag for each JEDEC ID in spi_nor_ids[].

However, its becoming increasingly common practice for vendors to reuse
the same JEDEC ID for new revisions of current parts.
For example Winbond W25Q256FV does not fully support 4-byte OPCODE-s while
newer W25Q256JV revision does fully support them but they share the same
JEDEC ID thus currently its not possible to advertise support for 4-byte
OPCODE-s on W25Q256JV.

Luckily for us, there usually is a way to differentiate between parts with
the same JEDEC ID by differences in SFDP tables, so in order to be able to
apply a fixup after they are parsed lets add a feature flag that we can
override.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/mtd/spi/spi-nor-core.c | 6 ++++--
 include/linux/mtd/spi-nor.h    | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index f86003ca8c..7615ba602f 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3879,7 +3879,7 @@ static int spi_nor_init(struct spi_nor *nor)
 	if (nor->addr_width == 4 &&
 	    !(nor->info->flags & SPI_NOR_OCTAL_DTR_READ) &&
 	    (JEDEC_MFR(nor->info) != SNOR_MFR_SPANSION) &&
-	    !(nor->info->flags & SPI_NOR_4B_OPCODES)) {
+	    !(nor->flags & SNOR_F_4B_OPCODES)) {
 		/*
 		 * If the RESET# pin isn't hooked up properly, or the system
 		 * otherwise doesn't perform a reset command in the boot
@@ -4118,6 +4118,8 @@ int spi_nor_scan(struct spi_nor *nor)
 		nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
 	if (info->flags & USE_CLSR)
 		nor->flags |= SNOR_F_USE_CLSR;
+	if (info->flags & SPI_NOR_4B_OPCODES)
+		nor->flags |= SNOR_F_4B_OPCODES;
 
 	if (info->flags & SPI_NOR_NO_ERASE)
 		mtd->flags |= MTD_NO_ERASE;
@@ -4156,7 +4158,7 @@ int spi_nor_scan(struct spi_nor *nor)
 		/* enable 4-byte addressing if the device exceeds 16MiB */
 		nor->addr_width = 4;
 		if (JEDEC_MFR(info) == SNOR_MFR_SPANSION ||
-		    info->flags & SPI_NOR_4B_OPCODES)
+		    nor->flags & SNOR_F_4B_OPCODES)
 			spi_nor_set_4byte_opcodes(nor, info);
 #else
 	/* Configure the BAR - discover bank cmds and read current bank */
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index d1dbf3eadb..80e56cf308 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -294,6 +294,7 @@ enum spi_nor_option_flags {
 	SNOR_F_BROKEN_RESET	= BIT(6),
 	SNOR_F_SOFT_RESET	= BIT(7),
 	SNOR_F_IO_MODE_EN_VOLATILE = BIT(8),
+	SNOR_F_4B_OPCODES 	= BIT(9),
 };
 
 struct spi_nor;
-- 
2.44.0

