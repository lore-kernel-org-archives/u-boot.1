Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E0AC44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3197584659;
	Mon, 20 Jul 2026 10:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kr0CcXMJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ORrvqCDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C391C82991; Mon, 20 Jul 2026 10:52:16 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66FFE80517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6RZkI1506405
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GR4Ch0R2XKe
 r0ltMHZXWNZfenRjumzbIAp/z7DcO0O4=; b=Kr0CcXMJUTFRedF00YGY6VTJWvm
 o/UCK0dccWg2dxTwANlbn6vtn1isBCkf0lLkSvLfIJHqZUKIMAj9rVqScdyxtjP+
 aFTAZdWuD+oI+paFoZLuj+CRGvPHHs99D//Cuv8WfuvMqLL/WAAN0xcbbH9V7cho
 k1gwX+MySB8gEW5P2Re3F6r1Q7S6KJiQQtlOjdkUlKC4Ju70A/0pLWpFQ986GVuU
 cSJcGP/1xr6lbVUwR2VsYhGILq+3SP4OnUD60ApbA8LvnskJZjGVU/9PC8wBwdH2
 d0FCXB8zwacgLEBnbvnEPBGy3Ino3O43c31yPeyEfuHTwkJRW9AFfIsyxRg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bvw93j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:52:12 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90410c668adso201262916d6.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 01:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784537531; x=1785142331; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GR4Ch0R2XKer0ltMHZXWNZfenRjumzbIAp/z7DcO0O4=;
 b=ORrvqCDJHudZWETRUvxzFNkpXdZXbmqOUAPMUj34Ne9gwAFdYpuT2M5Np3Wh4TbIhI
 VXDUDEcYKCtN/KuVpsNG1Ehl+qKaK7Ojoz4Ne+GGA1FmutksSp5j3M/t/MvbFxQZcNLC
 q93Q5lvhVJC6511TXmNRlFWeF4wm4rAqG6xHdynKIzawnqrXNs8A7Nhxy1pvVvJrBBLU
 TXHAg56ziecwva5iRrkUk5QEcNvBXSjqzMuDZUGnCRJRrS7/WqGLtn+Ylk9Y/ceQ+ac8
 /GUWtCQ/ANNvi97T2lFV9yoA0yXHhlcgmo1ttcMONEHkEP8pjP5nsNnsuXcn14LaXaZo
 7BMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784537531; x=1785142331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GR4Ch0R2XKer0ltMHZXWNZfenRjumzbIAp/z7DcO0O4=;
 b=hTQ4w04kfvSZXLNMtN/oZCwvsRnPoVvbmX/UMQL4iMIOOau5yBthNWh6aLrLnlu40l
 hL7Vt8qRjgnzV7tOLp0LTyBjtgM9G/jtzouP9ahiZ/7B66J+TQdbBM2D7uphXDHjCQrZ
 i/rHVi57Lth73TLfnVmSHRZKJ59tWK+SJuzZOpjNnWLmmpQqfidhiw6b7/oJOV0rcee8
 hzGnGdyEers3fAnqblbGy3iLRmXx++teYXovMfxIdZEfL1sdZEPX6HxLHIhFJ/zajyH7
 pGCJy4FOzw3C3mQoG8y+OaYygiDMdcWAyWS1D8XnS0aASpXmR8lgjoYAWoKxPoMiw8TW
 X/8w==
X-Gm-Message-State: AOJu0Yyzzhu11WacCQ7CivjLQKEerXFQwRa/HRb0x/MWjIe2+or9sX/W
 jqBMsEcIKoWdfFGncyw5xsF5RVH0rLAvkpYuqLelverKH8m0hWMUxRPnCTFUVgwJCceboBaWGWZ
 uo8aEdWXqoSBbS5GSR2rrzWqJGXPAg3L5xh3LEguucNGm+oG1eFXMIqxq
X-Gm-Gg: AfdE7cmldZuJKpmPUWiJ9WxN5h+AUnxLiYV4QlObFqPz3HjZjoq24sNgNDmVu30AEbw
 3ENTARcm5pKbCbp8KtDKM+3YgY160wyHSwDcqAvDolsy5975++QqyJMDo5zyPBlfByk0uGhSBlv
 jV3ugwFWMCWxhQyB85o13oHPZ7zGpQQtono5ssbCAH/1IojcFsi2MCjbBDTkbt1DS1QtmWVHEGg
 xWVxcYUJj/gRLB8KECZybsJFhNQaqmHf4Qb8Rl+NsfYGCYovtjb9RWwOeYb2oPngZeNNir+XsWg
 tDuQQwHvNSsQAHvgEvBUOQ2nfjDJAgeQ2HbtrbjBQEGCgzabDAjg7XrkfsHKraVI/Oqr1Ksh7BX
 4pSJPzT69rx6ixNPcigOJA1wgyeEqnxPxjbMauMDipBU/YB8TuqY=
