Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0716CC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 19:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C781B40A6D;
	Tue, 28 Jul 2026 19:14:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LdQlNCDNYEOu; Tue, 28 Jul 2026 19:14:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 80EA640A55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785266080;
	bh=B8M/NGupg5LLnJCh/2UohvTN/rx5+hl13+YBouK1p1E=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=pzjxlwXz364XSBwhPaY8IsRNDPix6khyLpOZ7EqZtl2Yc8ZlEs8tJm37KKh2kQhd2
	 Yrxj8gG8oqKB2LgNwFot932fLLnIPDdKiasDjrGqsdKUJ9HqZ79wScWPtgBvUg/Qeo
	 zIbMK+6NHCWY9hMfyCl2sfT7IzMm0kcw/SXb5IBpCfWpoi5LKEItx0n+Wq7ex2nXUG
	 mCu5Vxi9ykZUoowWcoWMuc/gjou+Nvrchggs1wbuJvjoh11w7PIXWJn4+gXVeB8NS3
	 LQirw8kUPALYjNvRVfcJCPU3rt3rkrh3WlcAREYqDCk2xnf9MR76ea1ytRBP+hkSym
	 u/TedW2oKBM7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80EA640A55;
	Tue, 28 Jul 2026 19:14:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1ABFB23F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C79A4038E
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:14:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WoPW1Ac4MaMK for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 19:14:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9D4A740099
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D4A740099
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9D4A740099
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:14:37 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CECB48494B; Tue, 28 Jul 2026 21:14:35 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C6FB8404D
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 21:14:33 +0200 (CEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SIBa7A3960770
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 19:14:31 GMT
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fq108rcu2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 19:14:30 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb4cdf95b5aso149498a12.1
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 12:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266070; x=1785870870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=B8M/NGupg5LLnJCh/2UohvTN/rx5+hl13+YBouK1p1E=;
 b=smaMBYUl5m1gV3dD4t47tfOHaX2Hxvu8oshXVh3zFws+ZLdp74yf8eWkzh7M2QMja/
 CChTzwYFDNaRRbIIPl8RKxUm9Nf1ZxWe3zWn7IwQ4Y8wpsR7w/iPobIZ1xvgdYXyBOD8
 qPZZJdGqYdaH82uX1Z9u3aEoG4Djf00iLL9d+CEOo5PO2P2Q0M1CJ1M4E67Kwlo+uCFf
 skTkEEy8xafV3S+7ndKxbc1aEqvjPVwOg2rHIPGv+ENLWegL/tm8NbI0MLzXDHIhDDVF
 6yC34XZmCLCarjDsvq/GVUqimrdrJc9R3lY+w063mO5pE4p6mEI/qQ0scegpQpq6xC/y
 AN9g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0RYd8UwIvePV7FM1yf1YIyLTA+KTK7LmDHEpAZK7UU8l0seIJ5wHMqGIP/zHUixL74OXSI0Q=@lists.denx.de
X-Gm-Message-State: AOJu0YxMFotopSni/0pe8BVZi8wLunydC2fvQyZVSC6bAjdXLvO5lRDK
 o5M4Mn3Zo/Zuh0AXCdmUyX9zI3UkWWtk+EsM0gRFdP7RD1fhVcAE7beHtc1Tj3haZyJ6AdcjATw
 RubkmX18BsOAne6BdkkyQrIOQQAxzELU189e5WiuLpzocA30+hwe+8b9r
X-Gm-Gg: AR+sD13dhWvdQLTsd7/MdvqZOf+pc/hSRjfyu3rAXIt76YzniHay53ZUdg3zH7gJbhb
 Cu2GfTGhcV5hT0mPLsi5IU9JdCn98b3idyhdiiwLBcUqSJT/q9Yf4DcYPLHrapLVExRCH8Y772y
 0i6Tw9eGNeQKkw6PRqmZc52CRhbajMQkNLPGIMJXFXpnHa9DG/7zClPDMQ6O8ReY/OZpoUhqx7y
 sa8TqHAq9U4c9U4r6v1TKAx5EU4xzGi5852+YbkHPsF0/BbUESrrhwRy9NZcLuXOI2x4XoloAtJ
 w81v4PssxvXRQgq6POUQLgpWvGlcUtU2IdiEis7LmCDvVygqTN5tWhTvSDRdviTMoekZpJ3zjfn
 +tLecYIJMQPKy7nVkhrDzwIY8bS+FVJZXvchlWgs/htUOLvdiu38BL+etiRQHW+XkcXDX1INBM8
 uHodORJzdQYT/KBWZHyqQ=
X-Received: by 2002:a05:6a20:cd96:b0:3c0:9c1b:d0b7 with SMTP id
 adf61e73a8af0-3c8ba66957amr4529089637.66.1785266069971; 
 Tue, 28 Jul 2026 12:14:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:cd96:b0:3c0:9c1b:d0b7 with SMTP id
 adf61e73a8af0-3c8ba66957amr4529065637.66.1785266069491; 
 Tue, 28 Jul 2026 12:14:29 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504d373c3sm1261294eec.23.2026.07.28.12.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:14:29 -0700 (PDT)
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, quic_varada@quicinc.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, linux@smankusors.com, ilias.apalodimas@linaro.org,
 nathbappai@gmail.com, luca.weiss@fairphone.com, jbx6244@gmail.com,
 peng.fan@nxp.com, ycliang@andestech.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, quentin.schulz@cherry.de,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 2/5] mach-snapdragon: Add hardware detection helper
