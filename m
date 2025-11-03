Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8A6CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 13:11:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE8F3838AE;
	Mon,  3 Nov 2025 14:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="BR7sSeKm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 163EF838CE; Mon,  3 Nov 2025 14:11:36 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6061383700
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 14:11:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3402134e50=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A3DBO7F3294856; Mon, 3 Nov 2025 14:11:31 +0100
Received: from as8pr04cu009.outbound.protection.outlook.com
 (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a59yh8125-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 03 Nov 2025 14:11:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nug2A0BRDMzq+WF6+zFea4r+CyKdTK9uE4+32iLXFQzf2azKXDBe9Cibm85vv5d9DXelVwhF3ApAxYVZRAKa2MzFd1ziYxGAk+/FOrOCuiWa1OmVRtbEkkEaEqoP+Fr8zlzD215JDPTOcg0QTzfCbb7xeW3/lObDzH0/EkcY/LbkSsp8FjuMQPz7qIy+db/DmXdFqELkAZ90wBhmFXvYvkIvy4aR9mbimqHHWJDxHD+z6hqlthGLMasU3XRN0yDAn6je5m3yTkU4teI6ZeuaQI+BJygNK2mU8Xrt2OFk1RmAL5+5W2K7yALemMff4JuvIQZBrti/+y4YELMhpSKRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vajqWvIV9Jqzd0FxVIEQffdsB2nn/P8XUZCfk4ygQpw=;
 b=H26t4q21v0szh3DLFDzCHABXPPTGvt8m+9aLXfuy3Tcc0lQnCHyR50YXv7kWOMqZZ59mGSeSEvYhjLv84ej1PicGWa8Y5OeqNvUJDaDb3FlCVldkF9miOMsu6dv7/wxjgpXFYxQSZLQY5ELj/9GcAX9TjzP0oF23jyYsCpu3cjy323Z2MeBHYUrrv0A1kEN7wigLtPD/eKnlK7tLyMw7chfBFGOY9i9ydE6JTLngpG/yM37a0TiyO0KG2i3z90ypZ/AcuoGog/wi3mHkclsNSDy1POjaf08YsWvt+9Sufc13RB6/J0RNN8pcTy1H3bHhm9ZefEPizVTuxuUt5FG3SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vajqWvIV9Jqzd0FxVIEQffdsB2nn/P8XUZCfk4ygQpw=;
 b=BR7sSeKmiYeCfaqD5frsb3w3FFV2Uol6u4iiOMGKfYvtH1DN30A8jgjbfEH3rchfw+1SfgNkzQ8VA/NZlCpyU/Lim/NVgMVwUqNKLv5Akif75tgQveVQ0VLX6nyVYUcIXPe7mWPCJaS2uOLXSd5K7LUiogwXtSPVXIulIRLIY+lv5kvGauYbZUmzgy6ZFElOSduku0RzVQLwtdwU8vY7hWyL46n/VHVCNHdWxhD++pMUTb5/R6iGbOIOKTav3RsqxKzDtkCRk41UeRc+He4Z0L7AxMqKfhgjzDkd6THxktC2dqrgtAl3p4Prvz3fwHe9+i92NXe8rzcO3uIAboZxGw==
Received: from DU6P191CA0053.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::23)
 by VI1PR10MB3327.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 13:11:26 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::e9) by DU6P191CA0053.outlook.office365.com
 (2603:10a6:10:53e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 13:11:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 13:11:25 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 14:11:30 +0100
Received: from [10.48.87.108] (10.48.87.108) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 3 Nov
 2025 14:11:23 +0100
Message-ID: <189dc72e-a2a3-4081-99df-8ec17cf730ff@foss.st.com>
Date: Mon, 3 Nov 2025 14:11:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW0VYVF0gUmU6IOWbnuWkjTog5Zue5aSNOiDlm54=?=
 =?UTF-8?B?5aSNOiBbUEFUQ0hdIGZpcm13YXJlOiBzY21pOiBEcm9wIG1tdV9zZXRfcmVnaW9u?=
 =?UTF-8?Q?=5Fdcache=5Fbehaviour=28=29_misuse?=
To: Marek Vasut <marek.vasut@mailbox.org>, Alice Guo <alice.guo@nxp.com>,
 "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Etienne Carriere <etienne.carriere@linaro.org>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Vinh Nguyen
 <vinh.nguyen.xz@renesas.com>, Viorel Suman <viorel.suman@nxp.com>, Ye Li
 <ye.li@nxp.com>
References: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB9644A04B5499EA2BDC3130A7E2FDA@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <e7063153-036d-4079-b9c0-252a5d1eb364@mailbox.org>
 <PAXPR04MB964488C508F283B14E8B9B11E2FBA@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <eca51372-3bcd-4873-ba47-c06781d18466@mailbox.org>
 <PAXPR04MB964436F50D41BF186019598FE2F8A@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <ad762bb5-fb1d-47db-94ca-b8115f077e6f@mailbox.org>
 <PAXPR04MB96441809F6362E35C7D3E052E2F8A@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <6193cdf5-ff52-4c8f-952e-0feb738f5c8f@mailbox.org>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <6193cdf5-ff52-4c8f-952e-0feb738f5c8f@mailbox.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.108]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FB:EE_|VI1PR10MB3327:EE_
