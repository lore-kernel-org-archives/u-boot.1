Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AB3C4453E
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 06:40:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A939A605EC;
	Thu, 23 Jul 2026 06:40:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H4tTZzZuDC3b; Thu, 23 Jul 2026 06:39:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F0005606F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784788799;
	bh=E3n4EYJ/42E5ehIA/VDfWoXQSRVF7EoHKXmeJjZPeEU=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=qkcV5Yja/XE5TQr/aQ4qFRMzQDd0/P9KasXYbD+XLT65PVtgxYx+YAxYhnZr4TH8M
	 Mvjvo4CKVuI7/ihaRtSo7b3UlcknMvqtb44a0ieenzZBEaULysJlMje6QOYa0NfLGG
	 kfBFE5cvqoVr+x7O2+J0X3mU68vmwXF/ool+6zf1xh4H2aYlvYKgJ+M6XWYE+Wqst1
	 j2isaMfjxUlVn7onck5qU0wfrjCIGovppE3e+jrj0VGXL257KYIIpFx3QnVZmNdVzb
	 fZLeQfr47vvR7Wob2+FvIMVcuYxakPLIZ4e0NZgpd5zDreGzldbEInGloQwd37VVX/
	 58tA3Lz3pYd6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0005606F0;
	Thu, 23 Jul 2026 06:39:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 336BB39E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2515B80E2F
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:39:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UnSBy2IYOAYe for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 06:39:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4654480E2B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4654480E2B
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4654480E2B
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:39:55 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N6AkCR3144957
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:39:54 GMT
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjxm13sc5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:39:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cce870a060so8252035ad.2
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 23:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784788793; x=1785393593;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=E3n4EYJ/42E5ehIA/VDfWoXQSRVF7EoHKXmeJjZPeEU=;
 b=A/366IV3jrQcpdU27bD/3toKtGfxOWwxy7mB+MtBXBDQ6WqLNIqoAq+OzQj4E9pehs
 iGJksi6b2gLJ26uQS9xZMxerpkKR8P6rYP17XigdsaWushdOHuq96bxoRWe6jLGDLgXj
 h8TL7i9Wk/xMOfJJE+KMKLstAGrBM3dcOKxtpyqpNNd4NY8mYup8sla/cSCWa+1pbgDh
 4AMOzkujUI7c16RMEnt66eJNT+Or+XuWl8Or7ehGgi+qh/f4ZeoDGgNu93VO5BdqZ+k4
 pVY6rsBnreTqArVz5/nNrllaG1tFzRkTTaKnL00eLdd5zeYWAxh7JsbZRCAlLUGQJyt/
 dB1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqyzjghgsYiBozcQzd9uLbsUwVNThyrXeOiUFBsP5jbCTLBrvK/UzY9Wj1r0n3sDVB4dQFmRPo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzT5dygPCsOzJEcm04T0Tbf3C+WPTzwhT8sJrzXNuND4JgS3z+V
 qwzyBbtmF/IBPSD6fY3EBqxJC820QbvIMnsXENiz2V/9446rfoI58JMTq+aAkcPqFkLOG23wbIb
 mR29yo0QQ1IfHQKikhk3rtgC6o8rUXzGwdW8EO6Hh2k6ER+XNpkkat6RewwrAHM+4zwBGUAQ=
X-Gm-Gg: AR+sD129qRPDxfa6uZQGe8dZG7nuPXAApuskLgA7Vz2LLy5bRck812D5qy65ervkFFw
 bY15KAa/lGkJsNaROC93o4xNsJxRNkm3ZztfxDj35n1nLVvbdje46ytlapdB1vV97MtYhhFd5aa
 2YI0PC/Mg685UJHOpMRFGvNXjcgOXi22u/q2Rl/aKF2MlZd0K4GfQ3297TwqsZvrk4zg/tcmB2u
 U4fqMxa1+QoBZ3z3WLZHqLWqaJUxdwCIYHY3hnwC8De+sizFGDjFJau94SVyH1evNoNcIzYtCvI
 VvyzZ+Ssg/DbANCuEzZ6hmEq5iYidQIB7NDLUF51XxIsx17NJI0MZhcoRX8BZhih6eKK4e3P87Y
 vddjakGbFZ6jePKUqFvbuvOEg6KUUui4nLMjgHxVtyXv62S/3yyDVbREqX+ozRes3eM58puU3uc
 3WKH2b4EDgWiN3vNPB2XJ5sHlTB8Mm
X-Received: by 2002:a05:6a21:7303:b0:3b3:f46:1efa with SMTP id
 adf61e73a8af0-3c44b18ce94mr1695758637.42.1784788793314; 
 Wed, 22 Jul 2026 23:39:53 -0700 (PDT)
X-Received: by 2002:a05:6a21:7303:b0:3b3:f46:1efa with SMTP id
 adf61e73a8af0-3c44b18ce94mr1695722637.42.1784788792837; 
 Wed, 22 Jul 2026 23:39:52 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147dc6781dsm17496758eec.9.2026.07.22.23.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 23:39:52 -0700 (PDT)
Subject: [PATCH 0/3] clk: qcom: use GATE_CLK_POLLED for CBCR-backed gate clocks
Date: Thu, 23 Jul 2026 12:09:45 +0530
Message-Id: <20260723-clk_gate-v1-0-9549cad4d097@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADG3YWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNj3eSc7Pj0xJJUXcNk01RTk0SLxFQTcyWg8oKi1LTMCrBR0bG1tQA
 bC/uWWgAAAA==
