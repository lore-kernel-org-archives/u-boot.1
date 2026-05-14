Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691E2CD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 13:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E45CC80F0E;
	Thu, 14 May 2026 15:37:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="O1Yb4v3j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D3CB8467B; Thu, 14 May 2026 15:37:16 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E65A8039B
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 15:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6112210D133; Thu, 14 May 2026 15:37:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1778765830;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=5Q+rMcLMbdpTu4HfRDArnxWjWpD3OGfmv/BaUtdthbI=;
 b=O1Yb4v3jQPyZJkc7P4H8IwjotX1Kw9Z84wxKi4wAZZ0uY5pUEbuadn3b1O3GrLtZpdjN8R
 Q8ZjMH6Pw7ll8GClKviKVaLJcaj60MveCTjjm2500YsWkQwh23MIifhu/k9y/ovH0HX06j
 UN5QE47B8XICKh5NUriKgZtmAK5d0yWyiXhYpx0eh5fuSmaIoMUNoYrG/oxIDzkS932B2u
 E9/T8lriJYIc92sr3SEJhg4WMLAVe0toRCgQnI4d4NVUGfAJLZQHAKmrnj8bAOCpmB7/FE
 mOJSJ3ZsQtWo+2zfcnQ687Rz9nDc1mAgIuGD/gW1QE/w9cwr907riLa32Bo0VA==
Message-ID: <1f922957-e56d-1187-4441-e98e9f8fe25e@nabladev.com>
Date: Thu, 14 May 2026 15:36:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut@mailbox.org>
From: Heiko Schocher <hs@nabladev.com>
Subject: Please pull u-boot-i2c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Tom,

The following changes since commit 36d4c653580824b16574560b21d4401614d8b68e:

   virtio: fix return value check (2026-05-12 12:38:49 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2c-updates-for-2026.07-rc3

for you to fetch changes up to 0c464b6cc3ead31a5b3bfe23d38871380f3fb6fa:

   i2c: Remove legacy CONFIG_SYS_I2C_SOFT (2026-05-14 11:17:20 +0200)

----------------------------------------------------------------
updates for 2026.07-rc3

- designware_i2c: Staticize driver ops from Marek
- i2c: Remove legacy CONFIG_SYS_I2C_SOFT
-

----------------------------------------------------------------
Marek Vasut (1):
       i2c: designware_i2c: Staticize driver ops

Tom Rini (1):
       i2c: Remove legacy CONFIG_SYS_I2C_SOFT

  README                           |  92 ---------------------------------
  board/nxp/m53017evb/README       |   4 --
  board/nxp/m5373evb/README        |   4 --
  drivers/i2c/Kconfig              |  20 --------
  drivers/i2c/Makefile             |   1 -
  drivers/i2c/designware_i2c_pci.c |   2 +-
  drivers/i2c/soft_i2c.c           | 418 
-----------------------------------------------------------------------------------------------------------------------------------------------------
  7 files changed, 1 insertion(+), 540 deletions(-)


Azure build looks good:

https://dev.azure.com/hs0298/hs/_build/results?buildId=207&view=results

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
