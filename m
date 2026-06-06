Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B70CD8C8E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 11:20:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 210C3846F9;
	Sat,  6 Jun 2026 13:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FLg+inBu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GSkvj+mD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB69F83EF9; Sat,  6 Jun 2026 13:20:44 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A07F883EF9
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 13:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656BDt1x1257123
 for <u-boot@lists.denx.de>; Sat, 6 Jun 2026 11:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QofbVny1fmxido9cPSKJ77zl9ZD23J8pcdfqFB1CCH8=; b=FLg+inBu2rTVEiLi
 ma4pG/vs8PoBCvfQjbLrWl+32HG9Bn8xBkE+rS3NPUTqg+EP8LLUjbNlvL2ZxRy2
 bhHI2jXx17Vw57BjELZF7DHDMt64XUNKBOsjdsdG5+6Zpin2um+btKYwmH2SifmS
 +zJpefiy1FKEXRCkyXuiBDc+54gLia5KSg9cwzoAcVGDNQGHD+CNKaVSXpNYCTO/
 tTZLI0SioJ5R7u8ebPH+bnRAlfrdvr/vwJooN9LmSmzEUuxF97VoYxuMrQ8tnSTi
 NpPA8Nar+nkjJZOPGWMwHDBdY5udOXOOyrm1CVys1tRDBk3jZjnZ6UAzPKCaM57J
 +ydOAg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcadrrgf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 11:20:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2bf0d79d41eso22499435ad.1
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 04:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780744840; x=1781349640; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QofbVny1fmxido9cPSKJ77zl9ZD23J8pcdfqFB1CCH8=;
 b=GSkvj+mDXRlWXlKGepAqfo2uVPMETfY28K5eEfbYwR9wjgjtp5EFoV5DRxHWd2Jsi7
 etVLdY7fiDjKVUALIdi8NGbX3pRbCNBWrESwP5kocGff9SETIvfXA4buHhX18QRX4gk/
 m1zKxX6H/dm8s3Z3AUtufAwf0rqyk6KfECwseJGvuMQwYaB89KldKnLduA/J/nUqEUvp
 TdO1+2dwoB0k2Wpbld84Kv5Ne1NVMB0pL1VmRLWsB6l5pKBxbzSTvpx/qNLxTPlVCpLe
 9Qp+7mlHj6N4ZdIST9cfLhd9ZrEBtn/WIfc20BKiPHQM27aP9FyC5PLs2OxHCCJ3YePz
 AILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780744840; x=1781349640;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QofbVny1fmxido9cPSKJ77zl9ZD23J8pcdfqFB1CCH8=;
 b=cRFRyhHpo2P6eS7eFQuVg4lr2jyWRHRCnwU60NA8jVMfPKtvvbG+vfGK7V2Iw/Bht8
 2S1TXvl6ziu3dyQQsBBNB+t4VeU3q7k85iz6Q9v4p4VQaeEXyCRL9lxGLOKjVQ70sKzO
 6bE9BRfbBaULCZl+eaMVJ1q1FgLqBGbZVhTE8GLI9RNAHA0pXAWM6vUuGJoDvVtnEH6k
 rwnyzxBHTe/kT5ZN30brwnCZ09/TtH7aj1N3Wc6TPUYUgD7BRMHmSYjlaHAyOJBRKaWd
 L/H1oLZPDpoNKcreYJE137LB1cfrQkbNktpdFt2sUv4bElRIIS0SOWOJGa2t12VPvBEC
 eHhg==
X-Gm-Message-State: AOJu0YzWJrKHrFe+0pTywCsO52JhAqJQiV+dVsLiwvEsAvV7qiGjOSBr
 i0xBcprUtI1wWq5lyXa1ISPM5XCTB1XiA+9WLf6NWoA+iZUhWKeYzjLax+8iBQecypDKH0yDbQv
 QuMcXA5ZVp2zLIzv9tYS+tDXqvfKf/xaVrt6zOFTsvvqTG34PGBEE3Jok