X-Received: by 2002:a05:622a:208:b0:51a:8c9c:7f51 with SMTP id
 d75a77b69052e-5213e67fed1mr123445631cf.68.1784537531274; 
 Mon, 20 Jul 2026 01:52:11 -0700 (PDT)
X-Received: by 2002:a05:622a:208:b0:51a:8c9c:7f51 with SMTP id
 d75a77b69052e-5213e67fed1mr123445541cf.68.1784537530849; 
 Mon, 20 Jul 2026 01:52:10 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e499c2sm26450052f8f.4.2026.07.20.01.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:52:09 -0700 (PDT)
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
Subject: [PATCH v1 2/7] ufs: add RPMB transport over SCSI SECURITY PROTOCOL
Date: Mon, 20 Jul 2026 10:51:42 +0200
Message-ID: <20260720085202.537019-3-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
References: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KV4zTxrEG2FPhhN1nOhzhIB83148fNmV
X-Authority-Analysis: v=2.4 cv=EcH4hvmC c=1 sm=1 tr=0 ts=6a5de1bc cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=oiSwwY7edkvY4YQpmvYA:9 a=O8hF6Hzn-FEA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5OCBTYWx0ZWRfX3EAHKx3XQfr2
 TzDXBhHA4AYH8EPY7KFbsz4th2Q/KzMSX2obe/ponW+d/3LSXxq6CGlUhJVEcJ98nYGQNDYx9ul
 HbfaGstRyUcziBS9ilfM9GOWXMhwcNQeONugGB7gETOkzsbBDpTojmEGKXRiehUQ9jiqji9jqNx
 6x+7N8Oz32PoFdRRH6lL6urLmPgOdLPvLeWVE6o7eyRpzCfZZ7rT/C+5M5qZio0ggo3gqiF4M3t
 KwiMqv6dWbJp3OUv5whWLqCo8GKpEDhOBZW9RBF4gv44Z/rGUhj9f1NMVnSaQ5Ess2bOr1n1DJT
 RYseE/LEuCwfvxERshj9e3BfsfuYg0obfegDIvzNjN+g606H306OhmkWVbMH+2xtV9F0x7OI60W
 FiOLBCGb88A6RJj81HsGm9bTrg4TredY99PXuyVaVxPNwuIP5ZiXh9T3ZEIRoCXMqv98Xf+8j0n
 afF1TqjMeytoqMcSa/Q==
X-Proofpoint-ORIG-GUID: KV4zTxrEG2FPhhN1nOhzhIB83148fNmV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5OCBTYWx0ZWRfX23nhCdOeYudV
 J+d7SdyooIThSlSsqr4HlWIuytERHqCS/nxBhnkBd4SpUdr5nq+HF0bMPcPU7DcqiYINow5R3y/
 9XMbopAoQU0pH0DjmABeCnwTuc/C9xs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200098
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

Add a UFS RPMB transport that moves fully-formed JEDEC RPMB frames to and
from the RPMB Well-Known LUN using SCSI SECURITY PROTOCOL IN/OUT commands,
exposed through ufs_rpmb_route_frames() for the OP-TEE RPMB supplicant and
guarded by CONFIG_SUPPORT_UFS_RPMB.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/Kconfig      |  13 ++++
 drivers/ufs/Makefile     |   1 +
 drivers/ufs/ufs-rpmb.c   | 146 +++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs-uclass.c |   6 ++
 drivers/ufs/ufs.h        |  13 ++++
 include/ufs.h            |   8 +++
 6 files changed, 187 insertions(+)
 create mode 100644 drivers/ufs/ufs-rpmb.c

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 49472933de3..d39fcda42dc 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -92,4 +92,17 @@ config UFS_TI_J721E
 	  This selects the glue layer driver for Cadence controller
 	  present on TI's J721E devices.
 
