Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB49CD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 09:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A8838491C;
	Tue, 16 Jun 2026 11:23:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="boiTit0G";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X8RPSZa4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D761984935; Tue, 16 Jun 2026 11:23:48 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5EB5848EB
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 11:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G8s2q81239601
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 09:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uJqcuhG4cXyfq5u1S/oTBnB51FN/yXEN4dfiBsCVAKs=; b=boiTit0GY4IrlCn3
 dKSa343nh/AXJMCIt627iGSQOtEg7tsg6B7cw7LugGfv8JAbaWaBTnOwLYRDxWGm
 GM33Zo7G4cYRzYwnN+Mg4BtHztSMAvvuxKdHO1J2fyU1GJiFlwx598T4jCwcw0ba
 ameq0Dh8NnNZnDk766MjyYHpGjsbDjkHg5PHbjD7QBRxUpW5qRCetCoVKxV1rzEy
 ty8L5NauhD3Uyv8zzXI9aM5Qx4Q+t/GG15O/GOMFUW7/9SnM9j6105T4EY/q90D5
 NZiyaYQ3Empr6o+6ttPbpp66ZXyk3ttgMNTJeMfn7JssnlfKuuwR2tyJLerqBR1c
 YdzNfA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu3ct043d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 09:23:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36bd4146cb2so4804671a91.1
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 02:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781601824; x=1782206624; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uJqcuhG4cXyfq5u1S/oTBnB51FN/yXEN4dfiBsCVAKs=;
 b=X8RPSZa44sJIHYld/Dl0R8yWVzL/F5vaeqbBJgBKMpayoKB1ornMMkdJ6T07vNyMxA
 f8AFaNFwFbW/HNWGQPFLBPAmyESjH8ccHWg62kkverejJZYG3dRC++1jpMp+lO+r54uD
 aFm/eBDgDAEiXf6CKoVg7/jSX67HbF/eP8arbgn8sjB4mjkO9cOr6OXF/bEx8o1gKkTH
 b7AUUFMUsCdtm7l0PJ2EDnFvh7yK3TAtDOJ0kmvh6Y4Jh9ZQC+EqojBXYgtlk7N0aPHf
 Wto2xnqmOO3BkPmjiB2ZkwOldvsIyPB/cgiDDn9rtm9muKofgO05g7noJgfhRA8lY0tc
 TiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781601824; x=1782206624;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uJqcuhG4cXyfq5u1S/oTBnB51FN/yXEN4dfiBsCVAKs=;
 b=kmVuKmckcgKCK7thmYTyYVsbYR0Dkb+t55Nm7s0Mmaw1XWMYpDqZknJ52BybpIRGLp
 H0Y7iUR0wX/trcVW9jSTB9plUfyVtuLT7LC58mdPoCYPjBlqh2eWIcMrjepwsHXhia+2
 ZLl7gUDgkwmQaEl4etsxoAMJfZ1qMKZV1HDFetEEwgsz99pGMjH0D5rJMa7D6Y0eDUTG
 gxCIaO9y5/vO8+xBQGCRqvFO6msaxu0bvnlyBG8X7YWNrBPMSWqo1/eZ5l/ugp6QX/2W
 xCpaUJ2pxWh0YgiT5UyhOMPAK2I6MNowYKKzTnt/qGyfMQgx+GiWgSR1DY0eEswiBvBf
 BYfw==
X-Gm-Message-State: AOJu0YyEAX8zH79WpX7xfMXopddazmIbQcl8HrU+G/jviJxFAjvy5Xaz
 eAkz/sdrkrl+SKQ819v2T1rLMKQHtlmeEDhRcP5evwUtrELdU36RXfvnrxvlsVauBiwmfgEpxbo
 3P6e9sWJt2KQubgDna4Puw+Na/p3wh95buQMiu+zSX5EEjl1uQxo5JCXh
X-Gm-Gg: Acq92OFYok5YKrKa1jhMxEuG9VCf1TEjCJYu5tqe/EWXd8T/OnDa7zbm9Y71LU6E4qu
 EYvU/er7z3/U1q51zNiqwGqxdFRYNhN2CFqHA2U76GbxZrCr83464el0lJREbCoUh2/F+aacSlU
 C9YU6kqNwkNA2mSQuioFpRtbfH3t/jaPJMm4xnjPWCrGyEG1ODNP909+w11sC5oUCgl94BhOQl7
 3eYhZp/MjFvtxgOjo2S2hIeiYObLBF+ygijxzpeJU7AMfQHiHLxVXRjjHJ5jiiU4PfiObnh9+/O
 OYYJyj9xyYOvnJC1gNFKdDqJ0DWe3qWTB8h7Pe1bUjwjRH5veixymcMiIh/kMAkdzKqGtHzUA2y
 C7iEj1FlSIRZfrBtyteBn7UDxHTDNtq7WdmQihBx63/lyd+dSK7i40xUae3gNLbfFtG7qaJpD8e
 +cfL8bcvbSJ1+NUEueJWL2qmPYvRn4ukbemc7pRrmHEdNUN8Rc7A==
X-Received: by 2002:a17:90b:50ce:b0:36b:a162:a1be with SMTP id
 98e67ed59e1d1-37c5237f51emr2166555a91.4.1781601823887; 
 Tue, 16 Jun 2026 02:23:43 -0700 (PDT)
