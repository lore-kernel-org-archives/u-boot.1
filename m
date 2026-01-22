Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE59C44500
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 08:40:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5687683AB0;
	Thu, 22 Jan 2026 09:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DZ+L1aUO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="je5jyNje";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C0D0839DF; Thu, 22 Jan 2026 09:40:09 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0916F839DF
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 09:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60M7B3Qh817280
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 08:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cAJMaN9dgng
 qoGF/smq2rbrY+wxGNg1g5ugmne0tYYk=; b=DZ+L1aUOB94MtTWxnN2orLfVM1c
 2QWztNjR37O1KnyjX9a3CjM3Vd6eBmSvFopA35WQd9DSAiHCnce/MeJmAk7O0FfT
 Nl2jj485iYNrCBNbeFhN510QNxLXOq6AknQCRJh+4wo0sopVhgVoDrhMx+jApe23
 Z8hYQfyUpLfVSJ9gD2x6RjRv5c8Bkhclgp7/7F6w7Xr9Fd/+yYcRbeFytvZVy67R
 P72GzgePsHMRMeSI3O7Ua6aVMKf5uixX/0a6Ef/bRzu/eBxB+SFy1Ira0sZXyE1s
 QgyhwjCtfWipJJgxbhO82RLfWj64D0xXCkLV1JEXS6b99Y9XVtAuFImk7ew==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu65v1s1m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 08:40:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-34c5d203988so1407242a91.3
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 00:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769071203; x=1769676003; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cAJMaN9dgngqoGF/smq2rbrY+wxGNg1g5ugmne0tYYk=;
 b=je5jyNjeAAxbVXZFQUT9ViGnLGDBDL20AT5CpM+m5vFQLwwbCRt7+jFeL5WG1bf1BW
 lwH0uFR50MfycmAOHOLNp4LRQYgmVm7YV4D+l2U53r6FO8hhx09cBZaV1cxF2VylMAq/
 kfBYPEF7z6CGmggqpP92mqjqaQsHniRzwUT2ypNHY1hMZphbUf7mTDTugG3bsied5q70
 KZpB5DgZV7XNERlxKgfGYCjip8aX5efbNjcByoTukJzP086o/tU8hmQtsd8+pBDJBPDr
 cQLcyB/lSVRscDQTBSEisdd3+FZNp1yU5g1jiqXQF8JFkHbnE0AkXcNoyiGdKrbKAZZI
 Vt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769071203; x=1769676003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cAJMaN9dgngqoGF/smq2rbrY+wxGNg1g5ugmne0tYYk=;
 b=hASAMuQ6gbpkCwvJv9keZPBeNs+tqP4NQaqW2BXdjsO8HnSK6CzpOrrq9JRH4o5gqS
 nwKaUSmfzKeI9s7D6dDR1LBAXEa1pD31R+OvmOJmwDjOnd+wgH3hv9FA9zqd7uG9HyYd
 77ZQ+3AvPlO+TbLOBV8PqqsapfC2LTRtHY1Qs1k4zduJpYwGHIac6TUUi9c2Rtnvj8GE
 NcpV/ggTP5yywfgSu11GERUiavvuUIjJ/1oE2qm7hkzgo5wv9/NJBpkKoakoEJcuPGUc
 D3zqHpCDUNdopdOkdTXBDcgIRNA3MnwT2PybjS3GGwOKGPU2VwMMUr/uPeocXSTsZHgb
 i5Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNhTOYfv9mW5GCSH9eeagdMGR56QHi0Ox4oMt/dIYH8xVJu6EI0Basyrv2wR1dZsKqRCgUtQE=@lists.denx.de
X-Gm-Message-State: AOJu0Yzz/L8py4U232gpchHNXpgV/N1VkDv+scFlfGk1alDJelAN+iFK
 JQHaHjfFilKlHysfXsXYhyJqiKjFjuwXRZUwlHiOc71iucDXcZ++A6LHKXGxRAoES+0yra8sJf2
 DRbujBz5aF9yYfGviBkEHjwSuN7lHrUzwPyJBZ9gETeJr7FPhbOOePXkg
