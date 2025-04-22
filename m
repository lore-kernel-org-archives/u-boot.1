Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD45C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 15:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D1B280F6B;
	Tue, 22 Apr 2025 17:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745335316;
	bh=Y4FtKeGylkqZ2eXIJjaxayAg97ya+j5WdF7rqqz7vyo=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=DTAcKAr/h9abqbUjky8fcOCl24g4LINQ94UnvUceKY9VBo4ciuiHFeuufE9BmLiGh
	 HzhyF8bxT/p9uxMvWOwRiLPfH3qyhWwFhH09tuDFRFGeDynEo22hHj6Np6ZNiCXRNC
	 dDLi/BbbPJCJobjlCuy6CdaMtnVsiKLmDOZ8bS6N/BQbXDLrL1XGPN89UEhvr8NzO/
	 IL2/+3cjHrP94QdRgA3WF+JwwopIYw2EPVk5OybMskM+2e96DL44+7h4YKI5pxVcFh
	 4b5TN2zXaBbBWzRm8F1GtcL3b/x6of1ttXfDygwlrDblV2diCrRU3jCEQUcSxtZ7Qo
	 m3bGDiutX5Z6Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CE6181273; Tue, 22 Apr 2025 17:21:55 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01C3C80F03
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 17:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Jjw9Ct6t"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F2CE21039EF31; 
 Tue, 22 Apr 2025 17:21:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745335312;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=Y4FtKeGylkqZ2eXIJjaxayAg97ya+j5WdF7rqqz7vyo=;
 b=Jjw9Ct6t+NU8nTjcUHKtIAau2lPIbNKShWwboFd2L1ZpmkVBJND9GyX9MsdZSR48dMnuol
 pHAAzQGYEDYHe/EXxqoR5X6ehu9KHPrCXlAyoMGgFS2UaRyzrYWlfyRRW220DS1eaRBvuB
 i1f2HnW0IT1wW3af6X102H6a5FUCPzPVhX0s57zTeKFMgyWzoIcUpEnc3qO1f8fWECpfM6
 fNx/uLEmYQFQmxmyo4GdaDMagElSgGx5QLzxg83ookYBiTd5R7aHwkClk1vDgeWh4uoz6V
 k/KbKY/VBHy6khuBOWZhJPd5ColU7H2QUT5gVVp0qHx0YgvHqxPUxSZAWZk/0Q==
Message-ID: <07741b5d-ecd7-7221-8d77-fc5c1fc38408@denx.de>
Date: Tue, 22 Apr 2025 17:22:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Aniket Limaye <a-limaye@ti.com>, Martin Schiller <ms@dev.tdt.de>
From: Heiko Schocher <hs@denx.de>
Subject: Please pull u-boot-i2c master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

The following changes since commit cde0050618968aae335dfbc930641656d51ff5d0:

   Merge tag 'u-boot-at91-2025.07-b' of https://source.denx.de/u-boot/custodians/u-boot-at91 
(2025-04-21 08:24:54 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2cfixes-for-2025.07-rc1

for you to fetch changes up to 28d78a53c72c4ac3d5033a0c21396cadf7438bee:

   i2c: mediatek: remove duplicate entry in mt_i2c_regs_v1[] (2025-04-22 13:04:22 +0200)

----------------------------------------------------------------
i2c updates for v2025.07-rc1

- omap24xx_i2c: Enable Repeated Start functionality
   add Repeated Start functionality for the DM_I2C xfer
   API (omap_i2c_xfer()

   from Aniket Limaye

- mediatek i2c driver
   fixes from Martin
   - add end marker for struct udevice_id mtk_i2c_ids
   - remove duplicate entry in mt_i2c_regs_v1

----------------------------------------------------------------
Aniket Limaye (4):
       i2c: omap24xx_i2c: Remove unused CONFIG_I2C_REPEATED_START
       i2c: omap24xx_i2c: Use new function __omap24_i2c_xfer_msg()
       i2c: omap24xx_i2c: support CONFIG for repeated start in DM_I2C xfer
       drivers: i2c: Kconfig: Add CONFIG_SYS_I2C_OMAP24XX_REPEATED_START

Martin Schiller (2):
       i2c: mediatek: add missing empty entry at end of mkt_i2c_ids[]
       i2c: mediatek: remove duplicate entry in mt_i2c_regs_v1[]

  drivers/i2c/Kconfig        |   9 +++++++++
  drivers/i2c/mtk_i2c.c      |   3 +--
  drivers/i2c/omap24xx_i2c.c | 165 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------
  3 files changed, 145 insertions(+), 32 deletions(-)


Azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=175&view=results

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
