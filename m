Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF71F8A146
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:11:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C912B8422D;
	Thu, 16 Apr 2026 11:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BxBfvDHn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZyroC6V3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09BF08423F; Thu, 16 Apr 2026 11:11:06 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C50C8422D
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:11:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G6JNxF1668220
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 09:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w/pPf4eRb2Ay4Z7j6QJLQnbU+YWcD6NIwqqpt3PUs2U=; b=BxBfvDHnaQpxrSQx
 76ActYng27zgH6TmFcukeNut0kFrxhkBDbeRwd3cM789RQcKzlCFE7iV2up+Xq6N
 I4T5Q46ixJNRj0LHfI+dKg0tGFGoFAnYK0zvjLxTgIm6cxmX28i+Qn8M2ZXop7w3
 aJzBzZZ0lnqId8xEj5tmrfJBeHJJ5EhpuhR2z8tkPPnQG37Itk271XdQsRrvz3MD
 cLcMjxOWs1Efat7Wxl5J2ULyH4C8CfKGmY6GgGaqciiUituNvcfwmIEmpOUbwLzY
 LxB8QWg8nS5c+fZnwa65Jrx9BnG4mtmzsEjJkjST+w6MdWxXvoMZrvfFNMmQdhPW
 cWkrbA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djtd90nrp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 09:11:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35d9f68d00fso15627730a91.2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 02:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776330660; x=1776935460; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w/pPf4eRb2Ay4Z7j6QJLQnbU+YWcD6NIwqqpt3PUs2U=;
 b=ZyroC6V3P0KvbBJg4eBRf2u9cTaLkYUdtLPCh5HkfUEA18VoPEv6TPAg/JuZ9jMzf1
 t96KTeDWTtkYOKstPRc6mxHWNj5THjo+yB/8+20TgcPPu38o6ispbkVNO8D2wMvUi1JJ
 SS2eTH5vxzs4HGfwaIN5c7RZwM/czfSII0S0X9BlgHEIJ5d/FDItjxtm413f8uT1Fv/C
 /CaOzguGOwkwF04jcdfKyp43yh8gCHFxstl1RsVbwlxM0lLZggfRt3LNxZyv5lkWfzIv
 rQOdYQuQ9SSzouaNr/j7ujrhdy+a2deFCfKUFYbu65O2jUdQvcGw3ArD7iSYkfrFy5sn
 eW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776330660; x=1776935460;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=w/pPf4eRb2Ay4Z7j6QJLQnbU+YWcD6NIwqqpt3PUs2U=;
 b=Fn9L5dMEfoBrFphS+3siypLoUoBy0d4YzCYXDY3u2u2i55joBNjEVtcONK0Uo1zL9N
 IVY/n9IXybB4buEW7B9h9O/C4sQmnEnXVsj7UVayU+SSp4NL5iR2WfhkxGptyl+7M6Wq
 j2r4MC8CB8GUX0Y0/DTLyiWph4d/uh0VnlzH7LDlCvzhwFEo6Qzwc/m+/Cm8ZXKXoib3
 OXeRIglDaI9+1iNDXWjh6crZCUxUeL/lYn0isJMtfz3wJyVTD5u9fsnL8NJ5YYV89sYJ
 TsXj95AgaGe7YN28TXcesvfoib/0Y2gSS1dzRREg/r7yDS2bRHZQ1EJX+Cu2opXAj6Gw
 IDtA==
X-Gm-Message-State: AOJu0YziQvpLw38KYvUARt8g+mIMWyZSb+EO/1bDNBsJpw9B+IF8EdVN
 XMlUSJpqrdmMjnbtIRKYhK2X5jryalJOyPDQ6h57kzLDyQyfLEhvRHcXjg8a+d4EOBWjwTs/TRY
 ZH5KYk9k1F8haW4kzgXSmMZhHWeHd7k1RWM0Um6xaaAZRe18EOpHaZHTF
X-Gm-Gg: AeBDiet4m1iv/X9GpTqyPTfOIUiH0i+PkruNjkvMSmaOFaDPV5FCRhcuboTvZ/AwzDm
 1Jkll7VCMy+feJVfBCVucuppAo/PWzU6uQmPi6KdFUK4cd4E3xDFKOOppAklhTI4w33Gp9ce9cT
 YLztfSvjlKpU0C9SGL+lqiVjpdY8NwmwjBdNdIajMvobAYIAJX4s7ytfCNKgh5sxWC+aqntA3In
 5SKa3RNM6tAkl2xL8npkYz1qJUtmRvFwiHIvlsNcx48W9tIr3ovNnrbZWKXc5wx3Ly0lXRWhcTG
 yCdXdZf8ZxSNGP0ckA0ZOS7kvRe8lcDXfeUX7qMPefQb7S8QE/RpfM9J8VcYVs3vqaGI5uEPsBi
 +iXDXVEcEC8gwctecZQWg4FwnbfR0pWuWpa9diBkjayzoWnYU3Ssj0l2jLZmGzAZfq5CWpMC0I3
 BsjQwssiQms7bmtIQwztOgAtFVJw56uQACi0sPc15+cMVb3bXCvQ==
