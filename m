Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C4DD3B9BE
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 17:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E81283A26;
	Wed, 10 Dec 2025 18:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nNjI9MQh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B/DAGw1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D395283C08; Wed, 10 Dec 2025 16:55:09 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26E7B808AF
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 16:55:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=loic.poulain@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BA8e0EU1917972
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=jg5AHOBE2D3Hl8UMIB8rzf4u3qoD1vEm8gE
 pgiMAnes=; b=nNjI9MQhswtZPHPxgnJsKe51SW49tu9RO3KrNpFBpid3bWOIgxn
 aOmjQdOqMXHgbH+WcAo2pyRnC5lMoMPcAMkQjjlNY8T9LxzSFvMKjpQj+R776y81
 dU/aiF1Myf2cOpc41cde0AiwoMSaFK3teURs+wt+I1Z+bYiFTaGLCS9hMtbkbc+e
 IBRh6RjUtBCW3JLc8cq4Z5vjV2EB8zAqd8TnYnUm1cC/xafjB9rNRWGlc4fpkHV6
 d0GBsWtIkPMic8caUNzTExVaVy0xyPtrYxgTYOoXth9fjfvOkx6ZdHrmm/Y0iejp
 HbpKr7QRdoqE4I0hhcCsIrvaXxkvSaEyJCg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ay1xp22aq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:55:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4edad69b4e8so19801141cf.1
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 07:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1765382099; x=1765986899; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jg5AHOBE2D3Hl8UMIB8rzf4u3qoD1vEm8gEpgiMAnes=;
 b=B/DAGw1m5s22rGU0oo5rH5rOpEJliy1UJpQBd/DiyAkxzhVDGfUs99Qs4WTU36zcor
 DVaYJvJ9LMUOix9kwM3M+fyoZOGIqiniDd3RrcIHpnjbIc0ILdK6l+sAqrnJjvHJ5x6s
 Tn9O3g4rjoBwy7UTcVyX3Xli2GJPbZFfmB+rgdJ7fh1MT0mkz1dE/mB81EdSRkGHU3Y3
 pgEB20JUnFjecTK/4p9vPP4l7XWOLpr5tvgu1q5U1e6a5Mc2IGEcBIVd5PZBwM9KKZat
 pRBvOTPWtRi2+PpfUWiV5RStfjM3v/MuZ+w404vkFe88oHPjgb42tSkS6ePdzMcJmqDk
 NvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765382099; x=1765986899;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jg5AHOBE2D3Hl8UMIB8rzf4u3qoD1vEm8gEpgiMAnes=;
 b=T2kd/P0DQxC+jcC7Egwiep4yTINaBWr4d/xKmtSHp1g8lgnU1pS4mqmjCFqLqBsj30
 Eo2PI8L4Q2Ed8TUsyzuzVLFO0ZpjS+HeJ4Kf8qp1kJu63qJMNZlYDxkEEvyUqAWdlNR/
 /HLB/trfGIbaNiAymzHomHM74Z+fvEM+3h6OhgYx1p8p/18uQ8+GY/VrOzWFFEDyS7nZ
 NjaxWvjjby4newLGb4p+y/Qx5I2GKnBUdMhdD3Okh9cZ34Bi+415s+4KMb3m6JiMu3uN
 I4zwHb0+otxCnYu4U6yEUmjPcj+Yf5ZVuzX9fZ1b41TVpl6nDFUSSorSrzCY1B0JimGF
 bufg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU21N0r7oCEeHiomrh5l88+TdSuKs4GOCsDQKcl6rtlCFlWCy6qlS1qXTi9XZMJdrOM98oqVw0=@lists.denx.de
X-Gm-Message-State: AOJu0YxeC3M/hzw7MjzIR3U/KFL1NEYwsuSlZQ0C2Tl4QCO9QDBa0QuY
 U4OHU0zKMT9aV6zur73qXt7zxyzjaCSEiScxdnnNKPJkDCDzsQLW8xq0WAh8dUycmMbHYFTVh9j
 YVXUTh0xrxqb27lM5FdS/UEKtikUDf+0OAOHoXxKe8qfw+xkBVsCZXFN3
