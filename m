Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2754EDF152
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 11:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EB3783E16;
	Fri, 13 Feb 2026 12:11:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H5RSQlIT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OCHhTkKN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B5583CBD; Fri, 13 Feb 2026 12:11:17 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68EBA83E36
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D7TGaQ3046895
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7pnLvOkFoNa
 X/mZTO+D0rm8qL9ok+EDjCWC6hQoRPLs=; b=H5RSQlIT+TPrQ5G0bDTiqq7sUmc
 2ESiuqkWJ5HJDo9rda7PhRNzgt8I0zft7U93toMfVMq8O30o02C4hA7n3FComxcC
 P4u4AzA+zvIV9FcgBcVp74rnE4FU4YSUdaJ9HEtoR/FWY4NRWAoyhlz+7kW4ES2o
 rU3T3CRnXte8FKo814MRw9vcpVjVxuC8W4kLQxcPd+nmGhAtOS5LWD24e+/YlYeU
 PpHVFxYUCToD6YXLS/KRU/frVdjIWpv6HXTvIgLo//ZvUgYpbLZDdrJVjwLZbptO
 hVe5NZpZvG2+9luR34TdIm1SQ+kJ3qH3imqf2Ikbs1blMuxjtd6jXGFrBsQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9ps2tkbm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:11:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35464d7c539so836896a91.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 03:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770981073; x=1771585873; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7pnLvOkFoNaX/mZTO+D0rm8qL9ok+EDjCWC6hQoRPLs=;
 b=OCHhTkKNT9kvU5buHRkKRf8fC8JEwhli+EtZX26bmJO+EZBez3ffSDnI9lYNoNh7sg
 4dH9JIZDKtaeVAUVNsyuavDW3DKO/nJmzb9mG+jBud7M5oRO2IavMCjcmvz1S5wMchz8
 sfMXmDARqe+3XdNAwFXCbQDIXDk6rath7zym/yM6hwYy+BW2jhzJwR7Yf9h+XYkL6mYQ
 XhiAnSW+uQ9ihrpce0EbPFY0bsAX393UJSmvP/uw1vHHswa3B0xzTiVXLsL8U+abuLlC
 biS8Au7XILfsU3dQTsXQo26mLS9YoAKhtry0GagxJXSAo+k6Nt1UDR9ApO+Zc9t/nUW5
 EnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770981073; x=1771585873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7pnLvOkFoNaX/mZTO+D0rm8qL9ok+EDjCWC6hQoRPLs=;
 b=HqKn+pyxRwoAWVqkY1caNTuMw/jRGct3I3aRH4f5rfFhTlNmytjLynrdSnMuUB5tjv
 pAIg+O3V90R/H0DeR2akQq8mKN/fiT3zzMVCokuff4qg55qHGL+a7bde6nD7yXqr4bYu
 Plc7fHqpPq5g23b7/jQVJTMtz5/56tk7C25vUAqRPZ4NrjZ4rUNuhf/udllUGoXavGrw
 jtPiDfSNyaEf6oZT52xl4mdOoh/9GyAiw9ROu7gu6TKDBlcV1KQFpGlG75lNTxY7zMlx
 e1znk3fAqP4XuWcWLh8W4x75se2dBKKYn9lX3niz5/jmlbcCo74A193xlhJIzmxXEfRc
 Hb/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMpiGRBL6uY9Jdu9z3+I4XMtgkfEp1cIyzbpjH/n+uTTHJV6jaHBZtxYkVHhTVdseHfRDP57w=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8+f12MYA9mamLy/f16jViKpGRGnQ/KePh/HZVfIzRbhy6kbGp
 uuk+q5nsLv86yEvFsuloCG+YD1K9uobE4rmvgN9M38SHfuagno1STtxoTZKuKEKrPmEMq6PLOTD
 FOTlQWQpaJ0WYYQkdq5oXfQ0Zl+C+2ph0m+v9aSG3L5d9+I1ALsHJ/xtj