X-Received: by 2002:a17:90b:17d0:b0:359:fe72:3559 with SMTP id
 98e67ed59e1d1-35e42883e2cmr27351512a91.21.1776330659910; 
 Thu, 16 Apr 2026 02:10:59 -0700 (PDT)
X-Received: by 2002:a17:90b:17d0:b0:359:fe72:3559 with SMTP id
 98e67ed59e1d1-35e42883e2cmr27351457a91.21.1776330659366; 
 Thu, 16 Apr 2026 02:10:59 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b47810b898sm46211895ad.25.2026.04.16.02.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:10:58 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 14:40:47 +0530
Subject: [PATCH v3 2/2] scsi: Enable FUA bit in WRITE10 commands
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-enable_fua-v3-2-84508de2bfd9@oss.qualcomm.com>
References: <20260416-enable_fua-v3-0-84508de2bfd9@oss.qualcomm.com>
In-Reply-To: <20260416-enable_fua-v3-0-84508de2bfd9@oss.qualcomm.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776330648; l=1165;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=K8FU1jHxNjWdsxAsB0hUWphZ5zsNXcrzIM8XrHaqwp4=;
 b=UNIeIjpXI7+4kYLGqyMPrr9QUQ+J8g4jWxNPgCFAhKubLbruJE4ueyVMC4L3Y1ralRQqedN+8
 hcvKLnzG0ZeBi119OFYTyTymyNtESJG62zU/zLSDji57SpTELBnmGxN
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA4NiBTYWx0ZWRfX1E7+CNu+tDkV
 fWgaE32TAZ5paIwEfeC6fsLYAzv+LirM23URcMP0fmsvm8DEIvSwC41hOsaNnBXUCRsD5JPi0Uf
 /PdupJKEJRbo1jOCwZVTVKRXpTGRhkRJjCcKIsgSQV8WN0BxcC5vNm+mi6tGh0EiGjmlFFRt53E
 VvhCWjjeH1I5/NR6LthyJJbpQfAFj/01SLfL01g+PsdN/qoDBgEGKM6uBfNXMNy6oiwd75NLBpa
 2JRZffHNpp2WwIL3Y7K9DnisfRSuzJ1L8KsTHJ8z4HRg5p8uMkhjhFGmFpKO2CsXJIPbk50hO1/
 AGJkgIBtJZJWqj9wLCIZ7NYIfWgPJ9aCVaS3Eu0EfnIFpASRAg70Ua8Y5ZyznQZzqZ7yeivovQB
 x3Vg52AzmJfjDjxEF+NoYYgudbvdSKaBIcStB2tmugqHgstgdb2NcgfYZHZxxD453rM7dpxpBkQ
 BYsPEXOq9aqp/hojxVg==
X-Authority-Analysis: v=2.4 cv=avuCzyZV c=1 sm=1 tr=0 ts=69e0a7a5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=2KWoTbq3bzERRF-STQcA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 80ti04OHpWlGzhR9N65Bk4a6dMRflkvP
X-Proofpoint-ORIG-GUID: 80ti04OHpWlGzhR9N65Bk4a6dMRflkvP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160086
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

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Enable the Force Unit Access (FUA) bit in SCSI WRITE10 commands to
ensure writes bypass the device's volatile cache and go directly to
non-volatile storage. This provides write-through behavior that prevents
data loss during board resets.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Added SoB in commit description.
---
 drivers/scsi/scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 9a417795851..50e7d749921 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -107,7 +107,7 @@ static void scsi_setup_write_ext(struct scsi_cmd *pccb, lbaint_t start,
 				 lbaint_t blocks)
 {
 	pccb->cmd[0] = SCSI_WRITE10;
-	pccb->cmd[1] = 0;
+	pccb->cmd[1] = 0x08; /* Set FUA bit to bypass write cache */
 	pccb->cmd[2] = (unsigned char)(start >> 24) & 0xff;
 	pccb->cmd[3] = (unsigned char)(start >> 16) & 0xff;
 	pccb->cmd[4] = (unsigned char)(start >> 8) & 0xff;

-- 
2.34.1

