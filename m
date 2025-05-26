Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF74C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 09:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A63B982D40;
	Mon, 26 May 2025 11:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z3fMTv6A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 833EB8004F; Mon, 26 May 2025 11:32:19 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E6B82D40
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 11:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54PMtDJB023008
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=l4hQMQ9IHSl
 hjDlenocQK7j2s5joSog4fsBh6WlNxKg=; b=Z3fMTv6A8yP+yphSyBvqTP1eBYA
 n+gNzb5SfWLzkPRRV8f95Y0B4nRgn+8fp8AMyzZw01iGiiF4WAl1xzaarnMS1n/y
 19tRj7lg6c998wwZ+H4ZqvAtx+BUhHHjgX9mYgtN/Q0PCHqczlU0uJm98psQEdTV
 B4zrTslmES8oobstrw1d5wkgwHrOuhucQAyfFfdKzcleNwU1kAVXtvQvnoEPMzjl
 iDwxKUJo1jH+1OOlE/vMl3nF9CMQQZ5fMJoO6SZoUooN3MqlcZlQHIupwS6lJu28
 MUh0pKnT9puSm9AQ1MBHWeFdB6+x+V3eVVun4HPebh0jguavXLceTs3Vnag==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6vjkp1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:32:15 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-740774348f6so1717415b3a.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 02:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748251935; x=1748856735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l4hQMQ9IHSlhjDlenocQK7j2s5joSog4fsBh6WlNxKg=;
 b=pVZ8ylE4qNXEUMHd+RmcsDREPq+fv6mRT/3z4qe0l1b6hAPKTLiW5spd8aVZOQUwym
 dQP86I6BDqKAZnLnmIpThZlSnoKGWkw9P+4cwVn3J4cXRnAFwQwIbDo9oD6xVfetzhDt
 AomC5MUHA5inINQt/PmOk5xi2TGrB5xHlrHIwkd+Pdmh2TlEJTxi6EnY8ZDjtKE2MaEc
 JTrphfow7ceU5QDpJA0DLMzVLBlHjJlrPGpyo8vrJTgSEyHB2roDxqXjDzApSrTJBT9D
 K41PrJoUQLVTZUsFPpqtXGGW5qp799nO3094kjBYOmPGOlwHPMnDyqeqS1AyvH1n+jLY
 azSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfU113Zf9ZiQmbKlTQGxr9ovsxgdFxKQbYnfVKEcf18jFvOxkZHcUM1D7FBphQmLjFBCqQwZ8=@lists.denx.de
X-Gm-Message-State: AOJu0YxsBo3WMtMplk2/ZwILc1anLebDD3dKFkb18MsdLleG8nBH1h5v
 9ZnKX83/bO5GsqAOnbZfQv1o9JfurEfUFbatXD6BR6gb28CRp1Pj1TZQEtYKIy6tWDTMp4YNtbx
 XVci1tSL9HzrA1KBlWDvXKYiAvHYa4Ke5QfR+BC4Ao1rMJh+ln76Gk+pG
X-Gm-Gg: ASbGncsCZA9i6QD/ILSuI+ek0UL2JD1gRhHpxmGDNPZEEF1PcYSYeMqSvb6jGtYjKxB
 frBna9aks/KToecV2gSAaKHXQu8xoLZWbrPOzLIyjgNYroD814UXTo4X8P8nkbLsc0AW8HgpY0a
 iT2bRPWdq0VqOay0XbC8KIIGIEJZU3qp6uMc918Xo6oyMyTTBBexHMKcpvipyf/DRSQ/HnAbKIc
 JRVTxhmlLdUv9Dl9zoFlVhgU+hI/rpGuneRBznOvIx9s3x/tdN2oOaShkDIWX8KIU64hT7eNEpF
 46dXhNsEDJPTaU2y3nwBMrwwt1KjxS2x+MvNMCHtNQxlFRKC8Sd4PXQrZhEWFODueeZPJ3aOmLr
 PsAUsL6M21KEJAy4PXYwZkz0zsry4DQG1SuF+VCu/
