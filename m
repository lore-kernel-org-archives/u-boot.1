Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93324D148AF
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 06:50:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 426B683A26;
	Thu,  8 Jan 2026 07:50:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UxjZDpMH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kQY1CWuR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6874683A1E; Thu,  8 Jan 2026 07:50:11 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D66D83A26
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 07:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6086TqSu3152713
 for <u-boot@lists.denx.de>; Thu, 8 Jan 2026 06:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JvO1Qh9+QpM
 mc1EeYW57dnVe2PS2PGyp+m538k/JyFw=; b=UxjZDpMHUEUG4H3AfgGQ6PKESio
 AOLRrpbB4XZQp8RA6o9I/tCeTw5kcMhGpBLukLCCf7x2t7jW53cDRcVC+Akx7prE
 MT3vJ2rzTe/QHxUGAaIhgXNFUBdKcwZhQ5EwWQv3N9wXJD1BvArz2rxKI53QZI9h
 08rxnB64eLAdungHkqcva8KIQNZUj7sRx9r6YBRw6LXp7Z8GVBYM5+4EZoVbn3tr
 yV3xIjB7bXjDcWmypOpEOSnUFrqda21nGQgiI0S/9+nRY6HWrm/M9l2PMnAigEtq
 UXzDW4w4h4bu9leZgj4Jkx+IuOYG8V9IDtPcsXW0XVzoFD/Z3go+U8dCXAQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhpjaub7t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 06:50:07 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-34eff656256so3813761a91.2
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 22:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767855007; x=1768459807; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JvO1Qh9+QpMmc1EeYW57dnVe2PS2PGyp+m538k/JyFw=;
 b=kQY1CWuRSq7aY2L89CrBsaHydDyCchCaaGFTmcURTGrgmoz7j/ozVWbXjdWuxZ4a06
 s0sUXTR+zAurOUA3bCmwdTkPKUQMeUNw6nf1wgzS1Gy+BQCZvefeSiLLm0y4zd++It5+
 +VOB+RZv6bCNNaE23N+3oE1sPzpDGDt8v8dpBj0PRgXasa0JMhetBS5iWOqFUrpGWN/T
 q67EleY+48bTyld7MXuZTQhlqM6v0Vt4Pt0zZZrJUAl84gI1gs7xRSwhL+HaNLcIBRz3
 k5QxUe2JySrio6dRmZ2HF3SkPCskhHhuMiU0WgCJtFe6QS1msh7wXIbDFkJ9kQqVtKUF
 epmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767855007; x=1768459807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JvO1Qh9+QpMmc1EeYW57dnVe2PS2PGyp+m538k/JyFw=;
 b=ZYfR0vYEXzk0DJnb8Gpy9fAUwUIxFQdN3Wy8kMdGg4RZWlsj2W67DqBmEQLWlFTsmv
 /1BCi7+0WfutoRUNdOFCRZX8PZgTnHCJsw7c8OOI6ljr+UJY0GLrrofk/Sa0Q4jiVtgc
 sXKUd5rQn0USC3MyaTwqmNh9RFP1nmnmIstkYTM+ZLreNTdtA0stB64uLBAXlidigtc4
 p2FP9eRZsloHr9JACBhBwt/LPT+M64RlikBivJQD5GBm/EQQ9fBNAP7iJO3ckG1+TKA+
 AUJu7D4J+EQuH0voQwaXf4dD1WF937s4k7W4/vzAvnBMYGlWgCv1zrLe77ZcJ1wl6lhG
 g4dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsHs127U1yiyi5xib9xPDr+pppjwcRQ88s8/VL5eSi00t+t4I8qRaAejeh1BzHktjzHufaUD0=@lists.denx.de
X-Gm-Message-State: AOJu0YwFXr6ZwnluIDe82Xgqs0MwX150+kH8UHqk656zSEP7b0ZYmgJt
 /Ndm7ttOecFpyQsgy1Oi3JqP8HtnLhzbAH6Mq0tKDywtZXhbDFke0DrZB+JVSKMuCKDHU4Rc9k7
 WWv9V+pkMC0Jx0HG3v2QCzVkOCD+9/JhwEOeQGFf5RFB1C1kW7d4moY3p
X-Gm-Gg: AY/fxX4NQmvLGnZ2YxCHYuXL9mUfIeHRYbOiNx/q9Wxt6wL0M0Lo8sRHZcoDKdWjP8L
 QOtcgT1oOukDbDOEPLbOeDMWUlVnRMYiXXDx7ktpfj4wgNEoCdfx8rQTQs68sJUPzHYfp3WAWdt
 +0GsmGNaH+04PcXQKi6tygYd0/zCdzy87kysLt++Hk1aH8dOdqEXMTSoAQcZ3wg1k9+d1iJ4CaY
 Bsvf+kQWK4V2XQW7vK2Zu8GcHJfoCxJw7Mlc04ggSaFnts0Tq6Zjf/RZGa3YBGz9GsP8uCURI91
 tiBGMYRzYUk7alxAAeUozz2m5WC1xIAwGmCiZiJsp4WKVo2SbCON7muugOkokh4pWLuUktFuul/
 1EtNpb4ulQDUrN+M1bfvi+HrtRD+QRo7s3pYwqH6NmTTjS/DgZyOeFnwrIz2nHal2FNyJ22DZUx
 XFNVwSot0hpFz4k1kL7VMy4b8Hf+SJ/zZVXKYVJQ==
