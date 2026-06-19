Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6336CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 11:11:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DA0E849F7;
	Fri, 19 Jun 2026 13:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XF9wLYkh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a6Ve1pj1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 066F6847C3; Fri, 19 Jun 2026 13:11:33 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F23C584A04
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 13:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65J7RndZ4001199
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zq7yqvrOJvpdcN91V5MZEwjUgSqS0pYjyy8oakEM3GM=; b=XF9wLYkhbHLvchHQ
 pd09RkTc6kwYGRXBOOnTybKqVKwCLmItfOD8BKPYTOJc9RUhOVMWHWfCM9V3CjwK
 wk94jE94+tRyedqdiY2me3LyvXG9sYYc5orM23X+IqeMMCPRjfTxYcQrScRCFzN3
 o2eHXUBmNNSkQRhOIZykj5CHbF9AUxhEQ6a0tDulu5eUhzIZzGWmXSLgVCyOwx9F
 u+il9AhLt7vIrRetOGubNQ7HtP61HpbUwbdoNLVchUVL/OQVEoiXbPVZ6zYExRGf
 bsyCmMMzbhp1+nijvapsvdg+xhd8hI/RrlFLlh5gYu4sbKZ0v9TFpyMcSoj8+M1+
 DQwiVQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evpyutpqw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:11:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c6bf305403so17900525ad.2
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 04:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781867487; x=1782472287; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zq7yqvrOJvpdcN91V5MZEwjUgSqS0pYjyy8oakEM3GM=;
 b=a6Ve1pj1EF8qo4sfKdg9wXG9crK+cj3NFtNNFYwm4ac1wAN0LvSjQ59P6k0d+oRp+4
 kab1uvLgXKZnTz80QDhdjs249MgSe2QfZl7Jz1l+kHBnPFWI4hrZh2t4vQ2YEWX+OsRp
 40aUT3kCC0Kr0h8SpZzXtiENBS7SaMsLlTf50HmfRYt8FeCl4t+1+juZsb21P+cKL4Oj
 uWsDJQicchrJdcy/BZiZzLQAkdfhiFd4/MUGrf87JtTzKaHbGFhcVco7jo4XfZ0J7Z7E
 JK1Cvq6lg0wJSOowAJWo2Nb6NxdV0UztXVsB2ZOjWftbVkNCuFptjZuAt0rJzBc9qq0a
 4NLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781867487; x=1782472287;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zq7yqvrOJvpdcN91V5MZEwjUgSqS0pYjyy8oakEM3GM=;
 b=IxLJCimFaGdHpZZvrRfVAoZFjBOK4uDP6/yRvGc/bCeVGhVJirgAV14kVK7e3bz6Y6
 dAktwGg+JpGPcaqPh6LgYV6xpehNP1Gr7+/DaDj0jyjikhu3mqw+d9uIktzPhQcUqrZN
 A4eTna4ZjZCXElkfVk8aQ9rqQdX5ZxW5WABwIdo1kFN4/8dduYa+5M6K6r2DJ4QWSnJD
 SEpdJXBrSjC236T5EJEb0X3H8FG2JZuSqASh5+AaYT3b8BgQGwUqc5fT23/D+0f7lbdi
 My7yI18I31a7F/qR609/xnGW/cU54ocVedq0ZfBlB8AjSsjHqlG5St/h0cteV4OvAiAI
 qShA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8x7HwskpnDCrH72nAtiecQ65OgZwwdhKiq4k9WZP/WNETtkAjQF8NicD4QY5IT1lXWEQhxeQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yxs87ew8L+h3gFxHYSNkvCxOai3mGl7030poPrFO/QTJBARoI/n
 JRYhsgu2Bp27wRsc8t79wapT8S4GmwkUnua/zluQf8iIjbHcIymbcGcxVaBTw6S+si0bV4+GghE
 LIFEXPSGdydw3iGkMd144l88pxquz3IUkDrUYkXTF2sK8AQncGMGYRpKo
