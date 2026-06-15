Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFD8CD98C7
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 12:20:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08F938488A;
	Mon, 15 Jun 2026 14:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NsgsGMMq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R7fmE5t4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEDDE83FEE; Mon, 15 Jun 2026 14:20:03 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E7A3848D8
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FAoKr33983241
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JPyFwPSrEEj
 JwTEnAZYjYS2KDCflMfASqtgdwbnXP5M=; b=NsgsGMMq5+OynvUKqTwKPrxc1CZ
 jhhn0PXB32YpB6RVXj635qCLUsFH+vWUmfaXSaPrUgANzMz2OsO3Yb743w271PRa
 Qq2rxDN+X9wITMgcj7jtaK9mNnfoo4fXuhZYKuSOzsnr1kozBuxHCD18g1r9P3Nk
 AyqfM+qoJifk6Y7e8sm+kgcPboP+Z0PD2IbHL0jd8HHgipNGXnY1mgWKAh5lNxmY
 fZcBroipqHjRHfOwgKGbTNIoU/joINZwf7t9fw/Dwei1mqOW68iUTKf3ENb9bcf3
 2RSV4XpStIyqSAeBQPcRHa5KYGhxnKo/qVmDpb9oCrCHKx++PMY/z3cU6Jg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etfa70g4v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:19:58 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8421f5d76aaso2415828b3a.2
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 05:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781525998; x=1782130798; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JPyFwPSrEEjJwTEnAZYjYS2KDCflMfASqtgdwbnXP5M=;
 b=R7fmE5t47utt+ThIh+zsLivYhU4tIX+wyJ8+RpmQKdA1pTB/bmQl2FbBDAucdfh1C4
 U7fZcCJAKHGmMsPDUr/BZQ09CTrt4lMjic7fsb3AUOp6veLh3RE5pNSiunaslYRBgwmZ
 ho4JDZMYcmqDWcBPwvv4mktyHW4d9XH1884wypFWcow9ieVDGwzS5cmgOnv7VFrUNvUR
 H4+hkrY/Ry28LJcFuLF+fNVfLR1LF+i2STY54ct8/zLGEoGRFL9bOBxZBzmTdwfP5ait
 RfxAHn2qkXOWnNVyrjrDmddL2ADbmMgZPPUPraMebHdYREfojORbfP2jtvjGueEb4fgo
 5bCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781525998; x=1782130798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JPyFwPSrEEjJwTEnAZYjYS2KDCflMfASqtgdwbnXP5M=;
 b=APEa0ZgpGBw6YkVRxIH9U+1iYudAcvmUKR8D1NMfJqqGQMaVULCGmqjhyx3z3J698L
 nYqU8bwgx32X2o0cP/dgEIVKgdXkj6dc0bQlY2a7koeKEhtKjUqHiUjhSpHsXrHmMqXU
 3JtG/wJi1Y34mFa0IgVHNLhkgQODPQYwuAibsJvZrS4rwhAR8D0Qr3taEMupX1GcRCNS
 Z9WZ0fsSLvytL3Ih4umD7qQl8eRjc0EoEsuwXQyqVbFULKSB4u9vlu8gk7Bad/tYfHBd
 pUin5xpXZK410HQlzYVDp/mrFk5+c6Ufg13naeu6HKgrdNlcv91gNo1o112Jqvpqe6b/
 JQPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8umby6NPnahfvzXKOchi5tUJulCSSms7dXTXwkzE5kZ792cgIvQDrxrwMYDwxuOU8d5ISYSYg=@lists.denx.de
X-Gm-Message-State: AOJu0YwlIeKf7bXo3lXwcPF++R/M+Tpg9WhReYCwNLy8NNqVaF3PIecR
 5Ppo7aI5xoCbiBiGU8ON6/rdTTASriAksVP0H/Re4OPSyV7ausi0usBQeP3sRYAHTeqrLrMxt3f
 NsvLpe9C41D6pTrggquljXqQOO0fIMuGHfFOGHbX6tFpU77YUhBWg4Ncj
X-Gm-Gg: Acq92OFGfdsKWJJGyuqhv5fnPrk0JBMmM3SOwhn1QH6bmECQXbbczlI3Rkl1BDabzaY
 ud3nAbdNQrqdzdJxA62WBzY27QyuBVByECD80BWmxsM6zAl4/iF4Qxpk1Iokg+XOK+cJXX7D7ez
 wdjO484oJPsZC9SYFd4jYs+nCCHe2eRVYciV5ctDTMSlawJEW7u4caza7oG22IwoikMBV5V2V3P
 yxrZPTmp8N0G5qRHyV5H5v2TOyDG+A97j5WzyPspKNseqqxVqLQw1MFqFnuX3D/RGBb8DGiUfqG
 barm8DDBkOw2bnGM1V4bWBA9p9ExJUWsIbdg/e5T1ZsI9r4SMlRwrIaSbT2HVln98uLHUomF5Ar
 ARkhSMH6/WD8MXSKYL66h/T8FQmw9HnUU9IiyjiaFK4tFmnKjAN6rcAgFZoMpybBuu07jo/bYXz
 SdE6CLXEuqBAL2kxXWVAtgZFIDulTDBpyhXPLPTCGC
