Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103B8CDB466
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 05:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0165849BF;
	Sun, 21 Jun 2026 07:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="S46ju63M";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="R9rSnpAh";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="VpdGH94g";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="VWb2u9Fe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3CEF849BA; Sun, 21 Jun 2026 07:15:06 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FAAC849AC
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 07:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367126.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65L1IRht1540766
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 05:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=cvL
 yYDR8SqJR7/+/7CBGE/hYBrugi0UNx8OCu8zBrrg=; b=S46ju63M+ZQwcDjW6N4
 b/9SAyQpQR+9J3RUpRfkXqaxYf03otM7bEKRAMIN27nm2ni6ZEVjAeLKKfcwnkqY
 fTSOwzMin0jGbBL64odEW4lcOy4xgbyqdCuwWLZurxQghnS02aEBge0OKaFGn1yF
 Bp3AAX8OMp0gQO7Mf28OxOT7S39nmIIj47G1vjTXVkHKKoaSYaqQmNgVW1/DpC1M
 Blnp1hHJ/i25voQXZOSPD3Xk7N6Cx11KoADXJR8WLpqeXHkK82qTDA07qECpPwj6
 z+tCH/a3LckCEwo/rrLEMPHOw9s7SDhWJIqH2ordWbpuZJZb6l4Bi5UdtR0HDxma
 E6w==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013008.outbound.protection.outlook.com
 [40.93.201.8])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4ex65v8m8r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 05:15:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gh/ZvDb217KzQSks3/vIWhZDl2s11w0d1K2QwJlFmSSmKzhY0wI8TFcoNi0Zrl7i3O3hCsLZkNImqyHTK9tcuKx0SJuB0cJSrABJf0QKyDJ4Xfv79GTudYaWT4devAG81PagXx1R09UMLzFuDNx1zcn+YMJGSTFJo6uQeI2GYDxZdMR0r5lOEO0lxva46DIpTIttd+yalYVy5SZczHrEzXLbrVysk4872g9ucmlTixQrmOXWqh0fzS1dFUVJlh4iBiPhlnAlczvXyDJkkL8D+ZwbdyIUAM8naM/35vOIbLljlx0md/s/2iuB4Q916WCTHx/zSZ17UQJke6CbZTAajQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvLyYDR8SqJR7/+/7CBGE/hYBrugi0UNx8OCu8zBrrg=;
 b=abHuVvUj9kSgswWwxL8eRpsoxH579fCAo9AMRq9SpOzrcn66JanDAH/J0fv6DNc3pfsINBm9W362hHYmOvMs5GLAZqvAzTY/QV3Duvn6O8H7/NXh1/KoPb5HFIZ4h09Ykkq9hNbB1q/9yrDEH87/5+QABmC9BwuvtffQxdUiuuKMGVLYB1Gz8ES1QCyRsuaVBIgxdChL1MtgKy3MDG3bwMg7sz0feX1RgEjR3x71VUThDm7/1wQZQIdyXblUjrQOSciVM4w6AJD3frxrFMotPMTlsbDHEclMhBZ9QhtAVz8UTY+hyTq0LbQ8THpxlrHHXUhHBXOf3Xjs36sXtdjp9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvLyYDR8SqJR7/+/7CBGE/hYBrugi0UNx8OCu8zBrrg=;
 b=R9rSnpAhXHHXJaFZRU4xggTlave4qRBK6SMxGo86CDttWck6pBEUQZTj7gislvLDz1NExjhI4iwORICH+T1vOaABLH0uJLCIp9Tt+SVQWqXAA3UIygQ7DEXihl52LB9hLxDy19eHnCc4MiUcrWWBdVYBF02j21BT85A1FYjLeJ8=
