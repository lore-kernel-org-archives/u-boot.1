Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F89C47DDF
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 10:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AFB587C3D;
	Thu,  1 Feb 2024 11:50:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1706784650;
	bh=suaskAb/Ila9asaDwCF8b5yN2bZIZ5nm96xsZXxVAJM=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h+M6om9n8pJ4rQc38ktlIUgPH2DxU97zAGgMVlK4j58Xa1Nt4B4r5O8Bxe0XBJ5MM
	 OHuBLhLRUJZA+ts0uVFNHPeluHQfgkXOztTbwx1zfWzgszK15gMT1WDCE9DlYSFFJD
	 yecX1yRAspkGDUPL5toI9h4acp0DrLvVjUWsP0UNG/qk+osv5K63y2OUjbtx7cAnlY
	 udSRng/aiL5ld8rSKX6Tpvk+AdrlOneTed4hMIJ3Grvx7bUwtTv27DTCLF2tOfQ1ke
	 g8tTT0o9t6+LPUGOkOXJPuXqt16F3lmLUVR93h9DHXpBlzXVGBAr/y1lG741Vi2jgJ
	 0Dl0hQGpbyERg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F33887C74; Thu,  1 Feb 2024 11:50:49 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1682D87C49
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 11:50:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4TQbKc3csDz9scD;
 Thu,  1 Feb 2024 11:50:44 +0100 (CET)
Message-ID: <d46b4ac3-8834-42e1-8371-dbbc596af962@denx.de>
Date: Thu, 1 Feb 2024 11:50:43 +0100
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
From: Stefan Roese <sr@denx.de>
Subject: Please pull u-boot-watchdog/master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

please pull the following watchdog related last minute fixes:

----------------------------------------------------------------
- add andes atcwdt200 support (Randolph)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=339&view=results

Thanks,
Stefan


The following changes since commit b6d8969bcb94321dfed1399f2eaa8768ba42caaa:

   Merge tag 'u-boot-at91-2024.04-a' of 
https://source.denx.de/u-boot/custodians/u-boot-at91 (2024-01-31 
10:44:33 -0500)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-watchdog.git

for you to fetch changes up to 094eda0660d419f35e10c49fade75a6738a56137:

   configs: andes: add watchdog support fot andes ae350 (2024-02-01 
09:08:44 +0100)

----------------------------------------------------------------
Randolph (2):
       drivers: watchdog: add andes atcwdt200 support
       configs: andes: add watchdog support fot andes ae350

  configs/ae350_rv32_defconfig         |   4 +
  configs/ae350_rv32_spl_defconfig     |   4 +
  configs/ae350_rv32_spl_xip_defconfig |   4 +
  configs/ae350_rv32_xip_defconfig     |   4 +
  configs/ae350_rv64_defconfig         |   4 +
  configs/ae350_rv64_spl_defconfig     |   4 +
  configs/ae350_rv64_spl_xip_defconfig |   4 +
  configs/ae350_rv64_xip_defconfig     |   4 +
  drivers/watchdog/Kconfig             |   6 +
  drivers/watchdog/Makefile            |   1 +
  drivers/watchdog/atcwdt200_wdt.c     | 220 
+++++++++++++++++++++++++++++++++++
  11 files changed, 259 insertions(+)
  create mode 100644 drivers/watchdog/atcwdt200_wdt.c
