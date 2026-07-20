Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B440C4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 163258494B;
	Mon, 20 Jul 2026 10:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vn8ak/1E";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L3YvQIX+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 497F78498B; Mon, 20 Jul 2026 10:52:22 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F25782991
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:52:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6RYWG1506356
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=L1R9dde2LPx
 41JKo8fi/r7ythUaHLldjPCa02z7R1gU=; b=Vn8ak/1EFc1oLuRugdtiv2ukQns
 LRjQmHd2Yu17lS7BHI6Qc3kkEJmbh92dwcLLXu+BJOFw94gUBD8P3XHRK1yGBfQn
 qeVQ60MeE/LIa54tbmIwx/1yIoB85W+usCDIzKDGCbDJcIEAOChhfipACBn3TPhP
 No1c4ixbz7Y5GejPmTFmRBS+mlLwBYm5XbVdzorLC8HnEtB4rmSzkpsW7VpPlXR5
 iltclOEkwpI8zQHTgzHaw2Mkgw/LEql0Lwy1g+tkz9KgP+VZsbIIw+s2yI6LDjjV
 fbgs3OuO89Av1LNKgDVs4Sp8Na+0nO+/WecqNIj+Uxx3CQ6SUAtcYEuT+Bg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bvw944-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:52:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51ebdfceddcso107714311cf.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 01:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784537537; x=1785142337; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L1R9dde2LPx41JKo8fi/r7ythUaHLldjPCa02z7R1gU=;
 b=L3YvQIX+GwET9h7I9vYhlAqK4HNrfr2K9UaWNrl4vLCBTHE1scSBTo1Rcjli/a6MRy
 jtmxKc1JMl5ea2DH4y7BDyxuUOAPtcLjrypVTXGAL+QSUAOoOA7S6rlWuKpB1u4RFcGm
 Rjw5tB/fr3pmVTHu9CT7Toh69NCzTh0wn1qM9GKgwybYG9rl5pzDQ4z0blily7dcVfTx
 4kcn86RBZFURd5ziCNwCGikmh1l/aQxoiEL+QDELYKw8WaHEkEwjedXyzz0n1Jq92t7S
 bDPn0iajBeK75lo0webbF0/zfAx0WBkwlInIvC393ApnVSfdbBetPaChKNSxUuKLDM+b
 OaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784537537; x=1785142337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L1R9dde2LPx41JKo8fi/r7ythUaHLldjPCa02z7R1gU=;
 b=WwtU644xQNBDhHli7e3TYrM0hmcSAA50Lr9Mla5ncEcFQ1ySV7rVr/l5Ai+FQxneMC
 +aD3MDEgAX7XwN8SL9f9/0X3I5IWs78d4DcqEX3eu9OyxwRhgw7zO5WtBu5Uy8pB5iLX
 dEj4HErou2iBBOYo9fpuU0WZj++I6GNMbd9r/apCHIFWsVfPslogthH62ggsyccCSzGR
 ccWkxAaaQuh6m1LMZk/wv4w2XoNBi3EaSHU22Zfr+bxcs3wYkdiWgsPjUToXWR4/DZMe
 xKPFI6eeoWaSAY6eOhx50OjEsF1WMJIpS0+0OSYarv6JTl69XWEn37CSbqvSZZCDNtn8
 O8SA==
X-Gm-Message-State: AOJu0YywvBfC+FPWPGXBSirkoHxO6ITe+BqF0XfAITwX3vLEUlnBY/rn
 Rm4LNTqqQrPFXYj5YgoaDVqj1SK1S+yr3yePYnpo22CNAucuNmo7RV5MnK4bEfx+uQmM89Q9JXL
 18cNixh19iSHASwey9h1Vn1ZpOWsIpJljz+rWZrBB8hnWA7xfpv+vlSX4
X-Gm-Gg: AfdE7cmtePVZ+8+SDY7GDGU+pbTiiCN5Yj0PuFmvZ6uyO+cyBiQsRAkwIQh99Z/I2XP
 FS901IarD5Dl7d9QLh6FoVfRCqF54IGeZzFQWnEU9tnsjejZKsCwrSDaGTSkizMJYCfQ73XSWmX
 SeFl608R7gsKjxzKu6VXp/h7FL7yraIJpq4HyUobfn4V9dLlyNC/TYGNmprBA1bGgOm7DmdBAxJ
 NMXRDUl97+rkNeeL2fTOiiSmfj4qgWFm1IG82ndzUVKcB/XcBofvbNBjO2sjTkC44xg5xLrLlZr
 PSb9mYGPznx4lmYSW5dfrDIIvamoB5tntNHMzwNtXVJ0NapRGMYm/XWD0NfCbv3C5uUkRCwjmgQ
 FZ8ekU/9pket0OrBEz1sZhroyB8369BAEXFjX+LH8bLDo57dy9r4=
X-Received: by 2002:a05:622a:259a:b0:50d:db76:55cd with SMTP id
 d75a77b69052e-5213daa0bc2mr123408401cf.52.1784537537171; 
 Mon, 20 Jul 2026 01:52:17 -0700 (PDT)