X-Gm-Gg: Acq92OERfquiX69FSDTKEFKFxEz9TwA28xNyjS1cgx/+wPJ/3rcgpw563glkDrTKU79
 6p36N4goVgAGBbOkRKHps9/cCNDJhMVDorh+u2CO7jvmCJvDW+ldV40vony7ElZXSquEvmsF9ZS
 OQqeLu4B3Tw9hQELVPsc+TDt0U44yTzLApeFtWSGVijoKog1TntI7tUkzfvv0FhAIIN//yajFYp
 DqDxIjmalpkYCrnW2dYrEI76dMjPCEKr5pqRXq+PnvxDKZOtAiSGN+8cMqYJ9YxaMcIn3ho7Iw+
 QJHzXt1wI3wkRPdw3kyI2iB1RM8HkNdBOBiliE28omj8Cx5poO2s7JlsTQ7nouAi0gtuWEF1cgL
 BRC8PRVKw028vYwYCnPolG79Zld/WmNluvnnDxieX1qk9WA6Gg2A99GuHFENZFzhZ9+fpy/7xQW
 O+o8bva2LD2Yn5lWEpQZXk3hRJwfOtharcPsFlFwcGf6H0wS33PWtrO9gegZ0n
X-Received: by 2002:a17:903:2c08:b0:2c0:c625:4011 with SMTP id
 d9443c01a7336-2c1e7b40049mr93979195ad.4.1780744839644; 
 Sat, 06 Jun 2026 04:20:39 -0700 (PDT)
X-Received: by 2002:a17:903:2c08:b0:2c0:c625:4011 with SMTP id
 d9443c01a7336-2c1e7b40049mr93978865ad.4.1780744839174; 
 Sat, 06 Jun 2026 04:20:39 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f6e294sm120672185ad.6.2026.06.06.04.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 04:20:38 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 16:50:28 +0530
Subject: [PATCH 2/2] configs: qcom: Add qcom_lemans_spl_defconfig for
 Lemans EVK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-lemans_spl-v1-2-ead97dd5b515@oss.qualcomm.com>
References: <20260606-lemans_spl-v1-0-ead97dd5b515@oss.qualcomm.com>
In-Reply-To: <20260606-lemans_spl-v1-0-ead97dd5b515@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780744830; l=3363;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=KE4tZeBEXDBuSV/J4I7ZuOzbRHBdKY5T48vSAWX9dqw=;
 b=QOzUT4lrC/lqwCUpI7edww0ghmcs5RAsTCvItpxd7Ch9Mk7AE4spo8uuf2zRLiBTYDbrOsKOB
 gtdaOGTWig6CNGxrUeR4WC5g1beJ/J2FUQnzWcaBVQ9DO+vxaNbQLmX
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=DIa/JSNb c=1 sm=1 tr=0 ts=6a240288 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=MIDpp_XfdsXPtEUIc0cA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: cshH2-eEXmw6m2UjHamLtlmtKyZ7ENpM
X-Proofpoint-ORIG-GUID: cshH2-eEXmw6m2UjHamLtlmtKyZ7ENpM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDExMSBTYWx0ZWRfX1tt2esUDy8rh
 F5RcYZHJ/Ob6UHHvNNXKdF6Mvnzd2IATghONVU5TqfBzf1z7bQENhaH3sxPjXeB8MD6bCwIA8po
 3PjZCpvBIor3doLDKD7cC9Qv2KjHi3tC7My7hQCL6BrnMMY/C/Z45lJBgZFUw6wbQpac+g5NOKM
 oiT3zleyy+W+z+lmg0mAspTU5tNsPFONcZI3FoJdztxqL8w69EkckJGYORMFpew6qLkVji2PWzv
 NG5RN7f87aZK62Ww0mIr72z67A86OkXSZgLUFq6OorP+Jih0rJbfJuvDT1BBp8kqCcFR68u7C7Z
 tTXmtEBCSdFkIWllBxp+3AUuHKv0AEXpbJ1lmHQSlU8Xc3nNcG5hcRbsDooTJfGNlo0qaaFGrHB
 pVeEOkRBzM5qtyFi0P0O7mE1W7oD7SQYGugm1hxLOz8xbe+vAKmDlws+eT/ziHLKoiCdZ6Rg/gE
 PB03KovgmubNbGmgzmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606060111
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

