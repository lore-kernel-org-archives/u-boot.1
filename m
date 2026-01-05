Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678E7C2A072
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 05:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B67583A9F;
	Mon,  5 Jan 2026 06:25:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yig6AyQx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kTA+2ak9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5B3183AB7; Mon,  5 Jan 2026 06:25:41 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B242B83A3B
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 06:25:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 604Mi3Yv3629275
 for <u-boot@lists.denx.de>; Mon, 5 Jan 2026 05:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=BJPcq0Ad8IVSLxvKXw5SSA/pXbd+0NZIZQs
 DK8GRkR8=; b=Yig6AyQxLa12eQ8Ly0OB2gjs3LB/J3y1QkcxwSssmFyWPKXxlyp
 VPBxTAlYoDVz4H7u0sDPUjqNv6ZbiEwfbm2I5cOIsLHhZHuJmwgwqlphCEJivLaW
 nMXBaDDcBScjSEcWu5Am5KfqT0enVw4eaKdgjv1rrGX0RT4r7mnlTpG2T4xIWcMc
 oYMd3WFmvDllh4I1lxSenpvOLJIk7+FCme4Qb4xVv9Lkzc5egnKzSoUADU3h3K/b
 PJuo2/+mVTFZ6jyKyDpV72JTyoQtIDXh1jzBl8S37ayJ/xkAd5XqRXSmDfkYx77p
 guFB6H23TtWowB0SJUs77hh4DiyhCiVdOjQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4beu6t37s4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 05:25:33 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8088be744afso672778b3a.0
 for <u-boot@lists.denx.de>; Sun, 04 Jan 2026 21:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767590733; x=1768195533; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BJPcq0Ad8IVSLxvKXw5SSA/pXbd+0NZIZQsDK8GRkR8=;
 b=kTA+2ak9RqGRypycia0C91/mih21NHRixKgB8PBj9YktxYl+tlK0IZqW/kpSPvb0cR
 QCk1L8xvcmBQoUvXxZ2+qClfdc/zouny7UgB7lCar0AMnHtcjFQrZe4LCY/ceBzet0TW
 QJUdfgxXNkO5gzC5xGUAdme7fpjDLHnf1Ka8w9HWWLCVKIBsTvVEkmd/hZhyaOyfAMCo
 lZHrhFWq1zJFiY6UVQSFNaQ3xPD1WXSXrJ9IQt04pSGi3UcnJb8J46Yfg6sY8LVE6cNb
 9aB+cp06+swANl7y0QXqUO0s4lxBX24bQORHEU8XNY8rW7bWrtlGYQzV6D3lT4bJ+TWC
 yg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767590733; x=1768195533;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BJPcq0Ad8IVSLxvKXw5SSA/pXbd+0NZIZQsDK8GRkR8=;
 b=Ra4OXEPc5OUTy8Ua4uK98KYrrcp/nWRF9G+DXFO8bKahj3ox2Prt9dqANX/G/OLYpO
 YcVoVUkM9R1yuW4HtP9Me5cy5VTZiSrnDe8LtqzymXwdyMKTwB601jcPIUL/cvbmXFzn
 jN/gMIjjvi8xu/dVIQe3k1QQSeR+Zd737F0YDz1lHXoKbN8sZwrSXLDXThWFHZ0Nw3zb
 BA8kl/omMg1brhOEa7X79P5PsMJ61XVEvsClxIwu8J9Fiq63KSUOuArVUk8tMZ1qyRVA
 NW4l4biX/DuNF/MsK5eKqYzrjTcXz4ys3tgY0z6hshkyW8SCs8tHnkzNLkHtZf5TgclX
 GoIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9j8NBmBOtRUQue3cpJ5f+K7QycFiunZEZZkZL0WdUygKhCLnESvExwXem9bjwkrk9ubT90l4=@lists.denx.de
X-Gm-Message-State: AOJu0YyNAyo97NFxA7puwvzYRuYb0cbyy2OXhZWGryXkEBxbG1BNuYlp
 edKw9s6MI4GzcKKxshXhbYXEZZMDb0zZ9c5KRN9dd4VT9nhFosJ0ZcEAWcN7W2id7Hu+f2kuwqi
 qhWoLiE8RQOR7pVeuqkQipP+tTr9E5dYmH5qSHyztgBk84est5cpkmT7O
