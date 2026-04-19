Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B20EA7195
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 10:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A71284214;
	Sun, 19 Apr 2026 12:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="huD/v0kh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b+KDMIjS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28D1684297; Sun, 19 Apr 2026 12:24:37 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1F54839D9
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 12:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63J9BFYc666626
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 10:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fxnNs8FmJzW1GMl+aLT4/2QFxAozH9DHOktpqtNRhPs=; b=huD/v0khd6TjaPy4
 DTBiuGIKDfIFySBGzmajnelWQqNWg8l0SwYXhhEVtmwXys1PXCOJVfRMp6vXgZze
 yli7xPE2TlCd5S32q7PjF3Ij0d7DTPgMTMpA/7IG9rcJpmWDA2u3Bx1ETTOvioNB
 OaQYnSJcsoq1UoIoB81qwqrarm9mt2b+W66mStfYiuh/3kDjINt+vUMtk4LfTzqx
 sDJWjdypr0aVLV3zdyFRUkg4Ah2PfRqBZmZVr3idU/iydAvPJ52iQY6+cmTSAyAy
 bfv41ivENRuOIfsoPSz3Cqh52/Lyi0961PrBEikOSs3lO6pdOmj4U7LHikEWZl2V
 2+qrJg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm21ujb3q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 10:24:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2ed279eedso13822405ad.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 03:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776594272; x=1777199072; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fxnNs8FmJzW1GMl+aLT4/2QFxAozH9DHOktpqtNRhPs=;
 b=b+KDMIjSbeYuqGh7duU/cJnqBf4q/buR09J/opTMGUSg4SAZW+hvUJhQY1z/yR0iDw
 n3qwLPjxoTkAPk1Kp3SOD1mAlxU4iuNwP5XwtHRx0Dfoa5MbvmcZ/Idce42zw3yrL37+
 6Gb0MYAVDQdwhtAW2wBK37qAt2xSY+tzWmtJVQz+LoTMNaQTBiq/Jggab3RK5wee/iJT
 OSJBfVtlvqvJJUsPApR4xgnihBUhtkA1BMj7iQUQAAjaHokmitW2hTgwDggqqrBROJkd
 bFlr+SP7p832uXDBkoA37RHyvJrq77jwRlK3ZNK/rOMcw0/3k2UBBR2lDaVAENRMz1MO
 63sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776594272; x=1777199072;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fxnNs8FmJzW1GMl+aLT4/2QFxAozH9DHOktpqtNRhPs=;
 b=rL2H0w7FU9hqZIE8jfRKtR4Cr3pKomckZSm6Suk3fIVUqmmgagPd4nAvTOItPqeNYl
 rn7Sma0sweZKAntap3NiCdwoNv5Kz7cut0ma178bwv/Bdhw6dvzXNWx5kF5O/xpqkznh
 SWuoksQgT20zXcV/vBQsdgOknZUOxciPy0292rVBMazuShdqTzAV1CffXO0lQ7G77k2g
 R6aVg9VQCp70kTqibBClfN9t+XHA+UlGiyPpanl5T7Ke9iuygjZ88pnzxKT3MouCIPYz
 MRat8l1ps1bWsxueAcg/lXXvDNluRJuK8Ev1YMwPJOCwTxjRQbWKnAjEVtLsHCTru9TG
 DJiw==
X-Gm-Message-State: AOJu0YzyFN6qRZxZutlgUEeyUJpXQWKGdYUd8CWFGPcuRQ8nTA3FZOZ6
 +KSpoo8UrY6+co49RJpk9hcwkDT2zVWH0keOBxNe6/uWIajXde3GUBb8Vn+huTTkuTD9ZXG19pS
 Vw8jGP5FlaJHwOvKTGFbb+ESFyYFNB7IjwOpsGDv312CoY9fq7WlRVFof
X-Gm-Gg: AeBDiesnCo9Nz46ZgisS9xsRAKMCFzo3S2WSKFiirZjxGBRZZUOlPyQDmDSpwJCNyqH
 Mzwqa5zQioZ6arG6pgE5Gtm4vkCogmdQKOQn3nwnCjSc25uVIfxmh6BipAbpjuaTx74oncl7cFf
 V2wqb2qm6i5aB2lgLixXm6hGYeJQwaVRwaDuVX6tFW8NMfKxk4eiyAI3/2GEH58Vmr4hMduJIf2
 LcqhmhRNcJd59A64fyzganftpl9ecJ0zUf+2gD78rWee8A6TyPI8Opn7UaIS38gVZvSNFO7uFId
 oeNf6I2bE6ARd6GW4O0ddjbq2Usoixl2ZACErOiASCYFHpJ+kQdqUVyUVLJlXieFkdLlo6+N7Wf
 mj360wPk1RdJ8NZGYDcAxAyTDZuKkxy0Yj633+9gE1kE64bv6L/V8JVZVqcySs6gjcGabz2Gucv
 etmWDbSZ56OofxYJakJlA4QXsVyVi5vk3VLH0cWQ9GhPf/c1nBKM2iRttpD5UW
X-Received: by 2002:a17:902:f652:b0:2b0:beb4:3bb with SMTP id
 d9443c01a7336-2b5f9e7f300mr96450915ad.10.1776594272388; 
 Sun, 19 Apr 2026 03:24:32 -0700 (PDT)
X-Received: by 2002:a17:902:f652:b0:2b0:beb4:3bb with SMTP id
 d9443c01a7336-2b5f9e7f300mr96450495ad.10.1776594271862; 
 Sun, 19 Apr 2026 03:24:31 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0caf1sm72754675ad.42.2026.04.19.03.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 03:24:31 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 19 Apr 2026 15:54:04 +0530
