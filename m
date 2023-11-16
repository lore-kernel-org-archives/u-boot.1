Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBBCC197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 13:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6401387479;
	Thu, 16 Nov 2023 14:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 748D087479; Thu, 16 Nov 2023 14:02:10 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9E078748D
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 14:02:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3AGD1rst001768;
 Thu, 16 Nov 2023 21:01:53 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 16 Nov 2023
 21:01:52 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 <peterlin@andestech.com>, Randolph <randolph@andestech.com>
Subject: [PATCH V3 0/3] doc: falcon: riscv: Falcon Mode boot on RISC-V 
Date: Thu, 16 Nov 2023 21:01:33 +0800
Message-ID: <20231116130136.2796918-1-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3AGD1rst001768
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
- Change by suggestions in falcon.rst 
- Move the board-related code to arch-specific code,
  its the issue when enabling LOAD_FIT_OPENSBI_OS_BOOT
- Add SPL_PAYLOAD_ARGS_ADDR to defconfig.
  This is the address that SPL copies into defconfig.

Randolph (3):
  doc: falcon: riscv: Falcon Mode boot on RISC-V
  spl: riscv: falcon: move fdt blob to specified address
  configs: andes: add the fdt blob address for SPL copy to

 board/AndesTech/ae350/ae350.c           |  25 ----
 common/spl/Kconfig                      |   2 +-
 common/spl/spl_opensbi.c                |  16 +++
 configs/ae350_rv32_falcon_defconfig     |   1 +
 configs/ae350_rv32_falcon_xip_defconfig |   1 +
 configs/ae350_rv64_falcon_defconfig     |   1 +
 configs/ae350_rv64_falcon_xip_defconfig |   1 +
 doc/develop/falcon.rst                  | 171 ++++++++++++++++++++++++
 8 files changed, 192 insertions(+), 26 deletions(-)

-- 
2.34.1

