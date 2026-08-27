Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECF5C61DC2
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 07:34:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BDE4406B3;
	Thu, 27 Aug 2026 07:34:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0BCqJG7S8ITb; Thu, 27 Aug 2026 07:34:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787816045;
	bh=ebwvCSsiSDwpcW9tICzgxP/4GGReud5Wv52qb5cX0jk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zJMhDjngPg+KlB023aolurXktkkSuScDYEUYvm3t2q4lD1cESP/tXy7wnNyXqMM/M
	 TKVWooKYqssazehyfRKqXcuIgMptbn4X2No6xne7P7FfC8ZshYzJTdqKqzX06Q1Ahu
	 5Q5ZFpPOjG2gwbPSy0fr4Ea/zkiJ6a0PH+Qs6IfpDPuOxJ8Fv7yyXR+tPqUz+xSPci
	 pIx2UZj7fh174Iy4AxL3Q6ypb6POHEl2wRv0l93mIjV40jkTx99WxpsGuaJX6HsxLJ
	 t/KF7zYyx8Llyy8mbHPgJBFezglVLbe5L6sQmsSIAph9nXerBMMTeUezqCnXHMJodg
	 oOwPNnpzLr0UA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 023AF406AB;
	Thu, 27 Aug 2026 07:34:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 67C5D334
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:34:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4864F4009C
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:34:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Akz49zIB6bAI for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 07:34:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ZQpVgWlw; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LfnXTXLq
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 64B9B4025F
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:34:00 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6R75V3257818
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ebwvCSsiSDw
 pcW9tICzgxP/4GGReud5Wv52qb5cX0jk=; b=ZQpVgWlwimCCtxMns6sIm7u/V8Q
 uHsPsO24XS6Vj8BiG4pyU6YqzcgoiamT4T4jomIU9VMt/Cq48sVW7jp+SCTnDc1l
 b69bjra3Gezu/OvESxM41g31Xeuenqt5IKQiT92k+3nNWAwf32Av2i695V9cKsYN
 QMHk+xmTVC4ppXCCcBgzEOKPiWa3paDeJhOdrpuxvISzILnzo55Jh8SRdS5KiJk6
 aApNepz6dlvaQ2ReoX/lXUcG1t/nysEl2vrFDe9OqgZlWh7bQzbGtRWFzBOFBFn6
 vB89fnwrYNxrSR+jwakFkuKJ+KgdLk1pZegSnvJFEGMfrzkOdmqfUgMXq7w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4ecajpn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:34:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38f5ac7416eso2934639a91.3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 00:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787816039; x=1788420839;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ebwvCSsiSDwpcW9tICzgxP/4GGReud5Wv52qb5cX0jk=;
 b=LfnXTXLqQgpx0rlQWARcIYPP7niudoM4xSA411lFXgC6Cdgz/Zjs3VCV6KUR774R1G
 KZCD+vJX/Q4sKb/hoBd9ESND3Ms0QheaN8jRGNGGFmMuSixgT5tj0K2d8xe1nCh02Ez1
 GPSEWEIXOKMpp86DRm21/dKZwiTRvFmEAeyjrLUC5ozwhNAi57WOmM/a0qbW2pPbJkmo
 OjpsaJGbA4CnbDKDaaaQVDLTU6Ew1cMKF+7/khg9FYuf1kPGdM076WZHXM+OFmOERIzE
 cIqefinet8xD9kmPfrldJFKZocU7iS7+jW3ElSDxn+cVJdnhBM9Zj+GnUvc8EU15Q7P0
 tgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787816039; x=1788420839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ebwvCSsiSDwpcW9tICzgxP/4GGReud5Wv52qb5cX0jk=;
 b=Jlz6YP2Fa/0+xEWHrml2OzTvKH6P1O/qXLwoovTBMG9z6qEVhSi6m90hL0alQC9nZz
 PGQQFU9PRRhwdZONb1l6ak+FI29SjRkMv13uXr+pNNOXGL3wnrghHzdhnl2rxKplvZSW
 utUksFt8GMqaveVhmsh6yyNMVBaZFtA1Je/Io0mFow4nZcbzhlpQGFR6j2WiJnPSY8Fp
 auN0K6UF3T0NvaAmmQTUimKtu4Z5NbbXN/JsHqN04++k/TcbLQJgv2C1z2ohVFUZw21y
 QjYwHRNs4aZKg8F4bgAhWGuyHdOove7tLcmvLWZJVWUyFx4uRplljppK8eQ5muOX4Lfi
 yIfg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqosHeZmL39S4tp+QxwMEuxaUiBhgt9sGlAohfDJ5If3WlK+JxrMvMIZUsvEXAuqi1XBiPu0Jg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++niJxQUmma8DZJOZQAYkyiOtrfTd55ua4NaztKa/7s0FuUC0e5F
 b+LuK9furD5KB6+5aLgJGooqVYnCYoteh+tfGgRKGxyMkmdxOFp2QOk72zhPWQKGvEmi4ECWrgu
 xUq6nh9t99ZT00A+sswhNdmdv02h+VlQLIb5nz19aXGl5ecpKdCb8xGxyJcoPV/kGB39vtUg=