Subject: [PATCH v3 2/5] scsi: Add partition lookup by type GUID for SCSI
 devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260419-type-v3-2-ec49acd6870e@oss.qualcomm.com>
References: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
In-Reply-To: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776594245; l=2787;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=br+DcFt5glpdW/xzZ4CVXJ+Syg9Dc7rKFiepj4xSDwE=;
 b=Q8OgfMjYQMetoPBKVS9WD6YrbitroCpJ7+m5yQ52ORipctHMhuADcCaf5fLc8I/dYA9DeTuvu
 NJz4ONY0oTiC6DJJhqnKGbinNV+mJYYkjPRsQal6WeEzkL7Ta4B+PM9
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDEwOCBTYWx0ZWRfX1+Sxj80dU72u
 J6E0bHbVVxf7Zz+dcyvnkKkJOZSBotVW51RMQvtJEIJv1FIeHWsDWFinPgGjqjZxB4TRKqirzBf
 WBL23q2lXP96IDlVzNIgm/hTqtnSt4f0ucpDIO7xpk2cxuwRpLQfvl302Vpico7GG9o18yHow1l
 nun2lpu7tx42bXWOkCC4GUc93z0lSigKlEwFR7N8RnLnVrW7+8rrw36f3KO2AkXOkqnexZNYXYg
 DJMN431DMXa7o/qq8RitW9AGeKlcbI2tN45vr3Nh4ODGUeqm49QgpFgJMBTpUuG7OP7+fc6yjjD
 QqsBApYzFAdyNW8Y42vifI3V5GzO09LFrPgaA3ag+ci9KGkZ72xsxfWHpR3TnERcSJsxdPKeq6P
 x1qWwYqWB7ECCCwdEbUaqrg4sWgnVbctUJXhVWTj3gSEK8etPMOHD/UidJTz1wp7kU+TCPwocNY
 /KWdPJ76o0O0bGdvBLQ==
X-Proofpoint-GUID: AHBkue57vrS9pmL7gIwVKjCLydPthP4Z
X-Proofpoint-ORIG-GUID: AHBkue57vrS9pmL7gIwVKjCLydPthP4Z
X-Authority-Analysis: v=2.4 cv=WK1PmHsR c=1 sm=1 tr=0 ts=69e4ad61 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=DfNHnWVPAAAA:8 a=EUspDBNiAAAA:8 a=4Z9OGKtuVjyKH-hDXNMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_03,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190108
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

Introduce scsi_get_blk_by_type_guid() function to enable SCSI
partition discovery using partition type GUID. This function scans
all available SCSI devices and searches for a partition matching the
specified type GUID.

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- No changes

Changes in v2:
- Compute blk_find_max_devnum(UCLASS_SCSI) only once in scsi_get_blk_by_type_guid()
---
 drivers/scsi/scsi-uclass.c | 28 ++++++++++++++++++++++++++--
 include/scsi.h             | 11 +++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
index 39b4c7476d4..031dc01b9de 100644
--- a/drivers/scsi/scsi-uclass.c
+++ b/drivers/scsi/scsi-uclass.c
@@ -30,9 +30,10 @@ int scsi_get_blk_by_uuid(const char *uuid,
 			 struct disk_partition *part_info_ptr)
 {
 	struct blk_desc *blk;
-	int i, ret;
+	int i, ret, max;
 
-	for (i = 0; i < blk_find_max_devnum(UCLASS_SCSI) + 1; i++) {
+	max = blk_find_max_devnum(UCLASS_SCSI) + 1;
+	for (i = 0; i < max; i++) {
 		ret = blk_get_desc(UCLASS_SCSI, i, &blk);
 		if (ret)
 			continue;
@@ -47,6 +48,29 @@ int scsi_get_blk_by_uuid(const char *uuid,
 	return -ENODEV;
 }
 
+int scsi_get_blk_by_type_guid(const char *type_guid,
+			      struct blk_desc **blk_desc_ptr,
+			      struct disk_partition *part_info_ptr)
+{
+	struct blk_desc *blk;
+	int i, ret, max;
+
+	max = blk_find_max_devnum(UCLASS_SCSI) + 1;
+	for (i = 0; i < max; i++) {
+		ret = blk_get_desc(UCLASS_SCSI, i, &blk);
+		if (ret)
+			continue;
+
+		ret = part_get_info_by_type_guid(blk, type_guid, part_info_ptr);
+		if (ret > 0) {
+			*blk_desc_ptr = blk;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
 int scsi_bus_reset(struct udevice *dev)
 {
 	struct scsi_ops *ops = scsi_get_ops(dev);
diff --git a/include/scsi.h b/include/scsi.h
index 2520a8b8fe6..83aaf0a70f6 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -366,6 +366,17 @@ int scsi_scan_dev(struct udevice *dev, bool verbose);
 int scsi_get_blk_by_uuid(const char *uuid, struct blk_desc **blk_desc_ptr,
 			 struct disk_partition *part_info_ptr);
 
+/**
+ * scsi_get_blk_by_type_guid() - Provides SCSI partition information by type GUID.
+ *
+ * @type_guid:		Type GUID of the partition for fetching its info
+ * @blk_desc_ptr:	Provides the blk descriptor
+ * @part_info_ptr:	Provides partition info
+ * Return: 0 if OK, -ve on error
+ */
+int scsi_get_blk_by_type_guid(const char *type_guid, struct blk_desc **blk_desc_ptr,
+			      struct disk_partition *part_info_ptr);
+
 #define SCSI_IDENTIFY					0xC0  /* not used */
 
 /* Hardware errors  */

-- 
2.34.1

