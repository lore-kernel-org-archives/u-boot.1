Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D84BCD6E75
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 03:40:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AD6884A1C;
	Fri,  5 Jun 2026 05:39:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="RUvFxJER";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="Eq85D0V7";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="nCHBVcN+";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="DXbGFYx8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E013B849F3; Fri,  5 Jun 2026 05:39:38 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96E8D84A02
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 05:39:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367127.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6553T1bs275273
 for <u-boot@lists.denx.de>; Fri, 5 Jun 2026 03:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=Rp0
 UCd1tv4ULKJI3WuJdi70+YKKsbtBL8xII7zZW+yU=; b=RUvFxJERsfh2yQyyp+g
 EOWIsozAhTPC3HA8vb+uIoEPDexA1eOfHSeMwsQ/EnFctjOq52ycjE0Lr8tPqzTZ
 3F53RmdSOMArx0/3OKg79QoWf5EjVesnplbgbQbkmpre9Bzx0ImFwT6gbRH+bXUj
 OCimTJc5T7lb2lAbcT1x5ka/FNCWEwvxoNgtWuHH997L/noFJ9a3KX7cba2R5JCW
 2CqQwcbmK6O+/2/LSUzKOsPjaKB1g4A5SZlhB2sFUULqMtuE5knpgu0KXtPo2wZE
 Bvze3FjdckGQl98TlpnN9U+c2y7qLUpHUVm0n+XaroWCP5w/wmojpkkS7Ic+kZXh
 Q0w==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ekpkc017t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 03:39:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VP7WhvoAbzhyYfy6jG0cs8SCi2ZjNJaeV3qygJcNi+wt5OW1LqmIZPrCZ0gTuPc0dmNALwfI2tsRYbjj8+hdc/SE6ZWq4jQzxb3TOkw2FOa9vXwyMYZqAQ/mXQZiCFrfqF9402SPCqRZvi8II2i2OmxuZRJSxJA7H/1QqAI/Qb3JdH2viVbx1xEDnDuEMAGhSYN9i9G6ji6qOju8FGl/WYA2fGLSxpAKKp7RlL3fV3D2fgF/u+3xeC16zOCl8RJnWMIecCol/BLd1QxuJKFzeg0b5KK9PVrZ2h+ndV3ykTtBuSOtMDyIC0Z5YDJS2LIMrXpzT/mjUHHEFLHdSMCxbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rp0UCd1tv4ULKJI3WuJdi70+YKKsbtBL8xII7zZW+yU=;
 b=bx/eqW8w8obgf3RfsRDZmZ/jLrR2Vw7QsUp0fPVOOSN3r24HDDnmwV89FJKwMJlPtGY3BDKJs8adPGTRLwX5VGen6wKl0Nh06wDrA55hIwNwyw0KsH0eMEKNFs5y9BP3GNDjjZAaozKSLgbgtiOHN0Ej18gthGd7tzC5bqmxUEF6lqJBsZuaBiBhh5OEP3z5tduHWdTUozwEgF9gUc1TLPBCMBMCT0Iv6MWFDq4mt7Y5lDpIIxw6RytVZG1GjgtIKdbmkRX9gPuhxLPGP3hNLa1m+2bODJXnnnSGDGYUSadzsiUm44PbbqJ0L4fzEvbHYPTzbaqg175Uf1VRDO5umg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rp0UCd1tv4ULKJI3WuJdi70+YKKsbtBL8xII7zZW+yU=;
 b=Eq85D0V73bzemfx1vez+BXKOrdEqfzF69D4Lp6ZOr83H0TO6qmdXyisG23LGRisZzkRF3KptRNV72k7KUnHxIX/hxll/fng85k7bX0/XZgTUtiQ8bZNRIHZZyyzOz3VLqS3zoJmZ/a5E9tqIEjyihTrJgXekgOiKqcxVGWiIPjY=
