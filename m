Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0BDCD5BAB
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 02:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDCAE848B4;
	Fri, 22 May 2026 04:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="Mej9Zo3d";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="Pn6qdUgX";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="OsK0o4q8";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="clhbgM++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B65F984878; Fri, 22 May 2026 03:23:36 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8729E847B0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 03:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482516.ppops.net [127.0.0.1])
 by m0482516.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64LNvs1T1412759
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:23:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=srb
 yLrYBrBKJK3SpsIKV1XodFF0anGOP9affSTZsgog=; b=Mej9Zo3de/Yjs2lG8mW
 YMK5JuoI+aBo6SsH9EBVBp1ShaFh34JVpcdAzdvY4qYdG+2/hZQDWpYJqydkAO4H
 5fTUNaM/nvFhUzxtp9oDNIUMmnMHVtSPrIrOn/Dyk8hFKE0vXInP23dh0qNXuelD
 Gr9oh+GCxz84wCGM6K4Z6SJeZAOhju5Xus3BdpOlA2LpbyMp49jWEfKVGNw/gKNx
 t4vAF0nNgQBmc5exIdjCnApP/rX4qSH59jiQLH5nE4pX1ZidNpSwC2RxTveTuNQJ
 u1RQc1eDhmp/C15CbHOsZKJDj0wj627kzETj1zIprzmzfx9ww3VVoiWN8ytGWENQ
 T3g==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
 by m0482516.ppops.net (PPS) with ESMTPS id 4eac6b0dw1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwcRq82zIkNDV0z21Z9lfAuz7vEaBq019dVwyikxBTPYGTuD6IOJYY9YX18sS7pB3HQ4KhYeP/uIhVeXDp/83EIbwctb1dToKGtX9QHyjwZH+EhqIUwGj+wEMTzWbDrVT99sUKiCIG8Rwk92Sb9mjX22d+4CgPJEzLh50pFtz30j1Wk4Xd3zSuRdK3OhIkdLkAWxOT+xdSg/xdbIlME9Z9L3sC8N69mkColpWAkpre5Zzw6ZyVjqEEZAbIfnq4t8+qvipQxSF8H0ZkOcHsgDBKWb4MXBUhLMdr5qadWFevkynsSSsu6qmYzdQgc1NeoNfAfRQj8nlVmbiestHgjjxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srbyLrYBrBKJK3SpsIKV1XodFF0anGOP9affSTZsgog=;
 b=aEpoNo//ekoSnD/G67MM76vRz78fGsQv+0ubNBU/d3arx0rCaYbQeVuGrG8ea2Huvn44CKrxp2liCTDv2OTBiyKz54bAO6K6loxBMwDgQqdx9IU9jWu36WY249wYCOTvUOKBaRQvyBuNwDGjFs4pYtHfHwc7FvMd+ecJd4EQ5ieG8XAe/2Mlonjznahoktgh/OdkGW+q5yD5BC7Had56RPwmjGZhHL16azEtr4BZvRd76zVsXXRvg4ZcjcsCO5c3l9oYZWOLARDKJN+sZxvInUmI4SrprRQhPahjO8KJY/7G5m9HM/jjbYIxuutpjztoO282w/IgvegvKQon0SVNTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srbyLrYBrBKJK3SpsIKV1XodFF0anGOP9affSTZsgog=;
 b=Pn6qdUgXQIi4YFkvmoRaJpznMDl4jbzWO4GngtXTE8AXELOts0Q+v1+LsaNa/0pJfTMwtb+IZX1jyL0t9GPStwd0ClKiWs1YzoXro/veBB37jGqWQ2joMlzW4ws9D3b1Qo7zwgxl8S6L5f1VzIMcNtSyECpEtKH6tHvfR4dhS9A=
