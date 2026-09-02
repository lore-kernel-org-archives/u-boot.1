Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2017C624D4
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 17:08:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D216410B7;
	Wed,  2 Sep 2026 17:08:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 42cltXD2jGdL; Wed,  2 Sep 2026 17:08:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788368886;
	bh=ebwvCSsiSDwpcW9tICzgxP/4GGReud5Wv52qb5cX0jk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n+N0cyRPMyt8ENBeV1ZS3kojREZSAeNVVxUkf2sCb/0tpxpb+h0rcYNNWFNoCeGCU
	 vucI9Ce75cgFKgiKP4Bgey5fpFdFI6ZP/YZZW78P4WgLty7j2Am0Jfu1Tb19K9ujPV
	 1eWGMmWKMOnXyCT2wwZxQ6DoGzAr7G+zuFprkLs7BQNtAqmOha6NNsKE9pP2FWtyit
	 3tuqAluD5JAmP3B2qdkJJI1xHXTWA26N+6seOGEc4r3M5NCfaPYqztGSqkM6ZRFI9R
	 owzhO3xSuf7Oqj2tQnKbFDNY+1isEAEzNZfIi+j+5Ua14HpayDacMkCF49ELk7l0Xa
	 Ui1J9JA6ynEWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFE3640305;
	Wed,  2 Sep 2026 17:08:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D7D79498
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:08:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D563440725
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:08:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kxwtXB3wfD7S for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 17:08:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Gu7R8ou5; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aPheiZEr
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E649140730
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:06:26 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682GfZr02113867
 for <u-boot@lists.u-boot-project.org>; Wed, 2 Sep 2026 17:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ebwvCSsiSDw
 pcW9tICzgxP/4GGReud5Wv52qb5cX0jk=; b=Gu7R8ou5m/If0vOZ/G2+90RDeeP
 0o68O9GLmK1waQ7z14OeoOKMs38OpTp3y/XjCIGEy9Ut8YKNgc9IRLZ3BvVCCxl5
 XkPqgrVHqsG8KNToztfIU1Ip/+3sp6Mx6m2/vsve+fStv2oy1ZsGANdgYhGtCLtm
 aOH4egLvywyGhFyW+vPB5ImVq3eGqINuMlrbiOn1qkE396ZG9M5sPZSPTTpKeiFz
 WcCDgI9URc0RUQ4mDir9BOulDh+w3btJ0ESa2o/698+9rcrAqQwZkCVLYxIjJQ/k
 ydHB9Lg171T4WVRE+0o50nWJLZFDU/mJGeWCM6DjxxE2RCSxcRMILTTtvRg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gej2c9kas-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 17:06:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38f283baf1fso1887447a91.3
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 10:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788368784; x=1788973584;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ebwvCSsiSDwpcW9tICzgxP/4GGReud5Wv52qb5cX0jk=;
 b=aPheiZErd8qAMlo2xdmiVqPkNoiKLACQOJJD+ssS6uekD1KOUYRJSyQN+Rwng576Dl
 ahdWLHGCnE8RcpPlW5At61a0E3JL7Z5WVQ6DQKTR0rhcYcLDcBWakyvlMpE0zvxKlJAK
 XOQbVGJGXibRQ2NNTS3ZF3OuiPn1MULrh6fPyCaFjPs96vVlzTvFX+1tPg06Ls0f/fs1
 Hnq/K2qe9uv2tbl606ruW5TLLjYJMd7uf0S5dV1YAheJzAtkmARLTGPKPnISniB2235N
 cca5Xj/jIt7+NV4pJeS3+1422ou1Dvm4/f5ScgQtLufNjzqoVtAkyYeS4n9H0ft2CCos
 YiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788368784; x=1788973584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ebwvCSsiSDwpcW9tICzgxP/4GGReud5Wv52qb5cX0jk=;
 b=cRklBg694XbQbIGTuttY5Eo0i86ZJ60EIgv/ZUj8FkZ7+4z/fGLzSHywlWBm1hRxjX
 iZkYR5abuNFhekGow55Paowklq1VhPxqy07Hd6rCFPYjXuX3EikUtBANLVURuR0jkzyd
 mxI2VOg+u2zybYGwP6qgQ2UN6LDnbKN9ih4IrIF+w5Fb0L9fwdw11v7R0POIO38McOKX
 +BbOw3EQiQeBpemdrBTLB0nH4I91f/KzZXiSKOeka+Y1/0MM2qquOTC1/sBjZJUOekQ+
 yIjrZK/F5Lxa2y+1BrJdv1j7h+LzVyGhxFm9+ROitpnswSrTnl506B23YLnhc4Cq2t7/
 y2Ig==
