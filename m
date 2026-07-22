Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8AAC4452D
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 01:37:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBE1080E8C;
	Wed, 22 Jul 2026 01:37:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XV6xw9HRI6Zh; Wed, 22 Jul 2026 01:37:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1888A80C44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784684222;
	bh=DIAIftOjShD0Es4WkfWTbeCEuumftCPZaQHFRJCKMNM=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=GOwfCj3A4TFyqCmc2RWjTVZlm+C8Rjlpumfv13K3HGGWBWfkPt+OdmK8xCyBVB6RL
	 9+mR403tK00ho/G9eOVo35+ABESzAmdNY6qAqi8OYguE6/3qM7QHLVr+8Lut0xjDly
	 ofyXW4G5lo1bB39BCUikLRh2LAr6zklwtg5KqfA6qTUDMmYukaUV95XZ9t2ebKIink
	 JVowPc4ybpFg31mYVBJC4p68GkFQcCvGSNYL1vHsyyY5+S9B4x1SeCLdW7wZAN2Rtl
	 +y03u8rsvI/EZqLdx9w+Qb0NJiHqDHY+rLXVCZ6goRxTd+XrfNGIPPo/ufD7mnhBF9
	 axAAMG8OxHeOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1888A80C44;
	Wed, 22 Jul 2026 01:37:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B59E313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:37:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 31573400A8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:37:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DIER0XRKxcRP for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 01:37:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 759EA4007C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 759EA4007C
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 759EA4007C
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:37:00 +0000 (UTC)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-80814edb536so90029257b3.2
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 18:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784684219; x=1785289019;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DIAIftOjShD0Es4WkfWTbeCEuumftCPZaQHFRJCKMNM=;
 b=FOIGqGLX5fzhrsLED7GjF509r9ElDbjPTN9Agr8aFJ0pJBcizKvx4/L6AqoxgrGDhr
 cNB87WjHgpxq176onx2cDc+Q3+9kUoXLIw+nZEuUW1+qM9wfvVlspFV4ymXXPMlsttMk
 5zikSvqcnCP4fk/nCxkNBwWS6tLd4spRkK7DUB/w08eRCkEmNnVDQkwDYB3szn3+9tYn
 v1mEhnDCF+lIxCHvj1ACvwkQacwJJI+Y5j5ETO+AYeo+i3vi0l86iAwf/PHpt2GJfuTG
 1upeIGODft80U8e8W69S05oXDAAJjhGVxvUMQpF77za8mHvKRRs7kSC98lw1wbjdHMxV
 Md6g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqv+dTuEDPMr6xkPo32xFTpTMmumyYic9b4l0lgczdRLIl36IgQDFG4SL42epHPNub+hI2beyU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyV/ar9uSOMw7L+Zxzdl4bb4YFNJkmAOCIvni5YEc6BxxtrqbB7
 HkTqJDNvAFpElVsGY5tEkQMhWmkduB7JOhAJPONc8BsAG2oybQuXSCXB3EQBFQ==
X-Gm-Gg: AR+sD13lpryr7heqWmSVMx/Uq0CHIvAaNmD3o/Ui9TdJ59wamGoIQIJrOr0k6lhifBj
 Pjh8vfgi4Pdnh9McFjzGCa03+FS93NKumDeSnXtw+HWl4/QMGM2DKy27bW+Pj4i94zIphGoa/xO
 TwA0cfJ8LRp/SwqPn+/ohnWqMQF1T0xhXZCbcjXKq8D9NetTNJD1FXL+RpqP2H0TAqvPaoP/aYG
 W4p7l30pCuWCzsEKJg2emrDWA63hKQQgxHZ8QjhUKnDL7VwyHqmxOx760+mNqGYvbRGiztbz5z8
 zpRhpJaW75wEBeytSXTHVuMLm9YTzq377TGgO52nNy0ANLZMdYLuU8HB4ztYturzVfJCoQGYrPU
 2jukzQaXqrHoSRIezKv+kJMah1aRKLBEYgeFtobXHD1NTuQWSJ1jxq6IVHrIoWYqDLKJvtqFyyX
 h3AlCtBcGBiWb3NQQ1aTc3AvFK5Lh+FqS/cnMJVL8XlDWp0Zs=
X-Received: by 2002:a05:690c:dc5:b0:81e:893c:2c23 with SMTP id
 00721157ae682-81ef22e08c3mr71726827b3.11.1784684219153; 
 Tue, 21 Jul 2026 18:36:59 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a801:a24:1ad1:7a2c:313f:6408])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33ee52a0sm6372937b3.36.2026.07.21.18.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 18:36:58 -0700 (PDT)
To: u-boot@0leil.net
Cc: djw@t-chip.com.cn, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, trini@konsulko.com,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2 1/5] mtd: spi-nor-ids: Add XMC XM25QH128C
Date: Tue, 21 Jul 2026 22:36:38 -0300
Message-ID: <20260722013642.1011666-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784684219; x=1785289019;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DIAIftOjShD0Es4WkfWTbeCEuumftCPZaQHFRJCKMNM=;
 b=siPtlmh+TChruYVgsghq+NsUd+Eo0YDYtr5Z8hMzwdMBM2GcZIsJOQ/85q5KYzE+q8
 l40Vw3YrJiassR9RtRb+jZA3FzohN+I1JUHBfcC04yO+SQFkPlgE5IZCBfCTs51aB7QX
 UlQ0KCtg65h1mpYtBFUsCQC/UQ6tCfYQ5pEzxryeqTa0KhTUkjC47fqyglTelArfGJMk
 X7V2yquqqgNwvUdIP+YkSxcGZ/r5sy6E5wkhM+qH3bKuszCGW1rs7Tn7+1WTaKk/rnPH
 BQQIxJwPda7s++jvCLMngkTqnASPoFKtLz79HcMNxVrZmdQ+PR4yuk2Vqc7e+h4ybQop
 A5iA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=siPtlmh+
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
From: Fabio Estevam via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Fabio Estevam <festevam@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Fabio Estevam <festevam@nabladev.com>

Add the JEDEC ID for the XMC XM25QH128C SPI NOR flash.

This is a 128Mbit device using 64KiB sectors and supporting 4KiB
erase, dual read and quad read, matching the other XM25QH128 variants.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v1:
- None.

 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 31a2ba49a87c..90aa1025176c 100644
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

