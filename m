Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42ABC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 14:09:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2214E88B9F;
	Fri,  9 Aug 2024 16:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723212595;
	bh=efRyObPOaWEBCrXAx0cY8Yr558UzQtF59GffZ7AKOOY=;
	h=Date:To:From:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=Afmvqk8TNHE8cEO6glUnjWVgla8+HeaB84zXMewdFT9X6nhOOHrq/PrTvF0ISBkc0
	 DjOYQMezV4ajBXkYu71OQsJeo5x4ug9iS53ysMi9Ewd1X2Hjv+jft0e3oHBx5tkqgT
	 HNbCiK8InKDGp2DD8sYaQ4D5jaumDq92dlCtgWL7g7QrsfUHvKXLQ3bf+Tk3BnmAc5
	 hpbro5UbKPDZZ0jaBmSw9Etw56wSu8dCzYXvHRe6zs2J85FFW31GIwhEQjU0f21sPk
	 qvMtvTRAAiGuVrx0/Hq3l8f3oMAwAf5AKsfxXXdp8MjJdAFI80KXvyAHXfXzmk8uRS
	 w7+nXg1Q3VhVA==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CE28A88B99;
 Fri,  9 Aug 2024 16:09:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723212594;
 bh=efRyObPOaWEBCrXAx0cY8Yr558UzQtF59GffZ7AKOOY=;
 h=Date:To:Reply-To:From:Subject:Cc:From;
 b=JHrRJRb8o3rI4PttUp+x3Adjx+wsvPypHxYzYJUmqJgejKEJq806jIQ1oe9xlNTnk
 c2bOl8EdTayYWj+0aHE0xV/P12EHEMAa7C56e1jmg6q9pSLd2Iphy0FzREX8lZVENL
 XTwxkft0FHV4Z40D422SVt6pUccd/8i+hyb0frV5eEiNK90EaLjQj6y4FT6WEhs2Dh
 SeL3yAc78ni11Xm+0Vv4tWoTumgDC5N5GYIqRZXy7tOvFkxBTbYNUuTEQHo1WxOJMs
 7L7o/KsBX7LuES6Mka89hVORsrwwU5f0lu/LXRsN10iHRdMc58010SAOBriEuk1wyF
 wcotZ3nfPmF9Q==
Message-ID: <09a3ff7e-d7bd-8dd5-82ea-a62a90b9054b@denx.de>
Date: Fri, 9 Aug 2024 16:09:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
From: Heiko Schocher <hs@denx.de>
Subject: Please pull v2 u-boot-i2c
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>, Fedor Ross <fedor.ross@ifm.com>,
 David Virag <virag.david003@gmail.com>, Anatolij Gustschin <agust@denx.de>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

please pull from u-boot-i2c master, sorted out the DM_I2C patches from Anatolij,
to seperate pull request for next.

The following changes since commit eb8e25c000d185ece0136b13cca73084eb980253:

   Merge tag 'u-boot-nand-20240808' of https://source.denx.de/u-boot/custodians/u-boot-nand-flash 
(2024-08-08 16:15:06 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2cfixes-v2-for-v2024-10-rc3

for you to fetch changes up to ec07bcc8eafb8d201d15facc969fe96600660095:

   i2c: imx_lpi2c: Support read transfers longer than 256 bytes (2024-08-09 14:46:49 +0200)

----------------------------------------------------------------
i2c updates for v2024.10-rc3 (second try)

- i2c: samsung: Support platforms other than EXYNOS4 and EXYNOS5
   from David

- imx_lpi2c: cleanups and support read transfers longer than 256 bytes
   from Fedor

- pca954x: Remove pointer to GD
   from Michal

- i2c: mux: Fix error path in i2c-arb-gpio
   from Michal

----------------------------------------------------------------
David Virag (2):
       i2c: samsung: Drop s3c24x0 specific code.
       i2c: samsung: Support platforms other than EXYNOS4 and EXYNOS5

Fedor Ross (3):
       i2c: imx_lpi2c: Fix a typo in bus_i2c_receive
       i2c: imx_lpi2c: Replace hard-coded bus speed value with bus->speed_hz
       i2c: imx_lpi2c: Support read transfers longer than 256 bytes

Michal Simek (2):
       i2c: pca954x: Remove pointer to GD
       i2c: mux: Fix error path in i2c-arb-gpio

  drivers/i2c/Kconfig                        |  2 +-
  drivers/i2c/exynos_hs_i2c.c                | 25 +++++++++++++++++++++----
  drivers/i2c/imx_lpi2c.c                    | 87 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------
  drivers/i2c/muxes/i2c-arb-gpio-challenge.c | 11 ++++-------
  drivers/i2c/muxes/pca954x.c                |  3 ---
  drivers/i2c/s3c24x0_i2c.c                  | 32 ++++++++++++++++++++++++--------
  drivers/i2c/s3c24x0_i2c.h                  |  2 ++
  7 files changed, 108 insertions(+), 54 deletions(-)


Azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=117&view=results

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
