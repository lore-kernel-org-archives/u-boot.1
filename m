Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279ABC25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 10:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D36B888760;
	Tue,  7 May 2024 12:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="yWdoMI6L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F8C38875F; Tue,  7 May 2024 12:04:41 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C46A38874A
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 12:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a59a0e4b773so693183466b.2
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 03:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1715076277; x=1715681077; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsXHH3tlBcKEad3v9mRb4Z+8Xx+3jxTikoglNmEAeWE=;
 b=yWdoMI6Ld6qJhL8IxU1DKYqo3xX1Tj+2JC1YQJToHyC6LCVIgjAh6T1aAUl05rlcBB
 8JiLT4shUmjBbM0nOag7MpN6CVXNGCCQs/YQiso0/3nzM6nBImMXhCIc1zTDo6OBC+cN
 eYzRzD7J0wTvTlw0q3b5qpFqLL+wW8ir7wX9jgkc2G1NyglLFG6iiJpD6H4iBWxx0Nkg
 OR1z2dsJHvkHRwClxqxTuIByJT2h99nTRahynDmuz7OVLtWos19xkq57axMfI6eY6pd7
 RZmo8FA8lSE85RoVycK2uz9cbNF3cEbZ5CG0V9TKxMic5SsW/HjXRs9ljkAZBPx3S/cD
 a/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715076277; x=1715681077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vsXHH3tlBcKEad3v9mRb4Z+8Xx+3jxTikoglNmEAeWE=;
 b=cJx3/Z3QvBzZyiVj+z8jqbZoSYQMC6muBCTx2gRSOVVo3k4EYmJWSls+jKkSoN9Hla
 rWVLIR6YvziYzyreU8DxL5U+hDtiUq2xGkZFf5wkuAX2g85LUzgF3VdgV3TgE4dve40u
 TOCsCPx6WfmYr4D16rzzWAQGzJahnqtOr63Gl/vPzKJVSaF31geDZKlVgktxedAWq0OF
 7kG0wHQDgvoooQR8fvqboJhRV990xWERTjJd07sQyRBGvfVI+TsTyd8Xly8+uRT78mu8
 F8q6ftbC5db0cxieFevxFYgca3xHDPujMUgeA7AtkPBP5tl4sZ/CXdNRRh4qbNnGaGdU
 B9aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpFYDUVT5avtTjg7SAR7qCt4fS3S2EPwSYIopqPi71nUKXxY7iswpZvQH4euOpbuHv/taoirny4eoj0uwVPD1fT5uKVA==
X-Gm-Message-State: AOJu0YxEq7q6wrQRoOrqE59DDhEFywlVTZk56EOqUqLHz9ksrEuN6a2X
 wObANU61afl5ZeEFjQ3MFi/3SPRwjhfORJL6Vk8NTz9OL8QzseFr5z/Zc2/v4WU=
X-Google-Smtp-Source: AGHT+IEBIsPkFRIEz1Fio5lTmKH2kAk/uOMArOGJTVuetUEFCwRNe5pBFwOH3TCKXRlN6IKV2fTdbA==
X-Received: by 2002:a17:906:a43:b0:a59:c090:7780 with SMTP id
 x3-20020a1709060a4300b00a59c0907780mr4323355ejf.7.1715076277307; 
 Tue, 07 May 2024 03:04:37 -0700 (PDT)
Received: from fedora.. (cpe-188-129-46-59.dynamic.amis.hr. [188.129.46.59])
 by smtp.googlemail.com with ESMTPSA id
 s20-20020a170906455400b00a59c4a16e4asm2878350ejq.120.2024.05.07.03.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:04:36 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: sjg@chromium.org, trini@konsulko.com, jagan@amarulasolutions.com,
 vigneshr@ti.com, marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [RFC PATCH 3/5] mtd: spi-nor: rename and export 4-byte adressing mode
 function
Date: Tue,  7 May 2024 12:03:51 +0200
Message-ID: <20240507100431.206670-4-robert.marko@sartura.hr>
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

Currently 4-byte adressing mode function is not exported, but since we plan
to use it outside of the SPI NOR core we need to export it.

While we are here, rename it to align the naming with the rest of exported
functions.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/mtd/spi/spi-nor-core.c |  7 +++----
 include/linux/mtd/spi-nor.h    | 10 ++++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 8882b045ce..8a64ee40c3 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -682,8 +682,7 @@ static void spi_nor_set_4byte_opcodes(struct spi_nor *nor,
 #endif /* !CONFIG_SPI_FLASH_BAR */
 
 /* Enable/disable 4-byte addressing mode. */
-static int set_4byte(struct spi_nor *nor, const struct flash_info *info,
-		     int enable)
+int spi_nor_set_4byte(struct spi_nor *nor, const struct flash_info *info, int enable)
 {
 	int status;
 	bool need_wren = false;
@@ -3481,7 +3480,7 @@ static int s25_s28_post_bfpt_fixup(struct spi_nor *nor,
 	 */
 	if (params->size > SZ_128M) {
 		if (bfpt->dwords[BFPT_DWORD(16)] & BFPT_DWORD16_EX4B_PWRCYC) {
-			ret = set_4byte(nor, nor->info, 1);
+			ret = spi_nor_set_4byte(nor, nor->info, 1);
 			if (ret)
 				return ret;
 		}
@@ -3915,7 +3914,7 @@ static int spi_nor_init(struct spi_nor *nor)
 		 */
 		if (nor->flags & SNOR_F_BROKEN_RESET)
 			debug("enabling reset hack; may not recover from unexpected reboots\n");
-		set_4byte(nor, nor->info, 1);
+		spi_nor_set_4byte(nor, nor->info, 1);
 	}
 
 	return 0;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 80e56cf308..94c0e5e98f 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -646,6 +646,16 @@ static inline int spi_nor_remove(struct spi_nor *nor)
  * Return: 0 for success, -errno for failure.
  */
 int spi_nor_remove(struct spi_nor *nor);
+
+/**
+ * spi_nor_set_4byte() - perform cleanup before booting to the next stage
+ * @nor:	the spi_nor structure
+ * @flash_info:	the flash_info structure
+ * @enable:	enable or disable 4byte mode
+ *
+ * Return: 0 for success, -errno for failure.
+ */
+int spi_nor_set_4byte(struct spi_nor *nor, const struct flash_info *info, int enable);
 #endif
 
 #endif
-- 
2.45.0

