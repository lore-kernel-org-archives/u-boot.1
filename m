Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35ABBD68BDD
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 06:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33DA183CC7;
	Thu, 18 Dec 2025 07:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iPQ35Srj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fjboCTbv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF10E83B55; Thu, 18 Dec 2025 07:16:33 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5260F83CC7
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 07:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BI1Z80F168160
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 06:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AI/EKejlBei
 lOiRSx52YN638I0SlHOkh5rh3MtdLEqY=; b=iPQ35Srjb+ST16YXP+lca21LpAO
 S9sTtMfQXPnEDj6L7BZ8ST2KoKF+FFYnuHg+akIw0erOEnzoOB08hipRHDQVuSPa
 jFx5zmmueLd0cB0QDaFXwL3+lDGFf+j8DFYs9mHMdnfStLaq39Eof9Fx0wu9QMrJ
 Dc9pLqrXxyCSWXMLkw2QPP/fHTr1+YT++brN9yrSRxsYwj28rp2DndHbwAnqZyJD
 9vebMGW3CulOu0aWeNCnGBYagXYB3aLRcI3ZFKZfKr5xLUTgGcZZmIARzDpqk0pB
 1hT/S+GASPIgN/KXfzncfrUWFMTYKt9mc6iT4BNsqefYHIhIjXsVnjHmyhA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b45w51152-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 06:16:29 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-34c6cda4a92so647015a91.3
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 22:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766038589; x=1766643389; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AI/EKejlBeilOiRSx52YN638I0SlHOkh5rh3MtdLEqY=;
 b=fjboCTbvMF3+B5DjHZmMbYXWnz0t1bEhjcFpY8qSnjY+qoJsXic5yTLRRoRPCwppwz
 iRR7TyjXbNjUHZzXwI+cqOMkOVrGJTQSqerWhNV+s5TlJeBWRfvP9FruWHHWg91hg+2X
 aD/+MkF6twMuzRjd00akyhsfCsWHF3GVMUMPybstZbDAlDd2sZOiducN8++vJtYSLbI+
 +H9nrJXfrFfHuGtlnehMMcO1vnLfiu3S41M29bGVUS7XoFicOXKkbx7lEdcPQ6HfgBRZ
 cW7fC44EXdsRjADejhuzwXrJUviJgRyX8mAUdl9XakbvDgfGhE1taT8iXkk9XKVsjuxU
 fN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766038589; x=1766643389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AI/EKejlBeilOiRSx52YN638I0SlHOkh5rh3MtdLEqY=;
 b=Du2UYBTqEC6ZjqcGeasyk9Ds4/Dj+R0r3Rk142eMuDh0gePym+DjkOenecmHAszjeF
 HtIzkidliDQn+8ks5KSUpOZTlxJT7Vs8uIPF6z5OIyRr6ybsYexgS99dMWIB3bXdfRoJ
 OYSnOz0pc5AZlnOTHFk1XHIZodAKKDGb1Bwwe0cDqrK0iQei1kTOp2aA2rI5ATOCVZeb
 OLMf1JfnlflTAcGvPqQY23U8I7X2mYtqimmdxGXiRbYBmcHqe85oy8IQbVg/FRAhHK8u
 //fKOO/JqUON4FGDp4ww7J0IivV6q6layGFv0TIjmqc0Ms6akmbSEQWD5rrk6s9e1IBs
 JX0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7GIZcq3ggHZneW+ArgAqtLY5A6uuOHbpEvMIu2r0EHl5PWOt2oUtO8VLfiN1zm0vkQa3ccnU=@lists.denx.de
X-Gm-Message-State: AOJu0Ywq455Sd+Cc4piUfDa+MbIcsPYPp+VNCA93ocFDFTx1h8vdJDIw
 PIAA5zn6taeTY371NVWzbXh8YW+g3e2b+Z6nHm0iKYFKTo8tgIXqVkiiR9yRZsPmiUquZvn8J5U
 1Eru1Yfrfe1mUsOkib2NJTN88ptJkA97ZjqwBtaHPc0ZC2Ak/jXaWeX8G
