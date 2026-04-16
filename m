Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAA8F8808C
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 07:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BF6F83EEF;
	Thu, 16 Apr 2026 09:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="W19NrX5h";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aQYZhjeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF5D7840AB; Thu, 16 Apr 2026 09:03:44 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0691083C2B
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 09:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G1VUja3089238
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=XrAx0X9wkDj+inJ6ZqBqpKXu05MCeOUtFCD
 ymkWcnX8=; b=W19NrX5h8wqKSH6WbRYkNF+/DqdBKs1WVDJz5v/8ZjMAu6O5M0a
 dHw6E+eWmHWKMIJYWagdrd0bnRg0HZl+ouRdDxURq+ey6MT7ZKWxdtQMQ8XjFZFs
 3d4PAhqP90+/c209ZWiqvb+TOARqHOOs4dlt8O4u/Ts8UvFkXMVT+h9J4KswJMQg
 80ondql02p06BDh4v+c6ZsLAUs/mstPPzua0XFtzGYPRE8H9FOZl6a8ju0INU/3a
 tB9YdPn1bIqfkM5PGbC8gmItOukOcCoEFv5w5ehxGWxLsTJ/ITXWTLw46vDoo0j0
 7oW074ZCkCaPhyew8enbb+7zinVkt5ocNKg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djp6a8wxn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:03:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b249541063so71307535ad.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 00:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776323019; x=1776927819; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=XrAx0X9wkDj+inJ6ZqBqpKXu05MCeOUtFCDymkWcnX8=;
 b=aQYZhjeEPgkTEMQF38kHn8fQPsAu0JZ53Fq3fnTFzz8mdTzoZPzBzqsLnULH/mPCbx
 32PO0UXMPmB5N6jLdvwG+djtwHMbhu2dOhHYXcvisqKR+/Pq8/gkSNtUC2VhpK85U5pn
 78vZ3vz0m4zv28ssg9HV6UsQ3EAyCSehGTtGWZmYvcMCfKCZjyE1do0Xp+WwZ2DIpaC5
 i93J1jPPnsvjeFqt7sA81/vCiZdMe8W32UWn6zv8NsHLzmgQkPfm7mOS+n/9qjbxBkoh
 r6qh6TzboGE0uuhlCv8JG9xpQTMFpDCxAjrUkmlRegy8DC995YClZqjPFO1IPuVqe/81
 +QFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776323019; x=1776927819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XrAx0X9wkDj+inJ6ZqBqpKXu05MCeOUtFCDymkWcnX8=;
 b=WgNOV4rc1T15Q72VavwVozbIZG3KnUP3TfyWdf4i+wO75evRwLPZDT5v9Sj3GpYGRt
 aBeWsZCcfCJdVdTWC+jhW8cy16d6LglwZARj2+Lq9CIWRIovZXCKP71KjVfNKFOYdPpf
 zbJ/qPQpCd5CICGg6H7ke6Tk9xADjaTzOHE7wroRyaOBNlOI8vihfxpAYRJA1CvnV6ZD
 7FHCH9PhTXetHZ78eVqInT6CgUgvyysLxmgdnGGlwVRLDXydQc9N8muCPDi6DwC1gwAl
 k1aOkDKXd+PB+M4zKuoLBaRIASxShhrXTkf3EVZb1OQGn05MOAAoyn5cJneEW6FVviCl
 Wsjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+BXY08vp1K0eP0qD2VvicrN8joqWa0WvRfvz+lRGT+4OYPppvvyplxZCzSG6PqBZEkzlRcZnE=@lists.denx.de
X-Gm-Message-State: AOJu0YzhTRKHz+0h3zxWHV9j2shUzqn+S7I2n1DN+rNFrShbrRnOwGBQ
 Z9j+w5rgu+C2WJ3FNMIo8JymyliEdG2OFiF4ou61wjW6Wf6iJLlZzAzGapj7c9Vgw0T73CN2N5q
 hdNx/XTxRQwPFmygyjjgV3wzErKFfgyUMUAAEcjm086x//5gxu63lAfS5
