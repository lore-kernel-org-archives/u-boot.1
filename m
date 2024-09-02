Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C01ECA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 05:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E44F88A49;
	Mon,  2 Sep 2024 07:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71668888D7; Mon,  2 Sep 2024 07:33:37 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4D1B889CA
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 07:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiawei_wang@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 2 Sep
 2024 13:33:26 +0800
Received: from mail.aspeedtech.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 2 Sep 2024 13:33:26 +0800
From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <bob.wolff68@gmail.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 0/4] aspeed: ast2700: Add Caliptra ECDSA driver
Date: Mon, 2 Sep 2024 13:33:22 +0800
Message-ID: <20240902053326.3273410-1-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Aspeed AST2700 SoCs integrates the Caliptra secure IP, where an ECDSA384
signature verification HW interface is exported for SoC crypto needs.

This patch series firstly extends the FIT image signing/verify common
code to support the ECDSA384 algorithm. For better convenience, the
device tree for ECDSA public key storage is also revised by referring
to RSA implementations.

After the FIT common code revision, the driver is implemented for
AST2700 to leverage the Caliptra ECDSA384 signature verification.

These are verified by signed FIT images with the algorithm "sha384,ecdsa384".

Chia-Wei Wang (4):
  lib: ecdsa: Add ECDSA384 support
  lib: ecdsa: Create device tree node automatically
  image-fit-sig: Remove padding check
  drivers/crypto: aspeed: Add Caliptra ECDSA384 support

 boot/image-fit-sig.c                |   2 +-
 drivers/crypto/aspeed/Kconfig       |  10 ++
 drivers/crypto/aspeed/Makefile      |   1 +
 drivers/crypto/aspeed/cptra_ecdsa.c | 187 ++++++++++++++++++++++++++++
 include/u-boot/ecdsa.h              |   1 +
 lib/ecdsa/ecdsa-libcrypto.c         |  25 ++--
 lib/ecdsa/ecdsa-verify.c            |  14 ++-
 tools/image-sig-host.c              |   7 ++
 8 files changed, 236 insertions(+), 11 deletions(-)
 create mode 100644 drivers/crypto/aspeed/cptra_ecdsa.c

-- 
2.25.1

