Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C440CD8CA8
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 05:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83A7583EEF;
	Sun, 14 Jun 2026 07:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cj6srKq4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B142E84105; Sun, 14 Jun 2026 02:06:35 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBE55801A9
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 02:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martialonso11@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4600cbb06deso1198558f8f.1
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 17:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781395593; x=1782000393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cCnVpbM5EQnKhkYBxSkq4wBInR0iudF/i5oTCAqMGmY=;
 b=Cj6srKq41TegkG8xFiQDzIQQQ3pT+FV8nOzP9xwA8dKnHzEUwRkVaIxI/id9iiHLvP
 S409qsh4KN+oGswTLyinBBkDA0n3DHOVjtyf0FkNtv86jy9DhojPATAkqNbXoZJcEnEc
 D/JS0EgGEvG0P/1/TqawOU+nP6JWswcdkLvV4/COxiI/uI7JIQwpEfTBiI3jYdIu6t+r
 ZOgaOn/HnrDCDBezZpqc/uF3Yt4wg/lWMiyKv3svCpIFSUjxsNC4RGRn8V6tf3HnSL5X
 kZKJ4jmNk05IapGnlWJ64/0wUoQJibjs4kQ+F+81m41sYo0tujgx6XQo/dZreXajqhSL
 q6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781395593; x=1782000393;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cCnVpbM5EQnKhkYBxSkq4wBInR0iudF/i5oTCAqMGmY=;
 b=j52NcQvLI/r4Lyxx48jCb+EddtPtB552w3onr3wpeVhD2/fwrGXNlWzzm9Jd2qall5
 311Yw+CqnGpRJFhEKraw2vk5nlvzK2slzLIwZ3+mA+di0Ux107g1rfgk9WMUTRqXcN3g
 5PQZ4YRpHNuzraIr/t9bd4Ug2qzCRHt8kCDd7/My29OMD1HsD2ilckLSwpxsYCixVn0S
 cbnZ7xjJPXM83Gf27FD13z/GCWzMDA9Wr6R7owOhwhUfIwpBvSlq22TSSD3uxOJfHrCS
 Z+/jpKAI46yZBRUrUzAoruKrRjEMJpgxcRvJxI6gvo6md7QuzhA+pWNEa01p+AcetB64
 H1gA==
X-Gm-Message-State: AOJu0YypdCX4v8q48Y8rPQfEQMF6GWBMd9OKu89ICFIUWkXYkPNsu6rM
 eYmhg4S3W2iJ3pFPP/lvK+DnCvwxssdMqhUV2mOKIw+nbUMOOzbD4JdHtZ5dapOc
X-Gm-Gg: Acq92OFtF2P6mQmAXUEYAmpDtYyyoGO5CUJ81CiJCUMAKpmLKKjOT/94LVDqa0dms5x
 d/uTWRbe+lpDvTiJQWcxGcNkO1h/rax288YA56b95+BZC5fFu8fw+OaHkUq3Ad7kpxhPZL73I0W
 JGqSj3B96St6Jz3v6Ja/oFx/WTMjpyOiwwE0lqXaRk/WdZOWH06SNjNob3/kzpe4jR7XoTmrhsL
 7boheBkTs09Z3Ht00gB0ua8T5yJi/QL5PvMsODBTswkKfPCgT+XXc71OIr6xxj34cvsyPXeLqJr
 pSVBlYt8w7x6cQXlPrh6P5o+0RmQxBF9XNWbEWWUCrxWaESRyAJWMM29rllFOr9+/O+bXYVLSB5
 PiAlfQ2CQPO0ptpn28x6ynNVobu/zPoQ1lFH8O30XuH6AbxH/IEjRpGSi2v8c4ebOgZzfABIyHA
 2zruyI9lsZE1DtPHMIlrI1zkudT3Gw1JRlWQl1MH7ZbxbJr/kFYAnFOKc/0uBYNIoAF2maHLKZi
 YdHniQDR+7ga3PtjKdhp2L3+FbLx9ISLJouUw==
X-Received: by 2002:a05:6000:719:b0:44f:b82f:2d18 with SMTP id
 ffacd0b85a97d-4606cb2b59emr11455178f8f.11.1781395592981; 
 Sat, 13 Jun 2026 17:06:32 -0700 (PDT)
Received: from ubuntu-server.. (75.71.133.37.dynamic.jazztel.es.
 [37.133.71.75]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2dbfb1sm20895501f8f.35.2026.06.13.17.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2026 17:06:32 -0700 (PDT)
From: =?UTF-8?q?Mart=C3=AD=20Alonso?= <martialonso11@gmail.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 =?UTF-8?q?Mart=C3=AD=20Alonso?= <martialonso11@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Han Xu <han.xu@nxp.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Tom Rini <trini@konsulko.com>, Yanir Levin <yanir.levin@tandemg.com>
Subject: [PATCH 1/2] mmc: detect illegal command response in SPI mode
Date: Sun, 14 Jun 2026 02:04:37 +0200
Message-ID: <20260614000543.2098992-1-martialonso11@gmail.com>
X-Mailer: git-send-email 2.43.0
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

At idle state, prior initialization, MMC cards (not SD) will respond
with illegal command to anything other than CMD1 (MMC_SEND_OP_COND) and
CMD58 (MMC_READ_OCR). The MMC driver initially sends CMD8
(SD_SEND_IF_COND) to check for an SD card, but this needs to return an
error, if not an SD card, so it can later check for an MMC card with
CMD1 (MMC_SEND_OP_COND).

Additionally, CMD55 + ACMD41 (SD_APP_SEND_OP_COND) can be skipped if
CMD8 (SD_SEND_IF_COND) already failed.

Signed-off-by: Martí Alonso <martialonso11@gmail.com>
---

 drivers/mmc/mmc.c     | 18 ++++++++++--------
 drivers/mmc/mmc_spi.c |  3 +++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index f0e38efb262b..27eed9a76ba2 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -3014,16 +3014,18 @@ retry:
 	/* Test for SD version 2 */
 	err = mmc_send_if_cond(mmc);
 
-	/* Now try to get the SD card's operating condition */
-	err = sd_send_op_cond(mmc, uhs_en);
-	if (err && uhs_en) {
-		uhs_en = false;
-		mmc_power_cycle(mmc);
-		goto retry;
+	if (!err) {
+		/* Now try to get the SD card's operating condition */
+		err = sd_send_op_cond(mmc, uhs_en);
+		if (err && uhs_en) {
+			uhs_en = false;
+			mmc_power_cycle(mmc);
+			goto retry;
+		}
 	}
 
-	/* If the command timed out, we check for an MMC card */
-	if (err == -ETIMEDOUT) {
+	/* If the command timed out or returned illegal, we check for an MMC card */
+	if (err == -ETIMEDOUT || err == -EOPNOTSUPP) {
 		err = mmc_send_op_cond(mmc);
 
 		if (err) {
diff --git a/drivers/mmc/mmc_spi.c b/drivers/mmc/mmc_spi.c
index 675e642efd08..53bf4f583243 100644
--- a/drivers/mmc/mmc_spi.c
+++ b/drivers/mmc/mmc_spi.c
@@ -168,6 +168,9 @@ static int mmc_spi_sendcmd(struct udevice *dev,
 			return -ETIMEDOUT;
 	}
 
+	if (resp[0] & R1_SPI_ILLEGAL_COMMAND)
+		return -EOPNOTSUPP;
+
 	debug("\n");
 
 	return 0;
-- 
2.43.0

base-commit: 5ca1a73c7d3064582498a8aa96c29e714402a6d3
branch: fix-mmc-no-sd