X-Gm-Gg: AeBDiesXxVZ9rEukP7xu2UzlukoK3Br7GZUAt1uYFD56h0vi1zY+vawXyTYjuHNML/5
 LFqXzMvF7B/qmZBX4KtzktPJqffxgj20Ta9a/2bPtKEdfMllvokkn1BNCpK1KQ4kSb2zAlijiPD
 MyYJllCslrekuBeT5y/nSxp6NbBzao8PzLIKoWlmWATtk0jIKc8b5YMZ/7l91ZoXNrPXQ2b0p71
 Xy2SCTQA6zre+6dGs9/Shw0Aowg4sTykDoxeZbqOdflBXXgycwVMV7ktdGYIoLUKX4f2ptd0W42
 Wp2SOhKOE8u38NX9/v39dXmu3NQDbJSL26zC+jsAUEhEOLjBmZUbF7xYlOjgXFoNmbkSFHSBcU3
 9PdUEhX17TT8GgHjlmhERUoVXXBx02HVom+GsUl/V4k18JDUGqLGnxBmmTXyqO7RJ3DSFyGqSyk
 F4w5Hz7fD1u+082WALKqlvsDayW8DGZRUCqhHI0aYyMkYB8KfJO5Q=
X-Received: by 2002:a17:902:a5c5:b0:2b2:454f:b951 with SMTP id
 d9443c01a7336-2b2d5a34726mr204906865ad.29.1776323019109; 
 Thu, 16 Apr 2026 00:03:39 -0700 (PDT)
X-Received: by 2002:a17:902:a5c5:b0:2b2:454f:b951 with SMTP id
 d9443c01a7336-2b2d5a34726mr204906555ad.29.1776323018537; 
 Thu, 16 Apr 2026 00:03:38 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4782b1174sm54195255ad.70.2026.04.16.00.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 00:03:38 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, aswin.murugan@oss.qualcomm.com,
 simon.glass@canonical.com, tien.fong.chee@altera.com,
 michal.simek@amd.com, visitorckw@gmail.com, clamor95@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v7 0/5] Implement reset to EDL for qcs9100
Date: Thu, 16 Apr 2026 12:33:25 +0530
Message-Id: <20260416070330.3006528-1-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WR3Mk61VTlHBvL-tiB3mb7ZxH8MZPIDe
X-Authority-Analysis: v=2.4 cv=NuvhtcdJ c=1 sm=1 tr=0 ts=69e089cb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=YfCOm-DyAAAA:8 a=COk6AnOGAAAA:8 a=oNkET6w61TwMc-c2jNEA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=zQLMK8awuJ6_Hvp-_9Ux:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: WR3Mk61VTlHBvL-tiB3mb7ZxH8MZPIDe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA2NCBTYWx0ZWRfX8qu9liq3mPk0
 lIAo7NjGzEsR8IMhTkqyxBxyhsW21HVJyRe9wkoiAhTg79gDMKo6HkqyKLEqM6MorgolqbS+/hf
 ZyG/+JFkDuDamyZGaQy6Mj+D5uL853fiTBCZ19TN38yBj7l70XmSjWuhnuwzGbOXMPe7Mcx7JxG
 Iv/Tl31shgh7BOOsk6bWOb474KASpDF9DbcG6O7u3M+qV3cKtks0qWf4OKa5qbsXkrQ+5Sc+at+
 UvPBNnxknEJt2R0JvQ61Lph0dQyR4UGcLx9yhKXzr+h7rsCHchdjqK053CWKf0NbOOJE2i8nLYR
 rh3hwTjmRcyu1CdGoYXP58w43MQwh50iLIzmK0Fj3JMgmUp2d0zZ/3XJ4EiKT2jhfsxL1fr5ueE
 j+MASaus10bN1heAqO4yLRDObMDjBGUT9wCUDaaSg6gezd3NHQKF9oGU+0R6iNyeIQBPPvtGwh1
 uV1Wlexr6zp6fdlPCQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160064
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

