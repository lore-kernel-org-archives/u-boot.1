Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73914CD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9AFF848A2;
	Mon, 15 Jun 2026 10:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h3MQpjZa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AL+WBmLx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5524384895; Mon, 15 Jun 2026 10:49:10 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2700184895
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 10:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F7U3f34091542
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 08:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OlnOkiGHsn8lHz6LFtHCWFFJR63GekZLJsFdN7jWWsw=; b=h3MQpjZaiXgoi6BQ
 01BjU9lNdanTDoROtIAi/SipyY3x5n0PpyF719wSOWQ1Okvyi5JW1nozQz//OIb/
 IvoLkMq7r3zYlNaNyFA55xlDvZ4CDkEUCXgT5R3fImB9+19j7Z/y7MCW/iytDBXd
 88ouCv6wNxZXk5l1i1bHFdE3GBiopRagvX/DHo9oqzsYrfuuCU529v9wBJwzZI13
 ffq7wnuUsXKX11hzGpSOZFG/xC7oqOlMPCTz2LASzLWjj8h1iZ03lcGX9yXPOrc/
 iSo+urmM83kk+gAVABhL2N217dqGcofFxiRoKqryLB0A/WiPburZNjhDEginUxjG
 W9Y8OQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etd2c8a7x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 08:49:06 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c85a3669a15so1642254a12.1
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 01:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781513346; x=1782118146; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OlnOkiGHsn8lHz6LFtHCWFFJR63GekZLJsFdN7jWWsw=;
 b=AL+WBmLx8yOTy8AoGYE4/y2j1th81ORju8gO8ATAIltycJuSiy4AW5mIylk8q1A8D1
 cp/Q05BdCpiRGrJGrOdfXFaKiKLKMNYCI7wehphG0+3Bo61Efo9jr6P996bwiWCridu7
 bhHzmipkPxb6r+Nu50SVY7HXrQ28QEMUhCGjbWaLsJHHAs7EbjF1x0wG/Ltb0Dia7Szr
 fxvGJ0bs315Ty7KBssbLzhxBMbcfEgYBNx/xs5qYy4qPWae8YaoU8GyFpENnokjR+MPS
 +hefK0PR7q3MoJcacgS2IpfKm4oY0oIhIYcjuZjEKkZ7Ud8QveErH1gg+5jLFuUVSmJW
 RZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781513346; x=1782118146;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OlnOkiGHsn8lHz6LFtHCWFFJR63GekZLJsFdN7jWWsw=;
 b=RvVNkE8CUjxrquYQEYx8sWps0Hqzksb1kMfusiBY/Ophdd2nj+ApGM+QRbaGaK7g/h
 SzaAYSAmIIUotHQcmCwK6u4E8pk4ctEaE7FUiEGZuVUlS2HPjyMYkIm3uAvzqwkEt4+u
 GOsnxcpbpxzLtMUy2BmKifoB95IJMdEuP6Xp1PtdLyknTM9U1m3+GB0ASODfVuJRP9Bb
 EukBfcM5D9ep5ugmAdeW9tghpSRSkdsRp6ntXYcGhSawKIqVUB/KJyzl8X+UgfCjcoRW
 rw0uEYstZY4E0u2Dbtj+6FJFMUtTg61bhnkEHTTXwZVJFr62++ZxjcFJ0KSC+X583p3B
 0ukA==
X-Gm-Message-State: AOJu0YyK7YQLkLMaUQmWKf3ShhEdUlc1cCBH7KEKhY7XJaHrzRVnZFXB
 btfWB+hKrl1Gbz/zZqmGlTXfyiBpXm3nSAjO7G3/3EalGdszvLYoh1o/yJjE7QVRZlAri8XAJt6
 XteAzvQ021E28xn9X9vbYR1QO4KFxCPqAydv03wa3ZUDQcAPkv/IFwdu2
