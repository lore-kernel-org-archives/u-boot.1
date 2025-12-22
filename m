Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557C0E6749A
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 11:49:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30C5B83EDF;
	Mon, 22 Dec 2025 12:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PQbS4i8m";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N3G6C79a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53BAF83F4C; Mon, 22 Dec 2025 12:49:17 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61FEC83C28
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:49:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BMBaaJr1200883
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 11:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VMX72faXIpQ
 fTJsQtDSF0vcSEjjDhQ9DD7lPhXWL6hQ=; b=PQbS4i8mEi+jNtGxNt6vzZffqsO
 wJvFInCNLc0a5VbtgFi5BqErqZ6fZwGjChnhGxylswuXER/yui7HbaEX0sBXOSnK
 lAf7Tkv3wV7zcjYd+myb7CHVf4jLmgZJ50DHZM/C/cq1nNpZ5LdedKc7tyFyop8n
 Xl1IFrUDXDyBeCtcZYQFqzQr5dxsFA/hpVTvJqeGYk6rNTuHrGg6sTTUVj2zSVvr
 VhXScRimIAm4EsDxfcZxHOMmAiV3qIrDGglp9Bcq5dCmMQj/cZGMq89JNM05k3Jl
 Hams6OAegDVaqpEprjbotGTfp4rKoOhhiVXB+gz9jQCJgKt9jMmRVMO+ffg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b758y00w6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 11:49:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-29f29ae883bso56352585ad.3
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 03:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766404148; x=1767008948; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMX72faXIpQfTJsQtDSF0vcSEjjDhQ9DD7lPhXWL6hQ=;
 b=N3G6C79aBtFyPX5PFw54v3snm30cPzp8adtP80Ye73nNXUrNOAzwe6tRDl/zU92XGw
 rIrVSbicsplKCASRr8bChNUuBoRPXeagsNzwEn4rduCatEqwhcz4RspbpTY3bwRDOboN
 XOoJLuMPgAEtA3rfX7yRSYK5mAUg+NgKhExPKG5hV3Q9sATEFbxnF/08l4JzixDIA2ci
 nTKe8QRHglKoy/OwhZUPxr0oNJtYTNCoSlcSK3lnr6Trj57SktAtlUK3X1/BJC/CkNdr
 ar2EfezXnTlgcYOnwn6W1rGHe9+1lafbWzn2tDvzUbLlvb+GimXV5wLRNKdZpKZz7cy9
 RV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766404148; x=1767008948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VMX72faXIpQfTJsQtDSF0vcSEjjDhQ9DD7lPhXWL6hQ=;
 b=Iq3DPW6I3yZQEzKhzBYEvcrMuwSeSQfiySLnoAMI9mwFLm2QAHKQ8wx7EDbWircdwT
 L4uC51BK5M3LP4MCSmuZwkbODoV4l4vZ+2CRIJk6O25n3nwb3y57bzq0pjsaoLJJLSaJ
 bfpCmtVUXVfZ2ywH3JYmT/YIl69acpr5iMZZZ3jzGI4Th0lNzLY09aqgoKwN28i9Lg+0
 srumTISc+5T16H9mq0D0521gGkD/Y29eOqmaR6lrA43jqTF9DJR8QbjeEafo1SztbiR2
 BOwYkKCFxmpcdq5nhfYsyEQk+/VXQZ9gjVBcR6c8p9zq0usZ6/IbglR8hhyYC6gLyhXe
 YMig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkOvMGrvm23nCEBiqYdOW59BGhdABVGrlViR1MookYBzp6D3LcUv02+DFnq82TnVIAGUDKWhs=@lists.denx.de
X-Gm-Message-State: AOJu0YxbsjW+BleppgiaB90GsWh8ocJwFdqWytGeerBluDPcLUqcmpvf
 KExRFqSkghGnmzn0PU0sef67jS6ST+R9uXo5k82HJlwUcjw7/gB+VUOUV8Af101DsUWzE58jaMO
 4TVRgcVVaQrhaEG4zO2y8IG5tr2qh0xc46GovhN02tsF3GJquMs7dYL1uuvU6431k
X-Gm-Gg: AY/fxX6Xx2Pu1qv2VwwKbPVaZWGfdzk6xTglmDQuYUNTvoDzHddgCLmrCNdPC66aV1K
 vuzY93l00i0R7ENg7olONPjRcTgA8V50xuNwGvebjkl62h0nPrJfZ+r5pJQ0ag8+TtWJKbt/iYH
 8C3A8m3JdZHWJm057670r0Vt9krXWrnX8B0pEONyWVaXPU+IbqZSqIIBZf/qvnY3FCPY5r2XeS8
 w8FDpPmP1ZjfIpkR1vdya080QpSMh2QEKvLifAcmm4sll16ONGOUtDSC8Pwgtr1X/m7R+XJnUWf
 +iuWRWZwySuwAZvZLnwKMGEV2fTs591ZK7VrtrRyxOxeLffIOlfp5CIoka8PGP18euYI6ujzt1Q
 ih5G3D0wzsnOFDteK8A5l0K0A+JMLw11W4hBeb7b2ZqObBDXZHAO4DBmEXvP2AqOkhoQHnDnOQy
 GijhY23+uiajoc7e95Z5JwlYIz9SMG
