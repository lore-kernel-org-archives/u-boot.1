Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0AEC55ABA
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 02:21:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 695B080E66;
	Thu,  6 Aug 2026 02:21:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tIm_d6KF6CIj; Thu,  6 Aug 2026 02:21:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 80D8480E77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785982900;
	bh=BscyhOutBSzD0F2Q53LkfRflWIRsk8HpcYOAC+36laY=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=RSb/INTk5z/dEY9jcqtBkMX6mX6J1ELel6xih68S5koSgk+B7tXJE6aj/4rfrC4VD
	 UBCe/bZdH2OGy5QNTbE0cIoEdYUq0lLc/bkUMMj7Pr0iItVCcuVjqi8E29lUpSJR7i
	 /qsQzdxA7NchlNcv3EqMVDeN4/LB7kxJJZ8G66e9rHcWbTBBjHWTrb1pteKcc8fR+j
	 HQGn9kPOBkLOv6hSuRu+oxIbw89q0ltsLWHQjNWn42AU3YAtpHJqw9zpZag7EhnDf7
	 2s1LoltLRepz+9ROHoJMr2xI0Y5AlY0Qjd0Mm5/TQNEKH8hzhVCRbYPES0ExUWE/VC
	 rmW8aLt07c+tQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80D8480E77;
	Thu,  6 Aug 2026 02:21:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A620E144
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 02:21:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 980004053C
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 02:21:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fucZYDKGLCKT for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 02:21:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8C216407CA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C216407CA
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C216407CA
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 02:21:38 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675NbXIx207345
 for <u-boot@lists.u-boot-project.org>; Thu, 6 Aug 2026 02:21:37 GMT
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv2c0c37f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 02:21:37 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so1242498a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 19:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785982896; x=1786587696;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BscyhOutBSzD0F2Q53LkfRflWIRsk8HpcYOAC+36laY=;
 b=NtG7NsG6QIP2r9U3kBNlaOfCr5WmFYYkJmWWvif85dRzUT8dn9mxs3LaiRORl4K6dQ
 zrpY9PdpSYAplxnJnwD+iaQ4XaCLvvN02f+velH0s3ZxfSl7yOdOswtvDrCxFA5P4o/N
 /o/e9I1BsKJAMnR+H7Kvh2wn2049vjPspn07R6JdKSabWNbLCmFch0Dvo2f/gTUKniZr
 Vhm3sjbBm15TfsMca6cZzw+or6I3/k6uPq3sjXhsFAfDyz9NHVeM2RUANfwn9o6zSChn
 OMeIfk1X9dCtobqPSOe7AI7GYgE04xp7PVi5gxaet62StmCX2phndnIRPrCIrOv7rFpE
 VGbg==
X-Forwarded-Encrypted: i=1;
 AHgh+RreVdyReaM34GbiPhVmtc7/32VxtDVfXn56QYV+if4TV4ln4cI2KYK/sHiwyxQDliDqA/bkF5Q=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyjwqYBUMX53NUmu1LeRnportUpr/U0UvSfWx9mfBP/5+gwpF3w
 fJ0aFiNSrtT1VF8SUJRbm01j/TxGcMtjeHCjbeORXygF+37/g8VviuNVinqmjKVTrpC14ZgxPEd
 /w3tMCKNycF87W3CYZ69O+/GwWHnSP4MH4ysQc2uNzoWyMzG+PTqDIfT2+g2Z6A84+gspyo4=
X-Gm-Gg: AR+sD11/GKvpAJCI2OvxSDuVEUJlriUThMLbFq92C0eJ4CRsM0G3BYB8voiunVxM+a0
 cwrJbTRxx+SO9o57aJFa95sIPLu2fg4CYAGqt06/MZ7jaUVuymgvb6prwmycGtMnJ4piWZtQFMt
 tUmXqU3YobWhu9kfFZpVNc+CnXXaMuMVGBD/T4CsBmYtBzJnvTiW4NGaJ92n2IukO+6pqHED/nu
 oxA4aSV/4QePxDXblIemkLNjPAZMr+U0/akI9SBAWMf+e4qYAB2zrlbZ7+cjOEvKZAUh5L6S+VF
 Z7KcSMw9rP86ST8XH9ogQgNRy589yUnQG/WHxj4v7kYG25+Mk9x7wOKvPbJ2Humfe7s6Jno7Yi2
 n9RvpSZh8Rny3KtwsR6aX/Yz8v/71ylYEn0sDPbZTPubx7Ju+/3zg90qM8dhZqh0HozuwG+WNu8
 l9tC1wQHoFf1PWJGC9bIk1+4w42cDdFA==
X-Received: by 2002:a05:6a21:1f89:b0:3ba:f5c7:6bc3 with SMTP id
 adf61e73a8af0-3cb85e9924emr13483975637.10.1785982896365; 
 Wed, 05 Aug 2026 19:21:36 -0700 (PDT)
X-Received: by 2002:a05:6a21:1f89:b0:3ba:f5c7:6bc3 with SMTP id
 adf61e73a8af0-3cb85e9924emr13483939637.10.1785982895966; 
 Wed, 05 Aug 2026 19:21:35 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158673be99sm36385067eec.15.2026.08.05.19.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 19:21:35 -0700 (PDT)
