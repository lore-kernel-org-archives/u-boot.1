Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72782CDB46B
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 01:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9B49849E4;
	Tue, 23 Jun 2026 03:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="Ydx3OJj5";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="OfJ8m+Lj";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="jqkFWJc+";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="MzPfuuYl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD657849E4; Tue, 23 Jun 2026 03:49:44 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B42A2849BD
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 03:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367129.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N0jmgf085422
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 01:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=Xj8K5PqwodkVTAP9lY/lhXBDi
 7aiuy0btjRjQueQokk=; b=Ydx3OJj5j2ba/yrL5cW6L1nXEwwHpFsxZtJPNZDK+
 9THPrr1jdQk4tyfLYUCHBAS5ZiVM9cp1ZQOlNdLVSOfawENTT8NtP7t3TKmknnS+
 +T5N2fQhex57DPyYGjBrMIn++ax9JIgjDLxb9rUAjxnZSzJiQ29V4n5TEtZ4MSXd
 A1ghChonxkO4k0zGiewWZ9EsoCV2wrCXbFH+etBoy0543gHGy1qQ3CnndIj20WHh
 xLNw6elHnzv13ofMZTWaCRlClT1FOlp6JMybwb9n5RuGWvjCbzsP6qMqlZuo75AS
 t8Nk61Kuz/D9k+IDkiagRjOP7onjjG92sqer8OELIYmNA==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013039.outbound.protection.outlook.com
 [40.93.201.39])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4eycey9tdr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 01:49:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9Yt4YqfFfLxwrpVtY2hcZ6qXJuOs1OFWXkvOLrxk9DQ8x6NrlC4ckAC16XMbBAKVKL5iyi4c7aQ9vc0MsHS5V+eRWpxSam8CFhfkrR1AenR1uhAwyxhyXaHM3M1IGF2cvgdY0kZzVgWpr7zVyCGgyElL2Ptw+z2C/gBjh7GD4l/agpRxvClbQxcLfVyGYTJ5OKuBFcVzZUq8Rpy3nHx+2iub+mwnNoas0KMty0m7u/T+4sPj24N6+6i+XsM6VfKUY6Oi5w2vS+MmGRh4AYxTCPkeTWF+wwig88cbyXefDTqBfxSZ3CFK1oZLFKhmIC2PF7BEn7PiVnQ/KaSf5xFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xj8K5PqwodkVTAP9lY/lhXBDi7aiuy0btjRjQueQokk=;
 b=HjccEGCIf9Ynb35avryNFme/N8oUnvfebd6zE2HQ3fPhck0uBpz8j80/xGkvaMxsVq52g7CYXIYafSHDcgSJzh4dmf7q+Uh+D/taBmH4xLHU1+I5thuxzVdx4+DAKHHm6YOz/VYQovhYkItN4pWyqQv1/NjO1G8SIlTcSCcn9Aax9dY8F6+8afDT1VDkw4zHaNSx407RFoRcsDvAh9VVisyA5RD/HkYH2Xn6h46n11aR4JAqdj4xRQpHGOwwMc5rAXUc8Fa8UV3ZobOAgNhs/4b0NPMZ1yOtxl05nlhNw8w8RLZuG3KjHU/Q1GGPD2oRHPjgEU9kGkdmBoKznujySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xj8K5PqwodkVTAP9lY/lhXBDi7aiuy0btjRjQueQokk=;
 b=OfJ8m+LjCnRKqZ9KwHWOUAC9lUNYn1rV+EyLogiYduEjKQ3T/IKUm+LdKs2tKdOr+x37omRcEvhge92pBnh7srZLr1OuSbma0tUZlDbruMzd2c1lmjDVOZhJ92SD8i4WY+glZo6Faug1th5vx8Jhpk/fAaivvKfvVfWA1xPAm3g=