Add SPL defconfig for the Lemans EVK board. The SPL loads a FIT image
containing TF-A, OP-TEE and U-Boot proper from the "uefi_a" UFS
partition and hands off to TF-A.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_lemans_spl_defconfig | 104 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/configs/qcom_lemans_spl_defconfig b/configs/qcom_lemans_spl_defconfig
new file mode 100644
index 00000000000..06626e27323
--- /dev/null
+++ b/configs/qcom_lemans_spl_defconfig
@@ -0,0 +1,104 @@
+# Configuration for building U-Boot to be flashed
+# to the uefi partition of Lemans-EVK dev boards with
+# the "Linux Embedded" partition layout (which have
+# a dedicated "uefi" partition for edk2/U-Boot)
+
+#include "qcom_defconfig"
+
+# Address where U-Boot proper will be loaded
+CONFIG_TEXT_BASE=0xaf000000
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
+# SPL configurations for Lemans-EVK
+# Purpose: Load FIT image (containing TFA, OPTEE and U-Boot proper)
+# from UFS storage and jump to next image (TFA)
+
+CONFIG_SPL=y
+CONFIG_SPL_BUILD=y
+CONFIG_SPL_FRAMEWORK=y
+
+CONFIG_SPL_TEXT_BASE=0x1c100000
+CONFIG_SPL_MAX_SIZE=0x60000
+CONFIG_SPL_BSS_LIMIT=y
+CONFIG_SPL_BSS_MAX_SIZE=0x10000
+# CONFIG_SPL_SEPARATE_BSS is not set
+
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_STACK=0xD7300000
+
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xdb300000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x10000
+
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+
+CONFIG_SPL_DM=y
+CONFIG_SPL_OF_LIBFDT=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_SPL_OF_REAL=y
+CONFIG_SPL_SIMPLE_BUS=y
+
+CONFIG_SPL_DM_RESET=y
+
+CONFIG_SPL_CLK=y
+
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_DM_GPIO=y
+
+CONFIG_SPL_UFS=y
+CONFIG_SPL_UFS_QCOM=y
+
+CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM=4
+CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR=0x0
+CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION=y
+CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME="uefi_a"
+CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM=1
+
+CONFIG_SPL_PARTITIONS=y
+CONFIG_SPL_DOS_PARTITION=y
+CONFIG_SPL_CHARSET=y
+
+CONFIG_SPL_PHY=y
+CONFIG_SPL_PHY_QCOM_QMP_UFS=y
+
+CONFIG_SPL_POWER=y
+CONFIG_SPL_POWER_DOMAIN=y
+
+CONFIG_SPL_LOAD_FIT=y
+
+CONFIG_SPL_ATF=y
+
+CONFIG_SPL_REMAKE_ELF=y
+
+CONFIG_COUNTER_FREQUENCY=19200000
+
+# CONFIG_SAVE_PREV_BL_FDT_ADDR is not set
+# CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR is not set
+CONFIG_SPL_ATF_LOAD_IMAGE_V2=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0xB0800000
+CONFIG_SPL_FRAMEWORK_BOARD_INIT_F=y
+
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_MISC=y
+CONFIG_SPL_QCOM_GENI=y
+CONFIG_SPL_MSM_GENI_SERIAL=y
+
+CONFIG_SPL_BANNER_PRINT=y
+CONFIG_SPL_CLK_STUB=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_PINCTRL_QCOM_SA8775P=y

-- 
2.34.1