Received: from DM6PR06CA0076.namprd06.prod.outlook.com (2603:10b6:5:336::9) by
 DS0PR16MB5461.namprd16.prod.outlook.com (2603:10b6:8:168::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.8; Fri, 5 Jun 2026 03:39:30 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:336:cafe::f) by DM6PR06CA0076.outlook.office365.com
 (2603:10b6:5:336::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 03:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 5 Jun 2026 03:39:30 +0000
Received: from pps.filterd (m0373460.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6550vhCf913809
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 23:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=Rp0UCd1tv4ULKJI3WuJdi70+YKKsbtBL8xII7zZW+yU=; b=
 nCHBVcN+Fhz4vx4Kwmxc0HX71oamn6Y5zmH0h+XpAN/spXWSBInw+CGIEyrdFMKC
 MCvhLw9LOdEs9MDxjTEXqPnQZgZ8TB6u72Fm3ZyHVM4QVPn2t0lm+fs6EbVqPCgE
 Fj5T/rjjJrIdcXlHfHsDIkR3T53dfC0jBIAijM7M79Vz3iwGTQfGH8tD16A6h7pV
 JL7KrQFSAeHI6XFwBKkDL5DCln6peBTw4ppxAFVaXA7tILDxxNK/HWee560b58lH
 9ZP/Wa2bBt+Nm4Vujht5VKh0L466baIMmXPHmXUBYdM5WkmnWcMJ0Gj6P3tcZffD
 HZJvjtabHKPlVGCWQEoS4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=Rp0UCd1
 tv4ULKJI3WuJdi70+YKKsbtBL8xII7zZW+yU=; b=DXbGFYx87bTDgPkWFcuFLn/
 /Vgty08dhDr4WmFNiDhcELciKeFQYEuBNzG+rI0hBpeo615uQHfMJgsz9wibegjn
 XJh7DVCPb5glRV3oJGJdiLmy/2ZncE8ffmK2H1w3716RS4hiKecJ7y7jgt/FFCaa
 NUQdDwZYGCHjbkFandJyH4d2LlViqskJiYD1h8s5ZNvRdWsYEBSZiflBp0atPhC5
 alhVhamGZsEjZqUnI0TRRTtQmUOKATLGXWmr25HrYk/WKYWm0hldkbtLpnGNR4fj
 +wOV4+txnwuaPwYkInorqG+/eosGssg0KjEaaZhw1biuHGyDIcQqEduq5fUf0OQ=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4eggry1cb2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 23:39:29 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id VLP5wrZ3RntbrVLP5w27LZ; Fri, 05 Jun 2026 03:39:28 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: VLP5wrZ3RntbrVLP5w27LZ
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 8/8] bootcount: gate bootcount_{inc,
 error}() behind !CONFIG_DM_BOOTCOUNT_GPT
Date: Thu,  4 Jun 2026 20:39:07 -0700
Message-ID: <20260605033907.1909319-9-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605033907.1909319-1-dmukhin@ford.com>
References: <20260605033907.1909319-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050031
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DS0PR16MB5461:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d9bc1ea2-3f83-4035-8954-08dec2b40d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: yxvvuQbRSUo/5z0CmI6F42ry3bN/fVPtMJtBSmDWTKw+3fttn6B9G/fxYC9VfrI3UdN9QU9tV3zqk9ibrJs3u9F5QU09C3GKMN++NwxpOPNA6NXIvSkJiVP4milb5aZxcCoWkAfz/VIoSdKGImEpgQMkO/29I7r8bgZ8rAQ+6YbpLSq4RVglVfyY/EsSh5mZzYI1m2CMmjKD1yFueeKu47t6LAHJTIqHHNX9dIW8Oo7XJuSLY1TSYzIPRhMDx+rpa11rMD4BdpyxRMlmTzGjki7MEu+R2ge6zhiFDs/QC/d2LqbZAzTN7vFRtrnWqEWYe+reMFPB6raQsUtAJz6f5lTiiGSJzwRxnrU0OGiOz+BFSi8Jb4MIe5+LU49OJS+amNR+6UzqO0eovoJg2fN73Jztb7TCLWcvN9XyHGMwfdbr+hnjQVCH8SsDqm7QRTwsfkRGgCyJ/sGrBqKpcf63BQkKLK5GOML0pWrF1Ad8DDvY6CNWeeOlYHIqj2EJZbf9K7LHGuuwADZs+3z5O1fR/W6SkSrsUi+zWc6G32LeEHxT5HJ5kj9gfDeQ6B40L6Jv9KWh8tRwQxrXqgvGvs3j6JgwFaLX/yyZVYnWhbFUztr8vfIeLr61D8bWLuyHm+JjAIQpO6ubtc2PoKagPq4F1peKGLnHJaHDRY0rUVbiUwUwGLsXVRlrZyNZTonc5Cj7Mt0riXaxAXYVCKWZ1nIjj+WcRco0yjoTxU/PYYHlCYQ=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EIbJm18+rQnMcSPucaJzymEnPDoX002NwbXuCh3Py5rKoUfjX33N3eNmCSD7E6nJH8Sjj7RF8Z/hnLUIEcXU51UZpiXRUzHNVPl/fFdzPwUXIRA2RWZ01TcKz/U1QbH8DJABSG+CW5vIMkenYG5p2K69AwjjafI0DA/FTPWGsdkygvfUlQ+mIanfikXyAvWLuKgOuYc7TtGOqjIrNRnTcM7ry+lptfC7NjYurANRNSwm8Iz1ngTzr4bF8SYc3i4LbmuJOXRACUleNhxviOV7q1Ukil29W9tNyNTkC6GOemNj6k1BCvNfLIc5hq5FtGvGUKK41vvf/vZNnLvGbF8pggDJmZoawW06KVADhbpIN+zMY6QziTwyXhYd/sd53s9WA344cNAxIRSmAAPn5fQ1ZnysETiz4q+2NVxQF0HJcEqHlkMCGlDLxeWtjdkGoR3n
X-Exchange-RoutingPolicyChecked: DYvcXMsfbTPYUnE/0LnSUNVfDG80/6+TB6UksBjxpwotXKFdOXEda3aREBXdiI6dUXxwiK3VlmzfP5M2OwLcUnzDzxaq5oHdGdjqz2fVIHKDXgtXXLfvrdo9pC6Na6GMiEBk9XWVb/mJWd2nfJN/ZxNui84RhO0cyC0IqNCyjiOGc9HBUVpFL9+xP1ujTmx2JjHD8HURywhNftLyeGpLbauyChkRG+EMHoDs+REmdrKf40MjPDPip2NS0hOC4qCz0g3FIHQXPGbP2tJcUxUQ0LW9JdFUYF+BeALeyY2XPv4PpvoL8ps1DbMfF1kcSNyVkvq8wHKumRPzJvOkt0Cq6w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HveGM7Y5vtFkK22AeVzZAYNesFVEy9AlVLPm6tNoctEJnWMJdIwvtsEbBvKGaz6MslTRzpuG2b4Q5yrNVTtUzGEHrq6+3OmWd2I8Wpg6l2LJlFCuiJEJviAyI1x7D5t9NsDAxyZ8hpa+R0RVRsI+g0lx2MinBBkGnKodVhTNbFNgEesbS2eTmU07sNavFfjIqDDFYyqkxwY5KJ8dxwgMFzVuy3jkgnfBVJa2IhKqJmxkjV4dUK7gCe1lbDpTzEb+BtD8iQAahxpJmYwDXa6eoSbpZGE5hbLDq8eDlpiaAdQBmwSZL8vDZEL4rCs4yfhM5RQxNavo6aOPXb76pNN/rEI9EEnik97jgBtFCZJZg/Cyzt+V0OiT2wiRuTVJf5YqB8edhlWfHPzO9b8AWBW/KEVUfGX8jBfE5MV+Swx20XDTSp6WkHKhmgxhDXJop6MZMm6w09G+GYLAzJkvbCBEZ+Yd8VepbLhaIBerLmhUjc3KuAWqpUWjW+HDJSsxFS33XsiWADf3jLZVNoIgjRjGGEP1XguQFcl+iO/LnfEuRTij/MgkdwCiBtCfHoeZQ7H+8SxCIpwq1/XS9RJSiVEy1zSCgdbEqTILl0smILjJGs3/gyvBdt9UiO6ooZajZf71
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 03:39:30.0713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9bc1ea2-3f83-4035-8954-08dec2b40d12
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR16MB5461
X-Proofpoint-ORIG-GUID: oPmEn-szMne8W1xyh21S3CUe6D_ibHeL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAzMSBTYWx0ZWRfXwAHjnXD2PPD1
 SdPiXx+4jPfB+CFoCFr8ux3ztVQs5Ud4vlnYbe8E/N/Wc41MFjM5Kk11W9+JBuQej2yw+vKr4YK
 mYZAYIa8a3Z6e5Sb18UDUjyxbouJcXnXZQhmC2HPixdxzdiJBG9OtXHuMW469TXsIt2o+6Ju8U9
 8UKTqXGT2WLs12yX6r5eZcn8ACndAHysti01aqBXTQ4a68GfDHlAOBIlEbQMq6ievXtgTzgwQnc
 1AtKrpLgj5E5wX3RfQ77UKBtUT54hsFCkix9BIOtRZKfTH5eApGxvQQ1JHaNH8SZVzefltElDUV
 4QTeORy6Rt5NdksCxOvmvpo3KbI07VjneH4h3ShuRA7ZztoN+o5hYVPvRe0nVuLuBXsOk34g9bI
 7mlpo7AcM9yTZJoTn+yos76hdJTM76rfVsObbJzS5xECH9E9RW0ZcOmixcOyEnBcbfjZeeuK3Qu
 NC9bUGNxYKp+rpxlI2g==
X-Authority-Analysis: v=2.4 cv=MMJQXsZl c=1 sm=1 tr=0 ts=6a2244f5 cx=c_pps
 a=JAvUoUKTMhMV/AtIpjtZgQ==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=dw5MciS7gY-znkhJuOLE:22 a=cbNQJ9GKAAAA:8
 a=1-54F7V7oHf9u0xfLZUA:9 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-GUID: oPmEn-szMne8W1xyh21S3CUe6D_ibHeL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 adultscore=0
 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050031
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

Autoboot calls into bootcount_inc()/bootcount_error() which rely on
environment variable.

Specifically, it may corrupt the state of a GPT-backed counter.

Gate bootcount_inc()/bootcount_error() by !CONFIG_DM_BOOTCOUNT_GPT to
compile out bootcount_store() calls on autoboot path.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 include/bootcount.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/bootcount.h b/include/bootcount.h
index 86474569d365..8aae3cb7ff1b 100644
--- a/include/bootcount.h
+++ b/include/bootcount.h
@@ -74,7 +74,8 @@ void bootcount_store(ulong);
  */
 ulong bootcount_load(void);
 
-#if defined(CONFIG_SPL_BOOTCOUNT_LIMIT) || defined(CONFIG_TPL_BOOTCOUNT_LIMIT) || defined(CONFIG_BOOTCOUNT_LIMIT)
+#if (defined(CONFIG_SPL_BOOTCOUNT_LIMIT) || defined(CONFIG_TPL_BOOTCOUNT_LIMIT) || defined(CONFIG_BOOTCOUNT_LIMIT)) && \
+	!defined(CONFIG_DM_BOOTCOUNT_GPT)
 
 #ifdef CONFIG_SYS_BOOTCOUNT_LE
 static inline void raw_bootcount_store(volatile u32 *addr, u32 data)
-- 
2.54.0

