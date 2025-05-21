Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C03C54E65
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 09:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23D4382E08;
	Wed, 21 May 2025 11:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cSst1yrF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EA5482D59; Wed, 21 May 2025 11:45:20 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED34882E08
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 11:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XMJh011357
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 09:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Xdo52cynpbl
 XgdLTK2I8iZTlecLZUTScvIy/4gNtafM=; b=cSst1yrFIow32jRCdG8HtWg54bA
 VoxJKounAITrw1pgp0qHNGUDvc+pGJaB8oGtklD6jNvX1lhnHq4wJ3cg+M+GjcW/
 mbR5qUgqiDzC38NtwRpIUdiAlQUIBA97CzSx+FKXOZjdXnQLsc5D/iIcRL8ZXefb
 LS8vUHH4KsZc4DuMKTFTYtN1n3gKG/6JNbTB/szFRk83f9upZNIa3beKS5D/b3vl
 NmB8mb1B42paFCXo/HKEJM59YQdhVr3UMZDZ7Cwc1yBe6yPKs8jCULVOqhBflozR
 lVp0USvQxrc3OCqGAw2AlQc3XuqlFKz2GVOeH8aIy+EE15cAD3FuM392dVw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwfb2ejj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 09:45:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-30ebf91d150so4943134a91.0
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 02:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747820715; x=1748425515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xdo52cynpblXgdLTK2I8iZTlecLZUTScvIy/4gNtafM=;
 b=b/Qf6Miz01pLo/6ESf9t03XcNbp0xznP/NYnqlJTMx3Qco0gHMk4BoWv/k1HXqbW1+
 3RYjkTcoUWvEuI1II9lUJ7ujH5NINn7TtF9hlSP0CqeUsgsQDKDzCqGLDntFW7k/UkK2
 BNllRzGda6WyU+o304NWAXJuzxcr6Gv0o+KJsBxdv2ZFB9sMM3IpOvvEvdS/AKJZXcw2
 +ut24MNW80ibYMJnje7DYY20NSgJMn6gh7esfhFLtf4O4k2upuJAguR9PPbolJvS1ZsS
 7Nmaud/seFmt6DsQHP3wUnojDYFRFBZxLac6ya/qKiBXLU8axjwN+D4FG/eZAUhteJoI
 XQJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBv0xBXLs86fcbmy0jyS7mi20VSPTZuetZ/3Yrsq7CP9kGHOKKRq3b32QVMVqJPDQLwq966o8=@lists.denx.de
X-Gm-Message-State: AOJu0YxKwG3R3DFlS54xEF5h4YUpqLPOH70jQ35tLnwuP8uJA8sEBLTi
 B/qsRnpIzrQFUEhTkf0P4/PWfFzPLLgCsdToCv+yerRcYrSOqzTTE562ePq5jn7aLKcJ6bJzs7W
 uu3FABlKIiswA4rd9pYsCH55vrYDH6iPps9dQtL3/EqkDh2vAIYpbVYP5
X-Gm-Gg: ASbGncusCS/hsCvCtBGWddopjE48hW8rMpzPg+MXmOLptM0yTzNGIwCXoas1p4VVTyd
 4IC9ymKwSHaA77LYc1Ohe7kf2p6bda3YYFLpoj3OUMVw9D5Lvy79ddK0PKYOlo9mNqG7PWB+vVh
 BRzu39MEOc/R7roO13sU5L3hiRMEn84wfksIIscLhruybmM8rG2dmTCRdUX1GFavtwHXp9XheVh
 42eBMl6Q21cEpByztk0GKoVxVq3wcfeYyxIAve3ReJuRUBP5P0gdGYQ5nG3X+KT5HlagIYt5r8c
 Nqu0Aj0fzUq+MpuRHyQwvh/RWW0BVDJ6dcilRXhVzi9bRjL1NqfLvZ6qmXHzNLulwkKsdJT4l+d
 VtwgWX83Zwb4ciHFYtMmrhIq0yjEuL6ktxqUoEXkR
X-Received: by 2002:a17:90b:3b46:b0:30a:204e:3271 with SMTP id
 98e67ed59e1d1-30e7d5564e7mr36717595a91.17.1747820715123; 
 Wed, 21 May 2025 02:45:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1FiVwuwoagb1DBeaPPVRHc0So8sAewf9Lmaq9Trh0DIQ5CeK4osNmBY/s2T2BkaGSbEK0Iw==
X-Received: by 2002:a17:90b:3b46:b0:30a:204e:3271 with SMTP id
 98e67ed59e1d1-30e7d5564e7mr36717547a91.17.1747820714673; 
 Wed, 21 May 2025 02:45:14 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f3650000csm3226367a91.37.2025.05.21.02.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 02:45:14 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 sjg@chromium.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 5/6] qcom_defconfig: Enable QCS8300 clock driver
Date: Wed, 21 May 2025 15:14:41 +0530
Message-Id: <20250521094442.3522036-6-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521094442.3522036-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250521094442.3522036-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PHzhBCzCJw0RyqTnYRT5p-9vwPHE15NZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5NiBTYWx0ZWRfX7Run/y7pvNHo
 ATx9CoMTuuFln+kIk7AsEKLUEvkXe5VCQ2m/a19i9Ct0p5lxaY5l+WK1tklPQi9WGRb+A4PhcXU
 5hqFwYwaE1Ut+WBuj0n8z7Y1MQwC2ZA664h5YbzdlVwbvgwAzo3S4M82nvKVVaAPntmSDbPl1j/
 oS2iNQcws7I+xkJoNAFcK0QWjzlDb0MxJki1Jc8kUHK772VEth0dqw9pDA1VrDexGsbcwaLmiha
 35Uii1l+X4vCU6IZ6Rc8KqXnIcCt9rBAzoCHPEZfnd40nclYz4eYRILRBUwBJ3J86CRUiwOwHqd
 kv4JrCwtY0qpr3bE72zaC7k9CHad+glxs+PUeKf9zUwI1tlLuV8+a4r7JoKuS6kfJlS0etrZ8zf
 rmf75OXdEk8iymehwdFrhy/LI115MS/yUNNUVPbb+u7vB12J/LmDI4o9YvXBEEdHP3Vjxz33
X-Proofpoint-GUID: PHzhBCzCJw0RyqTnYRT5p-9vwPHE15NZ
X-Authority-Analysis: v=2.4 cv=dLCmmPZb c=1 sm=1 tr=0 ts=682da0ac cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=yiAYSNrAowt6Iz-k4CwA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=766 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210096
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

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
v3:
- No changes to this patch in v3

v2:
- Arranged the configs in alphabetical order in configs/qcom_defconfig
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index b8399701da0..fbbf82d947a 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -51,6 +51,7 @@ CONFIG_CLK_QCOM_APQ8016=y
 CONFIG_CLK_QCOM_APQ8096=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
+CONFIG_CLK_QCOM_QCS8300=y
 CONFIG_CLK_QCOM_SA8775P=y
 CONFIG_CLK_QCOM_SDM845=y
 CONFIG_CLK_QCOM_SM6115=y
-- 
2.34.1

