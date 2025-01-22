Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFD2C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 15:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB7B2807E9;
	Wed, 22 Jan 2025 16:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737559179;
	bh=hxvt8H4T3kpHlVK7RX77/VCCO90RQN4fkGYXdhP8Cnc=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qj4ZPhcN/x9lkCkXzFbeIAStbthEygNnGB8rkuw4mWkBm6scd0H8oOEeNV3Q6Xha3
	 8dQgPOD1pEMMJz6IkjgkEfFFFUFppAo0u9HTkhM3HbNl28cWRvIV8PeKZdo0mEFxHf
	 jdM+O7UMJmafS1dsbNZWwfVkKLUomAE/1cJS6BL7FKNZLWQVsYSJgdcHedk0u4+rdm
	 8ec+hnW3ln+HbK3mYavIBZ7PApfJbg/QVzCW+cIpJfJuoCwCaMoXUFP2idPJ0m9uRm
	 Wj9GllPyOGRMTyGYzKzYVovZ44no8CjXan+OP5vRRFF8O9N7YBg8VzXLE/JiPaY63N
	 Xcu+cflkhBKMw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FC5A807F9; Wed, 22 Jan 2025 16:19:39 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D58A807D6
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 16:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4YdSRV5L8wz9smk;
 Wed, 22 Jan 2025 16:19:34 +0100 (CET)
Message-ID: <93c0d02b-889a-4dc3-8fab-677b1c4fc6be@denx.de>
Date: Wed, 22 Jan 2025 16:19:34 +0100
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
From: Stefan Roese <sr@denx.de>
Subject: Please pull u-boot-watchdog/master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4YdSRV5L8wz9smk
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

please pull the following watchdog related patches:

----------------------------------------------------------------
- cyclic: Fix rollover every 72 min on 32 bits platforms (Patrice)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=381&view=results

Thanks,
Stefan

The following changes since commit 82d262ae162d859d3b0bbcd40a9464e890b009da:

   Merge patch series "MediaTek MT7629 OF_UPSTREAM migration (v2)" 
(2025-01-21 09:29:05 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-watchdog.git

for you to fetch changes up to fb30f75655cdd1bf838827a8461b3434c07b1a62:

   cyclic: Fix typo in struct cyclic_info description (2025-01-22 
10:22:34 +0100)

----------------------------------------------------------------
Patrice Chotard (2):
       cyclic: Fix rollover every 72 min on 32 bits platforms
       cyclic: Fix typo in struct cyclic_info description

  common/cyclic.c  | 6 +++---
  include/cyclic.h | 2 +-
  2 files changed, 4 insertions(+), 4 deletions(-)

