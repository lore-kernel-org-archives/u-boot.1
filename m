Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BA2C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:01:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B5EB60706;
	Mon,  3 Aug 2026 19:01:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z8vg1njwaWb8; Mon,  3 Aug 2026 19:01:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 858F8606E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785783685;
	bh=1qUbjeAZU+IDSKaTlCGGqYPjyuK0cJHh+6UhjzEwmHU=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rGTEDwsrAq7dkUit3ENRoBpQDc55lFWU+oxncC7SYhp1wj9OyKSueBkj+wUakdQ4Z
	 qRfVe0hUU7VvkZUF7C2GRx++9m34J7V8/Gj4HX+CvfewozLgeWaKZ+waQEcpYyfoQ1
	 3vTvlLHNnr0trnFEt3EM0Kbtn9T7bKiiHJp0BK+WVzPF5tMce82PEvBH3R/8qSlD9S
	 Nc1cZbWlLwTcCidz0dn85PZ43a21uewxllPAXmr9g1mdggplYF+c1Bbob3YxhqRTOx
	 MA00GYOozfdZC7+ZwEdF7egvE3CKZgi2yDK7lAkadrzmsYDBPrcvQc2xpJDRk/+F0u
	 rBtkK9iHPE7Qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 858F8606E7;
	Mon,  3 Aug 2026 19:01:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E4821194
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:01:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D72884052E
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:01:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NxAX_5qMhobl for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:01:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E1E1C403E0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E1E1C403E0
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1E1C403E0
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:01:22 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-448b0ff4a57so3236632fac.2
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 12:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785783682; x=1786388482;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1qUbjeAZU+IDSKaTlCGGqYPjyuK0cJHh+6UhjzEwmHU=;
 b=MZpg54ulQnt+s1E4Bd+Iq03tbhJnThkUoOMm+LjifKT4XLspp0A25tukeY3cFvBMvi
 DcB9WPIWsullS6KmGWU90QynSY4kXjkw1RjtYk2gtwTqLpKgxpC5ltuTeOdrUNGQuyxf
 mAbWBJhvymcv0EtRe0T/JFGEYcG9xlNK5vswgQwzXlZJjmmKqci/ijDq8I50VFumYPNh
 X/6vgjMHnKrnQUZ1qcUq6inkkJBizveVpQTc8aa3BViW4RI4dPDHJABUt0FksqPM6paI
 NYkil3M6JXIRBixfkkF7hLAyhNgOTufcdBY+k++5TGFnq7P/M0pmyjhR41za1nfhDVdJ
 kCNQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhWXmqZjTarkXjXhaqhrauILUwpixMrdZb/EeNivI8c4LFzhpirTG16s5xUOhF6ct/mY1pnlM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwbPctYiucmwA7byGpXZNNiT2ifKexastpK9MIsP8ZLBjgnCt9G
 njmUdYBGM+tWafyg9sxFoUsR/B8Ngy+Ip/pVYdG0Xyb+vKmdvyG6FAiYvlL/ao+JTWA=
X-Gm-Gg: AR+sD11Ku2ePwG3QPhHl6pztEBtL7K/n8soVCr1dHx9atr+Lrc5MosMw6g+VFuEY4sL
 idyO860wZOBh99FAThT+RiWUnWPhKbFqzkcV2nypTvYEUnod39v5DzAK8irHDcsWFwuNjg4U7GD
 52dJ+NqZ2HtRaOci8ECB7grKbc2O4fQCxRsLLN4TZM+gET5f2ooEveCagGQkF1gFVpBfHjfEFeI
 hRVtmaBCiVpv7ldGDvq4oSyv0dDeGULAsRvT8cUoOMzsSwZiQNs9iLxA7UUK2JstEBvIJy2XAmX
 PHxPHVil7Y7qcREguAbmPcwkkw4eL77GbmhDfvE++4SteI08FuHYfXcw1yUjqqbPtdMSmbpr72O
 GKjSZ7H2VHXxzoZDY8i4QlPShsx17tS+baCmMntT6OZvhG/Ybg1Einx1lu0RI1M3uSz/p0k8rAy
 mwZVborP1vwYgMHrdvkjZ8nHMYHS27SsUeWXDzm9SyfrPnTyHj4RlSxTVzjot+z7YG5x0yFxQre
 mErIVUo1W5ynBx3mnIyKOBPb2kH1kADYWQgPW8=
