Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB30D262B2
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 06:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A4E183A8D;
	Wed, 21 Jan 2026 07:39:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WsY9ozY7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i857T4mP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4D0882A9E; Wed, 21 Jan 2026 07:39:55 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DC8C83B0B
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 07:39:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60L2e2bk314349
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5XbbtwY1/pZ
 F9V9LePGoaUX89Y5/tBdbFA+XCWKYcjo=; b=WsY9ozY7Cj97NKErH87EIywtVpB
 hgVvWzHja1cebpjLQYUOMsbLeKPODUZ5TBxnwpka00+Jn4Hl+EwYdruxAZKm9h9A
 LGcKD9TiV7ca9exR8ttr24qKTSow4D4+zU+grHKXCljlKflh+OKyG7reBwcoCk2r
 g5seErpS22LzIYla6iFgG8BAcx9SJqT9YasmjHcoOuyu/ORIzdTaO+SDdMoc5CP+
 YYq+T4HZdAhuOvqtgBcTic8f3y0nxfvln5Qb5JON9+HUAarLKlWziRKGE54f2xpO
 Ce7EYOMBJ+7YgxbBC6uLv+FVQ4G5utAox97B2PGa/XAJLOUS2iih9VQ9k+A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btdw2ahy2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:39:49 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a13be531b2so59388955ad.2
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 22:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768977589; x=1769582389; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XbbtwY1/pZF9V9LePGoaUX89Y5/tBdbFA+XCWKYcjo=;
 b=i857T4mPl7ANUxpmy+wCGsK43yoJb0I0CYAUCre7LbwIpmf4uSoMYLpnG1YmraXJEj
 VRW82zZ6zSKCFKDxP/wbBdR8OCVgbGg+KQK8jVJ5KFkRR8ocu+XPGzzjbf/hlPny2d4R
 Ccx8fceVmSuaKI3FdBTDuFlYogP+5LhLE2Twqu4rFx7FuSTmIJgUa2qOuF72z/8s7x6q
 pszTVUYSzWL/MeVo01kqtZIXAonknHjMW0iH8JCptf8rJ8uIUt2pA+QHbjcBeJNF3eOm
 LL1WviY5QFzjQTC7a+RXI7j5bfukLyg9JcHKKVzlOkfO9AwMmMVz9CjqVyQVDwPFWD4Z
 t+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768977589; x=1769582389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5XbbtwY1/pZF9V9LePGoaUX89Y5/tBdbFA+XCWKYcjo=;
 b=awuxJmiGfSPgMzt30fbqi9EL78ZGqMdWRDhjqlBg3VMagGZ2/wBAlPsQ+HueNcgMBz
 Bxb0pDpRgIFqVi4zzhSCV+NJTrdK+y5q1Ml6IETFX8ESCV484YlVJHblyehanfYVY0JD
 9178cbBmduhVxznf2KOeStXYWgIvw+VLDP+C/5dlm7LOmh6m9MDgVDoN2V3RS06ED+q0
 IZt6MoCYoVt7kGRF33miEz5tM5uaPpsa+Q+RJSjwDZh1Y3zmLiyDHGYR1wFtFiAdU/87
 Udcyw3CC1StwrQEOaU7SJhVEOX7+MVriOK6PVrdR2A67EQxmjRv7vNUvEoLQt9unXdxI
 ApZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMdgvkPfmgpIJ+7plLlPseMpSpv8X/rWBxqwNtUuh5Ivr0M6CGxKzx0dhxz0OfSsPbB2MluiM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7T8PSwwTUXjiH2mUMan4bSDunf/CaxyFps7+cZKthJm9JbR1c
 ejv5H9vly2Id9rnTyMukv3WAnqPMAxZXD1BfP3uu/EpU0vgC5aORlucbwHi0ovzs5LlS25IYRpj
 LMrk+2A+5X/0MmOG2FG1Pkh3fgRYPMJ/l6mo//PmZY0pGPyRGqFbBSj9T
