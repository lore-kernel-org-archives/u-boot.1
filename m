Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D119C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 17:07:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD15B81E52;
	Wed,  2 Sep 2026 17:07:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qYLtnnwH7Y85; Wed,  2 Sep 2026 17:07:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788368875;
	bh=Ud7gIa+/eK5uW6T/PW8qkIw813tfVFm1t8oE/q3AVbI=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fC0lU02U2+A3W8WEt2u6+52/y/50pQBsxOZd2tHHr4NRW7yzmR3DjwelUYBM8Yro9
	 jKacoL4J9ZZUIxd+5Omlp7XX5Cm6hDl3gz+s3hRf9tIlqs2luUUqmQM5PieAc3LgjQ
	 Eo1DfxpXnWRTUjKhoLBn21Sw2UCByclnxCd2OCLYCSOWciT0j60QO+itGakcwkWSfa
	 ZwIhtpASuMo4LH6HvajDBHOJUHyCGm0s3YIyojJdAHD6QTvGd4DNWO+jVlTj83SZvR
	 MiENrYboT+SyyM4t3kJJ3dNfVSKrIBZcjL9ibxWmO2b/zx0Iz3SdCrOjfNLROu3xzS
	 kO3zX47WjGmNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5A4F812E2;
	Wed,  2 Sep 2026 17:07:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B48262FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:07:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A0684A416
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:07:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s7yP3eqhGg1Y for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 17:07:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=H9CzQsp5; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jFSBxIuy
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0821342FC9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:06:18 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682GfmHE2215683
 for <u-boot@lists.u-boot-project.org>; Wed, 2 Sep 2026 17:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Ud7gIa+/eK5
 uW6T/PW8qkIw813tfVFm1t8oE/q3AVbI=; b=H9CzQsp5gyonIQntdzcvp4EPoNY
 i+GX3QiyVS6XxVs/1Win3NKlkYoC5++7H1qLTH5LWNhIESAlonjxHm+Zfs+bMc0C
 rjYstcDIhBrqqh59CedJgXwxka81xPqdbbX2aO8uoLJGOYdH/7sBqJ2PgQ2OCtL6
 W1lhtVr0xYrOq37MN5o0h2yVDqPJga4AAwQ5ihmUx9/CbpHmwEx1aZCzSEgfCFnb
 VVNDJr0+P9keASWq9THwnUcppwQdONL+lb7SdDdjtmmloNX5CgDYyffytYVCvSv/
 y9IkSLOyna55svNd6omEudOfamepR90Cp4HhYMxt3+nH8Jy2vfBd8Y+BvCA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gejv89d8h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 17:06:16 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so1724470a91.3
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 10:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788368776; x=1788973576;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ud7gIa+/eK5uW6T/PW8qkIw813tfVFm1t8oE/q3AVbI=;
 b=jFSBxIuy5GVRpxcxgJaaK1Pyg0ABpJQoDcP2wGBvxkwCFBBz5tn0XZPeSH6rIOoVZ/
 z4SVS6Use09rKK5gtF2+QftZCbAyaXFVaqdMu3iDo5G6PJ+skg7lc4N0Nu9IRBIbrUsB
 2Fgm6fAj2BgfiwROo+XvqKu6yRIkbYp488Jz6a4MRh6Ldo0hUDlKrJteBGTmtFZT+MUX
 0Eee1QiABaxXtOJQ+6Pu8xmaO7eEMUJBIawXFRtuIP3ADzvkO11b4R7k2+gJtrnQkrls
 1Lx/hc2hROiPs30m8E4QR9qpHqSSxR8cDoR4OcU5303iBC00s0MbzVOU42NAMjybKEPF
 Hdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788368776; x=1788973576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ud7gIa+/eK5uW6T/PW8qkIw813tfVFm1t8oE/q3AVbI=;
 b=XrTO+/orMi8YfLdJhxaMmBZY0FO7oZlJ6VAWNXUukD/qoGvayJtLicvnRoZOxibWQp
 wCPPsuOY6YFKJw/bhVaR/OVXpERabVyHehUhaXMG29PF5I41XzYh87UN63MpBr0myuLJ
 EiVKV1sHSZNcnV9qgtHDk0+l4bzomCuqMNfHgV01tLgnFTxJmWmAB9CxI8a3B+/Len04
 Y9ka8BllYNLDwb82nqQbD48yy+oOMuQsAPhh+61YkBdkDosKXHFPgdvQHMI1bmoMTaYX
 ZgJ55ooxa74MpzPN7L8IGc6cHA8ZZjW2hZPooWJovX87ZoLVJZibm2tBG6WuqNkByofp
 fdWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBznnjCO0Pv0SRfAQ0OuNXxcYegxnypvxuhcf5BjPdfc4BnaQZxeH23ttQdsgaLjbQWHFyk75To=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mn35kkbCyKvnX7EvL9xuEklPb5z1gLQU6UvRg2QlToJFwCJyXs
 cyHW4vJQbNCSBILNFITvrvikOhCMLTJS2qP3grRy5T7gydrPzwRachKveAVxu8yntN+LmU0XRbL
 VGpecxfARdAinEHRqpdNQlK4jHzooerJ2YcfTkGw3W1FpCU0VGxp+YBqcscffuX75GQImgBM=
