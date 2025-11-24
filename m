Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EE6CFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 15:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08DB083E62;
	Mon, 24 Nov 2025 16:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ik+sROMB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ETqDL6MF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E6BF83B85; Mon, 24 Nov 2025 16:55:53 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7442183E62
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 16:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AOEvXIi706862
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qaHkUg0Nb1x
 gZ37RYove6jDoAAQ/IE0PN7sTeoNpiNY=; b=ik+sROMBr7jXN1dfkpNMGsm+jU7
 kL2n6ZKiKz1U08CVkITVuZnH8iEemesnM8YSACfm+yk0t93XYVhcFT9S79NL7GaA
 Q3T9Dou8KYmUmP2Mdv7KI+LrdXRuJTtsN887A/y7ynuIpiB6oRB+cTRNR3dDSIUt
 CyB+HQMGlz7wj0xmG+M11Y7Bkx9BgNrnQk1dTT+ICxxIsvqtqx5cu8BnkbEldcWx
 gUevqTPGRNT7Hb696bBtCQs3gEg+dOUjtVXkPsJkDfSzlLf191hMa3BFnwJcGyIt
 8ExL3v/y77l9dRHuHcT4jS7HmHs9gRvaEQtmW1U+7zrGT6cfp1uEWLd6cnA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amsk685wx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:55:49 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7b9208e1976so9603659b3a.1
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 07:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763999749; x=1764604549; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qaHkUg0Nb1xgZ37RYove6jDoAAQ/IE0PN7sTeoNpiNY=;
 b=ETqDL6MFDfHVE43uP20epZ6rTgs36l3IWPuwWZINgEgICc57Si+GOxmUzfi3HekY72
 ++eNxVPoWw8MkKxIoNHaOUwKRotlQ44eeO0SGjN5eRSudw9zoWdVb6AB6XPZDhVjyE9E
 HLnIebrcZ/JNDLE5Os9x//l1H9oXBlUHKcK8rMWNxQc4NKIrxJMZKBPB/KTPTfjdXIun
 GkNfYYz0BjH+Xg+2Nlm/1PWnKyLcI+233NiOU7may1v/CtNrbOxPqK49LCNje51dYUw2
 Qq2G+0xA2mrsaELgMmyJYpjKon/pDfedUU1ZsGGy0m0Ahz8OxevXq8kkBYYkB+1D7hm1
 tavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763999749; x=1764604549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qaHkUg0Nb1xgZ37RYove6jDoAAQ/IE0PN7sTeoNpiNY=;
 b=nakTApstzTO2oP4fOxz8VC3tyLbQAlpfCUhvbWucCU88wB4d2vw5vlQRAYu1sQM+O/
 uB5/SK7BC2rMvBgA8nihgS5DtqLUgkgGqJiL7vIXYSrJ6pcOocrBrYvH1Hyp4OJu7P1d
 +9NWFWu+VJI0M0YlN9ZAg61JXsBR9uzgLXbBuavOEBc4tIYHnCWV2qQKR3UMwj2Y5WgJ
 X4xU2iXMEXkwc+JOYzFdSe6zsxSQlE+YA5PBJtAiXYBEgL0+0MAr4/+OGqWKjHNLa9po
 ggVfNYQaV2G8YvwKN1fq5tROlh2oR+dhgC6Ud+0MrSZd5W1UWPoZvNziQnHtpJ5/nK9I
 3KlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqN7tL6Qr70/6zl9p/n8+rAUaISKHLQPDDlGJLQW6JCTMoYxKGiKyGXjiAIck5vZcx2ptmMAU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/qW/08BHdG5Z1S3UdFT83bQWCUP3UN8M00jIkXM7D9dms7XJC
 wR4UyTUcM9MyAX0eu3IwOnIcFIvoo743bLBW2Z46/oj7umpDgNz7SQrrbE6629TfBRkPTF06sEi
 vLSD9Z4D8jRuTpU1Abiu4i+z8cDPn5WR4TqyGDUq8fmwFviud2d2WCabt