X-Received: by 2002:a17:90b:50ce:b0:36b:a162:a1be with SMTP id
 98e67ed59e1d1-37c5237f51emr2166529a91.4.1781601823450; 
 Tue, 16 Jun 2026 02:23:43 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c522136cesm2360005a91.14.2026.06.16.02.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 02:23:43 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 14:52:56 +0530
Subject: [PATCH v3 6/6] configs: add qcom_lemans_snagboot_defconfig for
 Lemans-EVK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-sngboot-v3-6-6fb0dee8125c@oss.qualcomm.com>
References: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
In-Reply-To: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781601774; l=2304;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=34ZNQh885T5d5QyYhizXOy0qKPMRxMXi8xXaDNTRi1U=;
 b=YEJJU/n7CwY3k949NBUqDYkgziVSY6J468FV99G5wD0O1w9SLEpR4ze5jmvrLPgMXr6YIvrGK
 pQw6hkPOP+0BLwluhRba/++egBXlvKMUAIFp36hLwszkYZEMgXnYyOW
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=SoCgLvO0 c=1 sm=1 tr=0 ts=6a311620 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=iwDJoBWoSSKHgV_OplIA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: Ko0zGx_cXapCWsem8FCU9P22MZUGK7Z0
X-Proofpoint-ORIG-GUID: Ko0zGx_cXapCWsem8FCU9P22MZUGK7Z0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA5NCBTYWx0ZWRfX8ib52hW81jQM
 oAhR93+jefLAHng5WwXxuUGdwD9/VpfZAAtSFvYXTfVi0ESciaouOX1yRU0nnYBFCs5i/cx3MDe
 W5PWY1YKrF+ca3EBVSEcZEs35UgSKSBkGKpMX/F/QpjV4RUGaqrkJI/zpuHDkX1EaUWqjITSE6K
 BT1yABx56tDdDQjADeqqAIrrcTy/nLidm5hKJ+40bATASV34IJIa0evwExf2zUSe9WfiFAg7Hz8
 9Sqs3Qi9lPHyMcRoDHniNMpxfTdXh07warwNT26Tf51cOJ/bcejEXERTK1Z79pZk9RhXVK+4lLm
 m+stE8jGQWSBLTCvsrG+vQrPmcRlVDCdqZ5MgSYyI4EzImZ+zKhtLDa2vPVml88BMdATAMP0nzn
 JOaTint9hUwLCWZ3iPgr4KIje3eaYUhCar664QLvRgpBT1Gnj8Csw+3vBLjM71TFet5K7qi5ZgM
 pgAQIMtMURifPSw683A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA5NCBTYWx0ZWRfX0h0WIXvzNpsO
 12973hFyOAJaZIn3Ui/e9klMScVnl6G7/hQ4enSxJ4TUNxD4SUdBsqJVNlm+hwbXeKBA/ulPW+g
 /fvDIk2raY8fJAgbk06Fn4VQmhMA1GM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160094
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

Add a defconfig for booting U-Boot in snagboot mode on Lemans-EVK
development boards. In this mode, XBL loads U-Boot directly and
U-Boot immediately enters fastboot over USB for partition flashing.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Removed enabling QCOM_COMMAND_DB_OPTIONAL, ENABLE_ARM_SOC_BOOT0_HOOK
  and SKIP_RELOCATE as they are now automatically enabled by
  QCOM_SNAGBOOT_SUPPORT selection

Changes in v2:
- Newly introduced in v2
---
 configs/qcom_lemans_snagboot_defconfig | 45 ++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/configs/qcom_lemans_snagboot_defconfig b/configs/qcom_lemans_snagboot_defconfig
new file mode 100644
index 00000000000..c7ac07a6cf3
--- /dev/null
+++ b/configs/qcom_lemans_snagboot_defconfig
@@ -0,0 +1,45 @@
+# Configuration for building U-Boot for snagboot/recovery mode
+# on Lemans-EVK dev boards.
+#
+# For normal production boot, use qcom_lemans_defconfig instead.
+
+#include "qcom_defconfig"
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0x1c100000
+CONFIG_REMAKE_ELF=y
+CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
+CONFIG_DEFAULT_DEVICE_TREE="qcom/lemans-evk"
+CONFIG_ENV_IS_IN_SCSI=y
+CONFIG_ENV_SCSI_PART_USE_TYPE_GUID=y
+# SCSI partition type GUID for logfs partition
+CONFIG_ENV_SCSI_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"
+# CONFIG_ENV_IS_DEFAULT is not set
+# CONFIG_ENV_IS_NOWHERE is not set
+
+CONFIG_QCOM_SNAGBOOT_SUPPORT=y
+
+CONFIG_FASTBOOT_FLASH_BLOCK=y
+CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="scsi"
+CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=4
+CONFIG_FASTBOOT_GPT_NAME="gpt"
+CONFIG_FASTBOOT_MBR_NAME="mbr"
+
+# CONFIG_PSCI_RESET is not set
+
+CONFIG_COUNTER_FREQUENCY=19200000
+
+# CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR is not set
+
+# CONFIG_IOMMU is not set
+
+# CONFIG_REBOOT_MODE_ENV_UPDATE is not set
+
+# Disable default env file to use CONFIG_BOOTCOMMAND instead
+# This allows snagboot-specific bootcmd without modifying shared default.env
+# CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE is not set
+
+# Auto-enter fastboot mode for snagboot
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="fastboot -l $fastboot_addr_r usb 0"
+CONFIG_BOOTDELAY=0

-- 
2.34.1

