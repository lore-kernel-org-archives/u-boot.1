Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DB1D1F9B5
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 10:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D8E183FCD;
	Thu,  4 Dec 2025 11:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KJsOomWv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 619EF83FDB; Thu,  4 Dec 2025 11:53:39 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2738A83FA5
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 11:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-29844c68068so10652585ad.2
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 02:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764845615; x=1765450415; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZvH74xWcZDlXeDKtqljgjA+IUCHU7rs8cske6xG0l5Y=;
 b=KJsOomWvgm5vv8h7xf3jZMEWmB25W6pTcgyE8o+uYaRRtX2WK55yS1Zwo6gRpJQyJH
 XY3uxtl7fEiwxsX9sqdguBSvNXqRcf5nhcf62m/PQ2T5bTG/hiZHAJ1j1SJnBoKNgPom
 Ns79EFuMcg939CDqNdu+txTyEEpaWYiHh98OhFiDmtQrPIQc9tuMh6I+PSvdNkOfLr0w
 r+SzXepbemHdPTARKFtO3JMFYTZBrDtSh2Z2SzU5WJSZoQoeeu/Z7TDtKxKhF9Ait3xl
 RBBkxtUHgTypW3yFjDuKdgSpSFYgvtXe6pXYlx1jiQPp3OAHlTnoxwHhlM38nS2T4EJW
 ay2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764845615; x=1765450415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZvH74xWcZDlXeDKtqljgjA+IUCHU7rs8cske6xG0l5Y=;
 b=xMjZYeK8nAPQEWnglXw+2shk8YbksMg1ALcu/4Aqsw2vnCvViZNOH4M1eDce7Mzmh6
 Kxc4c/OOU8C2vjH9Rn9l08WuRRGNoqz3rt50gNcCcAAfNC+NZl7U3KrT7qcmM7JlIBko
 QnB9ZayHbeuqARonDtNZUPEpy9H5kr2f1PDQZ6PXcPoRCXc1E2NlnuEL9odQc37ZB/cp
 uQXtR6vGmxz1SDvcx9d+y3HmmlAMhDk89jN2mat7TGiSn5Fm582wn4r4XfL6vr1MRw/Y
 mrSSj8S2LKXBj6Uu0p735ZSG0e9tRw/aitSvcryCzNGuhgwYsYrvz1o7QH0uggrVnhRv
 Rk7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUPRjju9dPRxXh/hhcxbuMLwCLcdQyWBOwlbLvOOTwUWfH1lO548F5FdZ+4hhM8+ZEbPgflrI=@lists.denx.de
X-Gm-Message-State: AOJu0YyZsGEkr/ROKxR+5aIHdHEsro+oVX+f46l3bYRgUm7NcRRmlNyb
 Q+UYGXSlWnX9u/EUN+oUHF6KOGsbQsJCm6cJPZy3kUIOy5S5ffMHzphC
X-Gm-Gg: ASbGncvmmUGupvR2n1+v+Ye6Jy4xrtB6fjIG5h5DA9geJqV4TyQ9Ioyn/OMvLyfm+Xo
 J55+u+F6xTfpiyrg5dcO+WLTQ/b4pqisQOiXOPNAn5GWA+UQjc86G21pswQBsZ/WRriVHDgK54K
 R8yht9O5r67eFG329ZqU0mG10RvzVD4n2+QRqYxefEG+YWIyTQgbUxGyRvsAVZmacavATMbZNwX
 aObKR69hHpQWBPsd2AJZ7jqKrBdJNNvaA8fOPftcUvqJLQbrAjtHxClRveuwun39Ro9gEHRo+jz
 puoocSndo43c+3BxxRHnuO/yvm1Rtt6YD0VCdKy00/6ftPrjfVhApMyGI8RtAXWaVSGdOFM7DHK
 3jUIpejGpTkU9hI0c7Uw2CamK+JYgi74H6O7LWWXBrQQYyEpzhHwbrUzDrT+p64YhEzaML1fBSS
 Mukrynpl7WSeFE3PoMOp4Ux1gpp+o4o6YlfEE67MnsdfEAPa1q
X-Google-Smtp-Source: AGHT+IFf4aT0waNjat/uZSca6J2CIu+BVnNLMLb4AGGPsXrNmHoOZfxBazRYn4ySyHCqYHbueYiMvA==
X-Received: by 2002:a17:903:1b65:b0:297:c889:ba35 with SMTP id
 d9443c01a7336-29d683926c8mr65260215ad.31.1764845614575; 
 Thu, 04 Dec 2025 02:53:34 -0800 (PST)
Received: from sun-virtual-machine.localdomain ([154.12.177.165])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29dae4cfcfasm16265895ad.41.2025.12.04.02.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 02:53:33 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Ssunk <ssunkkan@gmail.com>, Takahiro.Kuwano@infineon.com,
 jagan@amarulasolutions.com, pratyush@kernel.org, trini@konsulko.com,
 tudor.ambarus@linaro.org, u-boot@lists.denx.de, vigneshr@ti.com
Subject: [PATCH v3] spi-nor: add support for XM25QH01D
Date: Thu,  4 Dec 2025 18:53:12 +0800
Message-Id: <20251110203000.9999-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <4cd587dc-da4d-4645-9a6a-fd14dcf15de8@mailbox.org>
References: <20251104110307.3993-1-ssunkkan@gmail.com>
 <4cd587dc-da4d-4645-9a6a-fd14dcf15de8@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Marek,

Thanks for the clarification.

As discussed, I am not reordering the XMC flash list. This v3 only adds
the new XM25QH01D entry in the appropriate alphabetical position, without
touching the rest of the list.

I welcome feedback from the SPI-NOR subsystem maintainers as well.

Thanks again for the guidance!

Regards,
Ssunk


---

[PATCH v3] spi-nor: add support for XM25QH01D

Add support for the XMC XM25QH01D SPI NOR flash.

This device has 1Gbit (128MB) capacity, with 64KB sectors and supports
4KB erase, dual/quad read, and 4-byte opcodes.
Datasheet:
  https://www.xmcwh.com/uploads/958/XM25QH01D_Ver1.0.pdf

Changes in v3:
- Do NOT reorder the XMC flash list (per Marek’s feedback)
- Only add the XM25QH01D entry in the correct sorted position

Changes in v2:
- Attempted to reorder the list; reverted in v3

Signed-off-by: Ssunk <ssunkkan@gmail.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 0383175beb5..00f78c2aaae 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -595,6 +595,7 @@ const struct flash_info spi_nor_ids[] = {
 #endif
 #ifdef CONFIG_SPI_FLASH_XMC
 	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
+	{ INFO("XM25QH01D", 0x204021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QH64A", 0x207017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH64C", 0x204017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH128A", 0x207018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-- 
2.34.1