Received: from MW4PR04CA0163.namprd04.prod.outlook.com (2603:10b6:303:85::18)
 by SA5PPFAE37514D9.namprd16.prod.outlook.com
 (2603:10b6:80f:fc04::91c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Fri, 22 May
 2026 01:23:28 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::ee) by MW4PR04CA0163.outlook.office365.com
 (2603:10b6:303:85::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 01:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Fri, 22 May 2026 01:23:27 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M0g7nY728084
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 21:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=srbyLrYBrBKJK3SpsIKV1XodFF0anGOP9affSTZsgog=; b=
 OsK0o4q8h+Cu631DpcpaN8cVxZVgTJSEsAxBhi6sPjU2zjCCwAQZUqqWz1E03InR
 3vkTK+y36lpVy//ydFwRKMzjWyecq5ftIcg1i4ALp1DG46FQDA9j8E7AwN2BCZzW
 qRNajZTvBlVnj6OxRA4qlEyFSWZPzwdnyGWEwXx4+lb+2eJKn3gsT9lbHmtrC8Ad
 X3UU6tKkHE2hiN8DSu1HR5OmZQ3NHCjla6P6CgPAOiWHujdNfv/xhJmGhN3yYjc7
 86CW/YbtcLQFImhCeYomXBMK8pPo5ibKwVfoit9Pj8/mUy8T/oq8IlOlOEF+3rTZ
 12GwY4RDWnVkJ9t5YBNAdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=srbyLrY
 BrBKJK3SpsIKV1XodFF0anGOP9affSTZsgog=; b=clhbgM++HGRzraA8OKP//sU
 oURLcrRyS6yLAY283eN8TWvdI9Y7hfqvo/dOKmarHFS6AN6Ymnjnf1eoUd+YQ7eN
 G/yqmSk7lVEfZhDkCh0aiP02LHutZh09U4bqAC+VQ1rzYEU2z0eWFYrcaSmoD/lj
 0dMsejxFuMDTGznPXGbCjfujEnhgHXJYWkH2ACB/KZR4pVRUivaO6vJu92zjUsuw
 +gGf5BUPr89ZuBYh5LOdJez3uGc3MC1CoiXmX6rhlIqDH8Uz/l9p4Cqdr06zpmOu
 6gX8pcNlhVZARg1/weTwwbapzOjaWd/YKG5sxPGzZh3fucZlZRJP7h/U4v3M1sg=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4eactrg10h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 21:23:26 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id QEblwwRT1tNm4QEblwdFlL; Fri, 22 May 2026 01:23:26 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: QEblwwRT1tNm4QEblwdFlL
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 1/4] reset: Allow per-board reset type
Date: Thu, 21 May 2026 18:23:09 -0700
Message-ID: <20260522012312.860026-2-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522012312.860026-1-dmukhin@ford.com>
References: <20260522012312.860026-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605130000 definitions=main-2605220011
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|SA5PPFAE37514D9:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 08b42f15-403c-4a4f-e7e7-08deb7a0ba47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: GheunxFPnZoRF8UxcOo93y6yz9tgoZBEIfUb18Yz1qDjlaucguVQuiQDI5Z/Mv7ExoZ7NYkCmunYIMjswB5RWqLeR27nA6qO+A07EHHmVwnZsDFNk1JB/mF8H2sXDRwNIh2tvBdNtSNYh6dm2x+xNlYqtgD5hnf2iLgcMUf+FLu3iWv451Y4q0G2DJDLb3Wcl8zKfnWF9Yu4rP9igPhlSRchaZCRxmofMh0FTG7Y9ihf/BWybVHv5pmgyTV9oS9nJNyYGfJgTxyy8fdSPA3r6Tr/5pHZUQJCwnAob8g2RSHz64aJxqQmG/MzMbbeamKLSvJTp6x1t8TugdoIsGL/wL1KSu8G+yQQpHXStsgr+d/RqX3qGh+yT9fPNRZioQtH4JikNnfjrnS5O+u956k/JQ1oN5hm1zkPwpkI68cVqXiwdPFyMtwlgrcK/2sHkkIDLtYSTpVKp8p6MvfWCFLPRsoT3m8aD9U/YQ33UHiGq0ZTrvE/8CbpLMmo/CBrJOMWuo8v93leEp8HItaXzAy3y2RLlDA9oYZ93wYPo4VDQKD8VPEgLJzLlXdhkUmlR06rxOUSnT9qZu4m6FI6nqWptsfLrU0wyUSNcLhElAecGmk+2+UOgBUXydoZh34birVpj7ejxEpecZtdfzfRv9uTy5ZlG40uJ3C3eqeDvSuMbxU1fIb9bdbV4GAnpC09K+AqIT+QIr8N91ZJd4MuAPhpgTtCUwDrkOrEzLFoZbnl5Qo=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hK3fl7oZwn1X5s3qQ0X+AB70GLgI4PSWX9hVo2/coLIh6XvfugKQw8g0nV9+wVaibrVIBmpCgD49M+7b09zA9622RjF73mvFr6GHffFcSt5+LCwK8LFBb23ejoAW6PJsgTT3ucivtSPqzqYHu8GpbdFYlcizXVgIPqKRcaQqJeeTqoReqRcaNgXZiSa9NOG09ZLBzS72tUWaEx7CZXpwDoiiMGKMZ8m5Ie9mjUaMPuNMP5v33QNs/SkNBTKSrO7OiSEkLlEdC24yrbwLUmTjgqYfPYBQ2OLq0/KLh9i/J8336c8UosNQOiuTcyodbw1+L9O5UbkU7MiNHQwOHnigJR4O9VBqzEUZWTPSevzP9jPXKuwN2zO+f2Fn7u0ml/ZDOKrznq/M1VwwPhdxw1x/GWCF5Hyb7pS2b8DIS5zYkl/PIcS10PD0XaTDZI1eDZ26
X-Exchange-RoutingPolicyChecked: m5sVAwfW3Iow1yBlTmDcsiFs8IyekoBff01m1SDgCFb4z3JhdjMuddnUEXsHN/RqCWq3OyJPMWeSoNMJ7c+wPWjCxJsONdH2ZI5uo2PsohL3wyjFNKREzzrq3cfs529UZnap+ULE1ebHJeYxdLn9B/M+rKK1nOmY9TTZ7SBl2SFFwKQUCdtREntZKuneCe9LpoZD2z8rGeo8g8Lw/egKMVabvBaHFWnAFPKd5bMmp/65S57jEtB/qEDdEtAKIvR+fGU7Y/nklOteAKqOmjfrSxx+VgaTtYBZ0DdJUKJWPhCZ8rEQpQZiTFcxLv/0Uq65sUhS62/GnPC5o3xH04ccsw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oVAW/rxxwaBAe5N1rr/Z5oHT1tReuJRMMyTAGTku+EGBbLFdQv6NTJHcXwJErWpIUZuyWkOfE5bIzdpq4Vj4obqAV7UH4v5X0iOqlLy30sr1wuqH6rGno0FNHIxCTWUwpmcuU/GVIsf2/eFDA+pXxzDymBCLz2ne2siCaglvGPUk5PJ28NJJM4eMiZZ3BGo4Wi/uzKR0no6t2gvYprUXUe2ZeP92Gz6pypzcJjp9KBpJLEWboTBDlBNNZF4e5Xgx4ulEqgWU9IpegcpeED8FIn+O8l1GxkMnW6jkKw29u5x4yy7JEJyzBoWSJH9hStwPWbDlM3fKLRmYNswAyHgEjEb6aLKSMJ2lTaRxvcOn5yw8JEPppPsH3BaeI2lal3/bK3/Afue/N8Q5Jk6On1y1/vpThMAPlcShGdC/Zk+Q0gIBdEzBGDJ23CfyrkZcBCN1wwcoFOHHvfg+S3uRkgXddWwUx3NgkD1PzhojLZTVfJARV40/sZiWv6WWHC8CkfscZDmi1rNgGreNibKPlCkYiYG82XDfemaOk7Wb+dW/e7ncnMvkZb3kDmEzFee/noHNH6I/y8w+9bJIZH5keOBk177omhC2mMVLo5iaVyOUlrWZVUbngbBJOYisq+wyeAF4pcRXDTbEnUynkYXwBp6sDw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 01:23:27.8879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b42f15-403c-4a4f-e7e7-08deb7a0ba47
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFAE37514D9
X-Proofpoint-ORIG-GUID: L9EtDuual_iKJPm0p2KzPthnkrN3JmnN
X-Proofpoint-GUID: L9EtDuual_iKJPm0p2KzPthnkrN3JmnN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDAxMSBTYWx0ZWRfX9vBhWc+lqXYa
 VKsCnBE+2Z1V9cuPMHVyy+sUI5DekLxftmcPcWe8T8hFMSYvpIMK5o5S/Rt8+IspaEJ7WgKkEGH
 6V+Wo77iA/6pHKi8KmNiAqXSOW82896SR7tTxo/h6hPHxmbSe70dVXMIYQLe396jzKV+pcV1Lry
 RAo9Lhtb4tNB98FdENBwucmkqzUB8zqfByuC//DkFyuNfsQ+O/HrWyifLMt10G6hyd1W1cGLKVp
 8P/YMX9BdMPgTcMrNkkBeV4Lkgb8D/dY+AQdpPP3VVlCbbtSQ8bn9H7DFXd+jnpxpRXDYQwpEFP
 ozyT0ARmXVqn9uKnrZPxzgSUBdi492OfjAxwelgWxUxj9z38df0G2WS7UtqXc53DkHhzTQO5FU7
 C2+0ojj7UuvJ9mxfzU6mjAwDf5/hO4NwE2hV+hNx3I8VBBXOQGscK6aXgI1m0bkjuphtri+HjKv
 ZPMayJfKMMIYw4hoPgw==
