Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED29C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 22:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA20881FD;
	Fri, 12 Apr 2024 00:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="KDjHERth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EB4B881F1; Fri, 12 Apr 2024 00:37:48 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE2E1881F1
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 00:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-dd161eb03afso327506276.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 15:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1712875063; x=1713479863;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cwmGtDM/sA+95pY5uIfDWYc2ODxI8hTv7lUwHq58KoM=;
 b=KDjHERthIo/pBrNOuEq12jje4LfKhe3iCjVNq7DaLuTe4CSkU9wnRome4PD8Q71Zxu
 KrEiPpalF4Hi8bJfPRQsiu1vlhbfzVtbEjqf+wmx4le+0ywTLFjBiFH/wJZocedsuCjk
 jLMPt5QPTYdxWRbdeAvIz0YJfnHzNtAAUvon0qtSCH86C6vbD5lSqEr+/0ykrJJ4Supw
 izmU040pEX/zwF/r8GK5CZy5y/RCI//9G/Pc8TKe71UouB8TOs1x+I9DADfac+iJLoSp
 cmU+wyTD7Ff/aT+lRr0L6EmAV3QVoa6nzufCSZuurZBNE4Zkju7Ken/TIBxM90TmaL2/
 uYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712875063; x=1713479863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cwmGtDM/sA+95pY5uIfDWYc2ODxI8hTv7lUwHq58KoM=;
 b=xIk/7A0czgPH5F59k86i04416Az/U7Mgyab1ZayjyUSeTGULW2nX/J2HSgpQujKda6
 kF2K0tiKOC5p0a1/g3mhjTD5g9ZfdqK6kozEDsteI3M1RZCnQafV3re+yvgZ9r2/xDWG
 9O47Xo6DYhdIE2QomO0hwtgWCHD7F10O5NiBs4kq2DxK0WU7rkn6kpRe5GEB47TeaSGg
 bek3v8mgp/Fr6zHs1VSBeczRf6AJDt3ccdOvbU7/gx5tlaleVyEnW0LE9fqgioKDldgP
 9pjRWK7nrB0kuvjyRtBZwONwg+10xV2or7/W72u8BVVJTvadUoANJ/cpAfexpuxS9KBo
 vfCg==
X-Gm-Message-State: AOJu0YwtIB4AYeQNZUeZHusomeel4ABVqTm6D3KA7PYz84Qh0rzb4HQJ
 yC7l/vlS5PDn6HKwfFhyZgPeIW3ep3Rz2VF5o049i7bW2mna9iajO/gPiKaLqKysaceNuMoEYBP
 yqg==
X-Google-Smtp-Source: AGHT+IEzmz9/m3IwN68W4zDwoljswLSBXzaAD256VSuCysxg2axm3TXVJgQSr6TqTbKl89dqnBX12A==
X-Received: by 2002:a25:b193:0:b0:dcf:bc57:cd61 with SMTP id
 h19-20020a25b193000000b00dcfbc57cd61mr932181ybj.50.1712875063526; 
 Thu, 11 Apr 2024 15:37:43 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a25f90b000000b00dcbbea79ffcsm482744ybe.42.2024.04.11.15.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 15:37:43 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Arturs.Artamonovs@analog.com, Vasileios.Bimpikas@analog.com,
 Utsav.Agarwal@analog.com, Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, Apurva Nandan <a-nandan@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/11] spi: cadence-quadspi: unconditionally disable auto
 status register reads
Date: Thu, 11 Apr 2024 18:36:50 -0400
Message-ID: <20240411223709.573-7-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240411223709.573-1-greg.malysa@timesys.com>
References: <20240411223709.573-1-greg.malysa@timesys.com>
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

From: Ian Roberts <ian.roberts@timesys.com>

In addition to the given reason for the conditional disable
of this feature for DTR:

Theoretically, some flashes have their WIP bit in different
bit positions or have a different bit polarity. spi-nor
currently does not have an interface in place to dictate
this information to this driver for proper configuration.

The default of the controller hardware has this status register
auto polling without expiration. This means that if there is any
controller misconfiguration or communication failure, it will
completely lock up the controller.

Thus, unconditionally disable this feature for now.

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
---

 drivers/spi/cadence_qspi_apb.c | 46 ++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 176cff5338..d347cb8d47 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -853,19 +853,29 @@ int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
 
 	writel(op->addr.val, priv->regbase + CQSPI_REG_INDIRECTWRSTARTADDR);
 
-	if (priv->dtr) {
-		/*
-		 * Some flashes like the cypress Semper flash expect a 4-byte
-		 * dummy address with the Read SR command in DTR mode, but this
-		 * controller does not support sending address with the Read SR
-		 * command. So, disable write completion polling on the
-		 * controller's side. spi-nor will take care of polling the
-		 * status register.
-		 */
-		reg = readl(priv->regbase + CQSPI_REG_WR_COMPLETION_CTRL);
-		reg |= CQSPI_REG_WR_DISABLE_AUTO_POLL;
-		writel(reg, priv->regbase + CQSPI_REG_WR_COMPLETION_CTRL);
-	}
+	/*
+	 * Some flashes like the cypress Semper flash expect a 4-byte
+	 * dummy address with the Read SR command in DTR mode, but this
+	 * controller does not support sending address with the Read SR
+	 * command. So, disable write completion polling on the
+	 * controller's side. spi-nor will take care of polling the
+	 * status register.
+	 *
+	 * Theoretically, some flashes have their WIP bit in different
+	 * bit positions or have a different bit polarity. spi-nor
+	 * currently does not have an interface in place to dictate
+	 * this information to this driver for proper configuration.
+	 *
+	 * The default of the controller hardware has this status register
+	 * auto polling without expiration. This means that if there is any
+	 * controller misconfiguration or communication failure, it will
+	 * completely lock up the controller.
+	 *
+	 * Thus, unconditionally disable this feature for now.
+	 */
+	reg = readl(priv->regbase + CQSPI_REG_WR_COMPLETION_CTRL);
+	reg |= CQSPI_REG_WR_DISABLE_AUTO_POLL;
+	writel(reg, priv->regbase + CQSPI_REG_WR_COMPLETION_CTRL);
 
 	reg = readl(priv->regbase + CQSPI_REG_SIZE);
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
@@ -970,16 +980,8 @@ int cadence_qspi_apb_write_execute(struct cadence_spi_priv *priv,
 	const void *buf = op->data.buf.out;
 	size_t len = op->data.nbytes;
 
-	/*
-	 * Some flashes like the Cypress Semper flash expect a dummy 4-byte
-	 * address (all 0s) with the read status register command in DTR mode.
-	 * But this controller does not support sending dummy address bytes to
-	 * the flash when it is polling the write completion register in DTR
-	 * mode. So, we can not use direct mode when in DTR mode for writing
-	 * data.
-	 */
 	cadence_qspi_apb_enable_linear_mode(true);
-	if (!priv->dtr && priv->use_dac_mode && (to + len < priv->ahbsize)) {
+	if (priv->use_dac_mode && (to + len < priv->ahbsize)) {
 		memcpy_toio(priv->ahbbase + to, buf, len);
 		if (!cadence_qspi_wait_idle(priv->regbase))
 			return -EIO;
-- 
2.43.2

