Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A31CFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 15:55:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3813483E63;
	Mon, 24 Nov 2025 16:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TEvoax3q";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eSmF5th6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ECB883E60; Mon, 24 Nov 2025 16:55:38 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2DE483B85
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 16:55:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AOEvaNg707010
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MYW5hLHlcm6
 euRDMbFOCbaDwLK/m3fgrCbxEV+YXXqk=; b=TEvoax3qluF+XAaPYJcEmDbPcAi
 mhgB6BUvSdCpTVzmevCLKO7Yp1xqxaBDXOAm+3sTBbWjYldT/wZwxfwJlQ3uPuOH
 hQaE+v5MVjApLq6xRnWToxc6snAZ3E1Yka68UCoLnO+qMGjQlCoNzo7BdOdavQOW
 cDoAVqAYXOq0ZemGh0Qt+kBc5KIZcAOlo8RRw6UUFJ0qeIllTKJL2I7OizQY83+Y
 xcnJGBY4mdu48t0YxRj6m6hoUucs8WBBTjxHYFZmVnKG/jXi4Tlvw90/ihN+91OE
 cTZmkvRuQ3bnxaO6tlM1WHnoAQHhr+6USmVuIGYxfdZRMYWYSpO90/x6Qkg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amsk685vw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:55:29 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7a99a5f77e0so7638910b3a.2
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 07:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763999728; x=1764604528; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MYW5hLHlcm6euRDMbFOCbaDwLK/m3fgrCbxEV+YXXqk=;
 b=eSmF5th6k0ZzRYBxe7IwMZ/l7tBsywD0WRQ45gPTFprYuGgKDgEOkFLgnt5F17t+L5
 TX2F/qCmre6/obeh5QB+U7CxukTmO9uiofnwq+UFXOHIj0jf+Sf2XnGkSGTRwnHtATJS
 Wt6U4Sp7gGZslHpxK9yJ6Nc+Z1ilGNc+YW7ywRM3q9ZxfR8ayEyg6SZ2k01tsqXQjIPn
 NdjVnozwHwribE1nDSLhby5AfKb64WUpK7H/vfjEsNt/IjSllgX16P38NCbUHdVy7d6u
 Itjf32vFM8B45YPau/O4GcM0z9qOg0o9mCmg1kFNnHn2nog9MePAZSJpW0Y115/feMSV
 QvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763999728; x=1764604528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MYW5hLHlcm6euRDMbFOCbaDwLK/m3fgrCbxEV+YXXqk=;
 b=dW7rDc8/XlDejv1fzN0a5bI5jp/ECcId2r05FxviLYIoltuUTQom1jggVo3ESIbFcS
 YHeSyWf5PTGP/rDdaHDtNI8d+IaeZwDUgnce35EtRm6le+Nxf64OM6Bngxemh0FJGSKP
 JuMtpr/dGP8q8zN690gKyInGUzNfxTDCV+HwIEWSaivUebAFb+iHg7fKxFQUN98XWs38
 JgdhQA9/wt7JTC3plb/SubDNXMRR1TwoWNY4DK0MnEgUApxW5CiN8y7QIu0MF17PmcIE
 uc/E71V62z392ZYmKLNeW9F2KRlpBPOQICZvHfyphvWFgn0/lxEEafTDS5g5axwp6pK+
 ncxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeXBhUcCfucF6gQS9jAPd374TeN1jA8Q/LL56biNwkfP/NSw2koZJnGy6Qe2EVph2Jd7kax34=@lists.denx.de
X-Gm-Message-State: AOJu0YwmCDEMXGE+ZL9yu9bC7bKurrgWK+QJISvM46FD1qhRPHGtTXnl
 g1ybINztDWJ68NhyURMbueqL251bZHGRVIKN4G2o5qVFLJN1dMIrhMGYTM19mnWPF3pKZ9BNtGK
 The+bZwKKnohQLE/XvtclUGRWxIWvIZkCaIrjy+kTQHOKtZVtqKm7hSC3
