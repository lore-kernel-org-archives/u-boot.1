Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B55F8A145
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73EDD8407E;
	Thu, 16 Apr 2026 11:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hTp9Kidj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="biS1yhOX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 455AE84222; Thu, 16 Apr 2026 11:10:58 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD6C283FC0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G8X7dQ3089111
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 09:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=A28Na7tnzDZG+AkfaNDPC9
 1KxmxTQrJ0JTPMT4mQAII=; b=hTp9KidjZ77tV2FtVPhuG+nK2KBgcmQDzXOGb4
 3n7o13QHkvzp4kGCga0/Iiv5mRZOTvpbIlhdbr7sMMSvPH81LbFeuItaXFRVTRwB
 J4qrqhLBdebTjqu1KMHKQ+nAJWj6tFHRuxFK/n5ZLx6RDNHGTTVfxEhPFoCDVHNu
 614yASnFw3RCq0gT3J74swX90IL6hNdihq7PmUowHjUp3Bh01+d0rdKWtGefEjCz
 D8S/+UQ8dLTt2QyQtDHpbg89kdl9ZUZ8MQ4MCnX6ghK662WlI9Tll2pi6j2R6VMZ
 P+4nCQk2K2FeQmfe+Be1c9FkNHBMLVxPmsSoY0QiJhVRnLww==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djp6a9f90-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 09:10:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2e6ee9444so6442465ad.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 02:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776330653; x=1776935453; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A28Na7tnzDZG+AkfaNDPC91KxmxTQrJ0JTPMT4mQAII=;
 b=biS1yhOXN7ZZh1g2TYpZKKa4+f9rAWHO/CZKnMCQLbd8Bei9kMohUvx93rnDHL8+VO
 W88xBVSC6D9BlKWat4h/JX1RGbXP+Zy7WP1ADhza+1ce9vYrgJE8CdDFWncyQrpBemih
 SfUgjYgeHMXsH+uDryePXIeJmY6UhfwtX6F7bCjoCSYrlewrBzjjjpuDNYi//w157kpE
 QTnZr1rQ6QsW/m5JkotUV3dzLYljGsM8SbgjkHkumXlNsFZD8au7x3ugkjZhL0Y3mQ18
 B3YxWm0ksIF23BzBmX2VIT7kZkNQUhvg8/y7t5wOYAXwGRzY6ohoMHSx8bBGAJ/vuF21
 1YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776330653; x=1776935453;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A28Na7tnzDZG+AkfaNDPC91KxmxTQrJ0JTPMT4mQAII=;
 b=Jtx/tlqDwSJ6shVL4k2puybhUpCXGCLpnS9i6Aes6gzeVvIUHoQm1/5/frz6TvIOjh
 mVGu0Vce0MyMxOl2Ftw/1vMDBq5skW65Zj7i+G16UTvKE+eRoOprzB9qz1c4jKfTu7uB
 Ky199hsta46uKQCMzQb4hKamuxEf7uyv9cnT2G3qWZX5hCggjcDqRFH7O688I8Jl5cSJ
 eolFGZB7lWLoLnQFzZ3kbNSlSWdj5kUH/F8wRp9mmAiPQRqiskVv+QpDUXofKx5sFOBJ
 O/R9kxx1tUgR1loqgmPQ3bJtzkUOeDbILH1iJTxccfmFoLST1bpXjTuXxI4VeGS0Cjuq
 zhOg==
X-Gm-Message-State: AOJu0YzJM9En32ABV50Xeh3D5cGQiL7N0+xeywj4LTIiHpGo8pSUL1eO
 oOHUiwE1S4b1S4fPANsv2585JUfhOB2QPQ3JDoKnB9AYkjib6PiSgMNjwLnRcEIieGlXHIbBi1z
 wKC5G/VU1qJFu6fJpt5+tpNwPr8abNdw34clwkyVYVw/5+mChdPBHKYOW
X-Gm-Gg: AeBDiestnT4xYXqzNHdCuNCK5zQ8Y4ducdAuTSvV8eaiuC1iIpYdpTdL8grRMgG/TUK
 3GRgjHOf9i3ty6ErysFmdKEhKhI8WZUs8VfvN8b4QdLWUHfA4ZockAg4iP8bjXrCKv4PisUFfHZ
 tu+FsXkrlhM/w02a7cMUHPmVkihKQfz+Zs5NujToNBe7ApPFb9PEp/NMHv4WwtJ74DyCuI88KKT
 xPyGsgqFP2+xG/SslxMbVtiq79wziRUtq1rvj3vSbsCAe09/Xfk1q1u3m8ogvZerx7z0173e2ZJ
 wkPEDsG985IDDv5UmPTjOwbt4dI4DjLqjyyzgOuaTL/HYBs/ZKrk+cUnLWlbIbScNSoOBnfnPyg
 UzdbPvGNgSHjGgegcEZcvIKn0qqvhe4Crv4XhmakuhHRbxNKV17xYG/W9auS5s+P/6RMWvWi8Ck
 QXuODjofR1HkxTwI0FLKOUkCdvYj0WhNwCKyYCYYEETheaRL1aHA==
