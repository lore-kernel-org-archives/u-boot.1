Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38291D29FEE
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 11:17:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E68083623;
	Wed, 14 Jan 2026 12:17:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hien6tIp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aEZXUqQ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E0798003E; Wed, 14 Jan 2026 12:16:59 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46CC18352B
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 12:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60EA56Kv2902912
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 11:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=j6zEKCN9Oqq
 9ghxYnXPwJK7AHUxUENJQywz7P2DPp1s=; b=Hien6tIp7ZEoCrEPUJbpqjIL0ox
 2DE4MixZMgqSLZ7mYnD0TDoAzYT2RAtacGVedmsgsHxaKxfArnxTAOgkJjSGVOGj
 f5s0rfRxzmLKXX9D/Rw2R6wXRUyT1XHQLBmkaMSiYzAZMvTZOAS/oeFq+3oDT1zA
 iCv3pZ3vpLi4bIH1QWV425hEXMeZNe+Yb/SFB59K4NrCdj3O9ilIlHfoaVicKPvh
 u8y1ILxpyejj67MTIoZfAQzh8xW9/dUKR5AvjJjFcTiLp765DZrqoA4SlmPuLNb0
 FRQPnEE+0dXoB1owX1FIW1SkN6iwYYohXfckRkgApH9FzslxhH9W9IZAQBw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp931g7m2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 11:16:55 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-81f46844106so650762b3a.0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 03:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768389415; x=1768994215; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j6zEKCN9Oqq9ghxYnXPwJK7AHUxUENJQywz7P2DPp1s=;
 b=aEZXUqQ3qXaGktA2MEfca247EWBznz67fq2By7T/aaDEXSF1DcYio3ufNc6GbUl7F/
 dFKmsomofz+WL6Jxrhg3orEIsSP33Vk8NRo5gKe5voZxIPeeo0GACeV1ZXa+8G9vYzi6
 T5DoMcRHjSiXis7avT4KIYf8UDyc9/yUrcaF/AM0WaRG8haXEFiMcNhOQ4shRderJrc1
 g+Zuyw6KC7OjAZyrcY4iQqUveHo0AF2SsSLqfzcJDcE2EdY8MAt2sTSPkhkmvLcKiiqS
 Bzb1MN/ZCL77LFzXluhfGI7WYNg7cjAlrfFNZxy8PpFj/Cn+EjAYssQntUADGbzTxj6+
 fmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768389415; x=1768994215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=j6zEKCN9Oqq9ghxYnXPwJK7AHUxUENJQywz7P2DPp1s=;
 b=YVAfa4YEtGRx41R5wIx9qV09Xt9s2d7f51jgcdmQQgziGshoyUYyku//f3uvK5k9Ps
 YV2GWrI+esEjiXmPCNEOyiZrkyW3g9GSiHjGWfoo2XZicTrIs4Ohhle9S2jy7/hj/LUA
 u8VR9+V0917OsaT6GzM+iZtK6BwjuLJ/xFN/WvtXQEfdgDC5QEMdaMybdKTkTbtTIBR4
 QglYu4ivf56jg4v7FJW+PKC6fe3TAAgvCDnzobG7gFIw/DVPcWKl+PdIiCG9XmKkKHGt
 /AgEsD6qwvyx8aW2qRHIty6wojm+DNiB1QBKGaDZVBpVxQRLisYigGpr3flHy4BuH0m5
 uAYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMCqIBRNNev/E2/BpdkChY1EUCdYsKDhW9wgRTXYO57sKWq7eP3bRkisTAxzUrK0pFpi+/G3Q=@lists.denx.de
X-Gm-Message-State: AOJu0YyZSYiBbflXzVx8suF9IzHBDWofeyqk2Kmo1rFi6vYzrPDbmSPe
 z/SQNtEhY/ThA9SOGbxbZm1T9fjm087heZQhfnxgplIvEY6PW+3t11yqgJGH8DT/Tkc3TFwg5Yg
 o0iUFJ6RxAbNgsn5J8zAE1APmbGUJkJyltxXdXN4FFAnm/3GBiXbO3dFD
