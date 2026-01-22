Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D892BC44536
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 08:40:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E4483A6A;
	Thu, 22 Jan 2026 09:40:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kZYv8UOP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZMiNSzvy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FA8680077; Thu, 22 Jan 2026 09:40:06 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7071280077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 09:40:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60M7LXOt483542
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 08:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=L+sz9EY3UbKuGdRte71+z6tyn5kV7sJl+KN
 e4ywquR0=; b=kZYv8UOPwR+YM8KOu6pcDFE++U1Hi8HzoUTlChk3052WT7cEUhM
 5a3pT/XtF55VXv8M4U7xWPspqZWiMMZG7rYotIuFi8yneld/2sAXm5DQj5Leg4DW
 bG3jW/cXkDQHYZOJ76vK8bkxGqZPCY6Pzy5MT55n0RmLV9/UxY0S8Nzi0gas/Csy
 TEMNpz44xr5NM1/cC8q3r+eBAmDXzVBHC5Px7QfyieRBjtuAdQBtgt8XyZIn3P1T
 PtWfEyWDyCPG0RsQy+BQSyFK8FDgf4ek7mY75IT267VIJ3kdkhXrF449brmPHAEM
 y8TdBUtLL+PXv+P8bebM4rqi36Xk3z37o9A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu6pj1qmr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 08:40:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-29f2381ea85so15969295ad.0
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 00:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769071201; x=1769676001; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=L+sz9EY3UbKuGdRte71+z6tyn5kV7sJl+KNe4ywquR0=;
 b=ZMiNSzvyRqtuCgrvlWlG2mVYUww9bv08UtIEKhKUInrtrzXDoBk1u/ntQtcY3/AWCB
 ZpeYGSCKNLwmnc21/h12WFcRKxMJhT+Ju8qM06z3QkkPSevSGstCWxSK0XxDjtJic6rp
 AlQZ+5ANUblpCidI+Fyy6aHdDoT3flDtG26b66LlWecVJODQQsWXCvKfrDflIoUkpLnt
 HpGX1P3IzJB42FxCtmP8tfbdmC5SGDFzmBL3qGfqUB0gvD6sx0/lEL9WgQrkqMW+4m6s
 OEW3UT88RwTHcgQAqtuePbYA98Jjp7zxi4xmSREM+rHdT5aMvFn1ZUs4tL6aSEvVkE00
 pF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769071201; x=1769676001;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L+sz9EY3UbKuGdRte71+z6tyn5kV7sJl+KNe4ywquR0=;
 b=gs2R4IA3/fIPzEb2yUMz1eF1P49rAyyRSqKGPBZc1N1fcu2P+/fM04Q5YUplFa/rgP
 xmFGp8LQJdz7ffKcplqelQHi5+QjvtX1aXK7AlVlxscdZRjsDiZeMs2FG2XZLwVDlXtd
 CgaNZK8wzao1pwSW8/u234eDWc8Znc8qYTi+PELOIZ0LGTLWEoXlv1jgFJ+SBuH/8q3N
 zEVckkolWZfEn3GuLBol+kzzqhZPd8hElk8DEF+CYVoeG8hSuxRUA+KuxfMaWIf+mBiB
 iVzsitjLoMcr8E28MpZX5OPFtgYfRGRDTLv4h1pUKUQ86GdqxoeOAIQqEXWWMu3KMHiY
 qDoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrkRp5zBuufuE6IrOnTCUYC1VoQ8yA6Ycio/e3VYSgLYIMEXrXtqW+Qee+Pgo0A1raOrBKP0M=@lists.denx.de
X-Gm-Message-State: AOJu0YwXmN9s7nuGx0aoJ2ThaZGTDM7I+FqYhIL7NOe5vLHa5cd0appa
 TBlt7nXhO4Yqd8R7cW9lWV4QveEtN4DqGp84qH21XEwTEsUcNlLAQGDv6l+m11vPekBv3CT1bML
 X5MpnzNuO5cczYiHJxiH484iagNaZWXfpkqItI+4yk3q7kOkHwTxtDQBE