X-MS-Office365-Filtering-Correlation-Id: c526705d-e4bc-41eb-aa15-08de1ada7e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUttZGw2QTZWaXlzd2FWeXAvbWF0Rm41aEFhTVVMQ04zOUpBNDBDQ25rMm82?=
 =?utf-8?B?ODBjZDNLK01DVUdoaXZvR2hmd0RxdEZWTlUvTGtndmtSa3BNK1I4NDJVb3pt?=
 =?utf-8?B?OGFkZ3BQdFc1RlJYWU5UbkZmblAyTkF4dUMzS0ZKQVJVODNQN0JmQTZhcllG?=
 =?utf-8?B?NkZWQlJ6NkpwM0V3Ris4VGtLZkdPNTl2Y3l3RVE3RElTQ3BZTVZTYk5BRHQx?=
 =?utf-8?B?ZGQxZkhZajExTTVMei8vZWR4TEJBOEFHVWsxaFBXVDhMSTJSZzVoNmMrcHlh?=
 =?utf-8?B?dG9iQ0pwcm9sSmtMbXE1UkRkWTJka2JldWM1ZFFDMHZnME9pSWRTb3p1WmZU?=
 =?utf-8?B?d0dqYW91MTN5MnNXclVNVk5VUnVTNXhZQ0RraXNZUzMydnVpa0ZKTkFxS04y?=
 =?utf-8?B?eHUyNGhqS2tGQURxTkJWV2Jjb2Q3NlR3ZEJjWFhYRHNWMEZlZVBvQU83cHVT?=
 =?utf-8?B?cW5iTWtKSDdEK1U5azFIWGdnM3VieGYrZldlREZ4ZzltRVBpNE1xR1paaGI3?=
 =?utf-8?B?U0txQzBhUGxBeGErcEp0dVdFNm03c2VyZm02SWxVVEVXTFFDbFFxdGpiZGhn?=
 =?utf-8?B?R2ZKdGdqa055aTNTeUJOZjhZUm45WVpvS003OEx0VTBDOS9pSVJ3aFBNZ3VC?=
 =?utf-8?B?eFJMSkNWRzVTMXMrZXoyQnpXMFdKbWMvaVZvaFhTcERTTDhTUGtGd25YQWU4?=
 =?utf-8?B?UFZsN2FVZkF1UlJlV252dWcvUElNMnZQbkc0emZzMUlzL1MyUzdEeG9SaGhx?=
 =?utf-8?B?TCs2eEZ4WUZjRmdIN2grcmVPRlF3ZVpHZDRXSmF5RU5kS0piVGVFY2NON2d5?=
 =?utf-8?B?Y25VMVlFVjZ3UUFrTFUySEZQS1kwNlVhbDJFUWpuU0RLZjdLRGh1SmpDb1V0?=
 =?utf-8?B?Zmg2WWV0RncrbUtmQ28yWUxPVjM5RVErWFN6ell0UkdHOW0vdGI3dEhwVWlH?=
 =?utf-8?B?aUc4SDZBUkd5N0xLMGQvMDgyWnlqR0dsOFNnazNraGJ4S0MvWUg3MHlSUTV1?=
 =?utf-8?B?Vk16TGRWM3dYaVQ1TXJsaUdTMCtxR2tRNUlkYWVoMUJpcGZDMUVscmpYdzlZ?=
 =?utf-8?B?L3FQaExxZFloLzhtaVVHejBhZWxKS285elBjMkxMcE40YTkzWDkwNGlWYmk2?=
 =?utf-8?B?K1hEbzl3YzI0bnJlaTZjQ29zdUtLaHVvTDMzM3AydkpyVEUwOEU4R1R3djI3?=
 =?utf-8?B?V2IxNDVUOGtjQm9yMmZZL3VFcVNhdUFrQmlQVHZJcGxXcXFJYjFJVzJhSUhL?=
 =?utf-8?B?MWNGZ2RmQUUzVnh2am1PVTF2NkwrdGZZWW5yT2t1bnBLWm1RTEZGdFYvLzVY?=
 =?utf-8?B?OSthNTBaRCtYV3dldzJ1c0d5UDNwOXluREI5WGVUZWNEczNlK0FoM3hkTFFu?=
 =?utf-8?B?UE14ZWw5VEFjNDRUclhHU1BJOW8vSUU1MEN4NU1jV0FxcEIwMHB5ZURRK3Q3?=
 =?utf-8?B?MEkwRXRsTnZlQ2FOL3dudUliK0F5Mnh0dVZmSmFrUThPNG55U3BySDdYMXlh?=
 =?utf-8?B?WThwTlg4TG5zTzJHcW83T3h2Ni9JRkpzeEhYa1V5MnI4a055YXB2eFpNYnNE?=
 =?utf-8?B?RHQyZTZDRlZwYU9Kb3ZTRUZtRkU5djh5WDdzdVUyZlhQTTcxUE12SHQvVzN0?=
 =?utf-8?B?VStaL0FaUFNFUllDenMraWptMlc5Y2srdGQvdzc1Z0RyZ3VhOUxFckhuMVQv?=
 =?utf-8?B?TGZSS1ZkTWs5REg4dmlGQTRpWXIvRGZGdUQzVXJsNFRsTHVqNExkbk8zUDln?=
 =?utf-8?B?a1F5Sk1ncmZkMkpGdDgxc1dGV25KYU1mOXJlWFVONmZGOUMzUlozSm9LOHo3?=
 =?utf-8?B?c2FSa1RVT1o2a01WcTVMbDE0UlduQ2R3N3dtY1N0VnZndXJSUE9QWi9sSUJv?=
 =?utf-8?B?MEN3c3luOStUZTBIWkpBczRVVWdwbTVDSnhJcXpKYTZvNURQVS9sRHhGZE5Q?=
 =?utf-8?B?SHFtMGF5S0FEL085Q1V0MmF2TnFHV0tyajFmZDNFbTYyL0Y3MDlzYVVRUEw2?=
 =?utf-8?B?bGtXR3NucGJUL2tFMlFhUWpxcUxOczhuaDJtampQSnRsR1p1Y0gvdkI2RFpF?=
 =?utf-8?Q?nKNoeb?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 13:11:25.1799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c526705d-e4bc-41eb-aa15-08de1ada7e0a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3327
