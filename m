Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BCDF8A145
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:11:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 862F18423F;
	Thu, 16 Apr 2026 11:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="n6JnIuNT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V1zogV2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4431B83FC0; Thu, 16 Apr 2026 11:11:07 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCEA58423D
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:10:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G90YmA2979251
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 09:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 psUcOxmKqahpoc0p2mWl7enoVqWY+qAczqDSLmlikxk=; b=n6JnIuNTAFs/QREO
 SWMfA72mFMpByNpL70xmqmN4DjTRYmAtryxxMZfDpvpfTe2WXi//MLGwzpNrkVAA
 oycSYiOCQuFcePY6AzhKFFZD9cd5QFEQRr1IYV9PjZKIici8BAnlLhGiuN2skJ4m
 qByNm8mRPs9myDEgtwOmvKlzSfqJ/Y3G23sJidhzpjzR19yZzYm+5TyOyBQyyDMM
 KrGpK8nL7GXELJ2wNcaFwFi1cdX+STkQsHCg/tCnF6wX7HG2+RWvKO/rNXh79Xfz
 ORFqhkIJ4yilg1tJQzybqZuuE1FZZG5ts9tNwvgaOirHX1FwYHupQs0nNsLd7Gq9
 iJPaGg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djvru81jg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 09:10:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2eba42b8dso42839105ad.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 02:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776330656; x=1776935456; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=psUcOxmKqahpoc0p2mWl7enoVqWY+qAczqDSLmlikxk=;
 b=V1zogV2tDzFfFVOCnS9n6wYfvksb8kIKhqHz9XeCaX8Wgc+88X3fvr+Bbmcoq9d1AP
 JClNaS5Rx90XKSb2CAqPvFNAaygwib9BfuGOnnP/fM7bFV0EKoaPDzwV5etng53M9RNd
 HktFO+aS+AzXVljikpPt5rOhI7XAiBnVN8jZQoKKvHERj5R5yoCyh+7pQvwpFjsioVzR
 9q3qGhV1tNGqB5Vke+/nM3sKJkBttpSUfOa6Vu9F0a/z+Ysp0wE0Ae/hBrcHaMH7wGVS
 +ZXxlMZsBfwmDS7G5vcgb7rZ+6lvRhZTTFlzU+xTR0thF3Oe0qPvPnQs6r5sqCSZ9jfv
 N/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776330656; x=1776935456;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=psUcOxmKqahpoc0p2mWl7enoVqWY+qAczqDSLmlikxk=;
 b=Le0xxtl5YrzW2DV4xesQCT1rcTP8la3wm9Yy2VmI+r0H+eFEMMc9QLDf1RNWFq786P
 emZlpnvD/reRuvTBo//ox8D1/P4pXvK5qsnsCFu9vBUK5eFSIjNG9gFsx07yukbBQfNg
 +nTcyx98otvTM9qdCd578Bvq+txphxRbW4M0FgWc6btzgctwiw0IjhXYUwgaMj0I0mNU
 x4lraqHLgG/IxJC5sOxV0PUvVH3MSpgiTRHgfWeY/aKcWPwG+PXp1zfma4xZFD8k7j/e
 5BrEIyhg2OXgHL7SlhaBfNBVDT4CdYYKY/9k+9Y26HQOLMswgwY1mHRiafb0ppogTnbN
 +nzw==
X-Gm-Message-State: AOJu0YwV2S7tgbh0ZjrCaNH9gv7sxi4c1r9CMhUkgMGXzxYvsLEcVjKS
 jJNK8BCZX3YrodYNRtjhLA5wcNoH7aooak7o/V6ibEOwthKlosHvapTH0IKH93ZmMymW1S4fzsG
 Qy1+5+SOcxmW5QluYMWWkhcQbu3NO9xtH9/GEncesrs4h27lJlDqp/bun
X-Gm-Gg: AeBDiesMS9g1Cj0/8r+6BagwRWcgvz85qZbxqSq5AHwqZfvL1vZm78ugryJNHOjfMV5
 feH27gqS1dw7TRh6cF/bB6LGJCmtjE0a3QEmP/RpFSwlJGvfAp1ueQ9K8tfOVEkS04bpIpAr+DZ
 2foz40mkYnL3iTVypQu39ynV9m2c4u8M1naqup8Kl6OKUNOyFB7nzK43F+k/xjK1GpD9ZlszmFQ
 zbUL3TgVegSLL8XIBDP/prXoWyEUZ0ddNFsOdJWfjTG7YsLcSmsz5vAbGA3i8w9/FgaKCbTYmKh
 +HNsqizNuIuQD0bC65zn1p/4v0eScX6JaEqcxpytXTsmySYUh3o8ADoctsGAiDDIJtFq/EdcrvZ
 Il6dAEVOqR1DtB0qUPuCokZFcY/WZdxjURUfAkrXGH/kX2rwsLnu06EMlEwCA8CWqAZBtkIg4S3
 uqQ0Z87rlw1Ck3NH4A1EXkUKr0kbSa2lFbYAzqpsMHpw6rhUjziA==
X-Received: by 2002:a17:903:2c10:b0:2b2:e6e8:3c09 with SMTP id
 d9443c01a7336-2b2e6e83e45mr177241405ad.40.1776330656216; 
 Thu, 16 Apr 2026 02:10:56 -0700 (PDT)
