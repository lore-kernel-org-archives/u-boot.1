Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5560DC25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 10:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44F9A88742;
	Tue,  7 May 2024 12:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="SA5IrlNA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C284888742; Tue,  7 May 2024 12:04:42 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9B3988750
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 12:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a59a5f81af4so752158066b.3
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 03:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1715076278; x=1715681078; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZFM/0jiokvrFy3Z+ryB6aiOjjvnOIQs2tA/TbvBVuE=;
 b=SA5IrlNAlxK63jUyfNy/QrJwLacTdxnY21c0bBHSgeoPdpen5jkTGZGpIFq3XevXcq
 frblBFytmtdh06fiOgFlHM+YIAUCWjTcKKTiKjEQym+t0vA47az2wBHSDmlu2TXWNQSo
 +AY+STKBPTEw2xerSL7WvSxHHbpEtYz3jXs8t7W97hk8nlx8qPbCuSXj2WVtbxc3WUM4
 IX/FWZXsTn09HapSXLjCdiVH3K3WlIiCvMfn89DvV90hgxukdqj+aIzID5zzrtbqsJ4q
 ijIuBYudBRBzvaXQ/IWWcr1sQ+XDEdHpkzOy8qNXvKc1DwAZuwacO4ir2jE2byMESRqs
 5AVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715076278; x=1715681078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LZFM/0jiokvrFy3Z+ryB6aiOjjvnOIQs2tA/TbvBVuE=;
 b=clKQcrcttpKSe2gkjdusNOMAyyGKkveECAS6NIa5/LZvHuvLyHWhhpP+5leHniDjO6
 qOZ+Hz3pO+10dip8PSGLw4Y49gHgphpWr+vUJsFHDdGYawI5KcApvcBEohhQiFtLB7hz
 z5m/ncLFDAgGtf1lg/yX5j+QpV315snf8IzT8BTcVKSwHXUcSD+9t5vuWK8o2ar2wmGK
 E3MR4g1C5rI+NkOIeOh8oQIk+BMh94ooTfpvrjGP1Za9xhimFt7NvGpXYDgeR2WXPPnF
 Lq7+NrN4fIn1/wMJYxfNH5VdMgRYCl31ZF1bGlKbTjChLNF1Dhsxsf9TfXREzuW5+9RB
 MGPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKdyE8QrIo71Lm6pf7Gn+RTvjOn+GWlXmWkTCWOy1nMNHLmM1S7V2l5Km6yr+kD5UDocNW/NG7r0D6XQTN2Qc7QwngLg==
X-Gm-Message-State: AOJu0YxDikvtuGk05cRX50Br+F5S7NwMUetQ49nz9mzJdhJGKTWHzFve
 3pWrolQRIa9EfYZYwdS1gCRiuNVXfIQntmOyx/VhWVJPtnr+nJoyFz86bZlYk2Q=
X-Google-Smtp-Source: AGHT+IE7YS+eiSCXqnEQUyag70UdlzhA/d85p4C6V3b6QPN9x1CUaNoTrwmQ9VeZOm2awZJv06gtpQ==
X-Received: by 2002:a17:906:a159:b0:a58:e71d:d74 with SMTP id
 bu25-20020a170906a15900b00a58e71d0d74mr7617021ejb.13.1715076278328; 
 Tue, 07 May 2024 03:04:38 -0700 (PDT)
Received: from fedora.. (cpe-188-129-46-59.dynamic.amis.hr. [188.129.46.59])
 by smtp.googlemail.com with ESMTPSA id
 s20-20020a170906455400b00a59c4a16e4asm2878350ejq.120.2024.05.07.03.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:04:37 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: sjg@chromium.org, trini@konsulko.com, jagan@amarulasolutions.com,
 vigneshr@ti.com, marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [RFC PATCH 4/5] mtd: spi: sf: implement .on_reset method
Date: Tue,  7 May 2024 12:03:52 +0200
Message-ID: <20240507100431.206670-5-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507100431.206670-1-robert.marko@sartura.hr>
References: <20240507100431.206670-1-robert.marko@sartura.hr>
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

Implement .on_reset method for SPI flash, by extending the remove method
to exit 4-byte adressing mode in case it was entered before.

This fixes the issue with 4-byte adressing mode being left enabled on
board reset.
That is an issue on Qualcomm IPQ4019 boards since the CPU expects flash
to be in 3-byte adressing mode and will just hang otherwise.

Note that this does not fix a case where you remove the power while U-Boot
is still running and in that case it will still be stuck in 4-byte mode.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/mtd/spi/sf_probe.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/spi/sf_probe.c b/drivers/mtd/spi/sf_probe.c
index de6516f106..31dae17ba0 100644
--- a/drivers/mtd/spi/sf_probe.c
+++ b/drivers/mtd/spi/sf_probe.c
@@ -225,6 +225,15 @@ static int spi_flash_std_remove(struct udevice *dev)
 	struct spi_flash *flash = dev_get_uclass_priv(dev);
 	int ret;
 
+	if (flash->addr_width == 4 &&
+	    !(flash->info->flags & SPI_NOR_OCTAL_DTR_READ) &&
+	    (JEDEC_MFR(flash->info) != SNOR_MFR_SPANSION) &&
+	    !(flash->flags & SNOR_F_4B_OPCODES)) {
+		ret = spi_nor_set_4byte(flash, flash->info, 0);
+		if (ret)
+			return ret;
+	}
+
 	if (CONFIG_IS_ENABLED(SPI_DIRMAP)) {
 		spi_mem_dirmap_destroy(flash->dirmap.wdesc);
 		spi_mem_dirmap_destroy(flash->dirmap.rdesc);
@@ -258,6 +267,7 @@ U_BOOT_DRIVER(jedec_spi_nor) = {
 	.of_match	= spi_flash_std_ids,
 	.probe		= spi_flash_std_probe,
 	.remove		= spi_flash_std_remove,
+	.on_reset	= spi_flash_std_remove,
 	.priv_auto	= sizeof(struct spi_nor),
 	.ops		= &spi_flash_std_ops,
 	.flags		= DM_FLAG_OS_PREPARE,
-- 
2.45.0

