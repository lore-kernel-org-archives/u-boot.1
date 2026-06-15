Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F52CD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1965848D8;
	Mon, 15 Jun 2026 10:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nPgR82Ed";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fH0WAa9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BC4984704; Mon, 15 Jun 2026 09:01:44 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D515983FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6L1ot3888523
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fTOdOF1tH7J+yshNLRz9Nu+J7epxppGlm0ciW73SEi8=; b=nPgR82Ed2UAw6k5v
 lHvIxb9yUR2Obp3UgxyRBCjWx4CxZE2Kak4B9IHkGYSUVndfbj6k2+uvaHRsxauc
 WPnvGpFnKIcUqD2a8Dv7rtgqzLwe7PBamJRaaiDROcbfH50XqHYtXPICPZvGVA4q
 XvXr6jiQCQ+4ZYJSMm9eGC5Iq6aK3W5FF+OQpyZP8fipDDp+N4LFflDKr2kJg7w8
 JwX2YWz/V+fX1iXVx2mju/ep6KGS73ZXjTjlHbrZDTbKBBSfT+pCGsS7l9/2A/bh
 V0h/JkuXIdf/P5T2m/QdmkMaqX+dmvspXkpwakFEfnAMUwmxOoBfWY5RJHCo76sR
 1cJOXQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery8wx3bt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:01:40 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c85a2c129b3so1422273a12.1
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 00:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781506899; x=1782111699; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fTOdOF1tH7J+yshNLRz9Nu+J7epxppGlm0ciW73SEi8=;
 b=fH0WAa9NzLzzjWHua7Xzdh6YZok/cOr3enrDmGPtRnBA2gNnrCoW7AYVh1J3dbmwGa
 /h4Mcvp0aInQySGySz/M3Kdtc0Vkw5Jd31I3CPrLvr8uiV1r608BlKuBiiUaGOLnIBOb
 ylzSsbNNvaOdJqV1U9Rd7wyKQv47Xcy35nCQPac4kmdzBDR6LC0e4/oTJLr1si4CG/V5
 M03hDd0d/Mhl6utLY4pBYiRWvpxfKOxa816hnm7QufRs4nUoIw1+2+Vd5Is8n7sncjtg
 +D1aou1bir0YeZbpNeLvG71VW075bsMEw7TdANwQmdrkmssJlMpjSeQa3Zwv5/9gQEIz
 8eFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781506899; x=1782111699;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fTOdOF1tH7J+yshNLRz9Nu+J7epxppGlm0ciW73SEi8=;
 b=fMJ7GIahWtrg3pNRY3d4iKOV2LFZ5mJpHkwb24UD7BLyvZbLU3aOvau9ukqKU3OkUw
 qTd8dyaoQxp1VyxSYwEkd2Y/tvc1DmlVGyruMtDqIT1D9XuMdF+TQ+6myfvOJ25IjJ3R
 ZJ+yYNhVEXQHYDZfSAuRCtNmtjRQO6Dzqo8P7G601xv/tOGCfGyjmVkCDC651FGzBmRg
 QHnaq5hSJqMp6kPWOIDuCmHV7WzP+t0bWIAkjruOf3D5mEYt99z6APV8i3r6Y1SShJvi
 yorqZm4+8CRjUtjti4mmQFrRjq5EaV+OWHmVIO/bpMYZNTzi5NsLb+ZDOcwwEA8vMkdf
 wjHA==
X-Gm-Message-State: AOJu0YwbzscdTMzthMsdOFFeen09Hsya127Etymo/ot7rMZUHsTLWiji
 2KA2IrDic8TSmZj7rcUlTjPs8ruxPjdtZw3srJk1KLv1VRbmMTTibzIBr/YrntV+vbpy5cqzZcR
 RI69x0RbP5cBdvnPKK9eGDEfdk8BLl3Rx0MeaZLEtL4WY6gm94WXc3JDB
X-Gm-Gg: Acq92OFooRpoetgI6P227Ad+4PWKgiT5GCGmnidc95X7+c+sksYl6taYNL7steSaTEJ
 4s29g+Qvjm3mpRvuEmIDzjAh2NTYDgheIoXKUJNccYToO2dqxtjZ9LAV9hi0uihjSHEyuMKL5F8
 DynotPyBmIoF9M1sGR88/Us/0bosQ/SxG0IQczWmxIZYlR1LEH0MyknVCXwpFoJ8uqMEy2e+Vwj
 FbJ1rRt3uTs1yIwoAThf8pxH7kMIcR3EK6Z2AJGDWhpjZGTcwblJSFYAH0d8G+PGxZZYVejDlUC
 EhhaC0dhxk4wLaRr1plhj8g9PU37OUsZ4wZ0PFjNedpVqS6aIKLh9biBmoVgC1acfMcPyRb3T8R
 feD95/78ZzF34rNyX+MorfX0ob/cFnWUqS1YF0W6nbTDLeDrcpZngGVq3To3DVXFrYgndSIVbb8
 a7YDm1Sk5FfrlajGHz0O06qByw29rFeIhbmt6F7LYkt0O/Ut52Mw==
