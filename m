Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C60EC44506
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 15:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 068F984B88;
	Thu,  9 Jul 2026 17:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="YMDIZVos";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4850584BC3; Thu,  9 Jul 2026 17:24:49 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DC3B84B77
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 17:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9B745117D84; Thu,  9 Jul 2026 17:24:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1783610686;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=b6bJ/j3LbV+aDuhbpphIPipZM2/wu3T7zvxUb/8Omo4=;
 b=YMDIZVosiabMNxnS31msGmKY5n0UzXb+LWFU0VD0LcJf2oQ+XJ/9pbcGN3sg9WdUCl1TV3
 a7jZjz27t1LIAWlNP1yd6iueB6Vo5uchDsLvrp4Fnjf3oM/jhGSPUn9u/aj3y14YYohvCd
 lGdQJ3RjYhr9YVjFE6LG8KrNIhXYGSleDVHtdOFbUVcY1iudXkiHzGBOAT0E5V/NBxM6cm
 RofkJTCi4AwwLMdUY3GP8byT9VgfwI0IiEYiUUA1pOYy/1Ji0iY7XMeefX0Yso9A6drC6b
 Z5EEKcMX9ggmLe8cIdtJeXhEkr4UT627yFlJqWLwseYjDReglwxMfMg1/Ickrg==
Message-ID: <7f4e54a5-00ba-56d8-891a-a29f987e703c@nabladev.com>
Date: Thu, 9 Jul 2026 17:24:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Julien Stephan <jstephan@baylibre.com>, Coben Han <cobenhan@mediastek.com>,
 Peng Fan <peng.fan@nxp.com>
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

please pull from

The following changes since commit ee5d46b45ec0c63f8f9dd1e816e0dac3452ccc3d:

   Merge branch 'next' (2026-07-06 18:26:12 -0600)

are available in the Git repository at:

   git@git.u-boot-project.org:u-boot/custodians/hs/u-boot-i2c.git tags/i2c-updates-for-2026.10-rc1

for you to fetch changes up to 0ded029735303c0db04510792bfc5f0dcc62f5af:

   cmd: kconfig: i2c: add missing I2C API dependency (2026-07-09 07:18:18 +0200)

----------------------------------------------------------------
i2c updates for 2026.10-rc1

- i2c: designware: fix i2c probe error
   from Coben

   It would be good to have some Testers...

- i2c: nx_i2c: updates from Peng

   - Added License information
   - use dev_read_addr_ptr()

- cmd: kconfig: i2c: add missing I2C API dependency
   from Julien

----------------------------------------------------------------
Coben Han (1):
       i2c: designware: fix i2c probe error

Julien Stephan (1):
       cmd: kconfig: i2c: add missing I2C API dependency

Peng Fan (2):
       i2c: nx: Use dev_read_addr_ptr()
       i2c: nx: Add License

  cmd/Kconfig                  |  1 +
  drivers/i2c/designware_i2c.c | 44 +++++++++++++++++++++++++++++++++++++++-----
  drivers/i2c/nx_i2c.c         |  9 ++++++---
  3 files changed, 46 insertions(+), 8 deletions(-)


Azure build is fine:

https://dev.azure.com/hs0298/hs/_build/results?buildId=210&view=results

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