Received: from SJ2PR07CA0009.namprd07.prod.outlook.com (2603:10b6:a03:505::6)
 by BY1PR16MB6368.namprd16.prod.outlook.com (2603:10b6:a03:4a9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Sun, 21 Jun
 2026 05:14:53 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::a) by SJ2PR07CA0009.outlook.office365.com
 (2603:10b6:a03:505::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.18 via Frontend Transport; Sun,
 21 Jun 2026 05:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.10
 via Frontend Transport; Sun, 21 Jun 2026 05:14:53 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65KMGPCP2588060
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 01:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=cvLyYDR8SqJR7/+/7CBGE/hYBrugi0UNx8OCu8zBrrg=; b=
 VpdGH94gksGRIDCNcHXtNySSUg2Xg7SfDRVcRgzWnq2pdhIziZsHNAi0gYJm1hzw
 mdXrxBBcXR/TLXpUMpOERso/npOl2p07zcZQ0nuk6gyJQKYWfNXz2WFwGvj+XOzQ
 lrXmgZr/zYFY5GkNe1YiMhxT8VmvDB0qQyPhl7hnzuhqxbbVcZUZSfc3tIoZpuSI
 Nouug5RmNhktn6G7c/n3n/tVfgYOgXRiKIR7MkvgfUTrVqdDS+s45t8TFAWff7bY
 rc9LcncCRansASznDJmTPIlljIihHQhEvGzHlSW5DOY2x/QRQEuwRySbL9LCyafL
 X0TLk2tJvB1+Q4evEqWCDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=cvLyYDR
 8SqJR7/+/7CBGE/hYBrugi0UNx8OCu8zBrrg=; b=VWb2u9FeoMOR4V3VK7PzHwR
 KPujCKy0Y2FF0XcopoxjB0o+dREBFJwDCCoEJ3OIXVDbbveCV0SBiPkknUXYwtTe
 yZAAZH7sRAi8eU9alnnzlwzJOsDBj6MqfnI9u95p4mXge8e/ygDNJby42nOJWF+Y
 9HT7zz7VHoHVdc6WBjc5+iQrsNdNd7g+ecrjGf6OwUZfs4Mq4GiXMUY6733ljbHn
 ncMbkD5/twmzbKR8lg9AZZfJYvB8UAH4GkZe0Bw8xnHkUck4t+E/skzyzchOcGSB
 mFKlIk90iYBXG2q9EEGIq/lk6hkhCHkNCChPIJW8G+BYE/wCXfOL/UGwrto3pMg=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4eueehncvq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 01:14:52 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id bAWAwzMPDaKlDbAWBwd6Oo; Sun, 21 Jun 2026 05:14:51 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: bAWAwzMPDaKlDbAWBwd6Oo
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 1/3] bootdev: fix typos
Date: Sat, 20 Jun 2026 22:14:43 -0700
Message-ID: <20260621051445.1763952-2-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621051445.1763952-1-dmukhin@ford.com>
References: <20260621051445.1763952-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606210049
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|BY1PR16MB6368:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 19f9881b-a59a-45fc-b8d9-08decf540709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: uqmht7PdQ8H+bNycYX8SR9ChPo4sNAo4ptaaU53Wb46BvsHsj++8WU9NsDjL14FJ+i/5+MBlfbsH0kx9w3dwhj9GEbv1vUGXsGVkp0qz2VdrUFNqNvYWtetzFf/K0Epsw0CP1oxJEHmPyy/tB9jLIv/NpJuIjv8wjm0AXPgTj+QVoqBQDbcOs3oUjGWt3vl37OYKap7zcJD75+ca1duCNs8Ysvq0PkaUjaPS4pONK/YhlZP5vUk1diBIwdlkCp02CDG9RlpjcjFeOFb9pDXJoLZ67LTrU0n1qtTC/0fibQfi7Cm9SjhJADmD4HSPWASxEqhIlc56tsRPUViUWGmC8QJyqkIyuqGGcwosB2GwP31UrT0ZBxvdySJ+x+NkcQHFNQ/n0FCKjJZxXHdrNC5GmKS+IEj4zOx8Moou2yXdAknuJGmQdEQzL5LRY2l2RWD0fCkXCsSD8YM+fc/h7+MUD6nzjFyYKsjSwiZvnZlxEOBXT93pa4Qx0Ey3jdj9+BSBGHEZ6QF2PIXLAJXl71Dfc+KIoynUeuXS52vtOIFkQGBb8WtQYkL/Aauu4TPXYyZPk0k+SOwj4KZ1bUaTcuMzAZ9HMwJ34rGnSzElAEfm4ykZjt3S09tsXdOaA7o7ELcFatTHutsZvkDVvRSEtWdS6kwNkU79UqqFJ4B4Q/fF9esxYizU0uEfnbriLvw0GTqyWEz2uBRxs0up5g8bABCWUg==
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RKnI8wRawc6ttuGqnu6svS+oy6ADGq0endLiuPp7ZAED7/DPdZ/ZuvTlCzxTyZ1hA6uWnBIU4moTwSW9Fo4NJ6mAuW089sca3QMw9nhtCLkpY92i7rTGv1f2ebcy7VJVHJhhg8zzaJbfcXbLb85IRLrYO31ue40ZQ0QxxUiZKwTyIW9rEv990XrsDqhosGu6C6nJBTvvWs624w8/lkD0zf1c5DwcziSnUNdpnR8YAHXKNp+W/GELA6Y+fIcJxuH33TfJd1C/1GDVhg9pYnOsJrTpyQN714AYmp41dyqxeHkfoYvmyn0SVePMZ5jyGkaeE2jBnawARgYOgYNYKTYn0gS78zCsLAg4PynMkryLYTnogqlXld1zgaIzCC9G8km/MAcHcO8LZCCU4gU8rf0Hx1VBBkmJZPcJJ5ZFOHLm8xG/ZErcbixs2wgcCk1WjzCx
X-Exchange-RoutingPolicyChecked: hg7T5QTjA0fjfNjbyoT7UTlmPZ9YpTxQmFELdnMrPWWWaEljdGfTkYxKOSFKLlZ1Sh4cmLutjRc/GvkskD9jbkgHtc7ALCRo6tC+lln0/LSMmDga/mkW3mQA8oZxFNaHuKETipfl3/N0JPLQrRzH/dcC13g/5SVesowSwd46rBB52yyds+GPxoTL0ldum89hEneCU8FKovH9NyEU5m1R44vUDWFfuCIjMM0G3eBlCI93rh60bxX9tb48M1OVrqxRjxbnSpdiOSUhCK1ERiayJ4iHLxSPlwPRbMJo0FxfgqVKaFqnlVWbieVggzN6Bi6aiw0Grlt7t3QpkwKRtm7bjg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IGkQklE6Ry+rZkYbTn2k4oA5hzDrXvVzjqW0hzBHj0nZMoUAhTs/vU6VJXq+WBlilMUwjF0TeFHEsrkuSwkaVhbHu7XigMk5A062D20YHpQV7iudKKOa6d6XzwbU2KjYqFJUlnIcgY6LHpAcUVLv19LHhJ0Fd8EeMSmMN0bHMMZd0du1cLU36hMMCjSCvzggYoI1YazXlkKYxSGBlzsbZMkcjI2LhGy8N4FMtXC9D9o7s7x/6kkWp8NZmmHUdoH8r/M5triLL1wxBJWkFs+onZUX6zuXkk3fWoAx/HZAez8CW7K4gwYQ14VhICdLzsIjJ8i7XXThf8NYxuBUVwY5+CmjEv8TStXVxUx3rlow2MwDd4YayFT73Y36x4WhORDLRxBnopnY7ZK8u/+4jyb1B5N+W8RuXEwSrIMJvWgEH/yw6L/vyTr8zkD7w5KFJDqqOO8++y6J36FEh481FR0fxz6/E7MdQfflX0wfhXlesgGjZWrwgHcWUxwZSQm/zPmYGc5ttYkdDYrIYxhhoy2u2b4zvCGn7G/VIrIaFVZGYuBteEEunBqce7RPPbdGaD3lmlapEXykDP9hWLKHwOika8cYKwBjsefrmF+ZoE8XiPrm8/AvIMyHmw36EgB/AIfsJMI1JdnYKQyWmzvlZiaSSg==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 05:14:53.2675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f9881b-a59a-45fc-b8d9-08decf540709
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR16MB6368
X-Proofpoint-ORIG-GUID: D7jNnVf0W5ul1jJP5J55xfsroiCjlU9D
X-Authority-Analysis: v=2.4 cv=LeUMLDfi c=1 sm=1 tr=0 ts=6a377356 cx=c_pps
 a=2E9rO6gqkamS8B1JEYjvvA==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=-OawqTZBqJjt90xPb8wn:22 a=cbNQJ9GKAAAA:8
 a=cm27Pg_UAAAA:8 a=8pUfwE4-Zr-z-6C-i9sA:9 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-GUID: D7jNnVf0W5ul1jJP5J55xfsroiCjlU9D
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIxMDA0OSBTYWx0ZWRfX5yFPjn9H3FOq
 +li9JOojZtBRBQAjDlkXGdS6Y/ECKxqEJaccCufxFj7AsF8L2LMg4WtsAROnqdVOidKSdVG29GZ
 JDXpbGb+/2NSIs07DKNKq4G/Mt7oqgXnbGWN9k0oE3JFmD7k943S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIxMDA0OSBTYWx0ZWRfXx1CnMhjk1sS7
 Uve13urQ3GrAEMqUUJXTfswiKRrN4F8A+9NiGnXEN4gd537MgXk+6wwWjVDqcL/JBfW/bD7TJ5s
 WmNcp4XHQLje2k+5iapWSw0CC7QrYky5LL+QVJtnuzCQcPnI2vIJKvEM3ZOZBnGDw6+vtXb12ix
 v5JztJCz4o0CWzSR9d0uM7akxYaQXZ32pPSApACY61HvaQlN1qWDDz9Bdf7fMoxHAdkcZ9jb3gH
 Ef1vsR5T/fkkv1ZeAUkih8IHyOOKgJo0PeyO57wI4MWiWRSp3OqRKWadGHI4MiSKvEibbKA8G3u
 Zq6+4Eqbq3qgidYUkUoum7NQtNTZPeUNd2WpGd5NJgcj56nRG8Ftw+FMaIgZtRSytknTwelec0x
 rSzaMCdzc21KZ+u5ick2X7zT6x3N4hWzBWG9Va6b4zl0SMIgVMrujxDO8+tMZ2kv8pPm80EsBhj
 0Mr/UKu6SJ7v7EmkevA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606210049
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

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since v2:
- n/a

