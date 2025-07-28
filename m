Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD548C83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 16:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31C2982C87;
	Mon, 28 Jul 2025 18:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jFYLUt8l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F47582CBB; Mon, 28 Jul 2025 18:21:17 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A840782C84
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 18:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlO4T018954
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 16:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=vGjV239jyvu6GIVc4BTrlitle5Xf1dgHL+3
 3AMFp+Wo=; b=jFYLUt8lKPXuXHaIpDMeMoTYWgAWtW9UOXYNT6OEP469g5QDNF5
 f8Sorgcf0RhGds+McPgbDrx6FGuTQNuC1e1n3N6jV+TyUiUOlGBMU0MFM9oeH8HS
 H2kWbWqWkThMxgN80Wnuv3ljGiLsyxfO2savW3FzX3n3WSsvwgPbCqUCLvBETkFZ
 zC+EXEkoI9vmR++oDFF1Siz3bmJ1IfeNX1HLRw1775mq9JgAwUcodIRe8ZcIck5/
 xthsqltj62MU2A9bkZEkg3i1fHcwHeVMnW5ZXBx2NAhs9RuGAc3AfbwbGrr2o+C/
 GwnaWdkF0B/rPddGKAzzSJ/1Bnw+rRcSr6Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q85w84v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 16:21:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-23fe26e5a33so24877185ad.3
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 09:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753719672; x=1754324472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vGjV239jyvu6GIVc4BTrlitle5Xf1dgHL+33AMFp+Wo=;
 b=uYFuQEWUgCEjp0ygs7U+WwEczODqVch1WcRFllcEufUR9Ac3SgsrvPGTIXaShCN0HZ
 HRAIrYpqHACUlxjPvVOsuRb4I82qJ+tPd43fFMPjjeHZ6g16xwHfzBVqjTVo/M7FMzco
 +3tSVsEoee8/h8bbuujCAITVlsQckIjB1vhU/f5F+Td4AwRUEs+GuzL+YLwEZdlZ7Das
 UDDHM06EfjFJcka4a5g64PftL3WSC6F9HN1GlXIGwDJQfCPwmA6KmkfXvAtbvNw4XHUW
 /aW3z4huwCq5FMO2PP/V3LX8jOOdJSLezxQVSoUGT+ja0Joz/su3CXs7fwKhXA211oRn
 8tHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjaA5PDkiMaoxTYagTzsdBjnyILy4iNxZpGV+iLj0974scu9xU15OqrFYBcpJbxbdpKmMUm8w=@lists.denx.de
X-Gm-Message-State: AOJu0YzyI53eR8nl6qshytbsreq9pSCbIoBC8lzn1qW2sRn5IyvSfe7Y
 o6IGVqFNqUqhqyLua9fGTGsZa+nTMwuylj+Cgx6pDzL8TKaH20goNH9iWdDdIIvy6/48KqzST5O
 oHGXO+dchPtLfCYUnOngW66DAT+IRFKNISfhxJz6gBn2GJ0PP/mFzBf0R
X-Gm-Gg: ASbGnctMGe2MguZAJWrIj4mvTNsqX3HuGV0YZjt3G4n5QsdAhu8hKmjfEVrCxQXktTf
 GBg64cN1uC1Xx3gz9H9AwKV7sKs0G9XHZ4GepG0ohEuyQOUKcVW1QpQUEUMxdmciez0S2xulVsS
 GwyBBwKAXFWhOFYSQ7EWeavJWm04M5W2ykPyOFqS2PTsPpq8m/CPybHp08DJftnsnBDcV8c19X8
 lbTCoE14phgu0uSjlwAu1HGY0gmAx8GBVj3DhvKm4joXQ5NAdkY51rW2RZcEFwsoTJOgYeqI9Ru
 ydFz4AvpJwxqytS59bwCsTghzZSte8Rslm9yrGwiU4KvS4c3R/IlfQXsxFxvZM/w4TK4hhwScB4
 JiLOj7uEXOqC+cCK0e7DnkKzjg+Hf57M8zsWMnAntdBgy+jdYtYFjKyH56CxE7X2svoOL
X-Received: by 2002:a17:903:fa4:b0:234:df51:d16c with SMTP id
 d9443c01a7336-23fb30e8d49mr223086755ad.45.1753719671974; 
 Mon, 28 Jul 2025 09:21:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0NatHOVCTrAAfZYhwltLn0IotMi4vTEMUjJRlsRNo3jRCXjtdhXE2EZLkS209U5vPVtEX6g==
X-Received: by 2002:a17:903:fa4:b0:234:df51:d16c with SMTP id
 d9443c01a7336-23fb30e8d49mr223086215ad.45.1753719671390; 
 Mon, 28 Jul 2025 09:21:11 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fd45617efsm50944015ad.176.2025.07.28.09.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 09:21:11 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 casey.connolly@linaro.org, andrew.goodbody@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, lehmanju@devpi.de,
 u-boot@lists.denx.de