X-Received: by 2002:a17:902:e94f:b0:267:a5df:9b07 with SMTP id
 d9443c01a7336-2a2f2212844mr96341765ad.12.1766404147554; 
 Mon, 22 Dec 2025 03:49:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHE9fl+8XrrVLhLeacEfwQ7ToUuMqte3k60GObnvCO9vDKwdfjlh5SdH3sTEGnL5tfdiRHlXg==
X-Received: by 2002:a17:902:e94f:b0:267:a5df:9b07 with SMTP id
 d9443c01a7336-2a2f2212844mr96341585ad.12.1766404147099; 
 Mon, 22 Dec 2025 03:49:07 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d658sm94875935ad.78.2025.12.22.03.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 03:49:06 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, miquel.raynal@bootlin.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 w.egorov@phytec.de, u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v7 2/4] power-domain: Add warning when power-domain driver is
 missing
Date: Mon, 22 Dec 2025 17:18:21 +0530
Message-Id: <20251222114823.2146775-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251222114823.2146775-1-aswin.murugan@oss.qualcomm.com>
References: <20251222114823.2146775-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TOdIilla c=1 sm=1 tr=0 ts=69493034 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=oaKz_nLDyQCm_LzWltEA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: GNdS1tGIDnfw-ue_hqdkL1027aSE_AKV
X-Proofpoint-GUID: GNdS1tGIDnfw-ue_hqdkL1027aSE_AKV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDEwNiBTYWx0ZWRfX6toMFjuiIfGX
 +EbLja4xbgUHOCJQudi1UylHI0JP84yim35/1aY4VrgnTbDdSGQhf/RnYU7G2WuUBf/WiNhFYbl
 /C/zycP8xyeUwlGLpvOWA3tkaLXWCHbb2dC4mUjMPJcpYNnLKYXD/MM9xuD0CoiWH0YJ5b8SHov
 vyyxsU0LSWh0vYUP8ZKmWR5xLGZo6BJ6+ShqEyrGZakDVezSprrhfMohkqg+PFfOWAkL1Kn2Wsj
 mLE962m9drTApLbBN8RT/RHHwSY/ExvA7hq4LnFMA2z0LBnh9pz7cQLgb3SipT7HHVqK7ESY0XP
 jRtr9Itaup/dnbsbyVWBbFsFt7SHjh3mgr3e55aC7flgEBEEnVk/tomKZ9u9eoUfiUvOjyl/ZDB
 FfoUHjT0LWmNK6rdO6uxhDmFy8epsMNJLQNLJo0LE/GZOuycT1/Ornwg+0iZTn4xNwXnr2vfJyc
 5pZ+T7zLJQ0t1QcwcFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220106
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

Update dev_power_domain_ctrl() to log a warning if the power-domain
driver is not found (-ENODEV). Return 0 in this case to allow continued
execution, while preserving error handling for other failures.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v7:
- Cleaned up the warning logic in drivers/power/domain/power-domain-uclass.c
  when power-domain driver is missing

Changes in v6:
- Newly added the change in drivers/power/domain/power-domain-uclass.c to give warning
  when power-domain driver is missing
---
 drivers/power/domain/power-domain-uclass.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/domain/power-domain-uclass.c b/drivers/power/domain/power-domain-uclass.c
index d9fa8ad4bd2..52f56f57658 100644
--- a/drivers/power/domain/power-domain-uclass.c
+++ b/drivers/power/domain/power-domain-uclass.c
@@ -10,6 +10,7 @@
 #include <malloc.h>
 #include <power-domain.h>
 #include <power-domain-uclass.h>
+#include <dm/device_compat.h>
 #include <dm/device-internal.h>
 
 struct power_domain_priv {
@@ -184,6 +185,12 @@ static int dev_power_domain_ctrl(struct udevice *dev, bool on)
 					    "#power-domain-cells", 0);
 	for (i = 0; i < count; i++) {
 		ret = power_domain_get_by_index(dev, &pd, i);
+
+		if (ret == -ENODEV) {
+			dev_warn(dev, "power-domain driver not found\n");
+			return 0;
+		}
+
 		if (ret)
 			return ret;
 		if (on)
-- 
2.34.1

