Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160A8CCF2D3
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 09:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92EE28313B;
	Mon, 19 Jan 2026 10:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="nom8nOIu";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nom8nOIu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D0FC8389A; Mon, 19 Jan 2026 10:36:48 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55CB6800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 10:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=dRr9YS7R1isvqCfIBhcNGVW/IP+hZK24XRJIYmtb8RBMgyq53BB5RLXBh+j9//paZrkN/SVZ12URwrDTUVQ9IRfy73m7vZzvXLcYhdfacnKQnhA650cUm/cIEyVB3xfsDhomr0BQ+NsyeKs7RcKHbvRqTIWhwbc35F1Z3abe1nVmlFsbvLvPUVki5OrNya4Hi3C+S6K6gRq94G/jVHCCIBBoY1GF2j7RvrdtAjqiogzwdumonerYP9QtDbJ/mGqqLlvSov1TIGwS6Y28FFlbZ+rnUb7IEBGxZ6PfcWuVnRb8sUrkQgyLDANfJAgQ4nqGX3DCHHlS7rVLdxodexes0A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BTj3aFyREQrGX5xVNiQJBUMfq7h5AI2dex+CPSsBZo=;
 b=GIHWHyt7sY74TCE19bj/k4GV0zWq+bhaIyR0OySkgLGYYY8q6oPEsokMAq9hzS5AO8Th4lrjKL7OE5cOEf3kEnRNeVYZTwS2m+FfQnYS8+2f6FvK6VTNwx0DJtuDVG2kmin6dA0Pn/TsA7gJzalW+yth9wBDtb7/CaJgAu81wURg6N8PXc28zhwe3QHc15m5MvlP5r0BxHtTtkgxUI67WSIpl0hfx5ZaWCl/OaSBNVfB2k4C50+lbbG+4eGtsbiEIT0nQ2xb0De08wslqslP/b1O71eLUVYbJj0+CpGSfBNI1JtMEwpeChNTwSXZBrCme3CnUE3BqzcMmQS6spJO/g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BTj3aFyREQrGX5xVNiQJBUMfq7h5AI2dex+CPSsBZo=;
 b=nom8nOIul5suDb1v28pih8sB69cWWH4FSTejKS0o9W8WYW93OtrNX7ptQCugZe4mf4TmGvMMuN7TVOfSuIhR82wk7+Xf93CSZf3m/lJdo19nC6LHJCbNXVFJQZ1B9YPzZGkqyjQ//whAbasutV7M8dQIqFK0LlB0RDVu79dI42Q=