Date: Thu, 06 Aug 2026 07:51:07 +0530
Subject: [PATCH 4/5] configs: ipq9574: Enable fastboot support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-fastboot-v1-4-cab7d64e592b@oss.qualcomm.com>
References: <20260806-fastboot-v1-0-cab7d64e592b@oss.qualcomm.com>
In-Reply-To: <20260806-fastboot-v1-0-cab7d64e592b@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 David Lechner <dlechner@baylibre.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: GOi8iTg1CP1Clg8RzGPBObcrqvqdzmmV
X-Authority-Analysis: v=2.4 cv=aOfAb79m c=1 sm=1 tr=0 ts=6a73efb1 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=6zSr0Cm5jUOs9Rz06jIA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAxNiBTYWx0ZWRfX1AKhChUJgQMi
 Z1UO9yjDUH6FRi7IjXBkPvaP7CQmUovnr3uf8hyPqXFixDO4QhdE0ZB/rZ7Y1tb5iyvLJ3ktvd9
 1Mr+rG2TZ/7g5tC5fB2Zj/Hofls0fBM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAxNiBTYWx0ZWRfX1daIGpSOkrQl
 En//qGsoUnbt2OCfo1PVmzPYwUOtEpjVxKdHE9tVRDm6BhZl9g2ohxPMWL9ModLCOdtXcu8UJDa
 J8J2n2A/ZQjmNi0xGQHGUmUZDPo++VWUu8MFuWdIt5T9PWNulUoqgumcYj8xHykhsg0ycCsb34Y
 G2RRV64fXsRG7aIC9tf94cqyp5wSZobrRi/ZnjgFCtZuNenM4D/Yb0Ek/qmJgfWBfxB7+sC5qTg
 ZlIvXKhkqUiCsIXa5PwGLg9DSy2dEB9++jBukZvHg+OiPzpGofCfSVI77NO4fLqtdOYEhdRKFUk
 /OOC0ZZ54WgIBD0El2YpwiYHJeUgHu9gHUgbzrwnLlV0Ohl11V8I6Hbkgd1Zhp+aCdFvnGxYsUb
 fW2iuaCykGaAJXu2sNPuUMQfFqfUEtiIfS1qz3bXOnlDXgCnvhQ8AFaQbkh7EEUtVj12e/+T1Hd
 QODgU6JqB4cDoOlWrFg==
X-Proofpoint-GUID: GOi8iTg1CP1Clg8RzGPBObcrqvqdzmmV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060016
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BscyhOutBSzD0F2Q53LkfRflWIRsk8HpcYOAC+36laY=; b=FFJroWji3gvLze/a
 E6n5iplVVDapBKxrVcXbzlkgN0BLpWs2fVcvy2g1V3PhkNk5JZYHL92Xtz2rkRYc
 5AvUTHF5HZCaF1gACwsdKoiDRaEs3/zT5V8afHaViz5oPJuUQj/Rme9DBI+bdj8R
 wABZNcrgyk475Vvk72+TsbTkTSZ6uNrQ6xMY0+GNMirJyEPFCLiTxJtrTcgPygjH
 GFkhS7e4fmpaSUA+X7Cy80dZQpb/YBTawaet6wMywOqF9A42Ur6Yrs+Y22o+vJrb
 JsvmUR+AjP+hvTx9sewR9ZBEYGBZi7r9hQ9iWJnxpYyxuTBCSqM9xA6avW3QU9e8
 mG1g3A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785982896; x=1786587696;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BscyhOutBSzD0F2Q53LkfRflWIRsk8HpcYOAC+36laY=;
 b=XClzAPb1Y+UqkGoYF4ULtVY2BXN2u+/R1BsTxoEFVqzpM7/e32foxAfw04rJh3xy8J
 c4czKcJfJ6VbEDYRd2F7HTjwXQnfnO47JHjgooRJxe2dAU2ss2XXxKKiJTBqcgzGHeYW
 W7vtpIP/D3ti/Akxw4FgYPYSYgcWxqoAaSKNCG8HLt0mnHbawjXE+3/uzcamDa3giUIi
 aiRKj7OG1fY3ld72x0fU8qttXDAYfJ1/L5e4uSkld6AR8TYZXqygLa2eiKoLl6Xx6O6q
 4z7GNMnU4CIjSjGR2tHz1CcxnHBqSavzi71EzibaIVXjV68SwWhfEhOQtcI992xJmuz2
 9HdA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=FFJroWji; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XClzAPb1
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

Enable relevant configs like USB PHY, gadget, fastboot,
fastboot MMC support etc. to enable fastboot flashing
of IPQ9574 based boards.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 configs/qcom_ipq9574_mmc_defconfig | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
index d1da6bc82c8..a5def1b9a7c 100644
--- a/configs/qcom_ipq9574_mmc_defconfig
+++ b/configs/qcom_ipq9574_mmc_defconfig
@@ -44,7 +44,7 @@ CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_QCOM=y
 CONFIG_RGMII=y
 CONFIG_PHY=y
-CONFIG_PHY_QCOM_QMP_UFS=y
+CONFIG_PHY_QCOM_QMP_USB=y
 CONFIG_PHY_QCOM_QUSB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
@@ -53,3 +53,19 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
 CONFIG_SOC_QCOM=y
+CONFIG_USB=y
+CONFIG_USB_GADGET=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_CMD_USB=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GADGET=y
+CONFIG_MISC=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT=y
+CONFIG_CMD_FASTBOOT=y
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_BUF_ADDR=0x50000000
+CONFIG_FASTBOOT_BUF_SIZE=0x4000000

-- 
2.34.1