X-Received: by 2002:a17:903:2c10:b0:2b2:e6e8:3c09 with SMTP id
 d9443c01a7336-2b2e6e83e45mr177241075ad.40.1776330655756; 
 Thu, 16 Apr 2026 02:10:55 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b47810b898sm46211895ad.25.2026.04.16.02.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:10:55 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 14:40:46 +0530
Subject: [PATCH v3 1/2] Revert "scsi: sync cache on write"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-enable_fua-v3-1-84508de2bfd9@oss.qualcomm.com>
References: <20260416-enable_fua-v3-0-84508de2bfd9@oss.qualcomm.com>
In-Reply-To: <20260416-enable_fua-v3-0-84508de2bfd9@oss.qualcomm.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776330648; l=2029;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=o8PwxZfXcVL44M49MTd/tAXHJrEfHBvmrSSCiqJGpuA=;
 b=z2Y2aoqfLkE455vOT5pOs/Tqe8Zfuxv/9pyD4XkUKe9B198OwX/wqZPg4dNV8ip+LtiB/GBZu
 kP/6T3SgEGqA4nZn3V8zS52eXpTJK6uASGTq8Z+IrcRGW5SgzQq/lJU
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA4NiBTYWx0ZWRfX5H6G0lgb/yyO
 ukyi3iyiuKQ2zEVHGAj1Jct4h4O5MHDebkNJvMWY39TQWOqX/BxnZTN9/L9/uvGzGdi8ajZoBMB
 voFnPPkaQUTI7Gp+9S+ET7xb0tnOrmTj1VS7E3RJZDyyYkiSs4A6rXPtuieNqh+AGvmcNcDjfk5
 xunpUNOqHRBd5k4e+6NREGfJJ+w18oR6/7LDi2NTnUYxD+I+5njdEXuv2LgvE/jGp6OL8ILm+o+
 F+4kKH8jYG6pOq77Ixm8nD6/BVxQ26GkGzGfsuO9WegrRoL5OEiqciSXB2Q0UI2+YD9wTyv9qZj
 H2l6z3VJwU24kzpLs5SK0ctRVs4+x7igNeUNeOCqKeiDSz5XHnpule8akTAP+a67fsgvRVJXTIj
 H+LDgrkxBau+NQzuEjUXaENOjS+KjNdTHq7IsXqqJ/GsFWwFUyC09GkmqH9xTj+IKpD79DZEJKw
 +wMYl0S9XISZ+O1uAdw==
X-Proofpoint-GUID: DQHD7Itkifj8t2e0BTF3E8cb2oNgDrU9
X-Proofpoint-ORIG-GUID: DQHD7Itkifj8t2e0BTF3E8cb2oNgDrU9
X-Authority-Analysis: v=2.4 cv=GcInWwXL c=1 sm=1 tr=0 ts=69e0a7a0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=OPt5pyjpXDMeivyPd00A:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160086
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

While the SYNC_CACHE approach prevents data loss during board resets,
it causes system hangs during large sparse image flashing operations.
This will be replaced with a FUA (Force Unit Access) approach in future
commit, which achieves the same data integrity goal more efficiently.

This reverts commit ffe4e6ab42d2534302be825e49a2d085acf80f30.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Changed commit description's structure.
---
 drivers/scsi/scsi.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 116b696b08d..9a417795851 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -82,23 +82,6 @@ static void scsi_setup_inquiry(struct scsi_cmd *pccb)
 	pccb->msgout[0] = SCSI_IDENTIFY; /* NOT USED */
 }
 
-static void scsi_setup_sync_cache(struct scsi_cmd *pccb, lbaint_t start,
-				  lbaint_t blocks)
-{
-	pccb->cmd[0] = SCSI_SYNC_CACHE;
-	pccb->cmd[1] = 0;
-	pccb->cmd[2] = (unsigned char)(start >> 24) & 0xff;
-	pccb->cmd[3] = (unsigned char)(start >> 16) & 0xff;
-	pccb->cmd[4] = (unsigned char)(start >> 8) & 0xff;
-	pccb->cmd[5] = (unsigned char)start & 0xff;
-	pccb->cmd[6] = 0;
-	pccb->cmd[7] = (unsigned char)(blocks >> 8) & 0xff;
-	pccb->cmd[8] = (unsigned char)blocks & 0xff;
-	pccb->cmd[9] = 0;
-	pccb->cmdlen = 10;
-	pccb->msgout[0] = SCSI_IDENTIFY; /* NOT USED */
-}
-
 static void scsi_setup_read_ext(struct scsi_cmd *pccb, lbaint_t start,
 				lbaint_t blocks)
 {
@@ -301,11 +284,6 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 		buf_addr += pccb->datalen;
 	} while (blks != 0);
 
-	/* Flush the SCSI cache so we don't lose data on board reset. */
-	scsi_setup_sync_cache(pccb, 0, 0);
-	if (scsi_exec(bdev, pccb))
-		scsi_print_error(pccb);
-
 	debug("%s: end startblk " LBAF ", blccnt " LBAF " buffer %lX\n",
 	      __func__, start, blocks, buf_addr);
 	return blkcnt;

-- 
2.34.1

