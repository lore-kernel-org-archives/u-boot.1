Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D02DC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 06:53:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E37EE607FF;
	Tue, 21 Jul 2026 06:53:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UX2YzPJtXc3l; Tue, 21 Jul 2026 06:53:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CFFC86076D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784616788;
	bh=wNm5ZSv/jwpBImhuywdBTQwhpOXOeNbTzo5+DW6nRyk=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=OZt68S9Q9R/hIuwVselkimGV89kdRTAECFgthgeddys6S0PXrxaHQzbgoAx9Zg+Tg
	 Swpj00p5fKLPPKQg04uuFC6X/19WoMaHIk6f75Np/V4n8kxZG8mJlSeyBucDQiPnJS
	 QO/r4y9opfLJbSokeiQnzuMWLseG8bkjriWGdtALrzD3MYfwvyw5pOW1zrQpk8pmi2
	 rrK3a56A913fvsetZQBh9O6qtxPgrB2BkU/P+kK5KVAXKVauYmZlwdRhJVqaijxMK3
	 PzZhj4I4KrZLJP7Zgwgx8h85amA7ZnKEpRgSHeLkhw2YAxcrCRj5m00fp2y/Pu10LP
	 UENdMTINsr2mA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFFC86076D;
	Tue, 21 Jul 2026 06:53:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B04BE1099
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A19C24029F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:53:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n4w8aGSbodJE for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 06:53:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A9167400C2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A9167400C2
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A9167400C2
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:53:06 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L2T5uD092220
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:53:06 GMT
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj01a8ydf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:53:05 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca7c1e22995so16726392a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 23:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784616785; x=1785221585;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wNm5ZSv/jwpBImhuywdBTQwhpOXOeNbTzo5+DW6nRyk=;
 b=ibh9MSAfQdd47Er88O+I4k699SJA0V9ZGPuzZZEQJcgXpvgkQfjLdFpmEHusVGse1o
 OP3foup+xsdZY4v2rIc8v6itTxouVMlVdLj5IFvGeUQusK4RyiAcTldY7RsCoxT9YboN
 y8++x9uA9deeHcVzDnrG2HpOGGE5yu9tAPa4vBKABOSI4Hm6p/pmFWuExRUC95SHvSP4
 GJ77SJcTYUXhnzDMaj4nXGGwwDJiSQHUj8FP2TLLKRgsBZ0yERbdp1XfuiNnITpyR9OZ
 6hggamwaFs7qMNZzVkDtgynL/Y1A8ToQWXu/ipEqMnnnTM4Ano1+JXt4QzVlyaJOGZ4J
 Un2w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpA95mHOrjSGKYr6lxjllRsQEztfrEi+IIUdaELLjXQq48SlT1UKkscWbFvxhTZ4xadBsQUHQI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw8gtmu6lXeF2iKubee48c9Z4H0sO/Dv9pfeFTG5NKnX6eBYldm
 cTNg2RCa+Ah0qyT9jhfD3Mx5ER/Glo5OM7ruNRh3cKH5smkfEZlfwyr/Op5T9oDTZvUpTRyuDcG
 xKksBok1QJC2YxVAJFLemBRIviWqAmiZlu2QH8IEegeU8uwGtccBeDmYRU781WXE0jfwFBGg=
X-Gm-Gg: AfdE7cm2yxIDp8JehcoP0sjbvD/GcsbWqFkfyabr2T5za64HqVsrWWHNIrGSIpjZXi3
 C8853Gpej08jL1euyEVYUOCPBgULnxyWNmNGvhbqBcN67MTLpufb90GcCvtHXWw2dCVR539y2wr
 EnWDrQJE2Y76NBKgbx8rmK72jGpazL3N84NhaLSXEIE2ICfHKgv3iddfi1UnvLF2VI5jcIEuV3C
 Xp93wCmtyoFANPqr2QYBLK0yPGIWhZpt2tonH7WFtI6jKfkAJBURPG2fvrPfNvVx3mMkIBaSZn5
 uX352xcS2f8T0UDoywK2Yjtjo6HXxaCCAwaNmiEgzW3u62SIrgVPyAxfDTdGDEKvlldfIbTuLIt
 Sc5WyyfTZOQGUXFX9YcY6vFGZ86ZxxMlst+DjfSUa1IBzyNNg/M6nTN5ZZPUSQFb71Y5+iuNuoM
 yKB9CEs8Xpg/iAQEibAwZSEM8n1GUJ
X-Received: by 2002:a05:6300:218d:b0:3c0:9c19:65b3 with SMTP id
 adf61e73a8af0-3c3ada61e6cmr20792277637.75.1784616785216; 
 Mon, 20 Jul 2026 23:53:05 -0700 (PDT)
X-Received: by 2002:a05:6300:218d:b0:3c0:9c19:65b3 with SMTP id
 adf61e73a8af0-3c3ada61e6cmr20792241637.75.1784616784771; 
 Mon, 20 Jul 2026 23:53:04 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dde81sm73931642eec.21.2026.07.20.23.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 23:53:04 -0700 (PDT)
Date: Tue, 21 Jul 2026 12:22:44 +0530
Subject: [PATCH v3 3/3] configs: qcom_defconfig: Limit MMC transfer size to
 prevent controller timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-emmc-v3-3-35cebc036994@oss.qualcomm.com>
