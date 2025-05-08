Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D68C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 12:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EF7C822D7;
	Thu,  8 May 2025 14:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bFkhoea6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F24A2828B3; Thu,  8 May 2025 13:20:12 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80F3482153
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 13:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5484Wgme009260
 for <u-boot@lists.denx.de>; Thu, 8 May 2025 11:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LB2fdGS99vH
 m7hAfUtK0ZqhKO2ioy8o4vdqy/e/GWM4=; b=bFkhoea6qeK+bz1smtqYRL3R6A6
 K6kyM3lrAKrs/AtA6H1iYo8DB7470CRhEp9tUmbAbOMoVck3Z5/BF0eCXpfb/03h
 zAFutGUa2iVL+OjJ6Ewx5m2SDP+tc7Q6ORcUzoUNOdBaN3wflMYFXhjZwo/o8Ws1
 iOW4pRMWcgkZCigXBf8l3SVIzc+ce92GRJX5vZc2LDb2KpVFJx08ahJ+jfAk01Zu
 MCW8clcBqLBTGGMqZuwXQLYjZTQOrI6riB7IW0lFfrJ8nw3iF/TeB9lT7/w5rnAu
 KCsuK6Dsa4bvPpUSDFJLs4SllMEk/XK2oZlWjzL3TwGHcNUDJbKIj9LZEAA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnp593y8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 11:20:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-22e68e50f80so7082945ad.1
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 04:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746703208; x=1747308008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LB2fdGS99vHm7hAfUtK0ZqhKO2ioy8o4vdqy/e/GWM4=;
 b=aYKss6qTV3dqYCG6ouDekQ5ZBzPejxc7fcod75pDYOXjplPLJxC44Ls8XPxjexic/1
 CnKG99BmicP1k1k0DWnEuN2jzr1HDFMFmgm5VN2Q2qSAWxeszMASkktoBZ/ZZpm7nRJD
 Q5PwdqpWYQy4NlIYU2XBywzaWaVUEgWyS9PUy93QiAN4CCwJNhTTONCKJwbrqPI3ExN7
 nsD4BCukGbS7LT5UriC8P9Tkky+KJ8epFvkmkX2DVwBAbNB9lzM9DODN9x/HomlZ+IbG
 4J4xsM4AmfZGzb9k9IdgkNPK2oyGlLJNUFaEUGu6Sbf4TNg05/kSmXkvE/j/4ZNaB1q/
 Yxig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWW6ZwVjH9viOuqI1JsKoP9qp9weeC4noMUW5cyLB0ncUluvTt4IRDajkHThvxZ0xxMoUW86Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzWmwzOYAaDRufnMWoFgJPgSzQeXdII1FI+F4+tbhcWDDY7eGqi
 tX0iie/ygdbt9f/bTaWvzA/U/ZJT2sq6ufSppDBpj5V5WSaAbOYepoDC9zSr1FgRJSO4IVtmegM
 qgYXplkMlXwzZQu6jdzj/oBRvbDjLoGUWraCogwC0lvC4NAB92fPc
X-Gm-Gg: ASbGncu0ySBwAA0d5kAPCqGiPbap8SavBoWLWW52CT1dmPosTrtedK9nLhjzOqRMdMo
 et9zaT/l1cBmqMzyoCkuuy6rarctI7MDn3gDXw/cPtwJwfthbodNHT0Lw2DwLbzxrPH9uo48Txb
 2tfFroU1xGCt105rSzIckP34E8NmeSoWnVmc1pU63azKoneyC2mwl/cpDlpNLZJGnsGoixnyLMm
 fKUnDyaXUq0cgVBRi3bxduVnpHsM+8Ri8GCsB0vfTjn5LCKLiw3lwyfJo3qLHB+1z72VZ/5F06C
 oBYQGjWg9kYbq6GFnEIKEKrucjqufo9RH8VsBNbF1itXekp9wgps8U3BUSOxxf0fNznN4uha5dk
 DR3v20kuRZkRYQc4qXY9PTd17CFHPdRRzjBC+r78g
