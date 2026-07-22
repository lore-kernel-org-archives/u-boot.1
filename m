Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4151DC44533
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:42:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D41D40762;
	Wed, 22 Jul 2026 07:42:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X5kL1Y0GswXb; Wed, 22 Jul 2026 07:42:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 33827406E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784706150;
	bh=lmjMHwig10wIMRYigr/zdo82O/c8w22S2YeLQsuFO/c=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=N/hvIsnbJH1OwkLpp7bMZ5ueBawSE0w/M5D1LhmEB5Sij/GPY2NkWHSlsnbn9+sZ2
	 ZGWHDuGa2HECbmT8iDLfOF4fXrEm3Zhe7iS0CCftI2+jrGR4AM5+kTo7CNBeI3fNV2
	 MgejBq68mSqwnl4lrJ97Xbdmwfvi3oekVbLNQZcZNQj4ejso09T9PkHAyi+rBJqwGP
	 wWkCTqYTRi738d47VSujPg/BLyQaOgiL/VXDWQQZLLlDkWLpfriKrPnZv0w9SRIgw1
	 19/LzDXJgOpZHo2myiqRevq2l7rhmQ0APqI3KEuXYOauW5tDBTWRfVZdHJgUmrDE47
	 aaWUl+nKtM7jA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33827406E3;
	Wed, 22 Jul 2026 07:42:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CF7242A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 32C9960746
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xYi-Ns9AvySj for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:42:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1306760739
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1306760739
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1306760739
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:27 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53h9W3917571
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:26 GMT
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6aatj5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:26 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb6cf425e86so4704163a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 00:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706145; x=1785310945;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lmjMHwig10wIMRYigr/zdo82O/c8w22S2YeLQsuFO/c=;
 b=ApLYYVLPgTRj8m53d248bZIo8gXHKNYWK1ba0HVZ8VVfOxkc5uYNzB/eKfecZabjmB
 5MenAGqOVfZIGDLTCCdbH1PMB/NTgxZABIVtAw6daHM0v2IcxNTQSVA4UWIHFi3V2yUW
 NUu9xdL0B7viAr5/40oiYEjON9K+AVUPlvuQ0fH8WQu9S4WOH7wuSf8MPjizUK28kObU
 FLtcd0SjburHUZ/Pg+YuqJ6Isi0s8wRjkWh2kTAgQgq0srFZ9ghDjZmMRV9neb54qxEq
 Fsv8lU4gTn5IHUR7B/2Kdk+wuRAaT+47fw7uzhxfX2b2BiCVmUBKEkB78usnqPBkF7yE
 ARrQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKV9cBz/U28PVoM2Kx4y9fOF/MkfrHaxv2L8LHWLnW/Vd0cYXoAnpWYBKF2+1rpqqiGefjM80=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzvyKV5wiXVB2OxKQ1AzXd23fJ7kH0cGlH9rDSAnGd4nPuySMII
 QtxRk0Z/Vzpvy+2FLYWUxs3Z9l8tngLP1UjF/2bOFv0HnNZT1cC9QS3m8iStxX8TpRAYXaMefge
 hh4LGeD0QyK6LskyEZQ4bCpKwyqB4h6cfH17NaZ+f3VQSFi1e5d59CllDnyC/ZOg8E4wgP+c=
X-Gm-Gg: AR+sD10xpu+1UXwCehhQ6AJ1LJNr1aSMUwAnZ76T+ULETU94V8vd95/cTduoBCWLK//
 8avBuuSKZYt/Rrennwb0KUhItiIKbnM1D8q5P1Lfaek+P0UAGmuWYxo5Dh1dWpUfY9dhD/XnHmD
 mOsX6eeX0ugBmR3rwPU6LNkWStekAdD/UGyuUWGVQKn1CY8HSSaUjhmHqedVTBv+ATbJ2PdtRn/
 YcjreJO1t5jgBwNGT/4M6Pld9WHsCY6Cxze9PH0pm+Hjv7JFw041KUcPtgjH8t94ckipmNZTLKN
 9E+q5/1z/D9KGcuHd3WCOqLq9vocKR3AbWxhuWi1lR2z7bUtdKNoPVYqxmIVJ66zFQRtaHzjQCc
 DSci5JeGll37P/NG9lVsj1p1cVw0KHTkrwTGevb7LakVwqscdKu738N3PwrF3t+wqi4noMkzxdB
 2ZeP/5CfqXGhIpQM0I8mFC0xHoehyVaw==
X-Received: by 2002:a05:6a21:7111:b0:3c1:b9c:4890 with SMTP id
 adf61e73a8af0-3c3ad675d23mr24489799637.22.1784706145376; 
 Wed, 22 Jul 2026 00:42:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:7111:b0:3c1:b9c:4890 with SMTP id
 adf61e73a8af0-3c3ad675d23mr24489766637.22.1784706144938; 
 Wed, 22 Jul 2026 00:42:24 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df09ac0sm5572577eec.16.2026.07.22.00.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:42:24 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:11:17 +0530
