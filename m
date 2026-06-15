Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5867CD98C7
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 12:19:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9594B84894;
	Mon, 15 Jun 2026 14:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Besf2x3O";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JVvy0lx+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7FFE848BF; Mon, 15 Jun 2026 14:19:28 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBCC983FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FAoW5U3956107
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=beB8lyGIF8y
 mPNEX/bpvj5B3i79i9lV5KHka+tHWT5A=; b=Besf2x3OGDdzzD62rMFzfA9iEGM
 6H5aE5u4OTuFwvoQNWiQC7gz51FRN7I3Xq+1FA2bGKQqoArWQUqpg2YzmPFIVWAY
 3cWWHvv+qaNn2W3FXNEod1v8FrCdU03bN5gPpLOzvGrV3selJS5bZzp024yinkEH
 b0ukuSBX6oXk46BOxlf4VSe7LG/YICb6fMamesNXtrAUN5lAiG+v6yWmRD1BKBdG
 tP9QhOCVRwRcrNbW/C/YSKrZkmM0/dW3rvopT5cA3bZfJaRYenHmlUVbt11SFVXM
 bNKtPQL3eE/l5cVs0oJiFKuTclL5J4bA6ubDOcIKGoTtnbF2LlxNbnBOFsA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eter00kw7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:19:24 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8422a0eee68so4584881b3a.0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 05:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781525964; x=1782130764; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=beB8lyGIF8ymPNEX/bpvj5B3i79i9lV5KHka+tHWT5A=;
 b=JVvy0lx+ruSW92/cAVwwf2+Qa6qIXeA6GWNf4AXU4TWena6fwA42QJGF+V5PJf3cXp
 TTys/jZvmpl+HcuyHleQg4eThXpUm2sZ8TFlmG2vxa9a1aoTj4uQFwIiBmbMusPFfL/n
 KqW7mPXhSpBJjsdhvmvq5B3j+3mL7rtPLohKh9T0xLFj7JmEki6uBnHE9Py61eYmO+Nx
 oNVhwSlDkdXnV7riwniKdn65M3xfttqW++5cYXARmwSvomKrD7pOM/rbwmcWorbvGHc0
 rL/7c3ikEW3Akritqvbq1E7tdtjV10MCEms7ybZOoaje4V3RwsMJTKvbyI7eo5b4hCpy
 TNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781525964; x=1782130764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=beB8lyGIF8ymPNEX/bpvj5B3i79i9lV5KHka+tHWT5A=;
 b=YpCpaVsZxoS6zKBkXnYffbBQ26fE7g2i0UEFJZ7s8lA0YGTcIj+mfdEsGhzkc86ssR
 JPcZcmVAwHk1CNXGsTHmb44abxS8Ole5ByePyh/5v9lFZn8TodkUtG/Cb0LUZYu24Y3F
 MLemjGAr16z+DaBnuNBoXgn1o63l+H0fVNiZBZWIyaTZQo9onQuYcB67TfHF5BbQi8q1
 hwQpad/UFpb3/NLZDeySpVgNiSL5U3T4m3E/oSqSZrdhyDzKCJBrRulWFgudNo1yarrj
 XaHgHmis3kmo+0YXaeT5WC2T5KMoWM0ZvQFeXy4qPOizQcqCDY/TcW/86NAbtVsPRDKT
 wHVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fYGIA40M5fZ/582m8cXoPKbiMq4BLVRyarJre86eYywyOmgHE78YmWkOIV00FaEtPkHFumpc=@lists.denx.de
X-Gm-Message-State: AOJu0YzUO+98wlNVi4o0pbmrjIO4JS/9hEs8m3eSRdc7Wk1FsNlOZct8
 MWbdKVrlL3pKLu4QIcwySaTtVDqOu5he0dEctJFkJ2HI+RJ/0WF8xc6l4U01J1UH9F34Q7hAxF4
 RduUuipoyhqEWXoAYctmLJ1wKk+VqDbEYWkxgNtZpt7S/Ye7NSDZPTbVr