X-Gm-Gg: AZuq6aLohupnl0JAFrdMrjy8159rA+ujjVr69DDY7ZtSPHrW282Ws2GpLUHw04sVwDz
 1Ot+/dc5te8O1eJlc/nntWMScWCf+Q1MIiJzIkYMIUO7AgMPq4xitCvvy0yL2SBr3L0Koo8a8Je
 WF8IMiVc7iKITzv+Fh9BEjFXxOW2Uk23iL1T3ts6184IwQazDe90mnbPk0Fhgo9EJFcUtWAAq+V
 7RYLivWlREqQFmRSUn7zN21GSG8DIsRCWN7sIUNuqKwWr0XTbKoFuTRENFNffxy+pkJm2TqVykT
 t/qZrEc+X81n+57d4PEjilEfM9PHGMOhq5Y3DM31sAIFsiKie1fs+Euj8pTJ6ALJEyGPoMviN+z
 a8YXrqBLWZiy0njhcbtoXE6mrKkqugRt8CDwvTuVTwOrH61Pmqs7UCgNKc6VzBhSNPsQk0IW1c3
 kLjqgT9Zf5e5xur8RoL8Q9TjFieszoC2W3Mu8kKA==
X-Received: by 2002:a17:902:e949:b0:2a7:8088:371a with SMTP id
 d9443c01a7336-2a7808838cdmr63095165ad.35.1769071200740; 
 Thu, 22 Jan 2026 00:40:00 -0800 (PST)
X-Received: by 2002:a17:902:e949:b0:2a7:8088:371a with SMTP id
 d9443c01a7336-2a7808838cdmr63094945ad.35.1769071200242; 
 Thu, 22 Jan 2026 00:40:00 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35335213ca9sm1720708a91.7.2026.01.22.00.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 00:39:59 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, neil.armstrong@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, quic_varada@quicinc.com,
 casey.connolly@linaro.org, bmeng.cn@gmail.com,
 andrew.goodbody@linaro.org, u-boot@lists.denx.de
Subject: [PATCH v2 0/2] scsi: Replace SYNC_CACHE with FUA for scsi write
Date: Thu, 22 Jan 2026 14:09:52 +0530
Message-Id: <20260122083954.2722972-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=D8pK6/Rj c=1 sm=1 tr=0 ts=6971e261 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Us0OqhRn_OvhrVabkMwA:9 a=zZCYzV9kfG8A:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA1NyBTYWx0ZWRfX00/SF0wsZ/mt
 PXUB9QTjszlQC1YQX0wILpaQBehcDufPzUMV4lobigVygwxwjcx/N9CNsTTO1xCF18S2CddE4uj
 NiOcYSIswRnpteZiX8FX32j7+jmhVAXBQ2cDLiBdjOxlKSlSYIXj/crNV3vTLW97UgFgp34GhuL
 bS5eIN5zpQpTyGsHsJNnEnkzAkBJrDQ9Xe03jNomMI3lUIo3jU3bxVdECAeVpL+kw29NVUNPqd5
 FppruDeaZ4+Ne/ChGa/g2cZGYKX6vmXv6afS0Br3E1YSpv3F7p9VzTdRVMpPqOw9q9UibnK6TKp
 aUQ/WZ5itLupXlGpt3nJo2O5M46qw4ybUg78mwjNg+x5r9zHjLVCIIuyzApw0hvIJdgjgmDSgbz
 fRxEDsNUP+jPzVh31TOe/h6IZqOGyAC0XZUu6iIfCskurTC+VvguUX8OVR704q7xYuAHeWlRFMA
 3/8SI4MJMQB60rNdjDA==
X-Proofpoint-ORIG-GUID: _u-p6Lr1TYYvWr_VRpphIHK_afLkcEc2
X-Proofpoint-GUID: _u-p6Lr1TYYvWr_VRpphIHK_afLkcEc2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
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

This series replaces the SYNC_CACHE approach with FUA (Force Unit
Access) to prevent data loss during board resets while avoiding
system hangs during large sparse image flashing operations.

The previous SYNC_CACHE implementation caused timeouts and hangs
when flashing large sparse images because it issued cache sync
commands after every write operation. The FUA approach achieves
the same data integrity goal by setting the FUA bit in 
WRITE10 commands.
---
Changes in v2:
- Reverted "scsi: sync cache on write" commit and then set the FUA bit
- Link to v1: https://lore.kernel.org/u-boot/20260105052526.593017-1-balaji.selvanathan@oss.qualcomm.com/

Aswin Murugan (1):
  scsi: Enable FUA bit in WRITE10 commands

Balaji Selvanathan (1):
  Revert "scsi: sync cache on write"

 drivers/scsi/scsi.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

-- 
2.34.1
