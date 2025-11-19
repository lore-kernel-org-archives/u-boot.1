Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F4ACF34C3
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:26:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBDBC84021;
	Wed, 19 Nov 2025 16:26:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VM36CVY+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ajowv5sg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B90F8401A; Wed, 19 Nov 2025 16:26:10 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38ECE84021
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AJBIs9v536906
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LBlI7VpNGjo
 Ql5Tz12IK6qgb4K+jzvDWVepzthF/PKI=; b=VM36CVY+snGlA0wWv4wbxGzC2Y4
 TEzgltN+bc6OtFV1aAn9XdoMSDLG9kpNzwH0+sZQI3VinyHSznd/XTE5ubMBo7yt
 nrYNDhaL/G0qPmGVKJ3Cc2Q36F67FN97er1EeYdPBpZYncQ21UhhKD9EBcyzKR8d
 tfRx+SccM/ckwMr5UqPnvLbEZxE/mTSg6+mQ/iHfBRdPF5+DbbOTX0A0aJgavBsu
 ZnMvz4HN0kPlTZ87aMzoWla1bQG2p4yKhwH5L5O7+eVYQYb/4vy6EVOdcRlEjl8W
 8I8fkpoSl8DVNENbSM+kKZlVUOzhC380y/ZlW6z4lAN3O/lErGzT6V8s0HQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ah65t202a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:26:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34188ba5990so20515203a91.0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 07:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763565966; x=1764170766; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LBlI7VpNGjoQl5Tz12IK6qgb4K+jzvDWVepzthF/PKI=;
 b=Ajowv5sg/9w1Jpm8eYXz2DDPBYwJPwnfxPAUyZ5EHQsqIZc4ys00Y2cH1BTQmcjCVk
 GypsLY5WLQRr+jnAEkPEbup+LXWkOu5mH/1OkV7TUDobu/UGYZbb3Aab4ulgt3LnZLHA
 cVPN8kgVu4QkOtbyUhZbXOvw3OWKz9mrTz59eTRszqfy95Ddy2rsPO+rWwrRm1P8d3pj
 3j0VCG2xbJ8yX/osroSw1+uhRG8TaKIhySmXBQOsRtKZaKkOyCAAsz/YrAahHWh5lTav
 p56cf3F+DU2v+sLFtoA12V4NMUVInAS1IaKwpvWigr8gZNrWaNaGBDtntLTfSfiHCDSo
 EZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763565966; x=1764170766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LBlI7VpNGjoQl5Tz12IK6qgb4K+jzvDWVepzthF/PKI=;
 b=DcqHGJt/5ab+QYdzwRrgN2JtkRhOLUNiZKNqSVvFyuSF9suYTUsot4Aa1JnphPmGBm
 eLlR47RN7ErOH/BabxjE4a+UDOm9KF8jNnO8ueVD8vXn+LprbKkxqsiyWjzOxb7RkPpo
 ix4YJE4vitjKmxliJe7qBl5vWL14WfQg/PajyL9+ckdRRFfV47n+RFq/9PtAlqZR2nTX
 k6uzVcZHr67GT7pImigTMh4Qf/izOBOWa+EaF28XwaZD5v7oSfkHZxbTISY5apvP1gmC
 Xowqjaw3dKcTMjW3CC7R3qqGJxnA1JxtU60A2SmrdT3Vj/4Rviac/UHHdI3r3aVTcr2F
 Gs8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZmSiLREo2rnrz74dAyFlZgwnD1QoQ//8VQmXCOeom/VaRPX03dqitufqkz54pkQevQd3DKoM=@lists.denx.de
X-Gm-Message-State: AOJu0Ywj/Rtl5Tt0gxT3oe5xicJkGyqTrIXGnvgGzFNhtbR++fg2o5P4
 wtifbPvPTdgMN124ZEfJOgd3C/BLAiPMV/Q/h0heAH4FsZmCX4o0SdbvFCv0gs0qopEglb58+1y
 rbBU58k8ogkWOj4m+7YarpLS6QNXm9mdorL9vGG8jw2SrEFSfyeJntmw6