X-Gm-Gg: AY/fxX6hhDy6pmv2sUezoGRGGjRjY7pfOX8IsGLhf5IM0qnqIK1Pbm8w/HxsAm1ag4b
 Xrm3QqAYkYfhO7wn8X3hMdoEQVefkj2s2w5bfgqTonOtuGRcq8xKZ/y95OaM009Z5RvQGHjoL8c
 0n9O0xGUIRoLqSuuYA2WEXXL8GDUSG+AvK68dKcxbW4K1fcAqdeq02yfsgLQFZWgAuD4qwGjpx2
 5v38BvafdxApV72SSfhuh7n9cNdfrQWI3G8aDSfp5ts07QAYYtdEFUEgjshvqlbGzhmbv9RZKt/
 Vhk4Hven73NIt4trV//apG6d2Vmk+AmCt9ZYtWYt090rSNYD2OT3DyWdBw6GlTdpLe1kM7tcIk6
 mLHFKMRMPyuINnAlBSD6gpPcAla7Obq36Xf38dxCo4Q2IV2gxK7UVcs9iHQpow8gJUgdqg0y0B7
 oKmh8Nw/eeFCQYpGGH5tfC8SiFi4gc
X-Received: by 2002:a05:6a20:7d86:b0:343:9397:c4d6 with SMTP id
 adf61e73a8af0-38bed38880dmr2297022637.23.1768389414572; 
 Wed, 14 Jan 2026 03:16:54 -0800 (PST)
X-Received: by 2002:a05:6a20:7d86:b0:343:9397:c4d6 with SMTP id
 adf61e73a8af0-38bed38880dmr2296997637.23.1768389414066; 
 Wed, 14 Jan 2026 03:16:54 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cd4654sm227758225ad.97.2026.01.14.03.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 03:16:53 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 sajattack@postmarketos.org, marek.vasut+renesas@mailbox.org,
 quic_varada@quicinc.com, me@samcday.com, michal.simek@amd.com,
 sjg@chromium.org, j-humphreys@ti.com, paul.liu@linaro.org,
 raymondmaoca@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v2 2/2] qcom_defconfig: Disable CONFIG_EFI_PSCI_RESET_RUNTIME
Date: Wed, 14 Jan 2026 16:46:24 +0530
Message-Id: <20260114111624.2321852-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114111624.2321852-1-aswin.murugan@oss.qualcomm.com>
References: <20260114111624.2321852-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BOW+bVQG c=1 sm=1 tr=0 ts=69677b27 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=4ZEQAkDRShqY13A0WCoA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: 9PecVAFuI3be2A0sEhiDfigsIqlALzGT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA5MyBTYWx0ZWRfX2JC7/TAAoZos
 D33tmYNdiAS5ZB8G404MR0QzvcMDOXIY4FaUjShx4KBiRBSlDz4lxrndLgKdhHgqUA8gprZGD8Y
 bALa7XEVyLwrCqGu1SSV/zYtM4eAMZhZCbRMd4iojY4LTq514FnBPQnjn7CgvPJORuGk+QF6mSE
 13D/kvd2I1VMThG0dgEIapwrdrPgYE52bWv0bvFAQkHGV8lfbvwQl9QJSYZYlgXn3DQYkLfAWJT
 lpkzT8l/3tD8MyPYVlneB8E5i/Tehtod/wucY2tpT9vxI7X8cV5QnKe6KIHOaDxr86cJ9s0Oj1z
 OXXLIxd8AmZew+e93qTvc62Au9+Ky1vDjl+63jrHNIn3eg7FjWcUzCGnbTw58A5Bo8ofsWL4NtA
 eMMCEvXnrYr3BErU7eh/EtiQxuXeC1PVY1O+QuGDX8f+EVP6wJWpaKJytZY3QtjSTfHeEJ3ihp0
 T10Sp4f5uTRNKSfMkgg==
X-Proofpoint-GUID: 9PecVAFuI3be2A0sEhiDfigsIqlALzGT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140093
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

Disable CONFIG_EFI_PSCI_RESET_RUNTIME in qcom_defconfig to let the kernel
manage reset modes and handle specialized reboot requests correctly.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index a210f4dc5e6..0bd87b1f5a1 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -6,6 +6,7 @@ CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_NR_DRAM_BANKS=24
 CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
 CONFIG_SYS_LOAD_ADDR=0xA0000000
+CONFIG_EFI_PSCI_RESET_RUNTIME=n
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
-- 
2.34.1

