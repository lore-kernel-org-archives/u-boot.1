Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250C7CD5BCE
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 11:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6948583DFF;
	Thu, 13 Nov 2025 12:35:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lkmt6qJG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CRLg7CGd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5236483DFA; Thu, 13 Nov 2025 12:35:05 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 187AD83E1B
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 12:35:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ADBLs9S174840
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=YBE5IVIA5T8
 4d3GfIfa6UqokcwLZNXJsgg2Ako2d1V4=; b=lkmt6qJGCMwku+aD9SDoggPfl9i
 E63aPfLpfwBkqtLpN5LFuLss7K8Q/xZvEvehw3+iay3XGeuzPyjwD3z+LiCb9u6Q
 Nl/i4DX4R+AeZIT22AQ9OmJOyDVMJGpFeLtHvFYNJQmL8FBrXyKm8ybpCf1zU6D8
 lvjDpAsqHgEImDBC+uLATkY7PpSZ2i38Srxb0PDBkfirZ9mwivuvBeqlwz7LOs9B
 xfg9JU1RFfdul951cp7vFKVefCZGpa5MivQdQFXuzgYLAiH/haMZ8u7l8hf1zgsO
 CUrJsy6TZiNnGYJZbJntDZ80+4nWKNHOaUIZlKAW3E1pVfNzvRFTabK8yJw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aded1r13v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:35:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-298389232c4so8923515ad.2
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 03:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763033700; x=1763638500; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YBE5IVIA5T84d3GfIfa6UqokcwLZNXJsgg2Ako2d1V4=;
 b=CRLg7CGdwtOdoPkF3/S9Cc4mDY1KlhNiPUGUvsoMHR2GE77NJhO7cmS0FlrrbbL8UH
 xUsfa89fN3hyvwzQNYiTxrkaesTQnqY9Pi0JPqCl53UvNPHDRMtr/z1Qfee1zz0MBvIz
 Rk3ENpPFgx7yEpf3QHckvf4tx24jUHkbdgBRwxNe0Nf4Zct2Km4TKgWTdRbN1vBUlaak
 PteBxDH4ZmTz3cUCHJ4w+bwSPEbNi8whnFkjuic5Bou6is/Je3hgIPX5dmw9uc6+EZC7
 ICdANvgNy8n/eeE+kV7KLCo0GFaUEkTgUwJQqb0kHxL4Jv0z3SYCYjrrgY/XiyigAy8H
 kjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763033700; x=1763638500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YBE5IVIA5T84d3GfIfa6UqokcwLZNXJsgg2Ako2d1V4=;
 b=qDut42YTBGiVn4pl0tDXLRZxBDPpON2IJzU5BbcN8G9UU7O/NhG1DUIZpn721fY7Vl
 BiXFmCtNzyDsoMzcX/RMsoIReHE57QGxCZ04taTw4Bmys2Tb978DQwa1uZwEHkMlpOEL
 dfxE7E97LlIsB/4yqNpkom91IwNeYl6hFLoe8TEY67A00E6079Wtj5LkYlTQ7Fkk1KiO
 5aqK1ExXhaG52hMhEARYRQP/FjfNaf4BKoH4maEgBqzDqwX+2FfmctqQeOzANC6xhVTy
 3b2K+z7dbJqyzMNtkRvCL0X0QthbtHfV6ekTKhkr+44a7NeeddPMmmQUp7PFYzRigL5I
 pJLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMKIZVzsvxyl9jRDJNTHThVXyo1dMsa41hxGGgmfaOZjxIHP0GVB4X8XGCnE6vQJsNId9C2sE=@lists.denx.de
X-Gm-Message-State: AOJu0YznI2XVK6NdhNIJ71tuQL0QvoBGLaNsVs2s4sidAyZnsBZzJ6t6
 vL/yqvlLwNx9oEO/e3HZSAk+aA6qpel7yAgl1qcGvUCMPqrtNCyrs+qdDo6Tg/nK67NEgRiTvV0
 NXGj8Vj/QCPp3/J39NVnPcj5rGALAIdhLEPnGA+eYJYpEwGRV6jt0RcjY
