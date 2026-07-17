Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153C6C44507
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 09:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4BFE84D52;
	Fri, 17 Jul 2026 11:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aPfGrL6H";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e/cg9RL2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38B4C84D85; Fri, 17 Jul 2026 11:30:22 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06D8184D32
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 11:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66H6cnKT1093309
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 09:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=gkHedwayZuY2t3vrxZhrVZhVde+r7UF8lPa
 hj5NlqGQ=; b=aPfGrL6HrsTx7f9giQfR/0/G3UwMlXG+uiVxLm1jIOB1AMoxJr3
 BLJpBoOhXca4CJxr6I8gCrH0pY+HiWkhJlfXyE04MZcuE88/1J6TYvdSqvcV+9+P
 yXm5mSJTtL+KifOmSHB4L1I7CMrryL9cbIQ3OXbZP8yJeV8jzoTSEq1xoegZgkUA
 DNNgzdTyutzqcKr5vMIQoAvaACTBizeYpU3LS69suEmNzv0gIDZ0RyMaZcyiPs8/
 kXXZP0dSLhN+NHtW/J0luWGmy38Ohkjxc0Rzko5zafLtOQCLYwbEGP7CWDCBYZ5G
 U96QRyb2J3Q5SPD0xS1iu5iiYkP0VSq4Ptw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffe0urymh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 09:30:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d137a68so181385471cf.3
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 02:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784280618; x=1784885418; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gkHedwayZuY2t3vrxZhrVZhVde+r7UF8lPahj5NlqGQ=;
 b=e/cg9RL2Lcn85sr9EpmwY9LOnzigJ/QC+cnjtS1/R4s33NTVVoCDie2I1duKnqngxZ
 RDoaGEzsFPE/tU0igrnwBbvTQ1WyYYnLAy143De9+QjYnmCBXzowNfjwKlDC7n0P8fL6
 ++Sb1nXhwH2gmJnzuwUr0gJtEAz6zZgNadvs21bC9FlI9uKJ7t4kLyyd6NpA0tYjgj7q
 KSLmKQM79KR2u3wvKuKplaoYQXlBD8752sE5eC9y6so76pINoa90NDAlq8Uz3H6F94DE
 uMlOqDMkNGiP7NcVKNMCfFytk4Pk3wPwJ6b9mbzy/5iF2NuJIGB0tT7ttGEMWBBjQTNy
 5IVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784280618; x=1784885418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gkHedwayZuY2t3vrxZhrVZhVde+r7UF8lPahj5NlqGQ=;
 b=SsG0AwK8s6LDIuIKz5+3muqlCsnSlfQyQK83yrhbHu47FmwqFP4TvfkL7Bmjb50fgL
 girTGR/tA1q8cSMtQJlvIo+k4Frq8cEO78Zrq6zuXaJ3FScder6hpDQ+g+etbi2rwkyP
 WnsurSw3enCu3xG9JRvqSWQ+Rrof/GR6+32o9DWCZi6lKI2SZBBe96NVSB578+W2Zext
 S+zBlSJYez3q4boczso1BmBHkbUkknliJEMeEzqPZ9+e5cCGCqpbfiEpzoBt8dJ6WUGe
 tqxDO8bEHZ4PZ6v6tLN/zGG3tEeYW3Xro88/vUX3sPGQWs+tq/u5mkfhdGA13Gn5gGUu
 Sc9Q==
X-Gm-Message-State: AOJu0YxQp2vlU384TdLR3HE6X+r3eNy6S8rg89eFcvkSvqeNsA2+74KV
 KOe4GrO64a9YiWkHt0fpTt9cliluVvkYeea6xNJGyh8wYSeW69o9rH6YOjeG5xQ9md8o45O2yVZ
 tJXbA0lB7B6dZqifiixYRiRRDW6YOc0RK0JpTcxu3FaNmLnOTP1PUadJv
X-Gm-Gg: AfdE7ckJEzX4+FhaiTEl42O+SsEJQinjzK3DVpe2/eMFOu7+d3gTRGfRmKOzE90r+tu
 5ocm7oEeL+HEIAB5K0yNvBCxD5LyEX+sNoVrGVY8C88MZ/tjgY4Nd6eOqpXz46rxtNWx9fOQp5a
 4Mk/KIf0uXw081Bnk+sL+JAmbo6nfew2dUEbKXojIj+SFDSdj27FO+ihjtrisw7f4XrpE3Im3HA
 8jr8I3SU7rWznZFgC0/OjlJpBl6gmtsZoyXufZbkPXOsvhrpSMLQvLTcvJbGC0Mf5zyRKy8G2Tx
 KQwEFBeVGKDvf3JG9WHrukJGGk/vIoJbcV+NKbPZmIoqiw8HhIySKR4cfCml9TG/rHgRPDnEYSi
 9ueYaL8xlvOx89UeUOiFOByOH6LtelhodsQLOtCzcczoByZpsr3M=
