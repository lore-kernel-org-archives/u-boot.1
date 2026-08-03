Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C47AC55184
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 15:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0196F405D7;
	Mon,  3 Aug 2026 15:59:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y1f-ok0kS1C7; Mon,  3 Aug 2026 15:59:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29EF340583
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785772767;
	bh=BEwq/o0gvKvP7zQgA0zWRulTzDtHs3RznCHpnt0/nUw=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=OB2tv1RcOVqAswktUCP2RyRkFYWm5sMyR5eoW6WzJ7nhiIvrnxgRs3vo30HDpQXJJ
	 wRbz7BaZ7E0AR2qDCgYHdUTtgdiZ8G35GAAKmLu27W9CWsXD4d9/LCiAWyeJaNmT/q
	 EmYRAm9AuArZCb89lsokKe5IzkFfespgAPl76uX5r87Lv2TEL2luRaKvKkj4xtTshd
	 0VfdjY5yCjLBoOw7JHXb/5P+dnwTff9nQQQEFJIDQapN4nDHhDqvROfywrMvApjia5
	 aGYZ6gbzJZQ7jDDMtVZy2LxYASGC3YECbmtwTgKpOPqYBU8WGsyQY262nYIwzZmT+r
	 /XtDUDQaD5lnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29EF340583;
	Mon,  3 Aug 2026 15:59:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 977EA3A6
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 89BB660625
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BEvp4DfmlTSg for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 15:59:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 676DF6064E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 676DF6064E
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 676DF6064E
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:24 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673EBwmW1133447
 for <u-boot@lists.u-boot-project.org>; Mon, 3 Aug 2026 15:59:23 GMT
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnj7ad2e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 15:59:22 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8487ed7f7beso3979976b3a.0
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 08:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785772762; x=1786377562;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BEwq/o0gvKvP7zQgA0zWRulTzDtHs3RznCHpnt0/nUw=;
 b=Hphvg3cVWjAL6t7wz07Ut+Pt4c5ESy0d7TspwNZmHs3FGFRcaRzxMIwYSu2ENUAO57
 YpB8Sx/Z4E24UHlHSk0ezSU8gHpP/Ah5PHwcf1aEca/BRTOwxbU2RRjmVlhqhJIE1Lst
 j2zKpsX+wvwWArN/lpNefVaMWrGTiMm8VAt5xEfH9AtbMVTrHi5ayOFdM8Q3/Y/oA8jr
 CESLpGwQyLYBcrcwQ2/2QffDvvof2pezzdBxnMIH3LgV3gqpRbflE7AoliEyzkmBufc7
 LkokprYyGroNQpdvhT+IqeiptPC5Rr5L3IfTHExVPrgvJdojC21h5hbH9AHwu/frwvOk
 ahjA==
X-Gm-Message-State: AOJu0YyZGXS7TTi6UR85KsljV2icI3GwTM238qe55qG+U6atA0W3ZX7l
 igIlP66Bxa1Xj6pwFOhT2jfDXSTbHLGYLgy4JmuTMDblLlA4k19lcu9umTuw5lIeBF92Ysc5xRT
 i44Dq3yTis9Dy2QEPaDWF9RTFcGnjefrBODwxStLVEBtnnMZHafQZ+pmoWvtTOKguPCEfmgugy8
 FDSoY=
X-Gm-Gg: AR+sD13Xst+34y9Go5s1LP+WNsHJy9U7CXuYE3gf66qaXNiWaRMeyu6qiUjSttjuTsr
 qhcBvN/bZNUeHtKtAI3+B4kRg7qpGPHnpg7kkTEY+v+R9rfeWru5v9tGLwv1yyagEISklYTIfWn
 L/qjRtMdsjPajM+Rcva51nkuv4dDNHVzeiBDD9OhjWPx9qXS5PtZ6zhAHP4hiZD63tTg7Y/HC+I
 hJQk3a5HUVEGQXL7sK1XmyFS1pRWIylBMgpqPohzZDr+5rK1vQBZjDpv/54UsuH/DQl+YWP8O71
 qHxmKBgSh3Yjj6PVGAECHhrYxCHHYORYIyUHGU+BFfo6yjAgsyiArSiKiRwf+Phv+y1IQqNZ8bH
 0OXx8RgQtwuS5vF2JoS7A9nXIhWUa0TY2jc/t54osRgP36pV56yd71GVRMuX7aKPWX6Uw79zHex
 jotKe4B7b+Rx33L7q37M8uQ7AKlOuF
X-Received: by 2002:a05:6a21:3a4a:b0:3bf:6237:4d46 with SMTP id
 adf61e73a8af0-3c92a758658mr11124878637.28.1785772761633; 
 Mon, 03 Aug 2026 08:59:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a4a:b0:3bf:6237:4d46 with SMTP id
 adf61e73a8af0-3c92a758658mr11124837637.28.1785772761084; 
 Mon, 03 Aug 2026 08:59:21 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd9c1casm38955713eec.10.2026.08.03.08.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:59:20 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:28:50 +0530