Received: from DS7P220CA0113.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::15) by
 DS1PR16MB6638.namprd16.prod.outlook.com (2603:10b6:8:1e7::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Tue, 23 Jun 2026 01:49:35 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:8:25f:cafe::ad) by DS7P220CA0113.outlook.office365.com
 (2603:10b6:8:25f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 01:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.10
 via Frontend Transport; Tue, 23 Jun 2026 01:49:35 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N0lAJu3852215
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 21:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=Xj8K5Pq
 wodkVTAP9lY/lhXBDi7aiuy0btjRjQueQokk=; b=jqkFWJc+GgN0EbvZmJ76XGd
 g0ABR+eX01cAFeWtUFOtCS9rQj3a3267vl9Tf00DKXGzancyygO5Hc5E3ejQj/9q
 4mlZZSnNaGXoJ4F8FwrrGZwzQeUKJSVm47mWJl8O9eSc+7bHPE2s45ygc4Cjtv5O
 64SOh3aoDuGsUr+6ekHIr4PCBeWfR8KW42oUTNvwZXNeDAFP++RmwnyeSVJB04Nj
 /VKArog5QSS/6uvG1KuhsqTvsrpj/buCS9YAwv+kcBYorE3IZVc4aRka+gnsk4H7
 DHFnrvQ2GfojzRoXAcgOvAvqGMlexUCC31WqG9LHsMFo4L4pTkhWAcxyhf1sc/Q=
 =
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=Xj8K5PqwodkVTAP9lY/lhXBDi7aiuy0
 btjRjQueQokk=; b=MzPfuuYlRo4u50FKtGNoeaQnBGbCA9h0p06gE9QM9ccW+lr
 lMYYk7vFDb+FHskbcvgDApsQOFey8Pstrg94kNh9dIgrXy1fVBSqI1DI2n39L0Wd
 LSX9iez81TYUZnNlJTjyBXW4W0HaJzsTRGO0bEnumD4izINxTo2pwoqx009116hK
 wBm55k/MWv7XXPx1Y79jft/dl/Z2SDS3ggQN4h68zKJREHbovBTaTNQUlvlxVNb5
 a+aC5mwecy/Sd6Wb6A3vk4rJlUSBTjM5FEK/+T5z7QdveEq9Dvb6tnJwkJ5X1/vZ
 UF+8EBNYINx0sS356bLEgBrWpFntSSIVnXKy5yw==
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ex9xp2atq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 21:49:34 -0400 (EDT)
Received: from localhost ([19.12.92.221]) by cmsmtp with ESMTPSA
 id bqGZwV3QsftKQbqGawdC53; Tue, 23 Jun 2026 01:49:33 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: bqGZwV3QsftKQbqGawdC53
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v4 0/2] bootdev: few fixes for automatic boot
Date: Mon, 22 Jun 2026 18:49:28 -0700
Message-ID: <20260623014930.2741494-1-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230012
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DS1PR16MB6638:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c68ecb8c-cd45-4f1d-9430-08ded0c9adaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|13003099007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: +4+TDAkpI0Xy0hmVT2ads9EhQ2mIXNzLyXIIL+t1SDdIF4aVKaK18llNovY3rVA9shc0yEx1XeYe+xodhMHDGngokAPu72ZhB6FPNz6YVDfSu9XGJUMp6jcx8TltfKh0JGeqIaMHbGAIfvsTGMg3WA83kAS7kiMp/mDArizSEAxfMEMgveO5l/BoU3jV4Fak9mnElPFwFdNuDFKb4ZMkZmM36gRyT6jP9efi10Rlo8ix91SgJsd+foITxFvYR8AI0Mvj3jc2+eQXAXqsLNXviELZ+qw0C4MVF/3TrSfOjcAi+x5AntLftm7WJgnmQaUWyF4wNDPDr6Eh8zAp5az3DOQUu66+NCSFnCeCGBvSsbT8YY1+LEd7kqy+xma9cR4Ql5kXCyh4gbEl2uyRHUoQ7+tq1C2xitejDewajrZoJVnAxwcX0p4xiuePt8LtI9XtSC+rv7BqpOqPiK49MuBkAZPR6aBqbsyK6dsDr2HwaC+fAf0L3ZPiqRU6wbiiwfrrWAf4Hr2Oa+5h9tPZXUwmMeezZsmFAPdLgoqm581TBfuYCPebHe8SoOpkbU938J+VfuzNeV0YRhz4whOgIFRR3MSEL/K/gSPjAVmpSpEtBjoPLeh4JHhc/fHOnAo9ICRWuindFHplmynrq1xml9Rwjx7Bm10mkAA5Wsp5VCDiWORG6Mbrm9ye3I71Cj6Wummgm7bbDSFsAgatVvahL0+p4Q==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(13003099007)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YaVjp53BlREyb8B7JPa94oztyG9NMs0Mp6cxpzKVG5Ra3g9vQ8zLDpDU19vPdvMD9g4ahrfFT2+6W9zWo/MR2mfxoTuOonFGqfkQStgt5B8lyCR5cm27xe6ImryeM6VXQCff6wbwqGnatBn5bVztQJeZJ17WS3NrCip5nixrzV+VZL0UqJ8jHKflPjWrLiq3Q2j9f2RdU6Wg9spg1aKRJdni7rc3M2l9vYkqaoYIadvp1phglh1Uka4Tk10hHHrl/i26efen3RdO3QdpuxlGUGXusFDFS4GwsjK/J6EDzWFuqa8IrmvyEaUgdNJrrAb1YlDvy7XOYZs4UoK2F/1Jriv+hQqn9R4oR0LkhkzDAfkJfSuViybcLoKeBYzCCezZFUbZT0sA/8bctiM3GHuJjUMeC83/cO84vd5EfRmg+hthATopEBbXpgt0VRQCfY8C
X-Exchange-RoutingPolicyChecked: DQIZLUrprhIYglmxeGZhOpxyIZiAU9sxiqhQqIFi6VEp66uVpVaDhXRCtiOuJCEVFiYvYag+rKOIz439JWup7XYS8MIdJMfMQfMZoDmtqx9fnZp5tTCyFXN3uWmXZj95FAogGslG1k1Ukt3Gvs3Mo5DKrFZ2RLtNyl11nG0rX80A+H1yw/u/aoAQ1Ol0cDL92OSDoT34i2cXeZPSRutLDvVLz6iy2af7nIMa+wI6Ep489BFOx/GeXRwPuWMrRtjca7p7TvKVRminngpIGsTE6lB0VOXZX96a0Tl/FKlU+V6NLreMK0u8jFwM9ewCQcUSIBb6vqqoihlhhSIHvenYrQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JAt4/WBdQbQfXUDT114NblHS67g95JezW3m1yBGK3uD3ZTgjzl03onFT0dCYSVjjXmMKtFFwVCMJ4TUWwqHwLpcGifBTCSTejb+WLCTIkYCjq8WgzadfBuE3jvSJdnVhz8Xx72UGUwduaHDpdz+NKNGsnRFXMRR0HfhtUL9655FxCzucOoz92bEZciRdYKZg17b/7DOZAuHwexmiM30ygOwkwWq93VJr8HpVi4kAIW5PfQnDjXajWYqtQ1AlcSKlLzMiV0k8byWZcvPRS+4P0vII/gAU3bTm63GABOVEwh34O0OQ2wOSq4vzU9KWVUsKRVRe+0ovPhbNbFnB5+ab5v5M+Q5t/r2o0tcHaM42TBXt4Rks88gQXmWMhLkvekoxXwMUd4XC5HDMExOHg/L8N5NPPrSm1+BeTNnWKSbZW5a86SmcPyzuNRWLmI8iPp1JQ29N3+V1t3/hdJnRZ6TTlZopSX4qdc6pSm2lx2CPYXhDB+K5ZozdYlPUC5En/bhizTIIEy1whFzC8KV5M4f+1yQ8VRWDe1hXpV7WzaLVpPaqDp2F0xlNvEFsvvyy2oGARRo1oBU9C12HO4vw+PNA46OGOeogw4PzJksQDEkoHrKkN+Pq1kkfDFmWaF1p5z+UmNxoKXrVFeMU3ZNPpeiPXQ==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 01:49:35.2473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c68ecb8c-cd45-4f1d-9430-08ded0c9adaf
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR16MB6638
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAxMiBTYWx0ZWRfX35jiqiF/HmR3
 3oGLmbWpKchuPQGR0Xmms+RgpgOcg+oSIdcLaTVBSDH5xZSh9w/q3OWEw/k9TjwkwQOKPQK36TY
 I3BnycbU+hujP855E/7v8bl0TyH4pd4vGbCWilRGdVSdCr/ZELRWLfdg2dBIy5BL2X43XScNNCD
 35CffYUYDWWHmLXe+4GR2x02dIOAL6XbKg/pn+S56anqUkD41Dq20+4i8a6L2k7m2np0r2F9tNi
 8RIvUkiURC82Zav+mM/WWc/aTHbiKUgV3tU2o9A4Kp4FxAVNYfeXUSQb9Fb9eA85HkwGUyoCSCz
 67D5QWeUzSdLrAYMyhJFOvZifYm1evsimbER4NhK50vuw3J8BBUun4qBaoGJ/tiXvFARLG1RQ7H
 p4Cemsrc5rmH/QnYNKuDDgtnIWQwjh6ByZ8ZvtLg+jlhTcIgzn6DTdqq//AaoA65kKYTqV90iVr
 k4tSNEPVaigZDBrVhAw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAxMiBTYWx0ZWRfX9vFad4zycVvg
 gowGfHXIeSgT9XovKmGEl4ZXJOie/1EqlxQ84SQ5Gx+4oDdLmNBA97FBV5gsGbaM+YaLxRM0mTY
 WjlskDjcfALbHnd/ZQjunW/CN3aqe++JayxwkM+w7QTanhwBGLFq