X-Received: by 2002:a05:6a20:3d0d:b0:371:7f31:17f with SMTP id
 adf61e73a8af0-3898f9e2ddcmr4376925637.77.1767855006546; 
 Wed, 07 Jan 2026 22:50:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSsHm8ZzLGPW/35lOUoLtSBrqzCKu9pcU0aaKe9OYL290cX0pweXO5To+SZTd97GXbiD8Dnw==
X-Received: by 2002:a05:6a20:3d0d:b0:371:7f31:17f with SMTP id
 adf61e73a8af0-3898f9e2ddcmr4376907637.77.1767855006094; 
 Wed, 07 Jan 2026 22:50:06 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbf28faa9sm6918641a12.2.2026.01.07.22.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 22:50:05 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, joe.hershberger@ni.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 quentin.schulz@cherry.de, ravi@prevas.dk, javier.tia@linaro.org,
 quic_varada@quicinc.com, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, ansuelsmth@gmail.com, mwalle@kernel.org,
 anshuld@ti.com, jan.kiszka@siemens.com, javierm@redhat.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 2/4] scsi: Add partition lookup by type GUID for SCSI
 devices
Date: Thu,  8 Jan 2026 12:19:45 +0530
Message-Id: <20260108064947.3237361-3-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=efMwvrEH c=1 sm=1 tr=0 ts=695f539f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=4Z9OGKtuVjyKH-hDXNMA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: v7v510hEv9ZCiB_AjK0esTWbyzXDWV_x
X-Proofpoint-GUID: v7v510hEv9ZCiB_AjK0esTWbyzXDWV_x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA0MyBTYWx0ZWRfX0Mo2taSYHPOz
 BLzMHTTQEWuxH++T8xbCu5IL3++OhXy28TfKDTCHKJcDMEqJ4+NrxysEZn898kGGgA+SrfzQMMz
 K3OY249+1FvYGqvBqZWau77wpGDt8ITxLDFkVH7MkKcxBKWfoj7jvmlgjPFzB9Hyqi15rDkurBo
 udL1ukyuAPNDdnHyowPpIedRVum7hZWZupQ+QBw0YF5eqUNwf0gBvaU3ESjLeIqx2U4r0IZyCX1
 Joyw8VWePas2WBuhsiemLLV6X8HTHwA//EflYzXWWfa+jRVdNF9Hzxyjd4E5fuD5QPNfYGcBwn2
 LdzLgEcRGAI9oXKD41qpxSb5q0AMQsI18jX7iLbv3zPd2ZIBAcQ0vZQbzPBRnjozLdIZObNIU61
 x16MDknI1HQdwjFBtU90Ht9/Yc/YzogezzJG9U2Hpm13puODUHcEnmNirurde9jjYi2YryP9O+f
 jcIsotN5KK4JJ4b5/Bg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080043
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

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/scsi/scsi-uclass.c | 28 ++++++++++++++++++++++++++++
 include/scsi.h             | 11 +++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
index 3eb6069649f..42a6b5233c2 100644
--- a/drivers/scsi/scsi-uclass.c
+++ b/drivers/scsi/scsi-uclass.c
@@ -53,6 +53,34 @@ int scsi_get_blk_by_uuid(const char *uuid,
 	return -1;
 }
 
+int scsi_get_blk_by_type_guid(const char *type_guid,
+			      struct blk_desc **blk_desc_ptr,
+			      struct disk_partition *part_info_ptr)
+{
+	static int is_scsi_scanned;
+	struct blk_desc *blk;
+	int i, ret;
+
+	if (!is_scsi_scanned) {
+		scsi_scan(false /* no verbose */);
+		is_scsi_scanned = 1;
+	}
+
+	for (i = 0; i < blk_find_max_devnum(UCLASS_SCSI) + 1; i++) {
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
+	return -1;
+}
+
 int scsi_bus_reset(struct udevice *dev)
 {
 	struct scsi_ops *ops = scsi_get_ops(dev);
diff --git a/include/scsi.h b/include/scsi.h
index 8d6c5116419..e0b2f869057 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -361,6 +361,17 @@ int scsi_scan_dev(struct udevice *dev, bool verbose);
 int scsi_get_blk_by_uuid(const char *uuid, struct blk_desc **blk_desc_ptr,
 			 struct disk_partition *part_info_ptr);
 
+
+/**
+ * scsi_get_blk_by_type_guid() - Provides SCSI partition information by type GUID.
+ *
+ * @type_guid:		Type GUID of the partition for fetching its info
+ * @blk_desc_ptr:	Provides the blk descriptor
+ * @part_info_ptr:	Provides partition info
+ */
+int scsi_get_blk_by_type_guid(const char *type_guid, struct blk_desc **blk_desc_ptr,
+			      struct disk_partition *part_info_ptr);
+
 #define SCSI_IDENTIFY					0xC0  /* not used */
 
 /* Hardware errors  */
-- 
2.34.1

