Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D703ACA1015
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 07:04:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2681C836AC;
	Thu,  4 Sep 2025 09:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="SJoCnSJl";
	dkim=pass (1024-bit key; unprotected) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b="mkUybdqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6031836B8; Thu,  4 Sep 2025 09:03:57 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A98E283678
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 09:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=13429524db=yannick.fertre@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58450GKn007335;
 Thu, 4 Sep 2025 09:03:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 NuNRXJzXaQGKA9v9ZKbY+8CDH/c/v7eqs0P6KQfgByo=; b=SJoCnSJl6KZL5SUE
 7dFzxBGDW61nsv78uA1X2H0TIhNsl/Hfi60JbkyYL7aD8VX0s95cESsbHNePfizZ
 ViSmFpyuiULh0+lNRAlB+QswZ+0owfUhXhsGntdIlnxthZL3vxo60jDQLNS3bUQE
 hkt/v8zdzYCqsHen2OD0pvkjIpDLF3QdSRdhmZ8jlidlt9vXcNrTuH2VX/VmiR5l
 OCqFskPQRoFAT6z/+rhvGnwGc4QS+ot7Fp8x3AE+b4rIL+80iwxmpmu0BGyWFpY+
 uU3qz+FaPpsmXuWyV35OKF7lAht3QGU4G0MTq5m2ylHyPppTrjDyeDFp+qPGwdYE
 EOU/Kw==
Received: from gvxpr05cu001.outbound.protection.outlook.com
 (mail-swedencentralazon11013064.outbound.protection.outlook.com
 [52.101.83.64])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48upqkn12k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Sep 2025 09:03:46 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpkTgf5H1lhb5HOgjBVzGpWzLBOjGNyD8VREO0T9dpY9zLsRTcZJBDTLHo2euyCGZg9FTmSrVjKyb9DscqRhpiDiinoHNx9xDBHBPBnR6ozw/8gYKqeDXi3d0b/VI86vQNr2X9JYrfr1rYGHRTs8jvtAjcwJv6lJGrxfgHqRca162oubm9kobhsOWIP++U6BZW+j/HCXOI2xBXJAXcZwgClnVScmBiDgMuUypPCLqA00Bcv4Y1M30cfV1JJ8fGWB3S0CgMeeRewnknF+BkIFlPCwRdESzNBYz1jk1pWZK8ePxjmhtQcWimzPC9T+wHq614vE9shXpmi//nZA1zqp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuNRXJzXaQGKA9v9ZKbY+8CDH/c/v7eqs0P6KQfgByo=;
 b=nI23HaEwZqsD5hR7DE6u059hngts35Cl58BMxYrz/UaKyRcxTX+1+Izc1mVSbb1+WYprQ6V3EEaryLmEVpS3vh29tREj4TzopJP5EscplJdFxwe4rKnIn8isOxO2SHH42Kk2TZLl7q6tOjvjnqH+4U6+oCsRepwRlf7BzbrLxIQ79QBvVW7zdudATDGaau1RTJ1MtbHyBGQD59TbS0ZQSX/YpHrpG4tiFJN5uS3pQWGv7Z+IFEaniIKCi2UJxmUqCOCjx9txhGC4jv2aKT5eIwGplZMEprVcDszFvkzjk/z1FsDRkkJRbxjf9MH7dmtHLHat80KwJDIBAJoPURIGXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmicroelectronics.onmicrosoft.com;
 s=selector2-stmicroelectronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuNRXJzXaQGKA9v9ZKbY+8CDH/c/v7eqs0P6KQfgByo=;
 b=mkUybdqOJGv9B8t1eyxni5D4+NlpjbPvb0iUQVijgwyJWwxYnkesO/B/z3Nae42ZfUZ77Og4n5GeyE9jmCVYAD0oLrXMD11aU3gdRPCXCHT+SxsF4gPIfWlXPyf8Quj8hv5U1LC2C6cIWPeEWb0LhEmwg/EZIEnqUBzUDhd89Mw=
Received: from CWLP123CA0048.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:58::36)
 by AS8PR10MB7328.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:614::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 07:03:44 +0000