Received: from DUZPR01CA0214.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::19) by PA4PR08MB6190.eurprd08.prod.outlook.com
 (2603:10a6:102:e6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 09:36:41 +0000
Received: from DB5PEPF00014B96.eurprd02.prod.outlook.com
 (2603:10a6:10:4b4:cafe::6) by DUZPR01CA0214.outlook.office365.com
 (2603:10a6:10:4b4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 09:37:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B96.mail.protection.outlook.com (10.167.8.234) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 09:36:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO9rWJuY9XWU9EH+U4h3Sc6Cng+Z8rMy8ef+h7vfzPDfBL2JPTgyeOPdfZQC8F+ybiKI0D4xuuzKeenkTcsFR0XSsxiUU3bSVbWsjrQ4NXC/siDEN0nMWPKq8SU5dvUdpTGUnYKDcLEN311lsmdpydhWlh2pYzVjqm0uHujcXiauUT/h408a4Bp1ya46qxlWPRPNPMA+bXBVk+fEn/JlJ1GzqmAcljd4lc4SjEt6PZ/vVbZJBmR1CminjXNf105v04DvaOmM5gQlBqIhJ6uYKUKj6mbTVTgylw9lPvw9VvnyV6rp3phHD51ow918ClI+ThG60zijGvxR5itZTK61NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BTj3aFyREQrGX5xVNiQJBUMfq7h5AI2dex+CPSsBZo=;
 b=E62HX2CbD9M/Cno4JqCIiBY3r/MgluIVkdL9vt9Yavxd+stz/KbzOuHvJzIGgi9546BPY3A/tM4XzcSXdpaKTcJtqi5S1yl+BoPTF0va3R3hERLdpUMxvvyrN7RtFAW5XBUc2bjpvBBR1FHvwV+KyZ5+TW4gcrpClIDxWvqgbRsdAd/R2871xQ1WONO8N/2/DsgKfG/5QmqUdkRrqAkUTDHfbXoBP0d58TlnrffA1udNhdVwGAPG0j8B+xa+vLj/FgoDpH6mLo5lzq0QCsydZqTr1sDvmEBH4cy294HCfxVGYV4kW/08l2htADqYnDyNFashSqSY4I57bT4RDPDMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BTj3aFyREQrGX5xVNiQJBUMfq7h5AI2dex+CPSsBZo=;
 b=nom8nOIul5suDb1v28pih8sB69cWWH4FSTejKS0o9W8WYW93OtrNX7ptQCugZe4mf4TmGvMMuN7TVOfSuIhR82wk7+Xf93CSZf3m/lJdo19nC6LHJCbNXVFJQZ1B9YPzZGkqyjQ//whAbasutV7M8dQIqFK0LlB0RDVu79dI42Q=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PAVPR08MB9793.eurprd08.prod.outlook.com
 (2603:10a6:102:31d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Mon, 19 Jan
 2026 09:36:06 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 09:36:06 +0000
Message-ID: <d43b3f64-9a44-4461-8534-3b945a4e784d@arm.com>
Date: Mon, 19 Jan 2026 10:35:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] net: lwip: dhcp: Do not write past end of buffer
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Martyn Welch <martyn.welch@collabora.com>, Benjamin Hahn <B.Hahn@phytec.de>,
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>,
 nd@arm.com
References: <20260114-tftp_fix-v2-0-8de8e6ecf4e8@linaro.org>
 <20260114-tftp_fix-v2-2-8de8e6ecf4e8@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260114-tftp_fix-v2-2-8de8e6ecf4e8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0334.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::15) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PAVPR08MB9793:EE_|DB5PEPF00014B96:EE_|PA4PR08MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9d3658-62f8-4977-ce94-08de573e403c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?VlFhYjIvVVNXamNFZEYwM1E5ODNsNzd2MHFFZ0NKZDUzVU5YaG5nenZFMXEv?=
 =?utf-8?B?OWsxRy9vcVBRVkYvdTAycm5EcHBwWk4zZHVtdUozRkp3WTNEUWN1SlduN0R6?=
 =?utf-8?B?aXRzckRTVHhpNUpjN1I4UDhpU0owMERnU1FiRjJCaFFlSkxkRHVuOFpZQ0N4?=
 =?utf-8?B?SmlnOWU1dTJTdGt4aU5BSlVPUXkrRXpadEpDUFFYYUliQTBRMHZNK3NVWHp6?=
 =?utf-8?B?QmZuUlc1UDkxMzVXVFF5eXdPV0pHblJoTVRkK0VkRDYwS3FaQmpvcnlkeTU0?=
 =?utf-8?B?YXkxOTQrWkFhSFd1ZFpYcFVHMVlXWFI5b1FYOXgzZUdlcUh3bTJnbTRsenR2?=
 =?utf-8?B?dGdwZmVBZlZHSDV3ZmN1bzNHdlRDTFFia0NkcWh2ZHphZnV5OEdDSmw4bjdM?=
 =?utf-8?B?Z0VwZmJhT0YyMlNSUDdsSzN0dUJqNmlVcmtpYUxNWW1Vd0dVY3hHbkpoczNW?=
 =?utf-8?B?WjJHMmoxZEpNYlVWSEFIRTVZS2YvVzdUWkNXSk9MUDFweUhxZDdOWmo2RXlv?=
 =?utf-8?B?eUhsdzlzM1pWT2RmZENodGlWL0RsVSsxZ1BOM2JsOVgwN3IrUEhUWTk0NVU1?=
 =?utf-8?B?ZUNiblViMndlRTdSTjBDVmpoOFhRZjVaRTM5M2c2bjVzZzFsbWxDK2NGQXVU?=
 =?utf-8?B?UnUxaHREMU05MTA2VmhPVFhNOFB4UXVDTzEzNXcvUTRPOEJzTkcyTE5pek1R?=
 =?utf-8?B?ZzNTVzJOVlc4dkFBTXFnMzRieVRRR2dsWFZQcXVtOWExekZBUmJqTkFrQzlu?=
 =?utf-8?B?d3RXWlJvNm1jeGV0Ryt1UGZ1SGlVY3dDQ1hoK1NJT2JpRUFLRVNqbGdqZ2hk?=
 =?utf-8?B?V0JaOWVyeEVpdU5TMWhWT1R0S1VnWlFONHRSWXJCM0JpU1VYM0IrUEpVem1o?=
 =?utf-8?B?SURLdjBMcEk4N0xvaHNNZTNIUXZEZDI2d0tDOHN2TFQ0c2JtaFhEYk9FVEc0?=
 =?utf-8?B?Ni8rTEFia3RDMHdzVUlCNnFXNnQzYms3dzBiL2hBcldMUGVUWjRKeG91RTNa?=
 =?utf-8?B?R2NBOTFkVHdaU0ZkTHhFeDROSHRtdzFzb0krbnRham4xbHpEc1M1NzcvUzlD?=
 =?utf-8?B?MEM0OUp4VHhEMnE3QlVpZjdjY0tCYXlpbmlMUU42TGwzYWZxTEZPSkxEMncy?=
 =?utf-8?B?SWhZdGpxV0kyUWN5SmdPV29tNDE1UktVdHN0b1FmWHRDeFpid3VqZ3pNS0tZ?=
 =?utf-8?B?d01ORE5qdDdtc0FyNm1McnR5N1IzSEt2R1FsWGpCTFhaMi9hQy80ck5WUFU4?=
 =?utf-8?B?UU01QU1IKzFtbVJLQmp0clFjd1d5bm5hUzZQTjlaa0RvNnFCcHU5N2tQbUZS?=
 =?utf-8?B?N0pMT1RJYkwwTTdFWVVnb1FseitHZlhIMTBMeVNCbXJXMS9FR0M0aFRYU3hO?=
 =?utf-8?B?dzBQb2JxSlZGWlk0WUorejFGSFpRcjF0bUlCb0dwWTlLR1NDRHhOeko0QTdv?=
 =?utf-8?B?NTR6UThUS3VkTmZXbzhwbldFMk95MHRxSElPUWdiWEVvblVxZ2lWTEZ5ZW9W?=
 =?utf-8?B?Rk9EdkR3RWpIcUo3bXVaYWpOei92bHNQak1EYlJsVlJ2WXRpajkvUUNYalZ2?=
 =?utf-8?B?TnNOWHlkcmlSd1ZoWlNqK3BHT3FHSHVuNVNiRG5KRHVFdVEvNHRwMkJHMVNt?=
 =?utf-8?B?UGFSYTVJMVJNa0drS3JXcklyaUYvSjFXQkdjaDB3RElpU3kvSkh1TW04NEx6?=
 =?utf-8?B?cTgyMzFvZW0zVktrM1JuMDc3VTE4VzVCeWY1Y25KcSt0RjNscXFibEN4Vjd1?=
 =?utf-8?B?MUpuNVdwU3AyU1VVbXBibTlJN2l2cEZ1YW4yZkFvZHlBR2lqcEFVVjgyT2pz?=
 =?utf-8?B?WVJMbDVpc1owV3g3eTVVZW1nNlVUbkplb0Z1VkI5YXVsTnFQOUduUU96WEIr?=
 =?utf-8?B?V2Y3aXZvZHhDVis1Vk5HQWt5UUxWUjdnMlp0OFRtYnovOUhzejlpQWpBR1Fr?=
 =?utf-8?B?Q2VBMXZSdFdLT3NkL0RnSVVnWjA3QUM5b3BDV2YzTEZLVlJFek1NdlR3dkEy?=
 =?utf-8?B?VWxSKzFDa1FTTzdxdGZiejU3b1BzMFZpQXkwZzB4VFpPYnY5Mit4S1lSNFcr?=
 =?utf-8?B?L0lud2Q0YStZVFRKSEJEUDhiWkZZbVlpa0pNRnE2bDFXWXVrWlB6TjQzVHF2?=
 =?utf-8?Q?umhw=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9793
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B96.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7bd2c9ae-ee2e-4fe9-d59b-08de573e2b6c
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|35042699022|1800799024|376014|7416014|82310400026|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGxIaEtNcHQ0YnRzTEw3VDc1VlJZOEd4YUxlTXFiZkhIL3F4NTBxZ25JKyt0?=
 =?utf-8?B?R2J1REMybjE4UEFJek5KRk5nTXFGWmRqSUxmQTl2dHowYU1FdFZRYTk3WDlC?=
 =?utf-8?B?TTJmV2s3U0o0UlE0eXZXKzFCYzRER2FYUHRPcCtqU0dkMFhPanVjMjBhYS9F?=
 =?utf-8?B?NnB2aEF1SjdsbzNmanlFcWtNNmYvdlBUOWFvRndHS3pzRGF0S1FLV1hueEc5?=
 =?utf-8?B?NzgzZHYyNGtyQzdZRldzMEVjbDY0ZkNrRCtrb092cUdrb0MySTdlRXdLS3hr?=
 =?utf-8?B?RGxHSjZRZ0I1aXRWRzF1WDhqa2lFUzB3RzRvVHd4NHlMeUUyek83TTRKM1Fw?=
 =?utf-8?B?Q3RDaGNUNXhoTE9kSVYzYjhjb1d2eHA1SjJBWjhRdUZBN0pWQUJMMUxsakR3?=
 =?utf-8?B?ZUJQUkYxa0QwWDlCeEtjeERpb2VpYmxuQW5KdnNjbU5icHVkdjFQeG9pa3N0?=
 =?utf-8?B?dloraGZycmlJZkRUUDhLZ2UvRit5eWJhLzNuQzZpeTByMWhUNy95dENXTTQ2?=
 =?utf-8?B?dC8rV1RpdEtzeXNnSktpWXJhVDl4bWI1a054ZS9nZmxKR2Yvc0xuSWlGVHpu?=
 =?utf-8?B?bVB5QVVMdk9wMlZMa3ZzS0l6QWdMNGxKR29RTFdKd3VQNnUvSXRyaUwydXJC?=
 =?utf-8?B?b3BuRHVySzBEbmoramwwbGZtd1VpSWRPcWhTVTlYa0NmUHJhMTZoOE1nakkv?=
 =?utf-8?B?U2VrSjZOS0RtNjVhNjUveVZJbGluVGFzOWxQU0hMSktaejdoZXc0ZlJTYnBy?=
 =?utf-8?B?OVd6OTJIMkR1dWh5UjZ3ajlndU85djdZNW5HSGNTbTgvM1BKOHhXVzVSSVA3?=
 =?utf-8?B?UFMyYnRIVlF3eGtXY1lXVGJoOG5JV1YvVmpIZmxmc3BRbTRUTmdheU1SS2xM?=
 =?utf-8?B?RDFQdkJHQXd6NlJaNkxoL3E5em4xRStxUDVhdmsvRVBuVHhEaGthM0l2L3hO?=
 =?utf-8?B?cmpmbm93N2xWenFhMTF5MlRUcWNkd0I3TmVzc29YenNxcXhFZFJlMHA4Q044?=
 =?utf-8?B?ajdUaTFLTWduRkR6QzJvSmc3VGp1MkRxVkNKc3hESjFNaWpnL3JWd0tUUmg2?=
 =?utf-8?B?UWxnaVFvSmtkU012ZmphQjdKTFdJSjVmODY3R2hqaFphZGNxZVM2U2dJQk5s?=
 =?utf-8?B?MXV3T1VpQ05wemYrNnVSTll5OWp5eEdPYThja2Jwb1IvandmRHlZcWVtNkF3?=
 =?utf-8?B?Tjh1b3RoZk1vQ1RqMDY1M0N4MXlsWExxMVA0ZUNIRWpuTTd1dFVNTUlRMGkw?=
 =?utf-8?B?MGR2em1WWXUxRlVBMUM2eWJ3UDA3VElacGRwMFZXYXpiaFh1dXZPRHgrUWFv?=
 =?utf-8?B?Mzl5ZjdPYm9Dd1V4elk0aFJDRHMwTTduVnJla3AzdE1hbHh5ZW5oNVNPLzhJ?=
 =?utf-8?B?bUV0RldMaUJyVjh3V2FGWWZUTnB6eldOK09ZbzU3anhxSjM0a1N1Tm1ablFu?=
 =?utf-8?B?NU0wWFBrLzQ3UHM2RDJXWSsyVkQ4SWdhNXhWQ3loQTV0WHRWZ3BWVW4yT0Qz?=
 =?utf-8?B?aVFGZU5Wa3loNTh5RStHeHJDNVpWeTZZc1RQWU9iRENFRVlrTnQrWlJLTDZ6?=
 =?utf-8?B?Rm9SWlJ6ZWw4NU91NzZxVWlXTzF4Ykd4aXdIS29uRW9IV1MwaTJjSlJYRm9h?=
 =?utf-8?B?alRyWXRJMnhuRUZlTzZJbEJVR3VDZ0R2QjQ3NVBuQTBvbTlScG1PeldyMXE0?=
 =?utf-8?B?a21ZR0VTb3R1NlcrcytMRTVOdzBPOXJVNE0vSUlid0xENWwyZmJ3bjMrMC9j?=
 =?utf-8?B?U2N5L05FQ2pSYmptaHBCZ05NM2lHZmVQYTBQYWJKWDRjK3NCQk5Jb0xzdWlP?=
 =?utf-8?B?R3l5bUYvSWp0b1JLRThTeExqQ2Z6OXBuditGLzhDUnJ5d1N0M0huVnVjZW1s?=
 =?utf-8?B?eVJLYzZTd1N5R0liV1RIOFBHYmlXK0EyL01qT2t2Zjh4bEE4RGs0b1NIUDdW?=
 =?utf-8?B?UGNvdHJtckZaOGhLRmRvdmwxUG82dXV1WDJYK2JqdmlHY2h0ZHRsNjdqMzJQ?=
 =?utf-8?B?SjVhenNoSlZCYzAzWjRtV3hhL1VVL0VlQjFPWmJvclhhUGNtSWRBeEJpbXFz?=
 =?utf-8?B?My8zM0pwZkJCUnlBb2JsL0xLaUkzN2xqbnZ3a0I4RG5QWnRpeHBzTmlQeTJj?=
 =?utf-8?B?bS9ZN05mNzkvUjdZejRxam1TWmpqUEd4bXVmWEFWZlo3WlJWOURDWktjYXlN?=
 =?utf-8?B?WWpCZzQxNVdhMVVHZkk4cVhuSlpRcEtITVpHYS85Z1FGTCtoUU53SjNiMklN?=
 =?utf-8?B?Q0xtSDdETHZScTUvd2JzZ05rN0ZRPT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(35042699022)(1800799024)(376014)(7416014)(82310400026)(14060799003)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:36:40.9503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9d3658-62f8-4977-ce94-08de573e403c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B96.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6190
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

On 14/01/2026 16:12, Andrew Goodbody wrote:
> sprintf will write a trailing \0 at the end of the string so when
> writing into a buffer, that buffer must be sized to allow for that
> trailing zero. In the DHCP code when the index is a number needing two
> digits to express the index would use up the two \0 bytes in the buffer
> and the trailing \0 from sprintf would be beyond the end of the
> allocation. Fix this by adding a third \0 in the buffer.
> 
> This was found by code inspection when looking for an issue reported by
> Michal Simek, but I do not have the hardware to reproduce, so cannot
> confirm if this addresses that issue or not.
> 
> Fixes: 98ad145db61a ("net: lwip: add DHCP support and dhcp commmand")
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  net/lwip/dhcp.c     | 6 +++---
>  net/lwip/net-lwip.c | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
> index b798014ebcb97dee688e29ccb34da916296c6772..731b57de3ba4336a22fee5957b6e2163360d78a1 100644
> --- a/net/lwip/dhcp.c
> +++ b/net/lwip/dhcp.c
> @@ -30,9 +30,9 @@ static void call_lwip_dhcp_fine_tmr(void *ctx)
>  
>  static int dhcp_loop(struct udevice *udev)
>  {
> -	char ipstr[] = "ipaddr\0\0";
> -	char maskstr[] = "netmask\0\0";
> -	char gwstr[] = "gatewayip\0\0";
> +	char ipstr[] = "ipaddr\0\0\0";
> +	char maskstr[] = "netmask\0\0\0";
> +	char gwstr[] = "gatewayip\0\0\0";
>  	const ip_addr_t *ntpserverip;
>  	unsigned long start;
>  	struct netif *netif;
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index 8741f65fe12e23cc30068506453a762533f8a67f..0fa33730a636727d0718625215a69002242810d0 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -108,9 +108,9 @@ struct netif *net_lwip_get_netif(void)
>  static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
>  			      ip4_addr_t *mask, ip4_addr_t *gw)
>  {
> -	char ipstr[] = "ipaddr\0\0";
> -	char maskstr[] = "netmask\0\0";
> -	char gwstr[] = "gatewayip\0\0";
> +	char ipstr[] = "ipaddr\0\0\0";
> +	char maskstr[] = "netmask\0\0\0";
> +	char gwstr[] = "gatewayip\0\0\0";
>  	int idx = dev_seq(dev);
>  	char *env;
>  
> 

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