X-Gm-Gg: Acq92OENWeTTpy5dyRtxGtt52a4biIGx1q9Xqt/0q9NEQcFErBtSpLFBgj5uG4ha/Nc
 jgfnpM6iffk83p4wX2HV/1kwSW+bdtIoYcNXhiVl8idAgBeAbnxGtaKaB3J7t2vI3Kmjc2gwryv
 MaO6wY6+utDJRw5mUIzRkCy38sVGaByW8cFGfc/GPCk17o3hd3BpO/xaCPqdjLNB5AV1vQe+OUo
 iYvdKbyfbDwEy06IFzHX0nKT/gINLJeV/WI8KA33xprG/0gxYXs4RiveqNOrUi9ZB91NJXppWlT
 5NjEcGxuXyT40V4KmzdfUFWpb92LQac4CIyeSaDLDfz87Etf/djIpJ1wZXiKHqpfVivbvxf+JB1
 OvaalOjIcQU1J1reGvoZx4zl1YLEJi5eBdgS1i/4hV6C586bKJxIKehEN4tpQQbIe5exfBs6c80
 61+aya43HGb+yvu9iq3VKb+Fr9FbfpkyLfSVFCIuqXVXybJY+KiA==
X-Received: by 2002:a05:6a20:7f83:b0:3b4:702f:36a4 with SMTP id
 adf61e73a8af0-3b78164e831mr13139829637.28.1781513345638; 
 Mon, 15 Jun 2026 01:49:05 -0700 (PDT)
X-Received: by 2002:a05:6a20:7f83:b0:3b4:702f:36a4 with SMTP id
 adf61e73a8af0-3b78164e831mr13139803637.28.1781513345042; 
 Mon, 15 Jun 2026 01:49:05 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866325d1d3sm8014848a12.11.2026.06.15.01.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 01:49:04 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 14:18:53 +0530
Subject: [PATCH v2 2/2] configs: qcom: Add qcom_lemans_spl_defconfig for
 Lemans EVK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-spl_lemans-v2-2-d15746f4a64c@oss.qualcomm.com>
References: <20260615-spl_lemans-v2-0-d15746f4a64c@oss.qualcomm.com>
In-Reply-To: <20260615-spl_lemans-v2-0-d15746f4a64c@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781513334; l=3398;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=0uiCnzPDY5RUusYPwaf/ewEzLHiz/I9vbcjpnCQj7fU=;
 b=H5wp9fmrtYOYr92Uvrmh/JpqisZlu3gNqIiAmTzJzIeCNZyBXRJmW17lTVFWh/4ui9br1Txxe
 hBpCvdxRXcrADpUF80aneJi7E3AhCMPbdJxkCnMmRIJAM2eSDIzm4T4
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5MiBTYWx0ZWRfX5XwSCP5Fb6KI
 1tRfn8ZB9o1SByiKR0lk/2Ab2T7loCG8tY9WoKaXmgNBexyyxX0KcibquDFd28c6eLO9S5g3nfK
 hfk3h80yRd7x+8Ljr8qHe7ZzsaHrb54e8DOby38Npo6y7vutkoqqWnqgyZxjQFi9y7i2HDmAxgf
 PD892YBNtdccouynyf22B9O5N32dTFKjUxuUQs/ZtOKGMHorBcRO1dbol+u88KT38JI9aiIzMI/
 bL3Be1IFsrcZm6sKIYL+lUBdD2mgbB+AU8zpPKvEcw1PPJ3n6UKT3dEalhPcaF+iiSRtFvRnTnD
 2g44sbG1HtHHxalquTpfyToIwdPh7Vmx1tGuWXXTLpqpxsPCU00sIfVCASJ9p0StS2itNajnQE6
 H8dnGI8+BtLMZU7CW8plTO5U2gqhid4NirMM0GtQzz4xU6j5JF5N2iuO08Lty9+lZQuq4QCJkwP
 5/Ltnb2/Sd+O6DyIpqg==
X-Proofpoint-ORIG-GUID: R-1fYE_xAynEzVzPEhsR3obAW42_fZBV
X-Proofpoint-GUID: R-1fYE_xAynEzVzPEhsR3obAW42_fZBV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5MiBTYWx0ZWRfXznWg8HrCBtVj
 jzl0dVkaxSJlMD3XzVaoStwg3pPU6DbiOmaiLn3gRvS8JurIoYydO7MBrAv76WTP8u3UNceELGt
 HfKok0tHkf17LkqbZxst6EeyMJxVyrQ=
X-Authority-Analysis: v=2.4 cv=MsRiLWae c=1 sm=1 tr=0 ts=6a2fbc82 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=MIDpp_XfdsXPtEUIc0cA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150092
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
Changes in v2:
- No changes
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

