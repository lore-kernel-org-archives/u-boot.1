Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595DCC3DA6D
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 09:14:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4485183214;
	Fri, 23 May 2025 11:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="3ekU5Ffx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 679488310F; Fri, 23 May 2025 11:13:55 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AF29831E1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 11:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=72381bbdd8=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N825Bb024875;
 Fri, 23 May 2025 11:13:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=ACFrisDu8tg1goyDNxT7D6
 YzhKoQyyK3ZgaPIm9+gjs=; b=3ekU5FfxMPzPp0vxEASlHy+qhURsvTxV62+t7n
 F6c2QYBqGMLxs3PM2xSJIxozNc5c6EctI57Ih3p34RHBnHaMqoquK7J5rVrBVaYN
 8jZx1jdk5gr5RA3HmztSFmhNxwm5mzyesBUY7DGCcA0cV1ZzKt4Ro1ojagP6sxfT
 iqO1qqvWrqnWZBp0VOoIKB27zETVk+FpiVSC2ei3Hu0SqoriYHBjtSaPGuYPOoCg
 WKY1ZZfttqXuhhy1ey0H0mUg18NQjcCZZc1TLw0lkSreHEjCiM1d9LR2hvx4RdM0
 HIo389lFjYUnajMY2oi4aMJkRd7cp+4jEX+TWk1iHgg6Zy7g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46rwfan7p0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 11:13:40 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 41A5440048;
 Fri, 23 May 2025 11:12:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8FBB1AC4D07;
 Fri, 23 May 2025 11:11:48 +0200 (CEST)
Received: from localhost (10.48.86.182) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 11:11:48 +0200
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: <caleb.connolly@linaro.org>, <jerome.forissier@linaro.org>,
 <ilias.apalodimas@linaro.org>, <patrice.chotard@foss.st.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Adriano Cordova
 <adrianox@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, =?UTF-8?q?Vincent=20Stehl=C3=A9?=
 <vincent.stehle@arm.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 0/3] Restore support of short name for type UUID parameter
Date: Fri, 23 May 2025 11:11:37 +0200
Message-ID: <20250523091140.149298-1-patrick.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.182]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
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
branch: sdsfsfsdfsdfds