X-Gm-Gg: AZuq6aLCatrV/RP09vzPUFAwCowg6PonuykkWhkVC1aBh6WKOSNkx9lxlwlvFXs/ttF
 eejGdodz9w7QBJaHoo7a973U7GnaoDj5dcj0e2IZ7QYYBSAk4QFOM9V1lTvDofNbx/8faL+Gyzf
 VdGjh4ojYs8GDlQzgoxFGIT+PJvNJ8+h0g+Wg64j8811xWCb4OiTVzXdKcPU+2zlrYwO32jf2fl
 eb3faCRvbzu1d3gyQ68fk67fh5WKvdi8xtZfk8S5rMSk2gOaoQMJSkE1m8BwhdaBLe8h+ecQYeJ
 L5KK/QhFtYd4gjLJC+u3VuSGROJ06hZvwicr1DA+F6FWVE7jB9Ky2jV+qDhd6TODE1I6HRjHQcS
 ICZeuT8wf0DleEAEyXkAsYkfA1w2HAd4uDUuz/sTJthVkyVDNmK+K2KWM3Y5Dc2atSaps23fM9u
 81lvNeehxAC7/Or5kzMh1Wh5Yxk1uNmMHsXAeBoQ==
X-Received: by 2002:a17:90b:3f8e:b0:353:883:aff6 with SMTP id
 98e67ed59e1d1-3530883b063mr3508089a91.20.1769071203405; 
 Thu, 22 Jan 2026 00:40:03 -0800 (PST)
X-Received: by 2002:a17:90b:3f8e:b0:353:883:aff6 with SMTP id
 98e67ed59e1d1-3530883b063mr3508064a91.20.1769071202884; 
 Thu, 22 Jan 2026 00:40:02 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35335213ca9sm1720708a91.7.2026.01.22.00.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 00:40:02 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, neil.armstrong@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, quic_varada@quicinc.com,
 casey.connolly@linaro.org, bmeng.cn@gmail.com,
 andrew.goodbody@linaro.org, u-boot@lists.denx.de
Subject: [PATCH v2 1/2] Revert "scsi: sync cache on write"
Date: Thu, 22 Jan 2026 14:09:53 +0530
Message-Id: <20260122083954.2722972-2-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260122083954.2722972-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260122083954.2722972-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: W3LsWKPxV-g_LWQlTY--6stRYIGuwwtN
X-Proofpoint-ORIG-GUID: W3LsWKPxV-g_LWQlTY--6stRYIGuwwtN
X-Authority-Analysis: v=2.4 cv=J8qnLQnS c=1 sm=1 tr=0 ts=6971e264 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=h1w11nEmysqmhQMIoQEA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA1NyBTYWx0ZWRfX55RpDrh/ztBW
 l3gPTWjWEA2FT466Dr+Uge/ksubdSuhPfkp+5cUnvV6tzpxxsRgmcxCLM99xTDRIiDVvxVXmZBI
 18GKeXOhYTKezwGRT+nLVULLOh0ol+cqDDATTlKcGKbWROLGbdpvTi+Q5luT3NIYzGFBRwqCwO+
 lOVUiByTr8SGVz4QzxWtXsFJJlxCciToi7byjVQhr9xUcIGgH00WH1+XNh01qwxFibElqO3bY6U
 9Lm3mtWampbGeE6LNyxbk1c26L1YEzeFdoJX9XDGTnpGREgWFG7Nfr0cfBeDHiaCzJtrTjoRJnE
 7vjPnXkZc0WeEiYfsvFZP33soOIhSw0EEskAHSVVHMZifqr6pQ9GQijLQduOoUQPtRad/MnS78H
 pe5ksA734jS1yRVTxcqOK68G24uc+f5rRaCQ9NAmFqN6QaJfoKw1KInVrE8T3vmXzvcYxoBr+Wm
 BTEmtXoiv3jIOSG/q5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601220057
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

This reverts commit ffe4e6ab42d2534302be825e49a2d085acf80f30.

While the SYNC_CACHE approach prevents data loss during board resets,
it causes system hangs during large sparse image flashing operations.
This will be replaced with a FUA (Force Unit Access) approach in future
commit, which achieves the same data integrity goal more efficiently.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/scsi/scsi.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 8fe6b38a8c7..2e99f68cc5a 100644
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

