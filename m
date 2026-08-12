Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4212DC5CFC1
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 01:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5482B40820;
	Wed, 12 Aug 2026 01:12:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pWYUwdq8UEyH; Wed, 12 Aug 2026 01:12:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 40374407FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786497145;
	bh=syb99HMjASyzJju6ZMiMKWB2Q/BQB5kpEwWvHuZQWxw=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=YkKjXN2DidTyhJgfN99rQULB+Q9FMQRABVO+7kKiX/a4KToWuZhttB2PWkHzwNdU0
	 S/VWuE5QjzWm1s/loeqDdxi38O/BimOG0jdHWoqpuavxmajaG9bhSDwaDwDJ91kWw5
	 0jVvrgGeGKdvUWEDvTgifo3eAx7PSpxtbWgtQRAqVVeZj374zCcGq2SuTR0q1NY4pL
	 VN+m0RakmF6Z/OiJNIvm0mjeyDJ06AusdWECK7qTY3VWI90u2wngERW0hD87qhThxx
	 MCuoO0+uYbrTxsS/zJcF+jMWVRJjU3+NJRas8UwS5+Z+uwrLmbzYh0cp0p0E2Khw30
	 3PBlaqxMyuRNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40374407FF;
	Wed, 12 Aug 2026 01:12:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AC2911B8
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A9BF060769
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sDDSVx0EHGTS for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 01:12:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 972DD60633
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 972DD60633
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 972DD60633
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:21 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BNGmxw1754761
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:20 GMT
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049mjrqv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:20 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb7d6ba548eso439215a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 18:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786497140; x=1787101940;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=syb99HMjASyzJju6ZMiMKWB2Q/BQB5kpEwWvHuZQWxw=;
 b=Vq3GaaEIXjqcjsHy3fYAcxwnHbacKXj/tXL+XXBzWVn/bmWrg7X1RbuEJIpaIP8XZJ
 VtHIt4qfrslyqjYyOdxQWv2fNRgyhmq7jwGiisDPdYhX4YuNecn/bAeXIZz9QfnI0mfK
 en3/SM0YYhbpD+plMzX5U6VVldfNSMExWv31Tsu531kF9rjHXxrYi5zPx4QZu+rNO8+p
 jIDzqR5nj8Wo5HpVGsDfjeWFTF44VLdsyhuab26j0Tr40gPR76ymYFgvv9hNxAPOfiRH
 oT4ewyUnD2GwqE5TFS4HgsoT1Ak9oDfvOw9WNO4ew1CfXJ3EYP/fkOVjOHDDZ/1ip9ox
 KyqA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNz0yUHzecOmIZOFKeNtDky6/KmtG0uh4bhqE1UySFoEfao30bpG/h6xWj5GMQTdP4BMeg7xI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yzp0o+NhHqnRjIMVov+bsFAXUpZ/7TddJ6qmZ3PvWeRxh/Qo9J0
 6PMdNgr69AfD1QgnFG40F9wXrhpRLUybCr5E2cGRLti/5gWlp/dbrRQEXcAmIoPY9u6Y35+li/u
 nDWeXrNFD5VC5OzuA7YDkB0rEl+7KQEkAuSF1+sN57OSX59zeos4u7Dy42FNLXxyWxKGnmQI=
X-Gm-Gg: AR+sD13opneA7wc3y+bLCz8/2Ro0pmsB+6ZOC5SOChAa6uUhnEPbFVRRMASMjgYMVvp
 9tGIkXPkNfiOjyM/9PBKKLisS1HKhjIbRFA0wkqElggHhxeBwYzyrFbnbXBaGbmOjbHEzcTZXUu
 +yLtVTfKsNK34+eGTDI3mQVriE3otdzPYyF0kOEyKX5Y+xfnzKsNOj5vdY+2eaJPxUTa8aqO2k5
 vf0vO/VQJl026cDxxm6PfhyIDIxz2kUxY+SrUKBmQ1ifAvXNu9C/Z3Z6R17CwvpmeMQiDyPBMgJ
 zCVzHqtOTR7OgfmJfLhwk+w7LhA7fRk7SpO4fRCMtwYcYe1AjCRuoB1KKcoLNFuFUu+2aV0iuSd
 IvxkQ7llNPEhdWj+rL3Kz/BYG6c9X0aHJA4ixgZJbaR7uqrUZnvfI6SAAs8wZRdfq1Ee1VYVv9I
 7IpU+h+sWHkcGP1Z8i47akTJtbSi/L