Date: Wed, 29 Jul 2026 00:43:58 +0530
Message-Id: <20260728191401.849143-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728191401.849143-1-aswin.murugan@oss.qualcomm.com>
References: <20260728191401.849143-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: H2E9MfQ8hiNj4wPeQ3fcvVjziuCd_ZLx
X-Authority-Analysis: v=2.4 cv=fufsol4f c=1 sm=1 tr=0 ts=6a68ff96 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=c7FPpqzS4i-k0sXx9q4A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: H2E9MfQ8hiNj4wPeQ3fcvVjziuCd_ZLx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE2NiBTYWx0ZWRfX3Mm49PXKPyaq
 ezuIRsE1Lqa1PD3bf8jtOtS5HXziSRBwtblLr0p4J4OlyiBgWC9xiylvuSgqHXqylBB05jkMdn3
 2UyVgcjvI2lzcy1TaGqJ/2149JG9oLk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE2NiBTYWx0ZWRfX3al/wldKGKfM
 SDK3FmL9Q+L70Tdpd8suZf6cXiaSyM4BRKi2Cst308o2SHAgjMEuWzIr9d1pkMvgnblztFL/VXZ
 F9Gm6pzUNhqUMFcAuaFpxT0wCf1KbpkXhLuqIh5w6AhBDMjWOmsExbNWkK5e8dat8kL/4dCBcAx
 dOcIObAEAMOJYqAQ5KiyP88jcLkNkl2TWXSBmYzdJJWzJTtj5eIwsYZEHPbdy6i5WDrRV2VU0Vg
 ceRFdCU9rXatZq5j5sSQCtUqbJtx/vBsuoVMB8dOjXHNUygc4rJXIi4uNL2xovN88PDYB+pshJj
 MJyRvNVXW8U23+c6o1gT7gZ3c1eKZXeG+Rvx34bEezRS7VU0Cf89jS3vG1ku1RUSQQUS2++l6bL
 3sUaL+LLMpeYEodH7b3AbYpoc1aIwXZqsij2/69n5wo4xL2Jkxlk45HzZ3NDeHMBRQxgsuWQQmA
 FC+pCDV92LlPknsA5Dg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280166
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=B8M/NGupg5L
 LnJCh/2UohvTN/rx5+hl13+YBouK1p1E=; b=QjgOEtj/XBMRe3hACPVzgSkZG5T
 KdcxWVtHOndjSr/qlsZIM9w8Y0/H3Wn9DWY7ZcveFm6PXEg8kenVu6zJ2l1vbRhH
 LUYZr9V+lShLaqpqWqunBogCR6qdwKAWv0if7+O8oCsmMqgC273hgOwK4M+IZbnU
 bkDYQAayl9WLXTW/27+8AJt+QQUdwERwqzJXsO7dZq10F1pj+SQX1umPM9lWwDd6
 3OA9FErA5bCLS365cjw7UA/d4XBRrDWmUIehYPVAaiXGg1ob/Q+sMlMEsY3f77s3
 aJN/dmNAHc8g76gNcWTVxUnQhuRmJPSB4YUOYTjyid/yh5SL2IKC9HFtvIQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785266070; x=1785870870; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=B8M/NGupg5LLnJCh/2UohvTN/rx5+hl13+YBouK1p1E=;
 b=HGOjrdJ/pq0GWTSQYHiIck+fSiAQcscYZjgU9NM++FVFqCY3Iv/+71oa3+gqhgk+I0
 jY2zgcyyqZf5jG6xJxzqvSCdzopIL0aS2qn0FsonENBdXhYP7fjT16I+BevfiRor81MB
 ++nfp/w1hlR2aNPH53G6Xa4QZH2qm3XVYwYHuqmTyn4uHjtUeIWB8orYtFStqI2K7GNT
 FvYDWZ8WloJByFcGSDja3tJM9vjD85VfJHalkiPtsTyenZT0kGniqSBPHxn6j0KrPNrk
 LdpZTIqqM40CfdgRgUAm7FiI2j9TnkzzZwPA3tkLehNCvnoE6+2LaaskmR9lIAp4NVHl
 7Ndg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org; spf=fail
 smtp.mailfrom=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=QjgOEtj/; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=HGOjrdJ/
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=aswin.murugan@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QjgOEtj/";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="HGOjrdJ/"; 
 dkim-atps=neutral
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
From: Aswin Murugan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add qcom_hwdetect, a helper that aggregates hardware parameters
(chip ID, chip version, board version, platform, subtype, OEM
variant, foundry ID, DDR size type, storage type) from SMEM, TCSR,
and IMEM into a single struct qcom_hw_params. This is intended for
consumption by FIT multi-DTB selection and other subsystems that
need a unified view of hardware identification data.