X-Received: by 2002:a05:622a:259a:b0:50d:db76:55cd with SMTP id
 d75a77b69052e-5213daa0bc2mr123408041cf.52.1784537536731; 
 Mon, 20 Jul 2026 01:52:16 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e499c2sm26450052f8f.4.2026.07.20.01.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:52:15 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, trini@konsulko.com,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, macpaul.lin@mediatek.com,
 padmarao.begari@amd.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com
Cc: u-boot@lists.denx.de, sumit.garg@kernel.org
Subject: [PATCH v1 5/7] ufs: rpmb: bounce unaligned frames through a
 DMA-aligned buffer
Date: Mon, 20 Jul 2026 10:51:45 +0200
Message-ID: <20260720085202.537019-6-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
References: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cMonKDoyKvbZ_6kUSpq9rQbtXu1iKn0K
X-Authority-Analysis: v=2.4 cv=EcH4hvmC c=1 sm=1 tr=0 ts=6a5de1c2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Fx0htqEYQn2EdjxiwRwA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5OCBTYWx0ZWRfX9PLcQdVANlZf
 pzFKfIlFOUCuqakPw2fJFDEcB6H9y9qylfuz4oqCPah3r5XPfGIC9TOiC8vS8L9byAH8YY+8YgF
 Gm+ggBSNyxuXu10EycVOgmqro+s06W3bUCuBSSbJLLPYIfH3CRC8mTxerJZAU95hmUl7GmNnCsF
 z2Iddt7qKvmEPi8m2/bIfbbQe2Du3pnoDq3kdBtq9A5Zec+9zpro1mfNUl1GcQG1gyX1S4KFVKE
 1q8+Qs1HbfAIVT72kSUBf+PuZF5Usl3Fh2kgRvegx8oTJPO+z0nv2pvRliJ41ef2hBkpApdevlt
 OOzxhLDCYhuiAQGyDaodrwBNBcZEufWm2WO1/4PvACbmjcsVkPCf1aoDlaFMh/tHaiBNbZYvjGF
 vMFJxT2rBR6TwpaCC3IpVrXW6tVFki7imnKgSz53c4digePQRiyBt4otWV1TPrLzP7k17u+RDqV
 OOAeG4tVrviIP9IG9Kg==
X-Proofpoint-ORIG-GUID: cMonKDoyKvbZ_6kUSpq9rQbtXu1iKn0K
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5OCBTYWx0ZWRfX6eIWmdayi/Gx
 CbsutAKnv+tMpwXBq7sQ7MCMo/4OH61UbkFXQT8GVbb8uVfEu70mVzfiANRlCU+aotyKROnvZ+n
 JTDo/4EC7JY28L9I+POGqEuY1mtXvR0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200098
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

The UFS controller requires DMA buffers aligned to ARCH_DMA_MINALIGN,
but the RPMB supplicant may hand the transport an unaligned frame (for
example the status-result frame built on the stack). DMAing from an
unaligned address corrupts the frame and OP-TEE reports the RPMB device
as failed.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/ufs-rpmb.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
index 1434161682b..6a02803edd9 100644
--- a/drivers/ufs/ufs-rpmb.c
+++ b/drivers/ufs/ufs-rpmb.c
@@ -2,10 +2,12 @@
 #include <dm.h>
 #include <hexdump.h>
 #include <log.h>
+#include <malloc.h>
 #include <scsi.h>
 #include <ufs.h>
 #include <vsprintf.h>
 #include <u-boot/blake2.h>
+#include <asm/cache.h>
 #include <asm/unaligned.h>
 #include <linux/errno.h>
 #include <linux/string.h>
@@ -36,9 +38,21 @@ static int ufs_rpmb_secprot(struct udevice *scsi_dev, unsigned int region,
 	struct scsi_cmd pccb;
 	u32 len = nframes * RPMB_FRAME_SIZE;
 	u16 spsp = (region << 8) | UFS_RPMB_SEC_PROTOCOL_ID;
+	void *dma_buf = buf;
+	void *bounce = NULL;
 	int retries;
 	int ret = 0;
 
+	if (!IS_ALIGNED((uintptr_t)buf, ARCH_DMA_MINALIGN)) {
+		bounce = memalign(ARCH_DMA_MINALIGN,
+				  ALIGN(len, ARCH_DMA_MINALIGN));
+		if (!bounce)
+			return -ENOMEM;
+		dma_buf = bounce;
+		if (dir == DMA_TO_DEVICE)
+			memcpy(bounce, buf, len);
+	}
+
 	memset(&pccb, 0, sizeof(pccb));
 	pccb.lun = UFS_UPIU_RPMB_WLUN;
 	pccb.cmd[0] = opcode;
@@ -54,7 +68,7 @@ static int ufs_rpmb_secprot(struct udevice *scsi_dev, unsigned int region,
 	pccb.cmd[10] = 0;
 	pccb.cmd[11] = 0;
 	pccb.cmdlen = 12;
-	pccb.pdata = buf;
+	pccb.pdata = dma_buf;
 	pccb.datalen = len;
 	pccb.dma_dir = dir;
 
@@ -64,6 +78,12 @@ static int ufs_rpmb_secprot(struct udevice *scsi_dev, unsigned int region,
 			break;
 	}
 
+	if (bounce) {
+		if (!ret && dir == DMA_FROM_DEVICE)
+			memcpy(buf, bounce, len);
+		free(bounce);
+	}
+
 	return ret;
 }
 
-- 
2.54.0

