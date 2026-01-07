Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067EBCF6BF0
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 07:15:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A50083C6E;
	Wed,  7 Jan 2026 08:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="FTMPs6ur";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 221FB84033; Wed,  7 Jan 2026 08:15:17 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA56E83BC4
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 08:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6298010C196; Wed,  7 Jan 2026 08:15:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1767770114;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=crMmfu4LL9f9fqJ9my3YijbB0MlR5zNPbnihbHs8AhY=;
 b=FTMPs6urgUumUR6gxMx4OeTn3BtifuGh8iqdAYhE4NrePZtARWTy78T2nkTkXHWVZKGDNi
 nUek46hYtX9+t20wiYnEDfrFjyCv9HvGZvRc2RM+MhnhfNxeF1d8/nGFwuB1+vaD8Q4tcB
 638sD457PDjGtWhrMw/AcBEUrnkITBIDX1LbUANb87DMjszYodP3SowSr4/hDBJRXYunku
 E5xNLdHWiK/oE0S5XhRrUTXTjMyNgVAA7EsSuuhlWsZ9P2jrP5eyLOMxwGtmtjqZUYfK8C
 9c3OZyQWYKM7pI3wMnEPIb8bOYqMdNaVfsKU1cG/uMr1TYJTkIR2NfwyE8vOEQ==
Message-ID: <0ff1fcc2-4d2f-f48e-549f-6c7d04765cb3@nabladev.com>
Date: Wed, 7 Jan 2026 08:15:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Kaustabh Chakraborty <kauschluss@disroot.org>
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

Hi Tom,

The following changes since commit c344087025a4c296468a1d5aeb61078a58baa59e:

   Merge branch 'next' (2026-01-05 15:12:02 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2c-updates-for-2026.04-rc1

for you to fetch changes up to 2622dd613b4e18ff5d26cc66819dbd4c4ba5f6be:

   i2c: samsung: add support for Exynos7 HS-I2C (2026-01-06 11:13:50 +0100)

----------------------------------------------------------------
Updates for 2026.04-rc1

- add support for Exynos7 HS-I2C
   from Kaustabh Chakraborty

----------------------------------------------------------------
Kaustabh Chakraborty (1):
       i2c: samsung: add support for Exynos7 HS-I2C

  drivers/i2c/exynos_hs_i2c.c | 109 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------
  drivers/i2c/s3c24x0_i2c.h   |   7 +++++++
  2 files changed, 96 insertions(+), 20 deletions(-)

Azure build looks good:

https://dev.azure.com/hs0298/hs/_build/results?buildId=198&view=results

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
