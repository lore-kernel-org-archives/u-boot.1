Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BB0C87FDB
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 13:25:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 675908329C;
	Mon, 11 Aug 2025 15:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="HKuzu5ql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D14DF832DD; Mon, 11 Aug 2025 15:25:22 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6FA48311B
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7PdqD0YsmuYvImeLAkW6lyLDH2s/er00Zfn/N4RQsQtgSecxTub2Dl+293IG5OUeC0V5ZVj1J2jMuXCKFVUZ4QrnAbYOB6EiPpzNPFHVl8forKoTmT5AgzlMdCMJDVyGZLlHSS3/SdOvuw0+cAzGQfqKOIZOocbklFMlsRC5kXFs9nUjfk+koFSWDk2gwRDod2AplYyfAiUtTQTSLL0LttZUNGZGNn6f1+VDdLjFv68lorwsBQb7gcDDnNJgjJtgU/OfZHedEInKeoYyo6gAuzC33w4jrjBjxEjv5U42WpTvmE3jQGYvlfTsk11VGuHW7azvNhlbn/G96JZPwuY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gocUfbNXexr3Rw7zPhKDgrowZw/ER1BtjhhvIwKnZ9c=;
 b=Saus9lJ0RWe1qDRj/oOQH/EEoBtfCFHwgzfUC/f/74masMtbC7vl4UIkKc2IOcZNbUEwCZ6PhMH8xSiT7Hln26li+m4luL5xpn85QN+2j6sGBlnvzt2RBEwFW8Myl75YjqLJA2t8jcQVjTzzAvRUe7RRd+pr/dbN/ZsvDRHh0mkT9yn9T4nbRRohNBBO0pRHy4njx8EpxKlP/ZalAuo9w8tVaXqPsNCIZwrt0A5vQxt6w62gpV18iYqzFBvKxJbi8gz8QYILuq7g8yjtiJSrcdG3Z9GlwIGustVymAomCLAK2UuFjLXx5TdcJZeEmZa6bXcwm9dzL+WOBdkrtG00yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gocUfbNXexr3Rw7zPhKDgrowZw/ER1BtjhhvIwKnZ9c=;
 b=HKuzu5qlzTY+Z0TpQcIwuPvUnP8flWNvPe9uxDHfd0gz/MwGUjeviOwuPwVnHeS2jujhxBzBkBUxkhjX8aewom+7SQjBvxh2qerebDW9PtCw1gJvCiV1wCDt7NVEtLN0VbW31wmVHkJlnJPBM1NdpRr9Nq46OyhWRQLpzv4V1jQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.12; Mon, 11 Aug
 2025 13:25:19 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 13:25:19 +0000
