Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035E0E6749C
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 11:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EFF2840C3;
	Mon, 22 Dec 2025 12:52:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XBmcQiZ9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jI7SoixG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 112D784042; Mon, 22 Dec 2025 12:52:24 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB18D83F64
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:52:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BM8DU17101413
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 11:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=85gkO+xRE3Q
 EgsElQo8dl7869tJvBKeOFLDserG9pEM=; b=XBmcQiZ9sWqOMM+X9S8syc8h2CV
 hoaFZHbHq06n3vdPEfQzwMqtYt93zuk8SpQHIe2E3kyhPLbs0yXNT4jT1mgJ6Gzn
 U97a7uMFbJZM+tdDa1sXllCJrBp3Pu1V7LDPL3flAJvEHwXaNfOp1Bs92va5TJUW
 m34CkJa2mm0dMdwQ9mC+kl3AGRNYMPB23zkpBhoQhk205yOUGiaTGLMJvjVETI5s
 nZmzXk2kVzrJua7kvTERHZVcVOnmaawJ0UiR9VOe1y0qQg/5q2hrCYwGeRbATtFq
 NV8646BmVjmoCzR5I263cMKgnNdySHhHAzsxNZ0AdqzQtsLgdILD021Yj0w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mracvar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 11:52:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-29f13989cd3so119406565ad.1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 03:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766404338; x=1767009138; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85gkO+xRE3QEgsElQo8dl7869tJvBKeOFLDserG9pEM=;
 b=jI7SoixGDMHveNMH1cMjLe2lEB4zqHZhE15nMLU0UlklODYK5nDZ2oC2iVtWOFe27E
 YssClDAzPkQx4ZDVTZtxzOPunRVQvHMjCBwxDPRPodfNOdYgsNvV+AthdC2YpgTC4CpO
 8yYraTK/plGR03t2MfmlAs5plyK0wELN2+WbHTRgIde8EO9QU/ZrCQRbANq5lbUMHjlh
 ob/YE/peSRCOmxduHCrGw6P4WazQJk2Wu0FmofsOSN5XP4xdzx889bqlixnLQbOKAitV
 cbswL5qqkfR1viQZCDPYC4TIA/7TgeL8rHo8Wl8WM12mvaC0KGvJf6wmaHLsNbDSVljH
 yaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766404338; x=1767009138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=85gkO+xRE3QEgsElQo8dl7869tJvBKeOFLDserG9pEM=;
 b=bVsikIQ001Bt9hUIdMjuKUt8qfJg3XcR5RFMOk6w4yzShxrE4QyaZv1bwgCI5i4HcD
 OAmy3wztEnnhd8ncaJkVgma5T9xjMNSdCuhbs7ddTZlVR8CY7h9Zz0QhaXj1U3JnIfrS
 6MLs6ZK7EZ9MwFOul0LO5rkqzakM36veCgul6Q6loLUfvK8k7odxVlARD6R/w1ieyrJb
 0bz/xQFrDVgJPRz8m8y9foJaT1UaXyZGVfuOfrEkisD9pToYHyBcWwFM2XlQqI7Jp1oL
 Ep5X3MuNZK1S7/+e3M8JmEHbLeRN6WmzM/H/StqEt8KTMhm9Mgsv1ijaWRHhgI+aCrBx
 e2lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB1fqjBvBOCoSKCAp4BRLB94sT2hgh2W2xgNZl20JM5otZykE+VfceL06+UUYGKa/KcLmHlPQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8NVY9YNMSbktOaAhT5lTFgSDSibrBuT+xCjf5NbxA+y7wj38l
 rKP/nIPSQU3ywJUKUTAdgY+Izxt+oB3pmLz9maJwh+QjgEknVU4+ZI0koEGmuoDqm4PijSwlSMo
 dfGWtZxm+rxzWKwhb+gr0n/uNpqlh5ToGOgEcKu1im/0mvQqp+w6al0jp
X-Gm-Gg: AY/fxX4U9qF6srzErcVIDhKja1TlWM/ieecB6q+SBzSRCklgZMjfqCmiJ0JhIO5dB7N
 Yj9Gnfb5LFXWrvkRgei2XUmF848f86NTRIdEgQtSwCHek54/0gOSUiTpDnm8SG8BrfOVUHk6yBB
 tt5KPxpOqv/bvjA9x0BQpPbOfIjSfAHNHVElZ0hFeVrhGTf6N2dmpN1aVEnJPAlNcF7COlQ0P0i
 9oamwYWGjapgv5L2vP/fm4rvBgJeFjHFgsJgSJ6UIs4eBmdAiFFEqrzuKoLgipdhxN7sRL996eq
 S5A8Z1d7ublNz5EtYH81c3MRQoQb92knwVNnMZ9+7vAkxH/gbLqWY9zktEYQfRpctqnI857BxUA
 HQACCYIGRNjRcXewccDj6ZelNNPI9/LvBNU46/cMcEfMScTkRBWrt6qvNTZEUzVuYb1jg5AY4qv
 suKrKHYwmkSFkidjKaebeYg5ihlJ3t
