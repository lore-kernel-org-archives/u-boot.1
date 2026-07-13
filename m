Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E40C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 16:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F01B484C4D;
	Mon, 13 Jul 2026 18:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pRjIdtmW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ifHj+dA1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0952984C60; Mon, 13 Jul 2026 18:35:18 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9053B84C43
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 18:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DF8lIM1908363
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=oESy0NkAnkJwRPsTcyE9oKV+M30V4qVSXuf
 6y0uQ6fs=; b=pRjIdtmWzjfkH7Y/s4hb0iMCeRh4BNEmKDg1j7EO+BmG1JIl5sO
 X9QLAKqR5cMeOF7pNZzmlRH4PxzjYTY3Ehb/LF22GaC5ApqG03oZNNJbuNn15XMK
 LYv3bxEHmE34jbiWkxpxi7sypqTCoLx/LuyOYHKyouzLcc9HDT8iLEF5MZHlFUjE
 me6MN6k7jUPOW0xwFmBFQpuPefGc4JWPDfFzTLpmT638efpAQD9tty77pRiqVc81
 97LlkhNShM45W+vRT8pFZmOitA5X/5PAAnAXjyS8MXrz/hc/gTbt5GBhlkzWvbQQ
 2Xidnl2SxzScxgK02fBBCNNlBOv5nHiXiPA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwda1pm6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:35:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e11baa66eso75028a91.2
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783960513; x=1784565313; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oESy0NkAnkJwRPsTcyE9oKV+M30V4qVSXuf6y0uQ6fs=;
 b=ifHj+dA1tvD/24Ao+o1W2x1chJWvnNOVq4yVVoQwoEc7dwCuzunPOv/86NyF0ERMd8
 ylDxt4104JG8vnsXILjkr39I9s9wohooQfTrhp5F7fU3ZWWK1DiPaKQz0OaOZCNg2C1E
 /w8RVRUznDekUpW6aXkBo8eXTOdHxvtTVO02L+6D+WO0cufRT81OuMnC+Q/1bJPGCWyI
 yw8xuzRaMxNNJAcMpCdlU/6tBFu5FqHJveZBMIP0UtiVZgxMRkJeN7i5HVnWJM7ozkpS
 CZwZws0pKvPR+J8l552p8aKhqL1Y5Dx3tBHnDP43WSgvkO6unkseLOpyKKluffZDGoQj
 p0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783960513; x=1784565313;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oESy0NkAnkJwRPsTcyE9oKV+M30V4qVSXuf6y0uQ6fs=;
 b=KcvXSY6elIlVsh+LQrt6KZ4DF+VJMl1h6HMf9RSc/nGiSHNdSJNgmpexWAuSldIXmM
 WksOLLMSYvghoriFCtYxdaCrDHmtzYdQU6racFs44/FHfijevr6k9fqMDEEQquERtBrU
 QPlblOtJrHLDpxh4cBDcLyNv8BJ4v3LX+PbVIwCGl/07hLQzbBV5EbrQzeT/UiztxpiE
 Oy1W6nJ6xwPVxlEmYZWVME5o8zApbL8euZRWgimWYUGf/xmM6HQHKEJO8zb2JUSA0FN0
 aCnnJfFQaAC+Rl3E6gFRWpxHR3fM6ZmFZhGWHvspUtl/dALyI4K6632cUYCJbPLJ8JhA
 z8Tg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhvhRHYI0p9S/tiZ3XlFchaCrryjT9685uAn32Ck7T/fAskd0fwc8pXq/SvvmFY3el7c0bxtU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0UtC5GPfeHKvUJC6azNeocdQkJcRqk8Sy1qfWsrQ0gyE+bBU7
 6UQgCUQ7cHshbHJJtyrW6lTCochu9cH0QIisFLRpP6Hhgw3CoFSSGIXauXgIH+YDa38RpT1BUU6
 0f/zECUutzCWAbMoio4BNT5seZq4q5iuGPSXXmhdopxW7EH31u1Qqwqjx
X-Gm-Gg: AfdE7cmCCMNace3hYAcbn4Q3XMs3hj2dhBHC+Gv0kIuJCoB4aCFPoZNLoRnb++2JfOa
 FcdEKz2ww0+g1ZThMEjBZhK2/TXDEbHcW1VNulwhbbquAtX5Ii3Bcxbj1uKJC/1MIAghACnNbJu
 QDZK37VHWyZyZiEwrRX+CQ62BOyDua4caQJQiRomLFx6EIVfY8c4/oqAe4mMixLmW2krFF9cUZ4
 lekSLHzI9fUYFsOAzoKO7djs9lO4t9C5gEHqSEggGr1REWFjgb2gjCP+A72OujwzDWncm3oyqRG
 6eX1Pa0cbEcZ1NB/H/yqhXwFojoa97W2AglluWcxRAJtyBLU0dMnV4MqGjWjev8ms889hOkRnAH
 TlkUJS2aPUqw6Nyyy/3La2xnbDmd3neR6p3d+yw0k+f4qdmVJ1DgmJG7pLq6p0VqAF7Ez4esof7
 VGUph78wpyT7/u3txyzthqZSSEkJFRxw==
