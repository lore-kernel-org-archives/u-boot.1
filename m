Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A76BC98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EF308132D;
	Fri, 25 Sep 2026 14:27:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id phvc8-Bfwlwh; Fri, 25 Sep 2026 14:27:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 546A781349
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790346420;
	b=ElPcijme4Oiao9Na+FWTn+24CYTxnqYHcRp9qVu1TPbO/uqS16JzahMcEHGSPVwFkfY3
	 50vuINdy9QrktaEs2sgG7/nMG8CSvvV4DKGVQFsyP47a5l2r+DIaly9EnomXgPanzRLKD
	 2QY/kW1b7qJIfXbgZoKQyx0QOclhB9Yobuchq2GsaRMfe6yeDZN6uCZ4ypoV0z6REf7l6
	 eql0snGlRObLBZpUGybkICnv5VTgvuJkXv/1wgQ3RseunmqJoYQ2Qo8cpJ3jnEaabzUV6
	 2W014N2kv3fy08jUBBVuepi7p0MXMsVoiDgBOd2my53EBP411lI+Eh3GHmsMn+a676A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790346420;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:Received:Received:From:To:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PSIyz9t4sMMAIzObVHG2qERuKLf+r8qKTErEn87fazU=;
	b=cPmpU6kMgsI5akY5NAqHq0eYfmQiOM8qS0mcuwak6rkZa4LSIsfEnl4dtWwwdKlqHDFC
	 JykXxSbCAx8gs9Qd4f6orig52DMs21Ct9BYolRI4yalT69SeAHaXLpgbLQk+hHee9igMq
	 lX8CaYDd5ih2qFcZbg6tiIv2XgjJ87N2mffXOSIsmlO+im/Yb9znR9933eS5sJYKb8ybr
	 HCKmwB4JO8CuMpM0n5I9enVX4IBj15ee+G7BrLBNZhFcmR7AZsc9iWpdRCRLilvVR7r6m
	 Hrq3I4dfJSAsYDiqhlU4rRa+oDaaEz2yk8HzCWm0ZdpSG8qSkT95OtPpImMVwUpp5PA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790346420;
	bh=PSIyz9t4sMMAIzObVHG2qERuKLf+r8qKTErEn87fazU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p3rF76cueV6j2LsVZlAYhcBobr5ciEcvi1xrKJsY9Ze/RLul+xOZAspJoXbBLGfiA
	 3FPKbWkcTKq6rEnqMME003AxZrjY2llDP7DWXFJDYoNdduWaLgQCwHzbkP11IoS2jC
	 cbssTJD4ti6JYkLk6nfPKa/mEGjMK/ugmLHh3CRAYJhY+YZS6PjkdcfVvxl1b1ahg/
	 kh+L0PpNTV81caGXE8ft7m+qwXqKY5wUJ2XThxM6M7HTqldTLzUaSTrodM5T9ev3Fp
	 a4bYCS/LfACpsVrSHsucEozfLbbcRY1NpJidxnmIVh95KSEOqCjoC6Ri8CZnGvy7Hk
	 pluWtOUDa3J/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 546A781349;
	Fri, 25 Sep 2026 14:27:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 24CECA33
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1679140AE5
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C9cYXyZDT--4 for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 12:58:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0052E40AE9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790341105;
 b=mc7lKPhm42ZqTU6ima3H3rByg/MFCMwPbv3fsDgX0sZJ60tUr38nbx467hLFHV1eTTZ+
 R+5jDzgyHVMH3vLfImAqDrm6XlvNl7KNHdvztq+b74XCkfYYhhVLu+kl4UGtnUi8yYTcq
 Qu+5h8nRbsMgIbmzTqXWhR6QZQDL74zrLs4zPAKxO1ZMJNYJ2ycMuXgIBTOejnWDMHANF
 im0u69BOVYWuKAOWFYmRI1ay6nW2Iv6m4eBcNePV7drKhAvCGAE4y4AIpaP5GXH/6vCw4
 SAzBBTiOwWkJNbE0/7cSyUfnUBYDtw1KIn/7KjDgtoF1AJNdhqm3phrS3CP2/DHaSPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790341105;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:Received:
 Received:From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:
 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=PSIyz9t4sMMAIzObVHG2qERuKLf+r8qKTErEn87fazU=;
 b=a0+OaKL9Ords8+ebcvBV/tAPQFc+xyFzP5HXqbZTcpO0uBNrc9zNet5u48JvSc9zOHor
 2rvNsFlrhzVCiheo9O7use+oElBFudX/xMi7tv4rHSVx8OWdi5ImOS4yI1Ou2yrJQ0cSu
 WC0f+eGT7PhdJxJrHxt8I9TWOcMkIp8B9B352GfiqZ3ybw+bB7efbwC0DG/g1bsAKdrpm
 QRm/jMFp/ksZO3iWCYJID6QvfcEhMzXSjNphB6gZi43BhbHbNzdllB4jjtxpBoCErIHUh
 XBVSES2PbV0QrarWinbPfaoJOtConKG0enEQ0LaYKA+br/fsJ3C7hngjV7Yl3qzBjAg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=qti.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=MVqqp0de; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhiv@qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=qti.qualcomm.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=MVqqp0de
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0052E40AE9
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 12:58:24 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4YbSR1193851; Fri, 25 Sep 2026 12:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PSIyz9t4sMM
 AIzObVHG2qERuKLf+r8qKTErEn87fazU=; b=MVqqp0deRqksfSaG9Kw+3rbMrqv
 CybGRCQCdGHgpDiiVO/WS525PA0yOXXufY7kt5leSHcTFrA7WjBig35hbQKsFQyE
 sC5t4CgwmocrJghIxkGhJiFSAp9ZtL65j/hOVG/sF2YUqgcoz9OfQan9xRK2T9+d
 OHP1C7w2www3HkCyrpeDv+NMQQAymilHCIE+US0gulO9Cnew08R9r0MB6XmH/3ub
 nn/q+EQfQlrnQZi3xGSeey7MZ+dtWQ8YCzJybynR1m5DImuICvy1HPqoKafeFdFO
 MRgBqyAu9ru4gsifUU2z6DzzjagxhRtHEQd+pIiCESYwGCd2JRmkslrIQIQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw874kfax-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:14 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PCwDEp518184; Fri, 25 Sep 2026 12:58:13 GMT
