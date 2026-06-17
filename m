Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A96CD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 06:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA947846B0;
	Wed, 17 Jun 2026 08:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="U+0Blvxk";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="DByG9bcL";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="OF0J8vNu";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="JkuMuyLJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D679784704; Wed, 17 Jun 2026 08:29:19 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33966838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 08:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0384717.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H2eiOZ618172
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 06:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=5qtWPC36dwbrzBq3VY4EGoKXhXq
 9G3TuLqhlFaxT61A=; b=U+0Blvxk8to+twlRG7Ki3KxN3ySkCtQoqCx7UIVd995
 d6L/89AMMz2FzAgYyBYSeiW+IUtGwwhMShtCtOKepuKHy6fx4eLzGZz98j0S5xqk
 YF21nI9VzHw+EgnoWDm5SSz5Z1PwJYcAQBbPndL7cNVNtMlXc2UlsBnKDenH95Om
 5lOHNN22EjDSj9FxMuRyej5UhpI/eYY9qqcqXmqfAuqa7ym/FFyuxK4pyQWsFC9U
 lppBJ0AJiGGi5mDwYW+gkgRqNyMT2reTov4p/6s9ZpRiwrg8zttZA+zmLalOns/g
 epMd278p78Bhcd7ZfaCn4uvFf40DE703Pp0O9pNFySg==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4euefbtt2e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 06:29:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HN0VjVidiKDUY6YScF+CCXSCzh9iN810Jb3g2mrjBmpce8gnbBXIdRsVKp7na5igxp3jp/ox09JPunMLXt5Y+plOotH/dHYsdz20LJEYX7Jjm1BUlXjQ8Um5tOIAjA/ImIf3+OX/FEAYVGR2d+KVdwCRTN5PZQe6N5fnChCUg8DdhhhN5wkXvonEKDGYItbmVOWsl3S63PvAq/PeqIjyxChBDkpMVNZS3uVu+IKe223VstvvPZ5MNuS4eLGPX9Ztxi0j35c+oX+UuC5eig9FNeiiDtVSmHqWScG0PooCKy5G9PWnHXoGwVGFIyuJ/18/w/ujuDWveMI8kjMtybCTcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qtWPC36dwbrzBq3VY4EGoKXhXq9G3TuLqhlFaxT61A=;
 b=biCRrG07QBCoLvOrdHqFTUuBqmIGJLBM8hiGHje1SnK3D0LJVqzG645mbgidxpdwIBiiJxLfJgarR9riMYp2kVzhC1RlhAfmOcRdBlEGHLgEhZ09My5AkCE2e6dvMxLrKDKSQZ0FKJSjLtoyqR5R79TPh7YEx4YXejFSu4U/nKNgujnTOvSbFUTsUwl7KabSP91mbmEFMZM6GV4JSRAzUGlo6n9XFw1mbP86JztUR47UZFBkPjAsbo3rIgSxYikKrdn8EoO5gFlWZKZAS/Ix+1tuBRefOPCOnWWqDU1xk0gibFVVkdMG4NG9GTT4rkkFc10QU+zD4gV9xgR5XpEwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qtWPC36dwbrzBq3VY4EGoKXhXq9G3TuLqhlFaxT61A=;
 b=DByG9bcLwAsMzF7YOtBFhAYNAwphHhl0TiEQzGEbKeABRTQdfajS8CcuCJYJsiOtt8vah3ZU8lc35r93MgA5nam7o2rWKRRGFdbH2ajscLz5C7NkinnTtUIPYxf+iR9+rocAJOzy6pRogvx5oR8m/ecDxutFUA+vCaeJUh9qEOM=
