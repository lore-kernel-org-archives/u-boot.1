Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5161DC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 14:10:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E0DD877D4;
	Thu,  2 Nov 2023 15:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698934257;
	bh=T6Ems09+P7PhaPsFkQ55tj4vAG7Ewyt/bAjgVLgZ3zc=;
	h=To:Cc:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=pyPvWxRS2UwYqdze8zkXhyY0nX0cG3iMyDcKhb/TyZkAGC7B/bR8drY/QIcjBqiIm
	 GAwm1HVOuBLQ/24a6nEDoOlW1DhTNOeyGAwVv4YCu6g7hWduBQuy9va9rfc5RuOZGX
	 h4J3pDM4MYZWE5Zzj0FmT/mnJF/r6xq3MPvCDN2a7TcHtBwPS38CnQyezCkkLqrf2q
	 Wc3IXG3q9GX4K8NuXn+DHbZ4+nDzVtWR3jakR+BS8Ef6e257bofB41hKOr0Q9M1Vjb
	 0KDKffSnulyqZKWdFS5n2nnoNoU67N15HnXo9MrUYNAnrK76xGyRb46HbE+QqSPFeT
	 IbZRMZAmKn1RQ==
Received: from [192.168.1.107] (82-131-157-32.pool.digikabel.hu
 [82.131.157.32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8014A877D3;
 Thu,  2 Nov 2023 15:10:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698934256;
 bh=T6Ems09+P7PhaPsFkQ55tj4vAG7Ewyt/bAjgVLgZ3zc=;
 h=To:Cc:Reply-To:From:Subject:Date:From;
 b=WIj2Wo0U8KFNMAzT+ZB9Vky/hiZvZvwawlKCOIQh4YGDj7sXysSKNCZCYIfYYWGEs
 z9I1d8hKhrLhDOoIvu6GcYigTmC6O1dcNPC5wMR8dV8y/Z5By59T7IRHSVM1Z2zJ6z
 1k2r8aji5S30QqGoRstyW4b/mCqFBxsyfOKEhcBS2aWNmcDwig5HQWiT/2xxGOUJiF
 9kuMAzMfYuLkEN9ZNg1sl+axOEA3P4w2dyDOKeXR7d7Y/wkc0q95Ue7g1Lu3jfaAPf
 OWYvB1G22DVr8dJWNm21LUtkUSXSivm0kIxSSZfv+k4z7AT3xQjihHRs/wNRsiQy6/
 2DTbMjE54XJGQ==
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Jim Liu <jim.t90615@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Philip Richard Oberfichtner <pro@denx.de>
From: Heiko Schocher <hs@denx.de>
Subject: Please pull u-boot-i2c
Message-ID: <6b4f373a-b81b-e937-cdfb-83d49e4e4e37@denx.de>
Date: Thu, 2 Nov 2023 15:10:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

please pull from u-boot-i2c:

The following changes since commit d9650a48234058c645d1a07951c3d2cf129427e6:

  Merge branch '2023-10-28-assorted-platform-updates' (2023-10-28 09:23:27 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2cfixes-for-v2024-01-rc2

for you to fetch changes up to 5b6ee512ceb8d990e010646c4fe7b8a3633fad68:

  bootcount: Add driver model I2C driver (2023-10-31 09:09:04 +0100)

----------------------------------------------------------------
i2c updates for v2024.01-rc2

- nuvoton: support standard/fast/fast plus mode
- bootcount: remove legacy i2c driver and implement
  DM based version

Bugfixes:
- designware_i2c: adjust timing calculation
  SPL probing failed on the StarFive VisionFive 2 board
  Heinrich fixed this, by syncing timing calculation with
  linux implementation.

----------------------------------------------------------------
Heinrich Schuchardt (1):
      i2c: designware_i2c: adjust timing calculation

Jim Liu (1):
      i2c: nuvoton: remove standard mode only

Philip Richard Oberfichtner (3):
      bootcount: Remove legacy I2C driver
      i2c: Implement i2c_get_chip_by_phandle()
      bootcount: Add driver model I2C driver

 drivers/bootcount/Kconfig            |  34 +++++++++++++---------------------
 drivers/bootcount/Makefile           |   2 +-
 drivers/bootcount/bootcount_dm_i2c.c | 102
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/bootcount/bootcount_i2c.c    |  43 -------------------------------------------
 drivers/i2c/designware_i2c.c         |  19 +++++++++++++++----
 drivers/i2c/i2c-uclass.c             |  75
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/npcm_i2c.c               |   5 -----
 include/i2c.h                        |  12 ++++++++++++
 8 files changed, 218 insertions(+), 74 deletions(-)
 create mode 100644 drivers/bootcount/bootcount_dm_i2c.c
 delete mode 100644 drivers/bootcount/bootcount_i2c.c

azure build is fine:

https://dev.azure.com/hs0298/hs/_build/results?buildId=109&view=results

Thanks!

bye,
Heiko

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
