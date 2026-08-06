Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B4DC56205
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 16:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43FDF80E9C;
	Thu,  6 Aug 2026 16:12:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GX1L85ds49uU; Thu,  6 Aug 2026 16:12:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6282080E93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786032760;
	bh=fvL6giPhPA3qduLXv5gQfei7vFbC1qMOTdtQdd0MWww=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=u1ZfdXpbObHMX0C9FHP+yc3DiNwv8OezuE5d1sIvtmmL19j5agPVvoKcMPBdFaUL5
	 hAX1dvG/FU1TPm/Mtxw+UJAtd71MzM1gEtxpRMbjKjSj537gDnDa+zTHyFTWRXH2H8
	 wQGsqNqiOmMYN2AbI1uJ+4UyLPFQ4hotIyOwQjcQAtEk0ZYMNAq54tThsoJJF41fZs
	 f6BTdXLkZ8sY69jhKLio/sQEGLtlB82DCEAvr95CM7T01usA0kwhByz6dljBiRqwfO
	 Z4e3k7B3B8oF7S9y+hjKRUbGlVpY+q1olJtOlwp82rKSJa7Y5PPj0jhuYnhbyC4G5w
	 FyLotiGfAOiug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6282080E93;
	Thu,  6 Aug 2026 16:12:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B8D3D2B6
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F3C1406C2
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:12:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RbA_IG0-q4Kh for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 16:12:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CF9674065D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF9674065D
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF9674065D
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:12:38 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676EmkEf2808153
 for <u-boot@lists.u-boot-project.org>; Thu, 6 Aug 2026 16:12:38 GMT
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvq732603-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 16:12:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cfc52ddc55so30653915ad.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 09:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786032757; x=1786637557;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fvL6giPhPA3qduLXv5gQfei7vFbC1qMOTdtQdd0MWww=;
 b=UiO3EGQTIBH/PnDpkB+UquA6mhCDbyE24TCXVFXbRPmNcuqW0ApFhC+ZH4fCGq+eJf
 XUX6f7BTYXxsgoRDCK0RdLiUNqvJcwvfV5/cq13ufAkWVSveWSV8/axP8ZdsGEOmx4nl
 Yfvr5LD8h2aeHK8d+D+wb7cPuhvPRTEYLh0YwnfGZQYS5UJFTQ6N+zZUWcrbhOOvUQcR
 G9xMg94JXdHBpywmrk2NeKgbwA8WfhpT405ls5MbkpK6aCXOCyGw0deWoudRL+AVxpRI
 okNYrz2eiv5KtGOQGMpa8AkCVaOXKrPUfkjQocpDcafj/QmzM6wI6mYXjy1kJeFyuBQD
 8ZPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpdAsQ7pJdeJoG0/+Up74UqSuk0GeRz8NYiNticmtzMGXakjDf3FC0phPDRcE/U1+B2MaPp7HE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwZY4ZbddRU9MYpMSbRFBCkLeJKOkZ7rH5vMrXdRhP4LbmOvXSQ
 rgbNDquyhMMPjZYEy1Jv1R5uD6C3Cvc3mcULSFHC+3Vbgns1vFW/TWetqvbmDpayzukBNYtv3qO
 xHTC+j6H4fGOeU3YHqpYKZeChr1TG1sBzeArqyFVYfcfGdDAfqUwWhkXoMrKmJSDfe+wIJPv6B+
 OFlUI=
X-Gm-Gg: AR+sD10vVEvlQMULl9eqAa+rApXO9mbWluBPeJRdrXyZq0b6gNS79k4Lm0TrZUA/enh
 LQKX8lGQiyzuXSUFbLUkrgBVNKyfNbxYko/XQqI+NhSoEA1qsnJTLOrybnTU3v+rIWRLCnpqRWW
 y7jctRpRIyiGGwTxCABjx+IZLQHGH8hIB9AqMja7xCiBqChhBNMBnGS6FrXtapUSDblUFWf3a0e
 TwjuP5Aas45GaXYQpWKmurDIGpqyxwWbWkFB9NtoikP/gDi5Rgh7acvDUHV2G23ropPYi62mUe3
 +1sIv1VS43qPWldRoSC69JBwBC9CoI69WHO4VvVSRgYgXWjHJeZe9tX6tSCU+sm6nYOoGUbE1YH
 abbZdhYgQcF91V24LUmVUhMQtK/X0+7b/9zffMVXRHGLsQXSlAFPsBmTt8OYYiWHCNsg5wlhZJG
 z+iQq+VtpFFmOgdl4X9q+kkFgajrfz
