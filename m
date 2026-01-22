Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06321C44536
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 08:40:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4765839DF;
	Thu, 22 Jan 2026 09:40:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hXMnRR5y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iUWBq9fc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C07483A1E; Thu, 22 Jan 2026 09:40:12 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 018F183A1E
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 09:40:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60M65F0G3902078
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 08:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=os7Fp0f+TLb
 18mYi03YihNtvP0DToEa9YBzE9/q+a10=; b=hXMnRR5yaVkAXFg/hLgkfNSDohg
 GQoFQcuMBdO0tYYeDD1J1rGTuEtsNbbmqQcbz/T3ufFOFIKCr9XokC9cMz8aV7RT
 4rfCb8rt2LGqQ3RH0K7eAlWx2X0LcCbuAgYZQdr8/hiuYIXdFhF9b2yofU37uft2
 WgiZMJmyJPD3f6azOueIUO6vc4n+xptIHQm8ea7+YrTwnUWKT+RPyktw5JIPLRLY
 3migCB6kMS95tlThdaBmPnWc+PQeIUP5Jj+31JLnqN0+w/DN/eaoNoM6O/jwY8pN
 Za9xG8zkj3cjO+6Zw6T8MidRiRgUOlJIH7v1ddcgNfvZ/LjpFEF6AxOY8wA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu4khj3ed-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 08:40:06 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-352b6ad49ddso506816a91.0
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 00:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769071206; x=1769676006; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=os7Fp0f+TLb18mYi03YihNtvP0DToEa9YBzE9/q+a10=;
 b=iUWBq9fcAI06HgOTLutnGB44VAd68Dh02w7hcsNSKHmfdiNz+JkNRGMwlukIy8ikfZ
 L5a6pH3F1FczVWl8yUUO7MxPHmvtJ5P1qih8WjWMnNj0q2BI76D+fwT9Rffbd5rutnOj
 Y5MvJdMK/PDux+NSj6KMTvalGf1479suiRtUnWHWC0vxS7injY3JwQi2KTBC37cvFMaI
 wgHZVHFrG/jqJbQdBvaQkA27u5G+anb/vWGLaCPtPHE8RRQSTYNyTKVcqzMlpiZ/nBEQ
 TjeJGHpNxaJ7sxsz2s6IunXoCgnaavD5QKjXVNpvtt2F16ITrrPPGn7cqY0QzVRocWN7
 6i2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769071206; x=1769676006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=os7Fp0f+TLb18mYi03YihNtvP0DToEa9YBzE9/q+a10=;
 b=d+1ReV1UtDaghBi9UHNFA0xZg1tdn0P0h7B4z6z0XOYPk5eewf0ykRHXwXmA3D5767
 PmIL64eNmzNwlBcRg5AxMo1+q1wEP1UrcmBdHzfIOW5RsFAIyLMO5AhBLAtZxJN78ql+
 Otz3BjAy0VDoUZ9UAIXl3P4EeOunBnEyAxAjj7svMk/53NW5b8n7ONFIPoP7WhtMhKW+
 Wc6Xa/TxS4BQCd4ZFtwO08/zNi3nBMdBjR6ibpzgEqIkyivQVN8rH6w9qpi2rUKVx/6g
 1f7kzgHBhuedRFjOOuG9c/13rPCCtKTMnDjLDE7MySfTl78gMZ6gXTc9ypSYkIYENTL9
 Upug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK500EC+F4dbLu0/5Ifng6V8yvYxDyRqF6U95gq+SGj9l7dc1MrHCaegAbTABZZUZOgHCzJGs=@lists.denx.de
X-Gm-Message-State: AOJu0YwmYy/HunNtBq6+52TiR0VNO4WwVIMXbXgNAS78CKvKyJGucMGl
 JK3xZwJhFUcmTB004sy4fl3YKkCZjtn4I52QPfnmVMZjVlF3orpEIJi4UhAT75npVF4aXagNd7i
 s999ISUu8ee31tjr5U7U0RD0ytyhPLE1pg+MzhTMLDxji+vH8kZkrj7NT
