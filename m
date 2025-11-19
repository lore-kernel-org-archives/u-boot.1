Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09182CF34D9
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:26:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 984988401B;
	Wed, 19 Nov 2025 16:26:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KO/+FGC+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NuTiEG3L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27B978401A; Wed, 19 Nov 2025 16:26:06 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E825383FDF
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AJA2eiL3165137
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qaHkUg0Nb1x
 gZ37RYove6jDoAAQ/IE0PN7sTeoNpiNY=; b=KO/+FGC+rNwl7yXeeeAKgSoARlU
 BDhmpiZhBACBPLcjVXoM03RZp8jUCPytyaVRVy3//W8MWP3amczb2kTmYOh2+w4a
 MfodPBMEmaeNT71oQczDkIeIapGA7pwvRIcp+WEzEJP7POCfz1mhPxoj/xUPVbjb
 HrHu74eWWjGS5KX4+4yo2VzOycY0qmVO3zbT/046oTuqgkRjE7sUW/1UeAbsjUnC
 U38wszCqc+4uHLBszs+wC70oW7kKVYlEGR4K5eTJHmpzlzSiidENxv19SvrfmGvx
 SJKgODLkcm27T94ZpLmb7A+MK5rnBEEvHzhcOp3Wy3pZZz7w97MGMU+0mBw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agvqgun1a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:26:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-340c261fb38so13461986a91.0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 07:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763565961; x=1764170761; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qaHkUg0Nb1xgZ37RYove6jDoAAQ/IE0PN7sTeoNpiNY=;
 b=NuTiEG3L8wWX/FzPrnBNphMX8VMxbHRHBbs8tM4DIiBNLR9VedRJ+YWTR6E9tO5wYh
 9fkP3sI145Ng1CI+0XEP2/5DekCMbz20cQ9dKL4FCctDEnmbWRD89WKcPeuvPUNtxwq/
 L+oZVNneE/EcLQdHhKJeqVLAYuJ7cqyyFzLnjmpRNGh1qccGaMo29xRZqwgCWV1kWYVq
 XcL5BN+KsCyQ1OGfKg8buNF/4OHhG/KQqB6CCpAFr4K4x9PcV5iEPR8YBQBihe5QXsiM
 TohIl/P287WvSeIT7F2k7vqilStMOsUl9UOvQR0BVtmmpmXCjpUje+TR4R40zjG8zUzq
 Xo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763565961; x=1764170761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qaHkUg0Nb1xgZ37RYove6jDoAAQ/IE0PN7sTeoNpiNY=;
 b=qV+nuei208JhlXtgYUI1HIOoJHjGYUsf6C1tZd7QaNSMuA2mVGCd0k19iStJk4JaQH
 9c9LgQNeC1qtXWt07sy4KFYTKCAIEB7ZwEDBZPPOtnMN+JE91gfR7LccJIranqnXssO7
 1m/uR9xzlw6nEJJvmSw/OjuElpMse8xSgVblJ34EXGBZJ3+Uzl02wwLHGaXyfLqMdRP+
 gCQZwA7IoHSVHWZI6oTaaVHXVrnmYCSKzu2BN8GZu04JBymt86rYDO2HCed3Qy9i5nW5
 p1Futzp6g/USPnJZhX6XIF7DRxdonKT4CxCo9uQintxXVkN4TRZY93zbC9MRkEVqnq46
 HYVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNv1pSvIoN6mSF5acEg5qw7WIapBLI3odMKuAtWQIacVj3J17WGgNOa2Uwbht8boFlA7mxc+E=@lists.denx.de
X-Gm-Message-State: AOJu0Ywv01v9zKPvaWYn4lS9uT/UNwLiO/0BOgOJAGUO2keUfhAtyN+L
 6SylgSEVp3b7e2Fqv6Ql9xnPZABBDJz+QuQdT+dkFSDVVrOijvMyTpx0HmP+Ge3HqYm+oYdP8EX
 6NXnsUv7LZYNiCiq8TbJfMVcq+5RfhF7BtJ11jnsjgtrtUlqTbxDDtEN5
X-Gm-Gg: ASbGnctLZDB60v5KekzrIrxyZd3PKjgBtfwWGNWzF6ggYqHpFjhVOy+0OslJ6FxH47K
 vUsLvRCkcm7MBD3n4C3m2l3KdGr5YC+VzsaKBysWLMA7P/glKGoDgzHpdORJGYpe6WKZ5e949gk
 5YzEbDvIFCYS2fm4Hh9x2WFGBp+bV+cuGXfyDzy9Gbrtax0o3os1Ds8bvCc6332RSQj7qnHRPUD
 +tJWeDLPiJM4MzlafHPB99iQDP2jYgFgihX5C6MqGvUO9DHxQgaxMFwWXUQbmbAAYjaNG50lOtL
 LEBNMwAOWXg2/HvesPtt/qi8bZQkxWE/D2s2Cjd8ANxBL6R3bnwPCcscY6XBmpgBFaoyGNJoWG9
 VwKrQ9kko7J4lKZnJ74uJUyUiMWq/oG8DbzYg5mCkH7EzmC31Gupbi3jLyj37A1AnYiKY+IIoMq
 Eyb9jJr/ZPryZApKh+OAcv0wW7Cr6fexDglNnoLg==
X-Received: by 2002:a17:90b:58e4:b0:33b:d74b:179 with SMTP id
 98e67ed59e1d1-345bd413350mr3122783a91.27.1763565961492; 
 Wed, 19 Nov 2025 07:26:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGP6wAruNwkg8H8MdasQn3gZlXg3Tbwephuc2lkkt7wwXKTJZ5u4MIkEsE8XEtPbu5HCurKgQ==
X-Received: by 2002:a17:90b:58e4:b0:33b:d74b:179 with SMTP id
 98e67ed59e1d1-345bd413350mr3122747a91.27.1763565961042; 
 Wed, 19 Nov 2025 07:26:01 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-345bbfc8eefsm3083157a91.4.2025.11.19.07.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 07:26:00 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 rui.silva@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, mkorpershoek@kernel.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: [PATCH v1 5/6] arch: arm: dts: qcs6490-rb3gen2: Override USB3 PHY
 clocks
Date: Wed, 19 Nov 2025 20:55:29 +0530
Message-Id: <20251119152530.4175628-6-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pyhK4bOcnpoSLYDkjb43kk3X0yjSVF_f
X-Proofpoint-GUID: pyhK4bOcnpoSLYDkjb43kk3X0yjSVF_f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDEyMyBTYWx0ZWRfX/qxT43N3wKiM
 8yRWl280MhTrHdNRg+l5yV3UoSLt9+BBUJyDSXom4SVVmITH3qspjigSv4190uBtmmGSi0WNtBD
 6AF/o4/qO66OYL9DtVhsg/gnV9Va/x/l6WwhPWqqTywVQ0zcDM8geWCwFrzsNrAetXZd/GjI3cm
 O74RUcT/dREBoxrupWHlO/9fU9PF7gUdwMHjyn5zDSPSn6tmWIhFAjN8oVjWed3/rFBX+Ua4j9q
 7KfAyS1anxXB5uQdsBQIauNrOj0yuD0sPa91V5YcAgDyJu2W2vmGEaYudszwRQVeud8XRTvA5ci
 MMRm0zVUe0F8zmN/K4Bzyi57JF24cTTvbG/vecWdw==
X-Authority-Analysis: v=2.4 cv=LMJrgZW9 c=1 sm=1 tr=0 ts=691de18a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=tu5VpDzJmJffWT5g6q8A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511190123
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

