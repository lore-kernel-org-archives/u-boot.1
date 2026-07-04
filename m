Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F795C43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 05:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9223841F2;
	Sat,  4 Jul 2026 07:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SuApiR/H";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H/mmL7lo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95D85846A4; Sat,  4 Jul 2026 07:35:13 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64FA1841F2
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 07:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6644lthI1911039
 for <u-boot@lists.denx.de>; Sat, 4 Jul 2026 05:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ybt1l0S6vOH
 zY3IuyYFrmBYdfgRVE0jwtpF4GlhzkrQ=; b=SuApiR/H7nTh70FTKIPuw8j15kG
 OGDDUhsEAgqaExp9R5bu3jL1kLiBQ/I+GiMEJtvaIa+94KCyhev6qRCzT63SZTn8
 ozIf7sQcYwuHnk3OAl/XsOBOazU1jrkM/uScDkqhmsMIc81X6cNFW0bQd6craMu+
 GjItnMSx9LHnvtFbd6w2y3S8kast9178+63SMryp/DZ8wJKJ9O5pHhk74XoLUIE/
 nJCC6Xd2d852OuU6erTCCueXjMjmn64rjm1fvg5xG6JiX26uDJtsmkIbeC9QiTyH
 01+v07lfr6e+qiJY+Tf6uq+MNnykmlKqHf3ZRri56Y8kzGVuXz9jd7rkI9g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6uf802dw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 05:35:09 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c9d5a5b63c5so1816787a12.1
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 22:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783143309; x=1783748109; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ybt1l0S6vOHzY3IuyYFrmBYdfgRVE0jwtpF4GlhzkrQ=;
 b=H/mmL7logxtD9YiFqdMIsP+hE0jsElwVzZVlYj1US83qDt6WZgiaXu5OVMiSwtj+Uq
 Z4KvoENOZvCwss45SnIqBGvvCwgljBTvjsCfma9N3j2ZZE+T1O2jKG/SA4oSynxXGZSQ
 lKHKqq9+NO9nygAvjrjjSlwK8rKH15jp/e7F5xK1jRpQwBuYfhQCKo5k+H46pq/jqu6v
 E6HYoRKh13VvLOEe8VhIT0kJBc2oOBOZVDkZk9E2hAx3tKz+b4BDfltl14k3oo6McuUU
 QlsASZRZlx/+O/hRUNhq5zHsdKslnTN1KNQIrMu9dJmiX168iLuRTlyPsyvBKKcvHgQr
 EOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783143309; x=1783748109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ybt1l0S6vOHzY3IuyYFrmBYdfgRVE0jwtpF4GlhzkrQ=;
 b=pN4aUa/UyS3+OutVZx+VNfDos+Z0xls/S0P6Mg1hoZj7ELXeOKr7I/9T7ThAL7NqYt
 /TWNgWYtJpHs/svc2XI9+bEAm8dRiHOQegoKgAeetHInbO6TzgIRfdhHXmYkZwpHgUet
 NHMHOh3kiM/asmn6XmRcKQCtSjSYYXDfsMtoIpYp12J0QjYOYWZHU2Ze8pNwIoveeKxD
 0j7MYLSU0bmCG9DcOa7jiL/wPER+6JnEf28dz0Eol3We0wxCfHuIJxtbvr1JISySJHjR
 ydtX/V4mLRdwH6JeGblYE0CvkQHs8aBx1jC1PMqzBRsgQZfPkfTRXPHt5SL0IRTGa/Fy
 dI4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrvShPjiLBZbotIDeXqsQKbUN+9qe/EcUNVTkTNGI540CxRaP5KMqRR3z7OBUDFsXtO0xdTq3M=@lists.denx.de
X-Gm-Message-State: AOJu0YyL0aYm383ZcIPKxwOzKaSMK/9xwHw8lfqGXwM/fuBbBETQMyGb
 K2ELtyLSR+4g5MHXoPocwaQE+cLX1Giy/+KAm5tEESZr1pTCVuEb4vBMmyIiKJENrlBsC9UueOE
 olqi7fM1DoxRggu1deeUtF3kw1ypJQw4NN+5DRtJb0m2ieAcmT8CYdUYS