X-Received: by 2002:a05:6a20:da14:b0:3c4:3112:33 with SMTP id
 adf61e73a8af0-3cc3f51c7a5mr1341374637.6.1786497139444; 
 Tue, 11 Aug 2026 18:12:19 -0700 (PDT)
X-Received: by 2002:a05:6a20:da14:b0:3c4:3112:33 with SMTP id
 adf61e73a8af0-3cc3f51c7a5mr1341323637.6.1786497139028; 
 Tue, 11 Aug 2026 18:12:19 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31cf6d7a366sm4371725eec.27.2026.08.11.18.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 18:12:18 -0700 (PDT)
Subject: [PATCH v2 0/7] qcom: qcs8300/monaco-evk: pinctrl, interconnect,
 RPMH clock and reboot-mode support
Date: Wed, 12 Aug 2026 06:41:58 +0530
Message-Id: <20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF7Ie2oC/03MQQrCMBCF4auUWZuSxDQtrryHdJGmExuwTc1oU
 ErubiwIbgb+4fFtQBg9EpyqDSImTz4sJeShAjuZ5YrMj6VBcql5xxs2KDaHxdjApG64GFxrO32
 Esl8jOv/arUtfevL0CPG900l8vz9F/ylJMM66sR0USqccinMgqu9Pc7NhnutyoM85fwCPr7jEq
 QAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786497134; l=2236;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=gwJeYZLEYMzECnnDrZRkbTYD2llSKhaV8e9NnHR4KNM=;
 b=/7JBiDS7qiUPCNmerdEds+9LTrpL5Sl/ff7GqXM56FllMejqHjakCtdSy+G5GgSt8Eyc09Zhu
 G2zVv/Cajo1C6si6pERl93FiqiCOsW9AlpZxS6gbmD33qt3EqS9rhxK
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: 8cqrNNm-Tu_nk0pgiM71puZyrS_BT_YD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDAwNiBTYWx0ZWRfXyEYCYDhFkQHM
 yGwgDWRLLgorRqv5eOVCMWWpQVL1VHuoQS/+NnEPV6YkLoWdOrgoFcbVljAJPrixhHqIh6D3WI2
 CbT7LvM3CyFmvfBqMYv8YoDRmRygE8rwAq6Kun0+wn0/ExQTDrnAOJa9y569XnoJhdO8MQUBaiy
 TfEPAz4t1uGyIrle84Oh5ygrUf+qPsS/OlI8JC7dCUz6Xowt29fYGoXmPrabuIPMEfPZuC2bp1T
 IgLUwE4CnJQ1Y3sbTaFA8QMujP9vQBxXTijy08nkBgPJgtbNVWpESsNjmYvuZ368TfgN1iag/BD
 B0WTjP1e/vZ42KpIE+eW1C2FoaI7WngrXlQy/HpxUJYtd7QMQHFJWi0YGQL3+GQ33HxNLEJY9GF
 zRlbMEjW2VCgPHCJc9f4M5dFV/aH8Ar5qVSHfkpOK63wqiXFoNHeszqa5+4LlZzjzrv3g6ymEon
 +Zg51QT5QnfwdGFyOLQ==