Received: from hu-devc-lv-u22-a.qualcomm.com (hu-abhiv-lv.qualcomm.com
 [10.81.94.242])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 68PCwDcl518170
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:58:13 +0000 (GMT)
Received: by hu-devc-lv-u22-a.qualcomm.com (Postfix, from userid 4779521)
 id 91977617; Fri, 25 Sep 2026 05:58:13 -0700 (PDT)
From: abhiv <abhiv@qti.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com, abhilash.v@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 02/12] pinctrl: qcom: add Shikra SPL pinctrl option
Date: Fri, 25 Sep 2026 05:57:59 -0700
Message-Id: <20260925125809.1360030-3-abhiv@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
References: <20260925125809.1360030-1-abhiv@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: UUqCnx5zuVd6sjJ9_OxNVGX0hf9KcbN5
X-Authority-Analysis: v=2.4 cv=MI71C8Zl c=1 sm=1 tr=0 ts=6ab66fe6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=w3U0zNvCpQhp3vIinEQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfXyVWI9ekNt8Uk
 lQcyLm6iGmHAsLrxLM3JNIv094lEIIScGF1RfIuMdi/Ef0/O6fG+oMnKAtT/yvxJ30ACZ4qd20T
 4/aKU+IpRSUrqeIxNeI2zXJ4rN3mm27nkCEmRzEb3JpzWGRXgn9eheHQfndcoOYSii35bynSvmR
 fYwgzf0FbN1BK6nSTml9/vPpQYTcBr2wT0o+SImoVO0BpEbuOFf/J+z+A+ieYfUfImuBmlvEzHk
 t9u8d8jMm2R4RzCciZZVAQ0eYzJpcIkyMmVLVURNogHp/AiHa6hmEZpxGs4qwdh4fHqF/WFZEFN
 3RAUgGbAs30XRVjjMGbwPcYnDP3v9jsx2swnGe+VkYB6HGGqf7wgsT0b4mEiSLIE6uNWRB91PEN
 Ycokl6PPkmqafYxORKh0uZgjh79mMGMio2chgnUrtivANtyJX0y4h3Tk195P+1QQEDIYaLkUmeH
 pVzgKDzR/J5BQkBMR4w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX09ZBeT3iVr2v
 F7H0fR0Hz7+28iMs6EembRuFCjKZ8a05AXVht3YYWCWtxgU2EDKBSKlnviXkn3cRLeyXHr4Z9V8
 DVH66cU+brRxwCyB6LXklMAf73OWb6M=
X-Proofpoint-GUID: UUqCnx5zuVd6sjJ9_OxNVGX0hf9KcbN5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1011 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250051
X-Mailman-Approved-At: Fri, 25 Sep 2026 14:26:47 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Abhilash V <abhilash.v@oss.qualcomm.com>

Add the SPL Kconfig variant for the Shikra pinctrl driver so
SPL can configure eMMC and console pins during early boot.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index ba866b5b6b2..0317489a3da 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -235,6 +235,14 @@ config PINCTRL_QCOM_SHIKRA
 	  Say Y here to enable support for pinctrl on the Snapdragon Shikra SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SHIKRA
+	bool "Qualcomm Shikra Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SHIKRA.
+	  See the help of PINCTRL_QCOM_SHIKRA for details.
+
 config PINCTRL_QCOM_SDM670
 	bool "Qualcomm SDM670 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -421,4 +429,3 @@ config SPL_PINCTRL_QCOM_X1E80100
 endmenu
 
 endif
-
-- 
2.34.1