Subject: [PATCH v6 5/8] soc: qcom: cmd-db: Allow boot without CMD DB data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-snagboot-v6-5-e8bf7a6fc0a4@oss.qualcomm.com>
References: <20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com>
In-Reply-To: <20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785772731; l=1910;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=TVnS/d7dOSCVdwvZ8mYnQy7lI2vJF0a1OVJdRMGL6oo=;
 b=ze+FxNXVtR1IfGQf0GRlPzC+ftwn4V/GwECsoY+fOXoYfRKAP/5EY6uUqCvVPkQA12BY9v6a+
 BfvcO24bBeGA0XA/1fPbGdAflmOWaXboPgLODdRbJUWw884/LBl/LRi
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: 9FQDkSZbRhvLBn_v5cN86WqF__w5cUvz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MyBTYWx0ZWRfX9TaBMwhLpWsZ
 1pAYPQzIg0yweYVLt9DIQwHUCom0DprwHTwWmcWMpZiMyyjJyaymIfmlMhAj3vfURG3KhiM6muz
 xJAzkOY31MKxDghIzisKCqqQtiLBTNHBPHNg2Yco31WgMPIX/X6wP0wkCG7p5JZ97wKw03HcHcy
 vLMyTWMxfBuMbofPyZqgP3Ajxq/4yH9rAEJ6peSC/81YPae6G3jECpvs5ebgkzOAre89MpAaCzF
 NTlbsPt8vYaISJ5OE1//Vc/2yoj+7CpTCwlW7FXAErrLjGAeAaafmtXcqFJtfloz/SVJk4s0KuF
 Up7T9KhXg1HCLGhq47CPiQnBeY8XbAneGc9IEKnNQ4q3RFUhsemwPBgSzNDMAw7d5v6K6d52Dx6
 Szr2Ir/e/TJeLVL1A0FHcwPKSx+8R25wGYR37LHofQCkMn2mWLf0+9MMS3d/M6uBb0oSUbkpvM9
 OePyoq/sIALm7QkrIwA==
X-Proofpoint-GUID: 9FQDkSZbRhvLBn_v5cN86WqF__w5cUvz
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a70bada cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=GqjHzkLP_lxEehVDorYA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MyBTYWx0ZWRfX1GC4QjVQHGRn
 DvcuvU+2ta+k9H/Az5zhb1tQyd7bM5TTmnIkTzpihUmZK6DdrYrfNyoHecUnB7n+tZDmA//gePd
 SW8f4p59In2q/SB3q4tRoTukcSVHqnk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030143
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BEwq/o0gvKvP7zQgA0zWRulTzDtHs3RznCHpnt0/nUw=; b=iGJdZbka+o7ESgFL
 TnSCVtcT/we/XTOaz9sltPngga82INABY8T1dSMlP23HnrKht58EyuIo1zpbMTWr
 soGQuhH8dIryk7WA2azbtjc2hidmSkFEcJcfRU+PrNR6mg2TmVxLzDBy8/hGEpv3
 kf+OkJChHaPv/eeDIt5t+FI1Djb5iNJEMjCJfRHvwctKIe23ujx3BV0joLWP8aBe
 l/OEHTDp+T/hZOTU2+7uhXzIxjUIoZdyMcrUs04EigQ81tQ4n/55WBf5jvoWhVyM
 WGu1Ce9SQ6nw875MdFtACrgV8x2kWBnFyjHDE8foXUj701IegzPnqfNzH680ZcW2
 IC0mzg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785772762; x=1786377562;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BEwq/o0gvKvP7zQgA0zWRulTzDtHs3RznCHpnt0/nUw=;
 b=gFym8XnGP5wUcJUcwXRLezGDM+U19BszUKSxponC8lPHAG3Xt6xeItz/Ta5Csqh/qa
 B4UZwo1i1AL2bxZBUfEFuGf6TE1JdLY2ORDEyGnDQE0saQLA4hZ07y9B1fgcxPc1nhB5
 2uVXdj6WDF8jw/wU8Deay6F2T4fWOreLBnhCLTwW8MF0wRZal1dHIMIEpWC1pM+rn9pw
 dCqedirCPklnBoTtKnV1ZHC+dr7L5Ez1nOmT06jSQWcbOJXbwuv7ProTJPYbFjVhDRnH
 UppNhfhVWZLjewxEKcmouL+YO1oprn943z3ilMfxUqn0amQa/A4uEtGwKYG3F1xsAm2i
 pbwg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=iGJdZbka; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gFym8XnG
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

In snagboot mode, XBL loads U-Boot directly without populating CMD DB.
The cmd-db driver fails to bind when CMD DB magic is invalid, blocking
boot even when CMD DB is not strictly required.

Use QCOM_SNAGBOOT_MODE config to allow the driver to bind
successfully when CMD DB data is absent. When QCOM_SNAGBOOT_MODE is
enabled and CMD DB data is present, we log a warning.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v5:
- Remove QCOM_COMMAND_DB_OPTIONAL definition from Kconfig as its now
  not used

Changes in v4:
- Removed QCOM_COMMAND_DB_OPTIONAL as now we use
  CONFIG_QCOM_SNAGBOOT_MODE
- Drop these warnings if snagboot mode is enabled since that's the
  expected case
- Log a warning if snagboot is enabled and we do have a valid cmd-db,
  since that isn't an expected usecase

 Changes in v3:
- Used "if (IS_ENABLED(CONFIG_QCOM_COMMAND_DB_OPTIONAL))" instead
  of #ifdef

Changes in v2:
- No changes
---
 drivers/soc/qcom/cmd-db.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index d0a6047b8a6..c94a90a2903 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -252,8 +252,19 @@ static int cmd_db_bind(struct udevice *dev)
 
 	cmd_db_header = base;
 	if (!cmd_db_magic_matches(cmd_db_header)) {
-		log_err("%s: Invalid Command DB Magic\n", __func__);
-		return -EINVAL;
+		if (IS_ENABLED(CONFIG_QCOM_SNAGBOOT_MODE)) {
+			/* Missing CMD DB is expected in snagboot mode */
+			cmd_db_header = NULL;
+			return 0;
+		} else {
+			log_err("%s: Invalid Command DB Magic\n", __func__);
+			return -EINVAL;
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_QCOM_SNAGBOOT_MODE)) {
+		log_warning("%s: CMD DB found in snagboot mode - this is unexpected\n",
+			    __func__);
 	}
 
 	return 0;

-- 
2.34.1

