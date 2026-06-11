Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E60CD98C6
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 01:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49F2284928;
	Thu, 11 Jun 2026 03:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="wg3RSsJ1";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="ZeY/N9Ku";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="nOsvff23";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="JANv8LxW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 524378491C; Thu, 11 Jun 2026 03:49:06 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BABB2848BC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 03:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482515.ppops.net [127.0.0.1])
 by m0482515.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65AJY6I5551251
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 18:49:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=q2IxBr5f61G6jXzpEGLo7Y86j
 zX18Vz4GfxEr/hgANE=; b=wg3RSsJ1irfUW0KEB+o2JUGd+nn5c1yGjksJawfJo
 713hgbnP2JnDqcxIGeO+lZsKL0gmr9JSqTCQby1ZVDoHfpMu4zMYX7X4BHe7lroZ
 XlsYvNKOmyyzSEjsub1WNQyodLLUChKGNyO6qsvtJ/3nsDhFS7plNkJ5UacNfDZL
 reSwr1kepHHKqZIIwQGofeE2BB9JnsixwY1BLeUS3mKGneI39hhRyY8fZ/uYvaOL
 KiIfygQgQ2BZlXrVW9t1T6um+b8bXqiKEGK2wd5YjjL2wsUqWi3lby20ZSwc/QVQ
 zm6cHTBScyhOdCBRDl0LMIu+gCSvCE3brL2LVV+gydl7A==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
 by m0482515.ppops.net (PPS) with ESMTPS id 4eqe6uap6m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 18:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=of1KHix/+/7OqGv+i6Yvd1l/u7fXpRRmOVb64TXOv6lbmJC8zxzt5aZkfL+n+v5Y9yHdLLsCwE41a2EQB//YPyuTODw2wGzL/SjPwI+SovFlgrY53mCXV09ElG9xsQyIShwrQFRYUS18+Bra00I1p+yrZi3IvDQ2vJ6mbd4LZ3QT6DkGlZD9+q8YnaaKM3I84NfQcDXq/Hl1fpTXurlGiP6UFfF+tZ+E3zyC3FSKPihDvmchYdo0oUC640g8rYUp0pyCk9+11pbY71kqJbx/Tt3MGmLOKVpDBtjQNg92Gz0P/UrmtSoy88tgkB/4U3ZlSW3stGkEW8/aVRahXYmFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2IxBr5f61G6jXzpEGLo7Y86jzX18Vz4GfxEr/hgANE=;
 b=CtTvNmWTooNc9FoPC7HeaYvWdcQBsqRxfqRnOeH5HUCSwqKKR4c2Z139HpI+7+sZVIxK/XKhO60mtD305ucZpIW2CXTNA9GstwC4HCPFuVorK7VFDRyRzSpdq0Z8buk9MrBjU8cC27TygMTeLamEtcrewiArj9Em81WDMv8YiizzQr8BpLD+crPrw1VUZTSFYs5jJJ2OFzUvZXw3stSattv7OqHz76p09fPGa4V6W7hKC/qLOkdILjr9jvsM7HDvI0/kV9RLjR7V9vc0ZWpKaWv1cuV5wLZVRL/tn+Y2H5paGLBIXtn6CThCo2/ePyHusDOjsucVE8q3PMTV9sbqqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2IxBr5f61G6jXzpEGLo7Y86jzX18Vz4GfxEr/hgANE=;
 b=ZeY/N9Ku0L/xgOe4TgeNQ2iA+0VAkSsh5EHI0xH3SKGdKEkPD/0RbBvgG5TMckyNOlwMXmHWmWW6ZQuyNohuMew8Kabghk+fDboQYk/rk6qQe4D+NXbO68ZQ1l1BJN+PKrcOU3acd8GoA39wsSwyNw3ZMwijcz3Il/t/ypC7X+A=
