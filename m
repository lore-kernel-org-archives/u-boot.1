Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E053CD3425
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 16:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 571D883CEE;
	Wed, 12 Nov 2025 17:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="B5fM3DLT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NVWodXqD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6759800B6; Wed, 12 Nov 2025 17:48:43 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 339E783CF3
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 17:48:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AC9ggxE1109096
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 16:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Mv0huwsmdu9
 ayY2Sp6m+Mw+NY93V1s2TBq3cnPTwhDk=; b=B5fM3DLT5AIo/WC5NrhDNCr9u28
 debioyUB5Ukwp8kCKGPhq7xbgYop7MyJdwJ/J3h5G9/EGeSYv6zOLmRNaYzXOqnV
 QWA6eaN2XQ/1gSndtBaSAu+7titFDHi9idYB4jtvAwFRelKJEBvg0tbw+kT4kASo
 xaoDn6z4aj4A9/WfaKAXSW850KVuGIdefO+rtmxidetFYRyTPqxZaihPsx/VmXpp
 z+DA20UMLW9p2PRMuvqSwALPc95AWD4uRu5OORq2boGGJFTfhOJyYqPS2x6buF+X
 YWMhnfJ9Z3vpOpLWb5iQ4wNOKAB4dTuhNlTmHpQxyW19hKCVp8+L7XUFzaQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqum18gk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 16:48:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34374bfbcccso1074907a91.0
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 08:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1762966119; x=1763570919; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mv0huwsmdu9ayY2Sp6m+Mw+NY93V1s2TBq3cnPTwhDk=;
 b=NVWodXqDssUfCFxvRO1pGXjbNAxpUbfZofqPc9eQcXZEXXOmIhgAmB1Zu54/UHcl0+
 Mfr0/owqBgef9YKNo4i2npMsKgJwMnlZXT7Dipz5KwW0O5+7Q0thtDZJu3HdJxKDlMGs
 nG9H5GAaWtQnjQEtMaA+kZumWL6a/RjcYu3HiICYdBtb2NPnpEhW+tmWdKcCjfpfzsUx
 2EGbsm/4TrDYgO8int4Y7oxDoBlyfEmgoRA7UxI66Sz2n5Dq0PI0jRbMGKlGh07LSVBN
 ImSCKXC3DZhCn4aGD6E3X7l80JQOJPBLSTX4tkvaKh8Qivdhnxbnuvy6kzHiRitWAUq3
 awIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762966119; x=1763570919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Mv0huwsmdu9ayY2Sp6m+Mw+NY93V1s2TBq3cnPTwhDk=;
 b=CqT++zyP4/v/yV5Png3qw5hWxvdhU2Pp05xF+3rmDUO+j0GWIvZ90O6Tto4dbZhGU/
 ga6sLvvuAPazH/2dI49Ks9ZbD+BAauwZWZGetytGFzGraqcFbvLQHvJ4Ysz20oDCCKGX
 4sa+7HsfZ0RsLuLN9e0pg9LMJDaBWKbP+ght+48mi2ra7WwfOLV7m70O8ceRU6SxZfMV
 i2prku4TS2dRr/nPvWufiKrP5t5v77E7hcAwrXWb6qShSoWWCSv1Paqu7DmW+u0hY3TK
 pN0JPAEn04Sis7ST1LgZaz2Mja5m/AKGu+Z+MUpXusW5eo55pAxQicj4vI7EYI0n+UM1
 74FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+VYaJxg12UAfK4O+R284Iv53DFD575I4Dh5uyCJj+GngtEm6T/Z2uMkH6AaRJP1tLovtSCjo=@lists.denx.de
X-Gm-Message-State: AOJu0YxkoNdBSMAGbiQZmUzlnYCMupOrrCED58NRKueCxL+sFUWr5SEB
 rA9/UsbA/etuDLsDVOfRueFmkKYn+RO+30lk72iZqvFldUu36gHVflOtcbiaNCQMtIialdnkXBS
 x0mroXYnvTBqF8HCwoGbEjh3fGNmwD17um6yqbMz7uIMg5WN0I/cyUvCZ