X-Gm-Gg: AfdE7ckGtkzES5g/ly4GBDXOUjtxEXtmBK9XWraXp35cMLcfATq0o6+OHJZXX3XDLvG
 3hv0jzfydmuzV0WXPsRcBOFmYh8cIt/PDLhjl9TA5osJwhKKiHZcnABimrf7rDu00rmjYQAmsSY
 b1SWmRlHLQ46KaG++mSFo3q5wZHrkzQhBiwyN1vqzdsNCpr2X5AoSJCV47jEz0sJR8liCLpQq2s
 XGPgrtLOgy3CtQagZgDxABV/sL4SuZikvcf7N+3G8NlVF5F6dtjaQNH7Knwq73LvQ4LzrCnQbf+
 ZGWwO9M2mFiMmjZlz8w3UaSHtQUqhEwnR9TUI4jfBa/g7Zx4aiNbZq4gC3hCgkQ24dmxcz8z1Fn
 lLzg/za5Rw/Ncp3SybWFbQPt3z65D2WdMKzAis3X3SK1Q2PDBeG27Fie28IeOQ8tcvd2DXiVLCS
 bCVUp/NUfIAIFiy1JDxthCwiRB786eSg==
X-Received: by 2002:a17:90a:d408:b0:381:bc4c:da5b with SMTP id
 98e67ed59e1d1-3829e55cb5emr2107825a91.18.1783143308798; 
 Fri, 03 Jul 2026 22:35:08 -0700 (PDT)
X-Received: by 2002:a17:90a:d408:b0:381:bc4c:da5b with SMTP id
 98e67ed59e1d1-3829e55cb5emr2107807a91.18.1783143308366; 
 Fri, 03 Jul 2026 22:35:08 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bbd221bsm28362250eec.22.2026.07.03.22.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 22:35:07 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 luca.weiss@fairphone.com, andrew.goodbody@linaro.org,
 swboyd@chromium.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 1/2] configs: qcom_defconfig: Enable CONFIG_SKIP_EARLY_DM
Date: Sat,  4 Jul 2026 11:04:51 +0530
Message-Id: <20260704053452.761684-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260704053452.761684-1-aswin.murugan@oss.qualcomm.com>
References: <20260704053452.761684-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SqwP4Q8oA7JRmRsDUW7vSULMn9hkZKKJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDA1MCBTYWx0ZWRfX2EZvmpm5wNec
 vmaHW7huXqOEznmO0uHB3T3o2bsnj6pAWQivD+WhMS+/Au9YMawSzhR7JeNNM736LvbCG/BWUk6
 +pFL++DqElrjaYTEqkfd5eCtcuh9Mu0=
X-Authority-Analysis: v=2.4 cv=Z4Tc2nRA c=1 sm=1 tr=0 ts=6a489b8d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=0qtIWHj19sAmir4OP2QA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: SqwP4Q8oA7JRmRsDUW7vSULMn9hkZKKJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDA1MCBTYWx0ZWRfX1owOCfyTsnFP
 clZnpXyVrjJ3ucaIJV3LD5/A4J3uoQyId8AOuqpKATGtqmuIXfvd/+rt1sJFDWi8iHiy/6rEqIn
 rYOxZfn+9/UjVMmVAxzrUzUDG7t2brhnKf2eyfzbTtDQuCwPDo0LkSXLMAWno/IhXj20f545WXT
 ju55h1sdES0idfeRfVyZsuT6g8suCyqcqOgOn9bravKYiP3auKbPYjztm5zEWWpmFWbBE5pSjKn
 8qGZgrPg8eg17IJOEjBpD6Dr9aEBXeTOdnWeavj68mpN9W7i9eMH+6qNAQYWT28HD2GHoneJQXy
 TdGw9SzJOFaMfBrbM3THp1K8jx7tvZZ5EJkcNkgpx2U/dGyf2DAsQzzIxj5eRcOWaXOc2OdIvmg
 sbxcCKDD73xMZa+vuIxsDOR8+FbqV0P+goMJ+l2qaN7zY1tivzzKMJqjMW/ULHY9JBv5m1XwXSX
 0eNoL5cPHRPp+PeopMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040050
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

Enable CONFIG_SKIP_EARLY_DM to skip device model initialization during
pre-relocation phase, improving boot time by around 50% by deferring
device probing until after relocation.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index d0d54ec5a70..bf195610898 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SKIP_EARLY_DM=y
 CONFIG_POSITION_INDEPENDENT=y
 CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
 CONFIG_ARCH_SNAPDRAGON=y
-- 
2.34.1