X-Received: by 2002:a17:903:32d2:b0:295:ed0:f7bf with SMTP id
 d9443c01a7336-2a2f2a4932dmr87157745ad.58.1766404337837; 
 Mon, 22 Dec 2025 03:52:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBlRlkC8efkrb++HLLsJ/RooyQkno7KbWPaUwjp3p2tA+26GyG04FXHBV5LNxPYbDNkk72tg==
X-Received: by 2002:a17:903:32d2:b0:295:ed0:f7bf with SMTP id
 d9443c01a7336-2a2f2a4932dmr87157615ad.58.1766404337422; 
 Mon, 22 Dec 2025 03:52:17 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d20dsm96656055ad.67.2025.12.22.03.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 03:52:17 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 christopher.obbard@linaro.org, quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, alexeymin@postmarketos.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v1 2/2] configs: qcom_defconfig: Remove redundant pinctrl
 driver selections
Date: Mon, 22 Dec 2025 17:21:44 +0530
Message-Id: <20251222115144.2146964-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251222115144.2146964-1-aswin.murugan@oss.qualcomm.com>
References: <20251222115144.2146964-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DAYxT4vnF5bwcg5UusDrFPTFhb-pjtPr
X-Proofpoint-GUID: DAYxT4vnF5bwcg5UusDrFPTFhb-pjtPr
X-Authority-Analysis: v=2.4 cv=e9wLiKp/ c=1 sm=1 tr=0 ts=694930f4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=3Ywh16zS-PkExWgXSrwA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDEwNyBTYWx0ZWRfX1A4aMb+1Uwwx
 CNrS4Xol+lf0cws2WpvdfL09NoJfuIvF8pjxgSmYbyKdcKx5WYRQYxUu3W9P8HfJB3Jps3POn2r
 /3d/dckLfBW69HvboEkqyCqsfx0QTi3KSNmHaQ6NxJEOBIsaVHxNVtuVEkBP8FdL+rSEyZmrtem
 g4Taif7xF1UTLNUYw3tUPk/nAKVQUhkI9XLmEEa5w61G2wDU6h2J8PQwheO2SgGPNxxvQVxxdAi
 hkflgPu79kQAFYbFvaFkcCDxZ7cYP4rg4EOraqp8Xa3xmcQVyOdJE6+kN67cDzZNhM2sVhtLM/B
 GSoa+FuvVJvD4QCUjXbUSl+dwtDZSaCh8+9Th3YR0dpn0lLQBKiD2NuZSPqOjmj+gDt2fVL2dZJ
 ahgWxsmPeJOvAs5uupROecs5l0YsTiXogcNBnacaJ6Z4nJLuElHUp33dPVfZWE0I6DyfEsGfjwY
 qmL+X2j+8wMINzvibwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220107
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

These pinctrl drivers are now automatically enabled via Kconfig
defaults based on ARCH_SNAPDRAGON, so explicit selection in the
defconfig is no longer needed.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 919897b8d40..e1ae0d946ee 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -110,24 +110,6 @@ CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
 CONFIG_PHY_QCOM_SNPS_EUSB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
-CONFIG_PINCTRL_QCOM_APQ8016=y
-CONFIG_PINCTRL_QCOM_APQ8096=y
-CONFIG_PINCTRL_QCOM_QCM2290=y
-CONFIG_PINCTRL_QCOM_QCS404=y
-CONFIG_PINCTRL_QCOM_QCS615=y
-CONFIG_PINCTRL_QCOM_SA8775P=y
-CONFIG_PINCTRL_QCOM_SC7280=y
-CONFIG_PINCTRL_QCOM_SDM670=y
-CONFIG_PINCTRL_QCOM_SDM660=y
-CONFIG_PINCTRL_QCOM_SDM845=y
-CONFIG_PINCTRL_QCOM_SM6115=y
-CONFIG_PINCTRL_QCOM_SM6350=y
-CONFIG_PINCTRL_QCOM_SM7150=y
-CONFIG_PINCTRL_QCOM_SM8150=y
-CONFIG_PINCTRL_QCOM_SM8250=y
-CONFIG_PINCTRL_QCOM_SM8550=y
-CONFIG_PINCTRL_QCOM_SM8650=y
-CONFIG_PINCTRL_QCOM_X1E80100=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_DM_REGULATOR=y
-- 
2.34.1