X-Gm-Gg: AfdE7ckHNelQ83PySoWyT/RwxZV5YYh/V18f/vmMSRRUmBRgPNRi7wo8TBeoz/b7B4p
 zETWpMtcpNw0RB/dXjlJmPX+onxTxsc1zphT0iqmRJoNE5Gdze9DReydIDUgfyLrdKrB9N6B2lU
 FrgADTkZYvImhTy51RBDZbmCxelU4w3JBwHfPtkq6DL9AD7r4LNzZY6goHzkfI8jo7QrIi6ORjQ
 YXltjmA0BTpkBgD5qyICSgoVAQesICGCohnobEqAYupUUJLyimcElZZyVB41c53ncz4SAJjP/Dh
 Ggo3jW8wE+C9m4LYOmRjqdbEB5S0+LAzeXC93RE59StiKCti0BjExVzDtyDyLKQAFl1Nnnmw6NV
 7jotcubDiBfgaiPwaIwV6g25HPhSfsclqDDLgemJJd6AlcuXfhyWq+uv8SBsCgfNsIDAc1rwIgR
 AveLL6PM1ohSMZufccxjAiKBn03s1uMFqv81WNcEg=
X-Received: by 2002:a17:902:cec1:b0:2c6:b3dc:b82a with SMTP id
 d9443c01a7336-2c725d33bccmr22758205ad.24.1781867487335; 
 Fri, 19 Jun 2026 04:11:27 -0700 (PDT)
X-Received: by 2002:a17:902:cec1:b0:2c6:b3dc:b82a with SMTP id
 d9443c01a7336-2c725d33bccmr22757825ad.24.1781867486876; 
 Fri, 19 Jun 2026 04:11:26 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c72089a6b2sm22619585ad.2.2026.06.19.04.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 04:11:26 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 16:40:30 +0530
Subject: [PATCH v4 7/8] configs: add qcom_lemans_snagboot_defconfig for
 Lemans-EVK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-snagboot-v4-7-385497442db2@oss.qualcomm.com>
References: <20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com>
In-Reply-To: <20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781867429; l=3289;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=GvIOA+4vvDN/A9YgQhj97RzXkgGbnZmzLG52wMbyRJk=;
 b=rbl8QnkPsVKSlvsfbzGd6xJLkL8eYSjSukgK5Pyyj7jyaKyREAzJ3rT+qecHju8Xdd9ulFtLu
 lwgUofSZlfdAAH4+7QyrdALrXs/yP5JYuY2coM7O+JudAOzb0GLbYiy
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEwNCBTYWx0ZWRfX9ivPov+PtoXI
 Q3FnLYgiP0PaRxN3phaniA8TSd3Ev6upO98eP+uOMEr5B5PSkVij0b3QgFHXYh8K70sK1XUnqmw
 fU9zsYobVmdv1PEHKz2PbAR5pNUkPzk=
X-Proofpoint-GUID: P1RJ3nfCPVLt23azb8EmtQ2Q-fazghx7
X-Proofpoint-ORIG-GUID: P1RJ3nfCPVLt23azb8EmtQ2Q-fazghx7
X-Authority-Analysis: v=2.4 cv=cY3iaHDM c=1 sm=1 tr=0 ts=6a3523e0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=BuiL7dxMnaOT5FYPNy4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEwNCBTYWx0ZWRfXyqro4EvRR6vQ
 vVJNJO2OJF55GYBh+ySm2yIyFq4052iPGuPMe2xhCJXUTR9Z+WQlRp1LSSloV1BIl6wnKsDIRH/
 YT5iufmvhkU/yq7FkpxX2M0AKew2Az5ycEZx96oBSu+fd1DF+2XGcosgmscPxKYHhB1IbNMHFNn
 9ThOqTmyUPIKE+6CRrWD4RjaXsSwioCk5NfRAUsng2dGZhzEou/8FUqEnEASF3/+8CXjbm0VSBS
 1lBEdLoW+eKihDML7ys7zxz9Kbt6rX5u0JG83EHW+UQSs8fZ1maDHaLjfqlHbGafSciVhM2qlpM
 LwhlHqSTTvnqpMTwzDEErx0nleF9dWqh2nrGXwnNCGnv6l1gGBpxtSANbsIOha1AIVsx05MOvVO
 woB4Ti15+2hVp5PzcYbJrT+8g0hkRvF81Fl32RBvE3+flSEmmxMWs4qO1Q7xUWuaVdZ6Rg23YbT
 YzaBHlJ1NtImE3q1OPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190104
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

