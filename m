Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEEDF436B1
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 06:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A96A2842C7;
	Sat, 18 Apr 2026 08:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KNhr9ZBE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KjAJbMJI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D68784246; Sat, 18 Apr 2026 08:36:06 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73AAA83B99
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 08:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63I4UCAm1430686
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 06:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BgAk3WRtmMh4Yb0nicCPHGRIkeugehSNj56WNbi1t1Y=; b=KNhr9ZBEOuDLa51u
 E7+LMChUwMkyApvcZyNK78N8KiQQs+bxOanYvvTW7ns/VnSOlnG3bdGtzdYrBbJ/
 /3odF7MDelFAeploZ8mhZEwHRRJxVEuj5EMuT6Alo8VcyM29dt873qpfM+wAX/Wv
 gnLU0k7ZMLGMb7xEKBtncxtCIMkvezxjkA+fpMNug1S10dBihePVEriQcb4vhhfl
 zyfJhRpgsnj8ZFe6w4XWes8IZrlyvCfVDaH39z/LpB2sdwIlTgFBAoyC87WFPbhW
 w67RIUSeR4nEChhFDEe9K2ZYWQobAPh8dzIdjlUpSLxCNtdveQxOvT9LSUXdOnvY
 nzClsQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm21ug8r4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 06:36:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b250d3699aso29350155ad.2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 23:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776494161; x=1777098961; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BgAk3WRtmMh4Yb0nicCPHGRIkeugehSNj56WNbi1t1Y=;
 b=KjAJbMJIETWeHI6RergE0dJd8iwOp0WZ5klLNJ+H0BCwTsyhaZlwlG4DoVbcf59jat
 7bazdDGt4QgVApt9SnczpK7tXa8yYqCq1K8gq95edq4Wox9yntEb0krutWPu4s0GqR3v
 omxnRLseqnTX9+362HJqQm6PU543p2byALpgPu1Zws5P3k2xyNdB3n6MPaDEBal4FxTk
 j9uvZej2/Xb/Whuct3sfbPVqBkE/yDA/o1PZih/xXwPe6e09x5lf6KiISmfCJLchzD/K
 T9T9nJge/YUnJ8Bt0KQzEoqI+40zJxxcLHyyeE27pPLTUEURGS2E0V6/46fIqUfJbdUy
 Q+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776494161; x=1777098961;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BgAk3WRtmMh4Yb0nicCPHGRIkeugehSNj56WNbi1t1Y=;
 b=pp8da5q3OBgllDC57bvyp+xjoqWKI4OKJLgoDNN8YFHL/jhJzD2NSc81fuzeC5IOj3
 AnXmJPxFofDseY72f5iiztqw+ahEPslY143mQ9h7ZaKiqgSq6ihNdJX+iweZ3Q4DVcmV
 YneSLacbBg4O4Q9zqABoQG0jzcWeDpzksmxquElPIOtqMLKimFdR0q7zNMXV5v8DuAwq
 7w8hoGpvF66QD7CxtlFSDITetX44TkJWJais+QJCXmNmMcUAN8PINR9jSOPFujvAIrRP
 +R+sCnMl5TlY8QgN7YQJoj1W+8y46pOKhFnLWnVNDbFzZ9nOHr3c3F8RcNDUzVTKSP2F
 UTyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GdAWjU/i16vYQ1WmJBjNNxmnrTirwYyLB3iqgXZKDHIuM4LnAqx63NWmYkvAegn4/eZ/GnYM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8+YyZicY3RT8pjrQ1r1ZYMRambRKIPp1asvMoJR3u8rnrJFYF
 KHQuoWYeRLBt9LzfPDpHMts04+Nudzfo+sS17wRzfblZjlhsVTGyFi/kMEJHPNxGlgtFvd1jZX9
 nyR10e9bU0TpJv/34LTMoNsbTNFEX1PD3NXbUau0ZvvsmzQr08F6QbkjY