X-Proofpoint-ORIG-GUID: r37iXZeD2s990FPDyC36XDiuUXl_DdQR
X-Proofpoint-GUID: r37iXZeD2s990FPDyC36XDiuUXl_DdQR
X-Authority-Analysis: v=2.4 cv=TIh1jVla c=1 sm=1 tr=0 ts=6a39e632 cx=c_pps
 a=OPuTCcLOD/60NKbq+Taa8g==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=X3KReqg2EL6A36SYCKpz:22 a=VwQbUJbxAAAA:8
 a=cbNQJ9GKAAAA:8 a=NEAV23lmAAAA:8 a=cpCXUhs6SJ5m9--q1RkA:9
 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230012
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

This series addresses few findings in bootdev code.

Patch 1 fix for automatic boots in case higher-priority bootdevs fail
        to be hunted.

Patch 2 adds unit test for patch 1.

Link to v3: https://lore.kernel.org/u-boot/20260621051445.1763952-1-dmukhin@ford.com/
Link to CI: https://github.com/u-boot/u-boot/pull/994

Denis Mukhin (2):
  bootdev: scan boot devices at each priority level
  test: bootdev: scan with a broken high-priority device

 boot/bootdev-uclass.c           |  2 -
 drivers/block/Makefile          |  2 +-
 drivers/block/host-uclass.c     | 15 +++++++
 drivers/block/sandbox-bootdev.c | 73 +++++++++++++++++++++++++++++++++
 include/sandbox_host.h          | 18 ++++++++
 test/boot/bootdev.c             | 23 ++++++-----
 test/boot/bootflow.c            | 46 +++++++++++++++++++++
 test/boot/bootstd_common.h      |  5 ++-
 8 files changed, 169 insertions(+), 15 deletions(-)
 create mode 100644 drivers/block/sandbox-bootdev.c

-- 
2.54.0

