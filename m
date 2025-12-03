Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784CAD1269D
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 11:08:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9280183F8E;
	Wed,  3 Dec 2025 12:08:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZSF77k6z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hXZgTAQd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2132283F95; Wed,  3 Dec 2025 12:08:35 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00B0183F39
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 12:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B391gq7806006
 for <u-boot@lists.denx.de>; Wed, 3 Dec 2025 11:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4K2IVUX527O
 uk1Jhb7doI/R5KRhTYtzuGIZUYmfl8/g=; b=ZSF77k6zv/lWJuTh/ekxmj2Hb21
 BimKdkBvVd+UCNZTvQ8kArn7gP556069WIXpV2DhEtAZBG14jLxOPvxH1B7jRszQ
 gOQzqmg9XtMFTSNaoom9gKxNfyu3daVuLEzb3E9o94fCGpRTFCel6mkWPWRRhQlR
 87H9wVrCJVGou63SGC9lGnInoTwldvaiETnwhxSiRdVpkUZAVm9bTK3ReJgsSPxe
 BmTU1HgBRqw8lHKy6jx7EhwR1WZeAVjIDXJaxhT2/BUgjEKEylvM0zFVSdoAdPi/
 5P5hEtlYtaHdrsx8XemN08ML410IRcvG5bkxn7lmH8IBwis3c0+EJbC5BsA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atbmmhqsh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 11:08:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-297f587dc2eso130537865ad.2
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 03:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1764760110; x=1765364910; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4K2IVUX527Ouk1Jhb7doI/R5KRhTYtzuGIZUYmfl8/g=;
 b=hXZgTAQdJohLfbN3OHoMMUl6Fzgo/Pfx6XBgALK3gsslsVpvnUUmvU/MGHCxnVZls4
 sivhST0o957UtjcKKPy/3ombHImoLEJOA+vSKxEEUmYmUlq02vlNR3MsXikYiUyTsL5d
 2l6tIWsbbv8jvJ+sgHnAMPtLq6Hxt+Vi5JZaSFUg54xeM8z9hzjQHsWd/xu7UCnnrG50
 +4eHOo874p5Hw+RWvoTnWzH/wcmtxzMrOvIv4GNtbXtK9uf+4jlvXJ2A88Zx75J11oHW
 T90cD+RkZuzknn4QagR8U6DesnZ8MsSxi28zWBANyPmhtFn+xt2kATLVyUpqZp9yn1Ic
 70EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764760110; x=1765364910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4K2IVUX527Ouk1Jhb7doI/R5KRhTYtzuGIZUYmfl8/g=;
 b=PTs8EHEyijzF1aiPqiVTlFr3Y+lJzbCqmxGuRVPbeT3+uPPn5omV/9OoWljcilABqB
 3zClWKTUy2mmcdIsBBik95zZM6fFliPYwsqj+usfof7ArwqF9rbCuQ8ZdsJ3Km+WsEvl
 EaKJBJOdfexTj2+yDKvdacOq8E4Gu/bxBAkXkI6gJkNzmqmnfJGjhTkm8JxoKeqkprKZ
 16WWuWAGYGBurTGmhO7xYeDuPtdyBN0HVMam+eMSdJ3CWBpk2dO/19FbzahzjG3zIyB0
 BGwkZ9GfKHei8x3ZRcNtyNoRoCGiDDMy1HLLWV8qJJicJz2dNwUeDvAiWDXCYd28/cyF
 ktJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD8LcuVmTk8Hb9v6lTbDLVusAaf+73ZKkvKP2sjtH0sWjbR6UNmEZmAP0N2JiChSWf+iur22c=@lists.denx.de
X-Gm-Message-State: AOJu0Yyn/anlg289YzXLTcNOsrrFQ4rXgra/hYlngrzoL0be90ApCv84
 gB7SYYKVXdrrFpnzd6QAK/vxexvAU9QGyhSQfRrf/ztLcG1aNREa25RKcndxB+DotohP0bcfOgl
 tWppEB6S8qphpSX4eEsJ/O8aJfrwammJDW9loS6FYfT9bTKxM9urQpxPK