X-Received: by 2002:a17:903:18a:b0:2b2:4fc1:f653 with SMTP id
 d9443c01a7336-2b5f023e9d0mr9869395ad.3.1776330652787; 
 Thu, 16 Apr 2026 02:10:52 -0700 (PDT)
X-Received: by 2002:a17:903:18a:b0:2b2:4fc1:f653 with SMTP id
 d9443c01a7336-2b5f023e9d0mr9869055ad.3.1776330652269; 
 Thu, 16 Apr 2026 02:10:52 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b47810b898sm46211895ad.25.2026.04.16.02.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:10:51 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v3 0/2] scsi: Replace SYNC_CACHE with FUA for scsi write
Date: Thu, 16 Apr 2026 14:40:45 +0530
Message-Id: <20260416-enable_fua-v3-0-84508de2bfd9@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJWn4GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0Mz3dS8xKSc1Pi00kRdM/Mks8TElGSj5MQUJaCGgqLUtMwKsGHRsbW
 1AFKMhBhcAAAA
X-Change-ID: 20260416-enable_fua-67b6aadc2cad
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776330648; l=1353;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Hxt5J6h5HaFGIQdfECwm8IJy/jKvfYigNoqIM93Pl2g=;
 b=I7LyrNJjaaQM3Pl56E0P2J4NTi7Qs3WzH0ldqF0g9Zn76Cwwp7/bHXlrabthww6vpv1K5/agi
 0N2FTh5wh3eBSKlgvOntPfk/54a9CLhlx4H8eCBoXG8XTd8OlYXrQxc
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: 2rNPxnw-S8ymavb9TGvCungHrJUHupEd
X-Authority-Analysis: v=2.4 cv=NuvhtcdJ c=1 sm=1 tr=0 ts=69e0a79d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_YAsC3iZightoOqRCBgA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 2rNPxnw-S8ymavb9TGvCungHrJUHupEd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA4NiBTYWx0ZWRfX416cLLTVfwJJ
 wXciqraiyanDZ8js8CAjYIYjMDr5ANVEbBRJEm0TacTI8opYAAE7fbGB1THDzbnA/txyQ1wYyCz
 HC7DzjJVmZV5AIBGt5Z1Yq2aOLgw/O7g7nLS6RaEdr6eE/eRwMZTEYPulbs6/Fbv9kf0ANrRw6R
 YQYvr6P9PAXMrfmTZYMmV8I/XLn1o6aZmjfs4NXy8wicA+b/LWyF5HRH2VFoFogqInFDcYG7cjF
 CcoHnWVUNpJOXxEsnzXC+iF02OGO3WavX84GONJd/Nyp8yYmIa+hA+KLLPPne6GVzIbk0iYLfjd
 hQxqHdccS5Yz8q/bKN+9SQRRmeFGqb4Uph9ADIypmK8EL2MKCr3u+nIP9WjaxnijA+Vw24OfO7N
 rTWNm5f88evuS7+1Rs7SHoqGjEAR/GfFR+BDChcIddTdDSa/1ILV1FhkAG6aQkMujXfUNB2QSSn
 jE4KxexmwZtWVEuCQow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160086
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

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Changed commit description strcture and added SoB
- Link to v2: https://lore.kernel.org/u-boot/20260122083954.2722972-1-balaji.selvanathan@oss.qualcomm.com/

Changes in v2:
- Reverted "scsi: sync cache on write" commit and then set the FUA bit
- Link to v1: https://lore.kernel.org/u-boot/20260105052526.593017-1-balaji.selvanathan@oss.qualcomm.com/

---
Aswin Murugan (1):
      scsi: Enable FUA bit in WRITE10 commands

Balaji Selvanathan (1):
      Revert "scsi: sync cache on write"

 drivers/scsi/scsi.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)
---
base-commit: 70fd0c3bb7c26d42f24d10145dd5f3168ac92eac
change-id: 20260416-enable_fua-67b6aadc2cad

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