Using the 'reboot edl' command in Linux, the platform can reboot to the
Emergency Download mode. Implement the same for U-Boot.

v7: * This seems to have slipped through the cracks though all patches have R-b
    * So reposting the same after rebasing to ToT based on https://lore.kernel.org/u-boot/20260217143957.GZ2747538@bill-the-cat/
    * No code changes
    * Size change details
------------------------
qcom_qcs9100
------------------------
   aarch64: (for 1/1 boards) all +145.0 data -40.0 rodata +89.0 text +96.0
            qcom_qcs9100   : all +145 data -40 rodata +89 text +96
               u-boot: add: 9/0, grow: 4/0 bytes: 656/0 (656)
                 function                                   old     new   delta
                 sysreset_walk_arg                            -     124    +124
                 _u_boot_list_2_driver_2_qcom_psci_sysreset       -     120    +120
                 qcom_psci_sysreset_request_arg               -      84     +84
                 smc_call                                     -      68     +68
                 do_reset                                   100     160     +60
                 psci_system_reset2                           -      44     +44
                 psci_features                                -      44     +44
                 sysreset_request_arg                         -      32     +32
                 qcom_psci_sysreset_ops                       -      32     +32
                 psci_bind                                  188     212     +24
                 qcom_pshold_ops                             24      32      +8
                 qcom_psci_sysreset_get_status                -       8      +8
                 psci_sysreset_ops                           24      32      +8
------------------------
qemu_arm
------------------------
Building 2 commits for 1 boards (1 thread, 16 jobs per thread)
01: x86: there is no CONFIG_UBOOT_ROMSIZE_KB_12288
06: qcom_defconfig: enable psci based sysreset
    2    0    0 /2              qemu_arm
Completed: 2 total built, 2 newly), duration 0:00:19, rate 0.11
/tmp/qemu_arm/master/boards.cfg is up to date. Nothing to do.
Summary of 2 commits for 1 boards (1 thread, 16 jobs per thread)
01: x86: there is no CONFIG_UBOOT_ROMSIZE_KB_12288
06: qcom_defconfig: enable psci based sysreset
(no errors to report)

------------------------
qemu_arm64
------------------------
   aarch64: (for 1/1 boards) all +8.0 data +8.0
            qemu_arm64     : all +8 data +8
               u-boot: add: 0/0, grow: 1/0 bytes: 8/0 (8)
                 function                                   old     new   delta
                 psci_sysreset_ops                           24      32      +8

v6: * https://lore.kernel.org/u-boot/20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com/
    * Add r-b Sumit
    * Wrap the new code inside CONFIG_SYSRESET_CMD_RESET_ARGS
    * Size change details
------------------------
qcom_qcs9100
------------------------
Building 2 commits for 1 boards (1 thread, 16 jobs per thread)
01: Merge tag 'u-boot-imx-master-20260117' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
07: qcom_defconfig: enable psci based sysreset
    2    0    0 /2              qcom_qcs9100
Completed: 2 total built, 2 newly), duration 0:00:25, rate 0.08
/tmp/qcom_qcs9100/tot/boards.cfg is up to date. Nothing to do.
Summary of 2 commits for 1 boards (1 thread, 16 jobs per thread)
01: Merge tag 'u-boot-imx-master-20260117' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
07: qcom_defconfig: enable psci based sysreset
   aarch64: (for 1/1 boards) all +145.0 data -40.0 rodata +89.0 text +96.0
            qcom_qcs9100   : all +145 data -40 rodata +89 text +96
               u-boot: add: 9/0, grow: 4/0 bytes: 656/0 (656)
                 function                                   old     new   delta
                 sysreset_walk_arg                            -     124    +124
                 _u_boot_list_2_driver_2_qcom_psci_sysreset       -     120    +120
                 qcom_psci_sysreset_request_arg               -      84     +84
                 smc_call                                     -      68     +68
                 do_reset                                   100     160     +60
                 psci_system_reset2                           -      44     +44
                 psci_features                                -      44     +44
                 sysreset_request_arg                         -      32     +32
                 qcom_psci_sysreset_ops                       -      32     +32
                 psci_bind                                  188     212     +24
                 qcom_pshold_ops                             24      32      +8
                 qcom_psci_sysreset_get_status                -       8      +8
                 psci_sysreset_ops                           24      32      +8