X-Gm-Gg: ASbGncvwXlrLUjF7zdjNLT97GnZdqB4Pyo19qlvBePZ644soRZv2vjLfNyJFot1xBpg
 nDUa87gzsuBud8jwjYNTfxpuw8ozT72jd+2LT3oB9mLfymK1QV01e9pLDpb9ZAur2v0saIZWMw6
 5hpi9OUWR85z0rbq/uSXOzjjtlVFV9h934yAudnSOq7NXs0k0YX8/aqHNEH9bMS9eZ3rUYmkyxv
 tsnWXaRRvFQ0+GvHnfSv7iRt6wfPZQR9urWKOWWCnmmiOQpsMvzgtWsZztr8s/9B3qvmH30RXjJ
 v9sWE7AtHqrxEv4Wh++ioFQHYe+icugP5vqnq1Dc8Wb+kNkHSPYK4hQabxPafXRLnbQdK7ANlWC
 20YcD+ieIxA3n4xGyM5fxnxwhMweeLfFWala9rJwYvj9Uerz7HJ+6r4nTqAsJe7owt2OEe1btPd
 WJAN3qXvJjBYE9c7/vcg==
X-Received: by 2002:a17:903:2f92:b0:252:a80c:3cc5 with SMTP id
 d9443c01a7336-2984ed40b02mr81589345ad.22.1763033700349; 
 Thu, 13 Nov 2025 03:35:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnXblVPsAttwcz1cXN+bwWuhMIvs3kn7WSyfutr57J/blqnSYIOD7jstc83RqXoClfCBQv7A==
X-Received: by 2002:a17:903:2f92:b0:252:a80c:3cc5 with SMTP id
 d9443c01a7336-2984ed40b02mr81588985ad.22.1763033699854; 
 Thu, 13 Nov 2025 03:34:59 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2985c2346e6sm22573885ad.22.2025.11.13.03.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 03:34:59 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com, peng.fan@nxp.com,
 aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, me@samcday.com,
 sajattack@postmarketos.org, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, alif.zakuan.yuslaimi@altera.com,
 tien.fong.chee@altera.com, miquel.raynal@bootlin.com,
 balaji.selvanathan@oss.qualcomm.com, w.egorov@phytec.de,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v6 3/5] power-domain: Add warning when power-domain driver is
 missing
Date: Thu, 13 Nov 2025 17:04:25 +0530
Message-Id: <20251113113427.2218045-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113113427.2218045-1-aswin.murugan@oss.qualcomm.com>
References: <20251113113427.2218045-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _JjEKy4BqQsfyaKV1kDqAbiSBmxCNIu-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA4NiBTYWx0ZWRfXzToo/NMOZNUL
 N8GVYztrAmCmlJCdDl5bZol8Bz4/8sVKKBnxsfQ9vh72F3/hlMN+Dwq34p6sBi5mHLsr00gXU49
 pBXdpajW8kPe77Kik/F2CRwFUD4/MrhlroFC4G+gRFZfYUtKj5BnBCf6SzD47dzGhg3+J+hLl3R
 Y2vkNriG88JsJ0HNNAWC8vDIDmdwqr1wLZU1D5z6sHmHOzcy56nl20htyNVUuGdhUHo0+y0V1Uf
 VGjN2sx16K6Gr5VUXhgDTzI0B/bPNR1ZnQ+hCWuRmEhyGZ2dGPlPHCz8vhoL9d7ncvo5dISK8Av
 J1gIL7V/PK8YrRaIk2DRx1fPrJfXBRMKha3Mi9b95zqBq2J6wv0HSiFO+EzTVEGXvJmxjFrgM6H
 TdahN/UeOr5rtHulk47mfiFrKvuDbQ==
X-Authority-Analysis: v=2.4 cv=StudKfO0 c=1 sm=1 tr=0 ts=6915c265 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=oaKz_nLDyQCm_LzWltEA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: _JjEKy4BqQsfyaKV1kDqAbiSBmxCNIu-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130086
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
Changes in v6:
- Newly added the change in drivers/power/domain/power-domain-uclass.c to give warning
  when power-domain driver is missing
---
 drivers/power/domain/power-domain-uclass.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/domain/power-domain-uclass.c b/drivers/power/domain/power-domain-uclass.c
index d9fa8ad4bd2..b5d9b08b150 100644
--- a/drivers/power/domain/power-domain-uclass.c
+++ b/drivers/power/domain/power-domain-uclass.c
@@ -10,6 +10,7 @@
 #include <malloc.h>
 #include <power-domain.h>
 #include <power-domain-uclass.h>
+#include <dm/device_compat.h>
 #include <dm/device-internal.h>
 
 struct power_domain_priv {
@@ -184,6 +185,13 @@ static int dev_power_domain_ctrl(struct udevice *dev, bool on)
 					    "#power-domain-cells", 0);
 	for (i = 0; i < count; i++) {
 		ret = power_domain_get_by_index(dev, &pd, i);
+
+		if (ret) {
+			if (ret == -ENODEV)
+				dev_warn(dev, "power-domain driver not found\n");
+			return (ret == -ENODEV) ? 0 : ret;
+		}
+
 		if (ret)
 			return ret;
 		if (on)
-- 
2.34.1

