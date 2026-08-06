Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46E3C55174
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 02:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67A5580E87;
	Thu,  6 Aug 2026 02:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ay65uxrXml3s; Thu,  6 Aug 2026 02:21:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B970B80E8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785982902;
	bh=7c/KOf+VnWP2cq/EWyTalLVysT5jk6hvDxBUbiqVLPY=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=KHYj0kXeUZ6iBqWc9I1hgqpBhIVbf9UXHWxl3i92K7kGmQ3AeNlOhq9cL2Faigvh7
	 cPJGLhCHXg+snMV4iGqWWKuOF+HJEd6n0sMteRHKAaVtOgRRWS2sfzvLshJVSvbBX8
	 IbdDN6i7xRfNk9uVpejtSapN0EgzlXeL97QAgl7G6nAU8vWMtryWRAYHDQrwMChr1j
	 i66u6FLM2xkQaGLcYgIwED2Vyu/kz4E16HFsggPo5A8u4btKrirt926aE1s7dGIPdI
	 WSGhZ3TNfwpc6ib3RLdmRcCslECRhcEs7NjIYDwyDSpbzbGfy/QdwfwWCHU/hqKp8I
	 G8mYI7bgrfmsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B970B80E8D;
	Thu,  6 Aug 2026 02:21:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DAA7C1AF
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 02:21:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B617680E7F
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 02:21:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a6ll6PQpKvch for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 02:21:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 111E080E5F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 111E080E5F
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 111E080E5F
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 02:21:37 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675NbHMU206613
 for <u-boot@lists.u-boot-project.org>; Thu, 6 Aug 2026 02:21:37 GMT
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv2c0c37e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 02:21:36 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cab048cdb3eso2308118a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 19:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785982895; x=1786587695;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7c/KOf+VnWP2cq/EWyTalLVysT5jk6hvDxBUbiqVLPY=;
 b=rfcCKTaizKjEbOSJdEb9mWawGjCX/WrJIy2Dhbcb3FQJ9QCS3fQhGbqdy2BXQW6qfo
 +Dnw3dT1JDQKAYwzSoPSXLC2oUdPHB0z60mgmVf+cU2db+MCI7ARyyCgTpohg5ZpzWIn
 y2KHOlB/hYQyzvenGEXmc7iTntJtu82KZwik/7uZPCZ0iDtA4+6zD7CoDRmBGYtdgXwK
 N8vrix2leLMxxonpfGdVskNcOnz73tHsTrK8i1T8kkQ22NySU6KVgI903K3H51bgUlvC
 BIgS5MaGcx98u+aIfoHzPweHgpMxb7zwc10QlYFYLYclHhFqsOW2Rwe+dy2k7r0WIc6M
 LL2w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQIgdDFyF8VLteiDuSaeIVkEX0yy6QnAgLR4h8suT/1ss+02MniHGBAWstmRYNfgZRRJ/pRC4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy2o++6jEdRhTVx5C88O4iCXR6eRgf5PtBnXzOZ8IVS10SDt6kp
 EJItW3zc7Drl28ERStJyA7zA5RxUGooJVg25U6ol6HRZfVy941Fp34UucjxIFqdrUQnLpjuD4hB
 WHKyoyjk3jMJ+gltbx3Br91WUM4RZZhDWeAmMFgLrBbOoLCtyALjDRgRwtupiyaV082Ltv0Y=
X-Gm-Gg: AR+sD12FGxLq6oW1g3JsufuPDFH323c/9yF6V9MZ4jswcc0KdwZssFCH4nvw3cq/W2k
 Cjlxaptgk57SViTjymWjLCb+RF6os6wcCHpjnZfu/57NiPOLAM6eid6+B/5tGmKZZaogq6V0MbO
 dhzmvPAnxfF2+sJRG5lZUNMxVg1LOVEfOI1xyI01U5Rw9rshzmbMUudnboQLIdzAmH4fMPaWfoC
 ADEWOU0Lcsv1jDTvctJcW71HR7sAP6eEMOlMwnf5+OGio7hCypU5tdglG5daMhVBVEZDaMvO6Bd
 Xa59bHDqLrUc0yBtiPuXCe9PaQIMJM+rDYEQO09xoB1O+qWiaj1BHrhUQ/SJ75kANGTcigVL1l3
 1SFdI9ZlFJyYDcqLwlfSzQqptSpxetBFPFm+Oicj8lOJgpUWGX0FoPL2VNCptws8AfESUfY7k9J
 LyIiQDBA/93s1VDeCm5RwHZM4Tp47PDw==
X-Received: by 2002:a05:6a21:398f:b0:3c3:a41f:ce7d with SMTP id
 adf61e73a8af0-3cb85bbea0dmr13474537637.0.1785982892938; 
 Wed, 05 Aug 2026 19:21:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:398f:b0:3c3:a41f:ce7d with SMTP id
 adf61e73a8af0-3cb85bbea0dmr13474356637.0.1785982890942; 
 Wed, 05 Aug 2026 19:21:30 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158673be99sm36385067eec.15.2026.08.05.19.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 19:21:29 -0700 (PDT)
Date: Thu, 06 Aug 2026 07:51:06 +0530
Subject: [PATCH 3/5] phy: qcom: Add QMP USB PHY driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-fastboot-v1-3-cab7d64e592b@oss.qualcomm.com>
References: <20260806-fastboot-v1-0-cab7d64e592b@oss.qualcomm.com>
In-Reply-To: <20260806-fastboot-v1-0-cab7d64e592b@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 David Lechner <dlechner@baylibre.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 7PLLoS9xmc2fcvuvxCzQIGyMpQvjAW37
X-Authority-Analysis: v=2.4 cv=aOfAb79m c=1 sm=1 tr=0 ts=6a73efb0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=uY2NmljVR4hHAAjbRY0A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAxNiBTYWx0ZWRfX/6sQBA0PVIRw
 Fo0hKQJKdsjRhkSfHUvVMxuxmvMxJDtsO7rHzOBZGEhM+OevH1ATtpVUhEzfF0vFcnkFLG1eyts
 jMiX/yPE+5WdLL5y5Tztm7rmBmM1qs8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAxNiBTYWx0ZWRfX7CswUmNwcICf
 IoSH3OlR20aoXJ0XMdqwDeHNUyyBB4F+0Q/84bNq2gzTAJ4WR4yiC6PNtjeWz3u73lFiuQgMNkG
 nhP12BvSyFnNSSh/7Gp9+n13fWz3nIviJFw351iLKDDwQzSAoSBSGH6a/v3EZfOi3xIMpLuDNHt
 C094uimykTI4fxwAfYub1JZeBcMLIBX5XhpIcUKShap1AcNyCHFh8U3LKc49GoXs5HCjgdl5zCJ
 fxZQwEKGWncKoJiKG0AlmhBTPlEAwgc81LNooNO5xy58x2P5WoAPvalkmKtqwU+N04bOkQtE+UR
 Ypi/bRZ/cyUzpe07yUmA6v539eQz5VS13dNGILjQEI0CXr+ayFirJJsQEDW8SwS1UpLr/vrRsUK
 aEL3ZPmFc703oeQ0bOUZYytUdno1R7yPdFXEyx53/TGRY4xQR1hOORxteLC0CwLIpFxd0jK7NaY
 ayNBRxsQK6DTjCmx4PQ==
X-Proofpoint-GUID: 7PLLoS9xmc2fcvuvxCzQIGyMpQvjAW37
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060016
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7c/KOf+VnWP2cq/EWyTalLVysT5jk6hvDxBUbiqVLPY=; b=YijjBgwhKJuGyu7n
 WIhf+2rU2DVeGk6R4idZdZljZG3g1m49mszVafAhB6QxRQA3gMrNtxRX5/nj+Mxa
 V1U2YFAppHdS3E/Oszi/DQnyfgjAaOfop4eIea93fzMO21OG1JVpC7rgOof8BgfN
 gKwf5zPKQK58x3DeQcGhOge0Vl0oJZ5ds3+2QSSsiMs7e7l+7XYkKulIZDfFZUIE
 FzLKV8NXgtyPvByyMndVt/op9WiKxJKR85N9c6E400jjH/l1+jTPX7GRq2uhXs7v
 BX7pixZc5+cRQQJWirUaOWU2HMzOoDySfenKdXrd7Jy0NRq8hAblEQzjDvfvIykD
 yGc/dA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785982895; x=1786587695;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7c/KOf+VnWP2cq/EWyTalLVysT5jk6hvDxBUbiqVLPY=;
 b=SNVbAo+sz+CLLG+xjVIbGUIrevbcrhlLwF/213cNveZ6BING0mlt/0hPOILx3Ybp8U
 sjY/BgjtehyrfDNYkNyobsq86KpYn1PraP2ulLfhH3UzPi4GgSX6S0ylu/D5tj8Y58jR
 iz1z7FBBvx75bWBdWCtFrLvZqlRdqkgZmxfIeT8gLeSUJONyUvyFDfm40YJkCjGuBvLS
 oQvKFBWvZcYGftxHI9nQbaBdd4Sx5vmBPha3keB95f5tnOaQrE5ZUMJ3w8YjQIJ/pneC
 mm1gH+egGUqK0+yMW/x+u+THKfjkqYJB08/XzITcMkCKqLnPwoPJdzwy0aYLBWjkY9Fp
 glmg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=YijjBgwh; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SNVbAo+s
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Port Qualcomm QMP USB PHY driver from Linux (v7.2-rc4). This PHY is
available in many Qcom SoCs. Enabled and tested the driver on IPQ9574.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/phy/qcom/Kconfig                           |    8 +
 drivers/phy/qcom/Makefile                          |    1 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-misc-v4.h        |   17 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v5.h         |   36 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v6.h         |   17 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v7.h         |   17 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v8.h         |   38 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v4_20.h          |   15 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v5_20.h          |   21 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v6-n4.h          |   32 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v6.h             |    2 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v7.h             |   34 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v8.h             |   32 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v8_50.h          |   13 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v2.h     |  109 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v6.h     |    7 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v7.h     |   87 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v8.h     |   75 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com.h        |  231 +-
 drivers/phy/qcom/phy-qcom-qmp-qserdes-lalb-v8.h    |  639 ++++++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-ln-shrd-v5.h |   11 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v2.h    |  205 ++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v4_20.h |   43 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v5_20.h |   86 +
 .../phy/qcom/phy-qcom-qmp-qserdes-txrx-v5_5nm.h    |  328 +++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v6.h    |    1 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v6_n4.h |   64 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v7.h    |   80 +
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v8.h    |   68 +
 drivers/phy/qcom/phy-qcom-qmp-ufs.c                |  136 +-
 drivers/phy/qcom/phy-qcom-qmp-usb.c                | 2198 ++++++++++++++++++++
 .../phy/qcom/phy-qcom-qmp-usb43-qserdes-com-v8.h   |  224 ++
 drivers/phy/qcom/phy-qcom-qmp.h                    |  142 +-
 33 files changed, 4726 insertions(+), 291 deletions(-)

diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
index 1fdadaccb12..38f46dd2ec1 100644
--- a/drivers/phy/qcom/Kconfig
+++ b/drivers/phy/qcom/Kconfig
@@ -32,6 +32,14 @@ config PHY_QCOM_QMP_UFS
 	help
 	  Enable this to support the UFS QMP PHY on various Qualcomm chipsets.
 
+config PHY_QCOM_QMP_USB
+	bool "Qualcomm QMP USB PHY Driver"
+	select GENERIC_PHY
+	default PHY_QCOM_QMP
+	help
+	  Enable this to support the QMP USB PHY transceiver that is used
+	  with USB3 controllers on Qualcomm chips.
+
 config PHY_QCOM_QUSB2
 	bool "Qualcomm USB QUSB2 PHY driver"
 	depends on PHY && ARCH_SNAPDRAGON
diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
index 714013dc572..7ede50e6bc1 100644
--- a/drivers/phy/qcom/Makefile
+++ b/drivers/phy/qcom/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
 obj-$(CONFIG_PHY_QCOM_QMP_COMBO) += phy-qcom-qmp-combo.o
 obj-$(CONFIG_PHY_QCOM_QMP_PCIE) += phy-qcom-qmp-pcie.o
 obj-$(CONFIG_PHY_QCOM_QMP_UFS) += phy-qcom-qmp-ufs.o
+obj-$(CONFIG_PHY_QCOM_QMP_USB) += phy-qcom-qmp-usb.o
 obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
 obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2) += phy-qcom-snps-femto-v2.o
 obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2) += phy-qcom-snps-eusb2.o
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-misc-v4.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-misc-v4.h
new file mode 100644
index 00000000000..e256a089f22
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-misc-v4.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_MISC_V4_H_
+#define QCOM_PHY_QMP_PCS_MISC_V4_H_
+
+/* Only for QMP V4 PHY - PCS_MISC registers */
+#define QPHY_V4_PCS_MISC_TYPEC_CTRL			0x00
+#define QPHY_V4_PCS_MISC_TYPEC_PWRDN_CTRL		0x04
+#define QPHY_V4_PCS_MISC_PCS_MISC_CONFIG1		0x08
+#define QPHY_V4_PCS_MISC_CLAMP_ENABLE			0x0c
+#define QPHY_V4_PCS_MISC_TYPEC_STATUS			0x10
+#define QPHY_V4_PCS_MISC_PLACEHOLDER_STATUS		0x14
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v5.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v5.h
new file mode 100644
index 00000000000..73de626223e
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v5.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_USB_V5_H_
+#define QCOM_PHY_QMP_PCS_USB_V5_H_
+
+/* Only for QMP V5 PHY - USB3 have different offsets than V4 */
+#define QPHY_V5_PCS_USB3_POWER_STATE_CONFIG1		0x000
+#define QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_STATUS		0x004
+#define QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL		0x008
+#define QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL2		0x00c
+#define QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_SOURCE_STATUS	0x010
+#define QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR		0x014
+#define QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL	0x018
+#define QPHY_V5_PCS_USB3_LFPS_TX_ECSTART		0x01c
+#define QPHY_V5_PCS_USB3_LFPS_PER_TIMER_VAL		0x020
+#define QPHY_V5_PCS_USB3_LFPS_TX_END_CNT_U3_START	0x024
+#define QPHY_V5_PCS_USB3_LFPS_CONFIG1			0x028
+#define QPHY_V5_PCS_USB3_RXEQTRAINING_LOCK_TIME		0x02c
+#define QPHY_V5_PCS_USB3_RXEQTRAINING_WAIT_TIME		0x030
+#define QPHY_V5_PCS_USB3_RXEQTRAINING_CTLE_TIME		0x034
+#define QPHY_V5_PCS_USB3_RXEQTRAINING_WAIT_TIME_S2	0x038
+#define QPHY_V5_PCS_USB3_RXEQTRAINING_DFE_TIME_S2	0x03c
+#define QPHY_V5_PCS_USB3_RCVR_DTCT_DLY_U3_L		0x040
+#define QPHY_V5_PCS_USB3_RCVR_DTCT_DLY_U3_H		0x044
+#define QPHY_V5_PCS_USB3_ARCVR_DTCT_EN_PERIOD		0x048
+#define QPHY_V5_PCS_USB3_ARCVR_DTCT_CM_DLY		0x04c
+#define QPHY_V5_PCS_USB3_TXONESZEROS_RUN_LENGTH		0x050
+#define QPHY_V5_PCS_USB3_ALFPS_DEGLITCH_VAL		0x054
+#define QPHY_V5_PCS_USB3_SIGDET_STARTUP_TIMER_VAL	0x058
+#define QPHY_V5_PCS_USB3_TEST_CONTROL			0x05c
+#define QPHY_V5_PCS_USB3_RXTERMINATION_DLY_SEL		0x060
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v6.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v6.h
new file mode 100644
index 00000000000..df670143feb
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v6.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_USB_V6_H_
+#define QCOM_PHY_QMP_PCS_USB_V6_H_
+
+#define QPHY_V6_PCS_USB3_POWER_STATE_CONFIG1		0x00
+#define QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL		0x08
+#define QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR		0x14
+#define QPHY_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL	0x18
+#define QPHY_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2	0x3c
+#define QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L		0x40
+#define QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H		0x44
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v7.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v7.h
new file mode 100644
index 00000000000..24368d45ae7
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v7.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_USB_V7_H_
+#define QCOM_PHY_QMP_PCS_USB_V7_H_
+
+#define QPHY_V7_PCS_USB3_POWER_STATE_CONFIG1		0x00
+#define QPHY_V7_PCS_USB3_AUTONOMOUS_MODE_CTRL		0x08
+#define QPHY_V7_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR		0x14
+#define QPHY_V7_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL	0x18
+#define QPHY_V7_PCS_USB3_RXEQTRAINING_DFE_TIME_S2	0x3c
+#define QPHY_V7_PCS_USB3_RCVR_DTCT_DLY_U3_L		0x40
+#define QPHY_V7_PCS_USB3_RCVR_DTCT_DLY_U3_H		0x44
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v8.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v8.h
new file mode 100644
index 00000000000..89ace8024bc
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v8.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_USB_V8_H_
+#define QCOM_PHY_QMP_PCS_USB_V8_H_
+
+#define QPHY_V8_PCS_USB_POWER_STATE_CONFIG1		0x00
+#define QPHY_V8_PCS_USB_AUTONOMOUS_MODE_STATUS		0x04
+#define QPHY_V8_PCS_USB_AUTONOMOUS_MODE_CTRL		0x08
+#define QPHY_V8_PCS_USB_AUTONOMOUS_MODE_CTRL2		0x0c
+#define QPHY_V8_PCS_USB_LFPS_RXTERM_IRQ_SOURCE_STATUS	0x10
+#define QPHY_V8_PCS_USB_LFPS_RXTERM_IRQ_CLEAR		0x14
+#define QPHY_V8_PCS_USB_LFPS_DET_HIGH_COUNT_VAL		0x18
+#define QPHY_V8_PCS_USB_LFPS_TX_ECSTART			0x1c
+#define QPHY_V8_PCS_USB_LFPS_PER_TIMER_VAL		0x20
+#define QPHY_V8_PCS_USB_LFPS_TX_END_CNT_U3_START	0x24
+#define QPHY_V8_PCS_USB_LFPS_CONFIG1			0x28
+#define QPHY_V8_PCS_USB_RXEQTRAINING_LOCK_TIME		0x2c
+#define QPHY_V8_PCS_USB_RXEQTRAINING_WAIT_TIME		0x30
+#define QPHY_V8_PCS_USB_RXEQTRAINING_CTLE_TIME		0x34
+#define QPHY_V8_PCS_USB_RXEQTRAINING_WAIT_TIME_S2	0x38
+#define QPHY_V8_PCS_USB_RXEQTRAINING_DFE_TIME_S2	0x3c
+#define QPHY_V8_PCS_USB_RCVR_DTCT_DLY_U3_L		0x40
+#define QPHY_V8_PCS_USB_RCVR_DTCT_DLY_U3_H		0x44
+#define QPHY_V8_PCS_USB_ARCVR_DTCT_EN_PERIOD		0x48
+#define QPHY_V8_PCS_USB_ARCVR_DTCT_CM_DLY		0x4c
+#define QPHY_V8_PCS_USB_TXONESZEROS_RUN_LENGTH		0x50
+#define QPHY_V8_PCS_USB_ALFPS_DEGLITCH_VAL		0x54
+#define QPHY_V8_PCS_USB_SIGDET_STARTUP_TIMER_VAL	0x58
+#define QPHY_V8_PCS_USB_TEST_CONTROL			0x5c
+#define QPHY_V8_PCS_USB_RXTERMINATION_DLY_SEL		0x60
+#define QPHY_V8_PCS_USB_POWER_STATE_CONFIG2		0x64
+#define QPHY_V8_PCS_USB_POWER_STATE_CONFIG3		0x68
+#define QPHY_V8_PCS_USB_POWER_STATE_CONFIG4		0x6c
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-v4_20.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-v4_20.h
new file mode 100644
index 00000000000..08c3dd11548
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-v4_20.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V4_20_H_
+#define QCOM_PHY_QMP_PCS_V4_20_H_
+
+/* Only for QMP V4_20 PHY - USB/PCIe PCS registers */
+#define QPHY_V4_20_PCS_RX_SIGDET_LVL			0x188
+#define QPHY_V4_20_PCS_EQ_CONFIG2			0x1d8
+#define QPHY_V4_20_PCS_EQ_CONFIG4			0x1e0
+#define QPHY_V4_20_PCS_EQ_CONFIG5			0x1e4
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-v5_20.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-v5_20.h
new file mode 100644
index 00000000000..bbee68df4e1
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-v5_20.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022, Linaro Ltd.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V5_20_H_
+#define QCOM_PHY_QMP_PCS_V5_20_H_
+
+#define QPHY_V5_20_PCS_INSIG_SW_CTRL7			0x060
+#define QPHY_V5_20_PCS_INSIG_MX_CTRL7			0x07c
+#define QPHY_V5_20_PCS_LOCK_DETECT_CONFIG1		0x0c4
+#define QPHY_V5_20_PCS_LOCK_DETECT_CONFIG2		0x0c8
+#define QPHY_V5_20_PCS_G3S2_PRE_GAIN			0x170
+#define QPHY_V5_20_PCS_RX_SIGDET_LVL			0x188
+#define QPHY_V5_20_PCS_ALIGN_DETECT_CONFIG1		0x1b8
+#define QPHY_V5_20_PCS_ALIGN_DETECT_CONFIG2		0x1bc
+#define QPHY_V5_20_PCS_EQ_CONFIG2			0x1d8
+#define QPHY_V5_20_PCS_EQ_CONFIG4			0x1e0
+#define QPHY_V5_20_PCS_EQ_CONFIG5			0x1e4
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-v6-n4.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-v6-n4.h
new file mode 100644
index 00000000000..b3024714dab
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-v6-n4.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V6_N4_H_
+#define QCOM_PHY_QMP_PCS_V6_N4_H_
+
+/* Only for QMP V6 N4 PHY - USB/PCIe PCS registers */
+#define QPHY_V6_N4_PCS_SW_RESET			0x000
+#define QPHY_V6_N4_PCS_PCS_STATUS1		0x014
+#define QPHY_V6_N4_PCS_POWER_DOWN_CONTROL	0x040
+#define QPHY_V6_N4_PCS_START_CONTROL		0x044
+#define QPHY_V6_N4_PCS_POWER_STATE_CONFIG1	0x090
+#define QPHY_V6_N4_PCS_LOCK_DETECT_CONFIG1	0x0c4
+#define QPHY_V6_N4_PCS_LOCK_DETECT_CONFIG2	0x0c8
+#define QPHY_V6_N4_PCS_LOCK_DETECT_CONFIG3	0x0cc
+#define QPHY_V6_N4_PCS_LOCK_DETECT_CONFIG6	0x0d8
+#define QPHY_V6_N4_PCS_REFGEN_REQ_CONFIG1	0x0dc
+#define QPHY_V6_N4_PCS_RX_SIGDET_LVL		0x188
+#define QPHY_V6_N4_PCS_RCVR_DTCT_DLY_P1U2_L	0x190
+#define QPHY_V6_N4_PCS_RCVR_DTCT_DLY_P1U2_H	0x194
+#define QPHY_V6_N4_PCS_RATE_SLEW_CNTRL1		0x198
+#define QPHY_V6_N4_PCS_RX_CONFIG		0x1b0
+#define QPHY_V6_N4_PCS_ALIGN_DETECT_CONFIG1	0x1c0
+#define QPHY_V6_N4_PCS_ALIGN_DETECT_CONFIG2	0x1c4
+#define QPHY_V6_N4_PCS_PCS_TX_RX_CONFIG		0x1d0
+#define QPHY_V6_N4_PCS_EQ_CONFIG1		0x1dc
+#define QPHY_V6_N4_PCS_EQ_CONFIG2		0x1e0
+#define QPHY_V6_N4_PCS_EQ_CONFIG5		0x1ec
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-v6.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-v6.h
index 08299d2b78f..aa5afb921f1 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-pcs-v6.h
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-v6.h
@@ -17,6 +17,8 @@
 #define QPHY_V6_PCS_LOCK_DETECT_CONFIG3		0x0cc
 #define QPHY_V6_PCS_LOCK_DETECT_CONFIG6		0x0d8
 #define QPHY_V6_PCS_REFGEN_REQ_CONFIG1		0x0dc
+#define QPHY_V6_PCS_G12S1_TXDEEMPH_M6DB		0x168
+#define QPHY_V6_PCS_G3S2_PRE_GAIN		0x170
 #define QPHY_V6_PCS_RX_SIGDET_LVL		0x188
 #define QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_L	0x190
 #define QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_H	0x194
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-v7.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-v7.h
new file mode 100644
index 00000000000..4b7fcaa6a37
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-v7.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V7_H_
+#define QCOM_PHY_QMP_PCS_V7_H_
+
+/* Only for QMP V7 PHY - USB/PCIe PCS registers */
+#define QPHY_V7_PCS_SW_RESET			0x000
+#define QPHY_V7_PCS_PCS_STATUS1			0x014
+#define QPHY_V7_PCS_POWER_DOWN_CONTROL		0x040
+#define QPHY_V7_PCS_START_CONTROL		0x044
+#define QPHY_V7_PCS_POWER_STATE_CONFIG1		0x090
+#define QPHY_V7_PCS_LOCK_DETECT_CONFIG1		0x0c4
+#define QPHY_V7_PCS_LOCK_DETECT_CONFIG2		0x0c8
+#define QPHY_V7_PCS_LOCK_DETECT_CONFIG3		0x0cc
+#define QPHY_V7_PCS_LOCK_DETECT_CONFIG6		0x0d8
+#define QPHY_V7_PCS_REFGEN_REQ_CONFIG1		0x0dc
+#define QPHY_V7_PCS_G12S1_TXDEEMPH_M6DB		0x168
+#define QPHY_V7_PCS_G3S2_PRE_GAIN		0x170
+#define QPHY_V7_PCS_RX_SIGDET_LVL		0x188
+#define QPHY_V7_PCS_RCVR_DTCT_DLY_P1U2_L	0x190
+#define QPHY_V7_PCS_RCVR_DTCT_DLY_P1U2_H	0x194
+#define QPHY_V7_PCS_RATE_SLEW_CNTRL1		0x198
+#define QPHY_V7_PCS_CDR_RESET_TIME		0x1b0
+#define QPHY_V7_PCS_ALIGN_DETECT_CONFIG1	0x1c0
+#define QPHY_V7_PCS_ALIGN_DETECT_CONFIG2	0x1c4
+#define QPHY_V7_PCS_PCS_TX_RX_CONFIG		0x1d0
+#define QPHY_V7_PCS_EQ_CONFIG1			0x1dc
+#define QPHY_V7_PCS_EQ_CONFIG2			0x1e0
+#define QPHY_V7_PCS_EQ_CONFIG5			0x1ec
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-v8.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-v8.h
new file mode 100644
index 00000000000..169fd5de747
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-v8.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V8_H_
+#define QCOM_PHY_QMP_PCS_V8_H_
+
+/* Only for QMP V8 PHY - USB/PCIe PCS registers */
+#define QPHY_V8_PCS_SW_RESET			0x000
+#define QPHY_V8_PCS_PCS_STATUS1			0x014
+#define QPHY_V8_PCS_POWER_DOWN_CONTROL		0x040
+#define QPHY_V8_PCS_START_CONTROL		0x044
+#define QPHY_V8_PCS_POWER_STATE_CONFIG1		0x090
+#define QPHY_V8_PCS_LOCK_DETECT_CONFIG1		0x0c4
+#define QPHY_V8_PCS_LOCK_DETECT_CONFIG2		0x0c8
+#define QPHY_V8_PCS_LOCK_DETECT_CONFIG3		0x0cc
+#define QPHY_V8_PCS_LOCK_DETECT_CONFIG6		0x0d8
+#define QPHY_V8_PCS_REFGEN_REQ_CONFIG1		0x0dc
+#define QPHY_V8_PCS_RX_SIGDET_LVL		0x188
+#define QPHY_V8_PCS_RCVR_DTCT_DLY_P1U2_L	0x190
+#define QPHY_V8_PCS_RCVR_DTCT_DLY_P1U2_H	0x194
+#define QPHY_V8_PCS_RATE_SLEW_CNTRL1		0x198
+#define QPHY_V8_PCS_CDR_RESET_TIME		0x1b0
+#define QPHY_V8_PCS_ALIGN_DETECT_CONFIG1	0x1c0
+#define QPHY_V8_PCS_ALIGN_DETECT_CONFIG2	0x1c4
+#define QPHY_V8_PCS_PCS_TX_RX_CONFIG		0x1d0
+#define QPHY_V8_PCS_EQ_CONFIG1			0x1dc
+#define QPHY_V8_PCS_EQ_CONFIG2			0x1e0
+#define QPHY_V8_PCS_EQ_CONFIG5			0x1ec
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-v8_50.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-v8_50.h
new file mode 100644
index 00000000000..325c127e8eb
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-v8_50.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V8_50_H_
+#define QCOM_PHY_QMP_PCS_V8_50_H_
+
+#define QPHY_V8_50_PCS_STATUS1			0x010
+#define QPHY_V8_50_PCS_START_CONTROL			0x05c
+#define QPHY_V8_50_PCS_POWER_DOWN_CONTROL			0x64
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v2.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v2.h
new file mode 100644
index 00000000000..cb599c11318
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v2.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_COM_V2_H_
+#define QCOM_PHY_QMP_QSERDES_COM_V2_H_
+
+/* Only for QMP V2 PHY - QSERDES COM registers */
+#define QSERDES_V2_COM_ATB_SEL1				0x000
+#define QSERDES_V2_COM_ATB_SEL2				0x004
+#define QSERDES_V2_COM_FREQ_UPDATE			0x008
+#define QSERDES_V2_COM_BG_TIMER				0x00c
+#define QSERDES_V2_COM_SSC_EN_CENTER			0x010
+#define QSERDES_V2_COM_SSC_ADJ_PER1			0x014
+#define QSERDES_V2_COM_SSC_ADJ_PER2			0x018
+#define QSERDES_V2_COM_SSC_PER1				0x01c
+#define QSERDES_V2_COM_SSC_PER2				0x020
+#define QSERDES_V2_COM_SSC_STEP_SIZE1			0x024
+#define QSERDES_V2_COM_SSC_STEP_SIZE2			0x028
+#define QSERDES_V2_COM_POST_DIV				0x02c
+#define QSERDES_V2_COM_POST_DIV_MUX			0x030
+#define QSERDES_V2_COM_BIAS_EN_CLKBUFLR_EN		0x034
+#define QSERDES_V2_COM_CLK_ENABLE1			0x038
+#define QSERDES_V2_COM_SYS_CLK_CTRL			0x03c
+#define QSERDES_V2_COM_SYSCLK_BUF_ENABLE		0x040
+#define QSERDES_V2_COM_PLL_EN				0x044
+#define QSERDES_V2_COM_PLL_IVCO				0x048
+#define QSERDES_V2_COM_LOCK_CMP1_MODE0			0x04c
+#define QSERDES_V2_COM_LOCK_CMP2_MODE0			0x050
+#define QSERDES_V2_COM_LOCK_CMP3_MODE0			0x054
+#define QSERDES_V2_COM_LOCK_CMP1_MODE1			0x058
+#define QSERDES_V2_COM_LOCK_CMP2_MODE1			0x05c
+#define QSERDES_V2_COM_LOCK_CMP3_MODE1			0x060
+#define QSERDES_V2_COM_EP_CLOCK_DETECT_CTR		0x068
+#define QSERDES_V2_COM_SYSCLK_DET_COMP_STATUS		0x06c
+#define QSERDES_V2_COM_BG_TRIM				0x070
+#define QSERDES_V2_COM_CLK_EP_DIV			0x074
+#define QSERDES_V2_COM_CP_CTRL_MODE0			0x078
+#define QSERDES_V2_COM_CP_CTRL_MODE1			0x07c
+#define QSERDES_V2_COM_PLL_RCTRL_MODE0			0x084
+#define QSERDES_V2_COM_PLL_RCTRL_MODE1			0x088
+#define QSERDES_V2_COM_PLL_CCTRL_MODE0			0x090
+#define QSERDES_V2_COM_PLL_CCTRL_MODE1			0x094
+#define QSERDES_V2_COM_PLL_CNTRL			0x09c
+#define QSERDES_V2_COM_BIAS_EN_CTRL_BY_PSM		0x0a8
+#define QSERDES_V2_COM_SYSCLK_EN_SEL			0x0ac
+#define QSERDES_V2_COM_CML_SYSCLK_SEL			0x0b0
+#define QSERDES_V2_COM_RESETSM_CNTRL			0x0b4
+#define QSERDES_V2_COM_RESETSM_CNTRL2			0x0b8
+#define QSERDES_V2_COM_RESCODE_DIV_NUM			0x0c4
+#define QSERDES_V2_COM_LOCK_CMP_EN			0x0c8
+#define QSERDES_V2_COM_LOCK_CMP_CFG			0x0cc
+#define QSERDES_V2_COM_DEC_START_MODE0			0x0d0
+#define QSERDES_V2_COM_DEC_START_MODE1			0x0d4
+#define QSERDES_V2_COM_VCOCAL_DEADMAN_CTRL		0x0d8
+#define QSERDES_V2_COM_DIV_FRAC_START1_MODE0		0x0dc
+#define QSERDES_V2_COM_DIV_FRAC_START2_MODE0		0x0e0
+#define QSERDES_V2_COM_DIV_FRAC_START3_MODE0		0x0e4
+#define QSERDES_V2_COM_DIV_FRAC_START1_MODE1		0x0e8
+#define QSERDES_V2_COM_DIV_FRAC_START2_MODE1		0x0ec
+#define QSERDES_V2_COM_DIV_FRAC_START3_MODE1		0x0f0
+#define QSERDES_V2_COM_VCO_TUNE_MINVAL1			0x0f4
+#define QSERDES_V2_COM_VCO_TUNE_MINVAL2			0x0f8
+#define QSERDES_V2_COM_INTEGLOOP_INITVAL		0x100
+#define QSERDES_V2_COM_INTEGLOOP_EN			0x104
+#define QSERDES_V2_COM_INTEGLOOP_GAIN0_MODE0		0x108
+#define QSERDES_V2_COM_INTEGLOOP_GAIN1_MODE0		0x10c
+#define QSERDES_V2_COM_INTEGLOOP_GAIN0_MODE1		0x110
+#define QSERDES_V2_COM_INTEGLOOP_GAIN1_MODE1		0x114
+#define QSERDES_V2_COM_VCO_TUNE_MAXVAL1			0x118
+#define QSERDES_V2_COM_VCO_TUNE_MAXVAL2			0x11c
+#define QSERDES_V2_COM_VCO_TUNE_CTRL			0x124
+#define QSERDES_V2_COM_VCO_TUNE_MAP			0x128
+#define QSERDES_V2_COM_VCO_TUNE1_MODE0			0x12c
+#define QSERDES_V2_COM_VCO_TUNE2_MODE0			0x130
+#define QSERDES_V2_COM_VCO_TUNE1_MODE1			0x134
+#define QSERDES_V2_COM_VCO_TUNE2_MODE1			0x138
+#define QSERDES_V2_COM_VCO_TUNE_INITVAL1		0x13c
+#define QSERDES_V2_COM_VCO_TUNE_INITVAL2		0x140
+#define QSERDES_V2_COM_VCO_TUNE_TIMER1			0x144
+#define QSERDES_V2_COM_VCO_TUNE_TIMER2			0x148
+#define QSERDES_V2_COM_CMN_STATUS			0x15c
+#define QSERDES_V2_COM_RESET_SM_STATUS			0x160
+#define QSERDES_V2_COM_RESTRIM_CODE_STATUS		0x164
+#define QSERDES_V2_COM_PLLCAL_CODE1_STATUS		0x168
+#define QSERDES_V2_COM_PLLCAL_CODE2_STATUS		0x16c
+#define QSERDES_V2_COM_BG_CTRL				0x170
+#define QSERDES_V2_COM_CLK_SELECT			0x174
+#define QSERDES_V2_COM_HSCLK_SEL			0x178
+#define QSERDES_V2_COM_INTEGLOOP_BINCODE_STATUS		0x17c
+#define QSERDES_V2_COM_PLL_ANALOG			0x180
+#define QSERDES_V2_COM_CORECLK_DIV			0x184
+#define QSERDES_V2_COM_SW_RESET				0x188
+#define QSERDES_V2_COM_CORE_CLK_EN			0x18c
+#define QSERDES_V2_COM_C_READY_STATUS			0x190
+#define QSERDES_V2_COM_CMN_CONFIG			0x194
+#define QSERDES_V2_COM_CMN_RATE_OVERRIDE		0x198
+#define QSERDES_V2_COM_SVS_MODE_CLK_SEL			0x19c
+#define QSERDES_V2_COM_DEBUG_BUS0			0x1a0
+#define QSERDES_V2_COM_DEBUG_BUS1			0x1a4
+#define QSERDES_V2_COM_DEBUG_BUS2			0x1a8
+#define QSERDES_V2_COM_DEBUG_BUS3			0x1ac
+#define QSERDES_V2_COM_DEBUG_BUS_SEL			0x1b0
+#define QSERDES_V2_COM_CMN_MISC1			0x1b4
+#define QSERDES_V2_COM_CMN_MISC2			0x1b8
+#define QSERDES_V2_COM_CORECLK_DIV_MODE1		0x1bc
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v6.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v6.h
index 328c6c0b0b0..258f3d30742 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v6.h
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v6.h
@@ -86,4 +86,11 @@
 #define QSERDES_V6_COM_CMN_STATUS				0x1d0
 #define QSERDES_V6_COM_C_READY_STATUS				0x1f8
 