X-Gm-Gg: ASbGncu+8oNYUuO+9/xoDGpho1Ozh8DbddtyDzl5upVsQPo1KGlHjq+2KMp5r/qVlsk
 RiNy6y74fuDcXwipUH7WWSaedXXoL4etCXDiC5HodIc2X+qC0rKxkZoGhKPy1wHSAFdnva1t23R
 WEGN4AOs9LnhQE6Kk7lf16Lh4dbGhuFcIBxme7fMk2TkdubInyJiNF2vpWPJehi44zdStulAdC6
 DDuNijaa1AH+EDkHlEMbQKI4P5T5X6Q6R/EhYzY2Rd1zn8uFCiFULm9IiS+1+Fp7kwe5AFFDw4X
 lyZaWNXBItbDHFK0RakxZIjgfgUeD9UM/D5Zr2k+4HT8/p/l1zBGMdIGNwi4js6ftsIWyhJNGRG
 Rz4jFm32/AC756ouzZ/olcOWgVl8R/sDGQRkxhtTjafPm4O1j868UMMPZOALB1ENhD7pF7onW0c
 oiVLvgz+3fAZ7p1XYu28EUkcXOHRbUBufsCb7fiQ==
X-Received: by 2002:a05:6a00:4615:b0:7b9:9232:2124 with SMTP id
 d2e1a72fcca58-7c58c3a6a5dmr14008387b3a.14.1763999728156; 
 Mon, 24 Nov 2025 07:55:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhfYIZv7AnqIC0YvS29EV2mwntSciVe04V0e/Nhd+llymgfe3aRFJTv/CMLlUBLrKLa6KJIA==
X-Received: by 2002:a05:6a00:4615:b0:7b9:9232:2124 with SMTP id
 d2e1a72fcca58-7c58c3a6a5dmr14008338b3a.14.1763999727647; 
 Mon, 24 Nov 2025 07:55:27 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c3f023fd82sm15254884b3a.42.2025.11.24.07.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 07:55:27 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 malysagreg@gmail.com, arturs.artamonovs@analog.com,
 utsav.agarwal@analog.com, vasileios.bimpikas@analog.com,
 ian.roberts@timesys.com, nathan.morrison@timesys.com, peng.fan@nxp.com,
 alif.zakuan.yuslaimi@altera.com, kory.maincent@bootlin.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 balaji.selvanathan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 2/7] drivers: usb: dwc3: Add delay after core soft reset
Date: Mon, 24 Nov 2025 21:24:58 +0530
Message-Id: <20251124155503.2839766-3-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TMCEr2SeugVZl9A_keYDyNNQYd2znYPp
X-Proofpoint-ORIG-GUID: TMCEr2SeugVZl9A_keYDyNNQYd2znYPp
X-Authority-Analysis: v=2.4 cv=WL5yn3sR c=1 sm=1 tr=0 ts=69247ff1 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ss--aXFnE7Wsk0pJjiIA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDEzOSBTYWx0ZWRfX1TeOP0Rs3T68
 ogKoESIUGVsswPt7XhuwmB/XFkRtYWbkdDkLDVOtVFG1lAHBnUSvIHE0Dx4qmnSJQC2OdHCsYdQ
 H3SmiCa5UOEqj5lGsyr5E2O4IbfuqSnuS8OJ4iabmSaM+FmDMds8/sMx8biNW791WJH6evO/h3f
 rhud3HDOmIpXtajtLnbJcZk7kZIzEViXlcZ0q1OkyAN8rXMdQ3KbYkS3Tq7tTo8lLqE7woGQGwf
 06VeeReg/ND0amamtxN+drHUgvTl+D2jtujaxPDnmA2lTiPwn6gB4tmwhXTolIUZv4EcZCk7Ey6
 sbfAYjb5bBVcXpMiOre8Z6uxDXTatLViBddMr5jVfxRvIDbX6s1VTvvtoQvXljKJe+hVe1sLnVZ
 qPzRiJzUJqjsDmBaaimZyg2WSq/xGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_06,2025-11-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240139
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

Add a 100 ms delay after clearing the core soft reset bit to ensure
the DWC3 controller has sufficient time to complete its reset
sequence before subsequent register accesses.

Without this delay, USB initialization can fail on some Qualcomm
platforms, particularly when using super-speed capable PHYs like
the QMP USB3-DP Combo PHY on SC7280/QCM6490.

The change is taken from following upstream Linux implementation:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/dwc3/core.c?id=f88359e1588b85cf0e8209ab7d6620085f3441d9

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
v2:
- Gave correct commit id for linux implementation
---
 drivers/usb/dwc3/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 847fa1f82c3..ff0bca0dd8e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -94,6 +94,8 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 	reg &= ~DWC3_GCTL_CORESOFTRESET;
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 
+	mdelay(100);
+
 	return 0;
 }
 
-- 
2.34.1

