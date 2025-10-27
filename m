Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0647CCCF9E5
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 11:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED2A182A9E;
	Mon, 27 Oct 2025 12:34:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dWGN+vPG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB0BA83804; Mon, 27 Oct 2025 12:34:19 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77D8780107
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 12:34:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59R7Ju8L2059252
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 11:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=DwgXzd2lXIs
 F2AKU67QKpjo9rSlJiorRlpY9nvaBj8U=; b=dWGN+vPGIEAtZa3qN5rSUGUvYR2
 psbCptM8Z3aIQWevjCYBXkki+VZtnsci6kNZshpw0ulzT8O2Mt7bJD0vzACdR0VO
 Dfdhx0itTn8z4KzjtOcNwvHZmTLxQBVBkzwsKwWDSL6k1fuye0snsoLxh9iKdo/a
 4eYuviawC3ox3sDwttuX0FxL7XMfZQX1F32ilpmgBw8iw4sJymu3J+rtorLZrsTl
 TCRSOEm3eIe7/E1cvE7NhIpIVsOSvUvc/Z+e1nn4LkovywbubKWqmuj4iMABNSDo
 B4QSSJ44sHrefop3wwrOc3iXjqCJhuclLY/wF5P4yGY1uhYJWETgkc952xQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a248p8pe3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 11:34:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-290992f9693so43033425ad.1
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 04:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761564855; x=1762169655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DwgXzd2lXIsF2AKU67QKpjo9rSlJiorRlpY9nvaBj8U=;
 b=bKi+pPiP3PjRjLJ6HpcF2wPGVIxeT6cUNfvkwI2uxVIymm2VBkCjPKNkNCYAGBgbkJ
 MH74rGrBuS/GcNtFXrqW1Ak5loLFAn+vHWDYsaNSLoYkJqa6dLQVzD4TSonh65Ps+2VO
 sm0jmctj24v1CzunUYFJmtDbE1u5oJGrAyGaFSHfL7sTAvjOOrOTVWZzHWSYV6oPY52t
 mf/MjBbudVR3qNekFdloUwFAfPZt8hRezgHdpTvhkYA1gBqQpb4H6Zc4oXW4Psni+y6L
 bIu6pMYHy66jPWgLl08avu4XFQVuqHRpfoGSCSOyEFtPHNFpDP12pNba45l1GJnrtzXP
 8z1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3opgbTrDLI9aDRcYVX9jLmG9uPReUe0Rh5XwgZJyQibedYBpzFT1RHvrr6Da5gCTAApOAosc=@lists.denx.de
X-Gm-Message-State: AOJu0YxCIm+6jQgis6JS7mGX9KA8Ft3/+xJ5Kota/kZTa1fXH97aK0hY
 7X5s+fg4UFn7KoStBURv9fRmqtOADzXe62zOYc7L5mxB4eQB5yNJdi1GJtvDU7GwbfTgvMNNfmq
 +uE/ycFA3b34l0b0sGthN8vjk9CmbWVhf+M1nyJUhYeWCvusoTkyNZZ0J
X-Gm-Gg: ASbGncsEYlk5LRkK+teztOikLt1xMA0A6nUfSzxA/imFQW1nSutR1TxCo4bbgoynSUA
 ckFYTveWxRhvNUwn2Bvp90FcDurjJFvz452Ls0j2hiVXIqAvEQdRmZkLFrljm7n1b3f/gU5avy9
 r5yc1ZxBqP6ZZIA8vVDI3KFrEJ7+4ZODhmrQDPJnoMQEwv+TfI3FViTyXQfR7/bNRp7aDqeASzC
 R6WyZBlrRj/xpdSYHPSAzGtF2mVsUmHGvLAY2QoC5uJzgh5l7FXEoSKCKk5R75MZE+m450TN/Er
 khmZgRCMlPWNYsAW+R4RZqRZevi0iuPraw8VxZmVM0ewE5VZcNzKD2aE+mCPmpN/vY8awVsibdJ
 ctT83wVpNuZPknRgoIcui1SeVwDkmYurB/QvR+J2vR6ibru/JFj4d72hs0mHuqUANnI7EkH/5VB
 1EEpDBkBdj
X-Received: by 2002:a17:902:f605:b0:267:912b:2b36 with SMTP id
 d9443c01a7336-29489e2bb73mr109711765ad.23.1761564854883; 
 Mon, 27 Oct 2025 04:34:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxleXrrLY2MxIKmLtRrcCvVcZBzb8GWVzcxB0t/Hw6QqVwj+CS5X4/6KPwR8vH6syakNzgBA==
X-Received: by 2002:a17:902:f605:b0:267:912b:2b36 with SMTP id
 d9443c01a7336-29489e2bb73mr109711315ad.23.1761564854335; 
 Mon, 27 Oct 2025 04:34:14 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498cf4aa5sm78497825ad.13.2025.10.27.04.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:34:14 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Google-Original-From: Aswin Murugan <aswinm@qti.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com, peng.fan@nxp.com,
 aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, christopher.obbard@linaro.org,
 quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v5 4/4] configs: qcom: Add QCOM_POWER_DOMAIN config
Date: Mon, 27 Oct 2025 17:03:12 +0530
Message-Id: <20251027113312.3815169-5-aswinm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027113312.3815169-1-aswinm@qti.qualcomm.com>
References: <20251027113312.3815169-1-aswinm@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Zvzg6t7G c=1 sm=1 tr=0 ts=68ff58b7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=vX9JJ52etyi1KlaNZ8UA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEwOCBTYWx0ZWRfX+VJU05Mmf4Tz
 dPAZ9A6Z5qKNAeVk+f6BxKuT9UI0d4CzxOwkeO79MbVBEvdae8XY0vjrBFiiqN8Pl6q9Uff6Q3h
 bQ29zfcBONfqxFfQzipRPKz5+dH768yL3NNnWkAk84TzWwnuH3nZrD4cSJUJrPDNqoc/7vih0eR
 tA463ahWSv8m0JGXwImTq9f1dJ36j34F7o2AGxTNYhWleNr4j7viTY7U6dbrTtnEqqQGG4x2lfr
 hPwSr5Te204w2A7qPLyxZsrNPmeKHAdPhqJyNaemPz72Tk+YjtB0x5tSjMWQre6tmNj2GiFSPNS
 tYSPfEB0LypRFGYwZ0BRauWQqWBykD3SGXWVFqUt3Lt1eDpQAjJORF5UHI23VI9Ff+/nsqHpPb3
 9Udv6HyTjvAmNLzEskHz9wxajNX8/Q==
X-Proofpoint-ORIG-GUID: BBG3c0svwbYLUVSAvONbqBpSoPFnjkPk
X-Proofpoint-GUID: BBG3c0svwbYLUVSAvONbqBpSoPFnjkPk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270108
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

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Enable QCOM_POWER_DOMAIN config for qualcomm devices

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
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
index 8d1269b4634..a5a1bf7368e 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -129,6 +129,7 @@ CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
 CONFIG_SOC_QCOM=y
 CONFIG_QCOM_COMMAND_DB=y
+CONFIG_QCOM_POWER_DOMAIN=y
 CONFIG_QCOM_RPMH=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
-- 
2.34.1

