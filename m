Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A502CD8C8E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 12:47:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 863538484C;
	Sat,  6 Jun 2026 14:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bPjJsV+h";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QG3tBvpo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A498405A; Sat,  6 Jun 2026 12:19:46 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6596838BB
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 12:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65663gPL675297
 for <u-boot@lists.denx.de>; Sat, 6 Jun 2026 10:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rHdknqkigpuIHaLWspUXVusw9P1fgRG7WiqU5YKVWj0=; b=bPjJsV+h++cQp76p
 ToCArY4C8a8LagWtV/7MGwe1Pu+3hObioAA0lOHqsmQYnHz0ciQugwhxeVnjsH3W
 kFiuIqQXtNe0notshvO6DTYpiHwcFCt4SB+thR0lM1KBG3lR9ioRS9ssro3aETg9
 tRqNpJfFzjX/Pmji8P+zCgTQ1E62s1GrBGblR9rhW8YZTzPlhdZ+EK+qgbDqBFp+
 97EcUoLLPLOAW7Ym3QYn8N5orhJCCcosNFO6DDVrAX+UUO1XmETgiwhn7C2QbL8H
 jUPvxlXkxVxB/W5g1gMxekmT1AqrEorv9nZK8exmAwMlGAQGYayLZ5tMuYdRopAF
 AHJAhg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emb4w0yk7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 10:19:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c0c32faa62so48965395ad.2
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 03:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780741181; x=1781345981; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rHdknqkigpuIHaLWspUXVusw9P1fgRG7WiqU5YKVWj0=;
 b=QG3tBvpomtumoqh+Zdq+uUp9LMt7mNsDE8uYzkrlEJZWzafhKlTLmnWerKNPqD1dzh
 d1tv1tedCgZN09hshfMQIZ6LgQErErhx2GNQN5O+lL+2+z7JNff8rOyc8zIoitY9luaI
 MTg3qVunJw6f+/9udHitUJlLyZRx9SW5LVu4pRlp/Dv+M9qOePUlYNx6yj51GYcmGGtP
 spakj76QzRqNskpM8L5tz5OBiUkFqG18j3HM3t2Ei/jXmsbCq7rRvAMHADkXVctODLWT
 wbozMboKS8UNNphGtSPN0yGB2oDdNNwYNCPxfpej83o7lwsIEAxYzCEU7NjJ5P+8UekJ
 1Lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780741181; x=1781345981;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rHdknqkigpuIHaLWspUXVusw9P1fgRG7WiqU5YKVWj0=;
 b=BtmGp4DS5KJhyhdyr66S3dXx/+k+uaApBwJ74yVFIT5iDtn2Rj4pdnWg/yvnZz8cXm
 TllFNlJyYa40Z22fxdtTvnvbFyOTAC2AwcUGEeJNbqOQ6TLPsmyg7nWoVpcbprXGIlH/
 CxDsdH6XeVJgFCF5k6D8PJzrKCyH3ENT879UXnUCVM0YZ70BVO0I5OWU2gtJblHh2Hac
 eHDJSnhzOdmXI7MTBRlcel/ToVtoH469nnI0PdmhA7PipEEslst4Oymo3pMSTThI9ZmF
 zhgls91KfCGnjO7cwZMOM0fa/2dypAbdlKIObC3stqBYwK8JrQRpYvWsjRIIVpxt1ECv
 j6WA==
X-Gm-Message-State: AOJu0YytxnjORQoQN0kQEYfoCGm4z3LlqHP747xKp4qes6vHmZCGUkU/
 8BBiXX6qS1JrbBCQR1HQesZyK4ZSrYbzgidg9nD2C2DZqFsBIf8r6dM5XQoC1Tcq8+RJwDapoRH
 t5gaz4dWqTE4KwIqpN6QdsQGTRprKky4eRFSaIcJ3Jr3QdrsNxHMaQeYo
X-Gm-Gg: Acq92OFGzZtHhRU4DfR9wKmzZe8+fSc/9A1KyjSB4Dln0WbEgeCgLV2tO/fHknxTRPI
 VBcbdigUd8/1GlP1wS81VRO6MeVF7NO2ikFSKRMCV0VNX/6GcKI50SL/LyapsoP7GkGQJln74AN
 ug/6dfNhGrdpqXipugPxJFsDIxxk792PoTbsehYH6Wmd9v5ZlxTVP1ZtRIFmU9i0wgmDr6hGLgO
 CTLEFq5inaz/u9Qm9S96CIBS8DgM/02XR86F/yhQs81oFTUIO3hmL3cY3oTcAOj+hwKtw1MrzN5
 JEqnL5hVP3xN5j3LvoUR9N6RXnRqUBRb8TRedD2GzuF5DZKngT1cM/qevYIjnSeRlFEIX7YXi9Y
 AGyMu3+ThJj2mPT0aBUOYM8bJyPUL/9219rPTZuZefpER82NFftsX6sgfYLv+OdTQzRMWY6qEoo
 vSmRA0B5MbcbXnf7aQLzs6az7Yau1w3WI6MkgeJ3s1Naa6gzCaPQsI1v7Xayct
X-Received: by 2002:a17:903:41c7:b0:2c1:77cd:fb0b with SMTP id
 d9443c01a7336-2c1e85e04bbmr82390995ad.37.1780741181159; 
 Sat, 06 Jun 2026 03:19:41 -0700 (PDT)