X-Received: by 2002:a05:6a20:4c8:b0:3b4:8625:55eb with SMTP id
 adf61e73a8af0-3b7840856dbmr15535991637.40.1781506899100; 
 Mon, 15 Jun 2026 00:01:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:4c8:b0:3b4:8625:55eb with SMTP id
 adf61e73a8af0-3b7840856dbmr15535896637.40.1781506898618; 
 Mon, 15 Jun 2026 00:01:38 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434aca3041sm9226124b3a.5.2026.06.15.00.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 00:01:38 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:30:00 +0530
Subject: [PATCH v3 04/14] spl: ufs: add partition-based U-Boot loading support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-spl_ufs-v3-4-360bceb29596@oss.qualcomm.com>
References: <20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com>
In-Reply-To: <20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, Andrew Davis <afd@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Dhruva Gole <d-gole@ti.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Michal Simek <michal.simek@amd.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Yao Zi <me@ziyao.cc>,
 Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781506817; l=6597;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=c8TEmcI5t1cnb4+Izkk+8Z50Cts6/sNzGVvYZcpXGhQ=;
 b=CgXUnIMyGdIK9TJVYoMFAqS3v9xESnLrUTFKRdYTSY3bq2GwJTKw+klHEjGThal3WsOvckqq3
 KtqVKzfb+8OCX+9+SL53PG+WSDD5UvZI0K7LoN2NDN8NCrpnhwQSlYB
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: 7kjLISEqZVaZrq8GfZQuPlm9u_iM9HK7
X-Proofpoint-GUID: 7kjLISEqZVaZrq8GfZQuPlm9u_iM9HK7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MCBTYWx0ZWRfX6ps0Abw09kih
 wEE4V/yc6naBI7Nd6PDRaalEjaJmufk0BK8s01Ew0fHa3SyXL9JXPongrxckHMg7v4rcWriUroC
 EhKlSK3HtJVUIubK+u2IaAC1tLyczHQ=
X-Authority-Analysis: v=2.4 cv=IqAutr/g c=1 sm=1 tr=0 ts=6a2fa354 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=KL21IebutpBlNCngNpcA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MCBTYWx0ZWRfX81Az3K5dWPk0
 HSKbp+75j40qxZ3Fz5PDSReK3+D6PSVED3oMpp4249Yotv8choZ0uTS5+DtssJaAMc8oysdB18z
 4b5wq3G4NcJ2tXUVNwWzKd8atGQPy4s/xyqnKXFZKP90Mxp9YSFMApsiR6iNd1h5jIwnWbIpxfC
 Xs4dqF1sjBhzw+tCOf/64gdwl6jjMPIgQyq/pXHoaFDLfqKVaNMQdLJxZISJDfjBwNcNbyQCPvx
 ST7VOlPg5xtkwIl9H37CqUCK3EWqTYC8ox2PHgCBWfvR8kNN5tJyJI2WXZ7WWr9Ve4Qat+40K14
 QcC3ZMHfOvlujNJzg2wf1mfCAN1wwP+60dBYYfEBEoEygWyODMKXml8RjWfz00kT57czn8M/gUh
 6S8AonO0t+FRRUvfohxw8GFZG0M/lCCb8gfjAVlidIYbW22ANV/uq+bSNUKukhJNepKT+YShHk7
 LSOq94zaJfUhzTfuESA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150070
X-Mailman-Approved-At: Mon, 15 Jun 2026 10:34:58 +0200
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

Refactor spl_ufs.c to support loading U-Boot either from a raw
sector offset or from a named/numbered partition, controlled by
the Kconfig choice introduced in the previous commit.

The monolithic spl_ufs_load_image() is split into helper functions:
ufs_load_image_raw_sector() handles sector-based loading, and
ufs_load_image_raw_partition() resolves the target sector by looking
up a partition name first, falling back to partition number. A new
exported spl_ufs_load() function drives the boot-mode switch and
can be reused by other callers. A weak spl_ufs_boot_mode() hook
allows board code to override the default raw boot mode.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Renamed h_spl_load_read to spl_ufs_load_read
- Simplified partition selection logic in ufs_load_image_raw_partition

Changes in v2:
- Refactored the codes in common/spl/spl_ufs.c to use helper functions
  to make the codes readable and clear
---
 common/spl/spl_ufs.c | 151 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 132 insertions(+), 19 deletions(-)

diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
index cef1843f40f..9ccabedce1c 100644
--- a/common/spl/spl_ufs.c
+++ b/common/spl/spl_ufs.c
@@ -3,15 +3,19 @@
  * (C) Copyright 2025 Alexey Charkov <alchark@gmail.com>
  */
 
+#include <dm.h>
+#include <log.h>
 #include <spl.h>
 #include <spl_load.h>
 #include <scsi.h>
-#include <errno.h>
-#include <image.h>
+#include <part.h>
+#include <blk.h>
 #include <linux/compiler.h>