References: <20260721-emmc-v3-0-35cebc036994@oss.qualcomm.com>
In-Reply-To: <20260721-emmc-v3-0-35cebc036994@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784616764; l=845;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Ae59jbhrLAfg7buGYz715Y7ZuX33rSge9eZ6/qZ+IsQ=;
 b=G2Xpbyy7cNo2QmJcROSSE1CG+eOEY0d/QPoeolV82f1nVLjSVraVvx5XpKoxp5WV2ZxQnfJBB
 uSRE/CEzaPQC6KOOe9S+Z2+sR61ygcrA8CXMGPRlB4BDTxQBMTRWdTF
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=BL6DalQG c=1 sm=1 tr=0 ts=6a5f1751 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=1OQmJc6SjKDH_2_2jscA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA3MCBTYWx0ZWRfX5XW6l5F9e9R+
 X8j6krvUUYR6v7oCufBtyFkjOYzkO5ysOl9FUs6EK4kOPsN6zCUL8sD8kREuo4YmDM7rkRUkMvU
 8VUFxTeFgIphqX3IezH+eZIatxmfiWz9qvGa1AvI4s2ycPijS/NV6cJE1hRA+MGV6dumEmez5Ev
 VWqah9aoAjBl9VUQtFw9USh+FalmglB7UShIS/kSCBfWF+wq0fjtgAu2YWErfP4rRir+XDZhRFk
 A0jRW/xQAAOYXCOBWVUgFPg8T7vXIqnWWDwgh80O5J0XOKh07+/roWLbgm8y3nOadYNSnatYu4h
 KUv4N1bExEWdoucvkyT+wQaPxy5/RF3ys8Ij3Ily1BI9ZHs4g5cjuXJY00C71EWtskUQTjsaH1R
 ODpP9v+CdSw0hvjQO/A/ndGXqDpCh+9QR3Ce8u5rCfDXkcgXizsNj5Xu6y7tdKK5+RotqgIYmic
 TbJxg32RXxyEoX/Dk5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA3MCBTYWx0ZWRfX+WmMzD4P0BwU
 IoWuIzMYed25UJOnZ+1mxid+tGlJcAR0EhMKfHiv8CjLX0IguB6YTLCzIcJHR1WvTbx6v4e5tbY
 fuEAYvyEQ3Pf0j4w7uehSYa5sPTd+Us=
X-Proofpoint-ORIG-GUID: r4pYkx_C64Xy3qdNMerXoNpwadvEbIVa
X-Proofpoint-GUID: r4pYkx_C64Xy3qdNMerXoNpwadvEbIVa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wNm5ZSv/jwpBImhuywdBTQwhpOXOeNbTzo5+DW6nRyk=; b=SEnq5kfksNn48Jeg
 KbVTkYwi4RnxCKgE/Z5mGwCGVCWpF23eJFAzmVSKEWJz0xjtOK4W3Q9IFi9HDgOp
 VJO/uG3BQaitIqQ0lyiEWDtoiY9G+OOyOOyBUTXvR7ktP0dl6l+Q6vTLyqVZj9CB
 R4pp26Jwpbmb0yTSE0P+JVnAP9qZzrkSGQZjeCAKSFo49tqmNPJipxHfoP14zdlj
 WaVYJ7JHQZvbRRtwprP0gE/gTnl5wGjVO9/lkpcAWlDIM7qGF523zv0+zX4G5OKH
 y5YYshm4vb3LLA71/oDLuSmCYx8qj2WP3fHIkCeRZg65It0LOCijAvtU2676ntPF
 BSldnw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784616785; x=1785221585;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wNm5ZSv/jwpBImhuywdBTQwhpOXOeNbTzo5+DW6nRyk=;
 b=aZDBvB81ZWglOdQqogkTROWQSD5EmD25t/OI+M6TLhzNnwTqv09jomnbbWcEaZ/r8a
 rkhyiLb+AP+Ch3X0SrgxHU6RmtrpJpb5ky07sdcNh3NIrcm4xywbE4awmvCw7pAX5Vco
 oaYrs7rdyVAS4Geq4tlujqogbGxWfBfR9u44Jql9br2O2v+stK+Lz8OLRy7mdlWLPqzi
 lP0GZ7HRMulQkkbsYfs+fMVCkCwM4O/y7n7A/NoZK59L55Vwt0Of5tOoOuXL5/i+UvDl
 Rxg2xS0Qz8QgSWsbnknLtnCH7R+xyC/KnmoNNhtOwsiOkN880w2RUKHQq26jJiu7glCf
 q9Jw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=SEnq5kfk; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aZDBvB81
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

Set CONFIG_SYS_MMC_MAX_BLK_COUNT to 16384 blocks to limit the
maximum transfer size per operation. This prevents controller timeouts.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- No changes in v3

Changes in v2:
- Set CONFIG_SYS_MMC_MAX_BLK_COUNT to deal with controller timeout.
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index c52f619850d..14ff0164ff4 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -100,6 +100,7 @@ CONFIG_MISC=y
 CONFIG_NVMEM=y
 CONFIG_QCOM_GENI=y
 CONFIG_I2C_EEPROM=y
+CONFIG_SYS_MMC_MAX_BLK_COUNT=16384
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_MSM=y

-- 
2.34.1

