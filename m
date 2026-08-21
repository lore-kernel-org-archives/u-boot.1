Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18EEC5DF81
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 00:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EF5D40858;
	Fri, 21 Aug 2026 00:44:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6cbYDMxGbTHl; Fri, 21 Aug 2026 00:44:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787273093;
	bh=tcWdcS/mSg4iSWf84CYQY4+EWp4t3ni3E7/yCJh4YSo=;
	h=From:Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CAF9YwcBG88NN4JRwIcF00Crm9viti+9Ai1MLYF91kn7s+QAA19JhaDMJfPap92Zj
	 oDpwiyyTL5Og6gxrUWyO8illmZCXu7Gbdm9czW2hJgx8E5TBA+xY321wjHFXftXmS5
	 7uQpnTZBpRVglP+QcvJ82BbLWgJuka77+OyvL4MyJqFfrG9rkYs1QNFMFtaebKmA9z
	 e+e7X1+VqZ3C8379+knvjZBNQ32lGrz1qPTm5IoNagKMBf1TWONTVgzzh13ygwZbzm
	 GdiuirqWa9WWumbbM4T57eAwbP1P1VDouraTwGdAzGjlk5I0nrvMcQ3tr8QGoi8E1O
	 4RKL9MNlCvpOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D39A44082C;
	Fri, 21 Aug 2026 00:44:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A76321B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 00:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D75380E65
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 00:44:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BBZhKYib9cHZ for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 00:44:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.146.23;
 helo=mx0a-00498f03.pphosted.com; envelope-from=dmukhin@ford.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ford.com header.i=@ford.com
 header.a=rsa-sha256 header.s=ppford header.b=Nr4uPIR5; 
 dkim=pass (1024-bit key, unprotected) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-azureford-onmicrosoft-com header.b=WBYNzNTe; 
 dkim=pass (2048-bit key, unprotected) header.d=saarlouis.ford.com
 header.i=@saarlouis.ford.com header.a=rsa-sha256 header.s=ppserprodsaar
 header.b=TguyTu1P; 
 dkim=neutral header.d=ford.com header.i=@ford.com header.a=rsa-sha256
 header.s=ppfserpocford header.b=Is24S3f5
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C5EEA80A76
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 00:44:43 +0000 (UTC)
Received: from pps.filterd (m0367126.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KMZvLE907052
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 00:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=tcWdcS/mSg4iSWf84CYQY4+EWp4
 t3ni3E7/yCJh4YSo=; b=Nr4uPIR5n4W+4LindsoLBBKf6PufkkSouEdFMg+nQbJ
 E9y4E2jBmh58WMImANQWFt8o9S/ppCrJwVesPEfBzGELBLoYDz/nzeqeyIq60DeQ
 sfnniixbcOC4aL8oio8PlUkOdImzHsoybcghPAnm3l9gdjFNKGVdN5SW7CuC3X+e
 1uG0WRiJJRCcm5w3QilmbeY1Jt6Ck29cIkq19UujMLx9VBGobWKNUmPAl9ukjLid
 MHxU3VNqveMt/JmTysswAu4Y31sPylvKaxrRLNf0/uejCTxuSrhVdQ2z5nLGAwY6
 tWSf8X5T2Yl4sxAOmbq+AyilkCqFDUVPfm7/gLfXMng==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012012.outbound.protection.outlook.com
 [40.107.200.12])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4g65nxurj4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 00:44:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOLBssN8iv5bxC0qHQuqEqN08VnjeOuM8BvbTxxlMkUBycF7BAjONtHTAWxOm0sB5TyfTyeMUDGb0z/q9dvHw/p4/u54bFoHhox3Y9YN4jWUhpWL04sNzqXc1D0dJlfipf/HYa0DlSQv0Cr9jg+I8d1gaN3fFlnKPUH+PZRhk7yG0QkrOGchBjfc74Qrfz+Y7hYo0MCugpZFWvKpxNkCx7UkB6/Z5VadxfH1Um4f9mKklg6cJjmhriJr4bnwAgggwKCLZVnoSiq/z7gH+GS7LoRUn1MsTcakMfk9JeJuoQ+WRnE79ju45kjRxZXOnpM41hUd0R/LPnGVK3I7OlUXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcWdcS/mSg4iSWf84CYQY4+EWp4t3ni3E7/yCJh4YSo=;
 b=iEr9jISMp6o6i1LLbB9WaE5DoLsrj8gsrTAz3Odu9MY1jim5zPooAcgLi0IuMdqoMUJdr9TTRl9nBtNf1sFDebccmAZ7LeESub9ofe3ZhPgeXwOUuhrXK2tuK+pURkwurgY9YvlZBvGazx/JuYM3WIOSt+3M2iCPaDWiPgpDpGD3Nif0pr003JdoKuo8Y4XxEjmBHLqoPspSpJwHnuLv+SE2b/RCfCIsbbE313n7d2012Ot6Hj7aLWglRbCn1zqaqRmsIL9KP1YlgI4Ck+CH5eZg+y8K2KiPLpNVbQbLZFnifBqd2gxFaT6BSwip1lfyMrHpoaJEroWA481ZVZqkUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ford.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com; dkim=pass (signature was verified)
 header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcWdcS/mSg4iSWf84CYQY4+EWp4t3ni3E7/yCJh4YSo=;
 b=WBYNzNTe9JGsXiSQOCohd6WQOMUHPBEZt0QXiPZu0Xe1aIU+iGzB/+IgGJOQOzhdNZGjGKhQNWrApagkRPhyS3AD7aAmmFnN0EtqCiQEIFCKnT5X9rJvjQGsSxgPm2CI2DtC25Mj70iihn/zHHdNQLt8rjqvBATnX39LqanzN4s=