X-Received: by 2002:a17:903:faf:b0:2d0:8b28:51ab with SMTP id
 d9443c01a7336-2d106a8aa6amr30653545ad.7.1786032757078; 
 Thu, 06 Aug 2026 09:12:37 -0700 (PDT)
X-Received: by 2002:a17:903:faf:b0:2d0:8b28:51ab with SMTP id
 d9443c01a7336-2d106a8aa6amr30652935ad.7.1786032756616; 
 Thu, 06 Aug 2026 09:12:36 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586777bcfsm43381878eec.21.2026.08.06.09.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:12:36 -0700 (PDT)
Subject: [PATCH 0/7] qcom: qcs8300/monaco-evk: pinctrl, interconnect, RPMH
 clock and reboot-mode support
Date: Thu, 06 Aug 2026 21:42:17 +0530
Message-Id: <20260806-b4-monaco-v1-0-8d7b4e2f4fe1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGGydGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwNT3SQT3dz8vMTkfF0jM1MDw6Q082QLM2MloPqCotS0zAqwWdGxtbU
 Aeem32FsAAAA=
X-Change-ID: 20260805-b4-monaco-26501bf7c863
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786032752; l=1868;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=XmnH83mePepMeLlVHvc6IEE7wpOVn46QDBjlUCV/un8=;
 b=q1aUzR0HW6tjDSNsoJP1WMj7XvH7OjmnsGlt+39qPoxYeqMy7VEbqP2xDwRky75nth36Mx0GK
 dls13jMJjHPB2OgYN2kzcnfkIirnPeFMtEuNiB5E9ryt5bk8Ug4spd6
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyNiBTYWx0ZWRfX2aGR5oKQ04s+
 vPam0XMlcLZdch2DHLuWtAKW1hYrnQLfw2UDVdZbgPU8MsDG5ZgLbGCnSBdC/9ZFICbdjsZWScD
 vUzaHjbPhJxNURnD3/ud0jQz0SPKQ+e9OEouE9vG8t8UgRTocxnoXyXeaNCD78w6k1xi3n2cKOt
 NCIpx5CriDQCcCFbhjSXOE/BCZiR3oJnwcdiezDvwvYjKJQ+o4HV8dEnN7gs7SueVZMcaDdmeYI
 uTb+n+Q4xUX7eZ786dJd7lE4NCjFGgqsea8HMKScqoVDObwSUxzhORRPgp1wnoOSB6vx/1doXry
 JnOTMzZ9Y6wdBviYLqygXusyh1obtG85abue+yHp0SDYFQiqlGpMqChayeNv4fXFOTuuaWd+Kim
 LlTEgzeUEXhilNN9r0fOZJ4VVHRU3/4OcntHBHXhE0Q+TjCmd/5oUORRw/JZgYHik/j0NbgJuB3
 7OpwOmhjYBjmK+ekr3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyNiBTYWx0ZWRfXyy6Xl8hSv4Eg
 Z+RydkLtZ5W4c1byINLQBlig7p/LpdLcEfxiWvgPhTUr2hWFp7msSD3ZavANXtPL3a5XcGrywbC
 SpKFDNL1D4HE0ImdrRaXP8PWFruAZJg=
