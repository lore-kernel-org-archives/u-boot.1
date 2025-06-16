Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD6BC71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 11:29:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB16582C2F;
	Mon, 16 Jun 2025 13:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="xijS5l6A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9A3481760; Mon, 16 Jun 2025 13:29:52 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B603C82B18
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 13:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=82620602e9=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GBS9rK021574;
 Mon, 16 Jun 2025 13:29:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=c5Nj47R8Jht5fo+YqW2KDw
 4P6C9hQSyFAXjUsfdheis=; b=xijS5l6AxmGCWVrRCwsDOKYJlOsTRCT8zGYMs5
 5w158yt9BfbnTvqFWlhecin67JeyKzbn6VsqUcb2XFz06C+9FT165+e6A3Qar4UP
 D3jyfVVTJFjV2eTrkehiCLs7MhWwZ0FIjZLWyul1swlTkJ5QNniUOTzSWMR7FdVe
 Sd2lP549vvTWYC+TcEZ6Kgjyyipimj/oyKDW6BNLo37lol3a3Vly3LAbSjPsLUTb
 3vJ8wXsowjueHho/pQLOllTE7iuHh28lQWEvLuxSqpHS0Cjq/A98ukJwxYpR3DMj
 3yu9y2ytk+h74iFQ+bVYIUdvt2j/R4evkZ6F+BnRvhWG7Bbw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47afw1gy3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 13:29:41 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0362C40046;
 Mon, 16 Jun 2025 13:28:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0E916AFAC4C;
 Mon, 16 Jun 2025 13:27:54 +0200 (CEST)
Received: from localhost (10.48.86.182) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 13:27:53 +0200
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: <caleb.connolly@linaro.org>, <jerome.forissier@linaro.org>,
 <patrice.chotard@foss.st.com>, <ilias.apalodimas@linaro.org>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Casey Connolly
 <casey.connolly@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v4 0/3] Restore support of short name for type UUID parameter
Date: Mon, 16 Jun 2025 13:27:46 +0200
Message-ID: <20250616112749.17311-1-patrick.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.182]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_05,2025-06-13_01,2025-03-28_01
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


V4 update the test print_guid, as "ESP" is a known part type UUID under
CONFIG_EFI_PARTITION flag and no more CONFIG_EFI or CONFIG_CMD_EFIDEBUG
or CONFIG_CMD_EFIDEBUG

test result:
https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/26699

V3 version solve issue for "ESP" support when
CONFIG_CMD_EFIDEBUG and CONFIG_EFI is not activated
for example for test with qemu-arm-sbsa defconfig

Fix and add documentation/tests for selection by string for known
partition type GUID introduced by bcb41dcaefac ("uuid: add
selection by string for known partition type GUID"):

- split list_guid for short name (used also for partiton
  description with type parameter) and full name to display
  information

- as the function are uuid_str_to_bin() / uuid_guid_get_str()
  are no more under CONFIG_PARTITION_TYPE_GUID,  since commit
  31ce367cd100 ("lib/uuid.c: change prototype of uuid_guid_get_str()")
  and commit c1528f324c60 ("lib: compile uuid_guid_get_str if
  CONFIG_LIB_UUID=y") move the content of array under EFI_PARTITION
  and linker will remove it is not used it (in SPL)

- Add and fix documentation for gpt command

- Add test test_gpt_write_part_type to test "type=" parameters

This first patch solves an issue for the "system" shortcut for ESP,
removed by commit d54V3 version solve issue for "ESP" support when
CONFIG_CMD_EFIDEBUG and CONFIG_EFI is not activated
for example for test with qemu-arm-sbsa defconfige1004b8b1 ("lib/uuid.c: use unique name
for PARTITION_SYSTEM_GUID") but used in 2 location (at least):

1- board/samsung/e850-96/e850-96.env:10:

partitions=name=esp,start=512K,size=128M,bootable,type=system;
partitions+=name=rootfs,size=-,bootable,type=linux

2- arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c:1151

			case PART_ESP:
				/* EFI System Partition */
			459219	type_str = "system"
....
			offset += snprintf(buf + offset,
					   buflen - offset,
					   ",type=%s", type_str);


Changes in v4:
- update compilation flag used in the test print_guid for
  "EFI System Partition" known part type UUID

Changes in v3:
- The definition for ESP = "system" partition in list_guid[]
  is no more under CONFIG_CMD_EFIDEBUG or CONFIG_EFI flags,
  and restore the initial level (always support for display)
  as it is done for MBR partition or when U-Boot is a UEFI
  loader (CONFIG_CMD_BOOTEFI).

Changes in v2:
- change 'string' to 'type' in struct for list_guid[]
- clarify the usage of struct field 'type' and 'description' in
  comment and in commit message
- use 'type' for EFI_XXX description as these string have
  no space and size is lower than 36 characters.

Patrick Delaunay (3):
  lib/uuid.c: restore support of system partition type for ESP
  doc: cmd: gpt: add information on type partition
  test/py: tests: gpt: add test_gpt_write_part_type

 doc/usage/cmd/gpt.rst     |  93 +++++++++++++++++++---
 lib/uuid.c                | 162 +++++++++++++++++++++-----------------
 test/common/print.c       |   3 +-
 test/py/tests/test_gpt.py |  27 +++++++
 4 files changed, 201 insertions(+), 84 deletions(-)

-- 
2.25.1

base-commit: c5afa1fef49f55146e78d6157470520391c40eca
branch: sdsdfsfdsddf
