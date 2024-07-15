Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACF8C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F36CE887EB;
	Mon, 15 Jul 2024 12:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721041150;
	bh=Ag0ekUi6RTMFjN2TmDYfHqALjBK2G5mE/S/OxXNaVgo=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aNOmChwZhkyxlPUoxauDuq6POqCUu4NAOYxxhdEA3Zrc4DWnFYav7ALx6nxKi2GJR
	 Wn9qoZaO5vH3Jb3mNImMJKKUeLcmh9LYPQE0Zm1lCA4s6MxlFRIBeEi50wTbvSk/A5
	 faUgKUrPVznnIK4FMe2qh9I2gW+n7EZfOpfJF65ca/gvDKU2SRX69ZGt/Bhyko/af1
	 jl/2hsKzq+TE9vt1lRTqSOQF+Yn3aBNnLdRScW1LLpD3U519MSeLqXVA/ZVuoWPcnL
	 JfVDioD8+Cx/FF1czs6A1XBh53a18hD8HEP3WOS1sJCCUhN5Aat5wk9yhXCLxQ5+Yz
	 IsFrjgxA/CyXQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB091887EE; Mon, 15 Jul 2024 12:59:08 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0D1487F9F
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4WMzj42sCzz9sSd;
 Mon, 15 Jul 2024 12:59:04 +0200 (CEST)
Message-ID: <412c7fd9-1495-447b-98c3-a0136950182c@denx.de>
Date: Mon, 15 Jul 2024 12:59:03 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
From: Stefan Roese <sr@denx.de>
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

please pull this small batch of Marvell related patches:

----------------------------------------------------------------
- mvebu: Migrate to upstream DT for Synology DS116 (Armada 385) board (Tony)
- mvebu: Enable bootstd and other modernization for Synology DS414 
(Armada XP) board (Tony)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=373&view=results

Thanks,
Stefan

The following changes since commit b182816c1fb436916661949213c543bf4d42250b:

   turris_1x: Normalize Kconfig usage (2024-07-13 10:42:15 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-marvell.git

for you to fetch changes up to 51d4eb8bbaf35d14d4e30b885863ae00fbc47258:

   arm: mvebu: Enable bootstd and other modernization for Synology DS414 
(Armada XP) board (2024-07-15 08:42:04 +0200)

----------------------------------------------------------------
Tony Dinh (2):
       arm: dts: mvebu: Migrate to upstream DT for Synology DS116 
(Armada 385) board
       arm: mvebu: Enable bootstd and other modernization for Synology 
DS414 (Armada XP) board

  arch/arm/dts/Makefile                      |   1 -
  arch/arm/dts/armada-385-synology-ds116.dts | 291 
-----------------------------
  board/Synology/ds414/ds414.c               |  14 +-
  configs/ds116_defconfig                    |   3 +-
  configs/ds414_defconfig                    |  19 +-
  include/configs/ds414.h                    |  65 +++++--
  6 files changed, 63 insertions(+), 330 deletions(-)
  delete mode 100644 arch/arm/dts/armada-385-synology-ds116.dts
