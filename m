Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C501C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 08:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2C1087034;
	Tue, 24 Oct 2023 10:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698135659;
	bh=Ai4umOnWE2aKyheNMKN6SDFqTDnWA+2Zn1eHM0q8M/A=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RpnwuR5PmGdvOFiVNY25v3LB27ebFSejyGxfcgdhoFEEK2jK8VjrzvMs1udAEmcUx
	 Bu9/bdG1Mol6rtgwNv8IF4YohrFA7c/Dbpm8h9xBDRqebAbBsuE+qFfvnwywO831j8
	 07oB6xNMHxqkWi+FbP4YwVs1AgrFZJwxbtNcpPXzZ5Uje5zJMInIkNDqoCPsaHb6bH
	 +0ut21kYpY/k/8pXNxKGPBIiCdWR6KdTHxavAEyZkJYYQFxoINoO9E5KDc82AN65Mc
	 y4R16+yNT3i8c1jLhPPFOfCVSLa9xGnijmw7RXqCOK9VJVWC0t4cFCEiOg8dpMGvkZ
	 VoN1qn2jAfOsA==
Received: from [IPV6:2001:a61:61a8:7a01:5365:c873:622b:9ad2] (unknown
 [IPv6:2001:a61:61a8:7a01:5365:c873:622b:9ad2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: sbabic@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2ABAA86FAA;
 Tue, 24 Oct 2023 10:20:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698135658;
 bh=Ai4umOnWE2aKyheNMKN6SDFqTDnWA+2Zn1eHM0q8M/A=;
 h=Date:To:Cc:From:Subject:From;
 b=kxrp9rsrYY+A6347mbfkc/9aWUKO5GQr0Zp1bpJZJdx0DZv0eojrUBRhdFRo7NG6m
 /tlCmG15clc1qt/6Rii5IgPtTOt0ff4evMXs1Dwwc796Y47TSD9Yfi2GZkaNie2hF4
 M63SsXBlnM+DtTyncDtoga8Jr6QfYYC4qSq9q3Q4uQWunN1EAopeS9CPTDagh1qWUE
 UPQoPDzVOQ0T492V97YbcVVTOUUXGNi06LvLfI5jSH6p4Ud/2cDjpOCVtT4VHa+0bq
 kBEiupEkpZd9DGG+DueJGjlD/naUwqY/LWeofVe+9ucyi0Dr44nnWycpfXApt3S2S8
 zBV2X1szfSPEw==
Message-ID: <3c1688e3-3500-440e-a398-704337b9dc47@denx.de>
Date: Tue, 24 Oct 2023 10:20:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tom Rini <trini@konsulko.com>
Content-Language: de-DE
Cc: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
From: Stefano Babic <sbabic@denx.de>
Subject: Pull request: please pull u-boot-imx-20231024
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

please pull from u-boot-imx, thanks !

The following changes since commit e65b5d35c9116485366bb08138043d51220551da:

   Merge branch 'master' of 
https://source.denx.de/u-boot/custodians/u-boot-sh (2023-10-17 09:15:56 
-0400)

are available in the Git repository at:

   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git 
tags/u-boot-imx-20231024

for you to fetch changes up to 2f96064d0cf78e21a668ad907d41d63e56f9f7bb:

   arm64: dts: imx8mp: Describe M24C32-D write-lockable page in DH 
i.MX8MP DHCOM DT (2023-10-18 21:29:59 +0200)

----------------------------------------------------------------
u-boot-imx-20231024
-------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/18211

- Fixes for MC2432 Eeprom
- i.MX93 ADC
- Secondary boot mode on i.MX8M

----------------------------------------------------------------
Fedor Ross (3):
       ARM: imx: Factor out parsing of ROM log
       ARM: imx: Use correct U-Boot offset in case of secondary boot 
from eMMC
       ARM: imx: Add support for detecting primary/secondary bmode on MX8M

Marek Vasut (3):
       spl: mmc: Introduce proper layering for 
spl_mmc_get_uboot_raw_sector()
       eeprom: at24: add ST M24C32-D Additional Write lockable page support
       arm64: dts: imx8mp: Describe M24C32-D write-lockable page in DH 
i.MX8MP DHCOM DT

Sébastien Szymanski (2):
       arm: dts: imx93-11x11-evk: add bootph-some-ram property
       dm: adc: imx93-adc depends on ADC (fix boot)

  arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts    |  8 ++++++++
  arch/arm/dts/imx8mp-dhcom-som.dtsi                  | 12 ++++++++++++
  arch/arm/dts/imx93-11x11-evk-u-boot.dtsi            | 20 
++++++++++++++++++++
  arch/arm/mach-imx/Kconfig                           |  2 +-
  arch/arm/mach-imx/cmd_bmode.c                       |  4 ++++
  arch/arm/mach-imx/image-container.c                 |  4 ++--
  arch/arm/mach-imx/imx8m/soc.c                       | 99 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
  arch/arm/mach-mvebu/spl.c                           |  4 ++--
  arch/arm/mach-sunxi/board.c                         |  4 ++--
  board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c |  2 +-
  board/data_modul/imx8mp_edm_sbc/spl.c               |  2 +-
  board/gateworks/venice/spl.c                        |  2 +-
  common/spl/spl_mmc.c                                | 14 +++++++++++++-
  configs/imx93_11x11_evk_defconfig                   |  1 +
  drivers/adc/Kconfig                                 |  1 +
  drivers/misc/i2c_eeprom.c                           |  8 ++++++++
  include/spl.h                                       | 26 
++++++++++++++++++++++++++
  17 files changed, 184 insertions(+), 29 deletions(-)

Best regards,
Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
