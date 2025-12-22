Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4CDE6748D
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 09:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00B1983BF1;
	Mon, 22 Dec 2025 10:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mE2AV0/R";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CwAcpg/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFD1083D3C; Mon, 22 Dec 2025 10:01:16 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DF9083B99
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 10:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BM6avPS4119279
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 09:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=CkiWs4KI9GSSzW1/Lj6bhKlgCiEB79aqbID
 4aYtPcP8=; b=mE2AV0/R0U4RirLF3ODu/jBhlHMbis2iUnBK548FdvdzYYp+tz5
 KfdB/XNJVvA3yxUzZfAlJ7e8gaD7Dnd1cr9UfEGKcBPiuClQL1wKfBEJUgVnSwqX
 Gu9E8CIDSpBKUVFUUCI1T5VsOgJ2tdiO74vyP/SAMV1irj735+6hWCI/ybFoj49l
 2gGdqIF4kV8oOzRgGqx+wTpdvNNjZygLoZau6VNqma3gnxI3GC8em2tJoXleGgQ/
 tOgSMUacEmnF4CaBp3dRbFCXHAKSmY32efPX/XfR9Wt7mR7iJUE06LyuMAtyTRaH
 pRS01pNU8O/MW7wD5wdk7uXNmWffaW5pj4g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b70v28dn4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 09:01:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a0d43fcb2fso120298915ad.3
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 01:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766394071; x=1766998871; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=CkiWs4KI9GSSzW1/Lj6bhKlgCiEB79aqbID4aYtPcP8=;
 b=CwAcpg/SN4texoXOjsKPrCZaMQa7H2Zumfw+6AICFzLK6EFUpqLLzWydFgYh9e4hYr
 exORA4l73pYOByl89lplmAjoRrwq4FQ6lnFasjqelRLH/jmuR++3KEJxZ+dcW8PRKGKk
 e+Pu9YDajemapnQxHLCVYvLDHjbkebUazQ6ESSio331BLfmG6l1e0VTJct766BfdWdC5
 2of0Pg5SvhXnNt9X2EgyNLNHSI6MhgLOVrDc4z2g01PzqaiIsQ1OE3Cb7+TPj/FpkZK5
 oy8IKWC/1Ya0Xm7hyYTr8HOooxeC+Fgyvof4of4x2WGaeoRz4zkS0zQZh8rTHvj53Ta2
 QZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766394071; x=1766998871;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CkiWs4KI9GSSzW1/Lj6bhKlgCiEB79aqbID4aYtPcP8=;
 b=MABBlVTBcJK2qpT+cEA2Bg4Uiq5+UBBzgMit5e8P0x18hK3yHBtaX6NLDu4r/RmWKJ
 U3eMeHPfsVQK6wlZVUx12aAnybeXhKwUEu5RALopx0PRsuMg81QrhAJFqle2yG14Rq5f
 ORPuT5JH+PlSk/hIumv8hHuQxPQAon+fVB7Ng1hlzWr9RwXfZMAlbwdt/54qF7vd6SKB
 KI7qIWzB//reDdeZioBEyvIXP9cinh+6mJk4keKDAXcGGZmMX4y4vfnYvm5ioVflXrvQ
 /OQFB08bLMGxC+r0+SPimo+ssp7t1lmqwyp4w4kh4V+ysdGcaC/Vz+49Adm6+85W2E9I
 E3tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwDlBoFdGyEVTSST8NyB7UvaczYL8rjWx1AUrq250/jPiMo+j3KKdKFNF0xTZh2hxzEzhIQTA=@lists.denx.de
X-Gm-Message-State: AOJu0YyaycvGpL1PDgpV2Yy43nhBZOR8ZpdIzYT1VdJZRipvOnBb/Zk5
 VMBVmlf/APPKTUyjLlQ8sWnJPXgCCh9QBu2uNbGh4WmC7JJ4bRREZ5XHgtFJWH78gaqq2duXg5v
 NCi7H8waUBptKHuf5E+pucxb0/jXMcLoQgE3pTUYBDpjpfPkC6Y3bRkql
