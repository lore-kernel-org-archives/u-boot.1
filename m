Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D16CD8C9F
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 09:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7C8E846D3;
	Mon,  8 Jun 2026 11:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dep/3iJU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AITZ1RhQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F498846D3; Mon,  8 Jun 2026 11:07:27 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7BB8807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 11:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586OlYj2801806
 for <u-boot@lists.denx.de>; Mon, 8 Jun 2026 09:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QDLdJf1gY60vpc4xqKEN1MR4VOMfVONRjiG050AV5pA=; b=dep/3iJUVz//wP9k
 Dvyf839RPBaG13Rp/27CwpeWEWw2MrGK5oKAxA2ben3o3+EAtzR/NH+aOsFCjTGz
 vpDTO7H3KBxDHTp/CyTn7ySjPxX6gDDiQkSodU/7Jk9WJ6pmQVU6oP0WrCNb3nnw
 xrcY8HUNigflIBIyg5Drjxett6GxxAyJHy8werdqdacipgY+t1uYEIwhpH2adW9/
 loA8CxeEOjYapeh/PPTw+vP5uV/D1UeeI+xdEyjccab34RONn2/YjC4ZdUwNV7WV
 AjrTeN0hbXBRz68W5wmbH63giEZc05qn9CoROw7ykTjC9hH51AKzhmw4f3zCsO0Z
 4Q25Rg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em9k3qd5m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 09:07:23 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2beff6b6e74so42838705ad.1
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 02:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780909642; x=1781514442; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QDLdJf1gY60vpc4xqKEN1MR4VOMfVONRjiG050AV5pA=;
 b=AITZ1RhQIO9EGMxJxiJt6NQsNo0dnTWDzQadoG5mGsYu/NJ6/QL2jRtPxLnNlYPnrH
 n6i+E5UrdD65y4W3/IjVOSJsGC4A0FQlgFZhMyO77eoAVVOMDJ3FO9jIwl1P6rNTeQ8k
 jRZFcVqc6wXYVy5HPzSpVFFhA3ScSxpSTNgkjGfsqzxtyRVyWAOVFjQa8/GbZtiebt4t
 6pKNLAp26H3Z2JOaTtVqQfMdmWBcjDVnmTWKXN2cR/AZqcALNtfG1/yMAEhCquLD18tY
 PrFpOGP+RqeCzNgLvI8ILnO+ZW2XqombBTBcW3fbbV4Cgn9KMeylnm8gG6TM3/6HTjet
 j31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780909642; x=1781514442;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QDLdJf1gY60vpc4xqKEN1MR4VOMfVONRjiG050AV5pA=;
 b=syfrN8ktGVR1uP3Q1o8YS5xu1kVA5FZxrRhU6uvp7pEZtbffyNPaIIuLu0zCGypYJX
 Npv5wTgAfupSQyMb8ra785oZFBGV/sT+YtGPxtJTUVqeN30YLxBXgv9hJAzP8qhRkgRK
 w62Tm1t7HdDyPok2G/cs7lzHYa1Q83gbzzi7Iw27xqUzcy6bauuYl2DB8960ZKiVK45i
 5kZcaUabOeQflTbOY1i2TGP6N4oAo0fgqebA+hxsIGeUdplUMcN+JfzgJb42LuN38Ets
 YH+esx4KCdiXm3ZYvkWSRZhJsIY+m2HAHQrKsy0Q3JBi01RzBpwf5C2iTyLmbr/9ZGZ0
 dEzg==
X-Gm-Message-State: AOJu0YywoUhxJPB53/1GAFX9MnCC/+W/TDPW9bY9fCHdJyrepopZndQG
 O9BIe7JjrW2hnZoGCvGczXpKRnpB2rxpqai9wMQYnPWRXRe9oDgGhikevgWCzUNMAiSKzrPwKzs
 fKSYYVzHdSLqDae9hrIi3zIZ+hBKzR0Z+nR3BCWzNLUsIQgFBruDJqaew