Subject: [PATCH v1] drivers: scsi: fix inaccurate block count reporting in
 scsi operations
Date: Mon, 28 Jul 2025 21:51:05 +0530
Message-Id: <20250728162105.63429-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDExOSBTYWx0ZWRfX5fWqD6ty4H5s
 0z+SG31x8DNFfFnR09xLTfmd7PikwAf/jgL0zwgBntP7hYs972zdJBvsJ4nFPom3zGgl5EDMYUj
 +FhzJFOpaf2jvxmRdIyMIKDy/89u8uEoeCOH6EFSVKiewuThPoqWJZOZ90fZ9p71m/KlsTFGT+j
 gl44scRQim5Surf3rGSnZZjwkbGBhTEFchZeuzvQytWseGFZbV3/aBB7fxRUHLG4n7IAfk8hUQJ
 tRYX+qNDxzBTBsDVbWWKHnYu1HFQrJAkbYl5F8J9QvAKZzLCsrf359j2lc2+aGQzHMTErPOOyNq
 tOwphIzqfx7MkY8ZogKUUCmG/KqXv8/LQJ4Q/bu6eXMvotfQcz416GZxVBbDHteQR2dpNk3P2ej
 zhkgg8wS737SHMeCGx5dK0yQoo8cRT0ONR+Vw56HX0SCQbe5bUEMPJgS/LU8XpTq9OoY2b3h
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=6887a378 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=uMgWRyxlToiOul934a8A:9
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: kK9EaYBZ6_8D81x415fDKRKmICoY_4yl
X-Proofpoint-GUID: kK9EaYBZ6_8D81x415fDKRKmICoY_4yl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280119
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

The 'blks' variable in scsi_read/write/erase functions is updated
regardless of pass/fail of the scsi operation . If the scsi operation
fails, 'blkcnt' is updated using an incorrect value of 'blks'. This
wrong 'blkcnt' is returned to the caller and it assumes all blocks were
processed correctly.

Fix this by updating the 'blks' variable only if the scsi operation
succeeds.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/scsi/scsi.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 78efed6b66a..05608399be1 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -228,13 +228,11 @@ static ulong scsi_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 			blocks = max_blks;
 			scsi_setup_read_ext(pccb, start, blocks);
 			start += max_blks;
-			blks -= max_blks;
 		} else {
 			pccb->datalen = block_dev->blksz * blks;
 			blocks = blks;
 			scsi_setup_read_ext(pccb, start, blocks);
 			start += blks;
-			blks = 0;
 		}
 		debug("scsi_read_ext: startblk " LBAF
 		      ", blccnt " LBAF " buffer %lX\n",
@@ -244,6 +242,7 @@ static ulong scsi_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 			blkcnt -= blks;
 			break;
 		}
+		blks -= blocks;
 		buf_addr += pccb->datalen;
 	} while (blks != 0);
 	debug("scsi_read_ext: end startblk " LBAF
@@ -286,13 +285,11 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 			blocks = max_blks;
 			scsi_setup_write_ext(pccb, start, blocks);
 			start += max_blks;
-			blks -= max_blks;
 		} else {
 			pccb->datalen = block_dev->blksz * blks;
 			blocks = blks;
 			scsi_setup_write_ext(pccb, start, blocks);
 			start += blks;
-			blks = 0;
 		}
 		debug("%s: startblk " LBAF ", blccnt " LBAF " buffer %lx\n",
 		      __func__, start, blocks, buf_addr);
@@ -301,6 +298,7 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 			blkcnt -= blks;
 			break;
 		}
+		blks -= blocks;
 		buf_addr += pccb->datalen;
 	} while (blks != 0);
 
@@ -322,7 +320,7 @@ static ulong scsi_erase(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt)
 	struct blk_desc *block_dev = dev_get_uclass_plat(dev);
 	struct udevice *bdev = dev->parent;
 	struct scsi_plat *uc_plat = dev_get_uclass_plat(bdev);
-	lbaint_t start, blks, max_blks;
+	lbaint_t start, blks, max_blks, blocks;
 	struct scsi_cmd *pccb = (struct scsi_cmd *)&tempccb;
 
 	/* Setup device */
@@ -339,19 +337,20 @@ static ulong scsi_erase(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt)
 	      __func__, block_dev->devnum, start, blks);
 	do {
 		if (blks > max_blks) {
+			blocks = max_blks;
 			scsi_setup_erase_ext(pccb, start, max_blks);
 			start += max_blks;
-			blks -= max_blks;
 		} else {
+			blocks = blks;
 			scsi_setup_erase_ext(pccb, start, blks);
 			start += blks;
-			blks = 0;
 		}
 		if (scsi_exec(bdev, pccb)) {
 			scsi_print_error(pccb);
 			blkcnt -= blks;
 			break;
 		}
+		blks -= blocks;
 	} while (blks != 0);
 	return blkcnt;
 }
-- 
2.34.1