X-Received: by 2002:a05:6820:1c85:b0:6a0:f3b5:12a2 with SMTP id
 006d021491bc7-6ae450da546mr14196829eaf.20.1785783676979; 
 Mon, 03 Aug 2026 12:01:16 -0700 (PDT)
Received: from [10.200.24.109] ([12.55.13.134])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6ae39db1c5bsm7034401eaf.5.2026.08.03.12.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 12:01:16 -0700 (PDT)
Date: Mon, 03 Aug 2026 14:00:34 -0500
Subject: [PATCH 1/2] mtd: spi-nor-ids: Add variant of mt25qu256a chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-spi_fixes-v1-1-33f36e764104@oss.tenstorrent.com>
References: <20260803-spi_fixes-v1-0-33f36e764104@oss.tenstorrent.com>
In-Reply-To: <20260803-spi_fixes-v1-0-33f36e764104@oss.tenstorrent.com>
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 u-boot@lists.u-boot-project.org
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>, 
 Ssunk <ssunkkan@gmail.com>, Jeffrey Yu <jeyu@issi.com>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, 
 Flaviu Nistor <flaviu.nistor@gmail.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1785783682; x=1786388482;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1qUbjeAZU+IDSKaTlCGGqYPjyuK0cJHh+6UhjzEwmHU=;
 b=N9iml0juojmcoP5Eku6Nv6T7WORw0xYsP+18GtDNxoa0nM1+yaKH5JYRLUPGnAyH6b
 SONf31NtkMKlmAxua32yIsDpKHrkIz6yiueoWACttklqRgdskPPpLlsMmanc3ns7DRVP
 3i4MKhOhBGqCc8SVEPCjO3F/dMDnhWcMxs6eJvFet02EK6At//xuyiwPO5zgrcPUSCrC
 Tb8D4DIx/G342fT8Qo0fMF1WsNf4lpdbxrFiQn7vvGM52izjEBdBvFo4j3F18svGuzG1
 3ZBn2Xot7fBR/j4N+S8ehBLQsGMPGtvGCAPWBbgEz2mV/gkYS9FIdRTFLru7Ku+e9PgM
 NheQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.tenstorrent.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=N9iml0ju
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Anirudh Srinivasan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The current mt25qu256a entry has a JEDEC ID with an extended device ID
byte of 0x44. A variant of this chip this (model mt25qu256aba1ew9), has
an extended device ID byte of 0x40. The current JEDEC ID parsing code
incorrectly detects this as an n25q256ax1, which results in 4 byte
read/write opcodes not being used for this chip even though it supports
it.

According to Page 34 in the datasheet [1], the differences in the JEDEC
ID (Bit 3 in the Extended Device ID Data) correspond to whether Pin 1
functions as a Hold or Reset pin. This shouldn't affect any
functionality in U-Boot's communication with the chip.

Document this chip and it's JEDEC ID so that U-Boot uses 4 byte opcodes
for this chip.

[1] https://www.mouser.com/catalog/specsheets/micron%20technology_mict-s-a0001400588-1.pdf

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

---
The differences in the functionality of Pin 1 (Hold/Reset) also reflect
in the model number of the flash chip, as per Page 2 of the datasheet.
The existing entry in U-Boot (0x44, Pin 1 reset), should have a model
number mt25qu256aba3xxx, whereas the chip I'm trying to document (0x40,
Pin 1 hold) should have a model number mt25qu256aba1xxx. I didn't want
to change the name of the existing entry in U-Boot, so I've left it as
is.
---
 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 31a2ba49a87..ed43104bf53 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -416,6 +416,8 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO6("mt25ql256a",    0x20ba19, 0x104400, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | USE_FSR) },
 	{ INFO("n25q256a",    0x20ba19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_FSR) },
 	{ INFO6("mt25qu256a",  0x20bb19, 0x104400, 64 * 1024,  512, SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | USE_FSR) },
+	{ INFO6("mt25qu256aba1",  0x20bb19, 0x104000, 64 * 1024,  512,
+	  SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | USE_FSR) },
 	{ INFO("n25q256ax1",  0x20bb19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_QUAD_READ | USE_FSR) },
 	{ INFO("mt25qu128ab", 0x20bb18, 0, 64 * 1024,  256, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
 	{ INFO6("mt25qu512a",  0x20bb20, 0x104400, 64 * 1024, 1024,

-- 
2.43.0

