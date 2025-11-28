Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852C4CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B26B4845CE;
	Fri, 28 Nov 2025 15:13:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uD7uyy5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDA38844D8; Fri, 28 Nov 2025 11:21:33 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2C1D844C4
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 11:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42b387483bbso1429662f8f.1
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 02:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764325291; x=1764930091;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JZsLdKCOQbmqaX9XcCihZhl2Aap6MtP+aviqwRKGg88=;
 b=uD7uyy5d0vz5O56nnzjGZf+tWQzOXIgoDl2D9To8sP60WBdPxH3sVIa46GLIbw2UMP
 dExvcjOWvRNCTEi9MafT0eEGv3oooShiiq+IDbhzu7WyTeQPseBi6WR5BxGUupnyHSwg
 +b4V125wEJVKCoPUUz6m2gnoMp7O4OqM7kzXjj10Eq9G3j7PN7IhZLDrJBub5qz0W2YT
 C58RBeHcTNq5PIZJMUgnzdFqz21PTpP5/Ch8z08Z4+mt+y37/EJKxINUfo4GNI+tszIG
 xVxp4dQc5LfzhfUY6odbPz/QXE0pHlnfsvhD/uMD/v4bETsvcpnbBYqXtb9voEf1Kd+4
 dASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764325291; x=1764930091;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZsLdKCOQbmqaX9XcCihZhl2Aap6MtP+aviqwRKGg88=;
 b=qEIB4DYFJZZaimb0eFEFtug1BLI8WrZcekKkcv83FzIghUbe3W5hOutITZk0y4kyG1
 SmQ8j+6c2GBHZt7Kq/qlkObMFhXEWfu672djHlD+lb/V2JOWacMx/z3KvShplwG94E02
 cleXzEzCrysqlQRrI83NG17ITGItB/S3kOtDkog5F+SiWUr7JpmKWELMnlIWzAnoEpNu
 2JL/bK4b/BjVb3VJpCwVTKpwOVYkR5UtglTOcqOF4EqbMbNw69TX6D4OaVyWxykD3kH4
 SeS1MO9vSwUOg1rqd9FVTPzfwEXHDtA0gmQbaxj7ApEhnQLY8n3rmgVdypaO5gdQ+olq
 xnPQ==
X-Gm-Message-State: AOJu0Yw1N32WXznSIrj+dNYo0NuHSkfUACHw9AaVG5XuC6wbKbheQT0Z
 ou6hkaoI4ETYUD2XMD2NdGoAU9ucBprQJG6ZEvyzFp2pYahVDL5OLJdwxwTux0dlsLl4U/TQrwd
 sOu5+
X-Gm-Gg: ASbGncs2sEAR2Nt7Q3KxJafs6VwkZZ4whGRpzMYFngBK0SRLvtVUqEEJBeNPFPx1LGd
 W04uM6ADclFkVhAlpGom4iyu9XQVWwRXXHaRcO9jE6I9rZCjNFBS095lq14va1qMmmK3AuDxXaA
 a4lERSUBB6WhlQd34w+9UEN3exOdE3//Kt21aLjvpt5buxFSWfeqbpNpG8xLpknloBvyCyyHBWt
 SbEFKLbscXuQy/l0XzJpCRJGPUCGbzdruqW2GWIHbURXYGvvdXpxiJP6Fo6iXiz0yO8hOwjVPda
 xF9MmaPrPYI59trbJV1Q3ooJW5JTsyYB1tqQPlpu4BCkrCuqYdo78/lGs7rDAsrV4x05r58tiKk
 U93y4JpzQiaeP59U4I4QAy+qdFC1gGECQjpn1qtChuHLdAQEwsSj/KE2oFe/q17icjyHN07vQlY
 7nDlaQFJKrC36ovjvzZA==
X-Google-Smtp-Source: AGHT+IFxpkw4CzfWyzBUVvoosxgK9bqzWYCVow1Ui3uRpD5c7YykRbsBBtjTtuYxcA5Ae30J9CbOGQ==
X-Received: by 2002:a05:6000:2681:b0:429:d0f0:6dd1 with SMTP id
 ffacd0b85a97d-42cc1d618b2mr29082891f8f.58.1764325291307; 
 Fri, 28 Nov 2025 02:21:31 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42e1cab9af3sm8866493f8f.41.2025.11.28.02.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 02:21:30 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Fri, 28 Nov 2025 11:21:21 +0100
Subject: [PATCH] simple-pm-bus: Make clocks optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-topic-simple-pm-bus-optional-clocks-v2026-01-v1-1-e38040c88b6d@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAKB3KWkC/x2N0QrCMAxFf2Xk2cDSoRR/RXzY0qjBbi3NHMLYv
 xt8PHDPPTuYNBWDa7dDk01Ny+JApw74NS5PQU3OEPpwJgoR11KV0XSuWbDOOH0MS11dGzNyLvw
 23Hx9wZ6QOA1xSjENKYJf1iYP/f5zt/tx/ABRbj6cfgAAAA==
X-Change-ID: 20251128-topic-simple-pm-bus-optional-clocks-v2026-01-1cd38bd8d3d8
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192; i=msp@baylibre.com;
 h=from:subject:message-id; bh=krOH6FdavcQAszjDen+2WqfNnfAVI+5/C/8bpKeDFxw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzN8qVvNk55nfToVvav131JwUn8GtaTA+POCzjxPv1hH
 PF039qpHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCR9EyGvzJty2L+WG49fNEi
 TdGst0j85N6bLz+VzuRfHhUU/6xv5nlGhvuvZrc1akgGTDtpnxgxa7PllYuH1viGhvOX+7hzcX4
 PYgMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 28 Nov 2025 15:13:26 +0100
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

simple-pm-bus binding requires either power-domains or clocks, not both.
Allow clk_get_bulk() to return -ENOENT.

When no clocks are present, bulk->count is set to 0, which works
correctly with clk_enable_bulk() and other clk functions used in this
driver.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/core/simple-pm-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/core/simple-pm-bus.c b/drivers/core/simple-pm-bus.c
index f38372ec60bcad4d8c630001d164630f2f99dc32..5df11728e82848b83eae6ab7dad857a8762c2aab 100644
--- a/drivers/core/simple-pm-bus.c
+++ b/drivers/core/simple-pm-bus.c
@@ -16,7 +16,7 @@ static int simple_pm_bus_probe(struct udevice *dev)
 	struct clk_bulk *bulk = dev_get_priv(dev);
 
 	ret = clk_get_bulk(dev, bulk);
-	if (ret)
+	if (ret && ret != -ENOENT)
 		return ret;
 
 	ret = clk_enable_bulk(bulk);

---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251128-topic-simple-pm-bus-optional-clocks-v2026-01-1cd38bd8d3d8

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

