Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2D8CD98D2
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 05:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA90A84841;
	Sun, 14 Jun 2026 07:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K0pJg6xI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CB2284105; Sun, 14 Jun 2026 02:06:44 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88671801A9
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 02:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martialonso11@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490b7866869so21577155e9.2
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 17:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781395602; x=1782000402; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oNEDhDUorKJZVs3Xxq3uAcJfx4/TcqqOdqGXSeYQhM=;
 b=K0pJg6xILgaWyYeQkY/u0gJ4wTHTCUoQZ4VxjaxwUz9EPOf16OzkufqbOu9AdS5+Rz
 B5tt8GBthM50+BDCIgV1UCJcRYbBUSZfYoixWmZQeINnltIhJTsC5DdVqj63E281/8WL
 90/i7xGNM8nyRpUc9ncsH99jOIk7RiOVeiq5UO+RIzU/bpvch8dmMuoRpPzoKC+G51tN
 oFYo2+sk6OErEdWkwif28DKXIbO88vcqLeWxxJh/Z8XQDwBbRM6roGnbU4iN+bn/vCfe
 3agBePAnN1eT7yidOgLvmYOuMxOa+JUy3Knc3U8nBmDiSpz3p+htkSuv302Ex3XL9ne/
 m/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781395602; x=1782000402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6oNEDhDUorKJZVs3Xxq3uAcJfx4/TcqqOdqGXSeYQhM=;
 b=ijLp3Vu/W6KhRqljhTM9Xt4+ma28bes/XCfkRhPsUupWO67U1QO5dhOb4zVO5wNN0h
 r7xUCxqgYMaRGENnLua47fLda6aNDWrOvlUyZGTDDAihnR4SDHHbBCxX7bTgUNILzuYm
 CvZC0isZ/T799Jlpltu6qUd7HtUlYOmTIDiiteWNeBs5/z0WckSB2t2rEIhCE48x6Zou
 lPnyyYX03L0vXDWj1Yl79Z2ht/gZ9Cj2Dc3KdmCBTBPRNkBlxJO8A8duKU1QDspc/sl0
 7grmGjiC+azdXIfPwvWgechozKAPvbjGCZivUYOKHBvL9bLh5VHnu6xLyIXgBrqE41Xs
 xgog==
X-Gm-Message-State: AOJu0YwPePUNSlvyPk4S0A9f/UbINhA/ibTtMdLWvks3AtHFUxvDKPGm
 MJsSF0ToBJ96ct/1AqIlcOvES2ItM0JLNC8SeBvmdUX182/F9UL6q75o3SWN4nJr
X-Gm-Gg: Acq92OHzZ8XYhAIHbJlqi2dR8VhYPdpHGeKHxZudufeHEcCGGJAJrryv7ptxaSQnW+t
 VNqT9vmLLyDFRVv3tqwoICMLMYwcFjEHBFnwr+tWvEadVc8HdjZIX+MOdtB+5RwlHJgvjYOofyu
 C9ucC/o4kXpg+tu6IkyaXA48TwBGcmSG7YpYbQKyjaItyAMpDMavua7BVmm752STg0pryLfr7RX
 MMu8dR7ZqLSunv8Y1q6RJKDCY7vuYBUqZtU8QtnJlNQN+XZ9qQt9QsFl+5y8ltEIVrqCPirl7H0
 m5jLXQ8HS0Oq7WNnfvYB/0elx4L7EGlFwA5c39pIJrhFHPj15DCw955nZrDkBtAsZqpipXx/ElX
 QcZ7Sz1KDx3RU3939zr6GnPjBdDxPiI6PxoLAtaE4+xYfNLeuxls9rnpHC9a9ltReCxOFu91niu
 FrCsIx9iXl0bVxZ72YQOOSQzgl6EgxJwP9vlvVgvIjt24nM8APBw3K+gVQx/l6tpEbUjBtupgRC
 FhCrj47hn49CBsGKEjBx3I/HpZYIEbGf+b/qA==