X-Gm-Gg: AY/fxX6DvCZzGk7SN90wcQuC/h7HLj++mwglEU2jdnQlFJI4Omi3Z+s0/SWeGfzqkKD
 VAs8euLpXRoUgjupbQksW15llu+2eGtLA5Fyahjz8lS2cw+kVwQfmwkbt9TmNJV8v/OMnQFkRvH
 ZeOxSjNj0+6QBLwkBJmkwx/dIfL4dHdVSxIjz5t3eWYLXm/E77kK2sNXwSObxboyJ4a+/l5n21h
 iyITCqVUbYwp+hNCftEhXOWtrgr8mE1aL36FPx/tPWcpXlYDBtxIbXwrInD6WHDMnyqkixbWRVf
 h1G2jaFaNs1U0dJI1QAqa27jD3EGge3sGSxM5FWeA1RMw6/nJkUc37MZ0OZjLkIPZcuczZLKEpH
 Jdq4dYH4uDoVL3JJ34x9sXZvB6xuLPNd5d027oy2GSFm77DSTy0paVBZHcxu4APSy9cnf3gkvY+
 Ha4vdan29N5Js5otQuAswQoh7QX7sOHhQ3aOpwVeQ=
X-Received: by 2002:a17:90b:17d0:b0:34c:7183:e290 with SMTP id
 98e67ed59e1d1-34c7183e3dfmr11485088a91.31.1766038588673; 
 Wed, 17 Dec 2025 22:16:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2KsfRVeRdPUYuJOGU1cyc4oFmSA+vGfV60KYfnA3sCgzll06COSuSNM1aJQbA4uzXWvPd2g==
X-Received: by 2002:a17:90b:17d0:b0:34c:7183:e290 with SMTP id
 98e67ed59e1d1-34c7183e3dfmr11485071a91.31.1766038588228; 
 Wed, 17 Dec 2025 22:16:28 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1d2fa228b5sm1198995a12.18.2025.12.17.22.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 22:16:27 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, varadarajan.narayanan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alexeymin@postmarketos.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [RESEND v2 5/6] dts: ipq9574-rdp433-u-boot: Enable USB device mode
 and MMC
Date: Thu, 18 Dec 2025 11:45:56 +0530
Message-Id: <20251218061557.1999367-6-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PD5F9Vr3fle571RUsrVrTv5GiYlUWFh_
X-Authority-Analysis: v=2.4 cv=eKceTXp1 c=1 sm=1 tr=0 ts=69439c3d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=CNuWJGMGguEIvuNeiLgA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: PD5F9Vr3fle571RUsrVrTv5GiYlUWFh_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA0OSBTYWx0ZWRfX5+Z5T4NtVMpL
 zULyGyFkeXG0omDp8vX2KMOQfjooZqnfk9jd2b97GevxVEHdChuuLx7tBOzs1OLVtZyK+5T6sCR
 lDGbc0rnAm/Bnj+sTHXN7zYLie0plC4gUfqCufJsfkdC2IyX1ZvAv2wT1DsP8uDIGOIsqd28PaM
 AntbAHoQobBfsKDmgW5KUE46zH86BYPnOMkYSBg47Ku1CG7mt3O8lvnD3ZUBKXcecvjijV1JTYM
 ZoPkF5XgJ+jSKRzG6J3nrtBGJHKSLaLfQgnlnD8PFV9FRf1HzMlv9pPuD14cU58+5ZMhLgSqdoY
 y3GGs6ZMGCOqtlNtENwEzTi0nl2mcbxX/3vdnCgemEvKivcpXLb44T1jqCe/uwL9lYqMzp9G5ey
 52X4QGwwvmaO5TBqnL9Lbdn4IUBawA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180049
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

Enable MMC and USB device mode by default to be able to use
fastboot for flashing images to IPQ9574 based boards.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
index 390e2338d65..9f04c0c1077 100644
--- a/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
+++ b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
@@ -22,4 +22,10 @@
 	 * reset done sdhci_init() times out.
 	 */
 	resets = <&gcc GCC_SDCC_BCR>;
+
+	status = "okay";
+};
+
+&usb_0_dwc3 {
+	dr_mode = "peripheral";
 };
-- 
2.34.1

