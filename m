Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CE9CF34D5
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CA1C83FA5;
	Wed, 19 Nov 2025 16:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PWI7Drz7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jwDlfBLn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38BD383FCE; Wed, 19 Nov 2025 16:25:49 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A35683FA3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:25:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AJFIHUf971221
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6bUjQDmI0/+
 9ZNnd7rD9YABirhyd9CDBVZraIxp1sAo=; b=PWI7Drz7x1g1BIU2P5kOfI0cwAw
 mokwCNAq5GWuW+UY47BCah6StmUZUwcGGkphmweIa3KPGmquJ9Qjg8oz2oxUtTya
 h9y15Sl/4B2fejL8TmmtXuwmXhixXVO/GhoZMUmV8oUAfvQ/nrEXxduvhS+/tkzA
 uctwUXcSEn2KSoF+MizvvP5setLBz20nZAMAK/axEsMm6u+t5/zsEYYzGAOsPnIF
 bA6FkQuiHjYYAYLLl2dKbJkdUdAC35tra14g723HccFmFWBrNAaekqryVe4ij8h8
 IyN9GBrotopP2PNV4ZP9om8vSBIKU69DEDkTE7omhI+FK1gpacuELpmol0Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ah9fu9dx6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:25:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-345b4f2a8e8so3735627a91.1
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 07:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763565945; x=1764170745; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6bUjQDmI0/+9ZNnd7rD9YABirhyd9CDBVZraIxp1sAo=;
 b=jwDlfBLnAxh927SWS8QmIyqOWu4p+O3s5NHh5W4CZbdqtTXn0fzG2AhxfaCpKB+Xcv
 yYqNIgoTslpC9qHESs2ZMgPM9TwchnDxzQgVjEnMFd3jK8+KPsmkb5pRnsTCjDJXdbbx
 R0nT0IFdIjE/f7mvkYgmciG5w88qyp3QiB/J86iOFS/8rorJARUKuG4dwQp6g53Tz+Yw
 WVz10yNLjAnM1BIAEarlRBd7S4V8se+O+webDpadCI3xw9LAh74HHzUdPaeTT35Y3kZI
 aS9cfePPzFeNXERQW44bruqPf4SfCLLQfkA+1wR0jWBoB+BLEUhsLaYqQRk5GIoQrZiN
 ooMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763565945; x=1764170745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6bUjQDmI0/+9ZNnd7rD9YABirhyd9CDBVZraIxp1sAo=;
 b=XjEsvNkT+JvT2bQE8xIsGt1zMLmNrtMTGQ36n52OmQUBZUpF8p5yldxe5E4xD+YjcT
 ynLrewPETQLjMoVXemoDcSF1MsCjOQFFe74J+y0oFBsCvbmzqlD7SjJiZepJWK305n5L
 vqcRfTmaHJ4fIeP1YicGb7ckptxlRb4rhlP75N1FWcJTKgZuLQJY9ROdkYy61Phq626p
 B2O/hcDZaIwTChs2B0s+AWaHAcvD16ESQsyn1PPd+PZrUJ+a7IKfLqsyAB7MCq8vzLyF
 8dPheGWjQ62BYd8GNWhVgkf5Dyj+2gQUhyDoWaA5wxMO9H3EvY7LZtjcVnGduT/nZxR+
 nDzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrPgzC0Fp/Opk+4NValxvempL9k4dyoQ4QODUWp7hOJeJJXLnbeWnrd79zKUCLJqqkYYMhkPw=@lists.denx.de
X-Gm-Message-State: AOJu0YzqqMEudjb3rNDVOBwZMBx4060nNB05MolnZrQVlw58fZRKDQtQ
 zDM/X8cNj5nRJJkVQI7gtREddcWh5KV1xkh2D6QIEKzSS8lYf5IvGQTJkR1jq22cE+xJhtrQ9/x
 eFTjTRSbrLgnKE//Jq2/j4In7sTE9xEGuwC268V9ZHqve1N8Vn9IJL9hV
