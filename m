Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F4DC4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 14:47:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75A2F878A5;
	Wed, 10 Jan 2024 15:47:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1704898050;
	bh=QuuHU2fgjdVTGKl+HEC9PGSoiPHuj9erCS5xXX3F7Pw=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DriK88//ycz+q+IM+LhViFZoeO6oU7pXdE1w/OXMZlznAyfsQ8Y6Qo1DKXAdXu4H4
	 8RhBknL7Dt83GdKQa82eq0WsnEx8kbyAdQbPR/5A87A/JviQPK0GwA8rd82OxFnG/D
	 B4vSJ0uC/9lPg9/Ma5RJYYUVOms+YArtiT5iG7ohPzxsi6oVecal0uW7gtnIkMovok
	 D5wiAnws4Qewjbzi700KAwAfyAQTOGm6v2ZT7H9cHgrfvnL5Bu59T3MGmj63gwawjb
	 iow5cKz+060kr4MjQj8eV8RGK7lBUh/pUDcA/Nxf5yCSKT7/MqIWc0r3RUQ2s0xTAL
	 jPwpkYvWKBlxg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC3038791E; Wed, 10 Jan 2024 15:47:29 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD71D8785F
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 15:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4T99cs3ctdz9snD;
 Wed, 10 Jan 2024 15:47:25 +0100 (CET)
Message-ID: <f8ce7a1a-8a39-458b-9202-ef2f364969a1@denx.de>
Date: Wed, 10 Jan 2024 15:47:24 +0100
MIME-Version: 1.0
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Please pull u-boot-marvell/master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4T99cs3ctdz9snD
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

please pull this next batch of Marvell related patches:

----------------------------------------------------------------
- AC5: Use finer grained memory map (Chris)
- Espressobin: Misc improvements (Robert)
- eDPU: Support new board revision (Robert)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=331&view=results

Thanks,
Stefan


The following changes since commit 344667db6450de838bd83f0f57e177e6d4744d89:

   Merge tag 'smbios-2024-04-rc1' of 
https://source.denx.de/u-boot/custodians/u-boot-efi (2024-01-09 12:50:04 
-0500)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-marvell.git

for you to fetch changes up to 46471e6c1d58442140259f7e44a5c3e0d6e02351:

   arm: mvebu: eDPU: support new board revision (2024-01-10 09:38:55 +0100)

----------------------------------------------------------------
Chris Packham (1):
       arm: mvebu: AC5: Use finer grained memory map

Robert Marko (3):
       arm: mvebu: Espressobin: move FDT fixup into a separate function
       arm: mvebu: Espressobin: move network setup into a separate function
       arm: mvebu: eDPU: support new board revision

  arch/arm/dts/armada-3720-eDPU-u-boot.dtsi |  13 ++-
  arch/arm/dts/armada-3720-eDPU.dts         |  47 +++++++++
  arch/arm/mach-mvebu/alleycat5/cpu.c       |  66 ++++++++++---
  board/Marvell/mvebu_armada-37xx/board.c   | 159 
++++++++++++++++++++++++++++--
  configs/eDPU_defconfig                    |   1 +
  5 files changed, 256 insertions(+), 30 deletions(-)