Received: from PH7P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::18)
 by CH0PR16MB5297.namprd16.prod.outlook.com (2603:10b6:610:18a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 01:48:55 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::43) by PH7P222CA0003.outlook.office365.com
 (2603:10b6:510:33a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Thu,
 11 Jun 2026 01:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Thu, 11 Jun 2026 01:48:54 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B0OZ7M1018975
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 21:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=q2IxBr5
 f61G6jXzpEGLo7Y86jzX18Vz4GfxEr/hgANE=; b=nOsvff23BWRrV0o8Q1xAKUx
 7YCPpqr1qjymN8Fv6WYms/z70R2jRUp3/yZDajHTd9UkQOlPrcJ0ZhFpVoXKRMEg
 AmcvI8T76bEdfOwGg1OyAV6dt4GFMaqSle8eXDcAB7tvCG6+eonuNB5LFLeXCO63
 TAwcwnh0gmhIYA1SUTRAgiLBMmCLTiFJQBglhjtxURkbtRPE/rWZNTTSP+aRK7Z6
 R+sOZSQHKvbDa92D023NUur4ypJ7dSOmt74WYcpvqbh1SZ3W3j54vp1sb7Baj/Bv
 NqJexNq/0O87AC2ZdwH7HJo+2bLWP97iuGPfMPPPuJuyZog5506Qszi5G+RLA4w=
 =
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=q2IxBr5f61G6jXzpEGLo7Y86jzX18Vz
 4GfxEr/hgANE=; b=JANv8LxWd82aCq0yyjpww6JtGjHcz7FRf3HifLcGLafau49
 cAJyO2+Ia5PM7LSLniOXRmuqRkoJTLl9dLuDMNes8UiyXfvwIszJUlFf2oF4mKCS
 wHwkDl+n7cHEHOtz8Ve3OAsm0RGvbBH3m1/dh3ppAjG8nbZGkZImxTS3oe9DBJMX
 eEpeO7xv6pylpQYsW1tCXtdONmMfvdIZ1A2OEBKF/r6+sJlUdpNGkK2oHBsgFtXB
 6dE4iiQwu4cMsThydFsiPf6C5bpom3klZuDeuJZv+ebG0XodpyoNUxV/NgIFRa23
 n87SiU4mu3KzG65ned49m4yqNOPDc34UOp/S4nQ==
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4eqe6qgaep-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 21:48:53 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id XUXMwhcRHfWWnXUXMwJRQl; Thu, 11 Jun 2026 01:48:53 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: XUXMwhcRHfWWnXUXMwJRQl
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 0/2] bootdev: few fixes for automatic boot
Date: Wed, 10 Jun 2026 18:48:41 -0700
Message-ID: <20260611014843.3735672-1-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110015
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CH0PR16MB5297:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cddd2c9b-ed9c-470b-b6e7-08dec75b988f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 8IkVHlTFqgxUUyp4Ug+A0/3ekUZyXQfoNYEkNb9XQlIWP6GbMHJQtwSsBcAmdKZ8XRvZqUu73yztWhGQz/KaLeoBud0XdSKuOx+b0//OdgomRaHznKfLaSPd/fEXGea9UbbiXJIB/nFX3/Zz59AFX1Ulikmk2yQpkRKS1V3BByNd69w4Ws4hZLON89GaKUk2e631uTSyZrf9eXZuB4syGLHYSaIZOFMQdsglPUeYQB5wlJH/2Qs9Z9MdL0cNGtgJMFpToKv3murICpRCgy++Uvrn6RA86BbKzCjEBD73mHaxGJM78gzdAf3GMWFKDPwUUmD7hBX/IH6VV8f4gfLcBb3QjbyZCOEWTmuLD3Y29/iKqqd6e48aG561PQPgjTiw+m2F9Tu9M9w1UekLjDvSA1w9K5pO3enUqL36OGOXzwL6NP49wAwpUAwr3U2WAsOtO4DTRK3PgI0yEJw+MCuftL4kGDG6kuDmTjahwpoF/YxpcnAQML+h1cB9vDBuc5rjx73VhmOpeOteYZwSAmuKZDsaFfd1fmoKAlcergxSnNeuZDs8wkpMkcwZhoX4rOGyiTb9akWsJ2LVr2oyLcCUzCp1yP8npwdnYNAN59z/cVoNkLzG5k+Ff0CnQ6HlH9LaEmkmDu+9KJKwRiLkWLsRbEaerWuR/XGhQPCLurwXzHGRuzkaZuIvyv7rvPMIyw/E+bBXqI8v26i2KCr18ZDEWDS1DPSChoX3BQ/5MDgSQXI=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZKX4nU4+yEWAxZnaHomxxJoSOtCzgVKYuiNzJnfSRBjwaAdpvkzCZh+iiBT8bCspVjB4WXyTxcbBND8/zBQdQBdXGcPQEqWUsj9orD6VGGUZjB6niu/L997WtSoYgHcW5Yp2MZT2ESIQ1I+/SQEZcnSaIRXaZ5SGO8hYtJwYm6uY5LTvGoMh+iJyyyIJR/X+YH0nLJ7OxGbImm/xbGDcPPNMfMP934QibwtEK880ChtFK1oQ2aQwQSnqY1dEveoYqkgnBmuBJwlFXZIinSrvBoQdec2r1pBPi2QXaqtgp/nD3T8JxtJC4+utKIwuImR7UgAUU/2FWoTUg8FL4mwik+ipueiXEbGLEhstmPu2RzRhn3c5o5EOB4THC7S5M1TD7TvJmVn5IEIgbyyI6tilrLSVAnsAMU4c3cedqUxMiiYY27lcBAR768wy5BRk50zn
X-Exchange-RoutingPolicyChecked: ZtZcp8YG5mk0KD7pyHY5CnU07vj0IBbmhkdZksl0RATiQS35gRMA6nI+sgIqPonty+hLxyUDsVALcuzbW96iKtOXYPwipjUst6Mpkp/BAXM4u/51IARoETsxahNB+PIlW8NaB7aesiFtUtXBgea44lYgn2wVFYVhxD/Qp5wrXuQlkCbEb+pSGuJ4fzvpWm8/409ZbjJeyDS1Sel4JGHOKB+mkKc1FGHaWRdyUD5adIvUOuFNAk7thxxmRTLaJw2/MGyztEqtr5lO20Kf/sCIrP1J3HXJdscJVZonjvzD4qeTPTrqiHw8Bqf1DONer00j3oK83MK8rU6aaXtIwNKKhQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: djZsK9YEUVngkoNHoy86LnXQVw6/BTXRnt2tMLpFDsTrbDFADh+qPDHX1mX3yjuiJZPB8bsNF+mgnG7eTvpqs56QbuMhPIP10BSL/cnmRehM3HyK8bJ86XirIFB2iwFtHWU6AfBZ2U6HmoWC33DBTlPtwSi79jtWnx7SUMRswDvxVG1l16tROrSC1mPwYGQKfkVlMua33v+ZoWLrVsjR3Hu5t2lyNsCEUnOwfaHX8QbwDLLRxaHHq0Z3Ot1Vsedw9zyzYBTEAs9+0YkI7qQghsPee1e1e8poGUhUYP5N8+8k3lwgASG4vT7EAQgZDrMbRTFGOPEqjOWBRPp7aLZPyf0UpiaN5wrtObC9WWysZUwlZ9whi4UZhp58RjfOeBjuEmaVriyKfWS1YJ3QKMpRMZcbOHv4xoisq8YMdb4g793Q5KHwHMei1L54GHe5NEZs0ZcJbWO609fBnpSA1r6m+N7HYs6ggCzye6vzHbQmgXvN0h7E/UynSw57KgU7kGLsrtBlt4O5VewCz6NvfB6JPhrYXRMvVEawKcm93CvCW03q28Zn9BgZBY4BTrg+bPW0Zpr16Xqa8CM8/iFvNYYd360wT8f8rtpQ1KSznIsOKx8Kb6sHYDVadGz7lbxKt063+ACwfpYEgonO5aSIUH49Tw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 01:48:54.7118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cddd2c9b-ed9c-470b-b6e7-08dec75b988f
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR16MB5297
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDAxNSBTYWx0ZWRfX7Kmrp0NdV+/g
 houMOE2mhmykPsLK3IpOsz6vILoRuLXZvi8ipVN/Doinf40282ONjj3s2d+/vs6ue9OWL679rWi
 X8amKucN5ciwUubID3FZWUIiIgViCkrdKYrrU60emuW2vRmeRldibE/kONTqBdiF03c46GTc6MG
 56yFZrEwFeLRdDOnRC+0pVjFC6uTk2YajhAfjL4678+9kVFUmZBLPWzn0HHDSYWncGXvofq3zzA
 l0ogcYKZdv5+uFKuu2c3vAlVEBVpbUn+Yw273TY5PoxHewTF54puVA/fj0oqV67v0JweeyBxfKZ
 bkgsJ/2W6VVAmJYC+bsYBJE/PjR26RwrxynwdxgpH9Q1q2TeUqAibkPXByi87sMZWXvRR7W5FfM
 7SauYKtxfPk0QPbaeXTM27G/UQvD/p9IULwIXoBBT/8D5OHT90+bVqTXU1m8wiAJd2JIYLeOmQf
 B1CbcEsXGids+zVCUsw==