X-Gm-Gg: AY/fxX6bVbJ294vCOYKRHDXaXDK4KwUGVissRiNb2V1PaUQqWlvnFpYuN717vTLkft+
 nzvnw6YQNgMUBXzWk8DsjHTLl/NbupB92Hxhg9FzgodBbArZ3Z/YOy2YDybXvLLx+9FvwqFkrly
 HfHmpCQvi8CFEf+HZKPQLxNT/OWDqVhygnfTv86UziHMrmngXMhR6wqfipW9BGj50qpqvRzDXEf
 qCYQVQgSQNlNiKrzOF51PXQgfQhBB8eUDefDSzxkHQ1i1GPMl2SzcnY/+++wmrkjnm3RipGUimC
 XQoPqadquqR9NfSdsW7ZwEKXXXUP/j8M26rtPU4B/InRcQ/Cw3LqkE9ZAo+jWRoN4X0XyPJ+WqI
 +XCSzNKKNG4y4pVXRULrFumaZo6OMdA1lPhQSc1sQGcv8hQevfRhEDbeBBmu3aKpNGBdWfx+59T
 X6iM1k/06S8+pAy3V6bNCpUvzISF6qb/1QeQgpTw==
X-Received: by 2002:a17:903:2345:b0:2a0:d43f:c934 with SMTP id
 d9443c01a7336-2a2f220a644mr80682365ad.8.1766394071430; 
 Mon, 22 Dec 2025 01:01:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMQhxX/yGWw916wMPt78Um4kkb3wJuAMQHZoIkWa0zhgzzIc/WO7cJRG8SII14QhYWcjt8mQ==
X-Received: by 2002:a17:903:2345:b0:2a0:d43f:c934 with SMTP id
 d9443c01a7336-2a2f220a644mr80682165ad.8.1766394070911; 
 Mon, 22 Dec 2025 01:01:10 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d4cb82sm92010205ad.52.2025.12.22.01.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 01:01:10 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 balaji.selvanathan@oss.qualcomm.com, casey.connolly@linaro.org,
 andrew.goodbody@linaro.org, bmeng.cn@gmail.com, u-boot@lists.denx.de,
 mibodhi@gmail.com
Subject: [PATCH v2] drivers: scsi: fix double decrement of block count in
 64-bit LBA path
Date: Mon, 22 Dec 2025 14:31:05 +0530
Message-Id: <20251222090105.2275585-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PyTSR7cr9Oue7cxGk_dJ83uv1nq5PV_8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA4MCBTYWx0ZWRfX2f4HbWJHETP8
 ljuWfCwXaRwRJ0DH2D0U8mcfIXllxRhbiP++ji3/me90580sg2jpfF50aoHnW4f7zBIUa0rqFEL
 QpFP6p6xTA7VZSWzsl6rFQsbRAHhGUvzfNdG1l7kMQsNx1qfRFA0HJdKg70JVfiU0U4SPg4ZB52
 wEGzVa+mqIzVsjTTgYmsSSu/j72vGPfoxAbLiFHz4/NAbw+15JgrqRNElxwQ2Zg20e3nnJ7G6V0
 B753LFTxOrVD2qCVmXbnpl6//xv3JEOuuCqjL187yvQzkBfzchLXWIlPFemU9m3NgOsFOpGTULw
 DJfT2WXDuwW3G3hppjYpJN3N49JhcBCkxX4Pnj23mGRmzc9VVj5i+4k+WKT7RNcd0L+EQ8k38Uz
 gHhQkIKHcl8idHpImXWZc4iyCNhSRuv6k5heIXXJDdrwMmDt03L7heW/Xdqhgr1zVBcAPgWt2Oe
 RuJ8euBgXhO8syb1IXA==
X-Authority-Analysis: v=2.4 cv=YOKSCBGx c=1 sm=1 tr=0 ts=694908d8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=L9jSeA6C3EV1Bkh-gcAA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: PyTSR7cr9Oue7cxGk_dJ83uv1nq5PV_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512220080
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

The scsi_read function incorrectly decrements the block count twice
when handling large disks that trigger the CONFIG_SYS_64BIT_LBA code
path (reads beyond block 268,435,455). The variable 'blks' was being
decremented both inside the 64-bit LBA block and after the successful
scsi_exec() call, causing incorrect block count tracking and data
abort errors on large capacity disks.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
v2:
- No changes from v1; just a resend
- Link to v1: https://lore.kernel.org/u-boot/20251222042533.2024310-1-balaji.selvanathan@oss.qualcomm.com/
---
 drivers/scsi/scsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index b414d022f3f..8fe6b38a8c7 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -220,7 +220,6 @@ static ulong scsi_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 			pccb->datalen = block_dev->blksz * blocks;
 			scsi_setup_read16(pccb, start, blocks);
 			start += blocks;
-			blks -= blocks;
 		} else
 #endif
 		if (blks > max_blks) {
-- 
2.34.1