X-Gm-Gg: ASbGncsxQaBeT38btm13bKd2C5WEG0XZuuEr24m9+++BsCKI3iOckvE68OMmcXuxJDG
 Hua1s3wDLtS0W7PB/yBskQWSr82h684OjWlJa/IBUWmw9KXfB39L6jtvUPoJrxq19ut7PFK6gL+
 lE1ijkYnD8aZij7hihTHbDqe7cfWYtottTsj+d6Vzn3xXLzKexYl+06vPVhg/eT7iplY/hNkMA1
 KzBVe1BaLRcsc5PUDvKriIC17umyusDCVVKWVtC6iCplSGkauW6JaE6C9bu3r0MGFg2pxrNp774
 YMSxRjM9Mvd5BVCURZgQBF33mAed2tYNWe0z+j5RnYbTS/WdXhK0avISQ6/0PXN1VlCIHvZVxaR
 klayiuD70tqyAUvFXXcmfZA+8pxRZEFMAzDHaHlv7mxJE9R7uS5GeBCR1bX8+/8qajO2aaJxTSc
 sipkMtO1QBnH5+v/P+BC4pbX3FMJOMTiyEz43lTQ==
X-Received: by 2002:a05:6a20:9389:b0:35d:8881:e6c6 with SMTP id
 adf61e73a8af0-3614eb0ff86mr12847959637.19.1763999748863; 
 Mon, 24 Nov 2025 07:55:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1pJeWXp5g+NQe7WZlrmoXiD1gY4Hc21SnIvxMMqlHPlazJiNZR83gZu1k+ekyvMTXDLbKLQ==
X-Received: by 2002:a05:6a20:9389:b0:35d:8881:e6c6 with SMTP id
 adf61e73a8af0-3614eb0ff86mr12847906637.19.1763999748337; 
 Mon, 24 Nov 2025 07:55:48 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c3f023fd82sm15254884b3a.42.2025.11.24.07.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 07:55:47 -0800 (PST)
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
Subject: [PATCH v2 5/7] arch: arm: dts: qcs6490-rb3gen2: Override USB3 PHY
 clocks
Date: Mon, 24 Nov 2025 21:25:01 +0530
Message-Id: <20251124155503.2839766-6-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: M0dn2am1-QR17CJI-k-gHnd52_jRkn2v
X-Proofpoint-ORIG-GUID: M0dn2am1-QR17CJI-k-gHnd52_jRkn2v
X-Authority-Analysis: v=2.4 cv=WL5yn3sR c=1 sm=1 tr=0 ts=69248005 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=tu5VpDzJmJffWT5g6q8A:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDEzOSBTYWx0ZWRfX/V5j26a/bvu/
 rQl89jplNOWaN+qgMiNKv/RD2Oa7jdRun7coumJn6226FgZEsSa9BxXyZZANbk0Hes5JihcbX46
 uVdiU0GyHL5U+ONJ7PfCG2XxURy4pa1GtNblPwYDIavpIYsBTjr/FdI0IjO20T97UmYr/HUtKIQ
 tndp3+NjwLyn2piabm8Waa4ZwcJEo2y3lTI4mfjIaVLjA6yScRSbf6GWiySEs+tS8V5G9iV+63Q
 0dYt7NnrwybD+TVnXwIN3o1/rxzwkVFu50yFw+bNWiYuEsussmPi5IgGhoH0lCnQgoRiZyZpocI
 161M3v1FIGH5W58D41CMb2MK/CS26eacs/j51V7e/vvMl+QHluUAOem0OkGoczwe4L1Y1KlxkpX
 uBBJJlMQsWAZTYeVfk6ws6mzEz7CyA==
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

Override the USB QMP PHY clock properties to use only GCC clocks
supported in U-Boot, removing the unsupported RPMH_CXO_CLK from
the qcs6490-rb3gen2's device tree.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
index 50674b692ed..14669b50821 100644
--- a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
+++ b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
@@ -22,6 +22,14 @@
 	/delete-property/ usb-role-switch;
 };
 
+&usb_1_qmpphy {
+	clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
+		 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
+		 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+	clock-names = "aux",
+		      "com_aux",
+		      "usb3_pipe";
+};
 // RAM Entry 0 : Base 0x0080000000  Size 0x003A800000
 // RAM Entry 1 : Base 0x00C0000000  Size 0x0001800000
 // RAM Entry 2 : Base 0x00C3400000  Size 0x003CC00000
-- 
2.34.1