X-Authority-Analysis: v=2.4 cv=EeH4hvmC c=1 sm=1 tr=0 ts=6a74b275 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=wmB8RBNAKKwTtG_2d0UA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: eKPSvPA52t3wA1IhvO7T6m_y_sxjHHdj
X-Proofpoint-GUID: eKPSvPA52t3wA1IhvO7T6m_y_sxjHHdj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060126
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=fvL6giPhPA3qduLXv5gQfe
 i7vFbC1qMOTdtQdd0MWww=; b=V2vHMC8dmv31gOIW/xUhmjPRvX76lc7x8hhP4a
 VuJbNlTWH5xjyioIROrggOEh4+h+/ppUBWqsoh3JUd249tqecJdyYGga+TdJ2lea
 iBQ4Xw7eDbi55BFBBv8wpUgqupxIcQfnL4ZPQZt3IFM5NLtk4I/tWFPg8pg3d9Lx
 Qs1ey213m/BGvYlaQ0n26FYrgcXlsg6gYNVTbxh/3QL9fnXpfk1X0BdFbh8/3e/I
 NDER0G1bqnyy0pWz56FSiObYMbg57cQrHkoTbigujfb5NLMdVDmVC3RaWrjkbqUb
 eQOcEIphlf4GVjtqqS9ZQ73LD8hFJcSxApkeCpMrsu1px3pQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786032757; x=1786637557;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fvL6giPhPA3qduLXv5gQfei7vFbC1qMOTdtQdd0MWww=;
 b=ee54tIihl1OlnwiL7vPBUA9ynI2fB/xdiJ4+avurGJly3ySlXqLp5LzUlLoqSTZR18
 QpCXj8SjcCQheJt5e4KoI1H9U/dnaAo543548chuKYmLz2bmpwQTgQy/RAsmhgGFqgW7
 7efpGwAOuoOCCKBvgG0ajDG/BhVWyzjq/9DNhnYdZrUvlWvhUT/OlEdk8qh+Z6qCCPK+
 18p7XnUK71CGtt0leNKKiKPUMARyD0N2AbhyxELcaIKyWLqVIlmZxGkMboHXx85CZAGO
 Mm1uHH3ExCVwmU78zurtU6szVrdHd61pjPwOI/F6aPjccT+p0kpPl5Ql3Bg79uGYEzji
 dVzQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=V2vHMC8d; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ee54tIih
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This series brings up the Monaco (QCS8300) EVK target with a dedicated
pinctrl driver, interconnect driver, a real sa8775p RPMH clock driver
(replacing the generic clk-stub no-op), and PON/SDAM-backed reboot-mode
support so "reboot bootloader" from Linux can be honored by U-Boot.
qcom_qcs8300_defconfig is switched over to the monaco-evk device tree
and the new drivers are enabled.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Balaji Selvanathan (7):
      clk: qcom: Add dedicated sa8775p RPMH clock driver
      clk: qcom: qcs8300: Extend GCC clock driver to full gate/RCG coverage
      pinctrl: qcom: Add QCS8300 pinctrl driver
      interconnect: qcom: Add QCS8300 interconnect driver
      arm64: dts: monaco-evk: Add reboot-mode support via PON/SDAM
      arm64: dts: monaco-evk: Force vreg_l8a always-on to protect UFS VCC
      configs: qcom_qcs8300: Switch to monaco-evk DT and enable new drivers

 arch/arm/dts/monaco-evk-u-boot.dtsi    |  40 +++
 configs/qcom_qcs8300_defconfig         |   6 +-
 drivers/clk/clk-stub.c                 |   1 -
 drivers/clk/qcom/clock-qcs8300.c       | 545 +++++++++++++++++++++++++++++++--
 drivers/clk/qcom/clock-sa8775p.c       |  46 +++
 drivers/interconnect/qcom/Kconfig      |   6 +
 drivers/interconnect/qcom/Makefile     |   1 +
 drivers/interconnect/qcom/qcs8300.c    | 269 ++++++++++++++++
 drivers/interconnect/qcom/qcs8300.h    |  24 ++
 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-qcs8300.c | 468 ++++++++++++++++++++++++++++
 12 files changed, 1393 insertions(+), 22 deletions(-)
---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260805-b4-monaco-26501bf7c863

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

