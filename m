Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69C1D6ACCA
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 13:09:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D34E897D9;
	Wed, 27 Nov 2024 14:09:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28DD9897D5; Wed, 27 Nov 2024 14:09:00 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4951897F9
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 14:08:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 4ARD8jXJ036199
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Wed, 27 Nov 2024 21:08:45 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Nov
 2024 21:08:45 +0800
Date: Wed, 27 Nov 2024 21:08:43 +0800
From: Leo Liang <ycliang@andestech.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <ycliang@andestech.com>, <rick@andestech.com>
Subject: [GIT PULL] u-boot-riscv/master
Message-ID: <Z0cZ274duxXqZ-9r@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4ARD8jXJ036199
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

The following changes since commit 3881c6b90350b0b04085ad46ef64989b43967eef:

  configs: Resync with savedefconfig (2024-11-26 08:17:35 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-riscv.git 

for you to fetch changes up to bdca70632dad38a1f7830c955771c0bd88ce7ae0:

  configs: enable CONFIG_PCI_REGION_MULTI_ENTRY=y in sifive_unmatched_defconfig (2024-11-27 19:58:08 +0800)

CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/23592
----------------------------------------------------------------
- some configs modification
----------------------------------------------------------------
Andreas Schwab (1):
      configs: visionfive2: re-enable SPL_SYS_MMCSD_RAW_MODE

Heinrich Schuchardt (1):
      configs: SiFive Unmatched: enable 'env erase' sub-command

Yuri Zaporozhets (2):
      spl: increase SPL_SYS_MALLOC_SIZE when using BIOSEMU on RISC-V
      configs: enable CONFIG_PCI_REGION_MULTI_ENTRY=y in sifive_unmatched_defconfig

 common/spl/Kconfig                     | 1 +
 configs/sifive_unmatched_defconfig     | 2 ++
 configs/starfive_visionfive2_defconfig | 3 +++
 3 files changed, 6 insertions(+)

Best regards,
Leo