X-Gm-Gg: AY/fxX6D1pJhWEeVbghGRq+W5lw4dAMbExNK7o7bYtTwWEedyrnkGDvEhLqkqhXexTs
 ffREIWS5CGgDTyrEb+yEURDSkxKN5QcL+i3P9bpH0BpZPXIbuPPmNSnpIcis65hZDH4lu2RhVZw
 M291KU+OKxgDUt8pSlcr86U9WBe0SGe2cwfhfDAMS3tFjrjp4tnKduNnY7YlIwADOeVD7TBgG8P
 K+wTmr/bgdQoitwufM88VqK+HSmjvbXwHOKAcaS/R8K8JZ8vEd5BW6FfBUxK+VFrsdtHSkLiF5f
 vHJj//jS7UO3Ogt4ivShoADbX8vdUBTdzrAmyzuxGhVIPYW2JdgJRF804EdKVgJsQJbTsELNCbw
 1D8qrZJRI4M3M+KvQdBU4UfzXX/QzTvFx/CenCaQ3Ok0rNmfqR3ItU77UrTsFl8aWmtJ8Fwc9YS
 BkEaYHqYSBqnnFe3oa0dOCBfQJ7nh/9Qiu6+yArA==
X-Received: by 2002:a05:6a00:4507:b0:7e8:3fcb:bc3d with SMTP id
 d2e1a72fcca58-8148ac39714mr5842249b3a.18.1767590732851; 
 Sun, 04 Jan 2026 21:25:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEAiB5FcYMrtdKbZqFUrLShFNN+o3H+s9qbs2YwEefL//WPI8f7/3pjIAr24lGz0RkopktGg==
X-Received: by 2002:a05:6a00:4507:b0:7e8:3fcb:bc3d with SMTP id
 d2e1a72fcca58-8148ac39714mr5842231b3a.18.1767590732405; 
 Sun, 04 Jan 2026 21:25:32 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e197f9asm45999244b3a.43.2026.01.04.21.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jan 2026 21:25:32 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, neil.armstrong@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, casey.connolly@linaro.org,
 quic_varada@quicinc.com, bmeng.cn@gmail.com,
 andrew.goodbody@linaro.org, u-boot@lists.denx.de
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v1] scsi: Enable FUA bit and remove per-write SYNC_CACHE
 operations
Date: Mon,  5 Jan 2026 10:55:26 +0530
Message-Id: <20260105052526.593017-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA0NyBTYWx0ZWRfXyDJHEORj4Qkd
 kH519e/4LexkmgrIjaMQ8BLesjKSQwILqEFQSIuXCNXk2H9bdaepWlSI6sGQefch09SEb2kbEop
 7EeCMFEftP92OE3mUJnCMaw/Ce7xzxKcAT5GaaAwP0xJ3BHo9br8N8SdYgsSH0vTY1X/hvmFQdc
 eZqZPJSoHs6yBA6KFcNMujIjdMSbsfySeMhImae/V1cKN+lbLGxQgM5+2zqGTTQYig9LrqZXjv4
 RlqatuvuWEMYRqO9bZDXagEa+7SGsJn/VmGK/xPz6KgOtpOe9OehACD6FjHYIbtfMaGYwyh6iIK
 N0p41TaaUJCDCTd+NTkNeaik+/yDQbRLjn+U0BmGQy9f89lxf930+zSV2HNYrBC6EkaHyBWmCRM
 VyIO1lb79AvUxvXI6tnw+aprOIIwqeZdXmJcSj5QaGyMt8Z2phkUrwxZV8DeHIB5jUhPqXAfZad
 jwRHl6oBlGfdwhwA29g==
X-Authority-Analysis: v=2.4 cv=HLbO14tv c=1 sm=1 tr=0 ts=695b4b4d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=2KWoTbq3bzERRF-STQcA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: v0N7BKPZKH_rk2tqTZWsItmBUyU87bdJ
X-Proofpoint-ORIG-GUID: v0N7BKPZKH_rk2tqTZWsItmBUyU87bdJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_07,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050047
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

Enable the Force Unit Access (FUA) bit in SCSI WRITE10 commands to
ensure writes bypass the device's volatile cache and go directly to
non-volatile storage. This provides write-through behavior without
requiring explicit cache flushes after each write operation.

Remove the SYNC_CACHE command that was being issued after every
scsi_write() call, as it is redundant when FUA is enabled and was
causing system hangs during large sparse image flashing operations.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/scsi/scsi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 8fe6b38a8c7..b755616bf3f 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -124,7 +124,7 @@ static void scsi_setup_write_ext(struct scsi_cmd *pccb, lbaint_t start,
 				 lbaint_t blocks)
 {
 	pccb->cmd[0] = SCSI_WRITE10;
-	pccb->cmd[1] = 0;
+	pccb->cmd[1] = 0x08; /* Set FUA bit to bypass write cache */
 	pccb->cmd[2] = (unsigned char)(start >> 24) & 0xff;
 	pccb->cmd[3] = (unsigned char)(start >> 16) & 0xff;
 	pccb->cmd[4] = (unsigned char)(start >> 8) & 0xff;
@@ -301,11 +301,6 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
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