Depends on the qcom,hwinfo driver for IMEM/TCSR register access.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Kconfig         |   8 ++
 arch/arm/mach-snapdragon/Makefile        |   1 +
 arch/arm/mach-snapdragon/qcom_hwdetect.c | 167 +++++++++++++++++++++++
 arch/arm/mach-snapdragon/qcom_hwdetect.h |  52 +++++++
 4 files changed, 228 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/qcom_hwdetect.c
 create mode 100644 arch/arm/mach-snapdragon/qcom_hwdetect.h

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index ddded0029ef..5911e76dc1e 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -59,6 +59,14 @@ config QCOM_GENERATE_MBN
 	  New platforms can be added to tools/qcom/mkmbn/mkmbn.py if they aren't already
 	  supported.
 
+config QCOM_HWDETECT
+	bool "Qualcomm Hardware Detection"
+	depends on QCOM_SMEM
+	select QCOM_HWINFO
+	help
+	  Hardware parameter detection from SMEM and TCSR for
+	  DTB selection and other platform subsystems.
+
 choice
 	prompt "Qualcomm boot0.h workaround"
 	optional
diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 2360b7c658e..6132847d7f4 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -10,6 +10,7 @@ obj-y += board_spl.o
 else
 obj-y += board.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
+obj-$(CONFIG_QCOM_HWDETECT) += qcom_hwdetect.o
 endif
 
 obj-$(CONFIG_OF_LIVE) += of_fixup.o
