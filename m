Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985FEC36018
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08F3D82F8F;
	Mon,  7 Apr 2025 19:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mTTSzS5V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CF1582E76; Mon,  7 Apr 2025 19:56:34 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36DAF82E76
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 19:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378e1o7016479
 for <u-boot@lists.denx.de>; Mon, 7 Apr 2025 17:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KeqYb4+0r8u
 mFmRxMQGE5fwWbgNp1qWhGwaTOPeQtQc=; b=mTTSzS5V0llft8YMFJ31Y+1+CqS
 ILImwAuhhmY1jo7BU7W31eCl2GfM+C1BZtuBBQWbBZBioqmFV6iSq3pRwTaGPyIi
 7y+5UknCmn18H6LbjIwgLbfifjtJUekgGQasRVr5byUmpJprOY195arVrIPpJGsT
 cqTO4LzzRwRUU89XcGcOPJO8lnfeliC7n+pUBA5jSMDJCtqk8UQ1uzj6pC7LSIQI
 7dEB0zDxpqgL1NtG5IhApJVCn/qMmFcGFdmgRyan2Bc75c1Gl2LH0YQgiDYThe5N
 BEtmZcvvCam53Bxh79E8BTwe51GNBzCADDgaDPeextlQ657sP3Nxgza9GVA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twdgd34w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 17:56:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c5b9333642so490599885a.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 10:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744048590; x=1744653390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KeqYb4+0r8umFmRxMQGE5fwWbgNp1qWhGwaTOPeQtQc=;
 b=g0VmcYgAbdczf2ags8/6w//GS4e26DZTCnIg1OllAQnRSp1yL4uzwUDDM1BrEVzmag
 VnqKBUK0hvE1DrXL2XPQnZwfwRmJWcxdfkTXJ2tn07E8nFnUUTvQMezRImaFriZGeR/6
 SJikILDyk7QIVMmWBSlApRib2xAbT2ZJDXpJ7yaFgkZXB/rCtOcwrSfjvt6S8zWiPcoV
 5tRqxeWU7oV+wEb8s2j49wkXSdXmqYCAoORQvwlwhTXbuqHe4LpkKAgxMOCjO5XfXgkI
 f7nfLfE5jisq006Bm4DokYx4/NbaENrKiTeHRx0pRe2q6d4gzEyQ4OP3QPK5BfpCix9Z
 w30g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCmpH4eG1YS6VXQwHcNcvB7euKCAewaMaNF6xkhZFdiA16Fkdx1wKyLrd3hWv70RBfkkNEwCM=@lists.denx.de
X-Gm-Message-State: AOJu0Ywp1z7SpfsjtWV5FEzievRUOOfcsAPvyBaucd7rN+j7F8cLHEJW
 1cdA8w66Kp1086BO6qGA3rXOusm0xbgigw7ePl67JLuPvAFOeGkHj6lUIhrJDCAhmSlCN/hPpwi
 j8ypd26pxVCyWbGf6We/TiSWs9q7ssb6kxW8KY2yG6bhm5bQhkCKG
X-Gm-Gg: ASbGnctwkOihNPgsXjRLh7NNfaaqWGH2ueYbm/Urx1i04y9dtCX5p9xYXgjF7MBa56z
 7/VRxvywdTZt2sI8GcLwiiX1JC1MPguRCz4atPvmxh3K0RjOGbH4k6ks+gXevwWYrBfBkAIwpnJ
 TRd/elSehokCUp026r7QBXnSesviC1nCZK/KS4fp5zbTy1dkrdvrHCN0o1wBrZ3q+KFquqd/sgE
 uuwkHPNLusLxoR6l/pFtKrCAJkWfEQj2paUE0MWi/V7cPaNwNbB8Tysxa1EBht/t3uBWvzcDPsw
 gdesE1K1dQG7mbjAdWYZM6ZqpXoKal9JON4TRWItgoqLz1VBrAWiw+dzbwdrTw0iD4E=
X-Received: by 2002:a05:620a:28d3:b0:7c5:4c49:7697 with SMTP id
 af79cd13be357-7c7759ea8f9mr2027584785a.6.1744048590115; 
 Mon, 07 Apr 2025 10:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9Iml2qY89DXGEgVRFbk3XI3LJh5qN+yUYhT4K+VBTD37sDClKhuU8w7OHS9JlWS8bBSQyzQ==
X-Received: by 2002:a05:620a:28d3:b0:7c5:4c49:7697 with SMTP id
 af79cd13be357-7c7759ea8f9mr2027581385a.6.1744048589765; 
 Mon, 07 Apr 2025 10:56:29 -0700 (PDT)
Received: from trex.. (65.red-79-144-193.dynamicip.rima-tde.net.
 [79.144.193.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec342a1fesm139346005e9.3.2025.04.07.10.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 10:56:29 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH 4/5] clk: stub: add qcom,glink-smd-rpm
Date: Mon,  7 Apr 2025 19:56:16 +0200
Message-Id: <20250407175617.3494506-4-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407175617.3494506-1-jorge.ramirez@oss.qualcomm.com>
References: <20250407175617.3494506-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PJgP+eqC c=1 sm=1 tr=0 ts=67f411ce cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=K4l/FCcx7sfGu+4G7WjjoA==:17
 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=UqlJzHZL04KVmTu5ItAA:9
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 0VqceXdqcw9SkDdIEuIWxyawfhekmiJn
X-Proofpoint-GUID: 0VqceXdqcw9SkDdIEuIWxyawfhekmiJn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_05,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070125
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

Add support for the resource power manager clocks over SMD/GLINK to be
stubbed.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/clk-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 5fbbb07b7f7..38ed0d094fa 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -14,7 +14,7 @@
 static const struct udevice_id nop_parent_ids[] = {
 	{ .compatible = "qcom,rpm-proc" },
 	{ .compatible = "qcom,glink-rpm" },
-	{ .compatible = "qcom,rpm-sm6115" },
+	{ .compatible = "qcom,glink-smd-rpm" },
 	{ }
 };
 
-- 
2.34.1