X-Received: by 2002:a17:903:41c7:b0:2c1:77cd:fb0b with SMTP id
 d9443c01a7336-2c1e85e04bbmr82390265ad.37.1780741180612; 
 Sat, 06 Jun 2026 03:19:40 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16609ed97sm123124235ad.41.2026.06.06.03.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 03:19:40 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 15:48:34 +0530
Subject: [PATCH v2 03/14] spl: ufs: add partition-based U-Boot loading support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-spl_ufs-v2-3-72fed24ef01b@oss.qualcomm.com>
References: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
In-Reply-To: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>, Dhruva Gole <d-gole@ti.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Korsgaard <peter@korsgaard.com>, Heiko Schocher <hs@nabladev.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 David Wronek <david.wronek@mainlining.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Yao Zi <me@ziyao.cc>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Bo-Chen Chen <rex-bc.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780741114; l=6498;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=kTnO2xb6UL+uKPWvyCaBD1gGF02/K0svG9MV23DocYw=;
 b=/HZLo4K9stxkLGcEwCp2eP8mlbKTivzWgRjSpS7nEL9Sc5YQ+cJtgqOYeMozIsac3bD6POagS
 018YJ2N/qZFCTArj4OsGRzhoy0TfUnJXnQvt502JudxmS18Dd3wta5i
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: 49n6t6so-gjwXJ1FVxMmAEcCh7w3O48k
X-Proofpoint-GUID: 49n6t6so-gjwXJ1FVxMmAEcCh7w3O48k
X-Authority-Analysis: v=2.4 cv=YIWvDxGx c=1 sm=1 tr=0 ts=6a23f43e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=uM3EmLzBpLvrW53vGigA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEwMSBTYWx0ZWRfXziEpJtqFEOrY
 261bOJdhzGgrBIOBjPCrPP3b2RupMXPeO7AALxT76jajMBwOx9IxKFkH2OcxX+L1huPjDEF/s27
 f/QgQrfy6pUkWVrfudgPrddtP+oIk0+y8R4zLeqa0QJMtBaOA80FtcQpkZigzYu12lj7AMWldJD
 2Q+iR2Dmjzdk55AVhiZ8JuENMp8iu3bcwQH4rSCvENouhLQI+04NQarf2pNRc+fYAp6knZT8gud
 H/9HM9YODd4D9JdD1b8XhlMdTtr5HVLPR5Pt1p383xFWPOTq/MEDGG98Xj7L4vb3iCMqsxpD+rj
 GBzQTwi0snMtUW/fBlI18GTY5w3uwwpijcuHmgD7paF/lnL552lpqFJtRoFN/a2bBunUHgqkQ8W
 KjnErfbSAIbh5d6Y/uDG8TQHkLIZt+3dn8F8+1Q5kFoCeCIRwopJweJ5DA0FlwFj4DLHjCCn6x6
 OUTRwR6b885VEmqCXAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060101
X-Mailman-Approved-At: Sat, 06 Jun 2026 14:46:23 +0200
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
Changes in v2:
- Refactored the codes in common/spl/spl_ufs.c to use helper functions
  to make the codes readable and clear
---
---
 common/spl/spl_ufs.c | 153 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 134 insertions(+), 19 deletions(-)

diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
index cef1843f40f..0590b796267 100644
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
+static ulong h_spl_load_read(struct spl_load_info *load, ulong off,
+			     ulong size, void *buf)
 {
 	struct blk_desc *bd = load->priv;
 	lbaint_t sector = off >> bd->log2blksz;
@@ -20,30 +24,141 @@ static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size
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
+	spl_load_init(&load, h_spl_load_read, bd, bd->blksz);
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
+	int ret;
+
+	/* Try partition name first if configured */
+#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME
+	if (strlen(CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME) > 0) {
+		debug("spl: ufs: trying partition name '%s'\n",
+		      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME);
+
+		ret = part_get_info_by_name(bd,
+					    CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME,
+					    &part_info);
+		if (ret >= 0) {
+			debug("spl: ufs: found partition '%s' at 0x%lx\n",
+			      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME,
+			      (ulong)part_info.start);
+			return ufs_load_image_raw_sector(spl_image, bootdev, bd,
+							 part_info.start);
+		}
+		debug("spl: ufs: partition name not found: %d\n", ret);
+	}
+#endif
+
+	/* Try partition number if configured */
+	if (IS_ENABLED(CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM)) {
+		debug("spl: ufs: trying partition number %d\n",
+		      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM);
+
+		ret = part_get_info(bd, CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM,
+				    &part_info);
+		if (ret >= 0) {
+			debug("spl: ufs: found partition %d at 0x%lx\n",
+			      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM,
+			      (ulong)part_info.start);
+			return ufs_load_image_raw_sector(spl_image, bootdev, bd,
+							 part_info.start);
+		}
+		debug("spl: ufs: partition number not found: %d\n", ret);
+	}
+
+	puts("spl: ufs: partition error\n");
+	return -ENOENT;
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
+
+	boot_mode = spl_ufs_boot_mode(bootdev->boot_device);
+	ret = -EINVAL;
 
-	spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
-	err = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
-	if (err) {
-		puts("spl_ufs_load_image: ufs block read error\n");
-		log_debug("(error=%d)\n", err);
-		return err;
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

