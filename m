Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FB5D232E8
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 07:10:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A01838430C;
	Fri,  9 Jan 2026 08:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="e8FCsSuk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="br4USQQh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEDAE84144; Fri,  9 Jan 2026 08:09:48 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E0F48431E
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 08:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6095SWRh2706841
 for <u-boot@lists.denx.de>; Fri, 9 Jan 2026 07:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QoXh9HDNquC
 z4FtJVsmHff1EYMeOGCKH3Sj1IzHWtCY=; b=e8FCsSukblV+2au7Y9W46dbUusT
 nUOk4/bNyIU6dbmWebuqniGF4zZsDvbGKB5WZTuCwuVYBk2YcigWFQVlgVwGNBG4
 YP1GrNAPr+ClnO8vlP/x49FEoFYqHOJAknAV2BMX5Yh9YDxH5b5WXxGKMVp0Y2HH
 ws22UY9LYGyIWX6GAxCQKXbMpkvzBfV4q69uTWwQrGDTqiPvW+V0xftxW9DoSyUN
 3nP71dqovuYXyv66bdZMvFRks735BDuITIx0pr557h45EUz5QaiXcpRi61s2Kjaj
 KASD0QW3wTbfaPOiSy7+0yZLWJlto8BSwOnKwwsMtvnVDvcKKilFeQik0GA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj9hqukyh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 07:09:44 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7bad1cef9bcso7018389b3a.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 23:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767942583; x=1768547383; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QoXh9HDNquCz4FtJVsmHff1EYMeOGCKH3Sj1IzHWtCY=;
 b=br4USQQh8FQbsxi5p41pdhZLLQBmrTDpUK9OMWRQS3WMKeXZE7SDeGd8C00waCnC7Q
 lYT8rQxaJ216SrmheBRJVvM7cCwAWzB+PXf25bHqKgigS43uZCLGJUTEy//sASpoeO44
 L3wIHHueMEDOt/Zo0XUfvzGmJQoKzb5EqUQfD+boQIXarN72JaJqC9C4LbJ1PBPFeC/x
 hKXRIMGn8nPno/pzk2PvSts6zI7hHj2kekunVIn47D1AFWkUQ1H62XPx0vEOYZ6d9N1v
 08srRv4OpSWn/HQZwkwg2JPYaIWyK6UU/v2YbSSnOp8iuqS9JRvSNCJu/BuCuRQKI8DL
 8OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767942583; x=1768547383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QoXh9HDNquCz4FtJVsmHff1EYMeOGCKH3Sj1IzHWtCY=;
 b=rqdhJejla1GZY53s4+5miYLJKUTwZ75XFNrdXzWUQ0+uRNvJewG6ToaN+safbMdk+H
 WtEs33sV/yJbVCD3EY4qxjzH/igwkFeAvlkZ9p8K9RNDm7a8OyrUGSrYPDq4P5lnufxx
 4mc3u1XFnSmofiD5EF8+rfVZQPjj1dIRbbb6cDPIiPsK9Lp9iCXmkv3EqIqPBjUdUXUX
 ITSSqj4JFnYDZWCSfMNs6O3E+ycZICACCf1TJOeIWE+vsEjlcNIyA1PNTDYrf+1X9bkz
 JRQhDZM7YcSzob6XmLe+fEWeJsps8Sra+gGhRvXNzdizgXJ9+mc1P+06AxdP6Lsbn+Yg
 QLGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ6FjorxNysklY0YIzMTkqDRNMxis57DzqZODp/3glHiHIUHjBHgm/AigbrL+tR8I4LWMPCKY=@lists.denx.de
X-Gm-Message-State: AOJu0YwxGapsJNcGextQbl960Q0d6Ko3SW50mHxd+GXOgbrmUz14VjLt
 on/Rsdbde4+IFztxIkG43JVCny1FC9+DzWUkEe6qBL7Ofm7c4rMQ93NyusV8wgvdkkmbcDX0BsT
 316NxqM4EMnVHkSeA+HYzOPuPLqoPZb4HOR4IhNRDknS2AwMeXTtzdIQ5
X-Gm-Gg: AY/fxX7hvdhwwh+2tBJFfdCckFxP58q+Mhh8PzZ1UZ3uSM5tA1UoVu58xi0YVZ5Y0K1
 Y1GKy2Bh0AvXJ8XTrifl0ZqY6nqJFBpwP6nMSyU/dyn09LOfjHze8TI6CqV8hLnp3cFwXUqtp66
 Ahp4p0VpVIzSsSGkIQd7q121qhH0lSLVGbEGcRA1fZZiM+z223EwYk3zXkyhwBOc3ZzIgKweShH
 BoPGl8hxzoe6FBQ0qWjg2zQ9g/3GegmEJ/RE96er9xw1uHjLgpp2Tp9kuclIC85OQcWVfAR/X0m
 EOiQEJdd1rT9veJg9AfLfv3ui3x/mr+19TCDUPxaN2LOWtrOpsNMO9tHiXqbvh2qL+fMtrZbiak
 PVa8DCPd8rBLqoHczo4lwFFt7u9RQcWDsEiA5HYK2CQ9S+lbzqhjdOka/IvJAYNXR1Yo75MpRq4
 ftuWevmYP21x6uBlkSc3Mgll8aPCn2dZbHPCDyaQ==
