Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A88CCD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 15:19:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A0208056B;
	Thu, 21 May 2026 17:19:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="IReGBYt6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06DB8844CF; Thu, 21 May 2026 15:54:09 +0200 (CEST)
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com
 [148.163.135.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3C6E805D7
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 15:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Caleb.Ethridge@analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L8n79e262998; Thu, 21 May 2026 09:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=DKIM; bh=G0ZyRpsyJjgX71XDJMu3TKUs/ow
 0GAvePed+uvroCTg=; b=IReGBYt6BUM/MobG/8JQEjbqwRWqpQlMz13bRmRALHT
 0R0/+y1yvGa0pvrcH317fTfhkeDSj8VbH07/GGXfaTTjMj4RZIHd9L+UZsD5aPFo
 lprbGW68hbKW6C4YPIFUjFMFMg9R+SMcVSqzSPgo0/28Ll0aupJxgGkgQYw1eDzZ
 kQJI3cTtF8u/F4NXNWVSHdzGyOuszU+ViTMBaFXOTNpb3tPX0NuEASjOTtQOtc+S
 +TlUSlE6gaggaRY87SnX4pGc2rCKifiArEnRjHpkGykpuMIyWctJltqQWVEpYTrC
 DnKX09IGhOVIpFTvXfL9JnXnvIv1OsMHrmotdCRlG8w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e95e2ek3e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 09:54:02 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
 by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LDs1vK046879
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL); 
 Thu, 21 May 2026 09:54:01 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 21 May
 2026 09:54:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 09:54:01 -0400
Received: from cethridg-sml01.ad.analog.com (cethridg-sml01.ad.analog.com
 [10.75.142.63])
 by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LDrkqc016286;
 Thu, 21 May 2026 09:53:48 -0400
From: Caleb Ethridge <caleb.ethridge@analog.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <malysagreg@gmail.com>, <philip@philipmolloy.com>,
 <sjg@chromium.org>, <linux@analog.com>, <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v6 00/16] sc5xx Environment Cleanup and Fixes
Date: Thu, 21 May 2026 09:53:11 -0400
Message-ID: <cover.1779370141.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: cuRit9NeRkapUXe1m3aOjuP_4Zb3oK7e
X-Authority-Analysis: v=2.4 cv=Fd0HAp+6 c=1 sm=1 tr=0 ts=6a0f0e7a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=jGRrxM5U7u9VleDmJ38A:9
X-Proofpoint-GUID: cuRit9NeRkapUXe1m3aOjuP_4Zb3oK7e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEzOSBTYWx0ZWRfX5lMrknrecG3g
 BkZakVtI0du39ljunomArnR5OezBupoX67zzEPZf+trNPPgnljq4LA8EHhz03JvwF4EqPqPUMhJ
 eNhP/+pj/Yr9pb9D63zwla1+AATJ05fE/CNuglEHUOJYSxuqSBYzb6Cdq+4gqGQsc1ATFAClCQE
 pXgJRhVA+b0Ni3A36vDC3nivB8833Jw6DzoJBATShQnb081VaFeI9otByK3lJDHksHM6cI9aVon
 9VGW6S22k69jXXKAp2W7Ig8dh6G7Q3ddAaE6WYWVWmwCH3pO6I5deoipJza4zOJ1R1FQ998/NPk
 V6Me6AQbAJTz0kqaTdyaeIVoxsP0292cjcmxVe7BFT0Dn0lEPU+GDm/wiiS+Dvjf44vhMYr6YDn
 84lfcFYRrSgbYOh72WdQbVpdet/C6Vl8YJZLMFM/XsSptFkTQiuDvsgTcW4KF9DUxGQzkMBUoX4
 MZ/W4+gJPWwtikK9rXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 clxscore=1011
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210139
X-Mailman-Approved-At: Thu, 21 May 2026 17:19:00 +0200
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

This series performs a general cleanup of the default U-boot environment
for sc5xx boards, stemming from the decision to no longer store the
environment in the SPI flash. The environments for each board have been
edited to contain the minimum number of commands needed for all supported
boot modes to avoid confusion, and the default boot command synced to spi
for all boards that support it. The filesystem for the SPI flash has also
been changed from jffs2 to ubifs.

A bug with the Ethernet reset line on the sc594 has been fixed, and the
sc573 has been renamed from the EZKIT to the EZLITE to match the name of the
publically available board. EZKIT was only used internally before release.
Preliminary binman support for sc5xx boards has been removed as it was unused
and full support never added.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>

