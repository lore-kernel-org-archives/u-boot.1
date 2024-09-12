Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F17EE6457
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 07:38:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF76588C86;
	Thu, 12 Sep 2024 09:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YbJgN+s9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C623C88C86; Thu, 12 Sep 2024 09:38:01 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C1688870D
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 09:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2db89fb53f9so437438a91.3
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 00:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726126677; x=1726731477; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nxpTGr9UaKaTuM4jpRJ+VnqgtuShAUJ9hhEXAKHxwqQ=;
 b=YbJgN+s9Rk0qSk6IWnN10IjAXZCeijCwZxxkZ5lrjKAWFzLmikt5iY9WWkG1Te5Jin
 UtVxfBP2q2j0xngRdmksPukzt7DtYzRviEPfa81BuU0R9yzFdWB+JTdHfJnTnrQmYID4
 8bqjvdclYsK0rykJQLc1pWVMZY/NdB+nrIv2rZzYJ8Pdx5b8P1l9N9IA2OZ+jn1/MaJO
 zAotvNiu6MHB3KOw0llJDMCXtSznScHCkWcBI8MVeVsB6hMdnKLWD22Q0fpRCqD9XX3h
 pr9aSTJdZxeL/fM3tnPIjBhNrk9REflswcdin9JtQM8ZRJjG2nVjUVnyaF0j/2zs2AFH
 uvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726126677; x=1726731477;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nxpTGr9UaKaTuM4jpRJ+VnqgtuShAUJ9hhEXAKHxwqQ=;
 b=CtWUNYgRjUq0kVpndrFQrAVXpVkCCLM7wSWLK06ZMJVcMFpzSEJ5VyBueXJa+7WwFa
 YwIb+3httnrBujzGF029RIKRcU7rVCMIbtFX7hvqsw0IqDGDJraLAR/47N8pEpN4v8W+
 qj54QM/9Dz1c5L7FcwWGMMy8zamZTBTjCx+w+/wtRUNjiEmNNrCfaqjAMLWmswL6CRNH
 aDjSpfzupHORQdkhbsaS4oQppgM9vxSfU1jOlWq/BRdZSBMBRpFcO5/nw6n8j8hWZgqA
 1ZoL4tvwvC3i829Wc9PrPNVTuRBV4ZzEksdCcwzoUq1ucMfacDaIddY4ZX8J4rnNtkh+
 911g==
X-Gm-Message-State: AOJu0YxiEguYNL4EBig4+z1umuoFFZDUjQT8ZT0Q8fniaiJEPYMHsXrX
 BnumiCRVBkhQRBlQY9sDCkys1sF1sAXsJsYH79XbVET+QmN1KEV+ndpBuw==
X-Google-Smtp-Source: AGHT+IEUBO6SRDiEexJPSVGgYa6CHRUuUKoRIk6YSu4G9fa8A17dp6r3g2h8hxEd9ffJFLVDLVlp4Q==
X-Received: by 2002:a17:90a:d507:b0:2d3:b8d6:d041 with SMTP id
 98e67ed59e1d1-2dba0064f94mr2074650a91.32.1726126676728; 
 Thu, 12 Sep 2024 00:37:56 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db043c3b65sm9860822a91.25.2024.09.12.00.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:37:56 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH v2 0/6] mtd: Make sure UBIFS does not do multi-pass
 page programming on flashes that don't support it
Date: Thu, 12 Sep 2024 16:37:18 +0900
Message-Id: <cover.1726126079.git.Takahiro.Kuwano@infineon.com>
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

Resent after modifying commit message in #5 (mention Linux commit first)
and collecting A-b tags.

This series is equivalent to the one for Linux MTD submitted by
Pratyush Yadav.

https://patchwork.ozlabs.org/project/linux-mtd/list/?series=217759&state=*

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