X-Gm-Gg: ASbGncsI8U9aHpTMciK9MCF2rL/8vNIyG7d2KOoQ55RFgyy05oNydDesOImSrywOY7r
 rooNL9t3GMm7m18KYV+mlUbIfLcJgftNEhJs70ynIPR2VG5F9GaPUUoLMI1PiOytsTICqSwLsgR
 7YzsdTy3OcUQdXVvr+CzdNMRgBDwbE/DmCeVagILc7EJUF+yKfVzqYmItNx+itpOLTD5JoMZHA6
 f44do06LpkMEMRUyAm274U2xMCOJOz/VPhRcAV3ORcUlD3irzy2RRJcX/F+rbXApDYdjf0EIbvz
 j0kOYwRzT5WgD7xhuQqrU3ob/XOu8So1/HEkKZgZA9UOb+ASzRT/WfsiGWzBQsPWK2e08J0bCfV
 sMd6sgGdta+GrRG4VtTh+SFjHMsEMIkta3nYSbw1ti/kzP/GcDuJawdWtS7LnZvRtm4Ujqi6dcY
 Oya/OD/BmEb2BbH3Fo2ni1ZwNCub5b+ZVWPjw+GQ==
X-Received: by 2002:a17:90b:554b:b0:338:3789:2e7b with SMTP id
 98e67ed59e1d1-343f9ea58c7mr22600528a91.13.1763565965671; 
 Wed, 19 Nov 2025 07:26:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwR77G5hzWWht/5vv3UqojlKFqFFa8KB1CFHX1xxD/F9z4r4kHKUg5em7Rn0s/ELx/erPGdQ==
X-Received: by 2002:a17:90b:554b:b0:338:3789:2e7b with SMTP id
 98e67ed59e1d1-343f9ea58c7mr22600497a91.13.1763565965230; 
 Wed, 19 Nov 2025 07:26:05 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-345bbfc8eefsm3083157a91.4.2025.11.19.07.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 07:26:04 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 rui.silva@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, mkorpershoek@kernel.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: [PATCH v1 6/6] configs: qcm6490: Enable super-speed USB support
Date: Wed, 19 Nov 2025 20:55:30 +0530
Message-Id: <20251119152530.4175628-7-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=avK/yCZV c=1 sm=1 tr=0 ts=691de18e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=bWnyX05zxYj0a8V6Ie8A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDEyMyBTYWx0ZWRfX6vAf60bWi8Bx
 6+XFUTeE0Yj6a9OhY2WJREPEfDHaX7l87XsLBBGLpKula1pTbnw6FwPgvlgyZY3oICwlMJJA0SO
 zhrAeqptdtdk8bwMaN+Kz4A2ajEa7YwCgmqqQbWlTgbDPiidrMKZ+dIu3Ou7rkRJ3gUC1QZnotj
 S/tkSOaPt25v4pj1v1YWnZeNogWFzDrIqGayI6fTtADt6PbFe9mzfzHNG6XC/fA2nT4kWVyeDbY
 BQo79vNeC6k7XOi20+HWJp1LKRGLs5QVyyjPtbENEls9NRLex8Syt+aMnIynxcvA3NOZ8sf7om3
 lZxAdj0Qob8CNVh2R9+pZkGylwq+BksuQa/G89SPD93xcTJWUFzCFrtolEgfv3pKIdGe/Krp14C
 1Tg0HqWL9NQaURFCOJj2IsBEu+S3HA==
X-Proofpoint-GUID: jbGgBmDxcbePVu-It5ItKtIk3wjD68aV
X-Proofpoint-ORIG-GUID: jbGgBmDxcbePVu-It5ItKtIk3wjD68aV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190123
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

Enable the QMP Combo PHY driver and disable the USB speed fixup
to allow super-speed USB operation on QCM6490 platforms.

With the QMP USB3-DP Combo PHY driver now available, QCM6490 can
support super-speed USB in U-Boot. The USB speed limitation fixup
is no longer needed and would prevent the hardware from operating
at full capability.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcm6490_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index 54eb5dedaec..1d9d9a2425d 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -13,3 +13,8 @@ CONFIG_TEXT_BASE=0x9fc00000
 CONFIG_REMAKE_ELF=y
 
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
+
+# Disable USB fixup - QCM6490 supports super-speed USB
+# CONFIG_QCOM_USB_FIXUP is not set
+
+CONFIG_PHY_QCOM_QMP_COMBO=y
-- 
2.34.1

