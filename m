Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE677F532DD
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 05:53:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDE88839DF;
	Tue, 24 Mar 2026 06:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PpusBsH8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G5U7jRz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27E2183FBC; Tue, 24 Mar 2026 06:53:05 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 672C783BE1
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 06:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O3sDAC943490
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 05:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lAqxQdSk2+pDIgnPjHKAEol7tgZP8bMsR1B5gO8YsWw=; b=PpusBsH8Xr13wpa1
 EuXNURyrMjLBfZknlEfPU8+WauFgXEVWwsrp9BZ36LMTtNTCtrXxyNHb+fgNi+V8
 nOgAQaLH/fpYiFFRZnhNM0FEaD0Uc5+s8ppkHTrfj2cEK00N4BGgqxz8cYlH0eX8
 95qCxR520IjNq5kSw3gMwvlib8FgdmpOkpOjuqGOKhcp8H8ay6XMsZESSMgX5QO5
 I+TI1bcNKDNfJWNK3WTSaq/5gG+ymJB7/US+yxuJrFi0NHifHQUTC3KjAvmpwo+z
 MZ+UygtoAFKdMQDaCehQJFOtweHItEFmIXq+znwULOyPqNsMTie8ut7leZdr786y
 YZUlXw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34vkudx2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 05:53:00 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-829bf6406ecso13097411b3a.0
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 22:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774331579; x=1774936379; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lAqxQdSk2+pDIgnPjHKAEol7tgZP8bMsR1B5gO8YsWw=;
 b=G5U7jRz1DiOtQGhpO7vqFNh7EK552y0E0D7UwYI99X6qSjo2I+dtfnYgglGdAq8iCw
 S+Av9uF1TnIqgb1SajoMppBLyY6RDjSipVAtzOvv0Euo5oXmEj5xGd1d7cXeZw4wCdTu
 UT/bb29SDyCdYqh9cMTE/M+57nsCEdDJOpKa+VKhV6jzqcQfCwKFPpPEVASKSlN2ByR9
 ChB/yttiKRZxPiSrbExj5un7frl2Z7X3rWpXtabnwM89utJqdZNiMmkNlBwEGajTt24S
 /M3uJCo7H+eLJV7BaKqwynm2zkt+s9eiIWEoMbp7Vb9WF3KukxE3K+azJBqEqZa0dHAx
 233w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774331579; x=1774936379;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lAqxQdSk2+pDIgnPjHKAEol7tgZP8bMsR1B5gO8YsWw=;
 b=HZqsZGUfkw4a4C6emSZJwVzB2RTYznrIgJcR5f5vnrClzVbOd+1+L54OhBxK4T+Peg
 Nx38vnxiCC6axfjsXBt7x1WJ73xAh2VvfuWEi1ou+xrHkqykb3zxsvjMq8981VeJhBZq
 UbVJAnZiu4LjWP59mEHweKJRSsgmaMb35r88gH6ZQU/kVkdGMW4BgVbfLpZ850UsgFl5
 Pu37M3dP/PGsaLRhVBYVCMSfk7YtMhpir9f6QsDeG8CAX+f0FSsHulyVe84z8WB8ZcgD
 73BOMCCxvMS4X65+3d23vFJbivppHE89CAAOqOWQCyfPCv/F4VyMM6kL2+Dj89rC3Vyw
 y1qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa7yQ0ZAtLSAt8+Pi3y4u+1me0iOiTz3K+RGVnfx2XsZMDCMl4BKcJp1Lca8Ta2d68Zra1zi8=@lists.denx.de
X-Gm-Message-State: AOJu0YyDqiY+jJ5/Pni+lTQLbG93Fk5cxYpWYkqqLsgybY7T57FITLS+
 J/9Z/IArowO1ZR6ifs/+LcV1gCKGPT2O4VbmJxM8NyctFVwvH7/Os9DR9hnqkkxJ5dqGmP/LMt3
 O039KVI1EfXBbv7L7XHDpLBAAvxNi6gdBSel7gg2WOnfz7VuFMh6B20XY
X-Gm-Gg: ATEYQzySlIlZzEgVi2Jot9K1PWy4SKOyC2IpL4bNxbu8pj25yOHJKhTej3VWSevpDBO
 guf9z9MQbqSEKrxspoRchRp13eQOl5Se99uEOn3NKgn/1LcAz1PEhUYgU4b67AgMtE7mphIkvWO
 emEiRanXzbBiiftkCr3op4XpQnzMsGiO6Ax12aZP5+ITWFAdcZmIe2Rg8+bgIdPTEU76OZtGc0T
 XHMIgfprRErHVRuiKz2jMAqgiHj0oQVhjpAuqloSFcAl7dwb0At5QpTWz8ecUEdc/PKH0ZXTDvp
 5rvpoKC1M8C5tvaBYkG1rdRkaF3iPs50cVFsOcVzee3oP+sXapldG+q8F1UUWc5YBU6dXxtftfw
 VTu7fEZCLYIs8Y8gVT8ExwOropp07R7/mauxATNuPH3bKdcamQJqaR4MjntjOvgI9PFaGqebrf/
 4IP4HXiynMfxUNPbMbwANOGhzuFSreVGaxxCZyIQuMFxf7xm7cSw==