X-Received: by 2002:a17:902:e5d2:b0:21b:d2b6:ca7f with SMTP id
 d9443c01a7336-23414fbb9d8mr157434985ad.32.1748251934815; 
 Mon, 26 May 2025 02:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExZsXl4apwoSi15Vduuplw/vbF3PRvK65grpRH8vUDJ8tcNw4q3jNYfXvt1qz+LgJhzI8F8g==
X-Received: by 2002:a17:902:e5d2:b0:21b:d2b6:ca7f with SMTP id
 d9443c01a7336-23414fbb9d8mr157434455ad.32.1748251934395; 
 Mon, 26 May 2025 02:32:14 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-233ff290d45sm46633845ad.153.2025.05.26.02.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 02:32:13 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, sr@denx.de, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, sjg@chromium.org,
 jonas@kwiboo.se, jerome.forissier@linaro.org, raymond.mao@linaro.org,
 ravi@prevas.dk, hs@denx.de, arturs.artamonovs@analog.com,
 devarsht@ti.com, nathan.morrison@timesys.com,
 balaji.selvanathan@oss.qualcomm.com, bastien.curutchet@bootlin.com,
 ian.roberts@timesys.com, festevam@gmail.com,
 vasileios.bimpikas@analog.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 2/2] common: board_f: Enable Qualcomm watchdog
 initialization in board_f
Date: Mon, 26 May 2025 15:01:53 +0530
Message-Id: <20250526093153.3387410-3-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526093153.3387410-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250526093153.3387410-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UOXdHDfy c=1 sm=1 tr=0 ts=6834351f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=fHYs-rb1nkPhiTdjf3UA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: m2ZFOwud-B5t-jStL2dqK7l6Gbgvb8I7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDA4MCBTYWx0ZWRfX9FNkdz/GQg+r
 eOPw/vVj91opcr7WNjh1J8yDj0jr5qQa3hpwSTYJ/+GhbqcCq8yku8c58L7Stbh4gMg40v8C4AP
 9CRmqSj05rEBBuDRzhk+eeMEXOXrbH9MeFqNgr30XKERq/gsW2FVMWUSWlj0Tb92bDkcxWvy8RZ
 ezmJFoa5kGfJsLc1zFIeNEt+w0h6oEWpXNUzKIceA267vzms4zROK+BYp5Wb1gXAbjGbZ39fjRl
 HqRDvo2oLofYKZS9IkGRnn70Fns/w8wSdXb0hfAkWDQjXrBAy4zWraKn/6GDBljNAF0CSGiNgSX
 FtV9AvVJS1hambjdWt/gs3uHEq0Pn8eIFOUldcmVRb2ejLpAmO6O1U1+BuSlnjBY4UDdqrajXZf
 CPo1RgfmAnlB1Zd5Ba78vFhEsp66f2lUIQ9+gAM2RnjGKweOF01uqyskf3uj3507y/pE+ICZ
X-Proofpoint-GUID: m2ZFOwud-B5t-jStL2dqK7l6Gbgvb8I7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_05,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505260080
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

Extend the watchdog initialization logic in board_f.c to include
support for the Qualcomm (QCOM) watchdog driver. This ensures that
the hardware watchdog is properly initialized during early boot
when CONFIG_QCOM_WATCHDOG is enabled.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 common/board_f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/board_f.c b/common/board_f.c
index bff465d9cb2..b03e3bc8e7c 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -93,7 +93,7 @@ static int init_func_watchdog_init(void)
 	(defined(CONFIG_M68K) || defined(CONFIG_MICROBLAZE) || \
 	defined(CONFIG_SH) || \
 	defined(CONFIG_DESIGNWARE_WATCHDOG) || \
-	defined(CONFIG_IMX_WATCHDOG))
+	defined(CONFIG_IMX_WATCHDOG) || defined(CONFIG_QCOM_WATCHDOG))
 	hw_watchdog_init();
 	puts("       Watchdog enabled\n");
 # endif
-- 
2.34.1