X-Gm-Gg: AYBFou0t9P7AcnuFy9k31yj+iFZebdXzR1t0B/TKmBYixbfwRqpxaDEmTtNePB6Gcmn
 CpdNZ72q2R8iUe4bbL/rZqOK/EJw8FSTREvDg5hh16KsB7X6EEYaOLO+2s2HgRnb/QrL25tb7FG
 okT0GBFMg33ktscGb2xBCB1PpwdB2F8umKdGHujnj8Uxq3++3Op8grIVlelDZcrFzHCfbe2x4vS
 xqF3dlpDYzlkEiTWfpALzhPsNMBzOajidA+w2N21LGDqytbMCG9qZ9j3tt/FGJwhgvB5m3T/Z6+
 /5JI9yhHcqtIJdL+Aah7R6SSovuqTT3pBucpgr++WzlNUyXmFH0i8L3dVmqjTl6Qjt6V03eQ6rc
 ll8Pdha4vB82NqjTCObcO1S5CmzSSHWIBMs575i0qRtGMXtsKJ/Ru0WriHOjFgPoGWr/mMMP1qE
 86PzHYS0qQdgkgDQBvPA4=
X-Received: by 2002:a17:90b:57e8:b0:398:9bd5:4910 with SMTP id
 98e67ed59e1d1-39aee14d247mr9659255a91.23.1788368775683; 
 Wed, 02 Sep 2026 10:06:15 -0700 (PDT)
X-Received: by 2002:a17:90b:57e8:b0:398:9bd5:4910 with SMTP id
 98e67ed59e1d1-39aee14d247mr9659136a91.23.1788368775177; 
 Wed, 02 Sep 2026 10:06:15 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f07bde5bfsm8105688eec.27.2026.09.02.10.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 10:06:14 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, aswin.murugan@oss.qualcomm.com,
 nathbappai@gmail.com, varadarajan.narayanan@oss.qualcomm.com,
 quentin.schulz@cherry.de, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 1/3] mmc: msm_sdhci: fix max-frequency read into
 wrong-sized variable
Date: Wed,  2 Sep 2026 22:35:57 +0530
Message-Id: <20260902170559.3225833-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902170559.3225833-1-aswin.murugan@oss.qualcomm.com>
References: <20260902170559.3225833-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ReI3LF5oDeX5d5KGsQ6EXwbX1fGxvpBe
X-Authority-Analysis: v=2.4 cv=L+wtheT8 c=1 sm=1 tr=0 ts=6a985788 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=flhWhx7jv1q-FmX2bWYA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1MCBTYWx0ZWRfX8/hOPOfOeexH
 a5tOS+H9/V1o6HVD10r4C3+eIsEnvX8o7ShLrz93mWgB4eH/yZzk3Obt5s5TVoVP6x9vnw6IaZY
 X/BJsS54l2Koptn9AYZzjKuCaMyN3CHbc3tmY/AcZXN0N7ZH0xXUVEI1WSM4nlx9udBmt8F94l0
 GQ3vXwZuM3hoJBbBCJ29Vvpf+1eIyShOUFF5vuhKeYtxC/a/dxsiBtf5NMOI89I+kQbcIz+1k5n
 waRHSvdLJ2vwQUXbkq8T4R/q8VXz7m7YBoss/7gnTvQ6bojvy/amqZHoqfQNBl0k+QgCFrBG3zj
 c4MmKQk9WX9oDyCMqYfhjGPs6QP8AntgDemZm5ssuxFLQW1HLe7XWR2wAgfElOT6/YomqgCw8av
 bz82jYy+2awC2T4HR+xAZX2LI0CV23tC4aifnwJK1M6eWTlYasTSFotFRiRbbOYm6N9AIO572Pr
 3DWWwmv8oMSZbrgYGrA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1MCBTYWx0ZWRfX4f+speE6TuK3
 oP5Yar6uUE+dwKZeu+QXIb7xRQb4mMytWBczb+Fqc77eAbVGJNFc3KPlYp5L8Ur/sBXBtQ4yYMJ
 +wwX+l97wyyKRjYk5J6z6N5wp44OGrU=
X-Proofpoint-ORIG-GUID: ReI3LF5oDeX5d5KGsQ6EXwbX1fGxvpBe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
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

msm_sdc_clk_init() reads the "max-frequency" DT property with
dev_read_u32(dev, "max-frequency", (uint *)(&clk_rate)), writing
only 4 bytes into clk_rate, an 8-byte ulong. The upper 4 bytes are
left uninitialized whenever the property is present. Read into a
u32 local instead, then assign it to clk_rate.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/mmc/msm_sdhci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 7bdb02142a2..e0753a1cd5d 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -70,8 +70,7 @@ static int msm_sdc_clk_init(struct udevice *dev)
 
 	var_info = (void *)dev_get_driver_data(dev);
 
-	if (dev_read_u32(dev, "max-frequency", (uint *)(&clk_rate)))
-		clk_rate = 201500000;
+	clk_rate = dev_read_u32_default(dev, "max-frequency", 201500000);
 
 	ret = clk_get_bulk(dev, &prv->clks);
 	if (ret) {
-- 
2.34.1