X-Gm-Gg: ASbGncs/6iZspHNgLkW9gvVJoV1doq4aWkgNZEssio5kOy2M0LMgy5Q+LqBnWX4K3Z0
 h9lmlxyVvOqbXr4fh1Vvl3/FGyCAnb8FyxVhwDgwCSTvv0IvdjHhncDlK6GyIH2NyqZHchiboEt
 LNys4LA68K+ZzF2AWwhE6KAA4rPhl0f9TY2u994zT44bprtjWLn2ElHjxIxEC1D+sTrhy8mTZMN
 Amt6VxWMJd7J4ehBT+kPfP9vVczSKuunNM4CU0gqQ43UkX8ar3cMYcOP625511kOCgGvi/ZarDh
 m+g++O1963Ow7qsXfCDvvWUtM7HzaRooQvAMS6CQ3SbKkAvK7BBf242mlGfa3nrkY+tiA87v2/Z
 RwcuWcfC3CwZ04/dWY+fvxRX0jpyGJ38CQcg3Nc3mmIE8ArOGlSqqcbv71VK9pWSLQZeBSyj5Ib
 6BJh8AtMSC8rU83ewnIg==
X-Received: by 2002:a17:90b:1e02:b0:340:2f48:b51a with SMTP id
 98e67ed59e1d1-343dde13720mr4019037a91.15.1762966118184; 
 Wed, 12 Nov 2025 08:48:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoLM/gt8rTHv+qK1DJCfZd8QuRhz1ESriF6Oo9W4z/Oj6tnVtye573gtUQkdbixsX+Vg4tpQ==
X-Received: by 2002:a17:90b:1e02:b0:340:2f48:b51a with SMTP id
 98e67ed59e1d1-343dde13720mr4018892a91.15.1762966115246; 
 Wed, 12 Nov 2025 08:48:35 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343e07b6dacsm3175770a91.14.2025.11.12.08.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 08:48:34 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 sajattack@postmarketos.org, quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 david.wronek@mainlining.org, adrian@mainlining.org,
 luca.weiss@fairphone.com, alexeymin@minlexx.ru, danila@jiaxyga.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 2/2] qcom_defconfig: enable pinctrl for QCS615
Date: Wed, 12 Nov 2025 22:17:58 +0530
Message-Id: <20251112164758.1560041-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112164758.1560041-1-aswin.murugan@oss.qualcomm.com>
References: <20251112164758.1560041-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEzNSBTYWx0ZWRfXyb1GXaan1H9J
 iGrEpX53WmtJbu10RghZS1m36pOgtOC0hm+gsJTguTCh1hblfEGQg+UjLhNfKy31Bq66X4uOAYf
 jGQhXjHsMDcA70CsnpsnxNup+jpoeSl7fINUF65IEiwXSK65IbaeUAjL94bcZWSWcQJ4R7qzzAp
 UD04hbCQvZGCRlZosrSQieR8Mwp9zFVn1y5oePOF80OHDaU3tUY+HscLnxfWWAJyBxNaJ3gAxfP
 Klpb1ry4PYUni/k79KCfTPpOx0CXuxkRak0OeuNYQnTmHgTtmnSGxXxPff6nyBcMWlsCFNnb4AK
 jeZwhsN7mWz/rheiUlerWOJsYjoMr/na6blos9792azS3vPcpuitn9RMaJp7/KsP4Mvcph2ajFM
 YxiGGNKfSZYyxZb07VSjPh2IECTLNA==
X-Proofpoint-GUID: 3TVS-loBMtBPTZyoOLg5_wWttiuS3o1m
X-Proofpoint-ORIG-GUID: 3TVS-loBMtBPTZyoOLg5_wWttiuS3o1m
X-Authority-Analysis: v=2.4 cv=KeTfcAYD c=1 sm=1 tr=0 ts=6914ba67 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=REMdOS92SEPfy5-joZ4A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120135
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

Enable the pinctrl driver for QCS615

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index e686ea857b9..919897b8d40 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -114,6 +114,7 @@ CONFIG_PINCTRL_QCOM_APQ8016=y
 CONFIG_PINCTRL_QCOM_APQ8096=y
 CONFIG_PINCTRL_QCOM_QCM2290=y
 CONFIG_PINCTRL_QCOM_QCS404=y
+CONFIG_PINCTRL_QCOM_QCS615=y
 CONFIG_PINCTRL_QCOM_SA8775P=y
 CONFIG_PINCTRL_QCOM_SC7280=y
 CONFIG_PINCTRL_QCOM_SDM670=y
-- 
2.34.1

