Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCEACDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 14:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CA4A86D0C;
	Thu, 12 Oct 2023 16:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="YCsppbed";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4685686DF6; Thu, 12 Oct 2023 16:49:25 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DBD886D0C
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 16:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eajames@linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CERJgc032031; Thu, 12 Oct 2023 14:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Z1vp6BP2HP458bZnaZEWM9nOrWaaww7QwogW7HU1E2s=;
 b=YCsppbedcPamMp9n+WK6hay3lhScAH6jQ4dGhW0Qnps3WqsssUlA8mhFa75XYexGSP9U
 SFsNVs34xRefM5kTdEAGXd9LLxW0HsHoSNua9Z0hGUyvNJnznqsO9kvx3ryPaKAv3zXl
 kXYCktYMB+F1uufLGbb6LX+O7Qos5z+2umPLB06MuNOGjK5XNQxNwPV5H6vvs2JZURdd
 kg0r1XAATCol9n0e6kdhZZpeBA0ij6BU2XGtSp9CbCU/x1kt0Ynp/PiWlIZXAVS8Uvc9
 NhzHaVRAUJb4oX6p/YBhP3xc5pcOlHETaijN7GLVv4dN3w+hDdRat2CzeP0ZTwzeC436 Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpjjxgrqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 14:49:13 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CETSWZ006573;
 Thu, 12 Oct 2023 14:47:58 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpjjxghhc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 14:47:58 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CE8CjD001170; Thu, 12 Oct 2023 14:45:52 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkkvk7q7c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 14:45:52 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CEjp0720972116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 14:45:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFFEE5805E;
 Thu, 12 Oct 2023 14:45:51 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8951B58052;
 Thu, 12 Oct 2023 14:45:51 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.148.23])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 14:45:51 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: u-boot@lists.denx.de
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, xypron.glpk@gmx.de,
 eajames@linux.ibm.com
Subject: [PATCH v12 0/8] tpm: Support boot measurements
Date: Thu, 12 Oct 2023 09:45:43 -0500
Message-Id: <20231012144551.679551-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OSeOkCZAwA5YRGfzVkLuT9kbMZb0Z0dW
X-Proofpoint-ORIG-GUID: LMNVyop8O9ghAy1CmDbVZnVunBJI8jDS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120122
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

This series adds support for measuring the boot images more generically
than the existing EFI support. Several EFI functions have been moved to
the TPM layer. The series includes optional measurement from the bootm 
command.
A new test case has been added for the bootm measurement to test the new
path, and the sandbox TPM2 driver has been updated to support this use
case.

Changes since v11:
 - Rebase on next. Sorry for the delay (been on leave).

Changes since v10:
 - Fix commit message on efi_loader change
 - Drop python test change
 - Squash armv7 fix from Ilias

Changes since v9:
 - Rebase and add Ilias' fixes (thanks!)

Changes since v8:
 - Fix a sandbox driver off-by-one error in checking the property type.
 - Fix log parsing again - any data corruption seen while replaying the
   event log was failing the entire measurement.
 - Added an option to ignore the existing log and a configuration option
   for systems to select that for the bootm measurement. This would only
   be selected for systems that know that U-Boot is the first stage
   bootloader. This is necessary because the reserved memory region may
   persist through resets and so U-Boot attempts to append to the
   previous boot's log.

Changes since v7:
 - Change name of tcg2_init_log and add more documentation
 - Add a check, when parsing the event log header, to ensure that the
   previous stage bootloader used all the active PCRs.
 - Change name of tcg2_log_find_end
 - Fix the greater than or equal to check to exit the log parsing
 - Make sure log_position is 0 if there is any error discovering the log
 - Return errors parsing the log if the data is corrupt so that we don't
   end up with half a log

Changes since v6:
 - Added comment for bootm_measure
 - Fixed line length in bootm_measure
 - Added Linaro copyright for all the EFI moved code
 - Changed tcg2_init_log (and by extension, tcg2_measurement_init) to
   copy any discovered event log to the user's log if passed in.

Changes since v5:
 - Re-ordered the patches to put the sandbox TPM driver patch second
 - Remove unused platform_get_eventlog in efi_tcg2.c
 - First look for tpm_event_log_* properties instead of linux,sml-*
 - Fix efi_tcg2.c compilation
 - Select SHA* configs
 - Remove the !SANDBOX dependency for EFI TCG2
 - Only compile in the measurement u-boot command when CONFIG_MEASURED_BOOT
   is enabled

Changes since v4:
 - Remove tcg2_measure_event function and check for NULL data in
   tcg2_measure_data
 - Use tpm_auto_startup
 - Fix efi_tcg2.c compilation for removing tcg2_pcr_read function
 - Change PCR indexes for initrd and dtb
 - Drop u8 casting in measurement test
 - Use bullets in documentation

Changes since v3:
 - Reordered headers
 - Refactored more of EFI code into common code
    Removed digest_info structure and instead used the common alg_to_mask
      and alg_to_len
    Improved event log parsing in common code to get it equivalent to EFI
      Common code now extends PCR if previous bootloader stage couldn't
      No need to allocate memory in the common code, so EFI copies the
      discovered buffer like it did before
    Rename efi measure_event function

Changes since v2:
 - Add documentation.
 - Changed reserved memory address to the top of the RAM for sandbox dts.
 - Add measure state to booti and bootz.
 - Skip measurement for EFI images that should be measured

Changes since v1:
 - Refactor TPM layer functions to allow EFI system to use them, and
   remove duplicate EFI functions.
 - Add test case
 - Drop #ifdefs for bootm
 - Add devicetree measurement config option
 - Update sandbox TPM driver

Eddie James (6):
  tpm: Fix spelling for tpmu_ha union
  tpm: sandbox: Update for needed TPM2 capabilities
  tpm: Support boot measurements
  bootm: Support boot measurement
  test: Add sandbox TPM boot measurement
  doc: Add measured boot documentation

Ilias Apalodimas (2):
  efi_loader: fix EFI_ENTRY point on get_active_pcr_banks
  test: use a non system PCR for testing PCR extend

 arch/sandbox/dts/sandbox.dtsi  |  13 +
 arch/sandbox/dts/test.dts      |  13 +
 boot/Kconfig                   |  32 ++
 boot/bootm.c                   |  74 +++
 cmd/booti.c                    |   1 +
 cmd/bootm.c                    |   2 +
 cmd/bootz.c                    |   1 +
 configs/sandbox_defconfig      |   1 +
 doc/usage/index.rst            |   1 +
 doc/usage/measured_boot.rst    |  23 +
 drivers/tpm/tpm2_tis_sandbox.c | 100 ++--
 include/bootm.h                |  11 +
 include/efi_tcg2.h             |  44 --
 include/image.h                |   1 +
 include/test/suites.h          |   1 +
 include/tpm-v2.h               | 263 ++++++++++-
 lib/Kconfig                    |   4 +
 lib/efi_loader/Kconfig         |   2 -
 lib/efi_loader/efi_tcg2.c      | 823 ++++-----------------------------
 lib/tpm-v2.c                   | 814 ++++++++++++++++++++++++++++++++
 test/boot/Makefile             |   1 +
 test/boot/measurement.c        |  66 +++
 test/cmd_ut.c                  |   4 +
 test/py/tests/test_tpm2.py     |  16 +-
 24 files changed, 1482 insertions(+), 829 deletions(-)
 create mode 100644 doc/usage/measured_boot.rst
 create mode 100644 test/boot/measurement.c

-- 
2.39.3