+config SUPPORT_UFS_RPMB
+	bool "Enable UFS RPMB (Replay Protected Memory Block) support"
+	depends on UFS && OPTEE && !SUPPORT_EMMC_RPMB
+	select BLAKE2
+	help
+	  Route OP-TEE RPMB requests to the UFS RPMB Well-Known LUN using
+	  SCSI SECURITY PROTOCOL IN/OUT commands. Required for OP-TEE secure
+	  storage (CFG_RPMB_FS) on UFS-based platforms that have no eMMC.
+	  BLAKE2 is used to derive the fixed-length RPMB CID that matches the
+	  Linux kernel UFS device_id ABI. The OP-TEE supplicant handles a
+	  single RPMB transport, so this is mutually exclusive with the eMMC
+	  RPMB supplicant (SUPPORT_EMMC_RPMB).
+
 endmenu
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index e7f3c1d30c4..d60440ca119 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
 obj-$(CONFIG_UFS_RENESAS_GEN5) += ufs-renesas-rcar-gen5.o
 obj-$(CONFIG_UFS_ROCKCHIP) += ufs-rockchip.o
 obj-$(CONFIG_UFS_TI_J721E) += ti-j721e-ufs.o
+obj-$(CONFIG_SUPPORT_UFS_RPMB) += ufs-rpmb.o
diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
new file mode 100644
index 00000000000..636ccb6e74f
--- /dev/null
+++ b/drivers/ufs/ufs-rpmb.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <dm.h>
+#include <log.h>
+#include <scsi.h>
+#include <ufs.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include "ufs.h"
+
+#define RPMB_REQ_KEY		1
+#define RPMB_REQ_WCOUNTER	2
+#define RPMB_REQ_WRITE_DATA	3
+#define RPMB_REQ_READ_DATA	4
+#define RPMB_REQ_STATUS		5
+
+#define RPMB_FRAME_REQ_OFFSET	510
+
+static u16 rpmb_frame_request(const void *frame)
+{
+	const u8 *p = frame;
+
+	return ((u16)p[RPMB_FRAME_REQ_OFFSET] << 8) |
+		p[RPMB_FRAME_REQ_OFFSET + 1];
+}
+
+static int ufs_rpmb_secprot(struct udevice *scsi_dev, unsigned int region,
+			    u8 opcode, void *buf, unsigned int nframes,
+			    enum dma_data_direction dir)
+{
+	struct scsi_cmd pccb;
+	u32 len = nframes * RPMB_FRAME_SIZE;
+	u16 spsp = (region << 8) | UFS_RPMB_SEC_PROTOCOL_ID;
+
+	memset(&pccb, 0, sizeof(pccb));
+	pccb.lun = UFS_UPIU_RPMB_WLUN;
+	pccb.cmd[0] = opcode;
+	pccb.cmd[1] = SEC_PROTOCOL_UFS;
+	pccb.cmd[2] = (spsp >> 8) & 0xff;
+	pccb.cmd[3] = spsp & 0xff;
+	pccb.cmd[4] = 0;
+	pccb.cmd[5] = 0;
+	pccb.cmd[6] = (len >> 24) & 0xff;
+	pccb.cmd[7] = (len >> 16) & 0xff;
+	pccb.cmd[8] = (len >> 8) & 0xff;
+	pccb.cmd[9] = len & 0xff;
+	pccb.cmd[10] = 0;
+	pccb.cmd[11] = 0;
+	pccb.cmdlen = 12;
+	pccb.pdata = buf;
+	pccb.datalen = len;
+	pccb.dma_dir = dir;
+
+	return scsi_exec(scsi_dev, &pccb);
+}
+
+static int ufs_rpmb_send(struct udevice *scsi_dev, unsigned int region,
+			 void *frames, unsigned int nframes)
+{
+	return ufs_rpmb_secprot(scsi_dev, region, SECURITY_PROTOCOL_OUT,
+				frames, nframes, DMA_TO_DEVICE);
+}
+
+static int ufs_rpmb_recv(struct udevice *scsi_dev, unsigned int region,
+			 void *frames, unsigned int nframes)
+{
+	return ufs_rpmb_secprot(scsi_dev, region, SECURITY_PROTOCOL_IN,
+				frames, nframes, DMA_FROM_DEVICE);
+}
+
+int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
+			  void *req, unsigned long reqlen, void *rsp,
+			  unsigned long rsplen)
+{
+	unsigned int n_req = reqlen / RPMB_FRAME_SIZE;
+	unsigned int n_rsp = rsplen / RPMB_FRAME_SIZE;
+	u16 request;
+	int ret;
+
+	if (!scsi_dev || reqlen % RPMB_FRAME_SIZE ||
+	    rsplen % RPMB_FRAME_SIZE || !n_req)
+		return -EINVAL;
+
+	request = rpmb_frame_request(req);
+
+	switch (request) {
+	case RPMB_REQ_KEY:
+	case RPMB_REQ_WRITE_DATA: {
+		u8 status_frame[RPMB_FRAME_SIZE];
+
+		ret = ufs_rpmb_send(scsi_dev, region, req, n_req);
+		if (ret)
+			return ret;
+
+		memset(status_frame, 0, sizeof(status_frame));
+		status_frame[RPMB_FRAME_REQ_OFFSET] = RPMB_REQ_STATUS >> 8;
+		status_frame[RPMB_FRAME_REQ_OFFSET + 1] = RPMB_REQ_STATUS & 0xff;
+		ret = ufs_rpmb_send(scsi_dev, region, status_frame, 1);
+		if (ret)
+			return ret;
+
+		if (n_rsp < 1)
+			return -EINVAL;
+		return ufs_rpmb_recv(scsi_dev, region, rsp, 1);
+	}
+	case RPMB_REQ_WCOUNTER:
+	case RPMB_REQ_READ_DATA:
+		ret = ufs_rpmb_send(scsi_dev, region, req, 1);
+		if (ret)
+			return ret;
+		if (n_rsp < 1)
+			return -EINVAL;
+		return ufs_rpmb_recv(scsi_dev, region, rsp, n_rsp);
+	default:
+		debug("ufs-rpmb: unsupported request 0x%x\n", request);
+		return -EINVAL;
+	}
+}
+
+struct udevice *ufs_rpmb_get_scsi_dev(int dev_id)
+{
+	struct udevice *scsi_dev;
+	int ret;
+
+	ret = uclass_get_device(UCLASS_SCSI, dev_id, &scsi_dev);
+	if (ret) {
+		debug("ufs-rpmb: no SCSI device for dev_id %d: %d\n",
+		      dev_id, ret);
+		return NULL;
+	}
+	return scsi_dev;
+}
+
+int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size)
+{
+	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
+	u8 desc[QUERY_DESC_GEOMETRY_DEF_SIZE];
+	int ret;
+
+	ret = ufshcd_read_descriptor(hba, QUERY_DESC_IDN_GEOMETRY, 0,
+				     desc, sizeof(desc));
+	if (ret)
+		return ret;
+
+	*rpmb_rw_size = desc[GEOMETRY_DESC_RPMB_RW_SIZE];
+	return 0;
+}
diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 4d10e0b11fe..962b6093762 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1712,6 +1712,12 @@ static inline int ufshcd_read_desc(struct ufs_hba *hba, enum desc_idn desc_id,
 	return ufshcd_read_desc_param(hba, desc_id, desc_index, 0, buf, size);
 }
 