X-Gm-Gg: ASbGnctsKhYUNNMlRCCdGmE8VDZe1XnEieKUX8EYSEGEAK23fkD8LklBbSZUuCJ50Ty
 xpGpmY8sWcLkdWZBlCJHVFUIvocDX5LMV+R5NHTQJRjvTMDfBKh+8NTvB91rwzL4QGG70TE0ir7
 7ZCsDp9byX23/75cVFn2YdY/JlBWjqlM/ZLxCZYANZaPXjpR3yb9/jbx7dtga1YLKBtR1nEjpuv
 LglpI4raycEYOWeIWFYZiXyiHnDgIxwhzHcCqQBjug9GcajB0tVv5YudEq+Ms/aPRuNfijQT8EJ
 zn+V0rGHqDkUyerc6/PFvJrakvFbNyo8Odw40Km4lwm/2Rn1irbOqmtcSWxTsadcC9UxxPqsPAT
 3Z5G47ELEX3KOV5u3/w0DtGSfchqP9oA9swVtN6meQNwosI3k4C0cq6CDRqsNwmzrTAvqDFea9x
 RswWACN4DyqWN0L+L46d7Vfd9q0xaJ962U7MhZ4A==
X-Received: by 2002:a17:90b:3e8a:b0:32d:dc3e:5575 with SMTP id
 98e67ed59e1d1-345bd35b96dmr2728589a91.5.1763565944714; 
 Wed, 19 Nov 2025 07:25:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZofQWBmY1Etqq8CHx1LoXl203ukeiVickvxfz4yGIbIhPfb+O/jFMFAmfwft7aGRWJ9VkaA==
X-Received: by 2002:a17:90b:3e8a:b0:32d:dc3e:5575 with SMTP id
 98e67ed59e1d1-345bd35b96dmr2728544a91.5.1763565944214; 
 Wed, 19 Nov 2025 07:25:44 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-345bbfc8eefsm3083157a91.4.2025.11.19.07.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 07:25:43 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 rui.silva@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, mkorpershoek@kernel.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: [PATCH v1 1/6] drivers: clk: qcom: sc7280: Add USB3 PHY pipe clock
Date: Wed, 19 Nov 2025 20:55:25 +0530
Message-Id: <20251119152530.4175628-2-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDEyMyBTYWx0ZWRfX5UMSR519p72r
 WaOOcDIHDp8G86depyDWzEjU5xedCjvB7B2fgd9Ej7Bh/okIOSogLzl6+dcf96AdFPwxiWVmHuC
 B4l8Njx0baYuIdnCkN1MULDQCDpJ7s4PJgfPCbs2rESU7LpyCT8r85jOyKyS/q4Ue8V7bzbK/Dz
 UjLdEBkWh30UzDV9o0gVmFiBVQdjq1nwc+Nblgfl77SBH+MJkIOrV3w9S/zP2XFG0N2tKO0kfL8
 HIkXNWV+UzqlKa5haazBEZYlKfZS6e0SXWCy/dp31hTfW+6olZbuZJ8T5oiqISal9ABxi0Z61PG
 Ug6oO5jYDbszLfSo/Jy8qwaVwzAQaF4EW9LZ/qaYw==
X-Authority-Analysis: v=2.4 cv=KZTfcAYD c=1 sm=1 tr=0 ts=691de179 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=poeaOmuzvgfykHCmRdkA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: tIH8NFeeKNQnMQC00n95-ACHq9b1TvDQ
X-Proofpoint-GUID: tIH8NFeeKNQnMQC00n95-ACHq9b1TvDQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Add support for GCC_USB3_PRIM_PHY_PIPE_CLK which is required by
the USB3 PHY on SC7280/QCM6490 platforms.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-sc7280.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index 55a233df394..a2af73cd976 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -111,6 +111,7 @@ static const struct gate_clk sc7280_clks[] = {
 	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf01c, 1),
 	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf054, 1),
 	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf058, 1),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf05c, 1),
 	GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK, 0x9e07c, 1),
 	GATE_CLK(GCC_USB30_SEC_MASTER_CLK, 0x9e010, 1),
 	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK, 0x9e080, 1),
-- 
2.34.1