X-Authority-Analysis: v=2.4 cv=Uu9T8ewB c=1 sm=1 tr=0 ts=6a0fb013 cx=c_pps
 a=0w/E51Vap1Xy1BB5zk4tLA==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=NvsXeTrgx-CJMFV-xl94:22 a=cbNQJ9GKAAAA:8
 a=VAzoJnNMuzy3fK8yYIEA:9 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220011
X-Mailman-Approved-At: Fri, 22 May 2026 04:13:03 +0200
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

From: Denis Mukhin <dmukhin@ford.com> 

Some prototype boards may not have (temporarily) all required reset
types supported (e.g. only warm reset supported).

Add `board_sysreset_default()` to obtain board-specific default reset
type to enable `reset` command on such boards.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 drivers/sysreset/sysreset-uclass.c | 7 ++++++-
 include/sysreset.h                 | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index f25e09e9cd06..dc569a6b8ade 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -150,9 +150,14 @@ void reset_cpu(void)
 }
 
 #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET)
+__weak enum sysreset_t board_sysreset_default(void)
+{
+	return SYSRESET_COLD;
+}
+
 int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	enum sysreset_t reset_type = SYSRESET_COLD;
+	enum sysreset_t reset_type = board_sysreset_default();
 
 	if (argc > 2)
 		return CMD_RET_USAGE;
diff --git a/include/sysreset.h b/include/sysreset.h
index d1cc9ebc542a..a9e743c13e8b 100644
--- a/include/sysreset.h
+++ b/include/sysreset.h
@@ -161,4 +161,11 @@ void reset_cpu(void);
  */
 int sysreset_register_wdt(struct udevice *dev);
 
+/**
+ * board_sysreset_default() - Get board-specific reset type.
+ *
+ * @return:	Board-specific reset type.
+ */
+enum sysreset_t board_sysreset_default(void);
+
 #endif
-- 
2.54.0

