Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7792FC87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 11:38:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D10AC83AB4;
	Thu,  7 Aug 2025 13:38:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E294083AB4; Thu,  7 Aug 2025 13:38:20 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41043833AD
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 13:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 577Bc7iR077224
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
 for <u-boot@lists.denx.de>; Thu, 7 Aug 2025 19:38:07 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 19:38:07 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <ycliang@andestech.com>, <randolph@andestech.com>, <tim609@andestech.com>
Subject: [PATCH 0/6] Add Andes Voyager board support
Date: Thu, 7 Aug 2025 19:37:29 +0800
Message-ID: <20250807113729.360044-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 577Bc7iR077224
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

The Voyager is a 9.6” x 9.6” Micro ATX form factor development board
including Andes QiLai SoC. This patch series adds minimal device tree
files for the QiLai SoC and the Voyager board [1].

[1] https://www.andestech.com/en/products-solutions/andeshape-platforms/qilai-chip/

Leo Yu-Chi Liang (6):
  riscv: board: Add Andes Voyager board Kconfig support
  riscv: dts: andes: Add Voyager device tree
  board: MAINTAINERS: Add Voyager board maintainer
  board: andestech: Add Voyager board support
  configs: andes: add Voyager board defconfig
  doc: board: voyager: Add documentation for Voyager

 arch/riscv/Kconfig                  |   4 +
 arch/riscv/dts/Makefile             |   1 +
 arch/riscv/dts/qilai-voyager.dts    | 227 ++++++++++++++++++++++++++++
 arch/riscv/dts/voyager-u-boot.dtsi  |  52 +++++++
 board/andestech/voyager/Kconfig     |  44 ++++++
 board/andestech/voyager/MAINTAINERS |   7 +
 board/andestech/voyager/Makefile    |   6 +
 board/andestech/voyager/voyager.c   |  71 +++++++++
 configs/voyager_spl_defconfig       |  66 ++++++++
 doc/board/andestech/voyager.rst     |  81 ++++++++++
 include/configs/voyager.h           |  40 +++++
 11 files changed, 599 insertions(+)
 create mode 100644 arch/riscv/dts/qilai-voyager.dts
 create mode 100644 arch/riscv/dts/voyager-u-boot.dtsi
 create mode 100644 board/andestech/voyager/Kconfig
 create mode 100644 board/andestech/voyager/MAINTAINERS
 create mode 100644 board/andestech/voyager/Makefile
 create mode 100644 board/andestech/voyager/voyager.c
 create mode 100644 configs/voyager_spl_defconfig
 create mode 100644 doc/board/andestech/voyager.rst
 create mode 100644 include/configs/voyager.h

-- 
2.34.1

