Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19068C4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 395E884974;
	Mon, 20 Jul 2026 10:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T/v7JIrl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VvQTyuyx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EE03847AF; Mon, 20 Jul 2026 10:52:29 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24ECF84A4B
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K76uCe1896128
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=gwUU62NzmNg
 POTZJUgaFolylyheChne1d7KAGjbFROc=; b=T/v7JIrlji3BYEjD+Mfgfm7Iptu
 3UmFAdmIcwdCS2arEXY9CelYu/YV8lqHLsk/Gjyk4IZTOI/xCLBoVPPOOV9dDCkb
 8dnwXOrS09d8+fFW08F88fQY0NWi8lL1Cvrcko2dROdWXnb1lZwmnNyrPKm6dNTP
 ezYbfVTphyUwQIAlTHAAFfqTCxrqd4iSIFVartIOxDW2leuFkRNQ/s61lu+NyoGJ
 SOL/ItAIsL0bzPqb2J7R6RJHGRMSp9xBaNNBndBYyXOZrrAWs6JOp/H4KiUu2AA2
 OiltP07T7rhUOhCSaO5xUutLNfeAL/G8k9tgBZfUuwHSu7h6QlNujMHj+gA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0krdg3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:52:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1e6f602cso141953081cf.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 01:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784537545; x=1785142345; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gwUU62NzmNgPOTZJUgaFolylyheChne1d7KAGjbFROc=;
 b=VvQTyuyx3ja1BfgejmRj1uVlwTQr4sWkUFabEuiHdC7c4dyi3ieMAi+sTZbVo+6AC9
 liBUPm77Jl+DTYqdfUAZHSKieXJK9iYlmDo5pcuEgcipbh4x5dSNPXoBX8OjZeH9w/i+
 QpX4MrKsEcFdz9ajnfIQSkqA4ot35rULrRZcNE8J/ZcgADMGO961XfARvrCwJcjIf58o
 9vUQnQryII6eEL0vpoRIVCDniGYdfjq+sHUJ+54oIjqtWbc83BjeU1ooyXDfMbu/+il4
 MeVxKxHYi5lbD17ge5LMQsPLULUCW/Ke4U34Q+SIylWmAjGN4I6ylnmjQ4CBjuIUJ/Z5
 aRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784537545; x=1785142345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gwUU62NzmNgPOTZJUgaFolylyheChne1d7KAGjbFROc=;
 b=T+s/dWEf0OUxonsgeM0qvl2qo6lbyVxU53BSCIqK2S6fx0Ix7u5jWOy0/9P6Luy2fl
 ZvMsIvYurBo7KjGz/4VqAKBsp3YakStaCLTJvgv1ruGH9PHItb6ZqHte9WohQdjf4CGS
 RfDJiFORlE5TDm1rVFJLX8fcQlhyy7cweGC3CHjy6Pa1V8qxOl68vQ/51kkBp3ETcS0U
 sYUKHi1xmuCOA/oPH8ELbYmnySGPWHwJo4lbtHzyM3DcvJyBUboV5eR5B4fpKBa3tS3R
 FixG4+WwoAw+HvR2P42wyIBIVQr1UzWojtp/Q6p7Wnii0OfAPA9673dRDl/R0EEK9bm/
 7qvQ==
X-Gm-Message-State: AOJu0YwzAhm10xBNT8WcckeHhi01Df6ygTLjJpFUyeh6NX7UETjjr8Fp
 I/HBapWY1muT6i6S3yh0Wz0Wcyhb9Lp31FM2NBOWWWe7is2SvWIqJby+xlLjooZJnzVAq7EGUPH
 Q+dfaDItIMJ+UrcPq97tj+LM0GTNF7HRjRyFxjf/vPU2qJ0krNuuaIW8nFR6JNWBI
X-Gm-Gg: AfdE7cmngnzmwBp1JNDSyDe7RA/rW0O0/7hC4yXGlstGOgI6WWRKvrZLJ3SdVg28VFD
 8e3CDuv/OaixKWOrcYkBvOOARLgh2h3bg3fklVrz5sIw8P9dpulqucAL39vwMWKU6Z5Fij8rndW
 dqWIxsPRex1C2LZcjBaU9WEUKmCIqSIXM7LXJGK+Cd72HqGWxAHfIPMZ6lO+9h/KcvUunAJIcZe
 I6x7kypYSoz8gB0lPQDr2Z916VslEMad6DJVmbdUSyGJcc52wcR2PsLp/XQqvP8LS7k9wt4I7PV
 wCRrdAWR4u4eGloJiN4IonIO7nCx4zgwAOKxfy6Tc7M8GX1UCrs69gt7052QJpB0Fq/UEtU38D3
 7o//JVoyq2TlUatbjwLPOglDuClwgsnSQ/KvSQst9Lbf7ocLiFw8=