Received: from AM3PEPF0000A792.eurprd04.prod.outlook.com
 (2603:10a6:401:58:cafe::bf) by CWLP123CA0048.outlook.office365.com
 (2603:10a6:401:58::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 07:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 AM3PEPF0000A792.mail.protection.outlook.com (10.167.16.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 07:03:43 +0000
Received: from SHFDAG1NODE3.st.com (10.75.129.71) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 08:56:27 +0200
Received: from [10.48.87.178] (10.48.87.178) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 09:03:40 +0200
Message-ID: <8cb33c73-46a9-4464-ba3a-7013db3b4add@foss.st.com>
Date: Thu, 4 Sep 2025 09:03:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] video: stm32: ltdc: support new hardware version
 for STM32MP25 SoC
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Kamil Lulko <kamil.lulko@gmail.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Dillon Min <dillon.minfei@gmail.com>,
 "Patrick Delaunay" <patrick.delaunay@foss.st.com>, Anatolij Gustschin
 <ag.dev.uboot@gmail.com>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@kernel.org>, Philippe Cornu <philippe.cornu@foss.st.com>
CC: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250903-master-v2-0-5cdf73bff42c@foss.st.com>
 <20250903-master-v2-4-5cdf73bff42c@foss.st.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20250903-master-v2-4-5cdf73bff42c@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.178]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A792:EE_|AS8PR10MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 7236dcbb-9a96-4553-b90b-08ddeb812fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1Bycm9VY2FFazRsZUFub0hNMWxzQ1hkUzlJRnF4SjhiMFNFNVZnY2VvTmdq?=
 =?utf-8?B?dnJPOUE1NStsZWg5VlNPTFc4SjVYYVJhczZwSm5nWmNVbEY0OTVJMzlyU2p2?=
 =?utf-8?B?eGdoVjRzTi9EeWNrQVlIbzd5L21DcC9XY05seG00YVI4OXF6N0FwSEh1Q3hh?=
 =?utf-8?B?d0xObDNva0RHZ2dEblVMMHI1QXQ4V29kOEJIdkpvTldWa3JWa2dRdVo4cksy?=
 =?utf-8?B?TFR0UEZzdWpZMmFXdk42ZkszQTFtckNmNXhxbUtlSTdYSG1KNk1EYTlKRlJL?=
 =?utf-8?B?WEZ4ZExHa1FqYVY5b2FxMFdkNWs2RXZKY1dKVHBnVjFrVnc1NHQyTjZuUnk2?=
 =?utf-8?B?Yko5amg4ZEdzK3R3S1BlNzcvZzk4U3RXS2xsWThQazZYQlY3aWwvelVNb0k0?=
 =?utf-8?B?TmNRZFpxcTdsa2RRdm9TMU1CVFZwUktQTUVZRzdXb0w1ZmtaL0pReGo1bUNs?=
 =?utf-8?B?ZC95bDA1TXBxSTRpNkQ5eGM4VUpuTmUvUXJpSnNiV05PVWVJS2dQQW12UlR6?=
 =?utf-8?B?L1hkWEpRU3ZOaXhLSEVKSzRxQmJvSkVEa1loN0lUWVg5VXpjZnZpOXlmV0lP?=
 =?utf-8?B?NHh0QTFqWk1BR1hPV0tRY1g0NndDbHc1anA5RnAxNHkrcUR0SXNMR3dLNk5z?=
 =?utf-8?B?U1dyeCtTcGRwTEdzVVVqU3AydEllSUVXSjRKNUYxSWNMcWhYYnJSY1V1TVZT?=
 =?utf-8?B?Tm01cFpSdkZTSFFKcXJEcDU5Smp0Sm9hRmpsVkVTN1R5MmwrRHZ5cWlVcVk0?=
 =?utf-8?B?UDVXdVBWVTV5QjNnZ1ZDTVhUZ0VrbklLMXQ3U2duRDRndnZNdHpNNUZTaE1X?=
 =?utf-8?B?Y2FlTEF2UXdieUwzUUwxSDZYajJBTXBDK0M5OHVhdkYxOWtXN1JvZElOUEhu?=
 =?utf-8?B?eTc4UVpxWlhoRjFaTzlTcWROZUpkTXpVd1RNejMrbXd4Y0pYNU5lajVIbEI0?=
 =?utf-8?B?Z2ptZTd1OGpvRGR0Ry9UcFJHOHNDQlJKYnI4TUFxd1ViWG1LZXFlSXFmc21E?=
 =?utf-8?B?L1Vrd3dUbXdiSUZCS3lpQ05YcEpPaE1OYi83ZTJuR3NPTWhiR1VUc215OFQr?=
 =?utf-8?B?N1VIRllJVTlON3lxaWxXL2c5cjdieVNEaENKRHlXSWN5ZkpjRzdLSm1CbDJP?=
 =?utf-8?B?RmxzRjRadU1oMWR0cktWOTZSV0lySFhZOWZLRm9TbDZjQmpPd1E2QkFmc3p4?=
 =?utf-8?B?Z3dLMzZaN25vbTRSNFpEYmNYV0ZhTDJYTnJLamc2cDZPSGJTbEZTZzRZZU1s?=
 =?utf-8?B?aE5NWGZzd2lPeWQ2QmVuZ20rdzFGQnA4YWVOekl1RDhFdTNJc3lsTlBlUE9w?=
 =?utf-8?B?SHpYOWF2SVllcWhwWEJHZHlaanZrenJ1VDNNejRwUmxOWUFoYUt6SnhjRjRN?=
 =?utf-8?B?Qzc5VWk2UFRDSVJrM1BQYzgzRFlYVW5vTjdGbkI2bDVNc3lYVlpacFF6RHNX?=
 =?utf-8?B?NVBDUnhVZ3dtaDVKQ0NCbVcwYzdIL3kwdDhsd2g5R2hhS0tZaUxmM1ROWG1O?=
 =?utf-8?B?NzJLRmI0bGtyaitVQVdWa0xNS0dvcDhHZGVTMXQ1QVR2ZkZ2RzM0QTJheHBw?=
 =?utf-8?B?YnhKZTV6ZWlvNXcwRXFvVUtGbXI4RC9ocHFoQklxKzdBUWJvc1NITmp6K2hO?=
 =?utf-8?B?S1RWcStqQ2NTTkFSOWYxWjJjd1pJS2xLbUc4VW45OFRwT0F5cXQ4aGl5dUxH?=
 =?utf-8?B?NE45UEMxS0xkMERRbEdNTWdaRzFOcWFhbkpJRndZWUFwekdMVyt4K3VqK0pw?=
 =?utf-8?B?US9CZTNYWGtCaHBnWVNtd3JKTTdpRGpYQzFac3JSWUxxZmpZdU5TZXVhMi9i?=
 =?utf-8?B?RkpSejFvSkg0eVpESDE3NGk0NjdveWhqa29keXJTTk0zM2Y1bGg4bWRyUHRN?=
 =?utf-8?B?c3dFOStwSm5RMFN5LzlwbURWVkpPdVc4aHpaQ1BYRVZxMmRlWkpjMUh0NU5E?=
 =?utf-8?B?YlM4UFp1dENEY2VCWGwwRm9PMkN5aHNTZy9LeGxSRVNRRzBYVkpmb1ZKR1pp?=
 =?utf-8?B?L0NCbXkrVjdaMFZOQ2RtcHhhL0NORXVWbDhnMjFaR3FmWEtWa0ZiYnorVlRh?=
 =?utf-8?B?ZVZNS1JoWFQyQUtHMVM4V2lhMDFGUURRb202Zz09?=
