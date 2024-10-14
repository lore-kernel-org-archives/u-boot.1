Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8DDCFC52F
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 09:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4EF689056;
	Mon, 14 Oct 2024 11:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEDA789074; Mon, 14 Oct 2024 11:56:25 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E246E8907E
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 11:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiawei_wang@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 14 Oct
 2024 17:56:20 +0800
Received: from mail.aspeedtech.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 14 Oct 2024 17:56:20 +0800
From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>
Subject: [PATCH v3 0/3] aspeed: ast2700: Add Caliptra ECDSA driver
Date: Mon, 14 Oct 2024 17:56:17 +0800
Message-ID: <20241014095620.216936-1-chiawei_wang@aspeedtech.com>
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

v3 change:
  - rebase on master branch and drop "[PATCH v2 2/4] lib: ecdsa: Create device
    tree node automatically" due to the duplicate change.

v2 change:
  - revise the commit message of padding check removal for better explanation
  - remove redundant check in static function
  - revise errno and error message as suggested by Simon
  - collect Reviewed-by tags

Chia-Wei Wang (3):
  lib: ecdsa: Add ECDSA384 support
  image-fit-sig: Remove padding check
  drivers/crypto: aspeed: Add Caliptra ECDSA384 support

 boot/image-fit-sig.c                |   2 +-
 drivers/crypto/aspeed/Kconfig       |  10 ++
 drivers/crypto/aspeed/Makefile      |   1 +
 drivers/crypto/aspeed/cptra_ecdsa.c | 184 ++++++++++++++++++++++++++++
 include/u-boot/ecdsa.h              |   1 +
 lib/ecdsa/ecdsa-verify.c            |  14 ++-
 tools/image-sig-host.c              |   7 ++
 7 files changed, 215 insertions(+), 4 deletions(-)
 create mode 100644 drivers/crypto/aspeed/cptra_ecdsa.c

-- 
2.25.1