X-Received: by 2002:ac8:5a86:0:b0:51e:a44f:c65c with SMTP id
 d75a77b69052e-5214055084dmr122166981cf.87.1784537544919; 
 Mon, 20 Jul 2026 01:52:24 -0700 (PDT)
X-Received: by 2002:ac8:5a86:0:b0:51e:a44f:c65c with SMTP id
 d75a77b69052e-5214055084dmr122166801cf.87.1784537544458; 
 Mon, 20 Jul 2026 01:52:24 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e499c2sm26450052f8f.4.2026.07.20.01.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:52:19 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, trini@konsulko.com,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, macpaul.lin@mediatek.com,
 padmarao.begari@amd.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com
Cc: u-boot@lists.denx.de, sumit.garg@kernel.org
Subject: [PATCH v1 7/7] optee: implement the RPMB subsystem interface for UFS
Date: Mon, 20 Jul 2026 10:51:47 +0200
Message-ID: <20260720085202.537019-8-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
References: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IAl7nF7jwF78Ipf9l75CLZLwLgysetd7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5OCBTYWx0ZWRfX48QX4pUYgpCk
 on8bjUsoKRTHzgvnrTY9e3X8Gp8a8vfpN1GPuSrZCUNYb0mLOV2LCdup2J5ekxWMk7jVoSV1fGc
 nnu8ld8t1LOLOOVrK7e4I3e7fhJT4sU=
X-Authority-Analysis: v=2.4 cv=G58s1dk5 c=1 sm=1 tr=0 ts=6a5de1c9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=4OB2SniIEselFtn8B8AA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5OCBTYWx0ZWRfX3Xpz6BaUZKNN
 jU/22883JPLQfXky6WOZ7/5b98VDw27Svk7QcCIMXNd6OlFGBXpUa8CLPcW1zlao728iwRU415d
 l5va/IMFiVXNXVu852zuM6ghwxX7n3/vbJs/q/JgIhg5pc0hRsvU+bzvPzqxAfCmMRc2K7cMQIp
 HlCwXPtGE77aZddBJnBg7nX/LzjifZ1E1cd15OVHHEILkt43tS0u6xr0/58pM2PuTZwep5+je/y
 bOO2QuzfXmlVDgM8+bUc/AVI+ACwrJYyZG/0ccgaktjUNal5eT9eVDmDGTjH8f0E/W52ipV/SM5
 0BXy393w4zkDC5RM4Ivrbvbs9Iggx5RcqzUqjHkbaRArhiVuXiJ2yqcRLuynDB0UIpNGcgw+aDw
 zfsWzW1JV0JAO/YoylzuwvUto1ks7rf/HyXuNxZqMEb3wmF/o44XR9Oxb5/OjXoRSRixosoc/df
 sjdui1iKbiaCWZL2Shw==
X-Proofpoint-GUID: IAl7nF7jwF78Ipf9l75CLZLwLgysetd7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200098
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

OP-TEE's legacy RPMB supplicant interface assumes the RPMB device is eMMC
and derives the key from an eMMC-shaped device ID, so it can never
reproduce the key Linux derives for a UFS device; secure storage on
UFS-only platforms instead needs the transport-agnostic RPMB subsystem
interface, through which the normal world describes the real RPMB device
to OP-TEE. Add a UFS backend for it so OP-TEE derives a key matching Linux
and can use RPMB secure storage on UFS, leaving the legacy eMMC path
untouched.

This subsystem backend currently supports UFS drives only; eMMC still uses
the legacy interface. As the legacy interface is dropped in favour of the
subsystem one, an eMMC backend should be added here so both transports are
served through a single RPMB path.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/tee/optee/Makefile               |   1 +
 drivers/tee/optee/optee_msg_supplicant.h |   8 ++
 drivers/tee/optee/optee_private.h        |  41 ++++++++
 drivers/tee/optee/rpmb.c                 | 126 +++++++++++++++++++++++
 drivers/tee/optee/supplicant.c           |   9 ++
 5 files changed, 185 insertions(+)
 create mode 100644 drivers/tee/optee/rpmb.c

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index 8321cf53a19..7af19834c00 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_OPTEE) += core.o
 obj-y += supplicant.o
 obj-$(CONFIG_DM_I2C) += i2c.o
 obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_legacy.o