X-Gm-Gg: AZuq6aKe6cV19uaTkUa857LfEsi2do4ZmE1PVqSmp8o+t6tNolNT+sCIZ2+Z3EWvn2W
 MoOCk7DPtb+dVkkXLsRxiRadJObR3s13vab8I7f39arV3qgdxarYROMzDn3RYY9GBHO4JZ8t7wf
 HlA5ZuQ70QKZzrz3/DlMu1a43bAC7VkSOuUh8x0bInLo92+3tNgh/Rc3NVox4lA5FE/+ebzXShX
 +8Zer/9Syz7Z9QhjP5Di3Vs/NEG9ATiK99CKo7jFAkzxooXh/XwpUq281OGA0oXxwqjJQqStinZ
 yxKy5X5DH+piwztFAMX8eCHASVlRx0aPsmrHKN1RelHqqKMKNZPFbLvaR4rLAkuPhQR7jq1KaQ3
 czqBl5LaxyuQTes3rvQYjXxSB8++Q3op/52g0LxBGr/Bfcyvpn4Ex7/sHxnB7g8/fDB4ouWIw/A
 vYdL8KJclG3K1sEfGMlbVUnUkXwlfMBrRRwren5zCD
X-Received: by 2002:a17:90b:58cb:b0:340:be44:dd0b with SMTP id
 98e67ed59e1d1-356aadc51dcmr1438392a91.34.1770981072479; 
 Fri, 13 Feb 2026 03:11:12 -0800 (PST)
X-Received: by 2002:a17:90b:58cb:b0:340:be44:dd0b with SMTP id
 98e67ed59e1d1-356aadc51dcmr1438356a91.34.1770981071934; 
 Fri, 13 Feb 2026 03:11:11 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35662f8cc57sm12364399a91.13.2026.02.13.03.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 03:11:11 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: trini@konsulko.com, sumit.garg@kernel.org, jh80.chung@samsung.com,
 peng.fan@nxp.com, neil.armstrong@linaro.org, tien.fong.chee@altera.com,
 miquel.raynal@bootlin.com, msp@baylibre.com,
 alif.zakuan.yuslaimi@altera.com, balaji.selvanathan@oss.qualcomm.com,
 w.egorov@phytec.de, varadarajan.narayanan@oss.qualcomm.com,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org, me@samcday.com,
 marek.vasut+renesas@mailbox.org,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v8 4/4] qcom_defconfig: Add QCOM_RPMH_POWER_DOMAIN config
Date: Fri, 13 Feb 2026 16:40:09 +0530
Message-Id: <20260213111009.1254360-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213111009.1254360-1-aswin.murugan@oss.qualcomm.com>
References: <20260213111009.1254360-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Flrbh4j7DYlDJzVmLAIAoRU7PLcL30oc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4NiBTYWx0ZWRfX9AOh85wqkrcw
 OwbcF4WXvXZJ9ZoJhO9VFD/q1IR9KQ2UaMmJXC/p+/3auWcBEQw16Sdqa9CvrY5w/6MOx/K7jNb
 OIbAVphxZU67OFe/nwfQ2JvMX7vP87uEIDzTgvtxQVbLb6Nj56rlz7p1c0DrxrHfXS8UBljpANf
 ntimlQeO3qhZyONgmwLCJnnM6mqs+N9aZ86ERt8tEPAmyJ/JhUR1h+46gWqJYP3w7PZuCMplbaF
 U1kkztVE+AWlfkohUuwczWxfXFQ3/9mIc9kHDKQ8Xu5i0oo/sxC2BPm0RosrxN5/Xwsqoz/nyD+
 KA7vqy6+wRZGoLce8Ey9bEaxTbskYERbojTUOovA4eqTfC/+eFglUfFXRuUIXv3vTUBg8SixLt7
 0S6lx5qbtT9/SkX2m0zy336YuEnk1dM2tn35aJ/t27DyCIYpMHbLDRsgRwApyId7PQw1HAkcIds
 o+fUvONtYkMwYcZuhgQ==
X-Authority-Analysis: v=2.4 cv=LoOfC3dc c=1 sm=1 tr=0 ts=698f06d1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=49fCDh50KohO0NEO94gA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Flrbh4j7DYlDJzVmLAIAoRU7PLcL30oc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130086
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

Enable QCOM_RPMH_POWER_DOMAIN config for qualcomm devices

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
v8:
- No changes to this patch in v8

v7:
- No changes to this patch in v7

v6:
- No changes to this patch in v6

v5:
- No changes to this patch in v5

v4:
- No changes to this patch in v4

v3:
- Removed OF_LIVE_SA8775P config, since there is no SA8775p specific fixups are done

v2:
- No changes to this patch in v2
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index fe5880de1fd..bced5d6eb0f 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -126,6 +126,7 @@ CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
 CONFIG_SOC_QCOM=y
 CONFIG_QCOM_COMMAND_DB=y
+CONFIG_QCOM_RPMH_POWER_DOMAIN=y
 CONFIG_QCOM_RPMH=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
-- 
2.34.1

