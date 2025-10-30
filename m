Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBE2CCF9FA
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 07:43:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9994D838FA;
	Thu, 30 Oct 2025 08:43:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="IacXDUFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 949DF8390D; Thu, 30 Oct 2025 08:43:56 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D13E838E7
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 08:43:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=33980d621d=yannick.fertre@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59U7f2x51095146; Thu, 30 Oct 2025 08:43:41 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com
 (mail-westeuropeazon11013035.outbound.protection.outlook.com [52.101.72.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a4399r6yp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:43:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HF4MadTmN7PZEqrTzgQKoKP0GsAIYu2m8XWz5Z7VsG71lMNiUE+GDLT8P+cqmTb/7aJBVfw0mrPyWZ9IyubgNQC92x4YP9F3Mp8wPxaIwDyIuAQIoHwImbYJ4yYBtysiVvwStqVoWQRmk5PMw5j6MQOAIl4LvMGiz0hgy6ibD9aiMLw2VqfOEiJ8wP4RlLYzVT/pyO9R2DRexRHQ4bZEit2pRSmTUU/fipO4cAzpsa9XFQtm9gjZaArOZB3Hb1ZajSSptfFUX4kd6FBh6Xet9Dbduek9J6bEd+okUTJsLZo62mxGDs+0zhibAtDOZEL1LZs+hReXa6J8LalhCX7+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6hqhR0Y9eIVb1d6Jwm6jcUkubcYdThIwhMd2OlW00k=;
 b=Zi0EJRTpIU5eUo4W+kDkH74PIwKlSmjc4JkFpi38HlUVlL06ih34cLuE86DNwl1XR3VSW3KF+1NfBo7nD3cGidfqprmEJJqN9++UqYURtCUmn4/087GnY2ad75ZVY94Q2XemGqdsgHG00rKrduG7DEeEvzYcdac1YJZ4gO4MCc2iUPbo1pJxPoVxXP/W+42PAiPiJKmG2+h1eepiP/T88agtTbwolc0grwztKLS9T3enng9VYj9CKQdzQV4n+rTX32Uyq7Ol8d2vTEejvjO2uukmik4FpAZ3D60rPhfOsvZKEeNC2lrQ9EyfzKhjXVKB4SstHm5Zof97JJ3lNf++6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6hqhR0Y9eIVb1d6Jwm6jcUkubcYdThIwhMd2OlW00k=;
 b=IacXDUFRlT+PThyXngd193I+R3CsOaViEWyMUW6dGdCAtw/Dl/vWvKZot+LVzdk5PgnkiJRVS7g+9KGCoywQCDG9uJMJmz9OgW0oCoOyJVHLU/R8VtFnjRXwhG5RphFdi4FBR26JU6pJg3FaL6M5B1+YshE8o5OOWvAPXgG77z71nw1fUx8ZX5H+MsWYMZ8bsK3ZFH1FNo5Jdnh9GQYFMDcD4hNuxGl5xb9xe/IBp65AJkypVunP8BD3dxGJm49PdUy6IXyNMJC7cjjJgwmLSFKRQRL4zA9ci+TH+tcGUrAgpsdkH0JHTMoB+zkisf+HpgMEw5XU1DlJmLCTZvnfzA==
Received: from PAZP264CA0157.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f9::12)
 by AS8PR10MB7427.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ab::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 07:43:38 +0000
Received: from AM4PEPF00025F98.EURPRD83.prod.outlook.com
 (2603:10a6:102:1f9:cafe::6f) by PAZP264CA0157.outlook.office365.com
 (2603:10a6:102:1f9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 07:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AM4PEPF00025F98.mail.protection.outlook.com (10.167.16.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Thu, 30 Oct 2025 07:43:38 +0000
Received: from SHFDAG1NODE3.st.com (10.75.129.71) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 30 Oct
 2025 08:41:21 +0100
Received: from [10.252.23.232] (10.252.23.232) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 30 Oct
 2025 08:43:35 +0100
Message-ID: <ac267663-0663-4ab4-8456-fb6256d001aa@foss.st.com>
Date: Thu, 30 Oct 2025 08:43:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] video: stm32: ltdc: properly search the first
 available panel
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Kamil Lulko <kamil.lulko@gmail.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Dillon Min <dillon.minfei@gmail.com>,
 "Patrick Delaunay" <patrick.delaunay@foss.st.com>, Anatolij Gustschin
 <ag.dev.uboot@gmail.com>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@kernel.org>, Philippe Cornu <philippe.cornu@foss.st.com>
CC: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250904-master-v3-0-b42847884974@foss.st.com>
 <20250904-master-v3-5-b42847884974@foss.st.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20250904-master-v3-5-b42847884974@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.23.232]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F98:EE_|AS8PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 242748ae-bb9f-4dc6-a46a-08de17880a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXRiY0ZtU1B4N3RISjR2N3VxTEwrekg1OHU2bjA2aDBVU21qU1JWZm50RGpr?=
 =?utf-8?B?RnVVOERWMStFYUduYXhKb2Uybzh4Zkp2RHhlN0FIZld1WEVBb0IxbFZlQVUr?=
 =?utf-8?B?ampCN1dkOENhd0NPMEFTd1Jmb3NVWmZWeTNrRVlqZjlBSGlCVCtWZWJDYUQw?=
 =?utf-8?B?RGdLb2ttSlNkWXZtbzhmREVzOTZMdUpub3RKa2JOWGdWdll2NlZ5M1VvWE1K?=
 =?utf-8?B?ekJOdkpHTGVKSVUyZTQyQXNNS0ZkZERvR1Qyd3daems1WTlWNlRWOGlKa0p0?=
 =?utf-8?B?L094YlZZdnlDN1M5b3VMZ0MyNTgvODdrci94WGFVeDg5ZHlpNnZCVG9paXl4?=
 =?utf-8?B?MGxQT1ZkTXo5cUxqck81aXhOdVVyV1lzVmw3NU1BQlR2UTdFMEtIaE96U2V2?=
 =?utf-8?B?VVYvS1ZodWtTUVEvdjRPdlc1TWNPTGgyT1hBTVVibWpPVDBKcjhleWJjNGpJ?=
 =?utf-8?B?MXRlaEJqank5dnlNQ1ZhOGtOTEVMUGRieXl5Ym0xOFBWVkxZUlpUQ21jR3ZU?=
 =?utf-8?B?WlBJWWg4eWtGc2tsUnc1bnBWQlMyZjFqQksrc2Q1VSt3bmFlSnN3eEkxTVcy?=
 =?utf-8?B?TndubGs3blVoeEFNaVhWTDhpblJNTkJGZ2VPWXkvMUFFQTVGaG5XUy9ON29t?=
 =?utf-8?B?QW9ibndleVdObGhXWmovdU9mTFVjMjFxWXNZNFplRXpDdlFEeDJlZTdrU2ha?=
 =?utf-8?B?ekJGUU9yajNLK1VPY1EwRnBGWVFFQWFYeU9DdnBZQXd4UWFBWGVuaEFkbCt0?=
 =?utf-8?B?Y01Bd3JtbUt4RHZLdC96K2o1bEg5NDBET1BuZlRtVk5JUC9BMGlkWGMrb3E0?=
 =?utf-8?B?TWU4UVZ0d1NhMnZicVpNaVRzWjNPeTBqQ1d4QzE0NFo2aHFIdVA1cnhJNDBN?=
 =?utf-8?B?aXZscGh4ODNNTW1PaFZwSnBhTzVEMmQxaFlnWkFxRHNtb2lRQ1lJejFnRzkw?=
 =?utf-8?B?ZGRCd2I1MXgyU1RzK2xxbjRwVWllT1hXWlVSUTA2QXF1M0I3OG1NT24zaUhW?=
 =?utf-8?B?bzJVSEtTZ1JmUE9xOVUxdE5MY0tkZ3Q5cktRQUhJdkxVc0M4YUxCWVpaWkNW?=
 =?utf-8?B?UDI4dmpXWEJMMDZwdGxIVzc1NVEyNll0TThSd20vbFp0Y0FxTG10K0RrUi9E?=
 =?utf-8?B?d1Y1ZXd0R0ptQ0t5YlA2NGlUbUtTb1VDK2tuOUZkWTR3dEJlVW1tLzNBOVhO?=
 =?utf-8?B?QmpwNG1IdzhPbVlTcFR1b0ZmbzB4L04rMjF6elBjMEsxTUNNc0M1VlhNZXh0?=
 =?utf-8?B?TE0zU1pFM29ZT3Y4Nzl5MWxSV2pqNWZqekxrVUduWW9Nejd0Y2N4Zjh2UFdH?=
 =?utf-8?B?YzFJaVI3Yjd6RTA3bWM3a3F2Ylo1eitOdkdHOGJEV1ZhSUVSaTFmaWRFcTdE?=
 =?utf-8?B?RkpnVkFKVUVtVFR2cm5EekYvN2xGUW5DY0hSZ1R5bUZ1ZzF4QVNiMmVaNU1n?=
 =?utf-8?B?RUpua3lRQVhQVEtaN25GZkxmY0tudDd2RlVKeEtQc2tpSTJlRldiS2liemVs?=
 =?utf-8?B?UzFTTzZJd2NERExsNW16aEIzN0NFUkZiNVV6cU05cTVTUzJBR3I1emVuQlZH?=
 =?utf-8?B?VzZwRkRwRjZ4K1hCNnQwbjU3MnpFcFlOYWJmcDZKNkhraytkYWNyR0Erbyt3?=
 =?utf-8?B?TjA0dzNENDRKeVl3TDJYRERaOGN4QmN0Z0hNRmsxcjlNUjVZcUI0cHI3YUZj?=
 =?utf-8?B?Q25NbjMwVExsaEozK2VLNEdicXgxNmNYVlg4ZnRhR3RiTnMrRHJTNHMwN2pZ?=
 =?utf-8?B?MUdOdlpHT3J5VkFyQmthSWVsY2RORzduOGtSYThZZ01PTkhpbFVsZHd6OTBL?=
 =?utf-8?B?d1E3bVZxbS95Y2ZvME94MmJzRU12N0huN1FkeUZCcC9wOVBVZ0dpVnVlYlJF?=
 =?utf-8?B?M3QwNFB4WHNRRGZIdlJ4RmNvWldUN0xSS3FoVDJsbnpUaWFaL0VFY0tYYjRI?=
 =?utf-8?B?S1YxYzZ5U1NTREVrVDV3SXJ5K0d0VmxmRml6RzlyYyt2VXMzUGxGd3RKd296?=
 =?utf-8?B?Y2k5Z2MzM3NxbXQrVmdUaFR0dEU1aDhCdEdOeGFDWEJKVVR2cDRQb2dpN1dR?=
 =?utf-8?B?clM1NHNKamo0bjBndnFXeDZKWmcxTmNnREJTTFBPcGtTRjVFKysxOWVMU2Ez?=
 =?utf-8?Q?Pm7Eg7QWrQifS0ahzIFrYMUa3?=
X-Forefront-Antispam-Report: CIP:164.130.1.43; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 07:43:38.6016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 242748ae-bb9f-4dc6-a46a-08de17880a2c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.43];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F98.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7427
X-Authority-Analysis: v=2.4 cv=api/yCZV c=1 sm=1 tr=0 ts=6903172d cx=c_pps
 a=sGfeb9PwuAfiW5dbaiAd6A==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=ttam_Flv6DUA:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=941mOKHnnHugEBzshyIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: NPDCKVaarpBn-AnCQxMAelHBaIlp2sCn