X-Received: by 2002:a05:6a00:22d1:b0:83d:b11f:7979 with SMTP id
 d2e1a72fcca58-844e1a3d7d2mr11313814b3a.29.1781525997680; 
 Mon, 15 Jun 2026 05:19:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:22d1:b0:83d:b11f:7979 with SMTP id
 d2e1a72fcca58-844e1a3d7d2mr11313772b3a.29.1781525997232; 
 Mon, 15 Jun 2026 05:19:57 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434accae18sm10434823b3a.17.2026.06.15.05.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 05:19:56 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, marek.vasut+renesas@mailbox.org,
 kever.yang@rock-chips.com, tien.fong.chee@altera.com,
 clamor95@gmail.com, jbx6244@gmail.com, frieder.schrempf@kontron.de,
 briansune@gmail.com, andre.przywara@arm.com, hai.pham.ud@renesas.com,
 dlechner@baylibre.com, emanuele.ghidoli@toradex.com,
 nguyen.tran.pz@bp.renesas.com, j@jannau.net, contact@paulk.fr,
 balaji.selvanathan@oss.qualcomm.com, quic_varada@quicinc.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 david.wronek@mainlining.org, peng.fan@nxp.com, me@ziyao.cc,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 8/8] board: qualcomm: add MAINTAINERS entries for Shikra
 platforms
Date: Mon, 15 Jun 2026 17:48:28 +0530
Message-Id: <20260615121828.1798789-9-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615121828.1798789-1-aswin.murugan@oss.qualcomm.com>
References: <20260615121828.1798789-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NZyuWaO2rYbfzigP0MkgVRb6ff52Ar9I
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX4d++gTtHiheK
 c9hyNuwd7ytJWlUsfW1OOQvv8Ojd1R9DJuzH6mAFiCd42zE16ii9Dv6/VoSyUvdpS8+wsiTH6Rq
 zdAFHMRoKviJGZe1mZhtpinQhsT+a5E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX2hbZQsWb0hRU
 sld2/VW+dD8n0aDtIeUuy5ZfR5ZXps4ia3zwVq20AEVRbxLR9929lMsPgDMu1JRyh/53GiBP7xV
 fBwrsumVuxhx9dURF6ATC/lHEKVL5nNzijTzExdt95hZl+rfEEOAaVe6VSBTBxF/s+vjjkKHEKD
 LO9TWG1PLCsSX1lq64ZNIsn03PHE46X0o/Dfx3gydHLXb2VbjqZadTm/GDsVvoMjMQ81KDbiI6C
 mSu0h+Iqt+PXi5oaJM82IXCyRbplRoflJGxTUp8/c0CpjtwWp2y0mLmngHpP9aqsmCUJakIi+oT
 +7T6HSDmJsQSzJRoICFle4V3LF6M/ySizHZRvjdRHioKNJQ6BwVGVozlZU7JXdRTHbBuOcsl9Vq
 qx49B8d/vInyyuUdUb4iK9kEUrAriA3qTmDwASsIFOPcY+S7fHxfGsJkXaveQiMeaQl9UkLVNXD
 yQQ9OJTVbeiXyDWSgUQ==
X-Proofpoint-GUID: NZyuWaO2rYbfzigP0MkgVRb6ff52Ar9I
X-Authority-Analysis: v=2.4 cv=AN2yTM5Z c=1 sm=1 tr=0 ts=6a2fedee cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=0qS0ShtDTrQMTPoL9qcA:9 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150130
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

Add MAINTAINERS entries for the Qualcomm Shikra platform

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 board/qualcomm/MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/qualcomm/MAINTAINERS b/board/qualcomm/MAINTAINERS
index 3767a2a7949..84ad7117bd9 100644
--- a/board/qualcomm/MAINTAINERS
+++ b/board/qualcomm/MAINTAINERS
@@ -6,6 +6,11 @@ M:	Aswin Murugan <aswin.murugan@oss.qualcomm.com>
 S:	Maintained
 N:	qcs615
 
+QUALCOMM DRAGONWING SHIKRA
+M:      Aswin Murugan <aswin.murugan@oss.qualcomm.com>
+S:      Maintained
+N:      shikra
+
 # RB3 Gen 2 and similar boards
 QUALCOMM DRAGONWING QCS6490
 M:	Casey Connolly <casey.connolly@linaro.org>
-- 
2.34.1

