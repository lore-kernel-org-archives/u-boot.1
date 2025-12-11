Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411F9D41C2C
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 12:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E867D839DE;
	Thu, 11 Dec 2025 13:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="P/gfRHp1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8053F83B48; Thu, 11 Dec 2025 13:27:19 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA4E383642
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 13:27:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=444057107b=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BBCN6v11360703; Thu, 11 Dec 2025 13:26:53 +0100
Received: from gvxpr05cu001.outbound.protection.outlook.com
 (mail-swedencentralazon11013058.outbound.protection.outlook.com
 [52.101.83.58])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4aymkr2n2w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 11 Dec 2025 13:26:53 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kue7jQL7gxWYVzQbD4RQABMDrZq65MgTmJgIrmlPTCQkM2107Xm7Bg7PIDHNQPOonh4TaFZi94tnasZy6o8V4Yb1dBZ/rtwcsuhV5bhsKA6bfu4nhrE7zxSwSiCmu0189zYJgGlqu4M4MCTtCh/9dgnR8w0+peEvZ8G15VuTHxceg4w4BmRsO7aD3rfe/2NAypS4Np+/DAx1SY2U8KRFekIGt6LHLdBsqbRkHMWYtfds4R/S/lusQw6UF9qIA/Ea1rY8sFVVHUZxMgq0623cOado3ub3xEVzvWHn282rwsbSZa4ocLB48qYUy5O5prfDI6egrorUjsgxAP8nuU9ZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGwk6ycvG4ZsaoRRzZnQNWsFQzQsbMrFU6K5dI8eQVM=;
 b=n85me/GLQLEHOpmemkKeNiLqIqppcuXbcjfsaRQJAq7HIY9d0aBYRbbAQFwq0UVptEkvvwrqoX/wBMwRyn/gfMGVnTAkBrzQs9Xe7m9tvAPikvVFBzrjvs+g7dF1wJINAeAJx/bumN+O5Wqg8Ql4xf6g/YFcPfGcWc0jHwoY+U0Wz6FkIBFf1ROiw8xVnB/mDS5eJYzm0zJyks9Sf/BR7EFVwYl6XaojGRtfqC+Lk3W5OGWBHe+wP05bOI/NbTREFbgoWKpN/KjnV5hYOf8/SnmnVZoff9o325MWxURvBQmatg+5j8AGfNrPCBZ1TfKAj/Z9DM7kdIr9sFmVCttpGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGwk6ycvG4ZsaoRRzZnQNWsFQzQsbMrFU6K5dI8eQVM=;
 b=P/gfRHp1KcxvcLMou4d3EeUoMM9vLn0cGiAprgTAL1guE6Qi1m9JvZhePfaZIUkxlJXtN5tPnSrhwgdf98tJyFYV3dLCuzU3nEVWQif82lgtOWQgShCjwaQYdqkhEbwtXCGuVPEijILk3bSZu4ARUKzQAGuArvmCpz4P7LTHXoqnuUhl8ctj4qjg20P9mH5yvHZ2caxQC+3YCWQf0gpUgDuoFC4KUEYoayHRaiXb0xZf1gnGqZkUnIYLqHjE6W0EHOEp6bfTWn1iNuXxZGCcpwg/ZY4Jqh6PC6xdnhJMnD6afToO6FfySyHel3uamTlbLe8jaxY8MWmassH9QpQzzg==
Received: from AS4PR10CA0027.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::17)
 by DU4PR10MB9665.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:63e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 12:26:50 +0000