X-Received: by 2002:a05:6a00:2355:b0:82a:6e7f:4c20 with SMTP id
 d2e1a72fcca58-82a8c23732amr12316418b3a.11.1774331579350; 
 Mon, 23 Mar 2026 22:52:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:2355:b0:82a:6e7f:4c20 with SMTP id
 d2e1a72fcca58-82a8c23732amr12316392b3a.11.1774331578795; 
 Mon, 23 Mar 2026 22:52:58 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c212ac8a2sm12874783b3a.17.2026.03.23.22.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 22:52:58 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 11:22:36 +0530
Subject: [PATCH 3/3] fs: fat: Limit transfer size to prevent SDHCI
 controller timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-emmc_sd-v1-3-883a45538b6e@oss.qualcomm.com>
References: <20260324-emmc_sd-v1-0-883a45538b6e@oss.qualcomm.com>
In-Reply-To: <20260324-emmc_sd-v1-0-883a45538b6e@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Simon Glass <sjg@chromium.org>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774331557; l=2078;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=WBwRU5VSodFmpPuHs9MNphIwKbPKyEqTLGxuNNtBm7U=;
 b=Wr4+OJ6YUc/e65XC1IMAYD66PQxpTCPoNGX1lk5Qbi1rTkW9BnvbZ373CwfwgbKebL3FXOVx9
 BZ7PM3iye4ODTo8JileZXe4i9VIGaG21kHsHGB0qm9lnXr5oX8vYrM+
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA0NiBTYWx0ZWRfX4Ujzu7/lHWaR
 cquDT29rIZRBClSgRliEhlQi5GxvW9iU4qIiThBsflgsn8I9p/RinZg7Xm0WDgB5iVkko29+ck9
 6I3LIPHEAsO1FLDjE9i6+0ailQwt12whSkUb7icucu+g1IzQ7Gn8Kf2/XpSNNIYHS1FcNifrgMq
 qwdXk7seoWLggZObl1q1/rn+4J1TCiDg/jyg5ceGzslqEHLbhMT+rhpF6PecbvuRSPe+EXBbewP
 QWaves2A5H0hkaWy3Yrks1xsQosddKZ7oBvhE9gFvI096eaXpUE9JEKSPpvAGZsgLMxZEvG/2WU
 i/nXlZxvhJh1IiMBJNrbv1bEljBSbLOYRZkyOOgSVBAWYqLLvK+oxJZ4Dz6ET0E7V/xnMvOGMdM
 wXuX93uF0ueP0v4/9dsUW7p/itc862WHGb+A7YvcA+pi9+IxknryEEazcVC1uStDMXr2M+B/G6R
 2pZonjmWro9xql1UmiQ==
X-Authority-Analysis: v=2.4 cv=eMoeTXp1 c=1 sm=1 tr=0 ts=69c226bc cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=T-L9CQQ_qxZGLtipIvUA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 9nGMtXIOGwgErNCOFSX4cF-PtGx2QTQi
X-Proofpoint-ORIG-GUID: 9nGMtXIOGwgErNCOFSX4cF-PtGx2QTQi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_01,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240046
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

Some SDHCI controllers have limitations on maximum transfer sizes
and can timeout on large block operations.

Break large read and write operations into chunks of 16384 blocks
to stay within controller limits. This prevents timeout errors during
large file transfers on FAT filesystems while maintaining
compatibility with all platforms.

This patch builds on top of the work from:
https://lore.kernel.org/u-boot/20260224035000.1617869-1-varadarajan.narayanan@oss.qualcomm.com/

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 fs/fat/fat.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 85b511f75af..6ec241af584 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -30,6 +30,9 @@
 /* maximum number of clusters for FAT12 */
 #define MAX_FAT12	0xFF4
 
+/* maximum blocks per read/write to avoid SDHCI timeout */
+#define MAX_BLOCKS_PER_TRANSFER 16384
+
 /*
  * Convert a string to lowercase.  Converts at most 'len' characters,
  * 'len' may be larger than the length of 'str' if 'str' is NULL
@@ -136,18 +139,26 @@ static int disk_rw(__u32 sect, __u32 nr_sect, void *buf, bool read)
 	if (rem > blksz) {
 		n = rem / blksz;
 
-		if (read)
-			ret = blk_dread(cur_dev, start + s, n, buf);
-		else
-			ret = blk_dwrite(cur_dev, start + s, n, buf);
+		/* Break large reads/writes into chunks */
+		while (n > 0) {
+			__u32 transfer_count = (n > MAX_BLOCKS_PER_TRANSFER) ? MAX_BLOCKS_PER_TRANSFER : n;
 
-		if (ret != n) {
-			ret = -1;
-			goto exit;
+			if (read)
+				ret = blk_dread(cur_dev, start + s, transfer_count, buf);
+			else
+				ret = blk_dwrite(cur_dev, start + s, transfer_count, buf);
+
+			if (ret != transfer_count) {
+				ret = -1;
+				goto exit;
+			}
+
+			buf += transfer_count * blksz;
+			s += transfer_count;
+			n -= transfer_count;
 		}
-		buf += n * blksz;
+
 		rem = rem % blksz;
-		s += n;
 	}
 
 	/* Do part 3, read a block and copy the trailing sectors */

-- 
2.34.1