X-Gm-Gg: ASbGncvAX4VhsrVdwlcASlfHkikqWcBiI3XngVZbSE6jaJt9EZcMp8KIM5nH0kUBZKf
 S13YR2ZpvlujAo9R4eDQs/R4vd4Otd/gTWHh2LS3f1boxt2pVjK/9zBGOvniuTCDOpjJ/5X3N5j
 c6IR++AdsEnDbtNGGXFGcKNFZIikaMyVFzJgZ+1LFnpoXtAXJUGbm7AUdI47+gMNG3NHXmg/6F2
 zUE5rbLhu/bngwXn9drObKLhJ/Fa5SVaCUO8uxzAINnzYPOJr5oQu2nGBauV0rbZUfOHWItncQt
 0og3UEz9QMOdDjK1IUH7kN5m/uDwMg4pWKD2yULIe1R7P8u4V6e7xMIY7mLg8+O9rOrPfs8LVHB
 Lvhs4z/STkLexbpy88SXqgJ21EODezVrmrhZoFTNGRp1eobX6Y9rAEiUiQ0oOwxzxf29UV0IoHj
 BZ4PSC/HG/aee3F0MNF1lahZ+xc5Xv8Iq6EF+u9g==
X-Received: by 2002:a17:903:983:b0:294:f310:5224 with SMTP id
 d9443c01a7336-29d68397ce8mr21632905ad.29.1764760110409; 
 Wed, 03 Dec 2025 03:08:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGw3SEHVYuSX3jsZIa0yli8fjMlyNjuRjtapXHvP3JY9asjhJefsKlD1psfBbAvMfIPnTakQQ==
X-Received: by 2002:a17:903:983:b0:294:f310:5224 with SMTP id
 d9443c01a7336-29d68397ce8mr21632415ad.29.1764760109896; 
 Wed, 03 Dec 2025 03:08:29 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29d7b6ba774sm10132925ad.83.2025.12.03.03.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 03:08:29 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 malysagreg@gmail.com, vasileios.bimpikas@analog.com,
 utsav.agarwal@analog.com, arturs.artamonovs@analog.com,
 nathan.morrison@timesys.com, peng.fan@nxp.com,
 kory.maincent@bootlin.com, patrice.chotard@foss.st.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 alif.zakuan.yuslaimi@altera.com, hs@nabladev.com, rui.silva@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, quic_varada@quicinc.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 6/6] MAINTAINERS: Add entry for Qualcomm PHY drivers
Date: Wed,  3 Dec 2025 16:37:35 +0530
Message-Id: <20251203110735.1959862-7-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Rq5dlLcA3C-ciWO_RUo0K_xDEuUr8GJ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA4OCBTYWx0ZWRfX2sgHjrdt6iba
 hHvzDpSVmq2h2nrcw8SCcHn2VpnQDNX+x/eLIGF8zpvBL3lfQ4PwH8xFUTQi5ezvzBFRPMArYn7
 /f1YAoyK5eQu63SwlBunpWXaBm7J86t3ghmZpWSe3CA4O+KB5l3LXR2EHeKJVUHxR+PgKdk9xjC
 KpTkJKiw+j/gW3adlF6OB13QeoYDH5mhE8nOjllUaojOtyanryyd9r5R/3wozQMiZo2J58dokEm
 aSwgsW3JYfbrLaf/42+KUAUFO6pgx/1bddz8RuiCK3kyszDQr5diVhAhBVCuFn5mXETKJKPG2xR
 Ff0Tg2CY/qogh+bVWflylNuMFbFqwyQftT5O19vZExbIP4CosTqpj5gAeAX37eJUGHrYjsbmiyQ
 f2UCf7duLaZ47pF1xqhS5VgkXXb57g==
X-Proofpoint-ORIG-GUID: Rq5dlLcA3C-ciWO_RUo0K_xDEuUr8GJ0
X-Authority-Analysis: v=2.4 cv=ApjjHe9P c=1 sm=1 tr=0 ts=69301a2f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Zz4FqkAgjQAisYH1-3EA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-02_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512030088
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

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b43dae882b3..9093ae35b65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -672,6 +672,7 @@ F:	drivers/*/*/pm8???-*
 F:	drivers/gpio/msm_gpio.c
 F:	drivers/mmc/msm_sdhci.c
 F:	drivers/phy/msm8916-usbh-phy.c
+F:	drivers/phy/qcom/
 F:	drivers/serial/serial_msm.c
 F:	drivers/serial/serial_msm_geni.c
 F:	drivers/smem/msm_smem.c
-- 
2.34.1

