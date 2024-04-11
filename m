Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3C3C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 22:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A3378822B;
	Fri, 12 Apr 2024 00:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="FJ/O9thL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFAB888229; Fri, 12 Apr 2024 00:37:48 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 552478821A
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 00:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-dc25e12cc63so1360428276.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 15:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1712875065; x=1713479865;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ez5KAUpmv7EhJN0xXjFazlw/untzxRkYccdlhMzF6g=;
 b=FJ/O9thLkpDwsDYYfcijdozjQamv7+GAYLWAoiiVcBx2Hamb7woXqsD4uu6ntqucQF
 MfgV/ADyzjIFGt1DAymVsHn4/UkeJM9NlonhETzWyAD8iyz2MwDWIGti4E2azsy1jYRx
 THrWizKiKymB4oOqzXuONXsZcB00SvHpnlnf2tL0CeQaiPD0SNF35zgyZgxbR8cQCIQv
 k2lcepxbkPntShjxvXpvmzzd6/O+0Chs/Z7By/lVD+5pPjxjpml1RRiRTwKtGbBDyAVe
 TIUYnljkQRvlSElzez/ICZZI2qyFdLTLR6R+/1UTLlSiLPeUumKmLito/rLokfUdSD+A
 RXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712875065; x=1713479865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ez5KAUpmv7EhJN0xXjFazlw/untzxRkYccdlhMzF6g=;
 b=dUZzVNuvIpu7UpxEXwsWRkPHoz39opUW6qz9nEJem4g6T6GVO1vW/tPeDRbMeC6tYe
 5CH/tBfNiBytVpxOwUdhzmcjATJ+j30YtfXAeGy2E8vuJUcXT+8qEZQEeeU9r7dzXPVS
 vHo+dWUTqVpRFyAlPzJVWDk+gJogO/9mufs9pBAwcPPMk0l8Jdw9AcW9Oo9x4Bq4RqQn
 +QK3EpCSwVBjhNaunrqWcsOj2jrtNlvLDEM8AHL27aNQk4hyKmvgIpPE82uIR4xyXRi7
 i4fuFMOZk138qrXNPM5EDZNU0W4ZwYTXDVRgb3jqBwndN3V4xEqUndWCJUfza4ja/nL2
 oUDw==
X-Gm-Message-State: AOJu0YwiBCYQiB9aRCbzXA2GbSDqPPggQYfqWh1nPSE2Ls/SingFruMn
 Co9b6gMimU5AtRLuGXcswcCg+3klln+HGpBL/XuJ4fm5LucI2Rbz/c5thjgi4Vj4PhZefSUO2ye
 VSw==
X-Google-Smtp-Source: AGHT+IFbXSXaKJ0FaJ39SbncBgLof/wK3ldyAJjq/0E1TsodUI7dLQevWNSZPoiL5tEyxhqcqS49xQ==
X-Received: by 2002:a25:5144:0:b0:dcf:eb30:c580 with SMTP id
 f65-20020a255144000000b00dcfeb30c580mr1036582ybb.3.1712875064792; 
 Thu, 11 Apr 2024 15:37:44 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a25f90b000000b00dcbbea79ffcsm482744ybe.42.2024.04.11.15.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 15:37:44 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Arturs.Artamonovs@analog.com, Vasileios.Bimpikas@analog.com,
 Utsav.Agarwal@analog.com, Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, Apurva Nandan <a-nandan@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/11] spi: cadence-quadspi: Direct mode does not support zero
 length addresses
Date: Thu, 11 Apr 2024 18:36:52 -0400
Message-ID: <20240411223709.573-9-greg.malysa@timesys.com>
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

It is not possible to configure the Cadence SPI IP block to use a zero
length address in DMA read or write commands.

Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
---

 drivers/spi/cadence_qspi_apb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 2600370f85..340889c271 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -784,7 +784,7 @@ int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
 
 	cadence_qspi_apb_enable_linear_mode(true);
 
-	if (priv->use_dac_mode && (from + len < priv->ahbsize)) {
+	if (op->addr.nbytes && priv->use_dac_mode && (from + len < priv->ahbsize)) {
 		if (len < 256 ||
 		    dma_memcpy(buf, priv->ahbbase + from, len) < 0) {
 			memcpy_fromio(buf, priv->ahbbase + from, len);
@@ -970,7 +970,7 @@ int cadence_qspi_apb_write_execute(struct cadence_spi_priv *priv,
 	size_t len = op->data.nbytes;
 
 	cadence_qspi_apb_enable_linear_mode(true);
-	if (priv->use_dac_mode && (to + len < priv->ahbsize)) {
+	if (op->addr.nbytes && priv->use_dac_mode && (to + len < priv->ahbsize)) {
 		memcpy_toio(priv->ahbbase + to, buf, len);
 		if (!cadence_qspi_wait_idle(priv->regbase))
 			return -EIO;
-- 
2.43.2

