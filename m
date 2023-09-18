Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E9ECD37B0
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 12:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF5CD86915;
	Mon, 18 Sep 2023 14:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F2F08690B; Mon, 18 Sep 2023 14:12:38 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78BA68082A
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 14:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 38ICCPoP050540;
 Mon, 18 Sep 2023 20:12:25 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Mon, 18 Sep 2023 20:12:25 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 Randolph <randolph@andestech.com>
Subject: [PATCH V2 0/3] andes: rearrange defconfig and dts
Date: Mon, 18 Sep 2023 20:11:33 +0800
Message-ID: <20230918121136.2295900-1-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 38ICCPoP050540
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

Changes in v2:
- Split the original patch into three smaller ones

Randolph (3):
  configs: andes: add vender prefix for target name
  configs: andes: rearrange SPL mode memory layout
  dts: andes: add SPL config option for itb layout

 arch/riscv/Kconfig                   |  4 ++--
 arch/riscv/dts/Makefile              |  2 +-
 arch/riscv/dts/ae350-u-boot.dtsi     |  1 +
 arch/riscv/dts/ae350_32.dts          |  1 -
 arch/riscv/dts/ae350_64.dts          |  1 -
 board/AndesTech/ae350/Kconfig        |  8 +++++++-
 configs/ae350_rv32_defconfig         |  3 ++-
 configs/ae350_rv32_spl_defconfig     | 10 ++++++----
 configs/ae350_rv32_spl_xip_defconfig |  8 +++++---
 configs/ae350_rv32_xip_defconfig     |  3 ++-
 configs/ae350_rv64_defconfig         |  3 ++-
 configs/ae350_rv64_spl_defconfig     | 10 ++++++----
 configs/ae350_rv64_spl_xip_defconfig |  8 +++++---
 configs/ae350_rv64_xip_defconfig     |  3 ++-
 14 files changed, 41 insertions(+), 24 deletions(-)

-- 
2.34.1

