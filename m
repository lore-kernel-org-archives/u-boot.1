Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46119CFC263
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 04:09:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DF6588FA4;
	Tue, 15 Oct 2024 06:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZYEN2ad1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EEC088FF6; Tue, 15 Oct 2024 06:09:12 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0255988F24
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20c70abba48so31898775ad.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728965348; x=1729570148; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sl9GY7CTADUe9fPzsEMnq9jRL9hwtz8uStu3jqzsWUQ=;
 b=ZYEN2ad1WxkZbvjmZWeRv+YMndpFilywpDH8f/cbv6p+RcwCBr9dNWHevBHrlODEuM
 9Wv8hHBLrX/te+UMbAgog8zutLN+l+C2KghrjXJfyM+OzR/QKvkjhyEdm4zIrzCIMjjG
 LAGxbH5TbgaM5bLBmkj5s83vYV3w7/QlKJ2H0lUZsyyVwqMk6sbcl7+SMJwgAx8f84q3
 Xe05ZnJ4SjB48cTAQl65KR+eEzSflaz1nHtBanWqCZ+/7S02mmgLwmn/kqA4x57+4xvH
 oDSX0Q1nuJMiUYU50OjxA9s6u6+yvPdar79wdNXxBhspTaeBlEjSHu1KQaVB7gG2FC0L
 xY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728965348; x=1729570148;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sl9GY7CTADUe9fPzsEMnq9jRL9hwtz8uStu3jqzsWUQ=;
 b=C2S2pCaoqHEMHzWe6dKXgcijeOtNRku+s6w4tMWS2R0/RQgl+V3MYsKYmxUugHJIP/
 YgoJyUfI72RFq9/wF8Hy+9TWkJcW5xT54JIoYRQ8j/mRFKt71Au0itBZCTPXAxP1jm78
 2qLSU7PFWlFjlXkKQoQP+ThsamJhb2nsYht9E27Er1z1S3PlYjdS4jfLv1Cp/LmZVeY/
 DHNmFkx5JoDitsiOlUlep0yq69iOlh3HM4GlxhWVjNtSa/fgAqhlwEFSgYioTADXrm/e
 aKCiCQnPNyxE2EFcoQwP8V3sLZpx44qPW/Qq7uQluebcU8cykAfWW+f60h7GLLGKVpCk
 OgPg==
X-Gm-Message-State: AOJu0YzP11awDAnEKKmwC+dYiaJrZcQXCkzBAmLYs47ysiiCGHUDLS+q
 4sUqVkWN/v1uUZvcqpCvs7Ij/O4bHn08CZnOplhuWPoseRSf18mu21h3NQIB
X-Google-Smtp-Source: AGHT+IE8ea3W+pYG+helRO0QYXKxBtKSrEkWKJMDkxSbOKAsaYKCWUsW+Q7Fk2QMm2WD9opDTQMNKg==
X-Received: by 2002:a17:902:d4cb:b0:20c:e2ff:4a2e with SMTP id
 d9443c01a7336-20ce2ff4bcdmr119884365ad.53.1728965348405; 
 Mon, 14 Oct 2024 21:09:08 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (sp49-98-220-86.msd.spmode.ne.jp.
 [49.98.220.86]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea9c6ba2a8sm357500a12.6.2024.10.14.21.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 21:09:07 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v3 0/6] mtd: Make sure UBIFS does not do multi-pass page
 programming on flashes that don't support it
Date: Tue, 15 Oct 2024 13:08:30 +0900
Message-Id: <cover.1728964655.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

This series is equivalent to the one for Linux MTD submitted by
Pratyush Yadav.

https://patchwork.ozlabs.org/project/linux-mtd/list/?series=217759&state=*

Changes in v3:
  - Rebase

Changes in v2:
  - Fix an issue in setting macronix_octal_fixups
  - Rework fixup hooks

Takahiro Kuwano (6):
  mtd: ubi: Do not zero out EC and VID on ECC-ed NOR flashes
  mtd: spi-nor: Allow flashes to specify MTD writesize
  mtd: spi-nor: Check nor->info before setting macronix_octal_fixups
  mtd: spi-nor: Replace default_init() hook with late_init()
  mtd: spi-nor: Call spi_nor_post_sfdp_fixups() only after
    spi_nor_parse_sfdp()
  mtd: spi-nor: Set ECC unit size to MTD writesize in Infineon SEMPER
    flashes

 drivers/mtd/spi/spi-nor-core.c | 88 +++++++++++++++++++++-------------
 drivers/mtd/ubi/build.c        |  4 +-
 drivers/mtd/ubi/io.c           |  9 +++-
 include/linux/mtd/spi-nor.h    |  1 +
 4 files changed, 65 insertions(+), 37 deletions(-)

-- 
2.34.1

