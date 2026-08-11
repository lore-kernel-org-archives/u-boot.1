Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D821C5AD7B
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 05:19:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7C9940753;
	Tue, 11 Aug 2026 05:19:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XXRNNs8bBGu3; Tue, 11 Aug 2026 05:19:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB2204071F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786425587;
	bh=O7zRHm7V61i27+hnfJ5toEFpJLrtgg7TaPBWcOsYN3A=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=NRjUn5T522vDhFZN0TIvuw7oy6RC9oybJlUW2AROARSAOnHUlpKepwNwXb62up4/E
	 TihW92XZE9hWA0WrsGUnrN2XXncF6VdkhF0MKPEKxWs4wT1qdi+vM/vvQeO9nZI9KU
	 x5+gQ0/JuUMVU9Ub4fp/GcY0MnqnAal8Jdishr09K2EFypfKnGFvHP/0b1S5b31ndT
	 ghcEijUMRspL8AXWFcByR9VNwNnUgIFcVFjA+uWavd5Kqylw+6sYYRLXMnP5oCrYkq
	 OZV6HvG8RftxbRdWTJMmAuS2xE9oJ5hbg0BWSigYfgVGJAAiUc6ETPcTTONesluKF6
	 aTwe5fZVJlraQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB2204071F;
	Tue, 11 Aug 2026 05:19:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ABD8C218
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A935E80F5E
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M4S03VA0b9aO for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 05:19:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A759880F5B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A759880F5B
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A759880F5B
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:45 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMpo3l2687069
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:45 GMT
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjsjgf3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:44 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-848662cd2a1so3014205b3a.2
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786425584; x=1787030384;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O7zRHm7V61i27+hnfJ5toEFpJLrtgg7TaPBWcOsYN3A=;
 b=HZjpXKrktZ69KkdETeKij0P2ZBUJZJ6DtZIqybk74GaX3l34Xsj76qxjS3nyj1g9f0
 NqfLm41PNWCxweepDq/9y/1+kA3BmeX2hnE8zRxsZkEkwNY8lZcX3ACeV0KJaUOZ4yKW
 d+MPuH5ZNkMuQgLNNZyhoYzD5n12LkeVw9W3GFvndcl2ol1V4E4QX84OOsmnQkVWz3sP
 ikbag9Ij7Jv6Sr9Ia4YazPXWn3tOPxGDxYa9e7s1qwdWSBUIFN2pkhyTC0w7VXDEl4a+
 qbNvtf1arv9ztfnPOKXMmwRw6vFhgXES5Qc7UcMhQb+LKaWNXxd6M7yoB6Y6ZdEfvlcp
 5l9Q==
X-Gm-Message-State: AOJu0Yy5RfXvyYenYYWllJGPgw+DDaN+NrVNvWQJkV1IjhYl7MICnBMq
 ++K/G1fSs0Qd2BfBgK2nVhElPGfPx5TTO8c8JgwRLSy6fqDhGoNL3WGsslCT0vjAudvUt9jBB+W
 3WkuIiLnd/u0vj0+0ovqyFe7dWyJOVrukQ9oHjjb29DqjyG2kZLPdSUpp/liW2oEPCoCSTaU=
X-Gm-Gg: AR+sD10Ffc7ezAK/Gz/yWH+NjMr31Lg0j2Bun/1b3jlfRi/r54qcJh0k4gWCJePrf2b
 mVGhFyu8ucEDw2OsH6scSUzV8zCpS7bB/KByjSkth1mA/wh4nzbGpvov2Abi/cAx3VmW760kPSz
 IME3UGT02NH6KTqSO/VdG20uRvPwXMKs28NDSXkyJnv57AL/aobs032pIlpqc6DgqyxySwTpY+u
 eP3NMcDqdEaW6o8g+Dz7S3tciqlSl5i7rePXSjvIGN9Zd7tkhnOfq/h244fVQkMTU9okMSjmmmB
 TrxoNz9c6JAbhyXqhGTGrpHu5PEFuwfuz0q7cHtFY94b2K1Wj0z1+crAvwZeIZ6Niha5coyZ+X5
 ignXYc6wN4yfDWwO2xjyfs5Ib4dEynqTyZbjF96L4vQ+Ikz11qAIdGJbGnu5OKPn+CiVEIRPpKg
 9SFdTr/4NU5FcGVC/qLljuzjX94KES
X-Received: by 2002:a05:6a20:734a:b0:3bf:6237:4d46 with SMTP id
 adf61e73a8af0-3cc2bb95289mr1105265637.28.1786425583909; 
 Mon, 10 Aug 2026 22:19:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:734a:b0:3bf:6237:4d46 with SMTP id
 adf61e73a8af0-3cc2bb95289mr1105214637.28.1786425583420; 
 Mon, 10 Aug 2026 22:19:43 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31c619d01f8sm1353804eec.2.2026.08.10.22.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 22:19:43 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:48:41 +0530