X-Gm-Gg: Acq92OFptA2SmRByO/rZjQjIScPuk+SoqgDQ+00ZrKE6xeYAQjbEly3D6M2AaA8vJ9J
 XRRkKebXi+z4IqgKfbcHwBknZR9uvMxCbt9oG92uc3jl91vpurRdukXp1L5UUxCTb5ANI/USE45
 FozooXSuyl8dZAUARfdR5RKto+quvd/vmpWMD5w6mg70rkRWFqLsAVv7NTXBAh1lwvj/eaX+GLo
 wNFbIcOo7JhGYDENQRMYrSx1X0AZcMVKWyqgLNzkSP4gIHMrb5ahPtCIqMW5UM7d1VWJY4mv42v
 9ubi3ezJ3HN1gPq7DojEBgapptq7nkZYBOYDhThqGps8elOpFQlDeCmbAW9XRJc+uZDuac/CZ1B
 w5BeyIwQIOhJ+IRYmrnq6BFg4ZS6tvGb1wlIXDTSoyNK4iGhKcUQOAXGao6w48PUHtoBSlU9mS2
 jqQBSgfSieEgInDJ/Q66IYcXtT+CcRfZ7XvLDfblh67VGhZE2eNCA/SvtDNIft
X-Received: by 2002:a17:903:11c6:b0:2b2:4d36:7ba with SMTP id
 d9443c01a7336-2c1e77c89acmr171642255ad.0.1780909642166; 
 Mon, 08 Jun 2026 02:07:22 -0700 (PDT)
X-Received: by 2002:a17:903:11c6:b0:2b2:4d36:7ba with SMTP id
 d9443c01a7336-2c1e77c89acmr171641895ad.0.1780909641686; 
 Mon, 08 Jun 2026 02:07:21 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f8679esm169309335ad.21.2026.06.08.02.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 02:07:21 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 14:36:32 +0530
Subject: [PATCH v2 5/6] configs: add qcom_lemans_snagboot_defconfig for
 Lemans-EVK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-snagboot-v2-5-036bb0343bf7@oss.qualcomm.com>
References: <20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com>
In-Reply-To: <20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780909590; l=2188;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=K62Mvtw0XKf7/CdtLTrv6JrC91lwF8mVyKfhz7gIIXA=;
 b=ze8V3+kgZzWTrOyTNc4tA29CC6iqvVeyVe/EDm2vbOBpVqm5jz1hghMpaaF+cPyH3REg00ufc
 HTT0Bh0/MEpDHglOrKhgvMcq4FulbLTiepHNjStnrX8iFDRSNrzEB0Z
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfXwuHdPeJNckBL
 QeIid0yal7Og8XFkh/bzm3QOQX4srEv//eJ+aw+AxzKFPCjcAytMdysh2srqBDW1rnlzX1vRGMP
 4BOVYPqM7P7nyw0fSbAq0vu+j4ZX5FO04p2jO6SA8uC+ftCbxqwK81CkVgpqMybeXTvHz47bUaK
 AfO6ky3iUYlCRm7BR9CgCZsRdvbuFBFD8HvaeXZiQFaESN7uQWOGhxgjYMnrSPdWgwloV5v5eCm
 OYpUjcJZqsVnxe7bJwiyPrDc9a+3l56URdfRILr6DMbnnUPGw2pm0BjkpdRMhmVAxyutbAjvVx8
 rD91GXTtWlm2JVEf1LX61Hgm6xV0Lntn+vME78gwABc+Ogi14C7j0B/9yGcRpzHNz9akBnwSNm+
 uJqMSTjKV5bUs3tw9ECmyYJ0sV8bHdWD2QxJBt2LJ3lBijzC0MLTon8bvA8ZY0+jqvh5QC0iywj
 WHKSFnjAI83awpZWsLw==
X-Proofpoint-ORIG-GUID: g3fu8O2Z9io5twtDA8QECmz3Q1rmNtHE
X-Proofpoint-GUID: g3fu8O2Z9io5twtDA8QECmz3Q1rmNtHE
X-Authority-Analysis: v=2.4 cv=TIB1jVla c=1 sm=1 tr=0 ts=6a26864b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=jnITjcyISYIG4jffwgEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080084
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
Changes in v2:
- Newly introduced in v2
---
 configs/qcom_lemans_snagboot_defconfig | 49 ++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/configs/qcom_lemans_snagboot_defconfig b/configs/qcom_lemans_snagboot_defconfig
new file mode 100644
index 00000000000..4b3bc41d070
--- /dev/null
+++ b/configs/qcom_lemans_snagboot_defconfig
@@ -0,0 +1,49 @@
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
+CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
+
+CONFIG_SKIP_RELOCATE=y
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
+CONFIG_QCOM_COMMAND_DB_OPTIONAL=y
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