Changes in v6:
- Fixed ramdisk_addr_r for the sc584-ezkit
- Updated commit messages with more information
- Split "Remove update commands" into two logical commits

Note: The series and future patch series will be sent using analog.com email addresses,
instead of personal emails with our analog.com emails cc'ed on the series.

Caleb Ethridge (15):
  configs: sc5xx: Do not store environment in SPI flash
  mach-sc5xx: Remove update commands from default environment
  mach-sc59x: Add CONFIG_SC5XX_LOADADDR
  mach-sc5xx: Update boot commands
  mach-sc5xx: Switch from tftp to wget
  mach-sc5xx: Add USB boot command
  mach-sc5xx: Remove preliminary binman support
  dts: sc594: Fix gige-reset line on EZKIT
  mach-sc5xx: sc573: Rename EZKIT board to EZLITE
  mach-sc5xx: Update image load address
  mach-sc5xx: Update SPI bootargs for ubifs
  configs: sc5xx: Set default bootcmd to SPI boot
  arm: sc5xx: Remove SC5XX_LOADADDR
  arm: sc5xx: Add fdt_addr_r, kernel_addr_r, and ramdisk_addr_r
  mach-sc5xx: Remove unused image offset Kconfig options

Ozan Durgut (1):
  arm: sc5xx: add missing boot env selectors

 arch/arm/dts/Makefile                         |   2 +-
 .../dts/{sc573-ezkit.dts => sc573-ezlite.dts} |   4 +-
 arch/arm/dts/sc594-som-ezkit.dts              |   2 +-
 arch/arm/dts/sc5xx.dtsi                       |  41 -------
 arch/arm/mach-sc5xx/Kconfig                   |  71 +-----------
 arch/arm/mach-sc5xx/init/dmcinit.c            |   2 +-
 board/adi/sc573-ezkit/sc573-ezkit.env         |  17 ---
 .../adi/{sc573-ezkit => sc573-ezlite}/Kconfig |   8 +-
 .../{sc573-ezkit => sc573-ezlite}/Makefile    |   2 +-
 .../sc573-ezlite.c}                           |   0
 board/adi/sc573-ezlite/sc573-ezlite.env       |  16 +++
 board/adi/sc584-ezkit/sc584-ezkit.env         |   9 +-
 board/adi/sc589-ezkit/sc589-ezkit.env         |   9 +-
 board/adi/sc589-mini/sc589-mini.env           |   9 +-
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env |   9 +-
 .../adi/sc594-som-ezlite/sc594-som-ezlite.env |   9 +-
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env |   9 +-
 .../adi/sc598-som-ezlite/sc598-som-ezlite.env |  14 ++-
 ...ezkit_defconfig => sc573-ezlite_defconfig} |  11 +-
 configs/sc584-ezkit_defconfig                 |  10 +-
 configs/sc589-ezkit_defconfig                 |  12 +-
 configs/sc589-mini_defconfig                  |  12 +-
 configs/sc594-som-ezkit-spl_defconfig         |   7 +-
 configs/sc594-som-ezlite-spl_defconfig        |   7 +-
 configs/sc598-som-ezkit-spl_defconfig         |   5 +-
 configs/sc598-som-ezlite-spl_defconfig        |   5 +-
 .../arm/adi/adi,sc5xx.yaml                    |   2 +-
 .../configs/{sc573-ezkit.h => sc573-ezlite.h} |   4 +-
 include/env/adi/adi_boot.env                  | 103 +++++-------------
 29 files changed, 108 insertions(+), 303 deletions(-)
 rename arch/arm/dts/{sc573-ezkit.dts => sc573-ezlite.dts} (98%)
 delete mode 100644 board/adi/sc573-ezkit/sc573-ezkit.env
 rename board/adi/{sc573-ezkit => sc573-ezlite}/Kconfig (92%)
 rename board/adi/{sc573-ezkit => sc573-ezlite}/Makefile (79%)
 rename board/adi/{sc573-ezkit/sc573-ezkit.c => sc573-ezlite/sc573-ezlite.c} (100%)
 create mode 100644 board/adi/sc573-ezlite/sc573-ezlite.env
 rename configs/{sc573-ezkit_defconfig => sc573-ezlite_defconfig} (87%)
 rename include/configs/{sc573-ezkit.h => sc573-ezlite.h} (79%)

-- 
2.34.1