X-Received: by 2002:a17:903:2446:b0:22e:40d7:3718 with SMTP id
 d9443c01a7336-22e8bfe87ecmr47339665ad.47.1746703207868; 
 Thu, 08 May 2025 04:20:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2jP+A/dVpksfeKvMAIA9CQWfFKIhwHXBytw+CyTvYQd9UszyTcg7kimxepUr6Vb7ril3xRg==
X-Received: by 2002:a17:903:2446:b0:22e:40d7:3718 with SMTP id
 d9443c01a7336-22e8bfe87ecmr47339235ad.47.1746703207495; 
 Thu, 08 May 2025 04:20:07 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e6c3b6513sm27779765ad.220.2025.05.08.04.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 04:20:06 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 1/6] dt-bindings: power: rpmpd: Add QCS8300 Power Domain
 Indexes
Date: Thu,  8 May 2025 16:49:47 +0530
Message-Id: <20250508111952.2304578-2-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Lu2Symdc c=1 sm=1 tr=0 ts=681c9369 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=Lm_5SJ9J54UdPhV11WkA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: ZfFDItDOhOius2pOT0f38dXBBNQqjndM
X-Proofpoint-ORIG-GUID: ZfFDItDOhOius2pOT0f38dXBBNQqjndM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA5NCBTYWx0ZWRfX02LtKb1og+D5
 qI70vMYFtZ5n2/RUxlX4cCcw343gBaytbBr9z9DpYvisG3Yfd/61KhZLk5VHXhxWF3qfQ4qJGJe
 QHcD/72MW+usKbWvB8k3QTSl8uR719U7KRT+NmMZmXc6QP1MF3S3ObpUUydkAWfvzd9wz4uJ+sl
 p00fuENXB7EUqh/BkDQaWqZUlmhCUvvXoAuQDkmUnQ+S5sZRX1MhAOtXpmithHRLPVLOtIhLL2J
 8W8VRdm+45qkVyglFSO9SxCd+j3arnimQx8i+fp7aIpuGhdNK4LImvZ8k7s6i/S+l4z7BszgXsy
 Rq8aTZiO65DbRSiTRMeCO/qNFtG0aRpJdVrcsWKTKyJcsFf9i4IbG82ngMWWiyThKZ35wK4tA5Q
 e6rNUqcqY1O18/fJJZ3I3ZuItFJZOJDCYMQAld7udRrdRjIAPqHGUH/SvvYyZJdXJsYkyRii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_03,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=991
 priorityscore=1501 suspectscore=0 clxscore=1011 adultscore=0 malwarescore=0
 spamscore=0 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080094
X-Mailman-Approved-At: Thu, 08 May 2025 14:49:28 +0200
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

Added QCS8300 Power Domain Indexes in dt-bindings/power/qcom-rpmhpd.h

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 .../include/dt-bindings/power/qcom-rpmpd.h    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/dts/upstream/include/dt-bindings/power/qcom-rpmpd.h b/dts/upstream/include/dt-bindings/power/qcom-rpmpd.h
index df599bf4622..50291f918c2 100644
--- a/dts/upstream/include/dt-bindings/power/qcom-rpmpd.h
+++ b/dts/upstream/include/dt-bindings/power/qcom-rpmpd.h
@@ -4,6 +4,25 @@
 #ifndef _DT_BINDINGS_POWER_QCOM_RPMPD_H
 #define _DT_BINDINGS_POWER_QCOM_RPMPD_H
 
+/* QCS8300 Power Domain Indexes */
+#define QCS8300_CX	0
+#define QCS8300_CX_AO	1
+#define QCS8300_DDR	2
+#define QCS8300_EBI	3
+#define QCS8300_GFX	4
+#define QCS8300_LCX	5
+#define QCS8300_LMX	6
+#define QCS8300_MMCX	7
+#define QCS8300_MMCX_AO	8
+#define QCS8300_MSS	9
+#define QCS8300_MX	10
+#define QCS8300_MX_AO	11
+#define QCS8300_MXC	12
+#define QCS8300_MXC_AO	13
+#define QCS8300_NSP0	14
+#define QCS8300_NSP1	15
+#define QCS8300_XO	16
+
 /* SA8775P Power Domain Indexes */
 #define SA8775P_CX	0
 #define SA8775P_CX_AO	1
-- 
2.34.1