Message-ID: <2cf42a18-ac9a-4ccd-a45e-9caaad4ebbec@cherry.de>
Date: Mon, 11 Aug 2025 15:25:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: dts: renesas: r8a779g3: Describe generic
 SPI NOR support on Retronix R-Car V4H Sparrow Hawk board
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
References: <20250806145903.8996-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250806145903.8996-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0439.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB9626:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a856c3-bfb9-49ac-1cf7-08ddd8da8483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXVrY2xhano0a3ArQ3JRNmllSlhFeDBEMDcwTWd5cy9tYjlkWUFPNllaZlpB?=
 =?utf-8?B?RG9xbGNNTGtwRWx4UDZBa1FsQ1k3SW9ncEZZc0ZHVVducnE5OHNndmdsSGNY?=
 =?utf-8?B?ejUvSGV6Q3J3V0xPUU15L3c0dkRKaVBoSmlIZXROWUNRakp2ZG5aOVhrYmdz?=
 =?utf-8?B?MlVoSFdybk5FZnBodDNHYjQweSsyWnlISTREVnV1a214UXFkcVV0TXV2OFZ0?=
 =?utf-8?B?VG8yempkZmFjZXMxeDdoNlZ4VjVRT3dRZDhCaXlGdHU0SVJ4MnVEaWVldUtO?=
 =?utf-8?B?aFJ4QUwyVnNNanpzZEcxQ3EyY1M0T082c2QzaXpIalFsbVl4cW1zZ1NWYVVS?=
 =?utf-8?B?UG1qWWZ5VVhnMy93L3Z6UlJFT3cvK1p2NCtzbGdBdlhRcWhUZ2FCY2NnWVVh?=
 =?utf-8?B?REw1SWNnSFloTFU4NlJOMDVLdGtNdVA5QThCbS83Nmd1cDdJZWk3RDJ6VnVv?=
 =?utf-8?B?dWszcndIZitjMlBVdjFHM0lxQjZCRWxuWTZMdUcxUGxYTWI3YkVnQW5nSVls?=
 =?utf-8?B?R2hJaGRtYlNSU0E1RmFoYTFnWk1JS3h3RXk5eU10eU16Q3dQUWt2cE5ZN056?=
 =?utf-8?B?QzV6UHVQN3dmd3Uxem9RVlF5RGtNRHR4eW9LSUl4UWJGTnFoZG9YZXVJZXpo?=
 =?utf-8?B?U2NRUVpRNWx6RFowcElsNE12c3hGZkg0VUV2M1VHdXk2RWJhMHZHeWV5cTJx?=
 =?utf-8?B?aGhoV2JFdnRiS0pIL21Hd3FidkhEYVFJcTdwZWlqZTJHSHBBeVNDTUxwOXBs?=
 =?utf-8?B?MWZ4VnNCWi9OdjZyQkhnYkU2U043SVdXZzd2eVJlUnJMcDBHMGd1blZoZ1Bs?=
 =?utf-8?B?Q3VaNnFOQW92eWZET3QwUGdDY0JiSCtCQWp5OFJtckhsRWVVcWhzc0R3VFdw?=
 =?utf-8?B?a0pnVzdpMnZvSHB3cEw2ZndEa0NIM2xqZE9xMkZvcnBlcWJ6VzY5N1RIT3ND?=
 =?utf-8?B?aTFqaldUYzI2dXRxMmNmMGVqdnA1dTArVHNpOVJRSHBuUjYyTTJ4WGVBam5B?=
 =?utf-8?B?alJQcUY5K3o5UDVoYjlKSkVUbHgyU0Rud0lEWHBuUWZ4bVhXM1ZLYXcyVUpG?=
 =?utf-8?B?ZE5SNmR3aTBWcFVzeGMxcGRMY1hoSy96TVJ0Y1M5ZGdFRmREd0hCLy9Ka25D?=
 =?utf-8?B?MG1TNkxxVjNmdXdqb1VVMWpkbFVsWGUyTlhaYVExanN4VVhrQ0h5NUNiOXo4?=
 =?utf-8?B?RHdYOGN2MTNuSjFnaUNIR0ttQ3lKNmNDOUZKMll4alBFbjZTSVA0ZUxhYk5q?=
 =?utf-8?B?Y3Vwb3M3OC93YzFIVGZGL29QZkFhaUIxTEt5TGhONmZYaHRLMDVIaFdSM3lj?=
 =?utf-8?B?eURIWjU5UWtZd2tLMmMwOEVDOXkwMWYwY3hGVCs5UFBYb2hEanFNbzFFSVlC?=
 =?utf-8?B?Qkd3NFBJcUxwWTU4TUNKNFlwWTh0ZHo4emN0eVFRUzFrRDFwbnpvY0xCQ0dR?=
 =?utf-8?B?VUl2ZEVTOHM0SGVTYzF2Y3RpRFYzMWR1cnVCMW5EMTIvOHd5TUtpTnFuOEtl?=
 =?utf-8?B?RFdyRm5UTHpUWDZWL1ZwQ2RrTUxETlhiMU5KUnZRR3dBM3k1MFkzS1dheE54?=
 =?utf-8?B?N2VrWEVxSkhaSytmUHhuSnREaHNqd1ZnQm00Nmgyd3VoODlRbWsySWZhVDd0?=
 =?utf-8?B?WWN1eldlTDJnWVNTd2RvcVBrdjJFcDVRUmEvOXVVTjc2S21JSlZLZGMzRFNS?=
 =?utf-8?B?UGNaYmtFaFRaQWVrOXRvWkduVGltdW1wSGtUNG5Ya2NzRDkwSVRaSllHOW1C?=
 =?utf-8?B?alU0Tmt3WHlBMnBDRXNoSnp5TXdHMEdUZVplcVVTL0Z6M3ZURkNCM2NGalJ5?=
 =?utf-8?B?Q0IrSjdTMmxoa2RtVmJRbjArWEptRWkzM1R2cVVTL2ZBVUQ2WlZvdm1YV2lp?=
 =?utf-8?B?UjZjUitBNDlVN2Q3OEJvQ1RXT3M1ODZTaGJzY3pZTTIwNFpkemtEeFl6OURq?=
 =?utf-8?Q?0Vjs53nhZu8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEpDa3lNRkd1WFJEY01Ea2dFazYvbVpFTEgzRUdEQ3NCNitFWFpTMkdKTzNO?=
 =?utf-8?B?MkRncTdKZmJuUkdwc0hCblVKY2ZkN3lNYXpkVTdSWnU0aFZISTdiYmI5RDk3?=
 =?utf-8?B?c0ttcktTZWJIWm1EWnRUeE1DbXFMd1hRWjcreUJudUNraHIxbXNqNFBvWFBL?=
 =?utf-8?B?emRNQVozM0FZL1picVRNZFRxVmZocGJjK2tVUlozMjFDR3ZYOTNOUWNzRXZr?=
 =?utf-8?B?eGNueVkwSUo1eXhlVnR2bnlHR25weVI0V3A5c0IwMmxyOVc3bGpuay9EV21E?=
 =?utf-8?B?dVRBRGNOSzhrNzBJSk9GSk9uZERRUXQ5eU5FZ3lWNTI3WnF6VXBhRTZ6MHhl?=
 =?utf-8?B?UGFkUXVrZEkzNGJnMWxETUpUNTIzdkJIeWp6N0ZLWlZXaXB5VWNCZ2wrVVRO?=
 =?utf-8?B?TWFKenVxRjFuMlE3YmQyMS9ncmlLb0IvUDluMnVWV2JkSFBLQXBNQ25ZTFhX?=
 =?utf-8?B?ZWp1UktFUVM5aitDME5EWHlwbi9URjdXSkRscWJtK0VlMHdqWGR4NkI2WU1T?=
 =?utf-8?B?OXRqU3M1Z21sSmZDVkdrRFR4djFCOSt1ZHZkbTZNZWtvY1RmSlcvMGlFQWpW?=
 =?utf-8?B?eFgzRUw2RU9WcFFNN1F2dmw2eGhEOVlkWlJ0cVRyQUYyN0E2aXFVQWhIM0NR?=
 =?utf-8?B?ckdCbEhFQ1pJZFowUG5aWDZ2Wnp4dFkzSGFPbll3ZEg3clhXWkJQVWdGQ2hp?=
 =?utf-8?B?enVGY09weGNaYWZCTzIxRU1tSVBQdHpwL0t0MlA1STJqcWxyZmFGV1krRWVU?=
 =?utf-8?B?eGlib20xaWM3K2ZoWEEremlEbWtCaHNOSTlKVUZSWUlOc0dnYy9UZi9JM1hW?=
 =?utf-8?B?OW5RbjRsZGdDUlRUakkrWXE4K0I4bTV0SStaUHkzZHVQcDFJbDZuOWo5ME4r?=
 =?utf-8?B?WEg0aS84ZkRNZXZUNGJDY0tkblVYeE5tZTV6emZPc0R0aEUwOVdoOU14djZ1?=
 =?utf-8?B?SXM2TUw2U3MzRzVUNW05OEtDUDhwWGtwTlN3YkRJR1NaQU1EVGFCazZSaDdy?=
 =?utf-8?B?b3NOTXVmQXE3TGFOR2RkeFZJRUlJOWpVVGRFMWg2QzVxaWpJUVhqd1I5eVow?=
 =?utf-8?B?MHNTMVdlUC9JRGthbDQzVDJrYnhoanlFV0NvanYwSlNTNUpSOVJuTVEzdFF4?=
 =?utf-8?B?b0ZQOGM2R3RIL3l2VWlVYmpYZ1VlSmtJaWw4RkhEdzNlcG9lNGZJRUpEWTE5?=
 =?utf-8?B?aHRZcnNkSUpjYmpVeG8wTHJLdVQrRjhPZHcyWmxPaFk1K2lSc21HYlhZYit1?=
 =?utf-8?B?OW1xTnE3b1JkOHZjczdUZWRiU2ZiVDV3ZlhsZG5RblZ2aGZEUWZEN0JkZUhu?=
 =?utf-8?B?Q290NUdWZi9JOEdmc0R6UjIxc213S1B5TDNRNkVzZG1MbmhqdVlVN3YxdVUz?=
 =?utf-8?B?WXhqaitFSmtONjNuUUcxUDJKOWVGekY3QnUyUEJkZjJ2dUNYOWNkYks1dENi?=
 =?utf-8?B?dWowNVduZlBibVptODVlQ2pDbGJpOFBLeDlZQlptUjFDUDVVZG9BT3FkNk53?=
 =?utf-8?B?QWJjWXZxTkZaaTZnaUk5OUlhZEtlb0I4c2JHdGQxUGxsVTY2RVkyTHNpaWFE?=
 =?utf-8?B?SDlXUjRwZEFXbGp5bGxiUEsreGhZbWdmWWlja3ZaS01vdFlVa3htUUZXWEhM?=
 =?utf-8?B?bjhSSmhha2pYNTRZdDVHTzF5TS9Hb21JbjU3ZjZGZEk4ZkF4QjZTZlFiN2pm?=
 =?utf-8?B?ZnM2M2pITklTV2daRnlsYXhqL1g5NTMrZGI1c0lKS25kemtTeloxVmZUL1hp?=
 =?utf-8?B?VEJPckpRU0hlRGhWcVczN1hXOUxidXNxSFZSN0N6WGdLbU42eGtMN00wZklt?=
 =?utf-8?B?NGhWUGlBd3JDYlQ5TDN2dDFpMUtiTGpBZ3V3V2NycFMxSW9ub1BrM0VsWmdy?=
 =?utf-8?B?MUgyS09Id2ZPd1VOMWVyKzFzZUUwNEhFUVRCUEZ2NmNjc0pWTEVKTlhmMktP?=
 =?utf-8?B?Z3VjdWN4YVpJcEphcE04R1UxUGppMUlnSjJHZXBaWW8zSFV4bENzZ0s1dGlF?=
 =?utf-8?B?SENIMDZXd3MxemFwUkNwUjBBUjdkN2VSNXAvSEtSblVMUC85bkZaSTAyeFcx?=
 =?utf-8?B?TUUxU1V5QllmWElNMHd6UFU5YTdoMjdrYVladnpkanl6SmRsMFIwWFJUeGVE?=
 =?utf-8?B?OXRhajNmNTg1cWswbStpNC9tMTJPNVlzL3ltTjQ3b2N2d1M4Q2RPak0yMHdU?=
 =?utf-8?B?VWJYNE9obnVGOE93RTdJUkJGaTVRalphK0ZnMmk2dllCdVlHTE1QNFhFSUVz?=
 =?utf-8?B?SFZNWDRtQXJqdmdnWWtvVUo1dHpnPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a856c3-bfb9-49ac-1cf7-08ddd8da8483
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 13:25:19.5615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmUTlLfjMImQLGoN4tFG8fhnAltJWKZ/rIYebU70q1N0+rWPSg5G+CFJ72C2bSM9Y0whddtUH/9K0LUrtYEImK/JTCrIGewMgby0qXWCfVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9626
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

On 8/6/25 4:58 PM, Marek Vasut wrote:
> Retronix R-Car V4H Sparrow Hawk EVTA1 is populated with Spansion S25FS512S,
> EVTB1 is populated with Winbond W77Q51NW. Describe the SPI NOR using generic
> "jedec,spi-nor" compatible, because both flashes can be auto-detected based
> on their built-in IDs.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: Update commit message, s@spi-flash@jedec,spi-nor@
> V3: Use capital F in the comment, s@fS@FS@

NACK, see v2 for explanations.

Cheers,
Quentin
