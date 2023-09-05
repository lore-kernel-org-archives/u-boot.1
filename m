Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7B6C83F33
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 07:56:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6103086611;
	Tue,  5 Sep 2023 09:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693900593;
	bh=XB9IdtmGc4UvcoQKW+IsBDD4w77RqYvaPWK1BbFGBdk=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=V0YN+gqJW52G3b2i4f/OqelQftYPj5WXL5nPN3NBYAacGx0vP3DnxbEXYcZYcA7fT
	 H4ZTohiGvvHas5M1poMMG7cUzBuYx1ZDg5Q5e6TFBmmtOydTT4Qkw9s1C4pb12k24S
	 xkH23dexHD2tniiHg2RzjiisgwNF4YLs3TP/0CwYgfEexwwdG/4MqtYSq1DTEbMG4P
	 hxBYjx8SnGNPwstIz6LJhIOVKC8XVPiDfkTt7HQtmCvNT+ucortteq5tr9PvtPNGcX
	 aLSDvmypl/IpV3IRcozZGbex4qvlI1zVWszMPYOuLXVr+bSxIhnPW8o3XAfOK48KlB
	 j74L9LyUp5sdg==
Received: from [IPV6:2001:a61:6041:6101:8b79:a919:5b01:e026] (unknown
 [IPv6:2001:a61:6041:6101:8b79:a919:5b01:e026])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: sbabic@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3264D86569;
 Tue,  5 Sep 2023 09:56:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693900592;
 bh=XB9IdtmGc4UvcoQKW+IsBDD4w77RqYvaPWK1BbFGBdk=;
 h=Date:To:Cc:From:Subject:From;
 b=YMNjEJ9hToWv3+cetlNLjKQrWsHwDogqB3gaoiO3yC4DqSAMPa7qvubZP7Yq3/wiD
 Xl6EBVyIDWntufgHIrsuf+2Unk62EUk/JN6aKOBnfv4ESMYcKfherZ9Xb9JUWByxxP
 ufhy8j7U0ZgoXLklgZTpd2VynVd+8+BmjoIwM0ts5J0LU6gCVDZvMcStVRlWtL+3QL
 PpAr8LZ3cRDHggJ80Va0Hru/5lhZxZAHoYBtXQUJFtXuQ63rYmckHN2vdjP6Gn/T5V
 qeylgvayczgijmrdp7WOS3HQYLdbEBPLXRcG2V5/D1+bhIpAdyP4W2lA3Vyn9hDF9Z
 +aNS/wOoi4loA==
Message-ID: <f0ca845c-890f-9360-7426-41dce4147a7e@denx.de>
Date: Tue, 5 Sep 2023 09:56:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
To: Tom Rini <trini@konsulko.com>
Content-Language: de-DE
Cc: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
From: Stefano Babic <sbabic@denx.de>
Subject: Pull request: please pull u-boot-imx-20230905
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

Hi Tom,

some fixes for the release, please pull from u-boot-imx, thanks !

The following changes since commit 8999257f219d1e371c2fd66f255b8782897944d9:

   Merge tag 'doc-2023-10-rc4-2' of 
https://source.denx.de/u-boot/custodians/u-boot-efi (2023-09-02 09:08:54 
-0400)

are available in the Git repository at:

   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git 
tags/u-boot-imx-20230905

for you to fetch changes up to a79fca7b44d0dee96e14d31de5869b35b587283c:

   thermal: imx_tmu: Increase the polling interval (2023-09-04 17:26:44 
+0200)

----------------------------------------------------------------
Fixes for release
-----------------

- imx9: fix DRAM calculation
- thermal: fixes
- fixed for DM, DH and Gateworks boards

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/17639

----------------------------------------------------------------
Elena Popa (1):
       arm: imx: imx8m: imx9: Fix DRAM size calculation due to rom_pointer

Fabio Estevam (5):
       imx8mm_evk_defconfig: Select CONFIG_IMX_TMU
       thermal: imx_tmu: Fix the polling default
       thermal: imx_tmu: Increase the log level for high temperatures
       thermal: imx_tmu: Fix the temperature unit
       thermal: imx_tmu: Increase the polling interval

Marek Vasut (5):
       ARM: imx: Drop CONFIG_USE_BOOTCOMMAND=n on i.MX6 DHSOM
       ARM: imx: Select 2 DRAM banks on Data Modul i.MX8M Mini eDM SBC
       ARM: imx: Use default SAVED_DRAM_TIMING_BASE on DH i.MX8M Plus DHCOM
       ARM: imx: Use default SAVED_DRAM_TIMING_BASE on Data Modul i.MX8M 
Mini eDM SBC
       ARM: imx: Use default SAVED_DRAM_TIMING_BASE on Data Modul i.MX8M 
Plus eDM SBC

Tim Harvey (1):
       board: gateworks: venice: fix gw7904

  arch/arm/mach-imx/imx8m/soc.c               |  7 ++++---
  arch/arm/mach-imx/imx9/soc.c                |  6 +++---
  configs/dh_imx6_defconfig                   |  1 -
  configs/imx8mm_data_modul_edm_sbc_defconfig |  3 +--
  configs/imx8mm_evk_defconfig                |  1 +
  configs/imx8mm_venice_defconfig             |  2 +-
  configs/imx8mp_data_modul_edm_sbc_defconfig |  1 -
  configs/imx8mp_dhcom_pdk2_defconfig         |  1 -
  configs/imx8mp_dhcom_pdk3_defconfig         |  1 -
  drivers/thermal/imx_tmu.c                   | 10 +++++++---
  10 files changed, 17 insertions(+), 16 deletions(-)

Best regards,
Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