X-Forefront-Antispam-Report: CIP:164.130.1.44; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 07:03:43.9220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7236dcbb-9a96-4553-b90b-08ddeb812fb3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.44];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7328
X-Authority-Analysis: v=2.4 cv=XYCJzJ55 c=1 sm=1 tr=0 ts=68b939d2 cx=c_pps
 a=RSP5wjQe9cmB1/5ZhXI0tA==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=P2A4Zi-lJHsA:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=FUbXzq8tPBIA:10 a=8b9GpE9nAAAA:8
 a=kxCilVioRAr92PqvDDsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: AuuxBS206KPEWJUGh15LS5Rr7g0w53It
X-Proofpoint-GUID: AuuxBS206KPEWJUGh15LS5Rr7g0w53It
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMiBTYWx0ZWRfXxmJFzSVPgfZG
 7nSlMRCiFk7ReuRw30o6z1oDR43lRVC7FqcR09QtJxH54lMxBImjeMN271BNFh88gr8YIqHiHYT
 PNw36EZexo3xvHD3l/9h7r+tCMquNAQFHAjSBTjzUtEaHzwYR0+hTD+CPpCxi7GkIYw79gHrNT9
 QvXQ5ex1gryroavTW3q/f5SCs6mi0dwBu7YEjCAh8GB4KKPw1qgPNhEArTk2o/V6CNY2VJi0Sgl
 iXglwjvvm0c7KrUZT0OnmiC6xP5KFzvmk5hX1Q5rybdCCdnM4O0cyUrmxGBeDSJRB1raKIYgyj1
 IQmVV5uV4DDPW5sPsoW2fyK+bjo+HLLtFfmSQlnmvC+Qz3sNsdGLXbA/yQSqWl0BEjb3P6RFuJN
 p2+4lXXq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300002
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