X-Gm-Gg: AZuq6aI3adSvZMoqawTMvy27gMCIyFddaa5bTUcOI/j252l/7A1OWSCL/oecW840tZ8
 oGvjf4lcCDM/La+if8rHVRzTpoGxjKiC8B/3nqZimr9T/jHk50LBHxFzwZECLtdats9RRoNCzL8
 mAENH89DFeXiYtdXVDp31r/gUqLYiD0d6WELaMFJhzS17hNI4OqssqT+3AtY0jta/GZX7FjfFWG
 I+rCUfBxJnoarTC9j3Al/MECT/7S63t+7FnmBQ+TOG/WzqlvWKGSoPkD/smJOlP4mcFV2ZTon9a
 ZVWxBu13JJv2QOA8N74hUz+6xJwDIYS2XPiblo/bRHGJ1zqY4nLOeCKjaTI8I3+34Os2CqvNG1k
 3V1d55sCaYuVddBI9vxp3EEq08VUurNzdUF8eWs78Ldewd8+OXE1cNX5Fwa4d9OAXjppbq3tXkz
 EWi/o4AxiBdOLnSd8JjU2NXaVnsKKh975tc4NFArA=
X-Received: by 2002:a17:903:1ae6:b0:2a2:f0cd:4351 with SMTP id
 d9443c01a7336-2a7175c3241mr156318305ad.37.1768977588933; 
 Tue, 20 Jan 2026 22:39:48 -0800 (PST)
X-Received: by 2002:a17:903:1ae6:b0:2a2:f0cd:4351 with SMTP id
 d9443c01a7336-2a7175c3241mr156318105ad.37.1768977588467; 
 Tue, 20 Jan 2026 22:39:48 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193fc8d9sm141392315ad.79.2026.01.20.22.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 22:39:48 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 jerome@forissier.org, marek.vasut+renesas@mailbox.org,
 ilias.apalodimas@linaro.org, me@samcday.com,
 aswin.murugan@oss.qualcomm.com, clamor95@gmail.com,
 michal.simek@amd.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v6 5/5] qcom_defconfig: enable psci based sysreset
Date: Wed, 21 Jan 2026 12:09:20 +0530
Message-Id: <20260121063920.1500293-6-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0V-Cg90Qz-luJgePS00Hzhz3wblZApyo
X-Proofpoint-GUID: 0V-Cg90Qz-luJgePS00Hzhz3wblZApyo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA1MyBTYWx0ZWRfXxQJTN+KE6sD+
 c9ITOe3VWMasTxwDvPX54zDisrHC/lFGZiCvE2ErXCMICGXUgKXN+/Sk8EmT367JgKhgCma9dIH
 Bx+hI0gPDeTdVjKElxsIRlIVsUZOV8D3QsK+WjX7Zf6RjjmMl/wWvVBCglqjlYmDcj4uNjMaflm
 zYkhvaO4x9LAUusuLf/eWVuRmua9JM7b3eyyElMME6KERsqJliiO/au84QfnVZw0Pt+uj6eutKz
 34I8diLiSCxUClqwubSa/LjKgQNx+Uu21hdlGc6uLEQ+VtPaNR8wvRXHqyOdP8cBiIzZk0J9yF5
 fpBpCgyWuBK4xC/LjSE4xgrVihzSW2ZdtdeXfKMZmUqGMVMStqsSEjqzvsDE3J/sIbLKRcqHi95
 +ZzjKk/ktjUkZSSns2dGtKjquhdH7ApshID/rpgBQn08z5csoy5xkKvvlYJez0nGpQgMNCuhXID
 5iIl0VERbSpDS9WlE/w==
X-Authority-Analysis: v=2.4 cv=RqzI7SmK c=1 sm=1 tr=0 ts=697074b5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=uqFMpbG4MC8BjM4yXrYA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210053
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

Enable CONFIG_SYSRESET_QCOM_PSCI to allow U-Boot to reset to Emergency
Download mode.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v6: Enabled CONFIG_SYSRESET_CMD_RESET_ARGS

v5: Moved from qcs9100_defconfig to qcom_defconfig
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index fe5880de1fd..64b3f7c4328 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -130,7 +130,9 @@ CONFIG_QCOM_RPMH=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
+CONFIG_SYSRESET_CMD_RESET_ARGS=y
 CONFIG_SYSRESET_QCOM_PSHOLD=y
+CONFIG_SYSRESET_QCOM_PSCI=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
-- 
2.34.1

