Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB7FC5CFCF
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 17:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0C3A409F8;
	Thu, 13 Aug 2026 17:02:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DaVfhyQ_CYEg; Thu, 13 Aug 2026 17:02:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 69169409D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786640578;
	bh=LDo5BHoSmcRacPhIdhrQFHVcKd4Hj2yAlk+b7SvAVNc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=m04C/LQc05/IyMfamEZAx7NAaCVqjCjCaXQhq4AjBggxB83GqCobfNRb1Hnwfj6AW
	 dEHwv2dqiY0gCDIxjEctFRaLgHWViL7l3kGQ+6RIKKlZrRLbWlrScLgre8cZ9Yh2/Z
	 aHkVcrXmCkBHacmc1PYcF5ArvPw6GMaLiUrkwEg7tGvUSGzeTb2Srj6z9vQ/ffUz9p
	 iub/fNXmIna9Of4lZ/raDFjiXM+k7fKg8JhYCNb72p0wz8UPzDYMCxfz3b1bRMEPgD
	 UuDjzs3stJp4T0Pa6JSqPjIjq4OpbC/z62hdkKGvALxL+0KNjiEUG1Pl1Ya8gajyh/
	 qXhZUwxZniZHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69169409D2;
	Thu, 13 Aug 2026 17:02:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B061A357
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9666740158
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:02:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MZO5315kST9k for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 17:02:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4C3F940061
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C3F940061
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C3F940061
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:02:55 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-381b831d535so103552a91.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 10:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786640574; x=1787245374;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LDo5BHoSmcRacPhIdhrQFHVcKd4Hj2yAlk+b7SvAVNc=;
 b=sHbyWIEO3RuyG6jELi0WGJYtDlsSgdV9ifXiMl/yY3wBBMVCJ8aw+ziEcvd+MZ9GNG
 UVbalF7NRTa1s/lQb4PrY/g/BgInPkkRFI4MpxsKocRttvUEj8Ev1ghamJYbJu1f3BB/
 wwT5P9fzDBdw7IsO8LmgBlcVVFgoHNEf2nGIpBno5CjyQ7R9j7CE04iPbSt3HzICodIs
 dx9YUqM9KXVryqZ3vSvhpRNxpKWNKGfDz+p8y2IkRz8v/KalmuuEAjgZixiCHB9oIbxM
 wNrPBE8izYld6B8QGdyFFbFeNpRiG6otXzm2vBPXk40MMGFMbpk2U+i2IbbvSSfxcpRg
 MjLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoxzNtcc2OeEfEW983b/lk1mpT+PpfO0yxC9Ld8oRQAOIIrQe9/A18h6elSLzcocjQBIk7jGZA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw/QMzfHDMqRhz5pUdxnJSRkyj0Si7pQ5YZ6R44ok+nasa0uW39
 0alEm8cC7y3LwXpNBjgvUBR3DqK7jg3VRpcW0ZX4mmteg3K8hRWncXjp
X-Gm-Gg: AR+sD10xM7HtzPW8lXL11c24CZMufDfWXRgMcgRHl0HGQX5+VjLHQEmelYokRK05b1J
 tCgzcMKhNwUOF/ciqZNATalgpR2GNajz+VOYXFI8spM9OtNX79F3carp/ywGiKrTmlv0Nt6gsjD
 SnoUFZJmoh0vcu8iXVlu8RxcyqTGT4cBuo4uZXW9NMeyPdiIWXsjMwGL0FjM3J8N8SwjvJweeyh
 pLmAhUvAfd4eintuWnfa2irDsuFaaMe+Yld2JHDFDEz6ft47UGhn3/Ox0gGTiaEbxjIWFTKDUr1
 nzACYXqNV8pSHkdeoY9E0J5P1yOr7O8cfWkmaEKiAdQ4veBhKpuQwpSBLELDqnB4kYdx5ejkggY
 a+kKuDI0AwZHyQowOahpK35VUsO2Z4a2LKnIBLoLXHADds5Rl6JUyB6xozqmeBQfMjSTQ38sb7M
 GfTwIaUKfAkMzP84dAcLj1YpJVEhKytxqOns0cGq6g8YRswDf58reKmdLemSQo9UMedRbXtwedf
 J63FlH7HbZ6hwlUgQYX0nO2DOR6Br1CYNLfMu0=
X-Received: by 2002:a17:90b:1f88:b0:38a:c3f:3b87 with SMTP id
 98e67ed59e1d1-3931e26fbeamr9716152a91.12.1786640574315; 
 Thu, 13 Aug 2026 10:02:54 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7..
 ([2804:1b3:a802:463c:b2f8:f8b2:9607:d599])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1413889d914sm92391c88.13.2026.08.13.10.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 10:02:52 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: u-boot@0leil.net
Cc: trini@konsulko.com, kever.yang@rock-chips.com, sjg@chromium.org,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
Subject: [PATCH v6 1/4] mtd: spi-nor-ids: Add XMC XM25QH128C
Date: Thu, 13 Aug 2026 14:02:43 -0300
Message-ID: <20260813170246.110899-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786640574; x=1787245374;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LDo5BHoSmcRacPhIdhrQFHVcKd4Hj2yAlk+b7SvAVNc=;
 b=DNL5BLkEQ25vOjOeb818jzyGmYBQbar+jdBX0MqCQyAiPm3r6wqj2VcnkdTTKCp14V
 GNwC3Jf6EA2rPKOn+repHoHlzC2UIBvxh0q/LY3GAFPa6LfPdVFc+kRNdvgvRE+40Otz
 5vBLYIizJlxCSUYQcW4RDlyfjSViELQ5/o0HG/R6VlVkbHNCkVIv+d51jODdG7iLSMYy
 Kv4827SIlkOJCV6lSkMJIXsW0/LEBLSqpMmwmUs4J+0z2YCDQ/IcrA3RENHqHvZGKJAn
 5YM9gfvRFB0nN/+D/cq7O1rKXFKOs3dRpp3xdJm6dsTN1Jn6pvccWK27BvtdOtGPnbsM
 XvcQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DNL5BLkE
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Fabio Estevam <festevam@nabladev.com>

Add the JEDEC ID for the XMC XM25QH128C SPI NOR flash.

This is a 128Mbit device using 64KiB sectors and supporting 4KiB
erase, dual read and quad read, matching the other XM25QH128 variants.

Link: https://www.xmcwh.com/uploads/435/XM25QH128C.pdf

Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Signed-off-by: Fabio Estevam <festevam@nabladev.com>
Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
---
Changes since v5:
- None.

 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 31a2ba49a87..90aa1025176 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -673,6 +673,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("XM25QH64A", 0x207017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH64C", 0x204017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH128A", 0x207018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("XM25QH128C", 0x204018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QU128C", 0x204118, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-- 
2.43.0