X-Gm-Gg: Acq92OER4qKGU2ra+dNdJLKfoLL1+2tT2vJLMmHnd+oLAZxkg3nbyRWKyL3v7S9l42s
 snqwnPa76jadTWrneFcMHd3V3h8uPQXvg+JFaNtcWdBqGPPU1sozmVn7XUa5D0YkmB/hiKu/Sj9
 GAEgx/PB6+xnZPhbF6i28hnJ+lZWFL6hRsga+IKFGRQNWcqfxiExJCqyvxDx8cF2eS9tK1IMoxs
 cxjkzizQ+ojV0xnX6Q25H+QSuv3TKxQxz9DrGu9o63dlnKLYnL9yMHNMkRjN8I6SSpwymfrTcuP
 +kFg7nwIfNoz9G/fYoke84isY/UO01bX6QNiCz2/+sJduyR7eyMT8EEZmS9aDMcE+svpncPO1eW
 /dvBg7QISYBRTQkWJ6u/iECv4veSlQl+dDyvZJpZzLFsBUsHgWHl00q7GmX6zriE/huH7939es9
 Nc0vRQfI2EHJvClYTXffCFpl441ywK7EeIJJhMt4es
X-Received: by 2002:a05:6a00:17a4:b0:82c:9e00:f958 with SMTP id
 d2e1a72fcca58-8434c9ce62cmr14701447b3a.0.1781525964150; 
 Mon, 15 Jun 2026 05:19:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:17a4:b0:82c:9e00:f958 with SMTP id
 d2e1a72fcca58-8434c9ce62cmr14701407b3a.0.1781525963672; 
 Mon, 15 Jun 2026 05:19:23 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434accae18sm10434823b3a.17.2026.06.15.05.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 05:19:23 -0700 (PDT)
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
Subject: [PATCH v1 4/8] qcom_defconfig: Enable Shikra clock driver
Date: Mon, 15 Jun 2026 17:48:24 +0530
Message-Id: <20260615121828.1798789-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615121828.1798789-1-aswin.murugan@oss.qualcomm.com>
References: <20260615121828.1798789-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -mAVYaH6S9Y_3-4eZWx5ezEZFfu0kMli
X-Proofpoint-GUID: -mAVYaH6S9Y_3-4eZWx5ezEZFfu0kMli
X-Authority-Analysis: v=2.4 cv=UPzt2ify c=1 sm=1 tr=0 ts=6a2fedcc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=rZL31eA30qPnalJFAQwA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX70foGDhFutAb
 LiyGHkFrsoXvQGfdB6pfQ62NWp095x94s56QRfzOSYes5APru9A6yV0lzMr1hjai1frCAF1KFxG
 lbxzIO815x1dZZ+EfI6IcDRw5svXUdd/eLlb/d1w1DuOl6jNP3Q2QyCd3d1mL2IbWX/Rc0bz9Hn
 tUf8i+GzMgmkpklfMOAQAnMfXMgAX8wB+JDRJccB9q4bW0G876vDr6AsRk7TREqblHQECzuacae
 VXpZk2Y1pO2MMFFuijEnAZvgM9iaKCrCwI7+DshXR2Vdc+VPM19qHI/cIXyd4LtE5EwpNkXB6ag
 PH0u1fWfU32f970POnlGHfPaMuBzrfRPJv/6qNCkd+uRNY/PjQWDobxI7pOA7ZXAck0iR+s8hos
 dFYCwfhEvRpzVbkKdwG7k989UQ7wtv1RXb1XSQWrQEo1o8MsNiqIag7Havjt+FN0C+sgUlvBr+k
 Dqb9v+odDstdxSy5CBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX8lPbaQvy/SJ3
 KJLRIUp10aJHkiKmM0SmR4oIZB2zB50rx5EbfrybCIYGgxcMePTqXEtmG9jMO1Xh3VJt782nyzX
 /FBtop1G8dMEQeicCTOa05oFP47S0q0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
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

Enable the Shikra clock driver in Qualcomm defconfig.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index d0d54ec5a70..0f7d9c3e81f 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -72,6 +72,7 @@ CONFIG_CLK_QCOM_SM8250=y
 CONFIG_CLK_QCOM_SM8550=y
 CONFIG_CLK_QCOM_SM8650=y
 CONFIG_CLK_QCOM_SC7280=y
+CONFIG_CLK_QCOM_SHIKRA=y
 CONFIG_CLK_QCOM_X1E80100=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_SCSI=y
-- 
2.34.1

