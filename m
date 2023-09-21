Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB337CD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FBCE86C72;
	Thu, 21 Sep 2023 03:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5375E86C55; Thu, 21 Sep 2023 03:29:57 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CFC086CC4
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:29:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 38L1TgFb000214;
 Thu, 21 Sep 2023 09:29:42 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 21 Sep 2023 09:29:41 +0800
Date: Thu, 21 Sep 2023 09:28:46 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>, <ycliang@andestech.com>
Subject: [PULL] u-boot-riscv/next
Message-ID: <ZQucTuzK1hvN9NMl@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 38L1TgFb000214
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

The following changes since commit c58ee1c9946a1550b1f6fee2b25da9ecc89baf71:

  Merge branch '2023-09-19-tidy-up-some-kconfig-options' into next (2023-09-19 17:44:18 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git next

for you to fetch changes up to 90602e779d3ae3bd02faae0eb40b4fcefec419f7:

  riscv: dts: starfive: generate u-boot-spl.bin.normal.out (2023-09-20 21:05:16 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/17779
----------------------------------------------------------------

+ Add NVMe & USB boot devices for VisionFive2
+ Add StarFive SPL image support in mkimage tool

----------------------------------------------------------------
Heinrich Schuchardt (4):
      riscv: set fdtfile on VisionFive 2
      configs: NVMe/USB target boot devices on VisionFive 2
      tools: mkimage: Add StarFive SPL image support
      riscv: dts: starfive: generate u-boot-spl.bin.normal.out

Milan P. Stanić (1):
      starfive: visionfive2: add mmc0 and nvme boot targets

 arch/riscv/Kconfig                                 |   1 +
 .../dts/jh7110-starfive-visionfive-2-u-boot.dtsi   |  11 ++
 board/starfive/visionfive2/starfive_visionfive2.c  |  43 ++++-
 boot/image.c                                       |   1 +
 doc/board/starfive/visionfive2.rst                 |  14 +-
 include/configs/starfive-visionfive2.h             |   3 +
 include/image.h                                    |   1 +
 tools/Makefile                                     |   1 +
 tools/sfspl.c                                      | 174 +++++++++++++++++++++
 9 files changed, 235 insertions(+), 14 deletions(-)
 create mode 100644 tools/sfspl.c

 Best regards,
 Leo
