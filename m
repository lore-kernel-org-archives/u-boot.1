Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434D9C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 12:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93A8882A0A;
	Thu,  8 May 2025 14:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dlCKMimV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A81582153; Thu,  8 May 2025 13:20:33 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02055828B3
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 13:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5484XAXP009222
 for <u-boot@lists.denx.de>; Thu, 8 May 2025 11:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uuaqsMudkpr
 mdlT1PwSkqbPhDNvE5VW6cla96cysnFY=; b=dlCKMimVC6r36suzwK8tLDiATy0
 /xsg7emjVwjX5pR6au2Qo4Opbo54x+m+XH7G2s1kMcKm+f77zhe8tPVJGn18l913
 DOs1CIm6oK48dg+0T34+ZJiqnCFh1SCHELl4NOP1wRClAoyIN4DJ1bQHu0VyK9RG
 y6qEFvVLlRbeOJi/lQ98BZoKz2rWzX5rbK9pPqllpw1djarz9LDf9g9OJwaDjihz
 EHm70+CcxcGwlKJ/zJOlihmbGtko6QmCu8FChs0Ngy1VKDa5N5vHOiAXqxmBP9Ql
 IYeTHe8Z38fArclqqtR020jhaJzoo9LgKdLzAH/AlhnoEFLq5ISrKEJlE0g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnpes2xq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 11:20:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-22fba2426f5so1230235ad.3
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 04:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746703228; x=1747308028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uuaqsMudkprmdlT1PwSkqbPhDNvE5VW6cla96cysnFY=;
 b=D6A6N6FqxkYiCN9pV+CI1E/+WkjVR7oJVUg3vHJtYwC/j0rEWnWX8jFV7TNbhvpAY0
 sU7atwy5y675Z7JFwMnRJuAqjbV5UQXpt8yc5kZhpJ7MZOu9bBBwuEuD5E1OwuRROxnL
 cVBjkVSYLGDDBxqh2f9hKSfShG+WaMV1PdYG0+cpf1hogRivXbaPXFiKqtjrbPH5/jxH
 UnSsrw4adEamuMy5VVeKZplM6Ejtn47K4ZXoU5rn+fQfLiXncl2n1LoNWMuGMbuPu6mZ
 OmW5NbvDvGGzWAEe3qIvhhHJGKBw2ttRa80XwRleatDVRSxF7OUv3FmeShNGUyDJQMq3
 xaVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwTjAwSc+WhqY1AvvwJz6V6nCLxkDxIX3WHBW9HNSv7dYhxjI/9EUEbHM8hF9Jsrb4eQ+JYP4=@lists.denx.de
X-Gm-Message-State: AOJu0YylSE5wp4PXxiDPsf5p6yL4HF8rUoNVOMfOzGel6bekM6ar7M26
 ojh/JP1sf30szYzkUBqHvpmYOujNTQ+w0tYxOPynZLmY31NgfJk639Pp5sSmLpLtY44dpZ/xahC
 UiU103sg1NDo34SpInEk3R9xT6bGEVIyrgBqBrp2a0t/RiVKk6+2W
X-Gm-Gg: ASbGncts8LTrVqFkHnZrk0BJTQc9qYk8S4aiok1R5koYJCbYdDkhdysRO0UlfbMfMws
 QvcBSzp8758vF9OtJLpqkTBkGQ5zsPGLNB8kzHz0MFAd2zVWxj9D6LLw3/0A+4fpw/O6oLtu+yZ
 msctXf8V69iPBiMPhFtuXMUJI0FjU16nvl+45f3Ya2S0AJ8A4xwnxZiCxnXKA9WtQBcOfw4biQd
 /xwjaCvCL6KlTS0lRjz/p/b6P1EQOIjAcRxPaw9Ej/zOp00p657/erZ0JDfDMYnfDuSOKLYOP8Y
 RlnTgpQroHoRRZT3IShF+/61XDo4TNmZsVAQ+PhY+JANE4t+4UGSXJSMEbzKXQ068jfWWol6cA0
 YAVH/SnfFKY+Of2AigFjM3TdW2bXcsUEy/VAXH5Sz
X-Received: by 2002:a17:902:e78b:b0:216:6283:5a8c with SMTP id
 d9443c01a7336-22e5edf7a71mr97890125ad.39.1746703228216; 
 Thu, 08 May 2025 04:20:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy3Zzluh86uASBOKhJg/oZmty6u/hhPf4w3oxLHOVd+Sx3dMLU0UOidDmzJGjoevstmSnOzw==
X-Received: by 2002:a17:902:e78b:b0:216:6283:5a8c with SMTP id
 d9443c01a7336-22e5edf7a71mr97889635ad.39.1746703227818; 
 Thu, 08 May 2025 04:20:27 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e6c3b6513sm27779765ad.220.2025.05.08.04.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 04:20:27 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 5/6] qcom_defconfig: Enable QCS8300 clock driver
Date: Thu,  8 May 2025 16:49:51 +0530
Message-Id: <20250508111952.2304578-6-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA5NCBTYWx0ZWRfX6ZlRaRZs+rlG
 ZgglEOxPy7WJVF8mKZ/l4/44LwCUGYw8DZELO77e8PuwkMTSoin3recdp3ELytRqsZOgm1VGhf5
 VEpesWCZlUHqdzdob6GIvTwCcjl1EGzzVtj/RXzWd26Q1U6G1Z0RAEfdim9f4aA9WifbPZLgQaf
 ggYdgJ46rLRTn37J6UWn/EkKESx9sk8FqoewpV9044OIfk8DfTqj1rdSeoQijVoIR9B50s8cGHA
 wW2LDmJfANwtKu+DdltDYDRMFK+gXrWeIzQ97GX3uQpkSn5WIjw6SAHDRAxqQ02CGLtXZNvQN84
 uswfEjTYlz+9IrgDIrmSWfj9uIpSO02Zq+EayQ8mnuBUTwg0BZGy1vq2Om2a9q+h2g+WBp/ROFJ
 NpdI9JHMCHpvwVqPp1bSXr2AUJGE02AwfALz4nNa5oB5yMWv7q5y9N+hkelse8gJd/x8v3I3
X-Proofpoint-ORIG-GUID: u2gs0P9HcpWP-Hz2WPI_8cqujXrfiO-E
X-Proofpoint-GUID: u2gs0P9HcpWP-Hz2WPI_8cqujXrfiO-E
X-Authority-Analysis: v=2.4 cv=Yt4PR5YX c=1 sm=1 tr=0 ts=681c937d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=ZzvCB5iDPKDA1w3LxRoA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_03,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=769 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080094
X-Mailman-Approved-At: Thu, 08 May 2025 14:49:28 +0200
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

Enable the QCS8300 clock driver in Qualcomm defconfig.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 537806450dc..5a3e5aa8e97 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -52,6 +52,7 @@ CONFIG_CLK_QCOM_APQ8096=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_SA8775P=y
+CONFIG_CLK_QCOM_QCS8300=y
 CONFIG_CLK_QCOM_SDM845=y
 CONFIG_CLK_QCOM_SM6115=y
 CONFIG_CLK_QCOM_SM8150=y
-- 
2.34.1