+obj-$(CONFIG_SUPPORT_UFS_RPMB) += rpmb.o
diff --git a/drivers/tee/optee/optee_msg_supplicant.h b/drivers/tee/optee/optee_msg_supplicant.h
index 963cfd47824..b720d5d7b3f 100644
--- a/drivers/tee/optee/optee_msg_supplicant.h
+++ b/drivers/tee/optee/optee_msg_supplicant.h
@@ -152,6 +152,14 @@
  */
 #define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 21
 
+#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_RESET	22
+#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_NEXT	23
+#define OPTEE_MSG_RPC_CMD_RPMB_FRAMES		24
+
+#define OPTEE_RPC_SHM_TYPE_APPL		0
+
+#define OPTEE_RPC_RPMB_UFS		1
+
 /*
  * Was OPTEE_MSG_RPC_CMD_SQL_FS, which isn't supported any longer
  */
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 1f07a27ee4b..2888257aefe 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -9,6 +9,17 @@
 #include <tee.h>
 #include <log.h>
 
+#ifdef CONFIG_SUPPORT_UFS_RPMB
+/**
+ * struct optee_private - OP-TEE driver private data
+ * @rpmb_next_region:	next UFS RPMB region to report on PROBE_NEXT
+ * @rpmb_cur_region:	UFS RPMB region selected by the last PROBE_NEXT
+ */
+struct optee_private {
+	unsigned int rpmb_next_region;
+	unsigned int rpmb_cur_region;
+};
+#else
 /**
  * struct optee_private - OP-TEE driver private data
  * @rpmb_mmc:		mmc device for the RPMB partition
@@ -22,6 +33,7 @@ struct optee_private {
 	int rpmb_dev_id;
 	int rpmb_original_part;
 };
+#endif
 
 struct optee_msg_arg;
 
@@ -60,6 +72,35 @@ static inline void optee_suppl_rpmb_release(struct udevice *dev)
 }
 #endif
 
+#ifdef CONFIG_SUPPORT_UFS_RPMB
+void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
+				      struct optee_msg_arg *arg);
+
+void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
+				     struct optee_msg_arg *arg);
+
+void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
+				 struct optee_msg_arg *arg);
+#else
+static inline void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
+						    struct optee_msg_arg *arg)
+{
+	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
+}
+
+static inline void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
+						   struct optee_msg_arg *arg)
+{
+	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
+}
+
+static inline void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
+					       struct optee_msg_arg *arg)
+{
+	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
+}
+#endif
+
 #ifdef CONFIG_DM_I2C
 /**
  * optee_suppl_cmd_i2c_transfer() - route I2C requests to an I2C chip
diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
new file mode 100644
index 00000000000..3b3bd0ac12e
--- /dev/null
+++ b/drivers/tee/optee/rpmb.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dm.h>
+#include <tee.h>
+#include <ufs.h>
+
+#include "optee_msg.h"
+#include "optee_msg_supplicant.h"
+#include "optee_private.h"
+
+#define UFS_RPMB_CONTROLLER	0
+
+void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
+				      struct optee_msg_arg *arg)
+{
+	struct optee_private *priv = dev_get_priv(dev);
+
+	if (arg->num_params != 1 ||
+	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT) {
+		arg->ret = TEE_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	priv->rpmb_next_region = 0;
+	priv->rpmb_cur_region = 0;
+
+	arg->params[0].u.value.a = OPTEE_RPC_SHM_TYPE_APPL;
+	arg->ret = TEE_SUCCESS;
+}
+
+void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
+				     struct optee_msg_arg *arg)
+{
+	struct optee_private *priv = dev_get_priv(dev);
+	struct udevice *scsi_dev;
+	struct tee_shm *cid_shm;
+	u8 size_mult = 0;
+	u8 rel_wr = 0;
+	void *cid_buf;
+	ulong cid_size;
+	int ret;
+
+	if (arg->num_params != 2 ||
+	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT ||
+	    arg->params[1].attr != OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT) {
+		arg->ret = TEE_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	cid_shm = (struct tee_shm *)(ulong)arg->params[1].u.rmem.shm_ref;
+	cid_buf = (u8 *)cid_shm->addr + arg->params[1].u.rmem.offs;
+	cid_size = arg->params[1].u.rmem.size;
+	if (cid_size < UFS_RPMB_CID_SIZE) {
+		arg->ret = TEE_ERROR_SHORT_BUFFER;
+		return;
+	}
+
+	scsi_dev = ufs_rpmb_get_scsi_dev(UFS_RPMB_CONTROLLER);
+	if (!scsi_dev) {
+		arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
+		return;
+	}
+
+	while (priv->rpmb_next_region < UFS_RPMB_NUM_REGIONS) {
+		unsigned int region = priv->rpmb_next_region++;
+
+		ret = ufs_rpmb_get_region_info(scsi_dev, region, &size_mult,
+					       &rel_wr, cid_buf);
+		if (ret < 0) {
+			arg->ret = TEE_ERROR_GENERIC;
+			return;
+		}
+		if (!ret)
+			continue;
+
+		priv->rpmb_cur_region = region;
+		arg->params[0].u.value.a = OPTEE_RPC_RPMB_UFS;
+		arg->params[0].u.value.b = size_mult;
+		arg->params[0].u.value.c = rel_wr;
+		arg->params[1].u.rmem.size = UFS_RPMB_CID_SIZE;
+		arg->ret = TEE_SUCCESS;
+		return;
+	}
+
+	arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
+}
+
+void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
+				 struct optee_msg_arg *arg)
+{
+	struct optee_private *priv = dev_get_priv(dev);
+	struct tee_shm *req_shm;
+	struct tee_shm *rsp_shm;
+	struct udevice *scsi_dev;
+	void *req_buf;
+	void *rsp_buf;
+	ulong req_size;
+	ulong rsp_size;
+
+	if (arg->num_params != 2 ||
+	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_RMEM_INPUT ||
+	    arg->params[1].attr != OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT) {
+		arg->ret = TEE_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	scsi_dev = ufs_rpmb_get_scsi_dev(UFS_RPMB_CONTROLLER);
+	if (!scsi_dev) {
+		arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
+		return;
+	}
+
+	req_shm = (struct tee_shm *)(ulong)arg->params[0].u.rmem.shm_ref;
+	req_buf = (u8 *)req_shm->addr + arg->params[0].u.rmem.offs;
+	req_size = arg->params[0].u.rmem.size;
+
+	rsp_shm = (struct tee_shm *)(ulong)arg->params[1].u.rmem.shm_ref;
+	rsp_buf = (u8 *)rsp_shm->addr + arg->params[1].u.rmem.offs;
+	rsp_size = arg->params[1].u.rmem.size;
+
+	if (ufs_rpmb_route_frames(scsi_dev, priv->rpmb_cur_region, req_buf,
+				  req_size, rsp_buf, rsp_size))
+		arg->ret = TEE_ERROR_BAD_PARAMETERS;
+	else
+		arg->ret = TEE_SUCCESS;
+}
diff --git a/drivers/tee/optee/supplicant.c b/drivers/tee/optee/supplicant.c
index 8a426f53ba8..50b780037fb 100644
--- a/drivers/tee/optee/supplicant.c
+++ b/drivers/tee/optee/supplicant.c
@@ -89,6 +89,15 @@ void optee_suppl_cmd(struct udevice *dev, struct tee_shm *shm_arg,
 	case OPTEE_MSG_RPC_CMD_RPMB:
 		optee_suppl_cmd_rpmb(dev, arg);
 		break;
+	case OPTEE_MSG_RPC_CMD_RPMB_PROBE_RESET:
+		optee_suppl_cmd_rpmb_probe_reset(dev, arg);
+		break;
+	case OPTEE_MSG_RPC_CMD_RPMB_PROBE_NEXT:
+		optee_suppl_cmd_rpmb_probe_next(dev, arg);
+		break;
+	case OPTEE_MSG_RPC_CMD_RPMB_FRAMES:
+		optee_suppl_cmd_rpmb_frames(dev, arg);
+		break;
 	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER:
 		optee_suppl_cmd_i2c_transfer(arg);
 		break;
-- 
2.54.0