Add defconfig for booting U-Boot in Snagboot mode on Lemans-EVK. In
this mode, XBL loads U-Boot directly into DDR and U-Boot enters
fastboot over USB for device provisioning.

Create a reusable config fragment at configs/qcom-snagboot.config
with common snagboot settings. Platform-specific defconfigs should
include this fragment along with their own settings.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Use CONFIG_ENV_IS_NOWHERE
- Place Snagboot related configs in seperate config fragment
  called configs/qcom-snagboot.config
- Include above config fragment in
  configs/qcom_lemans_snagboot_defconfig

Changes in v3:
- Removed enabling QCOM_COMMAND_DB_OPTIONAL, ENABLE_ARM_SOC_BOOT0_HOOK
  and SKIP_RELOCATE as they are now automatically enabled by
  QCOM_SNAGBOOT_SUPPORT selection

Changes in v2:
- Newly introduced in v2
---
 configs/qcom-snagboot.config           | 33 +++++++++++++++++++++++++++++++++
 configs/qcom_lemans_snagboot_defconfig | 18 ++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/configs/qcom-snagboot.config b/configs/qcom-snagboot.config
new file mode 100644
index 00000000000..d19ad453029
--- /dev/null
+++ b/configs/qcom-snagboot.config
@@ -0,0 +1,33 @@
+# Common configuration fragment for Qualcomm snagboot mode
+# Include this in platform-specific snagboot defconfigs
+
+CONFIG_QCOM_SNAGBOOT_MODE=y
+
+# Disable configs that conflict with snagboot mode
+# CONFIG_PSCI_RESET is not set
+# CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR is not set
+# CONFIG_IOMMU is not set
+# CONFIG_REBOOT_MODE_ENV_UPDATE is not set
+
+# Use default environment instead of loading from storage
+# This ensures snagboot mode works even with corrupted environment
+# CONFIG_ENV_IS_IN_SCSI is not set
+# CONFIG_ENV_IS_IN_MMC is not set
+# CONFIG_ENV_IS_IN_FLASH is not set
+# CONFIG_ENV_IS_IN_NAND is not set
+CONFIG_ENV_IS_NOWHERE=y
+
+# Disable default env file to use CONFIG_BOOTCOMMAND instead
+# CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE is not set
+
+# Auto-enter fastboot mode for snagboot
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="fastboot -l $fastboot_addr_r usb 0"
+CONFIG_BOOTDELAY=0
+
+# Fastboot configuration for partition flashing
+CONFIG_FASTBOOT_FLASH_BLOCK=y
+CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="scsi"
+CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=4
+CONFIG_FASTBOOT_GPT_NAME="gpt"
+CONFIG_FASTBOOT_MBR_NAME="mbr"
diff --git a/configs/qcom_lemans_snagboot_defconfig b/configs/qcom_lemans_snagboot_defconfig
new file mode 100644
index 00000000000..d6906c1e501
--- /dev/null
+++ b/configs/qcom_lemans_snagboot_defconfig
@@ -0,0 +1,18 @@
+# Configuration for building U-Boot for snagboot/recovery mode
+# on Lemans-EVK dev boards.
+#
+# For normal production boot, use qcom_lemans_defconfig instead.
+
+#include "qcom_defconfig"
+#include "qcom-snagboot.config"
+
+# Platform-specific settings for Lemans-EVK
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0x1c100000
+CONFIG_REMAKE_ELF=y
+CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
+CONFIG_DEFAULT_DEVICE_TREE="qcom/lemans-evk"
+
+# Timer frequency for Lemans platform
+CONFIG_COUNTER_FREQUENCY=19200000
\ No newline at end of file

-- 
2.34.1

