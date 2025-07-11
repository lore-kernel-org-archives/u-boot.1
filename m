Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B193C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 14:39:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF45882AE9;
	Fri, 11 Jul 2025 16:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RRy5YAQC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCF9682F6A; Fri, 11 Jul 2025 16:39:24 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBB82800D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 16:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAn4uX021908
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 14:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Wl6wcn9uShI
 DeC/iYQInPqcCOnU1N8iQxj9f0IS9V/0=; b=RRy5YAQCKtmKRoLqIey/1bxqDAv
 IppAR2YQZsTsmJ93NI1YT84lwYQ7Nwxr2nh0Zd1YlkTJ185vqoK5eKIaEdMdUXYf
 XyKVRDX6HMpqq4v4XTM2VIpZ7TGWUVH7J0yz0YHGR4SbYA0R3yLSRmBL4P8vzoTA
 sE6fpk4MW3p71aNuBe2nYPhc+bA/VMToODqYR1kel9RtyZ4gT3C8iVzutU+SoX4w
 m38bs6IGaTr7LxMKa9VSFMyFSbocfrrrbkGo9th9LQLMe/J5LyO64ZKYqnYXjzVp
 3qZH5dNyiQmezeGJmP81humiGlP0O2QINXkftRs3PowZk2dcxlGJXNICq4A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b19x3q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 14:39:20 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b0e0c573531so1635501a12.3
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 07:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752244760; x=1752849560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wl6wcn9uShIDeC/iYQInPqcCOnU1N8iQxj9f0IS9V/0=;
 b=iBuqMT8uIrvoxd0s8BSMg8RQfW/T/TmvHSdQbkWMuRva2fDnXFLFWEGnNL6mUhyYc3
 o7zvdUJNquyHT4nUHzZvcz9LAj6NWChHvdvYm4YAw9e9sIqwQB4CAGszyEzJh9Ov8oUj
 j+NI26rx0nfSh4txQrZhj9IRFVd3N/bVnu45pCtcDZg3q/fXO0uqBtTocDTOP9hOk7Q+
 mpmcDz12lIqCy4v3MAIGLPUc5B5oiaKxbzmUzy7qVstm1xc1YCwEch6bOEArPbyzxiTH
 wUY7N1Kg1Q2bkKgwsIqg8ScfntFbhLbWhlJ6qxuB0Ix5KofWwwvKwXM9BuV6AUMrquKh
 mIbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXF8WsEKjcYk9zcar+3hYNRO/PiEVBpxa93LaPe22FuW/slYfGc1jaWcGMaONYOkxwP9v7jAU=@lists.denx.de
X-Gm-Message-State: AOJu0YyVUQFWskF5EPA/I19bjoPGArNRLSZJQ/wOVeHdkxSL5cbxOSc4
 dtPrY9vNXIR21Y1b5Uu7Zsdt96XcYSV726gpZ6gVUClbiGR2HP17fCKrky6HAQVZ0CCJvZQZAQr
 uvG17cTVMAMAidkefbQFV1W1C6t2WHTApnw3LcnI/XcOGy19u7H82Gznx
X-Gm-Gg: ASbGncu4CnC10cMU0zEreUIF0IRAootb0BxCVRR/dknYz3vBlW7WnTxTfwPKcwPi16S
 qwsyasFdHLRLPGe6GzNh3QV1dA8YigUG08/vBEOchl1DJTdaSZwWnK4aX8dh7lpANQjOEggxKVr
 QZ+G+Nm2nkGTXVmg/NW3WIBCXMbFMdSOiWttmGXaX3B/EpdMzSIE7mp5Rt6qbLDslMJw0mL3tPi
 +szoIfI2cUJ9FAgoKo2nh+yAV0LXrEIQGyPnRDTrZOPpkxsAfqsIqCY51QHKdcOnbrQ6FNGDN2i
 XUZNsf8/bc9gFLQCXoqCMQ7FPtIcGn2gRG1udIlo9CGKQO7DlnB+T1oXxfiTtNNYSdAhko+tWCV
 CyzTkIXwC8G7taUFH1vjA4u3u9O214FJ4mZ6Oygyf0epnjHUEg+CF3goDYww=
X-Received: by 2002:a17:902:fa06:b0:235:c973:ba20 with SMTP id
 d9443c01a7336-23dede969aemr35895205ad.49.1752244759738; 
 Fri, 11 Jul 2025 07:39:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx1Xqr8lO8NV2ZnkL+HGL5LyF7EjnyyS7EW7uijF9mpU/X950LQlOu8MtfZpGjhhIj5Ag7cg==
X-Received: by 2002:a17:902:fa06:b0:235:c973:ba20 with SMTP id
 d9443c01a7336-23dede969aemr35894855ad.49.1752244759206; 
 Fri, 11 Jul 2025 07:39:19 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de42ad948sm54234675ad.61.2025.07.11.07.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 07:39:18 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com,
 aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, christopher.obbard@linaro.org,
 me@samcday.com, quic_varada@quicinc.com,
 marek.vasut+renesas@mailbox.org, sughosh.ganu@linaro.org,
 miquel.raynal@bootlin.com, balaji.selvanathan@oss.qualcomm.com,
 sjg@chromium.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v4 4/4] configs: qcom: Add QCOM_POWER_DOMAIN config
Date: Fri, 11 Jul 2025 20:08:51 +0530
Message-Id: <20250711143851.1490617-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711143851.1490617-1-aswin.murugan@oss.qualcomm.com>
References: <20250711143851.1490617-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=68712218 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=OxpuOtcKCx5i6Q2IK1cA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEwNCBTYWx0ZWRfXw0oEiiALypx8
 71a4KcpziNURFMU0ZVUEUxVRSpDwssVr7HOs3xoBHd+xqEzLZXve+gYwaZT2FpPDnY6q3sNKacy
 a6gL/BAwFtebWYVBdWok3P47ZVW3Gf10d2n3O34EgK38PAAZybT2S8C2YwleCk6Vs4ku7OuQtce
 gmUb4fbgrgGGSd/evqsw35bOKAZwAobD5tL1emMLDWFuF+fc4IrnfgF6b5GQLv5Rm9lbPilmQlz
 oy6U7FIoVSX8uD/LgMipypIri0T5tlBBnz1I2BhfJd6lrEUH5M+aqZyf6B8ErvbS75zqn8c0lF9
 y/IBb66MPkorN9FQPSM1Cfu1HCWBSfLcwaNCRn2whZHjTGrY3t8QIKbkE7p8Fkwva81bvgx4hH/
 go/tDF03Zrt9UTOJpd/FmVmNXN4bp8OS6Rm0343UkXmkwW6OD1e/cMBHB5OwBvzQLPB/QXvp
X-Proofpoint-GUID: u4Q3fpG1T7z_cmcVXJt7g-jQADhXscek
X-Proofpoint-ORIG-GUID: u4Q3fpG1T7z_cmcVXJt7g-jQADhXscek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=936 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110104
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

Enable QCOM_POWER_DOMAIN config for qualcomm devices

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
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
index 84cc4cf82d8..94b8a7295ee 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -128,6 +128,7 @@ CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
 CONFIG_SOC_QCOM=y
 CONFIG_QCOM_COMMAND_DB=y
+CONFIG_QCOM_POWER_DOMAIN=y
 CONFIG_QCOM_RPMH=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
-- 
2.34.1

