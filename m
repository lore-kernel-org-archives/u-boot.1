Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AB0C3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 11:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8FA082A8B;
	Fri, 16 May 2025 13:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1747395732;
	bh=uj3a7AgGZFZ2nN8YjYMxYYqcwvo1J7UL90ZLAm2y7rU=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QzKcNAfDofRKMMde3NaPXflx9RgCl7nMJF8uhodCb+PL75z4u58Yk1EyOyboftd+T
	 xgTor3K9X+KMkxGhR1dP07xQRznqs0HaibyWkiuacXCD/SCdUw7UIMCi+1nKuGMFKL
	 8t5zyniavIEm41TQUmykCY+Je1GLqCbjWx5mTCasXv2+IzS0zKbZhCsstC3ooO0ww+
	 V1AfcvA+HVh8x3wCEPHlq0KIYz85qkyy6u0HoJ3q+1ZyudLws2g4AiTpKpDYTVzHwe
	 o1dFM+v9Gk4MH7Pj+aP8W1ZJxnyEPnmhucLnHkkBPre3mt8e8IU+g/GwQYBl/S/toC
	 ih5orSz24xP3Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9B9382A8B; Fri, 16 May 2025 13:42:11 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E61E682A36
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 13:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4ZzQCv49wyz9tZh;
 Fri, 16 May 2025 13:42:03 +0200 (CEST)
Message-ID: <6e0b4e17-34c8-42f3-8f62-3e822e37fd4c@denx.de>
Date: Fri, 16 May 2025 13:42:02 +0200
MIME-Version: 1.0
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Please pull u-boot-marvell/master
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

please pull this next batch of mostly Marvell related patches:

----------------------------------------------------------------
- mvebu_espressobin_ultra-88f3720_defconfig: enable hwrng
- kirkwood: Convert to DM_SERIAL for Kirkwood boards
- kirkwood: Convert to DM_SERIAL for Synology DS109 board
- cmd: tlv_eeprom: return after successful read from EEPROM
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=392&view=results

Thanks,
Stefan

The following changes since commit 1b5e435102aa29a665119430196cb366ce36a01b:

   Merge tag 'u-boot-imx-master-20250512' of 
https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2025-05-12 16:05:22 
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-marvell.git 
tags/u-boot-marvell-20250516-v2

for you to fetch changes up to 7afcde09399297765945d57be4535291b2ac9549:

   cmd: tlv_eeprom: return after successful read from EEPROM (2025-05-16 
08:17:43 +0200)

----------------------------------------------------------------
Benjamin Schneider (1):
       configs: mvebu_espressobin_ultra-88f3720_defconfig: enable hwrng

Martin Schiller (1):
       cmd: tlv_eeprom: return after successful read from EEPROM

Tony Dinh (3):
       arm: kirkwood: Convert to DM_SERIAL for Kirkwood boards
       arm: kirkwood: Convert to DM_SERIAL for Synology DS109 board
       arm: kirkwood: Remove Synology DS109 board reset_misc

  arch/arm/mach-kirkwood/Kconfig                    |  9 +++++++++
  board/Synology/ds109/ds109.c                      | 18 ------------------
  cmd/tlv_eeprom.c                                  |  1 +
  configs/ds109_defconfig                           |  2 --
  configs/mvebu_espressobin_ultra-88f3720_defconfig |  2 ++
  5 files changed, 12 insertions(+), 20 deletions(-)

