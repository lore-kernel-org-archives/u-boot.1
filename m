Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A637CCA0ED3
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 08:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D4C588CA0;
	Wed,  4 Sep 2024 10:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725437870;
	bh=Oe/EpTI0vQTAJ2H9mip7cn5ymeFJ1SjhTSB22khGwEc=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GcAuwmtE8G+hlwvv8FvJmtdqw5Fj1clerXOXavHkbp8JY9C43MbZDB5qOOgISUxaH
	 LdbIOYSXuA7NcpoyVwpqC46EvcozjtPMuQTrhfcY1q100IrT6UODD6/VfWEcZVwuPT
	 uDRZdfPHSsjKJvvlSgi+gYJ3zBampmXsqj01Wk+lymUCwEpHNwCz13o0ccOJnFPGbT
	 /yEErWajMp9EYJHluwmlCS7qk7xyyQ+U+x6zFrpD73O07IYMdY55LI/vBZEU43kzBY
	 oXKD+RR1I3Bwbd4/0DabHoz+QUG2qm3FbOzuoEyk0jSvRwMpmI463gVya/K5O2tO8v
	 U/u8wRPOLQMFw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id F37D188CAF; Wed,  4 Sep 2024 10:17:48 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F19E988C8A
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 10:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4WzFjN4bNCz9skq;
 Wed,  4 Sep 2024 10:17:44 +0200 (CEST)
Message-ID: <ef195bc4-6b61-4c9e-9de8-269e93b73388@denx.de>
Date: Wed, 4 Sep 2024 10:17:43 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
From: Stefan Roese <sr@denx.de>
Subject: Please pull u-boot-marvell/master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

I know it's late in the release process. But please consider
pulling these Turris Omnia DDR related patches / fixes, which
Marek would like to see in the upcoming release:

----------------------------------------------------------------
- Turris Omnia DDR speed change with reset button (Marek)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=374&view=results

Thanks,
Stefan

The following changes since commit 1312faac5f52d27cfb45dfe1a5a93a2944ca5c21:

   Prepare v2024.10-rc4 (2024-09-02 14:07:53 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-marvell.git

for you to fetch changes up to bc8664c9f31195a0249dd4eb0794f4a8625ad864:

   arm: mvebu: turris_omnia: Switch DDR speed to 1333H when reset 9 is 
selected (2024-09-03 14:24:32 +0200)

----------------------------------------------------------------
Marek Behún (3):
       arm: mvebu: turris_omnia: Rename variable holding EEPROM udevice
       arm: mvebu: turris_omnia: Use the i2c_eeprom misc driver for 
EEPROM reading in U-Boot proper
       arm: mvebu: turris_omnia: Switch DDR speed to 1333H when reset 9 
is selected

  arch/arm/mach-mvebu/Kconfig              |   1 +
  board/CZ.NIC/turris_omnia/turris_omnia.c | 101 
++++++++++++++++++++++++++-----
  configs/turris_omnia_defconfig           |   1 -
  3 files changed, 86 insertions(+), 17 deletions(-)