X-Authority-Analysis: v=2.4 cv=JvPBas4C c=1 sm=1 tr=0 ts=6a2a140c cx=c_pps
 a=cC1MplHVCFGqAfo43Zf6QA==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=0GA0A_IKJoUHBEAzNTkD:22 a=suQ2AwccuV5Q8aL_zfQA:9
 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDAxNSBTYWx0ZWRfX8jt3ZwuxoW4d
 tK8KjvkN3zy9GOUsRr1l65m0uBC30kKUwitXmPFTViL6JIVDYtBkVL+lxyWUR0XO9Ze4jBwq9Kd
 OGof2LZOm9Gfyf7sJ6mRmuDBINRiWrZU3dsOr/vBbc7v/yvbDdGu
X-Proofpoint-GUID: qHGhTP6swiWvZfY53nbQ-mh5aQLSdJTl
X-Proofpoint-ORIG-GUID: qHGhTP6swiWvZfY53nbQ-mh5aQLSdJTl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110015
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

This mini-series addresses few findings in bootdev code.

Patch 1 some typo fixes in bootdev header.

Patch 2 fix for automatic boots in case of high-priority bootdev
        cannot be hunted.

Denis Mukhin (2):
  bootdev: fix typos
  bootdev: scan boot devices at each priority level

 boot/bootdev-uclass.c | 2 --
 include/bootdev.h     | 8 ++++----
 2 files changed, 4 insertions(+), 6 deletions(-)

-- 
2.54.0