+#define QSERDES_V6_COM_ADAPTIVE_ANALOG_CONFIG			0x268
+#define QSERDES_V6_COM_CP_CTRL_ADAPTIVE_MODE0			0x26c
+#define QSERDES_V6_COM_PLL_RCCTRL_ADAPTIVE_MODE0		0x270
+#define QSERDES_V6_COM_PLL_CCTRL_ADAPTIVE_MODE0			0x274
+#define QSERDES_V6_COM_CP_CTRL_ADAPTIVE_MODE1			0x278
+#define QSERDES_V6_COM_PLL_RCCTRL_ADAPTIVE_MODE1		0x27c
+#define QSERDES_V6_COM_PLL_CCTRL_ADAPTIVE_MODE1			0x280
 #endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v7.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v7.h
new file mode 100644
index 00000000000..7430f492147
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v7.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_COM_V7_H_
+#define QCOM_PHY_QMP_QSERDES_COM_V7_H_
+
+/* Only for QMP V7 PHY - QSERDES COM registers */
+
+#define QSERDES_V7_COM_SSC_STEP_SIZE1_MODE1			0x00
+#define QSERDES_V7_COM_SSC_STEP_SIZE2_MODE1			0x04
+#define QSERDES_V7_COM_CP_CTRL_MODE1				0x10
+#define QSERDES_V7_COM_PLL_RCTRL_MODE1				0x14
+#define QSERDES_V7_COM_PLL_CCTRL_MODE1				0x18
+#define QSERDES_V7_COM_CORECLK_DIV_MODE1			0x1c
+#define QSERDES_V7_COM_LOCK_CMP1_MODE1				0x20
+#define QSERDES_V7_COM_LOCK_CMP2_MODE1				0x24
+#define QSERDES_V7_COM_DEC_START_MODE1				0x28
+#define QSERDES_V7_COM_DEC_START_MSB_MODE1			0x2c
+#define QSERDES_V7_COM_DIV_FRAC_START1_MODE1			0x30
+#define QSERDES_V7_COM_DIV_FRAC_START2_MODE1			0x34
+#define QSERDES_V7_COM_DIV_FRAC_START3_MODE1			0x38
+#define QSERDES_V7_COM_HSCLK_SEL_1				0x3c
+#define QSERDES_V7_COM_INTEGLOOP_GAIN0_MODE1			0x40
+#define QSERDES_V7_COM_INTEGLOOP_GAIN1_MODE1			0x44
+#define QSERDES_V7_COM_VCO_TUNE1_MODE1				0x48
+#define QSERDES_V7_COM_VCO_TUNE2_MODE1				0x4c
+#define QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE1_MODE1		0x50
+#define QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE2_MODE1		0x54
+#define QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE1_MODE0		0x58
+#define QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE2_MODE0		0x5c
+#define QSERDES_V7_COM_SSC_STEP_SIZE1_MODE0			0x60
+#define QSERDES_V7_COM_SSC_STEP_SIZE2_MODE0			0x64
+#define QSERDES_V7_COM_CP_CTRL_MODE0				0x70
+#define QSERDES_V7_COM_PLL_RCTRL_MODE0				0x74
+#define QSERDES_V7_COM_PLL_CCTRL_MODE0				0x78
+#define QSERDES_V7_COM_PLL_CORE_CLK_DIV_MODE0			0x7c
+#define QSERDES_V7_COM_LOCK_CMP1_MODE0				0x80
+#define QSERDES_V7_COM_LOCK_CMP2_MODE0				0x84
+#define QSERDES_V7_COM_DEC_START_MODE0				0x88
+#define QSERDES_V7_COM_DEC_START_MSB_MODE0			0x8c
+#define QSERDES_V7_COM_DIV_FRAC_START1_MODE0			0x90
+#define QSERDES_V7_COM_DIV_FRAC_START2_MODE0			0x94
+#define QSERDES_V7_COM_DIV_FRAC_START3_MODE0			0x98
+#define QSERDES_V7_COM_HSCLK_HS_SWITCH_SEL_1			0x9c
+#define QSERDES_V7_COM_INTEGLOOP_GAIN0_MODE0			0xa0
+#define QSERDES_V7_COM_INTEGLOOP_GAIN1_MODE0			0xa4
+#define QSERDES_V7_COM_VCO_TUNE1_MODE0				0xa8
+#define QSERDES_V7_COM_VCO_TUNE2_MODE0				0xac
+#define QSERDES_V7_COM_BG_TIMER					0xbc
+#define QSERDES_V7_COM_SSC_EN_CENTER				0xc0
+#define QSERDES_V7_COM_SSC_ADJ_PER1				0xc4
+#define QSERDES_V7_COM_SSC_PER1					0xcc
+#define QSERDES_V7_COM_SSC_PER2					0xd0
+#define QSERDES_V7_COM_PLL_POST_DIV_MUX				0xd8
+#define QSERDES_V7_COM_PLL_BIAS_EN_CLK_BUFLR_EN			0xdc
+#define QSERDES_V7_COM_CLK_ENABLE1				0xe0
+#define QSERDES_V7_COM_SYS_CLK_CTRL				0xe4
+#define QSERDES_V7_COM_SYSCLK_BUF_ENABLE			0xe8
+#define QSERDES_V7_COM_PLL_IVCO					0xf4
+#define QSERDES_V7_COM_PLL_IVCO_MODE1				0xf8
+#define QSERDES_V7_COM_SYSCLK_EN_SEL				0x110
+#define QSERDES_V7_COM_RESETSM_CNTRL				0x118
+#define QSERDES_V7_COM_LOCK_CMP_EN				0x120
+#define QSERDES_V7_COM_LOCK_CMP_CFG				0x124
+#define QSERDES_V7_COM_VCO_TUNE_CTRL				0x13c
+#define QSERDES_V7_COM_VCO_TUNE_MAP				0x140
+#define QSERDES_V7_COM_VCO_TUNE_INITVAL2			0x148
+#define QSERDES_V7_COM_VCO_TUNE_MAXVAL2				0x158
+#define QSERDES_V7_COM_CLK_SELECT				0x164
+#define QSERDES_V7_COM_CORE_CLK_EN				0x170
+#define QSERDES_V7_COM_CMN_CONFIG_1				0x174
+#define QSERDES_V7_COM_SVS_MODE_CLK_SEL				0x17c
+#define QSERDES_V7_COM_CMN_MISC_1				0x184
+#define QSERDES_V7_COM_CMN_MODE					0x188
+#define QSERDES_V7_COM_PLL_VCO_DC_LEVEL_CTRL			0x198
+#define QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_1			0x1a4
+#define QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_2			0x1a8
+#define QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_3			0x1ac
+#define QSERDES_V7_COM_ADDITIONAL_MISC				0x1b4
+#define QSERDES_V7_COM_ADDITIONAL_MISC_2			0x1b8
+#define QSERDES_V7_COM_ADDITIONAL_MISC_3			0x1bc
+#define QSERDES_V7_COM_CMN_STATUS				0x1d0
+#define QSERDES_V7_COM_C_READY_STATUS				0x1f8
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v8.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v8.h
new file mode 100644
index 00000000000..d8ac4c4a2c3
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v8.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_COM_V8_H_
+#define QCOM_PHY_QMP_QSERDES_COM_V8_H_
+
+/* Only for QMP V8 PHY - QSERDES COM registers */
+#define QSERDES_V8_COM_SSC_STEP_SIZE1_MODE1		0x000
+#define QSERDES_V8_COM_SSC_STEP_SIZE2_MODE1		0x004
+#define QSERDES_V8_COM_SSC_STEP_SIZE3_MODE1		0x008
+#define QSERDES_V8_COM_CP_CTRL_MODE1			0x010
+#define QSERDES_V8_COM_PLL_RCTRL_MODE1			0x014
+#define QSERDES_V8_COM_PLL_CCTRL_MODE1			0x018
+#define QSERDES_V8_COM_CORECLK_DIV_MODE1		0x01c
+#define QSERDES_V8_COM_LOCK_CMP1_MODE1			0x020
+#define QSERDES_V8_COM_LOCK_CMP2_MODE1			0x024
+#define QSERDES_V8_COM_DEC_START_MODE1			0x028
+#define QSERDES_V8_COM_DEC_START_MSB_MODE1		0x02c
+#define QSERDES_V8_COM_DIV_FRAC_START1_MODE1		0x030
+#define QSERDES_V8_COM_DIV_FRAC_START2_MODE1		0x034
+#define QSERDES_V8_COM_DIV_FRAC_START3_MODE1		0x038
+#define QSERDES_V8_COM_HSCLK_SEL_1			0x03c
+#define QSERDES_V8_COM_VCO_TUNE1_MODE1			0x048
+#define QSERDES_V8_COM_VCO_TUNE2_MODE1			0x04c
+#define QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE1_MODE1	0x050
+#define QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE2_MODE1	0x054
+#define QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE1_MODE0	0x058
+#define QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE2_MODE0	0x05c
+#define QSERDES_V8_COM_SSC_STEP_SIZE1_MODE0		0x060
+#define QSERDES_V8_COM_SSC_STEP_SIZE2_MODE0		0x064
+#define QSERDES_V8_COM_CP_CTRL_MODE0			0x070
+#define QSERDES_V8_COM_PLL_RCTRL_MODE0			0x074
+#define QSERDES_V8_COM_PLL_CCTRL_MODE0			0x078
+#define QSERDES_V8_COM_CORECLK_DIV_MODE0			0x07c
+#define QSERDES_V8_COM_LOCK_CMP1_MODE0			0x080
+#define QSERDES_V8_COM_LOCK_CMP2_MODE0			0x084
+#define QSERDES_V8_COM_DEC_START_MODE0			0x088
+#define QSERDES_V8_COM_DEC_START_MSB_MODE0		0x08c
+#define QSERDES_V8_COM_DIV_FRAC_START1_MODE0		0x090
+#define QSERDES_V8_COM_DIV_FRAC_START2_MODE0		0x094
+#define QSERDES_V8_COM_DIV_FRAC_START3_MODE0		0x098
+#define QSERDES_V8_COM_HSCLK_HS_SWITCH_SEL_1		0x09c
+#define QSERDES_V8_COM_VCO_TUNE1_MODE0			0x0a8
+#define QSERDES_V8_COM_VCO_TUNE2_MODE0			0x0ac
+#define QSERDES_V8_COM_BG_TIMER				0x0bc
+#define QSERDES_V8_COM_SSC_EN_CENTER			0x0c0
+#define QSERDES_V8_COM_SSC_PER1				0x0cc
+#define QSERDES_V8_COM_SSC_PER2				0x0d0
+#define QSERDES_V8_COM_BIAS_EN_CLKBUFLR_EN		0x0dc
+#define QSERDES_V8_COM_CLK_ENABLE1		0x0e0
+#define QSERDES_V8_COM_SYS_CLK_CTRL		0x0e4
+#define QSERDES_V8_COM_PLL_IVCO		0x0f4
+#define QSERDES_V8_COM_SYSCLK_BUF_ENABLE		0x0e8
+#define QSERDES_V8_COM_SYSCLK_EN_SEL			0x110
+#define QSERDES_V8_COM_RESETSM_CNTRL			0x118
+#define QSERDES_V8_COM_LOCK_CMP_EN			0x120
+#define QSERDES_V8_COM_LOCK_CMP_CFG			0x124
+#define QSERDES_V8_COM_VCO_TUNE_MAP			0x140
+#define QSERDES_V8_COM_CLK_SELECT			0x164
+#define QSERDES_V8_COM_CORE_CLK_EN			0x170
+#define QSERDES_V8_COM_CMN_CONFIG_1			0x174
+#define QSERDES_V8_COM_CMN_MISC_1			0x184
+#define QSERDES_V8_COM_CMN_MODE			0x188
+#define QSERDES_V8_COM_VCO_DC_LEVEL_CTRL			0x198
+#define QSERDES_V8_COM_PLL_SPARE_FOR_ECO			0x2b4
+#define QSERDES_V8_COM_AUTO_GAIN_ADJ_CTRL_1		0x1a4
+#define QSERDES_V8_COM_AUTO_GAIN_ADJ_CTRL_2		0x1a8
+#define QSERDES_V8_COM_AUTO_GAIN_ADJ_CTRL_3		0x1ac
+#define QSERDES_V8_COM_ADDITIONAL_MISC			0x1b4
+#define QSERDES_V8_COM_CMN_STATUS			0x2c8
+#define QSERDES_V8_COM_C_READY_STATUS			0x2f0
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-com.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com.h
index 7fa5363feeb..cb599c11318 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-qserdes-com.h
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com.h
@@ -3,138 +3,107 @@
  * Copyright (c) 2017, The Linux Foundation. All rights reserved.
  */
 
-#ifndef QCOM_PHY_QMP_QSERDES_COM_H_
-#define QCOM_PHY_QMP_QSERDES_COM_H_
+#ifndef QCOM_PHY_QMP_QSERDES_COM_V2_H_
+#define QCOM_PHY_QMP_QSERDES_COM_V2_H_
 
 /* Only for QMP V2 PHY - QSERDES COM registers */
-#define QSERDES_COM_ATB_SEL1				0x000
-#define QSERDES_COM_ATB_SEL2				0x004
-#define QSERDES_COM_FREQ_UPDATE				0x008
-#define QSERDES_COM_BG_TIMER				0x00c
-#define QSERDES_COM_SSC_EN_CENTER			0x010
-#define QSERDES_COM_SSC_ADJ_PER1			0x014
-#define QSERDES_COM_SSC_ADJ_PER2			0x018
-#define QSERDES_COM_SSC_PER1				0x01c
-#define QSERDES_COM_SSC_PER2				0x020
-#define QSERDES_COM_SSC_STEP_SIZE1			0x024
-#define QSERDES_COM_SSC_STEP_SIZE2			0x028
-#define QSERDES_COM_POST_DIV				0x02c
-#define QSERDES_COM_POST_DIV_MUX			0x030
-#define QSERDES_COM_BIAS_EN_CLKBUFLR_EN			0x034
-#define QSERDES_COM_CLK_ENABLE1				0x038
-#define QSERDES_COM_SYS_CLK_CTRL			0x03c
-#define QSERDES_COM_SYSCLK_BUF_ENABLE			0x040
-#define QSERDES_COM_PLL_EN				0x044
-#define QSERDES_COM_PLL_IVCO				0x048
-#define QSERDES_COM_LOCK_CMP1_MODE0			0x04c
-#define QSERDES_COM_LOCK_CMP2_MODE0			0x050
-#define QSERDES_COM_LOCK_CMP3_MODE0			0x054
-#define QSERDES_COM_LOCK_CMP1_MODE1			0x058
-#define QSERDES_COM_LOCK_CMP2_MODE1			0x05c
-#define QSERDES_COM_LOCK_CMP3_MODE1			0x060
-#define QSERDES_COM_LOCK_CMP1_MODE2			0x064
-#define QSERDES_COM_CMN_RSVD0				0x064
-#define QSERDES_COM_LOCK_CMP2_MODE2			0x068
-#define QSERDES_COM_EP_CLOCK_DETECT_CTRL		0x068
-#define QSERDES_COM_LOCK_CMP3_MODE2			0x06c
-#define QSERDES_COM_SYSCLK_DET_COMP_STATUS		0x06c
-#define QSERDES_COM_BG_TRIM				0x070
-#define QSERDES_COM_CLK_EP_DIV				0x074
-#define QSERDES_COM_CP_CTRL_MODE0			0x078
-#define QSERDES_COM_CP_CTRL_MODE1			0x07c
-#define QSERDES_COM_CP_CTRL_MODE2			0x080
-#define QSERDES_COM_CMN_RSVD1				0x080
-#define QSERDES_COM_PLL_RCTRL_MODE0			0x084
-#define QSERDES_COM_PLL_RCTRL_MODE1			0x088
-#define QSERDES_COM_PLL_RCTRL_MODE2			0x08c
-#define QSERDES_COM_CMN_RSVD2				0x08c
-#define QSERDES_COM_PLL_CCTRL_MODE0			0x090
-#define QSERDES_COM_PLL_CCTRL_MODE1			0x094
-#define QSERDES_COM_PLL_CCTRL_MODE2			0x098
-#define QSERDES_COM_CMN_RSVD3				0x098
-#define QSERDES_COM_PLL_CNTRL				0x09c
-#define QSERDES_COM_PHASE_SEL_CTRL			0x0a0
-#define QSERDES_COM_PHASE_SEL_DC			0x0a4
-#define QSERDES_COM_CORE_CLK_IN_SYNC_SEL		0x0a8
-#define QSERDES_COM_BIAS_EN_CTRL_BY_PSM			0x0a8
-#define QSERDES_COM_SYSCLK_EN_SEL			0x0ac
-#define QSERDES_COM_CML_SYSCLK_SEL			0x0b0
-#define QSERDES_COM_RESETSM_CNTRL			0x0b4
-#define QSERDES_COM_RESETSM_CNTRL2			0x0b8
-#define QSERDES_COM_RESTRIM_CTRL			0x0bc
-#define QSERDES_COM_RESTRIM_CTRL2			0x0c0
-#define QSERDES_COM_RESCODE_DIV_NUM			0x0c4
-#define QSERDES_COM_LOCK_CMP_EN				0x0c8
-#define QSERDES_COM_LOCK_CMP_CFG			0x0cc
-#define QSERDES_COM_DEC_START_MODE0			0x0d0
-#define QSERDES_COM_DEC_START_MODE1			0x0d4
-#define QSERDES_COM_DEC_START_MODE2			0x0d8
-#define QSERDES_COM_VCOCAL_DEADMAN_CTRL			0x0d8
-#define QSERDES_COM_DIV_FRAC_START1_MODE0		0x0dc
-#define QSERDES_COM_DIV_FRAC_START2_MODE0		0x0e0
-#define QSERDES_COM_DIV_FRAC_START3_MODE0		0x0e4
-#define QSERDES_COM_DIV_FRAC_START1_MODE1		0x0e8
-#define QSERDES_COM_DIV_FRAC_START2_MODE1		0x0ec
-#define QSERDES_COM_DIV_FRAC_START3_MODE1		0x0f0
-#define QSERDES_COM_DIV_FRAC_START1_MODE2		0x0f4
-#define QSERDES_COM_VCO_TUNE_MINVAL1			0x0f4
-#define QSERDES_COM_DIV_FRAC_START2_MODE2		0x0f8
-#define QSERDES_COM_VCO_TUNE_MINVAL2			0x0f8
-#define QSERDES_COM_DIV_FRAC_START3_MODE2		0x0fc
-#define QSERDES_COM_CMN_RSVD4				0x0fc
-#define QSERDES_COM_INTEGLOOP_INITVAL			0x100
-#define QSERDES_COM_INTEGLOOP_EN			0x104
-#define QSERDES_COM_INTEGLOOP_GAIN0_MODE0		0x108
-#define QSERDES_COM_INTEGLOOP_GAIN1_MODE0		0x10c
-#define QSERDES_COM_INTEGLOOP_GAIN0_MODE1		0x110
-#define QSERDES_COM_INTEGLOOP_GAIN1_MODE1		0x114
-#define QSERDES_COM_INTEGLOOP_GAIN0_MODE2		0x118
-#define QSERDES_COM_VCO_TUNE_MAXVAL1			0x118
-#define QSERDES_COM_INTEGLOOP_GAIN1_MODE2		0x11c
-#define QSERDES_COM_VCO_TUNE_MAXVAL2			0x11c
-#define QSERDES_COM_RES_TRIM_CONTROL2			0x120
-#define QSERDES_COM_VCO_TUNE_CTRL			0x124
-#define QSERDES_COM_VCO_TUNE_MAP			0x128
-#define QSERDES_COM_VCO_TUNE1_MODE0			0x12c
-#define QSERDES_COM_VCO_TUNE2_MODE0			0x130
-#define QSERDES_COM_VCO_TUNE1_MODE1			0x134
-#define QSERDES_COM_VCO_TUNE2_MODE1			0x138
-#define QSERDES_COM_VCO_TUNE1_MODE2			0x13c
-#define QSERDES_COM_VCO_TUNE_INITVAL1			0x13c
-#define QSERDES_COM_VCO_TUNE2_MODE2			0x140
-#define QSERDES_COM_VCO_TUNE_INITVAL2			0x140
-#define QSERDES_COM_VCO_TUNE_TIMER1			0x144
-#define QSERDES_COM_VCO_TUNE_TIMER2			0x148
-#define QSERDES_COM_SAR					0x14c
-#define QSERDES_COM_SAR_CLK				0x150
-#define QSERDES_COM_SAR_CODE_OUT_STATUS			0x154
-#define QSERDES_COM_SAR_CODE_READY_STATUS		0x158
-#define QSERDES_COM_CMN_STATUS				0x15c
-#define QSERDES_COM_RESET_SM_STATUS			0x160
-#define QSERDES_COM_RESTRIM_CODE_STATUS			0x164
-#define QSERDES_COM_PLLCAL_CODE1_STATUS			0x168
-#define QSERDES_COM_PLLCAL_CODE2_STATUS			0x16c
-#define QSERDES_COM_BG_CTRL				0x170
-#define QSERDES_COM_CLK_SELECT				0x174
-#define QSERDES_COM_HSCLK_SEL				0x178
-#define QSERDES_COM_INTEGLOOP_BINCODE_STATUS		0x17c
-#define QSERDES_COM_PLL_ANALOG				0x180
-#define QSERDES_COM_CORECLK_DIV				0x184
-#define QSERDES_COM_SW_RESET				0x188
-#define QSERDES_COM_CORE_CLK_EN				0x18c
-#define QSERDES_COM_C_READY_STATUS			0x190
-#define QSERDES_COM_CMN_CONFIG				0x194
-#define QSERDES_COM_CMN_RATE_OVERRIDE			0x198
-#define QSERDES_COM_SVS_MODE_CLK_SEL			0x19c
-#define QSERDES_COM_DEBUG_BUS0				0x1a0
-#define QSERDES_COM_DEBUG_BUS1				0x1a4
-#define QSERDES_COM_DEBUG_BUS2				0x1a8
-#define QSERDES_COM_DEBUG_BUS3				0x1ac
-#define QSERDES_COM_DEBUG_BUS_SEL			0x1b0
-#define QSERDES_COM_CMN_MISC1				0x1b4
-#define QSERDES_COM_CMN_MISC2				0x1b8
-#define QSERDES_COM_CORECLK_DIV_MODE1			0x1bc
-#define QSERDES_COM_CORECLK_DIV_MODE2			0x1c0
-#define QSERDES_COM_CMN_RSVD5				0x1c4
+#define QSERDES_V2_COM_ATB_SEL1				0x000
+#define QSERDES_V2_COM_ATB_SEL2				0x004
+#define QSERDES_V2_COM_FREQ_UPDATE			0x008
+#define QSERDES_V2_COM_BG_TIMER				0x00c
+#define QSERDES_V2_COM_SSC_EN_CENTER			0x010
+#define QSERDES_V2_COM_SSC_ADJ_PER1			0x014
+#define QSERDES_V2_COM_SSC_ADJ_PER2			0x018
+#define QSERDES_V2_COM_SSC_PER1				0x01c
+#define QSERDES_V2_COM_SSC_PER2				0x020
+#define QSERDES_V2_COM_SSC_STEP_SIZE1			0x024
+#define QSERDES_V2_COM_SSC_STEP_SIZE2			0x028
+#define QSERDES_V2_COM_POST_DIV				0x02c
+#define QSERDES_V2_COM_POST_DIV_MUX			0x030
+#define QSERDES_V2_COM_BIAS_EN_CLKBUFLR_EN		0x034
+#define QSERDES_V2_COM_CLK_ENABLE1			0x038
+#define QSERDES_V2_COM_SYS_CLK_CTRL			0x03c
+#define QSERDES_V2_COM_SYSCLK_BUF_ENABLE		0x040
+#define QSERDES_V2_COM_PLL_EN				0x044
+#define QSERDES_V2_COM_PLL_IVCO				0x048
+#define QSERDES_V2_COM_LOCK_CMP1_MODE0			0x04c
+#define QSERDES_V2_COM_LOCK_CMP2_MODE0			0x050
+#define QSERDES_V2_COM_LOCK_CMP3_MODE0			0x054
+#define QSERDES_V2_COM_LOCK_CMP1_MODE1			0x058
+#define QSERDES_V2_COM_LOCK_CMP2_MODE1			0x05c
+#define QSERDES_V2_COM_LOCK_CMP3_MODE1			0x060
+#define QSERDES_V2_COM_EP_CLOCK_DETECT_CTR		0x068
+#define QSERDES_V2_COM_SYSCLK_DET_COMP_STATUS		0x06c
+#define QSERDES_V2_COM_BG_TRIM				0x070
+#define QSERDES_V2_COM_CLK_EP_DIV			0x074
+#define QSERDES_V2_COM_CP_CTRL_MODE0			0x078
+#define QSERDES_V2_COM_CP_CTRL_MODE1			0x07c
+#define QSERDES_V2_COM_PLL_RCTRL_MODE0			0x084
+#define QSERDES_V2_COM_PLL_RCTRL_MODE1			0x088
+#define QSERDES_V2_COM_PLL_CCTRL_MODE0			0x090
+#define QSERDES_V2_COM_PLL_CCTRL_MODE1			0x094
+#define QSERDES_V2_COM_PLL_CNTRL			0x09c
+#define QSERDES_V2_COM_BIAS_EN_CTRL_BY_PSM		0x0a8
+#define QSERDES_V2_COM_SYSCLK_EN_SEL			0x0ac
+#define QSERDES_V2_COM_CML_SYSCLK_SEL			0x0b0
+#define QSERDES_V2_COM_RESETSM_CNTRL			0x0b4
+#define QSERDES_V2_COM_RESETSM_CNTRL2			0x0b8
+#define QSERDES_V2_COM_RESCODE_DIV_NUM			0x0c4
+#define QSERDES_V2_COM_LOCK_CMP_EN			0x0c8
+#define QSERDES_V2_COM_LOCK_CMP_CFG			0x0cc
+#define QSERDES_V2_COM_DEC_START_MODE0			0x0d0
+#define QSERDES_V2_COM_DEC_START_MODE1			0x0d4
+#define QSERDES_V2_COM_VCOCAL_DEADMAN_CTRL		0x0d8
+#define QSERDES_V2_COM_DIV_FRAC_START1_MODE0		0x0dc
+#define QSERDES_V2_COM_DIV_FRAC_START2_MODE0		0x0e0
+#define QSERDES_V2_COM_DIV_FRAC_START3_MODE0		0x0e4
+#define QSERDES_V2_COM_DIV_FRAC_START1_MODE1		0x0e8
+#define QSERDES_V2_COM_DIV_FRAC_START2_MODE1		0x0ec
+#define QSERDES_V2_COM_DIV_FRAC_START3_MODE1		0x0f0
+#define QSERDES_V2_COM_VCO_TUNE_MINVAL1			0x0f4
+#define QSERDES_V2_COM_VCO_TUNE_MINVAL2			0x0f8
+#define QSERDES_V2_COM_INTEGLOOP_INITVAL		0x100
+#define QSERDES_V2_COM_INTEGLOOP_EN			0x104
+#define QSERDES_V2_COM_INTEGLOOP_GAIN0_MODE0		0x108
+#define QSERDES_V2_COM_INTEGLOOP_GAIN1_MODE0		0x10c
+#define QSERDES_V2_COM_INTEGLOOP_GAIN0_MODE1		0x110
+#define QSERDES_V2_COM_INTEGLOOP_GAIN1_MODE1		0x114
+#define QSERDES_V2_COM_VCO_TUNE_MAXVAL1			0x118
+#define QSERDES_V2_COM_VCO_TUNE_MAXVAL2			0x11c
+#define QSERDES_V2_COM_VCO_TUNE_CTRL			0x124
+#define QSERDES_V2_COM_VCO_TUNE_MAP			0x128
+#define QSERDES_V2_COM_VCO_TUNE1_MODE0			0x12c
+#define QSERDES_V2_COM_VCO_TUNE2_MODE0			0x130
+#define QSERDES_V2_COM_VCO_TUNE1_MODE1			0x134
+#define QSERDES_V2_COM_VCO_TUNE2_MODE1			0x138
+#define QSERDES_V2_COM_VCO_TUNE_INITVAL1		0x13c
+#define QSERDES_V2_COM_VCO_TUNE_INITVAL2		0x140
+#define QSERDES_V2_COM_VCO_TUNE_TIMER1			0x144
+#define QSERDES_V2_COM_VCO_TUNE_TIMER2			0x148
+#define QSERDES_V2_COM_CMN_STATUS			0x15c
+#define QSERDES_V2_COM_RESET_SM_STATUS			0x160
+#define QSERDES_V2_COM_RESTRIM_CODE_STATUS		0x164
+#define QSERDES_V2_COM_PLLCAL_CODE1_STATUS		0x168
+#define QSERDES_V2_COM_PLLCAL_CODE2_STATUS		0x16c
+#define QSERDES_V2_COM_BG_CTRL				0x170
+#define QSERDES_V2_COM_CLK_SELECT			0x174
+#define QSERDES_V2_COM_HSCLK_SEL			0x178
+#define QSERDES_V2_COM_INTEGLOOP_BINCODE_STATUS		0x17c
+#define QSERDES_V2_COM_PLL_ANALOG			0x180
+#define QSERDES_V2_COM_CORECLK_DIV			0x184
+#define QSERDES_V2_COM_SW_RESET				0x188
+#define QSERDES_V2_COM_CORE_CLK_EN			0x18c
+#define QSERDES_V2_COM_C_READY_STATUS			0x190
+#define QSERDES_V2_COM_CMN_CONFIG			0x194
+#define QSERDES_V2_COM_CMN_RATE_OVERRIDE		0x198
+#define QSERDES_V2_COM_SVS_MODE_CLK_SEL			0x19c
+#define QSERDES_V2_COM_DEBUG_BUS0			0x1a0
+#define QSERDES_V2_COM_DEBUG_BUS1			0x1a4
+#define QSERDES_V2_COM_DEBUG_BUS2			0x1a8
+#define QSERDES_V2_COM_DEBUG_BUS3			0x1ac
+#define QSERDES_V2_COM_DEBUG_BUS_SEL			0x1b0
+#define QSERDES_V2_COM_CMN_MISC1			0x1b4
+#define QSERDES_V2_COM_CMN_MISC2			0x1b8
+#define QSERDES_V2_COM_CORECLK_DIV_MODE1		0x1bc
 
 #endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-lalb-v8.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-lalb-v8.h