X-Proofpoint-GUID: NPDCKVaarpBn-AnCQxMAelHBaIlp2sCn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA2MSBTYWx0ZWRfXzNVB+WYOsbIO
 OAioJWHROQDydYAJ7yeTdo7XC0WiPY6ymO4if3Ju4W/gV6YWoQjDe8hwQ49bH0Nrsa9KEPQrq3m
 +ApPaNgVaBnwTMNfnS664maQpePaelQJTwVtKPt4iGEe79trIvHdp8OsBvOdyfAiztDfAQyojsc
 zxZdCAMntDcPE7uybw911NUGRQNRD6FeskEID1K8yoAzi7hTU/jYjtiC6g9yZz8rnyC7VGibL4n
 SY86sLLb2FlN6VYdHnBxdiuAOjKJ5FpAY4Ey1Kx0qa37BWeJZxbGHjZerbrzlaKXnzzq1a5sXBr
 SIWXrgKf1Y3H+mznkawVynEJrQlYFDskzPzZoK/SwJ2BDDuWArFV0Zgyor2a94MGRy6ei+iYHJf
 gK+/tmNNMlcCBo8jB+hB5Vk/2drTNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300061
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

Le 04/09/2025 à 14:53, Raphael Gallais-Pou a écrit :
> Initially there was only one DSI bridge with one panel attached to this
> device. This explained the call to uclass_first_device_err(UCLASS_PANEL,
> ...) which worked fine at the time.
>
> Now that multiple bridges and panels, with different technologies, can
> be plugged onto the board this way to get the panel device is outdated.
>
> The lookup is done is two steps. First we circle through the
> UCLASS_VIDEO_BRIDGE, and once we get one, we search through its
> endpoints until we get a UCLASS_PANEL device available.
>
> Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>   drivers/video/stm32/stm32_ltdc.c | 136 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 125 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
> index efe9a00996eca0301d2a2b82074ba9690a967a73..834bfb625d2d34a44bd8edff1c92af6dec344c20 100644
> --- a/drivers/video/stm32/stm32_ltdc.c
> +++ b/drivers/video/stm32/stm32_ltdc.c
> @@ -17,6 +17,7 @@
>   #include <video_bridge.h>
>   #include <asm/io.h>
>   #include <dm/device-internal.h>
> +#include <dm/uclass-internal.h>
>   #include <dm/device_compat.h>
>   #include <linux/bitops.h>
>   #include <linux/printk.h>
> @@ -495,6 +496,101 @@ static void stm32_ltdc_set_layer1(struct stm32_ltdc_priv *priv, ulong fb_addr)
>   	setbits_le32(priv->regs + LTDC_L1CR, LXCR_LEN);
>   }
>   
> +static int stm32_ltdc_get_remote_device(struct udevice *dev, ofnode ep_node,
> +					enum uclass_id id, struct udevice **remote_dev)
> +{
> +	u32 remote_phandle;
> +	ofnode remote;
> +	int ret = 0;
> +
> +	ret = ofnode_read_u32(ep_node, "remote-endpoint", &remote_phandle);
> +	if (ret) {
> +		dev_err(dev, "%s(%s): Could not find remote-endpoint property\n",
> +			__func__, dev_read_name(dev));
> +		return ret;
> +	}
> +
> +	remote = ofnode_get_by_phandle(remote_phandle);
> +	if (!ofnode_valid(remote))
> +		return -EINVAL;
> +
> +	while (ofnode_valid(remote)) {
> +		remote = ofnode_get_parent(remote);
> +		if (!ofnode_valid(remote)) {
> +			dev_dbg(dev, "%s(%s): no uclass_id %d for remote-endpoint\n",
> +				__func__, dev_read_name(dev), id);
> +			continue;
> +		}
> +
> +		ret = uclass_find_device_by_ofnode(id, remote, remote_dev);
> +		if (*remote_dev && !ret) {
> +			ret = uclass_get_device_by_ofnode(id, remote, remote_dev);
> +			if (ret)
> +				dev_dbg(dev, "%s(%s): failed to get remote device %s\n",
> +					__func__, dev_read_name(dev), dev_read_name(*remote_dev));
> +			break;
> +		}
> +	};
> +
> +	return ret;
> +}
> +
> +static int stm32_ltdc_get_panel(struct udevice *dev, struct udevice **panel)
> +{
> +	ofnode ep_node, node, ports;
> +	int ret = 0;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	ports = ofnode_find_subnode(dev_ofnode(dev), "ports");
> +	if (!ofnode_valid(ports)) {
> +		dev_err(dev, "Remote bridge subnode\n");
> +		return ret;
> +	}
> +
> +	for (node = ofnode_first_subnode(ports);
> +	     ofnode_valid(node);
> +	     node = dev_read_next_subnode(node)) {
> +		ep_node = ofnode_first_subnode(node);
> +		if (!ofnode_valid(ep_node))
> +			continue;
> +
> +		ret = stm32_ltdc_get_remote_device(dev, ep_node, UCLASS_PANEL, panel);
> +	}
> +
> +	/* Sanity check, we can get out of the loop without having a clean ofnode */
> +	if (!(*panel))
> +		ret = -EINVAL;
> +	else
> +		if (!ofnode_valid(dev_ofnode(*panel)))
> +			ret = -EINVAL;
> +
> +	return ret;
> +}
> +
> +static int stm32_ltdc_display_init(struct udevice *dev, ofnode *ep_node,
> +				   struct udevice **panel, struct udevice **bridge)
> +{
> +	int ret;
> +
> +	if (*panel)
> +		return -EINVAL;
> +
> +	if (IS_ENABLED(CONFIG_VIDEO_BRIDGE)) {
> +		ret = stm32_ltdc_get_remote_device(dev, *ep_node, UCLASS_VIDEO_BRIDGE, bridge);
> +		if (ret)
> +			return ret;
> +
> +		ret = stm32_ltdc_get_panel(*bridge, panel);
> +	} else {
> +		/* no bridge, search a panel from display controller node */
> +		ret = stm32_ltdc_get_remote_device(dev, *ep_node, UCLASS_PANEL, panel);
> +	}
> +
> +	return ret;
> +}
> +
>   #if IS_ENABLED(CONFIG_TARGET_STM32F469_DISCOVERY)
>   static int stm32_ltdc_alloc_fb(struct udevice *dev)
>   {
> @@ -532,6 +628,7 @@ static int stm32_ltdc_probe(struct udevice *dev)
>   	struct display_timing timings;
>   	struct clk pclk, bclk;
>   	struct reset_ctl rst;
> +	ofnode node, port;
>   	ulong rate;
>   	int ret;
>   
> @@ -568,7 +665,7 @@ static int stm32_ltdc_probe(struct udevice *dev)
>   	}
>   
>   	priv->hw_version = readl(priv->regs + LTDC_IDR);
> -	debug("%s: LTDC hardware 0x%x\n", __func__, priv->hw_version);
> +	dev_dbg(dev, "%s: LTDC hardware 0x%x\n", __func__, priv->hw_version);
>   
>   	switch (priv->hw_version) {
>   	case HWVER_10200:
> @@ -589,13 +686,35 @@ static int stm32_ltdc_probe(struct udevice *dev)
>   		return -ENODEV;
>   	}
>   
> -	ret = uclass_first_device_err(UCLASS_PANEL, &panel);
> -	if (ret) {
> -		if (ret != -ENODEV)
> -			dev_err(dev, "panel device error %d\n", ret);
> -		return ret;
> +	/*
> +	 * Try all the ports until one working.
> +	 *
> +	 * This is done in two times. First is checks for the
> +	 * UCLASS_VIDEO_BRIDGE available, and then for this bridge
> +	 * it scans for a UCLASS_PANEL.
> +	 */
> +
> +	port = dev_read_subnode(dev, "port");
> +	if (!ofnode_valid(port)) {
> +		dev_err(dev, "%s(%s): 'port' subnode not found\n",
> +			__func__, dev_read_name(dev));
> +		return -EINVAL;
>   	}
>   
> +	for (node = ofnode_first_subnode(port);
> +	     ofnode_valid(node);
> +	     node = dev_read_next_subnode(node)) {
> +		ret = stm32_ltdc_display_init(dev, &node, &panel, &bridge);
> +		if (ret)
> +			dev_dbg(dev, "Device failed ret=%d\n", ret);
> +		else
> +			break;
> +	}
> +
> +	/* Sanity check */
> +	if (ret)
> +		return ret;
> +
>   	ret = panel_get_display_timing(panel, &timings);
>   	if (ret) {
>   		ret = ofnode_decode_display_timing(dev_ofnode(panel),
> @@ -624,11 +743,6 @@ static int stm32_ltdc_probe(struct udevice *dev)
>   	reset_deassert(&rst);
>   
>   	if (IS_ENABLED(CONFIG_VIDEO_BRIDGE)) {
> -		ret = uclass_get_device(UCLASS_VIDEO_BRIDGE, 0, &bridge);
> -		if (ret)
> -			dev_dbg(dev,
> -				"No video bridge, or no backlight on bridge\n");
> -
>   		if (bridge) {
>   			ret = video_bridge_attach(bridge);
>   			if (ret) {
>
