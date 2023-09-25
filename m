Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3616DCE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 09:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E70286B3F;
	Mon, 25 Sep 2023 11:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 594D186BD3; Mon, 25 Sep 2023 11:26:25 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51CBA86B3A
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 11:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 38P9QBlc060858;
 Mon, 25 Sep 2023 17:26:11 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Mon, 25 Sep 2023 17:26:09 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 Randolph <randolph@andestech.com>
Subject: [PATCH V3 0/2] andes: rearrange defconfig and dts
Date: Mon, 25 Sep 2023 17:24:50 +0800
Message-ID: <20230925092452.1402614-1-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 38P9QBlc060858
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

Changes in v3:
- Drop the "SPL config option for itb layout" patch

Changes in v2:
- Split the original patch into three smaller ones

Randolph (2):
  configs: andes: add vender prefix for target name
  configs: andes: rearrange SPL mode memory layout

 arch/riscv/Kconfig                   | 4 ++--
 arch/riscv/dts/Makefile              | 2 +-
 board/AndesTech/ae350/Kconfig        | 2 +-
 configs/ae350_rv32_defconfig         | 2 +-
 configs/ae350_rv32_spl_defconfig     | 9 +++++----
 configs/ae350_rv32_spl_xip_defconfig | 7 ++++---
 configs/ae350_rv32_xip_defconfig     | 2 +-
 configs/ae350_rv64_defconfig         | 2 +-
 configs/ae350_rv64_spl_defconfig     | 9 +++++----
 configs/ae350_rv64_spl_xip_defconfig | 7 ++++---
 configs/ae350_rv64_xip_defconfig     | 2 +-
 11 files changed, 26 insertions(+), 22 deletions(-)

-- 
2.34.1