Received: from SJ2P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::8)
 by MW3PR16MB3692.namprd16.prod.outlook.com (2603:10b6:303:4b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 00:44:38 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:a03:5da:cafe::65) by SJ2P220CA0009.outlook.office365.com
 (2603:10b6:a03:5da::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 00:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 00:44:38 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KMav883931061
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 20:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=tcWdcS/mSg4iSWf84CYQY4+EWp4t3ni3E7/yCJh4YSo=; b=TguyTu1PiZpl
 KkuggqYyAZeN15LXHDyjPfUefjmnsIfYFbxHQ+wjwOqRcog6WnQgAh9ayEfZdFob
 1/4x5x4eZdvQpx72yYbSovA6GQn1bHcE3tRRb+fkWwzzLuGW+3076fHfRRyiEpTr
 KBAMv/Z6Vj2lMJVp0z4FuELI7Z9FZT1ILcT3sW6OnDD3ETge6n3/7dYScSjzPu1R
 Cj2imAliwtoIFh2CQF4mI8aWP6PuPqknStDA2n69si89iSVR9dDvIn2MQQDS4VNz
 hv5eGMtTZMDexFHy4qjAlxOBuGKvcBRRypFElJ/G3AvAWBa0+uyDd2kMr9+1Bgkm
 705qmckGnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=tcWdcS/mSg4iSWf84CYQ
 Y4+EWp4t3ni3E7/yCJh4YSo=; b=Is24S3f5014/T+6Hu3JDrqu+erGhcy0bU8Gy
 XAdm15rkHKRTDRZlxxof756pXJ0eXxlRp1qBg/NpmEvwit3F7XW2s+TEqV4w0Ydi
 Vyzhm6hSCvKFXAn7y4Bd0w6FlQV7NB58Anmv9p8qpWu85fAPzzpJaGSMBWKt2SIq
 LIqT3wtpHZuU5H2rfZ1eJMQd9svEtJKloLxfziOC3c5ZETDyx3u3qM1mKzHxMgB5
 pqtKh4cUTZRLK/zcGWXpFCZ7rfGq0qZEVK+2DCBq0lXozA1vDVUfSq+I+CEV6kjx
 FzR7uZrJZH9d955ewVFIIsFx7W89qAG334efDzZDxXESONqCzg==
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4g376req1x-8
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 20:44:35 -0400 (EDT)
Received: from localhost ([19.12.92.221]) by cmsmtp with ESMTPSA
 id xDN3w80gQm39JxDN4wpb3d; Fri, 21 Aug 2026 00:44:35 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: xDN3w80gQm39JxDN4wpb3d
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
Date: Thu, 20 Aug 2026 17:44:33 -0700
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/2] efi_loader: fix GetRng() implementation
Message-ID: <aoefcYKwsqnb7Gjb@kraken>
References: <20260820130746.164424-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820130746.164424-1-heinrich.schuchardt@canonical.com>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_03,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210002
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|MW3PR16MB3692:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe6cd7e-ed28-41ba-88e9-08deff1d611e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|56012099006|10067099003|3023799007|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: GzBt35Dhr11P/AEduQfNa5aWAQkWFLh3Rblwnmxxs7a27fGaeCdyOO6oJQi8RrYh9o+AZgjD3oQbzZfjoBf013yvcANRlKYHolbARlM6fsPpW0+RELz1GiwMP9j4F7l+ARUlo0H5HAYorzoPWAmsr3bbrq/RyEXIQlHHJGrLg+tg+OwvUSO1FiB34jT05TAi4kh9hbpYSF0raXJiDwavsIiyRC0EoxrkKFb5yOhkcoo/UvZImk+f+vrX1kLrcbPu7dmSsYPAhu235R9QdY+6zXSzxpQltba7kRNJN208IHtPmOFjeJww5dOLPLIsknMuK2JkYpVvGpT5vjVtP1JGY2irfh0LeIVPxYumXgtPBnUs91j/ejcGkN8QW4qNGFP6FmXGHpTzM8dDkt5qRgwL7jb71bWRjB0D9UWn4WlUAlyZJPF0Pxm4PpN4JktwAeqMMDGObxHUivtRezi4W1Xy/yZJ9PhBjOmbapoqg6jOIxuhwyA+oEP9wrxRVvG4m6oKw75S9FszwaPRDqkEIQXD1sp87nSdVad2QE2hjuhCZmOVKfLObrbKguUjJiAzVLbVeycEZIrFVVAXKXsftZiSKZIAadyMC0thJ257Dbpa8g5ct7Uw5w0Vc13i8p7Pzy7rW9sg5mfT1iKA8nT7McWy+5egPYFRy0qZ1nLspMIWL2fEnBzqEqrK1BbdMUOKfFLq93BxypLuHS4D0oiEaKSfOw==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UH2kyV5PevNTVSjg79kfr5y8IkyHBKiNUp4lE3nFLxBlx27uVBLAaCFeP9fiusye2t0HGgpgw/qBO1njc34U9nySpoxKpkOYuHFKIjCEC8GfomiCm3Ey/pX9A+AeTdx8qP8mdwz1BzdU0EzpiExK07qgk4PrQ+peN0lErH4yJUuTUTMxG0oAorzPrgTvEgtRd5pd0SOgGvCVBv31CeBwYtDQxuNskMjZodqiFFOH2egO+JKmfPrMIZtRv8FLvFa9jGcs/584MkuaitqF4nyRi3Xujq7YBSo+HpbChGIvfaDMXrE3EPlh+GX5/8KCanQBOfaZR6Yrwt6K9T3JRJCwXjfyetQzeI/7SOX1847S/+lGOGShBNKHCAPPTbVsZ2JYX3r6eRwALdT6jlgODRBsXgpJKSgjWVy18f8PUdHX3162FZ6Zp9L/4wevr+lIfFLt
X-Exchange-RoutingPolicyChecked: AejalqTjEEH9u9gM1U2PPy8wwZgTTe2kjfpEWhrQJqXDvFEQeIKcZnVYb/GmDMMbQZvKhZojca93ziZIEMSi1bJhPzWnToI9t+37cETU3my//BfJ/xjun5MNuLjxPjzWytKA03oGLmJyfy/mACMd7ZcJCyOMz8rR+PDIGj4yuZBoqJY9Yo38Hur62ENhG5c2fPGrb6r/esSHhpH2Zp+MNjfU7SJM6qa5z6s6vrsmgoW14/XzoLJb88mavrK6+BvNgep2RsmETB7BRdWkKgBPdd0WuY1myT9Uh2IQ/QmoCCTHqvNsxXtRa7Jdw8+YScar104W15VDIOaug9d9KoMwXg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +nizhcfgAMhLIbtqs+UJrXXbxLD3LMtq8Y93ebnid0pKKijSvXPiE5uwL4hNCLYeJ3da9sMEOF3yZSJJZUVNJ5/n4J9BZal2eK6VchB42ckx52+TZo2bmU1DR/HiJrk2p63QkFzEybuwX6B4BVHaDZ6dR16Mi3BiJ8FvueQ0ZMSuKFfsOBCZrI2wMqJXDqalTHT+nbE8Q6Kfhi/DdHEycdUTJaUIJUZIvJaCpbS9nlQkh7LDVkUCPKoTlPVfG50Glws/lYMJ1t599ProBxWfvRIYcLpApIE6R0axX4X11rFkHjwWXefWtnBcjSGK2vIvKBYaUJHUxoRm6kgGGrTtMGLJnyylHfTyKixvluMsWTIH7VxC9rKG2jSp6+SWBLp6uph8ed1i1SPSeRn5OtL1aZQRnfyNkN3wgYTLA9cVwVcRzmXxH9rDui64RmPA4X+UYbXbCRmyzoP5bYlzuFFhzV4M+HdD+cvhuVxXnKMDkVMT9GcU3pX/dLmj8rXs74jRN61dJ+1ixRnnNH3XEfmcztcqLnr5XXejV8uDXdTVRj8iHfKRgdnBUW2jqAV3N+L+qjn5+VerdQ+ZWz5nWXQs6W43n+zAaMkiVfuGnVNj08VL+CAPuSx+6YpU78S6zzag74zyoOYJEFP1S+NxDl/ayA==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 00:44:38.0383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe6cd7e-ed28-41ba-88e9-08deff1d611e
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR16MB3692
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a879f7a cx=c_pps
 a=dctP2Ni10a9Sh7weZd+SyQ==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=-OawqTZBqJjt90xPb8wn:22
 a=cbNQJ9GKAAAA:8 a=P9CnAGocHD7hpYGG0nAA:9 a=CjuIK1q_8ugA:10
 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-GUID: upN9aB1JZefVjtQJ8AaQOXQ91DdItVqU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDAwMiBTYWx0ZWRfXxOmGJv/cikH6
 F1BGs2HTXXNKUSPsQQL+f0uxRrmuGLIDIDI1LzLrV0duf9glnKai0UKJkEByG1dPMApI6/wEcAp
 D9ZOS+DIC6jUIOjhriebKFThwpanokM/uopnOGXPklFoqMCRM04/
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDAwMiBTYWx0ZWRfX6XvFtDylE/ez
 G9LI7efeQZl6ocf22YcIm9SwPG8u1wkTnR9oydcFtW3fHb8V6I4hRc3J9XQMix7S6opeTFvcE8G
 R5GIf831y0+OTQ+rqSyF3Ye6nCW0hOYcGC/a2YEvBsS4uhL3S7hxZIgQXdLNp8evQsMvA9fzwu9
 tEvrOKDY7iiO3ZrcoUwUBZKH4im5PMqNU/UonUSPPBX7VLd5+pjP4TNKVMIdE+WUz9/6Qw1zXXu
 wSu85QfHGKvUW/ekeoIrj4dPenbm8NEgDRk9Ut8/NBRRtetK+4Wou/FEbzEk9W6/XAP48/00dLT
 i9SDdgArL56yPJwkVOOII4C+uhFxreciTfEqRRKRxnhKhOPicTyJVFthM92wcZFRFPsg3MZ2alg
 0gikumZxSmabe0JP+Au/z8pigs1EZewMn/qrfphlpNWtZ9gUtDp+VjlvZp/d2rln4biiFCL+9LY
 6+Vw9dDxpCrPb4vItgA==
X-Proofpoint-ORIG-GUID: upN9aB1JZefVjtQJ8AaQOXQ91DdItVqU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_03,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210002
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

On Thu, Aug 20, 2026 at 03:07:44PM +0200, Heinrich Schuchardt wrote:
> Use EFI_PRINT() instead of debug() to correctly indent the message.
> 
> The return value of platform_get_rng_device() is efi_status_t.
> It does not fit into an integer variable ret. Use variable status.
> 
> We already write a debug message in platform_get_rng_device().
> We should not repeat ourselves.
> 
> The RNG device was available when registering the protocol. When it is no
> longer available in GetRng(), this is a device error and not an unsupported
> algorithm. Use EFI_DEVICE_ERROR returned by platform_get_rng_device() as
> return value of GetRng().
> 
> Heinrich Schuchardt (2):
>   efi_loader: in platform_get_rng_device() use EFI_PRINT()
>   efi_loader: consider type of platform_get_rng_device() return value

Please consider

Reviewed-by: Denis Mukhin <dmukhin@ford.com> 

for the series.

> 
>  lib/efi_loader/efi_rng.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> -- 
> 2.53.0
> 