X-Received: by 2002:a05:6000:1888:b0:456:d5bf:e24d with SMTP id
 ffacd0b85a97d-4606db9678fmr11461310f8f.2.1781395601801; 
 Sat, 13 Jun 2026 17:06:41 -0700 (PDT)
Received: from ubuntu-server.. (75.71.133.37.dynamic.jazztel.es.
 [37.133.71.75]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2dbfb1sm20895501f8f.35.2026.06.13.17.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2026 17:06:41 -0700 (PDT)
From: =?UTF-8?q?Mart=C3=AD=20Alonso?= <martialonso11@gmail.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 =?UTF-8?q?Mart=C3=AD=20Alonso?= <martialonso11@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] mmc: handle MMC_SEND_EXT_CSD/SD_SEND_IF_COND collision in
 SPI mode
Date: Sun, 14 Jun 2026 02:04:38 +0200
Message-ID: <20260614000543.2098992-2-martialonso11@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260614000543.2098992-1-martialonso11@gmail.com>
References: <20260614000543.2098992-1-martialonso11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Jun 2026 07:42:26 +0200
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

Both MMC and SD use index 8 for different commands, and expect different
types of responses. MMC_CMD_SEND_EXT_CSD expects a data block of 512
bytes while SD_CMD_SEND_IF_COND expects an R7 response (R1 + 32 bits).

Differentiate them with the data parameter which tells us if the MMC
driver expects a data block as a response.

Signed-off-by: Martí Alonso <martialonso11@gmail.com>
---

 drivers/mmc/mmc_spi.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/mmc_spi.c b/drivers/mmc/mmc_spi.c
index 53bf4f583243..f13ae8e6ebcd 100644
--- a/drivers/mmc/mmc_spi.c
+++ b/drivers/mmc/mmc_spi.c
@@ -339,11 +339,16 @@ static int dm_mmc_spi_request(struct udevice *dev, struct mmc_cmd *cmd,
 		resp_size = sizeof(resp8);
 		cmd->cmdarg = 0x40000000;
 		break;
-	case SD_CMD_SEND_IF_COND:
-		resp = (u8 *)&resp40[0];
-		resp_size = sizeof(resp40);
-		resp_match = true;
-		resp_match_value = R1_SPI_IDLE;
+	case SD_CMD_SEND_IF_COND: // Also MMC_CMD_SEND_EXT_CSD
+		if (data) {
+			resp = &resp8;
+			resp_size = sizeof(resp8);
+		} else {
+			resp = (u8 *)&resp40[0];
+			resp_size = sizeof(resp40);
+			resp_match = true;
+			resp_match_value = R1_SPI_IDLE;
+		}
 		break;
 	case MMC_CMD_SPI_READ_OCR:
 		resp = (u8 *)&resp40[0];
@@ -396,12 +401,16 @@ static int dm_mmc_spi_request(struct udevice *dev, struct mmc_cmd *cmd,
 	case MMC_CMD_SEND_OP_COND:
 		cmd->response[0] = (resp8 & R1_SPI_IDLE) ? 0 : OCR_BUSY;
 		break;
-	case SD_CMD_SEND_IF_COND:
+	case SD_CMD_SEND_IF_COND: // Also MMC_CMD_SEND_EXT_CSD
 	case MMC_CMD_SPI_READ_OCR:
-		cmd->response[0] = resp40[4];
-		cmd->response[0] |= (uint)resp40[3] << 8;
-		cmd->response[0] |= (uint)resp40[2] << 16;
-		cmd->response[0] |= (uint)resp40[1] << 24;
+		if (data && cmd->cmdidx == MMC_CMD_SEND_EXT_CSD) {
+			cmd->response[0] = resp8;
+		} else {
+			cmd->response[0] = resp40[4];
+			cmd->response[0] |= (uint)resp40[3] << 8;
+			cmd->response[0] |= (uint)resp40[2] << 16;
+			cmd->response[0] |= (uint)resp40[1] << 24;
+		}
 		break;
 	case MMC_CMD_SEND_STATUS:
 		if (resp16[0] || resp16[1])
-- 
2.43.0

base-commit: 5ca1a73c7d3064582498a8aa96c29e714402a6d3
branch: fix-mmc-no-sd