X-Gm-Gg: AR+sD12SeQoRMJ6MXv/xowqrmIGyax88xnzS0grKgz6gGFsh5lQvEbPwDxLeFDl9E7f
 +6oXjuOYDMGrEYHm024gSXnaHNoufBUgzEhWyzP/MKcG+bohM+JOeE4YepzpBJ6fyxqAoT3hHRm
 gm7rpaQw5ONhqOO+tstzfxeMNCwNUCYsFCy2WaqrLM/fE6znqRmC7zWn14b6zmbcXQQvwf3VVci
 jSbyQf5gbtILeCDd8Z7dTdgkygsVgjO2JSvUbVQTyfJZ/+TDwkVhq8uhqOmDPTrz/Ovtn5sNnop
 uk7KU6WjE70s9l5oIpcr4X5fQXAaPBs937QMBtHvUxCF/ZE4qwgPTdrTgtoShG7JI2ymmMJM5Ls
 qwo89IxBMpPE3n5hIbTugmDydws747nvl32rluj0wOPoD55RVeQCGBnv8ETayvYE1649DlYs8Jj
 LKrALox9HKveWr7m4J5O4=
X-Received: by 2002:a17:90a:d60f:b0:392:6638:2e6a with SMTP id
 98e67ed59e1d1-3966d44aa98mr28251400a91.13.1787816039452; 
 Thu, 27 Aug 2026 00:33:59 -0700 (PDT)
X-Received: by 2002:a17:90a:d60f:b0:392:6638:2e6a with SMTP id
 98e67ed59e1d1-3966d44aa98mr28251285a91.13.1787816038966; 
 Thu, 27 Aug 2026 00:33:58 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d8dc465sm15146713eec.24.2026.08.27.00.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 00:33:58 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, aswin.murugan@oss.qualcomm.com,
 nathbappai@gmail.com, quentin.schulz@cherry.de,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1 3/3] configs: qcom: enable CONFIG_MMC_HS400_SUPPORT
Date: Thu, 27 Aug 2026 13:03:25 +0530
Message-Id: <20260827073325.4113071-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827073325.4113071-1-aswin.murugan@oss.qualcomm.com>
References: <20260827073325.4113071-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KIBqylFo c=1 sm=1 tr=0 ts=6a8fe868 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=MqZgG2OwNoKaIsHWUFQA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: jtJRpMD8L8oIEpTHMUJA2BRP-1qk9zxV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfX6Th79R7euWJu
 EFe+vNLnzdMBhfqbX8tKRB/XL2o8zX+8wT4Yj6t+lksnyagyHXbRS10RJs8AyfjCkFjs417FJgi
 hSFzS/xGs6t11rFgdQirYDqtTH5SsuMm4qgg0pfQ6gAksbrz6W1KP+mG3FtIYr+jEL8zM+XbWSN
 nwE0wP6M8y7l4WrN8oRGxUodUNW8c82SuhiT34o9SacrSY9GE/+IBZ+VLqNPRrieriR+oM5Oh8y
 1d6W1/pScN6/YTZ8CQ6jdyFg+mlJd+Tn7G5px/AaRXbr6J6T9fFhsNiQkTr/wrA3FVxaEB9CuAM
 3BqCUSayYfNSWNrhkh5Fu3PnsJy+um7nOWA1nnz1F1d50ZrEbxid6I8oBwdPdnL01vfRX55v3Wo
 huH0YyANZ82QQlqG5TUeofYt2wc9gdnHgtzhmyV8c16cyIitM2IrwbSy3OavOo2LJwcA4jwoIJ2
 uHjXoQ+TBWW93AIgq5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfXwaCwq1bsTwRZ
 qSSbRehjkFgZTU3LHRrBfxHth87qk1RLaFFLbj8d0mNenJiMrR207mGfmlRPUIKgc0T5ZpGkIuQ
 Izhgm3+OCBrinUmWLh3UHVeyI6ZYeRA=
X-Proofpoint-GUID: jtJRpMD8L8oIEpTHMUJA2BRP-1qk9zxV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270061
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

Enable CONFIG_MMC_HS400_SUPPORT in qcom_defconfig to support
HS400 tuning and DLL calibration.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index c52f619850d..15a83c6ce9b 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -100,6 +100,7 @@ CONFIG_MISC=y
 CONFIG_NVMEM=y
 CONFIG_QCOM_GENI=y
 CONFIG_I2C_EEPROM=y
+CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_MSM=y
-- 
2.34.1