X-Gm-Gg: AZuq6aL/r0wRHFgvPqr5WjH4MQHe7AKaVj7IixUmqR3OHWoWdtECJRmmZ26Tb5++Qrz
 LYceNbw1Djn+MWwYKvLGZhE1qz2MBpoimAGsG60cAOvLY07Wa6SHWRUpF47qAGlw01w50eLZUYl
 Zg2SbVXvjh1jdYpAdmEGfP2PT9EUsldNLgGRv5ledj73JUGCIRWbFdzxkpbfE37qM0HzOA2kAza
 y0sBZ2JcwK9bf+sAzAt5IPW8NO5uZJxF04AtggXyh7R9EyJwASJzIU3aoJWHvTWQzrdE6TrOvEv
 rZyKdXDUyvMQsSApX3rTLV5F7EggU33WeQrJcoN+vitj01q9AUvaIRRlkQ8pyykXNKY0WcdFKDx
 C5TqU5T2X+RfKMgITixwliqal2YKIh6W5L2fvdOrOUdte45M7n/N8b5p131CNZMel0ga9tpYCyt
 e13lpzbzWix6nJWjHEsWzF61Kpx9KEjM1U7t2Xvw==
X-Received: by 2002:a17:90b:1dc7:b0:352:f2a6:334 with SMTP id
 98e67ed59e1d1-352f2a6161amr5210343a91.16.1769071206209; 
 Thu, 22 Jan 2026 00:40:06 -0800 (PST)
X-Received: by 2002:a17:90b:1dc7:b0:352:f2a6:334 with SMTP id
 98e67ed59e1d1-352f2a6161amr5210329a91.16.1769071205768; 
 Thu, 22 Jan 2026 00:40:05 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35335213ca9sm1720708a91.7.2026.01.22.00.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 00:40:05 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, neil.armstrong@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, quic_varada@quicinc.com,
 casey.connolly@linaro.org, bmeng.cn@gmail.com,
 andrew.goodbody@linaro.org, u-boot@lists.denx.de
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v2 2/2] scsi: Enable FUA bit in WRITE10 commands
Date: Thu, 22 Jan 2026 14:09:54 +0530
Message-Id: <20260122083954.2722972-3-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260122083954.2722972-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260122083954.2722972-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA1NyBTYWx0ZWRfX0RtlMV47LnyV
 nJ49CF3+AbsUByYXS5o6GWr59tmNIGTSnwqEXCJ5KdjHB3BXPCCSKRd32fJCmg53F2Z+9ZFn2Wi
 CLDuOnlNXRWBjKYp+9NZKcEmF8AfbG8tnV0eh7+zEcC6QzjD+n3+Is7cHDfZ4tsX9qJIrz2jZeY
 UwahHm8sd5QXqNF8njKPiMbexFJqZG4xa1EtRT1+Lf7JuWXNt+KibiSH3ZGjRJC5iZPFMZDyFe9
 9v5BB0gKkei82jm3vW5YMMNDhSK8UxWful+zIR8TE3Tlqm9eghFBkbbLsg5mLymRLBG1LTKcrlX
 9gUFto3Em2Gg1+N5AicJDWKSObt6vjRwpP//Yf1ohCb9OsKNjXgE8Wj9+6GkmzE+xqjeCDZ7JIi
 jS2YfEK4ImhniACytMB8fd9ubbDM6Ti3d3gKt/h56vnitG+8N3Pvsre0bVZwxy5LU/BtfLvTFXn
 w/KMBOOsiT5Lvj8ulvg==
X-Proofpoint-ORIG-GUID: YCdjiinxuH1A8dI9zefPwVbdOJY8Fmt3
X-Authority-Analysis: v=2.4 cv=UOjQ3Sfy c=1 sm=1 tr=0 ts=6971e266 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=2KWoTbq3bzERRF-STQcA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: YCdjiinxuH1A8dI9zefPwVbdOJY8Fmt3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 priorityscore=1501
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

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Enable the Force Unit Access (FUA) bit in SCSI WRITE10 commands to
ensure writes bypass the device's volatile cache and go directly to
non-volatile storage. This provides write-through behavior that prevents
data loss during board resets.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v2:
- Reverted "scsi: sync cache on write" commit and then set the FUA bit

 drivers/scsi/scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 2e99f68cc5a..153b4841add 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -107,7 +107,7 @@ static void scsi_setup_write_ext(struct scsi_cmd *pccb, lbaint_t start,
 				 lbaint_t blocks)
 {
 	pccb->cmd[0] = SCSI_WRITE10;
-	pccb->cmd[1] = 0;
+	pccb->cmd[1] = 0x08; /* Set FUA bit to bypass write cache */
 	pccb->cmd[2] = (unsigned char)(start >> 24) & 0xff;
 	pccb->cmd[3] = (unsigned char)(start >> 16) & 0xff;
 	pccb->cmd[4] = (unsigned char)(start >> 8) & 0xff;
-- 
2.34.1