X-Received: by 2002:ac8:7f47:0:b0:521:5c5:f981 with SMTP id
 d75a77b69052e-5213f565de7mr15766211cf.79.1784280617811; 
 Fri, 17 Jul 2026 02:30:17 -0700 (PDT)
X-Received: by 2002:ac8:7f47:0:b0:521:5c5:f981 with SMTP id
 d75a77b69052e-5213f565de7mr15765761cf.79.1784280617404; 
 Fri, 17 Jul 2026 02:30:17 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e499c2sm2052437f8f.4.2026.07.17.02.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 02:30:16 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, neil.armstrong@linaro.org,
 bhupesh.linux@gmail.com, n-francis@ti.com, trini@konsulko.com,
 marek.vasut+renesas@mailbox.org, macpaul.lin@mediatek.com,
 jstephan@baylibre.com, padmarao.begari@amd.com, faiz_abbas@ti.com
Cc: u-boot@lists.denx.de, sumit.garg@kernel.org
Subject: [PATCH] ufs: invalidate the whole descriptor data segment after a
 query read
Date: Fri, 17 Jul 2026 11:30:07 +0200
Message-ID: <20260717093013.3253643-1-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=deWwG3Xe c=1 sm=1 tr=0 ts=6a59f62a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=sVUJw9hY3dAOjW_6usgA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA5NCBTYWx0ZWRfXz9ApCBDwSjTf
 gjmnoQEG/tEP617HNi+rqjVbg9dkJXac0OumOR8sliy2OylD4+dDBSrtpKOgZyMLjJdbug2yMxM
 4/XXfsNT/G0Q/ezDaSkkK2S6VAUREwWBycd1+9qvbwxgBmMHMbVWYLWCGJsrXMje5OmAPMWoupG
 w6NJ813m5d8M0y5zHdMl2Z3Iu1+QjxCSMiJlVaUPoYkP7mAuaFL52sYycyxyOncmLypHrPUSq09
 0hArmXOKzodSYp2M6kiRvik9h8WWTRcM89nr5mCWvT4HKBIqFhoo2cKKCBKfxRVjgETGbXlce6k
 hoh+7+V56WPUl0vj3f+Glzpywub0EmJgo9zMrD5DX43IBCCTQ7C0V8Bzx1m5V5Dmz72sPIGOFhW
 c3wrxcL5VoN6BlEJ1ZYi1hqyzeIqGoYaCXAWc2LmUwUOjiM5Iw2ytWqH1bKH4HU/QkqmXMNxvVQ
 T++8UFHU0eiu4o7Lz8A==
X-Proofpoint-ORIG-GUID: kYzcV8Fab2Qot3KnOfafYDNlfCHDEDzF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA5NCBTYWx0ZWRfX5QHyrG1dVDHN
 cHupTq87d4hrHVSmhCACykQpaZr/Yxh9Q3mCU27h0rSAr7LYmUmJwcgIHu0y+3ZF5H51ngx9UI6
 d4BV6zHA+Q+9VUFiTfgfmMgo9LgOTtU=
X-Proofpoint-GUID: kYzcV8Fab2Qot3KnOfafYDNlfCHDEDzF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170094
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

ufshcd_get_req_rsp() invalidates only sizeof(struct utp_upiu_rsp) of the
DMA'd response, but a READ DESCRIPTOR response's data segment follows the
UPIU header at GENERAL_UPIU_REQUEST_SIZE and can extend past that window.
The tail of a longer descriptor was therefore read from stale cache (the
pre-transfer memset had zeroed it), so its last bytes came back as 0.

This corrupted the last UTF-16 code unit of longer string descriptors:
e.g. a 34-byte product-name descriptor "THGJFGT0T25BAZZA" was read as
"THGJFGT0T25BAZZ\0", dropping the final 'A'. Shorter descriptors that fit
within the invalidated cache line (serial numbers, etc.) were unaffected.

Invalidate the descriptor region before copying it out.

Tested on the Qualcomm IQ-9075-EVK.

Fixes: 7feafb0ae4f7 ("ufs: Add Initial Support for UFS subsystem")
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/ufs-uclass.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 6a51f337e47..6ef01f8e4aa 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1008,6 +1008,7 @@ static int ufshcd_copy_query_response(struct ufs_hba *hba)
 		buf_len =
 			be16_to_cpu(hba->dev_cmd.query.request.upiu_req.length);
 		if (likely(buf_len >= resp_len)) {
+			ufshcd_cache_invalidate(descp, resp_len);
 			memcpy(hba->dev_cmd.query.descriptor, descp, resp_len);
 		} else {
 			dev_warn(hba->dev,
-- 
2.54.0