new file mode 100644
index 00000000000..60ba730620f
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-lalb-v8.h
@@ -0,0 +1,639 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_V8_LALBH_
+#define QCOM_PHY_QMP_QSERDES_V8_LALBH_
+
+#define QSERDES_V8_LALB_BIST_MODE_LANENO	0x0
+#define QSERDES_V8_LALB_BIST_INVERT	0x4
+#define QSERDES_V8_LALB_PERL_LENGTH1	0x8
+#define QSERDES_V8_LALB_PERL_LENGTH2	0xc
+#define QSERDES_V8_LALB_BIST_PATTERN1	0x10
+#define QSERDES_V8_LALB_BIST_PATTERN2	0x14
+#define QSERDES_V8_LALB_BIST_PATTERN3	0x18
+#define QSERDES_V8_LALB_BIST_PATTERN4	0x1c
+#define QSERDES_V8_LALB_BIST_PATTERN5	0x20
+#define QSERDES_V8_LALB_BIST_PATTERN6	0x24
+#define QSERDES_V8_LALB_BIST_PATTERN7	0x28
+#define QSERDES_V8_LALB_BIST_PATTERN8	0x2c
+#define QSERDES_V8_LALB_PRBS_SEED1	0x30
+#define QSERDES_V8_LALB_PRBS_SEED2	0x34
+#define QSERDES_V8_LALB_PRBS_SEED3	0x38
+#define QSERDES_V8_LALB_PRBS_SEED4	0x3c
+#define QSERDES_V8_LALB_PRBS_SEED5	0x40
+#define QSERDES_V8_LALB_PRBS_SEED6	0x44
+#define QSERDES_V8_LALB_PRBS_SEED7	0x48
+#define QSERDES_V8_LALB_SW_RESET_PWRDNB	0x4c
+#define QSERDES_V8_LALB_RESET_GEN	0x50
+#define QSERDES_V8_LALB_RESET_TSYNC_EN_CTRL	0x54
+#define QSERDES_V8_LALB_CDR_EN_RXEQ_RESET	0x58
+#define QSERDES_V8_LALB_CLKBUF_ENABLE	0x5c
+#define QSERDES_V8_LALB_TX0_EMP_POST1_LVL	0x60
+#define QSERDES_V8_LALB_TX1_EMP_POST1_LVL	0x64
+#define QSERDES_V8_LALB_TX0_IDLE_CTRL	0x68
+#define QSERDES_V8_LALB_TX1_IDLE_CTRL	0x6c
+#define QSERDES_V8_LALB_TX0_DRV_LVL	0x70
+#define QSERDES_V8_LALB_TX0_DRV_LVL_OFFSET	0x74
+#define QSERDES_V8_LALB_TX1_DRV_LVL	0x78
+#define QSERDES_V8_LALB_TX1_DRV_LVL_OFFSET	0x7c
+#define QSERDES_V8_LALB_TRAN_DRVR_EMP_EN	0x80
+#define QSERDES_V8_LALB_TX_LVL_UPDATE_CTRL	0x84
+#define QSERDES_V8_LALB_TX0_PRE1_EMPH	0x88
+#define QSERDES_V8_LALB_TX1_PRE1_EMPH	0x8c
+#define QSERDES_V8_LALB_TX0_PRE2_EMPH	0x90
+#define QSERDES_V8_LALB_TX1_PRE2_EMPH	0x94
+#define QSERDES_V8_LALB_STALL_LDO_BOOST_EN	0x98
+#define QSERDES_V8_LALB_PRE_EMPH_EN_CTRL	0x9c
+#define QSERDES_V8_LALB_PCIE5_TOP_LDO_CODE_CTRL1	0xa0
+#define QSERDES_V8_LALB_PCIE5_TOP_LDO_CODE_CTRL2	0xa4
+#define QSERDES_V8_LALB_PCIE5_TOP_LDO_CODE_CTRL3	0xa8
+#define QSERDES_V8_LALB_PCIE5_TOP_LDO_CODE_CTRL4	0xac
+#define QSERDES_V8_LALB_TRANSMITTER_EN_CTRL	0xb0
+#define QSERDES_V8_LALB_HIGHZ_DRVR_EN	0xb4
+#define QSERDES_V8_LALB_TX_MISC_CTRL1	0xb8
+#define QSERDES_V8_LALB_LPB_EN_CTRL1	0xbc
+#define QSERDES_V8_LALB_LBP_EN_CTRL2	0xc0
+#define QSERDES_V8_LALB_TX0_SERDES_BYP_CTRL	0xc4
+#define QSERDES_V8_LALB_TX1_SERDES_BYP_CTRL	0xc8
+#define QSERDES_V8_LALB_LANE_MODE_1	0xcc
+#define QSERDES_V8_LALB_LANE_MODE_2	0xd0
+#define QSERDES_V8_LALB_LANE_MODE_3	0xd4
+#define QSERDES_V8_LALB_LANE_MODE_4	0xd8
+#define QSERDES_V8_LALB_ATB_SEL1	0xdc
+#define QSERDES_V8_LALB_ATB_SEL2	0xe0
+#define QSERDES_V8_LALB_TX0_RES_CODE_LANE	0xe4
+#define QSERDES_V8_LALB_TX0_RESTRIM_ICAL_OVRD	0xe8
+#define QSERDES_V8_LALB_TX0_RESTRIM_CAL_CTRL	0xec
+#define QSERDES_V8_LALB_TX0_RESTRIM_INIT_CODE	0xf0
+#define QSERDES_V8_LALB_TX0_RESTRIM_POST_CAL_OFFSET	0xf4
+#define QSERDES_V8_LALB_TX1_RES_CODE_LANE	0xf8
+#define QSERDES_V8_LALB_TX1_RESTRIM_ICAL_OVRD	0xfc
+#define QSERDES_V8_LALB_TX1_RESTRIM_CAL_CTRL	0x100
+#define QSERDES_V8_LALB_TX1_RESTRIM_INIT_CODE	0x104
+#define QSERDES_V8_LALB_TX1_RESTRIM_POST_CAL_OFFSET	0x108
+#define QSERDES_V8_LALB_TX0_RESTRIM_VREF_SEL	0x10c
+#define QSERDES_V8_LALB_TX1_RESTRIM_VREF_SEL	0x110
+#define QSERDES_V8_LALB_VMODE_CTRL1	0x114
+#define QSERDES_V8_LALB_SLEW_CNTL_RATE01	0x118
+#define QSERDES_V8_LALB_SLEW_CNTL_RATE23	0x11c
+#define QSERDES_V8_LALB_SLEW_CNTL_RATE4	0x120
+#define QSERDES_V8_LALB_ANA_INTERFACE_SELECT1	0x124
+#define QSERDES_V8_LALB_ANA_INTERFACE_SELECT2	0x128
+#define QSERDES_V8_LALB_ANA_INTERFACE_SELECT3	0x12c
+#define QSERDES_V8_LALB_PCS_INTERFACE_SELECT1	0x130
+#define QSERDES_V8_LALB_PCS_INTERFACE_SELECT2	0x134
+#define QSERDES_V8_LALB_LDO_TIMER_CTRL	0x138
+#define QSERDES_V8_LALB_AC_JTAG_ENABLE	0x13c
+#define QSERDES_V8_LALB_AC_JTAG_INITP	0x140
+#define QSERDES_V8_LALB_AC_JTAG_INITN	0x144
+#define QSERDES_V8_LALB_AC_JTAG_LVL	0x148
+#define QSERDES_V8_LALB_AC_JTAG_MODE	0x14c
+#define QSERDES_V8_LALB_AC_JTAG_RESET	0x150
+#define QSERDES_V8_LALB_RX_MODE_RATE_0_1_B0	0x154
+#define QSERDES_V8_LALB_RX_MODE_RATE_0_1_B1	0x158
+#define QSERDES_V8_LALB_RX_MODE_RATE_0_1_B2	0x15c
+#define QSERDES_V8_LALB_RX_MODE_RATE_0_1_B3	0x160
+#define QSERDES_V8_LALB_RX_MODE_RATE_0_1_B4	0x164
+#define QSERDES_V8_LALB_RX_MODE_RATE_0_1_B5	0x168
+#define QSERDES_V8_LALB_RX_MODE_RATE_0_1_B6	0x16c
+#define QSERDES_V8_LALB_RX_MODE_RATE_0_1_B7	0x170
+#define QSERDES_V8_LALB_RX_MODE_RATE2_B0	0x174
+#define QSERDES_V8_LALB_RX_MODE_RATE2_B1	0x178
+#define QSERDES_V8_LALB_RX_MODE_RATE2_B2	0x17c
+#define QSERDES_V8_LALB_RX_MODE_RATE2_B3	0x180
+#define QSERDES_V8_LALB_RX_MODE_RATE2_B4	0x184
+#define QSERDES_V8_LALB_RX_MODE_RATE2_B5	0x188
+#define QSERDES_V8_LALB_RX_MODE_RATE2_B6	0x18c
+#define QSERDES_V8_LALB_RX_MODE_RATE2_B7	0x190
+#define QSERDES_V8_LALB_RX_MODE_RATE3_B0	0x194
+#define QSERDES_V8_LALB_RX_MODE_RATE3_B1	0x198
+#define QSERDES_V8_LALB_RX_MODE_RATE3_B2	0x19c
+#define QSERDES_V8_LALB_RX_MODE_RATE3_B3	0x1a0
+#define QSERDES_V8_LALB_RX_MODE_RATE3_B4	0x1a4
+#define QSERDES_V8_LALB_RX_MODE_RATE3_B5	0x1a8
+#define QSERDES_V8_LALB_RX_MODE_RATE3_B6	0x1ac
+#define QSERDES_V8_LALB_RX_MODE_RATE3_B7	0x1b0
+#define QSERDES_V8_LALB_RX_MODE_RATE4_B0	0x1b4
+#define QSERDES_V8_LALB_RX_MODE_RATE4_B1	0x1b8
+#define QSERDES_V8_LALB_RX_MODE_RATE4_B2	0x1bc
+#define QSERDES_V8_LALB_RX_MODE_RATE4_B3	0x1c0
+#define QSERDES_V8_LALB_RX_MODE_RATE4_B4	0x1c4
+#define QSERDES_V8_LALB_RX_MODE_RATE4_B5	0x1c8
+#define QSERDES_V8_LALB_RX_MODE_RATE4_B6	0x1cc
+#define QSERDES_V8_LALB_RX_MODE_RATE4_B7	0x1d0
+#define QSERDES_V8_LALB_TX_DCC_ANA_CTRL1	0x1d4
+#define QSERDES_V8_LALB_TX_DCC_ANA_CTRL2	0x1d8
+#define QSERDES_V8_LALB_CMUX_DCC_CTRL1	0x1dc
+#define QSERDES_V8_LALB_CMUX_DCC_POSTCAL_OFFSET	0x1e0
+#define QSERDES_V8_LALB_CMUX_DCC_OVRD	0x1e4
+#define QSERDES_V8_LALB_TX_DCC_CTRL	0x1e8
+#define QSERDES_V8_LALB_TX0_CTUNE_DCC_CONFIG	0x1ec
+#define QSERDES_V8_LALB_TX0_CTUNE_DCC_POSTCAL_OFFSET	0x1f0
+#define QSERDES_V8_LALB_TX0_CTUNE_DCC_OVRD	0x1f4
+#define QSERDES_V8_LALB_TX0_FTUNE_MSB_DCC_CONFIG	0x1f8
+#define QSERDES_V8_LALB_TX0_FTUNE_MSB_DCC_OFFSET_AND_OVRD	0x1fc
+#define QSERDES_V8_LALB_TX0_FTUNE_LSB_DCC_CONFIG	0x200
+#define QSERDES_V8_LALB_TX0_FTUNE_LSB_DCC_OFFSET_AND_OVRD	0x204
+#define QSERDES_V8_LALB_TX1_CTUNE_DCC_CONFIG	0x208
+#define QSERDES_V8_LALB_TX1_CTUNE_DCC_POSTCAL_OFFSET	0x20c
+#define QSERDES_V8_LALB_TX1_CTUNE_DCC_OVRD	0x210
+#define QSERDES_V8_LALB_TX1_FTUNE_MSB_DCC_CONFIG	0x214
+#define QSERDES_V8_LALB_TX1_FTUNE_MSB_DCC_OFFSET_AND_OVRD	0x218
+#define QSERDES_V8_LALB_TX1_FTUNE_LSB_DCC_CONFIG	0x21c
+#define QSERDES_V8_LALB_TX1_FTUNE_LSB_DCC_OFFSET_AND_OVRD	0x220
+#define QSERDES_V8_LALB_CDR_VCO_CTUNE_CTRL	0x224
+#define QSERDES_V8_LALB_CDR_VCO_CTUNE_CODE_OVRD_RATE0	0x228
+#define QSERDES_V8_LALB_CDR_VCO_CTUNE_CODE_OVRD_RATE1	0x22c
+#define QSERDES_V8_LALB_CDR_VCO_CTUNE_CODE_OVRD_RATE2	0x230
+#define QSERDES_V8_LALB_CDR_VCO_CTUNE_CODE_OVRD_RATE3	0x234
+#define QSERDES_V8_LALB_CDR_VCO_CTUNE_CODE_OVRD_RATE4	0x238
+#define QSERDES_V8_LALB_CDR_VCO_CAL_CTRL	0x23c
+#define QSERDES_V8_LALB_CDR_VCO_CTUNE_MEAS_CNT1_RATE0	0x240
+#define QSERDES_V8_LALB_CDR_VCO_CTUNE_MEAS_CNT2_RATE0	0x244
+#define QSERDES_V8_LALB_CDR_VCO_CTUNE_MEAS_CNT1_RATE1	0x248
+#define QSERDES_V8_LALB_CDR_VCO_CTUNE_MEAS_CNT2_RATE1	0x24c
+#define QSERDES_V8_LALB_CDR_VCO_CTUNE_MEAS_CNT1_RATE2	0x250
+#define QSERDES_V8_LALB_CDR_VCO_CTUNE_MEAS_CNT2_RATE2	0x254
+#define QSERDES_V8_LALB_CDR_VCO_CTUNE_MEAS_CNT1_RATE3	0x258
+#define QSERDES_V8_LALB_CDR_VCO_CTUNE_MEAS_CNT2_RATE3	0x25c
+#define QSERDES_V8_LALB_CDR_VCO_CTUNE_MEAS_CNT1_RATE4	0x260
+#define QSERDES_V8_LALB_CDR_VCO_CTUNE_MEAS_CNT2_RATE4	0x264
+#define QSERDES_V8_LALB_CDR_VCTRL_RATE_0_1	0x268
+#define QSERDES_V8_LALB_CDR_VCTRL_RATE_2_3	0x26c
+#define QSERDES_V8_LALB_CDR_VCTRL_RATE_4	0x270
+#define QSERDES_V8_LALB_KVCO_INIT_RATE_0_1	0x274
+#define QSERDES_V8_LALB_KVCO_INIT_RATE_2_3	0x278
+#define QSERDES_V8_LALB_KVCO_INIT_RATE_4	0x27c
+#define QSERDES_V8_LALB_KVCO_CODE_OVRD_RATE0	0x280
+#define QSERDES_V8_LALB_KVCO_CODE_OVRD_RATE1	0x284
+#define QSERDES_V8_LALB_KVCO_CODE_OVRD_RATE2	0x288
+#define QSERDES_V8_LALB_KVCO_CODE_OVRD_RATE3	0x28c
+#define QSERDES_V8_LALB_KVCO_CODE_OVRD_RATE4	0x290
+#define QSERDES_V8_LALB_KVCO_CAL_VCTRL_HIGH_RATE_0_1	0x294
+#define QSERDES_V8_LALB_KVCO_CAL_VCTRL_HIGH_RATE_2_3	0x298
+#define QSERDES_V8_LALB_KVCO_CAL_VCTRL_HIGH_RATE_4	0x29c
+#define QSERDES_V8_LALB_KVCO_CAL_VCTRL_LOW_RATE_0_1	0x2a0
+#define QSERDES_V8_LALB_KVCO_CAL_VCTRL_LOW_RATE_2_3	0x2a4
+#define QSERDES_V8_LALB_KVCO_CAL_VCTRL_LOW_RATE_4	0x2a8
+#define QSERDES_V8_LALB_KVCO_IDEAL_FREQ_DIFF1_RATE0	0x2ac
+#define QSERDES_V8_LALB_KVCO_IDEAL_FREQ_DIFF2_RATE0	0x2b0
+#define QSERDES_V8_LALB_KVCO_IDEAL_FREQ_DIFF1_RATE1	0x2b4
+#define QSERDES_V8_LALB_KVCO_IDEAL_FREQ_DIFF2_RATE1	0x2b8
+#define QSERDES_V8_LALB_KVCO_IDEAL_FREQ_DIFF1_RATE2	0x2bc
+#define QSERDES_V8_LALB_KVCO_IDEAL_FREQ_DIFF2_RATE2	0x2c0
+#define QSERDES_V8_LALB_KVCO_IDEAL_FREQ_DIFF1_RATE3	0x2c4
+#define QSERDES_V8_LALB_KVCO_IDEAL_FREQ_DIFF2_RATE3	0x2c8
+#define QSERDES_V8_LALB_KVCO_IDEAL_FREQ_DIFF1_RATE4	0x2cc
+#define QSERDES_V8_LALB_KVCO_IDEAL_FREQ_DIFF2_RATE4	0x2d0
+#define QSERDES_V8_LALB_KP_CDR_UP_DN	0x2d4
+#define QSERDES_V8_LALB_KP_CODE_OVRD_RATE_0_1	0x2d8
+#define QSERDES_V8_LALB_KP_CODE_OVRD_RATE_2_3	0x2dc
+#define QSERDES_V8_LALB_KP_CODE_OVRD_RATE4	0x2e0
+#define QSERDES_V8_LALB_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE0	0x2e4
+#define QSERDES_V8_LALB_KP_CAL_UPPER_FREQ_DIFF_BND2_RATE0	0x2e8
+#define QSERDES_V8_LALB_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE1	0x2ec
+#define QSERDES_V8_LALB_KP_CAL_UPPER_FREQ_DIFF_BND2_RATE1	0x2f0
+#define QSERDES_V8_LALB_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE2	0x2f4
+#define QSERDES_V8_LALB_KP_CAL_UPPER_FREQ_DIFF_BND2_RATE2	0x2f8
+#define QSERDES_V8_LALB_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE3	0x2fc
+#define QSERDES_V8_LALB_KP_CAL_UPPER_FREQ_DIFF_BND2_RATE3	0x300
+#define QSERDES_V8_LALB_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE4	0x304
+#define QSERDES_V8_LALB_KP_CAL_UPPER_FREQ_DIFF_BND2_RATE4	0x308
+#define QSERDES_V8_LALB_KP_CAL_LOWER_FREQ_DIFF_BND_RATE0	0x30c
+#define QSERDES_V8_LALB_KP_CAL_LOWER_FREQ_DIFF_BND_RATE1	0x310
+#define QSERDES_V8_LALB_KP_CAL_LOWER_FREQ_DIFF_BND_RATE2	0x314
+#define QSERDES_V8_LALB_KP_CAL_LOWER_FREQ_DIFF_BND_RATE3	0x318
+#define QSERDES_V8_LALB_KP_CAL_LOWER_FREQ_DIFF_BND_RATE4	0x31c
+#define QSERDES_V8_LALB_CDR_KVCO_KP_CAL_FREQ_MEAS_CTRL	0x320
+#define QSERDES_V8_LALB_PLLLOCK_CMP_DEBUG_CTRL	0x324
+#define QSERDES_V8_LALB_PLLLOCK_CMP_DEBUG_CNT1	0x328
+#define QSERDES_V8_LALB_PLLLOCK_CMP_DEBUG_CNT2	0x32c
+#define QSERDES_V8_LALB_PLLLOCK_CMP_DEBUG_CNT3	0x330
+#define QSERDES_V8_LALB_RX_SUMMER_CAL_SPD_MODE_RATE_0123	0x334
+#define QSERDES_V8_LALB_RX_SUMMER_CAL_SPD_MODE_RATE_4	0x338
+#define QSERDES_V8_LALB_RX_IVCM_CAL_CODE_OVERRIDE_RATE0	0x33c
+#define QSERDES_V8_LALB_RX_IVCM_CAL_CODE_OVERRIDE_RATE1	0x340
+#define QSERDES_V8_LALB_RX_IVCM_CAL_CODE_OVERRIDE_RATE2	0x344
+#define QSERDES_V8_LALB_RX_IVCM_CAL_CODE_OVERRIDE_RATE3	0x348
+#define QSERDES_V8_LALB_RX_IVCM_CAL_CODE_OVERRIDE_RATE4	0x34c
+#define QSERDES_V8_LALB_RX_IVCM_CAL_CTRL1	0x350
+#define QSERDES_V8_LALB_RX_IVCM_CAL_CTRL2	0x354
+#define QSERDES_V8_LALB_RX_IVCM_CAL_CTRL3	0x358
+#define QSERDES_V8_LALB_RX_IVCM_CAL_CTRL4	0x35c
+#define QSERDES_V8_LALB_RX_IVCM_POSTCAL_OFFSET_RATE0	0x360
+#define QSERDES_V8_LALB_RX_IVCM_POSTCAL_OFFSET_RATE1	0x364
+#define QSERDES_V8_LALB_RX_IVCM_POSTCAL_OFFSET_RATE2	0x368
+#define QSERDES_V8_LALB_RX_IVCM_POSTCAL_OFFSET_RATE3	0x36c
+#define QSERDES_V8_LALB_RX_IVCM_POSTCAL_OFFSET_RATE4	0x370
+#define QSERDES_V8_LALB_RX_IDAC_I0_DC_OFFSETS	0x374
+#define QSERDES_V8_LALB_RX_IDAC_I0BAR_DC_OFFSETS	0x378
+#define QSERDES_V8_LALB_RX_IDAC_I1_DC_OFFSETS	0x37c
+#define QSERDES_V8_LALB_RX_IDAC_I1BAR_DC_OFFSETS	0x380
+#define QSERDES_V8_LALB_RX_IDAC_Q_DC_OFFSETS	0x384
+#define QSERDES_V8_LALB_RX_IDAC_QBAR_DC_OFFSETS	0x388
+#define QSERDES_V8_LALB_RX_IDAC_A_DC_OFFSETS	0x38c
+#define QSERDES_V8_LALB_RX_IDAC_ABAR_DC_OFFSETS	0x390
+#define QSERDES_V8_LALB_RX_IDAC_EN	0x394
+#define QSERDES_V8_LALB_DATA_SLICER_INIT_TIMER_CTRL	0x398
+#define QSERDES_V8_LALB_RX_IDAC_ENABLES	0x39c
+#define QSERDES_V8_LALB_RX_IDAC_SIGN	0x3a0
+#define QSERDES_V8_LALB_RX_IDAC_TSETTLE	0x3a4
+#define QSERDES_V8_LALB_SIGDET_ENABLES	0x3a8
+#define QSERDES_V8_LALB_SIGDET_CNTRL	0x3ac
+#define QSERDES_V8_LALB_SIGDET_LVL	0x3b0
+#define QSERDES_V8_LALB_SIGDET_DEGLITCH_CNTRL	0x3b4
+#define QSERDES_V8_LALB_SIGDET_CAL_CTRL1	0x3b8
+#define QSERDES_V8_LALB_SIGDET_CAL_CTRL2_AND_CDR_LOCK_EDGE	0x3bc
+#define QSERDES_V8_LALB_SIGDET_CAL_TRIM	0x3c0
+#define QSERDES_V8_LALB_IA_OFFSET_CENTER_CAL_CTRL	0x3c4
+#define QSERDES_V8_LALB_FREQ_LOCK_DET_DLY_RATE0	0x3c8
+#define QSERDES_V8_LALB_FREQ_LOCK_DET_DLY_RATE1	0x3cc
+#define QSERDES_V8_LALB_FREQ_LOCK_DET_DLY_RATE2	0x3d0
+#define QSERDES_V8_LALB_FREQ_LOCK_DET_DLY_RATE3	0x3d4
+#define QSERDES_V8_LALB_FREQ_LOCK_DET_DLY_RATE4	0x3d8
+#define QSERDES_V8_LALB_CDR_PHASE_LOCK_CNT_RATE0	0x3dc
+#define QSERDES_V8_LALB_CDR_PHASE_LOCK_CNT_RATE1	0x3e0
+#define QSERDES_V8_LALB_CDR_PHASE_LOCK_CNT_RATE2	0x3e4
+#define QSERDES_V8_LALB_CDR_PHASE_LOCK_CNT_RATE3	0x3e8
+#define QSERDES_V8_LALB_CDR_PHASE_LOCK_CNT_RATE4	0x3ec
+#define QSERDES_V8_LALB_CDR_LOCK_CTRL	0x3f0
+#define QSERDES_V8_LALB_CDR_CP_CUR_FLL_RATE0	0x3f4
+#define QSERDES_V8_LALB_CDR_CP_CUR_FLL_RATE1	0x3f8
+#define QSERDES_V8_LALB_CDR_CP_CUR_FLL_RATE2	0x3fc
+#define QSERDES_V8_LALB_CDR_CP_CUR_FLL_RATE3	0x400
+#define QSERDES_V8_LALB_CDR_CP_CUR_FLL_RATE4	0x404
+#define QSERDES_V8_LALB_CDR_CP_CUR_PLL_RATE0	0x408
+#define QSERDES_V8_LALB_CDR_CP_CUR_PLL_RATE1	0x40c
+#define QSERDES_V8_LALB_CDR_CP_CUR_PLL_RATE2	0x410
+#define QSERDES_V8_LALB_CDR_CP_CUR_PLL_RATE3	0x414
+#define QSERDES_V8_LALB_CDR_CP_CUR_PLL_RATE4	0x418
+#define QSERDES_V8_LALB_CDR_FLL_DIV_RATIO_RATE_0123	0x41c
+#define QSERDES_V8_LALB_CDR_FLL_DIV_RATIO_RATE4	0x420
+#define QSERDES_V8_LALB_CDR_LOOP_CCODE_RATE_01	0x424
+#define QSERDES_V8_LALB_CDR_LOOP_CCODE_RATE_23	0x428
+#define QSERDES_V8_LALB_CDR_LOOP_CCODE_RATE4	0x42c
+#define QSERDES_V8_LALB_CDR_LOOP_RCODE_FAST_RATE_0_1	0x430
+#define QSERDES_V8_LALB_CDR_LOOP_RCODE_FAST_RATE_2_3	0x434
+#define QSERDES_V8_LALB_CDR_LOOP_RCODE_FAST_RATE4	0x438
+#define QSERDES_V8_LALB_CDR_LOOP_RCODE_FLL_RATE_0_1	0x43c
+#define QSERDES_V8_LALB_CDR_LOOP_RCODE_FLL_RATE_2_3	0x440
+#define QSERDES_V8_LALB_CDR_LOOP_RCODE_FLL_RATE4	0x444
+#define QSERDES_V8_LALB_CDR_LOOP_RCODE_PLL_RATE_0_1	0x448
+#define QSERDES_V8_LALB_CDR_LOOP_RCODE_PLL_RATE_2_3	0x44c
+#define QSERDES_V8_LALB_CDR_LOOP_RCODE_PLL_RATE4	0x450
+#define QSERDES_V8_LALB_CDR_VCO_CAP_CODE_RATE_0123	0x454
+#define QSERDES_V8_LALB_CDR_VCO_CAP_CODE_RATE4	0x458
+#define QSERDES_V8_LALB_CDR_VCO_TYPE_CONFIG	0x45c
+#define QSERDES_V8_LALB_CDR_VCO_EN_LOWFREQ	0x460
+#define QSERDES_V8_LALB_CDR_FAST_SLOW_VCO_OVRD	0x464
+#define QSERDES_V8_LALB_CDR_LOOP_FUNC_CTRL	0x468
+#define QSERDES_V8_LALB_CDR_FAST_LOCK_EN_CTRL	0x46c
+#define QSERDES_V8_LALB_RX_RCVR_EN	0x470
+#define QSERDES_V8_LALB_LANE_RATE_CTRL	0x474
+#define QSERDES_V8_LALB_RX_TERM_RCVR_CTRL	0x478
+#define QSERDES_V8_LALB_REC_DETECT_CTRL	0x47c
+#define QSERDES_V8_LALB_RCV_DETECT_LVL	0x480
+#define QSERDES_V8_LALB_GM_CAL_EN	0x484
+#define QSERDES_V8_LALB_GM_CAL_RES_RATE0_1	0x488
+#define QSERDES_V8_LALB_GM_CAL_RES_RATE2_3	0x48c
+#define QSERDES_V8_LALB_GM_CAL_RES_RATE4	0x490
+#define QSERDES_V8_LALB_RX_TERM_BW_RATE_0123	0x494
+#define QSERDES_V8_LALB_RX_TERM_BW_RATE4	0x498
+#define QSERDES_V8_LALB_AUX_CLK_CTRL	0x49c
+#define QSERDES_V8_LALB_AUX_OFFSET_CONTROL	0x4a0
+#define QSERDES_V8_LALB_AUXDATA_TB	0x4a4
+#define QSERDES_V8_LALB_EOM_CTRL1	0x4a8
+#define QSERDES_V8_LALB_EOM_CTRL2	0x4ac
+#define QSERDES_V8_LALB_EOM_CTRL3	0x4b0
+#define QSERDES_V8_LALB_EOM_CTRL4	0x4b4
+#define QSERDES_V8_LALB_DFE_EN_TIMER	0x4b8
+#define QSERDES_V8_LALB_RX_EQ_OFFSET_LSB	0x4bc
+#define QSERDES_V8_LALB_RX_EQ_OFFSET_MSB	0x4c0
+#define QSERDES_V8_LALB_RX_EQ_OFFSET_ADAPTOR_CNTRL1	0x4c4
+#define QSERDES_V8_LALB_RX_OFFSET_ADAPTOR_CNTRL2	0x4c8
+#define QSERDES_V8_LALB_RX_OFFSET_ADAPTOR_CNTRL3	0x4cc
+#define QSERDES_V8_LALB_RX_EQU_ADAPTOR_CNTRL1	0x4d0
+#define QSERDES_V8_LALB_RX_EQU_ADAPTOR_CNTRL2	0x4d4
+#define QSERDES_V8_LALB_RX_EQU_ADAPTOR_CNTRL3	0x4d8
+#define QSERDES_V8_LALB_RX_EQU_ADAPTOR_CNTRL4	0x4dc
+#define QSERDES_V8_LALB_RX_EQU_ADAPTOR_CNTRL5	0x4e0
+#define QSERDES_V8_LALB_RX_EQU_KEQ_UP_LSB	0x4e4
+#define QSERDES_V8_LALB_RX_EQU_KEQ_UP_MSB	0x4e8
+#define QSERDES_V8_LALB_RX_EQU_KEQ_DN_LSB	0x4ec
+#define QSERDES_V8_LALB_RX_EQU_KEQ_DN_MSB	0x4f0
+#define QSERDES_V8_LALB_CTLE_ADP_RESET_INIT_CODE_RATE_0_1_2	0x4f4
+#define QSERDES_V8_LALB_CTLE_ADP_RESET_INIT_CODE_RATE_3_4	0x4f8
+#define QSERDES_V8_LALB_CTLE_POST_CAL_OFFSET_RATE_0_1_2	0x4fc
+#define QSERDES_V8_LALB_CTLE_POST_CAL_OFFSET_RATE_3_4	0x500
+#define QSERDES_V8_LALB_RX_VGA_GAIN2_BLK1	0x504
+#define QSERDES_V8_LALB_RX_VGA_GAIN2_BLK2	0x508
+#define QSERDES_V8_LALB_VGA_CAL_CNTRL1	0x50c
+#define QSERDES_V8_LALB_VGA_CAL_CNTRL2	0x510
+#define QSERDES_V8_LALB_VGA_CAL_MAN_VAL_RATE0_1	0x514
+#define QSERDES_V8_LALB_VGA_CAL_MAN_VAL_RATE2_3	0x518
+#define QSERDES_V8_LALB_VGA_CAL_MAN_VAL_RATE4	0x51c
+#define QSERDES_V8_LALB_KVGA_CTRL1	0x520
+#define QSERDES_V8_LALB_KVGA_CTRL2	0x524
+#define QSERDES_V8_LALB_VTHRESH_CAL_CNTRL1	0x528
+#define QSERDES_V8_LALB_VTHRESH_CAL_CNTRL2	0x52c
+#define QSERDES_V8_LALB_VTHRESH_CAL_MAN_VAL_RATE0	0x530
+#define QSERDES_V8_LALB_VTHRESH_CAL_MAN_VAL_RATE1	0x534
+#define QSERDES_V8_LALB_VTHRESH_CAL_MAN_VAL_RATE2	0x538
+#define QSERDES_V8_LALB_VTHRESH_CAL_MAN_VAL_RATE3	0x53c
+#define QSERDES_V8_LALB_VTHRESH_CAL_MAN_VAL_RATE4	0x540
+#define QSERDES_V8_LALB_VTHRESH_CAL_MAN_CAL_PAM3	0x544
+#define QSERDES_V8_LALB_VTH_POST_CAL_OFFSET_RATE_0_1	0x548
+#define QSERDES_V8_LALB_VTH_POST_CAL_OFFSET_RATE_2_3	0x54c
+#define QSERDES_V8_LALB_VTH_POST_CAL_OFFSET_RATE4	0x550
+#define QSERDES_V8_LALB_DFE_TAP1_CTRL	0x554
+#define QSERDES_V8_LALB_DFE_TAP1_MANVAL_KTAP	0x558
+#define QSERDES_V8_LALB_DFE_TAP1_POST_CAL_OFFSET_RATE_0_1_2	0x55c
+#define QSERDES_V8_LALB_DFE_TAP1_POST_CAL_OFFSET_RATE_3_4	0x560
+#define QSERDES_V8_LALB_DFE_TAP2_CTRL	0x564
+#define QSERDES_V8_LALB_DFE_TAP2_MANVAL_KTAP	0x568
+#define QSERDES_V8_LALB_DFE_TAP3_CTRL	0x56c
+#define QSERDES_V8_LALB_DFE_TAP3_MANVAL_KTAP	0x570
+#define QSERDES_V8_LALB_DFE_TAP4_CTRL	0x574
+#define QSERDES_V8_LALB_DFE_TAP4_MANVAL_KTAP	0x578
+#define QSERDES_V8_LALB_DFE_TAP5_CTRL	0x57c
+#define QSERDES_V8_LALB_DFE_TAP5_MANVAL_KTAP	0x580
+#define QSERDES_V8_LALB_DFE_TAP6_CTRL	0x584
+#define QSERDES_V8_LALB_DFE_TAP6_MANVAL_KTAP	0x588
+#define QSERDES_V8_LALB_DFE_TAP7_CTRL	0x58c
+#define QSERDES_V8_LALB_DFE_TAP7_MANVAL_KTAP	0x590
+#define QSERDES_V8_LALB_DFE_TAP1_DAC_ENABLE	0x594
+#define QSERDES_V8_LALB_DFE_TAP2_DAC_ENABLE	0x598
+#define QSERDES_V8_LALB_DFE_TAP345_DAC_ENABLE	0x59c
+#define QSERDES_V8_LALB_DFE_TAP67_DAC_ENABLE	0x5a0
+#define QSERDES_V8_LALB_CDR_IQTUNE_CTRL	0x5a4
+#define QSERDES_V8_LALB_CDR_IQTUNE_GAIN	0x5a8
+#define QSERDES_V8_LALB_CDR_IQTUNE_MAN_INDEX	0x5ac
+#define QSERDES_V8_LALB_CDR_IQTUNE_FILTER_CAL_CTRL1	0x5b0
+#define QSERDES_V8_LALB_CDR_IQTUNE_FILTER_CAL_CTRL2	0x5b4
+#define QSERDES_V8_LALB_CDR_IQTUNE_CLK0_CAL_CODE_RATE0	0x5b8
+#define QSERDES_V8_LALB_CDR_IQTUNE_CLK0_CAL_CODE_RATE1	0x5bc
+#define QSERDES_V8_LALB_CDR_IQTUNE_CLK0_CAL_CODE_RATE2	0x5c0
+#define QSERDES_V8_LALB_CDR_IQTUNE_CLK0_CAL_CODE_RATE3	0x5c4
+#define QSERDES_V8_LALB_CDR_IQTUNE_CLK0_CAL_CODE_RATE4	0x5c8
+#define QSERDES_V8_LALB_CDR_IQTUNE_CLK90_CAL_CODE_RATE0	0x5cc
+#define QSERDES_V8_LALB_CDR_IQTUNE_CLK90_CAL_CODE_RATE1	0x5d0
+#define QSERDES_V8_LALB_CDR_IQTUNE_CLK90_CAL_CODE_RATE2	0x5d4
+#define QSERDES_V8_LALB_CDR_IQTUNE_CLK90_CAL_CODE_RATE3	0x5d8
+#define QSERDES_V8_LALB_CDR_IQTUNE_CLK90_CAL_CODE_RATE4	0x5dc
+#define QSERDES_V8_LALB_CDR_IQTUNE_ANA_CTRL	0x5e0
+#define QSERDES_V8_LALB_CDR_IQTUNE_VDCC_CTRL	0x5e4
+#define QSERDES_V8_LALB_CDR_IQTUNE_DIV2_CTRL_RATE0123	0x5e8
+#define QSERDES_V8_LALB_CDR_IQTUNE_DIV2_CTRL_RATE4	0x5ec
+#define QSERDES_V8_LALB_BLW_CTRL	0x5f0
+#define QSERDES_V8_LALB_BLW_ANA_VER_CTRL	0x5f4
+#define QSERDES_V8_LALB_BLW_GAIN_CAL_CTRL	0x5f8
+#define QSERDES_V8_LALB_BLW_GAIN_FORCE_CODE	0x5fc
+#define QSERDES_V8_LALB_BLW_MAN_VAL_RATE3	0x600
+#define QSERDES_V8_LALB_BLW_MAN_VAL_RATE4	0x604
+#define QSERDES_V8_LALB_IVTH_CAL_CTRL1	0x608
+#define QSERDES_V8_LALB_IVTH_CAL_CTRL2	0x60c
+#define QSERDES_V8_LALB_IVTH_CAL_CTRL3	0x610
+#define QSERDES_V8_LALB_VTH_I_UP_CNTRL_VAL	0x614
+#define QSERDES_V8_LALB_VTH_I_DN_CNTRL_VAL	0x618
+#define QSERDES_V8_LALB_NRZ_EYE_HEIGHT_SEL_VAL	0x61c
+#define QSERDES_V8_LALB_IVTH_CAL_VAL_OVRD_MUX	0x620
+#define QSERDES_V8_LALB_CDR_VCO_CAP_CODE_OVRD_MUXES	0x624
+#define QSERDES_V8_LALB_VCO_CTUNE_LOWER_BND_RATE0	0x628
+#define QSERDES_V8_LALB_VCO_CTUNE_LOWER_BND_RATE1	0x62c
+#define QSERDES_V8_LALB_VCO_CTUNE_LOWER_BND_RATE2	0x630
+#define QSERDES_V8_LALB_VCO_CTUNE_LOWER_BND_RATE3	0x634
+#define QSERDES_V8_LALB_VCO_CTUNE_LOWER_BND_RATE4	0x638
+#define QSERDES_V8_LALB_VCO_CTUNE_UPPER_BND_RATE0	0x63c
+#define QSERDES_V8_LALB_VCO_CTUNE_UPPER_BND_RATE1	0x640
+#define QSERDES_V8_LALB_VCO_CTUNE_UPPER_BND_RATE2	0x644
+#define QSERDES_V8_LALB_VCO_CTUNE_UPPER_BND_RATE3	0x648
+#define QSERDES_V8_LALB_VCO_CTUNE_UPPER_BND_RATE4	0x64c
+#define QSERDES_V8_LALB_CDR_LOCK_KVCO_OFFSET_RATE0	0x650
+#define QSERDES_V8_LALB_CDR_LOCK_KVCO_OFFSET_RATE1	0x654
+#define QSERDES_V8_LALB_CDR_LOCK_KVCO_OFFSET_RATE2	0x658
+#define QSERDES_V8_LALB_CDR_LOCK_KVCO_OFFSET_RATE3	0x65c
+#define QSERDES_V8_LALB_CDR_LOCK_KVCO_OFFSET_RATE4	0x660
+#define QSERDES_V8_LALB_CDR_LOCK_KP_OFFSET_RATE0	0x664
+#define QSERDES_V8_LALB_CDR_LOCK_KP_OFFSET_RATE1	0x668
+#define QSERDES_V8_LALB_CDR_LOCK_KP_OFFSET_RATE2	0x66c
+#define QSERDES_V8_LALB_CDR_LOCK_KP_OFFSET_RATE3	0x670
+#define QSERDES_V8_LALB_CDR_LOCK_KP_OFFSET_RATE4	0x674
+#define QSERDES_V8_LALB_CDR_FASTLOCK_CP_CUR_PLL_RATE0	0x678
+#define QSERDES_V8_LALB_CDR_FASTLOCK_CP_CUR_PLL_RATE1	0x67c
+#define QSERDES_V8_LALB_CDR_FASTLOCK_CP_CUR_PLL_RATE2	0x680
+#define QSERDES_V8_LALB_CDR_FASTLOCK_CP_CUR_PLL_RATE3	0x684
+#define QSERDES_V8_LALB_CDR_FASTLOCK_CP_CUR_PLL_RATE4	0x688
+#define QSERDES_V8_LALB_DEBUG_BUS_SEL	0x68c
+#define QSERDES_V8_LALB_BIST_STATUS	0x690
+#define QSERDES_V8_LALB_BIST_ERROR_COUNT1	0x694
+#define QSERDES_V8_LALB_BIST_ERROR_COUNT2	0x698
+#define QSERDES_V8_LALB_AC_JTAG_OUTP	0x69c
+#define QSERDES_V8_LALB_AC_JTAG_OUTN	0x6a0
+#define QSERDES_V8_LALB_DATA_SLICER_DEBUG_STATUS	0x6a4
+#define QSERDES_V8_LALB_DATA_SLICER_TIMER1_STATUS	0x6a8
+#define QSERDES_V8_LALB_DATA_SLICER_TIMER2_STATUS	0x6ac
+#define QSERDES_V8_LALB_TX0_RESTRIM_CODE_STATUS	0x6b0
+#define QSERDES_V8_LALB_TX0_RESTRIM_ICAL_CODE_STATUS	0x6b4
+#define QSERDES_V8_LALB_TX0_RESTRIM_CAL_STATUS	0x6b8
+#define QSERDES_V8_LALB_TX1_RESTRIM_CODE_STATUS	0x6bc
+#define QSERDES_V8_LALB_TX1_RESTRIM_ICAL_CODE_STATUS	0x6c0
+#define QSERDES_V8_LALB_TX1_RESTRIM_CAL_STATUS	0x6c4
+#define QSERDES_V8_LALB_CMUX_DCC_CAL_FSM_STATUS	0x6c8
+#define QSERDES_V8_LALB_CMUX_DCC_READCODE_STATUS	0x6cc
+#define QSERDES_V8_LALB_TX_DCC_CAL_ANA_STATUS	0x6d0
+#define QSERDES_V8_LALB_TX0_CTUNE_DCC_FSM_DEBUG_STATUS	0x6d4
+#define QSERDES_V8_LALB_TX0_COARSE_DCC_READCODE_STATUS	0x6d8
+#define QSERDES_V8_LALB_TX0_FTUNE_MSB_DCC_FSM_DEBUG_STATUS	0x6dc
+#define QSERDES_V8_LALB_TX0_FTUNE_LSB_DCC_FSM_DEBUG_STATUS	0x6e0
+#define QSERDES_V8_LALB_TX0_FINE_DCC_READCODE_STATUS	0x6e4
+#define QSERDES_V8_LALB_TX1_CTUNE_DCC_FSM_DEBUG_STATUS	0x6e8
+#define QSERDES_V8_LALB_TX1_COARSE_DCC_READCODE_STATUS	0x6ec
+#define QSERDES_V8_LALB_TX1_FTUNE_MSB_DCC_FSM_DEBUG_STATUS	0x6f0
+#define QSERDES_V8_LALB_TX1_FTUNE_LSB_DCC_FSM_DEBUG_STATUS	0x6f4
+#define QSERDES_V8_LALB_TX1_FINE_DCC_READCODE_STATUS	0x6f8
+#define QSERDES_V8_LALB_CDR_VCO_CAL_STATUS	0x6fc
+#define QSERDES_V8_LALB_CDR_VCTRL_STATUS	0x700
+#define QSERDES_V8_LALB_CDR_VCO_CAP_CODE_STATUS	0x704
+#define QSERDES_V8_LALB_KVCO_CAL_DEBUG1_STATUS	0x708
+#define QSERDES_V8_LALB_KVCO_CAL_DEBUG2_STATUS	0x70c
+#define QSERDES_V8_LALB_KP_CAL_DEBUG1_STATUS	0x710
+#define QSERDES_V8_LALB_KP_CAL_DEBUG2_STATUS	0x714
+#define QSERDES_V8_LALB_CDR_VCO_FREQ_DEBUG1_STATUS	0x718
+#define QSERDES_V8_LALB_CDR_VCO_FREQ_DEBUG2_STATUS	0x71c
+#define QSERDES_V8_LALB_CDR_VCO_FREQ_DEBUG3_STATUS	0x720
+#define QSERDES_V8_LALB_CDR_VCO_FREQ_DEBUG4_STATUS	0x724
+#define QSERDES_V8_LALB_IVCM_CAL_STATUS	0x728
+#define QSERDES_V8_LALB_IVCM_CAL_DEBUG_STATUS	0x72c
+#define QSERDES_V8_LALB_IDAC_STATUS_I0	0x730
+#define QSERDES_V8_LALB_IDAC_STATUS_I0BAR	0x734
+#define QSERDES_V8_LALB_IDAC_STATUS_I1	0x738
+#define QSERDES_V8_LALB_IDAC_STATUS_I1BAR	0x73c
+#define QSERDES_V8_LALB_IDAC_STATUS_Q	0x740
+#define QSERDES_V8_LALB_IDAC_STATUS_QBAR	0x744
+#define QSERDES_V8_LALB_IDAC_STATUS_A	0x748
+#define QSERDES_V8_LALB_IDAC_STATUS_ABAR	0x74c
+#define QSERDES_V8_LALB_IDAC_STATUS_SM_ON	0x750
+#define QSERDES_V8_LALB_IDAC_STATUS_SIGNERROR	0x754
+#define QSERDES_V8_LALB_RX_SIGDET_STATUS	0x758
+#define QSERDES_V8_LALB_SIGDET_CAL_CODE_STATUS	0x75c
+#define QSERDES_V8_LALB_SIGDET_CAL_FSM_DEBUG_STATUS	0x760
+#define QSERDES_V8_LALB_CDR_FREQ_LOCK_CNT_STATUS	0x764
+#define QSERDES_V8_LALB_CDR_PHASE_LOCK_CNT_STATUS	0x768
+#define QSERDES_V8_LALB_CDR_LOCK_DEBUG_STATUS	0x76c
+#define QSERDES_V8_LALB_IDATA_HIGH_STATUS1	0x770
+#define QSERDES_V8_LALB_IDATA_HIGH_STATUS2	0x774
+#define QSERDES_V8_LALB_IDATA_HIGH_STATUS3	0x778
+#define QSERDES_V8_LALB_IDATA_HIGH_STATUS4	0x77c
+#define QSERDES_V8_LALB_IDATA_LOW_STATUS1	0x780
+#define QSERDES_V8_LALB_IDATA_LOW_STATUS2	0x784
+#define QSERDES_V8_LALB_IDATA_LOW_STATUS3	0x788
+#define QSERDES_V8_LALB_IDATA_LOW_STATUS4	0x78c
+#define QSERDES_V8_LALB_QDATA_STATUS1	0x790
+#define QSERDES_V8_LALB_QDATA_STATUS2	0x794
+#define QSERDES_V8_LALB_QDATA_STATUS3	0x798
+#define QSERDES_V8_LALB_QDATA_STATUS4	0x79c
+#define QSERDES_V8_LALB_IA_ERROR_COUNTER_LOW	0x7a0
+#define QSERDES_V8_LALB_IA_ERROR_COUNTER_HIGH	0x7a4
+#define QSERDES_V8_LALB_EOM_ERR_CNT_LSB_STATUS	0x7a8
+#define QSERDES_V8_LALB_EOM_ERR_CNT_MSB_STATUS	0x7ac
+#define QSERDES_V8_LALB_EOM_OP_STATUS	0x7b0
+#define QSERDES_V8_LALB_AUX_MIXER_INDEX_STATUS	0x7b4
+#define QSERDES_V8_LALB_AUX_OFFSET_STATUS	0x7b8
+#define QSERDES_V8_LALB_AUXDATA_TB_STATUS	0x7bc
+#define QSERDES_V8_LALB_AUX_MIXER_CTRL_0_STATUS	0x7c0
+#define QSERDES_V8_LALB_AUX_MIXER_CTRL_90_STATUS	0x7c4
+#define QSERDES_V8_LALB_AUX_MIXER_CTRL_180_STATUS	0x7c8
+#define QSERDES_V8_LALB_IQ_MIXER_INDEX_STATUS	0x7cc
+#define QSERDES_V8_LALB_IQTUNE_FLTR_INDEX_STATUS	0x7d0
+#define QSERDES_V8_LALB_IQ_MIXER_CTRL_0_STATUS	0x7d4
+#define QSERDES_V8_LALB_IQ_MIXER_CTRL_90_STATUS	0x7d8
+#define QSERDES_V8_LALB_IQ_MIXER_CTRL_180_STATUS	0x7dc
+#define QSERDES_V8_LALB_READ_EQCODE	0x7e0
+#define QSERDES_V8_LALB_READ_OFFSETCODE	0x7e4
+#define QSERDES_V8_LALB_VGA_READ_CODE	0x7e8
+#define QSERDES_V8_LALB_VTHRESH_READ_CODE	0x7ec
+#define QSERDES_V8_LALB_DFE_TAP1_READ_CODE	0x7f0
+#define QSERDES_V8_LALB_DFE_TAP2_READ_CODE	0x7f4
+#define QSERDES_V8_LALB_DFE_TAP3_READ_CODE	0x7f8
+#define QSERDES_V8_LALB_DFE_TAP4_READ_CODE	0x7fc
+#define QSERDES_V8_LALB_DFE_TAP5_READ_CODE	0x800
+#define QSERDES_V8_LALB_DFE_TAP6_READ_CODE	0x804
+#define QSERDES_V8_LALB_DFE_TAP7_READ_CODE	0x808
+#define QSERDES_V8_LALB_CDR_IQTUNE_FILTER_BIN_CODE	0x80c
+#define QSERDES_V8_LALB_CDR_IQTUNE_FILTER_CLK0_CODE	0x810
+#define QSERDES_V8_LALB_CDR_IQTUNE_FILTER_CLK90_CODE	0x814
+#define QSERDES_V8_LALB_BLW_READ_CODE	0x818
+#define QSERDES_V8_LALB_IA_OFFSET_CAL_DEBUG_STATUS	0x81c
+#define QSERDES_V8_LALB_IA_OFFSET_CAL_STATUS	0x820
+#define QSERDES_V8_LALB_IVTH_CAL_STATUS	0x824
+#define QSERDES_V8_LALB_IVTH_NRZ_EYE_HEIGHT_STATUS	0x828
+#define QSERDES_V8_LALB_IVTH_UPPER_EYE_MAX_STATUS	0x82c
+#define QSERDES_V8_LALB_IVTH_UPPER_EYE_MIN_STATUS	0x830
+#define QSERDES_V8_LALB_IVTH_LOWER_EYE_MAX_STATUS	0x834
+#define QSERDES_V8_LALB_IVTH_LOWER_EYE_MIN_STATUS	0x838
+#define QSERDES_V8_LALB_IVTH_UP_INIT_CTR_STATUS	0x83c
+#define QSERDES_V8_LALB_VTH_I_UP_CNTRL_STATUS	0x840
+#define QSERDES_V8_LALB_VTH_I_DN_CNTRL_STATUS	0x844
+#define QSERDES_V8_LALB_NRZ_EYE_HEIGHT_SEL_STATUS	0x848
+#define QSERDES_V8_LALB_DEBUG_BUS0	0x84c
+#define QSERDES_V8_LALB_DEBUG_BUS1	0x850
+#define QSERDES_V8_LALB_DEBUG_BUS2	0x854
+#define QSERDES_V8_LALB_DEBUG_BUS3	0x858
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL1	0x85c
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL2	0x860
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL3	0x864
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL4	0x868
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL5	0x86c
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL6	0x870
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL7	0x874
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL8	0x878
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL9	0x87c
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL10	0x880
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL11	0x884
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL12	0x888
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL13	0x88c
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL14	0x890
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL15	0x894
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL16	0x898
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL17	0x89c
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL18	0x8a0
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL19	0x8a4
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL20	0x8a8
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL21	0x8ac
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL22	0x8b0
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL23	0x8b4
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL24	0x8b8
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL25	0x8bc
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL26	0x8c0
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL27	0x8c4
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL28	0x8c8
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL29	0x8cc
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL30	0x8d0
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL31	0x8d4
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL32	0x8d8
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL_V2_1	0x8dc
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL_V2_2	0x8e0
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL_V2_3	0x8e4
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL_V2_4	0x8e8
+#define QSERDES_V8_LALB_DIG_BKUP_CTRL_V2_5	0x8ec
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS1	0x8f0
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS2	0x8f4
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS3	0x8f8
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS4	0x8fc
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS5	0x900
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS6	0x904
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS7	0x908
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS8	0x90c
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS9	0x910
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS10	0x914
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS11	0x918
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS12	0x91c
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS13	0x920
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS14	0x924
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS15	0x928
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS16	0x92c
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS17	0x930
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS18	0x934
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS19	0x938
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS20	0x93c
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS21	0x940
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS22	0x944
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS23	0x948
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS24	0x94c
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS25	0x950
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS26	0x954
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS27	0x958
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS28	0x95c
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS29	0x960
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS30	0x964
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS31	0x968
+#define QSERDES_V8_LALB_DIG_BKUP_RO_BUS32	0x96c
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS1	0x970
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS2	0x974
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS3	0x978
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS4	0x97c
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS5	0x980
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS6	0x984
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS7	0x988
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS8	0x98c
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS9	0x990
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS10	0x994
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS11	0x998
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS12	0x99c
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS13	0x9a0
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS14	0x9a4
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS15	0x9a8
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS16	0x9ac
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS17	0x9b0
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS18	0x9b4
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS19	0x9b8
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS20	0x9bc
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS21	0x9c0
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS22	0x9c4
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS23	0x9c8
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS24	0x9cc
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS25	0x9d0
+#define QSERDES_V8_LALB_DIG_BKUP_RO_V2_BUS26	0x9d4
+#endif /* QCOM_PHY_QMP_QSERDES_V8_LALBH_ */
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-ln-shrd-v5.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-ln-shrd-v5.h
new file mode 100644
index 00000000000..68c38fdfc1d
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-ln-shrd-v5.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_LN_SHRD_V5_H_
+#define QCOM_PHY_QMP_QSERDES_LN_SHRD_V5_H_
+
+#define  QSERDES_v5_LN_SHRD_UCDR_PI_CTRL2		0x04c
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v2.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v2.h
new file mode 100644
index 00000000000..9ae0cf95e31
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v2.h
@@ -0,0 +1,205 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_V2_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_V2_H_
+
+/* Only for QMP V2 PHY - TX registers */
+#define QSERDES_V2_TX_BIST_MODE_LANENO				0x000
+#define QSERDES_V2_TX_BIST_INVERT				0x004
+#define QSERDES_V2_TX_CLKBUF_ENABLE				0x008
+#define QSERDES_V2_TX_CMN_CONTROL_ONE				0x00c
+#define QSERDES_V2_TX_CMN_CONTROL_TWO				0x010
+#define QSERDES_V2_TX_CMN_CONTROL_THREE				0x014
+#define QSERDES_V2_TX_TX_EMP_POST1_LVL				0x018
+#define QSERDES_V2_TX_TX_POST2_EMPH				0x01c
+#define QSERDES_V2_TX_TX_BOOST_LVL_UP_DN			0x020
+#define QSERDES_V2_TX_HP_PD_ENABLES				0x024
+#define QSERDES_V2_TX_TX_IDLE_LVL_LARGE_AMP			0x028
+#define QSERDES_V2_TX_TX_DRV_LVL				0x02c
+#define QSERDES_V2_TX_TX_DRV_LVL_OFFSET				0x030
+#define QSERDES_V2_TX_RESET_TSYNC_EN				0x034
+#define QSERDES_V2_TX_PRE_STALL_LDO_BOOST_EN			0x038
+#define QSERDES_V2_TX_TX_BAND					0x03c
+#define QSERDES_V2_TX_SLEW_CNTL					0x040
+#define QSERDES_V2_TX_INTERFACE_SELECT				0x044
+#define QSERDES_V2_TX_LPB_EN					0x048
+#define QSERDES_V2_TX_RES_CODE_LANE_TX				0x04c
+#define QSERDES_V2_TX_RES_CODE_LANE_RX				0x050
+#define QSERDES_V2_TX_RES_CODE_LANE_OFFSET			0x054
+#define QSERDES_V2_TX_PERL_LENGTH1				0x058
+#define QSERDES_V2_TX_PERL_LENGTH2				0x05c
+#define QSERDES_V2_TX_SERDES_BYP_EN_OUT				0x060
+#define QSERDES_V2_TX_DEBUG_BUS_SEL				0x064
+#define QSERDES_V2_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN		0x068
+#define QSERDES_V2_TX_TX_POL_INV				0x06c
+#define QSERDES_V2_TX_PARRATE_REC_DETECT_IDLE_EN		0x070
+#define QSERDES_V2_TX_BIST_PATTERN1				0x074
+#define QSERDES_V2_TX_BIST_PATTERN2				0x078
+#define QSERDES_V2_TX_BIST_PATTERN3				0x07c
+#define QSERDES_V2_TX_BIST_PATTERN4				0x080
+#define QSERDES_V2_TX_BIST_PATTERN5				0x084
+#define QSERDES_V2_TX_BIST_PATTERN6				0x088
+#define QSERDES_V2_TX_BIST_PATTERN7				0x08c
+#define QSERDES_V2_TX_BIST_PATTERN8				0x090
+#define QSERDES_V2_TX_LANE_MODE					0x094
+#define QSERDES_V2_TX_IDAC_CAL_LANE_MODE			0x098
+#define QSERDES_V2_TX_IDAC_CAL_LANE_MODE_CONFIGURATION		0x09c
+#define QSERDES_V2_TX_ATB_SEL1					0x0a0
+#define QSERDES_V2_TX_ATB_SEL2					0x0a4
+#define QSERDES_V2_TX_RCV_DETECT_LVL				0x0a8
+#define QSERDES_V2_TX_RCV_DETECT_LVL_2				0x0ac
+#define QSERDES_V2_TX_PRBS_SEED1				0x0b0
+#define QSERDES_V2_TX_PRBS_SEED2				0x0b4
+#define QSERDES_V2_TX_PRBS_SEED3				0x0b8
+#define QSERDES_V2_TX_PRBS_SEED4				0x0bc
+#define QSERDES_V2_TX_RESET_GEN					0x0c0
+#define QSERDES_V2_TX_RESET_GEN_MUXES				0x0c4
+#define QSERDES_V2_TX_TRAN_DRVR_EMP_EN				0x0c8
+#define QSERDES_V2_TX_TX_INTERFACE_MODE				0x0cc
+#define QSERDES_V2_TX_PWM_CTRL					0x0d0
+#define QSERDES_V2_TX_PWM_ENCODED_OR_DATA			0x0d4
+#define QSERDES_V2_TX_PWM_GEAR_1_DIVIDER_BAND2			0x0d8
+#define QSERDES_V2_TX_PWM_GEAR_2_DIVIDER_BAND2			0x0dc
+#define QSERDES_V2_TX_PWM_GEAR_3_DIVIDER_BAND2			0x0e0
+#define QSERDES_V2_TX_PWM_GEAR_4_DIVIDER_BAND2			0x0e4
+#define QSERDES_V2_TX_PWM_GEAR_1_DIVIDER_BAND0_1		0x0e8
+#define QSERDES_V2_TX_PWM_GEAR_2_DIVIDER_BAND0_1		0x0ec
+#define QSERDES_V2_TX_PWM_GEAR_3_DIVIDER_BAND0_1		0x0f0
+#define QSERDES_V2_TX_PWM_GEAR_4_DIVIDER_BAND0_1		0x0f4
+#define QSERDES_V2_TX_VMODE_CTRL1				0x0f8
+#define QSERDES_V2_TX_VMODE_CTRL2				0x0fc
+#define QSERDES_V2_TX_TX_ALOG_INTF_OBSV_CNTL			0x100
+#define QSERDES_V2_TX_BIST_STATUS				0x104
+#define QSERDES_V2_TX_BIST_ERROR_COUNT1				0x108
+#define QSERDES_V2_TX_BIST_ERROR_COUNT2				0x10c
+#define QSERDES_V2_TX_TX_ALOG_INTF_OBSV				0x110
+
+/* Only for QMP V2 PHY - RX registers */
+#define QSERDES_V2_RX_UCDR_FO_GAIN_HALF				0x000
+#define QSERDES_V2_RX_UCDR_FO_GAIN_QUARTER			0x004
+#define QSERDES_V2_RX_UCDR_FO_GAIN_EIGHTH			0x008
+#define QSERDES_V2_RX_UCDR_FO_GAIN				0x00c
+#define QSERDES_V2_RX_UCDR_SO_GAIN_HALF				0x010
+#define QSERDES_V2_RX_UCDR_SO_GAIN_QUARTER			0x014
+#define QSERDES_V2_RX_UCDR_SO_GAIN_EIGHTH			0x018
+#define QSERDES_V2_RX_UCDR_SO_GAIN				0x01c
+#define QSERDES_V2_RX_UCDR_SVS_FO_GAIN_HALF			0x020
+#define QSERDES_V2_RX_UCDR_SVS_FO_GAIN_QUARTER			0x024
+#define QSERDES_V2_RX_UCDR_SVS_FO_GAIN_EIGHTH			0x028
+#define QSERDES_V2_RX_UCDR_SVS_FO_GAIN				0x02c
+#define QSERDES_V2_RX_UCDR_SVS_SO_GAIN_HALF			0x030
+#define QSERDES_V2_RX_UCDR_SVS_SO_GAIN_QUARTER			0x034
+#define QSERDES_V2_RX_UCDR_SVS_SO_GAIN_EIGHTH			0x038
+#define QSERDES_V2_RX_UCDR_SVS_SO_GAIN				0x03c
+#define QSERDES_V2_RX_UCDR_FASTLOCK_FO_GAIN			0x040
+#define QSERDES_V2_RX_UCDR_FD_GAIN				0x044
+#define QSERDES_V2_RX_UCDR_SO_SATURATION_AND_ENABLE		0x048
+#define QSERDES_V2_RX_UCDR_FO_TO_SO_DELAY			0x04c
+#define QSERDES_V2_RX_UCDR_FASTLOCK_COUNT_LOW			0x050
+#define QSERDES_V2_RX_UCDR_FASTLOCK_COUNT_HIGH			0x054
+#define QSERDES_V2_RX_UCDR_MODULATE				0x058
+#define QSERDES_V2_RX_UCDR_PI_CONTROLS				0x05c
+#define QSERDES_V2_RX_RBIST_CONTROL				0x060
+#define QSERDES_V2_RX_AUX_CONTROL				0x064
+#define QSERDES_V2_RX_AUX_DATA_TCOARSE				0x068
+#define QSERDES_V2_RX_AUX_DATA_TFINE_LSB			0x06c
+#define QSERDES_V2_RX_AUX_DATA_TFINE_MSB			0x070
+#define QSERDES_V2_RX_RCLK_AUXDATA_SEL				0x074
+#define QSERDES_V2_RX_AC_JTAG_ENABLE				0x078
+#define QSERDES_V2_RX_AC_JTAG_INITP				0x07c
+#define QSERDES_V2_RX_AC_JTAG_INITN				0x080
+#define QSERDES_V2_RX_AC_JTAG_LVL				0x084
+#define QSERDES_V2_RX_AC_JTAG_MODE				0x088
+#define QSERDES_V2_RX_AC_JTAG_RESET				0x08c
+#define QSERDES_V2_RX_RX_TERM_BW				0x090
+#define QSERDES_V2_RX_RX_RCVR_IQ_EN				0x094
+#define QSERDES_V2_RX_RX_IDAC_I_DC_OFFSETS			0x098
+#define QSERDES_V2_RX_RX_IDAC_IBAR_DC_OFFSETS			0x09c
+#define QSERDES_V2_RX_RX_IDAC_Q_DC_OFFSETS			0x0a0
+#define QSERDES_V2_RX_RX_IDAC_QBAR_DC_OFFSETS			0x0a4
+#define QSERDES_V2_RX_RX_IDAC_A_DC_OFFSETS			0x0a8
+#define QSERDES_V2_RX_RX_IDAC_ABAR_DC_OFFSETS			0x0ac
+#define QSERDES_V2_RX_RX_IDAC_EN				0x0b0
+#define QSERDES_V2_RX_RX_IDAC_ENABLES				0x0b4
+#define QSERDES_V2_RX_RX_IDAC_SIGN				0x0b8
+#define QSERDES_V2_RX_RX_HIGHZ_HIGHRATE				0x0bc
+#define QSERDES_V2_RX_RX_TERM_AC_BYPASS_DC_COUPLE_OFFSET	0x0c0
+#define QSERDES_V2_RX_RX_EQ_GAIN1_LSB				0x0c4
+#define QSERDES_V2_RX_RX_EQ_GAIN1_MSB				0x0c8
+#define QSERDES_V2_RX_RX_EQ_GAIN2_LSB				0x0cc
+#define QSERDES_V2_RX_RX_EQ_GAIN2_MSB				0x0d0
+#define QSERDES_V2_RX_RX_EQU_ADAPTOR_CNTRL1			0x0d4
+#define QSERDES_V2_RX_RX_EQU_ADAPTOR_CNTRL2			0x0d8
+#define QSERDES_V2_RX_RX_EQU_ADAPTOR_CNTRL3			0x0dc
+#define QSERDES_V2_RX_RX_EQU_ADAPTOR_CNTRL4			0x0e0
+#define QSERDES_V2_RX_RX_IDAC_CAL_CONFIGURATION			0x0e4
+#define QSERDES_V2_RX_RX_IDAC_TSETTLE_LOW			0x0e8
+#define QSERDES_V2_RX_RX_IDAC_TSETTLE_HIGH			0x0ec
+#define QSERDES_V2_RX_RX_IDAC_ENDSAMP_LOW			0x0f0
+#define QSERDES_V2_RX_RX_IDAC_ENDSAMP_HIGH			0x0f4
+#define QSERDES_V2_RX_RX_IDAC_MIDPOINT_LOW			0x0f8
+#define QSERDES_V2_RX_RX_IDAC_MIDPOINT_HIGH			0x0fc
+#define QSERDES_V2_RX_RX_EQ_OFFSET_LSB				0x100
+#define QSERDES_V2_RX_RX_EQ_OFFSET_MSB				0x104
+#define QSERDES_V2_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1		0x108
+#define QSERDES_V2_RX_RX_OFFSET_ADAPTOR_CNTRL2			0x10c
+#define QSERDES_V2_RX_SIGDET_ENABLES				0x110
+#define QSERDES_V2_RX_SIGDET_CNTRL				0x114
+#define QSERDES_V2_RX_SIGDET_LVL				0x118
+#define QSERDES_V2_RX_SIGDET_DEGLITCH_CNTRL			0x11c
+#define QSERDES_V2_RX_RX_BAND					0x120
+#define QSERDES_V2_RX_CDR_FREEZE_UP_DN				0x124
+#define QSERDES_V2_RX_CDR_RESET_OVERRIDE			0x128
+#define QSERDES_V2_RX_RX_INTERFACE_MODE				0x12c
+#define QSERDES_V2_RX_JITTER_GEN_MODE				0x130
+#define QSERDES_V2_RX_BUJ_AMP					0x134
+#define QSERDES_V2_RX_SJ_AMP1					0x138
+#define QSERDES_V2_RX_SJ_AMP2					0x13c
+#define QSERDES_V2_RX_SJ_PER1					0x140
+#define QSERDES_V2_RX_SJ_PER2					0x144
+#define QSERDES_V2_RX_BUJ_STEP_FREQ1				0x148
+#define QSERDES_V2_RX_BUJ_STEP_FREQ2				0x14c
+#define QSERDES_V2_RX_PPM_OFFSET1				0x150
+#define QSERDES_V2_RX_PPM_OFFSET2				0x154
+#define QSERDES_V2_RX_SIGN_PPM_PERIOD1				0x158
+#define QSERDES_V2_RX_SIGN_PPM_PERIOD2				0x15c
+#define QSERDES_V2_RX_SSC_CTRL					0x160
+#define QSERDES_V2_RX_SSC_COUNT1				0x164
+#define QSERDES_V2_RX_SSC_COUNT2				0x168
+#define QSERDES_V2_RX_RX_ALOG_INTF_OBSV_CNTL			0x16c
+#define QSERDES_V2_RX_RX_PWM_ENABLE_AND_DATA			0x170
+#define QSERDES_V2_RX_RX_PWM_GEAR1_TIMEOUT_COUNT		0x174
+#define QSERDES_V2_RX_RX_PWM_GEAR2_TIMEOUT_COUNT		0x178
+#define QSERDES_V2_RX_RX_PWM_GEAR3_TIMEOUT_COUNT		0x17c
+#define QSERDES_V2_RX_RX_PWM_GEAR4_TIMEOUT_COUNT		0x180
+#define QSERDES_V2_RX_PI_CTRL1					0x184
+#define QSERDES_V2_RX_PI_CTRL2					0x188
+#define QSERDES_V2_RX_PI_QUAD					0x18c
+#define QSERDES_V2_RX_IDATA1					0x190
+#define QSERDES_V2_RX_IDATA2					0x194
+#define QSERDES_V2_RX_AUX_DATA1					0x198
+#define QSERDES_V2_RX_AUX_DATA2					0x19c
+#define QSERDES_V2_RX_AC_JTAG_OUTP				0x1a0
+#define QSERDES_V2_RX_AC_JTAG_OUTN				0x1a4
+#define QSERDES_V2_RX_RX_SIGDET					0x1a8
+#define QSERDES_V2_RX_RX_VDCOFF					0x1ac
+#define QSERDES_V2_RX_IDAC_CAL_ON				0x1b0
+#define QSERDES_V2_RX_IDAC_STATUS_I				0x1b4
+#define QSERDES_V2_RX_IDAC_STATUS_IBAR				0x1b8
+#define QSERDES_V2_RX_IDAC_STATUS_Q				0x1bc
+#define QSERDES_V2_RX_IDAC_STATUS_QBAR				0x1c0
+#define QSERDES_V2_RX_IDAC_STATUS_A				0x1c4
+#define QSERDES_V2_RX_IDAC_STATUS_ABAR				0x1c8
+#define QSERDES_V2_RX_CALST_STATUS_I				0x1cc
+#define QSERDES_V2_RX_CALST_STATUS_Q				0x1d0
+#define QSERDES_V2_RX_CALST_STATUS_A				0x1d4
+#define QSERDES_V2_RX_RX_ALOG_INTF_OBSV				0x1d8
+#define QSERDES_V2_RX_READ_EQCODE				0x1dc
+#define QSERDES_V2_RX_READ_OFFSETCODE				0x1e0
+#define QSERDES_V2_RX_IA_ERROR_COUNTER_LOW			0x1e4
+#define QSERDES_V2_RX_IA_ERROR_COUNTER_HIGH			0x1e8
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v4_20.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v4_20.h
new file mode 100644
index 00000000000..114570f3017
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v4_20.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_V4_20_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_V4_20_H_
+
+/* Only for QMP V4_20 PHY - TX registers */
+#define QSERDES_V4_20_TX_LANE_MODE_1			0x88
+#define QSERDES_V4_20_TX_LANE_MODE_2			0x8c
+#define QSERDES_V4_20_TX_LANE_MODE_3			0x90
+#define QSERDES_V4_20_TX_VMODE_CTRL1			0xc4
+#define QSERDES_V4_20_TX_PI_QEC_CTRL			0xe0
+
+/* Only for QMP V4_20 PHY - RX registers */
+#define QSERDES_V4_20_RX_FO_GAIN_RATE2			0x008
+#define QSERDES_V4_20_RX_UCDR_PI_CONTROLS		0x058
+#define QSERDES_V4_20_RX_AUX_DATA_TCOARSE_TFINE		0x0ac
+#define QSERDES_V4_20_RX_DFE_3				0x110
+#define QSERDES_V4_20_RX_DFE_DAC_ENABLE1		0x134
+#define QSERDES_V4_20_RX_DFE_DAC_ENABLE2		0x138
+#define QSERDES_V4_20_RX_VGA_CAL_CNTRL2			0x150
+#define QSERDES_V4_20_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1	0x178
+#define QSERDES_V4_20_RX_RX_MODE_RATE_0_1_B1		0x1c8
+#define QSERDES_V4_20_RX_RX_MODE_RATE_0_1_B2		0x1cc
+#define QSERDES_V4_20_RX_RX_MODE_RATE_0_1_B3		0x1d0
+#define QSERDES_V4_20_RX_RX_MODE_RATE_0_1_B4		0x1d4
+#define QSERDES_V4_20_RX_RX_MODE_RATE2_B0		0x1d8
+#define QSERDES_V4_20_RX_RX_MODE_RATE2_B1		0x1dc
+#define QSERDES_V4_20_RX_RX_MODE_RATE2_B2		0x1e0
+#define QSERDES_V4_20_RX_RX_MODE_RATE2_B3		0x1e4
+#define QSERDES_V4_20_RX_RX_MODE_RATE2_B4		0x1e8
+#define QSERDES_V4_20_RX_RX_MODE_RATE3_B0		0x1ec
+#define QSERDES_V4_20_RX_RX_MODE_RATE3_B1		0x1f0
+#define QSERDES_V4_20_RX_RX_MODE_RATE3_B2		0x1f4
+#define QSERDES_V4_20_RX_RX_MODE_RATE3_B3		0x1f8
+#define QSERDES_V4_20_RX_RX_MODE_RATE3_B4		0x1fc
+#define QSERDES_V4_20_RX_PHPRE_CTRL			0x200
+#define QSERDES_V4_20_RX_DFE_CTLE_POST_CAL_OFFSET	0x20c
+#define QSERDES_V4_20_RX_MARG_COARSE_CTRL2		0x23c
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v5_20.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v5_20.h
new file mode 100644
index 00000000000..cf91154eed1
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v5_20.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_V5_20_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_V5_20_H_
+
+/* Only for QMP V5_20 PHY - TX registers */
+#define QSERDES_V5_20_TX_RES_CODE_LANE_OFFSET_TX	0x30
+#define QSERDES_V5_20_TX_RES_CODE_LANE_OFFSET_RX	0x34
+#define QSERDES_V5_20_TX_LANE_MODE_1			0x78
+#define QSERDES_V5_20_TX_LANE_MODE_2			0x7c
+#define QSERDES_V5_20_TX_LANE_MODE_3			0x80
+#define QSERDES_V5_20_TX_RCV_DETECT_LVL_2		0x90
+#define QSERDES_V5_20_TX_VMODE_CTRL1			0xb0
+#define QSERDES_V5_20_TX_PI_QEC_CTRL			0xcc
+
+/* Only for QMP V5_20 PHY - RX registers */
+#define QSERDES_V5_20_RX_UCDR_FO_GAIN_RATE2		0x008
+#define QSERDES_V5_20_RX_UCDR_FO_GAIN_RATE3		0x00c
+#define QSERDES_V5_20_RX_UCDR_SO_GAIN_RATE3		0x01c
+#define QSERDES_V5_20_RX_UCDR_PI_CONTROLS		0x020
+#define QSERDES_V5_20_RX_AUX_DATA_THRESH_BIN_RATE_0_1	0x02c
+#define QSERDES_V5_20_RX_AUX_DATA_THRESH_BIN_RATE_2_3	0x030
+#define QSERDES_V5_20_RX_RX_IDAC_SAOFFSET		0x07c
+#define QSERDES_V5_20_RX_DFE_1				0x088
+#define QSERDES_V5_20_RX_DFE_2				0x08c
+#define QSERDES_V5_20_RX_DFE_3				0x090
+#define QSERDES_V5_20_RX_DFE_DAC_ENABLE1		0x0b4
+#define QSERDES_V5_20_RX_TX_ADAPT_PRE_THRESH1		0x0bc
+#define QSERDES_V5_20_RX_TX_ADAPT_PRE_THRESH2		0x0c0
+#define QSERDES_V5_20_RX_TX_ADAPT_POST_THRESH1		0x0c4
+#define QSERDES_V5_20_RX_TX_ADAPT_POST_THRESH2		0x0c8
+#define QSERDES_V5_20_RX_TX_ADAPT_MAIN_THRESH1		0x0cc
+#define QSERDES_V5_20_RX_TX_ADAPT_MAIN_THRESH2		0x0d0
+#define QSERDES_V5_20_RX_VGA_CAL_CNTRL1			0x0d4
+#define QSERDES_V5_20_RX_VGA_CAL_CNTRL2			0x0d8
+#define QSERDES_V5_20_RX_VGA_CAL_MAN_VAL		0x0dc
+#define QSERDES_V5_20_RX_GM_CAL				0x0ec
+#define QSERDES_V5_20_RX_RX_EQU_ADAPTOR_CNTRL2		0x100
+#define QSERDES_V5_20_RX_RX_EQU_ADAPTOR_CNTRL3		0x104
+#define QSERDES_V5_20_RX_RX_EQU_ADAPTOR_CNTRL4		0x108
+#define QSERDES_V5_20_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1	0x118
+#define QSERDES_V5_20_RX_RX_OFFSET_ADAPTOR_CNTRL2	0x11c
+#define QSERDES_V5_20_RX_SIGDET_ENABLES			0x120
+#define QSERDES_V5_20_RX_SIGDET_CNTRL			0x124
+#define QSERDES_V5_20_RX_SIGDET_DEGLITCH_CNTRL		0x12c
+#define QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B0		0x160
+#define QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B1		0x164
+#define QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B2		0x168
+#define QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B3		0x16c
+#define QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B4		0x170
+#define QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B5		0x174
+#define QSERDES_V5_20_RX_RX_MODE_RATE_0_1_B6		0x178
+#define QSERDES_V5_20_RX_RX_MODE_RATE2_B0		0x17c
+#define QSERDES_V5_20_RX_RX_MODE_RATE2_B1		0x180
+#define QSERDES_V5_20_RX_RX_MODE_RATE2_B2		0x184
+#define QSERDES_V5_20_RX_RX_MODE_RATE2_B3		0x188
+#define QSERDES_V5_20_RX_RX_MODE_RATE2_B4		0x18c
+#define QSERDES_V5_20_RX_RX_MODE_RATE2_B5		0x190
+#define QSERDES_V5_20_RX_RX_MODE_RATE2_B6		0x194
+#define QSERDES_V5_20_RX_RX_MODE_RATE3_B0		0x198
+#define QSERDES_V5_20_RX_RX_MODE_RATE3_B1		0x19c
+#define QSERDES_V5_20_RX_RX_MODE_RATE3_B2		0x1a0
+#define QSERDES_V5_20_RX_RX_MODE_RATE3_B3		0x1a4
+#define QSERDES_V5_20_RX_RX_MODE_RATE3_B4		0x1a8
+#define QSERDES_V5_20_RX_RX_MODE_RATE3_B5		0x1ac
+#define QSERDES_V5_20_RX_RX_MODE_RATE3_B6		0x1b0
+#define QSERDES_V5_20_RX_PHPRE_CTRL			0x1b4
+#define QSERDES_V5_20_RX_DFE_DAC_ENABLE2		0x1b8
+#define QSERDES_V5_20_RX_DFE_EN_TIMER			0x1bc
+#define QSERDES_V5_20_RX_DFE_CTLE_POST_CAL_OFFSET	0x1c0
+#define QSERDES_V5_20_RX_DCC_CTRL1			0x1c4
+#define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH1_RATE210	0x1f4
+#define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH1_RATE3	0x1f8
+#define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH2_RATE210	0x1fc
+#define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH2_RATE3	0x200
+#define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH3_RATE210	0x204
+#define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH3_RATE3	0x208
+#define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH4_RATE3	0x210
+#define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH5_RATE3	0x218
+#define QSERDES_V5_20_RX_RX_MARG_COARSE_THRESH6_RATE3	0x220
+#define QSERDES_V5_20_RX_Q_PI_INTRINSIC_BIAS_RATE32    0x238
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v5_5nm.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v5_5nm.h
new file mode 100644
index 00000000000..a4a4e251348
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v5_5nm.h
@@ -0,0 +1,328 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_V5_5NM_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_V5_5NM_H_
+
+/* Only for QMP V5 5NM PHY - TX registers */
+#define QSERDES_V5_5NM_TX_BIST_MODE_LANENO			0x00
+#define QSERDES_V5_5NM_TX_BIST_INVERT				0x04
+#define QSERDES_V5_5NM_TX_CLKBUF_ENABLE				0x08
+#define QSERDES_V5_5NM_TX_TX_EMP_POST1_LVL			0x0c
+#define QSERDES_V5_5NM_TX_TX_IDLE_LVL_LARGE_AMP			0x10
+#define QSERDES_V5_5NM_TX_TX_DRV_LVL				0x14
+#define QSERDES_V5_5NM_TX_TX_DRV_LVL_OFFSET			0x18
+#define QSERDES_V5_5NM_TX_RESET_TSYNC_EN			0x1c
+#define QSERDES_V5_5NM_TX_PRE_STALL_LDO_BOOST_EN		0x20
+#define QSERDES_V5_5NM_TX_LPB_EN				0x24
+#define QSERDES_V5_5NM_TX_RES_CODE_LANE_TX			0x28
+#define QSERDES_V5_5NM_TX_RES_CODE_LANE_RX			0x2c
+#define QSERDES_V5_5NM_TX_RES_CODE_LANE_OFFSET_TX		0x30
+#define QSERDES_V5_5NM_TX_RES_CODE_LANE_OFFSET_RX		0x34
+#define QSERDES_V5_5NM_TX_PERL_LENGTH1				0x38
+#define QSERDES_V5_5NM_TX_PERL_LENGTH2				0x3c
+#define QSERDES_V5_5NM_TX_SERDES_BYP_EN_OUT			0x40
+#define QSERDES_V5_5NM_TX_DEBUG_BUS_SEL				0x44
+#define QSERDES_V5_5NM_TX_TRANSCEIVER_BIAS_EN			0x48
+#define QSERDES_V5_5NM_TX_HIGHZ_DRVR_EN				0x4c
+#define QSERDES_V5_5NM_TX_TX_POL_INV				0x50
+#define QSERDES_V5_5NM_TX_PARRATE_REC_DETECT_IDLE_EN		0x54
+#define QSERDES_V5_5NM_TX_BIST_PATTERN1				0x58
+#define QSERDES_V5_5NM_TX_BIST_PATTERN2				0x5c
+#define QSERDES_V5_5NM_TX_BIST_PATTERN3				0x60
+#define QSERDES_V5_5NM_TX_BIST_PATTERN4				0x64
+#define QSERDES_V5_5NM_TX_BIST_PATTERN5				0x68
+#define QSERDES_V5_5NM_TX_BIST_PATTERN6				0x6c
+#define QSERDES_V5_5NM_TX_BIST_PATTERN7				0x70
+#define QSERDES_V5_5NM_TX_BIST_PATTERN8				0x74
+#define QSERDES_V5_5NM_TX_LANE_MODE_1				0x78
+#define QSERDES_V5_5NM_TX_LANE_MODE_2				0x7c
+#define QSERDES_V5_5NM_TX_LANE_MODE_3				0x80
+#define QSERDES_V5_5NM_TX_ATB_SEL1				0x84
+#define QSERDES_V5_5NM_TX_ATB_SEL2				0x88
+#define QSERDES_V5_5NM_TX_RCV_DETECT_LVL			0x8c
+#define QSERDES_V5_5NM_TX_RCV_DETECT_LVL_2			0x90
+#define QSERDES_V5_5NM_TX_PRBS_SEED1				0x94
+#define QSERDES_V5_5NM_TX_PRBS_SEED2				0x98
+#define QSERDES_V5_5NM_TX_PRBS_SEED3				0x9c
+#define QSERDES_V5_5NM_TX_PRBS_SEED4				0xa0
+#define QSERDES_V5_5NM_TX_RESET_GEN				0xa4
+#define QSERDES_V5_5NM_TX_RESET_GEN_MUXES			0xa8
+#define QSERDES_V5_5NM_TX_TRAN_DRVR_EMP_EN			0xac
+#define QSERDES_V5_5NM_TX_VMODE_CTRL1				0xb0
+#define QSERDES_V5_5NM_TX_ALOG_OBSV_BUS_CTRL_1			0xb4
+#define QSERDES_V5_5NM_TX_BIST_STATUS				0xb8
+#define QSERDES_V5_5NM_TX_BIST_ERROR_COUNT1			0xbc
+#define QSERDES_V5_5NM_TX_BIST_ERROR_COUNT2			0xc0
+#define QSERDES_V5_5NM_TX_ALOG_OBSV_BUS_STATUS_1		0xc4
+#define QSERDES_V5_5NM_TX_LANE_DIG_CONFIG			0xc8
+#define QSERDES_V5_5NM_TX_PI_QEC_CTRL				0xcc
+#define QSERDES_V5_5NM_TX_PRE_EMPH				0xd0
+#define QSERDES_V5_5NM_TX_SW_RESET				0xd4
+#define QSERDES_V5_5NM_TX_TX_BAND				0xd8
+#define QSERDES_V5_5NM_TX_SLEW_CNTL0				0xdc
+#define QSERDES_V5_5NM_TX_SLEW_CNTL1				0xe0
+#define QSERDES_V5_5NM_TX_INTERFACE_SELECT			0xe4
+#define QSERDES_V5_5NM_TX_DIG_BKUP_CTRL				0xe8
+#define QSERDES_V5_5NM_TX_DEBUG_BUS0				0xec
+#define QSERDES_V5_5NM_TX_DEBUG_BUS1				0xf0
+#define QSERDES_V5_5NM_TX_DEBUG_BUS2				0xf4
+#define QSERDES_V5_5NM_TX_DEBUG_BUS3				0xf8
+#define QSERDES_V5_5NM_TX_TX_BKUP_RO_BUS			0xfc
+
+/* Only for QMP V5 5NM PHY - RX registers */
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_FO_GAIN_RATE0		0x000
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_FO_GAIN_RATE1		0x004
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_FO_GAIN_RATE2		0x008
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_FO_GAIN_RATE3		0x00c
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_SO_GAIN_RATE0		0x010
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_SO_GAIN_RATE1		0x014
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_SO_GAIN_RATE2		0x018
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_SO_GAIN_RATE3		0x01c
+#define QSERDES_V5_5NM_RX_UCDR_SO_SATURATION			0x020
+#define QSERDES_V5_5NM_RX_UCDR_FO_TO_SO_DELAY			0x024
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_COUNT_LOW_RATE0		0x028
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE0	0x02c
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_COUNT_LOW_RATE1		0x030
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE1	0x034
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_COUNT_LOW_RATE2		0x038
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE2	0x03c
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_COUNT_LOW_RATE3		0x040
+#define QSERDES_V5_5NM_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE3	0x044
+#define QSERDES_V5_5NM_RX_UCDR_PI_CTRL1				0x048
+#define QSERDES_V5_5NM_RX_UCDR_PI_CTRL2				0x04c
+#define QSERDES_V5_5NM_RX_UCDR_SB2_THRESH1_RATE0		0x050
+#define QSERDES_V5_5NM_RX_UCDR_SB2_THRESH1_RATE1		0x054
+#define QSERDES_V5_5NM_RX_UCDR_SB2_THRESH1_RATE2		0x058
+#define QSERDES_V5_5NM_RX_UCDR_SB2_THRESH1_RATE3		0x05c
+#define QSERDES_V5_5NM_RX_UCDR_SB2_THRESH2_RATE0		0x060
+#define QSERDES_V5_5NM_RX_UCDR_SB2_THRESH2_RATE1		0x064
+#define QSERDES_V5_5NM_RX_UCDR_SB2_THRESH2_RATE2		0x068
+#define QSERDES_V5_5NM_RX_UCDR_SB2_THRESH2_RATE3		0x06c
+#define QSERDES_V5_5NM_RX_UCDR_SB2_GAIN1_RATE0			0x070
+#define QSERDES_V5_5NM_RX_UCDR_SB2_GAIN1_RATE1			0x074
+#define QSERDES_V5_5NM_RX_UCDR_SB2_GAIN1_RATE2			0x078
+#define QSERDES_V5_5NM_RX_UCDR_SB2_GAIN1_RATE3			0x07c
+#define QSERDES_V5_5NM_RX_UCDR_SB2_GAIN2_RATE0			0x080
+#define QSERDES_V5_5NM_RX_UCDR_SB2_GAIN2_RATE1			0x084
+#define QSERDES_V5_5NM_RX_UCDR_SB2_GAIN2_RATE2			0x088
+#define QSERDES_V5_5NM_RX_UCDR_SB2_GAIN2_RATE3			0x08c
+#define QSERDES_V5_5NM_RX_RXCLK_DIV2_CTRL			0x090
+#define QSERDES_V5_5NM_RX_RX_BAND				0x094
+#define QSERDES_V5_5NM_RX_RX_TERM_BW				0x098
+#define QSERDES_V5_5NM_RX_UCDR_FO_GAIN_RATE0			0x09c
+#define QSERDES_V5_5NM_RX_UCDR_FO_GAIN_RATE1			0x0a0
+#define QSERDES_V5_5NM_RX_UCDR_FO_GAIN_RATE2			0x0a4
+#define QSERDES_V5_5NM_RX_UCDR_FO_GAIN_RATE3			0x0a8
+#define QSERDES_V5_5NM_RX_UCDR_SO_GAIN_RATE0			0x0ac
+#define QSERDES_V5_5NM_RX_UCDR_SO_GAIN_RATE1			0x0b0
+#define QSERDES_V5_5NM_RX_UCDR_SO_GAIN_RATE2			0x0b4
+#define QSERDES_V5_5NM_RX_UCDR_SO_GAIN_RATE3			0x0b8
+#define QSERDES_V5_5NM_RX_UCDR_PI_CONTROLS			0x0bc
+#define QSERDES_V5_5NM_RX_UCDR_PD_DATA_FILTER_ENABLES		0x0c0
+#define QSERDES_V5_5NM_RX_UCDR_SO_ACC_DEFAULT_VAL_RATE0		0x0c4
+#define QSERDES_V5_5NM_RX_UCDR_SO_ACC_DEFAULT_VAL_RATE1		0x0c8
+#define QSERDES_V5_5NM_RX_UCDR_SO_ACC_DEFAULT_VAL_RATE2		0x0cc
+#define QSERDES_V5_5NM_RX_UCDR_SO_ACC_DEFAULT_VAL_RATE3		0x0d0
+#define QSERDES_V5_5NM_RX_AUX_CONTROL				0x0d4
+#define QSERDES_V5_5NM_RX_AUXDATA_TB				0x0d8
+#define QSERDES_V5_5NM_RX_RCLK_AUXDATA_SEL			0x0dc
+#define QSERDES_V5_5NM_RX_EOM_CTRL				0x0e0
+#define QSERDES_V5_5NM_RX_AC_JTAG_ENABLE			0x0e4
+#define QSERDES_V5_5NM_RX_AC_JTAG_INITP				0x0e8
+#define QSERDES_V5_5NM_RX_AC_JTAG_INITN				0x0ec
+#define QSERDES_V5_5NM_RX_AC_JTAG_LVL				0x0f0
+#define QSERDES_V5_5NM_RX_AC_JTAG_MODE				0x0f4
+#define QSERDES_V5_5NM_RX_AC_JTAG_RESET				0x0f8
+#define QSERDES_V5_5NM_RX_RX_RCVR_IQ_EN				0x0fc
+#define QSERDES_V5_5NM_RX_RX_Q_EN_RATES				0x100
+#define QSERDES_V5_5NM_RX_RX_IDAC_I0_DC_OFFSETS			0x104
+#define QSERDES_V5_5NM_RX_RX_IDAC_I0BAR_DC_OFFSETS		0x108
+#define QSERDES_V5_5NM_RX_RX_IDAC_I1_DC_OFFSETS			0x10c
+#define QSERDES_V5_5NM_RX_RX_IDAC_I1BAR_DC_OFFSETS		0x110
+#define QSERDES_V5_5NM_RX_RX_IDAC_Q_DC_OFFSETS			0x114
+#define QSERDES_V5_5NM_RX_RX_IDAC_QBAR_DC_OFFSETS		0x118
+#define QSERDES_V5_5NM_RX_RX_IDAC_A_DC_OFFSETS			0x11c
+#define QSERDES_V5_5NM_RX_RX_IDAC_ABAR_DC_OFFSETS		0x120
+#define QSERDES_V5_5NM_RX_RX_IDAC_EN				0x124
+#define QSERDES_V5_5NM_RX_RX_IDAC_ENABLES			0x128
+#define QSERDES_V5_5NM_RX_RX_IDAC_SIGN				0x12c
+#define QSERDES_V5_5NM_RX_RX_IVCM_CAL_CODE_OVERRIDE		0x130
+#define QSERDES_V5_5NM_RX_RX_IVCM_CAL_CTRL1			0x134
+#define QSERDES_V5_5NM_RX_RX_IVCM_CAL_CTRL2			0x138
+#define QSERDES_V5_5NM_RX_RX_IVCM_POSTCAL_OFFSET		0x13c
+#define QSERDES_V5_5NM_RX_RX_SUMMER_CAL_SPD_MODE		0x140
+#define QSERDES_V5_5NM_RX_RX_HIGHZ_PARRATE			0x144
+#define QSERDES_V5_5NM_RX_RX_TERM_AC_BYPASS_DC_COUPLE_OFFSET	0x148
+#define QSERDES_V5_5NM_RX_DFE_1					0x14c
+#define QSERDES_V5_5NM_RX_DFE_2					0x150
+#define QSERDES_V5_5NM_RX_DFE_3					0x154
+#define QSERDES_V5_5NM_RX_DFE_4					0x158
+#define QSERDES_V5_5NM_RX_DFE_TAP3_CTRL				0x15c
+#define QSERDES_V5_5NM_RX_DFE_TAP3_MANVAL_KTAP			0x160
+#define QSERDES_V5_5NM_RX_DFE_TAP4_CTRL				0x164
+#define QSERDES_V5_5NM_RX_DFE_TAP4_MANVAL_KTAP			0x168
+#define QSERDES_V5_5NM_RX_DFE_TAP5_CTRL				0x16c
+#define QSERDES_V5_5NM_RX_DFE_TAP5_MANVAL_KTAP			0x170
+#define QSERDES_V5_5NM_RX_TX_ADPT_CTRL				0x174
+#define QSERDES_V5_5NM_RX_DFE_DAC_ENABLE1			0x178
+#define QSERDES_V5_5NM_RX_DFE_DAC_ENABLE2			0x17c
+#define QSERDES_V5_5NM_RX_TX_ADAPT_PRE_THRESH1			0x180
+#define QSERDES_V5_5NM_RX_TX_ADAPT_PRE_THRESH2			0x184
+#define QSERDES_V5_5NM_RX_TX_ADAPT_POST_THRESH1			0x188
+#define QSERDES_V5_5NM_RX_TX_ADAPT_POST_THRESH2			0x18c
+#define QSERDES_V5_5NM_RX_TX_ADAPT_MAIN_THRESH1			0x190
+#define QSERDES_V5_5NM_RX_TX_ADAPT_MAIN_THRESH2			0x194
+#define QSERDES_V5_5NM_RX_VGA_CAL_CNTRL1			0x198
+#define QSERDES_V5_5NM_RX_VGA_CAL_CNTRL2			0x19c
+#define QSERDES_V5_5NM_RX_VGA_CAL_MAN_VAL			0x1a0
+#define QSERDES_V5_5NM_RX_VTHRESH_CAL_CNTRL1			0x1a4
+#define QSERDES_V5_5NM_RX_VTHRESH_CAL_CNTRL2			0x1a8
+#define QSERDES_V5_5NM_RX_VTHRESH_CAL_MAN_VAL_RATE0		0x1ac
+#define QSERDES_V5_5NM_RX_VTHRESH_CAL_MAN_VAL_RATE1		0x1b0
+#define QSERDES_V5_5NM_RX_VTHRESH_CAL_MAN_VAL_RATE2		0x1b4
+#define QSERDES_V5_5NM_RX_VTHRESH_CAL_MAN_VAL_RATE3		0x1b8
+#define QSERDES_V5_5NM_RX_GM_CAL				0x1bc
+#define QSERDES_V5_5NM_RX_RX_VGA_GAIN2_BLK1			0x1c0
+#define QSERDES_V5_5NM_RX_RX_VGA_GAIN2_BLK2			0x1c4
+#define QSERDES_V5_5NM_RX_RX_EQU_ADAPTOR_CNTRL2			0x1c8
+#define QSERDES_V5_5NM_RX_RX_EQU_ADAPTOR_CNTRL3			0x1cc
+#define QSERDES_V5_5NM_RX_RX_EQU_ADAPTOR_CNTRL4			0x1d0
+#define QSERDES_V5_5NM_RX_RX_IDAC_TSETTLE_LOW			0x1d4
+#define QSERDES_V5_5NM_RX_RX_EQ_OFFSET_LSB			0x1d8
+#define QSERDES_V5_5NM_RX_RX_EQ_OFFSET_MSB			0x1dc
+#define QSERDES_V5_5NM_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1		0x1e0
+#define QSERDES_V5_5NM_RX_RX_OFFSET_ADAPTOR_CNTRL2		0x1e4
+#define QSERDES_V5_5NM_RX_SIGDET_ENABLES			0x1e8
+#define QSERDES_V5_5NM_RX_SIGDET_CNTRL				0x1ec
+#define QSERDES_V5_5NM_RX_SIGDET_LVL				0x1f0
+#define QSERDES_V5_5NM_RX_SIGDET_DEGLITCH_CNTRL			0x1f4
+#define QSERDES_V5_5NM_RX_CDR_FREEZE_UP_DN			0x1f8
+#define QSERDES_V5_5NM_RX_CDR_RESET_OVERRIDE			0x1fc
+#define QSERDES_V5_5NM_RX_RX_INTERFACE_MODE			0x200
+#define QSERDES_V5_5NM_RX_JITTER_GEN_MODE			0x204
+#define QSERDES_V5_5NM_RX_SJ_AMP1				0x208
+#define QSERDES_V5_5NM_RX_SJ_AMP2				0x20c
+#define QSERDES_V5_5NM_RX_SJ_PER1				0x210
+#define QSERDES_V5_5NM_RX_SJ_PER2				0x214
+#define QSERDES_V5_5NM_RX_PPM_OFFSET1				0x218
+#define QSERDES_V5_5NM_RX_PPM_OFFSET2				0x21c
+#define QSERDES_V5_5NM_RX_SIGN_PPM_PERIOD1			0x220
+#define QSERDES_V5_5NM_RX_SIGN_PPM_PERIOD2			0x224
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B0			0x228
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B1			0x22c
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B2			0x230
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B3			0x234
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B4			0x238
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B5			0x23c
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B6			0x240
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE_0_1_B7			0x244
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE2_B0			0x248
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE2_B1			0x24c
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE2_B2			0x250
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE2_B3			0x254
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE2_B4			0x258
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE2_B5			0x25c
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE2_B6			0x260
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE2_B7			0x264
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE3_B0			0x268
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE3_B1			0x26c
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE3_B2			0x270
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE3_B3			0x274
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE3_B4			0x278
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE3_B5			0x27c
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE3_B6			0x280
+#define QSERDES_V5_5NM_RX_RX_MODE_RATE3_B7			0x284
+#define QSERDES_V5_5NM_RX_PHPRE_CTRL				0x288
+#define QSERDES_V5_5NM_RX_PHPRE_INITVAL				0x28c
+#define QSERDES_V5_5NM_RX_DFE_EN_TIMER				0x290
+#define QSERDES_V5_5NM_RX_DFE_CTLE_POST_CAL_OFFSET		0x294
+#define QSERDES_V5_5NM_RX_DCC_CTRL1				0x298
+#define QSERDES_V5_5NM_RX_DCC_CTRL2				0x29c
+#define QSERDES_V5_5NM_RX_DCC_OFFSET				0x2a0
+#define QSERDES_V5_5NM_RX_DCC_CMUX_POSTCAL_OFFSET		0x2a4
+#define QSERDES_V5_5NM_RX_DCC_CMUX_CAL_CTRL1			0x2a8
+#define QSERDES_V5_5NM_RX_DCC_CMUX_CAL_CTRL2			0x2ac
+#define QSERDES_V5_5NM_RX_ALOG_OBSV_BUS_CTRL_1			0x2b0
+#define QSERDES_V5_5NM_RX_RX_MARG_CTRL1				0x2b4
+#define QSERDES_V5_5NM_RX_RX_MARG_CTRL2				0x2b8
+#define QSERDES_V5_5NM_RX_RX_MARG_CTRL3				0x2bc
+#define QSERDES_V5_5NM_RX_RX_MARG_CTRL_4			0x2c0
+#define QSERDES_V5_5NM_RX_RX_MARG_CFG_RATE_0_1			0x2c4
+#define QSERDES_V5_5NM_RX_RX_MARG_CFG_RATE_2_3			0x2c8
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_CTRL1			0x2cc
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_CTRL2			0x2d0
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH1_RATE210	0x2d4
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH1_RATE3		0x2d8
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH2_RATE210	0x2dc
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH2_RATE3		0x2e0
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH3_RATE210	0x2e4
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH3_RATE3		0x2e8
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH4_RATE210	0x2ec
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH4_RATE3		0x2f0
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH5_RATE210	0x2f4
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH5_RATE3		0x2f8
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH6_RATE210	0x2fc
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH6_RATE3		0x300
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH7_RATE210	0x304
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_THRESH7_RATE3		0x308
+#define QSERDES_V5_5NM_RX_Q_PI_INTRINSIC_BIAS_RATE10		0x30c
+#define QSERDES_V5_5NM_RX_Q_PI_INTRINSIC_BIAS_RATE32		0x310
+#define QSERDES_V5_5NM_RX_RX_MARG_VERTICAL_CTRL			0x314
+#define QSERDES_V5_5NM_RX_RX_MARG_VERTICAL_CODE			0x318
+#define QSERDES_V5_5NM_RX_RES_CODE_THRESH_HIGH_AND_BYP		0x31c
+#define QSERDES_V5_5NM_RX_RES_CODE_THRESH_LOW			0x320
+#define QSERDES_V5_5NM_RX_RX_BKUP_CTRL1				0x324
+#define QSERDES_V5_5NM_RX_RX_BKUP_CTRL2				0x328
+#define QSERDES_V5_5NM_RX_RX_BKUP_CTRL3				0x32c
+#define QSERDES_V5_5NM_RX_PI_CTRL1				0x330
+#define QSERDES_V5_5NM_RX_PI_CTRL2				0x334
+#define QSERDES_V5_5NM_RX_PI_QUAD				0x338
+#define QSERDES_V5_5NM_RX_QPI_CTRL1				0x33c
+#define QSERDES_V5_5NM_RX_QPI_CTRL2				0x340
+#define QSERDES_V5_5NM_RX_QPI_QUAD				0x344
+#define QSERDES_V5_5NM_RX_IDATA1				0x348
+#define QSERDES_V5_5NM_RX_IDATA2				0x34c
+#define QSERDES_V5_5NM_RX_IDATA3				0x350
+#define QSERDES_V5_5NM_RX_AC_JTAG_OUTP				0x354
+#define QSERDES_V5_5NM_RX_AC_JTAG_OUTN				0x358
+#define QSERDES_V5_5NM_RX_RX_SIGDET				0x35c
+#define QSERDES_V5_5NM_RX_ALOG_OBSV_BUS_STATUS_1		0x360
+#define QSERDES_V5_5NM_RX_READ_EQCODE				0x364
+#define QSERDES_V5_5NM_RX_READ_OFFSETCODE			0x368
+#define QSERDES_V5_5NM_RX_IA_ERROR_COUNTER_LOW			0x36c
+#define QSERDES_V5_5NM_RX_IA_ERROR_COUNTER_HIGH			0x370
+#define QSERDES_V5_5NM_RX_VGA_READ_CODE				0x374
+#define QSERDES_V5_5NM_RX_VTHRESH_READ_CODE			0x378
+#define QSERDES_V5_5NM_RX_DFE_TAP1_READ_CODE			0x37c
+#define QSERDES_V5_5NM_RX_DFE_TAP2_READ_CODE			0x380
+#define QSERDES_V5_5NM_RX_DFE_TAP3_READ_CODE			0x384
+#define QSERDES_V5_5NM_RX_DFE_TAP4_READ_CODE			0x388
+#define QSERDES_V5_5NM_RX_DFE_TAP5_READ_CODE			0x38c
+#define QSERDES_V5_5NM_RX_IDAC_STATUS_I0			0x390
+#define QSERDES_V5_5NM_RX_IDAC_STATUS_I0BAR			0x394
+#define QSERDES_V5_5NM_RX_IDAC_STATUS_I1			0x398
+#define QSERDES_V5_5NM_RX_IDAC_STATUS_I1BAR			0x39c
+#define QSERDES_V5_5NM_RX_IDAC_STATUS_Q				0x3a0
+#define QSERDES_V5_5NM_RX_IDAC_STATUS_QBAR			0x3a4
+#define QSERDES_V5_5NM_RX_IDAC_STATUS_A				0x3a8
+#define QSERDES_V5_5NM_RX_IDAC_STATUS_ABAR			0x3ac
+#define QSERDES_V5_5NM_RX_IDAC_STATUS_SM_ON			0x3b0
+#define QSERDES_V5_5NM_RX_IDAC_STATUS_SIGNERROR			0x3b4
+#define QSERDES_V5_5NM_RX_IVCM_CAL_STATUS			0x3b8
+#define QSERDES_V5_5NM_RX_IVCM_CAL_DEBUG_STATUS			0x3bc
+#define QSERDES_V5_5NM_RX_DCC_CAL_STATUS			0x3c0
+#define QSERDES_V5_5NM_RX_DCC_READ_CODE_STATUS			0x3c4
+#define QSERDES_V5_5NM_RX_RX_MARG_DEBUG1_STATUS			0x3c8
+#define QSERDES_V5_5NM_RX_RX_MARG_DEBUG2_STATUS			0x3cc
+#define QSERDES_V5_5NM_RX_RX_MARG_READ_CODE_STATUS		0x3d0
+#define QSERDES_V5_5NM_RX_EOM_ERR_CNT_LSB_STATUS		0x3d4
+#define QSERDES_V5_5NM_RX_EOM_ERR_CNT_MSB_STATUS		0x3d8
+#define QSERDES_V5_5NM_RX_RX_MARG_COARSE_TUNE_STATUS		0x3dc
+#define QSERDES_V5_5NM_RX_RX_BKUP_READ_BUS1_STATUS		0x3e0
+#define QSERDES_V5_5NM_RX_RX_BKUP_READ_BUS2_STATUS		0x3e4
+#define QSERDES_V5_5NM_RX_RX_BKUP_READ_BUS3_STATUS		0x3e8
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v6.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v6.h
index 23ffcfae9ef..f47fdc9cecd 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v6.h
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v6.h
@@ -6,6 +6,7 @@
 #ifndef QCOM_PHY_QMP_QSERDES_TXRX_USB_V6_H_
 #define QCOM_PHY_QMP_QSERDES_TXRX_USB_V6_H_
 