X-Proofpoint-ORIG-GUID: 8cqrNNm-Tu_nk0pgiM71puZyrS_BT_YD
X-Authority-Analysis: v=2.4 cv=FbkHAp+6 c=1 sm=1 tr=0 ts=6a7bc874 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ENtaLYsCR2d-Iyqe59UA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDAwNiBTYWx0ZWRfX4ShpVfZeQO6l
 EKTJTaid+qelmr/7D6dXeMiA+c+r8B/4KqyC4Lv721Y0EgfUrO4/7Q7nwg0o+KZ3anyAyU0bLSQ
 BGk/3XV/jEEBqon09MN/SK5sz2OdCok=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120006
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=syb99HMjASyzJju6ZMiMKW
 B2Q/BQB5kpEwWvHuZQWxw=; b=bFvP8NDeT9XLwtYeJD+1JRvIYsC0DruqkkXcV7
 mqL7G6F9y2SJwS2nlZUT2zAZzprjodEVzOAro9DeKiYwVny/ORyZEPLt/7yeR4lj
 VkWFpwYNxasGvIKjysrFho2gQ98F7qrLBEQior6i99c48796prGXyXNF8xAFrWhA
 Hzx+oJi/NLsKy9SoLOwLcCVUjrdAxWcM1qGXAx2QdnZE3/lnLJZ9Ip5CZDf+upGd
 RfUswWZVtVtLRh/S28/7JC7ZhU2Hrj8sMLg+h+JDB2kCeTV0ezh/dAyL/bxgyHpq
 0FOl3pu6FT6iLh9+BFoDxCrGUYsZ2EhAPk42s3FEIqb9LYbA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786497140; x=1787101940;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=syb99HMjASyzJju6ZMiMKWB2Q/BQB5kpEwWvHuZQWxw=;
 b=e7EkbvvxoT92r+bc1AOjpECe9Zw/GNBoTWR8VpRrB26LK5ADUq2a0JzLxQz6FHkXhU
 H2JYtoVakoLIYcaByx/x6OrR457Dm8yfIpR83d+M3FRo6vkzaMtlqxKdLD8iHNRJ4Qdw
 CVFI5yJqyUxqi7nkGP5skrPMBsJPB94jIVZr5bauaFAn6S8cjtiaJ6SVQG8wNnfRdA3l
 fYmZ9VjTANeZVTZ4tNy1XdG0QGUzWqFKXTeoZ7JQEUcBnSLPVIhDHaCA2ONGisyvEYc6
 sdgTqJXzXYMcFXwjwhnFRXIqfEO7bxaMHD1B02X3uLpiIzurbWly7F/4kj16/a3pSypl
 ujEA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=bFvP8NDe; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=e7Ekbvvx
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
qcom_qcs8300_defconfig is switched over to the monaco-evk device tree.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- clk: qcom: split RPMH clock support into a new standalone
  clock-rpmh.c driver shared by SM8550/SM8650/SA8775P instead of
  embedding it in the sa8775p GCC driver
- Link to v1: https://lore.kernel.org/r/20260806-b4-monaco-v1-0-8d7b4e2f4fe1@oss.qualcomm.com

---
Balaji Selvanathan (7):
      clk: qcom: Add shared RPMH clock driver for SM8550/SM8650/SA8775P
      clk: qcom: qcs8300: Extend GCC clock driver to full gate/RCG coverage
      pinctrl: qcom: Add QCS8300 pinctrl driver
      interconnect: qcom: Add QCS8300 interconnect driver
      arm64: dts: monaco-evk: Add reboot-mode support via PON/SDAM
      arm64: dts: monaco-evk: Force vreg_l8a always-on to protect UFS VCC
      configs: qcom_qcs8300: Switch to monaco-evk DT and enable new drivers

 arch/arm/dts/monaco-evk-u-boot.dtsi    |  40 +++
 configs/qcom_qcs8300_defconfig         |   6 +-
 drivers/clk/clk-stub.c                 |   3 -
 drivers/clk/qcom/Kconfig               |  12 +
 drivers/clk/qcom/Makefile              |   1 +
 drivers/clk/qcom/clock-qcs8300.c       | 545 +++++++++++++++++++++++++++++++--
 drivers/clk/qcom/clock-rpmh.c          |  61 ++++
 drivers/interconnect/qcom/Kconfig      |   6 +
 drivers/interconnect/qcom/Makefile     |   1 +
 drivers/interconnect/qcom/qcs8300.c    | 269 ++++++++++++++++
 drivers/interconnect/qcom/qcs8300.h    |  24 ++
 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-qcs8300.c | 468 ++++++++++++++++++++++++++++
 14 files changed, 1421 insertions(+), 24 deletions(-)
---
base-commit: 3fb0c443c5b70f25168c98ad88f8a2c0123e2c82
change-id: 20260805-b4-monaco-26501bf7c863

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