X-Change-ID: 20260723-clk_gate-1c5e54a8ae47
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Ajit Singh <blfizzyy@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784788788; l=1035;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=7UaHJHhhB1B1tbhr5HaYuKRzwn3E3nIS6c13ynBigo4=;
 b=yiaZc6TR9pjAgFbh+fjURmVftOXNLnPk7OOcdv2Hj8WwPbrj7u6eNmiDQ4AmSvzflKGd5qv1n
 A5gNhGde8AQC6zTAbP1IkL87E3lOE0BCHcdC1UGMzZtl/JyGApj910J
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA2NSBTYWx0ZWRfXykYjl1PjmrLy
 cSs+SYyzeCkmVg2UbySFmrizu8BhKDEha2aYleFsptFfPt0FoWjVKAVOfdvFhi4LPnSMofsBl8T
 diLGAWxtMH3rxNr6KU3sM8IJkjbh8jU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA2NSBTYWx0ZWRfX/GrAqfT+4bm0
 USwn49OQSI4I9pqdJSRVst/AsJsKahBZKw2LV9nrN8ZCGRW9wjL2C83bsHxXBJVhAkUUKX4pVH9
 u2p6A8ANR284avMeV4wXMBb1fur0Nmx7ZYV5mpKNjkkNoCt4lv7JAFQWWD2y+MeTuNxnqL7h9TX
 uRUcWUrqYZEHX6wR9I40PZGEX3VZTXjPv5Htw0rulsdskLSbotQiO0Nvo0klGEk37AxuhW2ccEY
 rSs8BY48fmdyUho9mP+ytMtXmEacmVIZ3C3Ej5OJMoVc6Z7mgSXT7WQWCsjEroS2c0FpiJm3/Dy
 0J0sq732Zrduv86AWMIIw17jj8Zy4Z0dYd1lYuM1n5hAvReQmmRzErfcykjEKpWAcC+w8jRFk6P
 dt+piAqu2n6K43qNu1WG8lSdzgMnuhck3bpvWcOTrbX+6KSePTKBg2B1Q0tGXDeic5gU1R2kNJf
 x6DF4v2xxmqfDeghfEg==
X-Authority-Analysis: v=2.4 cv=Rsv16imK c=1 sm=1 tr=0 ts=6a61b73a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ibkjCfJP2SEpUh-meP4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: fFwooJrZ89chOfGLW75e-FYj9hfEnTUD
X-Proofpoint-ORIG-GUID: fFwooJrZ89chOfGLW75e-FYj9hfEnTUD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230065
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=E3n4EYJ/42E5ehIA/VDfWo
 XQSRVF7EoHKXmeJjZPeEU=; b=HTUvO6VANC5xLfFWdl/cxsGp4SPn6tHyrDnGYz
 5uh5VT6SMH7DaLDUY0yGSaGkN+Udht9eipZrgr+G2c934T5iVNfaEsAw7uhZzFN0
 8zLsQDOUPcfGEy0MezhmTBQJ+Y8X/TgIQNbeb6KoOOUDtco+9eigQV14GTVbUtfN
 k+CFvIt9ZAmop+hUoHeeS13cOO/3pJAajP9mAyNODY5lGoYqLo8Dfg9aGL5hYw/6
 +Gkb7+76ZF81wO2Zhqdc9DgZNuKAgNvwTv9gTADEGCJSWuW5Uyczo8xMQcXriEbc
 LZruWt60hrFm7HHV/Y9vPIxYTjljQtx24nc3bnF5ivsXEoSA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784788793; x=1785393593;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=E3n4EYJ/42E5ehIA/VDfWoXQSRVF7EoHKXmeJjZPeEU=;
 b=SXZtc4DKz5lmg3y0I8xgkvFzdgMGGpj3jtv7pmRiXM73YqobwMRKA8MiiuLwo2/J/a
 Bji/lLD0Obkb9qS79BguUlRFUm7Xbr9z55nSPDGdFWy0gyqgCMYwBkLC5Co3tVrQJlQY
 aWRNS3DZ5yLR1wsAa+ZZ2HZ+bnEcadUCLr7eLUZbBIGlSjtkj2oETBUqqXSdcuCJIW87
 3wnD4aExtCCGv2s4qEJIW4qlOXT/i70lshUwX0jnP4Wcb19DZMxocdn7T5kMNvVGEweR
 UFaTCdYzLmLKy06jGE1TyxC1E6HGwkVtkgO6y0sGVwsCX8IdDAtbCKzO0AMKwYSOCcbj
 ACog==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=HTUvO6VA; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SXZtc4DK
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

Convert CBCR-backed gate clocks in the sa8775p, sc7280, and qcs615
clock drivers from GATE_CLK() to GATE_CLK_POLLED(), so clock enable is
confirmed by polling the per-clock CBCR status bit instead of assuming
the enable write took effect immediately.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Balaji Selvanathan (3):
      clk: qcom: sa8775p: use GATE_CLK_POLLED for CBCR-backed gate clocks
      clk: qcom: sc7280: use GATE_CLK_POLLED for CBCR-backed gate clocks
      clk: qcom: qcs615: use GATE_CLK_POLLED for CBCR-backed gate clocks

 drivers/clk/qcom/clock-qcs615.c  | 44 ++++++++++++++--------------
 drivers/clk/qcom/clock-sa8775p.c | 36 +++++++++++------------
 drivers/clk/qcom/clock-sc7280.c  | 62 +++++++++++++++++++++-------------------
 3 files changed, 73 insertions(+), 69 deletions(-)
---
base-commit: de02bc0eccb76aec8272abed651c35ab120f4844
change-id: 20260723-clk_gate-1c5e54a8ae47

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

