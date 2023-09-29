Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7098E71D40
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 14:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B292C86EE1;
	Fri, 29 Sep 2023 16:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="iE+vF7/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F25786EF0; Fri, 29 Sep 2023 16:36:44 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECDFF86E49
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 16:36:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [192.168.0.125] (unknown [82.76.24.202])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 4EC77660036E;
 Fri, 29 Sep 2023 15:36:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1695998201;
 bh=83NcbPznX/ofoohpz/3STjZBbDnVLbkTTYqeYWHigR8=;
 h=Date:From:Subject:To:Cc:From;
 b=iE+vF7/XnKKAWLyhjA1gQRpTCa3n6wntcnk1AGN2X1pQaYAJ2JGY4in82JKHVxyDU
 j+xeCH9inGK7JwkisEMJkSZaAb2b9MSFYxTbcDzlcb335O1/Y2ltk4e/jNIKPKo7DZ
 aWk+EwRdvV8WI0iO9lMflCxBd7uIEtqzGIr3UK75kOuDJpwhWR1BYSy9k4I1YSn825
 x3DAneViUuk/+Icmhy6fW4ckCrwwZc9jS47nY3sZ6InUHz1OpA7tIimDLSKZRXBRAO
 hRhpKeOUs57XssHJ/+o9yWiwYwliVFIIBdKQUrfCLdpKVdijqfXFCwlQwjhHGvTK/P
 RmBjX9WdNmBLw==
Message-ID: <f223ce83-55be-aa17-e003-69627d71e948@collabora.com>
Date: Fri, 29 Sep 2023 17:36:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PULL] u-boot-at91-fixes-2023.10-b
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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


Hello Tom,

Please pull tag u-boot-at91-fixes-2023.10-b , the second set of fixes 
for 2023.10 cycle.

This comes late, but I hope you can merge it before the release, it's 
only two small fixes , one for an array not initialized and the second 
one fixes an error case when a DT property is missing for the atmel NAND 
driver.

Thanks,
Eugen


The following changes since commit 15155ab0a3d1f839509bcac620bfb38f950bead6:

   Merge tag 'u-boot-imx-20230923' of 
https://source.denx.de/u-boot/custodians/u-boot-imx (2023-09-24 17:15:31 
-0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-at91.git 
tags/u-boot-at91-fixes-2023.10-b

for you to fetch changes up to 7b4ffe8c32db284e25d3a2636904def8e093da9e:

   clk: at91: Fix initializing arrays (2023-09-29 16:45:40 +0300)

----------------------------------------------------------------
Second set of u-boot-atmel fixes for the 2023.10 cycle

----------------------------------------------------------------
Alexander Dahl (1):
       mtd: nand: raw: atmel: Add error handling when rb-gpios missing

Francois Berder (1):
       clk: at91: Fix initializing arrays

  drivers/clk/at91/sam9x60.c                   |  4 ++--
  drivers/clk/at91/sama7g5.c                   |  4 ++--
  drivers/mtd/nand/raw/atmel/nand-controller.c | 11 +++++++----
  3 files changed, 11 insertions(+), 8 deletions(-)
