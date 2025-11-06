Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D152CCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 13:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4742483B91;
	Thu,  6 Nov 2025 14:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="xasC85sw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0502F83B82; Thu,  6 Nov 2025 10:46:18 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04FFD83B8F
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 10:46:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso8152455e9.3
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 01:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1762422371; x=1763027171;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DI6K/aIdpuSnX15tFEx2SJeo/7Da+vJWPzriBsx9UMk=;
 b=xasC85sw8a2N3CEgsqvPxu3QUYLpCgLO+0Xp+sz+1gysKpHUpdgRH1F10/0ZyQaWRZ
 FmxRFTDLpl2qHHlme1qy6Nu5efk4PmnsanrwoK75YxfbM5opA7v0PpGLU+m1rhOLTyxs
 vdcFUs324lN19MrZAN2s4rNnal0MrniowjuEDSJdrvrc1Y+Umk0qbL7EljMsRlpd/tXV
 9mXjJHLdjijJZ1Fg+kJ561xsceDuVBRK480AG8iauFWVYo183pqIbifh5aEL6R/fXkRN
 lEYc+otACXsEuq7ufDWDC1Aqse0/DbDvvRlWUA9sJzsq66nlhVaHtYWfUAMo+W7eZwIO
 KgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762422371; x=1763027171;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DI6K/aIdpuSnX15tFEx2SJeo/7Da+vJWPzriBsx9UMk=;
 b=TyIl+ZT/o8bg62rQp2r3LUPcs9zafVym3JhK29+yFe/wWd825kqTMtYHBFNZJApElT
 NnQ9UeBPeElc/Ch8AFduWmHoRCO2qEZUZKbU58kcRTgWhHUehr5/q7j/idWUwCfZdoi0
 m46vfZTOiJBd906E/5nSGWjS6bMCFd/q5kHOKT3F3EJBrFZLr4ssmUo/LYANG67o3RfX
 OeuLCQXs4S0qopU+SaVIEI3VN8sadx5ux9LfJxOFEHzfd+mZLh9X2ZeJw8I5xJc0hiLX
 FB5pAogNctfYZ/cKTQzNi+9IMgzB8ao5pLPJKfNDlXqZoY0QW0Z7xvUitrXTb20wgKlJ
 r/ug==
X-Gm-Message-State: AOJu0Yy9hO78W5H8Brfjd04Jf6atIxczLQ+7s2r1ycvS0FWXfIOioF45
 iun+g/E5edqyGB7cIyc4bHk83goDouUiUDttwd5GzZb2Hm8ZDi40lCQsJNIaOb/84hw=
X-Gm-Gg: ASbGnctvi5DHPBwe9Vv/DWkUBKYawlcS3nU+bXaai+4b4u+4jsL+KaG1NspA80ogeYP
 PGFryNWtMvy6BRbOb9bOGAZSRG0iPQi4H301cBqDNBLeSLdKMMXT81Hs2xit4ULmEA5Ylz1L6EM
 IV1HXM4erobB30mPZe1vz4uNzJQcA7myxOHcVU4Q/UM/7US2ZWWHiNYeeWv9Ldlzy+MDj3VEThC
 r5x3HdqZ2QarieWlPXIS4NsjLUvNhUMspFRsQMU8Pr4tX7iqt04pU0VPHxOo8k/xvGQCLnL3JxB
 YFt2vmZ4JGc59p3JFOuETGZVjPQz5hseE5xTxarqZ22mtiFlNoAf1j+7wUkKDi/8B3rBGARDklt
 QIMIlSLgfaR/CYXTBFbfhDGaWDJEot8r2eHSgth6g8crFImLuH+PZw2KxfD/f/GKn/Hwej786Ul
 quWgDGlPCN4A==
X-Google-Smtp-Source: AGHT+IElhMr5pUvSzJ4AXvtv1yfo9NZ0UwHDJXbZZQby00A0aVvPMq5W87xS4UGofkAGiRMeUJiBhQ==
X-Received: by 2002:a05:600c:1c08:b0:475:df09:c253 with SMTP id
 5b1f17b1804b1-4775ce286a7mr50605085e9.38.1762422371118; 
 Thu, 06 Nov 2025 01:46:11 -0800 (PST)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4776363da40sm34520295e9.2.2025.11.06.01.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 01:46:10 -0800 (PST)
From: Zixun LI <admin@hifiphile.com>
Date: Thu, 06 Nov 2025 10:45:59 +0100
Subject: [PATCH RESEND] mtd: spi-nor-ids: Add support for AT25SF321B and
 AT25SF641B
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-nor-v1-1-9be914d0178a@hifiphile.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Thu, 06 Nov 2025 14:09:21 +0100
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

These flash chips are similar to AT25DF321A with Quad I/O capacity.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
Tested on SAM9X60 custom board.
---
 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index e7e97780d7cdd27104fd7db900b3a779d2188922..18bc6f2f06e9a02594da6ad1880489e78458a60f 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -76,6 +76,8 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("at45db641d",	0x1f2800, 0, 64 * 1024, 128, SECT_4K) },
 	{ INFO("at25sl321",	0x1f4216, 0, 64 * 1024,  64, SECT_4K) },
 	{ INFO("at26df081a",	0x1f4501, 0, 64 * 1024,  16, SECT_4K) },
+	{ INFO("at25sf321b",	0x1f8701, 0, 64 * 1024,  64, SECT_4K) },
+	{ INFO("at25sf641b",	0x1f8801, 0, 64 * 1024, 128, SECT_4K) },
 #endif
 #ifdef CONFIG_SPI_FLASH_EON		/* EON */
 	/* EON -- en25xxx */

---
base-commit: 4d3b5c679bc9d5c6cbbeedcc1e4a186f1cc35541
change-id: 20250701-nor-0ee20c630bc4

Best regards,
-- 
Zixun LI <admin@hifiphile.com>