X-Gm-Gg: ASbGncsJRYjOns7XgwhtQy1/tcycm1KnbD4ZzoXchjNjdiQG0mS2RyY2MeqqO396lBS
 o7YuiVLyqRZMrUevGe9g8jM9gIPT7KBblYkAMjldmVMoeGhXtQ+jLXzVWdpgSnAy1zpxHbzMnu8
 kwyiBTbz+H8XRVVA8jqR1+YWWQNIwlT98Ed67ay2/u7NZnkqJnfy2RmZ7JsupwAurpRIH8wJsMk
 0oGR0l7jHmAlKYqYijhUmv7v7gztnXMI0JzaQQ7ncQWBHcEv3YE9spKeafn4NMfATOoXv/0D+1S
 ShWzjcfrnowOMXfvba6vZXnp0nQM59YkKeayqlBz5IxVna2mGOdU1tw02NGlyDQikvRKcv7i0dC
 nmM5eofDHBjDoy+fksZxcGXv/01eYHhgSeksKGfVIRIuh42pcHAdJ9CcCwrVWpqJREzvMjBJVgD
 6D
X-Received: by 2002:ac8:7255:0:b0:4f1:b362:eed7 with SMTP id
 d75a77b69052e-4f1b362f34dmr20989891cf.42.1765382099141; 
 Wed, 10 Dec 2025 07:54:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIltyHHE9GW3i9M4EgUrzmA24rjnYMY9g/qi3DXmbUT8Rot4MMNQ2j7S1B8/7DbJw+nmk9LQ==
X-Received: by 2002:ac8:7255:0:b0:4f1:b362:eed7 with SMTP id
 d75a77b69052e-4f1b362f34dmr20989701cf.42.1765382098695; 
 Wed, 10 Dec 2025 07:54:58 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.qualcomm.com
 ([2a01:e0a:82c:5f0:f840:4916:e7c3:a857])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbfee50sm38126808f8f.14.2025.12.10.07.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 07:54:57 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
To: lukma@denx.de, casey.connolly@linaro.org, neil.armstrong@linaro.org
Cc: sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH 1/3] mmc: msm_sdhci: Fix incorrect divider calculation for
 SDCLK
Date: Wed, 10 Dec 2025 16:54:52 +0100
Message-Id: <20251210155454.1561611-1-loic.poulain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDEyOSBTYWx0ZWRfX3rzsTSd1ww9S
 NBhdEZ8BmqyzWiBhKFa80HVqeuJtjaFEiPzhxjzWg8rEFGhGsJhgsJWwk5SRe/8IPqmkkRlfF2M
 T9N+xRbv0PO1JGxNAess7xNPrYub35arrgYdQoOkc5vkk5hX+OThTYjBuA5b3SgFlWchW6uRah6
 oZFJfu2p6cW9gzqDgNAYN6aZR7O5OsJ+cbCV0Tti68LSux6HSG2+/cZlDF7xLLralZe2kwPYmAm
 hHkZ4Zez+OyoE3cNwp4lFRs9khz/d2e3XxSjRQWYS0dMAcsdKuTdI8cMBdzBl/RpUM4ul/bX+I/
 aEx+L9o8IIjanu2val088xShYEBUAyInQFGKLMjTK3X/UonM3UpiUYx7VPBCA46UR7dZI5YxOjx
 wqJHKeP6OqRmLbjRBk5NuCXSbZ+Tqw==
X-Proofpoint-ORIG-GUID: KWb4I7euWmmhyZAnEGhP4AXxVJvfnQoL
X-Proofpoint-GUID: KWb4I7euWmmhyZAnEGhP4AXxVJvfnQoL
X-Authority-Analysis: v=2.4 cv=A/Zh/qWG c=1 sm=1 tr=0 ts=693997d4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=3jPR3l14tl_WsrGInXAA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512100129
X-Mailman-Approved-At: Wed, 10 Dec 2025 18:11:14 +0100
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

When 'max-clk' is not specified, the SDHCI core retrieves the base clock
from the SDHCI_CAPABILITIES register (bits [15:8]). However, this field
is unreliable on MSM SDHCI controllers, as noted by the Linux driver
using the SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN flag. In addition, the field
is only 8 bits wide and cannot represent base clocks above 255 MHz.

On platforms like Agatti/QCM2290, the firmware sets the SDHCI clock to
384 MHz, but the capabilities register reports 200 MHz. As a result,
the core calculates a divider of 4, producing a 96 MHz SDCLK instead of
the intended ~52 MHz. This overclocking can cause sporadic CRC errors
with certain eMMC.

To fix this, use the actual clock rate reported by the SDHCI core clock
instead of relying on the capabilities register for divider calculation.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/mmc/msm_sdhci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index ac77fb06bf7..ec003991928 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -114,6 +114,9 @@ static int msm_sdc_clk_init(struct udevice *dev)
 		return -EINVAL;
 	}
 
+	/* This is the base clock sdhci core will use to configure the SDCLK */
+	prv->host.max_clk = clk_rate;
+
 	writel_relaxed(CORE_VENDOR_SPEC_POR_VAL,
 		       prv->host.ioaddr + var_info->core_vendor_spec);
 
-- 
2.34.1