Hi Raphael,

Thanks for the patch.

Acked-by: Yannick Fertre<yannick.fertre@foss.st.com>

Le 03/09/2025 à 14:25, Raphael Gallais-Pou a écrit :
> STM32MP2 SoCs feature a new version of the LTDC IP.  This new version
> features a bus clock, as well as a 150MHz pad frequency.  Add its
> compatible to the list of device to probe and handle quirks.  The new
> hardware version features a bus clock.
>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>   drivers/video/stm32/stm32_ltdc.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
> index 0a062c8939dbe49b11aa50f5ca9701bdbe5c5b0b..efe9a00996eca0301d2a2b82074ba9690a967a73 100644
> --- a/drivers/video/stm32/stm32_ltdc.c
> +++ b/drivers/video/stm32/stm32_ltdc.c
> @@ -262,6 +262,7 @@ static const u32 layer_regs_a2[] = {
>   #define HWVER_10300 0x010300
>   #define HWVER_20101 0x020101
>   #define HWVER_40100 0x040100
> +#define HWVER_40101 0x040101
>   
>   enum stm32_ltdc_pix_fmt {
>   	PF_ARGB8888 = 0,	/* ARGB [32 bits] */
> @@ -529,7 +530,7 @@ static int stm32_ltdc_probe(struct udevice *dev)
>   	struct udevice *bridge = NULL;
>   	struct udevice *panel = NULL;
>   	struct display_timing timings;
> -	struct clk pclk;
> +	struct clk pclk, bclk;
>   	struct reset_ctl rst;
>   	ulong rate;
>   	int ret;
> @@ -540,7 +541,21 @@ static int stm32_ltdc_probe(struct udevice *dev)
>   		return -EINVAL;
>   	}
>   
> -	ret = clk_get_by_index(dev, 0, &pclk);
> +	ret = clk_get_by_name(dev, "bus", &bclk);
> +	if (ret) {
> +		if (ret != -ENODATA) {
> +			dev_err(dev, "bus clock get error %d\n", ret);
> +			return ret;
> +		}
> +	} else {
> +		ret = clk_enable(&bclk);
> +		if (ret) {
> +			dev_err(dev, "bus clock enable error %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = clk_get_by_name(dev, "lcd", &pclk);
>   	if (ret) {
>   		dev_err(dev, "peripheral clock get error %d\n", ret);
>   		return ret;
> @@ -566,6 +581,7 @@ static int stm32_ltdc_probe(struct udevice *dev)
>   		priv->pix_fmt_hw = pix_fmt_a1;
>   		break;
>   	case HWVER_40100:
> +	case HWVER_40101:
>   		priv->layer_regs = layer_regs_a2;
>   		priv->pix_fmt_hw = pix_fmt_a2;
>   		break;
> @@ -688,6 +704,8 @@ static int stm32_ltdc_bind(struct udevice *dev)
>   
>   static const struct udevice_id stm32_ltdc_ids[] = {
>   	{ .compatible = "st,stm32-ltdc" },
> +	{ .compatible = "st,stm32mp251-ltdc" },
> +	{ .compatible = "st,stm32mp255-ltdc" },
>   	{ }
>   };
>   
>