Received: from AMS0EPF00000194.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::11) by AS4PR10CA0027.outlook.office365.com
 (2603:10a6:20b:5d8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.9 via Frontend Transport; Thu,
 11 Dec 2025 12:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF00000194.mail.protection.outlook.com (10.167.16.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 11 Dec 2025 12:26:49 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Dec
 2025 13:27:33 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Dec
 2025 13:26:48 +0100
Message-ID: <aab5d66e-bbb2-4b82-bf9e-8a0e43477646@foss.st.com>
Date: Thu, 11 Dec 2025 13:26:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: scmi: export scmi_clk_resolve_attr
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Alice Guo
 <alice.guo@nxp.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, "Vinh
 Nguyen" <vinh.nguyen.xz@renesas.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Ye Li <ye.li@nxp.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Christoph Niedermaier
 <cniedermaier@dh-electronics.com>, Peng Fan <peng.fan@nxp.com>
References: <20251211-clk-scmi-imx-fix-v1-0-9579567da829@nxp.com>
 <20251211-clk-scmi-imx-fix-v1-1-9579567da829@nxp.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20251211-clk-scmi-imx-fix-v1-1-9579567da829@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000194:EE_|DU4PR10MB9665:EE_
X-MS-Office365-Filtering-Correlation-Id: 499056ac-445d-47e1-466e-08de38b08f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cU9UVHJzSGo0cnM4RXpFY0hlSVVUcjMrRUxUS1dvZ2ovRXdHKzZoUUlVdG1q?=
 =?utf-8?B?ekFIcnpZOXlkZjhlaXFBYW9qMkthSkQ4Q1RxcVRYR2xVeEZzMVdEQVlLU3I3?=
 =?utf-8?B?RUtPcFVqeVFSZWN0YnNwb0RydDgrQStxOXRDQ1FFcHZpMTBJeFpwZDB5dWI1?=
 =?utf-8?B?RUFYR2RuVnVEdTdiQWRISjQzWnRZMHhGL0pyaWg1YlJXYmlpTTNWZ25Id0ps?=
 =?utf-8?B?WmdmdGkwUXQ4aUVveUl6dHhBaThQbFpCS29ZeEZQVmNaRGxvWEk5ZGlWSEo0?=
 =?utf-8?B?VzJsUDRUV3l5TnpFS0piL3l1ekRvWWZ3TXJzRDZXU09jWENKS2ZXaEEwZFdk?=
 =?utf-8?B?TEFXOFpLUkU0d1Y2dFdlM2FZOUNSRVoyd0tMck5Kd04wcWI0UVdvRHk2Zmox?=
 =?utf-8?B?eW1qNkI5YzNkdnBwWW1QREYwdEpFbDU5d2ZLNDkra2EzMnoxVG8ydGVCeEJL?=
 =?utf-8?B?TUV2SFZHSWlacXNiQ0J4dWhtdXFzRzZteEl4SUxnQkZhRU5hRVRXcW41QkJq?=
 =?utf-8?B?dEJNQW84VnBvRVJtT2V4SmhQM2w3R1R6bVh1cklLdWhqR2R6ZHg2bUxLYXRs?=
 =?utf-8?B?b0xqVEJ2eWQ2ZGNVclNkWkFuVTlWNUdKYjBMNDQrdXpiY0xRS2pEK25MZVRp?=
 =?utf-8?B?U3pYblR1ZGg4eXU0VEVsL2JyWlBlTXduMlJtaWtrSDZwSUdSTCtFcmQ3eHJz?=
 =?utf-8?B?UExZb1hKdU4waGJsU3FvYzRFQitPTmlrUmw4L2dpRXhjakk3RUxZSzZHTzky?=
 =?utf-8?B?bjVLbnFtWVFXd0RJSHBhR0pjY1BOOWdVTkxud1ZHWGpWT3A1emRXazhpUHNk?=
 =?utf-8?B?aG4zWTV3NHYrWTFZUHI1bHFpbEx3dFlmNk1hRTFBVWlJempaejNuUm5rWld1?=
 =?utf-8?B?WmhoRXovMTcwQVYzd2M0dDlvOUxGb2Y3MjQvS0traXJWVGtNVU4wWFVHVS9B?=
 =?utf-8?B?N2xwRTkzamVpb1VUcUphYkdZVUtmaFNwL0Z2dmMva0JhbTAxek9SdjFMWlRo?=
 =?utf-8?B?RW5paVl5Rk9qTFRhbUcyQlF2N3gzUktIbi8zZTUrYk9qRUFZTXlJcFJwcis0?=
 =?utf-8?B?b1RRdEd3dHJ0VmlVRVA0Vm9iV2NjRk5KUnVPS1RXbnNGQWFaNmZLUUZmU2xO?=
 =?utf-8?B?bGh0MkxySmpuWUhPWWtxbSt6ZHAzVnBwSnZXZy82UkpMallqazVFeEFaMFJT?=
 =?utf-8?B?VytEbDdqSGhkdWNjeDY1ZDlxeGxEckU3cGduQlcxRW5yYjk1Rzlkc1dVQWlq?=
 =?utf-8?B?UXJWS3VMOExaQ3JMWnBuZnV2a3pxSSsycDFWdlpFTDZuWjJtK2Q3YjhTL2tp?=
 =?utf-8?B?YUdKZW5lUk50RE1ScXpUMzFYdTYwTDBPSURSdTV2aWZaS3FzeTE1ZEJLSUFC?=
 =?utf-8?B?enp4bVJCS0xpdUdyTDdXUXlDSkpEV0xZOHc5Qk9pZUhNTUF3OW05ZzlHNElP?=
 =?utf-8?B?bHI0QS9sRTBXT1pleDBHVjdYWlJSc1dTVEtMNlcrSkxnU2RPU0FZRmdUWlBV?=
 =?utf-8?B?V2ZsNnFrOWVZeG5KQy9mN1pma2toV2xUQkpEVzlvMExRV2VpRFE2Tm1oUlph?=
 =?utf-8?B?TWJRSFVYMlhuVUNaL3YvdXVDVkVDNWlzSytzeXd4ZWExU1hNYUM3MHNLTDJF?=
 =?utf-8?B?TzRKbUg5UmorbGdHT0ZucU1TekVVWVR4TDdtdWhQb2dHNzlnQU5MZEZjbzFQ?=
 =?utf-8?B?QTFvRWZUZU1pTytoZzV2N2QzUndqUnZjNXQxUDlOYlVqUTlKTVV4VlV3Uzg1?=
 =?utf-8?B?ek5CTTZ1M1N1L3Y3WXJLL1NnMXVCbjNPUmtBc2E5NGxqbW5DVU95SHVaYm10?=
 =?utf-8?B?T2IybVhuQkw1SU9VSXRhUE9oRG1JYTE5Nm0wWDM2ZkpyekpONHFLM0hyOGxS?=
 =?utf-8?B?UWlvRVJVR0tid2lGcWFvd1RvcFRzNE9WWGc1MC9Ud2tGWlYzU3NvSkNpUWlz?=
 =?utf-8?B?NU1VRkpDUVhYMEpXeHZ1ZE52aU5KZzN2c21SZGhhdVVxYVZvcVN5MStFY0dq?=
 =?utf-8?B?T1RTRXM5MGZJb0EwWEozMU1Ua0pUT3oxcEcvYkRoem1NZk4rS1NHc3p0NS9S?=
 =?utf-8?B?d1lrbXdhOU1OcUpsdFRjek5ZdmpDUm9UT1hhRXhyWjBvcE1vbU5YODdRU05Y?=
 =?utf-8?Q?WVck=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 12:26:49.7303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 499056ac-445d-47e1-466e-08de38b08f07
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9665
X-Proofpoint-ORIG-GUID: 23622UcigTOfpiua3C1wbvQryLmoGFd2
X-Authority-Analysis: v=2.4 cv=QvhTHFyd c=1 sm=1 tr=0 ts=693ab88d cx=c_pps
 a=xFT3qlHD+1xS+TaMy1FbcQ==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8AirrxEcAAAA:8 a=8b9GpE9nAAAA:8
 a=sKOxfsJ37bmbxYRla5kA:9 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA5NiBTYWx0ZWRfX3YvJc/cekugJ
 4Y36mTthgPeE0p+M6Oq+CCuP4wVb4aqrNzqQ/P/FXroZw3y/F0N+x1ZmqslEIA7hXycscXXMumq
 2WiMhP1qB1iM+NfzQUhTP2+7hpSjyYnCuyOcePA3OWSZx4KswnMU5ve4tybw7//NIsNMDZTlhxP
 4oOMLV6OBxv+1JzlFCQavDFvuZ6Xi65ckz/C3PFG7AErNc80DBYyoO+t4bSWY6YCw7kYTF6j0U1
 QRL7TkLzgaeRy8vU261kvVnrdgw7HS+zWTof/A6LXwuxqfz10bTBOe3psq4HKzde41Pzkccb+SW
 7f0OIqfTuzFTn+b75pNBIQ2f6oORDYARVrB1uvwiKkjaKkVvtIIYNYGnL/Y5AKvTkB4fmro0B21
 z1M1aZs0N/Fo0Y/mib91C30k6IW6Kw==
X-Proofpoint-GUID: 23622UcigTOfpiua3C1wbvQryLmoGFd2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110096
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



On 12/11/25 09:31, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> With commit 3547e315c188 ("clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES"),
> the SCMI clock names might be defered. However the SCMI clock may be
> input to other clock controllers, such as clk-imx95-blkctrl.
> 
> Without the clock names being resolved, there will be error:
> clk_register: failed to get hsiopll device (parent of hsio_blk_ctl_clk)
> 
> So export this API for users.
> 
> Fixes: 3547e315c188 ("clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES"),
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/clk_scmi.c | 20 +++++++++++---------
>  include/clk/scmi.h     | 12 ++++++++++++
>  2 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
> index cbd44f310b1..bc665e0bd3a 100644
> --- a/drivers/clk/clk_scmi.c
> +++ b/drivers/clk/clk_scmi.c
> @@ -6,6 +6,7 @@
>  #define LOG_CATEGORY UCLASS_CLK
>  
>  #include <clk-uclass.h>
> +#include <clk/scmi.h>
>  #include <dm.h>
>  #include <dm/device_compat.h>
>  #include <dm/device-internal.h>
> @@ -170,7 +171,7 @@ static int scmi_clk_gate(struct clk *clk, int enable)
>  	return scmi_to_linux_errno(out.status);
>  }
>  
> -static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
> +int scmi_clk_resolve_attr(ulong id, u32 *ctrl_flags)
>  {
>  	struct clk_scmi *clkscmi;
>  	struct udevice *dev;
> @@ -178,7 +179,7 @@ static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
>  	struct clk *c;
>  	int ret;
>  
> -	ret = clk_get_by_id(clk->id, &c);
> +	ret = clk_get_by_id(id, &c);
>  	if (ret)
>  		return ret;
>  
> @@ -188,7 +189,7 @@ static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
>  
>  	if (!clkscmi->attrs_resolved) {
>  		char name[SCMI_CLOCK_NAME_LENGTH_MAX];
> -		ret = scmi_clk_get_attribute(dev, clk->id & CLK_ID_MSK,
> +		ret = scmi_clk_get_attribute(dev, id & CLK_ID_MSK,
>  					     name, &attributes);
>  		if (ret)
>  			return ret;
> @@ -197,7 +198,7 @@ static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
>  		if (CLK_HAS_RESTRICTIONS(attributes)) {
>  			u32 perm;
>  
> -			ret = scmi_clk_get_permissions(dev, clk->id & CLK_ID_MSK, &perm);
> +			ret = scmi_clk_get_permissions(dev, id & CLK_ID_MSK, &perm);
>  			if (ret < 0)
>  				clkscmi->ctrl_flags = 0;
>  			else
> @@ -211,7 +212,8 @@ static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
>  		clkscmi->attrs_resolved = true;
>  	}
>  
> -	*ctrl_flags = clkscmi->ctrl_flags;
> +	if (ctrl_flags)
> +		*ctrl_flags = clkscmi->ctrl_flags;
>  
>  	return 0;
>  }
> @@ -224,7 +226,7 @@ static int scmi_clk_enable(struct clk *clk)
>  	if (!CONFIG_IS_ENABLED(CLK_CCF))
>  		return scmi_clk_gate(clk, 1);
>  
> -	ret = scmi_clk_get_ctrl_flags(clk, &ctrl_flags);
> +	ret = scmi_clk_resolve_attr(clk->id, &ctrl_flags);
>  	if (ret)
>  		return ret;
>  
> @@ -244,7 +246,7 @@ static int scmi_clk_disable(struct clk *clk)
>  	if (!CONFIG_IS_ENABLED(CLK_CCF))
>  		return scmi_clk_gate(clk, 0);
>  
> -	ret = scmi_clk_get_ctrl_flags(clk, &ctrl_flags);
> +	ret = scmi_clk_resolve_attr(clk->id, &ctrl_flags);
>  	if (ret)
>  		return ret;
>  
> @@ -312,7 +314,7 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
>  	if (!CONFIG_IS_ENABLED(CLK_CCF))
>  		return __scmi_clk_set_rate(clk, rate);
>  
> -	ret = scmi_clk_get_ctrl_flags(clk, &ctrl_flags);
> +	ret = scmi_clk_resolve_attr(clk->id, &ctrl_flags);
>  	if (ret)
>  		return ret;
>  
> @@ -402,7 +404,7 @@ static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
>  	if (!CONFIG_IS_ENABLED(CLK_CCF))
>  		return __scmi_clk_set_parent(clk, parent);
>  
> -	ret = scmi_clk_get_ctrl_flags(clk, &ctrl_flags);
> +	ret = scmi_clk_resolve_attr(clk->id, &ctrl_flags);
>  	if (ret)
>  		return ret;
>  
> diff --git a/include/clk/scmi.h b/include/clk/scmi.h
> new file mode 100644
> index 00000000000..9c669ba4adc
> --- /dev/null
> +++ b/include/clk/scmi.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#ifndef _CLK_SCMI_H
> +#define _CLK_SCMI_H
> +
> +#include <linux/types.h>
> +
> +int scmi_clk_resolve_attr(ulong id, u32 *ctrl_flags);
> +#endif
> 
Hi Peng

I encountered the same issue on STM32MP13/25 platforms.

First, I converted our clock drivers to use clock indexes instead of clock names
and proceed with clock name resolution inside our clock driver implementation.
which was complicated and riksy because STM32MP13 supports both SPL and SCMI boot.

I was about to submit my proposal, but your solution convinced me.
Using your proposal, it's much simpler and less prone to regression.

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice




