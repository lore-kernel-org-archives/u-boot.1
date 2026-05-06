Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C8BCD3424
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 06:14:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ECBF84837;
	Wed,  6 May 2026 08:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="F87HLG2H";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gje7Bn62";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A6B98484F; Wed,  6 May 2026 08:14:29 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 651C0846DB
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 08:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645M72X3152031
 for <u-boot@lists.denx.de>; Wed, 6 May 2026 06:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ZLttwKOhosotS/kSUn2bUg
 qcxHwUgWzc0V+1FfKP9rw=; b=F87HLG2H9IvAGFD61voKOWP9tbD7lb4GbH+eFt
 AWIENc3DfynRJH8QL+Gfngr3M7i07qNrQM+wO5hMkORTqeYayJY/8qaZl0zgveeU
 jk6vJlAuatoQQga4/VAjbgoU7fdhqug3EMqzJDknSz3sRycHT2C/aeghO2JxhwUm
 0KZZC8B1p9ec8MXTpGEPNHAmXyl/P+05tuXaraP/4k5F4OUAhpPLDVpcZLdhG/Or
 tDVlvo7xA2u1YJRx11p6PxUK912RTtywmilP/82xDEW6x6A1J8KnLVocVNnV20Oy
 XNDtsAvFypfw8KAdlLySM6L1L7HAoSxF1hqebR4sKN0zjOcQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyj80b7f2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 06:14:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ba224c3ffdso50898045ad.0
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 23:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778048065; x=1778652865; darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZLttwKOhosotS/kSUn2bUgqcxHwUgWzc0V+1FfKP9rw=;
 b=Gje7Bn62Uxoi1jrGPY5ACm2zUQmZUle2fM+7Hpo9RufS1OLwML0TEa14xNdmyYXNV1
 Q7XRWQ8dcZINrGVJnDTlDse6ORWfPzE/0BcThhGXoLfEgG+83usalnuLYHhWVObtWSbS
 bmhkFaHRxGKOBayD+r+werv/GOyhPBqTC44JT4hSXbClSvUNK3SDKmReoPjyjdWr2uIo
 KjcIceRdhdUWy3ldl9+3jcubWwyjI/cUfNt64AKUhDza3Gw0bpsZzA4m67CCKLOQWWCO
 g9KlJB90XNSYNOSNkF/AXDA0Gxpr1Yo9R/rEz1SFEaWWeYlPDuANcfwC7Ci4txa/WTuI
 HZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778048065; x=1778652865;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZLttwKOhosotS/kSUn2bUgqcxHwUgWzc0V+1FfKP9rw=;
 b=VtRk7EhDwt1Oh07BkcltKIpIaM3W5C7ykHuVZXof5a8vBlF+CMd9vCQABa+/APAwyB
 GPGfUKjZN3uMLE/QWUtnauDAg4VwwJD8bKFv5AnVc7n5WkbDiVCWVgOqeXGEc2TjaQSH
 3qdP+AgBfp+wmv5LP19+MUJLFuPtC6ZCU9ud8jscVYpZuUAP69iSq7BzJBtFp6/vng/C
 csDASCYw1ImHncxk/58jyKvyPhWeSP/ZBisI5yLROJSkiepp7BHok85WwJFoYTqwhwrQ
 oyA9QMwQ2hO69yvMy30FVtyzJ0L96hacPKKxga1ceaILC3ff3vO9JnDC+9Zv9hlo3Kcn
 LhqA==
X-Gm-Message-State: AOJu0YxKC7jcKfbB8+hZoxyfZOUaaWMUkErcg3Gbmw2gbMJbIKtDCTeV
 i48nIrCZ/8rjp7/jYa7j907zIE4a6WBxbZp5DZxRmRLmYG7BqLmABSof8qpbqJQ2yumDsWz6m3w
 JUEPJ6W+Go+cKdwfwx5mf4fJawSKuvLD2NvCrQbU81BV/EEECj25hy0qo