diff --git a/arch/arm/mach-snapdragon/qcom_hwdetect.c b/arch/arm/mach-snapdragon/qcom_hwdetect.c
new file mode 100644
index 00000000000..a3a3a26556d
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qcom_hwdetect.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm Hardware Detection
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Detects hardware parameters from SMEM, TCSR registers, and IMEM
+ * for use by DTB selection and other subsystems.
+ */
+
+#include <dm.h>
+#include <log.h>
+#include <qcom_hwinfo.h>
+#include <asm/global_data.h>
+#include <dm/uclass.h>
+#include <linux/errno.h>
+#include <linux/sizes.h>
+#include <soc/qcom/smem.h>
+#include <soc/qcom/socinfo.h>
+
+#include "qcom_hwdetect.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* TCSR SOC HW Version register field masks */
+#define TCSR_MAJOR_VERSION_MASK    0x0000ff00
+#define TCSR_MAJOR_VERSION_SHIFT   8
+#define TCSR_MINOR_VERSION_MASK    0x000000ff
+#define TCSR_MINOR_VERSION_SHIFT   0
+
+/* DDR type enum */
+enum ddr_type {
+	DDRTYPE_256MB = 1,
+	DDRTYPE_512MB,
+	DDRTYPE_1024MB,
+	DDRTYPE_2048MB,
+	DDRTYPE_3072MB,
+	DDRTYPE_4096MB,
+	DDRTYPE_128MB,
+};
+
+/**
+ * qcom_get_hwinfo_dev() - Look up the qcom,hwinfo device
+ * @devp: Returns the qcom_hwinfo udevice
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int qcom_get_hwinfo_dev(struct udevice **devp)
+{
+	int ret;
+
+	ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(qcom_hwinfo),
+					  devp);
+	if (ret)
+		log_warning("qcom,hwinfo device not found/probed: %d\n", ret);
+
+	return ret;
+}
+
+/**
+ * qcom_get_ddr_size_type() - Get DDR size type from gd->ram_size
+ * @ddr_type: Pointer to store DDR type
+ *
+ * Uses gd->ram_size which is calculated by dram.c from SMEM/FDT
+ * during early boot. Avoids redundant SMEM re-parsing.
+ *
+ * Return: 0 on success
+ */
+static int qcom_get_ddr_size_type(u32 *ddr_type)
+{
+	u64 total_ddr_size = gd->ram_size;
+
+	log_debug("Total DDR Size: 0x%llx (%llu MB)\n",
+		  total_ddr_size, total_ddr_size / SZ_1M);
+
+	*ddr_type = 0;
+	if (total_ddr_size <= SZ_128M)
+		*ddr_type = DDRTYPE_128MB;
+	else if (total_ddr_size <= SZ_256M)
+		*ddr_type = DDRTYPE_256MB;
+	else if (total_ddr_size <= SZ_512M)
+		*ddr_type = DDRTYPE_512MB;
+	else if (total_ddr_size <= SZ_1G)
+		*ddr_type = DDRTYPE_1024MB;
+	else if (total_ddr_size <= SZ_2G)
+		*ddr_type = DDRTYPE_2048MB;
+	else if (total_ddr_size <= (SZ_2G + SZ_1G))
+		*ddr_type = DDRTYPE_3072MB;
+	else if (total_ddr_size <= SZ_4G)
+		*ddr_type = DDRTYPE_4096MB;
+
+	log_debug("DDR Type: %u\n", *ddr_type);
+
+	return 0;
+}
+
+int qcom_hwdetect_get_params(struct qcom_hw_params *params)
+{
+	struct udevice *hwinfo;
+	struct socinfo *soc_info;
+	size_t size;
+	int ret;
+	u32 raw_version, reg_val, major, minor;
+
+	if (!params)
+		return -EINVAL;
+
+	memset(params, 0, sizeof(*params));
+
+	ret = qcom_get_hwinfo_dev(&hwinfo);
+	if (ret) {
+		log_err("qcom,hwinfo device not available\n");
+		return ret;
+	}
+
+	soc_info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, &size);
+	if (IS_ERR_OR_NULL(soc_info)) {
+		log_err("Failed to get SOC info from SMEM\n");
+		return -ENODEV;
+	}
+
+	params->chip_id = le32_to_cpu(soc_info->id) & 0xffff;
+
+	raw_version = le32_to_cpu(soc_info->plat_ver);
+	params->board_version = (SOCINFO_MAJOR(raw_version) << 4) | SOCINFO_MINOR(raw_version);
+
+	ret = qcom_hwinfo_get_tcsr_hw_version(hwinfo, &reg_val);
+	if (ret) {
+		log_err("Failed to read TCSR HW version via qcom,hwinfo: %d\n", ret);
+		return ret;
+	}
+	major = (reg_val & TCSR_MAJOR_VERSION_MASK) >> TCSR_MAJOR_VERSION_SHIFT;
+	minor = (reg_val & TCSR_MINOR_VERSION_MASK) >> TCSR_MINOR_VERSION_SHIFT;
+	params->chip_version = (major << 4) | minor;
+
+	params->platform = le32_to_cpu(soc_info->hw_plat);
+	params->subtype = le32_to_cpu(soc_info->hw_plat_subtype);
+
+	if (le32_to_cpu(soc_info->fmt) >= 17)
+		params->oem_variant_id = le32_to_cpu(soc_info->oem_variant);
+
+	if (le32_to_cpu(soc_info->fmt) >= 9)
+		params->foundry_id = le32_to_cpu(soc_info->foundry_id);
+
+	ret = qcom_get_ddr_size_type(&params->ddr_size_type);
+	if (ret)
+		log_warning("Failed to get DDR size, defaulting to 0\n");
+
+	ret = qcom_hwinfo_get_storage_type(hwinfo, &params->storage_type);
+	if (ret) {
+		log_warning("Failed to detect storage type via qcom,hwinfo, defaulting to UFS\n");
+		params->storage_type = QCOM_HWINFO_STORAGE_UFS;
+	}
+
+	log_debug("Hardware Parameters:\n");
+	log_debug("  Chip ID: 0x%x\n", params->chip_id);
+	log_debug("  Chip Version: 0x%x\n", params->chip_version);
+	log_debug("  Board Version: 0x%x\n", params->board_version);
+	log_debug("  Platform: 0x%x\n", params->platform);
+	log_debug("  Subtype: 0x%x\n", params->subtype);
+	log_debug("  OEM Variant ID: 0x%x\n", params->oem_variant_id);
+	log_debug("  DDR Size Type: %u\n", params->ddr_size_type);
+	log_debug("  Storage Type: %u\n", params->storage_type);
+	log_debug("  Foundry ID: 0x%x\n", params->foundry_id);
+
+	return 0;
+}
diff --git a/arch/arm/mach-snapdragon/qcom_hwdetect.h b/arch/arm/mach-snapdragon/qcom_hwdetect.h
new file mode 100644
index 00000000000..cb75f565756
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qcom_hwdetect.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Qualcomm Hardware Detection
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QCOM_HWDETECT_H__
+#define __QCOM_HWDETECT_H__
+
+#include <linux/types.h>
+
+/**
+ * struct qcom_hw_params - Hardware parameters
+ * @chip_id: SoC chip ID
+ * @chip_version: SoC version from TCSR
+ * @platform: Hardware platform ID
+ * @board_version: Board version
+ * @subtype: Hardware platform subtype
+ * @oem_variant_id: OEM variant ID
+ * @foundry_id: Foundry ID
+ * @softsku_id: Software SKU ID
+ * @ddr_size_type: DDR size type (0-7)
+ * @storage_type: Storage type (UFS/EMMC/NAND)
+ *
+ * Contains all hardware parameters detected from SMEM, TCSR, and IMEM.
+ */
+struct qcom_hw_params {
+	u32 chip_id;
+	u32 chip_version;
+	u32 platform;
+	u32 board_version;
+	u32 subtype;
+	u32 oem_variant_id;
+	u32 foundry_id;
+	u32 softsku_id;
+	u32 ddr_size_type;
+	u32 storage_type;
+};
+
+/**
+ * qcom_hwdetect_get_params() - Get hardware parameters
+ * @params: Pointer to store hardware parameters
+ *
+ * Detects all hardware parameters from SMEM, TCSR, and IMEM.
+ * Returns a complete structure ready for use by any subsystem.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qcom_hwdetect_get_params(struct qcom_hw_params *params);
+
+#endif /* __QCOM_HWDETECT_H__ */
-- 
2.34.1