X-Received: by 2002:a05:6a00:1c83:b0:808:434f:ba75 with SMTP id
 d2e1a72fcca58-81b7e04bba7mr8112920b3a.25.1767942583470; 
 Thu, 08 Jan 2026 23:09:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECz0dHfDTBCHHQsrGNKyX3ucMvkSkQ3ZQPWUJDB1EAG1DvbqtNmpZiNPcjojdcJrxPMqPdtg==
X-Received: by 2002:a05:6a00:1c83:b0:808:434f:ba75 with SMTP id
 d2e1a72fcca58-81b7e04bba7mr8112905b3a.25.1767942582926; 
 Thu, 08 Jan 2026 23:09:42 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819bb4c85bfsm9471943b3a.30.2026.01.08.23.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 23:09:42 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, joe.hershberger@ni.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 ravi@prevas.dk, quic_varada@quicinc.com, quentin.schulz@cherry.de,
 javier.tia@linaro.org, simon.glass@canonical.com,
 marek.vasut+renesas@mailbox.org, ansuelsmth@gmail.com,
 michal.simek@amd.com, mwalle@kernel.org, jan.kiszka@siemens.com,
 javierm@redhat.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v2 4/4] configs: Enable partition type GUID for QCM6490 and
 QCS615 boards
Date: Fri,  9 Jan 2026 12:39:12 +0530
Message-Id: <20260109070912.4106466-5-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109070912.4106466-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260109070912.4106466-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GN8F0+NK c=1 sm=1 tr=0 ts=6960a9b8 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=HwppXFL7jfFywDXtBMMA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: Vgv3hgVP_XfRu60IvttmdQSiTrEroene
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA0NyBTYWx0ZWRfXzHtXS6dKwgcD
 CCDsAYpxwTS1+uXTYvR0z+SAaWMfRU3ZQxDdBA6EY7s8TjRnUfHnKSEmkrGnhW/NZRCQaCDWhKr
 dIW50UOxiLmwzelzexTRX0eWJa+oB+njiEgdKUk3HKNJegeLnRvXoxX5SxGkQ2GSCoNy9T1blcj
 PZNM/T8tdGQ8DKdF7brt0tyViwGtDZix/XVcCqQ6k9le8WebJRy8J0uzWDwq/oL2Q4afx7gw5xD
 iUHibnKLM/OPlVtvsZssdnQIV9WNspqw+fkDMsNH3iN0TaI3EsHKYOOFZsxqgsbmwWgoa/A4WmT
 3b8zxRDNw28PqJLZIW4mp2LF2e74/+L6ahrkdZx66fXJDa1PZcpdQnVPjSAsjBGLA8Ia8Pz6Tk+
 J5v3T6itkej56nAIxZko/aQKpbyj/Eu9oTteira0x8DTCcCosPioA4bWt55c5V6me3ZhBq5iOcR
 ehITbXMNyL4X2HF4q+w==
X-Proofpoint-ORIG-GUID: Vgv3hgVP_XfRu60IvttmdQSiTrEroene
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090047
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

Enable CONFIG_PARTITION_TYPE_GUID and configure SCSI environment
partition type GUID for QCM6490 and QCS615 board configurations.
This allows these platforms to locate the environment partition
using GPT type GUID instead of unique UUID.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Enable above new config in qcom_qcs615_defconfig and qcm6490_defconfig

 configs/qcm6490_defconfig     | 5 +++++
 configs/qcom_qcs615_defconfig | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index 54eb5dedaec..e9932abbcd6 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -13,3 +13,8 @@ CONFIG_TEXT_BASE=0x9fc00000
 CONFIG_REMAKE_ELF=y
 
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
+
+CONFIG_ENV_IS_IN_SCSI=y
+CONFIG_PARTITION_TYPE_GUID=y
+CONFIG_SCSI_ENV_PART_USE_TYPE_GUID=y
+CONFIG_SCSI_ENV_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"
diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
index 2468267b955..94efa46815b 100644
--- a/configs/qcom_qcs615_defconfig
+++ b/configs/qcom_qcs615_defconfig
@@ -20,3 +20,8 @@ CONFIG_REMAKE_ELF=y
 
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0x9fc00000
+
+CONFIG_ENV_IS_IN_SCSI=y
+CONFIG_PARTITION_TYPE_GUID=y
+CONFIG_SCSI_ENV_PART_USE_TYPE_GUID=y
+CONFIG_SCSI_ENV_PART_TYPE_GUID="bc0330eb-3410-4951-a617-03898dbe3372"
-- 
2.34.1