X-Received: by 2002:a17:90b:1fc8:b0:37e:2005:6507 with SMTP id
 98e67ed59e1d1-38dc75f4cf5mr9168324a91.15.1783960512806; 
 Mon, 13 Jul 2026 09:35:12 -0700 (PDT)
X-Received: by 2002:a17:90b:1fc8:b0:37e:2005:6507 with SMTP id
 98e67ed59e1d1-38dc75f4cf5mr9168299a91.15.1783960512178; 
 Mon, 13 Jul 2026 09:35:12 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6091dsm81683540eec.14.2026.07.13.09.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 09:35:11 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH] mach-snapdragon: smem: Use available_length for RAM partition
 v2+
Date: Mon, 13 Jul 2026 22:05:04 +0530
Message-Id: <20260713163504.1830900-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE3MiBTYWx0ZWRfX50cZLICXsi21
 hBbP8LtkSAf/XRYbHkHGyb2Ej8P3r1EycTYaQKDx01T341Axd87OOzW1zJVbJ6BzOV5rjLj1mhW
 a64xfk5WWTvb3AiI/Ke4v9J+sgpIvss=
X-Authority-Analysis: v=2.4 cv=cNbQdFeN c=1 sm=1 tr=0 ts=6a5513c1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=NQbW43lCRD_eDx5gHQUA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: IoBL_4ZOD0aLrsStfruboxdBeaoMqcOy
X-Proofpoint-ORIG-GUID: IoBL_4ZOD0aLrsStfruboxdBeaoMqcOy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE3MiBTYWx0ZWRfX0WuBVjBoNJ3S
 nB98TC0AQKrVknfu86ECPWWrBhoJVoPNipgS1lkr97P5ruaipgn3P97rq2Gqs5Gyv7YdsxawXoE
 CEfXvW1pdAYR7Mtm1DWyHaJfKgmfea76dxZhl/Ub5RQqHjht3KcCbM1J1CriQ7n1oA/k0uQyTYt
 bBDRYfsrAEOv449aBX3LSgBDZ44VCIpcyCapP/qfW4qdBHDWf2tu6iyfZkMa/Ljrn+vXvcZXyi1
 t7TKLt73i2LWLrPatC5/D/skq7mtRcWpaCODctJSoHa8yf+ES46yAQ0QkSgt69uRX3uuQst0p4t
 Io8aP8uLx9OWb4jz6s0EMjz04VkQCb6kFHsAax5sUDzEARmQiYgqxAzSJwsYBo9npeBLWQyBkkJ
 4lbYcAlU1KoN67teseW2pjsrwhkhHUAF4YtVlSh1LKAFZTDA4beosm9vVZM3TWFmUpGSTirylkY
 m7fvgYJk/OKePSfnOlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130172
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

Using length field exposes dynamic carveout regions to kernel, causing
crashes when accessing these reserved memory areas. Subsystems like
hypervisor perform runtime carveouts & records it in SMEM.

RAM partition table v2+ includes available_length field which reflects
memory available after these dynamic carveouts, while length field
represents total partition size. Switch to available_length for v2+
to exclude runtime carveout regions.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
This patch is based on changes[1] in Qualcomm U-Boot Custodian Tree
[1] https://lore.kernel.org/u-boot/20260618-b4-modernise-smem-v3-0-472391477988@linaro.org/
---
 arch/arm/mach-snapdragon/dram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/dram.c b/arch/arm/mach-snapdragon/dram.c
index 0b97b698322..914ee6cd4ff 100644
--- a/arch/arm/mach-snapdragon/dram.c
+++ b/arch/arm/mach-snapdragon/dram.c
@@ -70,7 +70,8 @@ int dram_init_banksize(void)
 				 (v == 1 ? ((struct ram_partition_entry_v1 *)(e))->field : \
 				  ((struct ram_partition_entry_v3 *)(e))->field))
 #define entry_start(v, e) entry_field(v, e, start_address)
-#define entry_length(v, e) entry_field(v, e, length)
+#define entry_length(v, e) (v > 1 ? ((struct ram_partition_entry_v3 *)(e))->available_length : \
+                            entry_field(v, e, length))
 #define entry_category(v, e) entry_field(v, e, partition_category)
 #define entry_domain(v, e) entry_field(v, e, partition_domain)
 #define entry_type(v, e) entry_field(v, e, partition_type)
-- 
2.34.1

