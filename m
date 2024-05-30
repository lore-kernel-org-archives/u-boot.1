Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3133DC25B78
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 08:57:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 506798867C;
	Thu, 30 May 2024 10:57:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F78B88372; Thu, 30 May 2024 10:57:12 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89253881E5
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 10:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 44U8uuHT050879;
 Thu, 30 May 2024 16:56:56 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 30 May 2024 16:56:54 +0800
Date: Thu, 30 May 2024 16:56:49 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <ycliang@andestech.com>, <rick@andestech.com>
Subject: [GIT PULL] u-boot-riscv/master
Message-ID: <Zlg_MycDVG7f4pqx@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 44U8uuHT050879
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

Hi Tom,

The following changes since commit 46ff00bea5dd2dd247d5e2fdadbf5dcf8653cd9a:

  Merge tag 'tpm-master-27052024' of https://source.denx.de/u-boot/custodians/u-boot-tpm (2024-05-27 08:56:02 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to 1d29c718b7ba09807f8060796d9c21772e3c1b52:

  andes: Use UCCTLCOMMAND instead of MCCTLCOMMAND (2024-05-30 16:01:13 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/20920
----------------------------------------------------------------

- board: fix support for icicle
- board: support Star64 board
- andes: minor fixes
- riscv: deprecate cache enablement in start.S

----------------------------------------------------------------
Conor Dooley (2):
      board: microchip: icicle: correct type for node offset
      board: microchip: icicle: make both ethernets optional

H Bell (2):
      board: starfive: support Pine64 Star64 board
      board: starfive: support Pine64 Star64 board

Leo Yu-Chi Liang (3):
      andes: l2 cache driver: fixes typos and cctl status
      riscv: remove cache enablement in start.S
      andes: Use UCCTLCOMMAND instead of MCCTLCOMMAND

 arch/riscv/cpu/andes/cache.c                      |   4 +-
 arch/riscv/cpu/start.S                            |   4 -
 arch/riscv/include/asm/arch-andes/csr.h           |   2 +-
 board/microchip/mpfs_icicle/mpfs_icicle.c         |  25 +--
 board/starfive/visionfive2/spl.c                  |  89 ++++++++++
 board/starfive/visionfive2/starfive_visionfive2.c |   4 +
 doc/board/starfive/index.rst                      |   1 +
 doc/board/starfive/pine64_star64.rst              | 201 ++++++++++++++++++++++
 drivers/cache/cache-andes-l2.c                    |   8 +-
 9 files changed, 310 insertions(+), 28 deletions(-)
 create mode 100644 doc/board/starfive/pine64_star64.rst

Best regards,
Leo
