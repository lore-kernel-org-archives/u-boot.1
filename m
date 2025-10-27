Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97E1CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 17:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76CA2839AC;
	Mon, 27 Oct 2025 18:25:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="mJCFXEkL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82EFB839AC; Mon, 27 Oct 2025 18:25:52 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EC2F8394E
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 18:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=23951467bf=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59RH0jXl2336648; Mon, 27 Oct 2025 18:25:45 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com
 (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a24xvt7jw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 18:25:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gh7Um/zmjDxKayLQslD1tEOewPqBlpBJiQ24Vk1oDknL66wQNqiZDbU5d4vcxO7Lq3Pyv1/9XRdW6J5keLY/BfkyzJjilofWgg2cxvRsPaAav3hIQHqe1kgCEbQcrEAZ8Zq0djbYxmXkViBMEreZB4hhf502hxRSFNLjmlsTts6MdvBcOls4v/punrG4z/uDRJyjhtFXTRlEAE30gQkN/DwtlQvt5KMNcgANBADZF1czc6l4VDaMNSxfabLsovxh63wEz3M5kYUDMTsyCkoxKXflpyk4aHNyrheC831CQOMYB1fye4eDeLCXuGTuchrStAG7RDv+8dRR2pDuJ5OPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaxHpD30KSQu4dgvUNJUWJfeprOrxYiYUd4Zg8kT+QY=;
 b=U5NPcmu2L9eUo2BROxKeJEjlc1GOOU8ZZP8Xzt1FTUcadfXW4YYsnc0whXxwtJnVxOe98xLwayIHK1ZEKCmYh1+ee/7U/cdKXZ3zxFhd6vMaFmSVp3JWykLxTyjQ7MwcdT2GjEkDWkRblCOvxjba2tSeg9lS9KdSGQgm6vmbEwP/WalBikkaHoeyhOJCU691kzPGKUxeGK5CYOyVsT4/EjPIrnoHJhnGflZGbAJuZxYutdz3iWg2sVxa5nLDZj3ydLEPGt5GDI1VJRdfh6+lUsbM915fwpIyKC0b4pPVCSof7jKX9zMEcup9wz7l0wb4IxmzpiDSYE8OjGjCuyiqiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaxHpD30KSQu4dgvUNJUWJfeprOrxYiYUd4Zg8kT+QY=;
 b=mJCFXEkL7arHlr+Gt2CNmuHXhUkLwL8fueR3ld8iSHrz5FRmwbWhFJpAmvow794x+BSVPVxpp8qpsiuD8moLL4dYkLzLUM8jhgEju9JdC2g86mHsf+y3WmQUAlJsMnGOft9Le0zGvNJmvz72ka1A49ccKZ2EmbYLqtBwRkdpoDUWkeRoKKwt2KxjlDDK73TnIDnXCghM5gswTLHRb8JhKyiul8MVQVza2umPQgfJJsHT1lsQ7B0cbyc32W4v9nEbfh6QH99xCbE24tkkSjNgvacFNRxtFUM2PTHRTK+agVN/zT9mDIrJN5579OVfCR2bKred1afsxDeG86FeIrlWIw==
Received: from CWLP123CA0258.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19e::11)
 by VI0PR10MB8487.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:214::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 17:25:42 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:400:19e:cafe::70) by CWLP123CA0258.outlook.office365.com
 (2603:10a6:400:19e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.16 via Frontend Transport; Mon,
 27 Oct 2025 17:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 17:25:40 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 27 Oct
 2025 18:23:26 +0100
Received: from [10.48.87.93] (10.48.87.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 27 Oct
 2025 18:25:39 +0100
Message-ID: <64c3554b-d6b8-4239-bacb-37296ce5c9d9@foss.st.com>
Date: Mon, 27 Oct 2025 18:25:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: stm32: Add MAC address readout from fuses on DH
 STM32MP1 DHSOM
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20251023214855.181410-1-marek.vasut@mailbox.org>
 <20251023214855.181410-3-marek.vasut@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20251023214855.181410-3-marek.vasut@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|VI0PR10MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: cea80a51-9212-4424-9efc-08de157dda3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWJFcWdvQmxDMmt2b0xWSkxGeEZzL1FDOXExNWttbTM0dFZnWk5vQU9QWmNE?=
 =?utf-8?B?RWFHb2VwSis3ajFHWmlKNElHTGdBTEFQeE5McllNSjdybG1FeUswRjd0T1Va?=
 =?utf-8?B?d3o3d2gvMDljcTA3QUtmUjllQklYWWNha0thUzBscmR5U0t6M1VRcWtPUkVm?=
 =?utf-8?B?di9FUWJ6U216RHdOY04rbTJMdENrQkJtdFZmUzNwN3h3K0hpZDM3eEZta2Zo?=
 =?utf-8?B?Unh2bVRxYTBRZmV5UkkwcHJBL2g2alVKb0UzMGhKNlhFR01yREEzRk5sckdr?=
 =?utf-8?B?T0VzODNsa2JkeEYwVFhMT29sM1JsaGtxMFh1dXBkNTJzUTB6RkFJZ1ZpUjhu?=
 =?utf-8?B?ZS9FTE5oMU9CdWtWNDFqRGdJbDRIYzRxLy9XYzIzbkFEVkZxbXNVTFZOMTVP?=
 =?utf-8?B?TmUrUGI2Ky95Zy85NEtBNEpNSVR6QUhwY09ZODVZTWxtMzUzWXI4Q2l2Unlz?=
 =?utf-8?B?WXh1czRLUVZUZk9ubXNweloxRUFOVHB6TjJ1RTZRdTE2TWR2QnBBTFVCdE8x?=
 =?utf-8?B?UmJSMjNyWlEwU0FNWUs1KzUzT3hTTFNpUU5xM0tzanVwNmxLc3FQNzBSdk1S?=
 =?utf-8?B?N3pLeWtib243T0RsWTkyWUpvOUI0elArdktDOUhtRDRHR3VNUEhCUDZoakFP?=
 =?utf-8?B?NVNTQmFDaVc2d1FFWllvbVFORjFlZVprdnlvemRvQy9TREZtT0NmbmVXRUxw?=
 =?utf-8?B?ZWVPekltQUQxZi9EZlhtY2pjS1BSM3FUSkNGY1EvTFg2SkJyemp6RTdHRDZU?=
 =?utf-8?B?QUthVXhzWktQc09tQ0grVmZYOENudks1MVFhYTdyaGRVMEV4Sm5VdlpQdzY5?=
 =?utf-8?B?OTQ3UVoxRmpjdzkwQU1oR2lBTWs4MVZUaEZScUh1VkdPaEV4UWd4dEJ6M2dE?=
 =?utf-8?B?Wk1peHcvN3lxVlBnZUxIMVVLTDhEd3ZlOTdiaVhCbzBoWC8wM3RzQk9LWGQ1?=
 =?utf-8?B?N1Q2U29ZVnkrSk1MQnAvaElOMTEzaVJvVkVYUmd0cHNBaTc3a1lEbUxXNVVP?=
 =?utf-8?B?TkdxNnBrUWxtTmNNWXVkeHErdUV1UEhickljRWxWOTFueWtRTWtuOEpjWVFV?=
 =?utf-8?B?bTVSeDFrSzgraWFveUhhQ2xTUVQ3NmRHTi9rRTJubUdJeWQ1VXJLTDBETEpT?=
 =?utf-8?B?cFc3NlIzUnBZN0UxeFN1V0MwdEgvQlRQQzdBU25kN2FNOVI0T0M2MXN0MTg5?=
 =?utf-8?B?SG1FdXltTGlGdUxDditTakl4K05GdnBmSmF1cCtTamJ1dS9xR3VtSzl6V0Fi?=
 =?utf-8?B?bEc4d3ZQcEF6dDV2dHRNUUp5amZDYno0T1JpOExyQlpmZEJyY0pZMXV4Yzhr?=
 =?utf-8?B?S25wa1BXNC9DZWpzVGx0QmNTaUtPUGRKT0RXS0oxNmhiVG8wKytKbDVEQlpv?=
 =?utf-8?B?eTJnWUNVQUtrWmdVVmN5UjRNV3hZVnJNak01V0IrMUhEY3ZwZ1cvWmVHRGVU?=
 =?utf-8?B?RkNSSUFyL1ZhRDQ3TkRvUktRNXV2eUZhNytqZUxaQTV6TUl1M2p5eENWdU9U?=
 =?utf-8?B?WHBvOVNML092NFVJUE9ROGJ5bmg1Q1NRaUU0R3JhYWNqQ1ZQcjNXcWVYZHpz?=
 =?utf-8?B?MFFlMUtIWXRBRWdBLzdFZGgrWkE5a1lLUUwxK1FpNXBnUGd5YUZueEthekNt?=
 =?utf-8?B?RkQ2QUdJLzRGQm00T2xDbVlXKyt1elFYbHdmamJrZWZ0L0J1Y1ZNMzBJMkN5?=
 =?utf-8?B?b0pJTFhwQ0RmWWdtYmhFb3lMbXZnbU5SVWswMzVZQkhacmkvNk5xazF6YjZj?=
 =?utf-8?B?V0owczRMdjhIYy9kSHZLeVVyZjRyR1MxOSt3Z00wWnNkaDlxbnU2cVdDS3U1?=
 =?utf-8?B?blArSDNlOXhFSGg2TlBQSzlhK2kzTXNOcUZjQlkrS3ZZVDJrMmV4MEtQdWxR?=
 =?utf-8?B?ZEFZZVVpSWVFSUlWak11M0swL0RmRmJGVGdZZXZBSE5KOFZMTUhGL215cm5p?=
 =?utf-8?B?dXFpSkxTZndQQXRoeFRnLy9TUFJweGJUbmM1Z202OGo4RFVrVld3K3JHVlU3?=
 =?utf-8?B?amF5T21vb2MrellzcEFaNkpnaXF1c3lzNlVtV1F3YlFCK2dMOXpMRWsraXYx?=
 =?utf-8?B?ZzVLSGxLdklHbHBtbzY2VU1kbWU2WER2MmxFQlpwVmJHVGxLU3FMbkZBbERy?=
 =?utf-8?Q?XO1g=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.43; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:25:40.8632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cea80a51-9212-4424-9efc-08de157dda3e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.43];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8487
X-Authority-Analysis: v=2.4 cv=FNIWBuos c=1 sm=1 tr=0 ts=68ffab19 cx=c_pps
 a=zZ2aAuEz6FT5R9GdLdvfGA==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=b3CbU_ItAAAA:8 a=8b9GpE9nAAAA:8 a=k-42gJp3AAAA:8
 a=zk4-lHRcAAAA:8 a=phlkwaE_AAAA:8 a=rG1ne8FT4eNmTR5W3FAA:9 a=QEXdDO2ut3YA:10
 a=Rv2g8BkzVjQTVhhssdqe:22 a=T3LWEMljR5ZiDmsYVIUa:22 a=uCSXFHLys93vLW5PjgO_:22
 a=7cv85riZL9-k45RWW8P6:22 a=uKTQOUHymn4LaG7oTSIC:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: VokYiUv5UsubKwwXc-y7U7PRzMAwbZEg
X-Proofpoint-GUID: VokYiUv5UsubKwwXc-y7U7PRzMAwbZEg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDE2MSBTYWx0ZWRfXznMHYnJSxi/e
 UcKzFACepdUm6zgW3KFnW1V64w02QabB7bBpvw+5rqYHMkI39FWiqL6rtaUnozyBDlK0ndL4Tb+
 sARmrKw6nO4J1u3BSRNXVsrFkDlsR5mh1xTD/DNELLKN0ZJgiPAXu2v23cJBk/md7WrAHu4Np5N
 ztdQu7O8dzcey8IkoQ9Dkp3LA2viTMLCSA6T2IUg3Y74+pWWB2mtphx7+Bt2s+2jQbzvBD6B0q7
 rPsePmSHJb83h+61Arc/U0zV7qjDZdF+S6+d00J/xKz8R2c4M8MYC5cY0gLZqdHE9FCSwtjuwH4
 VVxBUa/gMqlMb8ILLsQIkQ9YEaMBXuPkxJhutZIbkU6YaXASkPPufn56+BXYOjybHTMa9KXsSKH
 li56Lo7cfOfSSspqQ/jWLzQODwRrsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270161
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



On 10/23/25 23:48, Marek Vasut wrote:
> Add support for reading out the MAC address from SoC fuses on DH STM32MP1 DHSOM.
> The DH STM32MP1 DHSOM may contain external ethernet MACs, which benefit from the
> MAC address stored in SoC fuses as well, handle those consistently. This however
> means the architecture setup_mac_address() cannot be used and instead a simpler
> local fuse read out is implemented in the board file.
> 
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  board/dhelectronics/dh_stm32mp1/board.c | 29 +++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/board/dhelectronics/dh_stm32mp1/board.c b/board/dhelectronics/dh_stm32mp1/board.c
> index 065d2f338c2..c18f1911fe4 100644
> --- a/board/dhelectronics/dh_stm32mp1/board.c
> +++ b/board/dhelectronics/dh_stm32mp1/board.c
> @@ -119,6 +119,29 @@ static bool dh_stm32_mac_is_in_ks8851(void)
>  	return false;
>  }
>  
> +static int dh_stm32_get_mac_from_fuse(unsigned char *enetaddr, int index)
> +{
> +	struct udevice *dev;
> +	u8 otp[12];
> +	int ret;
> +
> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
> +					  DM_DRIVER_GET(stm32mp_bsec),
> +					  &dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = misc_read(dev, STM32_BSEC_SHADOW(BSEC_OTP_MAC), otp, sizeof(otp));
> +	if (ret < 0)
> +		return ret;
> +
> +	memcpy(enetaddr, otp + ARP_HLEN * index, ARP_HLEN);
> +	if (!is_valid_ethaddr(enetaddr))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int dh_stm32_setup_ethaddr(struct eeprom_id_page *eip)
>  {
>  	unsigned char enetaddr[6];
> @@ -129,6 +152,9 @@ static int dh_stm32_setup_ethaddr(struct eeprom_id_page *eip)
>  	if (dh_get_mac_is_enabled("ethernet0"))
>  		return 0;
>  
> +	if (!dh_stm32_get_mac_from_fuse(enetaddr, 0))
> +		goto out;
> +
>  	if (!dh_get_value_from_eeprom_buffer(DH_MAC0, enetaddr, sizeof(enetaddr), eip))
>  		goto out;
>  
> @@ -154,6 +180,9 @@ static int dh_stm32_setup_eth1addr(struct eeprom_id_page *eip)
>  	if (dh_stm32_mac_is_in_ks8851())
>  		return 0;
>  
> +	if (!dh_stm32_get_mac_from_fuse(enetaddr, 1))
> +		goto out;
> +
>  	if (!dh_get_value_from_eeprom_buffer(DH_MAC1, enetaddr, sizeof(enetaddr), eip))
>  		goto out;
>  

Hi 

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