Changes since v1:
- added Heinrich's R-b
- added Simon's R-b
---
 include/bootdev.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/bootdev.h b/include/bootdev.h
index 12c90c4ec1ba..14f8a98633b3 100644
--- a/include/bootdev.h
+++ b/include/bootdev.h
@@ -30,10 +30,10 @@ struct udevice;
  * generally very quick to access, e.g. less than 100ms
  * @BOOTDEVP_3_INTERNAL_SLOW: Internal devices which don't need scanning but
  * take a significant fraction of a second to access
- * @BOOTDEVP_4_SCAN_FAST: Extenal devices which need scanning or bus
+ * @BOOTDEVP_4_SCAN_FAST: External devices which need scanning or bus
  * enumeration to find, but this enumeration happens quickly, typically under
  * 100ms
- * @BOOTDEVP_5_SCAN_SLOW: Extenal devices which need scanning or bus
+ * @BOOTDEVP_5_SCAN_SLOW: External devices which need scanning or bus
  * enumeration to find. The enumeration takes significant fraction of a second
  * to complete
  * @BOOTDEVP_6_NET_BASE: Basic network devices which are quickly and easily
@@ -327,7 +327,7 @@ int bootdev_hunt_and_find_by_label(const char *label, struct udevice **devp,
  * Bootdev scanners are used as needed. For example a label "mmc1" results in
  * running the "mmc" bootdrv.
  *
- * @iter: Interation info, containing iter->cur_label
+ * @iter: Iteration info, containing iter->cur_label
  * @devp: New bootdev found, if any was found
  * @method_flagsp: If non-NULL, returns any flags implied by the label
  * (enum bootflow_meth_flags_t), 0 if none
@@ -342,7 +342,7 @@ int bootdev_next_label(struct bootflow_iter *iter, struct udevice **devp,
  * This moves @devp to the next bootdev with the current priority. If there is
  * none, then it moves to the next priority and scans for new bootdevs there.
  *
- * @iter: Interation info, containing iter->cur_prio
+ * @iter: Iteration info, containing iter->cur_prio
  * @devp: On entry this is the previous bootdev that was considered. On exit
  *	this is the new bootdev, if any was found
  * Returns 0 on success (*devp is updated), -ENODEV if there are no more
-- 
2.54.0