X-Gm-Gg: AeBDiet1PVy2XJHFCdfz7/56LOQYx+OadM87fG78kNiy0J4Q9n+ytHN3BYmlLPJBN9N
 VwbnT4m4ld2zfFFtTzc/5kEVk2LONbCPXs/lk6Zyl8cDaMW6jJalrItSdM+zFeVQxQS8G9LtJvj
 lteSDkRM56+lT40WX/G03pE0PUHG98KFuBa3h6KRj4Yeijyi9wWxvX4BzKhPRg1GGnzpqDlEL6i
 z1em4PmWtW9BzZzCh7Y7Zrz1vkEiJuYpi1WAzrVfclso/SoB12fBlUL4q4LOUw7VnK14cCrNuMJ
 NG7Q6m3PpYTC0n4eLMtw0qoegXk6xkCWi4AaY9NiXaZOT1CAIx4LKP+C4nz8r4PGdnTXasVD3PU
 IcyR5gUhds/yH5nX9vA9BPnUg71bfW9nyPrP95B/F1Qvxb8mcKvEfEdAauPt1hFA3eTbbjWCVfC
 dwf6X4aDgPJid2H5HiW/hVfQfHwrTBDDDjdN1Qix7AMlPxJzJE4o+hJvj4f4+Q
X-Received: by 2002:a17:902:da87:b0:2b0:7531:b61e with SMTP id
 d9443c01a7336-2ba7a330deamr20361815ad.41.1778048064814; 
 Tue, 05 May 2026 23:14:24 -0700 (PDT)
X-Received: by 2002:a17:902:da87:b0:2b0:7531:b61e with SMTP id
 d9443c01a7336-2ba7a330deamr20361595ad.41.1778048064376; 
 Tue, 05 May 2026 23:14:24 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7bf330a0sm13048515ad.31.2026.05.05.23.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 23:14:24 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 06 May 2026 11:44:14 +0530
Subject: [PATCH] usb: dwc3: Fix crash on fastboot exit due to incorrect
 memory free
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-usb-v1-1-e0f426bb1e42@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADXc+mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwMz3dLiJF0LE2OLtESzFBNj8yQloMqCotS0zAqwKdGxtbUAFC8yNVU
 AAAA=
X-Change-ID: 20260506-usb-8438fa6d437b
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778048061; l=1058;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=oaRozSsAfsrEyZpK1rptmRV7y82k7LkeAITvCU8UffM=;
 b=laQPw5T4eJNazN2TAB4uH8mzUgLwJ5EVQgNxDURcinNZYoj+swCXs/tYbT5CsMBmiPSMh7It3
 mYaNGKatfcvD2l5f8YZEhuhcyRw/pWk9hp+KKIgIoNxLxFiL7KxuK5g
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=XvnK/1F9 c=1 sm=1 tr=0 ts=69fadc41 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=fKU-DjF7s0nMRrjlPjIA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: NVKwNZk0Hl3xUbi-5YfpVq-eIYDxbdRy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA1NyBTYWx0ZWRfX5Amz0xMaRHUq
 duAyKjNJqNqykRzLBJXHYorNd8ck0OFUKgpnxQ5F0GxWERE9RCMebdK9wJkQraypHyDHaTf/T5V
 vFoe25uSUlbE1D2j+LJuxRF1tkogmHEIUyAdi9F+Xrx61FuTPRsY8aYPC3bNqxNYwHP84R+2EeR
 nF1lNX7r52CocgtTHMEYIVYROxY2J6UXu93Iqhrb2ZXDW7KoJZcJ8xFUz7Nk71HA8lw65SNwZw0
 3UY+RCXQdA++IUO7PvuWmTtTorMOki7lLCa2RBPESuWypFETkLTulI/uXWbhsmtSs3PI4oHl8jV
 P9dKXLhX+MDGZ1+RMgUklb2DpbnbRUEjAiCX+DWToF/NGille8s3a4URs/NbTkM+wjMp02dnf1X
 LrT5AmUMAApirIZ5aAH/6taOdErZ+tbmlj4XadlkJ9ZRt+Maz06gTQBOB8Fj9D3NbRhnD6aFI3q
 ThSrYz5FEYYYSYmrz4w==
X-Proofpoint-GUID: NVKwNZk0Hl3xUbi-5YfpVq-eIYDxbdRy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060057
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

The dwc3_free_one_event_buffer() function incorrectly called free()
on event buffer structures allocated with devm_kzalloc(). This
caused heap corruption and a synchronous abort when exiting
fastboot mode via "fastboot continue".

Device-managed memory is automatically freed when the device is
removed, so manual deallocation causes the heap allocator to access
corrupted metadata.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/usb/dwc3/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 0dee14c8b59..be198041f08 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -208,7 +208,6 @@ static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
 		struct dwc3_event_buffer *evt)
 {
 	dma_free_coherent(evt->buf);
-	free(evt);
 }
 
 /**

---
base-commit: ae8987f4e690f397f507c4b1efabd68b3ed08db6
change-id: 20260506-usb-8438fa6d437b

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