Subject: [PATCH 6/8] configs: qcom: enable PSCI reboot-mode framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-b4-reset-edl-rebootmode-v1-6-2e15adc156a3@oss.qualcomm.com>
References: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
In-Reply-To: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786425541; l=794;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=+Hag8BlykRtXpUBkAf3pFWaOh+kvWi+GwfwSiATwYs8=;
 b=5Rg5T4cieu8hqwQcTWAURkgUM85OVXWW/jFHjqNtv5XJRtKeeHs6Q0oTViWa+5GSDb8JfsPog
 uHURV53tujuAPmVkeWwIj3acujNSMH+QrH7OnPDrHrDdcEm9rkiLSb5
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA0MiBTYWx0ZWRfX6bzJiyC/cxoV
 mGmAWKCFuyg9cSb0SrAONRx8pJhc8ocpMvRp5JPF1G6O6jui2JGoRSVWzUThrTyC4LicZriuRWL
 dGfwBwXvJKtlrDtnB6HP8MxXXyRjhgg=
X-Proofpoint-GUID: V2FkykS0vuHG0Qs5jof1xsA1O0lf8TJU
X-Proofpoint-ORIG-GUID: V2FkykS0vuHG0Qs5jof1xsA1O0lf8TJU
X-Authority-Analysis: v=2.4 cv=cfDiaHDM c=1 sm=1 tr=0 ts=6a7ab0f1 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=uqFMpbG4MC8BjM4yXrYA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA0MiBTYWx0ZWRfX0+l/QtQamPt2
 ObkkXxUb0MsAuR4nbC608brgLO2uvQ/qdz7k52NiEby6eZM9MFdViiLAScCGDGbKD0b8XskqMOk
 dlfXxmQD1m89jrqC//6jUlvwh5YIBGN3ZVq2eHvKcBwUY4Yd/x+4XcBqShAiuZfjCsAwyBcowwm
 EbFsqhCXCOPP+0xseBrz3LeE5JDvKPy4WlPSsy1g4Hp5ZgELAIL2/Q0jFvurEjMZ0okYKIBBc2S
 FS5g8jQkK4ZZsyQjLrJSff4Wu5KCkyy6p67SsUkdDkEhbchMfr7AaeSFcFKDkr8WcfcHtZG5/PJ
 4cuduJbM9QjVn2etoyWBhJFpJu2L1/B1XM968+GgePhS1MpRue7eIibs/0zEMkRje1trgUBV+ZV
 SJwqrHrcodDRnCLeO6oinkOzQIGDFVRr592N+wW5oQxarVXDmq37H/OEyxkEL0OYkqQJo9jVig/
 L9vdDWXFBtnP3zQtyvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110042
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 O7zRHm7V61i27+hnfJ5toEFpJLrtgg7TaPBWcOsYN3A=; b=ZUq5JqeG/XCrsoqC
 lb2pgoAglr7vzvGEhRrKq2VQxIeaWZB7mPLQZ+Rne54I7ehKzQ9eUClN67Y4hJv1
 j2xXOQ/kAXvAdtXt5OZJSsf3nxqVqAbZJ3+FrHRAAXNWVgSBnXH2Whp9i5Qr4Ug5
 d8PfA6aOkbNeX+RQRSwu6TfZHXX04Yb3fgmXeY8n8E8IS/lRa1LLKgTUg1RnWDA0
 2z9jjychB5NGY+aACWHnYYDVKOw5RFiq/fnAxsav1syM5F/8rH4r+v9//oLoYpTZ
 hd/nf3kFdEGc9Te4zZbU/MuKdC4q0Fh1X07t7mHvUZzr8BS3YrkQ2ii5Z6m0VSxp
 XRwNCw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786425584; x=1787030384;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O7zRHm7V61i27+hnfJ5toEFpJLrtgg7TaPBWcOsYN3A=;
 b=ey8CLAgJJ5xNzPgjqJ7n7ARJXKaT5OYibbe/7RozwTbovHBWg3Fq+ly+GcLrfmIksL
 3zm/ZsP8gsygo2bHnedV92amHj1ZcmNwkFfrRBzXv3iYCjo8fm7A9FVxt59xRpLsBbgl
 +Si3ESIDn6okNymgtAWflgWi6nOVI39fGW07O/KFZDESYY2onrulu5nI28rGpvci8Ng1
 XCOneBeHHFCedgXJMSMfld1ZBiHLDiwl+yR20tBGd0OPMs4mVpPFpJk+/2zu5/SIdYgC
 K30C8WzTe2AhcZuQElxQN7LjeGXA8WS/au4kgOZUuZwCTAvxKaFJlzbOBZHY0oCBlGwN
 tkVQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ZUq5JqeG; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ey8CLAgJ
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable CONFIG_DM_REBOOT_MODE and CONFIG_REBOOT_MODE_PSCI in the shared
qcom_defconfig so the "reset -<mode>" command can trigger the reset modes
declared under the psci "reboot-mode" device tree subnode (for example
"reset -edl").

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index c52f619850d..8703472d13e 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -124,6 +124,8 @@ CONFIG_PMIC_QCOM=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_QCOM_RPMH=y
+CONFIG_DM_REBOOT_MODE=y
+CONFIG_REBOOT_MODE_PSCI=y
 CONFIG_DM_RNG=y
 CONFIG_RNG_MSM=y
 CONFIG_SCSI=y

-- 
2.34.1

