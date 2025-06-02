Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243E1C54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 14:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9052E8205A;
	Mon,  2 Jun 2025 16:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="x8hxHfxx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26E178291D; Mon,  2 Jun 2025 16:03:25 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 243928070C
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 16:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=8248ff287b=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552AARZC025694;
 Mon, 2 Jun 2025 16:03:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=aOVwHK6vXZ4LJjfDH/gEGg
 mfu0yJJn2npVOuo1RlFkw=; b=x8hxHfxxS7sn2aY7Ahki1MQy4RJHr/DSivDSFX
 fvGj5F9T9KKWecNc+eg6QmOZxmwMZ+eKI7lxGiWMix2PCA4rUQenlhFmhTZT0WBh
 AtyZTL/gUq3xdhr2hCIvVmynxO98LvCvkNlwh8+Izkwfb3R/+TI6rzJA5/fISGn9
 +aaNsIL3W9TFFGwkMBxIXcpwjWqmqvwYnTpDA3/XNFbBEZTuQXDwAgUe95n/eZoz
 kVyZtDwcbZ2NjFbWP9DvEwqAONFLW6D389O79WE312dcLBuITZzHPYydYYGyWv3W
 tiVcHkfTHNMwiqlHLZOvQ63WONP6PJh07kkkoxr5FJFQFf5g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46yrngxx4c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Jun 2025 16:03:09 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 843E840098;
 Mon,  2 Jun 2025 16:01:42 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 98E68B5327F;
 Mon,  2 Jun 2025 15:59:41 +0200 (CEST)
Received: from localhost (10.48.86.182) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Jun
 2025 15:59:41 +0200
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: <caleb.connolly@linaro.org>, <ilias.apalodimas@linaro.org>,
 <jerome.forissier@linaro.org>, <patrice.chotard@foss.st.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Casey Connolly
 <casey.connolly@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v3 0/3] Restore support of short name for type UUID parameter
Date: Mon, 2 Jun 2025 15:59:31 +0200
Message-ID: <20250602135935.232370-1-patrick.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.182]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-06-02_01,2025-03-28_01
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
removed by commit d54e1004b8b1 ("lib/uuid.c: use unique name
for PARTITION_SYSTEM_GUID") but used in 2 location (at least):

1- board/samsung/e850-96/e850-96.env:10:

partitions=name=esp,start=512K,size=128M,bootable,type=system;
partitions+=name=rootfs,size=-,bootable,type=linux

2- arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c:1151

			case PART_ESP:
				/* EFI System Partition */
				type_str = "system"
....
			offset += snprintf(buf + offset,
					   buflen - offset,
					   ",type=%s", type_str);


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
 lib/uuid.c                | 158 ++++++++++++++++++++------------------
 test/py/tests/test_gpt.py |  27 +++++++
 3 files changed, 196 insertions(+), 82 deletions(-)

-- 
2.25.1

base-commit: cf37480bc8335494cf88b7180dc3f1eb8cf63a9d