X-Forwarded-Encrypted: i=1;
 AKwUvBzV7SgTTF/Q7xLgKhXCp/gQ4s2BWn7eRnEh/ORrHq7f0CwLnb56fSEH3UipWyQQDGsXoA6ytzI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mHlOWSJ7Ms3x66eCQtnJ/a2YJQqfHjVWyvb7RIsMgnrPoh7WJA
 J1ctGaR8IkQeBlqu7rTMUJHYJrS7iKAwjjolF3qNbP4Ocv/TMuaiv1iC+2rkXMuYTPzaRhcOOvA
 QG2cuY0eYQpg1DeKD9Tl1OtF+2YXTa9yiGEDU+D4OXg4hK4VZurf/9YdT2yJvaHWjFyaZ9Ug=
X-Gm-Gg: AYBFou3uSRU6aSCxKJ7qrSccyW56oHjikhLpnR2I2qF6DeajTBG5taFWK7dw8NNUawj
 myYbrMuUSzFSN+8P/bDILTvz0VQ7iO3sE950ndwNtfJZhLtPwbF9IlgQx7gGlmalMST3ZTH4Awc
 oobHCrsZO4nraGFIJx/d05IeJ4OOfOpfmFRPKGiRV1rFxY+pn8qhJPgQQdieiUKclmpGJeYTMlP
 //oiJOW1PLtAhoFzJE15UM96drIKPFNTKNcF3R13AJ1PomDdjEboDKAf+D5KHFQHiAO3ibkdXbo
 A0obDpHlNu/6u11CxraFgnAS1icgcsRd8I/jv64ZWYm5WD1Fj94xCF0MgPlt0bQpBUGKwv4iWgo
 Xou0Akdj0xBY7/7gSPnhSm3h1rPE/oXq9P/CH3e9f4m1+oMvmoNmfKsVB7dwAjA9Jzi5tIiEKe4
 4Is4zqitLBHpvFeBEvKQw=
X-Received: by 2002:a17:90b:3f84:b0:381:25ce:bcc2 with SMTP id
 98e67ed59e1d1-39aedf1922dmr9564595a91.6.1788368784481; 
 Wed, 02 Sep 2026 10:06:24 -0700 (PDT)
X-Received: by 2002:a17:90b:3f84:b0:381:25ce:bcc2 with SMTP id
 98e67ed59e1d1-39aedf1922dmr9564476a91.6.1788368783895; 
 Wed, 02 Sep 2026 10:06:23 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f07bde5bfsm8105688eec.27.2026.09.02.10.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 10:06:23 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, aswin.murugan@oss.qualcomm.com,
 nathbappai@gmail.com, varadarajan.narayanan@oss.qualcomm.com,
 quentin.schulz@cherry.de, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 3/3] configs: qcom: enable CONFIG_MMC_HS400_SUPPORT
Date: Wed,  2 Sep 2026 22:35:59 +0530
Message-Id: <20260902170559.3225833-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902170559.3225833-1-aswin.murugan@oss.qualcomm.com>
References: <20260902170559.3225833-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1MCBTYWx0ZWRfX32aoafVde8HI
 Np4SKCSEVD+eOL7w39IjE5EGWsdHyscrm9qHkTnFTt+SHWZ594XKaD55vc4QMjQGeOmcQ3cYKcs
 nXyLt1AQHnQyRReI8yDzanlFMY3Nv5M=
X-Authority-Analysis: v=2.4 cv=G+ss1dk5 c=1 sm=1 tr=0 ts=6a985791 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=MqZgG2OwNoKaIsHWUFQA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: oWAotA_UCJi_kF76z77DNchafKvb3G95
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1MCBTYWx0ZWRfX2xfLGn7ssBMa
 A1r9Ig0m/QTfYS0cQV3RYeVZHTcMW+TJ5B0sEwJY13L12uiEhPi4sC9Su0tzYB0gn00gu56WDbq
 9d2TvYOxIEEH9aF9OxkBqaH8X5I5IpMvJfXv2NM+7KbAL498sg/Gu1jhXiTPRSK+fvp2b8pjfXA
 Xmd5dbIOAq78imK3rBlyZs7Ced9++wI8FOo2JDOYBqQ0eSr9oCbYQpvGeErbdDq/mZ20pex9PCN
 vOt/mFCsWXJtRrtHLIpeH0FRrXMv7qec8GuvtskUS9qDH73EX3ujMhc/2A+683SaSWylsVuhyYh
 gyI7rY+cy5yUwZdkK0xhKVwC+ezr+uHoDyNBVzLgSAL5pG3Oc+aJAnfBNBuyF5phL+2mmnheOIx
 y01q+88RauZxRmVZcqr1P3Wunn2JyYAJCLwfMyiOAagv0UDKvYYDnZ8TVfrwvRsBJWcbtoQpcrI
 +cXELSgCWAePBt7YXxQ==
X-Proofpoint-ORIG-GUID: oWAotA_UCJi_kF76z77DNchafKvb3G95
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020150
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