+#define QSERDES_V6_TX_BIST_MODE_LANENO				0x00
 #define QSERDES_V6_TX_CLKBUF_ENABLE				0x08
 #define QSERDES_V6_TX_TX_EMP_POST1_LVL				0x0c
 #define QSERDES_V6_TX_TX_DRV_LVL				0x14
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v6_n4.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v6_n4.h
new file mode 100644
index 00000000000..d37cc0d4fd3
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v6_n4.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_V6_N4_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_V6_N4_H_
+
+#define QSERDES_V6_N4_TX_CLKBUF_ENABLE			0x08
+#define QSERDES_V6_N4_TX_TX_EMP_POST1_LVL		0x0c
+#define QSERDES_V6_N4_TX_TX_DRV_LVL			0x14
+#define QSERDES_V6_N4_TX_RESET_TSYNC_EN			0x1c
+#define QSERDES_V6_N4_TX_PRE_STALL_LDO_BOOST_EN		0x20
+#define QSERDES_V6_N4_TX_RES_CODE_LANE_OFFSET_TX	0x30
+#define QSERDES_V6_N4_TX_RES_CODE_LANE_OFFSET_RX	0x34
+#define QSERDES_V6_N4_TX_TRANSCEIVER_BIAS_EN		0x48
+#define QSERDES_V6_N4_TX_HIGHZ_DRVR_EN			0x4c
+#define QSERDES_V6_N4_TX_TX_POL_INV			0x50
+#define QSERDES_V6_N4_TX_PARRATE_REC_DETECT_IDLE_EN	0x54
+#define QSERDES_V6_N4_TX_LANE_MODE_1			0x78
+#define QSERDES_V6_N4_TX_LANE_MODE_2			0x7c
+#define QSERDES_V6_N4_TX_LANE_MODE_3			0x80
+#define QSERDES_V6_N4_TX_TRAN_DRVR_EMP_EN		0xac
+#define QSERDES_V6_N4_TX_TX_BAND			0xd8
+#define QSERDES_V6_N4_TX_INTERFACE_SELECT		0xe4
+#define QSERDES_V6_N4_TX_VMODE_CTRL1			0xb0
+
+#define QSERDES_V6_N4_RX_UCDR_FO_GAIN_RATE2		0x8
+#define QSERDES_V6_N4_RX_UCDR_SO_GAIN_RATE2		0x18
+#define QSERDES_V6_N4_RX_UCDR_PI_CONTROLS		0x20
+#define QSERDES_V6_N4_RX_IVCM_CAL_CODE_OVERRIDE		0x94
+#define QSERDES_V6_N4_RX_RX_IVCM_CAL_CTRL2		0x9c
+#define QSERDES_V6_N4_RX_RX_IVCM_POSTCAL_OFFSET		0xa0
+#define QSERDES_V6_N4_RX_DFE_3				0xb4
+#define QSERDES_V6_N4_RX_VGA_CAL_CNTRL1			0xe0
+#define QSERDES_V6_N4_RX_VGA_CAL_MAN_VAL		0xe8
+#define QSERDES_V6_N4_RX_GM_CAL				0x10c
+#define QSERDES_V6_N4_RX_SIGDET_ENABLES			0x148
+#define QSERDES_V6_N4_RX_SIGDET_CNTRL			0x14c
+#define QSERDES_V6_N4_RX_SIGDET_DEGLITCH_CNTRL		0x154
+#define QSERDES_V6_N4_RX_DFE_CTLE_POST_CAL_OFFSET	0x194
+#define QSERDES_V6_N4_RX_Q_PI_INTRINSIC_BIAS_RATE32	0x1dc
+#define QSERDES_V6_N4_RX_UCDR_PI_CTRL1			0x23c
+#define QSERDES_V6_N4_RX_UCDR_PI_CTRL2			0x240
+#define QSERDES_V6_N4_RX_UCDR_SB2_GAIN2_RATE2		0x27c
+#define QSERDES_V6_N4_RX_DFE_DAC_ENABLE1		0x298
+#define QSERDES_V6_N4_RX_MODE_RATE_0_1_B0		0x2b8
+#define QSERDES_V6_N4_RX_MODE_RATE_0_1_B1		0x2bc
+#define QSERDES_V6_N4_RX_MODE_RATE_0_1_B2		0x2c0
+#define QSERDES_V6_N4_RX_MODE_RATE_0_1_B3		0x2c4
+#define QSERDES_V6_N4_RX_MODE_RATE_0_1_B4		0x2c8
+#define QSERDES_V6_N4_RX_MODE_RATE_0_1_B5		0x2cc
+#define QSERDES_V6_N4_RX_MODE_RATE_0_1_B6		0x2d0
+#define QSERDES_V6_N4_RX_MODE_RATE2_B0			0x2d4
+#define QSERDES_V6_N4_RX_MODE_RATE2_B1			0x2d8
+#define QSERDES_V6_N4_RX_MODE_RATE2_B2			0x2dc
+#define QSERDES_V6_N4_RX_MODE_RATE2_B3			0x2e0
+#define QSERDES_V6_N4_RX_MODE_RATE2_B4			0x2e4
+#define QSERDES_V6_N4_RX_MODE_RATE2_B5			0x2e8
+#define QSERDES_V6_N4_RX_MODE_RATE2_B6			0x2ec
+#define QSERDES_V6_N4_RX_RX_SUMMER_CAL_SPD_MODE		0x30c
+#define QSERDES_V6_N4_RX_RX_BKUP_CTRL1			0x310
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v7.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v7.h
new file mode 100644
index 00000000000..6ab943ff57f
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v7.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_V7_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_V7_H_
+
+#define QSERDES_V7_TX_CLKBUF_ENABLE				0x08
+#define QSERDES_V7_TX_RESET_TSYNC_EN				0x1c
+#define QSERDES_V7_TX_PRE_STALL_LDO_BOOST_EN			0x20
+#define QSERDES_V7_TX_TX_BAND					0x24
+#define QSERDES_V7_TX_INTERFACE_SELECT				0x2c
+#define QSERDES_V7_TX_RES_CODE_LANE_TX				0x34
+#define QSERDES_V7_TX_RES_CODE_LANE_RX				0x38
+#define QSERDES_V7_TX_RES_CODE_LANE_OFFSET_TX			0x3c
+#define QSERDES_V7_TX_RES_CODE_LANE_OFFSET_RX			0x40
+#define QSERDES_V7_TX_PARRATE_REC_DETECT_IDLE_EN		0x60
+#define QSERDES_V7_TX_BIST_PATTERN7				0x7c
+#define QSERDES_V7_TX_LANE_MODE_1				0x84
+#define QSERDES_V7_TX_LANE_MODE_2				0x88
+#define QSERDES_V7_TX_LANE_MODE_3				0x8c
+#define QSERDES_V7_TX_LANE_MODE_4				0x90
+#define QSERDES_V7_TX_LANE_MODE_5				0x94
+#define QSERDES_V7_TX_RCV_DETECT_LVL_2				0xa4
+#define QSERDES_V7_TX_TRAN_DRVR_EMP_EN				0xc0
+#define QSERDES_V7_TX_TX_INTERFACE_MODE				0xc4
+#define QSERDES_V7_TX_VMODE_CTRL1				0xc8
+#define QSERDES_V7_TX_PI_QEC_CTRL				0xe4
+
+#define QSERDES_V7_RX_UCDR_FO_GAIN				0x08
+#define QSERDES_V7_RX_UCDR_SO_GAIN				0x14
+#define QSERDES_V7_RX_UCDR_FASTLOCK_FO_GAIN			0x30
+#define QSERDES_V7_RX_UCDR_SO_SATURATION_AND_ENABLE		0x34
+#define QSERDES_V7_RX_UCDR_FASTLOCK_COUNT_LOW			0x3c
+#define QSERDES_V7_RX_UCDR_FASTLOCK_COUNT_HIGH			0x40
+#define QSERDES_V7_RX_UCDR_PI_CONTROLS				0x44
+#define QSERDES_V7_RX_UCDR_SB2_THRESH1				0x4c
+#define QSERDES_V7_RX_UCDR_SB2_THRESH2				0x50
+#define QSERDES_V7_RX_UCDR_SB2_GAIN1				0x54
+#define QSERDES_V7_RX_UCDR_SB2_GAIN2				0x58
+#define QSERDES_V7_RX_AUX_DATA_TCOARSE_TFINE			0x60
+#define QSERDES_V7_RX_TX_ADAPT_PRE_THRESH1			0xc4
+#define QSERDES_V7_RX_TX_ADAPT_PRE_THRESH2			0xc8
+#define QSERDES_V7_RX_TX_ADAPT_POST_THRESH			0xcc
+#define QSERDES_V7_RX_VGA_CAL_CNTRL1				0xd4
+#define QSERDES_V7_RX_VGA_CAL_CNTRL2				0xd8
+#define QSERDES_V7_RX_GM_CAL					0xdc
+#define QSERDES_V7_RX_RX_EQU_ADAPTOR_CNTRL2			0xec
+#define QSERDES_V7_RX_RX_EQU_ADAPTOR_CNTRL3			0xf0
+#define QSERDES_V7_RX_RX_EQU_ADAPTOR_CNTRL4			0xf4
+#define QSERDES_V7_RX_RX_IDAC_TSETTLE_LOW			0xf8
+#define QSERDES_V7_RX_RX_IDAC_TSETTLE_HIGH			0xfc
+#define QSERDES_V7_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1		0x110
+#define QSERDES_V7_RX_SIGDET_ENABLES				0x118
+#define QSERDES_V7_RX_SIGDET_CNTRL				0x11c
+#define QSERDES_V7_RX_SIGDET_DEGLITCH_CNTRL			0x124
+#define QSERDES_V7_RX_RX_MODE_00_LOW				0x15c
+#define QSERDES_V7_RX_RX_MODE_00_HIGH				0x160
+#define QSERDES_V7_RX_RX_MODE_00_HIGH2				0x164
+#define QSERDES_V7_RX_RX_MODE_00_HIGH3				0x168
+#define QSERDES_V7_RX_RX_MODE_00_HIGH4				0x16c
+#define QSERDES_V7_RX_RX_MODE_01_LOW				0x170
+#define QSERDES_V7_RX_RX_MODE_01_HIGH				0x174
+#define QSERDES_V7_RX_RX_MODE_01_HIGH2				0x178
+#define QSERDES_V7_RX_RX_MODE_01_HIGH3				0x17c
+#define QSERDES_V7_RX_RX_MODE_01_HIGH4				0x180
+#define QSERDES_V7_RX_RX_MODE_10_LOW				0x184
+#define QSERDES_V7_RX_RX_MODE_10_HIGH				0x188
+#define QSERDES_V7_RX_RX_MODE_10_HIGH2				0x18c
+#define QSERDES_V7_RX_RX_MODE_10_HIGH3				0x190
+#define QSERDES_V7_RX_RX_MODE_10_HIGH4				0x194
+#define QSERDES_V7_RX_DFE_EN_TIMER				0x1a0
+#define QSERDES_V7_RX_DFE_CTLE_POST_CAL_OFFSET			0x1a4
+#define QSERDES_V7_RX_DCC_CTRL1					0x1a8
+#define QSERDES_V7_RX_VTH_CODE					0x1b0
+#define QSERDES_V7_RX_SIGDET_CAL_CTRL1				0x1e4
+#define QSERDES_V7_RX_SIGDET_CAL_TRIM				0x1f8
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v8.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v8.h
new file mode 100644
index 00000000000..4cb8b170860
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v8.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_V8_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_V8_H_
+
+#define QSERDES_V8_TX_TX_EMP_POST1_LVL			0x00c
+#define QSERDES_V8_TX_TX_DRV_LVL			0x014
+#define QSERDES_V8_TX_RES_CODE_LANE_TX			0x034
+#define QSERDES_V8_TX_RES_CODE_LANE_RX			0x038
+#define QSERDES_V8_TX_RES_CODE_LANE_OFFSET_TX		0x03c
+#define QSERDES_V8_TX_RES_CODE_LANE_OFFSET_RX		0x040
+#define QSERDES_V8_TX_TRANSCEIVER_BIAS_EN		0x054
+#define QSERDES_V8_TX_HIGHZ_DRVR_EN			0x058
+#define QSERDES_V8_TX_TX_POL_INV			0x05c
+#define QSERDES_V8_TX_LANE_MODE_1			0x084
+#define QSERDES_V8_TX_LANE_MODE_2			0x088
+#define QSERDES_V8_TX_LANE_MODE_3			0x08c
+#define QSERDES_V8_TX_LANE_MODE_4			0x090
+#define QSERDES_V8_TX_LANE_MODE_5			0x094
+#define QSERDES_V8_TX_RCV_DETECT_LVL_2			0x0a4
+#define QSERDES_V8_TX_PI_QEC_CTRL			0x0e4
+
+#define QSERDES_V8_RX_UCDR_FO_GAIN			0x008
+#define QSERDES_V8_RX_UCDR_SO_GAIN			0x014
+#define QSERDES_V8_RX_UCDR_SVS_FO_GAIN			0x020
+#define QSERDES_V8_RX_UCDR_FASTLOCK_FO_GAIN		0x030
+#define QSERDES_V8_RX_UCDR_SO_SATURATION_AND_ENABLE	0x034
+#define QSERDES_V8_RX_UCDR_FASTLOCK_COUNT_LOW		0x03c
+#define QSERDES_V8_RX_UCDR_FASTLOCK_COUNT_HIGH		0x040
+#define QSERDES_V8_RX_UCDR_PI_CONTROLS			0x044
+#define QSERDES_V8_RX_UCDR_SB2_THRESH1			0x04c
+#define QSERDES_V8_RX_UCDR_SB2_THRESH2			0x050
+#define QSERDES_V8_RX_UCDR_SB2_GAIN1			0x054
+#define QSERDES_V8_RX_UCDR_SB2_GAIN2			0x058
+#define QSERDES_V8_RX_AUX_DATA_TCOARSE_TFINE		0x060
+#define QSERDES_V8_RX_VGA_CAL_CNTRL1			0x0d4
+#define QSERDES_V8_RX_VGA_CAL_CNTRL2			0x0d8
+#define QSERDES_V8_RX_GM_CAL				0x0dc
+#define QSERDES_V8_RX_RX_EQU_ADAPTOR_CNTRL2		0x0ec
+#define QSERDES_V8_RX_RX_EQU_ADAPTOR_CNTRL3		0x0f0
+#define QSERDES_V8_RX_RX_EQU_ADAPTOR_CNTRL4		0x0f4
+#define QSERDES_V8_RX_RX_IDAC_TSETTLE_LOW		0x0f8
+#define QSERDES_V8_RX_RX_IDAC_TSETTLE_HIGH		0x0fc
+#define QSERDES_V8_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1	0x110
+#define QSERDES_V8_RX_SIGDET_ENABLES			0x118
+#define QSERDES_V8_RX_SIGDET_CNTRL			0x11c
+#define QSERDES_V8_RX_SIGDET_DEGLITCH_CNTRL		0x124
+#define QSERDES_V8_RX_RX_MODE_00_LOW			0x15c
+#define QSERDES_V8_RX_RX_MODE_00_HIGH			0x160
+#define QSERDES_V8_RX_RX_MODE_00_HIGH2			0x164
+#define QSERDES_V8_RX_RX_MODE_00_HIGH3			0x168
+#define QSERDES_V8_RX_RX_MODE_00_HIGH4			0x16c
+#define QSERDES_V8_RX_RX_MODE_01_LOW			0x170
+#define QSERDES_V8_RX_RX_MODE_01_HIGH			0x174
+#define QSERDES_V8_RX_RX_MODE_01_HIGH2			0x178
+#define QSERDES_V8_RX_RX_MODE_01_HIGH3			0x17c
+#define QSERDES_V8_RX_RX_MODE_01_HIGH4			0x180
+#define QSERDES_V8_RX_DFE_EN_TIMER			0x1a0
+#define QSERDES_V8_RX_DFE_CTLE_POST_CAL_OFFSET		0x1a4
+#define QSERDES_V8_RX_DCC_CTRL1				0x1a8
+#define QSERDES_V8_RX_VTH_CODE				0x1b0
+#define QSERDES_V8_RX_SIGDET_CAL_CTRL1			0x1e4
+#define QSERDES_V8_RX_SIGDET_CAL_TRIM			0x1f8
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
index 3df88189a90..2fad38bf5d1 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
@@ -814,83 +814,83 @@ static const struct qmp_ufs_init_tbl sc7280_ufsphy_hs_g4_rx[] = {
 };
 
 static const struct qmp_ufs_init_tbl sm6115_ufsphy_serdes[] = {
-	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x0e),
-	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x14),
-	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
-	QMP_PHY_INIT_CFG(QSERDES_COM_SYS_CLK_CTRL, 0x02),
-	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
-	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TIMER, 0x0a),
-	QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x00),
-	QMP_PHY_INIT_CFG(QSERDES_COM_CORECLK_DIV, 0x0a),
-	QMP_PHY_INIT_CFG(QSERDES_COM_CORECLK_DIV_MODE1, 0x0a),
-	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_EN, 0x01),
-	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_CTRL, 0x00),
-	QMP_PHY_INIT_CFG(QSERDES_COM_RESETSM_CNTRL, 0x20),
-	QMP_PHY_INIT_CFG(QSERDES_COM_CORE_CLK_EN, 0x00),
-	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP_CFG, 0x00),
-	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_TIMER1, 0xff),
-	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_TIMER2, 0x3f),
-	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x04),
-	QMP_PHY_INIT_CFG(QSERDES_COM_SVS_MODE_CLK_SEL, 0x05),
-	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x82),
-	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0x00),
-	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0x00),
-	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x00),
-	QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE0, 0x0b),
-	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
-	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE0, 0x28),
-	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE0, 0x80),
-	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
-	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE1_MODE0, 0x28),
-	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE2_MODE0, 0x02),
-	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0xff),
-	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x0c),
-	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
-	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE1, 0x98),
-	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE1, 0x00),
-	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE1, 0x00),
-	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE1, 0x00),
-	QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE1, 0x0b),
-	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE1, 0x16),
-	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE1, 0x28),
-	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE1, 0x80),
-	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN1_MODE1, 0x00),
-	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE1_MODE1, 0xd6),
-	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE2_MODE1, 0x00),
-	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE1, 0x32),
-	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE1, 0x0f),
-	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE1, 0x00),
-	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_IVCO, 0x0f),
-	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TRIM, 0x0f),
-	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_INITVAL1, 0xff),
-	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_INITVAL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CMN_CONFIG, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SYSCLK_EN_SEL, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CLK_SELECT, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SYS_CLK_CTRL, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_BG_TIMER, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_HSCLK_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CORECLK_DIV, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CORECLK_DIV_MODE1, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP_EN, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_VCO_TUNE_CTRL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_RESETSM_CNTRL, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CORE_CLK_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP_CFG, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_VCO_TUNE_TIMER1, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_VCO_TUNE_TIMER2, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_VCO_TUNE_MAP, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SVS_MODE_CLK_SEL, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DIV_FRAC_START1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DIV_FRAC_START2_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DIV_FRAC_START3_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CP_CTRL_MODE0, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_PLL_CCTRL_MODE0, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_INTEGLOOP_GAIN0_MODE0, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_VCO_TUNE1_MODE0, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_VCO_TUNE2_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP1_MODE0, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP2_MODE0, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP3_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DEC_START_MODE1, 0x98),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DIV_FRAC_START1_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DIV_FRAC_START2_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DIV_FRAC_START3_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CP_CTRL_MODE1, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_PLL_CCTRL_MODE1, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_INTEGLOOP_GAIN0_MODE1, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_INTEGLOOP_GAIN1_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_VCO_TUNE1_MODE1, 0xd6),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_VCO_TUNE2_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP1_MODE1, 0x32),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP2_MODE1, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP3_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_BG_TRIM, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_VCO_TUNE_INITVAL1, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_VCO_TUNE_INITVAL2, 0x00),
 };
 
 static const struct qmp_ufs_init_tbl sm6115_ufsphy_hs_b_serdes[] = {
-	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x44),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_VCO_TUNE_MAP, 0x44),
 };
 
 static const struct qmp_ufs_init_tbl sm6115_ufsphy_tx[] = {
-	QMP_PHY_INIT_CFG(QSERDES_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN, 0x45),
-	QMP_PHY_INIT_CFG(QSERDES_TX_LANE_MODE, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN, 0x45),
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_LANE_MODE, 0x06),
 };
 
 static const struct qmp_ufs_init_tbl sm6115_ufsphy_rx[] = {
-	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_LVL, 0x24),
-	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_CNTRL, 0x0f),
-	QMP_PHY_INIT_CFG(QSERDES_RX_RX_INTERFACE_MODE, 0x40),
-	QMP_PHY_INIT_CFG(QSERDES_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
-	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
-	QMP_PHY_INIT_CFG(QSERDES_RX_RX_TERM_BW, 0x5b),
-	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQ_GAIN1_LSB, 0xff),
-	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQ_GAIN1_MSB, 0x3f),
-	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQ_GAIN2_LSB, 0xff),
-	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQ_GAIN2_MSB, 0x3f),
-	QMP_PHY_INIT_CFG(QSERDES_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0d),
-	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SVS_SO_GAIN_HALF, 0x04),
-	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SVS_SO_GAIN_QUARTER, 0x04),
-	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SVS_SO_GAIN, 0x04),
-	QMP_PHY_INIT_CFG(QSERDES_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5b),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_SIGDET_LVL, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_SIGDET_CNTRL, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_INTERFACE_MODE, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_TERM_BW, 0x5b),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_EQ_GAIN1_LSB, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_EQ_GAIN1_MSB, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_EQ_GAIN2_LSB, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_EQ_GAIN2_MSB, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_UCDR_SVS_SO_GAIN_HALF, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_UCDR_SVS_SO_GAIN_QUARTER, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_UCDR_SVS_SO_GAIN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5b),
 };
 
 static const struct qmp_ufs_init_tbl sm6115_ufsphy_pcs[] = {
diff --git a/drivers/phy/qcom/phy-qcom-qmp-usb.c b/drivers/phy/qcom/phy-qcom-qmp-usb.c
new file mode 100644
index 00000000000..6f05f556dd6
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-usb.c
@@ -0,0 +1,2198 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#include <clk.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <generic-phy.h>
+#include <malloc.h>
+#include <reset.h>
+
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <linux/ioport.h>
+
+#include "phy-qcom-qmp-common.h"
+
+#include "phy-qcom-qmp.h"
+#include "phy-qcom-qmp-pcs-misc-v3.h"
+#include "phy-qcom-qmp-pcs-misc-v4.h"
+#include "phy-qcom-qmp-pcs-usb-v4.h"
+#include "phy-qcom-qmp-pcs-usb-v5.h"
+#include "phy-qcom-qmp-pcs-usb-v6.h"
+#include "phy-qcom-qmp-pcs-usb-v7.h"
+#include "phy-qcom-qmp-pcs-usb-v8.h"
+
+#define PHY_INIT_COMPLETE_TIMEOUT		10000
+
+/* set of registers with offsets different per-PHY */
+enum qphy_reg_layout {
+	/* PCS registers */
+	QPHY_SW_RESET,
+	QPHY_START_CTRL,
+	QPHY_PCS_STATUS,
+	QPHY_PCS_AUTONOMOUS_MODE_CTRL,
+	QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR,
+	QPHY_PCS_POWER_DOWN_CONTROL,
+	QPHY_PCS_MISC_CLAMP_ENABLE,
+	/* Keep last to ensure regs_layout arrays are properly initialized */
+	QPHY_LAYOUT_SIZE
+};
+
+static const unsigned int qmp_v2_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_SW_RESET]			= QPHY_V2_PCS_SW_RESET,
+	[QPHY_START_CTRL]		= QPHY_V2_PCS_START_CONTROL,
+	[QPHY_PCS_STATUS]		= QPHY_V2_PCS_USB_PCS_STATUS,
+	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V2_PCS_AUTONOMOUS_MODE_CTRL,
+	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V2_PCS_LFPS_RXTERM_IRQ_CLEAR,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V2_PCS_POWER_DOWN_CONTROL,
+};
+
+static const unsigned int qmp_v3_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_SW_RESET]			= QPHY_V3_PCS_SW_RESET,
+	[QPHY_START_CTRL]		= QPHY_V3_PCS_START_CONTROL,
+	[QPHY_PCS_STATUS]		= QPHY_V3_PCS_PCS_STATUS,
+	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V3_PCS_AUTONOMOUS_MODE_CTRL,
+	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V3_PCS_LFPS_RXTERM_IRQ_CLEAR,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V3_PCS_POWER_DOWN_CONTROL,
+	[QPHY_PCS_MISC_CLAMP_ENABLE]	= QPHY_V3_PCS_MISC_CLAMP_ENABLE,
+};
+
+static const unsigned int qmp_v4_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_SW_RESET]			= QPHY_V4_PCS_SW_RESET,
+	[QPHY_START_CTRL]		= QPHY_V4_PCS_START_CONTROL,
+	[QPHY_PCS_STATUS]		= QPHY_V4_PCS_PCS_STATUS1,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V4_PCS_POWER_DOWN_CONTROL,
+
+	/* In PCS_USB */
+	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V4_PCS_USB3_AUTONOMOUS_MODE_CTRL,
+	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V4_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
+	[QPHY_PCS_MISC_CLAMP_ENABLE]	= QPHY_V4_PCS_MISC_CLAMP_ENABLE,
+};
+
+static const unsigned int qmp_v5_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_SW_RESET]			= QPHY_V5_PCS_SW_RESET,
+	[QPHY_START_CTRL]		= QPHY_V5_PCS_START_CONTROL,
+	[QPHY_PCS_STATUS]		= QPHY_V5_PCS_PCS_STATUS1,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V5_PCS_POWER_DOWN_CONTROL,
+
+	/* In PCS_USB */
+	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL,
+	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
+};
+
+static const unsigned int qmp_v6_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_SW_RESET]			= QPHY_V6_PCS_SW_RESET,
+	[QPHY_START_CTRL]		= QPHY_V6_PCS_START_CONTROL,
+	[QPHY_PCS_STATUS]		= QPHY_V6_PCS_PCS_STATUS1,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_PCS_POWER_DOWN_CONTROL,
+
+	/* In PCS_USB */
+	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL,
+	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
+};
+
+static const unsigned int qmp_v7_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_SW_RESET]			= QPHY_V7_PCS_SW_RESET,
+	[QPHY_START_CTRL]		= QPHY_V7_PCS_START_CONTROL,
+	[QPHY_PCS_STATUS]		= QPHY_V7_PCS_PCS_STATUS1,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V7_PCS_POWER_DOWN_CONTROL,
+
+	/* In PCS_USB */
+	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V7_PCS_USB3_AUTONOMOUS_MODE_CTRL,
+	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V7_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
+};
+
+static const struct qmp_phy_init_tbl glymur_usb3_uniphy_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_SSC_STEP_SIZE1_MODE1, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_SSC_STEP_SIZE2_MODE1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_CP_CTRL_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_CORECLK_DIV_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_LOCK_CMP1_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_LOCK_CMP2_MODE1, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_DEC_START_MODE1, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_DEC_START_MSB_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_DIV_FRAC_START1_MODE1, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_DIV_FRAC_START2_MODE1, 0x75),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_DIV_FRAC_START3_MODE1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_HSCLK_SEL_1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_VCO_TUNE1_MODE1, 0x25),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_VCO_TUNE2_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0x5c),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0x5c),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_SSC_STEP_SIZE1_MODE0, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_SSC_STEP_SIZE2_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_CP_CTRL_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_LOCK_CMP1_MODE0, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_LOCK_CMP2_MODE0, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_DEC_START_MODE0, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_DEC_START_MSB_MODE0, 0x00),
+
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_DIV_FRAC_START1_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_DIV_FRAC_START2_MODE0, 0x75),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_DIV_FRAC_START3_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_VCO_TUNE1_MODE0, 0x25),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_VCO_TUNE2_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_BG_TIMER, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_SSC_PER1, 0x62),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_SSC_PER2, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_SYSCLK_BUF_ENABLE, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_SYSCLK_EN_SEL, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_LOCK_CMP_CFG, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_VCO_TUNE_MAP, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_CORE_CLK_EN, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_CMN_CONFIG_1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_AUTO_GAIN_ADJ_CTRL_1, 0xb6),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_AUTO_GAIN_ADJ_CTRL_2, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_AUTO_GAIN_ADJ_CTRL_3, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_ADDITIONAL_MISC, 0x0c),
+};
+
+static const struct qmp_phy_init_tbl glymur_usb3_uniphy_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_LOCK_DETECT_CONFIG1, 0xc4),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_LOCK_DETECT_CONFIG2, 0x89),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_LOCK_DETECT_CONFIG3, 0x20),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_LOCK_DETECT_CONFIG6, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_REFGEN_REQ_CONFIG1, 0x21),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_RX_SIGDET_LVL, 0x55),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_CDR_RESET_TIME, 0x0a),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_ALIGN_DETECT_CONFIG1, 0xd4),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_ALIGN_DETECT_CONFIG2, 0x30),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_PCS_TX_RX_CONFIG, 0x0c),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_EQ_CONFIG1, 0x4b),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_EQ_CONFIG5, 0x10),
+};
+
+static const struct qmp_phy_init_tbl glymur_usb3_uniphy_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V8_TX_RES_CODE_LANE_TX, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V8_TX_RES_CODE_LANE_RX, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V8_TX_RES_CODE_LANE_OFFSET_TX, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V8_TX_RES_CODE_LANE_OFFSET_RX, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V8_TX_LANE_MODE_1, 0xf5),
+	QMP_PHY_INIT_CFG(QSERDES_V8_TX_LANE_MODE_3, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V8_TX_LANE_MODE_4, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V8_TX_LANE_MODE_5, 0x5f),
+	QMP_PHY_INIT_CFG(QSERDES_V8_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V8_TX_PI_QEC_CTRL, 0x21),
+};
+
+static const struct qmp_phy_init_tbl glymur_usb3_uniphy_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_FO_GAIN, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_SO_GAIN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_PI_CONTROLS, 0x99),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_SB2_THRESH1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_SB2_GAIN1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_SB2_GAIN2, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_AUX_DATA_TCOARSE_TFINE, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_VGA_CAL_CNTRL1, 0x54),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_VGA_CAL_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_GM_CAL, 0x1b),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_IDAC_TSETTLE_LOW, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x27),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_SIGDET_ENABLES, 0x0c),
+
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_SIGDET_CNTRL, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_MODE_00_LOW, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_MODE_00_HIGH, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_MODE_00_HIGH2, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_MODE_00_HIGH3, 0xdf),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_MODE_00_HIGH4, 0xed),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_MODE_01_LOW, 0x19),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_MODE_01_HIGH, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_MODE_01_HIGH2, 0x91),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_MODE_01_HIGH3, 0xb7),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_MODE_01_HIGH4, 0xaa),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_DFE_EN_TIMER, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_DCC_CTRL1, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_VTH_CODE, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_SIGDET_CAL_CTRL1, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_SIGDET_CAL_TRIM, 0x08),
+};
+
+static const struct qmp_phy_init_tbl glymur_usb3_uniphy_pcs_usb_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_USB_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_USB_RXEQTRAINING_DFE_TIME_S2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_USB_RXEQTRAINING_WAIT_TIME, 0x75),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_USB_RCVR_DTCT_DLY_U3_L, 0x40),
+};
+
+static const struct qmp_phy_init_tbl ipq9574_usb3_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SYSCLK_EN_SEL, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CLK_SELECT, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_BG_TRIM, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SVS_MODE_CLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_HSCLK_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CMN_CONFIG, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SYS_CLK_CTRL, 0x06),
+	/* PLL and Loop filter settings */
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DEC_START_MODE0, 0x68),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DIV_FRAC_START1_MODE0, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DIV_FRAC_START2_MODE0, 0xaa),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DIV_FRAC_START3_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CP_CTRL_MODE0, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_PLL_CCTRL_MODE0, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_INTEGLOOP_GAIN0_MODE0, 0xa0),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP1_MODE0, 0xaa),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP2_MODE0, 0x29),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP3_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CORE_CLK_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP_CFG, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_VCO_TUNE_MAP, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_BG_TIMER, 0x0a),
+	/* SSC settings */
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_PER1, 0x7d),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_ADJ_PER1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_ADJ_PER2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_STEP_SIZE1, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_STEP_SIZE2, 0x05),
+};
+
+static const struct qmp_phy_init_tbl ipq9574_usb3_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN, 0x45),
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_LANE_MODE, 0x06),
+};
+
+static const struct qmp_phy_init_tbl ipq9574_usb3_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_UCDR_SO_GAIN, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_EQU_ADAPTOR_CNTRL2, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_EQU_ADAPTOR_CNTRL3, 0x6c),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4c),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_EQU_ADAPTOR_CNTRL4, 0xb8),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_SIGDET_CNTRL, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_SIGDET_DEGLITCH_CNTRL, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_SIGDET_ENABLES, 0x0c),
+};
+
+static const struct qmp_phy_init_tbl ipq9574_usb3_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0e),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL2, 0x83),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL1, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_L, 0x09),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_H_TOL, 0xa2),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_MAN_CODE, 0x85),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG1, 0xd1),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG2, 0x1f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG3, 0x47),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_POWER_STATE_CONFIG2, 0x1b),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_WAIT_TIME, 0x75),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LFPS_TX_ECSTART_EQTLOCK, 0x86),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TSYNC_RSYNC_TIME, 0x44),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_L, 0x40),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_H, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0x88),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x17),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0f),
+};
+
+static const struct qmp_phy_init_tbl ipq8074_usb3_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SYSCLK_EN_SEL, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CLK_SELECT, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_BG_TRIM, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SVS_MODE_CLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_HSCLK_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CMN_CONFIG, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SYS_CLK_CTRL, 0x06),
+	/* PLL and Loop filter settings */
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DIV_FRAC_START1_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DIV_FRAC_START2_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DIV_FRAC_START3_MODE0, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CP_CTRL_MODE0, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_PLL_CCTRL_MODE0, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_INTEGLOOP_GAIN0_MODE0, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP1_MODE0, 0x15),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP2_MODE0, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP3_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CORE_CLK_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP_CFG, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_VCO_TUNE_MAP, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_BG_TIMER, 0x0a),
+	/* SSC settings */
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_ADJ_PER1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_ADJ_PER2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_STEP_SIZE1, 0xde),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_STEP_SIZE2, 0x07),
+};
+
+static const struct qmp_phy_init_tbl ipq8074_usb3_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_UCDR_SO_GAIN, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_EQU_ADAPTOR_CNTRL2, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4c),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_EQU_ADAPTOR_CNTRL4, 0xb8),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_SIGDET_CNTRL, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_SIGDET_DEGLITCH_CNTRL, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_SIGDET_ENABLES, 0x0),
+};
+
+static const struct qmp_phy_init_tbl ipq8074_usb3_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0e),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL2, 0x83),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL1, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_L, 0x09),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_H_TOL, 0xa2),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_MAN_CODE, 0x85),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG1, 0xd1),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG2, 0x1f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG3, 0x47),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_POWER_STATE_CONFIG2, 0x1b),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_WAIT_TIME, 0x75),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LFPS_TX_ECSTART_EQTLOCK, 0x86),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TSYNC_RSYNC_TIME, 0x44),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_L, 0x40),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_H, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0x88),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x17),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0f),
+};
+
+static const struct qmp_phy_init_tbl msm8996_usb3_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SYSCLK_EN_SEL, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CLK_SELECT, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CMN_CONFIG, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SVS_MODE_CLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_HSCLK_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_BG_TRIM, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SYS_CLK_CTRL, 0x04),
+	/* PLL and Loop filter settings */
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DIV_FRAC_START1_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DIV_FRAC_START2_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_DIV_FRAC_START3_MODE0, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CP_CTRL_MODE0, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_PLL_CCTRL_MODE0, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_INTEGLOOP_GAIN0_MODE0, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_VCO_TUNE_CTRL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP1_MODE0, 0x15),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP2_MODE0, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP3_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_CORE_CLK_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_LOCK_CMP_CFG, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_VCO_TUNE_MAP, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_BG_TIMER, 0x0a),
+	/* SSC settings */
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_ADJ_PER1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_ADJ_PER2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_STEP_SIZE1, 0xde),
+	QMP_PHY_INIT_CFG(QSERDES_V2_COM_SSC_STEP_SIZE2, 0x07),
+};
+
+static const struct qmp_phy_init_tbl msm8996_usb3_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN, 0x45),
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_LANE_MODE, 0x06),
+};
+
+static const struct qmp_phy_init_tbl msm8996_usb3_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_UCDR_SO_GAIN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_EQU_ADAPTOR_CNTRL2, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4c),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_EQU_ADAPTOR_CNTRL4, 0xbb),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_SIGDET_CNTRL, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_SIGDET_LVL, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V2_RX_SIGDET_DEGLITCH_CNTRL, 0x16),
+};
+
+static const struct qmp_phy_init_tbl msm8996_usb3_pcs_tbl[] = {
+	/* FLL settings */
+	QMP_PHY_INIT_CFG(QPHY_V2_PCS_FLL_CNTRL2, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V2_PCS_FLL_CNTRL1, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V2_PCS_FLL_CNT_VAL_L, 0x09),
+	QMP_PHY_INIT_CFG(QPHY_V2_PCS_FLL_CNT_VAL_H_TOL, 0x42),
+	QMP_PHY_INIT_CFG(QPHY_V2_PCS_FLL_MAN_CODE, 0x85),
+
+	/* Lock Det settings */
+	QMP_PHY_INIT_CFG(QPHY_V2_PCS_LOCK_DETECT_CONFIG1, 0xd1),
+	QMP_PHY_INIT_CFG(QPHY_V2_PCS_LOCK_DETECT_CONFIG2, 0x1f),
+	QMP_PHY_INIT_CFG(QPHY_V2_PCS_LOCK_DETECT_CONFIG3, 0x47),
+	QMP_PHY_INIT_CFG(QPHY_V2_PCS_POWER_STATE_CONFIG2, 0x08),
+};
+
+static const struct qmp_phy_init_tbl qdu1000_usb3_uniphy_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG1, 0xc4),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG2, 0x89),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG3, 0x20),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG6, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xaa),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCS_TX_RX_CONFIG, 0x0c),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_CDR_RESET_TIME, 0x0a),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG1, 0x88),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG2, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG1, 0x4b),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG5, 0x10),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x21),
+};
+
+static const struct qmp_phy_init_tbl qdu1000_usb3_uniphy_pcs_usb_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_POWER_STATE_CONFIG1, 0x6f),
+};
+
+static const struct qmp_phy_init_tbl qmp_v3_usb3_uniphy_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_IVCO, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYSCLK_EN_SEL, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYS_CLK_CTRL, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_RESETSM_CNTRL2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CMN_CONFIG, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SVS_MODE_CLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_HSCLK_SEL, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DIV_FRAC_START1_MODE0, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DIV_FRAC_START2_MODE0, 0xea),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DIV_FRAC_START3_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN0_MODE0, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE2_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE1_MODE0, 0xc9),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CORECLK_DIV_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP3_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP2_MODE0, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP1_MODE0, 0x15),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP_EN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CORE_CLK_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP_CFG, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_MAP, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYSCLK_BUF_ENABLE, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_ADJ_PER1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_ADJ_PER2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_STEP_SIZE1, 0x85),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SSC_STEP_SIZE2, 0x07),
+};
+
+static const struct qmp_phy_init_tbl qmp_v3_usb3_uniphy_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_HIGHZ_DRVR_EN, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0xc6),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_RX, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x06),
+};
+
+static const struct qmp_phy_init_tbl qmp_v3_usb3_uniphy_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_VGA_CAL_CNTRL2, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x50),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4e),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x1c),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x75),
+};
+
+static const struct qmp_phy_init_tbl qmp_v3_usb3_uniphy_pcs_tbl[] = {
+	/* FLL settings */
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL2, 0x83),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_L, 0x09),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNT_VAL_H_TOL, 0xa2),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_MAN_CODE, 0x40),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_FLL_CNTRL1, 0x02),
+
+	/* Lock Det settings */
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG1, 0xd1),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG2, 0x1f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LOCK_DETECT_CONFIG3, 0x47),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_POWER_STATE_CONFIG2, 0x1b),
+
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0xba),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V0, 0x9f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V1, 0x9f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V2, 0xb5),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V3, 0x4c),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_V4, 0x64),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXMGN_LS, 0x6a),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V0, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V1, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V1, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V2, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V2, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V3, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V3, 0x1d),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_V4, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_V4, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M6DB_LS, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TXDEEMPH_M3P5DB_LS, 0x0d),
+
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RATE_SLEW_CNTRL, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TSYNC_RSYNC_TIME, 0x44),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK, 0x04),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_L, 0x40),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RCVR_DTCT_DLY_U3_H, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_WAIT_TIME, 0x75),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_LFPS_TX_ECSTART_EQTLOCK, 0x86),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RXEQTRAINING_RUN_TIME, 0x13),
+
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_REFGEN_REQ_CONFIG1, 0x21),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_REFGEN_REQ_CONFIG2, 0x60),
+};
+
+static const struct qmp_phy_init_tbl sm8150_usb3_uniphy_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_HSCLK_SEL, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START1_MODE0, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START2_MODE0, 0xea),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START3_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xca),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE1_MODE0, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP2_MODE0, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP1_MODE0, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP_EN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_BUF_ENABLE, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE2_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE1_MODE1, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CORECLK_DIV_MODE1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DEC_START_MODE1, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START1_MODE1, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START2_MODE1, 0xea),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START3_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP2_MODE1, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP1_MODE1, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0xca),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CMN_IPTRIM, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE1_MODE1, 0xde),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE2_MODE1, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE1_MODE0, 0xde),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE2_MODE0, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE_MAP, 0x02),
+};
+
+static const struct qmp_phy_init_tbl sm8150_usb3_uniphy_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0x95),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PI_QEC_CTRL, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX, 0x05),
+};
+
+static const struct qmp_phy_init_tbl sm8150_usb3_uniphy_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0xb8),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0x37),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0xef),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0xb3),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0x5c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0x99),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_THRESH1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_GAIN1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_GAIN2, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL1, 0x54),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL2, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_GM_CAL, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_EN_TIMER, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_CTLE_POST_CAL_OFFSET, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DCC_CTRL1, 0x0c),
+};
+
+static const struct qmp_phy_init_tbl sm8150_usb3_uniphy_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG1, 0xd0),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG3, 0x20),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG6, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xaa),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_CDR_RESET_TIME, 0x0f),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG1, 0x88),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG2, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG1, 0x4b),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG5, 0x10),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x21),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCS_TX_RX_CONFIG, 0x0c),
+};
+
+static const struct qmp_phy_init_tbl sm8150_usb3_uniphy_pcs_usb_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
+};
+
+static const struct qmp_phy_init_tbl sm8250_usb3_uniphy_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0xd5),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_2, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PI_QEC_CTRL, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_RX, 0x02),
+};
+
+static const struct qmp_phy_init_tbl sm8250_usb3_uniphy_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0xb8),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0xb4),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x7b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0x5c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0x99),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_THRESH1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_GAIN1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_GAIN2, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL1, 0x54),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL2, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_EN_TIMER, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DCC_CTRL1, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_GM_CAL, 0x1f),
+};
+
+static const struct qmp_phy_init_tbl sm8250_usb3_uniphy_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG1, 0xd0),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG3, 0x20),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG6, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xa9),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCS_TX_RX_CONFIG, 0x0c),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_CDR_RESET_TIME, 0x0a),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG1, 0x88),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG2, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG1, 0x4b),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG5, 0x10),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x21),
+};
+
+static const struct qmp_phy_init_tbl sm8250_usb3_uniphy_pcs_usb_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
+};
+
+static const struct qmp_phy_init_tbl sdx55_usb3_uniphy_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0xd5),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PI_QEC_CTRL, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX, 0x08),
+};
+
+static const struct qmp_phy_init_tbl sdx55_usb3_uniphy_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x26),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0xb4),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x7b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0x5c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0x99),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_THRESH1, 0x048),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_GAIN1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_GAIN2, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL1, 0x54),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL2, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_EN_TIMER, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DCC_CTRL1, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_GM_CAL, 0x1f),
+};
+
+static const struct qmp_phy_init_tbl sdx65_usb3_uniphy_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0xa5),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_2, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_3, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_4, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PI_QEC_CTRL, 0x21),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_TX, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_RX, 0x0b),
+};
+
+static const struct qmp_phy_init_tbl sdx65_usb3_uniphy_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH4, 0xdb),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH3, 0xbd),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH2, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_LOW, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH4, 0xa9),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH3, 0x7b),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH2, 0xe4),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_LOW, 0x64),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_PI_CONTROLS, 0x99),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_GAIN1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_GAIN2, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FO_GAIN, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL1, 0x54),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_CNTRL, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SO_GAIN, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_GM_CAL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_ENABLES, 0x00),
+};
+
+static const struct qmp_phy_init_tbl sdx75_usb3_uniphy_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE1, 0x9e),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORECLK_DIV_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x2e),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE1, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE1, 0xea),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE1_MODE1, 0x25),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE2_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0xb7),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xb7),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE1_MODE0, 0x9e),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_STEP_SIZE2_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START1_MODE0, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START2_MODE0, 0xea),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DIV_FRAC_START3_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE1_MODE0, 0x25),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE2_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_BG_TIMER, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_BUF_ENABLE, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_EN_SEL, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_CFG, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CORE_CLK_EN, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_1, 0xb6),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_2, 0x4b),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_3, 0x37),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_ADDITIONAL_MISC, 0x0c),
+};
+
+static const struct qmp_phy_init_tbl sdx75_usb3_uniphy_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_TX, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_RX, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RES_CODE_LANE_OFFSET_RX, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_1, 0xf5),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_3, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_4, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_LANE_MODE_5, 0x5f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V6_TX_PI_QEC_CTRL, 0x21),
+};
+
+static const struct qmp_phy_init_tbl sdx75_usb3_uniphy_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FO_GAIN, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SO_GAIN, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_PI_CONTROLS, 0x99),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_THRESH1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_GAIN1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_UCDR_SB2_GAIN2, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_AUX_DATA_TCOARSE_TFINE, 0xa0),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_VGA_CAL_CNTRL1, 0x54),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_VGA_CAL_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_GM_CAL, 0x13),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_IDAC_TSETTLE_LOW, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_CNTRL, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_00_LOW, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_00_HIGH, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_00_HIGH2, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_00_HIGH3, 0xdf),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_00_HIGH4, 0xed),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_LOW, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH, 0x5c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH2, 0x9c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH3, 0x1d),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_RX_MODE_01_HIGH4, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_DFE_EN_TIMER, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_DCC_CTRL1, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_VTH_CODE, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_CAL_CTRL1, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_RX_SIGDET_CAL_TRIM, 0x08),
+};
+
+static const struct qmp_phy_init_tbl sdx75_usb3_uniphy_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG1, 0xc4),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG2, 0x89),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG3, 0x20),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG6, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_REFGEN_REQ_CONFIG1, 0x21),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_RX_SIGDET_LVL, 0xaa),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_CDR_RESET_TIME, 0x0a),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_ALIGN_DETECT_CONFIG1, 0x88),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_ALIGN_DETECT_CONFIG2, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_PCS_TX_RX_CONFIG, 0x0c),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG1, 0x4b),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG5, 0x10),
+};
+
+static const struct qmp_phy_init_tbl sdx75_usb3_uniphy_pcs_usb_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L, 0x40),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H, 0x00),
+};
+
+static const struct qmp_phy_init_tbl qcs8300_usb3_uniphy_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0xa5),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_2, 0xf2),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_3, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_4, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PI_QEC_CTRL, 0x21),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_TX, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_RX, 0x0e),
+};
+
+static const struct qmp_phy_init_tbl sm8350_usb3_uniphy_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0xa5),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_2, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_3, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_4, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PI_QEC_CTRL, 0x21),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_TX, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_RX, 0x0e),
+};
+
+static const struct qmp_phy_init_tbl sm8350_usb3_uniphy_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH4, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH3, 0xbd),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH2, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_LOW, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH4, 0xa9),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH3, 0x7b),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH2, 0xe4),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_LOW, 0x64),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_PI_CONTROLS, 0x99),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_GAIN1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_GAIN2, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FO_GAIN, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL1, 0x54),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_CNTRL, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SO_GAIN, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_GM_CAL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_ENABLES, 0x00),
+};
+
+static const struct qmp_phy_init_tbl sm8350_usb3_uniphy_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG1, 0xd0),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG3, 0x20),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG6, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xaa),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCS_TX_RX_CONFIG, 0x0c),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_CDR_RESET_TIME, 0x0a),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG1, 0x88),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG2, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG1, 0x4b),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG5, 0x10),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x21),
+};
+
+static const struct qmp_phy_init_tbl sm8350_usb3_uniphy_pcs_usb_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_HSCLK_SEL, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START1_MODE0, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START2_MODE0, 0xea),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START3_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xca),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE1_MODE0, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE0, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE0, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP_EN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_BUF_ENABLE, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE2_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE1_MODE1, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CORECLK_DIV_MODE1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE1, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START1_MODE1, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START2_MODE1, 0xea),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DIV_FRAC_START3_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE1, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE1, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0xca),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE1_MODE1, 0xde),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE2_MODE1, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE1_MODE0, 0xde),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SSC_STEP_SIZE2_MODE0, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE_MAP, 0x02),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0xa5),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_2, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_3, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_4, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PI_QEC_CTRL, 0x21),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_TX, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_RX, 0x0e),
+};
+
+static const struct qmp_phy_init_tbl qcs8300_usb3_uniphy_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH4, 0xec),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH3, 0xbd),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH2, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_LOW, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH4, 0xa9),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH3, 0x7b),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH2, 0xe4),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_LOW, 0x64),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_PI_CONTROLS, 0x99),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_GAIN1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_GAIN2, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FO_GAIN, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL1, 0x54),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_CNTRL, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SO_GAIN, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_GM_CAL, 0x19),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_ENABLES, 0x00),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH4, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH3, 0xbd),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH2, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_LOW, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH4, 0xa9),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH3, 0x7b),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH2, 0xe4),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_LOW, 0x64),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_PI_CONTROLS, 0x99),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_GAIN1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SB2_GAIN2, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FO_GAIN, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL1, 0x54),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_VGA_CAL_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_CNTRL, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SO_GAIN, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_GM_CAL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_ENABLES, 0x00),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG1, 0xd0),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG3, 0x20),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG6, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RX_SIGDET_LVL, 0xaa),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCS_TX_RX_CONFIG, 0x0c),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_CDR_RESET_TIME, 0x0a),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_ALIGN_DETECT_CONFIG1, 0x88),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_ALIGN_DETECT_CONFIG2, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG1, 0x4b),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG5, 0x10),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_REFGEN_REQ_CONFIG1, 0x21),
+};
+
+static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_pcs_usb_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
+};
+
+static const struct qmp_phy_init_tbl sa8775p_usb3_uniphy_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG1, 0xc4),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG2, 0x89),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG3, 0x20),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG6, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RX_SIGDET_LVL, 0xaa),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCS_TX_RX_CONFIG, 0x0c),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_CDR_RESET_TIME, 0x0a),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_ALIGN_DETECT_CONFIG1, 0x88),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_ALIGN_DETECT_CONFIG2, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG1, 0x4b),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_EQ_CONFIG5, 0x10),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_REFGEN_REQ_CONFIG1, 0x21),
+};
+
+static const struct qmp_phy_init_tbl sa8775p_usb3_uniphy_pcs_usb_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_POWER_STATE_CONFIG1, 0x6f),
+};
+
+static const struct qmp_phy_init_tbl x1e80100_usb3_uniphy_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_STEP_SIZE1_MODE1, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_STEP_SIZE2_MODE1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_CP_CTRL_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_CORECLK_DIV_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_LOCK_CMP1_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_LOCK_CMP2_MODE1, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DEC_START_MODE1, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START1_MODE1, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START2_MODE1, 0x75),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START3_MODE1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_HSCLK_SEL_1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_VCO_TUNE1_MODE1, 0x25),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_VCO_TUNE2_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0x5c),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0x5c),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_STEP_SIZE1_MODE0, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_STEP_SIZE2_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_CP_CTRL_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_LOCK_CMP1_MODE0, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_LOCK_CMP2_MODE0, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DEC_START_MODE0, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START1_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START2_MODE0, 0x75),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_DIV_FRAC_START3_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_VCO_TUNE1_MODE0, 0x25),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_VCO_TUNE2_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_BG_TIMER, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_PER1, 0x62),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SSC_PER2, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SYSCLK_BUF_ENABLE, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_SYSCLK_EN_SEL, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_LOCK_CMP_CFG, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_VCO_TUNE_MAP, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_CORE_CLK_EN, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_CMN_CONFIG_1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_1, 0xb6),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_2, 0x4b),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_AUTO_GAIN_ADJ_CTRL_3, 0x37),
+	QMP_PHY_INIT_CFG(QSERDES_V7_COM_ADDITIONAL_MISC, 0x0c),
+};
+
+static const struct qmp_phy_init_tbl x1e80100_usb3_uniphy_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V7_TX_RES_CODE_LANE_TX, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V7_TX_RES_CODE_LANE_RX, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V7_TX_RES_CODE_LANE_OFFSET_TX, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V7_TX_RES_CODE_LANE_OFFSET_RX, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V7_TX_LANE_MODE_1, 0xf5),
+	QMP_PHY_INIT_CFG(QSERDES_V7_TX_LANE_MODE_3, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V7_TX_LANE_MODE_4, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V7_TX_LANE_MODE_5, 0x5f),
+	QMP_PHY_INIT_CFG(QSERDES_V7_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V7_TX_PI_QEC_CTRL, 0x21),
+};
+
+static const struct qmp_phy_init_tbl x1e80100_usb3_uniphy_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_FO_GAIN, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SO_GAIN, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_PI_CONTROLS, 0x99),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SB2_THRESH1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SB2_GAIN1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_UCDR_SB2_GAIN2, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_AUX_DATA_TCOARSE_TFINE, 0xa0),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_VGA_CAL_CNTRL1, 0x54),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_VGA_CAL_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_GM_CAL, 0x13),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_IDAC_TSETTLE_LOW, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x47),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_SIGDET_CNTRL, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_00_LOW, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_00_HIGH, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_00_HIGH2, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_00_HIGH3, 0xdf),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_00_HIGH4, 0xed),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_01_LOW, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_01_HIGH, 0x5c),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_01_HIGH2, 0x9c),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_01_HIGH3, 0x1d),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_RX_MODE_01_HIGH4, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_DFE_EN_TIMER, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_DCC_CTRL1, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_VTH_CODE, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_SIGDET_CAL_CTRL1, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V7_RX_SIGDET_CAL_TRIM, 0x08),
+};
+
+static const struct qmp_phy_init_tbl x1e80100_usb3_uniphy_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_LOCK_DETECT_CONFIG1, 0xc4),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_LOCK_DETECT_CONFIG2, 0x89),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_LOCK_DETECT_CONFIG3, 0x20),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_LOCK_DETECT_CONFIG6, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_REFGEN_REQ_CONFIG1, 0x21),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_RX_SIGDET_LVL, 0xaa),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_CDR_RESET_TIME, 0x0a),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_ALIGN_DETECT_CONFIG1, 0x88),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_ALIGN_DETECT_CONFIG2, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_PCS_TX_RX_CONFIG, 0x0c),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_EQ_CONFIG1, 0x4b),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_EQ_CONFIG5, 0x10),
+};
+
+static const struct qmp_phy_init_tbl x1e80100_usb3_uniphy_pcs_usb_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_USB3_RCVR_DTCT_DLY_U3_L, 0x40),
+	QMP_PHY_INIT_CFG(QPHY_V7_PCS_USB3_RCVR_DTCT_DLY_U3_H, 0x00),
+};
+
+struct qmp_usb_offsets {
+	u16 serdes;
+	u16 pcs;
+	u16 pcs_misc;
+	u16 pcs_usb;
+	u16 tx;
+	u16 rx;
+};
+
+/* struct qmp_phy_cfg - per-PHY initialization config */
+struct qmp_phy_cfg {
+	const struct qmp_usb_offsets *offsets;
+
+	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
+	const struct qmp_phy_init_tbl *serdes_tbl;
+	int serdes_tbl_num;
+	const struct qmp_phy_init_tbl *tx_tbl;
+	int tx_tbl_num;
+	const struct qmp_phy_init_tbl *rx_tbl;
+	int rx_tbl_num;
+	const struct qmp_phy_init_tbl *pcs_tbl;
+	int pcs_tbl_num;
+	const struct qmp_phy_init_tbl *pcs_usb_tbl;
+	int pcs_usb_tbl_num;
+
+	/* regulators to be requested */
+	const char * const *vreg_list;
+	int num_vregs;
+
+	/* array of registers with different offsets */
+	const unsigned int *regs;
+
+	/* true, if PHY needs delay after POWER_DOWN */
+	bool has_pwrdn_delay;
+
+	/* Offset from PCS to PCS_USB region */
+	unsigned int pcs_usb_offset;
+};
+
+struct qmp_usb {
+	struct udevice *dev;
+
+	const struct qmp_phy_cfg *cfg;
+
+	void __iomem *serdes;
+	void __iomem *pcs;
+	void __iomem *pcs_misc;
+	void __iomem *pcs_usb;
+	void __iomem *tx;
+	void __iomem *rx;
+
+	struct clk *pipe_clk;
+	struct clk_bulk clks;
+	int num_clks;
+	int num_resets;
+	struct reset_ctl_bulk *resets;
+	struct regulator_bulk_data *vregs;
+
+	enum phy_mode mode;
+
+	struct phy *phy;
+
+	struct clk_fixed_rate pipe_clk_fixed;
+};
+
+static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg |= val;
+	writel(reg, base + offset);
+
+	/* ensure that above write is through */
+	readl(base + offset);
+}
+
+static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg &= ~val;
+	writel(reg, base + offset);
+
+	/* ensure that above write is through */
+	readl(base + offset);
+}
+
+static const char * const usb3phy_reset_l[] = {
+	"phy_phy", "phy",
+};
+
+/* list of regulators */
+static const char * const qmp_phy_vreg_l[] = {
+	"vdda-phy", "vdda-pll",
+};
+
+static const struct qmp_usb_offsets qmp_usb_offsets_v3 = {
+	.serdes		= 0,
+	.pcs		= 0x800,
+	.pcs_misc	= 0x600,
+	.tx		= 0x200,
+	.rx		= 0x400,
+};
+
+static const struct qmp_usb_offsets qmp_usb_offsets_ipq9574 = {
+	.serdes		= 0,
+	.pcs		= 0x800,
+	.pcs_usb	= 0x800,
+	.tx		= 0x200,
+	.rx		= 0x400,
+};
+
+static const struct qmp_usb_offsets qmp_usb_offsets_v3_msm8996 = {
+	.serdes		= 0,
+	.pcs		= 0x600,
+	.tx		= 0x200,
+	.rx		= 0x400,
+};
+
+static const struct qmp_usb_offsets qmp_usb_offsets_v4 = {
+	.serdes		= 0,
+	.pcs		= 0x0800,
+	.pcs_usb	= 0x0e00,
+	.tx		= 0x0200,
+	.rx		= 0x0400,
+};
+
+static const struct qmp_usb_offsets qmp_usb_offsets_v5 = {
+	.serdes		= 0,
+	.pcs		= 0x0200,
+	.pcs_usb	= 0x1200,
+	.tx		= 0x0e00,
+	.rx		= 0x1000,
+};
+
+static const struct qmp_usb_offsets qmp_usb_offsets_v6 = {
+	.serdes		= 0,
+	.pcs		= 0x0200,
+	.pcs_usb	= 0x1200,
+	.tx		= 0x0e00,
+	.rx		= 0x1000,
+};
+
+static const struct qmp_usb_offsets qmp_usb_offsets_v7 = {
+	.serdes		= 0,
+	.pcs		= 0x0200,
+	.pcs_usb	= 0x1200,
+	.tx		= 0x0e00,
+	.rx		= 0x1000,
+};
+
+static const struct qmp_usb_offsets qmp_usb_offsets_v8 = {
+	.serdes		= 0,
+	.pcs		= 0x0400,
+	.pcs_usb	= 0x1200,
+	.tx		= 0x0e00,
+	.rx		= 0x1000,
+};
+
+static const struct qmp_phy_cfg ipq6018_usb3phy_cfg = {
+	.offsets		= &qmp_usb_offsets_v3,
+
+	.serdes_tbl		= ipq9574_usb3_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(ipq9574_usb3_serdes_tbl),
+	.tx_tbl			= msm8996_usb3_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(msm8996_usb3_tx_tbl),
+	.rx_tbl			= ipq8074_usb3_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(ipq8074_usb3_rx_tbl),
+	.pcs_tbl		= ipq8074_usb3_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(ipq8074_usb3_pcs_tbl),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v3_usb3phy_regs_layout,
+};
+
+static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
+	.offsets		= &qmp_usb_offsets_v3,
+
+	.serdes_tbl		= ipq8074_usb3_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_usb3_serdes_tbl),
+	.tx_tbl			= msm8996_usb3_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(msm8996_usb3_tx_tbl),
+	.rx_tbl			= ipq8074_usb3_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(ipq8074_usb3_rx_tbl),
+	.pcs_tbl		= ipq8074_usb3_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(ipq8074_usb3_pcs_tbl),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v3_usb3phy_regs_layout,
+};
+
+static const struct qmp_phy_cfg ipq9574_usb3phy_cfg = {
+	.offsets		= &qmp_usb_offsets_ipq9574,
+
+	.serdes_tbl		= ipq9574_usb3_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(ipq9574_usb3_serdes_tbl),
+	.tx_tbl			= ipq9574_usb3_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(ipq9574_usb3_tx_tbl),
+	.rx_tbl			= ipq9574_usb3_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(ipq9574_usb3_rx_tbl),
+	.pcs_tbl		= ipq9574_usb3_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(ipq9574_usb3_pcs_tbl),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v3_usb3phy_regs_layout,
+};
+
+static const struct qmp_phy_cfg msm8996_usb3phy_cfg = {
+	.offsets		= &qmp_usb_offsets_v3_msm8996,
+
+	.serdes_tbl		= msm8996_usb3_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(msm8996_usb3_serdes_tbl),
+	.tx_tbl			= msm8996_usb3_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(msm8996_usb3_tx_tbl),
+	.rx_tbl			= msm8996_usb3_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(msm8996_usb3_rx_tbl),
+	.pcs_tbl		= msm8996_usb3_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(msm8996_usb3_pcs_tbl),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v2_usb3phy_regs_layout,
+};
+
+static const struct qmp_phy_cfg qdu1000_usb3_uniphy_cfg = {
+	.offsets		= &qmp_usb_offsets_v5,
+
+	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
+	.tx_tbl			= sm8350_usb3_uniphy_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sm8350_usb3_uniphy_tx_tbl),
+	.rx_tbl			= sm8350_usb3_uniphy_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sm8350_usb3_uniphy_rx_tbl),
+	.pcs_tbl		= qdu1000_usb3_uniphy_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(qdu1000_usb3_uniphy_pcs_tbl),
+	.pcs_usb_tbl		= qdu1000_usb3_uniphy_pcs_usb_tbl,
+	.pcs_usb_tbl_num	= ARRAY_SIZE(qdu1000_usb3_uniphy_pcs_usb_tbl),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v4_usb3phy_regs_layout,
+	.pcs_usb_offset		= 0x1000,
+
+	.has_pwrdn_delay	= true,
+};
+
+static const struct qmp_phy_cfg sa8775p_usb3_uniphy_cfg = {
+	.offsets		= &qmp_usb_offsets_v5,
+
+	.serdes_tbl		= sc8280xp_usb3_uniphy_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_serdes_tbl),
+	.tx_tbl			= sc8280xp_usb3_uniphy_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_tx_tbl),
+	.rx_tbl			= sc8280xp_usb3_uniphy_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_rx_tbl),
+	.pcs_tbl		= sa8775p_usb3_uniphy_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sa8775p_usb3_uniphy_pcs_tbl),
+	.pcs_usb_tbl		= sa8775p_usb3_uniphy_pcs_usb_tbl,
+	.pcs_usb_tbl_num	= ARRAY_SIZE(sa8775p_usb3_uniphy_pcs_usb_tbl),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v5_usb3phy_regs_layout,
+};
+
+static const struct qmp_phy_cfg qcs8300_usb3_uniphy_cfg = {
+	.offsets		= &qmp_usb_offsets_v5,
+
+	.serdes_tbl		= sc8280xp_usb3_uniphy_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_serdes_tbl),
+	.tx_tbl			= qcs8300_usb3_uniphy_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(qcs8300_usb3_uniphy_tx_tbl),
+	.rx_tbl			= qcs8300_usb3_uniphy_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(qcs8300_usb3_uniphy_rx_tbl),
+	.pcs_tbl		= sa8775p_usb3_uniphy_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sa8775p_usb3_uniphy_pcs_tbl),
+	.pcs_usb_tbl		= sa8775p_usb3_uniphy_pcs_usb_tbl,
+	.pcs_usb_tbl_num	= ARRAY_SIZE(sa8775p_usb3_uniphy_pcs_usb_tbl),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v5_usb3phy_regs_layout,
+};
+
+static const struct qmp_phy_cfg sc8280xp_usb3_uniphy_cfg = {
+	.offsets		= &qmp_usb_offsets_v5,
+
+	.serdes_tbl		= sc8280xp_usb3_uniphy_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_serdes_tbl),
+	.tx_tbl			= sc8280xp_usb3_uniphy_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_tx_tbl),
+	.rx_tbl			= sc8280xp_usb3_uniphy_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_rx_tbl),
+	.pcs_tbl		= sc8280xp_usb3_uniphy_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_pcs_tbl),
+	.pcs_usb_tbl		= sc8280xp_usb3_uniphy_pcs_usb_tbl,
+	.pcs_usb_tbl_num	= ARRAY_SIZE(sc8280xp_usb3_uniphy_pcs_usb_tbl),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v5_usb3phy_regs_layout,
+};
+
+static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
+	.offsets		= &qmp_usb_offsets_v3,
+
+	.serdes_tbl		= qmp_v3_usb3_uniphy_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_uniphy_serdes_tbl),
+	.tx_tbl			= qmp_v3_usb3_uniphy_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_uniphy_tx_tbl),
+	.rx_tbl			= qmp_v3_usb3_uniphy_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_uniphy_rx_tbl),
+	.pcs_tbl		= qmp_v3_usb3_uniphy_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(qmp_v3_usb3_uniphy_pcs_tbl),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v3_usb3phy_regs_layout,
+
+	.has_pwrdn_delay	= true,
+};
+
+static const struct qmp_phy_cfg sm8150_usb3_uniphy_cfg = {
+	.offsets		= &qmp_usb_offsets_v4,
+
+	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
+	.tx_tbl			= sm8150_usb3_uniphy_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_tx_tbl),
+	.rx_tbl			= sm8150_usb3_uniphy_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_rx_tbl),
+	.pcs_tbl		= sm8150_usb3_uniphy_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_pcs_tbl),
+	.pcs_usb_tbl		= sm8150_usb3_uniphy_pcs_usb_tbl,
+	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8150_usb3_uniphy_pcs_usb_tbl),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v4_usb3phy_regs_layout,
+	.pcs_usb_offset		= 0x600,
+
+	.has_pwrdn_delay	= true,
+};
+
+static const struct qmp_phy_cfg sm8250_usb3_uniphy_cfg = {
+	.offsets		= &qmp_usb_offsets_v4,
+
+	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
+	.tx_tbl			= sm8250_usb3_uniphy_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sm8250_usb3_uniphy_tx_tbl),
+	.rx_tbl			= sm8250_usb3_uniphy_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sm8250_usb3_uniphy_rx_tbl),
+	.pcs_tbl		= sm8250_usb3_uniphy_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8250_usb3_uniphy_pcs_tbl),
+	.pcs_usb_tbl		= sm8250_usb3_uniphy_pcs_usb_tbl,
+	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8250_usb3_uniphy_pcs_usb_tbl),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v4_usb3phy_regs_layout,
+	.pcs_usb_offset		= 0x600,
+
+	.has_pwrdn_delay	= true,
+};
+
+static const struct qmp_phy_cfg sdx55_usb3_uniphy_cfg = {
+	.offsets		= &qmp_usb_offsets_v4,
+
+	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
+	.tx_tbl			= sdx55_usb3_uniphy_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sdx55_usb3_uniphy_tx_tbl),
+	.rx_tbl			= sdx55_usb3_uniphy_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sdx55_usb3_uniphy_rx_tbl),
+	.pcs_tbl		= sm8250_usb3_uniphy_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8250_usb3_uniphy_pcs_tbl),
+	.pcs_usb_tbl		= sm8250_usb3_uniphy_pcs_usb_tbl,
+	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8250_usb3_uniphy_pcs_usb_tbl),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v4_usb3phy_regs_layout,
+	.pcs_usb_offset		= 0x600,
+
+	.has_pwrdn_delay	= true,
+};
+
+static const struct qmp_phy_cfg sdx65_usb3_uniphy_cfg = {
+	.offsets		= &qmp_usb_offsets_v5,
+
+	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
+	.tx_tbl			= sdx65_usb3_uniphy_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sdx65_usb3_uniphy_tx_tbl),
+	.rx_tbl			= sdx65_usb3_uniphy_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sdx65_usb3_uniphy_rx_tbl),
+	.pcs_tbl		= sm8350_usb3_uniphy_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8350_usb3_uniphy_pcs_tbl),
+	.pcs_usb_tbl		= sm8350_usb3_uniphy_pcs_usb_tbl,
+	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8350_usb3_uniphy_pcs_usb_tbl),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v5_usb3phy_regs_layout,
+	.pcs_usb_offset		= 0x1000,
+
+	.has_pwrdn_delay	= true,
+};
+
+static const struct qmp_phy_cfg sdx75_usb3_uniphy_cfg = {
+	.offsets		= &qmp_usb_offsets_v6,
+
+	.serdes_tbl		= sdx75_usb3_uniphy_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sdx75_usb3_uniphy_serdes_tbl),
+	.tx_tbl			= sdx75_usb3_uniphy_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sdx75_usb3_uniphy_tx_tbl),
+	.rx_tbl			= sdx75_usb3_uniphy_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sdx75_usb3_uniphy_rx_tbl),
+	.pcs_tbl		= sdx75_usb3_uniphy_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sdx75_usb3_uniphy_pcs_tbl),
+	.pcs_usb_tbl		= sdx75_usb3_uniphy_pcs_usb_tbl,
+	.pcs_usb_tbl_num	= ARRAY_SIZE(sdx75_usb3_uniphy_pcs_usb_tbl),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v6_usb3phy_regs_layout,
+	.pcs_usb_offset		= 0x1000,
+
+	.has_pwrdn_delay	= true,
+};
+
+static const struct qmp_phy_cfg sm8350_usb3_uniphy_cfg = {
+	.offsets		= &qmp_usb_offsets_v5,
+
+	.serdes_tbl		= sm8150_usb3_uniphy_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_uniphy_serdes_tbl),
+	.tx_tbl			= sm8350_usb3_uniphy_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sm8350_usb3_uniphy_tx_tbl),
+	.rx_tbl			= sm8350_usb3_uniphy_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sm8350_usb3_uniphy_rx_tbl),
+	.pcs_tbl		= sm8350_usb3_uniphy_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8350_usb3_uniphy_pcs_tbl),
+	.pcs_usb_tbl		= sm8350_usb3_uniphy_pcs_usb_tbl,
+	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8350_usb3_uniphy_pcs_usb_tbl),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v5_usb3phy_regs_layout,
+	.pcs_usb_offset		= 0x1000,
+
+	.has_pwrdn_delay	= true,
+};
+
+static const struct qmp_phy_cfg x1e80100_usb3_uniphy_cfg = {
+	.offsets		= &qmp_usb_offsets_v7,
+
+	.serdes_tbl		= x1e80100_usb3_uniphy_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(x1e80100_usb3_uniphy_serdes_tbl),
+	.tx_tbl			= x1e80100_usb3_uniphy_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(x1e80100_usb3_uniphy_tx_tbl),
+	.rx_tbl			= x1e80100_usb3_uniphy_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(x1e80100_usb3_uniphy_rx_tbl),
+	.pcs_tbl		= x1e80100_usb3_uniphy_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(x1e80100_usb3_uniphy_pcs_tbl),
+	.pcs_usb_tbl		= x1e80100_usb3_uniphy_pcs_usb_tbl,
+	.pcs_usb_tbl_num	= ARRAY_SIZE(x1e80100_usb3_uniphy_pcs_usb_tbl),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v7_usb3phy_regs_layout,
+};
+
+static const struct qmp_phy_cfg glymur_usb3_uniphy_cfg = {
+	.offsets		= &qmp_usb_offsets_v8,
+
+	.serdes_tbl		= glymur_usb3_uniphy_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(glymur_usb3_uniphy_serdes_tbl),
+	.tx_tbl			= glymur_usb3_uniphy_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(glymur_usb3_uniphy_tx_tbl),
+	.rx_tbl			= glymur_usb3_uniphy_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(glymur_usb3_uniphy_rx_tbl),
+	.pcs_tbl		= glymur_usb3_uniphy_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(glymur_usb3_uniphy_pcs_tbl),
+	.pcs_usb_tbl		= glymur_usb3_uniphy_pcs_usb_tbl,
+	.pcs_usb_tbl_num	= ARRAY_SIZE(glymur_usb3_uniphy_pcs_usb_tbl),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v7_usb3phy_regs_layout,
+};
+
+static int qmp_usb_serdes_init(struct qmp_usb *qmp)
+{
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *serdes = qmp->serdes;
+	const struct qmp_phy_init_tbl *serdes_tbl = cfg->serdes_tbl;
+	int serdes_tbl_num = cfg->serdes_tbl_num;
+
+	qmp_configure(qmp->dev, serdes, serdes_tbl, serdes_tbl_num);
+
+	return 0;
+}
+
+static int qmp_usb_init(struct phy *phy)
+{
+	struct qmp_usb *qmp = dev_get_priv(phy->dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *pcs = qmp->pcs;
+	int ret;
+
+	ret = reset_assert_bulk(qmp->resets);
+	if (ret) {
+		dev_err(qmp->dev, "reset assert failed\n");
+		goto err_disable_regulators;
+	}
+
+	udelay(200);
+
+	ret = reset_deassert_bulk(qmp->resets);
+	if (ret) {
+		dev_err(qmp->dev, "reset deassert failed\n");
+		goto err_disable_regulators;
+	}
+
+	udelay(200);
+
+	ret = clk_enable_bulk(&qmp->clks);
+	if (ret)
+		goto err_assert_reset;
+
+	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], SW_PWRDN);
+
+	return 0;
+
+err_assert_reset:
+	reset_deassert_bulk(qmp->resets);
+err_disable_regulators:
+
+	return ret;
+}
+
+static int qmp_usb_exit(struct phy *phy)
+{
+	struct qmp_usb *qmp = dev_get_priv(phy->dev);
+
+	reset_assert_bulk(qmp->resets);
+
+	clk_disable_bulk(&qmp->clks);
+
+	return 0;
+}
+
+static int qmp_usb_power_on(struct phy *phy)
+{
+	struct qmp_usb *qmp = dev_get_priv(phy->dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *tx = qmp->tx;
+	void __iomem *rx = qmp->rx;
+	void __iomem *pcs = qmp->pcs;
+	void __iomem *pcs_usb = qmp->pcs_usb;
+	void __iomem *status;
+	unsigned int val;
+	int ret;
+
+	qmp_usb_serdes_init(qmp);
+
+	ret = clk_prepare_enable(qmp->pipe_clk);
+	if (ret) {
+		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
+		return ret;
+	}
+
+	/* Tx, Rx, and PCS configurations */
+	qmp_configure_lane(qmp->dev, tx, cfg->tx_tbl, cfg->tx_tbl_num, 1);
+	qmp_configure_lane(qmp->dev, rx, cfg->rx_tbl, cfg->rx_tbl_num, 1);
+
+	qmp_configure(qmp->dev, pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
+
+	if (pcs_usb)
+		qmp_configure(qmp->dev, pcs_usb, cfg->pcs_usb_tbl, cfg->pcs_usb_tbl_num);
+
+	if (cfg->has_pwrdn_delay)
+		udelay(20);
+
+	/* Pull PHY out of reset state */
+	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
+
+	/* start SerDes and Phy-Coding-Sublayer */
+	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START | PCS_START);
+
+	status = pcs + cfg->regs[QPHY_PCS_STATUS];
+	ret = readl_poll_timeout(status, val, !(val & PHYSTATUS),
+				 PHY_INIT_COMPLETE_TIMEOUT);
+	if (ret) {
+		dev_err(qmp->dev, "phy initialization timed-out\n");
+		goto err_disable_pipe_clk;
+	}
+
+	return 0;
+
+err_disable_pipe_clk:
+	clk_disable_unprepare(qmp->pipe_clk);
+
+	return ret;
+}
+
+static int qmp_usb_power_off(struct phy *phy)
+{
+	struct qmp_usb *qmp = dev_get_priv(phy->dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+
+	clk_disable_unprepare(qmp->pipe_clk);
+
+	/* PHY reset */
+	qphy_setbits(qmp->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
+
+	/* stop SerDes and Phy-Coding-Sublayer */
+	qphy_clrbits(qmp->pcs, cfg->regs[QPHY_START_CTRL],
+		     SERDES_START | PCS_START);
+
+	/* Put PHY into POWER DOWN state: active low */
+	qphy_clrbits(qmp->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
+		     SW_PWRDN);
+
+	return 0;
+}
+
+static int qmp_usb_enable(struct phy *phy)
+{
+	int ret;
+
+	ret = qmp_usb_init(phy);
+	if (ret)
+		return ret;
+
+	ret = qmp_usb_power_on(phy);
+	if (ret)
+		qmp_usb_exit(phy);
+
+	return ret;
+}
+
+static int qmp_usb_disable(struct phy *phy)
+{
+	int ret;
+
+	ret = qmp_usb_power_off(phy);
+	if (ret)
+		return ret;
+	return qmp_usb_exit(phy);
+}
+
+static int qmp_usb_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct qmp_usb *qmp = dev_get_priv(phy->dev);
+
+	qmp->mode = mode;
+
+	return 0;
+}
+
+static const struct phy_ops qmp_usb_phy_ops = {
+	.init		= qmp_usb_enable,
+	.exit		= qmp_usb_disable,
+	.set_mode	= qmp_usb_set_mode,
+};
+
+static int qmp_usb_reset_init(struct qmp_usb *qmp,
+			      const char *const *reset_list,
+			      int num_resets)
+{
+	struct udevice *dev = qmp->dev;
+	int ret;
+
+	qmp->num_resets = num_resets;
+
+	qmp->resets = devm_reset_bulk_get_optional(dev);
+	if (IS_ERR_OR_NULL(qmp->resets)) {
+		ret = PTR_ERR(qmp->resets);
+		dev_err(dev, "failed to get resets %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qmp_usb_clk_init(struct qmp_usb *qmp)
+{
+	struct udevice *dev = qmp->dev;
+	int ret;
+
+	ret = clk_get_bulk(dev, &qmp->clks);
+
+	if (!ret)
+		qmp->num_clks = qmp->clks.count;
+
+	return ret;
+}
+
+static int qmp_usb_parse_dt(struct qmp_usb *qmp)
+{
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	const struct qmp_usb_offsets *offs = cfg->offsets;
+	struct udevice *dev = qmp->dev;
+	void __iomem *base;
+	int ret;
+
+	if (!offs)
+		return -EINVAL;
+
+	base = (void __iomem *)dev_read_addr(dev);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	qmp->serdes = base + offs->serdes;
+	qmp->pcs = base + offs->pcs;
+	if (offs->pcs_usb)
+		qmp->pcs_usb = base + offs->pcs_usb;
+	if (offs->pcs_misc)
+		qmp->pcs_misc = base + offs->pcs_misc;
+	qmp->tx = base + offs->tx;
+	qmp->rx = base + offs->rx;
+
+	ret = qmp_usb_clk_init(qmp);
+	if (ret)
+		return ret;
+
+	qmp->pipe_clk = devm_clk_get(dev, "pipe");
+	if (IS_ERR(qmp->pipe_clk)) {
+		dev_err(dev, "failed to get pipe clock (%ld)\n",
+			PTR_ERR(qmp->pipe_clk));
+		return ret;
+	}
+
+	ret = qmp_usb_reset_init(qmp, usb3phy_reset_l,
+				 ARRAY_SIZE(usb3phy_reset_l));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int qmp_usb_probe(struct udevice *dev)
+{
+	struct qmp_usb *qmp = dev_get_priv(dev);
+	int ret;
+
+	qmp->dev = dev;
+	dev_set_drvdata(dev, qmp);
+
+	qmp->cfg = (struct qmp_phy_cfg *)dev_get_driver_data(dev);
+	if (!qmp->cfg)
+		return -EINVAL;
+
+	ret = qmp_usb_parse_dt(qmp);
+
+	if (ret)
+		goto err_node_put;
+
+err_node_put:
+	return ret;
+}
+
+static const struct udevice_id qmp_usb_phy_ids[] = {
+	{
+		.compatible = "qcom,glymur-qmp-usb3-uni-phy",
+		.data = (ulong)&glymur_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,ipq5424-qmp-usb3-phy",
+		.data = (ulong)&ipq9574_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,ipq6018-qmp-usb3-phy",
+		.data = (ulong)&ipq6018_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,ipq8074-qmp-usb3-phy",
+		.data = (ulong)&ipq8074_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,ipq9574-qmp-usb3-phy",
+		.data = (ulong)&ipq9574_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,msm8996-qmp-usb3-phy",
+		.data = (ulong)&msm8996_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,qcs8300-qmp-usb3-uni-phy",
+		.data = (ulong)&qcs8300_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,qdu1000-qmp-usb3-uni-phy",
+		.data = (ulong)&qdu1000_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sa8775p-qmp-usb3-uni-phy",
+		.data = (ulong)&sa8775p_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sc8180x-qmp-usb3-uni-phy",
+		.data = (ulong)&sm8150_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sc8280xp-qmp-usb3-uni-phy",
+		.data = (ulong)&sc8280xp_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sdm845-qmp-usb3-uni-phy",
+		.data = (ulong)&qmp_v3_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sdx55-qmp-usb3-uni-phy",
+		.data = (ulong)&sdx55_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sdx65-qmp-usb3-uni-phy",
+		.data = (ulong)&sdx65_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sdx75-qmp-usb3-uni-phy",
+		.data = (ulong)&sdx75_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sm8150-qmp-usb3-uni-phy",
+		.data = (ulong)&sm8150_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sm8250-qmp-usb3-uni-phy",
+		.data = (ulong)&sm8250_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,sm8350-qmp-usb3-uni-phy",
+		.data = (ulong)&sm8350_usb3_uniphy_cfg,
+	}, {
+		.compatible = "qcom,x1e80100-qmp-usb3-uni-phy",
+		.data = (ulong)&x1e80100_usb3_uniphy_cfg,
+	},
+	{ },
+};
+
+U_BOOT_DRIVER(qmp_usb_phy) = {
+	.name		= "qcom-qmp-usb-phy",
+	.id		= UCLASS_PHY,
+	.of_match	= qmp_usb_phy_ids,
+	.ops		= &qmp_usb_phy_ops,
+	.probe		= qmp_usb_probe,
+	.priv_auto	= sizeof(struct qmp_usb),
+};
diff --git a/drivers/phy/qcom/phy-qcom-qmp-usb43-qserdes-com-v8.h b/drivers/phy/qcom/phy-qcom-qmp-usb43-qserdes-com-v8.h
new file mode 100644
index 00000000000..e9c743fce9d
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-usb43-qserdes-com-v8.h
@@ -0,0 +1,224 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_USB43_QSERDES_COM_V8_H_
+#define QCOM_PHY_QMP_USB43_QSERDES_COM_V8_H_
+
+#define QSERDES_V8_USB43_COM_SSC_STEP_SIZE1_MODE1		0x000
+#define QSERDES_V8_USB43_COM_SSC_STEP_SIZE2_MODE1		0x004
+#define QSERDES_V8_USB43_COM_SSC_STEP_SIZE3_MODE1		0x008
+#define QSERDES_V8_USB43_COM_CLK_EP_DIV_MODE1			0x00c
+#define QSERDES_V8_USB43_COM_CP_CTRL_MODE1			0x010
+#define QSERDES_V8_USB43_COM_PLL_RCTRL_MODE1			0x014
+#define QSERDES_V8_USB43_COM_PLL_CCTRL_MODE1			0x018
+#define QSERDES_V8_USB43_COM_CORECLK_DIV_MODE1			0x01c
+#define QSERDES_V8_USB43_COM_LOCK_CMP1_MODE1			0x020
+#define QSERDES_V8_USB43_COM_LOCK_CMP2_MODE1			0x024
+#define QSERDES_V8_USB43_COM_DEC_START_MODE1			0x028
+#define QSERDES_V8_USB43_COM_DEC_START_MSB_MODE1		0x02c
+#define QSERDES_V8_USB43_COM_DIV_FRAC_START1_MODE1		0x030
+#define QSERDES_V8_USB43_COM_DIV_FRAC_START2_MODE1		0x034
+#define QSERDES_V8_USB43_COM_DIV_FRAC_START3_MODE1		0x038
+#define QSERDES_V8_USB43_COM_HSCLK_SEL_1			0x03c
+#define QSERDES_V8_USB43_COM_INTEGLOOP_GAIN0_MODE1		0x040
+#define QSERDES_V8_USB43_COM_INTEGLOOP_GAIN1_MODE1		0x044
+#define QSERDES_V8_USB43_COM_VCO_TUNE1_MODE1			0x048
+#define QSERDES_V8_USB43_COM_VCO_TUNE2_MODE1			0x04c
+#define QSERDES_V8_USB43_COM_BIN_VCOCAL_CMP_CODE1_MODE1		0x050
+#define QSERDES_V8_USB43_COM_BIN_VCOCAL_CMP_CODE2_MODE1		0x054
+#define QSERDES_V8_USB43_COM_BIN_VCOCAL_CMP_CODE1_MODE0		0x058
+#define QSERDES_V8_USB43_COM_BIN_VCOCAL_CMP_CODE2_MODE0		0x05c
+#define QSERDES_V8_USB43_COM_SSC_STEP_SIZE1_MODE0		0x060
+#define QSERDES_V8_USB43_COM_SSC_STEP_SIZE2_MODE0		0x064
+#define QSERDES_V8_USB43_COM_SSC_STEP_SIZE3_MODE0		0x068
+#define QSERDES_V8_USB43_COM_CLK_EP_DIV_MODE0			0x06c
+#define QSERDES_V8_USB43_COM_CP_CTRL_MODE0			0x070
+#define QSERDES_V8_USB43_COM_PLL_RCTRL_MODE0			0x074
+#define QSERDES_V8_USB43_COM_PLL_CCTRL_MODE0			0x078
+#define QSERDES_V8_USB43_COM_CORECLK_DIV_MODE0			0x07c
+#define QSERDES_V8_USB43_COM_LOCK_CMP1_MODE0			0x080
+#define QSERDES_V8_USB43_COM_LOCK_CMP2_MODE0			0x084
+#define QSERDES_V8_USB43_COM_DEC_START_MODE0			0x088
+#define QSERDES_V8_USB43_COM_DEC_START_MSB_MODE0		0x08c
+#define QSERDES_V8_USB43_COM_DIV_FRAC_START1_MODE0		0x090
+#define QSERDES_V8_USB43_COM_DIV_FRAC_START2_MODE0		0x094
+#define QSERDES_V8_USB43_COM_DIV_FRAC_START3_MODE0		0x098
+#define QSERDES_V8_USB43_COM_HSCLK_HS_SWITCH_SEL_1		0x09c
+#define QSERDES_V8_USB43_COM_INTEGLOOP_GAIN0_MODE0		0x0a0
+#define QSERDES_V8_USB43_COM_INTEGLOOP_GAIN1_MODE0		0x0a4
+#define QSERDES_V8_USB43_COM_VCO_TUNE1_MODE0			0x0a8
+#define QSERDES_V8_USB43_COM_VCO_TUNE2_MODE0			0x0ac
+#define QSERDES_V8_USB43_COM_ATB_SEL1				0x0b0
+#define QSERDES_V8_USB43_COM_ATB_SEL2				0x0b4
+#define QSERDES_V8_USB43_COM_FREQ_UPDATE			0x0b8
+#define QSERDES_V8_USB43_COM_BG_TIMER				0x0bc
+#define QSERDES_V8_USB43_COM_SSC_EN_CENTER			0x0c0
+#define QSERDES_V8_USB43_COM_SSC_ADJ_PER1			0x0c4
+#define QSERDES_V8_USB43_COM_SSC_ADJ_PER2			0x0c8
+#define QSERDES_V8_USB43_COM_SSC_PER1				0x0cc
+#define QSERDES_V8_USB43_COM_SSC_PER2				0x0d0
+#define QSERDES_V8_USB43_COM_POST_DIV				0x0d4
+#define QSERDES_V8_USB43_COM_POST_DIV_MUX			0x0d8
+#define QSERDES_V8_USB43_COM_BIAS_EN_CLKBUFLR_EN		0x0dc
+#define QSERDES_V8_USB43_COM_CLK_ENABLE1			0x0e0
+#define QSERDES_V8_USB43_COM_SYS_CLK_CTRL			0x0e4
+#define QSERDES_V8_USB43_COM_SYSCLK_BUF_ENABLE			0x0e8
+#define QSERDES_V8_USB43_COM_PLL_EN				0x0ec
+#define QSERDES_V8_USB43_COM_DEBUG_BUS_OVRD			0x0f0
+#define QSERDES_V8_USB43_COM_PLL_IVCO				0x0f4
+#define QSERDES_V8_USB43_COM_PLL_IVCO_MODE1			0x0f8
+#define QSERDES_V8_USB43_COM_CMN_IETRIM				0x0fc
+#define QSERDES_V8_USB43_COM_CMN_IPTRIM				0x100
+#define QSERDES_V8_USB43_COM_EP_CLOCK_DETECT_CTRL		0x104
+#define QSERDES_V8_USB43_COM_PLL_CNTRL				0x108
+#define QSERDES_V8_USB43_COM_BIAS_EN_CTRL_BY_PSM		0x10c
+#define QSERDES_V8_USB43_COM_SYSCLK_EN_SEL			0x110
+#define QSERDES_V8_USB43_COM_CML_SYSCLK_SEL			0x114
+#define QSERDES_V8_USB43_COM_RESETSM_CNTRL			0x118
+#define QSERDES_V8_USB43_COM_RESETSM_CNTRL2			0x11c
+#define QSERDES_V8_USB43_COM_LOCK_CMP_EN			0x120
+#define QSERDES_V8_USB43_COM_LOCK_CMP_CFG			0x124
+#define QSERDES_V8_USB43_COM_INTEGLOOP_INITVAL			0x128
+#define QSERDES_V8_USB43_COM_INTEGLOOP_EN			0x12c
+#define QSERDES_V8_USB43_COM_INTEGLOOP_P_PATH_GAIN0		0x130
+#define QSERDES_V8_USB43_COM_INTEGLOOP_P_PATH_GAIN1		0x134
+#define QSERDES_V8_USB43_COM_VCOCAL_DEADMAN_CTRL		0x138
+#define QSERDES_V8_USB43_COM_VCO_TUNE_CTRL			0x13c
+#define QSERDES_V8_USB43_COM_VCO_TUNE_MAP			0x140
+#define QSERDES_V8_USB43_COM_VCO_TUNE_INITVAL1			0x144
+#define QSERDES_V8_USB43_COM_VCO_TUNE_INITVAL2			0x148
+#define QSERDES_V8_USB43_COM_VCO_TUNE_MINVAL1			0x14c
+#define QSERDES_V8_USB43_COM_VCO_TUNE_MINVAL2			0x150
+#define QSERDES_V8_USB43_COM_VCO_TUNE_MAXVAL1			0x154
+#define QSERDES_V8_USB43_COM_VCO_TUNE_MAXVAL2			0x158
+#define QSERDES_V8_USB43_COM_VCO_TUNE_TIMER1			0x15c
+#define QSERDES_V8_USB43_COM_VCO_TUNE_TIMER2			0x160
+#define QSERDES_V8_USB43_COM_CLK_SELECT				0x164
+#define QSERDES_V8_USB43_COM_PLL_ANALOG				0x168
+#define QSERDES_V8_USB43_COM_SW_RESET				0x16c
+#define QSERDES_V8_USB43_COM_CORE_CLK_EN			0x170
+#define QSERDES_V8_USB43_COM_CMN_CONFIG_1			0x174
+#define QSERDES_V8_USB43_COM_CMN_CONFIG_3			0x178
+#define QSERDES_V8_USB43_COM_CMN_RATE_OVERRIDE			0x17c
+#define QSERDES_V8_USB43_COM_SVS_MODE_CLK_SEL			0x180
+#define QSERDES_V8_USB43_COM_DEBUG_BUS_SEL			0x184
+#define QSERDES_V8_USB43_COM_CMN_MISC1				0x188
+#define QSERDES_V8_USB43_COM_CMN_MODE				0x18c
+#define QSERDES_V8_USB43_COM_CMN_MODE_CONTD			0x190
+#define QSERDES_V8_USB43_COM_CMN_MODE_CONTD1			0x194
+#define QSERDES_V8_USB43_COM_CMN_MODE_CONTD2			0x198
+#define QSERDES_V8_USB43_COM_VCO_DC_LEVEL_CTRL			0x19c
+#define QSERDES_V8_USB43_COM_BIN_VCOCAL_HSCLK_SEL_1		0x1a0
+#define QSERDES_V8_USB43_COM_ADDITIONAL_CTRL_1			0x1a4
+#define QSERDES_V8_USB43_COM_AUTO_GAIN_ADJ_CTRL_1		0x1a8
+#define QSERDES_V8_USB43_COM_AUTO_GAIN_ADJ_CTRL_2		0x1ac
+#define QSERDES_V8_USB43_COM_AUTO_GAIN_ADJ_CTRL_3		0x1b0
+#define QSERDES_V8_USB43_COM_AUTO_GAIN_ADJ_CTRL_4		0x1b4
+#define QSERDES_V8_USB43_COM_ADDITIONAL_MISC			0x1b8
+#define QSERDES_V8_USB43_COM_ADDITIONAL_MISC_2			0x1bc
+#define QSERDES_V8_USB43_COM_ADDITIONAL_MISC_3			0x1c0
+#define QSERDES_V8_USB43_COM_ADDITIONAL_MISC_4			0x1c4
+#define QSERDES_V8_USB43_COM_ADDITIONAL_MISC_5			0x1c8
+#define QSERDES_V8_USB43_COM_SSC_STEP_SIZE1_MODE2		0x1cc
+#define QSERDES_V8_USB43_COM_SSC_STEP_SIZE2_MODE2		0x1d0
+#define QSERDES_V8_USB43_COM_SSC_STEP_SIZE3_MODE2		0x1d4
+#define QSERDES_V8_USB43_COM_CLK_EP_DIV_MODE2			0x1d8
+#define QSERDES_V8_USB43_COM_CP_CTRL_MODE2			0x1dc
+#define QSERDES_V8_USB43_COM_PLL_RCTRL_MODE2			0x1e0
+#define QSERDES_V8_USB43_COM_PLL_CCTRL_MODE2			0x1e4
+#define QSERDES_V8_USB43_COM_CORECLK_DIV_MODE2			0x1e8
+#define QSERDES_V8_USB43_COM_LOCK_CMP1_MODE2			0x1ec
+#define QSERDES_V8_USB43_COM_LOCK_CMP2_MODE2			0x1f0
+#define QSERDES_V8_USB43_COM_DEC_START_MODE2			0x1f4
+#define QSERDES_V8_USB43_COM_DEC_START_MSB_MODE2		0x1f8
+#define QSERDES_V8_USB43_COM_DIV_FRAC_START1_MODE2		0x1fc
+#define QSERDES_V8_USB43_COM_DIV_FRAC_START2_MODE2		0x200
+#define QSERDES_V8_USB43_COM_DIV_FRAC_START3_MODE2		0x204
+#define QSERDES_V8_USB43_COM_INTEGLOOP_GAIN0_MODE2		0x208
+#define QSERDES_V8_USB43_COM_INTEGLOOP_GAIN1_MODE2		0x20c
+#define QSERDES_V8_USB43_COM_VCO_TUNE1_MODE2			0x210
+#define QSERDES_V8_USB43_COM_VCO_TUNE2_MODE2			0x214
+#define QSERDES_V8_USB43_COM_PLL_IVCO_MODE2			0x218
+#define QSERDES_V8_USB43_COM_HSCLK_SEL_2			0x21c
+#define QSERDES_V8_USB43_COM_BIN_VCOCAL_CMP_CODE1_MODE2		0x220
+#define QSERDES_V8_USB43_COM_BIN_VCOCAL_CMP_CODE2_MODE2		0x224
+#define QSERDES_V8_USB43_COM_HSCLK_HS_SWITCH_SEL_2		0x228
+#define QSERDES_V8_USB43_COM_CMN_CONFIG_2			0x22c
+#define QSERDES_V8_USB43_COM_BIN_VCOCAL_HSCLK_SEL_2		0x230
+#define QSERDES_V8_USB43_COM_IVCOCAL_CONFIG_0			0x234
+#define QSERDES_V8_USB43_COM_IVCOCAL_CONFIG_1			0x238
+#define QSERDES_V8_USB43_COM_IVCOCAL_CONFIG_2			0x23c
+#define QSERDES_V8_USB43_COM_IVCOCAL_CONFIG_3			0x240
+#define QSERDES_V8_USB43_COM_IVCOCAL_CONFIG_4			0x244
+#define QSERDES_V8_USB43_COM_IVCOCAL_CONFIG_5			0x248
+#define QSERDES_V8_USB43_COM_LOCK_CMP1_EARLY_MODE0		0x24c
+#define QSERDES_V8_USB43_COM_LOCK_CMP2_EARLY_MODE0		0x250
+#define QSERDES_V8_USB43_COM_LOCK_CMP1_EARLY_MODE1		0x254
+#define QSERDES_V8_USB43_COM_LOCK_CMP2_EARLY_MODE1		0x258
+#define QSERDES_V8_USB43_COM_LOCK_CMP1_EARLY_MODE2		0x25c
+#define QSERDES_V8_USB43_COM_LOCK_CMP2_EARLY_MODE2		0x260
+#define QSERDES_V8_USB43_COM_EARLY_LOCK_CONFIG_0		0x264
+#define QSERDES_V8_USB43_COM_EARLY_LOCK_CONFIG_1		0x268
+#define QSERDES_V8_USB43_COM_ADAPTIVE_ANALOG_CONFIG		0x26c
+#define QSERDES_V8_USB43_COM_CP_CTRL_ADAPTIVE_MODE0		0x270
+#define QSERDES_V8_USB43_COM_PLL_RCCTRL_ADAPTIVE_MODE0		0x274
+#define QSERDES_V8_USB43_COM_PLL_CCTRL_ADAPTIVE_MODE0		0x278
+#define QSERDES_V8_USB43_COM_CP_CTRL_ADAPTIVE_MODE1		0x27c
+#define QSERDES_V8_USB43_COM_PLL_RCCTRL_ADAPTIVE_MODE1		0x280
+#define QSERDES_V8_USB43_COM_PLL_CCTRL_ADAPTIVE_MODE1		0x284
+#define QSERDES_V8_USB43_COM_CP_CTRL_ADAPTIVE_MODE2		0x288
+#define QSERDES_V8_USB43_COM_PLL_RCCTRL_ADAPTIVE_MODE2		0x28c
+#define QSERDES_V8_USB43_COM_PLL_CCTRL_ADAPTIVE_MODE2		0x290
+#define QSERDES_V8_USB43_COM_CMN_MODE_CONTD3			0x294
+#define QSERDES_V8_USB43_COM_CMN_MODE_CONTD4			0x298
+#define QSERDES_V8_USB43_COM_CMN_MODE_CONTD5			0x29c
+#define QSERDES_V8_USB43_COM_CMN_MODE_CONTD6			0x2a0
+#define QSERDES_V8_USB43_COM_ADDITIONAL_MISC_6			0x2a4
+#define QSERDES_V8_USB43_COM_ADDITIONAL_MISC_7			0x2a8
+#define QSERDES_V8_USB43_COM_VCO_WAIT_CYCLES			0x2ac
+#define QSERDES_V8_USB43_COM_BIAS_WAIT_CYCLES			0x2b0
+#define QSERDES_V8_USB43_COM_AUX_CLK_PSM_ENABLE			0x2b4
+#define QSERDES_V8_USB43_COM_PLL_SPARE_FOR_ECO			0x2b8
+#define QSERDES_V8_USB43_COM_PLL_SPARE_FOR_ECO_1		0x2bc
+#define QSERDES_V8_USB43_COM_PLL_SPARE_FOR_ECO_2		0x2c0
+#define QSERDES_V8_USB43_COM_LDO_CAL_1				0x2c4
+#define QSERDES_V8_USB43_COM_LDO_CAL_2				0x2c8
+#define QSERDES_V8_USB43_COM_LDO_CAL_3				0x2cc
+#define QSERDES_V8_USB43_COM_LDO_CAL_4				0x2d0
+#define QSERDES_V8_USB43_COM_LDO_CAL_5				0x2d4
+#define QSERDES_V8_USB43_COM_DCC_CAL_1				0x2d8
+#define QSERDES_V8_USB43_COM_DCC_CAL_2				0x2dc
+#define QSERDES_V8_USB43_COM_DCC_CAL_3				0x2e0
+#define QSERDES_V8_USB43_COM_DCC_CAL_4				0x2e4
+#define QSERDES_V8_USB43_COM_DCC_CAL_5				0x2e8
+#define QSERDES_V8_USB43_COM_DCC_CAL_6				0x2ec
+#define QSERDES_V8_USB43_COM_PSM_CAL_EN				0x2f0
+#define QSERDES_V8_USB43_COM_CLK_FWD_CONFIG_1			0x2f4
+#define QSERDES_V8_USB43_COM_CLK_FWD_CONFIG_2			0x2f8
+#define QSERDES_V8_USB43_COM_IP_CTRL_AND_DP_SEL			0x2fc
+#define QSERDES_V8_USB43_COM_DCC_CAL_7				0x300
+#define QSERDES_V8_USB43_COM_DCC_CAL_8				0x304
+#define QSERDES_V8_USB43_COM_DCC_CAL_9				0x308
+#define QSERDES_V8_USB43_COM_MODE_OPERATION_STATUS		0x30c
+#define QSERDES_V8_USB43_COM_SYSCLK_DET_COMP_STATUS		0x310
+#define QSERDES_V8_USB43_COM_CMN_STATUS				0x314
+#define QSERDES_V8_USB43_COM_RESET_SM_STATUS			0x318
+#define QSERDES_V8_USB43_COM_RESTRIM_CODE_STATUS		0x31c
+#define QSERDES_V8_USB43_COM_PLLCAL_CODE1_STATUS		0x320
+#define QSERDES_V8_USB43_COM_PLLCAL_CODE2_STATUS		0x324
+#define QSERDES_V8_USB43_COM_INTEGLOOP_BINCODE_STATUS		0x328
+#define QSERDES_V8_USB43_COM_DEBUG_BUS0				0x32c
+#define QSERDES_V8_USB43_COM_DEBUG_BUS1				0x330
+#define QSERDES_V8_USB43_COM_DEBUG_BUS2				0x334
+#define QSERDES_V8_USB43_COM_DEBUG_BUS3				0x338
+#define QSERDES_V8_USB43_COM_C_READY_STATUS			0x33c
+#define QSERDES_V8_USB43_COM_READ_DUMMY_1			0x340
+#define QSERDES_V8_USB43_COM_READ_DUMMY_2			0x344
+#define QSERDES_V8_USB43_COM_READ_DUMMY_3			0x348
+#define QSERDES_V8_USB43_COM_IVCO_CAL_CODE_STATUS		0x34c
+#define QSERDES_V8_USB43_COM_PLL_LDO_CAL_STATUS_2		0x350
+#define QSERDES_V8_USB43_COM_PLL_LDO_CAL_STATUS_3		0x354
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp.h b/drivers/phy/qcom/phy-qcom-qmp.h
index 06dac21ddc4..11b7e03b4fa 100644
--- a/drivers/phy/qcom/phy-qcom-qmp.h
+++ b/drivers/phy/qcom/phy-qcom-qmp.h
@@ -6,14 +6,35 @@
 #ifndef QCOM_PHY_QMP_H_
 #define QCOM_PHY_QMP_H_
 
-#include "phy-qcom-qmp-qserdes-com.h"
-#include "phy-qcom-qmp-qserdes-txrx.h"
+#include "phy-qcom-qmp-qserdes-com-v2.h"
+#include "phy-qcom-qmp-qserdes-txrx-v2.h"
 
 #include "phy-qcom-qmp-qserdes-com-v3.h"
 #include "phy-qcom-qmp-qserdes-txrx-v3.h"
 
 #include "phy-qcom-qmp-qserdes-com-v4.h"
 #include "phy-qcom-qmp-qserdes-txrx-v4.h"
+#include "phy-qcom-qmp-qserdes-txrx-v4_20.h"
+
+#include "phy-qcom-qmp-qserdes-com-v5.h"
+#include "phy-qcom-qmp-qserdes-txrx-v5.h"
+#include "phy-qcom-qmp-qserdes-txrx-v5_20.h"
+#include "phy-qcom-qmp-qserdes-txrx-v5_5nm.h"
+
+#include "phy-qcom-qmp-qserdes-com-v6.h"
+#include "phy-qcom-qmp-qserdes-txrx-v6.h"
+#include "phy-qcom-qmp-qserdes-txrx-v6_20.h"
+#include "phy-qcom-qmp-qserdes-txrx-v6_n4.h"
+#include "phy-qcom-qmp-qserdes-ln-shrd-v5.h"
+#include "phy-qcom-qmp-qserdes-ln-shrd-v6.h"
+
+#include "phy-qcom-qmp-qserdes-com-v7.h"
+#include "phy-qcom-qmp-qserdes-txrx-v7.h"
+
+#include "phy-qcom-qmp-qserdes-com-v8.h"
+#include "phy-qcom-qmp-usb43-qserdes-com-v8.h"
+#include "phy-qcom-qmp-qserdes-txrx-v8.h"
+#include "phy-qcom-qmp-qserdes-lalb-v8.h"
 
 #include "phy-qcom-qmp-qserdes-pll.h"
 
@@ -23,110 +44,47 @@
 
 #include "phy-qcom-qmp-pcs-v4.h"
 
-/* Only for QMP V3 & V4 PHY - DP COM registers */
-#define QPHY_V3_DP_COM_PHY_MODE_CTRL			0x00
-#define QPHY_V3_DP_COM_SW_RESET				0x04
-#define QPHY_V3_DP_COM_POWER_DOWN_CTRL			0x08
-#define QPHY_V3_DP_COM_SWI_CTRL				0x0c
-#define QPHY_V3_DP_COM_TYPEC_CTRL			0x10
-#define QPHY_V3_DP_COM_TYPEC_PWRDN_CTRL			0x14
-#define QPHY_V3_DP_COM_RESET_OVRD_CTRL			0x1c
+#include "phy-qcom-qmp-pcs-v4_20.h"
 
-/* QSERDES V3 COM bits */
-# define QSERDES_V3_COM_BIAS_EN				0x0001
-# define QSERDES_V3_COM_BIAS_EN_MUX			0x0002
-# define QSERDES_V3_COM_CLKBUF_R_EN			0x0004
-# define QSERDES_V3_COM_CLKBUF_L_EN			0x0008
-# define QSERDES_V3_COM_EN_SYSCLK_TX_SEL		0x0010
-# define QSERDES_V3_COM_CLKBUF_RX_DRIVE_L		0x0020
-# define QSERDES_V3_COM_CLKBUF_RX_DRIVE_R		0x0040
+#include "phy-qcom-qmp-pcs-v5.h"
 
-/* QSERDES V3 TX bits */
-# define DP_PHY_TXn_TX_EMP_POST1_LVL_MASK		0x001f
-# define DP_PHY_TXn_TX_EMP_POST1_LVL_MUX_EN		0x0020
-# define DP_PHY_TXn_TX_DRV_LVL_MASK			0x001f
-# define DP_PHY_TXn_TX_DRV_LVL_MUX_EN			0x0020
+#include "phy-qcom-qmp-pcs-v5_20.h"
 
-/* QMP PHY - DP PHY registers */
-#define QSERDES_DP_PHY_REVISION_ID0			0x000
-#define QSERDES_DP_PHY_REVISION_ID1			0x004
-#define QSERDES_DP_PHY_REVISION_ID2			0x008
-#define QSERDES_DP_PHY_REVISION_ID3			0x00c
-#define QSERDES_DP_PHY_CFG				0x010
-#define QSERDES_DP_PHY_PD_CTL				0x018
-# define DP_PHY_PD_CTL_PWRDN				0x001
-# define DP_PHY_PD_CTL_PSR_PWRDN			0x002
-# define DP_PHY_PD_CTL_AUX_PWRDN			0x004
-# define DP_PHY_PD_CTL_LANE_0_1_PWRDN			0x008
-# define DP_PHY_PD_CTL_LANE_2_3_PWRDN			0x010
-# define DP_PHY_PD_CTL_PLL_PWRDN			0x020
-# define DP_PHY_PD_CTL_DP_CLAMP_EN			0x040
-#define QSERDES_DP_PHY_MODE				0x01c
-#define QSERDES_DP_PHY_AUX_CFG0				0x020
-#define QSERDES_DP_PHY_AUX_CFG1				0x024
-#define QSERDES_DP_PHY_AUX_CFG2				0x028
-#define QSERDES_DP_PHY_AUX_CFG3				0x02c
-#define QSERDES_DP_PHY_AUX_CFG4				0x030
-#define QSERDES_DP_PHY_AUX_CFG5				0x034
-#define QSERDES_DP_PHY_AUX_CFG6				0x038
-#define QSERDES_DP_PHY_AUX_CFG7				0x03c
-#define QSERDES_DP_PHY_AUX_CFG8				0x040
-#define QSERDES_DP_PHY_AUX_CFG9				0x044
+#include "phy-qcom-qmp-pcs-v6.h"
 
-/* Only for QMP V3 PHY - DP PHY registers */
-#define QSERDES_V3_DP_PHY_AUX_INTERRUPT_MASK		0x048
-# define PHY_AUX_STOP_ERR_MASK				0x01
-# define PHY_AUX_DEC_ERR_MASK				0x02
-# define PHY_AUX_SYNC_ERR_MASK				0x04
-# define PHY_AUX_ALIGN_ERR_MASK				0x08
-# define PHY_AUX_REQ_ERR_MASK				0x10
+#include "phy-qcom-qmp-pcs-v6-n4.h"
 
-#define QSERDES_V3_DP_PHY_AUX_INTERRUPT_CLEAR		0x04c
-#define QSERDES_V3_DP_PHY_AUX_BIST_CFG			0x050
+#include "phy-qcom-qmp-pcs-v6_20.h"
 
-#define QSERDES_V3_DP_PHY_VCO_DIV			0x064
-#define QSERDES_V3_DP_PHY_TX0_TX1_LANE_CTL		0x06c
-#define QSERDES_V3_DP_PHY_TX2_TX3_LANE_CTL		0x088
+#include "phy-qcom-qmp-pcs-v7.h"
 
-#define QSERDES_V3_DP_PHY_SPARE0			0x0ac
-#define DP_PHY_SPARE0_MASK				0x0f
-#define DP_PHY_SPARE0_ORIENTATION_INFO_SHIFT		0x04(0x0004)
+#include "phy-qcom-qmp-pcs-v8.h"
 
-#define QSERDES_V3_DP_PHY_STATUS			0x0c0
-
-/* Only for QMP V4 PHY - DP PHY registers */
-#define QSERDES_V4_DP_PHY_CFG_1				0x014
-#define QSERDES_V4_DP_PHY_AUX_INTERRUPT_MASK		0x054
-#define QSERDES_V4_DP_PHY_AUX_INTERRUPT_CLEAR		0x058
-#define QSERDES_V4_DP_PHY_VCO_DIV			0x070
-#define QSERDES_V4_DP_PHY_TX0_TX1_LANE_CTL		0x078
-#define QSERDES_V4_DP_PHY_TX2_TX3_LANE_CTL		0x09c
-#define QSERDES_V4_DP_PHY_SPARE0			0x0c8
-#define QSERDES_V4_DP_PHY_AUX_INTERRUPT_STATUS		0x0d8
-#define QSERDES_V4_DP_PHY_STATUS			0x0dc
-
-/* Only for QMP V4 PHY - PCS_MISC registers */
-#define QPHY_V4_PCS_MISC_TYPEC_CTRL			0x00
-#define QPHY_V4_PCS_MISC_TYPEC_PWRDN_CTRL		0x04
-#define QPHY_V4_PCS_MISC_PCS_MISC_CONFIG1		0x08
-#define QPHY_V4_PCS_MISC_CLAMP_ENABLE			0x0c
-#define QPHY_V4_PCS_MISC_TYPEC_STATUS			0x10
-#define QPHY_V4_PCS_MISC_PLACEHOLDER_STATUS		0x14
-
-/* Only for QMP V6 PHY - DP PHY registers */
-#define QSERDES_V6_DP_PHY_AUX_INTERRUPT_STATUS		0x0e0
-#define QSERDES_V6_DP_PHY_STATUS			0x0e4
+#include "phy-qcom-qmp-pcs-v8_50.h"
 
 /* QPHY_SW_RESET bit */
-#define SW_RESET                                BIT(0)
+#define SW_RESET				BIT(0)
 /* QPHY_POWER_DOWN_CONTROL */
-#define SW_PWRDN                                BIT(0)
+#define SW_PWRDN				BIT(0)
+#define REFCLK_DRV_DSBL				BIT(1) /* PCIe */
 
 /* QPHY_START_CONTROL bits */
-#define SERDES_START                            BIT(0)
-#define PCS_START                               BIT(1)
+#define SERDES_START				BIT(0)
+#define PCS_START				BIT(1)
 
 /* QPHY_PCS_STATUS bit */
-#define PHYSTATUS                               BIT(6)
+#define PHYSTATUS				BIT(6)
+#define PHYSTATUS_4_20				BIT(7)
+
+/* QPHY_PCS_AUTONOMOUS_MODE_CTRL register bits */
+#define ARCVR_DTCT_EN				BIT(0)
+#define ALFPS_DTCT_EN				BIT(1)
+#define ARCVR_DTCT_EVENT_SEL			BIT(4)
+
+/* QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR register bits */
+#define IRQ_CLEAR				BIT(0)
+
+/* QPHY_PCS_MISC_CLAMP_ENABLE register bits */
+#define CLAMP_EN				BIT(0) /* enables i/o clamp_n */
 
 #endif

-- 
2.34.1