X-Authority-Analysis: v=2.4 cv=Uohu9uwB c=1 sm=1 tr=0 ts=6908aa03 cx=c_pps
 a=ECbzqkp4a+S0KsFAOAVhYQ==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=q6CKDgr7omsA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=5KLPUuaC_9wA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Vt2AcnKqAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=b3CbU_ItAAAA:8 a=8AirrxEcAAAA:8 a=KKAkSRfTAAAA:8 a=8b9GpE9nAAAA:8
 a=k-42gJp3AAAA:8 a=yC-0_ovQAAAA:8 a=oTOqbnW9x_6QonZdarUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=v10HlyRyNeVhbzM4Lqgd:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=Rv2g8BkzVjQTVhhssdqe:22 a=ST-jHhOKWsTCqRlWije3:22 a=cvBusfyB2V15izCimMoJ:22
 a=T3LWEMljR5ZiDmsYVIUa:22 a=uCSXFHLys93vLW5PjgO_:22 a=P8gMff4ppgpy92pg1mm4:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: GfGdwRLqJUwuH0cARhS_lxh61RcZLOM4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEyMCBTYWx0ZWRfXxuJ3m54NI84G
 mgqc7JtQy8CX57ZoRruXHrZSfQr/eDbTWHKdsme/wJEkZI1C0SiADlJFbcfkuU1c4iR1booUpTE
 m6fVIE2QfZWYMnV5hckQRUiHrkwnZ5W3KUcd/JpSjPwfCGD+FguaCfvLJhOObXb34FUUgKAvhly
 nWdnWRVmGUlxNilsEapgoQ48773IrzTbHmOVzeEsKIMUH7iuz1hjkFOjkA0GzAJ//npcX4h0Ld9
 EGnxhvdZlEu5q3BVt00HL4V75/w4KsIIhQQrezxxSn1zb0nfQXewx+s+Q3eSelaJQ16oOq9jYR9
 nLewNj5LAmAhxtrATR4ck6dbt/GkgfX8o2pHq708rsk6G+vwF+ayJXZhH7u+Qn0iro3K3CF95MY
 7IxQxpbHg8HApFF9rAwuzbTEbva41Q==