Subject: [PATCH v8 06/15] mach-snapdragon: spl: Setup malloc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-spl-v8-v8-6-cbfa79e85a9d@oss.qualcomm.com>
References: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
In-Reply-To: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Johan Jonker <jbx6244@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Erikas Bitovtas <xerikasxx@gmail.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX9B5jcajfhymz
 +Kia5ht1ebwpH7YbjN7CuDK53B7ilQmvM4XeoFxOcbnEEKCRn28p/Y8XB/QZ8CnoStFdmyeI6H1
 YxfY5/t+I6xAXJ7kEO/1HWwAndQShwMSj/hLP42xgSY5t291mj8BJHPw7HY+T+jdH6tdYlTjIiZ
 1115OjZh1twNnVlJXw/F3YTzeOodv7evDY4JSqskUtGEqs3XlhJVJgSTCYXXuhNVC1LYsrFGmmU
 ELNh8bnQLDUqOndCPp8cibAIAhyhx8T5LsOSumc/5F8sMSZ/aOlTGtc4DhF/0zyZGuW8k6/y5+n
 qbbVvwYD2j5CQDR39CRaEy1J742nL2q6ph8nIH9U2fsTXOa6BzJdBL3uVdgPJXteqM1iHnxU4Cq
 xIFd+LlAEBPdFSeKJTTv4T7tuSaJIDa06eT9Z+c5dBo3pKsP52NfdXbuuY8XeI7SPTuF4w7JVbI
 rNpsi7j1Nc0COgiT+Iw==
X-Proofpoint-GUID: 1SxqqKyxRieLP-GS6VlZwp57xK9u4P4g
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfXyn9PA7SajJhh
 iSkhbTA8wXw1d4O9uASQ1WICYeW+yhLeMA+oqdd/FKezMQKlI8mK+uL5An5UEhrKDU6tE2PQbTe
 Km278pBZYP9P+0zY9aJYtTJfGg1rF0s=
X-Authority-Analysis: v=2.4 cv=HvJG3UTS c=1 sm=1 tr=0 ts=6a607462 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=NRvlHJIojRdL4rzYw_gA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 1SxqqKyxRieLP-GS6VlZwp57xK9u4P4g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lmjMHwig10wIMRYigr/zdo82O/c8w22S2YeLQsuFO/c=; b=A7psSmlMdE/WNuA/
 sWgaCShrEOHyrVpHM2LVCOzEXx7irRqNv2dQ78tLqOjDnbTKzBsiT9DCPT3cKg1v
 pM7EGEMGVveLjlC3Gx6em8HjHlpXHeR2QJKVfV1Bmguu7omxQpHHd40pVm8o1CC+
 T/ldF4AyDYUFgSi8lzgn65SZSWzpekNyJOmj/yC35gIFbpz9DegOi6gIcLv/8WpT
 l5kX8vgrBkbZN5sMhJ57jq0wRRWPS1BG8Q9Ez0Ds9wK139vZgApbnbblhqKyerpI
 Y6y8gZuRaotnq1zPebV9fR7ZLSNqrPFXwmRWe6I5I3EMHC0Qsg6NG661FfUFNvC9
 K20Biw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784706145; x=1785310945;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lmjMHwig10wIMRYigr/zdo82O/c8w22S2YeLQsuFO/c=;
 b=Z/E4T/fPZIaAUya5WRuiyBC1ChDSsRVQP3xZ1a7y+KZGbS2jDQBefcQkqS0HFSAQOb
 ciP9/+yOHR4tLW9b2wqb/7IZnxfrjaPpi6aaRIEfY1Jq2cB8pc6ZRYjBMOdAYG+dMdRs
 VHv+CSJnCjK3gVfNwBMatA/KmrtsXq2z0QeY46llD+mc3DTTGE0C/iomata7puwvNce5
 q5w+jAEZpUnufHdyCDzMkJa1tlorw2vgJ4tfV7WsdAMIxYhJiYN0TX7BHDYA0MbkqvK3
 xownhpK6ngCVPKzNfiTBDzFrrlP13Dp9R3/GtC9hIWyukeYe7cQoDgKmLNmQFGOqr3UK
 s3Zg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=A7psSmlM; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Z/E4T/fP
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
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Setup the malloc base and limit for the SPL to be able to use the memory
allocation APIs.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index c5e86458616..25b1779391a 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -238,3 +238,18 @@ unsigned long spl_mmc_get_uboot_raw_sector(struct mmc *mmc, ulong raw_sect)
 	return 0;
 }
 #endif /* CONFIG_IS_ENABLED(MMC) */
+
+void qcom_spl_malloc_init_f(void)
+{
+	if (!CONFIG_IS_ENABLED(SYS_MALLOC_F))
+		return;
+	/*
+	 * Set up by crt0.S
+	 */
+	assert(gd->malloc_base);
+	gd->malloc_limit = CONFIG_VAL(SYS_MALLOC_F_LEN);
+	gd->malloc_ptr = 0;
+
+	mem_malloc_init(gd->malloc_base, gd->malloc_limit);
+	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
+}

-- 
2.34.1