-#include <log.h>
+#include <errno.h>
 
-static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size, void *buf)
+/* Block read callback for spl_load framework */
+static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off,
+			       ulong size, void *buf)
 {
 	struct blk_desc *bd = load->priv;
 	lbaint_t sector = off >> bd->log2blksz;
@@ -20,30 +24,139 @@ static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size
 	return blk_dread(bd, sector, count, buf) << bd->log2blksz;
 }
 
-static int spl_ufs_load_image(struct spl_image_info *spl_image,
-			      struct spl_boot_device *bootdev)
+/* Load image from raw sector */
+static int ufs_load_image_raw_sector(struct spl_image_info *spl_image,
+				     struct spl_boot_device *bootdev,
+				     struct blk_desc *bd,
+				     unsigned long sector)
 {
-	unsigned long sector = CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR;
-	int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
 	struct spl_load_info load;
+	int ret;
+
+	debug("spl: ufs: loading from sector 0x%lx\n", sector);
+
+	spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
+	ret = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
+
+	if (ret) {
+		printf("%s: ufs block read error\n", __func__);
+		log_debug("(error=%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/* Find and load from partition */
+static int ufs_load_image_raw_partition(struct spl_image_info *spl_image,
+					struct spl_boot_device *bootdev,
+					struct blk_desc *bd)
+{
+	struct disk_partition part_info;
+	int ret = -ENOENT;
+
+	/* Try partition name first if configured */
+#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME
+	if (strlen(CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME) > 0) {
+		debug("spl: ufs: trying partition name '%s'\n",
+		      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME);
+		ret = part_get_info_by_name(bd,
+					    CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME,
+					    &part_info);
+		if (ret >= 0)
+			debug("spl: ufs: found partition '%s' at 0x%lx\n",
+			      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME,
+			      (ulong)part_info.start);
+		else
+			debug("spl: ufs: partition name not found: %d\n", ret);
+	}
+#endif
+
+	/* Fall back to partition number if name lookup failed */
+	if (ret < 0 && IS_ENABLED(CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM)) {
+		debug("spl: ufs: trying partition number %d\n",
+		      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM);
+		ret = part_get_info(bd, CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM,
+				    &part_info);
+		if (ret >= 0)
+			debug("spl: ufs: found partition %d at 0x%lx\n",
+			      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM,
+			      (ulong)part_info.start);
+		else
+			debug("spl: ufs: partition number not found: %d\n", ret);
+	}
+
+	if (ret >= 0)
+		return ufs_load_image_raw_sector(spl_image, bootdev, bd,
+						 part_info.start);
+
+	puts("spl: ufs: partition error\n");
+	return ret;
+}
+
+u32 __weak spl_ufs_boot_mode(const u32 boot_device)
+{
+	return UFS_MODE_RAW;
+}
+
+int spl_ufs_load(struct spl_image_info *spl_image,
+		 struct spl_boot_device *bootdev,
+		 const char *filename)
+{
+	u32 boot_mode;
+	int ret = 0;
+	int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
 	struct blk_desc *bd;
-	int err;
 
-	/* try to recognize storage devices immediately */
-	scsi_scan(false);
+	log_debug("spl: ufs: devnum=%d\n", devnum);
+
+	ret = scsi_scan(false);
+	if (ret) {
+		printf("spl: ufs: scsi scan failed: %d\n", ret);
+		return ret;
+	}
+
 	bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, devnum);
-	if (!bd)
+	if (!bd) {
+		printf("spl: ufs: could not get device %d\n", devnum);
 		return -ENODEV;
+	}
 
-	spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
-	err = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
-	if (err) {
-		puts("spl_ufs_load_image: ufs block read error\n");
-		log_debug("(error=%d)\n", err);
-		return err;
+	boot_mode = spl_ufs_boot_mode(bootdev->boot_device);
+	ret = -EINVAL;
+
+	switch (boot_mode) {
+	case UFS_MODE_RAW:
+		debug("spl: ufs: boot mode: raw\n");
+
+#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_USE_SECTOR
+		ret = ufs_load_image_raw_sector(spl_image, bootdev, bd,
+						CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR);
+		if (!ret)
+			return 0;
+#elif defined(CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION)
+		ret = ufs_load_image_raw_partition(spl_image, bootdev, bd);
+		if (!ret)
+			return 0;
+#endif
+		break;
+	default:
+		puts("spl: ufs: wrong boot mode\n");
 	}
 
-	return 0;
+	return ret;
+}
+
+/* SPL load image entry point */
+static int spl_ufs_load_image(struct spl_image_info *spl_image,
+			      struct spl_boot_device *bootdev)
+{
+	return spl_ufs_load(spl_image, bootdev,
+#ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
+			    CONFIG_SPL_FS_LOAD_PAYLOAD_NAME);
+#else
+			    NULL);
+#endif
 }
 
 SPL_LOAD_IMAGE_METHOD("UFS", 0, BOOT_DEVICE_UFS, spl_ufs_load_image);

-- 
2.34.1