X-Gm-Gg: AeBDievfQmhY4NKuPTEzaIgsaNi1JxtVNKVutN25dMWZtjmSugYBUeFRPr8PT0EKq14
 aMXnXEh4Uwupno8yE/vQx0Owstdp8Wxg7eQO0WMDkRtJQ0jYElzPZeZJA6WiWXt/vriaw/A7AWk
 VpZyKlPNd2r40LC7U7+Cn+YUTe19xsehk0A3zDa+olD3baDH/4vzGSpP1GsAmz01fZzurPpdrgr
 zS6ZbwZrFYtGcsLAq39+xKwWY2QloVCXXI0nvBdHkTbHkr+nsE8Rnr9F71hHdHV1EP+0VsVzGZP
 18/3bIGBRZL1qyzg4YvoIBwuWSOwPly3ocuJ2KOJMSXBLjRhvktFa+SSBx9qPaTLd4Lk+/60vGv
 knpMeY1959g6JtBog/Rg9Fkge7btstZIlBD236hv8ptTxk/bGTs4ypAFjMCzz4BIGdxgE4F4OxN
 /iP/QpP+broLmZZNb9dedRgTOeUKtuCPYI+CwaxvK/ewS+LF1gzDD5NowpGh8b
X-Received: by 2002:a17:903:28e:b0:2b0:7531:b61e with SMTP id
 d9443c01a7336-2b5f9f9f125mr61209705ad.41.1776494161037; 
 Fri, 17 Apr 2026 23:36:01 -0700 (PDT)
X-Received: by 2002:a17:903:28e:b0:2b0:7531:b61e with SMTP id
 d9443c01a7336-2b5f9f9f125mr61209445ad.41.1776494160554; 
 Fri, 17 Apr 2026 23:36:00 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab20d33sm40542345ad.63.2026.04.17.23.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 23:36:00 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 18 Apr 2026 12:05:23 +0530
Subject: [PATCH v4 5/5] MAINTAINERS: Add entry for Qualcomm PHY drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-kodiak_ss-v4-5-d381670c9d78@oss.qualcomm.com>
References: <20260418-kodiak_ss-v4-0-d381670c9d78@oss.qualcomm.com>
In-Reply-To: <20260418-kodiak_ss-v4-0-d381670c9d78@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776494121; l=713;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Z0G/a1kK/+qxOgLcQpr52z8KCnGbukFPdfhlMvZWOcI=;
 b=UH0aFYfddux3hl7UoZ80JD+rHI/1LnZmDqQ/ScJNVFd6ZTRBrk2kAzRDHvVvjQdw5eL5HwwMq
 MQd+SqOOWXiCjp9cZbYOcn0mTrcpXJKpxMzpP4W8xerRM9n2trpjXi0
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDA1OSBTYWx0ZWRfX9axmFHlxGWq6
 p6Uj4jgUL4G2gAuKWNU4OUZpYi3SXOs3INE6K7hHRAqvbGf662hxELMbo8WlG8FPS+SHcZ1cybx
 IcibPw1TmFQZxzBV04hHxxkrQ8X3PBIEF2zSQMJe+ENboOIOjlj7lmFeh/4C4RTO4ENg/lKPzYC
 0n+najYJEzkPSzRjup3VCjOu0cOp25NKkbf3BSB3C7ChrGzgWqPMKypER7OCN9fw/tj9UP7yBdE
 p+d3ZKAogPZ6+raFHnmcUbwRksTVgFtvdyKJrbI2uVfpb1sLp9ur4yasscmTmzNQaRCYAxGrcMf
 l7ZwZAjy7QGBJSZW73b4rlao2rpMMufwcFD3ceZWIGCNgWdGH+ueP2PYQmW4K0d8D4RiMVOfquX
 n6CtRGKNQmAcdnZaltkVoPbeXhFg97P1W9fj9sAClhX77paGG8yXRIhuSwmu+dEoyKJJKhphH/6
 Qdpjwu7e4/D9IKIf/cg==
X-Proofpoint-GUID: 8PBaz-Edy5LIGcwKCS3Gbgz5uMXNKtcu
X-Proofpoint-ORIG-GUID: 8PBaz-Edy5LIGcwKCS3Gbgz5uMXNKtcu
X-Authority-Analysis: v=2.4 cv=WK1PmHsR c=1 sm=1 tr=0 ts=69e32651 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=N9Z03To9XfXxgccbh4wA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604180059
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

Add the file pattern for Qualcomm PHY drivers to the MAINTAINERS file.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- No changes
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 056902f6ef2..e084d58ac3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -680,6 +680,7 @@ F:	drivers/*/*/pm8???-*
 F:	drivers/gpio/msm_gpio.c
 F:	drivers/mmc/msm_sdhci.c
 F:	drivers/phy/msm8916-usbh-phy.c
+F:	drivers/phy/qcom/
 F:	drivers/serial/serial_msm.c
 F:	drivers/serial/serial_msm_geni.c
 F:	drivers/smem/msm_smem.c

-- 
2.34.1