X-Proofpoint-ORIG-GUID: GfGdwRLqJUwuH0cARhS_lxh61RcZLOM4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_02,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030120
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

Hi Marek,

On 10/31/25 15:41, Marek Vasut wrote:
> On 10/31/25 8:52 AM, Alice Guo wrote:
>>> -----邮件原件-----
>>> 发件人: Marek Vasut <marek.vasut@mailbox.org>
>>> 发送时间: 2025年10月31日 12:11
>>> 收件人: Alice Guo (OSS) <alice.guo@oss.nxp.com>; u-boot@lists.denx.de
>>> 抄送: Alice Guo <alice.guo@nxp.com>; Etienne Carriere
>>> <etienne.carriere@linaro.org>; Patrick Delaunay
>>> <patrick.delaunay@foss.st.com>; Peng Fan <peng.fan@nxp.com>; Tom Rini
>>> <trini@konsulko.com>; Vinh Nguyen <vinh.nguyen.xz@renesas.com>; Viorel
>>> Suman <viorel.suman@nxp.com>; Ye Li <ye.li@nxp.com>
>>> 主题: [EXT] Re: 回复: 回复: 回复: [PATCH] firmware: scmi: Drop
>>> mmu_set_region_dcache_behaviour() misuse
>>>
>>> Caution: This is an external email. Please take care when clicking 
>>> links or
>>> opening attachments. When in doubt, report the message using the 
>>> 'Report this
>>> email' button
>>>
>>>
>>> On 10/31/25 4:36 AM, Alice Guo (OSS) wrote:
>>>
>>> Hello Alice,
>>>
>>>>> Would it be possible to fix up the SRAM mapping in:
>>>>>
>>>>> arch/arm/mach-imx/imx8ulp/soc.c:static struct mm_region
>>>>> imx8ulp_arm64_mem_map[] = {
>>>>>
>>>>> ?
>>>>>
>>>>> -- 
>>>>> Best regards,
>>>>> Marek Vasut
>>>>
>>>> Hi Marek,
>>>>
>>>> Configuring the memory region for SCMI communication as
>>> MT_DEVICE_NGNRNE resolves the issue. With this change, SCMI works
>>> correctly and the i.MX8ULP boots successfully.
>>>>
>>>>                   /* SRAM0 (align with 2M) */
>>>>                   .virt = 0x22000000UL,
>>>>                   .phys = 0x22000000UL,
>>>> -               .size = 0x200000UL,
>>>> +               .size = 0x1f000UL,
>>>> +               .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>>>> +                        PTE_BLOCK_OUTER_SHARE |
>>>> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
>>>> +       }, {
>>>> +               .virt = 0x2201f000UL,
>>>> +               .phys = 0x2201f000UL,
>>>> +               .size = 0x1000UL,
>>>> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>>>> +                        PTE_BLOCK_NON_SHARE |
>>>> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
>>>> +       }, {
>>>> +               .virt = 0x22020000UL,
>>>> +               .phys = 0x22020000UL,
>>>> +               .size = 0x1e0000UL,
>>>>                   .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>>>>                            PTE_BLOCK_OUTER_SHARE |
>>>>                            PTE_BLOCK_PXN | PTE_BLOCK_UXN
>>>>
>>> Excellent !
>>>
>>> Can you please submit a fix like this upstream ?
>>
>> Patch has been sent out.
>> https://www.mail-archive.com/u-boot@lists.denx.de/msg557766.html
> Thank you !
>
> So I think, this now covers
> - NXP SoCs -- iMX8ULP , iMX95
> - TI SoCs -- AM6.. ?
>
> How about ST SoCs ?


No impacts for ST SoCs.


Now ae are using OP-TEE transport for SCMI messages without external 
shared memory

             compatible = "linaro,scmi-optee";
             linaro,optee-channel-id = <0>;

=> the message are managed by only by OP-TEE channel

Reference:

- b2fb22396f97 ("ARM: dts: stm32mp15: remove shmem for scmi-optee")

- 3fce6bf21309 ("ARM: dts: stm32mp13: remove shmem for scmi-optee")

Moreover the patch is coherent with linux behavior

(https://lore.kernel.org/r/20211125150730.188487-1-sudeep.holla@arm.com)


This part was initially introduced by Etienne when OP-TEE transport use 
a static or dynamic shmem in DDR,

which was mapped by default as cacheable.


But it is more the case for STM32 SoCs today or in futur

(SCMI channel with TF-M use internal memory mapped not ccheable).



>
> Anything else left over ?



Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