(no errors to report)

------------------------
qemu_arm
------------------------
Building 2 commits for 1 boards (1 thread, 16 jobs per thread)
01: Merge tag 'u-boot-imx-master-20260117' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
07: qcom_defconfig: enable psci based sysreset
    2    0    0 /2              qemu_arm
Completed: 2 total built, 2 newly), duration 0:00:19, rate 0.11
/tmp/qemu_arm/tot/boards.cfg is up to date. Nothing to do.
Summary of 2 commits for 1 boards (1 thread, 16 jobs per thread)
01: Merge tag 'u-boot-imx-master-20260117' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
07: qcom_defconfig: enable psci based sysreset
(no errors to report)

------------------------
qemu_arm64
------------------------
Building 2 commits for 1 boards (1 thread, 16 jobs per thread)
01: Merge tag 'u-boot-imx-master-20260117' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
07: qcom_defconfig: enable psci based sysreset
    2    0    0 /2              qemu_arm64
Completed: 2 total built, 2 newly), duration 0:00:18, rate 0.11
/tmp/qemu_arm64/tot/boards.cfg is up to date. Nothing to do.
Summary of 2 commits for 1 boards (1 thread, 16 jobs per thread)
01: Merge tag 'u-boot-imx-master-20260117' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
07: qcom_defconfig: enable psci based sysreset
   aarch64: (for 1/1 boards) all +8.0 data +8.0
            qemu_arm64     : all +8 data +8
               u-boot: add: 0/0, grow: 1/0 bytes: 8/0 (8)
                 function                                   old     new   delta
                 psci_sysreset_ops                           24      32      +8
(no errors to report)

v5: * Update author and signed-off-by email id from quicinc.com to oss.qualcomm.com
    * Add r-b tags
    * Enable CONFIG_SYSRESET_QCOM_PSCI in qcom_defconfig instead of qcs9100_defconfig

v4: * Update documentation about '-edl' option
    * Add API to check for support of PSCI functions
    * Check if RESET2 is supported before issuing the command
    * Fix compiler warnings

v3: * Introduce a sysreset op that will pass down the 'reset' command
      arguments to registered handlers
    * Handle 'reset to edl' alone in qcom-psci driver

v2: * Rebased to recent sources
    * Dropped the first patch as it is not applicable anymore
    * Bind the new driver from psci driver

Varadarajan Narayanan (5):
  arm: psci: Add API to check for support of specific PSCI function
  drivers: sysreset: Add sysreset op that can take arguments
  sysreset: Implement PSCI based reset to EDL mode for QCOM SoCs
  cmd: boot: Add '-edl' option to reset command documentation
  qcom_defconfig: enable psci based sysreset

 arch/arm/cpu/armv8/fwcall.c           | 15 +++++++++
 arch/arm/include/asm/system.h         |  1 +
 cmd/boot.c                            |  3 ++
 configs/qcom_defconfig                |  2 ++
 doc/usage/cmd/reset.rst               |  2 ++
 drivers/firmware/psci.c               |  4 +++
 drivers/sysreset/Kconfig              | 14 +++++++++
 drivers/sysreset/Makefile             |  1 +
 drivers/sysreset/sysreset-uclass.c    | 37 ++++++++++++++++++++++
 drivers/sysreset/sysreset_qcom-psci.c | 45 +++++++++++++++++++++++++++
 include/sysreset.h                    | 18 +++++++++++
 11 files changed, 142 insertions(+)
 create mode 100644 drivers/sysreset/sysreset_qcom-psci.c

-- 
2.34.1