+int ufshcd_read_descriptor(struct ufs_hba *hba, enum desc_idn desc_id,
+			   int desc_index, u8 *buf, u8 size)
+{
+	return ufshcd_read_desc_param(hba, desc_id, desc_index, 0, buf, size);
+}
+
 static int ufshcd_read_device_desc(struct ufs_hba *hba, u8 *buf, u32 size)
 {
 	return ufshcd_read_desc(hba, QUERY_DESC_IDN_DEVICE, 0, buf, size);
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 0f6c93fbce7..e66d2c5f533 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -10,6 +10,16 @@
 struct udevice;
 
 #define UFS_CDB_SIZE	16
+
+#define UFS_UPIU_RPMB_WLUN		0xC4
+#define RPMB_FRAME_SIZE			512
+
+#define SECURITY_PROTOCOL_IN		0xA2
+#define SECURITY_PROTOCOL_OUT		0xB5
+#define SEC_PROTOCOL_UFS		0xEC
+#define UFS_RPMB_SEC_PROTOCOL_ID	0x01
+
+#define GEOMETRY_DESC_RPMB_RW_SIZE	0x17
 #define UPIU_TRANSACTION_UIC_CMD 0x1F
 #define UIC_CMD_SIZE (sizeof(u32) * 4)
 #define RESPONSE_UPIU_SENSE_DATA_LENGTH	18
@@ -809,4 +819,7 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
 
 int ufshcd_probe(struct udevice *dev, struct ufs_hba_ops *hba_ops);
 
+int ufshcd_read_descriptor(struct ufs_hba *hba, enum desc_idn desc_id,
+			   int desc_index, u8 *buf, u8 size);
+
 #endif
diff --git a/include/ufs.h b/include/ufs.h
index f6e27d90e43..90c6aebcec1 100644
--- a/include/ufs.h
+++ b/include/ufs.h
@@ -20,4 +20,12 @@ int ufs_probe(void);
  */
 int ufs_probe_dev(int index);
 
+struct udevice *ufs_rpmb_get_scsi_dev(int dev_id);
+
+int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
+			  void *req, unsigned long reqlen, void *rsp,
+			  unsigned long rsplen);
+
+int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size);
+
 #endif
-- 
2.54.0