Received: from SJ0PR03CA0276.namprd03.prod.outlook.com (2603:10b6:a03:39e::11)
 by CH3PR16MB6513.namprd16.prod.outlook.com (2603:10b6:610:1d7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Wed, 17 Jun
 2026 06:29:11 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::60) by SJ0PR03CA0276.outlook.office365.com
 (2603:10b6:a03:39e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 06:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Wed, 17 Jun 2026 06:29:10 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H4Ujvk1348500
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 02:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=5qtWPC36dwbrzBq3VY4EGoKXhXq9G3TuLqhlFaxT61A=; b=OF0J8vNuuzxu
 baqr+hLj7bnzQgkAleOWO+M/cCJDfT6cYyn0WOp+Y5MUIBEA7UokBKwJGaMZFcwP
 E9f8/dwg9WMEO0MDC5/YE1za4Ry5Frks+QWSr0S162porYPPEhDBOAUCJ32soS4M
 /Kef2pVZoLD5V2277t95S0I4tHqFkk24ofzN1tTTqfv2Z12m6wYkBgdxg0pBaCwQ
 htRk5GmuXkjXIDlR3161I9/tto/0m/S8ie05wyHsPkhYUYgMPTFeRUR+zPOh7lJt
 b3vLO2xkXQ0awwLgMdV+IQEOGvtKM5jYglqRIvoODVs3BERyusJKOYdGWfFMohqE
 gTm6j5l6fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=5qtWPC36dwbrzBq3VY4E
 GoKXhXq9G3TuLqhlFaxT61A=; b=JkuMuyLJZERd/2kalWfjko9fOv7CphrjNSzZ
 5iVeaykMtBJxK/b1U7y1sZL3OUWuR5DxSZ4S3Dll9Ymo3exKdCBVsMti7RVjYiRr
 xX5DCU4xpI1gY293t/CX/jBxxxLiVYzKpQCUXD6LOg1RYinIHL17MkenbY/aNfQy
 jkYCsCGhCh6/WQ6mGZT9cqoPxU11yZr13Hln0puCFxhgiz8Za+ISUed45FKAKqqw
 anUGglN407va8PIMUWcjrOYlUHeIoxvbQwZg2QPzPesEv8hixfYWTrFuKoboRIN/
 GZ8Qg/MsL/8mcwIrj1vUxboOLVTig9O+urZ1tQLX8VhQdMaA3w==
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4euef20eay-7
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 02:29:09 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id ZjlswNjS4ftKQZjltwdwJ5; Wed, 17 Jun 2026 06:29:09 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: ZjlswNjS4ftKQZjltwdwJ5
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
Date: Tue, 16 Jun 2026 23:29:08 -0700
To: Tom Rini <trini@konsulko.com>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: [PATCH v4 2/7] reset: Add explicit cold reset support
Message-ID: <ajI+tBSR87dqYdpr@kraken>
References: <20260603070743.1268544-1-dmukhin@ford.com>
 <20260603070743.1268544-3-dmukhin@ford.com>
 <20260616214450.GA1740849@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616214450.GA1740849@bill-the-cat>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170059
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|CH3PR16MB6513:EE_
X-MS-Office365-Filtering-Correlation-Id: bb210e41-5076-44ab-fef5-08decc39be57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|22082099003|6133799003|11063799006|56012099006|18002099003|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info: bihDG6O/6WU+QNYeyGnDsGia9HZ1o/kvJ3J2W0xCi3gPxmGqoofP547bJpNcQ+Z7uEjc+hSnRU+eAytYhKW7U3dsAW3HE1+hPbZQVOZbZS6bI4R2e2Yi3AdPNcNNeu8/kAOQmKxITv4FcJ6RrQZyQe+ffw5cG68c/FIz+zOQK1Zk3QKvHnZTAZrye1VBB76nuY+BMBNkbK0tUKjrgP3YfZQa/Fc4T8Kopfwz2kx6pJCxT+/UnvsP782V6uyw67a+NS3la2ttOtlX0voUv44PDdhZ0BGA+zeVV9i2OhjGs7wuM6XmdwTOKaIa1CaVeOPwc8pleYBlb8wwmBkasirph+mAZuKDgS1DFywIDMyGk/uLX9ZewdN4vD1rLwmezlGlWCHt++g7cBMehG6oGstfp0KEGFiHvXvoWoUGpj9916VQPqLo9lbkOWbXF2OLcNs/HbGz2HqDvu/tCreEOLQfj3JPC65EThkCZ2Jq3OkofxUrZD2fe7tmDgpSc01Sibv9Z4fIcilHGfYgywLohvZnieMMZNZlYNaFBv6fd7Y4Tm8HK/mRDbXgjWz+DizI25Xe0/F1SrCPXj4wup3f0Ik19rZkeQVnekidE2zaEScfizBgY4QIGWAe7UD/X4JoSgr2g+Un0fTjOPPSRGpINXOgrr11TLorMzmQwgjvxxlFeEydGvRFeGpLzrWIE5ogM1IM
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(22082099003)(6133799003)(11063799006)(56012099006)(18002099003)(4143699003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +/Ybx7JBkT99eudtfpkSR8aValwH9sqJ4Y1EV/TFoB4TrGENmc30/maOBii6iQv1phQHm9ks9bjdteuUdqTG4JBNLzZfAWWnCfdn9eRc6FgehHFW507PRXXJeh06y/MENh0G7svC554/yLmIbSFR3TfDmLE48wsEgqgm9JR8a3wfbbq8Qy4A5BhaCRriCuXoY4WwzVzCqJqFw6vtthVHD2oB7pTgwygAj4PEsQ2iOH3gQ/P9dAxys7Hd7CZdKQrX/iwdJY+iOeWXhp/OMd3z7sAJJvRtIc34CF5eaUCdv9YzSGy/cJ9WTPwBGDQCbRnbuziTyDh/HwSyzHuoWa6/BLgZSwg2CLSCe+ygZNMSp4Rf06FuMZFTq6UYBu8Kbj2wCEnyQfvoGzjKnpQJTU23llhPpYPVbCM24b4eREAAKsQADNEouT68cwJOU76VT3dB
X-Exchange-RoutingPolicyChecked: BFXRogkekWYwMICNYq0x5KwwFeBZxfmVqEmW45K94oU/JpDzCkfneiaQcPUrckUd0NxpaL0rJnVu9tKx4dE2d9LwprtzgvIm9+5Zi1eDMq8+RRTqKXKzOW0IOhMmcSJZ+o4ygROxRGJpm/xBtEi4MB8ndTwV+2d+G/HHHvOaHS4SKiU9yT79RbGn2THMNhWFM211WnIkCcPjgPJWQu/ViFBpHlYl97cyEynDtIi3dkvPhLd2s8Q9OHxZSXBmXs0a7HduLwb6E58c3agz7pejFG8TBXFnns+ztWm6/CJ3a3HkoayhBmfgNWNB1dSpyGCDK0/VbFODuwbPoi3+cXkkCg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ok2g1LWMQV16PIonTZYdUmzgU3ZG5i90UUPDswQNrBKtby8+x1ksVhQc1NCnpjvv0Op/IcwMANjfrsDn/qlKubYQCl1iC+B2FV2fmCZVodNGEeGK9w2hjHLrGgPhAlpu847hPnHAd7u+pACmcev40/IGa1Pm2y+m3jcOWg7PVddveMv4iOZMtxbIu5Pgm4S50QlHuBGZ073QNtSgNBpIWmM4fKLJltKHYgKzOazvoIIyJM/38eYcLHYqFtlTgXW+9ZJZTUO6HZU7UI/Sty+JMNoYOFkigwr6H+7vDr/PaPWDBUlzJXj0/MKwI2231C9ubXLci1u0RiuCEhEPF+fL7RUxysNofRdtvHU00Gim/cIlih629yUYd+t+OeU8F3a/Mav9kvt9bZdyABLAmythv3xbCVDRD1xjy1kI890HvBAX6AuTtpQNWyb3lOG8TLWXD15Xpqc3HeCu9Hfv8+yKXthutnsctFfFRHV/uaTF9Vd4nJRJkn4YgXJT3KSfxBx37nys6PnKLsdMSPE7a/U7IcrxE0x6HDggLcy87sMT6tMZmxd/MGqA7Frd26joI9lps/oXPMJAyNO0NzuNxNKLe7LeMUJCqYZba08c7deOrzbYoR5uqnRb3t1COQ7mpro/PX5JdX35GwO/m3cI0/bNjg==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 06:29:10.9609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb210e41-5076-44ab-fef5-08decc39be57
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR16MB6513
X-Authority-Analysis: v=2.4 cv=VuETxe2n c=1 sm=1 tr=0 ts=6a323eba cx=c_pps
 a=fyslLl4jtBSJ9QFfScbUNQ==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=AHe91QgOk3R4nFVtG5At:22
 a=1VxDqnHFAAAA:8 a=cbNQJ9GKAAAA:8 a=dZwClMI2fhEQOhGrlWkA:9 a=CjuIK1q_8ugA:10
 a=3whSkbs7g9Me0DR5EJEX:22 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-ORIG-GUID: bFfZVSSeq_qDH2d4NnCmgJMeKJm9u6u4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA1OSBTYWx0ZWRfX1oRWW3zmubAe
 8GHJnJe6YVTT63B99ibcydK0k12WGlfzNO+appiiWNy/mIlcX3cEFhimOeqLhSKB8a9aV9qZkS8
 Ga/zrwyRMFQbCLbj++KCRmpZB9oR8eXzlgxChNdG2ArfqkspkD7/vIV9eL+aZuAiUNIDrQfMbzJ
 0RGaS2soXtWARinXcEcfXkCaC0V0gIotQ34hlKgWh6WSBVpi/e12zPayCa48qpWwVO8S1QFwTER
 cgBM1zG7ddixblfzapBPIdJZExCTj0tcj0VPRfl2mk51BLXwhTJ7nBaH32KFJf9Ah4Tq3uNBjaA
 e9Mab/HQLm2GPPSv5NtgzKEVRC52jFKh23TL4tioQcdqTbv0XxDXOOF8iufWFtK/bPucCCDYIpu
 LgSMoUGHhOGLOhiT0yi8FHDgQ6TuGK3PcmxTfUgtgHMjMCNWM7xYdYhF/Dfjen4kywW61eR/dZc
 NFTnNrnVjbcjXIYICIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA1OSBTYWx0ZWRfX5JJxcWaacp/a
 YBTB/kuMq9V7QYMUGJz/BxeSOvZssUIatcxQJ2DIx3VSqKXDZdUmZspf/iMo+zFl1sCbQo4XtIQ
 auUMyEOd0wY58KaNx/xTqMPwGCy9+fuGnagmZtzxPRjlTfJcozlV
X-Proofpoint-GUID: bFfZVSSeq_qDH2d4NnCmgJMeKJm9u6u4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501
 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170059
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

On Tue, Jun 16, 2026 at 03:44:50PM -0600, Tom Rini wrote:
> On Wed, Jun 03, 2026 at 12:07:38AM -0700, dmukhin@ford.com wrote:
> 
> > Some prototype boards default to a non-cold reset type, e.g. warm reset.
> > 
> > Add 'reset -c' so users can explicitly request a cold reset when needed.
> > 
> > Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> > ---
> > Changes since v3:
> > - preserved existing behavior for 'reset -edl' handling
> > - corrected commit message formatting
> 
> This, and the subsequent test add growth in SPL on platforms that aren't
> using it, and then one of them is now too large to link. Looking harder
> at the code, we need to start out with some sort of re-factoring to move
> do_reset / do_poweroff out of drivers/sysreset/sysreset-uclass.c and in
> to something under cmd/ (and not conflict with the non-DM implementation
> of those functions).
> https://docs.u-boot-project.org/en/latest/develop/ci_testing.html is a
> pointer on running CI which I forget if I'd given you for something else
> or not yet, but would also show the current series failing on the
> rockchip world build job.

Thanks, will double check CI; I haven't tried CI yet.

> 
> -- 
> Tom


